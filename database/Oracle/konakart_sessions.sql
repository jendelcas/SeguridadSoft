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
-- -----------------------------------------------------------
-- 
set escape \

-- Extend the size of the sesskey column in the sessions table
-- Change the name of the value column to sessvalue to avoid using reserved words
-- For various reasons, mainly DB2/MS-SQL limitations, we drop the sessions table and recreate it
BEGIN EXECUTE IMMEDIATE 'DROP TABLE sessions'; EXCEPTION WHEN OTHERS THEN NULL; END;
/
CREATE TABLE sessions (
  sesskey VARCHAR2(64) NOT NULL,
  expiry NUMBER(10,0) NOT NULL,
  customer_id NUMBER(10,0) NULL,
  value VARCHAR2(256) NULL,
  store_id VARCHAR2(64) NULL,
  custom1 VARCHAR2(128) NULL,
  custom2 VARCHAR2(128) NULL,
  custom3 VARCHAR2(128) NULL,
  custom4 VARCHAR2(128) NULL,
  custom5 VARCHAR2(128) NULL,
  PRIMARY KEY(sesskey)
);
CREATE INDEX i_store_id_sessions ON sessions (store_id);
exit;
