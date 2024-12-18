DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_TOLERANCIA_ITEMS_COTI';

    IF (nuTab1=0) THEN

      dbms_output.put_line('Insert del Parametro LDC_TOLERANCIA_ITEMS_COTI');

      INSERT INTO LD_PARAMETER VALUES ('LDC_TOLERANCIA_ITEMS_COTI', 1, NULL, 'TOLERANCIA PARA SUMATORIA DE ITEMS COTIZADOS');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_TOLERANCIA_ITEMS_COTI');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
