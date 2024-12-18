DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_IDREGLAEXCL';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_IDREGLAEXCL');
      INSERT INTO LD_PARAMETER VALUES ('LDC_IDREGLAEXCL', null, '0', 'ID DE REGLAS DE CONSUMO A EXCLUIR');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_IDREGLAEXCL');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/
