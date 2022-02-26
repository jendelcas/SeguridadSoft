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
-- From version 9.2.0.0 to version 9.4.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 9.2.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
set echo on
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '9.4.0.0 U', current timestamp);
UPDATE kk_config SET kk_config_value='9.4.0.0 DB2', date_added=current timestamp WHERE kk_config_key='VERSION';

-- Add net weight or volume attributes
ALTER TABLE products ADD net_weight_vol decimal(15,4);
ALTER TABLE products ADD net_weight_vol_uom varchar(32);

-- New attributes for bookings
ALTER TABLE kk_booking ADD state int DEFAULT 0;
ALTER TABLE kk_booking ADD last_modified TIMESTAMP;

-- New API Calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteReviewsPerCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteVendorReviewsPerCustomer', '', current timestamp);

-- Table for order return status
DROP TABLE kk_order_return_status;
CREATE TABLE kk_order_return_status (
  returns_status_pk INTEGER NOT NULL,
  store_id VARCHAR(64),
  returns_status_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  returns_status_name VARCHAR(32) NOT NULL,
  PRIMARY KEY(returns_status_pk)
);
DROP SEQUENCE kk_order_return_status_SEQ;
CREATE SEQUENCE kk_order_return_status_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add status to order returns table
ALTER TABLE orders_returns ADD status int DEFAULT 0 NOT NULL;

-- New API Calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderReturnStatuses', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteOrderReturnStatus', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertOrderReturnStatus', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertOrderReturnStatuses', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateOrderReturnStatus', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllOrderReturnStatuses', '', current timestamp);

-- Add some default order return statuses

INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name, store_id) SELECT nextval for kk_order_return_status_SEQ, 0,language_id,'Undefined',store_id from orders_status;
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name, store_id) SELECT nextval for kk_order_return_status_SEQ, 1,language_id,'Requested',store_id from orders_status;
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name, store_id) SELECT nextval for kk_order_return_status_SEQ, 2,language_id,'Approved',store_id from orders_status;
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name, store_id) SELECT nextval for kk_order_return_status_SEQ, 3,language_id,'Rejected',store_id from orders_status;
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name, store_id) SELECT nextval for kk_order_return_status_SEQ, 4,language_id,'Received',store_id from orders_status;

UPDATE kk_order_return_status SET returns_status_name = 'Undefiniert' WHERE returns_status_id = 0 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'de');
UPDATE kk_order_return_status SET returns_status_name = 'Erwünscht'   WHERE returns_status_id = 1 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'de');
UPDATE kk_order_return_status SET returns_status_name = 'Genehmigt'   WHERE returns_status_id = 2 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'de');
UPDATE kk_order_return_status SET returns_status_name = 'Abgelehnt'   WHERE returns_status_id = 3 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'de');
UPDATE kk_order_return_status SET returns_status_name = 'Empfangen'   WHERE returns_status_id = 4 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'de');

UPDATE kk_order_return_status SET returns_status_name = 'Indefinido' WHERE returns_status_id = 0 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'es');
UPDATE kk_order_return_status SET returns_status_name = 'Solicitado' WHERE returns_status_id = 1 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'es');
UPDATE kk_order_return_status SET returns_status_name = 'Aprobado'   WHERE returns_status_id = 2 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'es');
UPDATE kk_order_return_status SET returns_status_name = 'Rechazado'  WHERE returns_status_id = 3 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'es');
UPDATE kk_order_return_status SET returns_status_name = 'Recibido'   WHERE returns_status_id = 4 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'es');

UPDATE kk_order_return_status SET returns_status_name = 'Indefinido' WHERE returns_status_id = 0 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'pt');
UPDATE kk_order_return_status SET returns_status_name = 'Solicitada' WHERE returns_status_id = 1 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'pt');
UPDATE kk_order_return_status SET returns_status_name = 'Aprovado'   WHERE returns_status_id = 2 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'pt');
UPDATE kk_order_return_status SET returns_status_name = 'Rejeitado'  WHERE returns_status_id = 3 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'pt');
UPDATE kk_order_return_status SET returns_status_name = 'Recebido'   WHERE returns_status_id = 4 AND returns_status_pk >= 0 AND language_id IN (SELECT languages_id from languages WHERE code = 'pt');

-- Order Return statuses panel
-- New Admin App Panel for configuration of Order Return Statuses
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_orderReturnStatuses','Order Return Statuses', current timestamp);

-- Give Order Return statuses panel access to all roles that can access the 'kk_panel_orderStatuses' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orderStatuses' and p2.code='kk_panel_orderReturnStatuses';

-- Configuration variable for defining an output queue prefix
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Output Queue Prefix','ERP_OUTPUT_QUEUE_PREFIX','KonaKart.','Output queue name for ERP integration is this prefix + storeId + .Q',32,110,current timestamp,1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New configuration variable to allow setting of STARTTLS for emails
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'SMTP StartTLS','SMTP_STARTTLS','false','Whether or not to enable STARTTLS', 12, 3,current timestamp,1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- New configuration variable to be used for custom purposes as a System Id
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'System ID','SYSTEM_ID','','Can be used for any custom purpose to identify the system',32,120,current timestamp,1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Add tax rate code to order product table
ALTER TABLE orders_products ADD tax_rate_code varchar(64);

-- More custom fields for Manufacturer
ALTER TABLE manufacturers ADD custom6 varchar(128);
ALTER TABLE manufacturers ADD custom7 varchar(128);
ALTER TABLE manufacturers ADD custom8 varchar(128);
ALTER TABLE manufacturers ADD custom9 varchar(128);
ALTER TABLE manufacturers ADD custom10 varchar(128);

-- Run Initial Search on Products Panel
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Run Initial Product Search', 'PROD_PANEL_RUN_INITIAL_SEARCH', 'true','Set to true to always run the initial Product Search',21, 13,'choice(''true''=''true'',''false''=''false'')', current timestamp,1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- For specifying whether or not customer tags are intended to be used in expressions
ALTER TABLE kk_customer_tag ADD used_in_expressions INTEGER DEFAULT 1 NOT NULL;

-- Do not allow the B2B_ or _TIME_tags to be used in expressions
UPDATE kk_customer_tag set used_in_expressions = 0 WHERE name LIKE 'B2B_%';
UPDATE kk_customer_tag set used_in_expressions = 0 WHERE name LIKE '%_TIME_%';

-- Eliminate Duplicates and standardise Customer Tag Names
UPDATE kk_customer_tag SET description = 'Id of a product in the cart with time' WHERE name = 'PRODUCTS_TIME_IN_CART' AND description = 'Id of a product in the cart';
UPDATE kk_customer_tag SET description = 'Id of a product in the wish list with time' WHERE name = 'PRODUCTS_TIME_IN_WISHLIST' AND description = 'Id of a product in the Wish List';
UPDATE kk_customer_tag SET description = 'Id of a product in the wish list' WHERE name = 'PRODUCTS_IN_WISHLIST' AND description = 'Id of a product in the Wish List';
UPDATE kk_customer_tag SET description = 'Recently viewed category id with time' WHERE name = 'CATEGORIES_TIME_VIEWED' AND description = 'Recently viewed category id';
UPDATE kk_customer_tag SET description = 'Recently viewed manufacturer id with time' WHERE name = 'MANUFACTURERS_TIME_VIEWED' AND description = 'Recently viewed manufacturer id';
UPDATE kk_customer_tag SET description = 'Recently viewed product id with time' WHERE name = 'PRODUCTS_TIME_VIEWED' AND description = 'Recently viewed product id';

-- New KKAdminIf API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCatalogWithOptions', '', current timestamp);
exit;