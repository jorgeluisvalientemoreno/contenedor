DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_TIP_SOL_COMM_CONST';

    IF (nuTab1=0) THEN

        dbms_output.put_line('Insert del Parametro LDC_TIP_SOL_COMM_CONST');

        INSERT INTO LD_PARAMETER VALUES ('LDC_TIP_SOL_COMM_CONST', NULL, '100323,100366', 'TIPOS DE SOLICITUDES PARA EL PAGO AUTOMATICO DE COMISIONES DE CONSTRUCTORAS. CASO:861');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_TIP_SOL_COMM_CONST');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
