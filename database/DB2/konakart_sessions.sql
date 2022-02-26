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
-- -----------------------------------------------------------
-- 


-- Extend the size of the sesskey column in the sessions table
-- Change the name of the value column to sessvalue to avoid using reserved words
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
exit;
