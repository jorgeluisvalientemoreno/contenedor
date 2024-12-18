set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX 585');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
	nuMovimiento number;
	nuItemId	number:=10000114;
	nuUnidad	number:=3117;
	sbCaso		varchar2(100):='SOSF-585';
	nuCantidad	number:=-3;
	nuValor		number:=-680.77;
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