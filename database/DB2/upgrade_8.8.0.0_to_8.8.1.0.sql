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
-- From version 8.8.0.0 to version 8.8.1.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.8.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '8.8.1.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='8.8.1.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

-- Role determines whether to activate customer clone and multi-delete buttons
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set clone and multi-delete buttons are hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'cloneCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCustomerMultiStore', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getStoresForCustomer', '', current timestamp);
exit;
