set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX 584');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='J-R000009064';
	nuItemSeri	number:= 2059037;
	nuItemId	number:=10006967;
	nuUnidad	number:=2326;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-369676.11
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-369676.11
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

declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='J-R000011452';
	nuItemSeri	number:= 2059038;
	nuItemId	number:=10006967;
	nuUnidad	number:=2326;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-369676.12
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-369676.12
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

declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='O-75106744-11';
	nuItemSeri	number:= 1966797;
	nuItemId	number:=10000608;
	nuUnidad	number:=3006;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-4256583
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-4256583
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


declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='IT-3401094199-12';
	nuItemSeri	number:= 1991145;
	nuItemId	number:=10003862;
	nuUnidad	number:=3006;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-3237498
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-3237498
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

declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='O-1300886-13';
	nuItemSeri	number:= 1953961;
	nuItemId	number:=10004148;
	nuUnidad	number:=3007;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-7971289
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-7971289
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

declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='SH-21057834-19';
	nuItemSeri	number:= 2278859;
	nuItemId	number:=10004070;
	nuUnidad	number:=3020;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-63235.48
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-63235.48
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
declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='SH-21160386-19';
	nuItemSeri	number:= 2325361;
	nuItemId	number:=10004070;
	nuUnidad	number:=3020;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-63235.48
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-63235.48
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
declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='SH-21022280-19';
	nuItemSeri	number:= 2268737;
	nuItemId	number:=10004070;
	nuUnidad	number:=3020;
	sbCaso		varchar2(100):='SOSF-584';
begin
  update ge_items_seriado
     set id_items_estado_inv=8,
	 	 operating_unit_id = null
   where serie=sbSerial
     and id_items_seriado=nuItemSeri;

   update or_ope_uni_item_bala
      set balance=balance-1,
	  	  total_costs=total_costs-63235.48
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-1,
        total_costs=total_costs-63235.48
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
declare
	nuMovimiento number;
	nuItemId	number:=10000113;
	nuUnidad	number:=3020;
	sbCaso		varchar2(100):='SOSF-584';
begin
  

   update or_ope_uni_item_bala
      set balance=balance-91,
	  	  total_costs=total_costs-40729.24
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-91,
        total_costs=total_costs-40729.24
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
	nuUnidad	number:=3020;
	sbCaso		varchar2(100):='SOSF-584';
begin
  

   update or_ope_uni_item_bala
      set balance=balance-77,
	  	  total_costs=total_costs-44706.50
	where items_id=nuItemId
	  and operating_unit_id=nuUnidad;


	update ldc_inv_ouib
  set balance=balance-77,
        total_costs=total_costs-44706.50
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