column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  
  delete from OPEN.LDC_ORDENES_OFERTADOS_REDES a
   where a.orden_padre = 326458931;
  COMMIT;
  dbms_output.put_line('Se elimino la orden padre 326458931 Ok.');

exception
  when others then
    rollback;
    dbms_output.put_line('No se pudo eliminar la orden padre 326458931 Error: ' ||
                         sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/