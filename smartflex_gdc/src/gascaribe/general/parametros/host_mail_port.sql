Prompt Actualizando HOST_MAIL_PORT a 25
DECLARE

    CURSOR cuge_param_HOST_MAIL_PORT
    IS 
    SELECT a.value, a.ROWID Rid 
    FROM ge_parameter a
    WHERE parameter_id = 'HOST_MAIL_PORT';
    
    rcge_param_HOST_MAIL_PORT_Ini cuge_param_HOST_MAIL_PORT%ROWTYPE;
    
BEGIN

    OPEN cuge_param_HOST_MAIL_PORT;
    FETCH cuge_param_HOST_MAIL_PORT INTO rcge_param_HOST_MAIL_PORT_Ini;
    CLOSE cuge_param_HOST_MAIL_PORT;

    IF rcge_param_HOST_MAIL_PORT_Ini.value <> 25 THEN
    
        UPDATE ge_parameter
        SET value = 25
        WHERE ROWID = rcge_param_HOST_MAIL_PORT_Ini.Rid;
    
        COMMIT;
        
        dbms_output.put_line( 'Actualizado parámetro HOST_MAIL_PORT de ' || rcge_param_HOST_MAIL_PORT_Ini.value || ' a 25');
        
    ELSE
        dbms_output.put_line( 'El parámetro HOST_MAIL_PORT ya tiene valor 25'); 
    END IF;
    
END;
/
