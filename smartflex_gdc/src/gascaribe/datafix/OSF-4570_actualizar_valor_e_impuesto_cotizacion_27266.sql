column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

  csbCaso constant varchar2(20) := 'OSF-4570';

BEGIN

  update OPEN.CC_QUOTATION csf
     set csf.initial_payment = 85077374, csf.total_tax_value = 1241033
   where csf.quotation_id = 27266
     and csf.Package_Id = 224551078;

  update OPEN.CUPON a
     set a.cupovalo = 85077374
   where a.cuponume = 903909120
     and a.cuposusc = 67715756;

  commit;
  dbms_output.put_line('Se actualiza en valor del cupon 903909120');
  dbms_output.put_line('Se actualiza en valor total y valor total impuesto de la cotizacion 27266');

exception
  when others then
    rollback;
    dbms_output.put_line('No se actualiza en valor total y valor total impuesto de la cotizacion 27266 - Error: ' ||
                         sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/