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
    ) VALUES ('OPEN', 
              'PKTBLSERVSUSC.FRCGETRECORD', 
              'Obtener registro de un producto', 
              'ADM_PERSON', 
              'PKG_BCPRODUCTO.FRCOBTPRODUCTO', 
              'Obtener registro de un producto', NULL );

     INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'PKTBLSUSCRIPC.FRCGETRECORD', 
              'Obtener registro de una cuenta contrato', 
              'ADM_PERSON', 
              'PKG_BCCONTRATO.FRCOBTINFOCONTRATO', 
              'Obtener registro de una cuenta contrato', NULL );
    
      INSERT INTO personalizaciones.homologacion_servicios ( esquema_origen,
                                                            servicio_origen,
                                                            descripcion_origen,
                                                            esquema_destino,
                                                            servicio_destino,
                                                            descripcion_destino,
                                                            observacion
    ) VALUES ('OPEN', 
              'PKTBLMOVIDIFE.INSRECORD', 
              'Inserta movimiento de diferido', 
              'ADM_PERSON', 
              'PKG_MOVIDIFE.PRCINSERTARMOVIDIFE', 
              'Inserta movimiento de diferido', NULL );
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