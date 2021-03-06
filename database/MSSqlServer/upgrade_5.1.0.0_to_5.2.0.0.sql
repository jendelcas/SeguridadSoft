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
-- KonaKart upgrade database script for MS Sql Server
-- From version 5.1.0.0 to version 5.2.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 5.1.0.0, the upgrade
-- scripts must be run sequentially.
-- 

ALTER TABLE zones ADD zone_invisible int DEFAULT 0 NOT NULL;
ALTER TABLE zones ADD zone_search varchar(64);
CREATE INDEX i_zozones ON zones (zone_search);

-- New API call for checking Data Integrity
INSERT INTO kk_api_call (name, description, date_added) VALUES ('checkDataIntegrity','', getdate());

-- Addition of custom fields to digital_downloads
ALTER TABLE kk_digital_download_1 ADD custom1 varchar(128);
ALTER TABLE kk_digital_download_1 ADD custom2 varchar(128);
ALTER TABLE kk_digital_download_1 ADD custom3 varchar(128);

-- Add an attribute to the orders table 
ALTER TABLE orders ADD shipping_service_code varchar(128);

-- Add custom field descriptions for Shipping Command on Order panels
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Export For Shipping button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Export For Shipping button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_orders');

UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Export button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Export button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_orders');

-- Config variable to define the location of the Shipping Orders
DELETE FROM configuration where configuration_key = 'EXPORT_ORDERS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Exported Orders Directory', 'EXPORT_ORDERS_BASE_DIRECTORY', 'C:/KonaKart/orders', 'Defines the root directory where the Orders are exported to', '7', '7', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- New exportOrder API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('exportOrder','', getdate());

-- Add description field to category
ALTER TABLE categories_description ADD description VARCHAR(MAX);

-- Move the Admin Currency Decimal Place Configuration Variable to the Admn App Configuration Panel
UPDATE configuration set configuration_group_id = 21, sort_order = 40 where configuration_key = 'ADMIN_CURRENCY_DECIMAL_PLACES' and configuration_group_id = 1;

-- Move the Admin Date Template Configuration Variable to the Admn App Configuration Panel
UPDATE configuration set configuration_group_id = 21, sort_order = 35 where configuration_key = 'ADMIN_APP_DATE_TEMPLATE' and configuration_group_id = 1;

-- Move the Email From and Send Extra Emails Configuration Variable to the Email Configuration Panel
UPDATE configuration set configuration_group_id = 12, sort_order = 6 where configuration_key = 'EMAIL_FROM' and configuration_group_id = 1;
UPDATE configuration set configuration_group_id = 12, sort_order = 6 where configuration_key = 'SEND_EXTRA_EMAILS_TO' and configuration_group_id = 1;

-- Config variable to define whether to allow wish lists for non logged in users
DELETE FROM configuration where configuration_key = 'ALLOW_WISHLIST_WHEN_NOT_LOGGED_IN';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT 'Allow Wish List when not logged in', 'ALLOW_WISHLIST_WHEN_NOT_LOGGED_IN', 'false', 'Allow wish list functionality to be available for customers that have not logged in', '1', '25', 'choice(''true'', ''false'')', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Config variable to define the Address that Orders are shipped from
DELETE FROM configuration where configuration_key = 'SHIP_FROM_STREET_ADDRESS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Ship From Street Address', 'SHIP_FROM_STREET_ADDRESS', '', 'Ship From Street Address - used by some of the Shipping Modules', '7', '2', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Config variable to define the City that Orders are shipped from
DELETE FROM configuration where configuration_key = 'SHIP_FROM_CITY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Ship From City', 'SHIP_FROM_CITY', '', 'Ship From City - used by some of the Shipping Modules', '7', '2', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Add weight attribute to Orders Products table
ALTER TABLE orders_products ADD weight decimal(10,2);

