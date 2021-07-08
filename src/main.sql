CREATE PROCEDURE split_calloc_field(
    IN  calloc    VARCHAR(256), 
    OUT invoice_1 VARCHAR(99), 
    OUT amount_1  DECIMAL(10,2),
    OUT date_1    VARCHAR(99),
    OUT invoice_2 VARCHAR(99), 
    OUT amount_2  DECIMAL(10,2),
    OUT date_2    VARCHAR(99)
)

main:BEGIN    
    -- get the number of fields
    DECLARE fields_temp VARCHAR(255);
    DECLARE amount_temp VARCHAR(255);
    DECLARE fields_count INT;
    SET fields_count = LENGTH(calloc) - LENGTH(REPLACE(calloc, '|', '')) + 1;

    -- get field #1
    IF fields_count <= 0 THEN
        LEAVE main;
    END IF;
    SET fields_temp = SUBSTRING_INDEX(calloc, '|', 1);
    SET invoice_1   = SUBSTRING_INDEX(fields_temp, ';', 1);
    SET invoice_1   = SUBSTRING(invoice_1, 3);
    SET fields_temp = SUBSTRING_INDEX(fields_temp, ';', -2);
    SET amount_temp = SUBSTRING_INDEX(fields_temp, ';', 1);
    SET amount_temp = SUBSTRING(amount_temp, 3);
    SET amount_1    = CAST(amount_temp AS DECIMAL(10,2));
    SET fields_temp = SUBSTRING_INDEX(fields_temp, ';', -1);
    SET date_1      = SUBSTRING_INDEX(fields_temp, ';', 1);
    SET date_1      = SUBSTRING(date_1, 3);
    SET fields_count = fields_count - 1;
    SET calloc = SUBSTRING_INDEX(calloc, '|', fields_count * (-1));

    -- get field #2
    IF fields_count <= 0 THEN
        LEAVE main;
    END IF;
    SET fields_temp = SUBSTRING_INDEX(calloc, '|', 1);
    SET invoice_2   = SUBSTRING_INDEX(fields_temp, ';', 1);
    SET invoice_2   = SUBSTRING(invoice_2, 3);
    SET fields_temp = SUBSTRING_INDEX(fields_temp, ';', -2);
    SET amount_temp = SUBSTRING_INDEX(fields_temp, ';', 1);
    SET amount_temp = SUBSTRING(amount_temp, 3);
    SET amount_2    = CAST(amount_temp AS DECIMAL(10,2));
    SET fields_temp = SUBSTRING_INDEX(fields_temp, ';', -1);
    SET date_2      = SUBSTRING_INDEX(fields_temp, ';', 1);
    SET date_2      = SUBSTRING(date_2, 3);
    SET fields_count = fields_count - 1;
    SET calloc = SUBSTRING_INDEX(calloc, '|', fields_count * (-1));
END