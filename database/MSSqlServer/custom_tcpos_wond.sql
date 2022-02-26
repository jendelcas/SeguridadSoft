------------------------------------------------------------------
-- Custom TCPOS WOND Database Set-up
-- Add your custom SQL here.
------------------------------------------------------------------

-- Set the Store Name

UPDATE configuration SET configuration_value='TCPOS WOND Store'   WHERE configuration_key='STORE_NAME';

-- Set the Store Owner
UPDATE configuration SET configuration_value='TCPOS WOND Store Admin'   WHERE configuration_key='STORE_OWNER';

exit;
