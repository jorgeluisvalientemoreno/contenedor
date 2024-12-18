column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

DECLARE

  -- Informacion general
  nuOrden CONSTANT NUMBER := 337673031;

BEGIN

  dbms_output.put_line('Inicia Proceso OSF-3288');
  dbms_output.put_line('---------------------------------------------------------------------------------');

  -- Borra el registro
  DELETE ldc_ordenes_ofertados_redes WHERE orden_hija = nuOrden;

  COMMIT;
  dbms_output.put_line('Retirar orden hija ' || nuOrden);

  dbms_output.put_line('---------------------------------------------------------------------------------');
  dbms_output.put_line('Fin del Proceso OSF-3288');

EXCEPTION
  WHEN OTHERS THEN
    rollback;
    dbms_output.put_line('Error del proceso. ' || SQLERRM);
END;
/


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/