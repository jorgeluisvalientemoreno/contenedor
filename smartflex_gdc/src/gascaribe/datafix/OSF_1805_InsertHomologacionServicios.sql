column dt new_value vdt
column db new_value vdb
select TO_CHAR(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
SET SERVEROUTPUT ON SIZE UNLIMITED
EXECUTE dbms_application_info.set_action('APLICANDO DATAFIX 1805');
SELECT TO_CHAR(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
 
BEGIN
	DBMS_OUTPUT.PUT_LINE('Inicia DATAFIX OSF-1805');
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 'DAPR_PRODUCT.FNUGETPRODUCT_TYPE_ID', 'Retorna el Consecutivo De Tipo De Producto', 'ADM_PERSON', 'PKG_BCPRODUCTO.FNUTIPOPRODUCTO',  NULL, NULL );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('INSERTADOS DATOS EN HOMOLOGACION_SERVICIOS--> '||1);
    --
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 'DAPR_PRODUCT.FNUGETSUBSCRIPTION_ID', 'Retorna el Consecutivo de la Suscripción al producto', 'ADM_PERSON', 'PKG_BCPRODUCTO.FNUCONTRATO',  NULL, NULL );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('INSERTADOS DATOS EN HOMOLOGACION_SERVICIOS--> '||2);    
    --
    INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 'DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID', 'Retorna el id del Plan comercial del producto', 'ADM_PERSON', 'PKG_BCPRODUCTO.FNUTRAERCOMMERCIALPLANID',  NULL, NULL );
    COMMIT;
    DBMS_OUTPUT.PUT_LINE('INSERTADOS DATOS EN HOMOLOGACION_SERVICIOS--> '||3);      
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