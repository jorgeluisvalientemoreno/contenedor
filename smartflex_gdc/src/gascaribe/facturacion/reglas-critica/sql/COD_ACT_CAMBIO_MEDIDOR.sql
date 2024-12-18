DECLARE

    nuTab1 number := 0;

BEGIN
    update ld_parameter 
        set value_chain = '10764, 11045, 11260, 11094, 10526, 10527, 10075, 10528, 10074, 10534, 10720, 10933, 12143, 10951, 11027'
    WHERE PARAMETER_ID = 'COD_ACT_CAMBIO_MEDIDOR';

    -----------------------------------------------------------------------------------------------------
    commit;
END;
/