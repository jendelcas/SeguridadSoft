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

package com.konakart.bl.modules.ordertotal.shipping;

import java.math.BigDecimal;
import java.util.Collections;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.torque.TorqueException;

import com.konakart.app.KKConfiguration;
import com.konakart.app.KKException;
import com.konakart.app.Order;
import com.konakart.app.OrderTotal;
import com.konakart.appif.KKEngIf;
import com.konakart.bl.modules.BaseModule;
import com.konakart.bl.modules.ordertotal.BaseOrderTotalModule;
import com.konakart.bl.modules.ordertotal.OrderTotalInterface;
import com.konakart.bl.modules.ordertotal.OrderTotalMgr;
import com.konakart.util.JavaUtils;
import com.workingdogs.village.DataSetException;

/**
 * Module that creates an OrderTotal object for Shipping cost.
 */
public class Shipping extends BaseOrderTotalModule implements OrderTotalInterface
{
    // Module name must be the same as the class name although it can be all in lowercase
    private static String code = OrderTotalMgr.ot_shipping;

    private static String bundleName = BaseModule.basePackage + ".ordertotal.shipping.Shipping";

    private static HashMap<Locale, ResourceBundle> resourceBundleMap = new HashMap<Locale, ResourceBundle>();

    private static String mutex = "otShippingMutex";

    /** Hash Map that contains the static data */
    private static Map<String, StaticData> staticDataHM = Collections
            .synchronizedMap(new HashMap<String, StaticData>());

    // Configuration Keys

    private final static String MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER = "MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER";

    private final static String MODULE_ORDER_TOTAL_SHIPPING_STATUS = "MODULE_ORDER_TOTAL_SHIPPING_STATUS";

    // private final static String MODULE_ORDER_TOTAL_SHIPPING_DESCRIPTION =
    // "module.order.total.shipping.description";

    /**
     * Constructor
     * 
     * @param eng the KonaKart engine
     * 
     * @throws DataSetException an unexpected exception due to data in Torque (the database layer)
     * @throws KKException an unexpected exception from the KonaKart engine
     * @throws TorqueException an unexpected exception in Torque (the database layer)
     */
    public Shipping(KKEngIf eng) throws TorqueException, KKException, DataSetException
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
     * @throws KKException an unexpected exception from the KonaKart engine
     */
    public void setStaticVariables() throws KKException
    {
        KKConfiguration conf;
        StaticData staticData = staticDataHM.get(getStoreId());
        if (staticData == null)
        {
            staticData = new StaticData();
            staticDataHM.put(getStoreId(), staticData);
        } else
        {
            if (!updateStaticVariablesNow(staticData.getLastUpdatedMS()))
            {
                return;
            }
        }

        conf = getConfiguration(MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER);
        if (conf == null)
        {
            staticData.setSortOrder(0);
        } else
        {
            staticData.setSortOrder(new Integer(conf.getValue()).intValue());
        }

        staticData.setLastUpdatedMS(System.currentTimeMillis());
        
        if (log.isInfoEnabled())
        {
            if (log.isDebugEnabled())
            {
                log.debug(JavaUtils.dumpAllStackTraces(".*JavaUtils.dumpAllStackTraces.*",
                        getDebugStackTraceExclusions()));
            }
            String staticD = "Configuration data for " + code + " on " + getStoreId();
            staticD += "\n\t\t\t SortOrder          = " + staticData.getSortOrder();
            staticD += "\n\t\t\t LastUpdated        = " + staticData.getLastUpdatedMS();
            log.info(staticD);
        }
    }

    /**
     * Returns true or false
     * 
     * @throws KKException an unexpected exception from the KonaKart engine
     */
    public boolean isAvailable() throws KKException
    {
        return isAvailable(MODULE_ORDER_TOTAL_SHIPPING_STATUS);
    }

    /**
     * Create and return an OrderTotal object for the shipping cost.
     * 
     * @param order
     *            the order
     * @param dispPriceWithTax
     *            the dispPriceWithTax
     * @param locale
     *            the locale
     * @return Returns an OrderTotal object for this module
     * @throws Exception an unexpected exception
     */
    public OrderTotal getOrderTotal(Order order, boolean dispPriceWithTax, Locale locale)
            throws Exception
    {
        OrderTotal ot;
        StaticData sd = staticDataHM.get(getStoreId());

        // Get the resource bundle
        ResourceBundle rb = getResourceBundle(mutex, bundleName, resourceBundleMap, locale);
        if (rb == null)
        {
            throw new KKException("A resource file cannot be found for the country "
                    + locale.getCountry());
        }

        ot = new OrderTotal();
        ot.setSortOrder(sd.getSortOrder());
        ot.setClassName(code);
        if (order.getShippingQuote() == null)
        {
            return null;
        }
        String title = order.getShippingQuote().getTitle();
        if (order.getShippingQuote().getResponseText() != null)
        {
            title += " (" + order.getShippingQuote().getResponseText() + ")";
        }
        title += ":";
        ot.setTitle(title);
        BigDecimal cost;
        if (dispPriceWithTax)
        {
            cost = order.getShippingQuote().getTotalIncTax();
        } else
        {
            cost = order.getShippingQuote().getTotalExTax();
        }
        ot.setValue(cost);
        ot.setTax(order.getShippingQuote().getTax());
        ot.setText(getCurrMgr().formatPrice(cost, order.getCurrencyCode()));
        ot.setTaxRate(order.getShippingQuote().getTaxRate());

        return ot;
    }

    public int getSortOrder()
    {
        StaticData sd;
        try
        {
            sd = staticDataHM.get(getStoreId());
            return sd.getSortOrder();
        } catch (KKException e)
        {
            log.error("Can't get the store id", e);
            return 0;
        }
    }

    public String getCode()
    {
        return code;
    }
    
    public String getModuleClassName()
    {
        return this.getClass().getName();
    }

    /**
     * Used to store the static data of this module
     */
    protected class StaticData
    {
        private int sortOrder = -1;

        // lastUpdatedMS
        private long lastUpdatedMS = -1;

        /**
         * @return the lastUpdatedMS
         */
        public long getLastUpdatedMS()
        {
            return lastUpdatedMS;
        }

        /**
         * @param lastUpdatedMS
         *            the lastUpdatedMS to set
         */
        public void setLastUpdatedMS(long lastUpdatedMS)
        {
            this.lastUpdatedMS = lastUpdatedMS;
        }

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
    }
}
