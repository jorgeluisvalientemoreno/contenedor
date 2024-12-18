DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'COD_UNIDVALDOC_VENTXDEPA';

    IF (nuTab1=0) THEN
      
        dbms_output.put_line('Insert del Parametro COD_UNIDVALDOC_VENTXDEPA');
        INSERT INTO LD_PARAMETER VALUES ('COD_UNIDVALDOC_VENTXDEPA', NULL, '2:4067|3:4022|4:4091', 'CODIGOS DE LAS UNIDADES DE VENTA QUE REALIZAN VALIDACION DE DOCUMENTO X DPTO CASO:861');
    ELSE
        dbms_output.put_line('Existe el Parametro COD_UNIDVALDOC_VENTXDEPA');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
