//
// (c) 2006 DS Data Systems UK Ltd, All rights reserved.
//
// DS Data Systems and KonaKart and their respective logos, are 
// trademarks of DS Data Systems UK Ltd. All rights reserved.
//
// The information in this document is free software; you can redistribute 
// it and/or modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
// 
// This software is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//

package com.konakart.actions;

import java.math.BigDecimal;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.konakart.al.KKAppEng;
import com.konakart.al.KKAppException;
import com.konakart.app.BankTransferConfigData;
import com.konakart.app.EmailOptions;
import com.konakart.app.NameValue;
import com.konakart.app.OrderStatusHistory;
import com.konakart.app.PaymentDetails;
import com.konakart.appif.CustomerIf;
import com.konakart.appif.EmailOptionsIf;
import com.konakart.appif.OrderIf;
import com.konakart.appif.OrderStatusHistoryIf;
import com.konakart.appif.PaymentDetailsIf;
import com.konakart.util.KKConstants;

/**
 * Gets called after submitting the checkout confirmation page. Where we go from here depends on the
 * payment gateway chosen.
 */
public class CheckoutConfirmationSubmitAction extends BaseAction
{
    private static final long serialVersionUID = 1L;

    private String comment;

    public String execute()
    {
        HttpServletRequest request = ServletActionContext.getRequest();
        HttpServletResponse response = ServletActionContext.getResponse();

        try
        {
            int custId;

            KKAppEng kkAppEng = this.getKKAppEng(request, response);

            /*
             * Ensure that multiple threads don't execute the code at the same time. This is to
             * prevent a customer confirming the order twice. The mutex is local to KKAppEng and so
             * doesn't enforce blocking for different customers.
             */
            synchronized (kkAppEng.checkoutConfirmationSubmitMutex)
            {
                custId = this.loggedIn(request, response, kkAppEng, "Checkout");

                // Check to see whether the user is logged in
                if (custId < 0)
                {
                    return KKLOGIN;
                }

                // Ensure we are using the correct protocol. Redirect if not.
                String redirForward = checkSSL(kkAppEng, request, custId, /* forceSSL */false);
                if (redirForward != null)
                {
                    setupResponseForSSLRedirect(response, redirForward);
                    return null;
                }

                // Ensure that the user hasn't submitted the order and then got back to here using
                // the
                // back button. We check to see whether the basket is null
                // Check to see whether there is something in the cart
                CustomerIf cust = kkAppEng.getCustomerMgr().getCurrentCustomer();
                if (cust.getBasketItems() == null || cust.getBasketItems().length == 0)
                {
                    return "ShowCartItems";
                }

                // Get the host name and port number
                String hostAndPort = "";
                if (!kkAppEng.isPortlet())
                {
                    // Throws exception if called when running as a portlet
                    hostAndPort = request.getServerName() + ":" + request.getServerPort();
                }

                // Check that order is there and valid
                OrderIf checkoutOrder = kkAppEng.getOrderMgr().getCheckoutOrder();
                if (checkoutOrder == null)
                {
                    return "Checkout";
                }

                if (log.isDebugEnabled())
                {
                    String msg = "checkoutOrder: " + checkoutOrder.getLifecycleId();
                    if (checkoutOrder.getOrderTotals() == null)
                    {
                        msg += " NULL OrderTotals";
                    } else
                    {
                        msg += " " + checkoutOrder.getOrderTotals().length + " OrderTotals";
                    }
                    log.debug(msg);
                }

                if (checkoutOrder.getOrderTotals() == null)
                {
                    log.debug("Leaving checkout because the order has no Order Totals");
                    return null;
                }

                // Set the comment
                String escapedComment = escapeFormInput(getComment());
                OrderStatusHistoryIf osh = new OrderStatusHistory();
                osh.setComments(escapedComment);
                OrderStatusHistoryIf[] oshArray = new OrderStatusHistoryIf[1];
                oshArray[0] = osh;
                osh.setUpdatedById(kkAppEng.getOrderMgr().getIdForUserUpdatingOrder(checkoutOrder));
                checkoutOrder.setStatusTrail(oshArray);

                // Uncomment this for Canada Post - it sets the packaging details
                // checkoutOrder.setCustom4(checkoutOrder.getShippingQuote().getCustom4());

                // Don't go any further if the order needs to be approved
                boolean needApproval = kkAppEng.getCustomerMgr()
                        .getTagValueAsBool(KKConstants.B2B_ORDERS_NEED_APPROVAL, false);
                if (needApproval)
                {
                    // Set the order status
                    checkoutOrder.setStatus(com.konakart.bl.OrderMgr.WAITING_APPROVAL_STATUS);

                    // Save the order
                    kkAppEng.getOrderMgr().saveOrder(/* sendEmail */false,
                            getEmailOptions(kkAppEng));

                    // Empty the basket
                    kkAppEng.getBasketMgr().emptyBasket();

                    return "CheckoutFinished";
                }

                /*
                 * Check to see whether the order total is set to 0. Don't bother with a payment
                 * gateway if it is.
                 */
                BigDecimal orderTotal = checkoutOrder.getTotalIncTax();
                if (orderTotal != null && orderTotal.compareTo(java.math.BigDecimal.ZERO) == 0)
                {
                    // Set the order status
                    checkoutOrder.setStatus(com.konakart.bl.OrderMgr.PAYMENT_RECEIVED_STATUS);

                    // Save the order
                    int orderId = kkAppEng.getOrderMgr().saveOrder(/* sendEmail */true,
                            getEmailOptions(kkAppEng));

                    // Update the inventory
                    kkAppEng.getOrderMgr().updateInventory(orderId);

                    // If we received no exceptions, delete the basket
                    kkAppEng.getBasketMgr().emptyBasket();

                    return "CheckoutFinished";
                }

                int paymentType = kkAppEng.getOrderMgr().getPaymentType();
                if (paymentType == PaymentDetails.BROWSER_PAYMENT_GATEWAY
                        || paymentType == PaymentDetails.BROWSER_IN_FRAME_PAYMENT_GATEWAY)
                {
                    /*
                     * This payment gateway is a type where the customer enters the credit card
                     * details on a browser window belonging to the gateway. The result is normally
                     * returned through a callback. Therefore we don't update the inventory here,
                     * but leave it for the callback action which will do it if the payment was
                     * approved.
                     */

                    // Set the order status
                    checkoutOrder.setStatus(com.konakart.bl.OrderMgr.WAITING_PAYMENT_STATUS);

                    // Save the order
                    int orderId = kkAppEng.getOrderMgr().saveOrder(/* sendEmail */true,
                            getEmailOptions(kkAppEng));

                    // Get a fully populated PaymentDetails object and attach it to the order
                    PaymentDetailsIf pd = kkAppEng.getEng().getPaymentDetails(
                            kkAppEng.getSessionId(), checkoutOrder.getPaymentDetails().getCode(),
                            orderId, hostAndPort, kkAppEng.getLangId());
                    if (pd == null)
                    {
                        throw new KKAppException(
                                "The payment gateway " + checkoutOrder.getPaymentDetails().getCode()
                                        + " returned a null PaymentDetails object");
                    }
                    checkoutOrder.setPaymentDetails(pd);
                    checkoutOrder.setPaymentMethod(pd.getTitle());
                    checkoutOrder.setPaymentModuleCode(pd.getCode());
                    checkoutOrder.setPaymentModuleSubCode(pd.getSubCode());

                    // Save pd.getCustom1() on the session with key: orderId + "-CUSTOM1"
                    kkAppEng.setCustomConfig(Integer.toString(orderId) + "-CUSTOM1",
                            pd.getCustom1());
                    // Save pd.getCustom2() on the session with key: orderId + "-CUSTOM2"
                    kkAppEng.setCustomConfig(Integer.toString(orderId) + "-CUSTOM2",
                            pd.getCustom2());

                    // If we received no exceptions, delete the basket
                    kkAppEng.getBasketMgr().emptyBasket();

                    if (pd.getPreProcessCode() != null)
                    {
                        if (log.isInfoEnabled())
                        {
                            log.info("Returning PreProcessCode = " + pd.getPreProcessCode());
                        }
                        return pd.getPreProcessCode();
                    }

                    if (paymentType == PaymentDetails.BROWSER_IN_FRAME_PAYMENT_GATEWAY)
                    {
                        return "CheckoutExternalPaymentFrame";
                    }
                    return "CheckoutExternalPayment";
                } else if (paymentType == PaymentDetails.SERVER_PAYMENT_GATEWAY)
                {
                    /*
                     * This payment gateway is a type where the customer enters the credit card
                     * details on a browser window belonging to KonaKart. The details are passed to
                     * the KonaKart server which communicates with the Gateway server side. A
                     * response is returned immediately but we still save the order and change the
                     * state later.
                     * 
                     * Some notes on this:
                     * 
                     * -- If we save it after receiving payment notification, something may go wrong
                     * and we would have a payment notification for an unknown order.
                     * 
                     * -- If we save it after receiving payment notification, we don't have an order
                     * id to send to the gateway. The order id often appears in the email response
                     * from the gateway in order to match the response to the order.
                     * 
                     * -- We save the order with a pending status but don't send an email
                     * immediately. If the payment is approved, we change the status and then send
                     * an email.
                     * 
                     * -- If the payment request is never made, we keep the order in the database
                     * with a pending status.
                     * 
                     * -- If the payment is never approved, we keep the order in the database with a
                     * payment declined status. If the user made at least one attempt to pay for the
                     * order, we should also have an ipnHistory object with details of the gateway
                     * transaction.
                     */
                    // Set the order status
                    checkoutOrder.setStatus(com.konakart.bl.OrderMgr.WAITING_PAYMENT_STATUS);

                    // Save the order
                    int orderId = kkAppEng.getOrderMgr().saveOrder(/* sendEmail */false, null);

                    // Get a fully populated PaymentDetails object and attach it to the order
                    PaymentDetailsIf pd = kkAppEng.getEng().getPaymentDetails(
                            kkAppEng.getSessionId(), checkoutOrder.getPaymentDetails().getCode(),
                            orderId, hostAndPort, kkAppEng.getLangId());
                    checkoutOrder.setPaymentDetails(pd);
                    checkoutOrder.setPaymentMethod(pd.getTitle());
                    checkoutOrder.setPaymentModuleCode(pd.getCode());
                    checkoutOrder.setPaymentModuleSubCode(pd.getSubCode());

                    // Save pd.getCustom1() on the session with key: orderId + "-CUSTOM1"
                    kkAppEng.setCustomConfig(Integer.toString(orderId) + "-CUSTOM1",
                            pd.getCustom1());
                    // Save pd.getCustom2() on the session with key: orderId + "-CUSTOM2"
                    kkAppEng.setCustomConfig(Integer.toString(orderId) + "-CUSTOM2",
                            pd.getCustom2());

                    return "CheckoutServerPayment";
                } else if (paymentType == PaymentDetails.COD)
                {
                    /*
                     * Cash On Delivery. The order is saved with a pending status and the inventory
                     * is updated.
                     */

                    // Set the order status
                    checkoutOrder.setStatus(com.konakart.bl.OrderMgr.PENDING_STATUS);

                    kkAppEng.getOrderMgr().addPaymentDetailsToOrder("cod");

                    if (log.isDebugEnabled())
                    {
                        String msg = "checkoutOrder: " + checkoutOrder.getLifecycleId();
                        if (checkoutOrder.getOrderTotals() == null)
                        {
                            msg += " NULL OrderTotals";
                        } else
                        {
                            msg += " " + checkoutOrder.getOrderTotals().length + " OrderTotals";
                        }
                        log.debug(msg);
                    }

                    // Save the order
                    int orderId = kkAppEng.getOrderMgr().saveOrder(/* sendEmail */true,
                            getEmailOptions(kkAppEng));

                    // Update the inventory
                    kkAppEng.getOrderMgr().updateInventory(orderId);

                    // If we received no exceptions, delete the basket
                    kkAppEng.getBasketMgr().emptyBasket();

                    return "CheckoutFinished";
                } else if (paymentType == PaymentDetails.BANK_TRANSFER)
                {
                    /*
                     * Bank Transfer
                     */
                    // Get the config data from custom1 of the payment details object
                    PaymentDetailsIf pdPartial = checkoutOrder.getPaymentDetails();

                    BankTransferConfigData configData = null;
                    Gson gson = new GsonBuilder().create();
                    String json = pdPartial.getCustom1();
                    try
                    {
                        configData = gson.fromJson(json, BankTransferConfigData.class);
                    } catch (Exception e)
                    {
                        throw new KKAppException(
                                "The json \n" + json
                                        + "\nin custom1 of the PaymentDetails object cannot be converted to an object",
                                e);
                    }

                    // Set some order attributes before saving the order
                    checkoutOrder.setStatus(configData.getOrderStatusId());
                    checkoutOrder.setPaymentMethod(pdPartial.getTitle());
                    checkoutOrder.setPaymentModuleCode(pdPartial.getCode());
                    checkoutOrder.setPaymentModuleSubCode(pdPartial.getSubCode());

                    // Save the order
                    int orderId = kkAppEng.getOrderMgr().saveOrder(/* sendEmail */false,
                            getEmailOptions(kkAppEng));

                    // Get a fully populated PaymentDetails object and attach it to the order
                    PaymentDetailsIf pdFull = kkAppEng.getEng().getPaymentDetails(
                            kkAppEng.getSessionId(), checkoutOrder.getPaymentDetails().getCode(),
                            orderId, hostAndPort, kkAppEng.getLangId());
                    checkoutOrder.setPaymentDetails(pdFull);

                    json = pdFull.getCustom1();
                    try
                    {
                        configData = gson.fromJson(json, BankTransferConfigData.class);
                    } catch (Exception e)
                    {
                        throw new KKAppException(
                                "The json \n" + json
                                        + "\nin custom1 of the PaymentDetails object cannot be converted to an object",
                                e);
                    }

                    // Get the order
                    if (cust.getOrders() == null || cust.getOrders().length == 0)
                    {
                        throw new KKAppException("Cannnot find customer orders");
                    }

                    if (cust.getOrders()[0].getId() != orderId)
                    {
                        throw new KKAppException(
                                "Most recent customer order with id " + cust.getOrders()[0].getId()
                                        + " does not match order just saved " + orderId);
                    }

                    OrderIf savedOrder = cust.getOrders()[0];

                    if (configData.isUpdateInventory())
                    {
                        // Update the inventory
                        kkAppEng.getOrderMgr().updateInventory(orderId);
                    }

                    // If we received no exceptions, delete the basket
                    kkAppEng.getBasketMgr().emptyBasket();

                    // Set values on the payment details object to display on the JSP
                    pdFull.setCustom1(kkAppEng.formatPrice(configData.getTotal()));

                    // IBAN
                    pdFull.setCustom2(configData.getIban());

                    // Create a string used as the reference for the transfer
                    String ref = configData.getReferenceTemplate().replace("$orderId",
                            Integer.toString(orderId));
                    ref = ref.replace("$orderNum", savedOrder.getOrderNumber());
                    ref = ref.replace("$name", savedOrder.getCustomerName());
                    pdFull.setCustom3(ref);

                    if (configData.isSendEmail())
                    {
                        EmailOptionsIf options = new EmailOptions();
                        options.setCustomAttrs(new NameValue[]
                        { new NameValue("iban", configData.getIban()),
                                new NameValue("reference", ref),
                                new NameValue("formattedTotal", pdFull.getCustom1()) });
                        kkAppEng.getOrderMgr().sendOrderConfirmationEmail(orderId, options);
                    }

                    return "CheckoutFinished";
                } else
                {
                    throw new KKAppException("This Payment Type is not supported");
                }
            }
        } catch (Exception e)
        {
            return super.handleException(request, e);
        }
    }

    /**
     * Instantiate an EmailOptions object. Edit this method if you have installed Enterprise
     * Extensions and want to attach an invoice to the eMail.
     * 
     * @param kkAppEng
     * @return Returns a populated EmailOptions object
     */
    private EmailOptionsIf getEmailOptions(KKAppEng kkAppEng)
    {
        EmailOptionsIf options = new EmailOptions();
        options.setCountryCode(kkAppEng.getLocale().substring(0, 2));
        options.setTemplateName("OrderConfReceived");

        // Attach the invoice to the confirmation email (Enterprise Only). Defaults to false.
        // options.setAttachInvoice(true);

        // Create the invoice (if not already present) for attaching to the confirmation email
        // (Enterprise Only). Defaults to false.
        // options.setCreateInvoice(true);

        return options;
    }

    /**
     * @return the comment
     */
    public String getComment()
    {
        return comment;
    }

    /**
     * @param comment
     *            the comment to set
     */
    public void setComment(String comment)
    {
        this.comment = comment;
    }
}
