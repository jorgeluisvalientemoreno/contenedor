PROMPT Crea sinonimo a la funciOn ldc_show_payment_orders
BEGIN
    EXECUTE IMMEDIATE 'CREATE OR REPLACE SYNONYM ldc_show_payment_orders FOR ADM_PERSON.ldc_show_payment_orders';
END;
/