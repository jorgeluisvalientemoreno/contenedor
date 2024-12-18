DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_EMAIL_REG_NOTIF';

    IF (nuTab1=0) THEN

      dbms_output.put_line('Insert del Parametro LDC_EMAIL_REG_NOTIF');

      INSERT INTO LD_PARAMETER VALUES ('LDC_EMAIL_REG_NOTIF', NULL, 'hblanco@gascaribe.com,hangulo@gascaribe.com', 'CORREOS ELECTRONICOS PARA NOTIFICAR REGISTRO EN LDCAPLAC');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_EMAIL_REG_NOTIF');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
