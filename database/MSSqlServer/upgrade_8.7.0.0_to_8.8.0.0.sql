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
-- From version 8.7.0.0 to version 8.8.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 8.7.0.0, the upgrade
-- scripts must be run sequentially.
-- 


-- Set database version information
INSERT INTO kk_config (kk_config_key, kk_config_value, date_added) VALUES ('HISTORY', '8.8.0.0 U', getdate());
UPDATE kk_config SET kk_config_value='8.8.0.0 SQLServer', date_added=getdate() WHERE kk_config_key='VERSION';

-- Vendor table
DROP TABLE kk_vendor;
CREATE TABLE kk_vendor (
  vendor_id int NOT NULL identity(1,1),
  store_id varchar(64),
  vendor_name varchar(128) NOT NULL,
  vendor_desc varchar(256),
  company_id varchar(64),
  company_tax_id varchar(64),
  rating decimal(15,4),
  number_reviews int DEFAULT 0 NOT NULL,
  default_address_id int DEFAULT 0 NOT NULL,
  custom1 varchar(128),
  custom2 varchar(128),
  custom3 varchar(128),
  custom4 varchar(128),
  custom5 varchar(128),
  date_added datetime,
  last_updated datetime,
  PRIMARY KEY(vendor_id)
);

-- Vendor foreign keys
ALTER TABLE address_book ADD vendor_id int DEFAULT '0' NOT NULL;
ALTER TABLE reviews ADD vendor_id int DEFAULT '0' NOT NULL;
ALTER TABLE kk_store ADD vendor_id int DEFAULT '0' NOT NULL;

-- New APIs for Vendors
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteVendor', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('deleteVendorReview', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getReviewsPerVendor', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getVendorForId', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getVendorReview', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getVendorReviews', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('getVendors', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertVendor', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('updateVendor', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('addVendorToStore', '', getdate());

-- New Admin App Panels for Vendors
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_vendors','Vendor Maintenance', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_vendorForStore','Vendor For Store', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_vendorForReview','Vendor For Review', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_editVendor','Edit a Vendor', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_insertVendor','Insert a Vendor', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_storesForVendor','Stores for Vendor', getdate());

-- Add Vendor Management Panels to super admin role like kk_panel_stores
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_vendors';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_vendorForStore';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_vendorForReview';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_editVendor';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_insertVendor';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_storesForVendor';

-- Address Panel for vendors
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_vendor_address', 'Vendor Addresses', getdate());

-- Add Address Panel access to all roles that can access the Vendor panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_vendors' and p2.code='kk_panel_vendor_address';

-- Reviews Panels
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_vendor_reviews', 'Vendor Reviews For Vendor', getdate());
INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_all_vendor_reviews', 'Vendor Reviews', getdate());

-- Add Reviews Panels access to all roles that can access the Vendor panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_vendors' and p2.code='kk_panel_vendor_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, getdate(), store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_vendors' and p2.code='kk_panel_all_vendor_reviews';

-- Configuration variable to enable links to store details page in multi-vendor mode
DELETE FROM configuration WHERE configuration_key = 'MULTI_VENDOR_STORE_LINKS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Links to Store page in multi-vendor mode','MULTI_VENDOR_STORE_LINKS','true','Set to true to enable links to the store information page when in multi-vendor mode.','1', '36', 'choice(''true'', ''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Configuration variable to set SMTP server port
DELETE FROM configuration WHERE configuration_key = 'SMTP_PORT';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'SMTP Port','SMTP_PORT','25','SMTP Server Port','12', '2', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Control ERP Integration Customer notifications
DELETE FROM configuration WHERE configuration_key = 'ERP_CUSTOMER_NOTIFICATION';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Customer Update Notifications','ERP_CUSTOMER_NOTIFICATION','','Notifications when a customer registers or modifies his details or is deleted','32', '80', 'multiselect(1=label.insert,2=label.edit,3=label.delete)', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Control ERP Integration Order notifications
DELETE FROM configuration WHERE configuration_key = 'ERP_ORDER_NOTIFICATION';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Order Update Notifications','ERP_ORDER_NOTIFICATION','','Notifications when an order is inserted or the state is changed','32', '90', 'multiselect(1=label.insert,2=label.edit)', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Control ERP Integration Product notifications
DELETE FROM configuration WHERE configuration_key = 'ERP_PRODUCT_NOTIFICATION';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Product Update Notifications','ERP_PRODUCT_NOTIFICATION','','Notifications when a product is inserted, updated or deleted','32', '100', 'multiselect(1=label.insert,2=label.edit,3=label.delete)', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- System Admin Email Address
DELETE FROM configuration WHERE configuration_key = 'SYSADMIN_EMAIL_ADDRESS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Sys Admin Email','SYSADMIN_EMAIL_ADDRESS',configuration_value,'System Admin Email Address', '1', '5', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'STORE_OWNER_EMAIL_ADDRESS';

