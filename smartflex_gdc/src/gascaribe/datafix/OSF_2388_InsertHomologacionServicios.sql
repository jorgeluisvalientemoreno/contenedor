column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2388');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicia DATAFIX OSF-2388');
     INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 'DAGE_DIRECTORY.FSBGETPATH', 'Obtiene la ruta para el id de directorio enviado', 'ADM_PERSON', 'PKG_BCDIRECTORIOS.FSBGETRUTA',  NULL, NULL );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('INSERTADOS DATOS EN HOMOLOGACION_SERVICIOS--> '||1); 
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;

/ 