PROMPT Crea Sinonimo a tabla ldc_aud_act_val_order
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ADM_PERSON.ldc_aud_act_val_order FOR ldc_aud_act_val_order';
END;
/