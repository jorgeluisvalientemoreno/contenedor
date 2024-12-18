PROMPT Crea Sinonimo a tabla or_temp_data_values
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.or_temp_data_values FOR or_temp_data_values';
END;
/