column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 1805');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
 
BEGIN
	
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 'GE_BOSCHEDULE.SCHEDULEPROCESS', 'Crear programacion', 'ADM_PERSON', 'PKG_GESTIONPROCESOSPROGRAMADOS.PRC_CREAPROGRAMACION',  'Crear programacion', NULL );

    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 'GE_BOSCHEDULE.PREPARESCHEDULE', 'Preparar programacion', 'ADM_PERSON', 'PKG_GESTIONPROCESOSPROGRAMADOS.PRC_PROGRAMARPROCESO',  'Ejecutar programacion', NULL );
    COMMIT;

EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;
SET SERVEROUTPUT OFF
QUIT
/ 