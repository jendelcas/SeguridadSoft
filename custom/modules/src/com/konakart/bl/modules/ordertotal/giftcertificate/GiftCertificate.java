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

package com.konakart.bl.modules.ordertotal.giftcertificate;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.ResourceBundle;

import org.apache.torque.TorqueException;

import com.konakart.app.Coupon;
import com.konakart.app.KKBeanCopier;
import com.konakart.app.KKConfiguration;
import com.konakart.app.KKException;
import com.konakart.app.Order;
import com.konakart.app.OrderTotal;
import com.konakart.app.Promotion;
import com.konakart.appif.CouponIf;
import com.konakart.appif.KKEngIf;
import com.konakart.appif.PromotionIf;
import com.konakart.bl.modules.BaseModule;
import com.konakart.bl.modules.ordertotal.BaseOrderTotalModule;
import com.konakart.bl.modules.ordertotal.OrderTotalInterface;
import com.konakart.db.KKBasePeer;
import com.konakart.db.KKCriteria;
import com.konakart.om.BaseCouponPeer;
import com.konakart.om.BasePromotionToCouponPeer;
import com.workingdogs.village.DataSetException;
import com.workingdogs.village.Record;

/**
 * Module that creates an OrderTotal object for applying an amount discount on the order. It is used
 * for gift certificates.
 * 
 * The promotion may be activated only if:
 * <ul>
 * <li>The total amount of the order is greater than a minimum amount</li>
 * <li>The total number of products ordered is greater than a minimum amount</li>
 * <li>The total number of a single product ordered is greater than a minimum amount</li>
 * </ul>
 */
public class GiftCertificate extends BaseOrderTotalModule implements OrderTotalInterface
{
    // Module name must be the same as the class name although it can be all in lowercase
    private static String code = "ot_gift_certificate";

    private static String bundleName = BaseModule.basePackage
            + ".ordertotal.giftcertificate.GiftCertificate";

    private static HashMap<Locale, ResourceBundle> resourceBundleMap = new HashMap<Locale, ResourceBundle>();

    private static String mutex = "otGiftCertificateMutex";

    /** Hash Map that contains the static data */
    private static Map<String, StaticData> staticDataHM = Collections
            .synchronizedMap(new HashMap<String, StaticData>());

    // Configuration Keys

    private final static String MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_SORT_ORDER = "MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_SORT_ORDER";

    private final static String MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_STATUS = "MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_STATUS";

    // Message Catalog Keys
    private final static String MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_TITLE = "module.order.total.giftcertificate.title";

    /**
     * Constructor
     * 
     * @param eng
     *            the eng
     * 
     * @throws DataSetException
     *             an unexpected exception due to data in Torque (the database layer)
     * @throws KKException
     *             an unexpected exception from the KonaKart engine
     * @throws TorqueException
     *             an unexpected exception in Torque (the database layer)
     */
    public GiftCertificate(KKEngIf eng) throws TorqueException, KKException, DataSetException
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
     *             an unexpected exception from the KonaKart engine
     */
    public void setStaticVariables() throws KKException
    {
        KKConfiguration conf;
        StaticData staticData = staticDataHM.get(getStoreId());
        if (staticData == null)
        {
            staticData = new StaticData();
            staticDataHM.put(getStoreId(), staticData);
        }

        conf = getConfiguration(MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_SORT_ORDER);
        if (conf == null)
        {
            staticData.setSortOrder(0);
        } else
        {
            staticData.setSortOrder(new Integer(conf.getValue()).intValue());
        }
    }

    /**
     * Returns true or false
     * 
     * @throws KKException
     *             an unexpected exception from the KonaKart engine
     */
    public boolean isAvailable() throws KKException
    {
        return isAvailable(MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_STATUS);
    }

