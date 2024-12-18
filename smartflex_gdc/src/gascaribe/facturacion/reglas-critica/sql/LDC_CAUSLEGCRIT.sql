DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_CAUSLEGCRIT';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_CAUSLEGCRIT');
      INSERT INTO LD_PARAMETER VALUES ('LDC_CAUSLEGCRIT', 9689, NULL, 'CAUSAL PARA LEGALIZAR ORDENES DE CRITICA');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_CAUSLEGCRIT');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/