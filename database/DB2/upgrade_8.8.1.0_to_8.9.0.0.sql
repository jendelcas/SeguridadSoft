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
-- KonaKart upgrade database script for DB2
-- From version 8.8.1.0 to version 8.9.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.8.1.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '8.9.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='8.9.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

-- Used in storefront to decide whether to enable double opt-in for customer registration
DELETE FROM configuration WHERE configuration_key = 'ENABLE_REGISTRATION_DOUBLE_OPT_IN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Enable Registration Double Opt-In','ENABLE_REGISTRATION_DOUBLE_OPT_IN','false','When true, a customer receives an eMail with a link to click on to confirm registration',1, 60, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Used in storefront to decide whether to enable double opt-in for newsletter sign up
DELETE FROM configuration WHERE configuration_key = 'ENABLE_NEWSLETTER_DOUBLE_OPT_IN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Enable Newsletter Double Opt-In','ENABLE_NEWSLETTER_DOUBLE_OPT_IN','false','When true, a customer receives an eMail with a link to click on to confirm newsletter subscription',1, 65, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';


-- For DB2 Only - Increase size of the msg_value column in kk_msg
ALTER TABLE kk_msg ALTER COLUMN msg_value SET DATA TYPE VARCHAR(7000);

-- Used in storefront to set a default customer catalog if the customer does not have one assigned in a customer tag value
DELETE FROM configuration WHERE configuration_key = 'DEFAULT_CATALOG_KEY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Default Catalog Key','DEFAULT_CATALOG_KEY','','Default catalog key to use if the customer does not have one assigned in a customer tag value',1,70,current timestamp,1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeMallStore', '', current timestamp);

-- Drop store_id on products_to_categories table
ALTER TABLE products_to_categories DROP store_id;
-- For DB2 Only - REORG Required after dropping the store_id column
call SYSPROC.ADMIN_CMD ('REORG TABLE products_to_categories');

-- Add custom_attrs to the orders_products table
ALTER TABLE orders_products ADD custom_attrs VARCHAR(4000);

-- Extend the size of the password columns
ALTER TABLE customers ALTER COLUMN customers_password SET DATA TYPE VARCHAR(96);
ALTER TABLE kk_cust_pwd_hist ALTER COLUMN password SET DATA TYPE VARCHAR(96);

-- Increase length of configuration variables
ALTER TABLE configuration ALTER COLUMN configuration_value SET DATA TYPE VARCHAR(2048);

-- New Admin App Panel for configuration of integrations
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_integrations','Configuration for Integrations', current timestamp);

-- Add Integrations Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_integrations';

-- Used to store a comma separated list of integrated products
DELETE FROM configuration WHERE configuration_key = 'INTEGRATED_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Integrated Products','INTEGRATED_PRODUCTS','','Used to store a comma separated list of integrated products',33, 10, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add functionality to allow role based access to the Custom tab on the EditProduct panel
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='Set to deny access to the Custom Tab' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

-- Add more custom attribute to promotion
ALTER TABLE promotion ADD custom11 varchar(128);
ALTER TABLE promotion ADD custom12 varchar(128);
ALTER TABLE promotion ADD custom13 varchar(128);
ALTER TABLE promotion ADD custom14 varchar(128);
ALTER TABLE promotion ADD custom15 varchar(128);
ALTER TABLE promotion ADD custom16 varchar(128);
ALTER TABLE promotion ADD custom17 varchar(128);
ALTER TABLE promotion ADD custom18 varchar(128);
ALTER TABLE promotion ADD custom19 varchar(128);
ALTER TABLE promotion ADD custom20 varchar(128);

-- Customer tag updates
UPDATE kk_customer_tag SET validation = '((:[0-9]+)+:|)' WHERE validation = '((:[0-9]*)*:|)';
ALTER TABLE kk_customers_to_tag ALTER COLUMN tag_value SET DATA TYPE VARCHAR(1024);

DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_TIME_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added, store_id) SELECT nextval for kk_customer_tag_seq,'PRODUCTS_TIME_VIEWED', 'Recently viewed product id', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp, store_id FROM (SELECT store_id FROM kk_customer_tag GROUP BY store_id) STORES;
DELETE FROM kk_customer_tag WHERE name ='CATEGORIES_TIME_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added, store_id) SELECT nextval for kk_customer_tag_seq,'CATEGORIES_TIME_VIEWED', 'Recently viewed category id', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp, store_id FROM (SELECT store_id FROM kk_customer_tag GROUP BY store_id) STORES;
DELETE FROM kk_customer_tag WHERE name ='MANUFACTURERS_TIME_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added, store_id) SELECT nextval for kk_customer_tag_seq,'MANUFACTURERS_TIME_VIEWED', 'Recently viewed manufacturer id', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp, store_id FROM (SELECT store_id FROM kk_customer_tag GROUP BY store_id) STORES;
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_TIME_IN_CART';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added, store_id) SELECT nextval for kk_customer_tag_seq,'PRODUCTS_TIME_IN_CART', 'Id of a product in the cart', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp, store_id FROM (SELECT store_id FROM kk_customer_tag GROUP BY store_id) STORES;
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_TIME_IN_WISHLIST';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added, store_id) SELECT nextval for kk_customer_tag_seq,'PRODUCTS_TIME_IN_WISHLIST', 'Id of a product in the Wish List', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp, store_id FROM (SELECT store_id FROM kk_customer_tag GROUP BY store_id) STORES;
exit;
