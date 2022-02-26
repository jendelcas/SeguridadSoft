//
// (c) 2018 DS Data Systems UK Ltd, All rights reserved.
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

package com.konakart.bl.modules.payment.banktransfer;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.konakart.app.BankTransferConfigData;
import com.konakart.app.KKException;
import com.konakart.app.Order;
import com.konakart.app.OrderTotal;
import com.konakart.app.PaymentDetails;
import com.konakart.appif.KKEngIf;
import com.konakart.bl.modules.BaseModule;
import com.konakart.bl.modules.ordertotal.OrderTotalMgr;
import com.konakart.bl.modules.payment.BasePaymentModule;
import com.konakart.bl.modules.payment.PaymentInfo;
import com.konakart.bl.modules.payment.PaymentInterface;

/**
 * Bank Transfer Module.
 */
public class BankTransfer extends BasePaymentModule implements PaymentInterface
{
    /**
     * Module name must be the same as the class name although it can be all in lowercase
     */
    public static String code = "bankTransfer";

    private static String bundleName = BaseModule.basePackage
            + ".payment.banktransfer.BankTransfer";

    private static HashMap<Locale, ResourceBundle> resourceBundleMap = new HashMap<Locale, ResourceBundle>();

    /** Hash Map that contains the static data */
    private static Map<String, StaticData> staticDataHM = Collections
            .synchronizedMap(new HashMap<String, StaticData>());

    private static String mutex = "bankTransferMutex";

    // Configuration Keys
    private final static String MODULE_PAYMENT_BANK_TRANSFER_STATUS = "MODULE_PAYMENT_BANK_TRANSFER_STATUS";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_ZONE = "MODULE_PAYMENT_BANK_TRANSFER_ZONE";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_ORDER_STATUS_ID = "MODULE_PAYMENT_BANK_TRANSFER_ORDER_STATUS_ID";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_SORT_ORDER = "MODULE_PAYMENT_BANK_TRANSFER_SORT_ORDER";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_IBAN = "MODULE_PAYMENT_BANK_TRANSFER_IBAN";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_REFERENCE_TEMPLATE = "MODULE_PAYMENT_BANK_TRANSFER_REFERENCE_TEMPLATE";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_UPDATE_INVENTORY = "MODULE_PAYMENT_BANK_TRANSFER_UPDATE_INVENTORY";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_SEND_EMAIL = "MODULE_PAYMENT_BANK_TRANSFER_SEND_EMAIL";

    // Message Catalog Keys

    private final static String MODULE_PAYMENT_BANK_TRANSFER_TEXT_TITLE = "module.payment.banktransfer.text.title";

    private final static String MODULE_PAYMENT_BANK_TRANSFER_TEXT_DESCRIPTION = "module.payment.banktransfer.description";

    /**
     * Constructor
     * 
     * @param eng
     *            the eng
     * 
     * @throws KKException
     *             an unexpected KKException exception
     */
    public BankTransfer(KKEngIf eng) throws KKException
    {
        super.init(eng);

        StaticData sd = staticDataHM.get(getStoreId());

        if (sd == null)
        {
            synchronized (mutex)
            {
                sd = staticDataHM.get(getStoreId());
                if (sd == null)
                {
                    setStaticVariables();
                }
            }
        }
    }

    /**
     * Sets some static variables during setup
     * 
     * @throws KKException
     *             an unexpected KKException exception
     * 
     */
    public void setStaticVariables() throws KKException
    {
        StaticData staticData = staticDataHM.get(getStoreId());
        if (staticData == null)
        {
            staticData = new StaticData();
            staticDataHM.put(getStoreId(), staticData);
        }

        staticData.setZone(
                getConfigurationValueAsIntWithDefault(MODULE_PAYMENT_BANK_TRANSFER_ZONE, 0));
        staticData.setSortOrder(
                getConfigurationValueAsIntWithDefault(MODULE_PAYMENT_BANK_TRANSFER_SORT_ORDER, 0));
        staticData.setOrderStatusId(getConfigurationValueAsIntWithDefault(
                MODULE_PAYMENT_BANK_TRANSFER_ORDER_STATUS_ID, 0));

        String confVal = getConfigurationValue(MODULE_PAYMENT_BANK_TRANSFER_REFERENCE_TEMPLATE);
        if (confVal == null)
        {
            throw new KKException(
                    "The Configuration MODULE_PAYMENT_BANK_TRANSFER_REFERENCE_TEMPLATE must be set to the template used for creating the reference for"
                            + " money transfer. (e.g. placeholders $orderId, $orderNum, $name");
        }
        staticData.setReferenceTemplate(confVal);

        confVal = getConfigurationValue(MODULE_PAYMENT_BANK_TRANSFER_IBAN);
        if (confVal == null)
        {
            throw new KKException(
                    "The Configuration MODULE_PAYMENT_BANK_TRANSFER_IBAN must be set to the IBAN used for the transfer");
        }
        staticData.setIban(confVal);

        staticData.setSendEmail(
                getConfigurationValueAsBool(MODULE_PAYMENT_BANK_TRANSFER_SEND_EMAIL, false));
        staticData.setUpdateInventory(
                getConfigurationValueAsBool(MODULE_PAYMENT_BANK_TRANSFER_UPDATE_INVENTORY, false));
        staticData.setOrderStatusId(getConfigurationValueAsIntWithDefault(
                MODULE_PAYMENT_BANK_TRANSFER_ORDER_STATUS_ID, 0));
    }

