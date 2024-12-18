DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_EMAILNVPC';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_EMAILNVPC');
      INSERT INTO LD_PARAMETER VALUES ('LDC_EMAILNVPC', NULL, 'pabbar@gascaribe.com,fvillarreal@gascaribe.com', 'EMAIL PARA NOTIFICAR SALDOS DE CONTRATOS PADRES');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_EMAILNVPC');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/