    /**
     * Create and return an OrderTotal object for the discount amount.
     * 
     * @param order
     *            the order
     * @param dispPriceWithTax
     *            the dispPriceWithTax
     * @param locale
     *            the locale
     * @return Returns an OrderTotal object for this module
     * @throws Exception
     *             an unexpected exception
     */
    public OrderTotal getOrderTotal(Order order, boolean dispPriceWithTax, Locale locale)
            throws Exception
    {
        StaticData sd = staticDataHM.get(getStoreId());

        // Get the resource bundle
        ResourceBundle rb = getResourceBundle(mutex, bundleName, resourceBundleMap, locale);
        if (rb == null)
        {
            throw new KKException(
                    "A resource file cannot be found for the country " + locale.getCountry());
        }

        // Get the promotions
        Promotion[] promArray = getPromMgr().getPromotions(code, order);

        // List to contain an order total for each promotion
        List<OrderTotal> myOrderTotalList = new ArrayList<OrderTotal>();

        boolean applyBeforeTax = true;

        // Get list of coupon codes from the order
        ArrayList<String> couponCodeList = getCouponCodeList(order);

        if (promArray != null)
        {
            for (int i = 0; i < promArray.length; i++)
            {
                Promotion promotion = promArray[i];

                /*
                 * Get the configuration parameters from the promotion
                 */

                // Minimum value for order
                BigDecimal minTotalOrderVal = getCustomBigDecimal(promotion.getCustom1(), 1);

                // Minimum total quantity of products ordered
                int minTotalQuantity = getCustomInt(promotion.getCustom2(), 2);

                // Need to order at least this quantity of a single product for promotion to apply
                int minProdQuantity = getCustomInt(promotion.getCustom3(), 3);

                // Actual discount amount
                BigDecimal discountApplied = getCustomBigDecimal(promotion.getCustom4(), 4);

                // If set to true, minimum value of order is applied to pre-tax value.
                applyBeforeTax = getCustomBoolean(promotion.getCustom5(), 5);

                // Don't bother going any further if there is no discount
                if (discountApplied == null || discountApplied.equals(new BigDecimal(0)))
                {
                    continue;
                }

                // Get the order value
                BigDecimal orderValue = null;
                if (applyBeforeTax)
                {
                    orderValue = order.getSubTotalExTax();
                } else
                {
                    orderValue = order.getSubTotalIncTax();
                }

                // If promotion doesn't cover any of the products in the order then go on to the
                // next promotion
                if (promotion.getApplicableProducts() == null
                        || promotion.getApplicableProducts().length == 0)
                {
                    continue;
                }

                // Does promotion only apply to a min order value ?
                if (minTotalOrderVal != null)
                {
                    if (orderValue.compareTo(minTotalOrderVal) < 0)
                    {
                        // If we haven't reached the minimum amount then continue to the next
                        // promotion
                        continue;
                    }
                }

                // Does promotion only apply to a minimum number of products ordered ?
                if (minTotalQuantity > 0)
                {
                    int total = 0;
                    for (int j = 0; j < promotion.getApplicableProducts().length; j++)
                    {
                        total += promotion.getApplicableProducts()[j].getQuantity();
                    }
                    if (total < minTotalQuantity)
                    {
                        // If we haven't reached the minimum total then continue to the next
                        // promotion
                        continue;
                    }
                }

                // Does promotion only apply to a minimum number of single products ordered ?
                if (minProdQuantity > 0)
                {
                    boolean foundMin = false;
                    for (int j = 0; j < promotion.getApplicableProducts().length; j++)
                    {
                        if (promotion.getApplicableProducts()[j].getQuantity() >= minProdQuantity)
                        {
                            foundMin = true;
                        }
                    }
                    if (!foundMin)
                    {
                        // If we haven't reached the minimum total then continue to the next
                        // promotion
                        continue;
                    }
                }

                /*
                 * If the coupon code list contains more than one entry, it could mean that the
                 * customer has entered multiple gift certificates and so wants multiple discounts.
                 * In the framework, each active promotion is processed only once so we deal with
                 * this special case for the gift certificate promotion here.
                 */
                if (couponCodeList.size() > 1)
                {
                    // Get active coupons from the coupon codes
                    ArrayList<CouponIf> activeCoupons = getNumActiveCoupons(promotion.getId(),
                            couponCodeList);
                    if (log.isDebugEnabled())
                    {
                        log.debug(activeCoupons.size() + " acive coupons found:");
                        for (Iterator<CouponIf> iterator = activeCoupons.iterator(); iterator
                                .hasNext();)
                        {
                            // Create an order total for each active coupon
                            CouponIf coupon = iterator.next();
                            log.debug(coupon.toString());
                        }
                    }
                    for (Iterator<CouponIf> iterator = activeCoupons.iterator(); iterator
                            .hasNext();)
                    {
                        // Create an order total for each active coupon
                        CouponIf coupon = iterator.next();
                        myOrderTotalList.add(getOrderTotal(promotion, order, coupon,
                                discountApplied, applyBeforeTax, sd, rb));
                    }
                } else
                {
                    // Create an order total in the standard way
                    myOrderTotalList.add(getOrderTotal(promotion, order, null, discountApplied,
                            applyBeforeTax, sd, rb));
                }
            }
        } else
        {
            // Return null if there are no promotions
            return null;
        }

        // Call a helper method to decide which OrderTotal we should return
        OrderTotal retOT = getDiscountOrderTotalFromList(order, myOrderTotalList, applyBeforeTax);

        return retOT;

    }

