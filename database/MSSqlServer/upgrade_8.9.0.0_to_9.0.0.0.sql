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
-- From version 8.9.0.0 to version 9.0.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.9.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '9.0.0.0 U', getdate());
UPDATE kk_config SET kk_config_value='9.0.0.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';

-- Product Recommendation Suggestions for Products and Customers (for Artificial Intelligence)
DROP TABLE kk_suggestion;
CREATE TABLE kk_suggestion (
  suggestion_version INT NOT NULL,
  suggestion_type INT NOT NULL,
  customers_id INT DEFAULT -1 NOT NULL,
  bought_prod_id INT DEFAULT -1 NOT NULL,
  suggested_prod_id INT NOT NULL,
  confidence INT DEFAULT -1 NOT NULL,
  custom1 VARCHAR(16),
  custom2 VARCHAR(16),
  custom3 VARCHAR(16),
  store_id VARCHAR(64) NULL,
  date_added datetime,
  PRIMARY KEY(suggestion_version, suggestion_type, customers_id, bought_prod_id, suggested_prod_id)
);
CREATE INDEX i_store_id_kk_suggestion ON kk_suggestion (store_id);
CREATE INDEX i_customers_id_kk_suggestion ON kk_suggestion (customers_id);
CREATE INDEX i_bought_prod_id_kk_suggestion ON kk_suggestion (bought_prod_id);

-- New API calls (for Artificial Intelligence)
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertSuggestions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteSuggestions', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getSuggestions', '', getdate());

-- Delete existing config variables for AI group
DELETE FROM configuration WHERE configuration_group_id = 34;

-- Create new configuration variables for AI
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_URL';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'URL for AI Service','ARTIFICIAL_INTELLIGENCE_URL','http://to-be-confirmed/','URL for Artificial Intelligence Service',34,10,getdate(),'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_CONNECT_TIMEOUT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Connection timeout for AI Service','ARTIFICIAL_INTELLIGENCE_CONNECT_TIMEOUT','20000','Connection timeout for Artificial Intelligence Service in milliseconds',34,20,getdate(),'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_READ_TIMEOUT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Read timeout for AI Service','ARTIFICIAL_INTELLIGENCE_READ_TIMEOUT','30000','Read timeout for Artificial Intelligence Service in milliseconds',34,30,getdate(),'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_USERNAME';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'AI Service Username','ARTIFICIAL_INTELLIGENCE_USERNAME','','Artificial Intelligence Service Username',34,40,getdate(),'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_PASSWORD';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, set_function, store_id) SELECT 'AI Service Password','ARTIFICIAL_INTELLIGENCE_PASSWORD','','Artificial Intelligence Service Password',34,50,getdate(),'0','password', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_VERSION';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'AI Data Current Version','ARTIFICIAL_INTELLIGENCE_VERSION','1','Current version of the Artificial Intelligence data',34,60,getdate(),'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Admin App Panel for configuration of Artificial Intelligence Configurations
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_ai_config','Artificial Intelligence Configuration', getdate());

-- Add Integrations Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_ai_config';

-- Config variable to issue warning for matching Coupon Codes in Admin App
DELETE FROM configuration where configuration_key = 'ADMIN_APP_WARN_OF_DUPLICATE_COUPONS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Warn of Duplicate Coupons', 'ADMIN_APP_WARN_OF_DUPLICATE_COUPONS', 'true', 'Issue warning in Admin App of duplicate coupon codes', '21', '32', 'choice(''true''=''true'',''false''=''false'')', getdate(),'0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Order Total field
ALTER TABLE orders_total ADD tax decimal(15,4);

-- Example config parameter for the User Defined Configuration Panel - string(min,max)
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_3';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Example Parameter 3','USER_DEFINED_EXAMPLE_3','2 to 40 characters only','Example of a config variable with a string setFun','31', '20', 'string(2,40)', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Used in storefront to set a startup catalog id
DELETE FROM configuration WHERE configuration_key = 'STARTUP_CATALOG_KEY';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Startup Catalog Key','STARTUP_CATALOG_KEY','','Default catalog key used at startup',1,80,getdate(),'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Products table column : stores the product image CRCs
ALTER TABLE products ADD product_image_crc VARCHAR(128);

-- Whether or not to maintain a product image cache with CRC values in the image file names
DELETE FROM configuration WHERE configuration_key = 'MAINTAIN_CRC_IMAGE_CACHE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Maintain CRC Cache','MAINTAIN_CRC_IMAGE_CACHE','Maintain a product image cache','Maintain a cache of images that contain the CRC value in the filename - only for WOND systems','4', '25', 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add column to kk_customer_tag
ALTER TABLE kk_customer_tag ADD weighting INT DEFAULT '0' NOT NULL;

-- Set some default weightings - these are used by the KonaKart Suggestions algorithm
UPDATE kk_customer_tag SET weighting = '700' WHERE name ='PRODUCTS_TIME_VIEWED';
UPDATE kk_customer_tag SET weighting = '800' WHERE name ='PRODUCTS_TIME_IN_CART';
UPDATE kk_customer_tag SET weighting = '900' WHERE name ='PRODUCTS_TIME_IN_WISHLIST';

