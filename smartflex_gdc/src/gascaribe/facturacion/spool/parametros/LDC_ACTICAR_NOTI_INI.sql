DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia actualización parametro LDC_ACTICARM55');
        
        UPDATE ld_parameter
        SET     parameter_id = 'LDC_ACTICAR_NOTI_INI',
                description = 'ACTIVIDAD DE IMPRESION DE CARTA PARA NOTIFICACIÓN INICIAL DE RP'
        WHERE   parameter_id = 'LDC_ACTICARM55';
        
        COMMIT;
    dbms_output.put_line('Termina actualización parametro LDC_ACTICARM55');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error actualizado parametro LDC_ACTICARM55');
END;
/