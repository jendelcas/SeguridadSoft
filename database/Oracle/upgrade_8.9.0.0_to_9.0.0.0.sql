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
-- KonaKart upgrade database script for Oracle
-- From version 8.9.0.0 to version 9.0.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.9.0.0, the upgrade
-- scripts must be run sequentially.
-- 
set escape \
-- You can comment out the next 'Alter session' line if using 11gR1 or earlier
Alter session set deferred_segment_creation=false;


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (kk_config_seq.nextval, 'HISTORY', '9.0.0.0 U', sysdate);
UPDATE kk_config SET kk_config_value='9.0.0.0 Oracle', date_added=sysdate WHERE kk_config_key='VERSION';

-- Product Recommendation Suggestions for Products and Customers (for Artificial Intelligence)
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_suggestion'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_suggestion (
  suggestion_version NUMBER(10,0) NOT NULL,
  suggestion_type NUMBER(10,0) NOT NULL,
  customers_id NUMBER(10,0) DEFAULT -1 NOT NULL,
  bought_prod_id NUMBER(10,0) DEFAULT -1 NOT NULL,
  suggested_prod_id NUMBER(10,0) NOT NULL,
  confidence NUMBER(10,0) DEFAULT -1 NOT NULL,
  custom1 VARCHAR2(16),
  custom2 VARCHAR2(16),
  custom3 VARCHAR2(16),
  store_id VARCHAR2(64) NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(suggestion_version, suggestion_type, customers_id, bought_prod_id, suggested_prod_id)
);
CREATE INDEX i_store_id_kk_suggestion ON kk_suggestion (store_id);
CREATE INDEX i_customers_id_kk_suggestion ON kk_suggestion (customers_id);
CREATE INDEX i_bought_prod_id_kk_suggestion ON kk_suggestion (bought_prod_id);

-- New API calls (for Artificial Intelligence)
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'insertSuggestions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'deleteSuggestions', '', sysdate);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'getSuggestions', '', sysdate);

-- Delete existing config variables for AI group
DELETE FROM configuration WHERE configuration_group_id = 34;

-- Create new configuration variables for AI
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'URL for AI Service','ARTIFICIAL_INTELLIGENCE_URL','http://to-be-confirmed/','URL for Artificial Intelligence Service',34,10,sysdate,'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_CONNECT_TIMEOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Connection timeout for AI Service','ARTIFICIAL_INTELLIGENCE_CONNECT_TIMEOUT','20000','Connection timeout for Artificial Intelligence Service in milliseconds',34,20,sysdate,'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_READ_TIMEOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Read timeout for AI Service','ARTIFICIAL_INTELLIGENCE_READ_TIMEOUT','30000','Read timeout for Artificial Intelligence Service in milliseconds',34,30,sysdate,'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_USERNAME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'AI Service Username','ARTIFICIAL_INTELLIGENCE_USERNAME','','Artificial Intelligence Service Username',34,40,sysdate,'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_PASSWORD';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, set_function, store_id) SELECT configuration_seq.nextval, 'AI Service Password','ARTIFICIAL_INTELLIGENCE_PASSWORD','','Artificial Intelligence Service Password',34,50,sysdate,'0','password', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_VERSION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'AI Data Current Version','ARTIFICIAL_INTELLIGENCE_VERSION','1','Current version of the Artificial Intelligence data',34,60,sysdate,'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Admin App Panel for configuration of Artificial Intelligence Configurations
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_ai_config','Artificial Intelligence Configuration', sysdate);

-- Add Integrations Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, sysdate, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_ai_config';

-- Config variable to issue warning for matching Coupon Codes in Admin App
DELETE FROM configuration where configuration_key = 'ADMIN_APP_WARN_OF_DUPLICATE_COUPONS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Warn of Duplicate Coupons', 'ADMIN_APP_WARN_OF_DUPLICATE_COUPONS', 'true', 'Issue warning in Admin App of duplicate coupon codes', '21', '32', 'choice(''true''=''true'',''false''=''false'')', sysdate,'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Order Total field
ALTER TABLE orders_total ADD tax decimal(15,4);

