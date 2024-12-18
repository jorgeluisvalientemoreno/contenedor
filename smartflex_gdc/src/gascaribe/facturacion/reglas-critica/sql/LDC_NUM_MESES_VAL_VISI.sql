DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_NUM_MESES_VAL_VISI';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_NUM_MESES_VAL_VISI');
      INSERT INTO LD_PARAMETER VALUES ('LDC_NUM_MESES_VAL_VISI', 6, NULL, 'UMERO DE MESES A VALIDAR ORDENES DE REVISION DE CONSUMO INDISTRIAL');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_NUM_MESES_VAL_VISI');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/