DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_CODATRIBLECT';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_CODATRIBLECT');
      INSERT INTO LD_PARAMETER VALUES ('LDC_CODATRIBLECT', NULL, '5001011, 5001842', 'CODIGO DE ATRIBUTO DE LECTURAS');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_CODATRIBLECT');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/