#----------------------------------------------------------------
# KonaKart upgrade script from version 8.8.0.0 to version 8.8.1.0
#----------------------------------------------------------------
#
# In order to upgrade from earlier versions the upgrade scripts
# must be run sequentially
#

#MySQL -- For MySQL Only - Disable Safe Updates Mode
SET SQL_SAFE_UPDATES=0;

# Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.8.1.0 U', now());
UPDATE kk_config SET kk_config_value='8.8.1.0 MySQL', date_added=now() WHERE kk_config_key='VERSION';

# Role determines whether to activate customer clone and multi-delete buttons
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set clone and multi-delete buttons are hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

# New API calls
INSERT INTO kk_api_call (name, description, date_added) VALUES ('cloneCustomer', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteCustomerMultiStore', '', now());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getStoresForCustomer', '', now());
