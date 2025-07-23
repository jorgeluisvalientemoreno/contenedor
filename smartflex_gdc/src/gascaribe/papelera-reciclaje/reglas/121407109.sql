Declare
	
	nuExiste number;
	sbSql    varchar2(4000);
	
	cursor cuExiste 
	is
		select count(1) existe
		from dba_objects d
		where owner = 'OPEN'
		and object_name= 'MO_VALIDATTR_CT26E121407109';
Begin

	dbms_output.put_line('Inicia borrado MO_VALIDATTR_CT26E121407109');
	
	open cuExiste;
	fetch cuExiste into nuExiste;
	close cuExiste;
	
	if nuExiste > 0 then
		
		delete from gr_config_expression 
		where object_name = 'MO_VALIDATTR_CT26E121407109';		
		
		sbSql := 'drop procedure MO_VALIDATTR_CT26E121407109';
		execute immediate sbSql;
		
		COMMIT;
		
		dbms_output.put_line('MO_VALIDATTR_CT26E121407109'||'|'||'BORRADO CORRECTAMENTE');
	else
		dbms_output.put_line('MO_VALIDATTR_CT26E121407109 no existe');
		ROLLBACK;
	end if;
	
	dbms_output.put_line('Finaliza borrado MO_VALIDATTR_CT26E121407109');
	
Exception
	when others then
		ROLLBACK;
		dbms_output.put_line('MO_VALIDATTR_CT26E121407109'||'|'||sqlerrm);
End;
/
