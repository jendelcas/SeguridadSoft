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
-- From version 5.8.0.0 to version 6.0.0.0
-- -----------------------------------------------------------
-- In order to upgrade from versions prior to 5.8.0.0, the upgrade
-- scripts must be run sequentially.
-- 

ALTER TABLE ipn_history ADD transaction_type varchar(128);
ALTER TABLE ipn_history ADD transaction_amount decimal(15,4);
ALTER TABLE ipn_history ADD custom1 varchar(128);
ALTER TABLE ipn_history ADD custom2 varchar(128);
ALTER TABLE ipn_history ADD custom3 varchar(128);
ALTER TABLE ipn_history ADD custom4 varchar(128);
ALTER TABLE ipn_history ADD custom1Dec decimal(15,4);
ALTER TABLE ipn_history ADD custom2Dec decimal(15,4);

-- Extend the size of the product option and option value fields
ALTER TABLE products_options ALTER COLUMN products_options_name VARCHAR(64);
ALTER TABLE orders_products_attributes ALTER COLUMN products_options VARCHAR(64);
ALTER TABLE orders_products_attributes ALTER COLUMN products_options_values VARCHAR(64);

-- Add a new product option type
ALTER TABLE products_options ADD option_type int DEFAULT '0' NOT NULL;
ALTER TABLE customers_basket_attributes ADD attr_type int DEFAULT '0' NOT NULL;
ALTER TABLE customers_basket_attributes ADD attr_quantity int DEFAULT '0';
ALTER TABLE customers_basket_attributes ADD customers_basket_id int DEFAULT '0' NOT NULL;
ALTER TABLE orders_products_attributes ADD attr_type int DEFAULT '0' NOT NULL;
ALTER TABLE orders_products_attributes ADD attr_quantity int DEFAULT '0';

-- No longer used
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DATE_TEMPLATE';

exit;
