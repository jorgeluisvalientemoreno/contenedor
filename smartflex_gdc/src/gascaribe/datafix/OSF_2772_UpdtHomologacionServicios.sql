SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2772');
 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicia DATAFIX OSF-2772');
     UPDATE personalizaciones.homologacion_servicios
        SET observacion = 'el método GW_BOERRORS.CHECKERROR levanta error cuando la variable nuError tiene valor diferente de 0. El método PKG_ERROR.SETERRORMESSAGE levanta error siempre.'
      WHERE servicio_origen ='GW_BOERRORS.CHECKERROR'
        AND esquema_destino = 'ADM_PERSON'
        AND servicio_destino = 'PKG_ERROR.SETERRORMESSAGE';
    
    
    IF SQL%FOUND THEN
       dbms_output.put_line('Registros afectados: '||SQL%ROWCOUNT); 
    END IF; 
    COMMIT;
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/