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
-- KonaKart database script for Oracle
-- Created: Thu Dec 23 11:25:42 GMT 2021
-- -----------------------------------------------------------
-- 
set escape \
Delete from kk_store where store_id = 'store2';
set echo on
INSERT INTO kk_store (store_id, store_name, store_desc, store_enabled, store_under_maint, store_deleted, store_template, store_admin_email, store_logo_filename, store_css_filename, store_home, date_added) VALUES ('store2','store2','Store Called store2', 1,0,0,0, 'store2-admin@konakart.com', 'logo.png', 'style.css', 'derby', sysdate);

Delete from languages where store_id = 'store2';
INSERT INTO languages (languages_id, name, code, locale, image, directory, sort_order, store_id) VALUES (languages_seq.nextval, 'English', 'en', 'en_GB', 'icon.gif', 'english', 1, 'store2');

delete from configuration where configuration_key = 'DEFAULT_CURRENCY' and store_id = 'store2';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added, store_id) VALUES (configuration_seq.nextval, 'Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', '6', '0', 1, sysdate, 'store2');

delete from configuration where configuration_key = 'DEFAULT_LANGUAGE' and store_id = 'store2';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added, store_id) VALUES (configuration_seq.nextval, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', '6', '0', 1, sysdate, 'store2');

Delete from countries where store_id = 'store2';
INSERT INTO countries (countries_id, countries_name,countries_iso_code_2, countries_iso_code_3, address_format_id, store_id) VALUES (countries_seq.nextval,'United States','US','USA','1', 'store2');

Delete from address_book where store_id = 'store2';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, store_id) VALUES (address_book_seq.nextval,-1, 'm', 'ACME Inc.', 'store2', 'Admin', 'store2 Street', '', 'PostCodeX', 'City', '', 1, 'store2');

Delete from customers where store_id = 'store2';
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type, store_id) VALUES (customers_seq.nextval, 'm', 'store2', 'Admin', to_date('1977/01/01', 'yyyy/mm/dd'), 'store2-admin@konakart.com', -1, '019081', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1, 'store2');

Delete from customers_info where store_id = 'store2';
INSERT INTO customers_info select customers_id , sysdate, 0, sysdate, sysdate, 0, 'store2' from customers where customers_email_address = 'store2-admin@konakart.com' and store_id='store2';

UPDATE address_book set customers_id = (select customers_id from customers where customers_email_address = 'store2-admin@konakart.com' and store_id='store2') where customers_id=-1;
UPDATE customers set customers_default_address_id = (select address_book_id from address_book where entry_street_address='store2 Street' and entry_postcode='PostCodeX' and store_id='store2') where customers_default_address_id=-1;
UPDATE address_book set entry_country_id = (select countries_id from countries where store_id='store2') where store_id='store2';

-- Delete all store2 records (none expected however) and set store_id to store1 in the others...
DELETE FROM kk_customers_to_role where store_id = 'store2';
UPDATE kk_customers_to_role set store_id = 'store1';

-- We remove the Maintain Roles and Assign Roles panel from the Store Administrator role
delete from kk_role_to_panel where role_id = 5 and panel_id = 28;
delete from kk_role_to_panel where role_id = 5 and panel_id = 32;

-- Don't grant the administrator role access to change the Order Statuses - only the super user role
delete from kk_role_to_panel where role_id = 5 and panel_id = 34;
exit;
