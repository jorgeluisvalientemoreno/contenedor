DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_UNIOPEFOVC';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_UNIOPEFOVC');
      INSERT INTO LD_PARAMETER VALUES ('LDC_UNIOPEFOVC', 2152, null, 'UNIDAD OPERATIVA PARA PROCESO DE ASIGNACION FOVC');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_UNIOPEFOVC');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/