    /**
     * @param order
     * @return Returns a list of coupon codes retrieved from the order
     */
    private ArrayList<String> getCouponCodeList(Order order)
    {

        // Get list of coupon codes
        ArrayList<String> couponCodeList = new ArrayList<String>();
        if (order.getCouponCode() != null && order.getCouponCode().length() > 0)
        {
            String[] couponArray = order.getCouponCode().split(",");
            for (int i = 0; i < couponArray.length; i++)
            {
                String code = couponArray[i];
                couponCodeList.add(code);
            }
        }
        if (order.getGiftCertCode() != null && order.getGiftCertCode().length() > 0)
        {
            String[] giftCodeArray = order.getGiftCertCode().split(",");
            for (int i = 0; i < giftCodeArray.length; i++)
            {
                String code = giftCodeArray[i];
                couponCodeList.add(code);
            }
        }
        return couponCodeList;
    }

    /**
     * Common code to create an order total.
     * 
     * @param promotion
     * @param order
     * @param coupon
     * @param discountApplied
     * @param applyBeforeTax
     * @param sd
     * @param rb
     * @return Returns an OrderTotal object
     * @throws Exception
     */
    private OrderTotal getOrderTotal(Promotion promotion, Order order, CouponIf coupon,
            BigDecimal discountApplied, boolean applyBeforeTax, StaticData sd, ResourceBundle rb)
            throws Exception
    {
        OrderTotal ot = new OrderTotal();
        if (coupon != null)
        {
            /*
             * Promotion is repeated for each coupon so need to create a promotion clone and give
             * each clone the correct coupon
             */
            KKBeanCopier copier = new KKBeanCopier();
            PromotionIf prmCopy = copier.clonePromotion(promotion);
            prmCopy.setCoupon(coupon);
            ot.setPromotions(new Promotion[]
            { (Promotion) prmCopy });
        } else
        {
            /*
             * Only one coupon so we use the one that's already connected to the promotion
             */
            ot.setPromotions(new Promotion[]
            { promotion });
        }

        ot.setPromotionId(promotion.getId());
        ot.setDiscountAmount(discountApplied);
        ot.setSortOrder(sd.getSortOrder());
        ot.setClassName(code);

        ot.setValue(discountApplied);
        String formattedDiscount = getCurrMgr().formatPrice(discountApplied,
                order.getCurrencyCode());
        ot.setText("-" + formattedDiscount);
        // Title looks like "10EUR Gift Certificate:"
        ot.setTitle(
                formattedDiscount + " " + rb.getString(MODULE_ORDER_TOTAL_GIFT_CERTIFICATE_TITLE));

        // Get the tax portion of the discount
        int scale = new Integer(order.getCurrency().getDecimalPlaces()).intValue();
        BigDecimal tax = getTaxForDiscount(order, discountApplied, scale, applyBeforeTax);
        ot.setTax(tax);
        return ot;
    }

    /**
     * This is only called if there is more than one coupon code attached to the promotion. We do a
     * database lookup to get the coupons and figure out which ones are active. We return a coupon
     * object for each active one.
     * 
     * @param promotionId
     * @param couponCodeList
     * @return Returns a list of active coupons matching the codes in the couponCodeList
     * @throws DataSetException
     * @throws TorqueException
     */
    private ArrayList<CouponIf> getNumActiveCoupons(int promotionId,
            ArrayList<String> couponCodeList) throws DataSetException, TorqueException
    {

        // Search for an active coupon matching the coupon code
        KKCriteria c = getNewCriteria(/* AllStores */false);
        c.addSelectColumn(BaseCouponPeer.COUPON_CODE);
        c.addSelectColumn(BaseCouponPeer.COUPON_ID);
        c.addSelectColumn(BaseCouponPeer.DATE_ADDED);
        c.addSelectColumn(BaseCouponPeer.MAX_USE);
        c.addSelectColumn(BaseCouponPeer.TIMES_USED);

        // Add coupon code criteria
        KKCriteria.Criterion couponCrit = null;
        for (Iterator<String> iterator = couponCodeList.iterator(); iterator.hasNext();)
        {
            String coupon = iterator.next();
            if (couponCrit == null)
            {
                couponCrit = c.getNewCriterion(BaseCouponPeer.COUPON_CODE, coupon,
                        KKCriteria.EQUAL);
            } else
            {
                couponCrit = couponCrit.or(
                        c.getNewCriterion(BaseCouponPeer.COUPON_CODE, coupon, KKCriteria.EQUAL));
            }
        }
        c.add(couponCrit);

        // Add criteria.
        c.add(BasePromotionToCouponPeer.PROMOTION_ID, promotionId);
        c.addJoin(BasePromotionToCouponPeer.COUPON_ID, BaseCouponPeer.COUPON_ID);

        List<Record> rows = KKBasePeer.doSelect(c);

        /* For each coupon returned, we do a validity check before adding to the return list. */
        ArrayList<CouponIf> retList = new ArrayList<CouponIf>();
        for (Iterator<Record> iter = rows.iterator(); iter.hasNext();)
        {
            Record row = iter.next();
            Coupon coupon = new Coupon(row, c);
            if (coupon.isValid())
            {
                retList.add(coupon);
            }
        }

        return retList;
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