-- Config variable to define the Product Types that are not shown in the droplist on the Edit Product Panel
DELETE FROM configuration where configuration_key = 'HIDDEN_PRODUCT_TYPES';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Hidden Product Types', 'HIDDEN_PRODUCT_TYPES', '', 'The Product Types that are not shown in the droplist on the Edit Product Panel', '21', '27', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Product Quantity Table for different catalog ids
DROP TABLE kk_catalog_quantity;
CREATE TABLE kk_catalog_quantity (
  store_id varchar(64),
  catalog_id varchar(32) NOT NULL,
  products_id int NOT NULL,
  products_options varchar(128) NOT NULL,
  products_quantity int NOT NULL,
  products_date_available datetime,
  PRIMARY KEY(catalog_id,products_id, products_options)
);

-- Add new column to promotions table
ALTER TABLE promotion ADD max_use int NOT NULL DEFAULT '-1';

-- Tracks the number of times a promotion has been used
DROP TABLE promotion_to_customer_use;
CREATE TABLE promotion_to_customer_use (
  store_id varchar(64),
  promotion_id int NOT NULL,
  customers_id int NOT NULL,
  times_used int DEFAULT 0 NOT NULL,
  PRIMARY KEY(promotion_id,customers_id)
);

-- Page links
DELETE FROM configuration where configuration_key = 'MAX_DISPLAY_PAGE_LINKS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Search Result Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Maximum number of links used for page-sets - must be odd number', '3', '3', 'integer(3,null)', getdate());

-- Define the default state for reviews when written by a customer
DELETE FROM configuration where configuration_key = 'DEFAULT_REVIEW_STATE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT 'Default state for reviews', 'DEFAULT_REVIEW_STATE', '0', 'Allows you to make reviews visible only after approval if initial state is set to 1', '18', '10', 'integer(0,null)', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Add state attribute to reviews table
ALTER TABLE reviews ADD state int DEFAULT 0 NOT NULL;

-- Reviews Panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_reviews', 'Maintain Product Reviews', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_prod_reviews', 'Product Reviews for Product', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_cust_reviews', 'Product Reviews for Customer', getdate());

-- Add Reviews Panel access to all roles that can access the Product panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prod_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_cust_reviews';

-- getReviews API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getReviews','', getdate());

-- For storing all messages in the database
DROP TABLE kk_msg;
CREATE TABLE kk_msg (
  msg_key varchar(100) NOT NULL,
  msg_locale varchar(10) NOT NULL,
  msg_type int NOT NULL,
  msg_value text,
  PRIMARY KEY(msg_key,msg_type,msg_locale)
);

-- Add locale to languages table
ALTER TABLE languages ADD locale varchar(10);
UPDATE languages SET locale = code;
UPDATE languages SET locale = 'en_GB' where code = 'en';
UPDATE languages SET locale = 'de_DE' where code = 'de';
UPDATE languages SET locale = 'es_ES' where code = 'es';
UPDATE languages SET locale = 'pt_BR' where code = 'pt';

-- Messages Panel
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_messages', 'Maintain Application Messages', getdate());

-- Add Messages Panel access to all roles that can access the Languages panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_languages' and p2.code='kk_panel_messages';

-- Config variable to define the Messsage Types allowed in the System
DELETE FROM configuration where configuration_key = 'MESSAGE_TYPES';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Message Types', 'MESSAGE_TYPES', 'Application,AdminApp,AdminAppHelp', 'Used to populate the Message Types droplist in the Messages section', '21', '41', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Config variable to define whether we use files (the default) or the database for storing system messages
DELETE FROM configuration where configuration_key = 'USE_DB_FOR_MESSAGES';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT 'Use D/B For Messages', 'USE_DB_FOR_MESSAGES', 'false', 'If true use the Database for the system messsages, if false use file-based messages', '21', '40', 'choice(''true'', ''false'')', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- New Messages APIs
INSERT INTO kk_api_call (name, description, date_added) VALUES ('searchMsg','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getMsgValue','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteMsg','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertMsg','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateMsg','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('importMsgs','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('exportMsgs','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getLanguageById','', getdate());

-- Add indexes on product table
CREATE INDEX i_maproducts ON products (manufacturers_id);

-- Add new attribute to address_book table
ALTER TABLE address_book ADD manufacturers_id int DEFAULT 0 NOT NULL;

-- Address Panel
--INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_address', 'All Addresses', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_prod_address', 'Product Addresses', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_manu_address', 'Manufacturer Addresses', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_cust_address', 'Customer Addresses', getdate());

