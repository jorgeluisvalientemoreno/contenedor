DECLARE
    nuError NUMBER;
    sbError VARCHAR2(4000);
    nuActa  NUMBER:=177690;
    sbComm  VARCHAR2(200) :='CASO OSF-454';

BEGIN
    --Este update al acta se realiza previa validación co contabilidad
    --de que el acta no ha subido a sap o que ya fue anulada en sap
    --en el caso normal este update  no debe ir
    UPDATE open.ge_acta
      set extern_invoice_num = null,
          extern_pay_date = null
    WHERE id_acta = nuActa ;

    ldc_prAbrirActaCerrada(nuActa, 
                                sbComm, 
                                nuError,
                                sbError);

    IF nuError = 0 THEN
        COMMIT;
        DBMS_OUTPUT.PUT_LINE('ACTA '||nuActa||' REVERSADA OK ');
    ELSE
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('ERROR ACTA '||nuActa||' '||sbError);
    END IF;    
END;
/