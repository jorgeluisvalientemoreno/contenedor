DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_ACTI_NEW_WARRANTY';

    IF (nuTab1=0) THEN

      dbms_output.put_line('Insert del Parametro LDC_ACTI_NEW_WARRANTY');

      INSERT INTO LD_PARAMETER VALUES ('LDC_ACTI_NEW_WARRANTY', 100009343, NULL, 'IDENTIFICADOR DE LA NUEVA ACTIVIDAD DE GARANTIA');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_ACTI_NEW_WARRANTY');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
