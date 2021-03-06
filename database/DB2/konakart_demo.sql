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
-- KonaKart database script for DB2
-- Created: Thu Dec 23 11:26:07 GMT 2021
-- -----------------------------------------------------------
-- 


DROP TABLE address_book;
CREATE TABLE address_book (
  address_book_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  entry_gender char(1) NOT NULL,
  entry_company VARCHAR(32),
  entry_firstname VARCHAR(32) NOT NULL,
  entry_lastname VARCHAR(32) NOT NULL,
  entry_street_address VARCHAR(64) NOT NULL,
  entry_suburb VARCHAR(32),
  entry_postcode VARCHAR(10) NOT NULL,
  entry_city VARCHAR(32) NOT NULL,
  entry_state VARCHAR(32),
  entry_country_id INTEGER DEFAULT 0 NOT NULL,
  entry_zone_id INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(address_book_id)
);
DROP SEQUENCE address_book_SEQ;
CREATE SEQUENCE address_book_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE address_format;
CREATE TABLE address_format (
  address_format_id INTEGER NOT NULL,
  address_format VARCHAR(128) NOT NULL,
  address_summary VARCHAR(48) NOT NULL,
  PRIMARY KEY(address_format_id)
);
DROP SEQUENCE address_format_SEQ;
CREATE SEQUENCE address_format_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE banners;
CREATE TABLE banners (
  banners_id INTEGER NOT NULL,
  banners_title VARCHAR(64) NOT NULL,
  banners_url VARCHAR(255) NOT NULL,
  banners_image VARCHAR(64) NOT NULL,
  banners_group VARCHAR(10) NOT NULL,
  banners_html_text VARCHAR(4000),
  expires_impressions INTEGER DEFAULT 0,
  expires_date TIMESTAMP DEFAULT ,
  date_scheduled TIMESTAMP DEFAULT ,
  date_added TIMESTAMP NOT NULL,
  date_status_change TIMESTAMP DEFAULT ,
  status INTEGER DEFAULT 1 NOT NULL,
  PRIMARY KEY(banners_id)
);
DROP SEQUENCE banners_SEQ;
CREATE SEQUENCE banners_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE banners_history;
CREATE TABLE banners_history (
  banners_history_id INTEGER NOT NULL,
  banners_id INTEGER NOT NULL,
  banners_shown INTEGER DEFAULT 0 NOT NULL,
  banners_clicked INTEGER DEFAULT 0 NOT NULL,
  banners_history_date TIMESTAMP NOT NULL,
  PRIMARY KEY(banners_history_id)
);
DROP SEQUENCE banners_history_SEQ;
CREATE SEQUENCE banners_history_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE categories;
CREATE TABLE categories (
  categories_id INTEGER NOT NULL,
  categories_image VARCHAR(64),
  parent_id INTEGER DEFAULT 0 NOT NULL,
  sort_order INTEGER,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(categories_id)
);
DROP SEQUENCE categories_SEQ;
CREATE SEQUENCE categories_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE categories_description;
CREATE TABLE categories_description (
  categories_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  categories_name VARCHAR(32) NOT NULL,
  PRIMARY KEY(categories_id, language_id)
);

DROP TABLE configuration;
CREATE TABLE configuration (
  configuration_id INTEGER NOT NULL,
  configuration_title VARCHAR(64) NOT NULL,
  configuration_key VARCHAR(64) NOT NULL,
  configuration_value VARCHAR(255) ,
  configuration_description VARCHAR(255) NOT NULL,
  configuration_group_id INTEGER NOT NULL,
  sort_order INTEGER ,
  last_modified TIMESTAMP ,
  date_added TIMESTAMP NOT NULL,
  use_function VARCHAR(255) ,
  set_function VARCHAR(255) ,
  PRIMARY KEY(configuration_id)
);
DROP SEQUENCE configuration_SEQ;
CREATE SEQUENCE configuration_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE configuration_group;
CREATE TABLE configuration_group (
  configuration_group_id INTEGER NOT NULL,
  configuration_group_title VARCHAR(64) NOT NULL,
  configuration_group_desc VARCHAR(255) NOT NULL,
  sort_order INTEGER ,
  visible INTEGER DEFAULT 1 ,
  PRIMARY KEY(configuration_group_id)
);
DROP SEQUENCE configuration_group_SEQ;
CREATE SEQUENCE configuration_group_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE counter;
CREATE TABLE counter (
  startdate char(8),
  counter INTEGER
);

DROP TABLE counter_history;
CREATE TABLE counter_history (
  month char(8),
  counter INTEGER
);

DROP TABLE countries;
CREATE TABLE countries (
  countries_id INTEGER NOT NULL,
  countries_name VARCHAR(64) NOT NULL,
  countries_iso_code_2 char(2) NOT NULL,
  countries_iso_code_3 char(3) NOT NULL,
  address_format_id INTEGER NOT NULL,
  PRIMARY KEY(countries_id)
);
DROP SEQUENCE countries_SEQ;
CREATE SEQUENCE countries_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE currencies;
CREATE TABLE currencies (
  currencies_id INTEGER NOT NULL,
  title VARCHAR(32) NOT NULL,
  code char(3) NOT NULL,
  symbol_left VARCHAR(12),
  symbol_right VARCHAR(12),
  decimal_point VARCHAR(1),
  thousands_point VARCHAR(1),
  decimal_places VARCHAR(1),
  value FLOAT,
  last_updated TIMESTAMP ,
  PRIMARY KEY(currencies_id)
);
DROP SEQUENCE currencies_SEQ;
CREATE SEQUENCE currencies_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE customers;
CREATE TABLE customers (
  customers_id INTEGER NOT NULL,
  customers_gender char(1) NOT NULL,
  customers_firstname VARCHAR(32) NOT NULL,
  customers_lastname VARCHAR(32) NOT NULL,
  customers_dob TIMESTAMP NOT NULL,
  customers_email_address VARCHAR(96) NOT NULL,
  customers_default_address_id INTEGER NOT NULL,
  customers_telephone VARCHAR(32) NOT NULL,
  customers_fax VARCHAR(32),
  customers_password VARCHAR(96) NOT NULL,
  customers_newsletter char(1),
  PRIMARY KEY(customers_id)
);
DROP SEQUENCE customers_SEQ;
CREATE SEQUENCE customers_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE customers_basket;
CREATE TABLE customers_basket (
  customers_basket_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  products_id VARCHAR(255) NOT NULL,
  customers_basket_quantity INTEGER NOT NULL,
  final_price decimal(15,4) NOT NULL,
  customers_basket_date_added char(8),
  PRIMARY KEY(customers_basket_id)
);
DROP SEQUENCE customers_basket_SEQ;
CREATE SEQUENCE customers_basket_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE customers_basket_attrs;
CREATE TABLE customers_basket_attrs (
  customers_basket_attributes_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  products_id VARCHAR(255) NOT NULL,
  products_options_id INTEGER NOT NULL,
  products_options_value_id INTEGER NOT NULL,
  PRIMARY KEY(customers_basket_attributes_id)
);
DROP SEQUENCE customers_basket_attrs_SEQ;
CREATE SEQUENCE customers_basket_attrs_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE customers_info;
CREATE TABLE customers_info (
  customers_info_id INTEGER NOT NULL,
  customers_info_date_last_logon TIMESTAMP,
  customers_info_number_of_logon INTEGER,
  customers_info_date_created TIMESTAMP,
  customers_info_date_modified TIMESTAMP,
  global_product_notifications INTEGER DEFAULT 0,
  PRIMARY KEY(customers_info_id)
);

DROP TABLE languages;
CREATE TABLE languages (
  languages_id INTEGER NOT NULL,
  name VARCHAR(32)  NOT NULL,
  code char(2) NOT NULL,
  image VARCHAR(64),
  directory VARCHAR(32),
  sort_order INTEGER,
  PRIMARY KEY(languages_id)
);
DROP SEQUENCE languages_SEQ;
CREATE SEQUENCE languages_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


DROP TABLE manufacturers;
CREATE TABLE manufacturers (
  manufacturers_id INTEGER NOT NULL,
  manufacturers_name VARCHAR(32) NOT NULL,
  manufacturers_image VARCHAR(64),
  date_added TIMESTAMP ,
  last_modified TIMESTAMP ,
  PRIMARY KEY(manufacturers_id)
);
DROP SEQUENCE manufacturers_SEQ;
CREATE SEQUENCE manufacturers_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE manufacturers_info;
CREATE TABLE manufacturers_info (
  manufacturers_id INTEGER NOT NULL,
  languages_id INTEGER NOT NULL,
  manufacturers_url VARCHAR(255) NOT NULL,
  url_clicked INTEGER DEFAULT 0 NOT NULL,
  date_last_click TIMESTAMP ,
  PRIMARY KEY(manufacturers_id, languages_id)
);

DROP TABLE newsletters;
CREATE TABLE newsletters (
  newsletters_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  content VARCHAR(4000) NOT NULL,
  module VARCHAR(255) NOT NULL,
  date_added TIMESTAMP NOT NULL,
  date_sent TIMESTAMP,
  status INTEGER,
  locked INTEGER DEFAULT 0,
  PRIMARY KEY(newsletters_id)
);
DROP SEQUENCE newsletters_SEQ;
CREATE SEQUENCE newsletters_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE orders;
CREATE TABLE orders (
  orders_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  customers_name VARCHAR(64) NOT NULL,
  customers_company VARCHAR(32),
  customers_street_address VARCHAR(64) NOT NULL,
  customers_suburb VARCHAR(32),
  customers_city VARCHAR(32) NOT NULL,
  customers_postcode VARCHAR(10) NOT NULL,
  customers_state VARCHAR(32),
  customers_country VARCHAR(32) NOT NULL,
  customers_telephone VARCHAR(32) NOT NULL,
  customers_email_address VARCHAR(96) NOT NULL,
  customers_address_format_id INTEGER NOT NULL,
  delivery_name VARCHAR(64) NOT NULL,
  delivery_company VARCHAR(32),
  delivery_street_address VARCHAR(64) NOT NULL,
  delivery_suburb VARCHAR(32),
  delivery_city VARCHAR(32) NOT NULL,
  delivery_postcode VARCHAR(10) NOT NULL,
  delivery_state VARCHAR(32),
  delivery_country VARCHAR(32) NOT NULL,
  delivery_address_format_id INTEGER NOT NULL,
  billing_name VARCHAR(64) NOT NULL,
  billing_company VARCHAR(32),
  billing_street_address VARCHAR(64) NOT NULL,
  billing_suburb VARCHAR(32),
  billing_city VARCHAR(32) NOT NULL,
  billing_postcode VARCHAR(10) NOT NULL,
  billing_state VARCHAR(32),
  billing_country VARCHAR(32) NOT NULL,
  billing_address_format_id INTEGER NOT NULL,
  payment_method VARCHAR(32) NOT NULL,
  cc_type VARCHAR(20),
  cc_owner VARCHAR(64),
  cc_number VARCHAR(32),
  cc_expires VARCHAR(4),
  last_modified TIMESTAMP,
  date_purchased TIMESTAMP,
  orders_status INTEGER NOT NULL,
  orders_date_finished TIMESTAMP,
  currency char(3),
  currency_value decimal(14,6),
  PRIMARY KEY(orders_id)
);
DROP SEQUENCE orders_SEQ;
CREATE SEQUENCE orders_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE orders_products;
CREATE TABLE orders_products (
  orders_products_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  products_model VARCHAR(12),
  products_name VARCHAR(64) NOT NULL,
  products_price decimal(15,4) NOT NULL,
  final_price decimal(15,4) NOT NULL,
  products_tax decimal(7,4) NOT NULL,
  products_quantity INTEGER NOT NULL,
  PRIMARY KEY(orders_products_id)
);
DROP SEQUENCE orders_products_SEQ;
CREATE SEQUENCE orders_products_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE orders_status;
CREATE TABLE orders_status (
  orders_status_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR(32) NOT NULL,
  PRIMARY KEY(orders_status_id, language_id)
);

DROP TABLE orders_status_history;
CREATE TABLE orders_status_history (
  orders_status_history_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  orders_status_id INTEGER NOT NULL,
  date_added TIMESTAMP NOT NULL,
  customer_notified INTEGER DEFAULT 0,
  comments VARCHAR(4000),
  PRIMARY KEY(orders_status_history_id)
);
DROP SEQUENCE orders_status_history_SEQ;
CREATE SEQUENCE orders_status_history_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE orders_products_attributes;
CREATE TABLE orders_products_attributes (
  orders_products_attributes_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  orders_products_id INTEGER NOT NULL,
  products_options VARCHAR(32) NOT NULL,
  products_options_values VARCHAR(32) NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY(orders_products_attributes_id)
);
DROP SEQUENCE orders_products_attributes_SEQ;
CREATE SEQUENCE orders_products_attributes_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE orders_products_download;
CREATE TABLE orders_products_download (
  orders_products_download_id INTEGER NOT NULL,
  orders_id INTEGER DEFAULT 0 NOT NULL,
  orders_products_id INTEGER DEFAULT 0 NOT NULL,
  orders_products_filename VARCHAR(255) NOT NULL,
  download_maxdays INTEGER DEFAULT 0 NOT NULL,
  download_count INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(orders_products_download_id)
);
DROP SEQUENCE orders_products_download_SEQ;
CREATE SEQUENCE orders_products_download_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE orders_total;
CREATE TABLE orders_total (
  orders_total_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  title VARCHAR(255) NOT NULL,
  text VARCHAR(255) NOT NULL,
  value decimal(15,4) NOT NULL,
  class VARCHAR(32) NOT NULL,
  sort_order INTEGER NOT NULL,
  PRIMARY KEY(orders_total_id)
);
DROP SEQUENCE orders_total_SEQ;
CREATE SEQUENCE orders_total_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE products;
CREATE TABLE products (
  products_id INTEGER NOT NULL,
  products_quantity INTEGER NOT NULL,
  products_model VARCHAR(12),
  products_image VARCHAR(64),
  products_price decimal(15,4) NOT NULL,
  products_date_added TIMESTAMP NOT NULL,
  products_last_modified TIMESTAMP,
  products_date_available TIMESTAMP,
  products_weight decimal(5,2) NOT NULL,
  products_status smallint NOT NULL,
  products_tax_class_id INTEGER NOT NULL,
  manufacturers_id INTEGER ,
  products_ordered INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(products_id)
);
DROP SEQUENCE products_SEQ;
CREATE SEQUENCE products_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE products_attributes;
CREATE TABLE products_attributes (
  products_attributes_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  options_id INTEGER NOT NULL,
  options_values_id INTEGER NOT NULL,
  options_values_price decimal(15,4) NOT NULL,
  price_prefix char(1) NOT NULL,
  PRIMARY KEY(products_attributes_id)
);
DROP SEQUENCE products_attributes_SEQ;
CREATE SEQUENCE products_attributes_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE products_description;
CREATE TABLE products_description (
  products_id INTEGER NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  products_name VARCHAR(64) NOT NULL,
  products_description VARCHAR(4000),
  products_url VARCHAR(255) default ,
  products_viewed INTEGER DEFAULT 0,
  PRIMARY KEY(products_id,language_id)
);

DROP TABLE products_notifications;
CREATE TABLE products_notifications (
  products_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(products_id, customers_id)
);

DROP TABLE products_options;
CREATE TABLE products_options (
  products_options_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  products_options_name VARCHAR(32) NOT NULL,
  PRIMARY KEY(products_options_id,language_id)
);

DROP TABLE products_options_values;
CREATE TABLE products_options_values (
  products_options_values_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  products_options_values_name VARCHAR(64) NOT NULL,
  PRIMARY KEY(products_options_values_id,language_id)
);

DROP TABLE prod_opt_vals_to_prod_opt;
CREATE TABLE prod_opt_vals_to_prod_opt (
  prod_opt_vals_to_prod_opt_id INTEGER NOT NULL,
  products_options_id INTEGER NOT NULL,
  products_options_values_id INTEGER NOT NULL,
  PRIMARY KEY(prod_opt_vals_to_prod_opt_id)
);
DROP SEQUENCE prod_opt_vals_to_prod_opt_SEQ;
CREATE SEQUENCE prod_opt_vals_to_prod_opt_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE products_to_categories;
CREATE TABLE products_to_categories (
  products_id INTEGER NOT NULL,
  categories_id INTEGER NOT NULL,
  PRIMARY KEY(products_id,categories_id)
);

DROP TABLE reviews;
CREATE TABLE reviews (
  reviews_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  customers_id int,
  customers_name VARCHAR(64) NOT NULL,
  reviews_rating INTEGER,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  reviews_read INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(reviews_id)
);
DROP SEQUENCE reviews_SEQ;
CREATE SEQUENCE reviews_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE reviews_description;
CREATE TABLE reviews_description (
  reviews_id INTEGER NOT NULL,
  languages_id INTEGER NOT NULL,
  reviews_text VARCHAR(4000) NOT NULL,
  PRIMARY KEY(reviews_id, languages_id)
);

--DROP TABLE sessions;
--CREATE TABLE sessions (
--  sesskey varchar(32) NOT NULL,
--  expiry int(11) unsigned NOT NULL,
--  value text NOT NULL,
--  PRIMARY KEY (sesskey)
--);

DROP TABLE specials;
CREATE TABLE specials (
  specials_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  specials_new_products_price decimal(15,4) NOT NULL,
  specials_date_added TIMESTAMP,
  specials_last_modified TIMESTAMP,
  expires_date TIMESTAMP,
  date_status_change TIMESTAMP,
  status INTEGER DEFAULT 1 NOT NULL,
  PRIMARY KEY(specials_id)
);
DROP SEQUENCE specials_SEQ;
CREATE SEQUENCE specials_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE tax_class;
CREATE TABLE tax_class (
  tax_class_id INTEGER NOT NULL,
  tax_class_title VARCHAR(32) NOT NULL,
  tax_class_description VARCHAR(255) NOT NULL,
  last_modified TIMESTAMP ,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(tax_class_id)
);
DROP SEQUENCE tax_class_SEQ;
CREATE SEQUENCE tax_class_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE tax_rates;
CREATE TABLE tax_rates (
  tax_rates_id INTEGER NOT NULL,
  tax_zone_id INTEGER NOT NULL,
  tax_class_id INTEGER NOT NULL,
  tax_priority INTEGER DEFAULT 1,
  tax_rate decimal(7,4) NOT NULL,
  tax_description VARCHAR(255) NOT NULL,
  last_modified TIMESTAMP ,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(tax_rates_id)
);
DROP SEQUENCE tax_rates_SEQ;
CREATE SEQUENCE tax_rates_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE geo_zones;
CREATE TABLE geo_zones (
  geo_zone_id INTEGER NOT NULL,
  geo_zone_name VARCHAR(32) NOT NULL,
  geo_zone_description VARCHAR(255) NOT NULL,
  last_modified TIMESTAMP ,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(geo_zone_id)
);
DROP SEQUENCE geo_zones_SEQ;
CREATE SEQUENCE geo_zones_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE whos_online;
CREATE TABLE whos_online (
  customer_id int,
  full_name VARCHAR(64) NOT NULL,
  session_id VARCHAR(128) NOT NULL,
  ip_address VARCHAR(15) NOT NULL,
  time_entry VARCHAR(14) NOT NULL,
  time_last_click VARCHAR(14) NOT NULL,
  last_page_url VARCHAR(64) NOT NULL
);

DROP TABLE zones;
CREATE TABLE zones (
  zone_id INTEGER NOT NULL,
  zone_country_id INTEGER NOT NULL,
  zone_code VARCHAR(32) NOT NULL,
  zone_name VARCHAR(32) NOT NULL,
  PRIMARY KEY(zone_id)
);
DROP SEQUENCE zones_SEQ;
CREATE SEQUENCE zones_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE zones_to_geo_zones;
CREATE TABLE zones_to_geo_zones (
  association_id INTEGER NOT NULL,
  zone_country_id INTEGER NOT NULL,
  zone_id INTEGER ,
  geo_zone_id INTEGER ,
  last_modified TIMESTAMP ,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(association_id)
);
DROP SEQUENCE zones_to_geo_zones_SEQ;
CREATE SEQUENCE zones_to_geo_zones_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-- data

set echo on
INSERT INTO address_book VALUES (nextval for address_book_seq, 1, 'm', 'ACME Inc.', 'John', 'Doe', '1 Way Street', '', '12345', 'NeverNever', '', 223, 12);

-- 1 - Default, 2 - USA, 3 - Spain, 4 - Singapore, 5 - Germany
INSERT INTO address_format VALUES (nextval for address_format_seq, '$firstname $lastname$cr$streets$cr$city, $postcode$cr$statecomma$country','$city / $country');
INSERT INTO address_format VALUES (nextval for address_format_seq, '$firstname $lastname$cr$streets$cr$city, $state    $postcode$cr$country','$city, $state / $country');
INSERT INTO address_format VALUES (nextval for address_format_seq, '$firstname $lastname$cr$streets$cr$city$cr$postcode - $statecomma$country','$state / $country');
INSERT INTO address_format VALUES (nextval for address_format_seq, '$firstname $lastname$cr$streets$cr$city ($postcode)$cr$country', '$postcode / $country');
INSERT INTO address_format VALUES (nextval for address_format_seq, '$firstname $lastname$cr$streets$cr$postcode $city$cr$country','$city / $country');

INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 0, 1, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 0, 2, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 0, 3, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 3, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 3, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 3, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 3, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 3, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 3, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 1, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 2, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 2, 0, current timestamp, null);
INSERT INTO categories VALUES (nextval for categories_seq, 'no-image.png', 2, 0, current timestamp, null);

INSERT INTO categories_description VALUES ( 1, 1, 'Hardware');
INSERT INTO categories_description VALUES ( 2, 1, 'Software');
INSERT INTO categories_description VALUES ( 3, 1, 'DVD Movies');
INSERT INTO categories_description VALUES ( 4, 1, 'Graphics Cards');
INSERT INTO categories_description VALUES ( 5, 1, 'Printers');
INSERT INTO categories_description VALUES ( 6, 1, 'Monitors');
INSERT INTO categories_description VALUES ( 7, 1, 'Speakers');
INSERT INTO categories_description VALUES ( 8, 1, 'Keyboards');
INSERT INTO categories_description VALUES ( 9, 1, 'Mice');
INSERT INTO categories_description VALUES ( 10, 1, 'Action');
INSERT INTO categories_description VALUES ( 11, 1, 'Science Fiction');
INSERT INTO categories_description VALUES ( 12, 1, 'Comedy');
INSERT INTO categories_description VALUES ( 13, 1, 'Cartoons');
INSERT INTO categories_description VALUES ( 14, 1, 'Thriller');
INSERT INTO categories_description VALUES ( 15, 1, 'Drama');
INSERT INTO categories_description VALUES ( 16, 1, 'Memory');
INSERT INTO categories_description VALUES ( 17, 1, 'CDROM Drives');
INSERT INTO categories_description VALUES ( 18, 1, 'Simulation');
INSERT INTO categories_description VALUES ( 19, 1, 'Action');
INSERT INTO categories_description VALUES ( 20, 1, 'Strategy');
INSERT INTO categories_description VALUES ( 1, 2, 'Hardware');
INSERT INTO categories_description VALUES ( 2, 2, 'Software');
INSERT INTO categories_description VALUES ( 3, 2, 'DVD Filme');
INSERT INTO categories_description VALUES ( 4, 2, 'Grafikkarten');
INSERT INTO categories_description VALUES ( 5, 2, 'Drucker');
INSERT INTO categories_description VALUES ( 6, 2, 'Bildschirme');
INSERT INTO categories_description VALUES ( 7, 2, 'Lautsprecher');
INSERT INTO categories_description VALUES ( 8, 2, 'Tastaturen');
INSERT INTO categories_description VALUES ( 9, 2, 'M??use');
INSERT INTO categories_description VALUES ( 10, 2, 'Action');
INSERT INTO categories_description VALUES ( 11, 2, 'Science Fiction');
INSERT INTO categories_description VALUES ( 12, 2, 'Kom??die');
INSERT INTO categories_description VALUES ( 13, 2, 'Zeichentrick');
INSERT INTO categories_description VALUES ( 14, 2, 'Thriller');
INSERT INTO categories_description VALUES ( 15, 2, 'Drama');
INSERT INTO categories_description VALUES ( 16, 2, 'Speicher');
INSERT INTO categories_description VALUES ( 17, 2, 'CDROM Laufwerke');
INSERT INTO categories_description VALUES ( 18, 2, 'Simulation');
INSERT INTO categories_description VALUES ( 19, 2, 'Action');
INSERT INTO categories_description VALUES ( 20, 2, 'Strategie');
INSERT INTO categories_description VALUES ( 1, 3, 'Hardware');
INSERT INTO categories_description VALUES ( 2, 3, 'Software');
INSERT INTO categories_description VALUES ( 3, 3, 'Peliculas DVD');
INSERT INTO categories_description VALUES ( 4, 3, 'Tarjetas Graficas');
INSERT INTO categories_description VALUES ( 5, 3, 'Impresoras');
INSERT INTO categories_description VALUES ( 6, 3, 'Monitores');
INSERT INTO categories_description VALUES ( 7, 3, 'Altavoces');
INSERT INTO categories_description VALUES ( 8, 3, 'Teclados');
INSERT INTO categories_description VALUES ( 9, 3, 'Ratones');
INSERT INTO categories_description VALUES ( 10, 3, 'Accion');
INSERT INTO categories_description VALUES ( 11, 3, 'Ciencia Ficcion');
INSERT INTO categories_description VALUES ( 12, 3, 'Comedia');
INSERT INTO categories_description VALUES ( 13, 3, 'Dibujos Animados');
INSERT INTO categories_description VALUES ( 14, 3, 'Suspense');
INSERT INTO categories_description VALUES ( 15, 3, 'Drama');
INSERT INTO categories_description VALUES ( 16, 3, 'Memoria');
INSERT INTO categories_description VALUES ( 17, 3, 'Unidades CDROM');
INSERT INTO categories_description VALUES ( 18, 3, 'Simulacion');
INSERT INTO categories_description VALUES ( 19, 3, 'Accion');
INSERT INTO categories_description VALUES ( 20, 3, 'Estrategia');

--
-- Configuration groups
--

-- 1
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store Name', 'STORE_NAME', 'KonaKart', 'The name of my store', 1, 1, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store Owner', 'STORE_OWNER', 'Kenny Kart', 'The name of my store owner', 1, 2, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'E-Mail Address', 'STORE_OWNER_EMAIL_ADDRESS', 'root@localhost', 'The e-mail address of my store owner', 1, 3, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'E-Mail From', 'EMAIL_FROM', 'KonaKart <root@localhost>', 'The e-mail address used in (sent) e-mails', 1, 4, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (nextval for configuration_seq, 'Country', 'STORE_COUNTRY', '223', 'The country my store is located in', 1, 6, 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (nextval for configuration_seq, 'Zone', 'STORE_ZONE', '18', 'The zone my store is located in', 1, 7, 'tep_cfg_get_zone_name', 'tep_cfg_pull_down_zone_list(', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Order', 'EXPECTED_PRODUCTS_SORT', 'desc', 'This is the sort order used in the expected products box.', '1', '8', 'tep_cfg_select_option(array(\'asc\', \'desc\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expected Sort Field', 'EXPECTED_PRODUCTS_FIELD', 'date_expected', 'The column to sort by in the expected products box.', '1', '9', 'tep_cfg_select_option(array(\'products_name\', \'date_expected\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Switch To Default Language Currency', 'USE_DEFAULT_LANGUAGE_CURRENCY', 'false', 'Automatically switch to the language\'s currency when it is changed', '1', '10', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Search-Engine Safe URLs (still in development)', 'SEARCH_ENGINE_FRIENDLY_URLS', 'false', 'Use search-engine safe urls for all site links', '1', '12', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display Cart After Adding Product', 'DISPLAY_CART', 'true', 'Display the shopping cart after adding a product (or return back to their origin)', '1', '14', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Allow Guest To Tell A Friend', 'ALLOW_GUEST_TO_TELL_A_FRIEND', 'false', 'Allow guests to tell a friend about a product', '1', '15', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Default Search Operator', 'ADVANCED_SEARCH_DEFAULT_OPERATOR', 'and', 'Default search operators', '1', '17', 'tep_cfg_select_option(array(\'and\', \'or\'), ', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Address and Phone', 'STORE_NAME_ADDRESS', 'Store Name\nAddress\nCountry\nPhone', 'This is the Store Name, Address and Phone used on printable documents and displayed online', '1', '18', 'tep_cfg_textarea(', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Show Category Counts', 'SHOW_COUNTS', 'true', 'Count recursively how many products are in each category', 1, 19, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Tax Decimal Places', 'TAX_DECIMAL_PLACES', '0', 'Pad the tax value this amount of decimal places', '1', '20', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Prices with Tax', 'DISPLAY_PRICE_WITH_TAX', 'false', 'Display prices with tax included (true) or add the tax at the end (false)', 1, 21, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- 2
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'First Name', 'ENTRY_FIRST_NAME_MIN_LENGTH', '2', 'Minimum length of first name', 2, 1,'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Last Name', 'ENTRY_LAST_NAME_MIN_LENGTH', '2', 'Minimum length of last name', 2, 2, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Date of Birth', 'ENTRY_DOB_MIN_LENGTH', '10', 'Minimum length of date of birth', 2, 3, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'E-Mail Address', 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH', '6', 'Minimum length of e-mail address', 2, 4, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Street Address', 'ENTRY_STREET_ADDRESS_MIN_LENGTH', '5', 'Minimum length of street address', 2, 5, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Company', 'ENTRY_COMPANY_MIN_LENGTH', '2', 'Minimum length of company name', 2, 6, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Post Code', 'ENTRY_POSTCODE_MIN_LENGTH', '4', 'Minimum length of post code', 2, 7, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'City', 'ENTRY_CITY_MIN_LENGTH', '3', 'Minimum length of city', 2, 8, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'State', 'ENTRY_STATE_MIN_LENGTH', '2', 'Minimum length of state', 2, 9, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Telephone Number', 'ENTRY_TELEPHONE_MIN_LENGTH', '3', 'Minimum length of telephone number', 2, 10, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Password', 'ENTRY_PASSWORD_MIN_LENGTH', '5', 'Minimum length of password', 2, 11, 'integer(0,null)', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Owner Name', 'CC_OWNER_MIN_LENGTH', '3', 'Minimum length of credit card owner name', '2', '12', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Credit Card Number', 'CC_NUMBER_MIN_LENGTH', '10', 'Minimum length of credit card number', '2', '13', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Review Text', 'REVIEW_TEXT_MIN_LENGTH', '50', 'Minimum length of review text', '2', '14', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Best Sellers', 'MIN_DISPLAY_BESTSELLERS', '1', 'Minimum number of best sellers to display', '2', '15', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Also Purchased', 'MIN_DISPLAY_ALSO_PURCHASED', '1', 'Minimum number of products to display in the \'This Customer Also Purchased\' box', '2', '16', now());

-- 3
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Address Book Entries', 'MAX_ADDRESS_BOOK_ENTRIES', '5', 'Maximum address book entries a customer is allowed to have', 3, 1, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Search Results', 'MAX_DISPLAY_SEARCH_RESULTS', '20', 'Number of products to list', 3, 2, 'integer(0,null)', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Number of \'number\' links use for page-sets', '3', '3', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Special Products', 'MAX_DISPLAY_SPECIAL_PRODUCTS', '9', 'Maximum number of products on special to display', '3', '4', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'New Products Module', 'MAX_DISPLAY_NEW_PRODUCTS', '9', 'Maximum number of new products to display in a category', 3, 5, 'integer(0,null)', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Products Expected', 'MAX_DISPLAY_UPCOMING_PRODUCTS', '10', 'Maximum number of products expected to display', '3', '6', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Manufacturers List', 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST', '0', 'Used in manufacturers box; when the number of manufacturers exceeds this number, a drop-down list will be displayed instead of the default list', 3, 7, 'integer(0,null)', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Manufacturers Select Size', 'MAX_MANUFACTURERS_LIST', '1', 'Used in manufacturers box; when this value is \'1\' the classic drop-down list will be used for the manufacturers box. Otherwise, a list-box with the specified number of rows will be displayed.', '3', '7', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Length of Manufacturers Name', 'MAX_DISPLAY_MANUFACTURER_NAME_LEN', '15', 'Used in manufacturers box; maximum length of manufacturers name to display', 3, 8, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'New Reviews', 'MAX_DISPLAY_NEW_REVIEWS', '5', 'Maximum number of new reviews to display', 3, 9, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Selection of Random Reviews', 'MAX_RANDOM_SELECT_REVIEWS', '10', 'How many records to select from to choose one random product review', 3, 10, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Selection of Random New Products', 'MAX_RANDOM_SELECT_NEW', '10', 'How many records to select from to choose one random new product to display', 3, 11, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Selection of Products on Special', 'MAX_RANDOM_SELECT_SPECIALS', '10', 'How many records to select from to choose one random product special to display', 3, 12, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Categories To List Per Row', 'MAX_DISPLAY_CATEGORIES_PER_ROW', '3', 'How many categories to list per row', 3, 13, 'integer(0,null)', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('New Products Listing', 'MAX_DISPLAY_PRODUCTS_NEW', '10', 'Maximum number of new products to display in new products page', '3', '14', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Best Sellers', 'MAX_DISPLAY_BESTSELLERS', '10', 'Maximum number of best sellers to display', 3, 15, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Also Purchased', 'MAX_DISPLAY_ALSO_PURCHASED', '6', 'Maximum number of products to display in the ''This Customer Also Purchased'' box', 3, 16, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Customer Order History Box', 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX', '6', 'Maximum number of products to display in the customer order history box', 3, 17, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Order History', 'MAX_DISPLAY_ORDER_HISTORY', '10', 'Maximum number of orders to display in the order history page', 3, 18, 'integer(0,null)', current timestamp);

-- 4
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Small Image Width', 'SMALL_IMAGE_WIDTH', '100', 'The pixel width of small images', 4, 1, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Small Image Height', 'SMALL_IMAGE_HEIGHT', '80', 'The pixel height of small images', 4, 2, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Heading Image Width', 'HEADING_IMAGE_WIDTH', '57', 'The pixel width of heading images', 4, 3, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Heading Image Height', 'HEADING_IMAGE_HEIGHT', '40', 'The pixel height of heading images', 4, 4, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Subcategory Image Width', 'SUBCATEGORY_IMAGE_WIDTH', '100', 'The pixel width of subcategory images', 4, 5, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Subcategory Image Height', 'SUBCATEGORY_IMAGE_HEIGHT', '57', 'The pixel height of subcategory images', 4, 6, 'integer(0,null)', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Calculate Image Size', 'CONFIG_CALCULATE_IMAGE_SIZE', 'true', 'Calculate the size of images?', '4', '7', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Image Required', 'IMAGE_REQUIRED', 'true', 'Enable to display broken images. Good for development.', '4', '8', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());

-- 5
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Gender', 'ACCOUNT_GENDER', 'true', 'Display gender in the customers account', 5, 1, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Date of Birth', 'ACCOUNT_DOB', 'true', 'Display date of birth in the customers account', 5, 2, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Company', 'ACCOUNT_COMPANY', 'true', 'Display company in the customers account', 5, 3, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Suburb', 'ACCOUNT_SUBURB', 'true', 'Display suburb in the customers account', 5, 4, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'State', 'ACCOUNT_STATE', 'true', 'Display state in the customers account', 5, 5, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- 6 - Modules installed
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Installed Modules', 'MODULE_PAYMENT_INSTALLED', 'cod.php', 'List of payment module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: cc.php;cod.php;paypal.php)', 6, 0, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Installed Modules', 'MODULE_ORDER_TOTAL_INSTALLED', 'ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php', 'List of order_total module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ot_subtotal.php;ot_tax.php;ot_shipping.php;ot_total.php)', 6, 0, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Installed Modules', 'MODULE_SHIPPING_INSTALLED', 'flat.php', 'List of shipping module filenames separated by a semi-colon. This is automatically updated. No need to edit. (Example: ups.php;flat.php;item.php)', 6, 0, current timestamp);

-- 6 - COD module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Cash On Delivery Module', 'MODULE_PAYMENT_COD_STATUS', 'True', 'Do you want to accept Cash On Delevery payments?', 6, 1, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (nextval for configuration_seq, 'Payment Zone', 'MODULE_PAYMENT_COD_ZONE', '0', 'If a zone is selected, only enable this payment method for that zone.', 6, 2, 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort order of display.', 'MODULE_PAYMENT_COD_SORT_ORDER', '0', 'Sort order of display. Lowest is displayed first.', 6, 0, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES (nextval for configuration_seq, 'Set Order Status', 'MODULE_PAYMENT_COD_ORDER_STATUS_ID', '0', 'Set the status of orders made with this payment module to this value', 6, 0, 'OrderStatuses', 'tep_get_order_status_name', current timestamp);

--6 - Shipping Flat
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Flat Shipping', 'MODULE_SHIPPING_FLAT_STATUS', 'True', 'Do you want to offer flat rate shipping?', 6, 0, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Shipping Cost', 'MODULE_SHIPPING_FLAT_COST', '5.00', 'The shipping cost for all orders using this shipping method.', 6, 0, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (nextval for configuration_seq, 'Tax Class', 'MODULE_SHIPPING_FLAT_TAX_CLASS', '0', 'Use the following tax class on the shipping fee.', 6, 0, 'tep_get_tax_class_title', 'tep_cfg_pull_down_tax_classes(', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (nextval for configuration_seq, 'Shipping Zone', 'MODULE_SHIPPING_FLAT_ZONE', '0', 'If a zone is selected, only enable this shipping method for that zone.', 6, 0, 'tep_get_zone_class_title', 'tep_cfg_pull_down_zone_classes(', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort Order', 'MODULE_SHIPPING_FLAT_SORT_ORDER', '0', 'Sort order of display.', 6, 0, current timestamp);

--6 - Order Totals
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_STATUS', 'true', 'Do you want to display the order shipping cost?', 6, 1,'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort Order', 'MODULE_ORDER_TOTAL_SHIPPING_SORT_ORDER', '2', 'Sort order of display.', 6, 2, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Sub-Total', 'MODULE_ORDER_TOTAL_SUBTOTAL_STATUS', 'true', 'Do you want to display the order sub-total cost?', 6, 1,'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort Order', 'MODULE_ORDER_TOTAL_SUBTOTAL_SORT_ORDER', '1', 'Sort order of display.', 6, 2, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Tax', 'MODULE_ORDER_TOTAL_TAX_STATUS', 'true', 'Do you want to display the order tax value?', 6, 1,'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort Order', 'MODULE_ORDER_TOTAL_TAX_SORT_ORDER', '39', 'Sort order of display.', 6, 2, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Total', 'MODULE_ORDER_TOTAL_TOTAL_STATUS', 'true', 'Do you want to display the total order value?', 6, 1,'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort Order', 'MODULE_ORDER_TOTAL_TOTAL_SORT_ORDER', '40', 'Sort order of display.', 6, 2, current timestamp);

-- 6 - Defaults
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Default Currency', 'DEFAULT_CURRENCY', 'USD', 'Default Currency', 6, 0, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Default Language', 'DEFAULT_LANGUAGE', 'en', 'Default Language', 6, 0, current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Default Order Status For New Orders', 'DEFAULT_ORDERS_STATUS_ID', '1', 'When a new order is created, this order status will be assigned to it.', '6', '0', now());


-- 7
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, set_function, date_added) VALUES (nextval for configuration_seq, 'Country of Origin', 'SHIPPING_ORIGIN_COUNTRY', '223', 'Select the country of origin to be used in shipping quotes.', 7, 1, 'tep_get_country_name', 'tep_cfg_pull_down_country_list(', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Postal Code', 'SHIPPING_ORIGIN_ZIP', 'NONE', 'Enter the Postal Code (ZIP) of the Store to be used in shipping quotes.', 7, 2, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enter the Maximum Package Weight you will ship', 'SHIPPING_MAX_WEIGHT', '50', 'Carriers have a max weight limit for a single package. This is a common one for all.', 7, 3, 'double(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Package Tare weight.', 'SHIPPING_BOX_WEIGHT', '3', 'What is the weight of typical packaging of small to medium packages?', 7, 4, 'double(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Larger packages - percentage increase.', 'SHIPPING_BOX_PADDING', '10', 'For 10% enter 10', 7, 5, 'double(0,null)', current timestamp);

-- 8
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Image', 'PRODUCT_LIST_IMAGE', '1', 'Do you want to display the Product Image?', '8', '1', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Manufaturer Name','PRODUCT_LIST_MANUFACTURER', '0', 'Do you want to display the Product Manufacturer Name?', '8', '2', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Model', 'PRODUCT_LIST_MODEL', '0', 'Do you want to display the Product Model?', '8', '3', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Name', 'PRODUCT_LIST_NAME', '2', 'Do you want to display the Product Name?', '8', '4', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Price', 'PRODUCT_LIST_PRICE', '3', 'Do you want to display the Product Price', '8', '5', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Quantity', 'PRODUCT_LIST_QUANTITY', '0', 'Do you want to display the Product Quantity?', '8', '6', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Product Weight', 'PRODUCT_LIST_WEIGHT', '0', 'Do you want to display the Product Weight?', '8', '7', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Buy Now column', 'PRODUCT_LIST_BUY_NOW', '4', 'Do you want to display the Buy Now column?', '8', '8', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Display Category/Manufacturer Filter (0=disable; 1=enable)', 'PRODUCT_LIST_FILTER', '1', 'Do you want to display the Category/Manufacturer Filter?', '8', '9', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Location of Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', 'PREV_NEXT_BAR_LOCATION', '2', 'Sets the location of the Prev/Next Navigation Bar (1-top, 2-bottom, 3-both)', '8', '10', now());

-- 9
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Check stock level', 'STOCK_CHECK', 'true', 'Check to see if sufficent stock is available', 9, 1, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Subtract stock', 'STOCK_LIMITED', 'true', 'Subtract product in stock by product orders', 9, 2, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow Checkout', 'STOCK_ALLOW_CHECKOUT', 'true', 'Allow customer to checkout even if there is insufficient stock', 9, 3, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Mark product out of stock', 'STOCK_MARK_PRODUCT_OUT_OF_STOCK', '***', 'Display something on screen so customer can see which product has insufficient stock', '9', '4', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Stock Re-order level', 'STOCK_REORDER_LEVEL', '5', 'Define when stock needs to be re-ordered', 9, 5, 'integer(null,null)', current timestamp);

-- 10
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Page Parse Time', 'STORE_PAGE_PARSE_TIME', 'false', 'Store the time it takes to parse a page', '10', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Destination', 'STORE_PAGE_PARSE_TIME_LOG', '/var/log/www/tep/page_parse_time.log', 'Directory and filename of the page parse time log', '10', '2', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Log Date Format', 'STORE_PARSE_DATE_TIME_FORMAT', '%d/%m/%Y %H:%M:%S', 'The date format', '10', '3', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Display The Page Parse Time', 'DISPLAY_PAGE_PARSE_TIME', 'true', 'Display the page parse time (store page parse time must be enabled)', '10', '4', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Store Database Queries', 'STORE_DB_TRANSACTIONS', 'false', 'Store the database queries in the page parse time log (PHP4 only)', '10', '5', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());

-- 11
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use Cache', 'USE_CACHE', 'false', 'Use caching features', '11', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Cache Directory', 'DIR_FS_CACHE', '/tmp/', 'The directory where the cached files are saved', '11', '2', now());

-- 12
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Transport Method', 'EMAIL_TRANSPORT', 'sendmail', 'Defines if this server uses a local connection to sendmail or uses an SMTP connection via TCP/IP. Servers running on Windows and MacOS should change this setting to SMTP.', '12', '1', 'tep_cfg_select_option(array(\'sendmail\', \'smtp\'),', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('E-Mail Linefeeds', 'EMAIL_LINEFEED', 'LF', 'Defines the character sequence used to separate mail headers.', '12', '2', 'tep_cfg_select_option(array(\'LF\', \'CRLF\'),', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Use MIME HTML When Sending Emails', 'EMAIL_USE_HTML', 'false', 'Send e-mails in HTML format', '12', '3', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Verify E-Mail Addresses Through DNS', 'ENTRY_EMAIL_ADDRESS_CHECK', 'false', 'Verify e-mail address through a DNS server', '12', '4', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send E-Mails', 'SEND_EMAILS', 'true', 'Send out e-mails', 12, 1, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- 13
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable download', 'DOWNLOAD_ENABLED', 'false', 'Enable the products download functions.', '13', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Download by redirect', 'DOWNLOAD_BY_REDIRECT', 'false', 'Use browser redirection for download. Disable on non-Unix systems.', '13', '2', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Expiry delay (days)' ,'DOWNLOAD_MAX_DAYS', '7', 'Set number of days before the download link expires. 0 means no limit.', '13', '3', '', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Maximum number of downloads' ,'DOWNLOAD_MAX_COUNT', '5', 'Set the maximum number of downloads. 0 means no download authorized.', '13', '4', '', now());

-- 14
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Enable GZip Compression', 'GZIP_COMPRESSION', 'false', 'Enable HTTP GZip compression.', '14', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Compression Level', 'GZIP_LEVEL', '5', 'Use this compression level 0-9 (0 = minimum, 9 = maximum).', '14', '2', now());

-- 15
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Session Directory', 'SESSION_WRITE_DIRECTORY', '/tmp', 'If sessions are file based, store them in this directory.', '15', '1', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Force Cookie Use', 'SESSION_FORCE_COOKIE_USE', 'False', 'Force the use of sessions when cookies are only enabled.', '15', '2', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check SSL Session ID', 'SESSION_CHECK_SSL_SESSION_ID', 'False', 'Validate the SSL_SESSION_ID on every secure HTTPS page request.', '15', '3', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check User Agent', 'SESSION_CHECK_USER_AGENT', 'False', 'Validate the clients browser user agent on every page request.', '15', '4', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Check IP Address', 'SESSION_CHECK_IP_ADDRESS', 'False', 'Validate the clients IP address on every page request.', '15', '5', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Prevent Spider Sessions', 'SESSION_BLOCK_SPIDERS', 'False', 'Prevent known spiders from starting a session.', '15', '6', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Recreate Session', 'SESSION_RECREATE', 'False', 'Recreate the session to generate a new session ID when the customer logs on or creates an account (PHP >=4.1 needed).', '15', '7', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());

INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'My Store', 'General information about my store', 1, 1);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Minimum Values', 'The minimum values for functions / data', 2, 1);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Maximum Values', 'The maximum values for functions / data', 3, 1);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Images', 'Image parameters', 4, 1);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Customer Details', 'Customer account configuration', 5, 1);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Module Options', 'Hidden from configuration', 6, 0);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Shipping/Packaging', 'Shipping options available at my store', 7, 1);
--INSERT INTO configuration_group VALUES ('8', 'Product Listing', 'Product Listing    configuration options', '8', '1');
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Stock', 'Stock configuration options', 9, 1);
--INSERT INTO configuration_group VALUES ('10', 'Logging', 'Logging configuration options', '10', '1');
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Cache', 'Caching configuration options', 11, 1);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'E-Mail Options', 'General setting for E-Mail transport and HTML E-Mails', 12, 1);
--INSERT INTO configuration_group VALUES ('13', 'Download', 'Downloadable products options', '13', '1');
--INSERT INTO configuration_group VALUES ('14', 'GZip Compression', 'GZip compression options', '14', '1');
--INSERT INTO configuration_group VALUES ('15', 'Sessions', 'Session options', '15', '1');

INSERT INTO countries VALUES (nextval for countries_seq,'Afghanistan','AF','AFG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Albania','AL','ALB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Algeria','DZ','DZA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'American Samoa','AS','ASM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Andorra','AD','AND',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Angola','AO','AGO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Anguilla','AI','AIA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Antarctica','AQ','ATA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Antigua and Barbuda','AG','ATG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Argentina','AR','ARG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Armenia','AM','ARM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Aruba','AW','ABW',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Australia','AU','AUS',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Austria','AT','AUT',5);
INSERT INTO countries VALUES (nextval for countries_seq,'Azerbaijan','AZ','AZE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bahamas','BS','BHS',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bahrain','BH','BHR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bangladesh','BD','BGD',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Barbados','BB','BRB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Belarus','BY','BLR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Belgium','BE','BEL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Belize','BZ','BLZ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Benin','BJ','BEN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bermuda','BM','BMU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bhutan','BT','BTN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bolivia','BO','BOL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bosnia and Herzegowina','BA','BIH',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Botswana','BW','BWA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bouvet Island','BV','BVT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Brazil','BR','BRA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'British Indian Ocean Territory','IO','IOT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Brunei Darussalam','BN','BRN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Bulgaria','BG','BGR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Burkina Faso','BF','BFA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Burundi','BI','BDI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cambodia','KH','KHM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cameroon','CM','CMR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Canada','CA','CAN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cape Verde','CV','CPV',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cayman Islands','KY','CYM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Central African Republic','CF','CAF',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Chad','TD','TCD',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Chile','CL','CHL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'China','CN','CHN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Christmas Island','CX','CXR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cocos (Keeling) Islands','CC','CCK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Colombia','CO','COL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Comoros','KM','COM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Congo','CG','COG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cook Islands','CK','COK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Costa Rica','CR','CRI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cote D''Ivoire','CI','CIV',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Croatia','HR','HRV',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cuba','CU','CUB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Cyprus','CY','CYP',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Czech Republic','CZ','CZE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Denmark','DK','DNK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Djibouti','DJ','DJI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Dominica','DM','DMA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Dominican Republic','DO','DOM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'East Timor','TP','TMP',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Ecuador','EC','ECU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Egypt','EG','EGY',1);
INSERT INTO countries VALUES (nextval for countries_seq,'El Salvador','SV','SLV',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Equatorial Guinea','GQ','GNQ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Eritrea','ER','ERI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Estonia','EE','EST',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Ethiopia','ET','ETH',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Falkland Islands (Malvinas)','FK','FLK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Faroe Islands','FO','FRO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Fiji','FJ','FJI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Finland','FI','FIN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'France','FR','FRA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'France, Metropolitan','FX','FXX',1);
INSERT INTO countries VALUES (nextval for countries_seq,'French Guiana','GF','GUF',1);
INSERT INTO countries VALUES (nextval for countries_seq,'French Polynesia','PF','PYF',1);
INSERT INTO countries VALUES (nextval for countries_seq,'French Southern Territories','TF','ATF',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Gabon','GA','GAB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Gambia','GM','GMB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Georgia','GE','GEO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Germany','DE','DEU',5);
INSERT INTO countries VALUES (nextval for countries_seq,'Ghana','GH','GHA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Gibraltar','GI','GIB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Greece','GR','GRC',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Greenland','GL','GRL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Grenada','GD','GRD',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Guadeloupe','GP','GLP',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Guam','GU','GUM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Guatemala','GT','GTM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Guinea','GN','GIN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Guinea-bissau','GW','GNB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Guyana','GY','GUY',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Haiti','HT','HTI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Heard and Mc Donald Islands','HM','HMD',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Honduras','HN','HND',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Hong Kong','HK','HKG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Hungary','HU','HUN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Iceland','IS','ISL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'India','IN','IND',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Indonesia','ID','IDN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Iran (Islamic Republic of)','IR','IRN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Iraq','IQ','IRQ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Ireland','IE','IRL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Israel','IL','ISR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Italy','IT','ITA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Jamaica','JM','JAM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Japan','JP','JPN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Jordan','JO','JOR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Kazakhstan','KZ','KAZ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Kenya','KE','KEN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Kiribati','KI','KIR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Korea, Democratic People''s Republic of','KP','PRK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Korea, Republic of','KR','KOR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Kuwait','KW','KWT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Kyrgyzstan','KG','KGZ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Lao People''s Democratic Republic','LA','LAO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Latvia','LV','LVA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Lebanon','LB','LBN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Lesotho','LS','LSO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Liberia','LR','LBR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Libyan Arab Jamahiriya','LY','LBY',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Liechtenstein','LI','LIE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Lithuania','LT','LTU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Luxembourg','LU','LUX',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Macau','MO','MAC',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Macedonia, The Former Yugoslav Republic of','MK','MKD',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Madagascar','MG','MDG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Malawi','MW','MWI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Malaysia','MY','MYS',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Maldives','MV','MDV',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mali','ML','MLI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Malta','MT','MLT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Marshall Islands','MH','MHL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Martinique','MQ','MTQ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mauritania','MR','MRT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mauritius','MU','MUS',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mayotte','YT','MYT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mexico','MX','MEX',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Micronesia, Federated States of','FM','FSM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Moldova, Republic of','MD','MDA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Monaco','MC','MCO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mongolia','MN','MNG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Montserrat','MS','MSR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Morocco','MA','MAR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Mozambique','MZ','MOZ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Myanmar','MM','MMR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Namibia','NA','NAM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Nauru','NR','NRU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Nepal','NP','NPL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Netherlands','NL','NLD',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Netherlands Antilles','AN','ANT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'New Caledonia','NC','NCL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'New Zealand','NZ','NZL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Nicaragua','NI','NIC',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Niger','NE','NER',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Nigeria','NG','NGA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Niue','NU','NIU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Norfolk Island','NF','NFK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Northern Mariana Islands','MP','MNP',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Norway','NO','NOR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Oman','OM','OMN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Pakistan','PK','PAK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Palau','PW','PLW',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Panama','PA','PAN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Papua New Guinea','PG','PNG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Paraguay','PY','PRY',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Peru','PE','PER',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Philippines','PH','PHL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Pitcairn','PN','PCN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Poland','PL','POL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Portugal','PT','PRT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Puerto Rico','PR','PRI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Qatar','QA','QAT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Reunion','RE','REU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Romania','RO','ROM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Russian Federation','RU','RUS',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Rwanda','RW','RWA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Saint Kitts and Nevis','KN','KNA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Saint Lucia','LC','LCA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Saint Vincent and the Grenadines','VC','VCT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Samoa','WS','WSM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'San Marino','SM','SMR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Sao Tome and Principe','ST','STP',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Saudi Arabia','SA','SAU',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Senegal','SN','SEN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Seychelles','SC','SYC',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Sierra Leone','SL','SLE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Singapore','SG','SGP', 4);
INSERT INTO countries VALUES (nextval for countries_seq,'Slovakia (Slovak Republic)','SK','SVK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Slovenia','SI','SVN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Solomon Islands','SB','SLB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Somalia','SO','SOM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'South Africa','ZA','ZAF',1);
INSERT INTO countries VALUES (nextval for countries_seq,'South Georgia and the South Sandwich Islands','GS','SGS',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Spain','ES','ESP',3);
INSERT INTO countries VALUES (nextval for countries_seq,'Sri Lanka','LK','LKA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'St. Helena','SH','SHN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'St. Pierre and Miquelon','PM','SPM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Sudan','SD','SDN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Suriname','SR','SUR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Svalbard and Jan Mayen Islands','SJ','SJM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Swaziland','SZ','SWZ',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Sweden','SE','SWE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Switzerland','CH','CHE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Syrian Arab Republic','SY','SYR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Taiwan','TW','TWN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Tajikistan','TJ','TJK',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Tanzania, United Republic of','TZ','TZA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Thailand','TH','THA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Togo','TG','TGO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Tokelau','TK','TKL',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Tonga','TO','TON',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Trinidad and Tobago','TT','TTO',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Tunisia','TN','TUN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Turkey','TR','TUR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Turkmenistan','TM','TKM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Turks and Caicos Islands','TC','TCA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Tuvalu','TV','TUV',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Uganda','UG','UGA',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Ukraine','UA','UKR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'United Arab Emirates','AE','ARE',1);
INSERT INTO countries VALUES (nextval for countries_seq,'United Kingdom','GB','GBR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'United States','US','USA', 2);
INSERT INTO countries VALUES (nextval for countries_seq,'United States Minor Outlying Islands','UM','UMI',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Uruguay','UY','URY',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Uzbekistan','UZ','UZB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Vanuatu','VU','VUT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Vatican City State (Holy See)','VA','VAT',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Venezuela','VE','VEN',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Viet Nam','VN','VNM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Virgin Islands (British)','VG','VGB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Virgin Islands (U.S.)','VI','VIR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Wallis and Futuna Islands','WF','WLF',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Western Sahara','EH','ESH',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Yemen','YE','YEM',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Yugoslavia','YU','YUG',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Zaire','ZR','ZAR',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Zambia','ZM','ZMB',1);
INSERT INTO countries VALUES (nextval for countries_seq,'Zimbabwe','ZW','ZWE',1);

INSERT INTO currencies VALUES (NEXTVAL FOR currencies_seq,'US Dollar','USD','$','','.',',','2',1.0000, current timestamp);
INSERT INTO currencies VALUES (NEXTVAL FOR currencies_seq,'Euro','EUR','','EUR','.',',','2',1.1000, current timestamp);

-- John Doe User "root@localhost.com" Password: "password"
INSERT INTO customers VALUES (nextval for customers_seq, 'm', 'John', 'doe', to_date('2001-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'root@localhost', 1, '12345', '', 'd95e8fa7f20a009372eb3477473fcd34:1c', '0');

INSERT INTO customers_info VALUES (1, current timestamp, 0, current timestamp, current timestamp, 0);

INSERT INTO languages VALUES (nextval for languages_seq,'English','en','icon.gif','english',1);
INSERT INTO languages VALUES (nextval for languages_seq,'Deutsch','de','icon.gif','german',2);
INSERT INTO languages VALUES (nextval for languages_seq,'Espa??ol','es','icon.gif','espanol',3);

INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Matrox','manufacturer_matrox.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Microsoft','manufacturer_microsoft.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Warner','manufacturer_warner.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Fox','manufacturer_fox.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Logitech','manufacturer_logitech.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Canon','manufacturer_canon.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Sierra','manufacturer_sierra.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'GT Interactive','manufacturer_gt_interactive.gif', current timestamp, null);
INSERT INTO manufacturers VALUES (nextval for manufacturers_seq,'Hewlett Packard','manufacturer_hewlett_packard.gif', current timestamp, null);

INSERT INTO manufacturers_info VALUES (1, 1, 'http://www.matrox.com', 0, null);
INSERT INTO manufacturers_info VALUES (1, 2, 'http://www.matrox.de', 0, null);
INSERT INTO manufacturers_info VALUES (1, 3, 'http://www.matrox.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 1, 'http://www.microsoft.com', 0, null);
INSERT INTO manufacturers_info VALUES (2, 2, 'http://www.microsoft.de', 0, null);
INSERT INTO manufacturers_info VALUES (2, 3, 'http://www.microsoft.es', 0, null);
INSERT INTO manufacturers_info VALUES (3, 1, 'http://www.warner.com', 0, null);
INSERT INTO manufacturers_info VALUES (3, 2, 'http://www.warner.de', 0, null);
INSERT INTO manufacturers_info VALUES (3, 3, 'http://www.warner.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 1, 'http://www.fox.com', 0, null);
INSERT INTO manufacturers_info VALUES (4, 2, 'http://www.fox.de', 0, null);
INSERT INTO manufacturers_info VALUES (4, 3, 'http://www.fox.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 1, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 2, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (5, 3, 'http://www.logitech.com', 0, null);
INSERT INTO manufacturers_info VALUES (6, 1, 'http://www.canon.com', 0, null);
INSERT INTO manufacturers_info VALUES (6, 2, 'http://www.canon.de', 0, null);
INSERT INTO manufacturers_info VALUES (6, 3, 'http://www.canon.es', 0, null);
INSERT INTO manufacturers_info VALUES (7, 1, 'http://www.sierra.com', 0, null);
INSERT INTO manufacturers_info VALUES (7, 2, 'http://www.sierra.de', 0, null);
INSERT INTO manufacturers_info VALUES (7, 3, 'http://www.sierra.com', 0, null);
INSERT INTO manufacturers_info VALUES (8, 1, 'http://www.infogrames.com', 0, null);
INSERT INTO manufacturers_info VALUES (8, 2, 'http://www.infogrames.de', 0, null);
INSERT INTO manufacturers_info VALUES (8, 3, 'http://www.infogrames.com', 0, null);
INSERT INTO manufacturers_info VALUES (9, 1, 'http://www.hewlettpackard.com', 0, null);
INSERT INTO manufacturers_info VALUES (9, 2, 'http://www.hewlettpackard.de', 0, null);
INSERT INTO manufacturers_info VALUES (9, 3, 'http://welcome.hp.com/country/es/spa/welcome.htm', 0, null);

INSERT INTO orders_status VALUES ( 1, 1, 'Pending');
INSERT INTO orders_status VALUES ( 1, 2, 'Offen');
INSERT INTO orders_status VALUES ( 1, 3, 'Pendiente');
INSERT INTO orders_status VALUES ( 2, 1, 'Processing');
INSERT INTO orders_status VALUES ( 2, 2, 'In Bearbeitung');
INSERT INTO orders_status VALUES ( 2, 3, 'Proceso');
INSERT INTO orders_status VALUES ( 3, 1, 'Delivered');
INSERT INTO orders_status VALUES ( 3, 2, 'Versendet');
INSERT INTO orders_status VALUES ( 3, 3, 'Entregado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,1,'Waiting for Payment');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,2,'Warte auf Zahlung');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,3,'Para pago que espera');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,1,'Payment Received');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,2,'Zahlung empfangen');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,3,'Pago recibido');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,1,'Payment Declined');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,2,'Zahlung nicht erfolgt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,3,'Pago declinado');


INSERT INTO products VALUES (nextval for products_seq,32,'MG200MMS','matrox/mg200mms.gif',299.99, current timestamp,null,current timestamp,23.00,1,1,1,0);
INSERT INTO products VALUES (nextval for products_seq,32,'MG400-32MB','matrox/mg400-32mb.gif',499.99, current timestamp,null,current timestamp,23.00,1,1,1,0);
INSERT INTO products VALUES (nextval for products_seq,2,'MSIMPRO','microsoft/msimpro.gif',49.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,13,'DVD-RPMK','dvd/replacement_killers.gif',42.00, current timestamp,null,current timestamp,23.00,1,1,2,0);
INSERT INTO products VALUES (nextval for products_seq,17,'DVD-BLDRNDC','dvd/blade_runner.gif',35.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-MATR','dvd/the_matrix.gif',39.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-YGEM','dvd/youve_got_mail.gif',34.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-ABUG','dvd/a_bugs_life.gif',35.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-UNSG','dvd/under_siege.gif',29.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-UNSG2','dvd/under_siege2.gif',29.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-FDBL','dvd/fire_down_below.gif',29.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-DHWV','dvd/die_hard_3.gif',39.99, current timestamp,null,current timestamp,7.00,1,1,4,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-LTWP','dvd/lethal_weapon.gif',34.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-REDC','dvd/red_corner.gif',32.00, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-FRAN','dvd/frantic.gif',35.00, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-CUFI','dvd/courage_under_fire.gif',38.99, current timestamp,null,current timestamp,7.00,1,1,4,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-SPEED','dvd/speed.gif',39.99, current timestamp,null,current timestamp,7.00,1,1,4,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-SPEED2','dvd/speed_2.gif',42.00, current timestamp,null,current timestamp,7.00,1,1,4,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-TSAB','dvd/theres_something_about_mary.gif',49.99, current timestamp,null,current timestamp,7.00,1,1,4,0);
INSERT INTO products VALUES (nextval for products_seq,10,'DVD-BELOVED','dvd/beloved.gif',54.99, current timestamp,null,current timestamp,7.00,1,1,3,0);
INSERT INTO products VALUES (nextval for products_seq,16,'PC-SWAT3','sierra/swat_3.gif',79.99, current timestamp,null,current timestamp,7.00,1,1,7,0);
INSERT INTO products VALUES (nextval for products_seq,13,'PC-UNTM','gt_interactive/unreal_tournament.gif',89.99, current timestamp,null,current timestamp,7.00,1,1,8,0);
INSERT INTO products VALUES (nextval for products_seq,16,'PC-TWOF','gt_interactive/wheel_of_time.gif',99.99, current timestamp,null,current timestamp,10.00,1,1,8,0);
INSERT INTO products VALUES (nextval for products_seq,17,'PC-DISC','gt_interactive/disciples.gif',90.00, current timestamp,null,current timestamp,8.00,1,1,8,0);
INSERT INTO products VALUES (nextval for products_seq,16,'MSINTKB','microsoft/intkeyboardps2.gif',69.99, current timestamp,null,current timestamp,8.00,1,1,2,0);
INSERT INTO products VALUES (nextval for products_seq,10,'MSIMEXP','microsoft/imexplorer.gif',64.95, current timestamp,null,current timestamp,8.00,1,1,2,0);
INSERT INTO products VALUES (nextval for products_seq,8,'HPLJ1100XI','hewlett_packard/lj1100xi.gif',499.99, current timestamp,null,current timestamp,45.00,1,1,9,0);

INSERT INTO products_description VALUES (1,1,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8\&quot; PCI board.<br><br>With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br><br>Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters \& Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (2,1,'Matrox G400 32MB','<b>Dramatically Different High Performance Graphics</b><br><br>Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br><br><b>Key features:</b><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description VALUES (3,1,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description VALUES (4,1,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 80 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (5,1,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 112 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description VALUES (6,1,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch.<br><br>Audio: Dolby Surround.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 131 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description VALUES (7,1,'You''ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch, Spanish.<br><br>Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br><br>Audio: Dolby Digital 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (8,1,'A Bug''s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 91 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description VALUES (9,1,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (10,1,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (11,1,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (12,1,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 122 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (13,1,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (14,1,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 117 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (15,1,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (16,1,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (17,1,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (18,1,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 120 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (19,1,'There''s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 114 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (20,1,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 164 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (21,1,'SWAT 3: Close Quarters Battle','<b>Windows 95/98</b><br><br>211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description VALUES (22,1,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (23,1,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (24,1,'Disciples: Sacred Lands','A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description VALUES (25,1,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description VALUES (26,1,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description VALUES (27,1,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);
INSERT INTO products_description VALUES (1,2,'Matrox G200 MMS','<b>Unterst??tzung f??r zwei bzw. vier analoge oder digitale Monitore</b><br><br>Die Matrox G200 Multi-Monitor-Serie f??hrt die bew??hrte Matrox Tradition im Multi-Monitor- Bereich fort und bietet flexible und fortschrittliche L??sungen.Matrox stellt als erstes Unternehmen einen vierfachen digitalen PanelLink?? DVI Flachbildschirm Ausgang zur Verf??gung. Mit den optional erh??ltlichen TV Tuner und Video-Capture M??glichkeiten stellt die Matrox G200 MMS eine alles umfassende Mehrschirm-L??sung dar.<br><br><b>Leistungsmerkmale:</b><br><ul><br><li>Preisgekr??nter Matrox G200 128-Bit Grafikchip</li><br><li>Schneller 8 MB SGRAM-Speicher pro Kanal</li><br><li>Integrierter, leistungsstarker 250 MHz RAMDAC</li><br><li>Unterst??tzung f??r bis zu 16 Bildschirme ??ber 4 Quad-Karten (unter Win NT,ab Treiber 4.40)</li><br><li>Unterst??tzung von 9 Monitoren unter Win 98</li><br><li>2 bzw. 4 analoge oder digitale Ausgabekan??le pro PCI-Karte</li><br><li>Desktop-Darstellung von 1800 x 1440 oder 1920 x 1200 pro Chip</li><br><li>Anschlu??m??glichkeit an einen 15-poligen VGA-Monitor oder an einen 30-poligen digitalen DVI-Flachbildschirm plus integriertem Composite-Video-Eingang (bei der TV-Version)</li><br><li>PCI Grafikkarte, kurze Baul??nge</li><br><li>Treiberunterst??tzung: Windows?? 2000, Windows NT?? und Windows?? 98</li><br><li>Anwendungsbereiche: B??rsenumgebung mit zeitgleich gro??em Visualisierungsbedarf, Video??berwachung, Video-Conferencing</li><br></ul>','www.matrox.com/mga/deutsch/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (2,2,'Matrox G400 32 MB','<b>Neu! Matrox G400 \&quot;all inclusive\&quot; und vieles mehr...</b><br><br>Die neue Millennium G400-Serie - Hochleistungsgrafik mit dem sensationellen Unterschied. Ausgestattet mit dem neu eingef??hrten Matrox G400 Grafikchip, bietet die Millennium G400-Serie eine ??berragende Beschleunigung inklusive bisher nie dagewesener Bildqualitat und enorm flexibler Darstellungsoptionen bei allen Ihren 3D-, 2D- und DVD-Anwendungen.<br><br><ul><br><li>DualHead Display und TV-Ausgang</li><br><li>Environment Mapped Bump Mapping</li><br><li>Matrox G400 256-Bit DualBus</li><br><li>3D Rendering Array Prozessor</li><br><li>Vibrant Color Quality?? (VCQ??)</li><br><li>UltraSharp DAC</li><br></ul><br><i>\&quot;Bleibt abschlie??end festzustellen, da?? die Matrox Millennium G400 Max als Allroundkarte f??r den Highend-PC derzeit unerreicht ist. Das ergibt den Testsieg und unsere w??rmste Empfehlung.\&quot;</i><br><br><b>GameStar 8/99 (S.184)</b>','www.matrox.com/mga/deutsch/products/mill_g400/home.cfm',0);
INSERT INTO products_description VALUES (3,2,'Microsoft IntelliMouse Pro','Die IntelliMouse Pro hat mit der IntelliRad-Technologie einen neuen Standard gesetzt. Anwenderfreundliche Handhabung und produktiveres Arbeiten am PC zeichnen die IntelliMouse aus. Die gew??lbte Oberseite pa??t sich nat??rlich in die Handfl??che ein, die geschwungene Form erleichtert das Bedienen der Maus. Sie ist sowohl f??r Rechts- wie auch f??r Linksh??nder geeignet. Mit dem Rad der IntelliMouse kann der Anwender einfach und komfortabel durch Dokumente navigieren.<br><br><b>Eigenschaften:</b><br><ul><br><li><b>ANSCHLUSS:</b> PS/2</li><br><li><b>FARBE:</b> wei??</li><br><li><b>TECHNIK:</b> Mauskugel</li><br><li><b>TASTEN:</b> 3 (incl. Scrollrad)</li><br><li><b>SCROLLRAD:</b> Ja</li><br></ul>','',0);
INSERT INTO products_description VALUES (4,2,'Die Ersatzkiller','Originaltitel: \&quot;The Replacement Killers\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 80 minutes.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1998). Til Schweiger schie??t auf Hongkong-Star Chow Yun-Fat (\&quot;Anna und der K??nig\&quot;) ?? ein Fehler ...','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (5,2,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 112 minutes.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br><b>Sci-Fi-Klassiker, USA 1983, 112 Min.</b><br><br>Los Angeles ist im Jahr 2019 ein Hexenkessel. Dauerregen und Smog tauchen den ??berbev??lkerten Moloch in ewige D??mmerung. Polizeigleiter schwirren durch die Luft und ??berwachen das grelle Ethnogemisch, das sich am Fu??e 400st??ckiger Stahlbeton-Pyramiden tummelt. Der abgehalfterte Ex-Cop und \"Blade Runner\" Rick Deckard ist Spezialist f??r die Beseitigung von Replikanten, k??nstlichen Menschen, geschaffen f??r harte Arbeit auf fremden Planeten. Nur ihm kann es gelingen, vier fl??chtige, hochintelligente \"Nexus 6\"-Spezialmodelle zu stellen. Die sind mit ihrem starken und brandgef??hrlichen Anf??hrer Batty auf der Suche nach ihrem Sch??pfer. Er soll ihnen eine l??ngere Lebenszeit schenken. Das mu?? Rick Deckard verhindern.  Als sich der eiskalte J??ger in Rachel, die Sekret??rin seines Auftraggebers, verliebt, ger??t sein Weltbild jedoch ins Wanken. Er entdeckt, da?? sie - vielleicht wie er selbst - ein Replikant ist ...<br><br>Die Konfrontation des Menschen mit \"Realit??t\" und \"Virtualit??t\" und das verstrickte Spiel mit get??rkten Erinnerungen zieht sich als roter Faden durch das Werk von Autor Philip K. Dick (\"Die totale Erinnerung\"). Sein Roman \"Tr??umen Roboter von elektrischen Schafen?\" liefert die Vorlage f??r diesen doppelb??digen Thriller, der den Zuschauer mit faszinierenden<br>Zukunftsvisionen und der gigantischen Kulisse des Gro??stadtmolochs gefangen nimmt.','www.bladerunner.com',0);
INSERT INTO products_description VALUES (6,2,'Matrix','Originaltitel: \&quot;The Matrix\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 136 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1999) Der Geniestreich der Wachowski-Br??der. In dieser technisch perfekten Utopie k??mpft Hacker Keanu Reeves gegen die Diktatur der Maschinen...','www.whatisthematrix.com',0);
INSERT INTO products_description VALUES (7,2,'e-m@il f??r Dich','Original: \&quot;You''ve got mail\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 112 minutes.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1998) von Nora Ephron (\&quot;Schlaflos in Seattle\&quot;). Meg Ryan und Tom Hanks kn??pfen per E-Mail zarte Bande. Dass sie sich schon kennen, ahnen sie nicht ...','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (8,2,'Das Gro??e Krabbeln','Originaltitel: \&quot;A Bug''s Life\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA 1998). Ameise Flik zettelt einen Aufstand gegen gefr????ige Grash??pfer an ... Eine fantastische Computeranimation des \"Toy Story\"-Teams. ','www.abugslife.com',0);
INSERT INTO products_description VALUES (9,2,'Alarmstufe: Rot','Originaltitel: \&quot;Under Siege\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br><b>Actionthriller. Smutje Steven Seagal versalzt Schurke Tommy Lee Jones die Suppe</b><br><br>Katastrophe ahoi: Kurz vor Ausmusterung der \"U.S.S. Missouri\" kapert die High-tech-Bande von Ex-CIA-Agent Strannix (Tommy Lee Jones) das Schlachtschiff. Strannix will die Nuklearraketen des Kreuzers klauen und verscherbeln. Mit Hilfe des irren Ersten Offiziers Krill (lustig: Gary Busey) killen die Gangster den K??pt???n und sperren seine Crew unter Deck. Bl??d, dass sie dabei Schiffskoch Rybak (Steven Seagal) vergessen. Der Ex-Elitek??mpfer knipst einen Schurken nach dem anderen aus. Eine Verb??ndete findet er in Stripperin Jordan (Ex-\"Baywatch\"-Biene Erika Eleniak). Die sollte eigentlich aus K??pt???ns Geburtstagstorte h??pfen ... Klar: Seagal ist kein Edelmime. Daf??r ist Regisseur Andrew Davis (\"Auf der Flucht\") ein K??nner: Er w??rzt die Action-Orgie mit Ironie und nutzt die imposante Schiffskulisse voll aus. F??r Effekte und Ton gab es 1993 Oscar-Nominierungen. ','',0);
INSERT INTO products_description VALUES (10,2,'Alarmstufe: Rot 2','Originaltitel: \&quot;Under Siege 2: Dark Territory\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>(USA ???95). Von einem gekaperten Zug aus ??bernimmt Computerspezi Dane die Kontrolle ??ber einen Kampfsatelliten und erpresst das Pentagon. Aber auch Ex-Offizier Ryback (Steven Seagal) ist im Zug ...<br>','',0);
INSERT INTO products_description VALUES (11,2,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Ein mysteri??ser Mordfall f??hrt den Bundesmarschall Jack Taggert in eine Kleinstadt im US-Staat Kentucky. Doch bei seinen Ermittlungen st????t er auf eine Mauer des Schweigens. Angst beherrscht die Stadt, und alle Spuren f??hren zu dem undurchsichtigen Minen-Tycoon Orin Hanner. Offenbar werden in der friedlichen Berglandschaft gigantische Mengen Giftm??lls verschoben, mit unkalkulierbaren Risiken. Um eine Katastrophe zu verhindern, r??umt Taggert gnadenlos auf ...','',0);
INSERT INTO products_description VALUES (12,2,'Stirb Langsam - Jetzt Erst Recht','Originaltitel: \&quot;Die Hard With A Vengeance\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>So explosiv, so spannend, so rasant wie nie zuvor: Bruce Willis als Detectiv John McClane in einem Action-Thriller der Superlative! Das ist heute nicht McClanes Tag. Seine Frau hat ihn verlassen, sein Bo?? hat ihn vom Dienst suspendiert und irgendein Verr??ckter hat ihn gerade zum Gegenspieler in einem teuflischen Spiel erkoren - und der Einsatz ist New York selbst. Ein Kaufhaus ist explodiert, doch das ist nur der Auftakt. Der geniale Superverbrecher Simon droht, die ganze Stadt St??ck f??r St??ck in die Luft zu sprengen, wenn McClane und sein Partner wider Willen seine explosiven\" R??tsel nicht l??sen. Eine m??rderische Hetzjagd quer durch New York beginnt - bis McClane merkt, da?? der Bombenterror eigentlich nur ein brillantes Ablenkungsman??ver ist...!<br><i>\"Perfekt gemacht und stark besetzt. Das Action-Highlight des Jahres!\"</i> <b>(Bild)</b>','',0);
INSERT INTO products_description VALUES (13,2,'Zwei stahlharte Profis','Originaltitel: \&quot;Lethal Weapon\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Sie sind beide Cops in L.A.. Sie haben beide in Vietnam f??r eine Spezialeinheit gek??mpft. Und sie hassen es beide, mit einem Partner arbeiten zu m??ssen. Aber sie sind Partner: Martin Riggs, der Mann mit dem Todeswunsch, f??r wen auch immer. Und Roger Murtaugh, der besonnene Polizist. Gemeinsam enttarnen sie einen gigantischen Heroinschmuggel, hinter dem sich eine Gruppe ehemaliger CIA-S??ldner verbirgt. Eine Killerbande gegen zwei Profis ...','',0);
INSERT INTO products_description VALUES (14,2,'Labyrinth ohne Ausweg','Originaltitel: \&quot;Red Corner\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Dem Amerikaner Jack Moore wird in China der bestialische Mord an einem Fotomodel angeh??ngt. Brutale Gef??ngnisschergen versuchen, ihn durch Folter zu einem Gest??ndnis zu zwingen. Vor Gericht fordert die Anklage die Todesstrafe - Moore''s Schicksal scheint besiegelt. Durch einen Zufall gelingt es ihm, aus der Haft zu fliehen, doch aus der feindseligen chinesischen Hauptstadt gibt es praktisch kein Entkommen ...','',0);
INSERT INTO products_description VALUES (15,2,'Frantic','Originaltitel: \&quot;Frantic\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Ein romantischer Urlaub in Paris, der sich in einen Alptraum verwandelt. Ein Mann auf der verzweifelten Suche nach seiner entf??hrten Frau. Ein d??ster-bedrohliches Paris, in dem nur ein Mensch Licht in die t??dliche Aff??re bringen kann.','',0);
INSERT INTO products_description VALUES (16,2,'Mut Zur Wahrheit','Originaltitel: \&quot;Courage Under Fire\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Lieutenant Colonel Nathaniel Serling (Denzel Washington) l??sst w??hrend einer Schlacht im Golfkrieg versehentlich auf einen US-Panzer schie??en, dessen Mannschaft dabei ums Leben kommt. Ein Jahr nach diesem Vorfall wird Serling, der mittlerweile nach Washington D.C. versetzt wurde, die Aufgabe ??bertragen, sich um einen Kandidaten zu k??mmern, der w??hrend des Krieges starb und dem der h??chste milit??rische Orden zuteil werden soll. Allerdings sind sowohl der Fall und als auch der betreffende Soldat ein politisch hei??es Eisen -- Captain Karen Walden (Meg Ryan) ist Amerikas erster weiblicher Soldat, der im Kampf get??tet wurde.<br><br>Serling findet schnell heraus, dass es im Fall des im felsigen Gebiet von Kuwait abgest??rzten Rettungshubschraubers Diskrepanzen gibt. In Flashbacks werden von unterschiedlichen Personen verschiedene Versionen von Waldens Taktik, die Soldaten zu retten und den Absturz zu ??berleben, dargestellt (?? la Kurosawas Rashomon). Genau wie in Glory erweist sich Regisseur Edward Zwicks Zusammenstellung von bekannten und unbekannten Schauspielern als die richtige Mischung. Waldens Crew ist besonders ??berzeugend. Matt Damon als der Sanit??ter kommt gut als der leichtfertige Typ r??ber, als er Washington seine Geschichte erz??hlt. Im Kampf ist er ein mit Fehlern behafteter, humorvoller Soldat.<br><br>Die erstaunlichste Arbeit in Mut zur Wahrheit leistet Lou Diamond Phillips (als der Sch??tze der Gruppe), dessen Karriere sich auf dem Weg in die direkt f??r den Videomarkt produzierten Filme befand. Und dann ist da noch Ryan. Sie hat sich in dramatischen Filmen in der Vergangenheit gut behauptet (Eine fast perfekte Liebe, Ein blutiges Erbe), es aber nie geschafft, ihrem Image zu entfliehen, das sie in die Ecke der romantischen Kom??die steckte. Mit gef??rbtem Haar, einem leichten Akzent und der von ihr geforderten Darstellungskunst hat sie endlich einen langlebigen dramatischen Film.','',0);
INSERT INTO products_description VALUES (17,2,'Speed','Originaltitel: \&quot;Speed\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Er ist ein Cop aus der Anti-Terror-Einheit von Los Angeles. Und so ist der Alarm f??r Jack Traven nichts Ungew??hnliches: Ein Terrorist will drei Millionen Dollar erpressen, oder die zuf??lligen Geiseln in einem Aufzug fallen 35 Stockwerke in die Tiefe. Doch Jack schafft das Unm??gliche - die Geiseln werden gerettet und der Terrorist stirbt an seiner eigenen Bombe. Scheinbar. Denn schon wenig sp??ter steht Jack (Keanu Reeves) dem Bombenexperten Payne erneut gegen??ber. Diesmal hat sich der Erpresser eine ganz perfide Mordwaffe ausgedacht: Er plaziert eine Bombe in einem ??ffentlichen Bus. Der Mechanismus der Sprengladung schaltet sich automatisch ein, sobald der Bus schneller als 50 Meilen in der Stunde f??hrt und detoniert sofort, sobald die Geschwindigkeit sinkt. Pl??tzlich wird f??r eine Handvoll ahnungsloser Durchschnittsb??rger der Weg zur Arbeit zum H??llentrip - und nur Jack hat ihr Leben in der Hand. Als der Busfahrer verletzt wird, ??bernimmt Fahrgast Annie (Sandra Bullock) das Steuer. Doch wohin mit einem Bus, der nicht bremsen kann in der Stadt der Staus? Doch es kommt noch schlimmer: Payne (Dennis Hopper) will jetzt nicht nur seine drei Millionen Dollar. Er will Jack. Um jeden Preis.','',0);
INSERT INTO products_description VALUES (18,2,'Speed 2: Cruise Control','Originaltitel: \&quot;Speed 2 - Cruise Control\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Halten Sie ihre Schwimmwesten bereit, denn die actiongeladene Fortsetzung von Speed begibt sich auf Hochseekurs. Erleben Sie Sandra Bullock erneut in ihrer Star-Rolle als Annie Porter. Die Karibik-Kreuzfahrt mit ihrem Freund Alex entwickelt sich unaufhaltsam zur rasenden Todesfahrt, als ein wahnsinniger Computer-Spezialist den Luxusliner in seine Gewalt bringt und auf einen m??rderischen Zerst??rungskurs programmiert. Eine hochexplosive Reise, bei der kein geringerer als Action-Spezialist Jan De Bont das Ruder in die Hand nimmt. Speed 2: Cruise Controll l????t ihre Adrenalin-Wellen in rasender Geschwindigkeit ganz nach oben schnellen.','',0);
INSERT INTO products_description VALUES (19,2,'Verr??ckt nach Mary','Originaltitel: \&quot;There''s Something About Mary\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>13 Jahre nachdem Teds Rendezvous mit seiner angebeteten Mary in einem peinlichen Fiasko endete, tr??umt er immer noch von ihr und engagiert den windigen Privatdetektiv Healy um sie aufzusp??ren. Der findet Mary in Florida und verliebt sich auf den ersten Blick in die atemberaubende Traumfrau. Um Ted als Nebenbuhler auszuschalten, tischt er ihm dicke L??gen ??ber Mary auf. Ted l????t sich jedoch nicht abschrecken, eilt nach Miami und versucht nun alles, um Healy die Balztour zu vermasseln. Doch nicht nur Healy ist verr??ckt nach Mary und Ted bekommt es mit einer ganzen Legion liebeskranker Konkurrenten zu tun ...','',0);
INSERT INTO products_description VALUES (20,2,'Menschenkind','Originaltitel: \&quot;Beloved\&quot;<br><br>Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Sprachen: English, Deutsch.<br><br>Untertitel: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Bildformat: 16:9 Wide-Screen.<br><br>Dauer: (approx) 96 minuten.<br><br>Au??erdem: Interaktive Menus, Kapitelauswahl, Untertitel.<br><br>Dieser vielschichtige Film ist eine Arbeit, die Regisseur Jonathan Demme und dem amerikanischen Talkshow-Star Oprah Winfrey sehr am Herzen lag. Der Film deckt im Verlauf seiner dreist??ndigen Spielzeit viele Bereiche ab. Menschenkind ist teils Sklavenepos, teils Mutter-Tochter-Drama und teils Geistergeschichte.<br><br>Der Film fordert vom Publikum h??chste Aufmerksamkeit, angefangen bei seiner dramatischen und etwas verwirrenden Eingangssequenz, in der die Bewohner eines Hauses von einem niedertr??chtigen ??bersinnlichen Angriff heimgesucht werden. Aber Demme und seine talentierte Besetzung bereiten denen, die dabei bleiben ein unvergessliches Erlebnis. Der Film folgt den Spuren von Sethe (in ihren mittleren Jahren von Oprah Winfrey dargestellt), einer ehemaligen Sklavin, die sich scheinbar ein friedliches und produktives Leben in Ohio aufgebaut hat. Aber durch den erschreckenden und sparsamen Einsatz von R??ckblenden deckt Demme, genau wie das literarische Meisterwerk von Toni Morrison, auf dem der Film basiert, langsam die Schrecken von Sethes fr??herem Leben auf und das schreckliche Ereignis, dass dazu f??hrte, dass Sethes Haus von Geistern heimgesucht wird.<br><br>W??hrend die Gr??uel der Sklaverei und das blutige Ereignis in Sethes Familie unleugbar tief beeindrucken, ist die Qualit??t des Film auch in kleineren, genauso befriedigenden Details sichtbar. Die geistlich beeinflusste Musik von Rachel Portman ist gleichzeitig befreiend und bedr??ckend, und der Einblick in die afro-amerikanische Gemeinschaft nach der Sklaverei -- am Beispiel eines Familienausflugs zu einem Jahrmarkt, oder dem gospelsingenden N??hkr??nzchen -- machen diesen Film zu einem speziellen Vergn??gen sowohl f??r den Geist als auch f??r das Herz. Die Schauspieler, besonders Kimberley Elise als Sethes k??mpfende Tochter und Thandie Newton als der mysteri??se Titelcharakter, sind sehr r??hrend. Achten Sie auch auf Danny Glover (Lethal Weapon) als Paul D.','',0);
INSERT INTO products_description VALUES (21,2,'SWAT 3: Elite Edition','<b>KEINE KOMPROMISSE!</b><br><i>K??mpfen Sie Seite an Seite mit Ihren LAPD SWAT-Kameraden gegen das organisierte Verbrechen!</i><br><br>Eine der realistischsten 3D-Taktiksimulationen der letzten Zeit jetzt mit Multiplayer-Modus, 5 neuen Missionen und jede Menge n??tzliche Tools!<br><br>Los Angeles, 2005. In wenigen Tagen steht die Unterzeichnung des Abkommens der Vereinten Nationen zur Atom-??chtung durch Vertreter aller Nationen der Welt an. Radikale terroristische Vereinigungen machen sich in der ganzen Stadt breit. Verantwortlich f??r die Sicherheit der Delegierten zeichnet sich eine Eliteeinheit der LAPD: das SWAT-Team. Das Schicksal der Stadt liegt in Ihren H??nden.<br><br><b>Neue Features:</b><br><ul><br><li>Multiplayer-Modus (Co op-Modus, Deathmatch in den bekannten Variationen)</li><br><li>5 neue Missionen an original ??rtlichkeiten Las (U-Bahn, Whitman Airport, etc.)</li><br><li>neue Charakter</li><br><li>neue Skins</li><br><li>neue Waffen</li><br><li>neue Sounds</li><br><li>verbesserte KI</li><br><li>Tools-Package</li><br><li>Scenario-Editor</li><br><li>Level-Editor</li><br></ul><br>Die dritte Folge der Bestseller-Reihe im Bereich der 3D-Echtzeit-Simulationen pr??sentiert sich mit einer neuen Spielengine mit extrem ausgepr??gtem Realismusgrad. Der Spieler ??bernimmt das Kommando ??ber eine der besten Polizei-Spezialeinheiten oder einer der ??belsten Terroristen-Gangs der Welt. Er durchl??uft - als \"Guter\" oder \"B??ser\" - eine der h??rtesten und elit??rsten Kampfausbildungen, in der er lernt, mit jeder Art von Krisensituationen umzugehen. Bei diesem Action-Abenteuer geht es um das Leben prominenter Vertreter der Vereinten Nationen und bei 16 Missionen an Originalschaupl??tzen in LA gibt die \"lebensechte\" KI den Protagonisten jeder Seite so einige harte N??sse zu knacken.','www.swat3.com',0);
INSERT INTO products_description VALUES (22,2,'Unreal Tournament','2341: Die Gewalt ist eine Lebensweise, die sich ihren Weg durch die dunklen Risse der Gesellschaft bahnt. Sie bedroht die Macht und den Einfluss der regierenden Firmen, die schnellstens ein Mittel finden m??ssen, die tobenden Massen zu bes??nftigen - ein profitables Mittel ... Gladiatorenk??mpfe sind die L??sung. Sie sollen den Durst der Menschen nach Blut stillen und sind die perfekte Gelegenheit, die Aufst??ndischen, Kriminellen und Aliens zu beseitigen, die die Firmenelite bedrohen.<br><br>Das Turnier war geboren - ein Kampf auf Leben und Tod. Galaxisweit live und in Farbe! K??mpfen Sie f??r Freiheit, Ruhm und Ehre. Sie m??ssen stark, schnell und geschickt sein ... oder Sie bleiben auf der Strecke.<br><br>K??mpfen Sie allein oder kommandieren Sie ein Team gegen Armeen unbarmherziger Krieger, die alle nur ein Ziel vor Augen haben: Die Arenen lebend zu verlassen und sich dem Grand Champion zu stellen ... um ihn dann zu bezwingen!<br><br><b>Features:</b><br><ul><br><li>Auf dem PC mehrfach als Spiel des Jahres ausgezeichnet!</li><br><li>Mehr als 50 faszinierende Level - verlassene Raumstationen, gotische Kathedralen und graffitibedeckte Gro??st??dte.</li><br><li>Vier actionreiche Spielmodi - Deathmatch, Capture the Flag, Assault und Domination werden Ihren Adrenalinpegel in die H??he schnellen lassen.</li><br><li>Dramatische Mehrspieler-K??mpfe mit 2, 3 und 4 Spielern, auch ??ber das Netzwerk</li><br><li>Gnadenlos aggressive Computergegner verlangen Ihnen das ??u??erste ab.</li><br><li>Neuartiges Benutzerinterface und verbesserte Steuerung - auch mit USB-Maus und -Tastatur spielbar.</li><br></ul><br>Der Nachfolger des Actionhits \"Unreal\" verspricht ein leichtes, intuitives Interface, um auch Einsteigern schnellen Zugang zu den Duellen gegen die Bots zu erm??glichen. Mit diesen KI-Kriegern kann man auch Teams bilden und im umfangreichen Multiplayermodus ohne Onlinekosten in den Kampf ziehen. 35 komplett neue Arenen und das erweiterte Waffenangebot bilden dazu den w??rdigen Rahmen.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (23,2,'The Wheel Of Time','<b><i>\"Wheel Of Time\"(Das Rad der Zeit)</i></b> basiert auf den Fantasy-Romanen von Kultautor Robert Jordan und stellt einen einzigartigen Mix aus Strategie-, Action- und Rollenspielelementen dar. Obwohl die Welt von \"Wheel of Time\" eng an die literarische Vorlage der Romane angelehnt ist, erz??hlt das Spiel keine lineare Geschichte. Die Story entwickelt sich abh??ngig von den Aktionen der Spieler, die jeweils die Rollen der Hauptcharaktere aus dem Roman ??bernehmen. Jede Figur hat den Oberbefehl ??ber eine gro??e Gefolgschaft, milit??rische Einheiten und L??ndereien. Die Spieler k??nnen ihre eigenen Festungen konstruieren, individuell ausbauen, von dort aus das umliegende Land erforschen, magische Gegenst??nde sammeln oder die gegnerischen Zitadellen erst??rmen. Selbstverst??ndlich kann man sich auch ??ber LAN oder Internet gegenseitig Truppen auf den Hals hetzen und die Festungen seiner Mitspieler in Schutt und Asche legen. Dreh- und Anlegepunkt von \"Wheel of Time\" ist der Kampf um die finstere Macht \"The Dark One\", die vor langer Zeit die Menschheit beinahe ins Verderben st??rzte und nur mit Hilfe gewaltiger magischer Energie verbannt werden konnte. \"The Amyrlin Seat\" und \"The Children of the Night\" k??mpfen nur gegen \"The Forsaken\" und \"The Hound\" um den Besitz des Schl??ssels zu \"Shayol Ghul\" - dem magischen Siegel, mit dessen Hilfe \"The Dark One\" seinerzeit gebannt werden konnte.<br><br><b>Features:</b> <br><ul><br><li>Ego-Shooter mit Strategie-Elementen</li><br><li>Spielumgebung in Echtzeit-3D</li><br><li>Konstruktion aud Ausbau der eigenen Festung</li><br><li>Einsatz von ??ber 100 Artefakten und Zauberspr??chen</li><br><li>Single- und Multiplayermodus</li><br></ul><br>Im Mittelpunkt steht der Kampf gegen eine finstere Macht namens The Dark One. Deren Schergen m??ssen mit dem Einsatz von ??ber 100 Artefakten und Zaubereien wie Blitzschlag oder Teleportation aus dem Weg ger??umt werden. Die opulente 3D-Grafik verbindet Strategie- und Rollenspielelemente. <br><br><b>Voraussetzungen</b><br>mind. P200, 32MB RAM, 4x CD-Rom, Win95/98, DirectX 5.0 komp.Grafikkarte und Soundkarte. ','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (24,2,'Disciples: Sacred Land','Rundenbasierende Fantasy/RTS-Strategie mit gutem Design (vor allem die Levels, 4 versch. Rassen, tolle Einheiten), fantastischer Atmosph??re und exzellentem Soundtrack. Grafisch leider auf das Niveau von 1990.','www.strategyfirst.com/disciples/welcome.html',0);
INSERT INTO products_description VALUES (25,2,'Microsoft Internet Tastatur PS/2','<i>Microsoft Internet Keyboard,Windows-Tastatur mit 10 zus??tzl. Tasten,2 selbst programmierbar, abnehmbareHandgelenkauflage. Treiber im Lieferumfang.</i><br><br>Ein-Klick-Zugriff auf das Internet und vieles mehr! Das Internet Keyboard verf??gt ??ber 10 zus??tzliche Abk??rzungstasten auf einer benutzerfreundlichen Standardtastatur, die dar??ber hinaus eine abnehmbare Handballenauflage aufweist. ??ber die Abk??rzungstasten k??nnen Sie durch das Internet surfen oder direkt von der Tastatur aus auf E-Mails zugreifen. Die IntelliType Pro-Software erm??glicht au??erdem das individuelle Belegen der Tasten.','',0);
INSERT INTO products_description VALUES (26,2,'Microsof IntelliMouse Explorer','Die IntelliMouse Explorer ??berzeugt durch ihr modernes Design mit silberfarbenem Geh??use, sowie rot schimmernder Unter- und R??ckseite. Die neuartige IntelliEye-Technologie sorgt f??r eine noch nie dagewesene Pr??zision, da statt der beweglichen Teile (zum Abtasten der Bewegungs??nderungen an der Unterseite der Maus) ein optischer Sensor die Bewegungen der Maus erfa??t. Das Herzst??ck der Microsoft IntelliEye-Technologie ist ein kleiner Chip, der einen optischen Sensor und einen digitalen Signalprozessor (DSP) enth??lt.<br><br>Da auf bewegliche Teile, die Staub, Schmutz und Fett aufnehmen k??nnen, verzichtet wurde, mu?? die IntelliMouse Explorer nicht mehr gereinigt werden. Dar??ber hinaus arbeitet die IntelliMouse Explorer auf nahezu jeder Arbeitsoberfl??che, so da?? kein Mauspad mehr erforderlich ist. Mit dem Rad und zwei neuen zus??tzlichen Maustasten erm??glicht sie effizientes und komfortables Arbeiten am PC.<br><br><b>Eigenschaften:</b><br><ul><br><li><b>ANSCHLUSS:</b> USB (PS/2-Adapter enthalten)</li><br><li><b>FARBE:</b> metallic-grau</li><br><li><b>TECHNIK:</b> Optisch (Akt.: ca. 1500 Bilder/s)</li><br><li><b>TASTEN:</b> 5 (incl. Scrollrad)</li><br><li><b>SCROLLRAD:</b> Ja</li><br></ul><br><i><b>BEMERKUNG:</b><br>Keine Reinigung bewegter Teile mehr notwendig, da statt der Mauskugel ein Fotoempf??nger benutzt wird.</i>','',0);
INSERT INTO products_description VALUES (27,2,'Hewlett-Packard LaserJet 1100Xi','<b>HP LaserJet f??r mehr Produktivit??t und Flexibilit??t am Arbeitsplatz</b><br><br>Der HP LaserJet 1100Xi Drucker verbindet exzellente Laserdruckqualit??t mit hoher Geschwindigkeit f??r mehr Effizienz.<br><br><b>Zielkunden</b><br><ul><li>Einzelanwender, die Wert auf professionelle Ausdrucke in Laserqualit??t legen und schnelle Ergebnisse auch bei komplexen Dokumenten erwarten.</li><br><li>Der HP LaserJet 1100 sorgt mit gestochen scharfen Texten und Grafiken f??r ein professionelles Erscheinungsbild Ihrer Arbeit und Ihres Unternehmens. Selbst bei komplexen Dokumenten liefert er schnelle Ergebnisse. Andere Medien - wie z.B. Transparentfolien und Briefumschl??ge, etc. - lassen sich problemlos bedrucken. Somit ist der HP LaserJet 1100 ein Multifunktionstalent im B??roalltag.</li><br></ul><br><b>Eigenschaften</b><br><ul><br><li><b>Druckqualit??t</b> Schwarzwei??: 600 x 600 dpi</li><br><li><b>Monatliche Druckleistung</b> Bis zu 7000 Seiten</li><br><li><b>Speicher</b> 2 MB Standardspeicher, erweiterbar auf 18 MB</li><br><li><b>Schnittstelle/gemeinsame Nutzung</b> Parallel, IEEE 1284-kompatibel</li><br><li><b>Softwarekompatibilit??t</b> DOS/Win 3.1x/9x/NT 4.0</li><br><li><b>Papierzuf??hrung</b> 125-Blatt-Papierzuf??hrung</li><br><li><b>Druckmedien</b> Normalpapier, Briefumschl??ge, Transparentfolien, kartoniertes Papier, Postkarten und Etiketten</li><br><li><b>Netzwerkf??hig</b> ??ber HP JetDirect PrintServer</li><br><li><b>Lieferumfang</b> HP LaserJet 1100Xi Drucker (Lieferumfang: Drucker, Tonerkassette, 2 m Parallelkabel, Netzkabel, Kurzbedienungsanleitung, Benutzerhandbuch, CD-ROM, 3,5\"-Disketten mit Windows?? 3.1x, 9x, NT 4.0 Treibern und DOS-Dienstprogrammen)</li><br><li><b>Gew??hrleistung</b> Ein Jahr</li><br></ul><br>','www.hp.com',0);
INSERT INTO products_description VALUES (1,3,'Matrox G200 MMS','Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8\&quot; PCI board.<br><br>With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br><br>Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters \& Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description VALUES (2,3,'Matrox G400 32MB','<b>Dramatically Different High Performance Graphics</b><br><br>Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br><br><b>Key features:</b><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description VALUES (3,3,'Microsoft IntelliMouse Pro','Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description VALUES (4,3,'The Replacement Killers','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 80 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description VALUES (5,3,'Blade Runner - Director''s Cut','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 112 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description VALUES (6,3,'The Matrix','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch.<br><br>Audio: Dolby Surround.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 131 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description VALUES (7,3,'You''ve Got Mail','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch, Spanish.<br><br>Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br><br>Audio: Dolby Digital 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description VALUES (8,3,'A Bug''s Life','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 91 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description VALUES (9,3,'Under Siege','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (10,3,'Under Siege 2 - Dark Territory','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (11,3,'Fire Down Below','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (12,3,'Die Hard With A Vengeance','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 122 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (13,3,'Lethal Weapon','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (14,3,'Red Corner','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 117 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (15,3,'Frantic','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (16,3,'Courage Under Fire','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (17,3,'Speed','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (18,3,'Speed 2: Cruise Control','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 120 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (19,3,'There''s Something About Mary','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 114 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (20,3,'Beloved','Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 164 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description VALUES (21,3,'SWAT 3: Close Quarters Battle','<b>Windows 95/98</b><br><br>211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description VALUES (22,3,'Unreal Tournament','From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description VALUES (23,3,'The Wheel Of Time','The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description VALUES (24,3,'Disciples: Sacred Lands','A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description VALUES (25,3,'Microsoft Internet Keyboard PS/2','The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description VALUES (26,3,'Microsoft IntelliMouse Explorer','Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description VALUES (27,3,'Hewlett Packard LaserJet 1100Xi','HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);

INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,1,4,1,0.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,1,4,2,50.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,1,4,3,70.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,1,3,5,0.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,1,3,6,100.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,2,4,3,10.00,'-');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,2,4,4,0.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,2,3,6,0.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,2,3,7,120.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,26,3,8,0.00,'+');
INSERT INTO products_attributes VALUES (nextval for products_attributes_seq,26,3,9,6.00,'+');
--INSERT INTO products_attributes VALUES (26,22,5,10,0.00,'+');
--INSERT INTO products_attributes VALUES (27,22,5,13,0.00,'+');

INSERT INTO products_options VALUES (1, 1, 'Color');
INSERT INTO products_options VALUES (2, 1, 'Size');
INSERT INTO products_options VALUES (3, 1, 'Model');
INSERT INTO products_options VALUES (4, 1, 'Memory');
INSERT INTO products_options VALUES (1, 2, 'Farbe');
INSERT INTO products_options VALUES (2, 2, 'Gr????e');
INSERT INTO products_options VALUES (3, 2, 'Modell');
INSERT INTO products_options VALUES (4, 2, 'Speicher');
INSERT INTO products_options VALUES (1, 3, 'Color');
INSERT INTO products_options VALUES (2, 3, 'Talla');
INSERT INTO products_options VALUES (3, 3, 'Modelo');
INSERT INTO products_options VALUES (4, 3, 'Memoria');
--INSERT INTO products_options VALUES (5, 3, 'Version');
--INSERT INTO products_options VALUES (5, 2, 'Version');
--INSERT INTO products_options VALUES (5, 1, 'Version');


INSERT INTO products_options_values VALUES (1,1,'4 mb');
INSERT INTO products_options_values VALUES (2,1,'8 mb');
INSERT INTO products_options_values VALUES (3,1,'16 mb');
INSERT INTO products_options_values VALUES (4,1,'32 mb');
INSERT INTO products_options_values VALUES (5,1,'Value');
INSERT INTO products_options_values VALUES (6,1,'Premium');
INSERT INTO products_options_values VALUES (7,1,'Deluxe');
INSERT INTO products_options_values VALUES (8,1,'PS/2');
INSERT INTO products_options_values VALUES (9,1,'USB');
INSERT INTO products_options_values VALUES (1,2,'4 MB');
INSERT INTO products_options_values VALUES (2,2,'8 MB');
INSERT INTO products_options_values VALUES (3,2,'16 MB');
INSERT INTO products_options_values VALUES (4,2,'32 MB');
INSERT INTO products_options_values VALUES (5,2,'Value Ausgabe');
INSERT INTO products_options_values VALUES (6,2,'Premium Ausgabe');
INSERT INTO products_options_values VALUES (7,2,'Deluxe Ausgabe');
INSERT INTO products_options_values VALUES (8,2,'PS/2 Anschluss');
INSERT INTO products_options_values VALUES (9,2,'USB Anschluss');
INSERT INTO products_options_values VALUES (1,3,'4 mb');
INSERT INTO products_options_values VALUES (2,3,'8 mb');
INSERT INTO products_options_values VALUES (3,3,'16 mb');
INSERT INTO products_options_values VALUES (4,3,'32 mb');
INSERT INTO products_options_values VALUES (5,3,'Value');
INSERT INTO products_options_values VALUES (6,3,'Premium');
INSERT INTO products_options_values VALUES (7,3,'Deluxe');
INSERT INTO products_options_values VALUES (8,3,'PS/2');
INSERT INTO products_options_values VALUES (9,3,'USB');
--INSERT INTO products_options_values VALUES (10, 1, 'Download: Windows - English');
--INSERT INTO products_options_values VALUES (10, 2, 'Download: Windows - Englisch');
--INSERT INTO products_options_values VALUES (10, 3, 'Download: Windows - Inglese');
--INSERT INTO products_options_values VALUES (13, 1, 'Box: Windows - English');
--INSERT INTO products_options_values VALUES (13, 2, 'Box: Windows - Englisch');
--INSERT INTO products_options_values VALUES (13, 3, 'Box: Windows - Inglese');

INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,4,1);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,4,2);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,4,3);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,4,4);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,3,5);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,3,6);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,3,7);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,3,8);
INSERT INTO prod_opt_vals_to_prod_opt VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ,3,9);
--INSERT INTO prod_opt_vals_to_prod_opt VALUES (10, 5, 10);
--INSERT INTO prod_opt_vals_to_prod_opt VALUES (13, 5, 13);

INSERT INTO products_to_categories VALUES (1,4);
INSERT INTO products_to_categories VALUES (2,4);
INSERT INTO products_to_categories VALUES (3,9);
INSERT INTO products_to_categories VALUES (4,10);
INSERT INTO products_to_categories VALUES (5,11);
INSERT INTO products_to_categories VALUES (6,10);
INSERT INTO products_to_categories VALUES (7,12);
INSERT INTO products_to_categories VALUES (8,13);
INSERT INTO products_to_categories VALUES (9,10);
INSERT INTO products_to_categories VALUES (10,10);
INSERT INTO products_to_categories VALUES (11,10);
INSERT INTO products_to_categories VALUES (12,10);
INSERT INTO products_to_categories VALUES (13,10);
INSERT INTO products_to_categories VALUES (14,15);
INSERT INTO products_to_categories VALUES (15,14);
INSERT INTO products_to_categories VALUES (16,15);
INSERT INTO products_to_categories VALUES (17,10);
INSERT INTO products_to_categories VALUES (18,10);
INSERT INTO products_to_categories VALUES (19,12);
INSERT INTO products_to_categories VALUES (20,15);
INSERT INTO products_to_categories VALUES (21,18);
INSERT INTO products_to_categories VALUES (22,19);
INSERT INTO products_to_categories VALUES (23,20);
INSERT INTO products_to_categories VALUES (24,20);
INSERT INTO products_to_categories VALUES (25,8);
INSERT INTO products_to_categories VALUES (26,9);
INSERT INTO products_to_categories VALUES (27,5);

INSERT INTO reviews VALUES (nextval for reviews_seq,19,1,'John doe',5, current timestamp,current timestamp,0);

INSERT INTO reviews_description VALUES (1,1, 'this has to be one of the funniest movies released for 1999!');

INSERT INTO specials VALUES (nextval for specials_seq,3, 39.99, current timestamp, current timestamp, to_date('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), current timestamp, 1);
INSERT INTO specials VALUES (nextval for specials_seq,5, 30.00, current timestamp, current timestamp, to_date('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), current timestamp, 1);
INSERT INTO specials VALUES (nextval for specials_seq,6, 30.00, current timestamp, current timestamp, to_date('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), current timestamp, 1);
INSERT INTO specials VALUES (nextval for specials_seq,16, 29.99, current timestamp, current timestamp, to_date('2020-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), current timestamp, 1);

INSERT INTO tax_class VALUES (nextval for tax_class_seq, 'Taxable Goods', 'The following types of products are included non-food, services, etc', current timestamp, current timestamp);

-- USA/Florida
INSERT INTO tax_rates VALUES (nextval for tax_rates_seq, 1, 1, 1, 7.0, 'FL TAX 7.0%', current timestamp, current timestamp);
INSERT INTO geo_zones VALUES (nextval for geo_zones_seq,'Florida','Florida local sales tax zone',current timestamp,current timestamp);
INSERT INTO zones_to_geo_zones VALUES (nextval for zones_to_geo_zones_seq,223,18,1,current timestamp,current timestamp);

-- USA
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AL','Alabama');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AK','Alaska');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AS','American Samoa');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AZ','Arizona');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AR','Arkansas');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AF','Armed Forces Africa');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AA','Armed Forces Americas');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AC','Armed Forces Canada');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AE','Armed Forces Europe');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AM','Armed Forces Middle East');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'AP','Armed Forces Pacific');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'CA','California');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'CO','Colorado');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'CT','Connecticut');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'DE','Delaware');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'DC','District of Columbia');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'FM','Federated States Of Micronesia');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'FL','Florida');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'GA','Georgia');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'GU','Guam');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'HI','Hawaii');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'ID','Idaho');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'IL','Illinois');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'IN','Indiana');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'IA','Iowa');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'KS','Kansas');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'KY','Kentucky');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'LA','Louisiana');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'ME','Maine');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MH','Marshall Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MD','Maryland');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MA','Massachusetts');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MI','Michigan');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MN','Minnesota');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MS','Mississippi');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MO','Missouri');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MT','Montana');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NE','Nebraska');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NV','Nevada');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NH','New Hampshire');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NJ','New Jersey');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NM','New Mexico');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NY','New York');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'NC','North Carolina');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'ND','North Dakota');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'MP','Northern Mariana Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'OH','Ohio');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'OK','Oklahoma');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'OR','Oregon');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'PW','Palau');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'PA','Pennsylvania');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'PR','Puerto Rico');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'RI','Rhode Island');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'SC','South Carolina');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'SD','South Dakota');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'TN','Tennessee');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'TX','Texas');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'UT','Utah');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'VT','Vermont');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'VI','Virgin Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'VA','Virginia');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'WA','Washington');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'WV','West Virginia');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'WI','Wisconsin');
INSERT INTO zones VALUES (nextval for zones_seq, 223,'WY','Wyoming');

--Australia
INSERT INTO zones VALUES (nextval for zones_seq, 13,'ACT','Australian Capitol Territory');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'NSW','New South Wales');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'NT','Northern Territory');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'QLD','Queensland');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'SA','South Australia');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'TAS','Tasmania');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'VIC','Victoria');
INSERT INTO zones VALUES (nextval for zones_seq, 13,'WA','Western Australia');

-- Austria
INSERT INTO zones VALUES (nextval for zones_seq, 14,'WI','Wien');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'NO','Nieder??sterreich');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'OO','Ober??sterreich');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'SB','Salzburg');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'KN','K??rnten');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'ST','Steiermark');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'TI','Tirol');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'BL','Burgenland');
INSERT INTO zones VALUES (nextval for zones_seq, 14,'VB','Voralberg');

--China
INSERT INTO zones VALUES (nextval for zones_seq, 44,'AN','Anhui');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'BE','Beijing');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'CH','Chongqing');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'FU','Fujian');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'GA','Gansu');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'GU','Guangdong');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'GX','Guangxi');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'GZ','Guizhou');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HA','Hainan');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HB','Hebei');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HL','Heilongjiang');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HE','Henan');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HK','Hong Kong');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HU','Hubei');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'HN','Hunan');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'IM','Inner Mongolia');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'JI','Jiangsu');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'JX','Jiangxi');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'JL','Jilin');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'LI','Liaoning');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'MA','Macau');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'NI','Ningxia');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'SH','Shaanxi');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'SA','Shandong');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'SG','Shanghai');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'SX','Shanxi');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'SI','Sichuan');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'TI','Tianjin');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'XI','Xinjiang');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'YU','Yunnan');
INSERT INTO zones VALUES (nextval for zones_seq, 44,'ZH','Zhejiang');

--India
INSERT INTO zones VALUES (nextval for zones_seq, 99,'AN','Andaman and Nicobar Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'AP','Andhra Pradesh');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'AR','Arunachal Pradesh');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'AS','Assam');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'BI','Bihar');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'CH','Chandigarh');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'DA','Dadra and Nagar Haveli');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'DM','Daman and Diu');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'DE','Delhi');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'GO','Goa');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'GU','Gujarat');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'HA','Haryana');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'HP','Himachal Pradesh');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'JA','Jammu and Kashmir');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'KA','Karnataka');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'KE','Kerala');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'LI','Lakshadweep Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'MP','Madhya Pradesh');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'MA','Maharashtra');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'MN','Manipur');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'ME','Meghalaya');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'MI','Mizoram');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'NA','Nagaland');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'OR','Orissa');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'PO','Pondicherry');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'PU','Punjab');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'RA','Rajasthan');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'SI','Sikkim');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'TN','Tamil Nadu');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'TR','Tripura');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'UP','Uttar Pradesh');
INSERT INTO zones VALUES (nextval for zones_seq, 99,'WB','West Bengal');

--Netherlands
INSERT INTO zones VALUES (nextval for zones_seq, 150,'DR','Drenthe');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'FL','Flevoland');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'FR','Friesland');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'GE','Gelderland');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'GR','Groningen');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'LI','Limburg');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'NB','Noord Brabant');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'NH','Noord Holland');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'OV','Overijssel');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'UT','Utrecht');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'ZE','Zeeland');
INSERT INTO zones VALUES (nextval for zones_seq, 150,'ZH','Zuid Holland');

-- Canada
INSERT INTO zones VALUES (nextval for zones_seq, 38,'AB','Alberta');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'BC','British Columbia');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'MB','Manitoba');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'NF','Newfoundland');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'NB','New Brunswick');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'NS','Nova Scotia');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'NT','Northwest Territories');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'NU','Nunavut');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'ON','Ontario');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'PE','Prince Edward Island');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'QC','Quebec');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'SK','Saskatchewan');
INSERT INTO zones VALUES (nextval for zones_seq, 38,'YT','Yukon Territory');

-- Germany
INSERT INTO zones VALUES (nextval for zones_seq, 81,'NDS','Niedersachsen');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'BAW','Baden-W??rttemberg');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'BAY','Bayern');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'BER','Berlin');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'BRG','Brandenburg');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'BRE','Bremen');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'HAM','Hamburg');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'HES','Hessen');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'MEC','Mecklenburg-Vorpommern');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'NRW','Nordrhein-Westfalen');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'RHE','Rheinland-Pfalz');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'SAR','Saarland');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'SAS','Sachsen');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'SAC','Sachsen-Anhalt');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'SCN','Schleswig-Holstein');
INSERT INTO zones VALUES (nextval for zones_seq, 81,'THE','Th??ringen');

--Greece
INSERT INTO zones VALUES (nextval for zones_seq, 84,'AT','Attica');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'CN','Central Greece');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'CM','Central Macedonia');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'CR','Crete');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'EM','East Macedonia and Thrace');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'EP','Epirus');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'II','Ionian Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'NA','North Aegean');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'PP','Peloponnesos');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'SA','South Aegean');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'TH','Thessaly');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'WG','West Greece');
INSERT INTO zones VALUES (nextval for zones_seq, 84,'WM','West Macedonia');

-- Switzerland
INSERT INTO zones VALUES (nextval for zones_seq, 204,'AG','Aargau');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'AI','Appenzell Innerrhoden');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'AR','Appenzell Ausserrhoden');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'BE','Bern');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'BL','Basel-Landschaft');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'BS','Basel-Stadt');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'FR','Freiburg');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'GE','Genf');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'GL','Glarus');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'JU','Graub??nden');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'JU','Jura');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'LU','Luzern');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'NE','Neuenburg');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'NW','Nidwalden');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'OW','Obwalden');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'SG','St. Gallen');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'SH','Schaffhausen');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'SO','Solothurn');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'SZ','Schwyz');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'TG','Thurgau');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'TI','Tessin');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'UR','Uri');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'VD','Waadt');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'VS','Wallis');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'ZG','Zug');
INSERT INTO zones VALUES (nextval for zones_seq, 204,'ZH','Z??rich');

-- Spain
INSERT INTO zones VALUES (nextval for zones_seq, 195,'A Coru??a','A Coru??a');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Alava','Alava');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Albacete','Albacete');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Alicante','Alicante');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Almeria','Almeria');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Asturias','Asturias');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Avila','Avila');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Badajoz','Badajoz');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Baleares','Baleares');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Barcelona','Barcelona');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Burgos','Burgos');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Caceres','Caceres');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Cadiz','Cadiz');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Cantabria','Cantabria');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Castellon','Castellon');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Ceuta','Ceuta');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Ciudad Real','Ciudad Real');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Cordoba','Cordoba');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Cuenca','Cuenca');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Girona','Girona');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Granada','Granada');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Guadalajara','Guadalajara');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Guipuzcoa','Guipuzcoa');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Huelva','Huelva');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Huesca','Huesca');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Jaen','Jaen');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'La Rioja','La Rioja');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Las Palmas','Las Palmas');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Leon','Leon');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Lleida','Lleida');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Lugo','Lugo');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Madrid','Madrid');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Malaga','Malaga');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Melilla','Melilla');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Murcia','Murcia');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Navarra','Navarra');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Ourense','Ourense');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Palencia','Palencia');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Pontevedra','Pontevedra');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Salamanca','Salamanca');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Santa Cruz de Tenerife','Santa Cruz de Tenerife');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Segovia','Segovia');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Sevilla','Sevilla');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Soria','Soria');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Tarragona','Tarragona');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Teruel','Teruel');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Toledo','Toledo');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Valencia','Valencia');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Valladolid','Valladolid');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Vizcaya','Vizcaya');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Zamora','Zamora');
INSERT INTO zones VALUES (nextval for zones_seq, 195,'Zaragoza','Zaragoza');

--Turkey
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ADA','Adana');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ADI','Adiyaman');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'AFY','Afyonkarahisar');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'AGR','Agri');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'AKS','Aksaray');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'AMA','Amasya');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ANK','Ankara');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ANT','Antalya');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ARD','Ardahan');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ART','Artvin');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'AYI','Aydin');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BAL','Balikesir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BAR','Bartin');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BAT','Batman');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BAY','Bayburt');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BIL','Bilecik');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BIN','Bingol');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BIT','Bitlis');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BOL','Bolu');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BRD','Burdur');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'BRS','Bursa');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'CKL','Canakkale');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'CKR','Cankiri');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'COR','Corum');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'DEN','Denizli');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'DIY','Diyarbakir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'DUZ','Duzce');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'EDI','Edirne');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ELA','Elazig');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'EZC','Erzincan');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'EZR','Erzurum');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ESK','Eskisehir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'GAZ','Gaziantep');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'GIR','Giresun');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'GMS','Gumushane');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'HKR','Hakkari');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'HTY','Hatay');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'IGD','Igdir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ISP','Isparta');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'IST','Istanbul');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'IZM','Izmir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KAH','Kahramanmaras');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KRB','Karabuk');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KRM','Karaman');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KRS','Kars');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KAS','Kastamonu');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KAY','Kayseri');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KLS','Kilis');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KRK','Kirikkale');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KLR','Kirklareli');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KRH','Kirsehir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KOC','Kocaeli');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KON','Konya');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'KUT','Kutahya');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'MAL','Malatya');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'MAN','Manisa');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'MAR','Mardin');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'MER','Mersin');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'MUG','Mugla');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'MUS','Mus');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'NEV','Nevsehir');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'NIG','Nigde');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ORD','Ordu');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'OSM','Osmaniye');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'RIZ','Rize');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SAK','Sakarya');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SAM','Samsun');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SAN','Sanliurfa');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SII','Siirt');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SIN','Sinop');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SIR','Sirnak');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'SIV','Sivas');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'TEL','Tekirdag');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'TOK','Tokat');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'TRA','Trabzon');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'TUN','Tunceli');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'USK','Usak');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'VAN','Van');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'YAL','Yalova');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'YOZ','Yozgat');
INSERT INTO zones VALUES (nextval for zones_seq, 215,'ZON','Zonguldak');

--United Kingdom
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ABN', 'Aberdeen');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ABNS', 'Aberdeenshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ANG', 'Anglesey');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'AGS', 'Angus');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ARY', 'Argyll and Bute');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BEDS', 'Bedfordshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BERKS', 'Berkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BLA', 'Blaenau Gwent');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BRI', 'Bridgend');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BSTL', 'Bristol');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BUCKS', 'Buckinghamshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CAE', 'Caerphilly');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CAMBS', 'Cambridgeshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CDF', 'Cardiff');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CARM', 'Carmarthenshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CDGN', 'Ceredigion');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CHES', 'Cheshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CLACK', 'Clackmannanshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CON', 'Conwy');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'CORN', 'Cornwall');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DNBG', 'Denbighshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DERBY', 'Derbyshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DVN', 'Devon');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DOR', 'Dorset');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DGL', 'Dumfries and Galloway');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DUND', 'Dundee');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DHM', 'Durham');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ARYE', 'East Ayrshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'DUNBE', 'East Dunbartonshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LOTE', 'East Lothian');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'RENE', 'East Renfrewshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ERYS', 'East Riding of Yorkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SXE', 'East Sussex');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'EDIN', 'Edinburgh');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ESX', 'Essex');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'FALK', 'Falkirk');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'FFE', 'Fife');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'FLINT', 'Flintshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'GLAS', 'Glasgow');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'GLOS', 'Gloucestershire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LDN', 'Greater London');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'MCH', 'Greater Manchester');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'GDD', 'Gwynedd');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'HANTS', 'Hampshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'HWR', 'Herefordshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'HERTS', 'Hertfordshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'HLD', 'Highlands');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'IVER', 'Inverclyde');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'IOW', 'Isle of Wight');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'KNT', 'Kent');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LANCS', 'Lancashire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LEICS', 'Leicestershire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LINCS', 'Lincolnshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'MSY', 'Merseyside');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'MERT', 'Merthyr Tydfil');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'MLOT', 'Midlothian');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'MMOUTH', 'Monmouthshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'MORAY', 'Moray');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'NPRTAL', 'Neath Port Talbot');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'NEWPT', 'Newport');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'NOR', 'Norfolk');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ARYN', 'North Ayrshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LANN', 'North Lanarkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'YSN', 'North Yorkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'NHM', 'Northamptonshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'NLD', 'Northumberland');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'NOT', 'Nottinghamshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ORK', 'Orkney Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'OFE', 'Oxfordshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'PEM', 'Pembrokeshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'PERTH', 'Perth and Kinross');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'PWS', 'Powys');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'REN', 'Renfrewshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'RHON', 'Rhondda Cynon Taff');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'RUT', 'Rutland');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'BOR', 'Scottish Borders');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SHET', 'Shetland Islands');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SPE', 'Shropshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SOM', 'Somerset');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'ARYS', 'South Ayrshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'LANS', 'South Lanarkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'YSS', 'South Yorkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SFD', 'Staffordshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'STIR', 'Stirling');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SFK', 'Suffolk');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SRY', 'Surrey');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SWAN', 'Swansea');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'TORF', 'Torfaen');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'TWR', 'Tyne and Wear');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'VGLAM', 'Vale of Glamorgan');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WARKS', 'Warwickshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WDUN', 'West Dunbartonshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WLOT', 'West Lothian');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WMD', 'West Midlands');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'SXW', 'West Sussex');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'YSW', 'West Yorkshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WIL', 'Western Isles');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WLT', 'Wiltshire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WORCS', 'Worcestershire');
INSERT INTO zones VALUES (nextval for zones_seq, 222, 'WRX', 'Wrexham');



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

-----------------------------------------------------------------
-- KonaKart supplementary v9.4.0.2 demo database script for MySQL database
-----------------------------------------------------------------
--
-- KonaKart data configuration parameters
--
-- TODO:
-- To configure KonaKart to be able to send emails you have to modify the values to be inserted for the
-- Email configuration parameters..  You will need to set parameters for:
--	SMTP Server Name
--	SMTP Secure (whether or not the server requires authentication, true or false)
--	SMTP Username
--	SMTP Password
--	Email Reply To Address

-- TODO - Modify the following values for your own configuration:  (Default values are supplied - but these have to be changed)

-- Email Configuration:

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'SMTP Server',          'SMTP_SERVER',          'ENTER_YOUR_SMTP_SERVER_HERE', 'The SMTP server',                                         12, 2, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (nextval for configuration_seq, 'SMTP Secure',          'SMTP_SECURE',          'false',                       'Whether or not the SMTP server needs user authentication', 12, 3, current timestamp, 'choice(''true''=''true'',''false''=''false'')');
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'SMTP User',            'SMTP_USER',            'user@yourdomain.com',         'The SMTP user',                                           12, 4, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (nextval for configuration_seq, 'SMTP Password',        'SMTP_PASSWORD',        '',                            'The SMTP password',                                       12, 5, current timestamp, 'password');
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Email Reply To',       'EMAIL_REPLY_TO',       'user@yourdomain.com',         'The Reply To Address',                                    12, 6, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (nextval for configuration_seq, 'Debug Email Sessions', 'DEBUG_EMAIL_SESSIONS', 'false',                       'Debug email sessions',                                    12, 7, current timestamp, 'choice(''true''=''true'',''false''=''false'')');
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Send Extra Emails To', 'SEND_EXTRA_EMAILS_TO', '', 'Send extra emails to the following email addresses, separated by semicolons: email@address1; email@address2', 1, 11, current timestamp);

-- Stock Reorder implementation:

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Stock Reorder Class','STOCK_REORDER_CLASS','com.konakart.bl.ReorderMgr','The Stock Reorder Implementation Cass',9, 7, current timestamp);

-- Refresh interval for client side caches

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Client cache refresh interval','CLIENT_CACHE_UPDATE_SECS','600','Interval in seconds for refreshing client side caches',11, 8, 'integer(60,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Client config cache refresh check interval','CLIENT_CONFIG_CACHE_CHECK_SECS','30','Interval in seconds for checking to see whether the client side cache of config variables needs updating',11, 9, 'integer(30,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Client config cache refresh flag','CLIENT_CONFIG_CACHE_CHECK_FLAG','false','Boolean to determine whether to refresh the client config variable cache',100, 1 , current timestamp);

-- Table to store IPN notifications from payment gateways
DROP TABLE ipn_history;
CREATE TABLE ipn_history (
  ipn_history_id INTEGER NOT NULL,
  module_code VARCHAR(32) NOT NULL,
  gateway_transaction_id VARCHAR(128),
  gateway_result VARCHAR(128),
  gateway_full_response VARCHAR(4000),
  order_id int,
  konakart_result_id int,
  konakart_result_description VARCHAR(255),
  date_added TIMESTAMP,
  PRIMARY KEY(ipn_history_id)
);
DROP SEQUENCE ipn_history_SEQ;
CREATE SEQUENCE ipn_history_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Base URL and path for images

INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Image base URL','IMG_BASE_URL','http://localhost:8780/konakart/images/','The base URL for application images',4, 9, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Image base path','IMG_BASE_PATH','C:/KonaKart/webapps/konakart/images','The base path where application images are saved',4, 10, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for reaching Image servlet','IMG_SERVLET_URL','/konakartadmin/uploadAction','The URL used to reach the servlet used for uploading images',4, 11, current timestamp);

-- Addition of custom fields

ALTER TABLE customers ADD custom1 varchar(128);
ALTER TABLE customers ADD custom2 varchar(128);
ALTER TABLE customers ADD custom3 varchar(128);
ALTER TABLE customers ADD custom4 varchar(128);
ALTER TABLE customers ADD custom5 varchar(128);

ALTER TABLE products ADD custom1 varchar(128);
ALTER TABLE products ADD custom2 varchar(128);
ALTER TABLE products ADD custom3 varchar(128);
ALTER TABLE products ADD custom4 varchar(128);
ALTER TABLE products ADD custom5 varchar(128);

ALTER TABLE manufacturers ADD custom1 varchar(128);
ALTER TABLE manufacturers ADD custom2 varchar(128);
ALTER TABLE manufacturers ADD custom3 varchar(128);
ALTER TABLE manufacturers ADD custom4 varchar(128);
ALTER TABLE manufacturers ADD custom5 varchar(128);

ALTER TABLE address_book ADD custom1 varchar(128);
ALTER TABLE address_book ADD custom2 varchar(128);
ALTER TABLE address_book ADD custom3 varchar(128);
ALTER TABLE address_book ADD custom4 varchar(128);
ALTER TABLE address_book ADD custom5 varchar(128);

ALTER TABLE orders ADD custom1 varchar(128);
ALTER TABLE orders ADD custom2 varchar(128);
ALTER TABLE orders ADD custom3 varchar(128);
ALTER TABLE orders ADD custom4 varchar(128);
ALTER TABLE orders ADD custom5 varchar(128);

ALTER TABLE reviews ADD custom1 varchar(128);
ALTER TABLE reviews ADD custom2 varchar(128);
ALTER TABLE reviews ADD custom3 varchar(128);

ALTER TABLE categories ADD custom1 varchar(128);
ALTER TABLE categories ADD custom2 varchar(128);
ALTER TABLE categories ADD custom3 varchar(128);

-- SSL
DELETE FROM configuration WHERE configuration_key = 'ENABLE_SSL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enables SSL if set to true', 'ENABLE_SSL', 'false', 'Enables SSL if set to true to make the site secure', 16, 10, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'STANDARD_PORT_NUMBER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Port number for standard (non SSL) pages','STANDARD_PORT_NUMBER','8780','Port number used to access standard non SSL pages',16, 20 ,'integer(0,null)', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'SSL_PORT_NUMBER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Port number for SSL pages','SSL_PORT_NUMBER','8443','Port number used to access SSL pages',16, 30 ,'integer(0,null)', current timestamp);

-- Location for report definitions, and BIRT viewer home
DELETE FROM configuration WHERE configuration_key = 'REPORTS_DEFN_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Report definitions base path','REPORTS_DEFN_PATH','C:/KonaKart/webapps/birt-viewer/reports/','The reports definition location',17, 1, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'REPORTS_EXTENSION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Report file extension','REPORTS_EXTENSION','.rptdesign','The report file extension - identifies report files',17, 2, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'REPORTS_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Report viewer URL','REPORTS_URL','http://localhost:8780/birt-viewer/frameset?__report=reports/','The report viewer base URL',17, 3, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'REPORTS_STATUS_PAGE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Status Page Report URL','REPORTS_STATUS_PAGE_URL','http://localhost:8780/birt-viewer/run?__report=reports/OrdersInLast30DaysChart.rptdesign','The URL for the report on the status page',17, 4, current timestamp);

-- Stock Reorder Email
DELETE FROM configuration WHERE configuration_key = 'STOCK_REORDER_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'E-Mail address for low stock alert', 'STOCK_REORDER_EMAIL', 'reorder_mgr@konakart.com', 'The e-mail address used to send an alert email when the stock level of a product falls below the reorder level', 9, 6, current timestamp);

-- Allow user to insert coupon code
DELETE FROM configuration WHERE configuration_key = 'DISPLAY_COUPON_ENTRY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Coupon Entry Field', 'DISPLAY_COUPON_ENTRY', 'true', 'During checkout the customer will be allowed to enter a coupon if set to true', 1, 22, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Promotions
DROP TABLE promotion;
CREATE TABLE promotion (
  promotion_id INTEGER NOT NULL,
  order_total_code VARCHAR(32) NOT NULL,
  description VARCHAR(128),
  name VARCHAR(64),
  active INTEGER DEFAULT 0 NOT NULL,
  cumulative INTEGER DEFAULT 0 NOT NULL,
  requires_coupon INTEGER DEFAULT 0 NOT NULL,
  start_date TIMESTAMP,
  end_date TIMESTAMP,
  manufacturer_rule int,
  product_rule int,
  customer_rule int,
  category_rule int,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  custom6 VARCHAR(128),
  custom7 VARCHAR(128),
  custom8 VARCHAR(128),
  custom9 VARCHAR(128),
  custom10 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(promotion_id)
);
DROP SEQUENCE promotion_SEQ;
CREATE SEQUENCE promotion_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE promotion_to_manufacturer;
CREATE TABLE promotion_to_manufacturer (
  promotion_id INTEGER NOT NULL,
  manufacturers_id INTEGER NOT NULL,
  PRIMARY KEY(promotion_id,manufacturers_id)
);

DROP TABLE promotion_to_product;
CREATE TABLE promotion_to_product (
  promotion_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  products_options_id INTEGER DEFAULT 0 NOT NULL,
  products_options_values_id INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(promotion_id,products_id,products_options_id,products_options_values_id)
);

DROP TABLE promotion_to_category;
CREATE TABLE promotion_to_category (
  promotion_id INTEGER NOT NULL,
  categories_id INTEGER NOT NULL,
  PRIMARY KEY(promotion_id,categories_id)
);

DROP TABLE promotion_to_customer;
CREATE TABLE promotion_to_customer (
  promotion_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  max_use INTEGER DEFAULT -1 NOT NULL,
  times_used INTEGER DEFAULT 0 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  PRIMARY KEY(promotion_id,customers_id)
);

DROP TABLE coupon;
CREATE TABLE coupon (
  coupon_id INTEGER NOT NULL,
  coupon_code VARCHAR(64) NOT NULL,
  name VARCHAR(64),
  description VARCHAR(128),
  max_use INTEGER DEFAULT 1 NOT NULL,
  times_used INTEGER DEFAULT 0 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(coupon_id)
);
DROP SEQUENCE coupon_SEQ;
CREATE SEQUENCE coupon_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE promotion_to_coupon;
CREATE TABLE promotion_to_coupon (
  promotion_id INTEGER NOT NULL,
  coupon_id INTEGER NOT NULL,
  PRIMARY KEY(promotion_id,coupon_id)
);

-- Add promotion related fields to orders table
ALTER TABLE orders ADD promotion_ids varchar(64);
ALTER TABLE orders ADD coupon_ids varchar(64);


-- Utility Table
DROP TABLE utility;
CREATE TABLE utility (
  id INTEGER NOT NULL,
  PRIMARY KEY(id)
);

DELETE FROM utility;
INSERT INTO utility (id) VALUES (1);
INSERT INTO utility (id) VALUES (2);
INSERT INTO utility (id) VALUES (3);
INSERT INTO utility (id) VALUES (4);
INSERT INTO utility (id) VALUES (5);
INSERT INTO utility (id) VALUES (6);
INSERT INTO utility (id) VALUES (7);
INSERT INTO utility (id) VALUES (8);
INSERT INTO utility (id) VALUES (9);
INSERT INTO utility (id) VALUES (10);
INSERT INTO utility (id) VALUES (11);
INSERT INTO utility (id) VALUES (12);
INSERT INTO utility (id) VALUES (13);
INSERT INTO utility (id) VALUES (14);
INSERT INTO utility (id) VALUES (15);
INSERT INTO utility (id) VALUES (16);
INSERT INTO utility (id) VALUES (17);
INSERT INTO utility (id) VALUES (18);
INSERT INTO utility (id) VALUES (19);
INSERT INTO utility (id) VALUES (20);
INSERT INTO utility (id) VALUES (21);
INSERT INTO utility (id) VALUES (22);
INSERT INTO utility (id) VALUES (23);
INSERT INTO utility (id) VALUES (24);
INSERT INTO utility (id) VALUES (25);
INSERT INTO utility (id) VALUES (26);
INSERT INTO utility (id) VALUES (27);
INSERT INTO utility (id) VALUES (28);
INSERT INTO utility (id) VALUES (29);
INSERT INTO utility (id) VALUES (30);
INSERT INTO utility (id) VALUES (31);

-- Product relationships for merchandising
DROP TABLE products_to_products;
CREATE TABLE products_to_products (
  products_to_products_id INTEGER NOT NULL,
  id_from INTEGER NOT NULL,
  id_to INTEGER NOT NULL,
  relation_type INTEGER DEFAULT 0 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  PRIMARY KEY(products_to_products_id)
);
DROP SEQUENCE products_to_products_SEQ;
CREATE SEQUENCE products_to_products_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Max number of items to display for merchandising
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Up Sell Products', 'MAX_DISPLAY_UP_SELL', '6', 'Maximum number of products to display in the ''Top of Range'' box', 3, 20, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Cross Sell Products', 'MAX_DISPLAY_CROSS_SELL', '6', 'Maximum number of products to display in the ''Similar Products'' box', 3, 21, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Accessories', 'MAX_DISPLAY_ACCESSORIES', '6', 'Maximum number of products to display in the ''Accessories'' box', 3, 22, 'integer(0,null)', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Dependent Products', 'MAX_DISPLAY_DEPENDENT_PRODUCTS', '6', 'Maximum number of products to display in the ''Warranties'' box', 3, 23, 'integer(0,null)', current timestamp);

-- Single page checkout
DELETE FROM configuration WHERE configuration_key = 'ONE_PAGE_CHECKOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enables One Page Checkout', 'ONE_PAGE_CHECKOUT', 'true', 'When set to true, it enables the one page checkout functionality rather than 3 separate pages', 1, 23, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enables Checkout Without Registration', 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION', 'true', 'When set to true, and one page checkout is enabled, it allows customers to checkout without registering', 1, 24, 'choice(''true''=''true'',''false''=''false'')', current timestamp);


-- Order Integration Mgr
DELETE FROM configuration WHERE configuration_key = 'ORDER_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Order Integration Class', 'ORDER_INTEGRATION_CLASS','com.konakart.bl.OrderIntegrationMgr','The Order Integration Implementation Class, to trigger off events when an order is saved or modified', 9, 8, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_ORDER_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Admin Order Integration Class', 'ADMIN_ORDER_INTEGRATION_CLASS','com.konakartadmin.bl.AdminOrderIntegrationMgr','The Order Integration Implementation Class, to trigger off events when an order is modified from the Admin App', 9, 9, current timestamp);

-- Table to contain quantities for products with different options
DROP TABLE products_quantity;
CREATE TABLE products_quantity (
  products_id INTEGER NOT NULL,
  products_options VARCHAR(128) NOT NULL,
  products_quantity INTEGER NOT NULL,
  products_sku VARCHAR(255),
  PRIMARY KEY(products_id, products_options)
);

-- Add extra fields to orders_products_attributes table
ALTER TABLE orders_products_attributes ADD products_options_id int NOT NULL DEFAULT -1;
ALTER TABLE orders_products_attributes ADD products_options_values_id int NOT NULL DEFAULT -1;

-- Add extra fields to products table
ALTER TABLE products ADD products_invisible INTEGER NOT NULL DEFAULT 0;
ALTER TABLE products ADD products_sku varchar(255);

-- Tables for returns
DROP TABLE orders_returns;
CREATE TABLE orders_returns (
  orders_returns_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  rma_code VARCHAR(128),
  return_reason VARCHAR(4000),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(orders_returns_id)
);
DROP SEQUENCE orders_returns_SEQ;
CREATE SEQUENCE orders_returns_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE returns_to_ord_prods;
CREATE TABLE returns_to_ord_prods (
  orders_returns_id INTEGER NOT NULL,
  orders_products_id INTEGER NOT NULL,
  quantity INTEGER NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(orders_returns_id, orders_products_id)
);

-- Extend the size of the products_model column
ALTER TABLE products ALTER COLUMN products_model SET DATA TYPE VARCHAR(64);

-- Add an extra field to the ipn_history table
ALTER TABLE ipn_history ADD customers_id int;

-- For the case where SSL communication requires a different URL
DELETE FROM configuration WHERE configuration_key = 'SSL_BASE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Base URL for SSL pages','SSL_BASE_URL','','Base URL used for SSL pages (i.e. https://myhost:8443). This overrides the SSL port number config.',16, 40, current timestamp);

-- Variables for configuring auditing
DELETE FROM configuration WHERE configuration_key = 'READ_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Reads', 'READ_AUDIT', '0', 'Enable / Disable auditing for reads', 18, 1,'tep_cfg_pull_down_audit_list(', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'EDIT_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Edits', 'EDIT_AUDIT', '0', 'Enable / Disable auditing for edits', 18, 2,'tep_cfg_pull_down_audit_list(', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'INSERT_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Inserts', 'INSERT_AUDIT', '0', 'Enable / Disable auditing for inserts', 18, 3,'tep_cfg_pull_down_audit_list(', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'DELETE_AUDIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Auditing for Deletes', 'DELETE_AUDIT', '0', 'Enable / Disable auditing for deletes', 18, 4,'tep_cfg_pull_down_audit_list(', current timestamp);

-- Audit table
DROP TABLE kk_audit;
CREATE TABLE kk_audit (
  audit_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  audit_action INTEGER NOT NULL,
  api_method_name VARCHAR(128) NOT NULL,
  object_id int,
  object_to_string VARCHAR(4000),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(audit_id)
);
DROP SEQUENCE kk_audit_SEQ;
CREATE SEQUENCE kk_audit_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add extra fields to the customers table
ALTER TABLE customers ADD customers_type int;
ALTER TABLE customers ADD customers_enabled int DEFAULT 1;

-- Role table
DROP TABLE kk_role;
CREATE TABLE kk_role (
  role_id INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  description VARCHAR(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(role_id)
);
DROP SEQUENCE kk_role_SEQ;
CREATE SEQUENCE kk_role_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Customers_to_role table
DROP TABLE kk_customers_to_role;
CREATE TABLE kk_customers_to_role (
  ctor_id INTEGER NOT NULL,
  role_id INTEGER DEFAULT 0 NOT NULL,
  customers_id INTEGER DEFAULT 0 NOT NULL,
  store_id VARCHAR(64),
  date_added TIMESTAMP,
  PRIMARY KEY(ctor_id)
);
DROP SEQUENCE kk_customers_to_role_SEQ;
CREATE SEQUENCE kk_customers_to_role_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel table
DROP TABLE kk_panel;
CREATE TABLE kk_panel (
  panel_id INTEGER NOT NULL,
  code VARCHAR(128) NOT NULL,
  description VARCHAR(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(panel_id)
);
DROP SEQUENCE kk_panel_SEQ;
CREATE SEQUENCE kk_panel_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Role to Panel table
DROP TABLE kk_role_to_panel;
CREATE TABLE kk_role_to_panel (
  role_id INTEGER DEFAULT 0 NOT NULL,
  panel_id INTEGER DEFAULT 0 NOT NULL,
  can_edit INTEGER DEFAULT 0,
  can_insert INTEGER DEFAULT 0,
  can_delete INTEGER DEFAULT 0,
  custom1 INTEGER DEFAULT 0,
  custom1_desc VARCHAR(128),
  custom2 INTEGER DEFAULT 0,
  custom2_desc VARCHAR(128),
  custom3 INTEGER DEFAULT 0,
  custom3_desc VARCHAR(128),
  custom4 INTEGER DEFAULT 0,
  custom4_desc VARCHAR(128),
  custom5 INTEGER DEFAULT 0,
  custom5_desc VARCHAR(128),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(role_id, panel_id)
);

-- Default super-administrator user = "admin@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081';
DELETE FROM address_book WHERE entry_street_address='1 Way Street' AND entry_postcode='PostCode1';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'ACME Inc.', 'Andy', 'Admin', '1 Way Street', '', 'PostCode1', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq, 'm', 'Andy', 'Admin', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'admin@konakart.com', -1, '019081', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info select customers_id , current timestamp, 0, current timestamp, current timestamp, 0 FROM customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081';
UPDATE address_book SET customers_id = (select customers_id from customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (select address_book_id FROM address_book WHERE entry_street_address='1 Way Street' AND entry_postcode='PostCode1') WHERE customers_default_address_id=-1;

-- Default catalog maintainer user = "cat@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082';
DELETE FROM address_book WHERE entry_street_address='2 Way Street' AND entry_postcode='PostCode2';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'ACME Inc.', 'Caty', 'Catalog', '2 Way Street', '', 'PostCode2', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq, 'm', 'Caty', 'Catalog', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'cat@konakart.com', -1, '019082', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info SELECT customers_id , current timestamp, 0, current timestamp, current timestamp, 0 FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082';
UPDATE address_book SET customers_id = (SELECT customers_id FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (SELECT address_book_id FROM address_book WHERE entry_street_address='2 Way Street' AND entry_postcode='PostCode2') WHERE customers_default_address_id=-1;


-- Default order maintainer user = "order@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'order@konakart.com' and customers_telephone='019083';
DELETE FROM address_book WHERE entry_street_address='3 Way Street' and entry_postcode='PostCode3';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'ACME Inc.', 'Olly', 'Order', '3 Way Street', '', 'PostCode3', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq, 'm', 'Olly', 'Order', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'order@konakart.com', -1, '019083', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info SELECT customers_id , current timestamp, 0, current timestamp, current timestamp, 0 FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083';
UPDATE address_book SET customers_id = (SELECT customers_id FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (SELECT address_book_id FROM address_book WHERE entry_street_address='3 Way Street' AND entry_postcode='PostCode3') WHERE customers_default_address_id=-1;

-- Panels
DELETE FROM kk_panel;
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_addressFormats','Address Formats', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_audit','Audit', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_auditConfig','AuditConfig', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_cache','Cache', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_categories','Categories', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_configFiles','Configuration Files', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_digitalDownloadConfig','Digital Downloads', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_countries','Countries', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_coupons','Coupons', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_couponsFromProm','Coupons For Promotions', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_currencies','Currencies', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customerDetails','Customer Details', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customerOrders','Customer Orders', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customers','Customers', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_deleteSessions','Delete Expired Sessions', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editCustomer','Edit Customer', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editOrderPanel','Edit Order', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editProduct','Edit Product', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_emailOptions','Email Options', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_geoZones','Geo-Zones', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_httpHttps','HTTP / HTTPS', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_images','Images', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_insertCustomer','Insert Customer', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_ipnhistory','Payment Gateway Callbacks', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_ipnhistoryFromOrders','Payment Status For Order', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_languages','Languages', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_logging','Logging', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_roleToPanels','Maintain Roles', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_manufacturers','Manufacturers', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_maximumValues','Maximum Values', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_minimumValues','Minimum Values', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_userToRoles','Map Users to Roles', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_orders','Orders', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_orderStatuses','Order Statuses', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_orderTotalModules','Order Total', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_paymentModules','Payment', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_prodsFromCat','Products for Categories', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_prodsFromManu','Products for Manufacturer', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_productOptions','Product Options', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_products','Products', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_promotions','Promotions', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_promRules','Promotion Rules', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_refreshCache','Refresh Config Cache', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_reports','Reports', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_reportsConfig','Reports Configuration', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_returns','Product Returns', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_returnsFromOrders','Product Returns For Order', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_rss','Latest News', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_shippingModules','Shipping', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_shippingPacking','Shipping / Packing', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_status','Status', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_stockAndOrders','Stock and Orders', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_storeConfiguration','My Store', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_subZones','Sub-Zones', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxAreaMapping','Tax Area Mapping', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxAreas','Tax Areas', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxAreaToZoneMapping','Tax Area to Zone Mapping', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxClasses','Tax Classes', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_taxRates','Tax Rates', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_zones','Zones', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_changePassword','Change Password', current timestamp);

-- Roles
DELETE FROM kk_role;
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Super User','Permission to do everything to all stores', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Catalog Maintenance','Permission to maintain the catalog of products', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Order Maintenance','Permission to maintain the orders', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Customer Maintenance','Permission to maintain the customers', current timestamp);
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq,  'Store Administrator','Permission to maintain a single store', current timestamp);

-- Associate roles to panels
DELETE FROM kk_role_to_panel;

-- Super User Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 1, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 2, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 3, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 4, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 5, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 6, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 7, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 8, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 9, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 10, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 11, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 12, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 13, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc, custom2, custom2_desc) VALUES (1, 14, 1,1,1,current timestamp, 0, 'If set email is disabled', 0, 'If set cannot reset password');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 15, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 16, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 17, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 18, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 19, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 20, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 21, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 22, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 23, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 24, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 25, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 26, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 27, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 28, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 29, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 30, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 31, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 32, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 33, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 34, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 35, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 36, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 37, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 38, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 39, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 40, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 41, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 42, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 43, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc) VALUES (1, 44, 1,1,1,current timestamp, 0, 'If set reports cannot be run');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 45, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 46, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 47, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 48, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 49, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 50, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 51, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 52, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 53, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 54, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 55, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 56, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 57, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 58, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 59, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 60, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 61, 1,1,1,current timestamp);

-- Catalog maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 5, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 9, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 10, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 18, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 29, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 37, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 38, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 39, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 40, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 41, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 42, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 61, 1,1,1,current timestamp);

-- Order Maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 17, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 24, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 25, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 33, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 46, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 47, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 61, 1,1,1,current timestamp);

-- Customer Maintenance Role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 13, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, custom1, custom1_desc, custom2, custom2_desc) VALUES (4, 14, 1,1,1,current timestamp, 0, 'If set email is disabled', 0, 'If set cannot reset password');
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 16, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 23, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 61, 1,1,1,current timestamp);

-- Associate customers to roles
DELETE FROM kk_customers_to_role;

-- Super User
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT nextval for kk_customers_to_role_seq, 1, customers_id, current timestamp FROM customers WHERE customers_email_address = 'admin@konakart.com' AND customers_telephone='019081';

-- Catalog maintainer
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT nextval for kk_customers_to_role_seq, 2, customers_id, current timestamp FROM customers WHERE customers_email_address = 'cat@konakart.com' AND customers_telephone='019082';

-- Order & Customer Manager
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT nextval for kk_customers_to_role_seq, 3, customers_id, current timestamp FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083';
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT nextval for kk_customers_to_role_seq, 4, customers_id, current timestamp FROM customers WHERE customers_email_address = 'order@konakart.com' AND customers_telephone='019083';

-- Digital Download table
DROP TABLE kk_digital_download;
CREATE TABLE kk_digital_download (
  products_id INTEGER DEFAULT 0 NOT NULL,
  customers_id INTEGER DEFAULT 0 NOT NULL,
  max_downloads INTEGER DEFAULT -1,
  times_downloaded INTEGER DEFAULT 0,
  expiration_date TIMESTAMP,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(products_id, customers_id)
);

-- Add extra fields to the products table
ALTER TABLE products ADD products_type int DEFAULT 0;
ALTER TABLE products ADD products_file_path varchar(255);
ALTER TABLE products ADD products_content_type varchar(128);

-- Add extra field to the orders_products
ALTER TABLE orders_products ADD products_type int DEFAULT 0;

-- Configuration variables for digital downloads
DELETE FROM configuration WHERE configuration_key = 'DD_BASE_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Digital Download Base Path', 'DD_BASE_PATH', '', 'Base path for digital download files', 19, 0, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'DD_MAX_DOWNLOADS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Max Number of Downloads', 'DD_MAX_DOWNLOADS', '-1', 'Maximum number of downloads allowed from link. -1 for unlimited number.', 19, 1, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'DD_MAX_DOWNLOAD_DAYS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Number of days link is valid', 'DD_MAX_DOWNLOAD_DAYS', '-1', 'The download link remains valid for this number of days. -1 for unlimited number of days', 19, 2, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'DD_DELETE_ON_EXPIRATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Delete record on expiration', 'DD_DELETE_ON_EXPIRATION', 'true', 'When the download link expires, delete the database table record', 19, 3, 'choice(''true''=''true'',''false''=''false'')',current timestamp);
DELETE FROM configuration WHERE configuration_key = 'DD_DOWNLOAD_AS_ATTACHMENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Download as an attachment', 'DD_DOWNLOAD_AS_ATTACHMENT', 'true', 'Download the file as an attachment rather than viewing in the browser', 19, 4, 'choice(''true''=''true'',''false''=''false'')',current timestamp);

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 7;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,1,'Partially Delivered');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,2,'Teilweise geliefert');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,3,'Entregado parcialmente');

-- Configuration variable for enabling/disabling access to Invisible Products in the Admin App
DELETE FROM configuration WHERE configuration_key = 'SHOW_INVISIBLE_PRODUCTS_IN_ADM';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Show Invisible Products', 'SHOW_INVISIBLE_PRODUCTS_IN_ADM', 'true', 'Show invisible products in the Admin App', 9, 4, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Add a primary key to the counter table
DROP TABLE counter;
CREATE TABLE counter (
  counter_id INTEGER NOT NULL,
  startdate char(8),
  counter INTEGER,
  PRIMARY KEY(counter_id)
);
DROP SEQUENCE counter_SEQ;
CREATE SEQUENCE counter_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-- Logging configuration
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Logging', 'Logging configuration options', 20, 1);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_LOGGING_LEVEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Admin App logging level', 'ADMIN_APP_LOGGING_LEVEL', '4', 'Set the logging level for the KonaKart Admin App', 20, 1, 'option(0=OFF,1=SEVERE,2=ERROR,4=WARNING,6=INFO,8=DEBUG)', current timestamp);

-- Detailed eMail configurations
DELETE FROM configuration WHERE configuration_key = 'SEND_ORDER_CONF_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send Order Confirmation E-Mails', 'SEND_ORDER_CONF_EMAIL', 'true', 'Send out an e-mail when an order is saved or state changes', 12, 8, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'SEND_STOCK_REORDER_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send Stock Reorder E-Mails', 'SEND_STOCK_REORDER_EMAIL', 'true', 'Send out an e-mail when the stock level of a product falls below a certain value', 12, 9, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'SEND_WELCOME_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send Welcome E-Mails', 'SEND_WELCOME_EMAIL', 'true', 'Send out a welcome e-mail when a customer registers to use the cart', 12, 10, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'SEND_NEW_PASSWORD_EMAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Send New Password E-Mails', 'SEND_NEW_PASSWORD_EMAIL', 'true', 'Send out an e-mail containing a new password when requested by a customer', 12, 11, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Add extra image fields to product
ALTER TABLE products ADD products_image2 varchar(64);
ALTER TABLE products ADD products_image3 varchar(64);
ALTER TABLE products ADD products_image4 varchar(64);

-- Add field for comparison data to products_description
ALTER TABLE products_description ADD products_comparison VARCHAR(4000);

-- Initial configuration for the Order Total Shipping Module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow Free Shipping', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING', 'false', 'Do you want to allow free shipping?', 6, 3,'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, use_function, date_added) VALUES (nextval for configuration_seq, 'Free Shipping For Orders Over', 'MODULE_ORDER_TOTAL_SHIPPING_FREE_SHIPPING_OVER', '50', 'Provide free shipping for orders over the set amount.', 6, 4, 'currencies->format',current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Provide Free Shipping For Orders Made', 'MODULE_ORDER_TOTAL_SHIPPING_DESTINATION', 'national', 'Provide free shipping for orders sent to the set destination.', 6, 5, 'tep_cfg_select_option(array(''national'', ''international'', ''both''), ', current timestamp);

-- API Call table
DROP TABLE kk_api_call;
CREATE TABLE kk_api_call (
  api_call_id INTEGER NOT NULL,
  name VARCHAR(128) NOT NULL,
  description VARCHAR(255),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(api_call_id)
);
DROP SEQUENCE kk_api_call_SEQ;
CREATE SEQUENCE kk_api_call_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Role to API Call table
DROP TABLE kk_role_to_api_call;
CREATE TABLE kk_role_to_api_call (
  role_id INTEGER DEFAULT 0 NOT NULL,
  api_call_id INTEGER DEFAULT 0 NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(role_id, api_call_id)
);

-- Add the API Call Data
DELETE FROM kk_api_call;
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteCurrency','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertCurrency','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateCurrency','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteOrderStatusName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertOrderStatusName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertOrderStatusNames','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateOrderStatusName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteCountry','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertCountry','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateCountry','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteLanguage','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertLanguage','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateLanguage','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'sendEmail','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrdersCount','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrdersLite','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrders','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrderForOrderId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrderForOrderIdAndLangId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrdersCreatedSince','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateOrderStatus','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getHtml','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomersCount','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomersCountWhoHaventPlacedAnOrderSince','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomersCountWhoHavePlacedAnOrderSince','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteOrder','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomers','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomersLite','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomerForId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteTaxRate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertTaxRate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateTaxRate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteTaxClass','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertTaxClass','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateTaxClass','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteAddressFormat','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertAddressFormat','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateAddressFormat','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteGeoZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertGeoZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateGeoZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteSubZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertSubZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateSubZone','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getConfigurationInfo','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getConfigurationsByGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'saveConfigs','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertConfigs','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeConfigs','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getModules','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'registerCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'resetCustomerPassword','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'changePassword','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'searchForProducts','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteCategoryTree','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteSingleCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'moveCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteManufacturer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editManufacturer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertManufacturer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteReview','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editReview','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllReviews','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getReview','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getReviewsPerProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertReview','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertSpecial','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getSpecial','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteSpecial','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editSpecial','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllSpecials','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getSpecialsPerCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteProductOptions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteProductOptionValues','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductOptionsPerId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductOptionValuesPerId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductOption','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editProductOption','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductOptionValue','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editProductOptionValue','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getNextProductOptionId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getNextProductOptionValuesId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductAttributesPerProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteProductAttribute','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteProductAttributesPerProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editProductAttribute','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductAttribute','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductOptionValues','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductOptions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'checkSession','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'searchForIpnHistory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteExpiredSessions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getConfigFiles','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getReports','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'reloadReports','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getFileContents','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'saveFileContents','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteFile','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCategoriesToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCouponsToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addPromotionsToCoupon','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCustomersToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCustomersToPromotionPerOrdersMade','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addManufacturersToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addProductsToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deletePromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteCoupon','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editCoupon','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCouponsPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCoupons','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCategoriesPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getManufacturersPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductsPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getPromotions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getPromotionsCount','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getPromotionsPerCoupon','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertCouponForPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertCoupon','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeCategoriesFromPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeCouponsFromPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removePromotionsFromCoupon','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeCustomersFromPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeManufacturersFromPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeProductsFromPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getRelatedProducts','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeRelatedProducts','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addRelatedProducts','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'readFromUrl','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editOrderReturn','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertOrderReturn','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteOrderReturn','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getOrderReturns','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getSku','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getSkus','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'doesCustomerExistForEmail','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAuditData','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteAuditData','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getRolesPerSessionId','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getRolesPerUser','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addRolesToUser','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeRolesFromUser','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removePanelsFromRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeApiCallsFromRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addPanelsToRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addApiCallsToRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getPanelsPerRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getApiCallsPerRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllPanels','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllApiCalls','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllRoles','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deletePanel','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteApiCall','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editPanel','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editApiCall','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getPanel','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getApiCall','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getRole','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertPanel','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertApiCall','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertDigitalDownload','', current timestamp);

-- Variable for enabling / disabling API Call Security
DELETE FROM configuration WHERE configuration_key = 'API_CALL_SECURITY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Security on API Calls', 'API_CALL_SECURITY', 'false', 'Do you want to enable security on API calls ?', 18, 5,'choice(''true''=''true'',''false''=''false'')' , current timestamp);

-- KonaKart Mail Properties file location
DELETE FROM configuration WHERE configuration_key = 'KONAKART_MAIL_PROPERTIES_FILE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'KonaKart mail properties filename', 'KONAKART_MAIL_PROPERTIES_FILE', 'C:/KonaKart/conf/konakart_mail.properties', 'Location of the KonaKart mail properties file', 12, 8, current timestamp);

-- Log file location
DELETE FROM configuration WHERE configuration_key = 'KONAKART_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'KonaKart Log file Directory', 'KONAKART_LOG_FILE_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write diagnostic log files', 20, 2, current timestamp);

-- Extend the size of the country_name columns to match countries table
ALTER TABLE orders ALTER COLUMN customers_country SET DATA TYPE VARCHAR(64);
ALTER TABLE orders ALTER COLUMN billing_country SET DATA TYPE VARCHAR(64);
ALTER TABLE orders ALTER COLUMN delivery_country SET DATA TYPE VARCHAR(64);

-- Extend the size of the products_model column to match products table
ALTER TABLE orders_products ALTER COLUMN products_model SET DATA TYPE VARCHAR(64);

-- Do not allow checkout without registration by default
UPDATE configuration SET configuration_value = 'false', configuration_description='This allows checkout without registration only when one page checkout is enabled' WHERE configuration_key = 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION';

-- Add a new panel
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_communications','Customer Communications', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 62, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 62, 1,1,1,current timestamp);

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'sendTemplateEmailToCustomers1','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductNotification','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteProductNotification','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomerForEmail','', current timestamp);

-- Number of concurrent eMail sending threads to use for sending out the newsletter
DELETE FROM configuration WHERE configuration_key = 'EMAIL_THREADS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Number of email sender threads', 'EMAIL_THREADS', '5', 'Number of concurrent threads used to send newsletter eMails', 12, 15, current timestamp);

-- Addition of custom fields to orders_products and customers_basket

ALTER TABLE orders_products ADD custom1 varchar(128);
ALTER TABLE orders_products ADD custom2 varchar(128);
ALTER TABLE orders_products ADD custom3 varchar(128);
ALTER TABLE orders_products ADD custom4 varchar(128);
ALTER TABLE orders_products ADD custom5 varchar(128);

ALTER TABLE customers_basket ADD custom1 varchar(128);
ALTER TABLE customers_basket ADD custom2 varchar(128);
ALTER TABLE customers_basket ADD custom3 varchar(128);
ALTER TABLE customers_basket ADD custom4 varchar(128);
ALTER TABLE customers_basket ADD custom5 varchar(128);

-- Customer group
DROP TABLE kk_customer_group;
CREATE TABLE kk_customer_group (
  customer_group_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  name VARCHAR(64) NOT NULL,
  description VARCHAR(128),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(customer_group_id, language_id)
);

ALTER TABLE customers ADD customers_group_id int DEFAULT -1;
ALTER TABLE promotion ADD customer_group_rule int DEFAULT 0;

DROP TABLE promotion_to_cust_group;
CREATE TABLE promotion_to_cust_group (
  promotion_id INTEGER NOT NULL,
  customers_group_id INTEGER NOT NULL,
  PRIMARY KEY(promotion_id,customers_group_id)
);

-- Addition of custom fields to customer group

ALTER TABLE kk_customer_group ADD custom1 varchar(128);
ALTER TABLE kk_customer_group ADD custom2 varchar(128);
ALTER TABLE kk_customer_group ADD custom3 varchar(128);
ALTER TABLE kk_customer_group ADD custom4 varchar(128);
ALTER TABLE kk_customer_group ADD custom5 varchar(128);

-- Addition of price_id to customer group

ALTER TABLE kk_customer_group ADD price_id int DEFAULT 0;

-- Addition of new price fields to product and order product

ALTER TABLE products ADD products_price_1 decimal(15,4);
ALTER TABLE products ADD products_price_2 decimal(15,4);
ALTER TABLE products ADD products_price_3 decimal(15,4);

ALTER TABLE orders_products ADD products_price_0 decimal(15,4);
ALTER TABLE orders_products ADD products_price_1 decimal(15,4);
ALTER TABLE orders_products ADD products_price_2 decimal(15,4);
ALTER TABLE orders_products ADD products_price_3 decimal(15,4);

ALTER TABLE products_attributes ADD options_values_price_1 decimal(15,4);
ALTER TABLE products_attributes ADD options_values_price_2 decimal(15,4);
ALTER TABLE products_attributes ADD options_values_price_3 decimal(15,4);

-- Add a new customer group panel
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custGroups','Customer Groups', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 63, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (4, 63, 1,1,1,current timestamp);

-- Address format template for address in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDRESS_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Address Format for Admin App', 'ADMIN_APP_ADDRESS_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the customers panel', 21, 0, current timestamp);

-- Add a new configuration panel
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_adminAppConfig','Configure Admin App', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 64, 1,1,1,current timestamp);

-- Config variables for Admin customer login
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_LOGIN_BASE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Base URL for logging into the App', 'ADMIN_APP_LOGIN_BASE_URL', 'https://localhost:8443/konakart/AdminLoginSubmit.do', 'Base URL for logging into the App from the Admin App', 21, 1, current timestamp);

DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_LOGIN_WINDOW_FEATURES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Window features', 'ADMIN_APP_LOGIN_WINDOW_FEATURES', 'resizable=yes,scrollbars=yes,status=yes,toolbar=yes,location=yes', 'Comma separated features for the application window opened by the login feature of the admin app', 21, 2, current timestamp);

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeCustomerGroupsFromPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCustomerGroupsToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomerGroupsPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertCustomerGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateCustomerGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteCustomerGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomerGroups','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'editOrder','', current timestamp);

-- Login integration class
DELETE FROM configuration WHERE configuration_key = 'LOGIN_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Login Integration Class', 'LOGIN_INTEGRATION_CLASS','com.konakart.bl.LoginIntegrationMgr','The Login Integration Implementation Class, to allow custom credential checking', 18, 6, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_LOGIN_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Admin Login Integration Class', 'ADMIN_LOGIN_INTEGRATION_CLASS','com.konakartadmin.bl.AdminLoginIntegrationMgr','The Login Integration Implementation Class, to allow custom credential checking for the Admin App', 18, 7, current timestamp);

-- Add two custom privileges to the Orders screen for restricting access to PackingList and Invoice buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set packing list button not shown', custom2=0, custom2_desc='If set invoice button not shown' WHERE role_id=1 and panel_id=33;
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set packing list button not shown', custom2=0, custom2_desc='If set invoice button not shown' WHERE role_id=3 and panel_id=33;

-- Config variables for Admin search definitions
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADD_WILDCARD_BEFORE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Add wildcard search before text', 'ADMIN_APP_ADD_WILDCARD_BEFORE', 'true', 'When set to true, a wildcard search character is added before the specified text', 21, 10, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADD_WILDCARD_AFTER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Add wildcard search after text', 'ADMIN_APP_ADD_WILDCARD_AFTER', 'true', 'When set to true, a wildcard search character is added after the specified text', 21, 11, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- v2.2.5.0 -------------------------------------------------------------------------------------------------------

-- Customer Panel Custom Command Definitions
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_CUSTOM_LABEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Customer Custom Button Label', 'ADMIN_APP_CUST_CUSTOM_LABEL', '', 'When this is set, a custom button appears on the customer panel with this label', 21, 20, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_CUSTOM_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Customer Custom Button URL', 'ADMIN_APP_CUST_CUSTOM_URL', 'http://www.konakart.com', 'The URL that is launched when the Customer Custom button is clicked', 21, 21, current timestamp);

-- Default Customer Panel Search Definition
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DEFAULT_CUST_CHOICE_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Default Customer Choice', 'ADMIN_APP_DEFAULT_CUST_CHOICE_IDX', '0', 'Sets the default customer choice droplist on the Customer Panel', 21, 22, 'CustomerChoices', current timestamp);

-- Default Customer Group Search Definition
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DEFAULT_CUST_GROUP_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Default Customer Group', 'ADMIN_APP_DEFAULT_CUST_GROUP_IDX', '0', 'Sets the default customer group droplist on the Customer Panel', 21, 22, 'CustomerGroups', current timestamp);

-- Add the custom3 privilege to enable/disable the customer search options on the Customer panel
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id=14;

-- Set customer type to 0 (customer) for all customers with null customer types
UPDATE customers SET customers_type=0 WHERE customers_type is null;

-- v2.2.6.0 -------------------------------------------------------------------------------------------------------

-- Add attributes for supporting bundles
ALTER TABLE products_to_products ADD products_options varchar(128);
ALTER TABLE products_to_products ADD products_quantity int;

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getBundleProductDetails','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'customSecure','', current timestamp);

-- Insert a bundle product
INSERT INTO products (products_id, products_quantity, products_model, products_image, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_type) VALUES (nextval for products_seq,0,'MSMOUSEKBBUNDLE','microsoft/bundle.gif',121.45, current timestamp,null,current timestamp,16.00,1,1,2,0,4);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,1,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','www.microsoft.com/hardware/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,2,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','www.microsoft.com/hardware/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,3,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','',0);
INSERT INTO products_to_categories VALUES (28,9);
INSERT INTO products_to_categories VALUES (28,8);
INSERT INTO products_to_products (products_to_products_id, id_from, id_to, relation_type, products_options, products_quantity) VALUES (nextval for products_to_products_seq,28,26,5,'3{8}',1);
INSERT INTO products_to_products (products_to_products_id, id_from, id_to, relation_type, products_options, products_quantity) VALUES (nextval for products_to_products_seq,28,25,5,'',1);

-- Tags

DROP TABLE kk_tag_group;
CREATE TABLE kk_tag_group (
  tag_group_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  name VARCHAR(128) NOT NULL,
  description VARCHAR(255),
  PRIMARY KEY(tag_group_id, language_id)
);

DROP TABLE kk_tag;
CREATE TABLE kk_tag (
  tag_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  name VARCHAR(128) NOT NULL,
  sort_order INTEGER DEFAULT 0,
  PRIMARY KEY(tag_id, language_id)
);

DROP TABLE kk_category_to_tag_group;
CREATE TABLE kk_category_to_tag_group (
  categories_id INTEGER NOT NULL,
  tag_group_id INTEGER NOT NULL,
  PRIMARY KEY(categories_id,tag_group_id)
);

DROP TABLE kk_tag_group_to_tag;
CREATE TABLE kk_tag_group_to_tag (
  tag_group_id INTEGER NOT NULL,
  tag_id INTEGER NOT NULL,
  PRIMARY KEY(tag_group_id,tag_id)
);

DROP TABLE kk_tag_to_product;
CREATE TABLE kk_tag_to_product (
  tag_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(tag_id,products_id)
);

-- Movie Rating Tags
DELETE FROM kk_tag;
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,1,'General Audience: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,2,'General Audience: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,3,'General Audience: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,1,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,2,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,3,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,1,'Parents Cautioned: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,2,'Parents Cautioned: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,3,'Parents Cautioned: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,1,'Restricted: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,2,'Restricted: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,3,'Restricted: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,1,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,2,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,3,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,1,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,2,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,3,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,1,'HD-DVD',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,2,'HD-DVD',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,3,'HD-DVD',1);

-- Tag group
DELETE FROM kk_tag_group;
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,1,'MPAA Movie Ratings','The MPAA rating given to each movie');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,2,'MPAA Movie Ratings','The MPAA rating given to each movie');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,3,'MPAA Movie Ratings','The MPAA rating given to each movie');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,1,'DVD Format','The format of the DVD');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,2,'DVD Format','The format of the DVD');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,3,'DVD Format','The format of the DVD');

-- Add tags to group
DELETE FROM kk_tag_group_to_tag;
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,1);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,2);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,3);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,4);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (1,5);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (2,6);
INSERT INTO kk_tag_group_to_tag (tag_group_id, tag_id)  VALUES (2,7);

-- Add tag group to category
DELETE FROM kk_category_to_tag_group;
INSERT INTO kk_category_to_tag_group (categories_id,tag_group_id)  VALUES (10,1);
INSERT INTO kk_category_to_tag_group (categories_id,tag_group_id)  VALUES (10,2);

-- Add tags to products
DELETE FROM kk_tag_to_product;
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (1,4,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (1,6,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (2,9,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (2,10,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (3,11,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (3,12,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (4,13,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (4,17,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (5,18,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,4,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,6,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,9,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (6,10,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,11,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,12,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,13,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,17,current timestamp);
INSERT INTO kk_tag_to_product (tag_id, products_id, date_added)  VALUES (7,18,current timestamp);

-- Tag API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getTags','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getTagGroups','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertTags','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertGroups','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateTagGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteTagGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getTagGroupsPerCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addTagGroupsToCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeTagGroupsFromCategory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getTagsPerProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addTagsToProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeTagsFromProduct','', current timestamp);

-- Panels for maintaining Tags
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_tagGroups','Maintain Tag Groups', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_tags','Maintain Tags', current timestamp);

-- Allow super-user to maintain tags
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 65, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 66, 1,1,1,current timestamp);

-- Allow catalog maintainer to maintain tags
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 65, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 66, 1,1,1,current timestamp);

-- Save shipping and payment module information with the order
ALTER TABLE orders ADD shipping_module_code varchar(64);
ALTER TABLE orders ADD payment_module_code varchar(64);

-- Returns Panel Custom Command Definitions
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_RETURNS_CUSTOM_LABEL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Returns Custom Button Label', 'ADMIN_APP_RETURNS_CUSTOM_LABEL', '', 'When this is set, a custom button appears on the returns panels with this label', 21, 22, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_RETURNS_CUSTOM_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Returns Custom Button URL', 'ADMIN_APP_RETURNS_CUSTOM_URL', 'http://www.konakart.com', 'The URL that is launched when the Returns Custom button is clicked', 21, 23, current timestamp);

-- Add the custom3 privilege to enable/disable custom option on the 'Returns' and 'Returns from Orders' panel
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom returns button is disabled' WHERE panel_id=46;
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom returns button is disabled' WHERE panel_id=47;

-- Panel for viewing customer from orders panel. Also allow super-user and order maintainer to have access
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customerForOrder','Customer For Order', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 67, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (3, 67, 0,0,0,current timestamp);

-- Add the custom privileges to the CustomerForOrder panel to make it the same as the Customer panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set email is disabled' WHERE panel_id=67;
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set cannot reset password' WHERE panel_id=67;
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id=67;

-- Custom Panels
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom1','Custom1', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom2','Custom2', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom3','Custom3', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom4','Custom4', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom5','Custom5', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom6','Custom6', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom7','Custom7', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom8','Custom8', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom9','Custom9', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custom10','Custom10', current timestamp);

-- Add the custom panels to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 68, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 69, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 70, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 71, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 72, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 73, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 74, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 75, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 76, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 77, 1,1,1,current timestamp);

-- Custom Panel URLs
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL1_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom1 panel', 'ADMIN_APP_CUSTOM_PANEL1_URL', 'http://www.konakart.com/?', 'The URL for Custom1 panel', 22, 0, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL2_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom2 panel', 'ADMIN_APP_CUSTOM_PANEL2_URL', 'http://www.konakart.com/?', 'The URL for Custom2 panel', 22, 1, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL3_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom3 panel', 'ADMIN_APP_CUSTOM_PANEL3_URL', 'http://www.konakart.com/?', 'The URL for Custom3 panel', 22, 2, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL4_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom4 panel', 'ADMIN_APP_CUSTOM_PANEL4_URL', 'http://www.konakart.com/?', 'The URL for Custom4 panel', 22, 3, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL5_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom5 panel', 'ADMIN_APP_CUSTOM_PANEL5_URL', 'http://www.konakart.com/?', 'The URL for Custom5 panel', 22, 4, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL6_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom6 panel', 'ADMIN_APP_CUSTOM_PANEL6_URL', 'http://www.konakart.com/?', 'The URL for Custom6 panel', 22, 5, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL7_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom7 panel', 'ADMIN_APP_CUSTOM_PANEL7_URL', 'http://www.konakart.com/?', 'The URL for Custom7 panel', 22, 6, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL8_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom8 panel', 'ADMIN_APP_CUSTOM_PANEL8_URL', 'http://www.konakart.com/?', 'The URL for Custom8 panel', 22, 7, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL9_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom9 panel', 'ADMIN_APP_CUSTOM_PANEL9_URL', 'http://www.konakart.com/?', 'The URL for Custom9 panel', 22, 8, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL10_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'URL for Custom10 panel', 'ADMIN_APP_CUSTOM_PANEL10_URL', 'http://www.konakart.com/?', 'The URL for Custom10 panel', 22, 9, current timestamp);

-- Panel for configuring custom panels
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_customConfig','Configure Custom Panels', current timestamp);

-- Add configure custom panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 78, 1,1,1,current timestamp);

-- v3.0.1.0 -------------------------------------------------------------------------------------------------------

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateCachedConfigurations','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getKonakartPropertyValue','', current timestamp);

-- Update the REPORTS_STATUS_PAGE_URL (adding the storeId parameter)
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/run?__report=reports/OrdersInLast30DaysChart.rptdesign' WHERE configuration_key = 'REPORTS_STATUS_PAGE_URL';

-- Update the reports values after moving birt-viewer to birtviewer
UPDATE configuration SET configuration_value = 'C:/KonaKart/webapps/birtviewer/reports/' WHERE configuration_key = 'REPORTS_DEFN_PATH';
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/frameset?__report=reports/' WHERE configuration_key = 'REPORTS_URL';

-- Run Initial Search on Customer Panel
DELETE FROM configuration WHERE configuration_key = 'CUST_PANEL_RUN_INITIAL_SEARCH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Run Initial Customer Search', 'CUST_PANEL_RUN_INITIAL_SEARCH', 'true', 'Set to true to always run the initial Customer Search', 21, 12, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Clear button clears results on Customer Panel
DELETE FROM configuration WHERE configuration_key = 'CUST_PANEL_CLEAR_REMOVES_RESULTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Clear button on Customer Panel removes results', 'CUST_PANEL_CLEAR_REMOVES_RESULTS', 'false', 'Set to true to clear both the search criteria AND the results when the clear button is clicked', 21, 13, 'choice(''true''=''true'',''false''=''false'')', current timestamp);


-- For DB2 Only - Increase size of Auditing Column
ALTER TABLE kk_audit ALTER COLUMN object_to_string SET DATA TYPE VARCHAR(7000);

-- Add the ENABLE_ANALYTICS config variable
DELETE FROM configuration WHERE configuration_key = 'ENABLE_ANALYTICS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Analytics', 'ENABLE_ANALYTICS', 'false', 'Enable analytics to have the analytics.code (in your Messages.properties file) inserted into the JSPs', 20, 3, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Google Data Feed
DROP TABLE kk_product_feed;
--CREATE TABLE kk_product_feed (
--  product_id int NOT NULL,
--  language_id int NOT NULL,
--  feed_type int NOT NULL,
--  feed_key varchar(255) NOT NULL,
--  last_updated datetime NOT NULL,
--  PRIMARY KEY  (product_id, language_id, feed_type)
--);

-- Google Data Feed - Google Username config variable
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ENABLED';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Google Data Enabled', 'GOOGLE_DATA_ENABLED', '', 'Set to true to enable Google Data updates when products are amended in KonaKart', '23', '1', 'choice(\'true\'=\'true\',\'false\'=\'false\')', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_API_KEY';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google API Key', 'GOOGLE_API_KEY', '', 'Google API Key (obtain from Google) for populating Google Data with Product Information', '23', '2', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_USERNAME';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google Data Username', 'GOOGLE_DATA_USERNAME', '', 'Username (obtain from Google) for populating Google Data with Product Information', '23', '3', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_PASSWORD';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES ('Google Data Password', 'GOOGLE_DATA_PASSWORD', '', 'Password (obtain from Google) for populating Google Data with Product Information', '23', '4', 'password', now());
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_LOCATION';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Store Location', 'GOOGLE_DATA_LOCATION', 'Lake Buena Vista, FL 32830, USA', 'Store location (address) to be published to Google Data', '23', '5', now());

-- Panel for configuring Data Feeds
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_dataFeeds','Configure Data Feeds', current timestamp);

-- Add configure Data Feeds to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 79, 1,1,1,current timestamp);

-- Panel for Publishing Products
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_publishProducts','Publish Products', current timestamp);

-- Add Publish Products panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 80, 1,1,1,current timestamp);

-- publishProducts API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'publishProducts','', current timestamp);

-- Solr
DELETE FROM configuration WHERE configuration_key = 'USE_SOLR_SEARCH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Use Solr Search Server','USE_SOLR_SEARCH','false','Use Solr search server to search for products',24, 10, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'SOLR_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Base URL of Solr Search Server','SOLR_URL','http://localhost:8983/','Base URL of Solr Search Server',24, 30, current timestamp);

-- New Solr API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addAllProductsToSearchEngine','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addProductToSearchEngine','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeAllProductsFromSearchEngine','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeProductFromSearchEngine','', current timestamp);

-- Configuration variable for enabling/disabling storage of credit card details
DELETE FROM configuration WHERE configuration_key = 'STORE_CC_DETAILS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Store Credit Card Details', 'STORE_CC_DETAILS', 'false', 'Store credit card details', 9, 4, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Save encrypted Credit Card details
ALTER TABLE orders ADD cc_cvv varchar(10);
ALTER TABLE orders ADD e1 varchar(100);
ALTER TABLE orders ADD e2 varchar(100);
ALTER TABLE orders ADD e3 varchar(100);
ALTER TABLE orders ADD e4 varchar(100);
ALTER TABLE orders ADD e5 varchar(100);
ALTER TABLE orders ADD e6 varchar(100);

-- Add the custom1 privilege to enable/disable the reading and editing of credit card details on the Edit Order Panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow read and edit of credit card details' WHERE panel_id=17;

-- Panel for Configuring Solr
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_solr_search','Solr Search Engine Configuration', current timestamp);

-- Add Configure Solr panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 81, 1,1,1,current timestamp);

-- Panel for Controling products in Solr
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_solr_control','Solr Search Engine Control', current timestamp);

-- Add Control Solr panel to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 82, 1,1,1,current timestamp);

-- KonaKart Application Base URL
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store Base URL', 'KK_BASE_URL', 'http://localhost:8780/konakart/', 'KonaKart Base URL', 1, 25, current timestamp);

-- v3.2.0.0 -------------------------------------------------------------------------------------------------------

-- API call for inserting a configuration group
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertConfigurationGroup','', current timestamp);

-- Column for storing store_id on all tables
ALTER TABLE address_book ADD store_id varchar(64);
CREATE INDEX i_st_ce2c90a44e2d3 ON address_book (store_id);

ALTER TABLE address_format ADD store_id varchar(64);
CREATE INDEX i_st_b934af097bd19 ON address_format (store_id);

ALTER TABLE banners ADD store_id varchar(64);
CREATE INDEX i_store_id_banners ON banners (store_id);

ALTER TABLE banners_history ADD store_id varchar(64);
CREATE INDEX i_st_e5cc24af5ed10 ON banners_history (store_id);

ALTER TABLE categories ADD store_id varchar(64);
CREATE INDEX i_st_727041564dd58 ON categories (store_id);

ALTER TABLE categories_description ADD store_id varchar(64);
CREATE INDEX i_st_ba9939845d7f5 ON categories_description (store_id);

ALTER TABLE configuration ADD store_id varchar(64);
CREATE INDEX i_st_c9f557d8573ac ON configuration (store_id);

ALTER TABLE configuration_group ADD store_id varchar(64);
CREATE INDEX i_st_c5b88f9839871 ON configuration_group (store_id);

ALTER TABLE counter ADD store_id varchar(64);
CREATE INDEX i_store_id_counter ON counter (store_id);

ALTER TABLE counter_history ADD store_id varchar(64);
CREATE INDEX i_st_c4896bdc929da ON counter_history (store_id);

ALTER TABLE countries ADD store_id varchar(64);
CREATE INDEX i_st_377c476a6302e ON countries (store_id);

ALTER TABLE coupon ADD store_id varchar(64);
CREATE INDEX i_store_id_coupon ON coupon (store_id);

ALTER TABLE currencies ADD store_id varchar(64);
CREATE INDEX i_st_72705adb72fb2 ON currencies (store_id);

ALTER TABLE customers ADD store_id varchar(64);
CREATE INDEX i_st_377c4b1a3685e ON customers (store_id);

ALTER TABLE customers_basket ADD store_id varchar(64);
CREATE INDEX i_st_ad910311c2a1a ON customers_basket (store_id);

ALTER TABLE customers_basket_attrs ADD store_id varchar(64);
CREATE INDEX i_st_1c2b890aa8950 ON customers_basket_attrs (store_id);

ALTER TABLE customers_info ADD store_id varchar(64);
CREATE INDEX i_st_975087a4922d9 ON customers_info (store_id);

ALTER TABLE geo_zones ADD store_id varchar(64);
CREATE INDEX i_st_377c92f4d1fd7 ON geo_zones (store_id);

ALTER TABLE ipn_history ADD store_id varchar(64);
CREATE INDEX i_st_c09b83295fef0 ON ipn_history (store_id);

ALTER TABLE kk_audit ADD store_id varchar(64);
CREATE INDEX i_st_1ae73a4c85e51 ON kk_audit (store_id);

ALTER TABLE kk_category_to_tag_group ADD store_id varchar(64);
CREATE INDEX i_st_81a7f11b10741 ON kk_category_to_tag_group (store_id);

ALTER TABLE kk_customer_group ADD store_id varchar(64);
CREATE INDEX i_st_502a449ee1bb8 ON kk_customer_group (store_id);

ALTER TABLE kk_digital_download ADD store_id varchar(64);
CREATE INDEX i_st_f65dd12eafb1d ON kk_digital_download (store_id);

--ALTER TABLE kk_product_feed ADD COLUMN store_id varchar(64);
--ALTER TABLE kk_product_feed ADD KEY idx_store_id (store_id);

ALTER TABLE kk_role_to_api_call ADD store_id varchar(64);
CREATE INDEX i_st_662e42296d8dd ON kk_role_to_api_call (store_id);

ALTER TABLE kk_role_to_panel ADD store_id varchar(64);
CREATE INDEX i_st_8f9075d70f10a ON kk_role_to_panel (store_id);

ALTER TABLE kk_tag ADD store_id varchar(64);
CREATE INDEX i_store_id_kk_tag ON kk_tag (store_id);

ALTER TABLE kk_tag_group ADD store_id varchar(64);
CREATE INDEX i_st_d555747f372c1 ON kk_tag_group (store_id);

ALTER TABLE kk_tag_group_to_tag ADD store_id varchar(64);
CREATE INDEX i_st_104b101ee92dd ON kk_tag_group_to_tag (store_id);

ALTER TABLE kk_tag_to_product ADD store_id varchar(64);
CREATE INDEX i_st_319feeb16818d ON kk_tag_to_product (store_id);

ALTER TABLE languages ADD store_id varchar(64);
CREATE INDEX i_st_377cf6ca7d37b ON languages (store_id);

ALTER TABLE manufacturers ADD store_id varchar(64);
CREATE INDEX i_st_a79d46cbb5bb0 ON manufacturers (store_id);

ALTER TABLE manufacturers_info ADD store_id varchar(64);
CREATE INDEX i_st_160827a094b13 ON manufacturers_info (store_id);

ALTER TABLE newsletters ADD store_id varchar(64);
CREATE INDEX i_st_c0b4f3f286753 ON newsletters (store_id);

ALTER TABLE orders ADD store_id varchar(64);
CREATE INDEX i_store_id_orders ON orders (store_id);

ALTER TABLE orders_products ADD store_id varchar(64);
CREATE INDEX i_st_b83369b4358d1 ON orders_products (store_id);

ALTER TABLE orders_products_attributes ADD store_id varchar(64);
CREATE INDEX i_st_71ef5930e3470 ON orders_products_attributes (store_id);

ALTER TABLE orders_products_download ADD store_id varchar(64);
CREATE INDEX i_st_40c0476bcaeec ON orders_products_download (store_id);

ALTER TABLE orders_returns ADD store_id varchar(64);
CREATE INDEX i_st_1518d4a8dabbd ON orders_returns (store_id);

ALTER TABLE orders_status ADD store_id varchar(64);
CREATE INDEX i_st_e19be769fa772 ON orders_status (store_id);

ALTER TABLE orders_status_history ADD store_id varchar(64);
CREATE INDEX i_st_bdbf4e4395486 ON orders_status_history (store_id);

ALTER TABLE orders_total ADD store_id varchar(64);
CREATE INDEX i_st_d84a8ae42e705 ON orders_total (store_id);

ALTER TABLE products ADD store_id varchar(64);
CREATE INDEX i_st_1ae76e2a2f877 ON products (store_id);

ALTER TABLE products_attributes ADD store_id varchar(64);
CREATE INDEX i_st_390f139aa7407 ON products_attributes (store_id);

ALTER TABLE products_description ADD store_id varchar(64);
CREATE INDEX i_st_5aff5ecf5b342 ON products_description (store_id);

ALTER TABLE products_notifications ADD store_id varchar(64);
CREATE INDEX i_st_6d3a37d0fa913 ON products_notifications (store_id);

ALTER TABLE products_options ADD store_id varchar(64);
CREATE INDEX i_st_c7728fd5b236a ON products_options (store_id);

ALTER TABLE products_options_values ADD store_id varchar(64);
CREATE INDEX i_st_f445bd0d2878f ON products_options_values (store_id);

ALTER TABLE prod_opt_vals_to_prod_opt ADD store_id varchar(64);
CREATE INDEX i_st_e4b3f01a8da33 ON prod_opt_vals_to_prod_opt (store_id);

ALTER TABLE products_quantity ADD store_id varchar(64);
CREATE INDEX i_st_b5c48aa1267d0 ON products_quantity (store_id);

--ALTER TABLE products_to_categories ADD COLUMN store_id varchar(64);
--ALTER TABLE products_to_categories ADD KEY idx_store_id (store_id);

ALTER TABLE products_to_products ADD store_id varchar(64);
CREATE INDEX i_st_5b57fb3fcc2e6 ON products_to_products (store_id);

ALTER TABLE promotion ADD store_id varchar(64);
CREATE INDEX i_st_377d53384bb74 ON promotion (store_id);

ALTER TABLE promotion_to_category ADD store_id varchar(64);
CREATE INDEX i_st_bd57fc9bf6947 ON promotion_to_category (store_id);

ALTER TABLE promotion_to_coupon ADD store_id varchar(64);
CREATE INDEX i_st_d4eb64d86b3d3 ON promotion_to_coupon (store_id);

ALTER TABLE promotion_to_cust_group ADD store_id varchar(64);
CREATE INDEX i_st_7349ad038a82a ON promotion_to_cust_group (store_id);

ALTER TABLE promotion_to_customer ADD store_id varchar(64);
CREATE INDEX i_st_bd57fca1f8dfd ON promotion_to_customer (store_id);

ALTER TABLE promotion_to_manufacturer ADD store_id varchar(64);
CREATE INDEX i_st_72fef51299910 ON promotion_to_manufacturer (store_id);

ALTER TABLE promotion_to_product ADD store_id varchar(64);
CREATE INDEX i_st_7257ffe9c2258 ON promotion_to_product (store_id);

ALTER TABLE returns_to_ord_prods ADD store_id varchar(64);
CREATE INDEX i_st_3a4997bc2fb02 ON returns_to_ord_prods (store_id);

ALTER TABLE reviews ADD store_id varchar(64);
CREATE INDEX i_store_id_reviews ON reviews (store_id);

ALTER TABLE reviews_description ADD store_id varchar(64);
CREATE INDEX i_st_acfcbefb041a9 ON reviews_description (store_id);

--ALTER TABLE sessions ADD COLUMN store_id varchar(64);
--ALTER TABLE sessions ADD KEY idx_store_id (store_id);

ALTER TABLE specials ADD store_id varchar(64);
CREATE INDEX i_st_1ae78b3d943fb ON specials (store_id);

ALTER TABLE tax_class ADD store_id varchar(64);
CREATE INDEX i_st_377d9ab399455 ON tax_class (store_id);

ALTER TABLE tax_rates ADD store_id varchar(64);
CREATE INDEX i_st_377d9ab3a9e0b ON tax_rates (store_id);

--ALTER TABLE utility ADD COLUMN store_id varchar(64);
--ALTER TABLE utility ADD KEY idx_store_id (store_id);

ALTER TABLE whos_online ADD store_id varchar(64);
CREATE INDEX i_st_c0e660ffcd215 ON whos_online (store_id);

ALTER TABLE zones ADD store_id varchar(64);
CREATE INDEX i_store_id_zones ON zones (store_id);

ALTER TABLE zones_to_geo_zones ADD store_id varchar(64);
CREATE INDEX i_st_7533c0361a37a ON zones_to_geo_zones (store_id);

-- kk_store table for holding store instance information for multi-store
DROP TABLE kk_store;
CREATE TABLE kk_store (
  store_id VARCHAR(64) NOT NULL,
  store_name VARCHAR(64) NOT NULL,
  store_desc VARCHAR(128) NOT NULL,
  store_enabled INTEGER NOT NULL,
  store_under_maint INTEGER NOT NULL,
  store_deleted INTEGER NOT NULL,
  store_template INTEGER NOT NULL,
  store_admin_email VARCHAR(96),
  store_css_filename VARCHAR(128),
  store_logo_filename VARCHAR(128),
  store_url VARCHAR(128),
  store_home VARCHAR(64),
  store_max_products INTEGER DEFAULT -1 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP,
  last_updated TIMESTAMP,
  PRIMARY KEY(store_id)
);

INSERT INTO kk_store (store_id, store_name, store_desc, store_enabled, store_under_maint, store_deleted, store_template, store_admin_email, store_logo_filename, store_css_filename, store_home, date_added) VALUES ('store1','store1','Store Number One', 1,0,0,0, 'admin@konakart.com', 'logo.png', 'style.css', 'derby', current timestamp);

-- MultiStore Template StoreId
DELETE FROM configuration WHERE configuration_key = 'MULTISTORE_TEMPLATE_STORE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Multi-Store Template Store', 'MULTISTORE_TEMPLATE_STORE', 'store1', 'This is the storeId of the template store used when creating new stores in a multi-store installation', 25, 5, current timestamp);

-- MultiStore Admin Role
DELETE FROM configuration WHERE configuration_key = 'MULTISTORE_ADMIN_ROLE_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Multi-Store Admin Role', 'MULTISTORE_ADMIN_ROLE_IDX', '5', 'Defines the Role given to Admin users of new stores', 25, 6, 'Roles', current timestamp);

-- MultiStore Super User Role
DELETE FROM configuration WHERE configuration_key = 'MULTISTORE_SUPER_USER_ROLE_IDX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Multi-Store Super User Role', 'MULTISTORE_SUPER_USER_ROLE_IDX', '1', 'Defines the Role given to Super User user of new stores', 25, 6, 'Roles', current timestamp);

-- Filenames for new store sql
DELETE FROM configuration WHERE configuration_key = 'KK_NEW_STORE_SQL_FILENAME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'KonaKart new store creation SQL','KK_NEW_STORE_SQL_FILENAME','C:/KonaKart/database/MySQL/konakart_new_store.sql','Filename containing the KonaKart new store creation SQL commands',25, 10, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'USER_NEW_STORE_SQL_FILENAME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'User new store creation SQL','USER_NEW_STORE_SQL_FILENAME','C:/KonaKart/database/MySQL/konakart_user_new_store.sql','Filename containing the user defined new store creation SQL commands - these are executed after the KonaKart cloning commands',25, 11, current timestamp);

-- Table for wish list
DROP TABLE kk_wishlist;
CREATE TABLE kk_wishlist (
  kk_wishlist_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  customers_id INTEGER NOT NULL,
  name VARCHAR(128),
  description VARCHAR(255),
  public_or_private INTEGER NOT NULL,
  date_added TIMESTAMP NOT NULL,
  customers_firstname VARCHAR(32),
  customers_lastname VARCHAR(32),
  customers_dob TIMESTAMP,
  customers_city VARCHAR(32),
  customers_state VARCHAR(32),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  PRIMARY KEY(kk_wishlist_id)
);
DROP SEQUENCE kk_wishlist_SEQ;
CREATE SEQUENCE kk_wishlist_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Table for wish list items
DROP TABLE kk_wishlist_item;
CREATE TABLE kk_wishlist_item (
  kk_wishlist_item_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  kk_wishlist_id INTEGER NOT NULL,
  products_id VARCHAR(255) NOT NULL,
  priority int,
  date_added TIMESTAMP NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  PRIMARY KEY(kk_wishlist_item_id)
);
DROP SEQUENCE kk_wishlist_item_SEQ;
CREATE SEQUENCE kk_wishlist_item_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Enable / Disable wish list functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_WISHLIST';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Wish List functionality', 'ENABLE_WISHLIST', 'false', 'When set to true, wish list functionality is enabled in the application', 1, 24, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Add column to orders table for order number
ALTER TABLE orders ADD orders_number varchar(128);

-- Orders Panel Show Order Number or Order Id
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ORDERS_DISPLAY_ORDER_NUM';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Order Number', 'ADMIN_APP_ORDERS_DISPLAY_ORDER_NUM', '', 'When this is set, the order number is displayed in the orders panel rather than the order id', 21, 24, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Enable all customers
UPDATE customers SET customers_enabled = 1;

-- Panels for Managing Stores in a Multi-Store Environment
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_stores','Manage Multiple Stores', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_editStore','Edit a Store in a Mall', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_insertStore','Insert a Store in a Mall', current timestamp);
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_multistoreConfig','Multi-Store Configuration', current timestamp);

-- Add MultiStore Management Panels to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added) VALUES (1, 83, 1,1,1,1, 'Set to allow admin of all stores', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 84, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 85, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 86, 1,1,1,current timestamp);

-- API calls for Multi-Store Store Maintenance
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getMallStores','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertMallStore','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'deleteMallStore','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateMallStore','', current timestamp);

-- Add language code to products_description
ALTER TABLE products_description ADD language_code char(2);

UPDATE products_description SET language_code = 'en' WHERE language_id = 1;
UPDATE products_description SET language_code = 'de' WHERE language_id = 2;
UPDATE products_description SET language_code = 'es' WHERE language_id = 3;

-- Admin Store Integration Class
DELETE FROM configuration WHERE configuration_key = 'ADMIN_STORE_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Admin Store Integration Class', 'ADMIN_STORE_INTEGRATION_CLASS','com.konakartadmin.bl.AdminStoreIntegrationMgr','The Store Integration Implementation Class, to allow custom store maintenance function', 25, 7, current timestamp);

-- Add super_user and 5 custom fields to kk_role
ALTER TABLE kk_role ADD super_user INTEGER;
ALTER TABLE kk_role ADD custom1 varchar(128);
ALTER TABLE kk_role ADD custom2 varchar(128);
ALTER TABLE kk_role ADD custom3 varchar(128);
ALTER TABLE kk_role ADD custom4 varchar(128);
ALTER TABLE kk_role ADD custom5 varchar(128);
UPDATE kk_role SET super_user = 1 WHERE name = 'Super User';

-- Copy all the Super User role (role 1) permissions over to the Store Administrator role (role 5)
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, custom2, custom2_desc, custom3, custom3_desc, date_added) select 5, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, custom2, custom2_desc, custom3, custom3_desc, current timestamp from kk_role_to_panel WHERE role_id = 1;

-- Take off the permissions that the Store Administrator role should not have
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 1;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 6;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 8;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 11;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 20;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 21;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 26;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 28;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 32;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 54;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 55;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 56;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 57;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 58;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 59;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 60;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 63;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 85;
DELETE FROM kk_role_to_panel WHERE role_id = 5 and panel_id = 86;

-- Give Store Administrator Read-Only / special access to these:
UPDATE kk_role_to_panel SET can_insert = 0, can_delete = 0, custom1 = 0 WHERE role_id = 5 and panel_id = 83;
UPDATE kk_role_to_panel SET can_edit=0, can_insert=0, can_delete=0 WHERE role_id = 5 and panel_id = 12;
UPDATE kk_role_to_panel SET can_edit=0, can_insert=0, can_delete=0 WHERE role_id = 5 and panel_id = 14;

-- Reports re-located for MultiStore
UPDATE configuration SET configuration_value = 'C:/KonaKart/webapps/birtviewer/reports/stores/store1/' WHERE configuration_key = 'REPORTS_DEFN_PATH';
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/frameset?__report=reports/stores/store1/' WHERE configuration_key = 'REPORTS_URL';
UPDATE configuration SET configuration_value = 'http://localhost:8780/birtviewer/run?__report=reports/stores/store1/OrdersInLast25DaysChart.rptdesign' WHERE configuration_key = 'REPORTS_STATUS_PAGE_URL';

-- Add the custom1 privilege to enable/disable the reading and editing of custom fields and order number on the Edit Order Panel
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='Set to allow read and edit of custom fields and order number' WHERE panel_id=17;

-- KonaKart Home Directory
DELETE FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'KonaKart Installation Home', 'INSTALLATION_HOME','C:/KonaKart/','The home directory of this KonaKart Installation', 1, 26, current timestamp);

-- Version 4.0.0.0 ---------------------------------------------------------------------

-- Add Custom fields for zones table
ALTER TABLE zones ADD custom1 varchar(128);
ALTER TABLE zones ADD custom2 varchar(128);
ALTER TABLE zones ADD custom3 varchar(128);

-- Configuration for product select panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_SEL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Product Select Template' , 'ADMIN_APP_PROD_SEL_TEMPLATE', '$name', 'Sets the template for which attributes to view when selecting a product ($name, $sku, $id, $model, $manufacturer, $custom1 ... $custom5', 21, 25, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_SEL_NUM_PRODS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Product Select Default Num Prods', 'ADMIN_APP_PROD_SEL_NUM_PRODS', '0', 'Sets the default number of products displayed in the product select dialogs when opened', 21, 26, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_SEL_MAX_NUM_PRODS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Product Select Max Num Prods', 'ADMIN_APP_PROD_SEL_MAX_NUM_PRODS', '100', 'Sets the maximum number of products displayed in the product select dialogs after a search', 21, 27, current timestamp);

-- Add date available attribute to products quantity
ALTER TABLE products_quantity ADD products_date_available TIMESTAMP;

-- API calls for setting product quantity and product availability
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'setProductQuantity','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'setProductAvailability','', current timestamp);

-- Extra attributes for product object
ALTER TABLE products ADD max_num_downloads int default -1 not null;
ALTER TABLE products ADD max_download_days int default -1 not null;
ALTER TABLE products ADD stock_reorder_level int default -1 not null;

-- Cookie table to save cookie information
DROP TABLE kk_cookie;
CREATE TABLE kk_cookie (
  customer_uuid VARCHAR(128) NOT NULL,
  attribute_id VARCHAR(64) NOT NULL,
  attribute_value VARCHAR(256),
  date_added TIMESTAMP NOT NULL,
  last_read TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(customer_uuid, attribute_id)
);

-- Add tracking number to orders table
ALTER TABLE orders ADD tracking_number varchar(128);

-- Update description of role to panel
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='Set to allow read and edit of custom fields, order number, tracking number' WHERE panel_id=17;

-- Extra attribute for product object
ALTER TABLE products ADD can_order_when_not_in_stock int default -1 NOT NULL;

-- Add invisible attribute to categories table
ALTER TABLE categories ADD categories_invisible INTEGER DEFAULT 0 NOT NULL;

-- API calls for getting product quantity and product availability
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductQuantity','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductAvailability','', current timestamp);

-- Add a new panel for inserting product quantities
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_productQuantity','Product Quantity', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 87, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 87, 1,1,1,current timestamp);

-- API calls for XML import/export
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertTagGroupToTags','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getTagGroupToTags','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'importCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductNotificationsForCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductOptionsPerName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllProductOptionValues','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductOptionValuesPerName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductsOptionsValuesToProductsOptions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductOptionValueToProductOptions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllConfigurations','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getAllConfigurationGroups','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateConfiguration','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'updateConfigurationGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getConfigurationGroupsByTitle','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getConfigurationByKey','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertConfiguration','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertConfigurationGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertIpnHistory','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'importAudit','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCategoriesPerTagGroup','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCategoriesToTagGroups','', current timestamp);

-- Add a new panel for inserting product available dates
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_productAvailableDate','Product Available Date', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 88, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 88, 1,1,1,current timestamp);

-- Extra attributes for order product and basket objects
ALTER TABLE orders_products ADD products_state int DEFAULT 0;
ALTER TABLE orders_products ADD products_sku varchar(255);
ALTER TABLE customers_basket ADD products_sku varchar(255);

-- Add customer_id to sessions table - previously the customer_id was stored in the value column.  We also make value nullable.
-- For various reasons, mainly DB2 limitations, we drop the sessions table and recreate it
--DROP TABLE sessions;
--CREATE TABLE sessions (
--  sesskey varchar(32) NOT NULL,
--  expiry int(11) unsigned NOT NULL,
--  customer_id int NULL,
--  value varchar(256) NULL,
--  store_id varchar(64) NULL,
--  custom1 varchar(128) NULL,
--  custom2 varchar(128) NULL,
--  custom3 varchar(128) NULL,
--  custom4 varchar(128) NULL,
--  custom5 varchar(128) NULL,
--  PRIMARY KEY (sesskey)
--);
--ALTER TABLE sessions ADD KEY idx_store_id (store_id);

-- Determine whether to show dialog to send mail after a group change
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ALLOW_GROUP_CHANGE_MAIL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow Cust Group Change eMail', 'ADMIN_APP_ALLOW_GROUP_CHANGE_MAIL', 'true', 'When this is set, a popup window appears when the group of a customer is changed to allow you to send an eMail', 21, 28, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Admin App session related API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'addCustomDataToSession','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCustomDataFromSession','', current timestamp);

-- New Batch jobs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'com.konakartadmin.bl.AdminOrderBatchMgr.productAvailabilityNotificationBatch','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'com.konakartadmin.bl.AdminOrderBatchMgr.unpaidOrderNotificationBatch','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'com.konakartadmin.bl.AdminCustomerBatchMgr.removeExpiredCustomersBatch','', current timestamp);

-- Version 4.1.0.0 ---------------------------------------------------------------------

-- Product to stores
DROP TABLE kk_product_to_stores;
CREATE TABLE kk_product_to_stores (
  store_id VARCHAR(64) NOT NULL,
  products_id INTEGER NOT NULL,
  price_id INTEGER DEFAULT -1 NOT NULL,
  PRIMARY KEY(store_id ,products_id)
);

-- New Multi-Store Shared Products APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getProductsToStores','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertProductsToStores','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'removeProductsToStores','', current timestamp);

-- New Categories to Tag Groups API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'getCategoriesToTagGroups','', current timestamp);

-- Modifications for gift registry support
ALTER TABLE customers_basket ADD kk_wishlist_id int;
ALTER TABLE orders_products ADD kk_wishlist_id int;
ALTER TABLE customers_basket ADD kk_wishlist_item_id int;
ALTER TABLE orders_products ADD kk_wishlist_item_id int;

ALTER TABLE kk_wishlist ADD customers1_firstname varchar(32);
ALTER TABLE kk_wishlist ADD customers1_lastname varchar(32);
ALTER TABLE kk_wishlist ADD link_url varchar(255);
ALTER TABLE kk_wishlist ADD list_type int;
ALTER TABLE kk_wishlist ADD address_id int;
ALTER TABLE kk_wishlist ADD event_date TIMESTAMP;

ALTER TABLE kk_wishlist_item ADD quantity_desired int;
ALTER TABLE kk_wishlist_item ADD quantity_bought int;
ALTER TABLE kk_wishlist_item ADD comments varchar(255);

-- Enable / Disable gift registry functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_GIFT_REGISTRY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Gift Registry functionality', 'ENABLE_GIFT_REGISTRY', 'false', 'When set to true, gift registry functionality is enabled in the application', 1, 26, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Maximum number of gift registries displayed in a search
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_GIFT_REGISTRIES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Gift Registry Search', 'MAX_DISPLAY_GIFT_REGISTRIES', '6', 'Maximum number of gift registries to display', 3, 24, 'integer(0,null)', current timestamp);

-- New Insert Order API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq,  'insertOrder','', current timestamp);

-- Version 4.2.0.0 ---------------------------------------------------------------------

-- API call for forcing registration of admin users even if already registered - delete and re-insert (it may or may not be present)
DELETE FROM kk_role_to_api_call WHERE api_call_id in (select api_call_id from kk_api_call WHERE name='forceRegisterCustomer');
DELETE FROM kk_api_call WHERE name = 'forceRegisterCustomer';
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'forceRegisterCustomer','', current timestamp);

-- Extra attribute for product object
ALTER TABLE products ADD index_attachment int default 0 not null;

-- Maximum number of gift registry items displayed
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_GIFT_REGISTRY_ITEMS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Gift Registry Items', 'MAX_DISPLAY_GIFT_REGISTRY_ITEMS', '20', 'Maximum number of gift registry items to display', 3, 25, 'integer(0,null)', current timestamp);

-- WishList APIs for the Admin App... used by the XML_IO utility
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getWishLists','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertWishList','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteWishList','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertWishListItem','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteWishListItem','', current timestamp);

-- Tables for CustomerTags
DROP TABLE kk_customer_tag;
CREATE TABLE kk_customer_tag (
  kk_customer_tag_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255) NOT NULL,
  validation VARCHAR(128),
  tag_type integer DEFAULT 0 NOT NULL,
  max_ints integer DEFAULT 1,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_customer_tag_id)
   );
DROP SEQUENCE kk_customer_tag_SEQ;
CREATE SEQUENCE kk_customer_tag_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE kk_customers_to_tag;
CREATE TABLE kk_customers_to_tag (
  kk_customer_tag_id INTEGER DEFAULT 0 NOT NULL,
  customers_id INTEGER DEFAULT 0 NOT NULL,
  store_id VARCHAR(64),
  name VARCHAR(64) NOT NULL,
  tag_value VARCHAR(255),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_customer_tag_id, customers_id)
);

-- AdminApp CustomerTag API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCustomerTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCustomerTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateCustomerTag','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerTags','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCustomerTagForCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerTagForCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerTagForName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerTagsForCustomer','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCustomerTagForCustomer','', current timestamp);

-- Admin Engine Address API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAddressById','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAddresses','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertAddress','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateAddress','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteAddress','', current timestamp);

-- Add a new panel for managing customer tags
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_custTags','Customer Tags', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 89, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 89, 1,1,1,current timestamp);

-- Email Integration Class
DELETE FROM configuration WHERE configuration_key = 'EMAIL_INTEGRATION_CLASS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Email Integration Class', 'EMAIL_INTEGRATION_CLASS', 'com.konakart.bl.EmailIntegrationMgr', 'The Email Integration Implementation Class to enable you to change the toAddress of the mail', 12, 16, current timestamp);

-- Tables for Expressions
DROP TABLE kk_expression;
CREATE TABLE kk_expression (
  kk_expression_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255),
  num_variables integer DEFAULT 0 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_expression_id)
   );
DROP SEQUENCE kk_expression_SEQ;
CREATE SEQUENCE kk_expression_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE kk_expression_variable;
CREATE TABLE kk_expression_variable (
  kk_expression_variable_id INTEGER NOT NULL,
  kk_customer_tag_id INTEGER DEFAULT 0 NOT NULL,
  kk_expression_id INTEGER DEFAULT 0 NOT NULL,
  store_id VARCHAR(64),
  tag_type integer DEFAULT 0 NOT NULL,
  tag_value VARCHAR(255) NOT NULL,
  operator integer DEFAULT 0 NOT NULL,
  tag_order integer DEFAULT 0 NOT NULL,
  tag_and_or integer DEFAULT 0 NOT NULL,
  group_order integer DEFAULT 0 NOT NULL,
  group_and_or integer DEFAULT 0 NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_expression_variable_id)
   );
DROP SEQUENCE kk_expression_variable_SEQ;
CREATE SEQUENCE kk_expression_variable_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- AdminApp Expression API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertExpression','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateExpression','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteExpression','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getExpression','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getExpressions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getExpressionVariable','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getExpressionVariablesForExpression','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getExpressionForName','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertExpressionVariables','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateExpressionVariable','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteExpressionVariable','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteExpressionVariablesForExpression','', current timestamp);

-- Add new panels for managing expressions
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_expressions','Expressions', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 90, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 90, 1,1,1,current timestamp);

INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_variablesFromExp','Expression Variables', current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 91, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (2, 91, 1,1,1,current timestamp);

-- Connect the promotion to expressions
DROP TABLE kk_promotion_to_expression;
CREATE TABLE kk_promotion_to_expression (
  promotion_id INTEGER NOT NULL,
  kk_expression_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  PRIMARY KEY(promotion_id,kk_expression_id)
);

-----------------------------------------------------------------------------------------------------------------------------
-- Add Portuguese
INSERT INTO languages VALUES (nextval for languages_seq,'Portugu??s','pt','icon.gif','portuguese',4, null);

-- Category Descriptions
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 1, 4, 'Hardware');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 2, 4, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 3, 4, 'DVD Filmes');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 4, 4, 'Placas Gr??ficas');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 5, 4, 'Impressoras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 6, 4, 'Monitores');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 7, 4, 'Altavoces');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 8, 4, 'Teclados');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 9, 4, 'Ratones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 10, 4, 'Accion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 11, 4, 'Ciencia Ficcion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 12, 4, 'Comedia');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 13, 4, 'Dibujos Animados');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 14, 4, 'Suspense');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 15, 4, 'Drama');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 16, 4, 'Memoria');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 17, 4, 'Unidades CDROM');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 18, 4, 'Simulacion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 19, 4, 'Accion');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 20, 4, 'Estrategia');

-- Tags
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (1,4,'Audi??ncia Geral: G',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (2,4,'Parental Guidance: PG',1);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (3,4,'Pais Advertido: PG-13',2);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (4,4,'Restrito: R',3);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (5,4,'Adults Only: NC-17',4);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (6,4,'Blu-ray',0);
INSERT INTO kk_tag (tag_id, language_id, name, sort_order)  VALUES (7,4,'HD-DVD',1);

-- Tag groups
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (1,4,'Avalia????es MPAA Movie','A MPAA rating dado a cada filme');
INSERT INTO kk_tag_group (tag_group_id, language_id, name, description)  VALUES (2,4,'Formato DVD','O formato do DVD');

-- Manfacturer's Info
INSERT INTO manufacturers_info VALUES (1, 4, 'http://www.matrox.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (2, 4, 'http://www.microsoft.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (3, 4, 'http://www.warner.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (4, 4, 'http://www.fox.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (5, 4, 'http://www.logitech.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (6, 4, 'http://www.canon.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (7, 4, 'http://www.sierra.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (8, 4, 'http://www.infogrames.com', 0, null, null);
INSERT INTO manufacturers_info VALUES (9, 4, 'http://www.hewlettpackard.com', 0, null, null);

-- Order Statuses
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (1,4,'Pendente');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (2,4,'Processamento');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (3,4,'Entregue');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (4,4,'?? espera de pagamento');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (5,4,'Pagamento Recebido');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (6,4,'Pagamento recusado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (7,4,'Parcialmente entregue');

-- Product Descriptions
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (1,4,'Matrox G200 MMS','(pt) Reinforcing its position as a multi-monitor trailblazer, Matrox Graphics Inc. has once again developed the most flexible and highly advanced solution in the industry. Introducing the new Matrox G200 Multi-Monitor Series; the first graphics card ever to support up to four DVI digital flat panel displays on a single 8\&quot; PCI board.<br><br>With continuing demand for digital flat panels in the financial workplace, the Matrox G200 MMS is the ultimate in flexible solutions. The Matrox G200 MMS also supports the new digital video interface (DVI) created by the Digital Display Working Group (DDWG) designed to ease the adoption of digital flat panels. Other configurations include composite video capture ability and onboard TV tuner, making the Matrox G200 MMS the complete solution for business needs.<br><br>Based on the award-winning MGA-G200 graphics chip, the Matrox G200 Multi-Monitor Series provides superior 2D/3D graphics acceleration to meet the demanding needs of business applications such as real-time stock quotes (Versus), live video feeds (Reuters \& Bloombergs), multiple windows applications, word processing, spreadsheets and CAD.','www.matrox.com/mga/products/g200_mms/home.cfm',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (2,4,'Matrox G400 32MB','(pt) <b>Dramatically Different High Performance Graphics</b><br><br>Introducing the Millennium G400 Series - a dramatically different, high performance graphics experience. Armed with the industry''s fastest graphics chip, the Millennium G400 Series takes explosive acceleration two steps further by adding unprecedented image quality, along with the most versatile display options for all your 3D, 2D and DVD applications. As the most powerful and innovative tools in your PC''s arsenal, the Millennium G400 Series will not only change the way you see graphics, but will revolutionize the way you use your computer.<br><br><b>Key features:</b><ul><li>New Matrox G400 256-bit DualBus graphics chip</li><li>Explosive 3D, 2D and DVD performance</li><li>DualHead Display</li><li>Superior DVD and TV output</li><li>3D Environment-Mapped Bump Mapping</li><li>Vibrant Color Quality rendering </li><li>UltraSharp DAC of up to 360 MHz</li><li>3D Rendering Array Processor</li><li>Support for 16 or 32 MB of memory</li></ul>','www.matrox.com/mga/products/mill_g400/home.htm',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (3,4,'Microsoft IntelliMouse Pro','(pt) Every element of IntelliMouse Pro - from its unique arched shape to the texture of the rubber grip around its base - is the product of extensive customer and ergonomic research. Microsoft''s popular wheel control, which now allows zooming and universal scrolling functions, gives IntelliMouse Pro outstanding comfort and efficiency.','www.microsoft.com/hardware/mouse/intellimouse.asp',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (4,4,'The Replacement Killers','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 80 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.replacement-killers.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (5,4,'Blade Runner - Director''s Cut','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br>Languages: English, Deutsch.<br>Subtitles: English, Deutsch, Spanish.<br>Audio: Dolby Surround 5.1.<br>Picture Format: 16:9 Wide-Screen.<br>Length: (approx) 112 minutes.<br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.bladerunner.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (6,4,'The Matrix','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch.<br><br>Audio: Dolby Surround.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 131 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Making Of.','www.thematrix.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (7,4,'You''ve Got Mail','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch, Spanish.<br><br>Subtitles: English, Deutsch, Spanish, French, Nordic, Polish.<br><br>Audio: Dolby Digital 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.youvegotmail.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (8,4,'A Bug''s Life','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Digital 5.1 / Dobly Surround Stereo.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 91 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','www.abugslife.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (9,4,'Under Siege','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (10,4,'Under Siege 2 - Dark Territory','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 98 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (11,4,'Fire Down Below','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (12,4,'Die Hard With A Vengeance','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 122 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (13,4,'Lethal Weapon','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 100 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (14,4,'Red Corner','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 117 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (15,4,'Frantic','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 115 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (16,4,'Courage Under Fire','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (17,4,'Speed','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 112 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (18,4,'Speed 2: Cruise Control','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 120 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (19,4,'There''s Something About Mary','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 114 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (20,4,'Beloved','(pt) Regional Code: 2 (Japan, Europe, Middle East, South Africa).<br><br>Languages: English, Deutsch.<br><br>Subtitles: English, Deutsch, Spanish.<br><br>Audio: Dolby Surround 5.1.<br><br>Picture Format: 16:9 Wide-Screen.<br><br>Length: (approx) 164 minutes.<br><br>Other: Interactive Menus, Chapter Selection, Subtitles (more languages).','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (21,4,'SWAT 3: Close Quarters Battle','(pt) <b>Windows 95/98</b><br><br>211 in progress with shots fired. Officer down. Armed suspects with hostages. Respond Code 3! Los Angles, 2005, In the next seven days, representatives from every nation around the world will converge on Las Angles to witness the signing of the United Nations Nuclear Abolishment Treaty. The protection of these dignitaries falls on the shoulders of one organization, LAPD SWAT. As part of this elite tactical organization, you and your team have the weapons and all the training necessary to protect, to serve, and \"When needed\" to use deadly force to keep the peace. It takes more than weapons to make it through each mission. Your arsenal includes C2 charges, flashbangs, tactical grenades. opti-Wand mini-video cameras, and other devices critical to meeting your objectives and keeping your men free of injury. Uncompromised Duty, Honor and Valor!','www.swat3.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (22,4,'Unreal Tournament','(pt) From the creators of the best-selling Unreal, comes Unreal Tournament. A new kind of single player experience. A ruthless multiplayer revolution.<br><br>This stand-alone game showcases completely new team-based gameplay, groundbreaking multi-faceted single player action or dynamic multi-player mayhem. It''s a fight to the finish for the title of Unreal Grand Master in the gladiatorial arena. A single player experience like no other! Guide your team of ''bots'' (virtual teamates) against the hardest criminals in the galaxy for the ultimate title - the Unreal Grand Master.','www.unrealtournament.net',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (23,4,'The Wheel Of Time','(pt) The world in which The Wheel of Time takes place is lifted directly out of Jordan''s pages; it''s huge and consists of many different environments. How you navigate the world will depend largely on which game - single player or multipayer - you''re playing. The single player experience, with a few exceptions, will see Elayna traversing the world mainly by foot (with a couple notable exceptions). In the multiplayer experience, your character will have more access to travel via Ter''angreal, Portal Stones, and the Ways. However you move around, though, you''ll quickly discover that means of locomotion can easily become the least of the your worries...<br><br>During your travels, you quickly discover that four locations are crucial to your success in the game. Not surprisingly, these locations are the homes of The Wheel of Time''s main characters. Some of these places are ripped directly from the pages of Jordan''s books, made flesh with Legend''s unparalleled pixel-pushing ways. Other places are specific to the game, conceived and executed with the intent of expanding this game world even further. Either way, they provide a backdrop for some of the most intense first person action and strategy you''ll have this year.','www.wheeloftime.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (24,4,'Disciples: Sacred Lands','(pt) A new age is dawning...<br><br>Enter the realm of the Sacred Lands, where the dawn of a New Age has set in motion the most momentous of wars. As the prophecies long foretold, four races now clash with swords and sorcery in a desperate bid to control the destiny of their gods. Take on the quest as a champion of the Empire, the Mountain Clans, the Legions of the Damned, or the Undead Hordes and test your faith in battles of brute force, spellbinding magic and acts of guile. Slay demons, vanquish giants and combat merciless forces of the dead and undead. But to ensure the salvation of your god, the hero within must evolve.<br><br>The day of reckoning has come... and only the chosen will survive.','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (25,4,'Microsoft Internet Keyboard PS/2','(pt) The Internet Keyboard has 10 Hot Keys on a comfortable standard keyboard design that also includes a detachable palm rest. The Hot Keys allow you to browse the web, or check e-mail directly from your keyboard. The IntelliType Pro software also allows you to customize your hot keys - make the Internet Keyboard work the way you want it to!','',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (26,4,'Microsoft IntelliMouse Explorer','(pt) Microsoft introduces its most advanced mouse, the IntelliMouse Explorer! IntelliMouse Explorer features a sleek design, an industrial-silver finish, a glowing red underside and taillight, creating a style and look unlike any other mouse. IntelliMouse Explorer combines the accuracy and reliability of Microsoft IntelliEye optical tracking technology, the convenience of two new customizable function buttons, the efficiency of the scrolling wheel and the comfort of expert ergonomic design. All these great features make this the best mouse for the PC!','www.microsoft.com/hardware/mouse/explorer.asp',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (27,4,'Hewlett Packard LaserJet 1100Xi','(pt) HP has always set the pace in laser printing technology. The new generation HP LaserJet 1100 series sets another impressive pace, delivering a stunning 8 pages per minute print speed. The 600 dpi print resolution with HP''s Resolution Enhancement technology (REt) makes every document more professional.<br><br>Enhanced print speed and laser quality results are just the beginning. With 2MB standard memory, HP LaserJet 1100xi users will be able to print increasingly complex pages. Memory can be increased to 18MB to tackle even more complex documents with ease. The HP LaserJet 1100xi supports key operating systems including Windows 3.1, 3.11, 95, 98, NT 4.0, OS/2 and DOS. Network compatibility available via the optional HP JetDirect External Print Servers.<br><br>HP LaserJet 1100xi also features The Document Builder for the Web Era from Trellix Corp. (featuring software to create Web documents).','www.pandi.hp.com/pandi-db/prodinfo.main?product=laserjet1100',0);

UPDATE products_description SET language_code = 'pt' WHERE language_id = 4;

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (28,4,'Bundle Saver','Buy the Microsoft IntelliMouse Explorer and the Internet Keyboard together\, to save  10% on the individual prices and to receive free shipping !','',0);

-- Product Options
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (1, 4, 'Cor');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (2, 4, 'Tamanho');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (3, 4, 'Modelo');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (4, 4, 'Mem??ria');

-- Product Option Values
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (1,4,'4 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (2,4,'8 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (3,4,'16 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (4,4,'32 mb');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (5,4,'Valor');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (6,4,'Premium');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (7,4,'Deluxe');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (8,4,'PS/2');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (9,4,'USB');

-- Reviews
--INSERT INTO reviews_description (reviews_id, languages_id, reviews_text) VALUES (1,4, 'Isto tem de ser um dos mais engra??ados filmes lan??ados em 1999');

-- AdminApp Promotion - Expression API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addExpressionsToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getExpressionsPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeExpressionsFromPromotion','', current timestamp);

--Customer tag examples
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'PRODUCTS_VIEWED', 'Recently viewed product id', '((:[0-9]*)*:|)', 2, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='CATEGORIES_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'CATEGORIES_VIEWED', 'Recently viewed category id', '((:[0-9]*)*:|)', 2, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='MANUFACTURERS_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'MANUFACTURERS_VIEWED', 'Recently viewed manufacturer id', '((:[0-9]*)*:|)', 2, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_IN_CART';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'PRODUCTS_IN_CART', 'Id of a product in the cart', '((:[0-9]*)*:|)', 2, 50, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_IN_WISHLIST';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'PRODUCTS_IN_WISHLIST', 'Id of a product in the Wish List', '((:[0-9]*)*:|)', 2, 50, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='SEARCH_STRING';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'SEARCH_STRING', 'Product Search String', 0, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='COUNTRY_CODE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'COUNTRY_CODE', 'Country code of customer', 0, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='CART_TOTAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'CART_TOTAL', 'Cart total', 3, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='WISHLIST_TOTAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'WISHLIST_TOTAL', 'Wish List total', 3, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='BIRTH_DATE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'BIRTH_DATE', 'Date of Birth', 4, 5, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='IS_MALE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'IS_MALE', 'Customer is Male', 'true|false', 5, 5, current timestamp);

-- Enable / Disable customer tag functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_TAGS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Customer Tag functionality', 'ENABLE_CUSTOMER_TAGS', 'false', 'When set to true, the application sets customer tags. All tag functionality is disabled when false.', 5, 6, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Enable / Disable customer cart tag functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_CART_TAGS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Customer Cart Tag functionality', 'ENABLE_CUSTOMER_CART_TAGS', 'false', 'When set to true, the application sets customer cart tags', 5, 7, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Enable / Disable customer wishlist tag functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_WISHLIST_TAGS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Customer WishList Tag functionality', 'ENABLE_CUSTOMER_WISHLIST_TAGS', 'false', 'When set to true, the application sets customer wish list tags', 5, 8, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Config variables to determine whether to show internal ids
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PRODUCTS_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Product Ids', 'ADMIN_APP_PRODUCTS_DISPLAY_ID', 'true', 'When this is set, the product id is displayed in the products panel', 21, 29, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANUFACTURERS_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Manufacturer Ids', 'ADMIN_APP_MANUFACTURERS_DISPLAY_ID', 'true', 'When this is set, the manufacturer id is displayed in the manufacturers panel', 21, 30, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CATEGORIES_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Category Ids', 'ADMIN_APP_CATEGORIES_DISPLAY_ID', 'true', 'When this is set, the category id is displayed in the categories panel', 21, 31, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Evaluate Expression Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'evaluateExpression','', current timestamp);

-- Extra attribute for product object
ALTER TABLE products ADD rating decimal(15,4);

-- Update image names

UPDATE products SET products_image = 'dvd/replacement_killers.jpg'          WHERE products_image = 'dvd/replacement_killers.gif';
UPDATE products SET products_image = 'dvd/blade_runner.jpg'                 WHERE products_image = 'dvd/blade_runner.gif';
UPDATE products SET products_image = 'dvd/the_matrix.jpg'                   WHERE products_image = 'dvd/the_matrix.gif';
UPDATE products SET products_image = 'dvd/youve_got_mail.jpg'               WHERE products_image = 'dvd/youve_got_mail.gif';
UPDATE products SET products_image = 'dvd/a_bugs_life.jpg'                  WHERE products_image = 'dvd/a_bugs_life.gif';
UPDATE products SET products_image = 'dvd/under_siege.jpg'                  WHERE products_image = 'dvd/under_siege.gif';
UPDATE products SET products_image = 'dvd/under_siege2.jpg'                 WHERE products_image = 'dvd/under_siege2.gif';
UPDATE products SET products_image = 'dvd/fire_down_below.jpg'              WHERE products_image = 'dvd/fire_down_below.gif';
UPDATE products SET products_image = 'dvd/die_hard_3.jpg'                   WHERE products_image = 'dvd/die_hard_3.gif';
UPDATE products SET products_image = 'dvd/lethal_weapon.jpg'                WHERE products_image = 'dvd/lethal_weapon.gif';
UPDATE products SET products_image = 'dvd/red_corner.jpg'                   WHERE products_image = 'dvd/red_corner.gif';
UPDATE products SET products_image = 'dvd/frantic.jpg'                      WHERE products_image = 'dvd/frantic.gif';
UPDATE products SET products_image = 'dvd/courage_under_fire.jpg'           WHERE products_image = 'dvd/courage_under_fire.gif';
UPDATE products SET products_image = 'dvd/speed.jpg'                        WHERE products_image = 'dvd/speed.gif';
UPDATE products SET products_image = 'dvd/speed2.jpg'                       WHERE products_image = 'dvd/speed_2.gif';
UPDATE products SET products_image = 'dvd/theres_something_about_mary.jpg'  WHERE products_image = 'dvd/theres_something_about_mary.gif';
UPDATE products SET products_image = 'dvd/beloved.jpg'                      WHERE products_image = 'dvd/beloved.gif';

UPDATE products SET products_image = 'sierra/swat3.jpg'                     WHERE products_image = 'sierra/swat_3.gif';

UPDATE products SET products_image = 'gt_interactive/unreal_tournament.jpg' WHERE products_image = 'gt_interactive/unreal_tournament.gif';
UPDATE products SET products_image = 'gt_interactive/wheel_of_time.jpg'     WHERE products_image = 'gt_interactive/wheel_of_time.gif';
UPDATE products SET products_image = 'gt_interactive/disciples.jpg'         WHERE products_image = 'gt_interactive/disciples.gif';

UPDATE products SET products_image = 'hewlett_packard/lj1100xi.jpg'         WHERE products_image = 'hewlett_packard/lj1100xi.gif';

UPDATE products SET products_image = 'matrox/mg400-32mb.jpg'                WHERE products_image = 'matrox/mg400-32mb.gif';
UPDATE products SET products_image = 'matrox/mg200mms.jpg'                  WHERE products_image = 'matrox/mg200mms.gif';

UPDATE products SET products_image = 'microsoft/bundle.jpg'                 WHERE products_image = 'microsoft/bundle.gif';
UPDATE products SET products_image = 'microsoft/imexplorer.jpg'             WHERE products_image = 'microsoft/imexplorer.gif';
UPDATE products SET products_image = 'microsoft/intkeyboardps2.jpg'         WHERE products_image = 'microsoft/intkeyboardps2.gif';
UPDATE products SET products_image = 'microsoft/msimpro.jpg'                WHERE products_image = 'microsoft/msimpro.gif';

-- Add index to products_attributes table
CREATE INDEX i_pr_390f139aa7407 ON products_attributes (products_id);

-- New Digital Download table
DROP TABLE kk_digital_download;
DROP TABLE kk_digital_download_1;
CREATE TABLE kk_digital_download_1 (
  kk_digital_download_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  products_id INTEGER DEFAULT 0 NOT NULL,
  customers_id INTEGER DEFAULT 0 NOT NULL,
  products_file_path VARCHAR(255),
  max_downloads INTEGER DEFAULT -1,
  times_downloaded INTEGER DEFAULT 0,
  expiration_date TIMESTAMP,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(kk_digital_download_id)
);
DROP SEQUENCE kk_digital_download_1_SEQ;
CREATE SEQUENCE kk_digital_download_1_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add column to promotion_to_product table
ALTER TABLE promotion_to_product ADD relation_type int DEFAULT 0;

-- GiftCertificate APIs for the Admin App
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addGiftCertificatesToPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getGiftCertificatesPerPromotion','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeGiftCertificatesFromPromotion','', current timestamp);

-- Insert a gift certificate product

DELETE FROM products WHERE products_id = 29;
DELETE FROM products_description WHERE products_id = 29;
INSERT INTO products (products_id, products_quantity, products_model, products_image, products_price, products_date_added, products_last_modified, products_date_available, products_weight, products_status, products_tax_class_id, manufacturers_id, products_ordered, products_type) VALUES (nextval for products_seq,10000,'GIFTCERT','gifts/giftcert.jpg',10.00, current timestamp,null,current timestamp,0.1,1,1,10,0,5);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,1,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,2,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,3,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (29,4,'Gift Certificate','The Perfect Gift ! <br><br>After checking out, your gift certificate will be available as a stylish pdf document that you can download from your account page. You may then send it as an eMail attachment or print it out and deliver a hard copy.<br>Each gift certificate contains a code that is redeemable online.','www.konakart.com',0);

DELETE FROM products_options WHERE products_options_id = 5;
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 1, 'Type');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 2, 'Type');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 3, 'Type');
INSERT INTO products_options (products_options_id, language_id, products_options_name) VALUES (5, 4, 'Type');

DELETE FROM products_options_values WHERE products_options_values_id = 10;
DELETE FROM products_options_values WHERE products_options_values_id = 11;
DELETE FROM products_options_values WHERE products_options_values_id = 12;
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,1,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,2,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,3,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (10,4,'Bronze');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,1,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,2,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,3,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (11,4,'Silver');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,1,'Gold');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,2,'Gold');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,3,'Gold');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name) VALUES (12,4,'Gold');

DELETE FROM prod_opt_vals_to_prod_opt WHERE products_options_id = 5;
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ, 5, 10);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ, 5, 11);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ, 5, 12);

DELETE FROM products_attributes WHERE options_id = 5;
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) VALUES (nextval for products_attributes_seq,29,5,10,0.00,'+');
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) VALUES (nextval for products_attributes_seq,29,5,11,15.00,'+');
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix) VALUES (nextval for products_attributes_seq,29,5,12,40.00,'+');

DELETE FROM categories WHERE categories_id = 21;
DELETE FROM categories_description WHERE categories_id = 21;
DELETE FROM products_to_categories WHERE categories_id = 21;
INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 0, 4, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 1, 'Gifts');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 2, 'Gifts');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 3, 'Gifts');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES ( 21, 4, 'Gifts');
INSERT INTO products_to_categories (products_id, categories_id) VALUES (29, 21);

DELETE FROM manufacturers WHERE manufacturers_id = 10;
DELETE FROM manufacturers_info WHERE manufacturers_id = 10;
INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'KonaKart','konakart_tree_logo_60x60.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 1, 'http://www.konakart.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 2, 'http://www.konakart.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 3, 'http://www.konakart.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (10, 4, 'http://www.konakart.com', 0, null);

-- Table to store secret key used in payment gateways
DROP TABLE kk_secret_key;
CREATE TABLE kk_secret_key (
  kk_secret_key_id INTEGER NOT NULL,
  secret_key VARCHAR(50) NOT NULL,
  orders_id integer NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_secret_key_id)
   );
DROP SEQUENCE kk_secret_key_SEQ;
CREATE SEQUENCE kk_secret_key_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Digital Download Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'searchDigitalDownloads','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'importDigitalDownload','', current timestamp);

-----------------  v5.0.0.0

-- Reward points table
DROP TABLE kk_reward_points;
CREATE TABLE kk_reward_points (
  kk_reward_points_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  code VARCHAR(64),
  description VARCHAR(256),
  customers_id INTEGER DEFAULT 0 NOT NULL,
  initial_points INTEGER DEFAULT 0 NOT NULL,
  remaining_points INTEGER DEFAULT 0 NOT NULL,
  expired INTEGER DEFAULT 0 NOT NULL,
  tx_type INTEGER DEFAULT 0 NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_reward_points_id)
);
DROP SEQUENCE kk_reward_points_SEQ;
CREATE SEQUENCE kk_reward_points_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Reserved points table
DROP TABLE kk_reserved_points;
CREATE TABLE kk_reserved_points (
  kk_reserved_points_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  customers_id INTEGER DEFAULT 0 NOT NULL,
  reward_points_id INTEGER DEFAULT 0 NOT NULL,
  reservation_id INTEGER DEFAULT 0 NOT NULL,
  reserved_points INTEGER DEFAULT 0 NOT NULL,
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_reserved_points_id)
);
DROP SEQUENCE kk_reserved_points_SEQ;
CREATE SEQUENCE kk_reserved_points_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

--Extra order attributes for reward points
ALTER TABLE orders ADD points_used int DEFAULT 0;
ALTER TABLE orders ADD points_awarded int DEFAULT 0;
ALTER TABLE orders ADD points_reservation_id int DEFAULT -1;

-- Allow user to insert reward points
DELETE FROM configuration WHERE configuration_key = 'ENABLE_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'Enable Reward Points', 'ENABLE_REWARD_POINTS', 'false', 'During checkout the customer will be allowed to enter reward points if set to true', 26, 1, 'choice(''true''=''true'',''false''=''false'')', current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 8;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,1,'Cancelled');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,2,'Abgesagt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,3,'Cancelado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (8,4,'Cancelado');

-- Maximum number of reward point transactions displayed
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'Reward Point Transactions', 'MAX_DISPLAY_REWARD_POINTS', '15', 'Maximum number of reward point transactions to display', 3, 26, 'integer(0,null)', current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
-- Number of reward point awarded for registering
DELETE FROM configuration WHERE configuration_key = 'REGISTRATION_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'Reward Points for registering', 'REGISTRATION_REWARD_POINTS', '0', 'Reward points received for registration', 26, 2, 'integer(0,null)', current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';
-- Number of reward point awarded for writing a review
DELETE FROM configuration WHERE configuration_key = 'REVIEW_REWARD_POINTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'Reward Points for writing a review', 'REVIEW_REWARD_POINTS', '0', 'Reward points received for writing a review', 26, 3, 'integer(0,null)', current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Panel for Configuring Reward Points
INSERT INTO kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq,  'kk_panel_reward_points','Reward Points Configuration', current timestamp);

-- Add Configure Reward Points to super admin role
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (1, 92, 1,1,1,current timestamp);
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) VALUES (5, 92, 1,1,1,current timestamp);

-- Reward Point API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getRewardPoints','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deletePoints','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'importDigitalDownload','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'pointsAvailable','', current timestamp);

-- Add locale to customer and order
ALTER TABLE customers ADD customers_locale varchar(16);
ALTER TABLE orders ADD customers_locale varchar(16);

-- To enable/disable the new Rich Text Product Description Editor
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Use Rich Text Editor', 'RICH_TEXT_EDITOR', 'true', 'If true the Rich Text Editor is used for product descriptions, otherwise the Plain Text Editor is used', 9, 12, 'choice(''true''=''true'',''false''=''false'')', current timestamp);


INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, '1st Day of the Week', '1ST_DAY_OF_WEEK', '0', 'Define the first day of the week for the calendars in the Admin App.', 21, 35, 'option(0=date.day.long.Sunday,1=date.day.long.Monday,2=date.day.long.Tuesday,3=date.day.long.Wednesday,4=date.day.long.Thursday,5=date.day.long.Friday,6=date.day.long.Saturday)', current timestamp);

-- Allow user to insert gift certificate code
DELETE FROM configuration WHERE configuration_key = 'DISPLAY_GIFT_CERT_ENTRY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Gift Cert Entry Field', 'DISPLAY_GIFT_CERT_ENTRY', 'false', 'During checkout the customer will be allowed to enter a gift certificate if set to true', 1, 22, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Configure the customer communications panel to show or not show a drop list of templates
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set, template names can be entered in a text box' WHERE panel_id=62;
-- Configure the customer communications panel to show or not show a file upload button
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set, a file upload button is not displayed' WHERE panel_id=62;

-- PDF Creation API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getPdf','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFileContentsAsByteArray','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguageIdForLocale','', current timestamp);

-- PDF Config panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_pdfConfig', 'PDF Configuration', current timestamp);

-- Grant access to PDF Config panel to the Super Admin and the Standard Admin Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp from kk_panel WHERE code = 'kk_panel_pdfConfig';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp from kk_panel WHERE code = 'kk_panel_pdfConfig';

-- PDF Configuration Parameters
DELETE FROM configuration WHERE configuration_key = 'PDF_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'PDF Directory', 'PDF_BASE_DIRECTORY', 'C:/KonaKart/pdf/', 'Defines the root directory for the location of the PDF documents that are created', 27, 5, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ENABLE_PDF_INVOICE_DOWNLOAD';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, store_id) SELECT nextval for configuration_seq, 'Enable PDF Invoice Download', 'ENABLE_PDF_INVOICE_DOWNLOAD', 'false', 'When set to true, invoices in PDF format can be downloaded from the application', 27, 10, 'choice(''true''=''true'',''false''=''false'')', current timestamp, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add column for Invoice filename
ALTER TABLE orders ADD invoice_filename varchar(255);

-- Velocity Template Configuration Parameters
DELETE FROM configuration WHERE configuration_key = 'TEMPLATE_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Templates Directory', 'TEMPLATE_BASE_DIRECTORY', 'C:/KonaKart/templates', 'Defines the root directory where the velocity templates are stored', 28, 10, current timestamp);

-- Velocity Template Config panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_templates', 'Template Configuration', current timestamp);

-- Grant access to Velocity Template Config panel to the Super Admin and the Standard Admin Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp from kk_panel WHERE code = 'kk_panel_templates';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp from kk_panel WHERE code = 'kk_panel_templates';

-- Add extra column to returns table
ALTER TABLE orders_returns ADD orders_number varchar(128);

-- Config variable to automatically enable products when quantity > 0
DELETE FROM configuration WHERE configuration_key = 'STOCK_ENABLE_PRODUCT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Automatically Enable Product', 'STOCK_ENABLE_PRODUCT', 'false', 'Automatically enable a product if quantity is set to a positive number', 9, 4, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Configure the edit customer panel to allow editing of external customers only
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow editing of external customer fields only' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_editCustomer');

-- Configure the edit config files panel to control the upload of new files
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow upload of configuration files' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_configFiles');

-- Allow Super-User Role to upload new config files
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_configFiles') and role_id=1;

-- New Batch job for Creating Invoices
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'com.konakartadmin.bl.AdminOrderBatchMgr.createInvoicesBatch','', current timestamp);

-- Add new FileUpload configuration command
UPDATE configuration SET set_function='FileUpload' WHERE configuration_key = 'KONAKART_MAIL_PROPERTIES_FILE';
UPDATE configuration SET set_function='FileUpload' WHERE configuration_key = 'KK_NEW_STORE_SQL_FILENAME';
UPDATE configuration SET set_function='FileUpload' WHERE configuration_key = 'USER_NEW_STORE_SQL_FILENAME';

-- Added just as an example of using the FileUpload get_function in a module configuration parameter
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, use_function, date_added) VALUES (nextval for configuration_seq, 'Miscellaneous Config File', 'MODULE_PAYMENT_COD_MISC_CONFIG_FILE', 'C:/Temp/cod_misc.properties', 'Miscellaneous Configuration File (just an example - not actually used).', 6, 6, 'FileUpload', '', current timestamp);

-- Add index to customers table
CREATE INDEX i_cu_377c4b1a3685e ON customers (customers_email_address);

-- Addition of more custom fields to product object
ALTER TABLE products ADD custom6 varchar(128);
ALTER TABLE products ADD custom7 varchar(128);
ALTER TABLE products ADD custom8 varchar(128);
ALTER TABLE products ADD custom9 varchar(128);
ALTER TABLE products ADD custom10 varchar(128);
ALTER TABLE products ADD custom1Int int;
ALTER TABLE products ADD custom2Int int;
ALTER TABLE products ADD custom1Dec decimal(15,4);
ALTER TABLE products ADD custom2Dec decimal(15,4);
ALTER TABLE products ADD products_date_expiry TIMESTAMP;

-- Config variable to determine whether to show internal customer ids
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOMERS_DISPLAY_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Customer Ids', 'ADMIN_APP_CUSTOMERS_DISPLAY_ID', 'true', 'When this is set, the customer id is displayed in the edit customer panel', 21, 29, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Extra attributes for product object
ALTER TABLE products ADD payment_schedule_id int default -1 not null;

-- Payment Schedule
DROP TABLE kk_payment_schedule;
CREATE TABLE kk_payment_schedule (
  kk_payment_schedule_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  name VARCHAR(64),
  description VARCHAR(256),
  length INTEGER DEFAULT 0 NOT NULL,
  unit INTEGER DEFAULT 0 NOT NULL,
  day_of_month INTEGER DEFAULT 0 NOT NULL,
  occurrences INTEGER DEFAULT 0 NOT NULL,
  trial_occurrences INTEGER DEFAULT 0 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_payment_schedule_id)
);
DROP SEQUENCE kk_payment_schedule_SEQ;
CREATE SEQUENCE kk_payment_schedule_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Subscription
DROP TABLE kk_subscription;
CREATE TABLE kk_subscription (
  kk_subscription_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  orders_id INTEGER DEFAULT 0 NOT NULL,
  orders_number VARCHAR(128),
  customers_id INTEGER DEFAULT 0 NOT NULL,
  products_id INTEGER DEFAULT 0 NOT NULL,
  payment_schedule_id INTEGER DEFAULT 0 NOT NULL,
  products_sku VARCHAR(255),
  subscription_code VARCHAR(128),
  start_date TIMESTAMP,
  amount decimal(15,4) NOT NULL,
  trial_amount decimal(15,4),
  active INTEGER DEFAULT 0 NOT NULL,
  problem INTEGER DEFAULT 0 NOT NULL,
  problem_description VARCHAR(255),
  last_billing_date TIMESTAMP,
  next_billing_date TIMESTAMP,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(kk_subscription_id)
);
DROP SEQUENCE kk_subscription_SEQ;
CREATE SEQUENCE kk_subscription_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Payment Schedule Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_payment_schedule', 'Payment Schedule', current timestamp);

-- Grant access to Payment Schedule panel to the Super Admin and the Standard Admin and Catalog Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_payment_schedule';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 2, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_payment_schedule';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_payment_schedule';

-- Subscription Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_subscription', 'Subscription', current timestamp);

-- Grant access to Subscription panel to the Super Admin and the Standard Admin and Order Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscription';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 3, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscription';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscription';

-- Subscription From Orders Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_subscriptionFromOrders', 'Subscription From Orders', current timestamp);

-- Grant access to Subscription From Orders panel to the Super Admin and the Standard Admin and Order Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscriptionFromOrders';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 3, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscriptionFromOrders';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscriptionFromOrders';

-- Subscription from Customers Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_subscriptionFromCustomers', 'Subscription From Customers', current timestamp);

-- Grant access to Subscription from Customers panel to the Super Admin and the Standard Admin and Order Maintenance Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscriptionFromCustomers';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 3, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscriptionFromCustomers';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_subscriptionFromCustomers';

-- Extra attributes for ipn_history object
ALTER TABLE ipn_history ADD kk_subscription_id int DEFAULT -1 not null;

-- Config variable to determine whether to show button for subscriptions panel
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_DISPLAY_SUBSCRIPTIONS_BUTTON';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Display Subscriptions Button', 'ADMIN_APP_DISPLAY_SUBSCRIPTIONS_BUTTON', 'false', 'When this is set, a Subscriptions button is displayed in the Customers and Orders panels', 21, 30, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Allow the same product to be entered into the basket more than once without updating the quantity of the existing one
DELETE FROM configuration WHERE configuration_key = 'ALLOW_MULTIPLE_BASKET_ENTRIES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow multiple basket entries', 'ALLOW_MULTIPLE_BASKET_ENTRIES', 'false', 'When set, allow the same product to be entered into the basket more than once without updating the quantity of the existing one', 9, 11, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Addition of extra telephone and eMail attributes
ALTER TABLE customers ADD customers_telephone_1 varchar(32);
ALTER TABLE address_book ADD entry_telephone varchar(32);
ALTER TABLE address_book ADD entry_telephone_1 varchar(32);
ALTER TABLE address_book ADD entry_email_address varchar(96);
ALTER TABLE orders ADD customers_telephone_1 varchar(32);
ALTER TABLE orders ADD delivery_telephone varchar(32);
ALTER TABLE orders ADD delivery_telephone_1 varchar(32);
ALTER TABLE orders ADD delivery_email_address varchar(96);
ALTER TABLE orders ADD billing_telephone varchar(32);
ALTER TABLE orders ADD billing_telephone_1 varchar(32);
ALTER TABLE orders ADD billing_email_address varchar(96);

-- Make address format fields bigger
ALTER TABLE address_format ALTER COLUMN address_format SET DATA TYPE VARCHAR(255);
ALTER TABLE address_format ALTER COLUMN address_summary SET DATA TYPE VARCHAR(255);

-- Make product image fields bigger
ALTER TABLE products ALTER COLUMN products_image SET DATA TYPE VARCHAR(255);
ALTER TABLE products ALTER COLUMN products_image2 SET DATA TYPE VARCHAR(255);
ALTER TABLE products ALTER COLUMN products_image3 SET DATA TYPE VARCHAR(255);
ALTER TABLE products ALTER COLUMN products_image4 SET DATA TYPE VARCHAR(255);

-----------------  v5.1.0.0

-- These are required because we changed the default https port in server.xml

UPDATE configuration SET configuration_value='8783' WHERE configuration_key = 'SSL_PORT_NUMBER' AND configuration_value = '8443';
UPDATE configuration SET configuration_value='https://localhost:8783/konakart/AdminLoginSubmit.do' WHERE configuration_key = 'ADMIN_APP_LOGIN_BASE_URL' AND configuration_value = 'https://localhost:8443/konakart/AdminLoginSubmit.do';

-- Add attribute to determine whether to use basket price or product price
ALTER TABLE customers_basket ADD use_basket_price int DEFAULT 0;

-- Allow usage of basket price
DELETE FROM configuration WHERE configuration_key = 'ALLOW_BASKET_PRICE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow using the basket price', 'ALLOW_BASKET_PRICE','false','Allows you to define the price in the basket object when adding a product to the basket', 18, 8, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Add attribute to define the default behavior of the admin app when changing order status
ALTER TABLE orders_status ADD notify_customer int DEFAULT 0;

-- Add special price expiry date
ALTER TABLE specials ADD starts_date TIMESTAMP DEFAULT NULL;

-- Add a tier price table
DROP TABLE kk_tier_price;
CREATE TABLE kk_tier_price (
  kk_tier_price_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  products_id INTEGER NOT NULL,
  products_quantity INTEGER NOT NULL,
  tier_price decimal(15,4),
  tier_price_1 decimal(15,4),
  tier_price_2 decimal(15,4),
  tier_price_3 decimal(15,4),
  use_percentage_discount int,
  custom1 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  last_modified TIMESTAMP,
  PRIMARY KEY(kk_tier_price_id)
);
DROP SEQUENCE kk_tier_price_SEQ;
CREATE SEQUENCE kk_tier_price_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

--Add discount attribute to Orders Products table
ALTER TABLE orders_products ADD discount_percent decimal(15,4);

-- Set the rule for calculating tax
DELETE FROM configuration where configuration_key = 'TAX_QUANTITY_RULE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Tax Quantity Rule', 'TAX_QUANTITY_RULE', '1', 'Tax calculated on total=1\nTax calculated per item and then rounded=2', 9, 13, 'integer(1,2), ', current timestamp);

-- Set the number of decimal places for currency in the admin app
DELETE FROM configuration where configuration_key = 'ADMIN_CURRENCY_DECIMAL_PLACES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'No of decimal places for currency', 'ADMIN_CURRENCY_DECIMAL_PLACES', '2', 'No of decimal places allowed for entering prices in the admin app', 1, 27, 'integer(0,9), ', current timestamp);

-- Add extra street address to various tables
ALTER TABLE address_book ADD entry_street_address_1 varchar(64);
ALTER TABLE orders ADD customers_street_address_1 varchar(64);
ALTER TABLE orders ADD delivery_street_address_1 varchar(64);
ALTER TABLE orders ADD billing_street_address_1 varchar(64);

-- Config variable to decide whether to show 2nd street address
DELETE FROM configuration where configuration_key = 'ACCOUNT_STREET_ADDRESS_1';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Street Address 1', 'ACCOUNT_STREET_ADDRESS_1', 'false', 'Display 2nd street address in the customers account', 5, 4, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Config variable to define min length of 2nd street address
DELETE FROM configuration where configuration_key = 'ENTRY_STREET_ADDRESS1_MIN_LENGTH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Street Address 1', 'ENTRY_STREET_ADDRESS1_MIN_LENGTH', '5', 'Minimum length of street address 1', 2, 5, 'integer(0,null)', current timestamp);

-- Addition of custom fields to products_attributes
ALTER TABLE products_attributes ADD custom1 varchar(128);
ALTER TABLE products_attributes ADD custom2 varchar(128);

-- Addition of custom fields to products_options
ALTER TABLE products_options ADD custom1 varchar(128);
ALTER TABLE products_options ADD custom2 varchar(128);

-- Addition of custom fields to products_options_values
ALTER TABLE products_options_values ADD custom1 varchar(128);
ALTER TABLE products_options_values ADD custom2 varchar(128);

-- Config variable to issue warning for matching SKUs in Admin App
DELETE FROM configuration where configuration_key = 'ADMIN_APP_WARN_OF_DUPLICATE_SKUS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Warn of Duplicate SKUs', 'ADMIN_APP_WARN_OF_DUPLICATE_SKUS', 'false', 'Issue warning in Admin App of duplicate SKUs', 21, 32, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Move the Rich Text Editor Configuration Variable to the Admn App Configuration Panel
UPDATE configuration set configuration_group_id = 21, sort_order = 32 where configuration_key = 'RICH_TEXT_EDITOR' and configuration_group_id = 9;

-----------------  v5.2.0.0

-- Add extra columns to the Zones table
ALTER TABLE zones ADD zone_invisible int DEFAULT 0 NOT NULL;
ALTER TABLE zones ADD zone_search varchar(64);
CREATE INDEX i_zo_3110dd6d14_zo ON zones (zone_search);

-- New API call for checking Data Integrity
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'checkDataIntegrity','', current timestamp);

-- Addition of custom fields to digital_downloads
ALTER TABLE kk_digital_download_1 ADD custom1 varchar(128);
ALTER TABLE kk_digital_download_1 ADD custom2 varchar(128);
ALTER TABLE kk_digital_download_1 ADD custom3 varchar(128);

-- Add an attribute to the orders table
ALTER TABLE orders ADD shipping_service_code varchar(128);

-- Add custom field descriptions for Shipping Command on Order panels
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Export For Shipping button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Export For Shipping button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_orders');

UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Export button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Export button not shown' WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_orders');

-- Config variable to define the location of the Shipping Orders
DELETE FROM configuration where configuration_key = 'EXPORT_ORDERS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Exported Orders Directory', 'EXPORT_ORDERS_BASE_DIRECTORY', 'C:/KonaKart/orders', 'Defines the root directory where the Orders are exported to', 7, 7, current timestamp);

-- New exportOrder API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'exportOrder','', current timestamp);

-- Add description field to category
ALTER TABLE categories_description ADD description VARCHAR(4000);

-- Move the Admin Currency Decimal Place Configuration Variable to the Admn App Configuration Panel
UPDATE configuration set configuration_group_id = 21, sort_order = 40 where configuration_key = 'ADMIN_CURRENCY_DECIMAL_PLACES' and configuration_group_id = 1;

-- Move the Email From and Send Extra Emails Configuration Variable to the Email Configuration Panel
UPDATE configuration set configuration_group_id = 12, sort_order = 6 where configuration_key = 'EMAIL_FROM' and configuration_group_id = 1;
UPDATE configuration set configuration_group_id = 12, sort_order = 6 where configuration_key = 'SEND_EXTRA_EMAILS_TO' and configuration_group_id = 1;

-- Config variable to define whether to allow wish lists for non logged in users
DELETE FROM configuration where configuration_key = 'ALLOW_WISHLIST_WHEN_NOT_LOGGED_IN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Allow Wish List when not logged in', 'ALLOW_WISHLIST_WHEN_NOT_LOGGED_IN', 'false', 'Allow wish list functionality to be available for customers that have not logged in', 1, 25, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Config variable to define the Address that Orders are shipped from
DELETE FROM configuration where configuration_key = 'SHIP_FROM_STREET_ADDRESS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Ship From Street Address', 'SHIP_FROM_STREET_ADDRESS', '', 'Ship From Street Address - used by some of the Shipping Modules', 7, 2, current timestamp);

-- Config variable to define the City that Orders are shipped from
DELETE FROM configuration where configuration_key = 'SHIP_FROM_CITY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Ship From City', 'SHIP_FROM_CITY', '', 'Ship From City - used by some of the Shipping Modules', 7, 2, current timestamp);

-- Add weight attribute to Orders Products table
ALTER TABLE orders_products ADD weight decimal(10,2);

-- Config variable to define the Product Types that are not shown in the droplist on the Edit Product Panel
DELETE FROM configuration where configuration_key = 'HIDDEN_PRODUCT_TYPES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Hidden Product Types', 'HIDDEN_PRODUCT_TYPES', '', 'The Product Types that are not shown in the droplist on the Edit Product Panel', 21, 27, current timestamp);

-- Set the default customer to be John Doe
UPDATE customers SET customers_type = 3 where customers_email_address = 'root@localhost';

-- Set the custom1 field of the Super User role to Administrator (for Liferay SSO example)
UPDATE kk_role SET custom1 = 'Administrator' where role_id = 1;

-- Add new column to promotions table
ALTER TABLE promotion ADD max_use int NOT NULL DEFAULT -1;

-- Tracks the number of times a promotion has been used
DROP TABLE promotion_to_customer_use;
CREATE TABLE promotion_to_customer_use (
  store_id VARCHAR(64),
  promotion_id INTEGER NOT NULL,
  customers_id INTEGER NOT NULL,
  times_used INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(promotion_id,customers_id)
);

-- Page links
DELETE FROM configuration where configuration_key = 'MAX_DISPLAY_PAGE_LINKS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Search Result Page Links', 'MAX_DISPLAY_PAGE_LINKS', '5', 'Maximum number of links used for page-sets - must be odd number', 3, 3, 'integer(3,null)', current timestamp);

-- Define the default state for reviews when written by a customer
DELETE FROM configuration where configuration_key = 'DEFAULT_REVIEW_STATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Default state for reviews', 'DEFAULT_REVIEW_STATE', '0', 'Allows you to make reviews visible only after approval if initial state is set to 1', 18, 10, 'integer(0,null)', current timestamp);

-- Add state attribute to reviews table
ALTER TABLE reviews ADD state int DEFAULT 0 NOT NULL;

-- Reviews Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_reviews', 'Maintain Product Reviews', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_prod_reviews', 'Product Reviews for Product', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_cust_reviews', 'Product Reviews for Customer', current timestamp);

-- Add Reviews Panel access to all roles that can access the Product panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prod_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_cust_reviews';

-- getReviews API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getReviews','', current timestamp);

-- For storing all messages in the database
DROP TABLE kk_msg;
CREATE TABLE kk_msg (
  msg_key VARCHAR(100) NOT NULL,
  msg_locale VARCHAR(10) NOT NULL,
  msg_type INTEGER NOT NULL,
  msg_value VARCHAR(7000),
  PRIMARY KEY(msg_key,msg_type,msg_locale)
);

-- Add locale to languages table
ALTER TABLE languages ADD locale varchar(10);
UPDATE languages SET locale = code;
UPDATE languages SET locale = 'en_GB' where code = 'en';
UPDATE languages SET locale = 'de_DE' where code = 'de';
UPDATE languages SET locale = 'es_ES' where code = 'es';
UPDATE languages SET locale = 'pt_BR' where code = 'pt';

-- Messages Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_messages', 'Maintain Application Messages', current timestamp);

-- Grant access to Messages Panel to the Super Admin and the Standard Admin Users
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 1, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_messages';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added) SELECT 5, panel_id, 1,1,1, current timestamp FROM kk_panel WHERE code = 'kk_panel_messages';

-- Config variable to define the Message Types allowed in the System
DELETE FROM configuration where configuration_key = 'MESSAGE_TYPES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Message Types', 'MESSAGE_TYPES', 'Application,AdminApp,AdminAppHelp', 'Used to populate the Message Types droplist in the Messages section', 21, 41, current timestamp);

-- Config variable to define whether we use files (the default) or the database for storing system messages
DELETE FROM configuration where configuration_key = 'USE_DB_FOR_MESSAGES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Use D/B For Messages', 'USE_DB_FOR_MESSAGES', 'false', 'If true use the Database for the system messsages, if false use file-based messages', 21, 40, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- New Messages APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'searchMsg','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMsgValue','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteMsg','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertMsg','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateMsg','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'importMsgs','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'exportMsgs','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguageById','', current timestamp);

-- Add indexes on product table
CREATE INDEX i_ma_1ae76e2a2f877 ON products (manufacturers_id);

-- Add new attribute to address_book table
ALTER TABLE address_book ADD manufacturers_id int DEFAULT 0 NOT NULL;

-- Address Panel
--INSERT INTO kk_panel (code, description, date_added) VALUES ('kk_panel_address', 'All Addresses', now());
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_prod_address', 'Product Addresses', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_manu_address', 'Manufacturer Addresses', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_cust_address', 'Customer Addresses', current timestamp);

-- Add Address Panel access to all roles that can access the Customer panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_prod_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_manu_address';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_cust_address';

-- Table to connect products to addresses
DROP TABLE kk_addr_to_product;
CREATE TABLE kk_addr_to_product (
  store_id VARCHAR(64),
  address_book_id INTEGER NOT NULL,
  products_id INTEGER NOT NULL,
  relation_type INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(address_book_id,products_id)
);

-- Configuration for address select panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDR_SEL_NUM_ADDRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Address Select Default Num Addrs', 'ADMIN_APP_ADDR_SEL_NUM_ADDRS', '50', 'Sets the default number of addresses displayed in the address select dialogs when opened', 21, 50, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_ADDR_SEL_MAX_NUM_ADDRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Address Select Max Num Addrs', 'ADMIN_APP_ADDR_SEL_MAX_NUM_ADDRS', '100', 'Sets the maximum number of addresses displayed in the address select dialogs after a search', 21, 51, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_SELECT_PROD_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Addr Format for Prod Addr Sel', 'ADMIN_APP_SELECT_PROD_ADDR_FORMAT', '$company $street $street1 $suburb $city $state $country', 'How the address is formatted in the product select address panel', 21, 0, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Addr Format for Prod Addr', 'ADMIN_APP_PROD_ADDR_FORMAT', '$company $street $street1 $suburb $city $state $country', 'How the address is formatted in the product address panel', 21, 0, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUST_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Addr Format for Cust Addr', 'ADMIN_APP_CUST_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the customer address panel', 21, 0, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Addr Format for Manu Addr', 'ADMIN_APP_MANU_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the manufacturer address panel', 21, 0, current timestamp);

-- New address related API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addAddressesToProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeAddressFromProduct','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductCountPerAddress','', current timestamp);

-- New Manufacturer API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getManufacturers','', current timestamp);

-- New Product Option API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductOptions','', current timestamp);

-- Configuration for manufacturer panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_SEL_NUM_MANUS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Manufacturer Panel Default Num Manus', 'ADMIN_APP_MANU_SEL_NUM_MANUS', '50', 'Sets the default number of manufacturers displayed in the manufacturer panels and dialogs when opened', 21, 52, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_MANU_SEL_MAX_NUM_MANUS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Manufacturer Panel Max Num Manus', 'ADMIN_APP_MANU_SEL_MAX_NUM_MANUS', '100', 'Sets the maximum number of manufacturers displayed in the manufacturer panels and dialogs after a search', 21, 53, current timestamp);

-- Configuration for product option panel in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_OPT_SEL_NUM_PROD_OPTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Prod Option Panel Default Num Prod Opts', 'ADMIN_APP_PROD_OPT_SEL_NUM_PROD_OPTS', '50', 'Sets the default number of product options displayed in the prod option panel when opened', 21, 54, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_OPT_SEL_MAX_NUM_PROD_OPTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Prod Option Panel Max Num Prod Opts', 'ADMIN_APP_PROD_OPT_SEL_MAX_NUM_PROD_OPTS', '100', 'Sets the maximum number of product options displayed in the prod option panel after a search', 21, 55, current timestamp);

-----------------  v5.3.0.0

-- Tables for Custom Product Attributes
DROP TABLE kk_cust_attr;
CREATE TABLE kk_cust_attr (
  kk_cust_attr_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  name VARCHAR(64) NOT NULL,
  msg_cat_key VARCHAR(128),
  attr_type integer DEFAULT -1,
  template VARCHAR(128),
  validation VARCHAR(512),
  set_function VARCHAR(512),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_cust_attr_id)
   );
DROP SEQUENCE kk_cust_attr_SEQ;
CREATE SEQUENCE kk_cust_attr_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE kk_cust_attr_tmpl;
CREATE TABLE kk_cust_attr_tmpl (
  kk_cust_attr_tmpl_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  name VARCHAR(64) NOT NULL,
  description VARCHAR(255),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_cust_attr_tmpl_id)
   );
DROP SEQUENCE kk_cust_attr_tmpl_SEQ;
CREATE SEQUENCE kk_cust_attr_tmpl_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE kk_tmpl_to_cust_attr;
CREATE TABLE kk_tmpl_to_cust_attr (
  kk_cust_attr_tmpl_id INTEGER DEFAULT 0 NOT NULL,
  kk_cust_attr_id INTEGER DEFAULT 0 NOT NULL,
  store_id VARCHAR(64),
  sort_order INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(kk_cust_attr_tmpl_id, kk_cust_attr_id)
);

-- Custom product attribute panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_prodAttrTemplates', 'Product Custom Attribute Templates', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_prodAttrDescs', 'Product Custom Attributes', current timestamp);

-- Add Panel access to all roles that can access the Product maintenance panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prodAttrTemplates';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prodAttrDescs';

-- New Product Custom Attribute APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteProdAttrDesc','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteProdAttrTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrDesc','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrDescs','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrDescsForTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrTemplates','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertProdAttrDesc','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertProdAttrTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateProdAttrDesc','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateProdAttrTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeProdAttrDescsFromTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addProdAttrDescsToTemplate','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTemplateCountPerProdAttrDesc','', current timestamp);

-- Configuration for select product custom attr panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ATTR_SEL_NUM_PROD_ATTRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Prod Custom Attr Panel Default Num Attrs', 'ADMIN_APP_PROD_ATTR_SEL_NUM_PROD_ATTRS', '50', 'Sets the default number of product attributes displayed in the product attribute dialogs when opened', 21, 56, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_PROD_ATTR_SEL_MAX_NUM_PROD_ATTRS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Prod Custom Attr Panel Max Num Attrs', 'ADMIN_APP_PROD_ATTR_SEL_MAX_NUM_PROD_ATTRS', '100', 'Sets the maximum number of product attributes displayed in the product attribute dialogs after a search', 21, 57, current timestamp);

-- Configuration for select template panels in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_TMPL_SEL_NUM_TMPLS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Template Panel Default Num Templates', 'ADMIN_APP_TMPL_SEL_NUM_TMPLS', '50', 'Sets the default number of templates displayed in the select template dialogs when opened', 21, 58, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_TMPL_SEL_MAX_NUM_TMPLS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Template Panel Max Num Templates', 'ADMIN_APP_TMPL_SEL_MAX_NUM_TMPLS', '100', 'Sets the maximum number of templatess displayed in the select template dialogs after a search', 21, 59, current timestamp);

-- Add template / custom attribute attributes to product
ALTER TABLE products ADD cust_attr_tmpl_id int DEFAULT -1;
ALTER TABLE products ADD custom_attrs VARCHAR(4000);

-- Demo data for Custom product attributes
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'radio', 'label.size', 0, null, null, 'choice(''label.small'',''label.medium'',''label.large'')', current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'true-false', 'label.true.false', 4, null, 'true|false', null, current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'dropList', 'label.size', 0, null, null, 'option(s=label.small,m=label.medium,l=label.large)', current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'integer-1-to-10', null, 1, null, null, 'integer(1,10)', current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'any-int', null, 1, null, null, 'integer(null,null)', current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'decimal-1.5-to-2.3', null, 2, null, null, 'double(1.5,2.3)', current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'string-length-4', null, 0, null, null, 'string(4,4)', current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'date-dd/MM/yyyy', null, 3, 'dd/MM/yyyy', '^(((0[1-9]|[12]\d|3[01])\/(0[13578]|1[02])\/((1[6-9]|[2-9]\d)\d{2}))|((0[1-9]|[12]\d|30)\/(0[13456789]|1[012])\/((1[6-9]|[2-9]\d)\d{2}))|((0[1-9]|1\d|2[0-8])\/02\/((1[6-9]|[2-9]\d)\d{2}))|(29\/02\/((1[6-9]|[2-9]\d)(0[48]|[2468][048]|[13579][26])|((16|[2468][048]|[3579][26])00))))$', null, current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, custom1, custom2, custom3, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'any-string-use-custom', null, 0, null, null, null, 'c1', 'c2', 'c3', current timestamp);

-- Configuration variable for defining the way searches are done - for Oracle CLOB support etc
DELETE FROM configuration WHERE configuration_key = 'FETCH_PRODUCT_DESCRIPTIONS_SEPARATELY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Fetch Descriptions Separately', 'FETCH_PRODUCT_DESCRIPTIONS_SEPARATELY', 'false', 'Fetch Product Descriptions Separately', 9, 30, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Customer tags for preferences
DELETE FROM kk_customer_tag WHERE name ='PROD_PAGE_SIZE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'PROD_PAGE_SIZE', 'The page size for product lists', 1, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='ORDER_PAGE_SIZE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'ORDER_PAGE_SIZE', 'The page size for order lists', 1, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='REVIEW_PAGE_SIZE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'REVIEW_PAGE_SIZE', 'The page size for review lists', 1, 1, current timestamp);

-- Add a Message Catalog Key to the countries table to allow country names in multiple languages - default the value of this to 'CTRY.' + ISO-3 value
ALTER TABLE countries ADD msgCatKey VARCHAR(32);
UPDATE countries set msgCatKey = CONCAT('CTRY.',countries_iso_code_3);

-- Configuration variable for defining whether to look up country names in the message catalog or not
DELETE FROM configuration WHERE configuration_key = 'USE_MSG_CAT_FOR_COUNTRY_NAMES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  set_function, date_added) VALUES (nextval for configuration_seq, 'Use Country Names in Msg Cat', 'USE_MSG_CAT_FOR_COUNTRY_NAMES', 'false', 'Use the Country Names in the Message Catalogues', 1, 29, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Table for storing customer statistics data
DROP TABLE kk_cust_stats;
CREATE TABLE kk_cust_stats (
  cust_stats_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  customers_id INTEGER DEFAULT 0,
  event_type INTEGER DEFAULT 0,
  data1Str VARCHAR(128),
  data2Str VARCHAR(128),
  data1Int int,
  data2Int int,
  data1Dec decimal(15,4),
  data2Dec decimal(15,4),
  date_added TIMESTAMP NOT NULL,
  PRIMARY KEY(cust_stats_id)
   );
DROP SEQUENCE kk_cust_stats_SEQ;
CREATE SEQUENCE kk_cust_stats_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Enable / Disable customer event functionality from application
DELETE FROM configuration WHERE configuration_key = 'ENABLE_CUSTOMER_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Customer Event functionality', 'ENABLE_CUSTOMER_EVENTS', 'false', 'When set to true, the application inserts customer events. All event functionality is disabled when false.', 5, 9, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- Visibility of Customers - Customers are visible by default
ALTER TABLE customers ADD invisible INTEGER NOT NULL DEFAULT 0;

-- Virtual Customer 2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customers_2', 'Customers 2', current timestamp);

-- Add Panel access to all roles that can access the Customer panel - default to not allow access to invisible customers
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, 0, 'Set to Access Invisible Customers', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customers_2';

-- New Admin Payment Module API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'callPaymentModule','', current timestamp);

-----------------  v5.4.0.0

-- Delete the Rich Text selection configuration variable since no longer used
DELETE FROM configuration where configuration_key = 'RICH_TEXT_EDITOR';

-- Extend the size of the products_name field
ALTER TABLE products_description ALTER COLUMN products_name SET DATA TYPE VARCHAR(150);

-- For the New Google Shopping Interface
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_DATA_ACCOUNT_ID';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google Shopping Account Id', 'GOOGLE_DATA_ACCOUNT_ID', '', 'Account Id (obtain from Google) for populating Google Shopping with Product Information', '23', '3', now());

-- Move the two Google Base configs to the end
--UPDATE configuration set sort_order = 100 where configuration_key = 'GOOGLE_API_KEY';
--UPDATE configuration set sort_order = 101 where configuration_key = 'GOOGLE_DATA_LOCATION';

-- For defining the height of the Custom Panels
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_CUSTOM_PANEL_HEIGHT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Custom Panel Height', 'ADMIN_APP_CUSTOM_PANEL_HEIGHT', '500px', 'Custom Panel Height eg. 100% or 700px etc', 22, 20,  current timestamp);

--Add tax code to tax_class table and order_product
ALTER TABLE tax_class ADD tax_code VARCHAR(64);
ALTER TABLE orders_products ADD tax_code VARCHAR(64);

--Add lifecycle_id to order table
ALTER TABLE orders ADD lifecycle_id VARCHAR(128);

-- Add custom fields to product to stores
ALTER TABLE kk_product_to_stores ADD custom1 varchar(128);
ALTER TABLE kk_product_to_stores ADD custom2 varchar(128);
ALTER TABLE kk_product_to_stores ADD custom3 varchar(128);

-- Add custom privileges for the Customer and CustomerForOrder panels - default to allow access to Reviews button
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder');
-- Virtual CustomerForOrder 2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customerForOrder_2', 'Customer For Order 2', current timestamp);

-- Add Panel access to all roles that can access the CustomerForOrders panel - default to not allow access to invisible customers
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, 0, 'Set to Access Invisible Customers', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customerForOrder' and p2.code='kk_panel_customerForOrder_2';

-- Add custom privileges for the Customer2 and CustomerForOrder2 panels - default to allow access to Reviews button
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder_2');

-- Add custom privileges for the Customer and CustomerForOrder panels - default to allow access to login button
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder');

-- Add custom privileges for the Customer and CustomerForOrder panels - default to allow access to Addresses button
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers');
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder');

-- Add custom privileges for the CustomerOrders panel - default to allow access to Packing List and Invoice buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set packing list button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerOrders');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set invoice button not shown'      WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerOrders');

-- Add custom privileges for the Promotions panel - default to allow access to Coupons and Gift Certificates buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set coupons button not shown'           WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_promotions');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set gift certificates button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_promotions');

-- Add custom privileges for the Products panel - default to allow access to Reviews and Addresses buttons
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set reviews button not shown'   WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set addresses button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');

-- For defining the number of suggested search terms to show
DELETE FROM configuration WHERE configuration_key = 'MAX_NUM_SUGGESTED_SEARCH_ITEMS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Suggested Search Items','MAX_NUM_SUGGESTED_SEARCH_ITEMS','10','Max number of suggested search items to display',3, 3,'integer(0,null)', current timestamp);

-- Table for bookable products
DROP TABLE kk_bookable_prod;
CREATE TABLE kk_bookable_prod (
  products_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  start_date TIMESTAMP NOT NULL,
  end_date TIMESTAMP NOT NULL,
  max_num_bookings INTEGER DEFAULT -1,
  bookings_made INTEGER DEFAULT 0,
  monday VARCHAR(128),
  tuesday VARCHAR(128),
  wednesday VARCHAR(128),
  thursday VARCHAR(128),
  friday VARCHAR(128),
  saturday VARCHAR(128),
  sunday VARCHAR(128),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  PRIMARY KEY(products_id)
);

-- Table for bookings
DROP TABLE kk_booking;
CREATE TABLE kk_booking (
  booking_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  products_id INTEGER NOT NULL,
  quantity INTEGER DEFAULT 0,
  customers_id INTEGER DEFAULT 0,
  orders_id INTEGER DEFAULT 0,
  orders_products_id INTEGER DEFAULT 0,
  firstname VARCHAR(32),
  lastname VARCHAR(32),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  date_added TIMESTAMP,
  PRIMARY KEY(booking_id)
);
DROP SEQUENCE kk_booking_SEQ;
CREATE SEQUENCE kk_booking_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;


-----------------  v5.5.0.0

-- New Bookings Panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_bookingsForOrder', 'Bookings For Order', current timestamp);
-- Add access to the Bookings Panel to all roles that can access the Orders panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_bookingsForOrder';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_bookingsForProduct', 'Bookings For Product', current timestamp);
-- Add access to the Bookings Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_bookingsForProduct';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_bookingsForCustomer', 'Bookings For Customer', current timestamp);
-- Add access to the Bookings Panel to all roles that can access the Customers panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_bookingsForCustomer';

-- Add active flag on countries table
ALTER TABLE countries ADD active int DEFAULT 1 NOT NULL;
UPDATE countries SET active = 1;

-- store address ids in order table
ALTER TABLE orders ADD billing_addr_id int DEFAULT -1;
ALTER TABLE orders ADD delivery_addr_id int DEFAULT -1;
ALTER TABLE orders ADD customer_addr_id int DEFAULT -1;

-- New Product Catalog Definition Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_catalogs', 'Product Catalog Definitions', current timestamp);
-- Add access to the Bookings Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_catalogs';

-----------------  v5.6.0.0

-- New Other Modules Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_otherModules', 'Other Modules Configuration', current timestamp);
-- Add access to the Other Modules Panel to all roles that can access the Payment Modules panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_paymentModules' and p2.code='kk_panel_otherModules';

-- For defining the list of Other modules installed
DELETE FROM configuration WHERE configuration_key = 'MODULE_OTHERS_INSTALLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Installed Other Modules','MODULE_OTHERS_INSTALLED','','List of Other modules separated by a semi-colon.  Automatically updated.  No need to edit.',6, 0, current timestamp);

-----------------  v5.7.0.0

-- Add custom fields to Order Total
ALTER TABLE orders_total ADD custom1 varchar(128);
ALTER TABLE orders_total ADD custom2 varchar(128);
ALTER TABLE orders_total ADD custom3 varchar(128);

-- Add creator field to order
ALTER TABLE orders ADD order_creator varchar(128);

-----------------  v5.7.5.0

-- Configuration variable to define how to format the URLs for SEO
DELETE FROM configuration WHERE configuration_key = 'SEO_URL_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'How to format the URLs for SEO', 'SEO_URL_FORMAT', '2', 'Decide the format of the URLs for SEO', 1, 30, 'option(0=OFF,1=SEO Parameters,2=SEO Directory Structure)', current timestamp);

-- Configuration variables for defining-store front base paths
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store-Front base','STORE_FRONT_BASE','/konakart','Base directory used in JSPs for store-front application',4, 12, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_IMG_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store-Front image base','STORE_FRONT_IMG_BASE','/konakart/images','Image base used in JSPs for store-front application',4, 13, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store-Front script base','STORE_FRONT_SCRIPT_BASE','/konakart/script','Script base used in JSPs for store-front application',4, 14, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Store-Front style sheet base','STORE_FRONT_STYLE_BASE','/konakart/styles','Style sheet base used in JSPs for store-front application',4, 15, current timestamp);

-- New doesProductExist Admin API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'doesProductExist','', current timestamp);

-- Extend the size of the categories_name field
ALTER TABLE categories_description ALTER COLUMN categories_name SET DATA TYPE VARCHAR(150);

-----------------  v5.8.0.0

-- Extend the size of the products_name field
ALTER TABLE orders_products ALTER COLUMN products_name SET DATA TYPE VARCHAR(150);

-- Table to facilitate SSO
DROP TABLE kk_sso;
CREATE TABLE kk_sso (
  kk_sso_id INTEGER NOT NULL,
  secret_key VARCHAR(50) NOT NULL,
  customers_id INTEGER DEFAULT 0,
  sesskey VARCHAR(32),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_sso_id)
);
DROP SEQUENCE kk_sso_SEQ;
CREATE SEQUENCE kk_sso_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add sort order to the kk_category_to_tag_group table
ALTER TABLE kk_category_to_tag_group ADD sort_order int DEFAULT 0 NOT NULL;

-- Add facet number to the kk_cust_attr table
ALTER TABLE kk_cust_attr ADD facet_number int DEFAULT 0 NOT NULL;

-- Add facet number to the kk_tag_group table
ALTER TABLE kk_tag_group ADD facet_number int DEFAULT 0 NOT NULL;

-- Table for Miscellaneous Item Types
DROP TABLE kk_misc_item_type;
CREATE TABLE kk_misc_item_type (
  kk_misc_item_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name VARCHAR(128),
  description VARCHAR(256),
  store_id VARCHAR(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_misc_item_type_id, language_id)
);

-- Table for Miscellaneous Item Type Associations
DROP TABLE kk_misc_item;
CREATE TABLE kk_misc_item (
  kk_misc_item_id INTEGER NOT NULL,
  kk_obj_id INTEGER NOT NULL,
  kk_obj_type_id INTEGER NOT NULL,
  kk_misc_item_type_id INTEGER NOT NULL,
  item_value VARCHAR(512),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  store_id VARCHAR(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_misc_item_id)
);
DROP SEQUENCE kk_misc_item_SEQ;
CREATE SEQUENCE kk_misc_item_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- New Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductCountPerProdAttrDesc','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateProductsUsingProdAttrDesc','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateProductsUsingTemplates','', current timestamp);

-- New Miscellaneous Item Types Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_miscItemTypes', 'Miscellaneous Item Types', current timestamp);
-- Add access to the Miscellaneous Item Types Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_miscItemTypes';

-- New Miscellaneous Items Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_miscItems', 'Miscellaneous Items', current timestamp);
-- Add access to the Miscellaneous Items Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_miscItems';

-- New Miscellaneous Items For Categories Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_cat_miscItems', 'Miscellaneous Category Items', current timestamp);
-- Add access to the Miscellaneous Items for Categories Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_cat_miscItems';

-- New Miscellaneous Items For Products Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_prod_miscItems', 'Miscellaneous Product Items', current timestamp);
-- Add access to the Miscellaneous Items for Products Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_prod_miscItems';

-- New Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertMiscItemType','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateMiscItemType','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteMiscItemType','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMiscItemTypes','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertMiscItems','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateMiscItems','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteMiscItem','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMiscItems','', current timestamp);

-- Demo data for Rich Text custom attribute
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'RichText', null, 0, null, null, 'RichText(8)', current timestamp);

-- Install Digital Download Shipping Module
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Enable Digital Downloads', 'MODULE_SHIPPING_DD_STATUS', 'True', 'Set it to true if you sell digital downloads', 6, 0, 'choice(''true''=''true'',''false''=''false'')', current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sort Order', 'MODULE_SHIPPING_DD_SORT_ORDER', '0', 'Sort order of display.', 6, 0, current timestamp);
UPDATE configuration set configuration_value = 'DigitalDownload;flat.php' where configuration_key = 'MODULE_SHIPPING_INSTALLED';

-----------------  v6.0.0.0

-- Add new attributes to ipn_history table
ALTER TABLE ipn_history ADD transaction_type varchar(128);
ALTER TABLE ipn_history ADD transaction_amount decimal(15,4);
ALTER TABLE ipn_history ADD custom1 varchar(128);
ALTER TABLE ipn_history ADD custom2 varchar(128);
ALTER TABLE ipn_history ADD custom3 varchar(128);
ALTER TABLE ipn_history ADD custom4 varchar(128);
ALTER TABLE ipn_history ADD custom1Dec decimal(15,4);
ALTER TABLE ipn_history ADD custom2Dec decimal(15,4);

-- Extend the size of the product option and option value fields
ALTER TABLE products_options ALTER COLUMN products_options_name SET DATA TYPE VARCHAR(64);
ALTER TABLE orders_products_attributes ALTER COLUMN products_options SET DATA TYPE VARCHAR(64);
ALTER TABLE orders_products_attributes ALTER COLUMN products_options_values SET DATA TYPE VARCHAR(64);

-- Add a new product option type
ALTER TABLE products_options ADD option_type int DEFAULT 0 NOT NULL;
ALTER TABLE customers_basket_attrs ADD attr_type int DEFAULT 0 NOT NULL;
ALTER TABLE customers_basket_attrs ADD attr_quantity int DEFAULT 0;
ALTER TABLE customers_basket_attrs ADD customers_basket_id int DEFAULT 0 NOT NULL;
ALTER TABLE orders_products_attributes ADD attr_type int DEFAULT 0 NOT NULL;
ALTER TABLE orders_products_attributes ADD attr_quantity int DEFAULT 0;

-----------------  v6.1.0.0

-- Product attributes to manage catalog maintenance workflow
ALTER TABLE products ADD product_uuid varchar(128) DEFAULT NULL;
ALTER TABLE products ADD source_last_modified TIMESTAMP DEFAULT NULL;
CREATE INDEX i_pr_1ae76e2a2f877 ON products (product_uuid);

-- New Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'copyProductToStore','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductsToSynchronize','', current timestamp);

-- New Synchronize Products Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_syncProducts', 'Synchronize Products', current timestamp);
-- Add access to the Synchronize Products Panel to all roles that can access the Products panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_syncProducts';

-- Add attribute to allow display only languages that are not used to define language variants for products etc
ALTER TABLE languages ADD display_only int DEFAULT 0;
UPDATE languages SET display_only = 0;

-- New Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguageForLocale','', current timestamp);

-----------------  v6.2.0.0

-- New View Logs Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_viewLogs', 'View Logs', current timestamp);
-- Add access to the View Logs Panel to all roles that can access the Configuration Files panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, custom1, custom1_desc, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 0, 0, 'Set to hide the View button', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_configFiles' and p2.code='kk_panel_viewLogs';

-- Modify tag type of BIRTH_DATE to AGE_TYPE
DELETE FROM kk_customer_tag WHERE name ='BIRTH_DATE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'BIRTH_DATE', 'Age of Customer', 6, 5, current timestamp);
-- Add last login date tag
DELETE FROM kk_customer_tag WHERE name ='LOGIN_DATE';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'LOGIN_DATE', 'Time of Last Login', 6, 5, current timestamp);

-- Allow null values for entry_firstname and entry_lastname on addresses (useful for Manufacturer addresses particularly)
ALTER TABLE address_book ALTER COLUMN entry_firstname DROP NOT NULL;
ALTER TABLE address_book ALTER COLUMN entry_lastname DROP NOT NULL;
-- For DB2 Only - Required after setting field to nullable
call SYSPROC.ADMIN_CMD ('REORG TABLE address_book');

-- Table for KonaKart Config Values
DROP TABLE kk_config;
CREATE TABLE kk_config (
  kk_config_id INTEGER NOT NULL,
  kk_config_key VARCHAR(16),
  kk_config_value VARCHAR(256),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_config_id)
);
DROP SEQUENCE kk_config_SEQ;
CREATE SEQUENCE kk_config_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- New Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getConfigData','', current timestamp);

-- Customer from Reviews Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customerForReview', 'Customer From Reviews', current timestamp);

-- Add access to the Customer from Reviews Panel to all roles that can access the Customers panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customerForReview';
-- Add "Updated By Customer Id" to the Orders Status History table to record who updated the order
ALTER TABLE orders_status_history ADD updated_by_id int DEFAULT 0;

-- New Admin API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateOrder','', current timestamp);

-----------------  v6.3.0.0

-- New Admin API call - to get the version of the KonaKart Admin Engine
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getKonaKartAdminVersion','', current timestamp);

-- Add affiliate id field to order
ALTER TABLE orders ADD affiliate_id varchar(128);

-- For specifying whether or not to return configuration parameters in API calls
ALTER TABLE configuration ADD return_by_api INTEGER NOT NULL DEFAULT 0;

-- Set some defaults by configuration_group
UPDATE configuration set return_by_api = 1 where configuration_group_id in (1, 2, 3, 4, 5, 11, 19);
UPDATE configuration set return_by_api = 1 where configuration_key in ('ADMIN_CURRENCY_DECIMAL_PLACES', 'CLIENT_CONFIG_CACHE_CHECK_FLAG', 'DEFAULT_CURRENCY', 'DEFAULT_LANGUAGE');
UPDATE configuration set return_by_api = 1 where configuration_key in ('ALLOW_BASKET_PRICE', 'DEFAULT_REVIEW_STATE', 'ENABLE_ANALYTICS', 'ENABLE_SSL', 'SSL_BASE_URL');
UPDATE configuration set return_by_api = 1 where configuration_key in ('ENABLE_PDF_INVOICE_DOWNLOAD', 'ENABLE_REWARD_POINTS', 'SSL_PORT_NUMBER', 'STANDARD_PORT_NUMBER');
UPDATE configuration set return_by_api = 1 where configuration_key in ('SEND_EMAILS', 'SEND_ORDER_CONF_EMAIL', 'USE_DB_FOR_MESSAGES');
UPDATE configuration set return_by_api = 1 where configuration_key in ('STOCK_CHECK', 'STOCK_ALLOW_CHECKOUT', 'ALLOW_MULTIPLE_BASKET_ENTRIES');
UPDATE configuration set return_by_api = 1 where configuration_key in ('USE_SOLR_SEARCH');

-- Extend the size of the city columns
ALTER TABLE address_book ALTER COLUMN entry_city SET DATA TYPE VARCHAR(64) ;
ALTER TABLE orders ALTER COLUMN customers_city SET DATA TYPE VARCHAR(64) ;
ALTER TABLE orders ALTER COLUMN delivery_city SET DATA TYPE VARCHAR(64) ;
ALTER TABLE orders ALTER COLUMN billing_city SET DATA TYPE VARCHAR(64) ;
ALTER TABLE kk_wishlist ALTER COLUMN customers_city SET DATA TYPE VARCHAR(64);

-- Regex for SOLR suggested search
DELETE FROM configuration WHERE configuration_key = 'SOLR_TERMS_PRE_REGEX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Suggested Search prepend regex','SOLR_TERMS_PRE_REGEX','.*','Regex prepended to search string used for searching within SOLR term',24, 100, current timestamp, 0);
DELETE FROM configuration WHERE configuration_key = 'SOLR_TERMS_POST_REGEX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Suggested Search append regex','SOLR_TERMS_POST_REGEX','.*','Regex appended to search string used for searching within SOLR term',24, 110, current timestamp, 0);
DELETE FROM configuration WHERE configuration_key = 'SOLR_DELETE_ON_COMMIT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Delete from index on commit','SOLR_DELETE_ON_COMMIT','true','On commit, delete from index products marked for deletion',24, 70, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);

-----------------  v6.4.0.0

-- Set some defaults by configuration_group
UPDATE configuration set return_by_api = 1 where configuration_group_id in (26);

-- Return the STOCK_REORDER_LEVEL configuration variable
UPDATE configuration set return_by_api = 1 where configuration_key in ('STOCK_REORDER_LEVEL');

-- Admin API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'editProductWithOptions','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertProductWithOptions','', current timestamp);

-- Save payment module sub-code information with the order
ALTER TABLE orders ADD payment_module_subcode varchar(64);

-- Add number of reviews to product table
ALTER TABLE products ADD number_reviews int DEFAULT 0;

-- Change the email address for John Doe
UPDATE customers SET customers_email_address = 'doe@konakart.com' where customers_email_address = 'root@localhost';

-- Change previous occurrences of root@localhost
UPDATE configuration SET configuration_value = 'admin@konakart.com' where configuration_value = 'root@localhost' and configuration_key = 'STORE_OWNER_EMAIL_ADDRESS';
UPDATE configuration SET configuration_value = 'admin@konakart.com' where configuration_value = 'KonaKart <root@localhost>' and configuration_key = 'EMAIL_FROM';

-----------------  v6.5.0.0

-- New Canon Printer

INSERT INTO products (products_id, products_model, products_image, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'LBP7680CX', 'canon/lbp7680cx.jpg', 309.99, 44.00, 1, 1, 6, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 1, 'Canon I-SENSYS LBP7680CX Printer','- Print Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 2, 'Canon I-SENSYS LBP7680CX Drucker','- Drucker Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 3, 'Canon I-SENSYS LBP7680CX Impresora','- Impresora Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (30, 4, 'Canon I-SENSYS LBP7680CX Impressora','- Impressora Speed: Up to 20 ppm<br>- Max Resolution ( Colour ): 9600 dpi x 600 dpi<br>- Total Media Capacity: 300 sheets<br>- Interface: USB, Ethernet','http://www.canon.co.uk/For_Home/Product_Finder/Printers/Laser/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (30,5);

-- Update Laserjet Printer

UPDATE products SET products_price=65.00, products_image='hewlett_packard/hp5510e.jpg' WHERE products_model='HPLJ1100XI';
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(English Version) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=1;
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(Deutsch Version) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=2;
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(Versi??n en Espa??ol) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=3;
UPDATE products_description set products_name='HP Photosmart 5510 e', products_url='http://www.shopping.hp.com/en_US/home-office/-/products/Printers/Printers', products_description='HP Photosmart 5510 e-All-in-One with Photo value pack<br>(Vers??o em Portugu??s) Print, scan, copy and browse the Web with one convenient device<br>Enjoy speeds of up to 11 ppm black, 7.5 colour<br>Large 80-sheet input tray, 15-sheet output tray<br>Share with and print from multiple PCs via the integrated wireless' WHERE products_name='Hewlett Packard LaserJet 1100Xi' AND language_id=4;

-- New Logitech Keyboard

INSERT INTO products (products_id, products_model, products_image, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'LOGITECHIK', 'logitech/p800-0148872.jpg', 75.99, 6.00, 1, 1, 5, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 1, 'Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 2, '(DE) Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 3, '(ES) Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (31, 4, '(PT) Logitech Illuminated Keyboard','- Ultra Thin: 9.3 mm profile and transparent frame<br>- Bright, laser-etched, backlighted keys<br>- Sleek, minimalist design<br>- One-touch multimedia controls','http://www.logitech.com/en-gb/keyboards',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (31,8);

-- Replace The Replacement Killers with Hunger Games - new Lionsgate Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Lionsgate','manufacturer/lionsgate.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 1, 'http://www.lionsgate.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 2, 'http://www.lionsgate.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 3, 'http://www.lionsgate.com', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (11, 4, 'http://www.lionsgate.com', 0, null);
UPDATE products SET products_price=24.99, manufacturers_id=11 WHERE products_model='DVD-RPMK';
UPDATE products_description SET products_name='The Hunger Games', products_url='http://www.scholastic.com/thehungergames/' WHERE products_id=4;

-- Replace Courage Under Fire with Titanic

UPDATE products_description set products_name='Titanic', products_url='http://www.titanicmovie.com/' WHERE products_id=16;

-- Replace Beloved with Dark Knight

UPDATE products_description SET products_name='The Dark Knight', products_url='http://thedarkknight.warnerbros.com' WHERE products_id=20;

-- Replace Fire Down Below with Harry Potter

UPDATE products_description SET products_name='Harry Potter - The Goblet of Fire', products_url='http://harrypotter.warnerbros.co.uk/gobletoffire/master/' WHERE products_id=11;

-- For new Struts2 storefront

-- Maximum number of special price products to cache in client engine
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, return_by_api, date_added) VALUES (nextval for configuration_seq, 'Special Price Products', 'MAX_DISPLAY_SPECIALS', '9', 'Maximum number of special price products to cache', 3, 5, 'integer(0,null)', 1, current timestamp);
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, return_by_api, date_added) VALUES (nextval for configuration_seq, 'Stock warn level', 'STOCK_WARN_LEVEL', '5', 'Warn customer when stock reaches this level', 9, 5, 'integer(null,null)', 1, current timestamp);

-- Modify some configuration variables
UPDATE configuration SET configuration_value = '10', configuration_description = 'Maximum number of latest products to cache' WHERE configuration_key = 'MAX_DISPLAY_NEW_PRODUCTS';
UPDATE configuration SET configuration_value = '15' WHERE configuration_key = 'MAX_DISPLAY_MANUFACTURERS_IN_A_LIST';
UPDATE configuration SET configuration_title='KonaKart cache refresh check interval', configuration_description = 'Interval in seconds for checking to see whether to refresh the KonaKart caches' WHERE configuration_key = 'CLIENT_CONFIG_CACHE_CHECK_SECS';
UPDATE configuration SET configuration_description='This allows checkout without registration' WHERE configuration_key = 'ALLOW_CHECKOUT_WITHOUT_REGISTRATION';

-- Add number of reviews to Something about mary
UPDATE products SET number_reviews = 1 WHERE products_id = 19 AND products_model = 'DVD-TSAB';

-- Delete some config variables
DELETE FROM configuration WHERE configuration_key = 'MAX_RANDOM_SELECT_NEW';
DELETE FROM configuration WHERE configuration_key = 'MAX_RANDOM_SELECT_SPECIALS';
DELETE FROM configuration WHERE configuration_key = 'MAX_RANDOM_SELECT_REVIEWS';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_PRODUCTS_IN_ORDER_HISTORY_BOX';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_CATEGORIES_PER_ROW';
DELETE FROM configuration WHERE configuration_key = 'HEADING_IMAGE_WIDTH';
DELETE FROM configuration WHERE configuration_key = 'HEADING_IMAGE_HEIGHT';
DELETE FROM configuration WHERE configuration_key = 'SUBCATEGORY_IMAGE_WIDTH';
DELETE FROM configuration WHERE configuration_key = 'SUBCATEGORY_IMAGE_HEIGHT';
DELETE FROM configuration WHERE configuration_key = 'ENTRY_DOB_MIN_LENGTH';
DELETE FROM configuration WHERE configuration_key = 'ENTRY_EMAIL_ADDRESS_MIN_LENGTH';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_BESTSELLERS';
DELETE FROM configuration WHERE configuration_key = 'CLIENT_CACHE_UPDATE_SECS';
DELETE FROM configuration WHERE configuration_key = 'ONE_PAGE_CHECKOUT';
DELETE FROM configuration WHERE configuration_key = 'SMALL_IMAGE_WIDTH';
DELETE FROM configuration WHERE configuration_key = 'SMALL_IMAGE_HEIGHT';
DELETE FROM configuration WHERE configuration_key = 'MAX_DISPLAY_MANUFACTURER_NAME_LEN';

-- Add data to set up demo for faceted search using Solr. Only for struts2 store-front.
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, facet_number, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'DVD Format', null, 0, null, null, 'option(facet.blu.ray=Blu-ray,facet.hd.dvd=HD-DVD)' ,1, current timestamp);
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, facet_number, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'Movie Ratings', null, 0, null, null, 'option(facet.mpaa.g=General Audience: G,facet.mpaa.pg=Parental Guidance: PG,facet.mpaa.pg.13=Parents Cautioned: PG-13,facet.mpaa.r=Restricted: R,facet.mpaa.nc.17=Adults Only: NC-17)',2, current timestamp);
INSERT INTO kk_cust_attr_tmpl (kk_cust_attr_tmpl_id, name, description, date_added) VALUES (nextval for kk_cust_attr_tmpl_SEQ, 'Movie Template', 'Template for DVD Movies', current timestamp);
INSERT INTO kk_tmpl_to_cust_attr (kk_cust_attr_tmpl_id, kk_cust_attr_id, sort_order) VALUES (1, 11, 0);
INSERT INTO kk_tmpl_to_cust_attr (kk_cust_attr_tmpl_id, kk_cust_attr_id, sort_order) VALUES (1, 12, 1);
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.g]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 4;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.g]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 6;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 9;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.blu.ray]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 10;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg.13]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 11;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.pg.13]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 12;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.r]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 13;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.r]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 17;
UPDATE products SET cust_attr_tmpl_id = 1, custom_attrs='<kk_d><kk_a><kk_v><![CDATA[facet.hd.dvd]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[DVD Format]]></kk_n><kk_k><![CDATA[facet.dvd.format]]></kk_k><kk_f>1</kk_f></kk_a><kk_a><kk_v><![CDATA[facet.mpaa.nc.17]]></kk_v><kk_ty>0</kk_ty><kk_n><![CDATA[Movie Ratings]]></kk_n><kk_k><![CDATA[facet.mpaa.movie.ratings]]></kk_k><kk_f>2</kk_f></kk_a></kk_d>' WHERE products_id = 18;
UPDATE kk_tag_group SET facet_number = 1 where tag_group_id = 2;
UPDATE kk_tag_group SET facet_number = 2 where tag_group_id = 1;

-- Zone update
UPDATE zones SET zone_code='NL', zone_name='Newfoundland and Labrador' where zone_code='NF' and zone_name='Newfoundland' and zone_country_id in (select countries_id from countries WHERE countries_name='Canada');

-- Address book entry updates
UPDATE configuration SET configuration_value = '10' WHERE configuration_key = 'MAX_ADDRESS_BOOK_ENTRIES';

-- Solr faceted search
DELETE FROM configuration WHERE configuration_key = 'SOLR_DYNAMIC_FACETS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Use Solr dynamic facets','SOLR_DYNAMIC_FACETS','false','When true, the displayed facets are valid for only the products returned by the search rather than for all the available products.',24, 80, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);
DELETE FROM configuration WHERE configuration_key = 'PRICE_FACETS_SLIDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Use Slider for price filter','PRICE_FACETS_SLIDER','true','When false, price facets are displayed instead of a slider for filtering a result set by price.',1, 31, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Rename manufacturer images

UPDATE manufacturers SET manufacturers_image = 'manufacturer/matrox.gif'          WHERE manufacturers_image = 'manufacturer_matrox.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/microsoft.gif'       WHERE manufacturers_image = 'manufacturer_microsoft.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/warner.gif'          WHERE manufacturers_image = 'manufacturer_warner.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/fox.gif'             WHERE manufacturers_image = 'manufacturer_fox.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/logitech.gif'        WHERE manufacturers_image = 'manufacturer_logitech.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/canon.gif'           WHERE manufacturers_image = 'manufacturer_canon.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/sierra.gif'          WHERE manufacturers_image = 'manufacturer_sierra.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/gt_interactive.gif'  WHERE manufacturers_image = 'manufacturer_gt_interactive.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/hewlett_packard.gif' WHERE manufacturers_image = 'manufacturer_hewlett_packard.gif';
UPDATE manufacturers SET manufacturers_image = 'manufacturer/konakart.jpg'        WHERE manufacturers_image = 'konakart_tree_logo_60x60.jpg';

-- Change Name of Software Catgeory to Games

UPDATE categories set categories_image = 'no-image.png' where categories_id = 2;
UPDATE categories_description set categories_name = 'Games' where categories_id = 2 and language_id = 1;
UPDATE categories_description set categories_name = 'Games' where categories_id = 2 and language_id = 2;
UPDATE categories_description set categories_name = 'Juegos' where categories_id = 2 and language_id = 3;
UPDATE categories_description set categories_name = 'Jogos' where categories_id = 2 and language_id = 4;

-- Change Name of Hardware Catgeory to Computer Peripherals

UPDATE categories_description set categories_name = 'Computer Peripherals' where categories_id = 1 and language_id = 1;
UPDATE categories_description set categories_name = 'Computer Peripherals' where categories_id = 1 and language_id = 2;
UPDATE categories_description set categories_name = 'Perif??ricos' where categories_id = 1 and language_id = 3;
UPDATE categories_description set categories_name = 'Perif??ricos' where categories_id = 1 and language_id = 4;

-- New Software Catgeory

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 0, 3, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 1, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 2, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 3, 'Software');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (22, 4, 'Software');

-- New Electronics Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 0, 3, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 1, 'Electronics');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 2, 'Elektronik');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 3, 'Electr??nica');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (23, 4, 'Eletr??nica');

-- New Home & Garden Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 0, 3, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 1, 'Home & Garden');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 2, 'Home & Garden');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 3, 'Casa y Jard??n');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (24, 4, 'Casa e Jardim');

-- New Cameras Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 23, 5, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 1, 'Cameras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 2, 'Cameras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 3, 'Cameras');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (25, 4, 'Cameras');

-- New Tablets Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 23, 15, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 1, 'Tablets');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 2, 'Tablets');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 3, 'Tablets');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (26, 4, 'Tablets');

-- New Phones Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 23, 10, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 1, 'Phones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 2, 'Phones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 3, 'Phones');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (27, 4, 'Phones');

-- New Kitchen Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 24, 10, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 1, 'Kitchen');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 2, 'Kitchen');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 3, 'Kitchen');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (28, 4, 'Kitchen');

-- New Clocks Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 24, 5, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 1, 'Clocks');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 2, 'Clocks');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 3, 'Clocks');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (29, 4, 'Clocks');

-- New Lawnmowers Sub-Category

INSERT INTO categories (categories_id, categories_image, parent_id, sort_order, date_added, last_modified) VALUES (nextval for categories_seq, 'no-image.png', 24, 15, current timestamp, null);
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 1, 'Lawnmowers');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 2, 'Lawnmowers');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 3, 'Lawnmowers');
INSERT INTO categories_description (categories_id, language_id, categories_name) VALUES (30, 4, 'Lawnmowers');

-- New Windows 10 Software

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'WIN10', 129.99, 6, 1, 1, 2, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 1, 'Windows 10', 'With fast and hardworking features and new ways to interact with your computer - Windows 10 can help you be efficient and effective.<br>The most secure Windows ever, Windows 10 provides comprehensive protection - at no extra cost.<br>Forget your password. Just use your face or fingerprint to securely and instantly unlock your computer.<br>Your Windows device comes with built-in security features including firewall and internet protections to help safeguard against viruses and ransomware.<br>Encrypt sensitive data, access remote files and many other more advanced tasks.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 2, 'Windows 10', 'With fast and hardworking features and new ways to interact with your computer - Windows 10 can help you be efficient and effective.<br>The most secure Windows ever, Windows 10 provides comprehensive protection - at no extra cost.<br>Forget your password. Just use your face or fingerprint to securely and instantly unlock your computer.<br>Your Windows device comes with built-in security features including firewall and internet protections to help safeguard against viruses and ransomware.<br>Encrypt sensitive data, access remote files and many other more advanced tasks.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 3, 'Windows 10', 'With fast and hardworking features and new ways to interact with your computer - Windows 10 can help you be efficient and effective.<br>The most secure Windows ever, Windows 10 provides comprehensive protection - at no extra cost.<br>Forget your password. Just use your face or fingerprint to securely and instantly unlock your computer.<br>Your Windows device comes with built-in security features including firewall and internet protections to help safeguard against viruses and ransomware.<br>Encrypt sensitive data, access remote files and many other more advanced tasks.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (32, 4, 'Windows 10', 'With fast and hardworking features and new ways to interact with your computer - Windows 10 can help you be efficient and effective.<br>The most secure Windows ever, Windows 10 provides comprehensive protection - at no extra cost.<br>Forget your password. Just use your face or fingerprint to securely and instantly unlock your computer.<br>Your Windows device comes with built-in security features including firewall and internet protections to help safeguard against viruses and ransomware.<br>Encrypt sensitive data, access remote files and many other more advanced tasks.','http://windows.microsoft.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (32, 22);

-- New DeLonghi Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'DeLonghi','manufacturer/delonghi.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 1, 'http://www.delonghi.com/us_en/agency/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 2, 'http://www.delonghi.com/de_de/agency/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 3, 'http://www.delonghi.com/es_es/agency/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (12, 4, 'http://www.delonghi.com/pt_pt/agency/', 0, null);

-- DeLonghi Coffee Maker

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'DLBCO410', 159.99, 9, 1, 1, 12, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 1, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/us_en/family/combi/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 2, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/de_de/family/combi/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 3, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/es_es/family/combi/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (33, 4, 'De''Longhi BCO 410', 'The De''Longhi BCO 410 is a 15 bar espresso/filter coffee machine that will ensure you get the perfect coffee experience, regardless of your tastes. Able to make 10 cups of filter coffee or individual espressos (either via ground coffee or with "Easy Serving Espresso" pods), the BCO 410 is a versatile and high-quality machine. The espresso portion of the machine comes complete with a crema filter holder, adjustable steam emission, removable water reservoir and cup holder. The filter coffee portion of the machine comes complete with a jug warmer to ensure the coffee remains hot after brewing, frontal loading to make the machine incredibly easy to refill (both water and coffee) and a water filtration system to make your coffee taste that much better.','http://www.delonghi.com/pt_pt/family/combi/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (33, 28);

-- New Amazon Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Amazon','manufacturer/amazon.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 1, 'http://www.amazon.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 2, 'http://www.amazon.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 3, 'http://www.amazon.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (13, 4, 'http://www.amazon.co.pt/', 0, null);

-- New Kindle Fire HD

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'DLBCO410', 199.99, 3, 1, 1, 13, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 1, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 2, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 3, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (34, 4, 'Kindle Fire HD', 'World''s most advanced 7" tablet<br>1280x800 HD display with polarizing filter and anti-glare technology for rich color and deep contrast from any viewing angle<br>Exclusive Dolby audio and dual-driver stereo speakers for immersive, virtual surround sound<br>World''s first tablet with dual-band, dual-antenna Wi-Fi for 40% faster downloads and streaming (compared to iPad 3)<br>High performance 1.2 Ghz dual-core processor with Imagination PowerVR 3D graphics core for fast and fluid performance','http://www.amazon.com/Kindle-Fire-HD/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (34, 26);

-- New Apple Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Apple','manufacturer/apple.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 1, 'http://www.apple.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 2, 'http://www.apple.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 3, 'http://www.apple.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (14, 4, 'http://www.apple.co.pt/', 0, null);

-- New iPhone 5

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'DLBCO410', 999.99, 2, 1, 1, 14, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 1, 'iPhone 5', 'Thin, sleek and very capable. It''s hard to believe a phone so thin could offer so many features: a larger display, a faster chip, the latest wireless technology, an 8MP iSight camera and more. All in a beautiful aluminium body designed and made with an unprecedented level of precision. iPhone 5 measures a mere 7.6 millimetres thin and weighs just 112 grams.1 That''s 18 per cent thinner and 20 per cent lighter than iPhone 4S. The only way to achieve a design like this is by relentlessly considering (and reconsidering) every single detail ??? including the details you don''t see.','http://www.apple.com/uk/iphone/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 2, 'iPhone 5', 'D??nn, elegant und leistungsf??hig. Kaum zu glauben, dass ein so d??nnes Telefon so viel zu bieten hat: ein gr????eres Display, einen schnelleren Chip, die neuesten drahtlosen Technologien, eine 8-Megapixel iSight Kamera und mehr. Alles in einem eleganten Aluminiumgeh??use, das mit einer unglaublichen Pr??zision designt und gefertigt wurde. Das iPhone 5 ist gerade einmal 7,6mm d??nn und wiegt nur 112g. Damit ist es 18% d??nner und 20% leichter als das iPhone 4S. Ein solches Design kann man nur erreichen, indem man immer und immer wieder jedes einzelne Detail ??berdenkt. Und zwar auch die Details, die man gar nicht sieht.','http://www.apple.com/de/iphone/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 3, 'iPhone 5', 'Fino, estilizado y capaz de cualquier cosa. Parece incre??ble que un tel??fono tan fino pueda tener tantas cosas: una pantalla m??s grande, un chip m??s r??pido, la ??ltima tecnolog??a inal??mbrica, una c??mara de 8 megap??xeles... Y todo dentro de una espectacular carcasa de aluminio elaborada con un nivel de precisi??n sin precedentes. El iPhone 5 solo tiene 0,76 cm de grosor y 112 gramos de peso.1 O sea, es un 18% m??s fino y un 20% m??s ligero que el iPhone 4S. Solo hay una manera de conseguir algo as??: analizando una y otra vez hasta el ??ltimo detalle, incluso los que no se ven.','http://www.apple.com/es/iphone/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (35, 4, 'iPhone 5', 'Fino, elegante e muito potente. ?? dif??cil de acreditar que um telefone t??o leve tenha tantas funcionalidades: um ecr?? maior, um chip mais r??pido, a mais recente tecnologia sem fios, uma c??mara iSight de 8 megap??xeis e muito mais. Tudo numa elegante estrutura em alum??nio, concebida e constru??da com um n??vel de precis??o sem precedentes. O iPhone 5 tem apenas 7,6 mil??metros de espessura e s?? pesa 112 gramas.1 O que significa que ?? 18% mais fino e 20% mais leve do que o iPhone 4S. A ??nica forma de se conseguir este feito, ?? estudando e analisando exaustivamente cada detalhe, mesmo aqueles que n??o se veem.','http://www.apple.com/pt/iphone/features/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (35, 27);

-- New Acctim Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Acctim','manufacturer/acctim.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 1, 'http://www.acctim.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 2, 'http://www.acctim.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 3, 'http://www.acctim.co.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (15, 4, 'http://www.acctim.co.pt/', 0, null);

-- New Cadiz 74137 clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'CD74137', 19.99, 5, 1, 1, 15, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 1, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design \& Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 2, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design \& Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 3, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design \& Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (36, 4, 'Cadiz Clock', 'MSF Radio Controlled<br>Split Second Accuracy<br>Black Numbers With Black Hand<br>Excellent Design \& Quality<br>Dimensions: 255mm / 10" Colour: Silver','http://www.acctim.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (36, 29);

-- New Milan 93 clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'MI93', 12.99, 5, 1, 1, 15, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 1, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 2, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 3, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (37, 4, 'Milan 93 Clock', 'Radio Controlled for split second accuracy, automatically sets to correct time<br>255mm Diameter<br>12/24 hour dial<br>Plastic case and lens<br>Dimensions H.W.L 255mm x 255mm x 37mm','http://www.acctim.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (37, 29);

-- New Acctim Metal clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'B000H1QSJY', 21.99, 5, 1, 1, 15, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 1, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 2, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 3, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (38, 4, 'Acctim Metal Clock', 'Acctim wall clock<br>Radio controlled for split second accuracy<br>12/24 hour dial<br>Metal case<br>Diameter 300mm','http://www.acctim.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (38, 29);

-- New Eddingtons Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Eddingtons','manufacturer/eddingtons.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 1, 'http://www.eddingtons.co.uk/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 2, 'http://www.eddingtons.co.uk/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 3, 'http://www.eddingtons.co.uk/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (16, 4, 'http://www.eddingtons.co.uk/', 0, null);

-- New Bosch Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Bosch','manufacturer/bosch.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 1, 'http://www.bosch.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 2, 'http://www.bosch.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 3, 'http://www.bosch.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (17, 4, 'http://www.bosch.com/', 0, null);

-- New Rotak 40 Ergoflex

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'B004GTMNXI', 159.99, 16, 1, 1, 17, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 1, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 2, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 3, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (39, 4, 'Rotak 40 Ergoflex', 'Ergoflex System. Ergonomically shaped and adjustable handles for a better body posture and reduced muscle strain when mowing<br>1700W Powerdrive motor ensures a reliable cut, even in the most difficult conditions<br>Light weight for easy handling<br>Folding handles for compact storage<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns','http://www.bosch.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (39, 30);

-- New Rotak 32

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '0600885B71', 89.99, 7, 1, 1, 17, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 1, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 2, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 3, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (40, 4, 'Rotak 32', 'Ergonomic handle design for easy manoeuvrability<br>Lightweight and compact for convenient carrying and problem-free manoeuvrability<br>Powerdrive motor ensures a reliable cut, even under difficult circumstances<br>Innovative grass combs. Cut close to the edge of walls, flower beds and lawns<br>31-litre grass box for greater capacity and reduced need for emptying','http://www.bosch.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (40, 30);

-- New Flymo Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Flymo','manufacturer/flymo.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 1, 'http://www.flymo.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 2, 'http://www.flymo.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 3, 'http://www.flymo.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (18, 4, 'http://www.flymo.com/', 0, null);

-- New Flymo Chevron 34VC

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'CHEVRON34VC', 109.99, 7, 1, 1, 18, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 1, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 2, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 3, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (41, 4, 'Flymo Chevron 34VC', 'The Chevron 34VC from Flymo is a lightweight, easy to use electric wheeled mower with a rear roller that will give your lawn that classic striped finish.<br>1400 watt motor<br>5 heights of cut (20 - 60mm)<br>40 litre collection box<br>12 metre mains cable<br>34cm metal cutting blade','http://www.flymo.com/int/products/lawn-mowers/chevron-34vc/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (41, 30);

-- New Bosch SHM 38G

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '0600886102', 55.95, 7, 1, 1, 17, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 1, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 2, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 3, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (42, 4, 'Bosch SHM 38G', 'Cylinder cut system with 5 curved blades made from hardened steel<br>Variable height-of-cut adjustment and a cutting width of 38cm<br>Simple bottom blade adjustment with "click" locking system<br>Maintenance-free cutting cylinder on ball bearings<br>Easy-to-use bar for better ergonomics<br>Smooth-running wheels with special gear reduction for easy pushing','http://www.bosch.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (42, 30);

-- New Brita Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Brita','manufacturer/brita.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 1, 'http://www.brita.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 2, 'http://www.brita.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 3, 'http://www.brita.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (19, 4, 'http://www.brita.pt', 0, null);

-- New Brita Marella XL Water Filter

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '219185', 15.19, 1, 1, 1, 19, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 1, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50??C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 2, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50??C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 3, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50??C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (43, 4, 'Brita Marella XL Water Filter', 'Handy filling orifice in lid for easy filling<br>Electronic cartridge change display: BRITA MEMO<br>Dishwasher-safe up to 50??C (exception: lid)<br>XL version for larger demand, total volume: 3.5 L, filtered water: 2.0 L<br>Including 1x Maxtra cartridge','http://www.brita.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (43, 28);

-- New Brabantia Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Brabantia','manufacturer/brabantia.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 1, 'http://www.brabantia.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 2, 'http://www.brabantia.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 3, 'http://www.brabantia.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (20, 4, 'http://www.brabantia.pt', 0, null);

-- New Brabantia Touch Bin

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '424625', 149.49, 7, 1, 1, 20, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 1, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 2, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 3, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (44, 4, 'Brabantia Touch Bin', 'Brabantia Soft-Touch closure - easy and light operation<br>Unique hinge design - lid opens silently<br>Matching Brabantia bin liners available with tie-tape (size L) - perfect fit and no ugly over wrap<br>Dimensions: height 75.5cm, diameter 37cm, capacity 45 litres<br>10 year guarantee','http://www.brabantia.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (44, 28);

-- New Samsung Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Samsung','manufacturer/samsung.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 1, 'http://www.samsung.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 2, 'http://www.samsung.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 3, 'http://www.samsung.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (21, 4, 'http://www.samsung.pt', 0, null);

-- New Samsung Galaxy S III

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'GALAXYSIII', 589.99, 2, 1, 1, 21, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 1, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 2, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 3, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (45, 4, 'Galaxy S III', 'Designed for humans<br>Samsung GALAXY S III just gets us. Little things, like staying awake when you look at it and keeping track of loved ones. Designed for humans, it goes beyond smart and fulfills your needs by thinking as you think, acting as you act','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-I9300MBDBTU',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (45, 27);

-- New Samsung Galaxy Ace Plus

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'GT-S7500ABABTU', 289.99, 2, 1, 1, 21, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 1, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 2, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 3, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (46, 4, 'Galaxy Ace Plus', 'A stylishly designed smartphone contained in a modern and minimalist casing with HVGA display<br>Complete with Samsung''s Social Hub, Music Hub and ChatON services<br>2Gb shared storage capacity for multimedia content and up to 1 Gb of direct storage for applications - more than any smartphone in its category','http://www.samsung.com/uk/consumer/mobile-devices/smartphones/android/GT-S7500ABABTU',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (46, 27);

-- New iPhone XS

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'IPHONEXS', 999.99, 3, 1, 1, 14, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 1, 'iPhone XS', 'iPhone XS is packed with incredible specs. The 5.8-inch Super Retina HD display looks amazing, the 12MP dual lens camera takes stunning portraits with advanced bokeh effects, and it offers storage up to 512GB - more than any previous iPhone.','https://www.apple.com/uk/iphone-xs/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 2, 'iPhone XS', 'iPhone XS ist mit unglaublichen Spezifikationen verpackt. Das 5,8-Zoll-Super-Retina-HD-Display sieht umwerfend aus, die 12-Megapixel-Dual-Lens-Kamera bietet atemberaubende Portr??ts mit fortschrittlichen Bokeh-Effekten und bietet Speicherplatz bis zu 512 GB - mehr als jedes iPhone.','https://www.apple.com/de/iphone-xs/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 3, 'iPhone XS', 'iPhone XS est?? repleto de especificaciones incre??bles. La pantalla Super Retina HD de 5.8 pulgadas se ve incre??ble, la c??mara de lente doble de 12 megap??xeles toma retratos asombrosos con efectos de bokeh avanzados y ofrece almacenamiento de hasta 512 GB, m??s que cualquier otro iPhone anterior.','https://www.apple.com/es/iphone-xs/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (47, 4, 'iPhone XS', 'O iPhone XS ?? embalado com especifica????es incr??veis. A tela Super Retina HD de 5,8 polegadas parece incr??vel, a c??mera de lente dupla de 12MP tira retratos impressionantes com efeitos bokeh avan??ados, e oferece armazenamento de at?? 512GB - mais do que qualquer iPhone anterior.','https://www.apple.com/pt/iphone-xs/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (47, 27);

-- New Sony Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Sony','manufacturer/sony.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 1, 'http://www.sony.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 2, 'http://www.sony.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 3, 'http://www.sony.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (22, 4, 'http://www.sony.pt', 0, null);

-- New XPERIA S

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '1257-3114', 459.99, 1, 1, 1, 22, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 1, 'Sony XPERIA S', 'See movies and photos in crisp, clear HD on the large Reality Display with Mobile BRAVIA Engine. The full HD video recording and fast 12MP camera lets you shoot everything in sharp detail, even in low light, and view it on your TV via an HDMI cable. Xperia S is PlayStation Certified, so you can play the perfect game. And you can enjoy millions of songs from Music Unlimited. Or download hit movies from Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 2, 'Sony XPERIA S', 'Sehen Sie Filme und Fotos in gestochen scharfe, klare HD auf dem gro??en Reality Display mit Mobile BRAVIA Engine. Die Full-HD-Video-Aufzeichnung und schnelle 12MP Kamera k??nnen Sie schie??en alles in scharfe Details, auch bei schwachem Licht, und zeigen Sie sie auf dem Fernseher ??ber ein HDMI-Kabel. Xperia S PlayStation Certified, so k??nnen Sie das perfekte Spiel zu spielen. Und Sie k??nnen Millionen von Songs aus Music Unlimited genie??en. Oder laden Sie hit Filme von Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 3, 'Sony XPERIA S', 'Ver pel??culas y fotograf??as en claro y n??tido de alta definici??n en la pantalla grande Reality con Mobile BRAVIA Engine. La plena grabaci??n de v??deo HD y c??mara de 12MP r??pido le permite tomar todo con todo detalle, incluso en condiciones de poca luz, y verla en la TV mediante un cable HDMI. Xperia S es PlayStation Certified, para que pueda jugar el juego perfecto. Y usted puede disfrutar de millones de canciones de Music Unlimited. O descargar pel??culas de ??xito de Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (48, 4, 'Sony XPERIA S', 'Ver filmes e fotos em n??tido, HD claro no visor Reality grande com o Mobile BRAVIA Engine. A grava????o de v??deo Full HD e c??mera de 12MP r??pido permite gravar tudo em detalhes n??tidos, mesmo em condi????es de pouca luz, e v??-lo na sua TV atrav??s de um cabo HDMI. Xperia S ?? PlayStation Certified, de modo que voc?? pode jogar o jogo perfeito. E voc?? pode desfrutar de milh??es de m??sicas do Music Unlimited. Ou fazer o download de filmes de sucesso Video Unlimited.','http://www.sonymobile.com/gb/products/phones/xperia-s',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (48, 27);

-- New Canon Powershot G15

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '6350B009', 829.99, 1, 1, 1, 6, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 1, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 2, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 3, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (49, 4, 'Canon PowerShot G15', 'The fast, bright expert compact<br><br>Equipped for serious photography, the compact PowerShot G15 boasts a bright f/1.8-2.8, 5x zoom lens, fast AF and a high-sensitivity Canon CMOS sensor for capturing superior photos and Full HD movies.','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_G15/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (49, 25);

-- Samsung WB1100F Smart Camera

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'WB1100F', 155.99, 1, 1, 1, 21, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 1, 'Samsung WB1100F Camera', 'Samsung WB1100F Smart Camera - Black (16.2MP Optical Image Stabilisation) 3 inch LCD<br><br>16.2 megapixel sensor delivers superb image quality<br><br>35x zoom lens<br><br>Smart shooting modes ensure brilliant results every time<br><br>Built-in Wi-Fi and NFC let you backup and share your images with ease','https://www.samsung.com/uk/discover/camera/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 2, 'Samsung WB1100F Camera', 'Samsung WB1100F Smart Camera - Black (16.2MP Optical Image Stabilisation) 3 inch LCD<br><br>16.2 megapixel sensor delivers superb image quality<br><br>35x zoom lens<br><br>Smart shooting modes ensure brilliant results every time<br><br>Built-in Wi-Fi and NFC let you backup and share your images with ease','https://www.samsung.com/uk/discover/camera/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 3, 'Samsung WB1100F Camera', 'Samsung WB1100F Smart Camera - Black (16.2MP Optical Image Stabilisation) 3 inch LCD<br><br>16.2 megapixel sensor delivers superb image quality<br><br>35x zoom lens<br><br>Smart shooting modes ensure brilliant results every time<br><br>Built-in Wi-Fi and NFC let you backup and share your images with ease','https://www.samsung.com/uk/discover/camera/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (50, 4, 'Samsung WB1100F Camera', 'Samsung WB1100F Smart Camera - Black (16.2MP Optical Image Stabilisation) 3 inch LCD<br><br>16.2 megapixel sensor delivers superb image quality<br><br>35x zoom lens<br><br>Smart shooting modes ensure brilliant results every time<br><br>Built-in Wi-Fi and NFC let you backup and share your images with ease','https://www.samsung.com/uk/discover/camera/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (50, 25);

-- New Canon Powershot SX40

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '5251B011AA', 439.99, 1, 1, 1, 6, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 1, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 2, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 3, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (51, 4, 'Canon PowerShot SX40', 'Go far, get closer with 35x zoom<br><br>Get closer with the PowerShot SX40 HS. An ultra-wide 35x optical zoom, great low light results of the HS System, Full HD and high-speed shooting make this the travel powerhouse for those who want it all.<br>35x ultra wide-angle zoom with USM<br>Image Stabilizer (4.5-stop). Intelligent IS<br>HS System (12.1 MP) with DIGIC 5<br>Full HD, HDMI','http://www.canon.co.uk/For_Home/Product_Finder/Cameras/Digital_Camera/PowerShot/PowerShot_SX40_HS/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (51, 25);

-- New Nikon Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq, 'Nikon', 'manufacturer/nikon.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 1, 'http://www.nikon.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 2, 'http://www.nikon.de/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 3, 'http://www.nikon.es/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (23, 4, 'http://www.nikon.pt', 0, null);

-- New Nikon COOLPIX L810

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'L810', 279.99, 1, 1, 1, 23, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 1, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm ??? 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 2, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm ??? 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 3, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm ??? 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (52, 4, 'Nikon COOLPIX L810', 'The Nikon COOLPIX L810 - Stabilised 26x zoom, compact and user-friendly<br><br>This compact camera lets curious photographers get up close from anywhere with the incredible Nikon COOLPIX NIKKOR 26x optical zoom lens (22.5mm ??? 585mm). Taking the perfect picture is made simple with Easy Auto mode which takes care of all the camera settings. For super-sharp shots it has Nikon''s clever anti-blur technology and a side zoom lever to help keep a steady hand.','http://www.nikonusa.com/en/Nikon-Products/Product/Compact-Digital-Cameras/26294/COOLPIX-L810.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (52, 25);

-- New Nikon D5100 Digital SLR

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '25478', 849.99, 1, 1, 1, 23, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 1, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 2, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 3, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (53, 4, 'Nikon D5100 SLR', 'The Nikon D5100 and its included AF-S 18-55mm VR lens offer a host of new photographic and video tools including a 16.2 MP DX-format CMOS sensor, 4 fps continuous shooting and breathtaking Full 1080p HD Movies with full time autofocus.','http://www.nikonusa.com/en/Nikon-Products/Product/Digital-SLR-Cameras/25478/D5100.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (53, 25);

-- New Nikon 1 J2 Compact

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, '27577', 549.95, 1, 1, 1, 23, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 1, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 2, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 3, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (54, 4, 'Nikon 1 J2 Compact', 'Create your most exciting photos and HD videos yet.<br><br>Capture all the wonderful moments of your life in the brilliance they deserve. The Nikon 1 J2 will inspire your creativity to new heights with fun, artistic in-camera effects, an ultra-high-resolution display for framing and sharing your shots, enhanced controls and the remarkable speed, precision, low-light performance and stylish, compact design that has made the Nikon 1 system so popular. Discover a new passion for creative photography.','http://www.nikonusa.com/en/Nikon-Products/Product/Nikon1/V27573.27573/Nikon-1-J2.html',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (54, 25);

-- New Newgate Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Newgate','manufacturer/newgate.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 1, 'http://www.newgateclocks.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 2, 'http://www.newgateclocks.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 3, 'http://www.newgateclocks.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (24, 4, 'http://www.newgateclocks.com/', 0, null);

-- New Newgate Ministry Clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'MINISTRY', 83.99, 2, 1, 1, 24, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 1, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 2, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 3, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (55, 4, 'Ministry Clock', 'Inspiration for this design came from the vintage enamel signage that was once found in stations and shops, but are now only found in flea markets.','http://www.newgateclocks.com/store/Wall-Clocks/min203ar.asp?sn=1',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (55, 29);

-- New Newgate 60s Starburst Clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'PLUTOG', 133.99, 2, 1, 1, 24, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 1, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 2, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 3, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (56, 4, '60s Pluto Starburst Clock', 'You can have sun shine in your room 24/7 with our eye-catching Pluto Starburst Clock. It has been a few decades since the originals first made an appearance but our nostalgic Pluto is still going strong and as popular as ever!','http://www.newgateclocks.com/store/Wall-Clocks/plutog.asp?sn=2',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (56, 29);

-- New Newgate Vision Clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'PLUTOG', 79.99, 2, 1, 1, 24, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 1, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 2, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 3, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (57, 4, 'Vision Clock', 'You can''t miss this clock when its in pride of place on the wall. Its striking bold acrylic numbers, chrome spokes and bold metal hands, make The Vision a vintage, retro, iconic and contemporary timepiece all rolled into one!','http://www.newgateclocks.com/store/Wall-Clocks/visionk.asp?sn=1',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (57, 29);

-- New Office 2010 Software

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'OFFHOMESTUD', 159.99, 6, 1, 1, 2, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 1, 'Office Home and Student 2019', 'With Microsoft Office Home and Student 2019, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2019.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 2, 'Office Home and Student 2019', 'With Microsoft Office Home and Student 2019, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2019.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 3, 'Office Home and Student 2019', 'With Microsoft Office Home and Student 2019, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2019.','http://windows.microsoft.com/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (58, 4, 'Office Home and Student 2019', 'With Microsoft Office Home and Student 2019, you and your kids can create great schoolwork and home projects from multi-page bibliographies to multimedia presentations. Capture ideas and set them apart with video-editing features and dynamic text effects. Then easily collaborate with classmates without being face-to-face thanks to new Web Apps tools. The results go well beyond expectations with a little inspiration, a lot of creativity and Office Home and Student 2019.','http://windows.microsoft.com/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (58, 22);

-- New Bosch MUM48R1 Food Processor

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'SL500', 199.49, 5, 1, 1, 17, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 1, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 2, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 3, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (59, 4, 'MUM48R1 Food Processor', 'The Bosch MUM48R1 is an irreplaceable kitchen appliance with a clever product design and great range of accessories. The appliance can handle everything from kneading, mixing, slicing, grating as well as a whole host of other tasks that any home chef could need! The 600W power can be set to 4 different levels depending on the specific food or recipe. A food processor is the ideal solution for saving space in the kitchen, and the Bosch MUM48R1 is perfect for performing a wide variety of tasks in a very limited space. The appliance can be easily cleaned after use.','http://www.bosch-home.co.uk/store/category/food_preparation/food_preparation_food_mixers',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (59, 28);

-- New Apple iPad with Retina Display

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'IPADRET', 599.99, 2, 1, 1, 14, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 1, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad ??? the display, the processor, the cameras, the wireless connection ??? all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 2, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad ??? the display, the processor, the cameras, the wireless connection ??? all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 3, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad ??? the display, the processor, the cameras, the wireless connection ??? all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (60, 4, 'iPad', 'Pick up the iPad with Retina display and suddenly, it''s clear. You''re actually touching your photos, reading a book, playing the piano. Nothing comes between you and what you love. That''s because the fundamental elements of iPad ??? the display, the processor, the cameras, the wireless connection ??? all work together to create the best possible experience. And they make iPad capable of so much more than you ever imagined.', 'http://www.apple.com/uk/ipad/features/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (60, 26);

-- New Samsung Galaxy Tab S4

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'GALTABS4', 699.99, 2, 1, 1, 21, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 1, 'Galaxy Tab S4', 'The Galaxy Tab S4 makes working on the go easy. Enjoy plenty of space with a stunning, crystal clear 10.5 inch screen, and transform your tablet by attaching the bespoke keyboard case. For those jobs that need a larger screen, you can connect to a monitor and make light work of the chunkiest spreadsheet.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 2, 'Galaxy Tab S4', 'Das Galaxy Tab S4 macht das Arbeiten unterwegs einfach. Genie??en Sie viel Platz mit einem atemberaubenden, kristallklaren 10,5-Zoll-Bildschirm und verwandeln Sie Ihr Tablet, indem Sie das ma??geschneiderte Tastaturgeh??use anbringen. F??r Jobs, die einen gr????eren Bildschirm ben??tigen, k??nnen Sie eine Verbindung zu einem Monitor herstellen und die Arbeit mit der chunkiest Tabellenkalkulation erledigen.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 3, 'Galaxy Tab S4', 'El Galaxy Tab S4 hace que trabajar sobre la marcha sea f??cil. Disfrute de un mont??n de espacio con una impresionante pantalla de 10,5 pulgadas, cristalina, y transforme su tableta adjuntando la caja del teclado a medida. Para aquellos trabajos que necesitan una pantalla m??s grande, puede conectarse a un monitor y hacer que la hoja de c??lculo m??s pesada funcione.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (61, 4, 'Galaxy Tab S4', 'O Galaxy Tab S4 facilita o trabalho em movimento. Desfrute de muito espa??o com uma tela impressionante de 10,5 polegadas e transforme seu tablet anexando o estojo de teclado sob medida. Para aqueles trabalhos que precisam de uma tela maior, voc?? pode se conectar a um monitor e fazer um trabalho leve com a planilha mais chunky.', 'http://www.samsung.com/global/microsite/galaxytab2/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (61, 26);

-- New Weather Station clock

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'B000H1QSJY', 21.99, 5, 1, 1, 16, 100, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 1, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 2, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 3, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (62, 4, 'Weather Station Clock', 'Stylish clock featuring hygrometer (humidity) and thermometer dials and sweeping second hand. Aluminium rim. 30.5cm diameter. Retail box.','http://www.eddingtons.co.uk/',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (62, 29);

-- Add index to coupon table
CREATE INDEX i_co_652f6e86e79_c ON coupon (coupon_code);

-- Mouse had wrong manufacturer
UPDATE products SET manufacturers_id = 2 where products_id = 3 and products_model = 'MSIMPRO' and manufacturers_id = 3;

-- Panel for Licensing
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_license','Licensing', current timestamp);

-- Add access to the Licensing Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_license';

-- ConfigData API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertConfigData','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateConfigData','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeConfigData','', current timestamp);

-- Add Euro currency symbol
UPDATE currencies set symbol_left = '???', symbol_right = '' where currencies_id = 2;

-- Google Data Feed - Google Product Link
DELETE FROM configuration WHERE configuration_key = 'GOOGLE_PRODUCT_LINK';
--INSERT INTO configuration (configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES ('Google Product Link', 'GOOGLE_PRODUCT_LINK', 'SelectProd.action?prodId=', 'Added to the KonaKart base URL to form a link to a product that is sent to Google.  The ProductId is appended at the end.', '23', '105', now());

-- Image APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'scaleImage','', current timestamp);

-- Add extra fields to products table
ALTER TABLE products ADD product_image_dir varchar(64);
ALTER TABLE products ADD product_depth int NOT NULL DEFAULT 0;
ALTER TABLE products ADD product_width int NOT NULL DEFAULT 0;
ALTER TABLE products ADD product_length int NOT NULL DEFAULT 0;
ALTER TABLE products ALTER COLUMN products_weight SET DATA TYPE DECIMAL(15,2);
ALTER TABLE products ALTER COLUMN products_weight SET DEFAULT 0.00;

-- For DB2 Only - Required after modification
call SYSPROC.ADMIN_CMD ('REORG TABLE products');

-- New Activision Manufacturer

INSERT INTO manufacturers (manufacturers_id, manufacturers_name, manufacturers_image, date_added, last_modified) VALUES (nextval for manufacturers_seq,'Activision','manufacturer/activision.jpg', current timestamp, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 1, 'http://www.activision.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 2, 'http://www.activision.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 3, 'http://www.activision.com/', 0, null);
INSERT INTO manufacturers_info (manufacturers_id, languages_id, manufacturers_url, url_clicked, date_last_click) VALUES (25, 4, 'http://www.activision.com/', 0, null);

-- New Black Ops Game

INSERT INTO products (products_id, products_model, products_price, products_weight, products_status, products_tax_class_id, manufacturers_id, products_quantity, products_ordered, products_date_added, products_date_available) VALUES (nextval for products_seq, 'BLACKOPS2', 39.99, 1, 1, 1, 25, 200, 0, current timestamp, current timestamp);

INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 1, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 2, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 3, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);
INSERT INTO products_description (products_id, language_id, products_name, products_description, products_url, products_viewed) VALUES (63, 4, 'Call Of Duty', 'Call Of Duty - Black Ops2 - Stunning but Violent','http://www.callofduty.com/blackops2',0);

INSERT INTO products_to_categories (products_id, categories_id) VALUES (63, 19);

-- Set new locations for product images
UPDATE products SET products_image = '/prod/9/5/9/9/95992CDB-33D0-46BE-A6EF-4C973B3221B5_1_big.jpg', product_image_dir = '/prod/9/5/9/9/', product_uuid = '95992CDB-33D0-46BE-A6EF-4C973B3221B5' WHERE products_id = 1;
UPDATE products SET products_image = '/prod/7/8/5/7/7857D709-61C6-44C1-A5D4-52E463CBEAA9_1_big.jpg', product_image_dir = '/prod/7/8/5/7/', product_uuid = '7857D709-61C6-44C1-A5D4-52E463CBEAA9' WHERE products_id = 2;
UPDATE products SET products_image = '/prod/1/8/5/3/18536902-5B5C-4FF2-859B-A927EE8F38AF_1_big.jpg', product_image_dir = '/prod/1/8/5/3/', product_uuid = '18536902-5B5C-4FF2-859B-A927EE8F38AF' WHERE products_id = 3;
UPDATE products SET products_image = '/prod/9/3/E/E/93EE9E10-709E-4517-9041-D07C577AFBC9_1_big.jpg', product_image_dir = '/prod/9/3/E/E/', product_uuid = '93EE9E10-709E-4517-9041-D07C577AFBC9' WHERE products_id = 4;
UPDATE products SET products_image = '/prod/8/3/7/7/8377214C-C4A5-41C5-93A5-3A580132C55A_1_big.jpg', product_image_dir = '/prod/8/3/7/7/', product_uuid = '8377214C-C4A5-41C5-93A5-3A580132C55A' WHERE products_id = 5;
UPDATE products SET products_image = '/prod/9/5/2/1/95214187-5DF3-403B-BFEF-16DECA237BF6_1_big.jpg', product_image_dir = '/prod/9/5/2/1/', product_uuid = '95214187-5DF3-403B-BFEF-16DECA237BF6' WHERE products_id = 6;
UPDATE products SET products_image = '/prod/9/2/9/3/92937B41-BC5C-4CB8-92E3-4380A933F6E2_1_big.jpg', product_image_dir = '/prod/9/2/9/3/', product_uuid = '92937B41-BC5C-4CB8-92E3-4380A933F6E2' WHERE products_id = 7;
UPDATE products SET products_image = '/prod/0/6/D/A/06DAD86E-0FA8-4B42-9184-CE1B3F3CE4A6_1_big.jpg', product_image_dir = '/prod/0/6/D/A/', product_uuid = '06DAD86E-0FA8-4B42-9184-CE1B3F3CE4A6' WHERE products_id = 8;
UPDATE products SET products_image = '/prod/A/E/C/2/AEC246F9-F629-4657-B563-15B10F644CC8_1_big.jpg', product_image_dir = '/prod/A/E/C/2/', product_uuid = 'AEC246F9-F629-4657-B563-15B10F644CC8' WHERE products_id = 9;
UPDATE products SET products_image = '/prod/9/6/3/9/9639041E-710D-472A-B87C-85E59C435D82_1_big.jpg', product_image_dir = '/prod/9/6/3/9/', product_uuid = '9639041E-710D-472A-B87C-85E59C435D82' WHERE products_id = 10;
UPDATE products SET products_image = '/prod/3/F/D/D/3FDD11D0-C6F2-45D0-B906-7DDFDA015594_1_big.jpg', product_image_dir = '/prod/3/F/D/D/', product_uuid = '3FDD11D0-C6F2-45D0-B906-7DDFDA015594' WHERE products_id = 11;
UPDATE products SET products_image = '/prod/F/7/E/6/F7E61CE3-5778-4790-A705-EE2D9980E979_1_big.jpg', product_image_dir = '/prod/F/7/E/6/', product_uuid = 'F7E61CE3-5778-4790-A705-EE2D9980E979' WHERE products_id = 12;
UPDATE products SET products_image = '/prod/6/7/7/E/677E32E4-1DB2-44AD-A5BF-3CE389A25D3F_1_big.jpg', product_image_dir = '/prod/6/7/7/E/', product_uuid = '677E32E4-1DB2-44AD-A5BF-3CE389A25D3F' WHERE products_id = 13;
UPDATE products SET products_image = '/prod/F/3/1/8/F3186F6D-20DB-49A8-84F8-3F98BE3BA076_1_big.jpg', product_image_dir = '/prod/F/3/1/8/', product_uuid = 'F3186F6D-20DB-49A8-84F8-3F98BE3BA076' WHERE products_id = 14;
UPDATE products SET products_image = '/prod/E/6/A/B/E6AB1135-5B32-4FD1-BF28-12C5CD256CD9_1_big.jpg', product_image_dir = '/prod/E/6/A/B/', product_uuid = 'E6AB1135-5B32-4FD1-BF28-12C5CD256CD9' WHERE products_id = 15;
UPDATE products SET products_image = '/prod/2/1/E/0/21E0683C-62A7-4282-A36F-E0D6BC9AE8A2_1_big.jpg', product_image_dir = '/prod/2/1/E/0/', product_uuid = '21E0683C-62A7-4282-A36F-E0D6BC9AE8A2' WHERE products_id = 16;
UPDATE products SET products_image = '/prod/8/C/7/A/8C7A57B8-A6B5-48A5-A965-87A7D728F1BE_1_big.jpg', product_image_dir = '/prod/8/C/7/A/', product_uuid = '8C7A57B8-A6B5-48A5-A965-87A7D728F1BE' WHERE products_id = 17;
UPDATE products SET products_image = '/prod/C/5/1/A/C51A6C94-27CC-4159-89CF-D8EEFDBB2928_1_big.jpg', product_image_dir = '/prod/C/5/1/A/', product_uuid = 'C51A6C94-27CC-4159-89CF-D8EEFDBB2928' WHERE products_id = 18;
UPDATE products SET products_image = '/prod/C/1/9/2/C1929825-BD7C-4FE3-8AE8-DFEA73A230F0_1_big.jpg', product_image_dir = '/prod/C/1/9/2/', product_uuid = 'C1929825-BD7C-4FE3-8AE8-DFEA73A230F0' WHERE products_id = 19;
UPDATE products SET products_image = '/prod/6/8/9/6/68965D51-F873-4D1B-8A37-92A340E5B913_1_big.jpg', product_image_dir = '/prod/6/8/9/6/', product_uuid = '68965D51-F873-4D1B-8A37-92A340E5B913' WHERE products_id = 20;
UPDATE products SET products_image = '/prod/C/4/9/4/C4941395-021B-4C97-B46C-A4491AD3D620_1_big.jpg', product_image_dir = '/prod/C/4/9/4/', product_uuid = 'C4941395-021B-4C97-B46C-A4491AD3D620' WHERE products_id = 21;
UPDATE products SET products_image = '/prod/5/7/D/3/57D32457-0C8A-4387-9680-1B4861AE6178_1_big.jpg', product_image_dir = '/prod/5/7/D/3/', product_uuid = '57D32457-0C8A-4387-9680-1B4861AE6178' WHERE products_id = 22;
UPDATE products SET products_image = '/prod/F/9/8/F/F98FF9EA-110B-4096-AD22-1423E0E78C36_1_big.jpg', product_image_dir = '/prod/F/9/8/F/', product_uuid = 'F98FF9EA-110B-4096-AD22-1423E0E78C36' WHERE products_id = 23;
UPDATE products SET products_image = '/prod/3/8/3/B/383B8D87-B3EA-4AAF-B0AB-9614C17463F3_1_big.jpg', product_image_dir = '/prod/3/8/3/B/', product_uuid = '383B8D87-B3EA-4AAF-B0AB-9614C17463F3' WHERE products_id = 24;
UPDATE products SET products_image = '/prod/0/0/1/F/001F1EAA-2910-440E-BB8D-C714E0E859B4_1_big.jpg', product_image_dir = '/prod/0/0/1/F/', product_uuid = '001F1EAA-2910-440E-BB8D-C714E0E859B4' WHERE products_id = 25;
UPDATE products SET products_image = '/prod/F/E/F/2/FEF2DB86-728E-4C6A-A3FA-4F4B099D28E6_1_big.jpg', product_image_dir = '/prod/F/E/F/2/', product_uuid = 'FEF2DB86-728E-4C6A-A3FA-4F4B099D28E6' WHERE products_id = 26;
UPDATE products SET products_image = '/prod/5/1/B/7/51B73EC2-0845-4837-B125-EC8041C0EA76_1_big.jpg', product_image_dir = '/prod/5/1/B/7/', product_uuid = '51B73EC2-0845-4837-B125-EC8041C0EA76' WHERE products_id = 27;
UPDATE products SET products_image = '/prod/E/3/8/4/E384D77F-69C0-4DA9-97DE-32F042B437DB_1_big.jpg', product_image_dir = '/prod/E/3/8/4/', product_uuid = 'E384D77F-69C0-4DA9-97DE-32F042B437DB' WHERE products_id = 28;
UPDATE products SET products_image = '/prod/E/D/7/0/ED709A75-1C44-4983-ADB5-B42E963452C3_1_big.jpg', product_image_dir = '/prod/E/D/7/0/', product_uuid = 'ED709A75-1C44-4983-ADB5-B42E963452C3' WHERE products_id = 29;
UPDATE products SET products_image = '/prod/D/A/1/A/DA1A02B1-B200-4125-BBFA-22EE7D01963A_1_big.jpg', product_image_dir = '/prod/D/A/1/A/', product_uuid = 'DA1A02B1-B200-4125-BBFA-22EE7D01963A' WHERE products_id = 30;
UPDATE products SET products_image = '/prod/B/9/9/0/B990FBA5-CCFF-467D-A6ED-230298BB609E_1_big.jpg', product_image_dir = '/prod/B/9/9/0/', product_uuid = 'B990FBA5-CCFF-467D-A6ED-230298BB609E' WHERE products_id = 31;
UPDATE products SET products_image = '/prod/D/D/D/4/DDD4F497-9212-4E73-BD2E-2B56428E51A2_1_big.jpg', product_image_dir = '/prod/D/D/D/4/', product_uuid = 'DDD4F497-9212-4E73-BD2E-2B56428E51A2' WHERE products_id = 32;
UPDATE products SET products_image = '/prod/F/9/8/F/F98F155B-2D6D-41C0-897F-3071B6354AD8_1_big.jpg', product_image_dir = '/prod/F/9/8/F/', product_uuid = 'F98F155B-2D6D-41C0-897F-3071B6354AD8' WHERE products_id = 33;
UPDATE products SET products_image = '/prod/5/A/A/C/5AAC7490-1BB8-4980-BA0A-F49B25ADBA71_1_big.jpg', product_image_dir = '/prod/5/A/A/C/', product_uuid = '5AAC7490-1BB8-4980-BA0A-F49B25ADBA71' WHERE products_id = 34;
UPDATE products SET products_image = '/prod/3/7/4/F/374F4985-53E5-49FF-A277-4A8AEE40FE0D_1_big.jpg', product_image_dir = '/prod/3/7/4/F/', product_uuid = '374F4985-53E5-49FF-A277-4A8AEE40FE0D' WHERE products_id = 35;
UPDATE products SET products_image = '/prod/A/F/0/E/AF0E40B3-70C4-4A12-9026-5784BBD23C06_1_big.jpg', product_image_dir = '/prod/A/F/0/E/', product_uuid = 'AF0E40B3-70C4-4A12-9026-5784BBD23C06' WHERE products_id = 36;
UPDATE products SET products_image = '/prod/A/5/9/6/A5966A16-B912-47C8-980C-60B7CDFC9177_1_big.jpg', product_image_dir = '/prod/A/5/9/6/', product_uuid = 'A5966A16-B912-47C8-980C-60B7CDFC9177' WHERE products_id = 37;
UPDATE products SET products_image = '/prod/B/1/8/1/B181BD28-2701-4703-A30F-5056517A55C7_1_big.jpg', product_image_dir = '/prod/B/1/8/1/', product_uuid = 'B181BD28-2701-4703-A30F-5056517A55C7' WHERE products_id = 38;
UPDATE products SET products_image = '/prod/1/5/F/8/15F8FBB1-13DA-4A47-B3D2-0F1E7BECAE7C_1_big.jpg', product_image_dir = '/prod/1/5/F/8/', product_uuid = '15F8FBB1-13DA-4A47-B3D2-0F1E7BECAE7C' WHERE products_id = 39;
UPDATE products SET products_image = '/prod/4/A/6/B/4A6B2621-4689-41D7-9BB6-9C2A4200F39E_1_big.jpg', product_image_dir = '/prod/4/A/6/B/', product_uuid = '4A6B2621-4689-41D7-9BB6-9C2A4200F39E' WHERE products_id = 40;
UPDATE products SET products_image = '/prod/9/5/7/8/95782936-65F3-448F-BF8E-A0F5409B5048_1_big.jpg', product_image_dir = '/prod/9/5/7/8/', product_uuid = '95782936-65F3-448F-BF8E-A0F5409B5048' WHERE products_id = 41;
UPDATE products SET products_image = '/prod/1/1/B/C/11BC0D25-1B08-4141-BABB-1B1E633CB382_1_big.jpg', product_image_dir = '/prod/1/1/B/C/', product_uuid = '11BC0D25-1B08-4141-BABB-1B1E633CB382' WHERE products_id = 42;
UPDATE products SET products_image = '/prod/A/2/1/C/A21CA25F-645B-4D88-9539-1407737EC790_1_big.jpg', product_image_dir = '/prod/A/2/1/C/', product_uuid = 'A21CA25F-645B-4D88-9539-1407737EC790' WHERE products_id = 43;
UPDATE products SET products_image = '/prod/9/4/C/A/94CA0B48-0BCA-4696-A688-93C626E120F0_1_big.jpg', product_image_dir = '/prod/9/4/C/A/', product_uuid = '94CA0B48-0BCA-4696-A688-93C626E120F0' WHERE products_id = 44;
UPDATE products SET products_image = '/prod/4/0/4/1/4041A0F2-D827-4E55-ACAB-A1FDC48E423A_1_big.jpg', product_image_dir = '/prod/4/0/4/1/', product_uuid = '4041A0F2-D827-4E55-ACAB-A1FDC48E423A' WHERE products_id = 45;
UPDATE products SET products_image = '/prod/9/0/D/6/90D61688-734D-47CE-B98E-D4AAD5C5AA81_1_big.jpg', product_image_dir = '/prod/9/0/D/6/', product_uuid = '90D61688-734D-47CE-B98E-D4AAD5C5AA81' WHERE products_id = 46;
UPDATE products SET products_image = '/prod/6/D/F/6/6DF6E083-1AFA-4ADB-B91D-8C82D2CB3013_1_big.jpg', product_image_dir = '/prod/6/D/F/6/', product_uuid = '6DF6E083-1AFA-4ADB-B91D-8C82D2CB3013' WHERE products_id = 47;
UPDATE products SET products_image = '/prod/A/3/8/B/A38BC2F7-4BC2-4602-ABC1-053ABF1664DB_1_big.jpg', product_image_dir = '/prod/A/3/8/B/', product_uuid = 'A38BC2F7-4BC2-4602-ABC1-053ABF1664DB' WHERE products_id = 48;
UPDATE products SET products_image = '/prod/2/D/F/3/2DF3A010-69FC-4C33-B412-CC9921D162FB_1_big.jpg', product_image_dir = '/prod/2/D/F/3/', product_uuid = '2DF3A010-69FC-4C33-B412-CC9921D162FB' WHERE products_id = 49;
UPDATE products SET products_image = '/prod/9/6/A/2/96A22190-8D96-430E-8D29-F1B203994759_1_big.jpg', product_image_dir = '/prod/9/6/A/2/', product_uuid = '96A22190-8D96-430E-8D29-F1B203994759' WHERE products_id = 50;
UPDATE products SET products_image = '/prod/B/0/C/B/B0CBFAA6-C865-4DDC-9451-3ABEC85FB2D2_1_big.jpg', product_image_dir = '/prod/B/0/C/B/', product_uuid = 'B0CBFAA6-C865-4DDC-9451-3ABEC85FB2D2' WHERE products_id = 51;
UPDATE products SET products_image = '/prod/7/0/2/6/70261953-3F55-4999-A644-5EC19A321886_1_big.jpg', product_image_dir = '/prod/7/0/2/6/', product_uuid = '70261953-3F55-4999-A644-5EC19A321886' WHERE products_id = 52;
UPDATE products SET products_image = '/prod/1/B/3/F/1B3F5FA1-469D-4B95-8EE1-42A5856961BC_1_big.jpg', product_image_dir = '/prod/1/B/3/F/', product_uuid = '1B3F5FA1-469D-4B95-8EE1-42A5856961BC' WHERE products_id = 53;
UPDATE products SET products_image = '/prod/E/C/D/2/ECD283D0-BFFD-4639-8B08-965C3470B895_1_big.jpg', product_image_dir = '/prod/E/C/D/2/', product_uuid = 'ECD283D0-BFFD-4639-8B08-965C3470B895' WHERE products_id = 54;
UPDATE products SET products_image = '/prod/5/E/8/9/5E89B135-269C-4094-81F1-A71C98D1412A_1_big.jpg', product_image_dir = '/prod/5/E/8/9/', product_uuid = '5E89B135-269C-4094-81F1-A71C98D1412A' WHERE products_id = 55;
UPDATE products SET products_image = '/prod/A/8/6/C/A86C794E-5C00-4F5D-8D01-121C01E6A470_1_big.jpg', product_image_dir = '/prod/A/8/6/C/', product_uuid = 'A86C794E-5C00-4F5D-8D01-121C01E6A470' WHERE products_id = 56;
UPDATE products SET products_image = '/prod/1/0/3/0/10301426-3620-418E-AF4D-4319F708E564_1_big.jpg', product_image_dir = '/prod/1/0/3/0/', product_uuid = '10301426-3620-418E-AF4D-4319F708E564' WHERE products_id = 57;
UPDATE products SET products_image = '/prod/F/F/0/6/FF06923B-46B1-4F4B-9A6F-A68276A56FE5_1_big.jpg', product_image_dir = '/prod/F/F/0/6/', product_uuid = 'FF06923B-46B1-4F4B-9A6F-A68276A56FE5' WHERE products_id = 58;
UPDATE products SET products_image = '/prod/E/7/B/8/E7B8896B-3199-4C4A-966D-9CCD3EFAA33C_1_big.jpg', product_image_dir = '/prod/E/7/B/8/', product_uuid = 'E7B8896B-3199-4C4A-966D-9CCD3EFAA33C' WHERE products_id = 59;
UPDATE products SET products_image = '/prod/5/4/F/D/54FDD302-5B74-4075-8C2E-B9E11A0EEF2E_1_big.jpg', product_image_dir = '/prod/5/4/F/D/', product_uuid = '54FDD302-5B74-4075-8C2E-B9E11A0EEF2E' WHERE products_id = 60;
UPDATE products SET products_image = '/prod/3/1/1/1/3111B14C-0BC1-45E4-A4F9-968DAD99B6F2_1_big.jpg', product_image_dir = '/prod/3/1/1/1/', product_uuid = '3111B14C-0BC1-45E4-A4F9-968DAD99B6F2' WHERE products_id = 61;
UPDATE products SET products_image = '/prod/C/0/2/C/C02C89ED-CB73-4150-BB41-0726DEE2E5A1_1_big.jpg', product_image_dir = '/prod/C/0/2/C/', product_uuid = 'C02C89ED-CB73-4150-BB41-0726DEE2E5A1' WHERE products_id = 62;
UPDATE products SET products_image = '/prod/8/6/D/7/86D70649-28A3-492D-A18E-B6BB0934EB7C_1_big.jpg', product_image_dir = '/prod/8/6/D/7/', product_uuid = '86D70649-28A3-492D-A18E-B6BB0934EB7C' WHERE products_id = 63;

-- Reset Login base URL for new storefront
UPDATE configuration SET configuration_value='https://localhost:8783/konakart/AdminLoginSubmit.action' WHERE configuration_key='ADMIN_APP_LOGIN_BASE_URL';

-- Misc Items types
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 1, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 2, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 3, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (1, 4, 'Banner_1', 'Top banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 1, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 2, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 3, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (2, 4, 'Banner_2', '2nd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 1, 'Banner_3', '3rd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 2, 'Banner_3', '3rd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 3, 'Banner_3', '3rd banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (3, 4, 'Banner_3', '3rd banner');

-- Misc Items for categories
--cat 1 Computer Peripherals
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 1, 'images/banners/computer-peripherals/logitech-keyboard.jpg', 'SelectProd.action?prodId=31' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 2, 'images/banners/computer-peripherals/hp-photosmart.jpg','SelectProd.action?prodId=27' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 3, 'images/banners/computer-peripherals/deals-of-the-week.jpg', '' );
--cat 2 Games
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 1, 'images/banners/games/black-ops-2.jpg', 'SelectProd.action?prodId=63' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 2, 'images/banners/games/swat3.jpg','SelectProd.action?prodId=21' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 3, 'images/banners/games/winter-deals.jpg', '' );
--cat 3 DVD Movies
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 1, 'images/banners/movies/dark-knight.jpg', 'SelectProd.action?prodId=20' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 2, 'images/banners/movies/harry-potter.jpg','SelectProd.action?prodId=11' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 3, 'images/banners/movies/movie-deals.jpg', '' );
--cat 23 Electronics
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 1, 'images/banners/electronics/kindle-fire-hd.jpg', 'SelectProd.action?prodId=34' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 2, 'images/banners/electronics/canon-powershot.jpg','SelectProd.action?prodId=49' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 3, 'images/banners/electronics/electronics-sale.jpg', '' );
--cat 24 Home and Garden
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 1, 'images/banners/home-and-garden/delonghi.jpg', 'SelectProd.action?prodId=33' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 2, 'images/banners/home-and-garden/rotak-40.jpg','SelectProd.action?prodId=39' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 3, 'images/banners/home-and-garden/gifts-for-the-home.jpg', '' );

-- Assign some featured products
UPDATE products SET custom1 = 'featured' where products_id = 39;
UPDATE products SET custom1 = 'featured' where products_id = 40;
UPDATE products SET custom1 = 'featured' where products_id = 41;
UPDATE products SET custom1 = 'featured' where products_id = 42;
UPDATE products SET custom1 = 'featured' where products_id = 33;
UPDATE products SET custom1 = 'featured' where products_id = 43;
UPDATE products SET custom1 = 'featured' where products_id = 44;
UPDATE products SET custom1 = 'featured' where products_id = 59;

-----------------  v6.6.0.0

-- Add custom privileges for the Customers panel - default to allow access to the Custom button - custom 3 hides it
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForOrder_2');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

-- Increase the minimum password length to match the storefront validation
UPDATE configuration SET configuration_value='8' WHERE configuration_key = 'ENTRY_PASSWORD_MIN_LENGTH';

-- Modify image path for Misc Items for categories
--cat 1 Computer Peripherals
UPDATE kk_misc_item set item_value = 'banners/computer-peripherals/logitech-keyboard.jpg' where item_value='images/banners/computer-peripherals/logitech-keyboard.jpg';
UPDATE kk_misc_item set item_value = 'banners/computer-peripherals/hp-photosmart.jpg' where item_value='images/banners/computer-peripherals/hp-photosmart.jpg';
UPDATE kk_misc_item set item_value = 'banners/computer-peripherals/deals-of-the-week.jpg' where item_value='images/banners/computer-peripherals/deals-of-the-week.jpg';
--cat 2 Games
UPDATE kk_misc_item set item_value = 'banners/games/black-ops-2.jpg' where item_value='images/banners/games/black-ops-2.jpg';
UPDATE kk_misc_item set item_value = 'banners/games/swat3.jpg' where item_value='images/banners/games/swat3.jpg';
UPDATE kk_misc_item set item_value = 'banners/games/winter-deals.jpg' where item_value='images/banners/games/winter-deals.jpg';
--cat 3 DVD Movies
UPDATE kk_misc_item set item_value = 'banners/movies/dark-knight.jpg' where item_value='images/banners/movies/dark-knight.jpg';
UPDATE kk_misc_item set item_value = 'banners/movies/harry-potter.jpg' where item_value='images/banners/movies/harry-potter.jpg';
UPDATE kk_misc_item set item_value = 'banners/movies/movie-deals.jpg' where item_value='images/banners/movies/movie-deals.jpg';
--cat 23 Electronics
UPDATE kk_misc_item set item_value = 'banners/electronics/kindle-fire-hd.jpg' where item_value='images/banners/electronics/kindle-fire-hd.jpg';
UPDATE kk_misc_item set item_value = 'banners/electronics/canon-powershot.jpg' where item_value='images/banners/electronics/canon-powershot.jpg';
UPDATE kk_misc_item set item_value = 'banners/electronics/electronics-sale.jpg' where item_value='images/banners/electronics/electronics-sale.jpg';
--cat 24 Home and Garden
UPDATE kk_misc_item set item_value = 'banners/home-and-garden/delonghi.jpg' where item_value='images/banners/home-and-garden/delonghi.jpg';
UPDATE kk_misc_item set item_value = 'banners/home-and-garden/rotak-40.jpg' where item_value='images/banners/home-and-garden/rotak-40.jpg';
UPDATE kk_misc_item set item_value = 'banners/home-and-garden/gifts-for-the-home.jpg' where item_value='images/banners/home-and-garden/gifts-for-the-home.jpg';

-- Add extra custom fields to the kk_cust_attr table
ALTER TABLE kk_cust_attr ADD custom4 varchar(128);
ALTER TABLE kk_cust_attr ADD custom5 varchar(128);

-- Add some dimensions to the sample products (in mm)
UPDATE products SET product_length=200, product_width=50, product_depth=20 where products_id=1;
UPDATE products SET product_length=200, product_width=50, product_depth=20 where products_id=2;
UPDATE products SET product_length=260, product_width=140, product_depth=40 where products_id=3;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=4;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=5;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=6;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=7;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=8;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=9;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=10;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=11;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=12;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=13;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=14;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=15;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=16;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=17;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=18;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=19;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=20;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=21;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=22;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=23;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=24;
UPDATE products SET product_length=550, product_width=160, product_depth=60 where products_id=25;
UPDATE products SET product_length=300, product_width=140, product_depth=60 where products_id=26;
UPDATE products SET product_length=900, product_width=600, product_depth=600 where products_id=27;
UPDATE products SET product_length=600, product_width=240, product_depth=100 where products_id=28;
UPDATE products SET product_length=0, product_width=0, product_depth=0 where products_id=29;
UPDATE products SET product_length=900, product_width=600, product_depth=600 where products_id=30;
UPDATE products SET product_length=550, product_width=160, product_depth=60 where products_id=31;
UPDATE products SET product_length=240, product_width=120, product_depth=80 where products_id=32;
UPDATE products SET product_length=500, product_width=400, product_depth=200 where products_id=33;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=34;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=35;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=36;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=37;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=38;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=39;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=40;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=41;
UPDATE products SET product_length=2800, product_width=1200, product_depth=1000 where products_id=42;
UPDATE products SET product_length=600, product_width=400, product_depth=220 where products_id=43;
UPDATE products SET product_length=1000, product_width=500, product_depth=500 where products_id=44;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=45;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=46;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=47;
UPDATE products SET product_length=260, product_width=240, product_depth=100 where products_id=48;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=49;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=50;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=51;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=52;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=53;
UPDATE products SET product_length=320, product_width=280, product_depth=180 where products_id=54;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=55;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=56;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=57;
UPDATE products SET product_length=240, product_width=120, product_depth=80 where products_id=58;
UPDATE products SET product_length=800, product_width=600, product_depth=240 where products_id=59;
UPDATE products SET product_length=320, product_width=180, product_depth=180 where products_id=60;
UPDATE products SET product_length=320, product_width=180, product_depth=180 where products_id=61;
UPDATE products SET product_length=500, product_width=500, product_depth=120 where products_id=62;
UPDATE products SET product_length=200, product_width=140, product_depth=20 where products_id=63;

-- Make model codes unique
UPDATE products SET products_model='KFIREHD' where products_id=34;
UPDATE products SET products_model='IPHONE5' where products_id=35;
UPDATE products SET products_model='MV800' where products_id=50;
UPDATE products SET products_model='VISCLOCK' where products_id=57;
UPDATE products SET products_model='WSCLOCK' where products_id=62;

-- Batch Log file location
DELETE FROM configuration WHERE configuration_key = 'BATCH_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Batch Log file Directory', 'BATCH_LOG_FILE_DIRECTORY', 'C:/KonaKart/batchlogs/', 'The location where KonaKart will write batch log files', 20, 2, current timestamp);

-- Scheduler APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getJobStatus','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'runBatchJob','', current timestamp);

-- Panels for Scheduling
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_jobs','Scheduled Jobs', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_viewBatchLogs','View Batch Jobs', current timestamp);

-- Add access to the Scheduling Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_jobs';

-- Add access to the View Batch Logs Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewBatchLogs';

-- Admin APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertProductCategory', '', current timestamp);

-- Extend the size of the order name fields
ALTER TABLE orders ALTER COLUMN customers_name SET DATA TYPE VARCHAR(66);
ALTER TABLE orders ALTER COLUMN delivery_name SET DATA TYPE VARCHAR(66);
ALTER TABLE orders ALTER COLUMN billing_name SET DATA TYPE VARCHAR(66);

-- New Batch jobs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'com.konakartadmin.bl.AdminCustomerBatchMgr.countCustomersBatch', '', current timestamp);

-- New config variables for mobile application
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE_M';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added) VALUES (nextval for configuration_seq, 'Mobile Store-Front script base','STORE_FRONT_SCRIPT_BASE_M','/konakart-m/script','Script base used in JSPs for mobile store-front application',4, 20, 1, current timestamp);
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE_M';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, return_by_api, date_added) VALUES (nextval for configuration_seq, 'Mobile Store-Front style sheet base','STORE_FRONT_STYLE_BASE_M','/konakart-m/styles','Style sheet base used in JSPs for mobile store-front application',4, 21, 1, current timestamp);

-- Note that here we only create them as VARCHAR(2) here (to optimise performance for users who do not need these)
-- If you need them to be longer you can modify these columns and change the Admin App validation to suit your needs
ALTER TABLE products_description ADD customd1 VARCHAR(2);
ALTER TABLE products_description ADD customd2 VARCHAR(2);
ALTER TABLE products_description ADD customd3 VARCHAR(2);
ALTER TABLE products_description ADD customd4 VARCHAR(2);
ALTER TABLE products_description ADD customd5 VARCHAR(2);
ALTER TABLE products_description ADD customd6 VARCHAR(2);

-- New tailFile API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'tailFile', '', current timestamp);


-----------------  v7.0.0.0

-- New DB table for allowing a product to be associated with multiple custom attribute templates
DROP TABLE kk_product_to_templates;
CREATE TABLE kk_product_to_templates (
  store_id VARCHAR(64),
  products_id INTEGER NOT NULL,
  cust_attr_tmpl_id INTEGER NOT NULL,
  sort_order INTEGER DEFAULT 0 NOT NULL,
  PRIMARY KEY(products_id ,cust_attr_tmpl_id)
);

-- Sitemap file location
DELETE FROM configuration WHERE configuration_key = 'SITEMAP_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Sitemap file Directory', 'SITEMAP_FILE_DIRECTORY', 'C:/KonaKart/batchlogs/', 'The location where KonaKart will write sitemap files', 30, 1, current timestamp);

-- Sitemap Config panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_sitemap', 'SitemapConfiguration', current timestamp);

-- Add access to the Sitemap Config Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_sitemap';

-- Insert a Configuration for the Importer File Path
DELETE FROM configuration WHERE configuration_key = 'IMPORT_FILES_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Import files path','IMPORT_FILES_PATH','C:/KonaKart/data/','The import data files location',29,50,current timestamp);

-- Importer Log file location
DELETE FROM configuration WHERE configuration_key = 'IMPORTER_LOG_FILE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Importer Log file Directory', 'IMPORTER_LOG_FILE_DIRECTORY', 'C:/KonaKart/importerlogs/', 'The location where KonaKart will write importer log files', 29, 60, current timestamp);

-- Add some Configuration Groups
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Reward Points', 'Reward Points Configuration', 26, 1, null);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'PDF Configuration', 'PDF Configuration', 27, 1, null);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Velocity Templates', 'Velocity Templates Configuration', 28, 1, null);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Importer Config', 'Importer Configuration', 29, 1, null);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'Sitemap', 'Sitemap Configuration', 30, 1, null);

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_importer','Importer', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_importerConfig','Importer Configuration', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_resetDatabase','Reset Database', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_viewImporterLogs','View Importer Jobs', current timestamp);

-- Add access to the Importer Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_importer';

-- Add access to the Importer Config Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_importerConfig';

-- Add access to the Reset Database Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_resetDatabase';

-- Add access to the View Importer Logs Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewImporterLogs';

-- Add custom privileges for the Importer panel - default to allow access to the Custom Importer1 button - custom 1 hides it
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set Custom1 button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');
-- Add custom privileges for the Importer panel - default to allow access to the Custom Importer2 button - custom 2 hides it
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set Custom2 button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');
-- Add custom privileges for the Importer panel - default to allow access to the Custom Importer3 button - custom 3 hides it
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set Custom3 button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');
-- Add custom privileges for the Importer panel - default to allow access to the Upload button - custom 4 hides it
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set Upload button is not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_importer');

-----------------  v7.1.0.0

-- Add extra attributes to Order for multi-vendor mode
ALTER TABLE orders ADD store_name VARCHAR(64);
ALTER TABLE orders ADD parent_id int DEFAULT 0;

-- Configuration variable to enable multi-vendor mode
DELETE FROM configuration WHERE configuration_key = 'MULTI_VENDOR_MODE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Enable multi-vendor mode','MULTI_VENDOR_MODE','false','Set to true to enable multi-vendor mode. KK Engine must be in shared products mode.',1, 35, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Addr addr store id to address table
ALTER TABLE address_book ADD addr_store_id varchar(64);

-- New Velocity Templates Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_velocityTemplates','Maintain Velocity Templates', current timestamp);

-- Add access to the Velocity Templates Panel to all roles that can access the Configuration panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_velocityTemplates';

-- New copyFile API
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'copyFile', '', current timestamp);

-- Config variable for formatting store addresses in admin app
DELETE FROM configuration WHERE configuration_key = 'ADMIN_APP_STORE_ADDR_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Addr Format for Store Addr', 'ADMIN_APP_STORE_ADDR_FORMAT', '$street $street1 $suburb $city $state $country', 'How the address is formatted in the store address panel', 21, 1, current timestamp, 0);

-- Address Panel for stores
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_store_address', 'Store Addresses', current timestamp);

-- Add Address Panel access to all roles that can access the Customer panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_store_address';

-- Configuration variable to force login for storefront app
DELETE FROM configuration WHERE configuration_key = 'APP_FORCE_LOOGIN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Storefront force login','APP_FORCE_LOOGIN','false','Set to true to force customers to login in order to be able to use the storefront application.',1, 38, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-----------------  v7.1.1.0

-- No Database Changes in v7.1.1.0

-----------------  v7.2.0.0

-- Add some extra fields to the ipn_history table
ALTER TABLE ipn_history ADD gateway_capture_id varchar(64);
ALTER TABLE ipn_history ADD gateway_credit_id varchar(64);
ALTER TABLE ipn_history ADD admin_payment_class varchar(128);

-- Table for refunds
DROP TABLE kk_order_refunds;
CREATE TABLE kk_order_refunds (
  order_refunds_id INTEGER NOT NULL,
  orders_id INTEGER NOT NULL,
  ipn_history_id int,
  orders_number VARCHAR(128),
  refund_note VARCHAR(4000),
  refund_amount decimal(15,4),
  gateway_credit_id VARCHAR(64),
  notify_customer INTEGER DEFAULT 0,
  refund_status INTEGER DEFAULT 0,
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  store_id VARCHAR(64),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom1Dec decimal(15,4),
  custom2Dec decimal(15,4),
  PRIMARY KEY(order_refunds_id)
);
DROP SEQUENCE kk_order_refunds_SEQ;
CREATE SEQUENCE kk_order_refunds_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel for Refunds
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_refunds','Order Refunds', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_refundsFromOrders','Order Refunds For Order', current timestamp);

-- Add Refunds Panels access to all roles that can access the Order panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refunds';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_refundsFromOrders';

-- API calls for Refunds
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'editOrderRefund','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertOrderRefund','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteOrderRefund','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderRefund','', current timestamp);

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 9;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Approved');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'de'),'R??ckerstattung Genehmigt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Aprobado');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (9,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Aprovado');

-- Add a new order status
DELETE FROM orders_status WHERE orders_status_id = 10;
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Declined');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'de'),'R??ckerstattung Abgelehnt');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Rehus??');
INSERT INTO orders_status(orders_status_id, language_id, orders_status_name) VALUES (10,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Recusado');

-- Add new product option types
ALTER TABLE customers_basket_attrs ADD customer_price DECIMAL(15,2);
ALTER TABLE customers_basket_attrs ADD customer_string VARCHAR(512);
ALTER TABLE orders_products_attributes ADD customer_price DECIMAL(15,2);
ALTER TABLE orders_products_attributes ADD customer_string VARCHAR(512);

-- Table for KonaKart Events
DROP TABLE kk_event;
CREATE TABLE kk_event (
  kk_event_id INTEGER NOT NULL,
  kk_event_code INTEGER NOT NULL,
  kk_event_subcode INT,
  kk_event_value VARCHAR(64),
  store_id VARCHAR(64),
  custom1 VARCHAR(64),
  date_added TIMESTAMP,
  PRIMARY KEY(kk_event_id)
);
DROP SEQUENCE kk_event_SEQ;
CREATE SEQUENCE kk_event_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- API calls for KonaKart Events
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertKKEvent','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getKKEvents','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteKKEvents','', current timestamp);

-- Configuration variable to enable/disable Product Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Cache Products','CACHE_PRODUCTS','true','Set to true to Cache Products in memory.',11, 15, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Configuration variable to enable/disable Product Image Name Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_PRODUCT_IMAGES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Cache Product Images','CACHE_PRODUCT_IMAGES','true','Set to true to Cache Product Image Names in memory.',11, 20, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- New Custom Panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customA','Custom Panel A', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customB','Custom Panel B', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customC','Custom Panel C', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customD','Custom Panel D', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customE','Custom Panel E', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customF','Custom Panel F', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customG','Custom Panel G', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customH','Custom Panel H', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customI','Custom Panel I', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customJ','Custom Panel J', current timestamp);

-- Set up Custom Panels A-D as examples
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customA';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customB';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orders' and p2.code='kk_panel_customC';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_promotions' and p2.code='kk_panel_customD';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_refreshCache' and p2.code='kk_panel_customE';

-- Table for Shippers
DROP TABLE kk_shipper;
CREATE TABLE kk_shipper (
  shipper_id INTEGER NOT NULL,
  name VARCHAR(64) NOT NULL,
  tracking_url VARCHAR(255),
  date_added TIMESTAMP,
  store_id VARCHAR(64),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  PRIMARY KEY(shipper_id)
);
DROP SEQUENCE kk_shipper_SEQ;
CREATE SEQUENCE kk_shipper_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Panel for Shippers
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_shippers','Shippers', current timestamp);

-- Add Shippers Panel access to all roles that can access the Order status panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orderStatuses' and p2.code='kk_panel_shippers';

-- API calls for Shippers
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateShipper','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertShipper','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getShippers','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getShipper','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteShipper','', current timestamp);

-- Virtual kk_panel_customerForReview_2 Panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_customerForReview_2', 'Customer From Reviews 2', current timestamp);

-- Add Panel access to all roles that can access the kk_panel_customerForReview panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customerForReview' and p2.code='kk_panel_customerForReview_2';

-- Add custom privileges for kk_panel_customerForReview_2 panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to Access Invisible Customers' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set reviews button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set custom button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview_2');

-- Add custom privileges for the kk_panel_customerForReview panel
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='If set email is disabled' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='If set cannot reset password' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set customer search droplists are disabled' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set login button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');
UPDATE kk_role_to_panel SET custom5=0, custom5_desc='If set addresses button is hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customerForReview');

-- Tables for order shipments
DROP TABLE kk_order_shipments;
CREATE TABLE kk_order_shipments (
  order_shipment_id INTEGER NOT NULL,
  order_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  order_number VARCHAR(128),
  shipper_name VARCHAR(64),
  shipper_id int,
  tracking_number VARCHAR(64),
  tracking_url VARCHAR(255),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  shipment_notes VARCHAR(4000),
  date_added TIMESTAMP,
  last_modified TIMESTAMP,
  PRIMARY KEY(order_shipment_id)
);
DROP SEQUENCE kk_order_shipments_SEQ;
CREATE SEQUENCE kk_order_shipments_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

DROP TABLE kk_shipments_to_ord_prods;
CREATE TABLE kk_shipments_to_ord_prods (
  order_shipment_id INTEGER NOT NULL,
  order_product_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  quantity INTEGER NOT NULL,
  date_added TIMESTAMP,
  PRIMARY KEY(order_shipment_id, order_product_id)
);

-- Panel for Shipments
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_shipments','Order Shipments', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_shipmentsFromOrders','Shipments from Orders Panel', current timestamp);

-- Add Shipments Panel access to all roles that can access the Order returns panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returns' and p2.code='kk_panel_shipments';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_returnsFromOrders' and p2.code='kk_panel_shipmentsFromOrders';

-- API calls for Shipments
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderShipments','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertOrderShipment','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'editOrderShipment','', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteOrderShipment','', current timestamp);

-- New table for allowing miscellaneous prices to be associated to a product
DROP TABLE kk_misc_price;
CREATE TABLE kk_misc_price (
  kk_misc_price_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  product_id INTEGER NOT NULL,
  price_id VARCHAR(128) NOT NULL,
  price_0 decimal(15,4),
  price_1 decimal(15,4),
  price_2 decimal(15,4),
  price_3 decimal(15,4),
  quantity int,
  custom1 VARCHAR(256),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP,
  last_updated TIMESTAMP,
  PRIMARY KEY(kk_misc_price_id)
);
DROP SEQUENCE kk_misc_price_SEQ;
CREATE SEQUENCE kk_misc_price_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_pr_8002e79fd87af ON kk_misc_price (product_id);
CREATE INDEX i_st_8002e79fd87af ON kk_misc_price (store_id);

-- New MiscPrices APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertMiscPrices', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteMiscPrices', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMiscPrices', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateMiscPrices', '', current timestamp);

-- refactor order status table to introduce non semantic key
DROP TABLE orders_status;
CREATE TABLE orders_status (
  orders_status_pk INTEGER NOT NULL,
  store_id VARCHAR(64),
  orders_status_id INTEGER DEFAULT 0 NOT NULL,
  language_id INTEGER DEFAULT 1 NOT NULL,
  orders_status_name VARCHAR(32) NOT NULL,
  notify_customer INTEGER DEFAULT 0,
  PRIMARY KEY(orders_status_pk)
);
DROP SEQUENCE orders_status_SEQ;
CREATE SEQUENCE orders_status_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Add order statuses

--1
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,1,(SELECT languages_id FROM languages WHERE code = 'en'),'Pending');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,1,(SELECT languages_id FROM languages WHERE code = 'de'),'Offen');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,1,(SELECT languages_id FROM languages WHERE code = 'es'),'Pendiente');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,1,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pendente');
--2
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,2,(SELECT languages_id FROM languages WHERE code = 'en'),'Processing');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,2,(SELECT languages_id FROM languages WHERE code = 'de'),'In Bearbeitung');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,2,(SELECT languages_id FROM languages WHERE code = 'es'),'Proceso');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,2,(SELECT languages_id FROM languages WHERE code = 'pt'),'Processamento');
--3
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,3,(SELECT languages_id FROM languages WHERE code = 'en'),'Delivered');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,3,(SELECT languages_id FROM languages WHERE code = 'de'),'Versendet');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,3,(SELECT languages_id FROM languages WHERE code = 'es'),'Entregado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,3,(SELECT languages_id FROM languages WHERE code = 'pt'),'Entregue');
--4
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,4,(SELECT languages_id FROM languages WHERE code = 'en'),'Waiting for Payment');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,4,(SELECT languages_id FROM languages WHERE code = 'de'),'Warte auf Zahlung');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,4,(SELECT languages_id FROM languages WHERE code = 'es'),'Para pago que espera');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,4,(SELECT languages_id FROM languages WHERE code = 'pt'),'?? espera de pagamento');
--5
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,5,(SELECT languages_id FROM languages WHERE code = 'en'),'Payment Received');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,5,(SELECT languages_id FROM languages WHERE code = 'de'),'Zahlung empfangen');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,5,(SELECT languages_id FROM languages WHERE code = 'es'),'Pago recibido');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,5,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pagamento Recebido');
--6
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,6,(SELECT languages_id FROM languages WHERE code = 'en'),'Payment Declined');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,6,(SELECT languages_id FROM languages WHERE code = 'de'),'Zahlung nicht erfolgt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,6,(SELECT languages_id FROM languages WHERE code = 'es'),'Pago declinado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,6,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pagamento recusado');
--7
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,7,(SELECT languages_id FROM languages WHERE code = 'en'),'Partially Delivered');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,7,(SELECT languages_id FROM languages WHERE code = 'de'),'Teilweise geliefert');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,7,(SELECT languages_id FROM languages WHERE code = 'es'),'Entregado parcialmente');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,7,(SELECT languages_id FROM languages WHERE code = 'pt'),'Parcialmente Entregues');
--8
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,8,(SELECT languages_id FROM languages WHERE code = 'en'),'Cancelled');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,8,(SELECT languages_id FROM languages WHERE code = 'de'),'Abgesagt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,8,(SELECT languages_id FROM languages WHERE code = 'es'),'Cancelado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,8,(SELECT languages_id FROM languages WHERE code = 'pt'),'Cancelado');
--9
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,9,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Approved');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,9,(SELECT languages_id FROM languages WHERE code = 'de'),'R??ckerstattung Genehmigt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,9,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Aprobado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,9,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Aprovado');
--10
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,10,(SELECT languages_id FROM languages WHERE code = 'en'),'Refund Declined');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,10,(SELECT languages_id FROM languages WHERE code = 'de'),'R??ckerstattung Abgelehnt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,10,(SELECT languages_id FROM languages WHERE code = 'es'),'Reembolso Rehus??');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,10,(SELECT languages_id FROM languages WHERE code = 'pt'),'Reembolso Recusado');

-- Increase the size of the custom panel
UPDATE configuration set configuration_value = '600px' where configuration_key = 'ADMIN_APP_CUSTOM_PANEL_HEIGHT';

-- Control for SOLR suggested search and spelling
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Add suggested search for invisible prods.','SOLR_ADD_TERM_IF_INVISIBLE','true','Adds a suggested search entry even when products are invisible',24, 120, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Add suggested search for disabled prods.','SOLR_ADD_TERM_IF_DISABLED','true','Adds a suggested search entry even when products are disabled',24, 130, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);

DELETE FROM configuration WHERE configuration_key = 'SOLR_ENABLE_SPELLING_SUGGESTION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Enable spelling suggestions','SOLR_ENABLE_SPELLING_SUGGESTION','true','Enables spelling suggestion functionality',24, 90, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_INVISIBLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Add spelling data for invisible prods.','SOLR_ADD_SPELLING_IF_INVISIBLE','true','Adds data used for spelling suggestions even when products are invisible',24, 150, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_IF_DISABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Add spelling data for disabled prods.','SOLR_ADD_SPELLING_IF_DISABLED','true','Adds data used for spelling suggestions even when products are disabled',24, 160, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);

-- Move single custom attribute templates to the new multiple template structure
INSERT INTO kk_product_to_templates (products_id, cust_attr_tmpl_id) SELECT products_id, cust_attr_tmpl_id FROM products WHERE cust_attr_tmpl_id > -1;

-- Reset the single cust_attr_tmpl_id now that we've migrated to the new multiple template structure
UPDATE products SET cust_attr_tmpl_id = -1 WHERE cust_attr_tmpl_id > -1;

-- Add sort order to product attributes
ALTER TABLE products_attributes ADD sort_order int DEFAULT 0;

-- Set sort field of product attributes
update products_attributes set sort_order = 0 where products_id = 1 and options_id = 3 and options_values_id = 5;
update products_attributes set sort_order = 1 where products_id = 1 and options_id = 3 and options_values_id = 6;
update products_attributes set sort_order = 2 where products_id = 1 and options_id = 4 and options_values_id = 1;
update products_attributes set sort_order = 3 where products_id = 1 and options_id = 4 and options_values_id = 2;
update products_attributes set sort_order = 4 where products_id = 1 and options_id = 4 and options_values_id = 3;

update products_attributes set sort_order = 0 where products_id = 2 and options_id = 3 and options_values_id = 6;
update products_attributes set sort_order = 1 where products_id = 2 and options_id = 3 and options_values_id = 7;
update products_attributes set sort_order = 2 where products_id = 2 and options_id = 4 and options_values_id = 3;
update products_attributes set sort_order = 3 where products_id = 2 and options_id = 4 and options_values_id = 4;

update products_attributes set sort_order = 0 where products_id = 26 and options_id = 3 and options_values_id = 8;
update products_attributes set sort_order = 1 where products_id = 26 and options_id = 3 and options_values_id = 9;

update products_attributes set sort_order = 0 where products_id = 29 and options_id = 5 and options_values_id = 10;
update products_attributes set sort_order = 1 where products_id = 29 and options_id = 5 and options_values_id = 11;
update products_attributes set sort_order = 2 where products_id = 29 and options_id = 5 and options_values_id = 12;

-- Set a description on the EditProduct Panel custom1 field for assigning products to stores
UPDATE kk_role_to_panel SET custom1=0, custom1_desc='Set to allow assignment of products to stores' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

-- Allow super-users to assign products to stores
UPDATE kk_role_to_panel SET custom1=1 WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct') AND role_id IN (SELECT role_id FROM kk_role where super_user=1);

-----------------  v7.3.0.0

DROP TABLE kk_cust_pwd_hist;
CREATE TABLE kk_cust_pwd_hist (
  id INTEGER NOT NULL,
  cust_id INTEGER NOT NULL,
  password VARCHAR(96),
  date_created TIMESTAMP,
  custom1 VARCHAR(128),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_cust_pwd_hist_SEQ;
CREATE SEQUENCE kk_cust_pwd_hist_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'changeUserPassword', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'checkPasswordValidity', '', current timestamp);

-- For Enabling "Other" Gender
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Enable "Other" Gender', 'ENABLE_OTHER_GENDER', 'false', 'Enable "Other" gender in addition to Male and Female', 5, 1, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Remove Access to Data Feeds for all roles
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_dataFeeds');
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_publishProducts');

-- Remove Data Feeds and Publish Products Panels
DELETE FROM kk_panel WHERE code = 'kk_panel_dataFeeds';
DELETE FROM kk_panel WHERE code = 'kk_panel_publishProducts';

-- Add some extra fields to the customers table
ALTER TABLE customers ADD tax_identifier varchar(64);
ALTER TABLE customers ADD tax_exemption varchar(64);
ALTER TABLE customers ADD tax_entity varchar(64);
ALTER TABLE customers ADD ext_reference_1 varchar(64);
ALTER TABLE customers ADD ext_reference_2 varchar(64);

-- Config variable for displaying tax id
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Tax Id','ACCOUNT_TAX_ID','false','Display tax id in the customers account',5, 3, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Remove configuration of the edit customer panel to allow editing of external customers only
UPDATE kk_role_to_panel SET custom1='0', custom1_desc=null WHERE panel_id in (select panel_id from kk_panel WHERE code='kk_panel_editCustomer');

-- For specifying whether or not to Cache Bundle Products
DELETE FROM configuration WHERE configuration_key = 'CACHE_BUNDLE_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Cache Bundle Products','CACHE_BUNDLE_PRODUCTS','false','If true bundle products are cached; if false they are never cached',11, 25, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- For specifying whether or not to create Product Viewed Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_VIEWED_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Create Product Viewed Events','CREATE_PRODUCT_VIEWED_EVENTS','false','If true product viewed events are created; if false they are not.',11, 25, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- For specifying whether or not to Create Product Quantity Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_QTY_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Create Product Quantity Events','CREATE_PRODUCT_QTY_EVENTS','true','If true product quantity change events are created; if false they are not.',11, 29, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- For specifying whether or not to Create Products Ordered Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_ORDERED_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Create Products Ordered Events','CREATE_PRODUCT_ORDERED_EVENTS','true','If true products ordered change events are created; if false they are not.',11, 32, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- For specifying whether or not to Create Product Review Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_REVIEW_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Create Product Review Events','CREATE_PRODUCT_REVIEW_EVENTS','true','If true product review change events are created; if false they are not.',11, 35, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- For specifying whether or not to Create Product Booking Events
DELETE FROM configuration WHERE configuration_key = 'CREATE_PRODUCT_BOOKING_EVENTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Create Product Booking Events','CREATE_PRODUCT_BOOKING_EVENTS','true','If true product booking change events are created; if false they are not.',11, 38, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Max size of KonaKart Product cache
DELETE FROM configuration WHERE configuration_key = 'KK_PRODUCT_CACHE_MAX_SIZE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'KonaKart Product Cache Max Size','KK_PRODUCT_CACHE_MAX_SIZE','1000','Maximum Size (maximum number of Products) in the KonaKart Product Cache',11, 46, 'integer(1,10000)', current timestamp, 1);

-- Example config parameter for the User Defined Configuration Panel
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Example Parameter','USER_DEFINED_EXAMPLE','Example Value','Add your own configuration parameters to group 31 to appear in the User Defined Configs Panel',31, 10, current timestamp, 1);

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_userDefinedConfig','User Defined Configurations', current timestamp);

-- Add User Defined Configurations Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_userDefinedConfig';

-- Add new image API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addImage', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeImage', '', current timestamp);

-- Add new API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeProductFromCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getRMACode', '', current timestamp);

-- Misc Items types for responsive banners
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 1, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 2, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 3, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (4, 4, 'Banner_1_Medium', 'Top medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 1, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 2, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 3, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (5, 4, 'Banner_2_Medium', '2nd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 1, 'Banner_3_Medium', '3rd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 2, 'Banner_3_Medium', '3rd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 3, 'Banner_3_Medium', '3rd medium banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (6, 4, 'Banner_3_Medium', '3rd medium banner');

INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 1, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 2, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 3, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (7, 4, 'Banner_1_Small', 'Top small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 1, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 2, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 3, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (8, 4, 'Banner_2_Small', '2nd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 1, 'Banner_3_Small', '3rd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 2, 'Banner_3_Small', '3rd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 3, 'Banner_3_Small', '3rd small banner');
INSERT INTO kk_misc_item_type (kk_misc_item_type_id, language_id, name, description) VALUES (9, 4, 'Banner_3_Small', '3rd small banner');

-- Misc Items for categories
delete from kk_misc_item;
--cat 1 Computer Peripherals
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 1, 'banners/computer-peripherals/logitech.png', 'SelectProd.action?prodId=31' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 4, 'banners/computer-peripherals/logitech-medium.png', 'SelectProd.action?prodId=31' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 7, 'banners/computer-peripherals/logitech-small.png', 'SelectProd.action?prodId=31' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 2, 'banners/computer-peripherals/hp-photosmart.png','SelectProd.action?prodId=27' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 5, 'banners/computer-peripherals/hp-photosmart-medium.png','SelectProd.action?prodId=27' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 8, 'banners/computer-peripherals/hp-photosmart-small.png','SelectProd.action?prodId=27' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 3, 'banners/computer-peripherals/deals-of-the-week.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 6, 'banners/computer-peripherals/deals-of-the-week-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  1, 2, 9, 'banners/computer-peripherals/deals-of-the-week-small.png', '' );

--cat 2 Games
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 1, 'banners/games/black-ops-2.png', 'SelectProd.action?prodId=63' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 4, 'banners/games/black-ops-2-medium.png', 'SelectProd.action?prodId=63' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 7, 'banners/games/black-ops-2-small.png', 'SelectProd.action?prodId=63' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 2, 'banners/games/swat-3.png','SelectProd.action?prodId=21' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 5, 'banners/games/swat-3-medium.png','SelectProd.action?prodId=21' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 8, 'banners/games/swat-3-small.png','SelectProd.action?prodId=21' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 3, 'banners/games/winter-deals.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 6, 'banners/games/winter-deals-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  2, 2, 9, 'banners/games/winter-deals-small.png', '' );

--cat 3 DVD Movies
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 1, 'banners/movies/dark-knight.png', 'SelectProd.action?prodId=20' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 4, 'banners/movies/dark-knight-medium.png', 'SelectProd.action?prodId=20' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 7, 'banners/movies/dark-knight-small.png', 'SelectProd.action?prodId=20' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 2, 'banners/movies/harry-potter.png','SelectProd.action?prodId=11' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 5, 'banners/movies/harry-potter-medium.png','SelectProd.action?prodId=11' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 8, 'banners/movies/harry-potter-small.png','SelectProd.action?prodId=11' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 3, 'banners/movies/movie-deals.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 6, 'banners/movies/movie-deals-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  3, 2, 9, 'banners/movies/movie-deals-small.png', '' );

--cat 23 Electronics
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 1, 'banners/electronics/kindle-fire-hd.jpg', 'SelectProd.action?prodId=34' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 4, 'banners/electronics/kindle-fire-hd-medium.jpg', 'SelectProd.action?prodId=34' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 7, 'banners/electronics/kindle-fire-hd-small.jpg', 'SelectProd.action?prodId=34' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 2, 'banners/electronics/xbox.png','' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 5, 'banners/electronics/xbox-medium.png','' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 8, 'banners/electronics/xbox-small.png','' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 3, 'banners/electronics/electronics-sale.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 6, 'banners/electronics/electronics-sale-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  23, 2, 9, 'banners/electronics/electronics-sale-small.png', '' );

--cat 24 Home and Garden
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 1, 'banners/home-and-garden/delonghi.png', 'SelectProd.action?prodId=33' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 4, 'banners/home-and-garden/delonghi-medium.png', 'SelectProd.action?prodId=33' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 7, 'banners/home-and-garden/delonghi-small.png', 'SelectProd.action?prodId=33' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 2, 'banners/home-and-garden/rotak-40.png','SelectProd.action?prodId=39' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 5, 'banners/home-and-garden/rotak-40-medium.png','SelectProd.action?prodId=39' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 8, 'banners/home-and-garden/rotak-40-small.png','SelectProd.action?prodId=39' );

INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 3, 'banners/home-and-garden/gifts-for-the-home.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 6, 'banners/home-and-garden/gifts-for-the-home-medium.png', '' );
INSERT INTO kk_misc_item (kk_misc_item_id, kk_obj_id, kk_obj_type_id, kk_misc_item_type_id, item_value, custom1) VALUES (nextval for kk_misc_item_seq,  24, 2, 9, 'banners/home-and-garden/gifts-for-the-home-small.png', '' );

--Change currency labels
UPDATE currencies SET title='US $' WHERE currencies_id = 1;
UPDATE currencies SET title='EUR ???' WHERE currencies_id = 2;

-- Remove config variables for mobile application
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_SCRIPT_BASE_M';
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STYLE_BASE_M';

-----------------  v7.4.0.0

-- Table for Content Types
DROP TABLE kk_content_type;
CREATE TABLE kk_content_type (
  id INTEGER NOT NULL,
  content_type_id INTEGER DEFAULT 0 NOT NULL,
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added TIMESTAMP,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_content_type_SEQ;
CREATE SEQUENCE kk_content_type_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_co_857799e2b5683 ON kk_content_type (content_type_id);

-- Table for Content Type Descriptions
DROP TABLE kk_content_type_desc;
CREATE TABLE kk_content_type_desc (
  id INTEGER NOT NULL,
  content_type_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  content_type_name VARCHAR(32),
  description VARCHAR(256),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added TIMESTAMP,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_content_type_desc_SEQ;
CREATE SEQUENCE kk_content_type_desc_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_co_7df43ffab1495 ON kk_content_type_desc (content_type_id);

-- Table for Content
DROP TABLE kk_content;
CREATE TABLE kk_content (
  id INTEGER NOT NULL,
  content_id INTEGER DEFAULT 0 NOT NULL,
  content_type_id INTEGER DEFAULT 0 NOT NULL,
  object_id INT,
  obj_type_id INT,
  click_url VARCHAR(256),
  date_from TIMESTAMP,
  date_to TIMESTAMP,
  enabled INTEGER DEFAULT 0 NOT NULL,
  expression_id INTEGER DEFAULT 0 NOT NULL,
  search_key VARCHAR(128),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  custom3 VARCHAR(32),
  custom4 VARCHAR(32),
  updated_by INTEGER NOT NULL,
  date_updated TIMESTAMP,
  date_added TIMESTAMP,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_content_SEQ;
CREATE SEQUENCE kk_content_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_co_72719f001243b ON kk_content (content_id);
CREATE INDEX i_se_72719f001243b ON kk_content (search_key);

-- Table for Content Descriptions
DROP TABLE kk_content_desc;
CREATE TABLE kk_content_desc (
  id INTEGER NOT NULL,
  content_id INTEGER NOT NULL,
  language_id INTEGER NOT NULL,
  name1 VARCHAR(256),
  name2 VARCHAR(256),
  name3 VARCHAR(256),
  name4 VARCHAR(256),
  title VARCHAR(256),
  content VARCHAR(4000),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  custom3 VARCHAR(32),
  custom4 VARCHAR(32),
  date_added TIMESTAMP,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_content_desc_SEQ;
CREATE SEQUENCE kk_content_desc_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_co_857799e2b55f1 ON kk_content_desc (content_id);

-- Populate the Content tables
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 1, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 2, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 3, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 4, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 5, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 6, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 7, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 8, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 9, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 10, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 11, current date);
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 12, current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 1, 1, 'Top Banner', 'Top Banner - Top of store home page', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 1, 2, 'Top Banner', 'Top Banner - Top of store Startseite', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 1, 3, 'Top Banner', 'Top Banner - Inicio de tienda de la p??gina principal', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 1, 4, 'Top Banner', 'Top Banner - Top of Home Page da loja', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 2, 1, 'Sub Banner', 'Sub Banner - Secondary banner', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 2, 2, 'Sub Banner', 'Sub Banner - Sekund??r banner', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 2, 3, 'Sub Banner', 'Sub Banner - banner Secundaria', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 2, 4, 'Sub Banner', 'Sub Banner - bandeira Secund??rio', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 3, 1, 'Category Banner', 'Category Banner - Top of category pages', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 3, 2, 'Kategorie Banner', 'Kategorie Banner - Top of Kategorieseiten', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 3, 3, 'Categoria Banner', 'Categor??a Banner - Inicio de las p??ginas de categor??as', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 3, 4, 'Categoria Banner', 'Categoria Banner - Top de p??ginas da categoria', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 4, 1, 'Category Sub Banner', 'Category Sub Banner - Secondary Category Banner', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 4, 2, 'Kategorie Unter Banner', 'Kategorie Unter Banner - Sekund??re Kategorie Banner', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 4, 3, 'Categor??a Sub Banner', 'Categor??a Sub Banner - Categor??a Secundaria Banner', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 4, 4, 'Categor??a Sub Banner', 'Categoria Sub Banner - Categoria Secund??ria Bandeira', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 5, 1, 'About Us', 'About Us Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 5, 2, '??ber uns', '??ber uns', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 5, 3, 'sobre nosotros', 'sobre nosotros', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 5, 4, 'sobre n??s', 'sobre n??s', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 6, 1, 'Shipping and Handling', 'Shipping and Handling Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 6, 2, 'Versand-und Bearbeitungs', 'Versand-und Bearbeitungs', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 6, 3, 'Env??o y manipulaci??n', 'Env??o y manipulaci??n', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 6, 4, 'Envio e manipula????o', 'Envio e manipula????o', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 7, 1, 'Product Returns', 'Product Returns Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 7, 2, 'Produktr??ckgabe', 'Produktr??ckgabe', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 7, 3, 'Devoluci??n de productos', 'Devoluci??n de productos', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 7, 4, 'Devolu????es de produtos', 'Devolu????es de produtos', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 8, 1, 'International Orders', 'International Orders Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 8, 2, 'International Orders', 'International Orders Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 8, 3, 'Pedidos internacionales', 'Pedidos internacionales', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 8, 4, 'Encomendas internacionais', 'Encomendas internacionais', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 9, 1, 'Privacy Policy', 'Privacy Policy Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 9, 2, 'Datenschutz-Bestimmungen', 'Datenschutz-Bestimmungen', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 9, 3, 'Pol??tica de privacidad', 'pol??tica de privacidad', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 9, 4, 'Pol??tica De Privacidade', 'Pol??tica De Privacidade', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 10, 1, 'Terms of use', 'Terms of use Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 10, 2, 'Nutzungsbedingungen', 'Nutzungsbedingungen', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 10, 3, 'Condiciones de uso', 'Condiciones de uso', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 10, 4, 'Termos de uso', 'Termos de uso', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 11, 1, 'Help', 'Help Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 11, 2, 'Hilfe', 'Hilfe', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 11, 3, '??Ayuda', '??Ayuda', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 11, 4, 'Socorro', 'Socorro', current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 12, 1, 'Contact Us', 'Contact Us Text', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 12, 2, 'Kontaktdetails', 'Kontaktdetails', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 12, 3, 'Detalles de contacto', 'Detalles de contacto', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 12, 4, 'Detalhes de Contato', 'Detalhes de Contato', current date);

-- Category Banners

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 1, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Computer Peripherals', 31, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 1, 1, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 1, 2, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 1, 3, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 1, 4, 'logitech.png', 'logitech-medium.png', 'logitech-small.png', 'Logitech Keyboard', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 2, 4, 'SelectProd.action?prodId={OBJ_ID}', 'Computer Peripherals', 27, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 2, 1, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 2, 2, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 2, 3, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 2, 4, 'hp-photosmart.png', 'hp-photosmart-medium.png', 'hp-photosmart-small.png', 'HP Photosmart 5510', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 3, 4, '', 'Computer Peripherals', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 3, 1, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 3, 2, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 3, 3, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 3, 4, 'deals-of-the-week.png', 'deals-of-the-week-medium.png', 'deals-of-the-week-small.png', 'Deals of the Week', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 4, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Games', 63, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 4, 1, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 4, 2, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 4, 3, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 4, 4, 'black-ops-2.png', 'black-ops-2-medium.png', 'black-ops-2-small.png', 'Black Ops 2', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 5, 4, 'SelectProd.action?prodId={OBJ_ID}', 'Games', 21, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 5, 1, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 5, 2, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 5, 3, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 5, 4, 'swat-3.png', 'swat-3-medium.png', 'swat-3-small.png', 'Swat-3', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 6, 4, '', 'Games', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 6, 1, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 6, 2, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 6, 3, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 6, 4, 'winter-deals.png', 'winter-deals-medium.png', 'winter-deals-small.png', 'Winter Deals', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 7, 3, 'SelectProd.action?prodId={OBJ_ID}', 'DVD Movies', 20, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 7, 1, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 7, 2, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 7, 3, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 7, 4, 'dark-knight.png', 'dark-knight-medium.png', 'dark-knight-small.png', 'Dark Night', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 8, 4, 'SelectProd.action?prodId={OBJ_ID}', 'DVD Movies', 11, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 8, 1, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 8, 2, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 8, 3, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 8, 4, 'harry-potter.png', 'harry-potter-medium.png', 'harry-potter-small.png', 'Harry Potter', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 9, 4, '', 'DVD Movies', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 9, 1, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 9, 2, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 9, 3, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 9, 4, 'movie-deals.png', 'movie-deals-medium.png', 'movie-deals-small.png', 'Movie Deals', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 10, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Electronics', 34, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 10, 1, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 10, 2, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 10, 3, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 10, 4, 'kindle-fire-hd.jpg', 'kindle-fire-hd-medium.jpg', 'kindle-fire-hd-small.jpg', 'Kindle Fire', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 11, 4, '', 'Electronics', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 11, 1, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 11, 2, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 11, 3, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 11, 4, 'xbox.png', 'xbox-medium.png', 'xbox-small.png', 'Xbox', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 12, 4, '', 'Electronics', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 12, 1, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 12, 2, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 12, 3, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 12, 4, 'electronics-sale.png', 'electronics-sale-medium.png', 'electronics-sale-small.png', 'Electronics Sale', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 13, 3, 'SelectProd.action?prodId={OBJ_ID}', 'Home & Garden', 33, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 13, 1, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 13, 2, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 13, 3, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 13, 4, 'delonghi.png', 'delonghi-medium.png', 'delonghi-small.png', 'DeLonghi Coffee Maker', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 14, 4, 'SelectProd.action?prodId={OBJ_ID}', 'Home & Garden', 39, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 14, 1, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 14, 2, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 14, 3, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 14, 4, 'rotak-40.png', 'rotak-40-medium.png', 'rotak-40-small.png', 'Rotak 40', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 15, 4, '', 'Home & Garden', 39, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 15, 1, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 15, 2, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 15, 3, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 15, 4, 'gifts-for-the-home.png', 'gifts-for-the-home-medium.png', 'gifts-for-the-home-small.png', 'Gifts for the home', current date);

-- Top Banners on Home Page

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 16, 1, 'SelectProd.action?prodId={OBJ_ID}','TOP_BANNER_1', 34, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 16, 1, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 16, 2, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 16, 3, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 16, 4, 'home_kindle-fire-hd.jpg', 'home_kindle-fire-hd-medium.jpg', 'home_kindle-fire-hd-small.jpg', 'Kindle Fire', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 17, 1, 'SelectProd.action?prodId={OBJ_ID}','TOP_BANNER_2', 33, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 17, 1, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 17, 2, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 17, 3, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 17, 4, 'home_delonghi.png', 'home_delonghi-medium.png', 'home_delonghi-small.png', 'DeLonghi Coffee Maker', current date);

-- Sub-Banners on Home Page

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 18, 2, 'ShowSpecials.action','SUB_BANNER_1', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 18, 1, 'home_electronics-sale.jpg', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 18, 2, 'home_electronics-sale.jpg', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 18, 3, 'home_electronics-sale.jpg', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 18, 4, 'home_electronics-sale.jpg', 'Electronics Sale', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 19, 2, 'SelectCat.action?catId={OBJ_ID}','SUB_BANNER_2', 23, 2, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 19, 1, 'home_electronics-sale-2.jpg', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 19, 2, 'home_electronics-sale-2.jpg', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 19, 3, 'home_electronics-sale-2.jpg', 'Electronics Sale', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 19, 4, 'home_electronics-sale-2.jpg', 'Electronics Sale', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 20, 2, 'SelectCat.action?catId={OBJ_ID}','SUB_BANNER_3', 24, 2, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 20, 1, 'home_gifts-for-the-home.jpg', 'Gifts for the home', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 20, 2, 'home_gifts-for-the-home.jpg', 'Gifts for the home', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 20, 3, 'home_gifts-for-the-home.jpg', 'Gifts for the home', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 20, 4, 'home_gifts-for-the-home.jpg', 'Gifts for the home', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 21, 2, 'SelectProd.action?prodId={OBJ_ID}','SUB_BANNER_4', 32, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 21, 1, 'home_windows-8.jpg', 'Windows-8', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 21, 2, 'home_windows-8.jpg', 'Windows-8', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 21, 3, 'home_windows-8.jpg', 'Windows-8', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 21, 4, 'home_windows-8.jpg', 'Windows-8', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 22, 2, 'SelectProd.action?prodId={OBJ_ID}','SUB_BANNER_5', 35, 1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 22, 1, 'home_iphone-5.jpg', 'iPhone 5', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 22, 2, 'home_iphone-5.jpg', 'iPhone 5', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 22, 3, 'home_iphone-5.jpg', 'iPhone 5', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 22, 4, 'home_iphone-5.jpg', 'iPhone 5', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 23, 5, '','ABOUT_US', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 23, 1, 'Add your About Us information here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 23, 2, 'F??gen Sie Ihre ??ber uns Informationen hier', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 23, 3, 'A??ade tu Qui??nes somos informaci??n aqu??', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 23, 4, 'Adicione a sua Quem somos informa????es aqui', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 24, 6, '','SHIPPING_HANDLING', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 24, 1, 'Add your Shipping and Handling information here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 24, 2, 'F??gen Sie Ihre Versandinformationen hier', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 24, 3, 'Agregue su env??o y manipulaci??n de informaci??n aqu??', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 24, 4, 'Adicione sua informa????o de envio aqui', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 25, 7, '','RETURNS', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 25, 1, 'Add your Returns information here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 25, 2, 'F??gen Sie Ihre Versandkosten Informationen finden Sie hier', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 25, 3, 'A??ade tu informaci??n Devoluciones aqu??', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 25, 4, 'Adicione sua informa????o Returns aqui', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 26, 8, '','INTERNATIONAL_ORDERS', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 26, 1, 'Add your International Orders information here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 26, 2, 'F??gen Sie hier Ihre Informationen Internationale Bestellungen.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 26, 3, 'A??ade tu informaci??n Internacional ??rdenes aqu??.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 26, 4, 'Adicione sua informa????o Internacional Ordens aqui.', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 27, 9, '','PRIVACY', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 27, 1, 'Add your Privacy Policy here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 27, 2, 'F??gen Sie Ihren Datenschutz hier.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 27, 3, 'Agregue su pol??tica de privacidad aqu??.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 27, 4, 'Adicione a sua Pol??tica de Privacidade aqui.', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 28, 10, '','TERMS_CONDITIONS', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 28, 1, 'Add your Terms of Use here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 28, 2, 'F??gen Sie Ihr Nutzungsbedingungen hier', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 28, 3, 'A??ada sus T??rminos de Uso aqu??', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 28, 4, 'Adicione seus Termos de Uso aqui', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 29, 11, '','HELP', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 29, 1, 'Add your Help information here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 29, 2, 'F??gen Sie hier Ihre Informationen Hilfe.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 29, 3, 'A??ade tu informaci??n de ayuda aqu??.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 29, 4, 'Adicione sua informa????o ajuda aqui.', current date);

INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 30, 12, '','CONTACT', 0, 0, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 30, 1, 'Add your Contact information here.', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 30, 2, 'F??gen Sie Ihre Kontaktinformationen hier', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 30, 3, 'A??adir su informaci??n de contacto aqu??', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, content, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 30, 4, 'Adicione sua informa????o de contato aqui', current date);

-- New API calls for Content
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getContents', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getContent', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertContent', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteContent', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateContent', '', current timestamp);

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getContentTypes', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getContentType', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertContentType', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteContentType', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateContentType', '', current timestamp);

-- New Admin App Panels for Content

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_contentTypes','Content Types', current timestamp);

-- Add Content Type Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_contentTypes';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_content','Content', current timestamp);

-- Add Content Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_content';

INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_editContent','Edit Content', current timestamp);

-- Add Content Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_editContent';

-- Add a search key to categories
ALTER TABLE categories ADD search_key varchar(128);
UPDATE categories C SET search_key = (SELECT CD.categories_name FROM categories_description CD WHERE C.categories_id = CD.categories_id AND CD.language_id IN (SELECT languages_id FROM languages L, configuration CON WHERE code=configuration_value AND configuration_key='DEFAULT_LANGUAGE'));

DELETE FROM configuration WHERE configuration_key = 'ENABLE_KONAKART_CONTENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Enable KonaKart Content', 'ENABLE_KONAKART_CONTENT', 'false', 'When set to true, KonaKart Content is enabled', 1, 10, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'STORE_COUNTRY';

-- Add iso_numeric and custom1 columns to countries
ALTER TABLE countries ADD iso_numeric VARCHAR(10);
ALTER TABLE countries ADD custom1 VARCHAR(10);

DELETE FROM countries WHERE countries_iso_code_3 = 'FXX';
UPDATE countries SET iso_numeric = '004' WHERE countries_iso_code_3 = 'AFG';
UPDATE countries SET iso_numeric = '248' WHERE countries_iso_code_3 = 'ALA';
UPDATE countries SET iso_numeric = '008' WHERE countries_iso_code_3 = 'ALB';
UPDATE countries SET iso_numeric = '012' WHERE countries_iso_code_3 = 'DZA';
UPDATE countries SET iso_numeric = '016' WHERE countries_iso_code_3 = 'ASM';
UPDATE countries SET iso_numeric = '020' WHERE countries_iso_code_3 = 'AND';
UPDATE countries SET iso_numeric = '024' WHERE countries_iso_code_3 = 'AGO';
UPDATE countries SET iso_numeric = '660' WHERE countries_iso_code_3 = 'AIA';
UPDATE countries SET iso_numeric = '010' WHERE countries_iso_code_3 = 'ATA';
UPDATE countries SET iso_numeric = '028' WHERE countries_iso_code_3 = 'ATG';
UPDATE countries SET iso_numeric = '032' WHERE countries_iso_code_3 = 'ARG';
UPDATE countries SET iso_numeric = '051' WHERE countries_iso_code_3 = 'ARM';
UPDATE countries SET iso_numeric = '533' WHERE countries_iso_code_3 = 'ABW';
UPDATE countries SET iso_numeric = '036' WHERE countries_iso_code_3 = 'AUS';
UPDATE countries SET iso_numeric = '040' WHERE countries_iso_code_3 = 'AUT';
UPDATE countries SET iso_numeric = '031' WHERE countries_iso_code_3 = 'AZE';
UPDATE countries SET iso_numeric = '044' WHERE countries_iso_code_3 = 'BHS';
UPDATE countries SET iso_numeric = '048' WHERE countries_iso_code_3 = 'BHR';
UPDATE countries SET iso_numeric = '050' WHERE countries_iso_code_3 = 'BGD';
UPDATE countries SET iso_numeric = '052' WHERE countries_iso_code_3 = 'BRB';
UPDATE countries SET iso_numeric = '112' WHERE countries_iso_code_3 = 'BLR';
UPDATE countries SET iso_numeric = '056' WHERE countries_iso_code_3 = 'BEL';
UPDATE countries SET iso_numeric = '084' WHERE countries_iso_code_3 = 'BLZ';
UPDATE countries SET iso_numeric = '204' WHERE countries_iso_code_3 = 'BEN';
UPDATE countries SET iso_numeric = '060' WHERE countries_iso_code_3 = 'BMU';
UPDATE countries SET iso_numeric = '064' WHERE countries_iso_code_3 = 'BTN';
UPDATE countries SET iso_numeric = '068' WHERE countries_iso_code_3 = 'BOL';
UPDATE countries SET iso_numeric = '070' WHERE countries_iso_code_3 = 'BIH';
UPDATE countries SET iso_numeric = '072' WHERE countries_iso_code_3 = 'BWA';
UPDATE countries SET iso_numeric = '074' WHERE countries_iso_code_3 = 'BVT';
UPDATE countries SET iso_numeric = '076' WHERE countries_iso_code_3 = 'BRA';
UPDATE countries SET iso_numeric = '092' WHERE countries_iso_code_3 = 'VGB';
UPDATE countries SET iso_numeric = '086' WHERE countries_iso_code_3 = 'IOT';
UPDATE countries SET iso_numeric = '096' WHERE countries_iso_code_3 = 'BRN';
UPDATE countries SET iso_numeric = '100' WHERE countries_iso_code_3 = 'BGR';
UPDATE countries SET iso_numeric = '854' WHERE countries_iso_code_3 = 'BFA';
UPDATE countries SET iso_numeric = '108' WHERE countries_iso_code_3 = 'BDI';
UPDATE countries SET iso_numeric = '116' WHERE countries_iso_code_3 = 'KHM';
UPDATE countries SET iso_numeric = '120' WHERE countries_iso_code_3 = 'CMR';
UPDATE countries SET iso_numeric = '124' WHERE countries_iso_code_3 = 'CAN';
UPDATE countries SET iso_numeric = '132' WHERE countries_iso_code_3 = 'CPV';
UPDATE countries SET iso_numeric = '136' WHERE countries_iso_code_3 = 'CYM';
UPDATE countries SET iso_numeric = '140' WHERE countries_iso_code_3 = 'CAF';
UPDATE countries SET iso_numeric = '148' WHERE countries_iso_code_3 = 'TCD';
UPDATE countries SET iso_numeric = '152' WHERE countries_iso_code_3 = 'CHL';
UPDATE countries SET iso_numeric = '156' WHERE countries_iso_code_3 = 'CHN';
UPDATE countries SET iso_numeric = '344' WHERE countries_iso_code_3 = 'HKG';
UPDATE countries SET iso_numeric = '446' WHERE countries_iso_code_3 = 'MAC';
UPDATE countries SET iso_numeric = '162' WHERE countries_iso_code_3 = 'CXR';
UPDATE countries SET iso_numeric = '166' WHERE countries_iso_code_3 = 'CCK';
UPDATE countries SET iso_numeric = '170' WHERE countries_iso_code_3 = 'COL';
UPDATE countries SET iso_numeric = '174' WHERE countries_iso_code_3 = 'COM';
UPDATE countries SET iso_numeric = '178' WHERE countries_iso_code_3 = 'COG';
UPDATE countries SET iso_numeric = '180' WHERE countries_iso_code_3 = 'COD';
UPDATE countries SET iso_numeric = '184' WHERE countries_iso_code_3 = 'COK';
UPDATE countries SET iso_numeric = '188' WHERE countries_iso_code_3 = 'CRI';
UPDATE countries SET iso_numeric = '384' WHERE countries_iso_code_3 = 'CIV';
UPDATE countries SET iso_numeric = '191' WHERE countries_iso_code_3 = 'HRV';
UPDATE countries SET iso_numeric = '192' WHERE countries_iso_code_3 = 'CUB';
UPDATE countries SET iso_numeric = '196' WHERE countries_iso_code_3 = 'CYP';
UPDATE countries SET iso_numeric = '203' WHERE countries_iso_code_3 = 'CZE';
UPDATE countries SET iso_numeric = '208' WHERE countries_iso_code_3 = 'DNK';
UPDATE countries SET iso_numeric = '262' WHERE countries_iso_code_3 = 'DJI';
UPDATE countries SET iso_numeric = '212' WHERE countries_iso_code_3 = 'DMA';
UPDATE countries SET iso_numeric = '214' WHERE countries_iso_code_3 = 'DOM';
UPDATE countries SET iso_numeric = '218' WHERE countries_iso_code_3 = 'ECU';
UPDATE countries SET iso_numeric = '818' WHERE countries_iso_code_3 = 'EGY';
UPDATE countries SET iso_numeric = '222' WHERE countries_iso_code_3 = 'SLV';
UPDATE countries SET iso_numeric = '226' WHERE countries_iso_code_3 = 'GNQ';
UPDATE countries SET iso_numeric = '232' WHERE countries_iso_code_3 = 'ERI';
UPDATE countries SET iso_numeric = '233' WHERE countries_iso_code_3 = 'EST';
UPDATE countries SET iso_numeric = '231' WHERE countries_iso_code_3 = 'ETH';
UPDATE countries SET iso_numeric = '238' WHERE countries_iso_code_3 = 'FLK';
UPDATE countries SET iso_numeric = '234' WHERE countries_iso_code_3 = 'FRO';
UPDATE countries SET iso_numeric = '242' WHERE countries_iso_code_3 = 'FJI';
UPDATE countries SET iso_numeric = '246' WHERE countries_iso_code_3 = 'FIN';
UPDATE countries SET iso_numeric = '250' WHERE countries_iso_code_3 = 'FRA';
UPDATE countries SET iso_numeric = '254' WHERE countries_iso_code_3 = 'GUF';
UPDATE countries SET iso_numeric = '258' WHERE countries_iso_code_3 = 'PYF';
UPDATE countries SET iso_numeric = '260' WHERE countries_iso_code_3 = 'ATF';
UPDATE countries SET iso_numeric = '266' WHERE countries_iso_code_3 = 'GAB';
UPDATE countries SET iso_numeric = '270' WHERE countries_iso_code_3 = 'GMB';
UPDATE countries SET iso_numeric = '268' WHERE countries_iso_code_3 = 'GEO';
UPDATE countries SET iso_numeric = '276' WHERE countries_iso_code_3 = 'DEU';
UPDATE countries SET iso_numeric = '288' WHERE countries_iso_code_3 = 'GHA';
UPDATE countries SET iso_numeric = '292' WHERE countries_iso_code_3 = 'GIB';
UPDATE countries SET iso_numeric = '300' WHERE countries_iso_code_3 = 'GRC';
UPDATE countries SET iso_numeric = '304' WHERE countries_iso_code_3 = 'GRL';
UPDATE countries SET iso_numeric = '308' WHERE countries_iso_code_3 = 'GRD';
UPDATE countries SET iso_numeric = '312' WHERE countries_iso_code_3 = 'GLP';
UPDATE countries SET iso_numeric = '316' WHERE countries_iso_code_3 = 'GUM';
UPDATE countries SET iso_numeric = '320' WHERE countries_iso_code_3 = 'GTM';
UPDATE countries SET iso_numeric = '831' WHERE countries_iso_code_3 = 'GGY';
UPDATE countries SET iso_numeric = '324' WHERE countries_iso_code_3 = 'GIN';
UPDATE countries SET iso_numeric = '624' WHERE countries_iso_code_3 = 'GNB';
UPDATE countries SET iso_numeric = '328' WHERE countries_iso_code_3 = 'GUY';
UPDATE countries SET iso_numeric = '332' WHERE countries_iso_code_3 = 'HTI';
UPDATE countries SET iso_numeric = '334' WHERE countries_iso_code_3 = 'HMD';
UPDATE countries SET iso_numeric = '336' WHERE countries_iso_code_3 = 'VAT';
UPDATE countries SET iso_numeric = '340' WHERE countries_iso_code_3 = 'HND';
UPDATE countries SET iso_numeric = '348' WHERE countries_iso_code_3 = 'HUN';
UPDATE countries SET iso_numeric = '352' WHERE countries_iso_code_3 = 'ISL';
UPDATE countries SET iso_numeric = '356' WHERE countries_iso_code_3 = 'IND';
UPDATE countries SET iso_numeric = '360' WHERE countries_iso_code_3 = 'IDN';
UPDATE countries SET iso_numeric = '364' WHERE countries_iso_code_3 = 'IRN';
UPDATE countries SET iso_numeric = '368' WHERE countries_iso_code_3 = 'IRQ';
UPDATE countries SET iso_numeric = '372' WHERE countries_iso_code_3 = 'IRL';
UPDATE countries SET iso_numeric = '833' WHERE countries_iso_code_3 = 'IMN';
UPDATE countries SET iso_numeric = '376' WHERE countries_iso_code_3 = 'ISR';
UPDATE countries SET iso_numeric = '380' WHERE countries_iso_code_3 = 'ITA';
UPDATE countries SET iso_numeric = '388' WHERE countries_iso_code_3 = 'JAM';
UPDATE countries SET iso_numeric = '392' WHERE countries_iso_code_3 = 'JPN';
UPDATE countries SET iso_numeric = '832' WHERE countries_iso_code_3 = 'JEY';
UPDATE countries SET iso_numeric = '400' WHERE countries_iso_code_3 = 'JOR';
UPDATE countries SET iso_numeric = '398' WHERE countries_iso_code_3 = 'KAZ';
UPDATE countries SET iso_numeric = '404' WHERE countries_iso_code_3 = 'KEN';
UPDATE countries SET iso_numeric = '296' WHERE countries_iso_code_3 = 'KIR';
UPDATE countries SET iso_numeric = '408' WHERE countries_iso_code_3 = 'PRK';
UPDATE countries SET iso_numeric = '410' WHERE countries_iso_code_3 = 'KOR';
UPDATE countries SET iso_numeric = '414' WHERE countries_iso_code_3 = 'KWT';
UPDATE countries SET iso_numeric = '417' WHERE countries_iso_code_3 = 'KGZ';
UPDATE countries SET iso_numeric = '418' WHERE countries_iso_code_3 = 'LAO';
UPDATE countries SET iso_numeric = '428' WHERE countries_iso_code_3 = 'LVA';
UPDATE countries SET iso_numeric = '422' WHERE countries_iso_code_3 = 'LBN';
UPDATE countries SET iso_numeric = '426' WHERE countries_iso_code_3 = 'LSO';
UPDATE countries SET iso_numeric = '430' WHERE countries_iso_code_3 = 'LBR';
UPDATE countries SET iso_numeric = '434' WHERE countries_iso_code_3 = 'LBY';
UPDATE countries SET iso_numeric = '438' WHERE countries_iso_code_3 = 'LIE';
UPDATE countries SET iso_numeric = '440' WHERE countries_iso_code_3 = 'LTU';
UPDATE countries SET iso_numeric = '442' WHERE countries_iso_code_3 = 'LUX';
UPDATE countries SET iso_numeric = '807' WHERE countries_iso_code_3 = 'MKD';
UPDATE countries SET iso_numeric = '450' WHERE countries_iso_code_3 = 'MDG';
UPDATE countries SET iso_numeric = '454' WHERE countries_iso_code_3 = 'MWI';
UPDATE countries SET iso_numeric = '458' WHERE countries_iso_code_3 = 'MYS';
UPDATE countries SET iso_numeric = '462' WHERE countries_iso_code_3 = 'MDV';
UPDATE countries SET iso_numeric = '466' WHERE countries_iso_code_3 = 'MLI';
UPDATE countries SET iso_numeric = '470' WHERE countries_iso_code_3 = 'MLT';
UPDATE countries SET iso_numeric = '584' WHERE countries_iso_code_3 = 'MHL';
UPDATE countries SET iso_numeric = '474' WHERE countries_iso_code_3 = 'MTQ';
UPDATE countries SET iso_numeric = '478' WHERE countries_iso_code_3 = 'MRT';
UPDATE countries SET iso_numeric = '480' WHERE countries_iso_code_3 = 'MUS';
UPDATE countries SET iso_numeric = '175' WHERE countries_iso_code_3 = 'MYT';
UPDATE countries SET iso_numeric = '484' WHERE countries_iso_code_3 = 'MEX';
UPDATE countries SET iso_numeric = '583' WHERE countries_iso_code_3 = 'FSM';
UPDATE countries SET iso_numeric = '498' WHERE countries_iso_code_3 = 'MDA';
UPDATE countries SET iso_numeric = '492' WHERE countries_iso_code_3 = 'MCO';
UPDATE countries SET iso_numeric = '496' WHERE countries_iso_code_3 = 'MNG';
UPDATE countries SET iso_numeric = '499' WHERE countries_iso_code_3 = 'MNE';
UPDATE countries SET iso_numeric = '500' WHERE countries_iso_code_3 = 'MSR';
UPDATE countries SET iso_numeric = '504' WHERE countries_iso_code_3 = 'MAR';
UPDATE countries SET iso_numeric = '508' WHERE countries_iso_code_3 = 'MOZ';
UPDATE countries SET iso_numeric = '104' WHERE countries_iso_code_3 = 'MMR';
UPDATE countries SET iso_numeric = '516' WHERE countries_iso_code_3 = 'NAM';
UPDATE countries SET iso_numeric = '520' WHERE countries_iso_code_3 = 'NRU';
UPDATE countries SET iso_numeric = '524' WHERE countries_iso_code_3 = 'NPL';
UPDATE countries SET iso_numeric = '528' WHERE countries_iso_code_3 = 'NLD';
UPDATE countries SET iso_numeric = '530' WHERE countries_iso_code_3 = 'ANT';
UPDATE countries SET iso_numeric = '540' WHERE countries_iso_code_3 = 'NCL';
UPDATE countries SET iso_numeric = '554' WHERE countries_iso_code_3 = 'NZL';
UPDATE countries SET iso_numeric = '558' WHERE countries_iso_code_3 = 'NIC';
UPDATE countries SET iso_numeric = '562' WHERE countries_iso_code_3 = 'NER';
UPDATE countries SET iso_numeric = '566' WHERE countries_iso_code_3 = 'NGA';
UPDATE countries SET iso_numeric = '570' WHERE countries_iso_code_3 = 'NIU';
UPDATE countries SET iso_numeric = '574' WHERE countries_iso_code_3 = 'NFK';
UPDATE countries SET iso_numeric = '580' WHERE countries_iso_code_3 = 'MNP';
UPDATE countries SET iso_numeric = '578' WHERE countries_iso_code_3 = 'NOR';
UPDATE countries SET iso_numeric = '512' WHERE countries_iso_code_3 = 'OMN';
UPDATE countries SET iso_numeric = '586' WHERE countries_iso_code_3 = 'PAK';
UPDATE countries SET iso_numeric = '585' WHERE countries_iso_code_3 = 'PLW';
UPDATE countries SET iso_numeric = '275' WHERE countries_iso_code_3 = 'PSE';
UPDATE countries SET iso_numeric = '591' WHERE countries_iso_code_3 = 'PAN';
UPDATE countries SET iso_numeric = '598' WHERE countries_iso_code_3 = 'PNG';
UPDATE countries SET iso_numeric = '600' WHERE countries_iso_code_3 = 'PRY';
UPDATE countries SET iso_numeric = '604' WHERE countries_iso_code_3 = 'PER';
UPDATE countries SET iso_numeric = '608' WHERE countries_iso_code_3 = 'PHL';
UPDATE countries SET iso_numeric = '612' WHERE countries_iso_code_3 = 'PCN';
UPDATE countries SET iso_numeric = '616' WHERE countries_iso_code_3 = 'POL';
UPDATE countries SET iso_numeric = '620' WHERE countries_iso_code_3 = 'PRT';
UPDATE countries SET iso_numeric = '630' WHERE countries_iso_code_3 = 'PRI';
UPDATE countries SET iso_numeric = '634' WHERE countries_iso_code_3 = 'QAT';
UPDATE countries SET iso_numeric = '638' WHERE countries_iso_code_3 = 'REU';
UPDATE countries SET iso_numeric = '642' WHERE countries_iso_code_3 = 'ROM';
UPDATE countries SET iso_numeric = '642' WHERE countries_iso_code_3 = 'ROU';
UPDATE countries SET iso_numeric = '643' WHERE countries_iso_code_3 = 'RUS';
UPDATE countries SET iso_numeric = '646' WHERE countries_iso_code_3 = 'RWA';
UPDATE countries SET iso_numeric = '652' WHERE countries_iso_code_3 = 'BLM';
UPDATE countries SET iso_numeric = '654' WHERE countries_iso_code_3 = 'SHN';
UPDATE countries SET iso_numeric = '659' WHERE countries_iso_code_3 = 'KNA';
UPDATE countries SET iso_numeric = '662' WHERE countries_iso_code_3 = 'LCA';
UPDATE countries SET iso_numeric = '663' WHERE countries_iso_code_3 = 'MAF';
UPDATE countries SET iso_numeric = '666' WHERE countries_iso_code_3 = 'SPM';
UPDATE countries SET iso_numeric = '670' WHERE countries_iso_code_3 = 'VCT';
UPDATE countries SET iso_numeric = '882' WHERE countries_iso_code_3 = 'WSM';
UPDATE countries SET iso_numeric = '674' WHERE countries_iso_code_3 = 'SMR';
UPDATE countries SET iso_numeric = '678' WHERE countries_iso_code_3 = 'STP';
UPDATE countries SET iso_numeric = '682' WHERE countries_iso_code_3 = 'SAU';
UPDATE countries SET iso_numeric = '686' WHERE countries_iso_code_3 = 'SEN';
UPDATE countries SET iso_numeric = '688' WHERE countries_iso_code_3 = 'SRB';
UPDATE countries SET iso_numeric = '690' WHERE countries_iso_code_3 = 'SYC';
UPDATE countries SET iso_numeric = '694' WHERE countries_iso_code_3 = 'SLE';
UPDATE countries SET iso_numeric = '702' WHERE countries_iso_code_3 = 'SGP';
UPDATE countries SET iso_numeric = '703' WHERE countries_iso_code_3 = 'SVK';
UPDATE countries SET iso_numeric = '705' WHERE countries_iso_code_3 = 'SVN';
UPDATE countries SET iso_numeric = '090' WHERE countries_iso_code_3 = 'SLB';
UPDATE countries SET iso_numeric = '706' WHERE countries_iso_code_3 = 'SOM';
UPDATE countries SET iso_numeric = '710' WHERE countries_iso_code_3 = 'ZAF';
UPDATE countries SET iso_numeric = '239' WHERE countries_iso_code_3 = 'SGS';
UPDATE countries SET iso_numeric = '728' WHERE countries_iso_code_3 = 'SSD';
UPDATE countries SET iso_numeric = '724' WHERE countries_iso_code_3 = 'ESP';
UPDATE countries SET iso_numeric = '144' WHERE countries_iso_code_3 = 'LKA';
UPDATE countries SET iso_numeric = '736' WHERE countries_iso_code_3 = 'SDN';
UPDATE countries SET iso_numeric = '740' WHERE countries_iso_code_3 = 'SUR';
UPDATE countries SET iso_numeric = '744' WHERE countries_iso_code_3 = 'SJM';
UPDATE countries SET iso_numeric = '748' WHERE countries_iso_code_3 = 'SWZ';
UPDATE countries SET iso_numeric = '752' WHERE countries_iso_code_3 = 'SWE';
UPDATE countries SET iso_numeric = '756' WHERE countries_iso_code_3 = 'CHE';
UPDATE countries SET iso_numeric = '760' WHERE countries_iso_code_3 = 'SYR';
UPDATE countries SET iso_numeric = '626' WHERE countries_iso_code_3 = 'TMP';
UPDATE countries SET iso_numeric = '158' WHERE countries_iso_code_3 = 'TWN';
UPDATE countries SET iso_numeric = '762' WHERE countries_iso_code_3 = 'TJK';
UPDATE countries SET iso_numeric = '834' WHERE countries_iso_code_3 = 'TZA';
UPDATE countries SET iso_numeric = '764' WHERE countries_iso_code_3 = 'THA';
UPDATE countries SET iso_numeric = '626' WHERE countries_iso_code_3 = 'TLS';
UPDATE countries SET iso_numeric = '768' WHERE countries_iso_code_3 = 'TGO';
UPDATE countries SET iso_numeric = '772' WHERE countries_iso_code_3 = 'TKL';
UPDATE countries SET iso_numeric = '776' WHERE countries_iso_code_3 = 'TON';
UPDATE countries SET iso_numeric = '780' WHERE countries_iso_code_3 = 'TTO';
UPDATE countries SET iso_numeric = '788' WHERE countries_iso_code_3 = 'TUN';
UPDATE countries SET iso_numeric = '792' WHERE countries_iso_code_3 = 'TUR';
UPDATE countries SET iso_numeric = '795' WHERE countries_iso_code_3 = 'TKM';
UPDATE countries SET iso_numeric = '796' WHERE countries_iso_code_3 = 'TCA';
UPDATE countries SET iso_numeric = '798' WHERE countries_iso_code_3 = 'TUV';
UPDATE countries SET iso_numeric = '800' WHERE countries_iso_code_3 = 'UGA';
UPDATE countries SET iso_numeric = '804' WHERE countries_iso_code_3 = 'UKR';
UPDATE countries SET iso_numeric = '784' WHERE countries_iso_code_3 = 'ARE';
UPDATE countries SET iso_numeric = '826' WHERE countries_iso_code_3 = 'GBR';
UPDATE countries SET iso_numeric = '840' WHERE countries_iso_code_3 = 'USA';
UPDATE countries SET iso_numeric = '581' WHERE countries_iso_code_3 = 'UMI';
UPDATE countries SET iso_numeric = '858' WHERE countries_iso_code_3 = 'URY';
UPDATE countries SET iso_numeric = '860' WHERE countries_iso_code_3 = 'UZB';
UPDATE countries SET iso_numeric = '548' WHERE countries_iso_code_3 = 'VUT';
UPDATE countries SET iso_numeric = '862' WHERE countries_iso_code_3 = 'VEN';
UPDATE countries SET iso_numeric = '704' WHERE countries_iso_code_3 = 'VNM';
UPDATE countries SET iso_numeric = '850' WHERE countries_iso_code_3 = 'VIR';
UPDATE countries SET iso_numeric = '876' WHERE countries_iso_code_3 = 'WLF';
UPDATE countries SET iso_numeric = '732' WHERE countries_iso_code_3 = 'ESH';
UPDATE countries SET iso_numeric = '887' WHERE countries_iso_code_3 = 'YEM';
UPDATE countries SET iso_numeric = '891' WHERE countries_iso_code_3 = 'YUG';
UPDATE countries SET iso_numeric = '180' WHERE countries_iso_code_3 = 'ZAR';
UPDATE countries SET iso_numeric = '894' WHERE countries_iso_code_3 = 'ZMB';
UPDATE countries SET iso_numeric = '716' WHERE countries_iso_code_3 = 'ZWE';


-----------------  v8.0.0.0

-- Panels No Longer Used:
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_subZones');
DELETE FROM kk_panel WHERE code = 'kk_panel_subZones';
DELETE FROM kk_role_to_panel WHERE panel_id = (SELECT panel_id FROM kk_panel WHERE code = 'kk_panel_geoZones');
DELETE FROM kk_panel WHERE code = 'kk_panel_geoZones';

-- Make the panel name more obvious
UPDATE kk_panel SET description = 'Tax Areas / Geo Zones' WHERE code = 'kk_panel_taxAreas';

-- Fix API definitions
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'getOrderRefund');
DELETE FROM kk_api_call WHERE name = 'getOrderRefund';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'importCustomer');
DELETE FROM kk_api_call WHERE name = 'importCustomer';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'insertGroup');
DELETE FROM kk_api_call WHERE name = 'insertGroup';
DELETE FROM kk_role_to_api_call WHERE api_call_id = (SELECT api_call_id FROM kk_api_call WHERE name = 'insertGroups');
DELETE FROM kk_api_call WHERE name = 'insertGroups';
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addPoints', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'cloneStore', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'custom', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteBooking', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deletePaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteSubscription', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'doesMallStoreExist', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'execute', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAddressFormats', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllAddressFormats', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllCountriesFull', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllGeoZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllLanguages', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllManufacturers', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllOrderStatuses', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllProductOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllTaxClassesFull', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getAllTaxRates', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getBookings', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCatalogById', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCatalogs', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCategory', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCategoryTree', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCountries', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCouponCode', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCurrencies', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCurrency', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomValidatorSet', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getDefaultCurrency', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getDefaultLanguage', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getEngConf', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFiles', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getGeoZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getHelpMsg', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getKonakartAdminPropsFilePath', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguageByCode', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getLanguages', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getManufacturer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getMsgs', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderRefunds', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getOrderStatusNames', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getPaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getPaymentSchedules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProdAttrDescsForTemplates', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductAvailabilityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductCountPerTemplate', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductOptionValuesPerOption', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductQuantityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getProductWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getRelatedProductsWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSearchRules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getStores', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSubZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSubscription', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSubscriptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTaxClasses', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTaxRates', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getTopLevelCategories', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getZones', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getZonesById', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertBooking', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCustomerGroups', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertPaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertSubscription', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertTagGroup', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertTagGroups', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'logMsg', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'login', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'logout', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'resetCustomerPasswordSpecifyingEmail', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'searchForProductsWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'sendTemplateEmailToCustomers', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'sendTemplateEmailToCustomers1WithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'sendTemplateEmailToCustomersWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setConfigurationValue', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setCreditCardDetailsOnOrder', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setCustomerPassword', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setEndpoint', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setProductAvailabilityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'setProductQuantityWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'testDB', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateBooking', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateCatalog', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updatePaymentSchedule', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateSubscription', '', current timestamp);

-- New Custom fields:
ALTER TABLE orders ADD custom6 varchar(16);
ALTER TABLE orders ADD custom7 varchar(16);
ALTER TABLE orders ADD custom8 varchar(16);
ALTER TABLE orders ADD custom9 varchar(16);
ALTER TABLE orders ADD custom10 varchar(16);

ALTER TABLE orders_products ADD custom6 varchar(16);
ALTER TABLE orders_products ADD custom7 varchar(16);
ALTER TABLE orders_products ADD custom8 varchar(16);
ALTER TABLE orders_products ADD custom9 varchar(16);
ALTER TABLE orders_products ADD custom10 varchar(16);

ALTER TABLE customers_basket ADD custom6 varchar(16);
ALTER TABLE customers_basket ADD custom7 varchar(16);
ALTER TABLE customers_basket ADD custom8 varchar(16);
ALTER TABLE customers_basket ADD custom9 varchar(16);
ALTER TABLE customers_basket ADD custom10 varchar(16);

-- New logo content type
INSERT INTO kk_content_type (id, content_type_id, date_added) VALUES (NEXTVAL FOR kk_content_type_seq, 13, current date);

INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 13, 1, 'Logo', 'Logo Image', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 13, 2, 'Logo', 'Logo Image', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 13, 3, 'Logo', 'Imagen del logotipo', current date);
INSERT INTO kk_content_type_desc (id, content_type_id, language_id, content_type_name, description, date_added) VALUES (NEXTVAL FOR kk_content_type_desc_seq, 13, 4, 'Logotipo', 'Imagem do logotipo', current date);

-- Logo Image
INSERT INTO kk_content (id, content_id, content_type_id, click_url, search_key, object_id, obj_type_id, enabled, updated_by, date_updated, date_added) VALUES (NEXTVAL FOR kk_content_seq, 31, 13, 'Welcome.action','LOGO', -1, -1, 1, 2, current date, current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 31, 1, 'logo.png', '', '', 'KonaKart Logo', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 31, 2, 'logo.png', '', '', 'KonaKart Logo', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 31, 3, 'logo.png', '', '', 'KonaKart Logo', current date);
INSERT INTO kk_content_desc (id, content_id, language_id, name1, name2, name3, title, date_added) VALUES (NEXTVAL FOR kk_content_desc_seq, 31, 4, 'logo.png', '', '', 'KonaKart Logo', current date);

-- Configuration variable to enable/disable Content Caching
DELETE FROM configuration WHERE configuration_key = 'CACHE_CONTENT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Cache Content','CACHE_CONTENT','true','Set to true to Cache KonaKart Content in memory.',11, 28, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Config variable to define the location of the exported Mailing Lists
DELETE FROM configuration where configuration_key = 'MAILLISTS_BASE_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added) VALUES (nextval for configuration_seq, 'Exported Mailing List Directory', 'MAILLISTS_BASE_DIRECTORY', 'C:/KonaKart/mailLists', 'Defines the root directory where the Mailing Lists are exported to', 12, 9, current timestamp);

-- New createMailingList API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'createMailingList','', current timestamp);

-- New View Mailing Lists panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_viewMailingLists','View Mailing Lists', current timestamp);

-- Add View Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_viewMailingLists';

-- New Create Mailing Lists panel
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_createMailingLists','Create Mailing Lists', current timestamp);

-- Add Create Mailing Lists Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, '1', '1', '1', current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_createMailingLists';

-- Email output location
DELETE FROM configuration WHERE configuration_key = 'EMAIL_OUTPUT_DIRECTORY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Email Output Directory', 'EMAIL_OUTPUT_DIRECTORY', 'C:/KonaKart/logs', 'The location where KonaKart will write email output files', 20, 2, current timestamp, 1);

-- Add extra field to products table to ignore quantity defined in array of productQuantity objects
ALTER TABLE products ADD ignore_prod_qty_stock INTEGER NOT NULL DEFAULT 0;

-- Suggested search list for each catalog id
DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_TERM_FOR_CATALOG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Add suggested search for catalog','SOLR_ADD_TERM_FOR_CATALOG','false','Adds a suggested search list for each catalog id since the catalog may contain only a subset of products',24, 140, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

DELETE FROM configuration WHERE configuration_key = 'SOLR_ADD_SPELLING_FOR_CATALOG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Add spelling suggestions for catalog','SOLR_ADD_SPELLING_FOR_CATALOG','false','Adds spelling suggestions for each catalog id since the catalog may contain only a subset of products',24, 170, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_PRICE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Catalogs used for product prices','SOLR_CATALOG_USED_FOR_PRICE','false','Set to true if catalogs are used to determine product prices',24, 180, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);

DELETE FROM configuration WHERE configuration_key = 'SOLR_CATALOG_USED_FOR_QTY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Catalogs used for product quantities','SOLR_CATALOG_USED_FOR_QTY','false','Set to true if catalogs are used to determine product quantities',24, 190, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 0);

-- Email Verified flag for Customers
ALTER TABLE customers ADD email_verified INTEGER NOT NULL DEFAULT 0;

-- New Admin App Panel for generating catalog prices
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_catalog_prices','Catalog Price Generation', current timestamp);

-- Add Catalog Prices Panel access to all roles that can access the 'kk_panel_catalogs' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_catalogs' and p2.code='kk_panel_catalog_prices';

INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addCatalogRules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'createCatalogPricesFromRules', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCatalogRules', '', current timestamp);

-- Custom Filters for Orders
ALTER TABLE orders ADD filter1 VARCHAR(32);
ALTER TABLE orders ADD filter2 VARCHAR(32);
ALTER TABLE orders ADD filterDecimal1 DECIMAL(15,4);

-- Table for Custom Filters
DROP TABLE kk_filter;
CREATE TABLE kk_filter (
  id INTEGER NOT NULL,
  user_id INTEGER NOT NULL,
  filter_table VARCHAR(64),
  filter_column VARCHAR(64),
  filter_constraint VARCHAR(256),
  custom1 VARCHAR(32),
  custom2 VARCHAR(32),
  date_added TIMESTAMP,
  date_updated TIMESTAMP,
  store_id VARCHAR(64),
  PRIMARY KEY(id)
);
DROP SEQUENCE kk_filter_SEQ;
CREATE SEQUENCE kk_filter_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

CREATE INDEX i_us_377ce83e817bc ON kk_filter (user_id);

-- New Admin App Panel for maintaining the filters
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_filters','Filters', current timestamp);

-- Add Filter Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_filters';

-- New Filter APIs
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFilters', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFiltersForCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteFilter', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteFiltersForCustomer', '', current timestamp);

-- As an exmaple of using Filters we set up an Admin User who can just see Orders in a certain state (for following up incomplete orders)
-- Default order follow-up user = "order.followup@konakart.com" password = "princess"
DELETE FROM customers WHERE customers_email_address = 'order.followup@konakart.com' and customers_telephone='019084';
DELETE FROM address_book WHERE entry_street_address='4 Way Street' and entry_postcode='PostCode4';
INSERT INTO address_book (address_book_id, customers_id, entry_gender, entry_company, entry_firstname, entry_lastname, entry_street_address, entry_suburb, entry_postcode, entry_city, entry_state, entry_country_id, entry_zone_id) VALUES (nextval for address_book_seq, -1, 'm', 'KonaKart Ltd.', 'Order', 'Followup', '4 Way Street', '', 'PostCode4', 'NeverNever', '', 223, 12);
INSERT INTO customers (customers_id, customers_gender, customers_firstname, customers_lastname,customers_dob, customers_email_address, customers_default_address_id, customers_telephone, customers_fax, customers_password, customers_newsletter, customers_type) VALUES (nextval for customers_seq, 'm', 'Order', 'Followup', to_date('1977-01-01 00:00:00', 'YYYY-MM-DD HH24:MI:SS'), 'order.followup@konakart.com', -1, '019084', '', 'f5147fc3f6eb46e234c01db939bdb581:08', '0', 1);
INSERT INTO customers_info SELECT customers_id , current timestamp, 0, current timestamp, current timestamp, 0, 'store1' FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';
UPDATE address_book SET customers_id = (SELECT customers_id FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084') WHERE customers_id=-1;
UPDATE customers SET customers_default_address_id = (SELECT address_book_id FROM address_book WHERE entry_street_address='4 Way Street' AND entry_postcode='PostCode4') WHERE customers_default_address_id=-1;

-- Grant the new follow-up order user the Order Maintenance role
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT nextval for kk_customers_to_role_seq, 3, customers_id, current timestamp FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';
INSERT INTO kk_customers_to_role (ctor_id, role_id, customers_id, date_added) SELECT nextval for kk_customers_to_role_seq, 4, customers_id, current timestamp FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';

-- Set a filter for the follow-up order user to view only orders in these states: "Processing" (id 2) or "Waiting For Payment" (id 4)
INSERT INTO kk_filter (id, user_id, filter_table, filter_column, filter_constraint, date_added, date_updated) SELECT nextval for kk_filter_seq, customers_id, 'orders', 'orders_status', 'in (2,4)', current date, current date FROM customers WHERE customers_email_address = 'order.followup@konakart.com' AND customers_telephone='019084';

-- New API call for deleting promotions
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deletePromotionWithOptions', '', current timestamp);

-- Set up Custom Panels F as an example
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_products' and p2.code='kk_panel_customF';

-- Update Paths for new default home directory
UPDATE configuration SET configuration_value = 'C:/KonaKart/webapps/birtviewer/reports/stores/store1/' WHERE configuration_key = 'REPORTS_DEFN_PATH';
UPDATE configuration SET configuration_value = 'C:/KonaKart/webapps/konakart/images' WHERE configuration_key = 'IMG_BASE_PATH';
UPDATE configuration SET configuration_value = 'C:/KonaKart/conf/konakart_mail.properties' WHERE configuration_key = 'KONAKART_MAIL_PROPERTIES_FILE';
UPDATE configuration SET configuration_value = 'C:/KonaKart/logs' WHERE configuration_key = 'KONAKART_LOG_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/database/DB2/konakart_new_store.sql' WHERE configuration_key = 'KK_NEW_STORE_SQL_FILENAME';
UPDATE configuration SET configuration_value = 'C:/KonaKart/database/DB2/konakart_user_new_store.sql' WHERE configuration_key = 'USER_NEW_STORE_SQL_FILENAME';
UPDATE configuration SET configuration_value = 'C:/KonaKart/' WHERE configuration_key = 'INSTALLATION_HOME';
UPDATE configuration SET configuration_value = 'C:/KonaKart/pdf/' WHERE configuration_key = 'PDF_BASE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/templates/' WHERE configuration_key = 'TEMPLATE_BASE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/orders' WHERE configuration_key = 'EXPORT_ORDERS_BASE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/batchlogs/' WHERE configuration_key = 'BATCH_LOG_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/batchlogs/' WHERE configuration_key = 'SITEMAP_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/importerlogs/' WHERE configuration_key = 'IMPORTER_LOG_FILE_DIRECTORY';
UPDATE configuration SET configuration_value = 'C:/KonaKart/data/' WHERE configuration_key = 'IMPORT_FILES_PATH';


-----------------  v8.1.0.0

-- Add codes to product options and product option values for image names
ALTER TABLE products_options ADD code varchar(32);
ALTER TABLE products_options_values ADD code varchar(32);

-- Add some color product option values
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,1,'Red','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,2,'Rote','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,3,'Rojo','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (13,4,'Vermelho','RED');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,1,'Orange','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,2,'Orange','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,3,'Naranja','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (14,4,'laranja','ORAN');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,1,'Yellow','YEL');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,2,'Gelb','YEL');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,3,'Amarillo','YEL');
INSERT INTO products_options_values (products_options_values_id, language_id, products_options_values_name, code) VALUES (15,4,'Amarelo','YEL');

INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ, 1, 13);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ, 1, 14);
INSERT INTO prod_opt_vals_to_prod_opt (prod_opt_vals_to_prod_opt_id, products_options_id, products_options_values_id) VALUES (nextval for prod_opt_vals_to_prod_opt_SEQ, 1, 15);

UPDATE products_options SET code = 'COL' WHERE products_options_id = '1';

-- Add color attributes to Brabantia Bin product
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, sort_order) VALUES (nextval for products_attributes_seq,44,1,13,0.00,'+',1);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, sort_order) VALUES (nextval for products_attributes_seq,44,1,14,0.00,'+',0);
INSERT INTO products_attributes (products_attributes_id, products_id, options_id, options_values_id, options_values_price, price_prefix, sort_order) VALUES (nextval for products_attributes_seq,44,1,15,0.00,'+',2);

-- Add role for custom panel G
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_customers' and p2.code='kk_panel_customG';

-- lock table
DROP TABLE kk_lock;
CREATE TABLE kk_lock (
  lock_name VARCHAR(32) NOT NULL,
  lock_timestamp TIMESTAMP NOT NULL,
  PRIMARY KEY(lock_name)
);

-- Update Country data

INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'??land Islands','AX','ALA',1, '248');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Guernsey','GG','GGY',1, '831');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Montenegro','ME','MNE',1, '499');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Palestine','PS','PSE',1, '275');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Saint Barth??lemy','BL','BLM',1, '652');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Saint Helena, Ascension and Tristan da Cunha','SH','SHN',1, '654');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Saint Martin (French part)','MF','MAF',1, '663');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Saint Pierre and Miquelon','PM','SPM',1, '666');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Sint Maarten (Dutch part)','SX','SXM',1, '534');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'South Sudan','SS','SSD',1, '728');
INSERT INTO countries (countries_id, countries_name, countries_iso_code_2, countries_iso_code_3, address_format_id, iso_numeric) VALUES (nextval for countries_seq,'Timor-Leste','TL','TLS',1, '626');

DELETE FROM countries WHERE countries_name = 'East Timor';
DELETE FROM countries WHERE countries_name = 'Netherlands Antilles';
DELETE FROM countries WHERE countries_name = 'St. Helena';
DELETE FROM countries WHERE countries_name = 'St. Pierre and Miquelon';
DELETE FROM countries WHERE countries_name = 'Yugoslavia';

UPDATE countries set msgCatKey = CONCAT('CTRY.',countries_iso_code_3);

-- Reserved stock table
DROP TABLE kk_reserved_stock;
CREATE TABLE kk_reserved_stock (
  kk_reserved_stock_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  customers_id INTEGER DEFAULT 0 NOT NULL,
  catalog_id VARCHAR(32),
  products_id INTEGER NOT NULL,
  products_options VARCHAR(128) NOT NULL,
  quantity INTEGER DEFAULT 0 NOT NULL,
  reserve_start_time TIMESTAMP NOT NULL,
  reserve_end_time TIMESTAMP NOT NULL,
  PRIMARY KEY(kk_reserved_stock_id)
);
DROP SEQUENCE kk_reserved_stock_SEQ;
CREATE SEQUENCE kk_reserved_stock_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Stock reservation attributes for basket and order product
ALTER TABLE customers_basket ADD reservation_id int NOT NULL DEFAULT -1;
ALTER TABLE orders_products ADD reservation_id int NOT NULL DEFAULT -1;
ALTER TABLE orders_products ADD qty_reserved_for_id int NOT NULL DEFAULT 0;

-- Enables / Disables stock reservation
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_ENABLE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Enable stock reservation','STOCK_RESERVATION_ENABLE','false','Set to true if you want to reserve stock during checkout',9, 40, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Defines global stock reservation time
DELETE FROM configuration WHERE configuration_key = 'STOCK_RESERVATION_TIME_SECS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Stock Reservation time in secs','STOCK_RESERVATION_TIME_SECS','0','Number of seconds stock will be reserved for',9, 45, 'integer(0,null)', current timestamp, 1);

-- Add custom privileges for the Products panel - default to allow access to Remove From Cat button
UPDATE kk_role_to_panel SET custom3=0, custom3_desc='If set remove from cat button not shown' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_products');

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addRelatedProductsWithOptions', '', current timestamp);

-- Modify config variable text
UPDATE configuration SET configuration_title = 'Show Stock Levels', configuration_description='Displays the product stock levels in the storefront application. Set to false if products are virtual.' WHERE configuration_key = 'STOCK_CHECK';
UPDATE configuration SET configuration_title = 'Do Not Automatically Disable Product', configuration_description='If false, a product is automatically disabled when it goes out of stock.' WHERE configuration_key = 'STOCK_ALLOW_CHECKOUT';
UPDATE configuration SET sort_order = '3' WHERE configuration_key = 'STOCK_ENABLE_PRODUCT';

-- Used in storefront to allow checkout when stock isn't available
DELETE FROM configuration WHERE configuration_key = 'STORE_FRONT_STOCK_ALLOW_CHECKOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Allow Checkout When Stock Not Available','STORE_FRONT_STOCK_ALLOW_CHECKOUT','true','When true, the storefront allows checkout even when stock is not available',9, 2, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- New Order Total Custom fields:
ALTER TABLE orders_total ADD custom4 varchar(128);
ALTER TABLE orders_total ADD custom5 varchar(128);

-- Change currency value to decimal
ALTER TABLE currencies ALTER COLUMN value SET DATA TYPE DECIMAL(15,6);
-- For DB2 Only - Required after modifying the type
call SYSPROC.ADMIN_CMD ('REORG TABLE currencies');


-----------------  v8.3.0.0

-- Add parent id to customers
ALTER TABLE customers ADD parent_id int DEFAULT 0 NOT NULL;

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addChildrenToCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerForEmailWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getCustomerForIdWithOptions', '', current timestamp);

--B2B Customer tag examples
DELETE FROM kk_customer_tag WHERE name ='B2B_CAN_CHANGE_ADDRESS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_CAN_CHANGE_ADDRESS', 'Customer can modify / add the destination addresses of an order', 'true|false', 5, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_CAN_APPROVE_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_CAN_APPROVE_ORDERS', 'Customer can approve orders of child customers', 'true|false', 5, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_VIEW_PARENT_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_VIEW_PARENT_ORDERS', 'Customer can view orders of parent customer', 'true|false', 5, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_VIEW_CHILD_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_VIEW_CHILD_ORDERS', 'Customer can view orders of child customers', 'true|false', 5, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_VIEW_SIBLING_ORDERS';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_VIEW_SIBLING_ORDERS', 'Customer can view orders of sibling customers', 'true|false', 5, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_ORDERS_NEED_APPROVAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_ORDERS_NEED_APPROVAL', 'Order needs to be approved by a parent customer', 'true|false', 5, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_ORDER_LIMIT';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_ORDER_LIMIT', 'Maximum order value that can be submitted by this customer', '', 3, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_CATALOG_KEY';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_CATALOG_KEY', 'Catalog Key used for this customer', '', 0, 1, current timestamp);

-- New Order Total fields
ALTER TABLE orders_total ADD promotion_id int DEFAULT 0 NOT NULL;
ALTER TABLE orders_total ADD discount_amount decimal(15,4);
ALTER TABLE orders_total ADD discount_percent decimal(15,4);

-- New order state - Waiting for Approval
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,11,(SELECT languages_id FROM languages WHERE code = 'en'),'Waiting for Approval');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,11,(SELECT languages_id FROM languages WHERE code = 'de'),'Warten auf Best??tigung');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,11,(SELECT languages_id FROM languages WHERE code = 'es'),'A la espera de la aprobaci??n');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,11,(SELECT languages_id FROM languages WHERE code = 'pt'),'Esperando aprova????o');

-- New order state - Approved
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,12,(SELECT languages_id FROM languages WHERE code = 'en'),'Approved');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,12,(SELECT languages_id FROM languages WHERE code = 'de'),'Genehmigt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,12,(SELECT languages_id FROM languages WHERE code = 'es'),'Aprobado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,12,(SELECT languages_id FROM languages WHERE code = 'pt'),'Aprovado');

-- New order state - Approval Declined
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,13,(SELECT languages_id FROM languages WHERE code = 'en'),'Approval Declined');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,13,(SELECT languages_id FROM languages WHERE code = 'de'),'Genehmigt Abgelehnt');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,13,(SELECT languages_id FROM languages WHERE code = 'es'),'Se rechaza la aprobaci??n');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,13,(SELECT languages_id FROM languages WHERE code = 'pt'),'Aprova????o Recusado');

-- Name Format
ALTER TABLE address_format ADD name_format varchar(255);
UPDATE address_format SET name_format = '$firstname $lastname';

-- For Setting the default customer name format template
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Name format template', 'NAME_FORMAT_TEMPLATE', '$firstname $lastname', 'The default template used for formatting a customer name', 5, 20, current timestamp, 1);

------------------------------------------------------------------
-- ERP XML Interface

INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'User Defined', 'User Defined Configuration', 31, 1, null);
INSERT INTO configuration_group VALUES (nextval for configuration_group_seq, 'ERP Integration', 'ERP Integration Configuration', 32, 1, null);

-- Configuration variable for log directories
DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_BASE_PATH_OK';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Msg Log Directory Good', 'ERP_INT_LOG_BASE_PATH_OK', CONCAT(configuration_value, '/mq_logs/success'), 'Defines the directory where the log file is written for messages that are processed correctly', 32, 12, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_INTEGRATION_ENABLED';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'ERP Integration Enabled?', 'ERP_INT_INTEGRATION_ENABLED', 'false', 'Set to true to enable ERP Integration', 32, 5, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_BASE_PATH_KO';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api, store_id) SELECT nextval for configuration_seq, 'Msg Log Directory Failed', 'ERP_INT_LOG_BASE_PATH_KO', CONCAT(configuration_value, '/mq_logs/failure'), 'Defines the directory where the log file is written for messages that cannot be processed', 32, 20, current timestamp, 1, store_id FROM configuration WHERE configuration_key = 'INSTALLATION_HOME';

-- Configuration variables for sending log if a message fails
DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_KO_EMAIL_ADDR';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (nextval for configuration_seq, 'Email Address for Failed messages', 'ERP_INT_LOG_KO_EMAIL_ADDR', 'admin@konakart.com', 'Defines the email address where logs are sent when a message fails', 32, 30, current timestamp, 1);

DELETE FROM configuration where configuration_key = 'ERP_INT_LOG_KO_EMAIL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (nextval for configuration_seq, 'Template for failed msg email', 'ERP_INT_LOG_KO_EMAIL_TEMPLATE', 'ERPIntegrationErrorNotification_en.vm', 'The velocity email template for failed messages. Template name includes country code.', 32, 31, current timestamp, 1);

-- Configuration variable for ERP Invoice directory
DELETE FROM configuration where configuration_key = 'ERP_INT_INVOICE_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (nextval for configuration_seq, 'ERP Invoice Path', 'ERP_INT_INVOICE_PATH', '', 'Defines the directory where the ERP invoices can be found. Ignored if the path is included in the message', 32, 40, current timestamp, 1);

-- Configuration variable for ERP Invoice Email Velocity template
DELETE FROM configuration where configuration_key = 'ERP_INT_INVOICE_EMAIL_TEMPLATE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,  date_added, return_by_api) VALUES (nextval for configuration_seq, 'ERP Invoice template', 'ERP_INT_INVOICE_EMAIL_TEMPLATE', 'ERPIntegrationOrderInvoice_en.vm', 'Defines the velocity template for the email sent to the customer. Ignored if the template is included in the message. Country code is determined from the locale of the order if left out.', 32, 50, current timestamp, 1);

-- New Admin App Panel for ERP Integration Configuration
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_erpConfig','ERP Integration Configuration', current timestamp);

-- Add ERP Integration Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_erpConfig';

-- Password expiry
ALTER TABLE customers ADD password_change INTEGER DEFAULT 0 NOT NULL;
ALTER TABLE customers ADD password_expiry TIMESTAMP;

-- Define how long a new temporary password is valid when sent out to customer who has forgotten his password
DELETE FROM configuration where configuration_key = 'TEMP_PASSWORD_VALID_TIME_MINS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Valid time (mins) for temp password', 'TEMP_PASSWORD_VALID_TIME_MINS', '30', 'Defines the number of minutes a temporary password sent out in an email is valid for', 18, 20, 'integer(null,null)', current timestamp);

-- Add attributes to promotions
ALTER TABLE promotion ADD total_max_use int NOT NULL DEFAULT -1;
ALTER TABLE promotion ADD times_used int NOT NULL DEFAULT 0;

-- Defines order states to include for displaying customer orders
DELETE FROM configuration WHERE configuration_key = 'ORDER_DISPLAY_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Status Ids of orders to display','ORDER_DISPLAY_STATUS_IDS','','Comma separated list of order status ids that will be displayed to customers. All orders displayed if empty.',9, 50, current timestamp, 1);

-- Add some new indexes for improved read performance
CREATE INDEX i_pr_1ae78b3d943fb ON specials (products_id);
CREATE INDEX i_co_c9f557d8573ac ON configuration (configuration_key);
CREATE INDEX i_cu_3cde8a250bb43 ON kk_customers_to_tag (customers_id);

-- New order attributes
ALTER TABLE orders ADD admin_discount decimal(15,4);
ALTER TABLE orders ADD archive_id VARCHAR(128);

-- New order state - Archived
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,14,(SELECT languages_id FROM languages WHERE code = 'en'),'Archived');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,14,(SELECT languages_id FROM languages WHERE code = 'de'),'Archivierte');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,14,(SELECT languages_id FROM languages WHERE code = 'es'),'Archivado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,14,(SELECT languages_id FROM languages WHERE code = 'pt'),'Arquivado');

-- Defines order states to exclude for displaying customer orders
DELETE FROM configuration WHERE configuration_key = 'ORDER_DISPLAY_EXCLUDE_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Status Ids of orders to not display','ORDER_DISPLAY_EXCLUDE_STATUS_IDS','14','Comma separated list of order status ids that will not be displayed to customers. All orders displayed if empty.',9, 55, current timestamp, 1);

-- Used in storefront to allow an administrator to edit an order
DELETE FROM configuration WHERE configuration_key = 'ALLOW_EDIT_ORDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Allow admin to edit customer order','ALLOW_EDIT_ORDER','false','When true, an administrator logging in as a customer can edit a customer order',1, 45, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Used in storefront to allow an administrator to introduce a discount
DELETE FROM configuration WHERE configuration_key = 'ALLOW_ADMIN_ORDER_DISCOUNT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Allow admin to discount customer order','ALLOW_ADMIN_ORDER_DISCOUNT','false','When true, an administrator logging in as a customer can add a discount to a customer order',1, 50, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Allow NULLs in tag_value
ALTER TABLE kk_expression_variable ALTER COLUMN tag_value DROP NOT NULL;

-- For DB2 Only - Required after setting field to nullable
call SYSPROC.ADMIN_CMD ('REORG TABLE kk_expression_variable');


-----------------  v8.5.0.0

-- Used in storefront to decide whether to update the product viewed count every time a product is viewed
DELETE FROM configuration WHERE configuration_key = 'UPDATE_PRODUCT_VIEWED_COUNT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Update product viewed count','UPDATE_PRODUCT_VIEWED_COUNT','false','When true, the product viewed count is incremented every time a product is viewed',1, 55, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Add reservation_id to kk_reserved_stock
ALTER TABLE kk_reserved_stock ADD reservation_id int DEFAULT 0 NOT NULL;
CREATE INDEX i_re_9f13ec9583ca4 ON kk_reserved_stock (reservation_id);

-- For specifying whether or not customer tags can be set using KKEngIf API calls
ALTER TABLE kk_customer_tag ADD set_by_api INTEGER NOT NULL DEFAULT 0;
-- Do not allow the B2B_ tags to be set
UPDATE kk_customer_tag set set_by_api = 1 WHERE NOT name LIKE 'B2B_%';

-- Addition of custom fields
ALTER TABLE products_quantity ADD custom1 varchar(128);
ALTER TABLE products_quantity ADD custom2 varchar(128);

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteProdAttrDescWithOptions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteProducts', '', current timestamp);

--Promotion tester customer tag
DELETE FROM kk_customer_tag WHERE name ='PROMOTION_TESTER';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'PROMOTION_TESTER', 'Promotion Tester', 'true|false', 5, 1, current timestamp);

--Promotion tester expression
DELETE FROM kk_expression WHERE name ='PromotionTester';
INSERT INTO kk_expression (kk_expression_id, name, description, num_variables, date_added) VALUES (nextval for kk_expression_seq,'PromotionTester', 'Determines whether user is a promotion tester',1,current date);

-- Promotion tester expression variable
DELETE FROM kk_expression_variable WHERE kk_customer_tag_id = (select kk_customer_tag_id from kk_customer_tag where name ='PROMOTION_TESTER');
INSERT INTO kk_expression_variable (kk_expression_variable_id, kk_customer_tag_id, kk_expression_id, tag_type, tag_value, date_added) VALUES (nextval for kk_expression_variable_seq,(select kk_customer_tag_id from kk_customer_tag where name ='PROMOTION_TESTER'),(select kk_expression_id from kk_expression where name ='PromotionTester'),5,'true',current date);

-- For Setting the default expression for promotion testers
DELETE FROM configuration WHERE configuration_key = 'PROMOTION_TESTER_EXPRESSION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Promotion Tester Expression', 'PROMOTION_TESTER_EXPRESSION', 'PromotionTester', 'The expression used for determining promotion testers', 5, 25, current timestamp, 1);

DROP TABLE kk_credit_card;
CREATE TABLE kk_credit_card (
  kk_credit_card_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  customers_id INTEGER NOT NULL,
  address_id int,
  ccType VARCHAR(32),
  ccOwner VARCHAR(32),
  ccNumber VARCHAR(32),
  ccToken VARCHAR(32),
  ccExpires VARCHAR(16),
  ccExpiryMonth int,
  ccExpiryYear int,
  ccImage VARCHAR(32),
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  PRIMARY KEY(kk_credit_card_id)
);
DROP SEQUENCE kk_credit_card_SEQ;
CREATE SEQUENCE kk_credit_card_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- For Setting the tz database time zone for the store
DELETE FROM configuration WHERE configuration_key = 'TZ_DB_TIME_ZONE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'TZ DB Time Zone', 'TZ_DB_TIME_ZONE', '', 'The tz database time zone for the store. e.g. US/Pacific', 1, 7, current timestamp, 1);

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getStoreTime', '', current timestamp);

-- B2B Customer tags for monthly order limit
DELETE FROM kk_customer_tag WHERE name ='B2B_AGGREGATE_ORDER_LIMIT';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_AGGREGATE_ORDER_LIMIT', 'Maximum total order value that can be submitted in a period of time', '', 3, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='B2B_AGGREGATE_ORDER_TOTAL';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'B2B_AGGREGATE_ORDER_TOTAL', 'The current order value total for a period of time', '', 3, 1, current timestamp);

-- Admin Caches
DELETE FROM configuration WHERE configuration_key = 'ADMIN_CONFIG_CACHE_CHECK_SECS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Admin caches refresh check interval', 'ADMIN_CONFIG_CACHE_CHECK_SECS', '30', 'Interval in seconds for checking to see whether to refresh the KonaKartAdmin caches', 11, 10, current timestamp, 1);

DELETE FROM configuration WHERE configuration_key = 'ADMIN_CONFIG_CACHE_CHECK_FLAG';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Admin caches refresh flag','ADMIN_CONFIG_CACHE_CHECK_FLAG','false','Boolean to determine whether to refresh the admin config caches',100,1, current timestamp, 1);

-----------------  v8.7.0.0

-- New API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateCustomerWithOptions', '', current timestamp);

-- Addition of username field
ALTER TABLE customers ADD customers_username varchar(64);

-- Add custom attributes to orders_returns
ALTER TABLE orders_returns ADD custom1 varchar(128);
ALTER TABLE orders_returns ADD custom2 varchar(128);
ALTER TABLE orders_returns ADD custom3 varchar(128);
ALTER TABLE orders_returns ADD custom1Dec decimal(15,4);
ALTER TABLE orders_returns ADD custom2Dec decimal(15,4);

-- Add new attributes to orders_products
ALTER TABLE orders_products ADD refund_value decimal(15,4);
ALTER TABLE orders_products ADD refund_points int NOT NULL DEFAULT -1;

-- Add new attributes to returns_to_ord_prods
ALTER TABLE returns_to_ord_prods ADD refund_value decimal(15,4);
ALTER TABLE returns_to_ord_prods ADD refund_points int NOT NULL DEFAULT -1;
ALTER TABLE returns_to_ord_prods ADD custom1 varchar(128);
ALTER TABLE returns_to_ord_prods ADD custom2 varchar(128);
ALTER TABLE returns_to_ord_prods ADD custom3 varchar(128);

-- Table for Custom Configs - this is only for an example of using the CustomStoreService with database calls
DROP TABLE custom_config;
CREATE TABLE custom_config (
  custom_config_id INTEGER NOT NULL,
  custom_key VARCHAR(16),
  custom_value VARCHAR(256),
  date_added TIMESTAMP,
  PRIMARY KEY(custom_config_id)
);
DROP SEQUENCE custom_config_SEQ;
CREATE SEQUENCE custom_config_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- ERP Integration Configuration
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_CUSTOMER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Export Customer to ERP', 'ERP_EXPORT_CUSTOMER', 'true', 'When set to true KonaKart will export customer information (when a customer registers) to ERP', 32, 50, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);
DELETE FROM configuration where configuration_key = 'ERP_MATCH_CUSTOMER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Send Match Customer message to ERP', 'ERP_MATCH_CUSTOMER', 'true', 'When set to true KonaKart will send a Match Customer message to ERP', 32, 60, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);
DELETE FROM configuration where configuration_key = 'ERP_EXPORT_ORDER';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Export Order to ERP', 'ERP_EXPORT_ORDER', 'true', 'When set to true KonaKart will export orders to ERP', 32, 70, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Example config parameter for the User Defined Configuration Panel - MultiSelect
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_2';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Example Parameter 2','USER_DEFINED_EXAMPLE_2','1,3,5','Example of a MultiSelect parameter',31, 15, 'multiselect(0=date.day.short.Sun,1=date.day.short.Mon,2=date.day.short.Tue,3=date.day.short.Wed,4=date.day.short.Thu,5=date.day.short.Fri,6=date.day.short.Sat)', current timestamp, 1);

-- Add some indexes
CREATE INDEX i_or_bdbf4e4395486 ON orders_status_history (orders_id);
CREATE INDEX i_or_b83369b4358d1 ON orders_products (orders_id);
CREATE INDEX i_cu_ad910311c2a1a ON customers_basket (customers_id);

-- Custom Attribute Example using the MultiSelect set_function
INSERT INTO kk_cust_attr (kk_cust_attr_id, name, msg_cat_key, attr_type, template, validation, set_function, date_added) VALUES (nextval for kk_cust_attr_SEQ, 'days-of-the-week', null, 0, null, null, 'multiselect(0=date.day.short.Sun,1=date.day.short.Mon,2=date.day.short.Tue,3=date.day.short.Wed,4=date.day.short.Thu,5=date.day.short.Fri,6=date.day.short.Sat)', current timestamp);

INSERT INTO kk_cust_attr_tmpl (kk_cust_attr_tmpl_id, name, description, date_added, store_id) VALUES (nextval for kk_cust_attr_tmpl_SEQ, 'Example Template', 'Just an example which can be deleted at any time', current timestamp, 'store1');

INSERT INTO kk_tmpl_to_cust_attr (kk_cust_attr_tmpl_id, kk_cust_attr_id, store_id) SELECT kcat.kk_cust_attr_tmpl_id, kca.kk_cust_attr_id, 'store1' FROM kk_cust_attr_tmpl kcat, kk_cust_attr kca WHERE kca.name = 'days-of-the-week' AND kcat.name = 'Example Template';

-- Add additional custom attributes to orders
ALTER TABLE orders ADD custom11 varchar(16);
ALTER TABLE orders ADD custom12 varchar(16);
ALTER TABLE orders ADD custom13 varchar(16);
ALTER TABLE orders ADD custom14 varchar(16);
ALTER TABLE orders ADD custom15 varchar(16);
ALTER TABLE orders ADD custom16 varchar(16);


-----------------  v8.8.0.0

-- Vendor table
DROP TABLE kk_vendor;
CREATE TABLE kk_vendor (
  vendor_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  vendor_name VARCHAR(128) NOT NULL,
  vendor_desc VARCHAR(256),
  company_id VARCHAR(64),
  company_tax_id VARCHAR(64),
  rating decimal(15,4),
  number_reviews INTEGER DEFAULT 0 NOT NULL,
  default_address_id INTEGER DEFAULT 0 NOT NULL,
  custom1 VARCHAR(128),
  custom2 VARCHAR(128),
  custom3 VARCHAR(128),
  custom4 VARCHAR(128),
  custom5 VARCHAR(128),
  date_added TIMESTAMP,
  last_updated TIMESTAMP,
  PRIMARY KEY(vendor_id)
);
DROP SEQUENCE kk_vendor_SEQ;
CREATE SEQUENCE kk_vendor_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Vendor foreign keys
ALTER TABLE address_book ADD vendor_id int DEFAULT 0 NOT NULL;
ALTER TABLE reviews ADD vendor_id int DEFAULT 0 NOT NULL;
ALTER TABLE kk_store ADD vendor_id int DEFAULT 0 NOT NULL;

-- New APIs for Vendors
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteVendor', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteVendorReview', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getReviewsPerVendor', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getVendorForId', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getVendorReview', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getVendorReviews', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getVendors', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertVendor', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'updateVendor', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'addVendorToStore', '', current timestamp);

-- New Admin App Panels for Vendors
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_vendors','Vendor Maintenance', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_vendorForStore','Vendor For Store', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_vendorForReview','Vendor For Review', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_editVendor','Edit a Vendor', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_insertVendor','Insert a Vendor', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_storesForVendor','Stores for Vendor', current timestamp);

-- Add Vendor Management Panels to super admin role like kk_panel_stores
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_vendors';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_vendorForStore';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_vendorForReview';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_editVendor';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_insertVendor';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_stores' and p2.code='kk_panel_storesForVendor';

-- Address Panel for vendors
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_vendor_address', 'Vendor Addresses', current timestamp);

-- Add Address Panel access to all roles that can access the Vendor panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_vendors' and p2.code='kk_panel_vendor_address';

-- Reviews Panels
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_vendor_reviews', 'Vendor Reviews For Vendor', current timestamp);
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_all_vendor_reviews', 'Vendor Reviews', current timestamp);

-- Add Reviews Panels access to all roles that can access the Vendor panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_vendors' and p2.code='kk_panel_vendor_reviews';
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_vendors' and p2.code='kk_panel_all_vendor_reviews';

-- Configuration variable to enable links to store details page in multi-vendor mode
DELETE FROM configuration WHERE configuration_key = 'MULTI_VENDOR_STORE_LINKS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Links to Store page in multi-vendor mode','MULTI_VENDOR_STORE_LINKS','true','Set to true to enable links to the store information page when in multi-vendor mode.',1, 36, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Configuration variable to set SMTP server port
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'SMTP Port', 'SMTP_PORT', '25', 'SMTP Server Port', 12, 2, current timestamp, 0);

-- Control ERP Integration Customer notifications
DELETE FROM configuration WHERE configuration_key = 'ERP_CUSTOMER_NOTIFICATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Customer Update Notifications','ERP_CUSTOMER_NOTIFICATION','','Notifications when a customer registers or modifies his details or is deleted',32, 80, 'multiselect(1=label.insert,2=label.edit,3=label.delete)', current timestamp, 1);

-- Control ERP Integration Order notifications
DELETE FROM configuration WHERE configuration_key = 'ERP_ORDER_NOTIFICATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Order Update Notifications','ERP_ORDER_NOTIFICATION','','Notifications when an order is inserted or the state is changed',32, 90, 'multiselect(1=label.insert,2=label.edit)', current timestamp, 1);

-- Control ERP Integration Product notifications
DELETE FROM configuration WHERE configuration_key = 'ERP_PRODUCT_NOTIFICATION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Product Update Notifications','ERP_PRODUCT_NOTIFICATION','','Notifications when a product is inserted, updated or deleted',32, 100, 'multiselect(1=label.insert,2=label.edit,3=label.delete)', current timestamp, 1);

-- System Admin Email Address
DELETE FROM configuration WHERE configuration_key = 'SYSADMIN_EMAIL_ADDRESS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Sys Admin Email','SYSADMIN_EMAIL_ADDRESS','admin@konakart.com','System Admin Email Address', 1, 5, current timestamp, 0);

-- Notification of Storefront Exceptions
DELETE FROM configuration WHERE configuration_key = 'REPORT_STOREFRONT_EXCEPTIONS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Storefront Exceptions','REPORT_STOREFRONT_EXCEPTIONS','true','Report Storefront Exceptions', 12, 20, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Notification of KKEng Exceptions
DELETE FROM configuration WHERE configuration_key = 'REPORT_KKENG_EXCEPTIONS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'KKEng Exceptions','REPORT_KKENG_EXCEPTIONS','true','Report KKEng Exceptions', 12, 25, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Notification of KKAdmin Exceptions
DELETE FROM configuration WHERE configuration_key = 'REPORT_KKADMIN_EXCEPTIONS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'KKAdmin Exceptions','REPORT_KKADMIN_EXCEPTIONS','true','Report KKAdmin Exceptions', 12, 30, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Extend the size of the sesskey column in the sessions table
-- For various reasons, mainly DB2/MS-SQL limitations, we drop the sessions table and recreate it
DROP TABLE sessions;
CREATE TABLE sessions (
  sesskey VARCHAR(64) NOT NULL,
  expiry INTEGER NOT NULL,
  customer_id INTEGER ,
  value VARCHAR(256) ,
  store_id VARCHAR(64) ,
  custom1 VARCHAR(128) ,
  custom2 VARCHAR(128) ,
  custom3 VARCHAR(128) ,
  custom4 VARCHAR(128) ,
  custom5 VARCHAR(128) ,
  PRIMARY KEY(sesskey)
);
CREATE INDEX i_st_1ae788109da01 ON sessions (store_id);

-- Extend the size of the sesskey column in the kk_sso table
ALTER TABLE kk_sso ALTER COLUMN sesskey SET DATA TYPE VARCHAR(64);

-- New copyFiles, renameFile and renameFiles API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'copyFiles', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'renameFile', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'renameFiles', '', current timestamp);

-- Create Role for B2B Customer Admin
INSERT INTO kk_role (role_id, name, description, date_added) VALUES (nextval for kk_role_seq, 'B2B Customer Admin','Administrator of Company B2B Customers', current timestamp);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getAddresses'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getCustomerForIdWithOptions'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'registerCustomer'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getCustomerTagsForCustomer'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'insertCustomerTagForCustomer'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'deleteCustomerTagForCustomer'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'updateCustomer'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'getAddressById'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'deleteAddress'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'deleteCustomer'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'updateAddress'), current date);
INSERT INTO kk_role_to_api_call (role_id, api_call_id, date_added) values ((SELECT role_id FROM kk_role WHERE name = 'B2B Customer Admin'),(SELECT api_call_id FROM kk_api_call WHERE name = 'insertAddress'), current date);

-- Customer tag for saving the Facebook login Id
DELETE FROM kk_customer_tag WHERE name ='FACEBOOK_LOGIN_ID';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'FACEBOOK_LOGIN_ID', 'The Facebook id for a customer logging in using Facebook', '', 0, 1, current timestamp);

-- New insertCatalogPrices API call
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertCatalogPrices', '', current timestamp);

-- Additional SOLR Configuration Variables
DELETE FROM configuration WHERE configuration_key = 'SOLR_NO_COMMITS_IN_CODE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Do not commit in code','SOLR_NO_COMMITS_IN_CODE','true','Do not send commits to SOLR in code',24, 60, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

DELETE FROM configuration WHERE configuration_key = 'SOLR_DISTRIBUTED_TERMS_SEARCH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Distributed terms searching','SOLR_DISTRIBUTED_TERMS_SEARCH','false','Add distrib=true parameter to searches for terms',24, 200, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

DELETE FROM configuration WHERE configuration_key = 'SOLR_PATH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'SOLR path','SOLR_PATH','solr/konakart','SOLR path (typically this is solr/konakart)',24, 40, current timestamp, 0);

DELETE FROM configuration WHERE configuration_key = 'ZOOKEEPER_HOSTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Zookeeper Hosts','ZOOKEEPER_HOSTS','127.0.0.1:2181,127.0.0.1:2182,127.0.0.1:2183','Addresses of one or more Zookeeper hosts used to look up live SOLR locations',24, 50, current timestamp, 0);

DELETE FROM configuration WHERE configuration_key = 'SOLR_ACCESS_MODE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'SOLR Access Mode','SOLR_ACCESS_MODE','Solr','Do not send commits to SOLR in code',24, 20, 'option(Solr=dl.solr.access.mode.solr.url,Zookeeper=dl.solr.access.mode.zookeeper,Custom=dl.solr.access.mode.custom)', current timestamp, 0);

-----------------  v8.8.1.0

-- Role determines whether to activate customer clone and multi-delete buttons
UPDATE kk_role_to_panel SET custom4=0, custom4_desc='If set clone and multi-delete buttons are hidden' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_customers_2');

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'cloneCustomer', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteCustomerMultiStore', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getStoresForCustomer', '', current timestamp);

-----------------  v8.9.0.0

-- Used in storefront to decide whether to enable double opt-in for customer registration
DELETE FROM configuration WHERE configuration_key = 'ENABLE_REGISTRATION_DOUBLE_OPT_IN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Enable Registration Double Opt-In','ENABLE_REGISTRATION_DOUBLE_OPT_IN','false','When true, a customer receives an eMail with a link to click on to confirm registration',1, 60, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Used in storefront to decide whether to enable double opt-in for newsletter sign up
DELETE FROM configuration WHERE configuration_key = 'ENABLE_NEWSLETTER_DOUBLE_OPT_IN';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Enable Newsletter Double Opt-In','ENABLE_NEWSLETTER_DOUBLE_OPT_IN','false','When true, a customer receives an eMail with a link to click on to confirm newsletter subscription',1, 65, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Used in storefront to set a default customer catalog if the customer does not have one assigned in a customer tag value
DELETE FROM configuration WHERE configuration_key = 'DEFAULT_CATALOG_KEY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Default Catalog Key','DEFAULT_CATALOG_KEY','','Default catalog key to use if the customer does not have one assigned in a customer tag value',1,70,current timestamp,1);

-- New API calls
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'removeMallStore', '', current timestamp);

-- Add custom_attrs to the orders_products table
ALTER TABLE orders_products ADD custom_attrs VARCHAR(4000);

-- Increase length of configuration variables
ALTER TABLE configuration ALTER COLUMN configuration_value SET DATA TYPE VARCHAR(2048);

-- New Admin App Panel for configuration of integrations
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_integrations','ERP Integration Configuration', current timestamp);

-- Add Integrations Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_integrations';

-- Used to store a comma separated list of integrated products
DELETE FROM configuration WHERE configuration_key = 'INTEGRATED_PRODUCTS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Integrated Products','INTEGRATED_PRODUCTS','','Used to store a comma separated list of integrated products',33,10,current timestamp,1);

-- Add functionality to allow role based access to the Custom tab on the EditProduct panel
UPDATE kk_role_to_panel SET custom2=0, custom2_desc='Set to deny access to the Custom Tab' WHERE panel_id IN (SELECT panel_id FROM kk_panel where code='kk_panel_editProduct');

-- Add more custom attribute to promotion
ALTER TABLE promotion ADD custom11 varchar(128);
ALTER TABLE promotion ADD custom12 varchar(128);
ALTER TABLE promotion ADD custom13 varchar(128);
ALTER TABLE promotion ADD custom14 varchar(128);
ALTER TABLE promotion ADD custom15 varchar(128);
ALTER TABLE promotion ADD custom16 varchar(128);
ALTER TABLE promotion ADD custom17 varchar(128);
ALTER TABLE promotion ADD custom18 varchar(128);
ALTER TABLE promotion ADD custom19 varchar(128);
ALTER TABLE promotion ADD custom20 varchar(128);

-- Customer tag updates
UPDATE kk_customer_tag SET validation = '((:[0-9]+)+:|)' WHERE validation = '((:[0-9]*)*:|)';
ALTER TABLE kk_customers_to_tag ALTER COLUMN tag_value SET DATA TYPE VARCHAR(1024);

DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_TIME_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added) VALUES (nextval for kk_customer_tag_seq,'PRODUCTS_TIME_VIEWED', 'Recently viewed product id', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='CATEGORIES_TIME_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added) VALUES (nextval for kk_customer_tag_seq,'CATEGORIES_TIME_VIEWED', 'Recently viewed category id', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='MANUFACTURERS_TIME_VIEWED';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added) VALUES (nextval for kk_customer_tag_seq,'MANUFACTURERS_TIME_VIEWED', 'Recently viewed manufacturer id', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_TIME_IN_CART';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added) VALUES (nextval for kk_customer_tag_seq,'PRODUCTS_TIME_IN_CART', 'Id of a product in the cart', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='PRODUCTS_TIME_IN_WISHLIST';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, set_by_api, date_added) VALUES (nextval for kk_customer_tag_seq,'PRODUCTS_TIME_IN_WISHLIST', 'Id of a product in the Wish List', '((:[0-9]+ [0-9]+)+:|)', 7, 10, 1, current timestamp);

-- Allow access to the PDF Base directory name via the APIs
UPDATE configuration set return_by_api = 1 where configuration_key in ('PDF_BASE_DIRECTORY');

-----------------  v9.0.0.0

-- Product Recommendation Suggestions for Products and Customers (for Artificial Intelligence)
DROP TABLE kk_suggestion;
CREATE TABLE kk_suggestion (
  suggestion_version INTEGER NOT NULL,
  suggestion_type INTEGER NOT NULL,
  customers_id INTEGER DEFAULT -1 NOT NULL,
  bought_prod_id INTEGER DEFAULT -1 NOT NULL,
  suggested_prod_id INTEGER NOT NULL,
  confidence INTEGER DEFAULT -1 NOT NULL,
  custom1 VARCHAR(16),
  custom2 VARCHAR(16),
  custom3 VARCHAR(16),
  store_id VARCHAR(64) ,
  date_added TIMESTAMP,
  PRIMARY KEY(suggestion_version, suggestion_type, customers_id, bought_prod_id, suggested_prod_id)
);
CREATE INDEX i_st_8003f3c79598f ON kk_suggestion (store_id);
CREATE INDEX i_cu_8003f3c79598f ON kk_suggestion (customers_id);
CREATE INDEX i_bo_8003f3c79598f ON kk_suggestion (bought_prod_id);

-- New API calls (for Artificial Intelligence)
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'insertSuggestions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'deleteSuggestions', '', current timestamp);
INSERT INTO kk_api_call (api_call_id, name, description, date_added) VALUES (nextval for kk_api_call_seq, 'getSuggestions', '', current timestamp);

-- Delete existing config variables for AI group
DELETE FROM configuration WHERE configuration_group_id = 34;

-- Create new configuration variables for AI
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_URL';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'URL for AI Service','ARTIFICIAL_INTELLIGENCE_URL','http://to-be-confirmed/','URL for Artificial Intelligence Service',34,10,current timestamp,0);
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_CONNECT_TIMEOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Connection timeout for AI Service','ARTIFICIAL_INTELLIGENCE_CONNECT_TIMEOUT','20000','Connection timeout for Artificial Intelligence Service in milliseconds',34,20,current timestamp,0);
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_READ_TIMEOUT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Read timeout for AI Service','ARTIFICIAL_INTELLIGENCE_READ_TIMEOUT','30000','Read timeout for Artificial Intelligence Service in milliseconds',34,30,current timestamp,0);
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_USERNAME';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'AI Service Username','ARTIFICIAL_INTELLIGENCE_USERNAME','','Artificial Intelligence Service Username',34,40,current timestamp,0);
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_PASSWORD';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api, set_function) VALUES (nextval for configuration_seq, 'AI Service Password','ARTIFICIAL_INTELLIGENCE_PASSWORD','','Artificial Intelligence Service Password',34,50,current timestamp,0,'password');
DELETE FROM configuration WHERE configuration_key = 'ARTIFICIAL_INTELLIGENCE_VERSION';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'AI Data Current Version','ARTIFICIAL_INTELLIGENCE_VERSION','1','Current version of the Artificial Intelligence data',34,60,current timestamp,1);

-- New Admin App Panel for configuration of Artificial Intelligence Configurations
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_ai_config','Artificial Intelligence Configuration', current timestamp);

-- Add Integrations Config Panel access to all roles that can access the 'kk_panel_storeConfiguration' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_storeConfiguration' and p2.code='kk_panel_ai_config';

-- Change formatting for Euro currency
UPDATE currencies SET symbol_left='', symbol_right=' ???', decimal_point=',', thousands_point='.' WHERE currencies_id = 2;

-- Config variable to issue warning for matching Coupon Codes in Admin App
DELETE FROM configuration where configuration_key = 'ADMIN_APP_WARN_OF_DUPLICATE_COUPONS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Warn of Duplicate Coupons', 'ADMIN_APP_WARN_OF_DUPLICATE_COUPONS', 'true', 'Issue warning in Admin App of duplicate coupon codes', 21, 32, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

-- New Order Total field
ALTER TABLE orders_total ADD tax decimal(15,4);

-- Example config parameter for the User Defined Configuration Panel - string(min,max)
DELETE FROM configuration WHERE configuration_key = 'USER_DEFINED_EXAMPLE_3';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Example Parameter 3','USER_DEFINED_EXAMPLE_3','2 to 40 characters only','Example of a config variable with a string setFun',31, 20, 'string(2,40)', current timestamp, 1);

-- Add index on SKU
CREATE INDEX i_pr_1ae76e2a2f877 ON products (products_sku);
CREATE INDEX i_pr_b5c48aa1267d0 ON products_quantity (products_sku);

-- Used in storefront to set a startup catalog id
DELETE FROM configuration WHERE configuration_key = 'STARTUP_CATALOG_KEY';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Startup Catalog Key','STARTUP_CATALOG_KEY','','Default catalog key used at startup',1,80,current timestamp,1);

-- New Products table column : stores the product image CRCs
ALTER TABLE products ADD product_image_crc VARCHAR(128);

-- Whether or not to maintain a product image cache with CRC values in the image file names
DELETE FROM configuration WHERE configuration_key = 'MAINTAIN_CRC_IMAGE_CACHE';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Maintain CRC Cache','MAINTAIN_CRC_IMAGE_CACHE','Maintain a product image cache','Maintain a cache of images that contain the CRC value in the filename - only for WOND systems',4, 25, 'choice(''true''=''true'',''false''=''false'')', current timestamp, 1);

-- Table for catalogs
DROP TABLE kk_catalog;
CREATE TABLE kk_catalog (
  catalog_id INTEGER NOT NULL,
  store_id VARCHAR(64),
  cat_name VARCHAR(64) NOT NULL,
  description VARCHAR(255),
  use_cat_prices INT,
  use_cat_quantities INT,
  cat_name_for VARCHAR(64),
  catalog_type INTEGER DEFAULT 0 NOT NULL,
  date_active TIMESTAMP,
  last_creation_date TIMESTAMP,
  PRIMARY KEY(catalog_id)
);
DROP SEQUENCE kk_catalog_SEQ;
CREATE SEQUENCE kk_catalog_SEQ INCREMENT BY 1 START WITH 1 NOMAXVALUE NOCYCLE NOCACHE ORDER;

-- Create the kk_product_prices table
DROP TABLE kk_product_prices;
CREATE TABLE kk_product_prices (
  store_id VARCHAR(64),
  catalog_id VARCHAR(64) NOT NULL,
  products_id INTEGER NOT NULL,
  products_attributes_id INTEGER NOT NULL,
  tier_price_id INTEGER DEFAULT 0 NOT NULL,
  products_price_0 DECIMAL(15,4),
  products_price_1 DECIMAL(15,4),
  products_price_2 DECIMAL(15,4),
  products_price_3 DECIMAL(15,4),
  PRIMARY KEY(catalog_id, products_id, products_attributes_id, tier_price_id)
);

-- Add column to kk_customer_tag
ALTER TABLE kk_customer_tag ADD weighting INT DEFAULT 0 NOT NULL;

-- Set some default weightings - these are used by the KonaKart Suggestions algorithm
UPDATE kk_customer_tag SET weighting = '700' WHERE name ='PRODUCTS_TIME_VIEWED';
UPDATE kk_customer_tag SET weighting = '800' WHERE name ='PRODUCTS_TIME_IN_CART';
UPDATE kk_customer_tag SET weighting = '900' WHERE name ='PRODUCTS_TIME_IN_WISHLIST';

-- Used in the Admin Console for the future date format for catalogs
DELETE FROM configuration WHERE configuration_key = 'CATALOG_FUTURE_DATE_FORMAT';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Future Catalog Date Format','CATALOG_FUTURE_DATE_FORMAT','dd/MM/yyyy HH:mm','Future Catalog Date Format',1,100,current timestamp,1);

-- Product Quantity Table for different catalog ids
DROP TABLE kk_catalog_quantity;
CREATE TABLE kk_catalog_quantity (
  store_id VARCHAR(64),
  catalog_id VARCHAR(64) NOT NULL,
  products_id INTEGER NOT NULL,
  products_options VARCHAR(128) NOT NULL,
  products_quantity INTEGER NOT NULL,
  products_date_available TIMESTAMP,
  PRIMARY KEY(catalog_id, products_id, products_options)
);

-- Catalog to Category table
DROP TABLE kk_catalog_to_category;
CREATE TABLE kk_catalog_to_category (
  catalog_key VARCHAR(64) NOT NULL,
  categories_id INTEGER NOT NULL,
  price_adjustment DECIMAL(15,4),
  fixed_price DECIMAL(15,4),
  exclude INTEGER DEFAULT 0,
  store_id VARCHAR(64),
  PRIMARY KEY(catalog_key, categories_id)
);

-- Customer tag examples used in AI
DELETE FROM kk_customer_tag WHERE name ='FAVOURITE_CITY';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'FAVOURITE_CITY', 'Favourite City of the Customer', '', 0, 1, current timestamp);
DELETE FROM kk_customer_tag WHERE name ='FAVOURITE_COLOUR';
INSERT INTO kk_customer_tag (kk_customer_tag_id, name, description, validation, tag_type, max_ints, date_added) VALUES (nextval for kk_customer_tag_seq,'FAVOURITE_COLOUR', 'Favourite Colour of the Customer', '', 0, 1, current timestamp);

-- Update DD_BASE_PATH path
UPDATE configuration SET configuration_value = 'C:/KonaKart/digitalDownload' WHERE configuration_key = 'DD_BASE_PATH';

-- Defines the Order Status Ids for "Completed Orders"
DELETE FROM configuration WHERE configuration_key = 'COMPLETED_ORDER_STATUS_IDS';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Status Ids of completed orders','COMPLETED_ORDER_STATUS_IDS','3,5','Comma separated list of Completed Order Status Ids (used in Order Statistics batch jobs)',9,60,current timestamp,1);

-- French Zones (Metropolitan Departments from ISO-3166:FR)
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-01','Ain','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-02','Aisne','FR-HDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-03','Allier','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-06','Alpes-Maritimes','FR-PAC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-04','Alpes-de-Haute-Provence','FR-PAC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-08','Ardennes','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-07','Ard??che','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-09','Ari??ge','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-10','Aube','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-11','Aude','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-12','Aveyron','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-67','Bas-Rhin','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-13','Bouches-du-Rh??ne','FR-PAC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-14','Calvados','FR-NOR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-15','Cantal','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-16','Charente','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-17','Charente-Maritime','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-18','Cher','FR-CVL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-19','Corr??ze','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-2A','Corse-du-Sud','FR-COR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-23','Creuse','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-21','C??te-d''Or','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-22','C??tes-d''Armor','FR-BRE');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-79','Deux-S??vres','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-24','Dordogne','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-25','Doubs','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-26','Dr??me','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-91','Essonne','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-27','Eure','FR-NOR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-28','Eure-et-Loir','FR-CVL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-29','Finist??re','FR-BRE');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-30','Gard','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-32','Gers','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-33','Gironde','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-68','Haut-Rhin','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-2B','Haute-Corse','FR-COR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-31','Haute-Garonne','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-43','Haute-Loire','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-52','Haute-Marne','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-74','Haute-Savoie','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-70','Haute-Sa??ne','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-87','Haute-Vienne','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-05','Hautes-Alpes','FR-PAC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-65','Hautes-Pyr??n??es','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-92','Hauts-de-Seine','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-34','H??rault','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-35','Ille-et-Vilaine','FR-BRE');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-36','Indre','FR-CVL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-37','Indre-et-Loire','FR-CVL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-38','Is??re','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-39','Jura','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-40','Landes','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-41','Loir-et-Cher','FR-CVL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-42','Loire','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-44','Loire-Atlantique','FR-PDL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-45','Loiret','FR-CVL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-46','Lot','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-47','Lot-et-Garonne','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-48','Loz??re','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-49','Maine-et-Loire','FR-PDL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-50','Manche','FR-NOR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-51','Marne','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-53','Mayenne','FR-PDL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-54','Meurthe-et-Moselle','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-55','Meuse','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-56','Morbihan','FR-BRE');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-57','Moselle','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-58','Ni??vre','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-59','Nord','FR-HDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-60','Oise','FR-HDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-61','Orne','FR-NOR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-75','Paris','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-62','Pas-de-Calais','FR-HDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-63','Puy-de-D??me','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-64','Pyr??n??es-Atlantiques','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-66','Pyr??n??es-Orientales','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-69','Rh??ne','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-72','Sarthe','FR-PDL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-73','Savoie','FR-ARA');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-71','Sa??ne-et-Loire','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-76','Seine-Maritime','FR-NOR');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-93','Seine-Saint-Denis','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-77','Seine-et-Marne','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-80','Somme','FR-HDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-81','Tarn','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-82','Tarn-et-Garonne','FR-OCC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-90','Territoire de Belfort','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-95','Val-d''Oise','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-94','Val-de-Marne','FR-IDF');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-83','Var','FR-PAC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-84','Vaucluse','FR-PAC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-85','Vend??e','FR-PDL');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-86','Vienne','FR-NAQ');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-88','Vosges','FR-GES');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-89','Yonne','FR-BFC');
INSERT INTO zones (zone_id, zone_country_id, zone_code, zone_name, custom1) VALUES (nextval for zones_seq, 73,'FR-78','Yvelines','FR-IDF');

-- Add CHF

INSERT INTO currencies (currencies_id, title, code, symbol_left, symbol_right, decimal_point, thousands_point, decimal_places, value, last_updated) VALUES (NEXTVAL FOR currencies_seq,'CHF','CHF','CHF ','','.',',','2',1.0000, current timestamp);

-- New order state - Paid-Not Processed
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,15,(SELECT languages_id FROM languages WHERE code = 'en'),'Paid-Not processed');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,15,(SELECT languages_id FROM languages WHERE code = 'de'),'Bezahlt-Nicht bearbeitet');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,15,(SELECT languages_id FROM languages WHERE code = 'es'),'Pagado-No procesado');
INSERT INTO orders_status (orders_status_pk, orders_status_id, language_id, orders_status_name) VALUES (nextval for orders_status_seq,15,(SELECT languages_id FROM languages WHERE code = 'pt'),'Pago-N??o processado');

-- New Admin App Panel for setting user passwords
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_set_password','Set User Passwords', current timestamp);

-----------------  v9.2.0.0

-- Used to decide what content to show in the specifications panel in the product detail page
DELETE FROM configuration WHERE configuration_key = 'CONFIG_CONTENT_FOR_SPECS_TAB';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,set_function, date_added, return_by_api) VALUES (nextval for configuration_seq, 'Content for specifications tab','CONFIG_CONTENT_FOR_SPECS_TAB','CONTENT_CUSTOM_ATTRS','Content to display in specifications tab of product detail panel',1,110,'option(CONTENT_CUSTOM_ATTRS=label.custom.attrs,CONTENT_COMPARISON_DATA=label.productComparison)',current timestamp,1);

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


-----------------  v9.4.0.0

-- Set database version information
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'HISTORY', '9.4.0.0 I', current timestamp);
INSERT INTO kk_config (kk_config_id, kk_config_key, kk_config_value, date_added) VALUES (NEXTVAL FOR kk_config_seq, 'VERSION', '9.4.0.0 DB2', current timestamp);

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
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,0,1,'Undefined');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,0,2,'Undefiniert');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,0,3,'Indefinido');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,0,4,'Indefinido');

INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,1,1,'Requested');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,1,2,'Erw??nscht');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,1,3,'Solicitado');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,1,4,'Solicitada');

INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,2,1,'Approved');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,2,2,'Genehmigt');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,2,3,'Aprobado');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,2,4,'Aprovado');

INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,3,1,'Rejected');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,3,2,'Abgelehnt');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,3,3,'Rechazado');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,3,4,'Rejeitado');

INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,4,1,'Received');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,4,2,'Empfangen');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,4,3,'Recibido');
INSERT INTO kk_order_return_status (returns_status_pk,returns_status_id, language_id, returns_status_name) VALUES (nextval for kk_order_return_status_SEQ,4,4,'Recebido');

-- Order Return statuses panel
-- New Admin App Panel for configuration of Order Return Statuses
INSERT INTO  kk_panel (panel_id, code, description, date_added) VALUES (nextval for kk_panel_seq, 'kk_panel_orderReturnStatuses','Order Return Statuses', current timestamp);

-- Give Order Return statuses panel access to all roles that can access the 'kk_panel_orderStatuses' panel
INSERT INTO kk_role_to_panel (role_id, panel_id, can_edit, can_insert, can_delete, date_added, store_id) SELECT role_id, p2.panel_id, 1, 1, 1, current timestamp, store_id FROM kk_role_to_panel rtp, kk_panel p, kk_panel p2 where rtp.panel_id=p.panel_id and p.code='kk_panel_orderStatuses' and p2.code='kk_panel_orderReturnStatuses';

-- Configuration variable for defining an output queue prefix
DELETE FROM configuration where configuration_key = 'ERP_OUTPUT_QUEUE_PREFIX';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,date_added, return_by_api) VALUES (nextval for configuration_seq, 'Output Queue Prefix','ERP_OUTPUT_QUEUE_PREFIX','KonaKart.','Output queue name for ERP integration is this prefix + storeId + .Q',32,110,current timestamp,1);

-- New configuration variable to allow setting of STARTTLS for emails
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (nextval for configuration_seq, 'SMTP StartTLS','SMTP_STARTTLS','false','Whether or not to enable STARTTLS', 12, 3, current timestamp, 'choice(''true''=''true'',''false''=''false'')');

-- New configuration variable to be used for custom purposes as a System Id
DELETE FROM configuration where configuration_key = 'SYSTEM_ID';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order,date_added, return_by_api) VALUES (nextval for configuration_seq, 'System ID','SYSTEM_ID','','Can be used for any custom purpose to identify the system',32,120,current timestamp,1);

-- New configuration variable for the tax module
DELETE FROM configuration where configuration_key = 'MODULE_ORDER_TOTAL_TAX_MULTIPLE_LINES';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, date_added, set_function) VALUES (nextval for configuration_seq, 'New OT for each tax rate?','MODULE_ORDER_TOTAL_TAX_MULTIPLE_LINES','false','Do you want to have multiple order totals for different tax rates? Tax code must be set on tax class', 6, 3, current timestamp, 'choice(''true''=''true'',''false''=''false'')');

-- Add tax rate code to order product table
ALTER TABLE orders_products ADD tax_rate_code varchar(64);

-- More custom fields for Manufacturer
ALTER TABLE manufacturers ADD custom6 varchar(128);
ALTER TABLE manufacturers ADD custom7 varchar(128);
ALTER TABLE manufacturers ADD custom8 varchar(128);
ALTER TABLE manufacturers ADD custom9 varchar(128);
ALTER TABLE manufacturers ADD custom10 varchar(128);

-- Run Initial Search on Products Panel
DELETE FROM configuration WHERE configuration_key = 'PROD_PANEL_RUN_INITIAL_SEARCH';
INSERT INTO configuration (configuration_id, configuration_title, configuration_key, configuration_value, configuration_description, configuration_group_id, sort_order, set_function, date_added) VALUES (nextval for configuration_seq, 'Run Initial Product Search', 'PROD_PANEL_RUN_INITIAL_SEARCH', 'true', 'Set to true to always run the initial Product Search', 21, 13, 'choice(''true''=''true'',''false''=''false'')', current timestamp);

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

-- Create an IF function for compatibility with mySQL
DROP FUNCTION KK_IF;
CREATE FUNCTION KK_IF(test integer, a decimal(15,4), b decimal(15,4)) returns decimal(15,4) no external action begin atomic    if test > 0 then return a; end if;     return b; end;

exit;