-- Add Address Panel access to all roles that can access the Customer panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_prod_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_manu_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_cust_address';

-- Table to connect products to addresses
DROP TABLE kk_addr_to_product;
CREATE TABLE kk_addr_to_product (
  store_id varchar(64),
  address_book_id int NOT NULL,
  products_id int NOT NULL,
  relation_type int DEFAULT 0 NOT NULL,
  PRIMARY KEY(address_book_id,products_id)
);

-- Configuration for address select panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDR_SEL_NUM_ADDRS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Address Select Default Num Addrs', 'ADMIN_APP_ADDR_SEL_NUM_ADDRS', '50', 'Sets the default number of addresses displayed in the address select dialogs when opened', '21', '50', getdate(), store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDR_SEL_MAX_NUM_ADDRS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Address Select Max Num Addrs', 'ADMIN_APP_ADDR_SEL_MAX_NUM_ADDRS', '100', 'Sets the maximum number of addresses displayed in the address select dialogs after a search', '21', '51', getdate(), store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_SELECT_PROD_ADDR_FORMAT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Addr Format for Prod Addr Sel', 'ADMIN_APP_SELECT_PROD_ADDR_FORMAT', '$company $street $street1 $suburb $city $state $country', 'How the address is formatted in the product select address panel', '21', '0', getdate(), store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ADDR_FORMAT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Addr Format for Prod Addr', 'ADMIN_APP_PROD_ADDR_FORMAT', '$company $street $street1 $suburb $city $state $country', 'How the address is formatted in the product address panel', '21', '0', getdate(), store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_ADDR_FORMAT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Addr Format for Cust Addr', 'ADMIN_APP_CUST_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the customer address panel', '21', '0', getdate(), store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_ADDR_FORMAT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Addr Format for Manu Addr', 'ADMIN_APP_MANU_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the manufacturer address panel', '21', '0', getdate(), store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- New address related API calls
INSERT INTO kk_api_call (name, description, date_added) VALUES ('addAddressesToProduct','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('removeAddressFromProduct','', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductCountPerAddress','', getdate());

-- New Manufacturer API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getManufacturers','', getdate());

-- For MS SQL Server - Use nvarchar(max) for products_description
ALTER TABLE products_description ALTER COLUMN products_description nvarchar(max);

-- New Product Option API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getProductOptions','', getdate());

-- Configuration for manufacturer panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_SEL_NUM_MANUS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Manufacturer Panel Default Num Manus', 'ADMIN_APP_MANU_SEL_NUM_MANUS', '50', 'Sets the default number of manufacturers displayed in the manufacturer panels and dialogs when opened', '21', '52', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_SEL_MAX_NUM_MANUS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Manufacturer Panel Max Num Manus', 'ADMIN_APP_MANU_SEL_MAX_NUM_MANUS', '100', 'Sets the maximum number of manufacturers displayed in the manufacturer panels and dialogs after a search', '21', '53', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Configuration for product option panel in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_OPT_SEL_NUM_PROD_OPTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Prod Option Panel Default Num Prod Opts', 'ADMIN_APP_PROD_OPT_SEL_NUM_PROD_OPTS', '50', 'Sets the default number of product options displayed in the prod option panel when opened', '21', '54', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_OPT_SEL_MAX_NUM_PROD_OPTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT 'Prod Option Panel Max Num Prod Opts', 'ADMIN_APP_PROD_OPT_SEL_MAX_NUM_PROD_OPTS', '100', 'Sets the maximum number of product options displayed in the prod option panel after a search', '21', '55', getdate(), store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

exit;
