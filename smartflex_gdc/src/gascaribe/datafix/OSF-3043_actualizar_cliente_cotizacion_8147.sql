column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN
  
  update open.ldc_cotizacion_comercial l
    set l.cliente = 3220406, l.id_direccion = 51384
  where l.id_cot_comercial = 8147;
  COMMIT;
  dbms_output.put_line('Se actualiza cotizacion 8147 con el nuevo cliente 3220406.');

exception
  when others then
    rollback;
    dbms_output.put_line('No se pudo actualizar cotizacion 8147 con el nuevo cliente 3220406 - Error: ' ||
                         sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/