#----------------------------------------------------------------
# KonaKart sessions table creation script
#----------------------------------------------------------------

#MySQL -- For MySQL Only - Disable Safe Updates Mode
SET SQL_SAFE_UPDATES=0;

# Extend the size of the sesskey column in the sessions table
# Change the name of the value column to sessvalue to avoid using reserved words
# For various reasons, mainly DB2/MS-SQL limitations, we drop the sessions table and recreate it
DROP TABLE IF EXISTS sessions;
CREATE TABLE sessions (
  sesskey varchar(64) NOT NULL,
  expiry int(11) unsigned NOT NULL,
  customer_id int NULL,
  value varchar(256) NULL,
  store_id varchar(64) NULL,
  custom1 varchar(128) NULL,
  custom2 varchar(128) NULL,
  custom3 varchar(128) NULL,
  custom4 varchar(128) NULL,
  custom5 varchar(128) NULL,
  PRIMARY KEY (sesskey)
);
ALTER TABLE sessions ADD KEY idx_store_id (store_id);