-- Example config parameter for the User Defined Configuration Panel - string(min,max)
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_3';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Example Parameter 3','USER_DEFINED_EXAMPLE_3','2 to 40 characters only','Example of a config variable with a string setFun','31', '20', 'string(2,40)', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Used in storefront to set a startup catalog id
DELETE FROM configuration WHERE configuration_key = 'STARTUP_CATALOG_KEY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Startup Catalog Key','STARTUP_CATALOG_KEY','','Default catalog key used at startup',1,80,sysdate,'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Products table column : stores the product image CRCs
ALTER TABLE products ADD product_image_crc VARCHAR(128);

-- Whether or not to maintain a product image cache with CRC values in the image file names
DELETE FROM configuration WHERE configuration_key = 'MAINTAIN_CRC_IMAGE_CACHE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Maintain CRC Cache','MAINTAIN_CRC_IMAGE_CACHE','Maintain a product image cache','Maintain a cache of images that contain the CRC value in the filename - only for WOND systems','4', '25', 'choice(''true''=''true'',''false''=''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add column to kk_customer_tag
ALTER TABLE kk_customer_tag ADD weighting INT DEFAULT '0' NOT NULL;

-- Set some default weightings - these are used by the KonaKart Suggestions algorithm
UPDATE kk_customer_tag SET weighting = '700' WHERE name ='PRODUCTS_TIME_VIEWED';
UPDATE kk_customer_tag SET weighting = '800' WHERE name ='PRODUCTS_TIME_IN_CART';
UPDATE kk_customer_tag SET weighting = '900' WHERE name ='PRODUCTS_TIME_IN_WISHLIST';

-- Used in the Admin Console for the future date format for catalogs
DELETE FROM configuration WHERE configuration_key = 'CATALOG_FUTURE_DATE_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Future Catalog Date Format','CATALOG_FUTURE_DATE_FORMAT','dd/MM/yyyy HH:mm','Future Catalog Date Format',1,100,sysdate,'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Recreate kk_product_prices - Start by renaming kk_product_prices table to kk_product_prices_temp
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_prices_temp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
ALTER TABLE kk_product_prices RENAME TO kk_product_prices_temp;

BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_prices'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_product_prices (
  store_id VARCHAR2(64),
  catalog_id VARCHAR2(64) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_attributes_id NUMBER(10,0) NOT NULL,
  tier_price_id NUMBER(10,0) DEFAULT 0 NOT NULL,
  products_price_0 DECIMAL(15,4),
  products_price_1 DECIMAL(15,4),
  products_price_2 DECIMAL(15,4),
  products_price_3 DECIMAL(15,4),
  PRIMARY KEY(catalog_id, products_id, products_attributes_id, tier_price_id)
);
CREATE INDEX i_kpp_name ON kk_product_prices (catalog_id);
CREATE INDEX i_kpp_prodid ON kk_product_prices (products_id);
CREATE INDEX i_kpp_store ON kk_product_prices (store_id);

-- Copy all the existing records to the new table
INSERT INTO kk_product_prices (store_id, catalog_id, products_id, products_attributes_id, tier_price_id, products_price_0, products_price_1, products_price_2, products_price_3) SELECT store_id, catalog_id, products_id, products_attributes_id, tier_price_id, products_price_0, products_price_1, products_price_2, products_price_3 FROM kk_product_prices_temp;

-- Drop the temporary table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_product_prices_temp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Add new columns to kk_catalog
ALTER TABLE kk_catalog ADD cat_name_for VARCHAR(64);
ALTER TABLE kk_catalog ADD catalog_type INT DEFAULT '0' NOT NULL;
ALTER TABLE kk_catalog ADD date_active TIMESTAMP;

-- Increase the size of the catalog key columns in kk_catalog
ALTER TABLE kk_catalog MODIFY cat_name VARCHAR(64);

