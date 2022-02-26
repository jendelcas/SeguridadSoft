-- (c) 2006 DS Data Systems UK Ltd, All rights reserved.
-- 
-- DS Data Systems and KonaKart and their respective logos, are
-- trademarks of DS Data Systems UK Ltd. All rights reserved.
-- 
-- The information in this document below this text is free software; you can redistribute
-- it and/or modify it under the terms of the GNU Lesser General Public
-- License as published by the Free Software Foundation; either
-- version 2.1 of the License, or (at your option) any later version.
-- 
-- This software is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
-- Lesser General Public License for more details.
-- 
-- -----------------------------------------------------------
-- KonaKart database script for MS Sql Server
-- -----------------------------------------------------------
-- 

DELETE FROM address_book where store_id = 'TARGET_STOREID';
DELETE FROM address_format where store_id = 'TARGET_STOREID';
DELETE FROM banners where store_id = 'TARGET_STOREID';
DELETE FROM banners_history where store_id = 'TARGET_STOREID';
DELETE FROM categories where store_id = 'TARGET_STOREID';
DELETE FROM categories_description where store_id = 'TARGET_STOREID';
DELETE FROM configuration where store_id = 'TARGET_STOREID';
DELETE FROM counter where store_id = 'TARGET_STOREID';
DELETE FROM counter_history where store_id = 'TARGET_STOREID';
DELETE FROM countries where store_id = 'TARGET_STOREID';
DELETE FROM coupon where store_id = 'TARGET_STOREID';
DELETE FROM currencies where store_id = 'TARGET_STOREID';
DELETE FROM customers where store_id = 'TARGET_STOREID';
DELETE FROM customers_basket where store_id = 'TARGET_STOREID';
DELETE FROM customers_basket_attrs where store_id = 'TARGET_STOREID';
DELETE FROM customers_info where store_id = 'TARGET_STOREID';
DELETE FROM geo_zones where store_id = 'TARGET_STOREID';
DELETE FROM ipn_history where store_id = 'TARGET_STOREID';
DELETE FROM kk_addr_to_product where store_id = 'TARGET_STOREID';
DELETE FROM kk_audit where store_id = 'TARGET_STOREID';
DELETE FROM kk_bookable_prod where store_id = 'TARGET_STOREID';
DELETE FROM kk_booking where store_id = 'TARGET_STOREID';
DELETE FROM kk_catalog where store_id = 'TARGET_STOREID';
DELETE FROM kk_catalog_quantity where store_id = 'TARGET_STOREID';
DELETE FROM kk_catalog_to_category where store_id = 'TARGET_STOREID';
DELETE FROM kk_category_to_tag_group where store_id = 'TARGET_STOREID';
DELETE FROM kk_content WHERE store_id = 'TARGET_STOREID';
DELETE FROM kk_content_desc WHERE store_id = 'TARGET_STOREID';
DELETE FROM kk_content_type WHERE store_id = 'TARGET_STOREID';
DELETE FROM kk_content_type_desc WHERE store_id = 'TARGET_STOREID';
DELETE FROM kk_cust_attr where store_id = 'TARGET_STOREID';
DELETE FROM kk_cust_attr_tmpl where store_id = 'TARGET_STOREID';
DELETE FROM kk_cust_stats where store_id = 'TARGET_STOREID';
DELETE FROM kk_customer_group where store_id = 'TARGET_STOREID';
DELETE FROM kk_customer_tag where store_id = 'TARGET_STOREID';
DELETE FROM kk_customers_to_role where store_id = 'TARGET_STOREID';
DELETE FROM kk_customers_to_tag where store_id = 'TARGET_STOREID';
DELETE FROM kk_digital_download_1 where store_id = 'TARGET_STOREID';
DELETE FROM kk_event where store_id = 'TARGET_STOREID';
DELETE FROM kk_expression where store_id = 'TARGET_STOREID';
DELETE FROM kk_expression_variable where store_id = 'TARGET_STOREID';
DELETE FROM kk_filter where store_id = 'TARGET_STOREID';
DELETE FROM kk_misc_item where store_id = 'TARGET_STOREID';
DELETE FROM kk_misc_item_type where store_id = 'TARGET_STOREID';
DELETE FROM kk_misc_price where store_id = 'TARGET_STOREID';
DELETE FROM kk_order_refunds where store_id = 'TARGET_STOREID';
DELETE FROM kk_order_shipments where store_id = 'TARGET_STOREID';
DELETE FROM kk_payment_schedule where store_id = 'TARGET_STOREID';
DELETE FROM kk_product_prices where store_id = 'TARGET_STOREID';
DELETE FROM kk_product_to_stores where store_id = 'TARGET_STOREID';
DELETE FROM kk_product_to_templates where store_id = 'TARGET_STOREID';
DELETE FROM kk_reserved_points where store_id = 'TARGET_STOREID';
DELETE FROM kk_reward_points where store_id = 'TARGET_STOREID';
DELETE FROM kk_promotion_to_expression where store_id = 'TARGET_STOREID';
DELETE FROM kk_role_to_api_call where store_id = 'TARGET_STOREID';
DELETE FROM kk_role_to_panel where store_id = 'TARGET_STOREID';
DELETE FROM kk_shipments_to_ord_prods where store_id = 'TARGET_STOREID';
DELETE FROM kk_shipper where store_id = 'TARGET_STOREID';
DELETE FROM kk_store where store_id = 'TARGET_STOREID';
DELETE FROM kk_subscription where store_id = 'TARGET_STOREID';
DELETE FROM kk_tag where store_id = 'TARGET_STOREID';
DELETE FROM kk_tag_group where store_id = 'TARGET_STOREID';
DELETE FROM kk_tag_group_to_tag where store_id = 'TARGET_STOREID';
DELETE FROM kk_tag_to_product where store_id = 'TARGET_STOREID';
DELETE FROM kk_tier_price where store_id = 'TARGET_STOREID';
DELETE FROM kk_tmpl_to_cust_attr where store_id = 'TARGET_STOREID';
DELETE FROM kk_wishlist where store_id = 'TARGET_STOREID';
DELETE FROM kk_wishlist_item where store_id = 'TARGET_STOREID';
DELETE FROM languages where store_id = 'TARGET_STOREID';
DELETE FROM manufacturers where store_id = 'TARGET_STOREID';
DELETE FROM manufacturers_info where store_id = 'TARGET_STOREID';
DELETE FROM newsletters where store_id = 'TARGET_STOREID';
DELETE FROM orders where store_id = 'TARGET_STOREID';
DELETE FROM orders_products where store_id = 'TARGET_STOREID';
DELETE FROM orders_products_attributes where store_id = 'TARGET_STOREID';
DELETE FROM orders_products_download where store_id = 'TARGET_STOREID';
DELETE FROM orders_returns where store_id = 'TARGET_STOREID';
DELETE FROM orders_status where store_id = 'TARGET_STOREID';
DELETE FROM orders_status_history where store_id = 'TARGET_STOREID';
DELETE FROM orders_total where store_id = 'TARGET_STOREID';
DELETE FROM prod_opt_vals_to_prod_opt where store_id = 'TARGET_STOREID';
DELETE FROM products where store_id = 'TARGET_STOREID';
DELETE FROM products_attributes where store_id = 'TARGET_STOREID';
DELETE FROM products_description where store_id = 'TARGET_STOREID';
DELETE FROM products_notifications where store_id = 'TARGET_STOREID';
DELETE FROM products_options where store_id = 'TARGET_STOREID';
DELETE FROM products_options_values where store_id = 'TARGET_STOREID';
DELETE FROM products_quantity where store_id = 'TARGET_STOREID';
DELETE FROM products_to_products where store_id = 'TARGET_STOREID';
DELETE FROM promotion where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_category where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_coupon where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_cust_group where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_customer where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_customer_use where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_manufacturer where store_id = 'TARGET_STOREID';
DELETE FROM promotion_to_product where store_id = 'TARGET_STOREID';
DELETE FROM returns_to_ord_prods where store_id = 'TARGET_STOREID';
DELETE FROM reviews where store_id = 'TARGET_STOREID';
DELETE FROM reviews_description where store_id = 'TARGET_STOREID';
DELETE FROM specials where store_id = 'TARGET_STOREID';
DELETE FROM tax_class where store_id = 'TARGET_STOREID';
DELETE FROM tax_rates where store_id = 'TARGET_STOREID';
DELETE FROM whos_online where store_id = 'TARGET_STOREID';
DELETE FROM zones where store_id = 'TARGET_STOREID';
DELETE FROM zones_to_geo_zones where store_id = 'TARGET_STOREID';
exit;
