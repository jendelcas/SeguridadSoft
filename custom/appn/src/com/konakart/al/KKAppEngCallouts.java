package com.konakart.al;

import java.math.BigDecimal;
import java.util.HashMap;

import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;

import com.konakart.app.FetchProductOptions;
import com.konakart.app.KKException;
import com.konakart.appif.CatalogIf;
import com.konakart.appif.FetchProductOptionsIf;
import com.konakart.appif.OrderIf;
import com.konakart.appif.OrderTotalIf;
import com.konakart.util.KKConstants;

/**
 * Callouts to add custom code to the KKAppEng
 */
public class KKAppEngCallouts
{
    /**
     * The <code>Log</code> instance for this application.
     */
    private Log log = LogFactory.getLog(KKAppEngCallouts.class);

    /**
     * Called at the start of startup
     * 
     * @param eng
     *            the eng
     */
    public void beforeStartup(KKAppEng eng)
    {
        // System.out.println("Set product options for current customer");
        FetchProductOptionsIf fpo = new FetchProductOptions();
        fpo.setCalcQuantityForBundles(false);
        /*
         * Returns the image names when getting a single product. Used for different images based on
         * options. e.g. green shirt, blue shirt etc.
         */
        fpo.setGetImages(true);
        eng.setFetchProdOptions(fpo);

        /*
         * We keep a default value that we revert back to when a customer logs out
         */
        eng.setFetchProdOptionsDefault(fpo);
    }

    /**
     * Called at the end of startup
     * 
     * @param eng
     *            the eng
     */
    public void afterStartup(KKAppEng eng)
    {
        try
        {
            if (eng.getEng() != null)
            {
                String catalogKey = eng.getEng().getConfigurationValue("STARTUP_CATALOG_KEY");
                if (catalogKey != null && catalogKey.length() > 0)
                {
                    CatalogIf cat = null;

                    cat = eng.getEng().getCatalogPerKey(catalogKey);

                    if (cat != null)
                    {
                        FetchProductOptionsIf fpo = eng.getFetchProdOptions();
                        fpo.setCatalogId(catalogKey);
                        fpo.setUseExternalPrice(cat.isUseCatalogPrices());
                        fpo.setUseExternalQuantity(cat.isUseCatalogQuantities());
                        eng.setFetchProdOptions(fpo);
                        if (log.isInfoEnabled())
                        {
                            log.info("Startup catalog id used for store - " + catalogKey);
                        }

                        /*
                         * We keep a default value that we revert back to when a customer logs out
                         */
                        eng.setFetchProdOptionsDefault(fpo);
                    }
                }
            }
        } catch (KKException e)
        {
            log.error(e);
        }
    }

    /**
     * Called at the end of the RefreshCachedData method of KKAppEng
     * 
     * @param eng
     *            the eng
     */
    public void afterRefreshCaches(KKAppEng eng)
    {
    }

    /**
     * Called by the CustomerMgr after a login has been successful
     * 
     * @param eng
     *            the eng
     */
    public void afterLogin(KKAppEng eng)
    {

    }