-- Used in the Admin Console for the future date format for catalogs
DELETE FROM configuration WHERE configuration_key = 'CATALOG_FUTURE_DATE_FORMAT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Future Catalog Date Format','CATALOG_FUTURE_DATE_FORMAT','dd/MM/yyyy HH:mm','Future Catalog Date Format',1,100,getdate(),'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Recreate kk_product_prices - Start by renaming kk_product_prices table to kk_product_prices_temp
DROP TABLE kk_product_prices_temp;
SP_RENAME kk_product_prices, kk_product_prices_temp;

DROP TABLE kk_product_prices;
CREATE TABLE kk_product_prices (
  store_id VARCHAR(64),
  catalog_id VARCHAR(64) NOT NULL,
  products_id INT NOT NULL,
  products_attributes_id INT NOT NULL,
  tier_price_id INT DEFAULT 0 NOT NULL,
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
DROP TABLE kk_product_prices_temp;

-- Add new columns to kk_catalog
ALTER TABLE kk_catalog ADD cat_name_for VARCHAR(64);
ALTER TABLE kk_catalog ADD catalog_type INT DEFAULT '0' NOT NULL;
ALTER TABLE kk_catalog ADD date_active DATETIME;

-- Increase the size of the catalog key columns in kk_catalog
ALTER TABLE kk_catalog ALTER COLUMN cat_name NVARCHAR(64);

-- Add indexes to the kk_catalog table
CREATE INDEX i_cat_name_kk_catalog ON kk_catalog (cat_name);
CREATE INDEX i_cat_name_for_kk_catalog ON kk_catalog (cat_name_for);
CREATE INDEX i_date_active_kk_catalog ON kk_catalog (date_active);

-- Recreate kk_catalog_quantity - Start by renaming kk_catalog_quantity table to kk_catalog_quantity_temp
DROP TABLE kk_catalog_quantity_temp;
SP_RENAME kk_catalog_quantity, kk_catalog_quantity_temp;

-- Product Quantity Table for different catalog ids
DROP TABLE kk_catalog_quantity;
CREATE TABLE kk_catalog_quantity (
  store_id VARCHAR(64),
  catalog_id VARCHAR(64) NOT NULL,
  products_id INT NOT NULL,
  products_options VARCHAR(128) NOT NULL,
  products_quantity INT NOT NULL,
  products_date_available DATETIME,
  PRIMARY KEY(catalog_id, products_id, products_options)
);
CREATE INDEX i_kcq_store ON kk_catalog_quantity (store_id);
CREATE INDEX i_kcq_catname ON kk_catalog_quantity (catalog_id);
CREATE INDEX i_kcq_prodid ON kk_catalog_quantity (products_id);

-- Copy all the existing records back to the new kk_catalog_quantity table
INSERT INTO kk_catalog_quantity (store_id, catalog_id, products_id, products_options, products_quantity, products_date_available) SELECT store_id, catalog_id, products_id, products_options, products_quantity, products_date_available FROM kk_catalog_quantity_temp;

-- Drop the temporary table
DROP TABLE kk_catalog_quantity_temp;

-- Recreate kk_catalog_to_category - Start by renaming kk_catalog_to_category table to kk_catalog_to_category_tmp
DROP TABLE kk_catalog_to_category_tmp;
SP_RENAME kk_catalog_to_category, kk_catalog_to_category_tmp;

-- Product Quantity Table for different catalog ids
DROP TABLE kk_catalog_to_category;

-- Catalog to Category table
DROP TABLE kk_catalog_to_category;
CREATE TABLE kk_catalog_to_category (
  catalog_key VARCHAR(64) NOT NULL,
  categories_id INT NOT NULL,
  price_adjustment DECIMAL(15,4),
  fixed_price DECIMAL(15,4),
  exclude smallint DEFAULT 0,
  store_id VARCHAR(64),
  PRIMARY KEY(catalog_key, categories_id)
);
CREATE INDEX i_kclcg_store ON kk_catalog_to_category (store_id);
CREATE INDEX i_kclcg_catname ON kk_catalog_to_category (catalog_key);
CREATE INDEX i_kclcg_categid ON kk_catalog_to_category (categories_id);

-- Copy all the existing records back to the new kk_catalog_to_category table
INSERT INTO kk_catalog_to_category (catalog_key, categories_id, price_adjustment, fixed_price, exclude, store_id) SELECT catalog_key, categories_id, price_adjustment, fixed_price, exclude, store_id FROM kk_catalog_to_category_tmp;

-- Drop the temporary table
DROP TABLE kk_catalog_to_category_tmp;

-- Rename the set_function for OrderStatuses
UPDATE configuration SET set_function='OrderStatuses' WHERE set_function='tep_cfg_pull_down_order_statuses(';

-- Defines the Order Status Ids for "Completed Orders"
DELETE FROM configuration WHERE configuration_key = 'COMPLETED_ORDER_STATUS_IDS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Status Ids of completed orders','COMPLETED_ORDER_STATUS_IDS','3,5','Comma separated list of Completed Order Status Ids (used in Order Statistics batch jobs)',9,60,getdate(),'1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New Admin App Panel for setting user passwords
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_set_password','Set User Passwords', getdate());

exit;
