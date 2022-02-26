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
-- From version 8.8.0.0 to version 8.8.1.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.8.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.8.1.0 U', getdate());
UPDATE kk_config SET kk_config_value='8.8.1.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';

-- Role determines whether to activate customer clone and multi-delete buttons
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set clone and multi-delete buttons are hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

-- New API calls
INSERT INTO kk_api_call (name, description, date_added) VALUES ('cloneCustomer', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteCustomerMultiStore', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getStoresForCustomer', '', getdate());
exit;
