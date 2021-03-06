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
-- From version 6.5.1.0 to version 6.6.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 6.5.1.0, the upgrade
-- scripts must be run sequentially.
-- 

set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '6.6.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='6.6.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

-- Add custom privileges for the Customers panel - default to allow access to the Custom button - custom 3 hides it
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder_2');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

-- Add extra custom fields to the kk_cust_attr table
ALTER TABLE kk_cust_attr ADD custom4 varchar(128);
ALTER TABLE kk_cust_attr ADD custom5 varchar(128);

-- Set Euro currency symbol where it was not previously set
UPDATE currencies set symbol_left = '???', symbol_right = '' where code = 'EUR' and (symbol_right = 'EUR' or symbol_right = '' or symbol_right is null);

-- Batch Log file location
DELETE FROM configuration WHERE configuration_key = 'BATCH_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT nextval for configuration_seq, 'Batch Log file Directory', 'BATCH_LOG_FILE_DIRECTORY', 'C:/KonaKart/batchlogs/', 'The location where KonaKart will write batch log files', 20, 2, current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Scheduler APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getJobStatus','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'runBatchJob','', current timestamp);

-- Panel for Scheduling
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_jobs','Scheduled Jobs', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_viewBatchLogs','View Batch Jobs', current timestamp);

-- Add access to the Scheduling Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_jobs';

-- Add access to the View Batch Logs Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewBatchLogs';

-- Admin APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertProductCategory', '', current timestamp);

-- Extend the size of the order name fields
ALTER TABLE orders ALTER COLUMN customers_name SET DATA TYPE VARCHAR(66);
ALTER TABLE orders ALTER COLUMN delivery_name SET DATA TYPE VARCHAR(66);
ALTER TABLE orders ALTER COLUMN billing_name SET DATA TYPE VARCHAR(66);

-- New Batch jobs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'com.konakartadmin.bl.AdminCustomerBatchMgr.countCustomersBatch', '', current timestamp);

-- New config variables for mobile application
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE_M';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added, store_id) SELECT nextval for configuration_seq, 'Mobile Store-Front script base','STORE_FRONT_SCRIPT_BASE_M','/konakart-m/script','Script base used in JSPs for mobile store-front application',4, 20, 1, current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE_M';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added, store_id) SELECT nextval for configuration_seq, 'Mobile Store-Front style sheet base','STORE_FRONT_STYLE_BASE_M','/konakart-m/styles','Style sheet base used in JSPs for mobile store-front application',4, 21, 1, current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- New custom fields for products_description
-- Note that here we only create them as VARCHAR(2) here (to optimise performance for users who don't need these)
-- If you need them to be longer you can modify these columns and change the Admin App validation to suit your needs
ALTER TABLE products_description ADD customd1 VARCHAR(2);
ALTER TABLE products_description ADD customd2 VARCHAR(2);
ALTER TABLE products_description ADD customd3 VARCHAR(2);
ALTER TABLE products_description ADD customd4 VARCHAR(2);
ALTER TABLE products_description ADD customd5 VARCHAR(2);
ALTER TABLE products_description ADD customd6 VARCHAR(2);

-- New tailFile API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'tailFile', '', current timestamp);


exit;
