DECLARE
    rcLdparameter   dald_parameter.styld_parameter;
BEGIN
    dbms_output.put_line('Inicia actualización parametro LDC_ACTICARM57');
        
        UPDATE ld_parameter
        SET     parameter_id = 'LDC_ACTICAR_SEG_NOTI',
                description = 'ACTIVIDAD DE IMPRESION DE CARTA PARA SEGUNDA NOTIFICACIÓN DE RP'
        WHERE   parameter_id = 'LDC_ACTICARM57';
        
        COMMIT;
    dbms_output.put_line('Termina actualización parametro LDC_ACTICARM57');
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        dbms_output.put_line('Error actualizado parametro LDC_ACTICARM57');
END;
/