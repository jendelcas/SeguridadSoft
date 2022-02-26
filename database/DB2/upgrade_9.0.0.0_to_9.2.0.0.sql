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
-- From version 9.0.0.0 to version 9.2.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 9.0.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '9.2.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='9.2.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

UPDATE currencies SET symbol_left = 'CHF ' WHERE title = 'CHF';

-- Used to decide what content to show in the specifications panel in the product detail page
DELETE FROM configuration WHERE configuration_key = 'CONFIG_CONTENT_FOR_SPECS_TAB';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Content for specifications tab','CONFIG_CONTENT_FOR_SPECS_TAB','CONTENT_CUSTOM_ATTRS','Content to display in specifications tab of product detail panel',1,110,'option(CONTENT_CUSTOM_ATTRS=label.custom.attrs,CONTENT_COMPARISON_DATA=label.productComparison)',current timestamp,1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add a tax rate code and propogate this through to the order totals
ALTER TABLE orders_total ADD code VARCHAR(64);
ALTER TABLE tax_rates ADD tax_rate_code VARCHAR(64);

-- Update the expires_date on the demo data specials
UPDATE specials SET expires_date=to_date('2030-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS') WHERE products_id IN (SELECT products_id FROM products WHERE products_model IN ('MSIMPRO', 'DVD-BLDRNDC', 'DVD-MATR','DVD-CUFI'));

-- Add unit of measure attributes to product
ALTER TABLE products ADD weight_uom varchar(32);
ALTER TABLE products ADD size_uom varchar(32);

-- New API Call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeRelatedProduct', '', current timestamp);
exit;
