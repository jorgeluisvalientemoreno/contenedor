set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX 584');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;
declare
	nuMovimiento number;
	sbSerial 	varchar2(100):='M-17872243-12';
	nuItemSeri	number:= 1194806;
	sbCaso		varchar2(100):='OSF-1559';
begin
  update ge_items_seriado
     set id_items_estado_inv=17,
	 	 operating_unit_id = null,
		 subscriber_id = null
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