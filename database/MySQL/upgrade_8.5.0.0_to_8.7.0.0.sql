#----------------------------------------------------------------
# KonaKart upgrade script from version 8.5.0.0 to version 8.7.0.0
#----------------------------------------------------------------
#
# In order to upgrade from earlier versions the upgrade scripts
# must be run sequentially
#

#MySQL -- For MySQL Only - Disable Safe Updates Mode
SET SQL_SAFE_UPDATES=0;

# Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.7.0.0 U', now());
UPDATE kk_config SET kk_config_value='8.7.0.0 MySQL', date_added=now() WHERE kk_config_key='VERSION';

#Oracle -- For Oracle Only - Corrects incorrect values of REPORTS_STATUS_PAGE_URL in certain situations
#Oracle UPDATE configuration SET configuration_value = SUBSTR(configuration_value, 0, INSTR(configuration_value, 'rptdesign')) || 'ptdesign&' || SUBSTR(configuration_value, INSTR(configuration_value, 'storeId')) WHERE configuration_value LIKE '%rptdesign__storeId%' AND configuration_key = 'REPORTS_STATUS_PAGE_URL';

#DB2 -- For DB2 Only - Corrects incorrect values of REPORTS_STATUS_PAGE_URL in certain situations
#DB2 UPDATE configuration SET configuration_value = SUBSTR(configuration_value, 1, INSTR(configuration_value, 'rptdesign')) || 'ptdesign&' || SUBSTR(configuration_value, INSTR(configuration_value, 'storeId')) WHERE configuration_value LIKE '%rptdesign__storeId%' AND configuration_key = 'REPORTS_STATUS_PAGE_URL';

# New API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateCustomerWithOptions', '', now());

# Addition of username field
ALTER TABLE customers ADD COLUMN customers_username VARCHAR(64);

# Corrects an error from earlier insert of ERP_INT_INTEGRATION_ENABLED
UPDATE configuration SET configuration_value = 'false' WHERE configuration_key = 'ERP_INT_INTEGRATION_ENABLED' AND configuration_value LIKE '%false';

# Change column types in currencies table for greater portability
ALTER TABLE currencies MODIFY decimal_point VARCHAR(1);
ALTER TABLE currencies MODIFY thousands_point VARCHAR(1);
ALTER TABLE currencies MODIFY decimal_places VARCHAR(1);

#DB2 -- For DB2 Only - Required after modifying columns
#DB2 call SYSPROC.ADMIN_CMD ('REORG TABLE currencies');

UPDATE configuration SET configuration_value = 'false' WHERE configuration_key = 'ERP_INT_INTEGRATION_ENABLED' AND configuration_value like '%false';

# Add custom attributes to orders_returns
ALTER TABLE orders_returns ADD COLUMN custom1 varchar(128);
ALTER TABLE orders_returns ADD COLUMN custom2 varchar(128);
ALTER TABLE orders_returns ADD COLUMN custom3 varchar(128);
ALTER TABLE orders_returns ADD COLUMN custom1Dec decimal(15,4);
ALTER TABLE orders_returns ADD COLUMN custom2Dec decimal(15,4);

# Add new attributes to orders_products
ALTER TABLE orders_products ADD COLUMN refund_value decimal(15,4);
ALTER TABLE orders_products ADD COLUMN refund_points int NOT NULL default '-1';

# Add new attributes to returns_to_ord_prods
ALTER TABLE returns_to_ord_prods ADD COLUMN refund_value decimal(15,4);
ALTER TABLE returns_to_ord_prods ADD COLUMN refund_points int NOT NULL default '-1';
ALTER TABLE returns_to_ord_prods ADD COLUMN custom1 varchar(128);
ALTER TABLE returns_to_ord_prods ADD COLUMN custom2 varchar(128);
ALTER TABLE returns_to_ord_prods ADD COLUMN custom3 varchar(128);

# Table for Custom Configs - this is only for an example of using the CustomStoreService with database calls
DROP TABLE IF EXISTS custom_config;
CREATE TABLE custom_config (
   custom_config_id int NOT NULL auto_increment,
   custom_key varchar(16),
   custom_value varchar(256),
   date_added datetime,
   PRIMARY KEY (custom_config_id)
);

# ERP Integration Configuration
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_CUSTOMER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Export Customer to ERP', 'ERP_EXPORT_CUSTOMER', 'true', 'When set to true KonaKart will export customer information (when a customer registers) to ERP', 32, 50, 'choice(''true''=''true'',''false''=''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration where configuration_key = 'ERP_MATCH_CUSTOMER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Send Match Customer message to ERP', 'ERP_MATCH_CUSTOMER', 'true', 'When set to true KonaKart will send a Match Customer message to ERP', 32, 60, 'choice(''true''=''true'',''false''=''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_ORDER';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Export Order to ERP', 'ERP_EXPORT_ORDER', 'true', 'When set to true KonaKart will export orders to ERP', 32, 70, 'choice(''true''=''true'',''false''=''false'')', now(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

# Example config parameter for the User Defined Configuration Panel - MultiSelect
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_2';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Example Parameter 2','USER_DEFINED_EXAMPLE_2','1,3,5','Example of a MultiSelect parameter','31', '15', 'multiselect(0=date.day.short.Sun,1=date.day.short.Mon,2=date.day.short.Tue,3=date.day.short.Wed,4=date.day.short.Thu,5=date.day.short.Fri,6=date.day.short.Sat)', now(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

# Add some indexes
ALTER TABLE orders_status_history ADD KEY idx_orders_id (orders_id);
ALTER TABLE orders_products ADD KEY idx_orders_id (orders_id);
ALTER TABLE customers_basket ADD KEY idx_customers_id (customers_id);

# Add additional custom attributes to orders
ALTER TABLE orders ADD COLUMN custom11 varchar(16);
ALTER TABLE orders ADD COLUMN custom12 varchar(16);
ALTER TABLE orders ADD COLUMN custom13 varchar(16);
ALTER TABLE orders ADD COLUMN custom14 varchar(16);
ALTER TABLE orders ADD COLUMN custom15 varchar(16);
ALTER TABLE orders ADD COLUMN custom16 varchar(16);
