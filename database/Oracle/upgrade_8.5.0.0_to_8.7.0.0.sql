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
-- From version 8.5.0.0 to version 8.7.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.5.0.0, the upgrade
-- scripts must be run sequentially.
-- 
set escape \
-- You can comment out the next 'Alter session' line if using 11gR1 or earlier
Alter session set deferred_segment_creation=false;


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (kk_config_seq.nextval, 'HISTORY', '8.7.0.0 U', sysdate);
UPDATE kk_config SET kk_config_value='8.7.0.0 Oracle', date_added=sysdate WHERE kk_config_key='VERSION';

-- For Oracle Only - Corrects incorrect values of REPORTS_STATUS_PAGE_URL in certain situations
UPDATE configuration SET configuration_value = SUBSTR(configuration_value, 0, INSTR(configuration_value, 'rptdesign')) || 'ptdesign&' || SUBSTR(configuration_value, INSTR(configuration_value, 'storeId')) WHERE configuration_value LIKE '%rptdesign__storeId%' AND configuration_key = 'REPORTS_STATUS_PAGE_URL';


-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (kk_api_call_seq.nextval, 'updateCustomerWithOptions', '', sysdate);

-- Addition of username field
ALTER TABLE customers ADD customers_username VARCHAR(64);

-- Corrects an error from earlier insert of ERP_INT_INTEGRATION_ENABLED
UPDATE configuration SET configuration_value = 'false' WHERE configuration_key = 'ERP_INT_INTEGRATION_ENABLED' AND configuration_value LIKE '%false';

-- Change column types in currencies table for greater portability
ALTER TABLE currencies MODIFY decimal_point VARCHAR(1);
ALTER TABLE currencies MODIFY thousands_point VARCHAR(1);
ALTER TABLE currencies MODIFY decimal_places VARCHAR(1);


UPDATE configuration SET configuration_value = 'false' WHERE configuration_key = 'ERP_INT_INTEGRATION_ENABLED' AND configuration_value like '%false';

-- Add custom attributes to orders_returns
ALTER TABLE orders_returns ADD custom1 varchar(128);
ALTER TABLE orders_returns ADD custom2 varchar(128);
ALTER TABLE orders_returns ADD custom3 varchar(128);
ALTER TABLE orders_returns ADD custom1Dec decimal(15,4);
ALTER TABLE orders_returns ADD custom2Dec decimal(15,4);

-- Add new attributes to orders_products
ALTER TABLE orders_products ADD refund_value decimal(15,4);
ALTER TABLE orders_products ADD refund_points int DEFAULT '-1' NOT NULL;

-- Add new attributes to returns_to_ord_prods
ALTER TABLE returns_to_ord_prods ADD refund_value decimal(15,4);
ALTER TABLE returns_to_ord_prods ADD refund_points int DEFAULT '-1' NOT NULL;
ALTER TABLE returns_to_ord_prods ADD custom1 varchar(128);
ALTER TABLE returns_to_ord_prods ADD custom2 varchar(128);
ALTER TABLE returns_to_ord_prods ADD custom3 varchar(128);

-- Table for Custom Configs - this is only for an example of using the CustomStoreService with database calls
BEGIN EXECUTE IMMEDIATE 'DROP TABLE custom_config'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE custom_config (
  custom_config_id NUMBER(10,0) NOT NULL,
  custom_key VARCHAR2(16),
  custom_value VARCHAR2(256),
  date_added TIMESTAMP,
  PRIMARY KEY(custom_config_id)
);
BEGIN EXECUTE IMMEDIATE 'DROP SEQUENCE custom_config_SEQ'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE SEQUENCE custom_config_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- ERP Integration Configuration
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_CUSTOMER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Export Customer to ERP', 'ERP_EXPORT_CUSTOMER', 'true', 'When set to true KonaKart will export customer information (when a customer registers) to ERP', 32, 50, 'choice(''true''=''true'',''false''=''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration where configuration_key = 'ERP_MATCH_CUSTOMER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Send Match Customer message to ERP', 'ERP_MATCH_CUSTOMER', 'true', 'When set to true KonaKart will send a Match Customer message to ERP', 32, 60, 'choice(''true''=''true'',''false''=''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_ORDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Export Order to ERP', 'ERP_EXPORT_ORDER', 'true', 'When set to true KonaKart will export orders to ERP', 32, 70, 'choice(''true''=''true'',''false''=''false'')', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Example config parameter for the User Defined Configuration Panel - MultiSelect
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_2';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT configuration_seq.nextval, 'Example Parameter 2','USER_DEFINED_EXAMPLE_2','1,3,5','Example of a MultiSelect parameter','31', '15', 'multiselect(0=date.day.short.Sun,1=date.day.short.Mon,2=date.day.short.Tue,3=date.day.short.Wed,4=date.day.short.Thu,5=date.day.short.Fri,6=date.day.short.Sat)', sysdate, '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add some indexes
CREATE INDEX i_or_orders_status_history ON orders_status_history (orders_id);
CREATE INDEX i_orders_id_orders_products ON orders_products (orders_id);
CREATE INDEX i_cu_customers_basket ON customers_basket (customers_id);

-- Add additional custom attributes to orders
ALTER TABLE orders ADD custom11 varchar(16);
ALTER TABLE orders ADD custom12 varchar(16);
ALTER TABLE orders ADD custom13 varchar(16);
ALTER TABLE orders ADD custom14 varchar(16);
ALTER TABLE orders ADD custom15 varchar(16);
ALTER TABLE orders ADD custom16 varchar(16);
exit;
