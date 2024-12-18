column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare

	nuOperating_unit_id	number;
	nummitinte   		number;
	  
	cursor cuItemSeriado is
		select operating_unit_id
		from ge_items_seriado 
		where serie 			= 'J-56179-20'
		and id_items_seriado 	= 2378595;
		
	cursor cuLdciIntemmit is
		select mmitinte
		from LDCI_INTEMMIT 
		where mmitmens like ('%J-56179-20%')
		and mmitcodi = 101804;
		
begin

	dbms_output.put_line('---- Inicio DATAFIX OSF-3585 ----');
	
	IF (cuItemSeriado%ISOPEN) THEN
		CLOSE cuItemSeriado;
	END IF;
	
	OPEN cuItemSeriado;
	FETCH cuItemSeriado INTO nuOperating_unit_id;
	CLOSE cuItemSeriado;
  
	UPDATE ge_items_seriado
	SET operating_unit_id = NULL
	WHERE serie 			= 'J-56179-20'
	AND id_items_seriado 	= 2378595;
	
	dbms_output.put_line('Se actualiza la unidad operativa [' || nuOperating_unit_id || '] por la unidad [] al item seriado J-56179-20');
	
	IF (cuLdciIntemmit%ISOPEN) THEN
		CLOSE cuLdciIntemmit;
	END IF;
	
	OPEN cuLdciIntemmit;
	FETCH cuLdciIntemmit INTO nummitinte;
	CLOSE cuLdciIntemmit;
	
	UPDATE LDCI_INTEMMIT
	SET mmitinte = 0
	WHERE mmitmens like ('%J-56179-20%')
	AND mmitcodi = 101804;
	
	dbms_output.put_line('Se actualiza el numero de intentos de la interfaz de materiales de [' || nummitinte || '] a [0] al item seriado J-56179-20');
	
	commit;
  
	dbms_output.put_line('---- Termina DATAFIX OSF-3585 ----');
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/