column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO DATAFIX SOSF-1835');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
	nuMovimiento number;
--	sbSerial 	varchar2(100):='F-6617021-2009';
--	nuItemSeri	number:= 1942789;
	nuItemId	number:=10004070;
	nuUnidad	number:=3207;
	sbCaso		varchar2(100):='SOSF-1835';
	nuCantidad 	number:=-1;
	nuValor		number:=-66443.16;
    nuconta     number:= 1;
   
   cursor cu_serie is 
     select *
       from ge_items_seriado
      where serie in ('F-6617021-2009','F-6617221-2009','F-6617321-2009')
     and id_items_seriado in (1942789,1944805,1942549);

begin
for reg in cu_serie loop

  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie = reg.serie
     and id_items_seriado = reg.id_items_seriado;

   if nuConta = 3 then 
     nuValor := nuValor - 0.02;
   end if;
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
			id_items_seriado= reg.id_items_seriado
	   where uni_item_bala_mov_id=nuMovimiento;
	   
	  commit;
      nuConta := nuConta +1;

end loop;      
exception
  when others then
	rollback;
	dbms_output.put_line('Error: '||sqlerrm);
end;
/
declare
	nuMovimiento number;
	nuItemId	number:=10000113;
	nuUnidad	number:=3206;
	sbCaso		varchar2(100):='SOSF-1835';
	nuCantidad 	number:=-3;
	nuValor		number:=-0.01;
begin
 
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
declare
	nuMovimiento number;
	nuItemId	number:=10000113;
	nuUnidad	number:=3207;
	sbCaso		varchar2(100):='SOSF-1835';
	nuCantidad 	number:=-3;
	nuValor		number:=-3508;
begin
 
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
declare
	nuMovimiento number;
	nuItemId	number:=10000114;
	nuUnidad	number:=3207;
	sbCaso		varchar2(100):='SOSF-1835';
	nuCantidad 	number:=-3;
	nuValor		number:=-4425;
begin
 
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