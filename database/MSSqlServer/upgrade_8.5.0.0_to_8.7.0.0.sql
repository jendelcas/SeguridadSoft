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
-- From version 8.5.0.0 to version 8.7.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.5.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.7.0.0 U', getdate());
UPDATE kk_config SET kk_config_value='8.7.0.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';



-- New API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateCustomerWithOptions', '', getdate());

-- Addition of username field
ALTER TABLE customers ADD customers_username VARCHAR(64);

-- Corrects an error from earlier insert of ERP_INT_INTEGRATION_ENABLED
UPDATE configuration SET configuration_value = 'false' WHERE configuration_key = 'ERP_INT_INTEGRATION_ENABLED' AND configuration_value LIKE '%false';

-- Change column types in currencies table for greater portability
ALTER TABLE currencies ALTER COLUMN decimal_point VARCHAR(1);
ALTER TABLE currencies ALTER COLUMN thousands_point VARCHAR(1);
ALTER TABLE currencies ALTER COLUMN decimal_places VARCHAR(1);


UPDATE configuration SET configuration_value = 'false' WHERE configuration_key = 'ERP_INT_INTEGRATION_ENABLED' AND configuration_value like '%false';

-- Add custom attributes to orders_returns
ALTER TABLE orders_returns ADD custom1 varchar(128);
ALTER TABLE orders_returns ADD custom2 varchar(128);
ALTER TABLE orders_returns ADD custom3 varchar(128);
ALTER TABLE orders_returns ADD custom1Dec decimal(15,4);
ALTER TABLE orders_returns ADD custom2Dec decimal(15,4);

-- Add new attributes to orders_products
ALTER TABLE orders_products ADD refund_value decimal(15,4);
ALTER TABLE orders_products ADD refund_points int NOT NULL default '-1';

-- Add new attributes to returns_to_ord_prods
ALTER TABLE returns_to_ord_prods ADD refund_value decimal(15,4);
ALTER TABLE returns_to_ord_prods ADD refund_points int NOT NULL default '-1';
ALTER TABLE returns_to_ord_prods ADD custom1 varchar(128);
ALTER TABLE returns_to_ord_prods ADD custom2 varchar(128);
ALTER TABLE returns_to_ord_prods ADD custom3 varchar(128);

-- Table for Custom Configs - this is only for an example of using the CustomStoreService with database calls
DROP TABLE custom_config;
CREATE TABLE custom_config (
  custom_config_id int NOT NULL identity(1,1),
  custom_key varchar(16),
  custom_value varchar(256),
  date_added datetime,
  PRIMARY KEY(custom_config_id)
);

-- ERP Integration Configuration
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_CUSTOMER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Export Customer to ERP', 'ERP_EXPORT_CUSTOMER', 'true', 'When set to true KonaKart will export customer information (when a customer registers) to ERP', 32, 50, 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration where configuration_key = 'ERP_MATCH_CUSTOMER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Send Match Customer message to ERP', 'ERP_MATCH_CUSTOMER', 'true', 'When set to true KonaKart will send a Match Customer message to ERP', 32, 60, 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_ORDER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Export Order to ERP', 'ERP_EXPORT_ORDER', 'true', 'When set to true KonaKart will export orders to ERP', 32, 70, 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Example config parameter for the User Defined Configuration Panel - MultiSelect
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_2';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Example Parameter 2','USER_DEFINED_EXAMPLE_2','1,3,5','Example of a MultiSelect parameter','31', '15', 'multiselect(0=date.day.short.Sun,1=date.day.short.Mon,2=date.day.short.Tue,3=date.day.short.Wed,4=date.day.short.Thu,5=date.day.short.Fri,6=date.day.short.Sat)', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add some indexes
CREATE INDEX i_orders_id_orders_status_history ON orders_status_history (orders_id);
CREATE INDEX i_orders_id_orders_products ON orders_products (orders_id);
CREATE INDEX i_customers_id_customers_basket ON customers_basket (customers_id);

-- Add additional custom attributes to orders
ALTER TABLE orders ADD custom11 varchar(16);
ALTER TABLE orders ADD custom12 varchar(16);
ALTER TABLE orders ADD custom13 varchar(16);
ALTER TABLE orders ADD custom14 varchar(16);
ALTER TABLE orders ADD custom15 varchar(16);
ALTER TABLE orders ADD custom16 varchar(16);
exit;
