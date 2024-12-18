column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX 592');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='J-9397-14';
	nuItemSeri	number:= 2155715;
	nuItemId	number:=10007051;
	nuUnidad	number:=1927;
	sbCaso		varchar2(100):='SOSF-592';
	nuCantidad 	number:=-1;
	nuValor		number:=-5655000;
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

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
	    set comments =sbCaso,
			id_items_seriado= nuItemSeri
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