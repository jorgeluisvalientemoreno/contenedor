column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
DECLARE
  nuProcesados NUMBER;
BEGIN
  dbms_output.put_line('Incia Actualización de tramites procesados ');

  UPDATE  ldc_ordentramiterp 
  SET     procesado = 'S'
  WHERE   solicitud in 
                          (
                              SELECT package_id
                              FROM or_order a, or_order_activity b
                              WHERE a.order_id = b.order_id
                              AND a.order_id IN (SELECT ORAPORPA FROM LDC_ORDEASIGPROC)
                              AND order_status_id in (5,7,8)
                              AND package_id IS NOT NULL
                          );

  nuProcesados :=  SQL%ROWCOUNT;
  dbms_output.put_line('Registros Actualizados ['||nuProcesados||']');
  COMMIT;
  dbms_output.put_line('FIN Actualización de tramites procesados');
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/