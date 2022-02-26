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
-- From version 5.7.0.0 to version 5.7.5.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 5.7.0.0, the upgrade
-- scripts must be run sequentially.
-- 

DELETE FROM configuration WHERE configuration_key = 'SEO_URL_FORMAT';
set echo on
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'How to format the URLs for SEO', 'SEO_URL_FORMAT', '2', 'Decide the format of the URLs for SEO', 1, 30, 'option(0=OFF,1=SEO Parameters,2=SEO Directory Structure)', current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- Configuration variables for defining-store front base paths
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT nextval for configuration_seq, 'Store-Front base','STORE_FRONT_BASE','/konakart','Base directory used in JSPs for store-front application',4, 12, current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_IMG_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT nextval for configuration_seq, 'Store-Front image base','STORE_FRONT_IMG_BASE','/konakart/images','Image base used in JSPs for store-front application',4, 13, current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT nextval for configuration_seq, 'Store-Front script base','STORE_FRONT_SCRIPT_BASE','/konakart/script','Script base used in JSPs for store-front application',4, 14, current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, store_id) SELECT nextval for configuration_seq, 'Store-Front style sheet base','STORE_FRONT_STYLE_BASE','/konakart/styles','Style sheet base used in JSPs for store-front application',4, 15, current timestamp, store_id FROM configuration where configuration_key = 'STORE_COUNTRY';

-- New doesProductExist Admin API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'doesProductExist','', current timestamp);

-- Extend the size of the categories_name field
ALTER TABLE categories_description ALTER COLUMN categories_name SET DATA TYPE VARCHAR(256);
exit;
