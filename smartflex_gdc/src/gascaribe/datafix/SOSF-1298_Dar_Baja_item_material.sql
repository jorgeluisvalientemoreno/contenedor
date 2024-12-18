column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX SOSF-1298');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
  nuMovimiento number;
  nuItemId  number:=10006559;
  nuUnidad  number:=2557;
  sbCaso    varchar2(100):='SOSF-1298';
  nuCantidad   number:=-1;
  nuValor    number:=-78951;
begin
-- Bodega 2557 
   update or_ope_uni_item_bala
      set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;

  update ldc_inv_ouib
  set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
   where items_id=nuItemId
    and operating_unit_id=nuUnidad;
  
  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=nuItemId
    and operating_unit_id=nuUnidad;

   update open.or_uni_item_bala_mov
      set comments =sbCaso
     where uni_item_bala_mov_id=nuMovimiento;
 
   commit;
 -- Bodega 3001
  nuUnidad   :=3001;
  nuCantidad :=-3;
  nuValor    :=-237612;
  
   update or_ope_uni_item_bala
      set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;

  update ldc_inv_ouib
  set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor,
        transit_in = transit_in+nuCantidad
   where items_id=nuItemId
    and operating_unit_id=nuUnidad;
  
  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=nuItemId
    and operating_unit_id=nuUnidad;

   update open.or_uni_item_bala_mov
      set comments =sbCaso
     where uni_item_bala_mov_id=nuMovimiento;
 
   commit;
 
 -- Bodega 3003 
  
  nuUnidad   :=3003;
  nuCantidad :=-1;
  nuValor    :=-78951;
  
   update or_ope_uni_item_bala
      set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;

  update ldc_inv_ouib
  set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor,
        transit_in = transit_in+nuCantidad
   where items_id=nuItemId
    and operating_unit_id=nuUnidad;
  
  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=nuItemId
    and operating_unit_id=nuUnidad;

   update open.or_uni_item_bala_mov
      set comments =sbCaso
     where uni_item_bala_mov_id=nuMovimiento;
 
   commit;
   
-- Bodega 3015

  nuUnidad   :=3015;
  nuCantidad :=-1;
  nuValor    :=-78950;
  
   update or_ope_uni_item_bala
      set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;

  update ldc_inv_ouib
  set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;
  
  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=nuItemId
    and operating_unit_id=nuUnidad;

   update open.or_uni_item_bala_mov
      set comments =sbCaso
     where uni_item_bala_mov_id=nuMovimiento;
 
   commit;

-- Bodega 3017

  nuUnidad   :=3017;
  nuCantidad :=-2;
  nuValor    :=-152132;
  
   update or_ope_uni_item_bala
      set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;

  update ldc_inv_ouib
  set balance=balance+nuCantidad,
        total_costs=total_costs+nuValor
  where items_id=nuItemId
    and operating_unit_id=nuUnidad;
  
  DBMS_LOCK.SLEEP(5);
  select max(uni_item_bala_mov_id) 
      into nuMovimiento
    from open.or_uni_item_bala_mov
    where items_id=nuItemId
    and operating_unit_id=nuUnidad;

   update open.or_uni_item_bala_mov
      set comments =sbCaso
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