    /**
     * Return a payment details object for Customer Card
     * 
     * @param order
     *            the order
     * @param info
     *            the info
     * @return Returns information in a PaymentDetails object
     * @throws Exception
     *             an unexpected exception
     */
    public PaymentDetails getPaymentDetails(Order order, PaymentInfo info) throws Exception
    {
        StaticData sd = staticDataHM.get(getStoreId());

        /*
         * The payPalZone zone, if greater than zero, should reference a GeoZone. If the
         * DeliveryAddress of the order isn't within that GeoZone, then we throw an exception
         */
        if (sd.getZone() > 0)
        {
            checkZone(info, sd.getZone());
        }

        // Get the resource bundle
        ResourceBundle rb = getResourceBundle(mutex, bundleName, resourceBundleMap,
                info.getLocale());
        if (rb == null)
        {
            throw new KKException("A resource file cannot be found for the country "
                    + info.getLocale().getCountry());
        }

        PaymentDetails pDetails = new PaymentDetails();
        pDetails.setCode(code);
        pDetails.setSortOrder(sd.getSortOrder());
        pDetails.setOrderStatusId(sd.getOrderStatusId());
        pDetails.setPaymentType(PaymentDetails.BANK_TRANSFER);
        pDetails.setDescription(rb.getString(MODULE_PAYMENT_BANK_TRANSFER_TEXT_DESCRIPTION));
        pDetails.setTitle(rb.getString(MODULE_PAYMENT_BANK_TRANSFER_TEXT_TITLE));

        // Get the total
        BigDecimal total = null;
        if (info.isReturnDetails())
        {
            for (int i = 0; i < order.getOrderTotals().length; i++)
            {
                OrderTotal ot = (OrderTotal) order.getOrderTotals()[i];
                if (ot.getClassName().equals(OrderTotalMgr.ot_total))
                {
                    total = ot.getValue();
                }
            }

            if (total == null)
            {
                throw new KKException("An Order Total was not found");
            }
        }

        BankTransferConfigData conf = new BankTransferConfigData();
        conf.setIban(sd.getIban());
        conf.setOrderStatusId(sd.getOrderStatusId());
        conf.setReferenceTemplate(sd.getReferenceTemplate());
        conf.setSendEmail(sd.isSendEmail());
        conf.setTotal(total);
        conf.setUpdateInventory(sd.isUpdateInventory());

        Gson gson = new GsonBuilder().create();
        String confJson = gson.toJson(conf, BankTransferConfigData.class);
        pDetails.setCustom1(confJson);

        return pDetails;
    }

    /**
     * Returns true or false
     * 
     * @throws KKException
     *             an unexpected KKException exception
     */
    public boolean isAvailable() throws KKException
    {
        return isAvailable(MODULE_PAYMENT_BANK_TRANSFER_STATUS);
    }


    /**
     * Used to store the static data of this module
     */
    protected class StaticData
    {
        private int sortOrder = -1;

        private int zone;

        private int orderStatusId;

        private String iban;

        private String referenceTemplate;

        private boolean updateInventory;

        private boolean sendEmail;

        /**
         * @return the sortOrder
         */
        public int getSortOrder()
        {
            return sortOrder;
        }

        /**
         * @param sortOrder
         *            the sortOrder to set
         */
        public void setSortOrder(int sortOrder)
        {
            this.sortOrder = sortOrder;
        }

        /**
         * @return the zone
         */
        public int getZone()
        {
            return zone;
        }

        /**
         * @param zone
         *            the zone to set
         */
        public void setZone(int zone)
        {
            this.zone = zone;
        }

        /**
         * @return the orderStatusId
         */
        public int getOrderStatusId()
        {
            return orderStatusId;
        }

        /**
         * @param orderStatusId
         *            the orderStatusId to set
         */
        public void setOrderStatusId(int orderStatusId)
        {
            this.orderStatusId = orderStatusId;
        }

        /**
         * @return the iban
         */
        public String getIban()
        {
            return iban;
        }

        /**
         * @param iban
         *            the iban to set
         */
        public void setIban(String iban)
        {
            this.iban = iban;
        }

        /**
         * @return the referenceTemplate
         */
        public String getReferenceTemplate()
        {
            return referenceTemplate;
        }

        /**
         * @param referenceTemplate
         *            the referenceTemplate to set
         */
        public void setReferenceTemplate(String referenceTemplate)
        {
            this.referenceTemplate = referenceTemplate;
        }

        /**
         * @return the updateInventory
         */
        public boolean isUpdateInventory()
        {
            return updateInventory;
        }

        /**
         * @param updateInventory
         *            the updateInventory to set
         */
        public void setUpdateInventory(boolean updateInventory)
        {
            this.updateInventory = updateInventory;
        }

        /**
         * @return the sendEmail
         */
        public boolean isSendEmail()
        {
            return sendEmail;
        }

        /**
         * @param sendEmail
         *            the sendEmail to set
         */
        public void setSendEmail(boolean sendEmail)
        {
            this.sendEmail = sendEmail;
        }
    }

}