-- Add indexes to the kk_catalog table
CREATE INDEX i_cat_name_kk_catalog ON kk_catalog (cat_name);
CREATE INDEX i_cat_name_for_kk_catalog ON kk_catalog (cat_name_for);
CREATE INDEX i_date_active_kk_catalog ON kk_catalog (date_active);

-- Recreate kk_catalog_quantity - Start by renaming kk_catalog_quantity table to kk_catalog_quantity_temp
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_quantity_temp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
ALTER TABLE kk_catalog_quantity RENAME TO kk_catalog_quantity_temp;

-- Product Quantity Table for different catalog ids
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_quantity'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_catalog_quantity (
  store_id VARCHAR2(64),
  catalog_id VARCHAR2(64) NOT NULL,
  products_id NUMBER(10,0) NOT NULL,
  products_options VARCHAR2(128) NOT NULL,
  products_quantity NUMBER(10,0) NOT NULL,
  products_date_available TIMESTAMP,
  PRIMARY KEY(catalog_id, products_id, products_options)
);
CREATE INDEX i_kcq_store ON kk_catalog_quantity (store_id);
CREATE INDEX i_kcq_catname ON kk_catalog_quantity (catalog_id);
CREATE INDEX i_kcq_prodid ON kk_catalog_quantity (products_id);

-- Copy all the existing records back to the new kk_catalog_quantity table
INSERT INTO kk_catalog_quantity (store_id, catalog_id, products_id, products_options, products_quantity, products_date_available) SELECT store_id, catalog_id, products_id, products_options, products_quantity, products_date_available FROM kk_catalog_quantity_temp;

-- Drop the temporary table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_quantity_temp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Recreate kk_catalog_to_category - Start by renaming kk_catalog_to_category table to kk_catalog_to_category_tmp
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_to_category_tmp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
ALTER TABLE kk_catalog_to_category RENAME TO kk_catalog_to_category_tmp;

-- Product Quantity Table for different catalog ids
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_to_category'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Catalog to Category table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_to_category'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE kk_catalog_to_category (
  catalog_key VARCHAR2(64) NOT NULL,
  categories_id NUMBER(10,0) NOT NULL,
  price_adjustment DECIMAL(15,4),
  fixed_price DECIMAL(15,4),
  exclude NUMBER(10,0) DEFAULT 0,
  store_id VARCHAR2(64),
  PRIMARY KEY(catalog_key, categories_id)
);
CREATE INDEX i_kclcg_store ON kk_catalog_to_category (store_id);
CREATE INDEX i_kclcg_catname ON kk_catalog_to_category (catalog_key);
CREATE INDEX i_kclcg_categid ON kk_catalog_to_category (categories_id);

-- Copy all the existing records back to the new kk_catalog_to_category table
INSERT INTO kk_catalog_to_category (catalog_key, categories_id, price_adjustment, fixed_price, exclude, store_id) SELECT catalog_key, categories_id, price_adjustment, fixed_price, exclude, store_id FROM kk_catalog_to_category_tmp;

-- Drop the temporary table
BEGIN EXECUTE IMMEDIATE 'DROP TABLE kk_catalog_to_category_tmp'; EXCEPTION WHEN OTHERS THEN NULL; END;
/

-- Rename the set_function for OrderStatuses
UPDATE configuration SET set_function='OrderStatuses' WHERE set_function='tep_cfg_pull_down_order_statuses(';

-- Defines the Order Status Ids for "Completed Orders"
DELETE FROM configuration WHERE configuration_key = 'COMPLETED_ORDER_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Status Ids of completed orders','COMPLETED_ORDER_STATUS_IDS','3,5','Comma separated list of Completed Order Status Ids (used in Order Statistics batch jobs)',9,60,sysdate,'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Admin App Panel for setting user passwords
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (kk_panel_seq.nextval, 'kk_panel_set_password','Set User Passwords', sysdate);

exit;
