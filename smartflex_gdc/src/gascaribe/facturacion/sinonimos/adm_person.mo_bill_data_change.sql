PROMPT Crea Sinonimo a tabla mo_bill_data_change
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.mo_bill_data_change FOR mo_bill_data_change';
END;
/