------------------------------------------------------------------
-- Mago Integration Set-up
------------------------------------------------------------------

-- Set up MAGO as an integrated product

UPDATE configuration SET configuration_value='MAGO' WHERE configuration_key='INTEGRATED_PRODUCTS';

-- Set EUR as the default currency
UPDATE configuration SET configuration_value='EUR' WHERE configuration_key='DEFAULT_CURRENCY';

-- Display prices with tax
UPDATE configuration SET configuration_value='true' WHERE configuration_key='DISPLAY_PRICE_WITH_TAX';

-- Used to store a Mago Serial Number
DELETE FROM kk_config WHERE kk_config_key = 'MAGO_SERIAL_NUM';
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'MAGO_SERIAL_NUM', '', current timestamp);


-- Enable the sending of the ERP messages
UPDATE configuration SET configuration_value='2'     WHERE configuration_key='ERP_CUSTOMER_NOTIFICATION';
UPDATE configuration SET configuration_value='1,2'   WHERE configuration_key='ERP_ORDER_NOTIFICATION';
UPDATE configuration SET configuration_value=''      WHERE configuration_key='ERP_PRODUCT_NOTIFICATION';
UPDATE configuration SET configuration_value='false' WHERE configuration_key='ERP_MATCH_CUSTOMER';
UPDATE configuration SET configuration_value='false' WHERE configuration_key='ERP_EXPORT_CUSTOMER';
UPDATE configuration SET configuration_value='false' WHERE configuration_key='ERP_EXPORT_ORDER';
UPDATE configuration SET configuration_value='true'  WHERE configuration_key='ERP_INT_INTEGRATION_ENABLED';

UPDATE configuration SET configuration_value='false' WHERE configuration_key='STOCK_LIMITED';
UPDATE configuration SET configuration_value='0'     WHERE configuration_key='STOCK_REORDER_LEVEL';
UPDATE configuration SET configuration_value='0'     WHERE configuration_key='STOCK_WARN_LEVEL';

-- Set the Default data in teh Specifications tab
UPDATE configuration SET configuration_value='CONTENT_CUSTOM_ATTRS'  WHERE configuration_key='CONFIG_CONTENT_FOR_SPECS_TAB';

-- Remove Tax data
DELETE FROM geo_zones;
DELETE FROM zones_to_geo_zones;
DELETE FROM tax_class;
DELETE FROM tax_rates;
exit;
