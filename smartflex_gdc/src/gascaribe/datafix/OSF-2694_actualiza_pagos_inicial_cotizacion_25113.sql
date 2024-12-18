column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

BEGIN

  update OPEN.CC_QUOTATION a
     set a.initial_payment = 27156002
   where a.quotation_id = 25113
     and a.package_id = 213640039;

  COMMIT;

  dbms_output.put_line('Actualizacion de pago inicial de cotizacion 25113');
exception
  when others then
    dbms_output.put_line('Error actualizando de pago inicial de cotizacion 25113 - ' ||
                         sqlerrm);
  
END;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/