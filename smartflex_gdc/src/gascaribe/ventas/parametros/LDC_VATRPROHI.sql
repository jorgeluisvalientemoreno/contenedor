DECLARE

    nuTab1 number := 0;

BEGIN
    select count(1) into nuTab1
    from ld_parameter
    where parameter_ID = 'LDC_VATRPROHI';

    IF (nuTab1=0) THEN
      dbms_output.put_line('Insert del Parametro LDC_VATRPROHI');
      INSERT INTO LD_PARAMETER VALUES ('LDC_VATRPROHI', 15015, NULL, 'VALOR A TRASLADAR A PRODUCTO HIJO');
    ELSE
        dbms_output.put_line('Existe el Parametro LDC_VATRPROHI');
    END IF;
    -----------------------------------------------------------------------------------------------------
    commit;
END;
/

