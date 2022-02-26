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

package com.konakart.bl.modules.ordertotal.productdiscount;

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

import com.konakart.app.KKConfiguration;
import com.konakart.app.KKException;
import com.konakart.app.Order;
import com.konakart.app.OrderTotal;
import com.konakart.app.Product;
import com.konakart.app.Promotion;
import com.konakart.app.PromotionResult;
import com.konakart.appif.KKEngIf;
import com.konakart.appif.OrderProductIf;
import com.konakart.appif.OrderTotalIf;
import com.konakart.bl.modules.BaseModule;
import com.konakart.bl.modules.ordertotal.BaseOrderTotalModule;
import com.konakart.bl.modules.ordertotal.OrderTotalInterface;
import com.workingdogs.village.DataSetException;

/**
 * Module that creates an OrderTotal object for applying a percentage discount or an amount discount
 * on a single product normally because of a certain quantity is being purchased. The discount may
 * be applied on prices before or after tax.
 * 
 * The promotion may be activated on a product only if:
 * <ul>
 * <li>The total amount of the order is greater than a minimum amount</li>
 * <li>The total number of a single product ordered is greater than a minimum amount</li>
 * </ul>
 * 
 * There may be multiple valid promotions applicable for an order. If this is the case, the logic
 * applied is the following: All cumulative promotions are summed into one order total object. Then
 * we loop through the order total objects and choose the one that offers the largest discount.
 */
public class ProductDiscount extends BaseOrderTotalModule implements OrderTotalInterface
{
    /** Module name must be the same as the class name although it can be all in lowercase */
    public static String code = "ot_product_discount";

    private static String bundleName = BaseModule.basePackage
            + ".ordertotal.productdiscount.ProductDiscount";

    private static HashMap<Locale, ResourceBundle> resourceBundleMap = new HashMap<Locale, ResourceBundle>();

    private static String mutex = "otProductDiscountMutex";

    /** Hash Map that contains the static data */
    private static Map<String, StaticData> staticDataHM = Collections
            .synchronizedMap(new HashMap<String, StaticData>());

    // Configuration Keys

    private final static String MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_SORT_ORDER = "MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_SORT_ORDER";

    private final static String MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_STATUS = "MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_STATUS";

