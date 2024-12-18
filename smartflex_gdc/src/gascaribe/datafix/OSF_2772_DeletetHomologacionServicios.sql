SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2772'); 
DECLARE
 
 CURSOR cu_servicios is
    SELECT *
      FROM PERSONALIZACIONES.HOMOLOGACION_SERVICIOS
     WHERE SERVICIO_ORIGEN  in ('GE_DIRECTORY.PATH',
                                'LDC_BOUTILITIES.SPLITSTRINGS');
    nuCantidad NUMBER;
    nuCant NUMBER;
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicia DATAFIX OSF-2772');
     DELETE personalizaciones.homologacion_servicios 
      WHERE servicio_origen = 'GE_DIRECTORY.PATH' 
        AND esquema_destino = 'ADM_PERSON'
        AND servicio_destino= 'PKG_BCDIRECTORIOS.FSBGETRUTA';
        dbms_output.put_line(' GE_DIRECTORY.PATH borrado exitoso');
    COMMIT;
    
    
     DELETE personalizaciones.homologacion_servicios 
      WHERE servicio_origen = 'LDC_BOUTILITIES.SPLITSTRINGS' 
        AND esquema_destino = 'N/A'
        AND servicio_destino= 'REGEXP_SUBSTR';
        dbms_output.put_line(' LDC_BOUTILITIES.SPLITSTRINGS borrado exitoso');
    COMMIT;
    
    
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/