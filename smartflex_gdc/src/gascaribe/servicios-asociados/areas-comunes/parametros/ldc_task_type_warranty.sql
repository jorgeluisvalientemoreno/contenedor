DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_TASK_TYPE_WARRANTY';

    IF (nuTab1=0) THEN

      dbms_output.put_line('Insert del Parametro LDC_TASK_TYPE_WARRANTY');

      INSERT INTO LD_PARAMETER VALUES ('LDC_TASK_TYPE_WARRANTY', NULL, '12487', 'TIPOS DE TRABAJO PARA VALIDACION DE GARANTIAS');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_TASK_TYPE_WARRANTY');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