    // Message Catalogue Keys
    // private final static String MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_TITLE =
    // "module.order.total.productdiscount.title";

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
    public ProductDiscount(KKEngIf eng) throws TorqueException, KKException, DataSetException
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
        conf = getConfiguration(MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_SORT_ORDER);
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
        return isAvailable(MODULE_ORDER_TOTAL_PRODUCT_DISCOUNT_STATUS);
    }

    /**
     * Create and return an OrderTotal object for the discount amount. *
     * <p>
     * Custom field usage:
     * <ul>
     * <li>custom1 = Minimum Order Value</li>
     * <li>custom2 = Minimum quantity of a single product</li>
     * <li>custom3 = Discount Applied</li>
     * <li>custom4 = Percentage discount if set to true</li>
     * <li>custom5 = Discount applied to pre-tax value if set to true</li>
     * </ul>
     * If the promotion applies to multiple products, we create an array of order total objects and
     * attach the array to the order total that we return (ot.setOrderTotals(otArray)). The reason
     * for doing this is to get a line item of the order for each discounted product. We still need
     * to populate the order total that we return with the total discount amount because this will
     * be used to compare this promotion with other promotions in order to decide which one to use.
     * <p>
     * The returned OrderTotal custom attributes are populated as follows:
     * <ul>
     * <li>custom1 = Product Id</li>
     * <li>custom2 = Product SKU</li>
     * <li>custom3 = Encoded Product Id containing the product id and ids of the options.</li>
     * </ul>
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

        OrderTotal ot;
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

        // choice('true'='Product','false'='Promotion')
        boolean nonCumulativeProdLevel = true;

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

                // Need to order at least this quantity of a single product for promotion to apply
                int minProdQuantity = getCustomInt(promotion.getCustom2(), 2);

                // Actual discount. Could be a percentage or an amount.
                BigDecimal discountApplied = getCustomBigDecimal(promotion.getCustom3(), 3);

                // If set to true it is a percentage. Otherwise it is an amount.
                boolean percentageDiscount = getCustomBoolean(promotion.getCustom4(), 4);

                // If set to true, discount is applied to pre-tax value. Only relevant for
                // percentage discount.
                applyBeforeTax = getCustomBoolean(promotion.getCustom5(), 5);

                /*
                 * When promotions are not cumulative, we have to decide which discount to use if
                 * there is more than one applicable promotion. The standard KonaKart behaviour is
                 * to decide which promotion gives the biggest discount and to choose that one. In
                 * the case of the product discount promotion, sometimes it is more logical to
                 * consider each product individually and to decide on a product by product basis
                 * which discount to use for that product because the promotion that gives the
                 * biggest total discount may not be the one that gives the biggest discount for all
                 * products. For backwards compatibility the default bahaviour is to calculate at
                 * the promotion level. The calculation will only be done at the product level if
                 * all promotions are configured this way.
                 */
                if (promotion.getCustom6() != null
                        && promotion.getCustom6().equalsIgnoreCase("false"))
                {
                    nonCumulativeProdLevel = false;
                }

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

                ot = new OrderTotal();
                ot.setPromotionId(promotion.getId());
                ot.setSortOrder(sd.getSortOrder());
                ot.setClassName(code);
                ot.setPromotions(new Promotion[]
                { promotion });
                if (percentageDiscount)
                {
                    ot.setDiscountPercent(discountApplied);
                } else
                {
                    ot.setDiscountAmount(discountApplied);
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

                // Continue if promotion has no applicable products (should never happen)
                if (promotion.getApplicableProducts() == null)
                {
                    continue;
                }

                // Currency scale
                int scale = new Integer(order.getCurrency().getDecimalPlaces()).intValue();

                /*
                 * Create a new Order Total module for each discounted product and store in this
                 * list
                 */
                ArrayList<OrderTotal> otList = new ArrayList<OrderTotal>();

                // Loop through promotion products to determine whether to apply a discount
                boolean firstLoop = true;
                for (int j = 0; j < promotion.getApplicableProducts().length; j++)
                {
                    OrderProductIf op = promotion.getApplicableProducts()[j];
                    if (op != null && op.getQuantity() >= minProdQuantity)
                    {
                        String encodedProdId = getBasketMgr()
                                .createEncodedProduct(op.getProductId(), op.getOpts());

                        // Get the current total price of the product(s)
                        BigDecimal currentPrice = null;
                        if (applyBeforeTax)
                        {
                            currentPrice = op.getFinalPriceExTax();
                        } else
                        {
                            currentPrice = op.getFinalPriceIncTax();
                        }

                        // Apply the discount
                        BigDecimal discount = null;
                        if (percentageDiscount)
                        {
                            // Apply a percentage discount
                            discount = (currentPrice.multiply(discountApplied))
                                    .divide(new BigDecimal(100), scale, BigDecimal.ROUND_HALF_UP);
                        } else
                        {
                            // Apply an amount based discount
                            discount = discountApplied.multiply(new BigDecimal(op.getQuantity()));
                        }

                        // Determine whether it is the first discounted product or not
                        String formattedDiscount = getCurrMgr().formatPrice(discount,
                                order.getCurrencyCode());
                        if (firstLoop)
                        {
                            // Set the order total attributes
                            ot.setValue(discount);
                            if (op.getTaxRate() != null)
                            {
                                BigDecimal taxDiscount = null;
                                if (applyBeforeTax)
                                {
                                    taxDiscount = discount.multiply(op.getTaxRate()).divide(
                                            new BigDecimal(100), scale, BigDecimal.ROUND_HALF_UP);
                                } else
                                {
                                    taxDiscount = getTaxFromTotal(discount,
                                            op.getTaxRate().divide(new BigDecimal(100)), scale);
                                }
                                ot.setTax(taxDiscount);
                            }
                            if (percentageDiscount)
                            {
                                ot.setText("-" + formattedDiscount);
                                // Title looks like "-10% Philips TV"
                                ot.setTitle("-" + discountApplied + "% " + op.getName());

                            } else
                            {
                                ot.setText("-" + formattedDiscount);
                                // Title looks like "-10EUR Philips TV"
                                ot.setTitle("-" + formattedDiscount + " " + op.getName());
                            }
                            ot.setCustom1(Integer.toString(op.getProductId()));
                            ot.setCustom2(op.getSku());
                            ot.setCustom3(encodedProdId);
                        } else
                        {
                            // Set the order total attributes
                            ot.setValue(ot.getValue().add(discount));
                            if (op.getTaxRate() != null)
                            {
                                BigDecimal taxDiscount = null;
                                if (applyBeforeTax)
                                {
                                    taxDiscount = discount.multiply(op.getTaxRate()).divide(
                                            new BigDecimal(100), scale, BigDecimal.ROUND_HALF_UP);
                                } else
                                {
                                    taxDiscount = getTaxFromTotal(discount,
                                            op.getTaxRate().divide(new BigDecimal(100)), scale);
                                }
                                if (ot.getTax() == null)
                                {
                                    ot.setTax(taxDiscount);
                                } else
                                {
                                    ot.setTax(ot.getTax().add(taxDiscount));
                                }
                            }
                            ot.setText("-" + getCurrMgr().formatPrice(ot.getValue(),
                                    order.getCurrencyCode()));
                            ot.setTitle(ot.getTitle() + "," + op.getName());
                        }
                        firstLoop = false;

                        /*
                         * Create a new Order Total module for each product
                         */
                        OrderTotal singleOt = new OrderTotal();
                        singleOt.setPromotionId(promotion.getId());
                        singleOt.setSortOrder(sd.getSortOrder());
                        singleOt.setClassName(code);
                        singleOt.setValue(discount);
                        singleOt.setText("-" + formattedDiscount);
                        if (percentageDiscount)
                        {
                            singleOt.setTitle("-" + discountApplied + "% " + op.getName());
                            singleOt.setDiscountPercent(discountApplied);
                        } else
                        {
                            singleOt.setTitle("-" + formattedDiscount + " " + op.getName());
                            singleOt.setDiscountAmount(discountApplied);
                        }
                        singleOt.setCustom1(Integer.toString(op.getProductId()));
                        singleOt.setCustom2(op.getSku());
                        singleOt.setCustom3(encodedProdId);
                        otList.add(singleOt);
                    }
                }

                /*
                 * If we have more than one discounted product we create an array of order totals
                 * (one for each product) and add the array to the order total to be returned.
                 */
                if (otList.size() > 1)
                {
                    OrderTotal[] otArray = new OrderTotal[otList.size()];
                    int k = 0;
                    for (Iterator<OrderTotal> iterator = otList.iterator(); iterator.hasNext();)
                    {
                        OrderTotal lot = iterator.next();
                        otArray[k++] = lot;
                    }
                    ot.setOrderTotals(otArray);
                }

                if (ot.getValue() != null)
                {
                    ot.setValue(ot.getValue().setScale(scale, BigDecimal.ROUND_HALF_UP));
                    if (ot.getTax() != null)
                    {
                        ot.setTax(ot.getTax().setScale(scale, BigDecimal.ROUND_HALF_UP));
                    }
                    myOrderTotalList.add(ot);
                }
            }
        } else
        {
            // Return null if there are no promotions
            return null;
        }

        if (nonCumulativeProdLevel && myOrderTotalList.size() > 0)
        {
            /*
             * In order to consider each product individually and to decide on a product by product
             * basis which discount to use for that product, we need to group the order totals by
             * product and send each group to getDiscountOrderTotalFromList() to determine the
             * correct discount for that product. All of the returned OrderProducts need to be
             * bundled together in a single OrderProduct that can be returned.
             */
            HashMap<String, ArrayList<OrderTotal>> otMap = new HashMap<String, ArrayList<OrderTotal>>();
            for (Iterator<OrderTotal> iterator = myOrderTotalList.iterator(); iterator.hasNext();)
            {
                OrderTotal parentOT = iterator.next();
                if (parentOT.getOrderTotals() != null && parentOT.getOrderTotals().length > 0)
                {
                    for (int i = 0; i < parentOT.getOrderTotals().length; i++)
                    {
                        OrderTotal childOT = (OrderTotal) parentOT.getOrderTotals()[i];
                        childOT.setPromotions(parentOT.getPromotions());
                        String encodedProdId = childOT.getCustom3();
                        ArrayList<OrderTotal> otList = otMap.get(encodedProdId);
                        if (otList == null)
                        {
                            otList = new ArrayList<OrderTotal>();
                            otMap.put(encodedProdId, otList);
                        }
                        otList.add(childOT);
                    }
                } else
                {
                    String encodedProdId = parentOT.getCustom3();
                    ArrayList<OrderTotal> otList = otMap.get(encodedProdId);
                    if (otList == null)
                    {
                        otList = new ArrayList<OrderTotal>();
                        otMap.put(encodedProdId, otList);
                    }
                    otList.add(parentOT);
                }
            }
            /* Send each group of OTs for a single product to be processed */
            ArrayList<OrderTotal> retOTList = new ArrayList<OrderTotal>();
            for (Iterator<ArrayList<OrderTotal>> iterator = otMap.values().iterator(); iterator
                    .hasNext();)
            {
                ArrayList<OrderTotal> otList = iterator.next();
                OrderTotal retOT = getDiscountOrderTotalFromList(order, otList, applyBeforeTax);
                retOTList.add(retOT);
            }

            OrderTotal retOT = null;
            if (retOTList.size() == 1)
            {
                retOT = retOTList.get(0);
            } else
            {
                retOT = new OrderTotal();
                retOT.setSortOrder(sd.getSortOrder());
                retOT.setClassName(code);
                retOT.setOrderTotals(retOTList.toArray(new OrderTotalIf[retOTList.size()]));
            }

            // Modify the refund values of each product
            setRefundValues(order, retOT, applyBeforeTax);

            return retOT;
        }

        /*
         * We get to this point if we are using the behaviour where we choose the biggest discount
         * at the promotion level
         */

        // Call a helper method to decide which OrderTotal we should return
        OrderTotal retOT = getDiscountOrderTotalFromList(order, myOrderTotalList, applyBeforeTax);

        // Modify the refund values of each product
        setRefundValues(order, retOT, applyBeforeTax);

        /*
         * Commented example of how to modify the promotion module to not return Order Total modules
         * but to modify the actual product prices on the order. The new price is grabbed from the
         * refund value (after having removed tax) and then CalculateTotals() is called on the Order
         * to recalculate the order prices and totals. The old price is saved in the Price1
         * attribute of the order product so that the UI can use it to display the original price.
         * In order for this to work correctly, the sort order of the Product Discount module must
         * be changed for it to be called before the SubTotal module because CalculateTotals()
         * creates a new sub total that is picked up by the SubTotal module.
         */
        // for (int i = 0; i < order.getOrderProducts().length; i++)
        // {
        // OrderProductIf op = order.getOrderProducts()[i];
        // op.setPrice1(op.getFinalPriceIncTax());
        // op.setPrice(removeTax(op.getRefundValue(), op.getTaxRate(),
        // 7));
        // }
        //
        // int scale = getTaxMgr().getTaxScale();
        // int taxQuantityRule = getTaxMgr().getTaxQuantityRule();
        // order.calculateTotals(scale, taxQuantityRule);
        // return null;

        return retOT;

    }

    /**
     * Returns an object containing the promotion discount. This method is used to apply the
     * promotion to a single product.
     * 
     * @param product
     *            the product
     * @param promotion
     *            the promotion
     * @return Returns a PromotionResult object
     * @throws Exception
     *             an unexpected exception
     */
    public PromotionResult getPromotionResult(Product product, Promotion promotion) throws Exception
    {
        // Actual discount. Could be a percentage or an amount.
        BigDecimal discountApplied = getCustomBigDecimal(promotion.getCustom3(), 3);

        // Don't bother going any further if there is no discount
        if (discountApplied == null || discountApplied.equals(new BigDecimal(0)))
        {
            return null;
        }

        // If set to true it is a percentage. Otherwise it is an amount.
        boolean percentageDiscount = getCustomBoolean(promotion.getCustom4(), 4);

        // If set to true, discount is applied to pre-tax value. Only relevant for
        // percentage discount.
        boolean applyBeforeTax = getCustomBoolean(promotion.getCustom5(), 5);

        PromotionResult pd = new PromotionResult();
        pd.setPromotionId(promotion.getId());
        pd.setOrderTotalCode(code);
        pd.setValue(discountApplied);
        pd.setApplyBeforeTax(applyBeforeTax);
        pd.setPercentageDiscount(percentageDiscount);

        return pd;
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
