DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_NUMMESESVAL';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_NUMMESESVAL');
      INSERT INTO LD_PARAMETER VALUES ('LDC_NUMMESESVAL', 5, NULL, 'NUMERO DE MESES A VALIDAR ORDENES DE REVISION DE CONSUMO');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_NUMMESESVAL');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/