-- Notification of Storefront Exceptions
DELETE FROM configuration WHERE configuration_key = 'REPORT_STOREFRONT_EXCEPTIONS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Storefront Exceptions','REPORT_STOREFRONT_EXCEPTIONS','true','Report Storefront Exceptions', '12', '20', 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Notification of KKEng Exceptions
DELETE FROM configuration WHERE configuration_key = 'REPORT_KKENG_EXCEPTIONS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'KKEng Exceptions','REPORT_KKENG_EXCEPTIONS','true','Report KKEng Exceptions', '12', '25', 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Notification of KKAdmin Exceptions
DELETE FROM configuration WHERE configuration_key = 'REPORT_KKADMIN_EXCEPTIONS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'KKAdmin Exceptions','REPORT_KKADMIN_EXCEPTIONS','true','Report KKAdmin Exceptions', '12', '30', 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Extend the size of the sesskey column in the sessions table
-- Change the name of the value column to sessvalue to avoid using reserved words
-- For various reasons, mainly DB2/MS-SQL limitations, we drop the sessions table and recreate it
DROP TABLE sessions;
CREATE TABLE sessions (
  sesskey varchar(64) NOT NULL,
  expiry int NOT NULL,
  customer_id int NULL,
  value varchar(256) NULL,
  store_id varchar(64) NULL,
  custom1 varchar(128) NULL,
  custom2 varchar(128) NULL,
  custom3 varchar(128) NULL,
  custom4 varchar(128) NULL,
  custom5 varchar(128) NULL,
  PRIMARY KEY(sesskey)
);
CREATE INDEX i_store_id_sessions ON sessions (store_id);

-- Extend the size of the sesskey column in the kk_sso table
ALTER TABLE kk_sso ALTER COLUMN sesskey VARCHAR(64);

-- New copyFiles, renameFile and renameFiles API calls
INSERT INTO kk_api_call (name, description, date_added) VALUES ('copyFiles', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('renameFile', '', getdate());
INSERT INTO kk_api_call (name, description, date_added) VALUES ('renameFiles', '', getdate());

-- Create Role for B2B Customer Admin
INSERT INTO kk_role (name, description, date_added) VALUES ('B2B Customer Admin','Administrator of Company B2B Customers', getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getAddresses'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getCustomerForIdWithOptions'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'registerCustomer'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getCustomerTagsForCustomer'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'insertCustomerTagForCustomer'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'deleteCustomerTagForCustomer'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'updateCustomer'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getAddressById'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'deleteAddress'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'deleteCustomer'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'updateAddress'), getdate());
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'insertAddress'), getdate());

-- Customer tag for saving the Facebook login Id
DELETE FROM kk_customer_tag WHERE name ='FACEBOOK_LOGIN_ID';
INSERT INTO kk_customer_tag (name, description, validation, tag_type, max_ints, date_added, store_id) SELECT 'FACEBOOK_LOGIN_ID', 'The Facebook id for a customer logging in using Facebook', '', 0, 1, getdate(), store_id FROM (SELECT store_id FROM kk_customer_tag GROUP BY store_id) STORES;

-- New insertCatalogPrices API call
INSERT INTO kk_api_call (name, description, date_added) VALUES ('insertCatalogPrices', '', getdate());

-- Additional SOLR Configuration Variables
DELETE FROM configuration WHERE configuration_key = 'SOLR_NO_COMMITS_IN_CODE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Do not commit in code','SOLR_NO_COMMITS_IN_CODE','true','Do not send commits to SOLR in code','24', '60', 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration WHERE configuration_key = 'SOLR_DISTRIBUTED_TERMS_SEARCH';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'Distributed terms searching','SOLR_DISTRIBUTED_TERMS_SEARCH','false','Add distrib=true parameter to searches for terms','24', '200', 'choice(''true''=''true'',''false''=''false'')', getdate(), '1', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration WHERE configuration_key = 'SOLR_PATH';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'SOLR path','SOLR_PATH','solr/konakart','SOLR path (typically this is solr/konakart)','24', '40', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration WHERE configuration_key = 'ZOOKEEPER_HOSTS';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, store_id) SELECT 'Zookeeper Hosts','ZOOKEEPER_HOSTS','127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183','Addresses of one or more Zookeeper hosts used to look up live SOLR locations','24', '50', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration WHERE configuration_key = 'SOLR_ACCESS_MODE';
INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT 'SOLR Access Mode','SOLR_ACCESS_MODE','Solr','Do not send commits to SOLR in code','24', '20', 'option(Solr=dl.solr.access.mode.solr.url,Zookeeper=dl.solr.access.mode.zookeeper,Custom=dl.solr.access.mode.custom)', getdate(), '0', store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

UPDATE configuration SET configuration_value = REPLACE(configuration_value, 'solr/konakart', '') WHERE configuration_key = 'SOLR_URL';

-- Reorder the SOLR Group Configs
UPDATE configuration SET sort_order = 10 WHERE configuration_key = 'USE_SOLR_SEARCH';
UPDATE configuration SET sort_order = 30 WHERE configuration_key = 'SOLR_URL';
UPDATE configuration SET sort_order = 70 WHERE configuration_key = 'SOLR_DELETE_ON_COMMIT';
UPDATE configuration SET sort_order = 80 WHERE configuration_key = 'SOLR_DYNAMIC_FACETS';
UPDATE configuration SET sort_order = 90 WHERE configuration_key = 'SOLR_ENABLE_SPELLING_SUGGESTION';
UPDATE configuration SET sort_order = 100 WHERE configuration_key = 'SOLR_TERMS_PRE_REGEX';
UPDATE configuration SET sort_order = 110 WHERE configuration_key = 'SOLR_TERMS_POST_REGEX';
UPDATE configuration SET sort_order = 120 WHERE configuration_key = 'SOLR_ADD_TERM_IF_INVISIBLE';
UPDATE configuration SET sort_order = 130 WHERE configuration_key = 'SOLR_ADD_TERM_IF_DISABLED';
UPDATE configuration SET sort_order = 140 WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
UPDATE configuration SET sort_order = 150 WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_INVISIBLE';
UPDATE configuration SET sort_order = 160 WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_DISABLED';
UPDATE configuration SET sort_order = 170 WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
UPDATE configuration SET sort_order = 180 WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
UPDATE configuration SET sort_order = 190 WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
UPDATE configuration SET sort_order = 200 WHERE configuration_key = 'SOLR_DISTRIBUTED_TERMS_SEARCH';
exit;