    /**
     * Called after an order has been populated with order totals so that a verification can be made
     * to determine whether all compulsory modules exist. If shipping or tax modules call an
     * external service, the service may be down and if this is the case, the customer should not be
     * allowed to confirm the order. The logic will probably have to use the delivery address to
     * determine which modules should be present. e.g. USPS for US addresses and USPS International
     * for addresses outside of the US.
     * 
     * You may also implement a backup database driven order total module that only returns a value
     * if the service driven order total module doesn't return a value. In this case it may not be
     * necessary to make the check.
     * 
     * This method may be edited to match your requirements.
     * 
     * @param eng
     *            the eng
     * @param order
     *            the order
     * @return Returns null if all OK. Otherwise a message is returned that will be displayed to the
     *         customer.
     */
    public String validateOrderTotals(KKAppEng eng, OrderIf order)
    {
        String retMsg = eng.getMsg("one.page.checkout.problem");

        if (order == null)
        {
            return retMsg;
        }

        /*
         * Add the order total modules to a hash map for fast lookup
         */
        HashMap<String, OrderTotalIf> otMap = new HashMap<String, OrderTotalIf>();
        if (order.getOrderTotals() != null)
        {
            for (int i = 0; i < order.getOrderTotals().length; i++)
            {
                OrderTotalIf ot = order.getOrderTotals()[i];
                otMap.put(ot.getClassName(), ot);
            }
        }
        if (order.getDeliveryCountryObject().getIsoCode3().equalsIgnoreCase("USA"))
        {
            if (eng.getConfigAsBoolean("MODULE_ORDER_TOTAL_TAX_CLOUD_STATUS", false /* default */,
                    true /* tryEngIfNotInCache */, false /* warn if missing */))
            {
                // If using an external tax service like TaxCloud it is advisable to enable the
                // ExternalTax order total module to reassign the tax value in an "ot_tax" order
                // total to account for changes that may have occurred in the tax as a result of
                // promotion order totals.

                // The TaxCloud order total module sort order should be very low to run make it run
                // early whereas the ExternalTax module should run at or near the end after all
                // the modules that may change the tax on the order.

                // Therefore the logic below checks for the presence of either "ot_tax" or
                // "ot_tax_cloud" order total modules in the map depending on which order total
                // modules are enabled.

                if (eng.getConfigAsBoolean("MODULE_ORDER_TOTAL_EXTERNAL_TAX_ENABLED",
                        false /* default */, true /* tryEngIfNotInCache */,
                        false /* warn if missing */))
                {
                    OrderTotalIf taxStd = otMap.get("ot_tax");
                    if (taxStd == null)
                    {
                        OrderTotalIf taxCloud = otMap.get("ot_tax_cloud");
                        if (taxCloud == null)
                        {
                            log.error("TaxCloud Module didn't return a value for the address: \n"
                                    + order.getDeliveryFormattedAddress()
                                    + " no ot_tax or ot_tax_cloud OTs found");
                        } else
                        {
                            log.error("The ExternalTax module did not convert the ot_tax_cloud "
                                    + "order total to an ot_tax order total.");
                        }
                        return retMsg;
                    }
                } else
                {
                    OrderTotalIf taxCloud = otMap.get("ot_tax_cloud");
                    if (taxCloud == null)
                    {
                        log.error("TaxCloud Module didn't return a value for the address: \n"
                                + order.getDeliveryFormattedAddress()
                                + " no ot_tax_cloud OT found");
                        return retMsg;
                    }
                }
            }
            if (eng.getConfigAsBoolean("MODULE_SHIPPING_USPS_STATUS", false /* default */,
                    true /* try engine if not in cache */, false /* warn if missing */))
            {
                OrderTotalIf usps = otMap.get("ot_shipping");
                if (usps == null)
                {
                    log.error("USPS Module didn't return a value for the address: \n"
                            + order.getDeliveryFormattedAddress());
                    return retMsg;
                }
            }
        } else if (order.getDeliveryCountryObject().getIsoCode3().equalsIgnoreCase("CAN"))
        {
            if (eng.getConfigAsBoolean("MODULE_SHIPPING_CANADA_POST_STATUS",
                    false, /* tryEngIfNotInCache */
                    false))
            {
                OrderTotalIf canadaPost = otMap.get("ot_shipping");
                if (canadaPost == null)
                {
                    log.error("Canada Post Module didn't return a value for the address: \n"
                            + order.getDeliveryFormattedAddress());
                    return retMsg;
                }
            }
        } else
        {
            if (eng.getConfigAsBoolean("MODULE_SHIPPING_USPSINT_STATUS",
                    false, /* tryEngIfNotInCache */
                    false))
            {
                OrderTotalIf uspsInt = otMap.get("ot_shipping");
                if (uspsInt == null)
                {
                    log.error("USPS International Module didn't return a value for the address: \n"
                            + order.getDeliveryFormattedAddress());
                    return retMsg;
                }
            }
        }

        if (eng.getConfigAsBoolean("MODULE_SHIPPING_FEDEX_STATUS", false, /* tryEngIfNotInCache */
                false))
        {
            OrderTotalIf fedex = otMap.get("ot_shipping");
            if (fedex == null)
            {
                log.error("Fedex Module didn't return a value for the address: \n"
                        + order.getDeliveryFormattedAddress());
                return retMsg;
            }
        }

        if (eng.getConfigAsBoolean("MODULE_SHIPPING_UPS_STATUS", false, /* tryEngIfNotInCache */
                false))
        {
            OrderTotalIf ups = otMap.get("ot_shipping");
            if (ups == null)
            {
                log.error("UPS Module didn't return a value for the address: \n"
                        + order.getDeliveryFormattedAddress());
                return retMsg;
            }
        }

        /*
         * Check that a shipping module is always present. It should be present even for virtual
         * goods. If this check isn't made we risk not charging shipping for the cases where a
         * destination address may not be covered by any shipping module.
         */
        OrderTotalIf shipping = otMap.get("ot_shipping");
        if (shipping == null)
        {
            log.error("No shipping module found: \n" + order.getDeliveryFormattedAddress());
            return retMsg;
        }

        /*
         * Check that a payment method is always present on the order.
         */
        if (order.getPaymentDetails() == null)
        {
            log.error("No payment method found: \n" + order.getBillingFormattedAddress());
            return retMsg;
        }

        return null;
    }

