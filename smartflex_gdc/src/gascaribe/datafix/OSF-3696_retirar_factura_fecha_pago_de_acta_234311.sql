column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;


begin

  update open.ge_acta ga
     set ga.extern_pay_date = null, ga.extern_invoice_num = null
   where ga.id_acta = 234311;

  commit;

  dbms_output.put_line('Se retira factura y fecha de pago del acta 234311. Ok.');

exception
  when others then
    rollback;
    dbms_output.put_line('No se pudo retirar factura y fecha de pago del acta 234311');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/