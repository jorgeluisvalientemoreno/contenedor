DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_VASANOTI';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_VASANOTI');
      INSERT INTO LD_PARAMETER VALUES ('LDC_VASANOTI', NULL, NULL, 'VALOR PARA NOTIFICAR A USUARIOS');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_VASANOTI');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/

