set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
  nuMovimiento number;
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
      operating_unit_id = null
   where serie='C-1943394-14';
   update or_ope_uni_item_bala
      set balance=balance-1,
        total_costs=total_costs-132106.47
  where items_id=10002011
    and operating_unit_id=3020;
  update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-132106.47
   where items_id=10002011
    and operating_unit_id=3020;
  commit;
  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=10002011
    and operating_unit_id=3020;
   update open.or_uni_item_bala_mov
      set comments ='SOSF-662',
          id_items_seriado=2237455
     where uni_item_bala_mov_id=nuMovimiento;
    commit;
exception
  when others then
  rollback;
  dbms_output.put_line('Error: '||sqlerrm);
end;
/
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/