    /**
     * Ensures that the customer has the correct privileges for confirming the order
     * 
     * @param eng
     *            the eng
     * @param order
     *            the order
     * @return Returns null if all OK. Otherwise a message is returned that will be displayed to the
     *         customer.
     * @throws KKAppException
     *             an unexpected KKAppException exception
     * @throws KKException
     *             an unexpected KKException exception
     */
    public String validateOrderForCustomer(KKAppEng eng, OrderIf order)
            throws KKAppException, KKException
    {
        if (order == null)
        {
            return eng.getMsg("one.page.checkout.problem");
        }

        CustomerMgr custMgr = eng.getCustomerMgr();
        if (custMgr.isCustomerTagsAvailable())
        {
            /*
             * Check order total limit
             */
            BigDecimal limit = custMgr.getTagValueAsBigDecimal(KKConstants.B2B_ORDER_LIMIT);
            if (limit != null && order.getOrderTotals() != null)
            {
                for (int i = 0; i < order.getOrderTotals().length; i++)
                {
                    OrderTotalIf ot = order.getOrderTotals()[i];
                    if (ot.getClassName() != null && ot.getClassName().equals("ot_total"))
                    {
                        if (ot.getValue() != null && ot.getValue().compareTo(limit) > 0)
                        {
                            return eng.getMsg("one.page.checkout.limit.exceeded",
                                    eng.formatPrice(limit));
                        }
                    }
                }
            }
            /*
             * Check aggregate order total limit
             */
            BigDecimal aggregateLimit = custMgr
                    .getTagValueAsBigDecimal(KKConstants.B2B_AGGREGATE_ORDER_LIMIT);
            if (aggregateLimit != null && order.getOrderTotals() != null)
            {
                BigDecimal aggregateTotal = custMgr.getTagValueAsBigDecimal(
                        KKConstants.B2B_AGGREGATE_ORDER_TOTAL, /* fromDB */true);
                if (aggregateTotal == null)
                {
                    aggregateTotal = new BigDecimal(0);
                }
                limit = aggregateLimit.subtract(aggregateTotal);
                if (limit.compareTo(BigDecimal.ZERO) <= 0)
                {
                    return eng.getMsg("one.page.checkout.aggregate.limit.exceeded",
                            eng.formatPrice(aggregateLimit));
                }
                for (int i = 0; i < order.getOrderTotals().length; i++)
                {
                    OrderTotalIf ot = order.getOrderTotals()[i];
                    if (ot.getClassName() != null && ot.getClassName().equals("ot_total"))
                    {
                        if (ot.getValue() != null && ot.getValue().compareTo(limit) > 0)
                        {
                            return eng.getMsg("one.page.checkout.aggregate.limit.will.be.exceeded",
                                    eng.formatPrice(limit));
                        }
                    }
                }
            }
        }
        return null;
    }
}
