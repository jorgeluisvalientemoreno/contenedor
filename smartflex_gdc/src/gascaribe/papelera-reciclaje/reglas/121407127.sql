begin

    begin

        --Borrado regla encargada de crear la regla  
        DELETE FROM GR_CONFIG_EXPRESSION WHERE CONFIG_EXPRESSION_ID = 121407127;
        Commit;
        dbms_output.put_line('Regla 121407127 borrada Ok.');

    exception
        when others then
            Rollback;
            dbms_output.put_line('Error en el borrado de la regla 121407127');
        
    end;

    begin

    --Borrado objeto tipo función  
    EXECUTE IMMEDIATE 'DROP FUNCTION FABCCT14E121407127';

    dbms_output.put_line('Borrado Funcion FABCCT14E121407127.');  

    exception
        when others then
            Rollback;
            dbms_output.put_line('Ya fue borrada la funcion FABCCT14E121407127');
        
    end;

end;
/