column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update open.cupon
   set cupovalo=125000
  where cuponume in (230490715,230490721,230490708,230490707,230490712,230490717,230490710,230490711,230490713,230490719,230490722,230490697,230490695,230490690,230490699,230490692,230490694,230490689,230490691,230490696);

  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/