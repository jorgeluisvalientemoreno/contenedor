column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 2388');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicia DATAFIX OSF-2388');
     UPDATE personalizaciones.homologacion_servicios
     SET observacion = 'Se cambia select into variable por variable := PKG_SESSION.FNUGETSESION, la homologacion no aplica para funcionalidades de tipo PB Programado'
     WHERE SERVICIO_DESTINO ='PKG_SESSION.FNUGETSESION'
     AND ESQUEMA_ORIGEN = 'OPEN'
     AND ESQUEMA_DESTINO ='ADM_PERSON';
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('ACTUALIZAR DATOS EN HOMOLOGACION_SERVICIOS--> '||1); 
EXCEPTION
    WHEN OTHERS THEN
        ROLLBACK;
        DBMS_OUTPUT.PUT_LINE('Error: ' || sqlerrm);
END;
/

SELECT TO_CHAR(sysdate, 'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin FROM dual;

/ 