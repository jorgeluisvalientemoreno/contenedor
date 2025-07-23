column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	CURSOR cuProductos
	IS
		select * 
		from elmesesu where emsssesu in (4067426, 2000057, 17009896, 99632, 1999577, 1999595, 1999624, 1116221, 
										 50002109, 50045049, 50081405, 50037908, 1049291, 1063749
										 )
		and emssfere > sysdate;

begin

	dbms_output.put_line('Inicia datafix OSF-4192');
	
	FOR reg IN cuProductos LOOP
	
		dbms_output.put_line('Se actualiza la fecha de retiro del medidor del producto: ' || reg.emsssesu);
		dbms_output.put_line('Se actualiza la fecha de retiro: ' || reg.emssfere || ' por 01/02/2014');
		
		UPDATE elmesesu
		SET emssfere = TO_DATE('01/02/2014')
		WHERE emsssesu	= reg.emsssesu
		AND emsscoem	= reg.emsscoem;
		
		commit;
	
	END LOOP;
	
	dbms_output.put_line('Finaliza datafix OSF-4192');
	
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/