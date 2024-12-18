column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_inicio from dual;

declare

  nuMovimiento number;
  sbCaso       varchar2(2000) := 'Costo 0 al item 10011187 de la unidad operativa 3615 en bodega por memorando autorizado por CASO OSF-2652';

begin

  update open.or_ope_uni_item_bala oouib
     set oouib.total_costs = 0
   where oouib.items_id = 10011187
     and oouib.operating_unit_id = 3615;
  update open.ldc_inv_ouib oouib
     set oouib.total_costs = 0
   where oouib.items_id = 10011187
     and oouib.operating_unit_id = 3615;
  update open.ldc_act_ouib oouib
     set oouib.total_costs = 0
   where oouib.items_id = 10011187
     and oouib.operating_unit_id = 3615;

  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id)
    into nuMovimiento
    from open.or_uni_item_bala_mov
   where items_id = 10011187
     and operating_unit_id = 3615;

  update open.or_uni_item_bala_mov
     set comments = sbCaso
   where uni_item_bala_mov_id = nuMovimiento;

  commit;
  dbms_output.put_line('Costo 0 al item 10011187 de la unidad operativa 3615 en bodega.');

exception
  when others then
    dbms_output.put_line('Error: ' || sqlerrm);
    rollback;
  
end;
/

select to_char(sysdate,'DD-MM-YYYY hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/