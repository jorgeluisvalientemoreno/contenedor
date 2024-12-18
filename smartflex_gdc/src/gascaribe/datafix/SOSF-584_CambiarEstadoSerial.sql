set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX 584');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='J-R000009064 ';
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