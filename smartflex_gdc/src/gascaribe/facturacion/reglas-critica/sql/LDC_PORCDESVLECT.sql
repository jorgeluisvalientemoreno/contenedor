DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_PORCDESVLECT';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_PORCDESVLECT');
      INSERT INTO LD_PARAMETER VALUES ('LDC_PORCDESVLECT', 50, NULL, 'PROCENTAJE DE DESVIACION DE CONSUMO');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_PORCDESVLECT');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/