Declare
	nuExiste number;
	sbSql    varchar2(4000);
	cursor cuExiste is
	select count(1) existe
	from dba_procedures d
	where owner = 'OPEN'
	  and object_name= 'CC_POL_BRILLA_CT585E121007390'
	  and not exists( select null from gr_config_expression c where c.object_name=d.object_name)
	  and not exists( select null from dba_dependencies c where c.referenced_owner=d.object_name);
Begin
	open cuExiste;
	fetch cuExiste into nuExiste;
	close cuExiste;
	if nuExiste>0 then
		sbSql := 'drop procedure CC_POL_BRILLA_CT585E121007390';
		execute immediate sbSql;
		dbms_output.put_line('CC_POL_BRILLA_CT585E121007390'||'|'||'BORRADO CORRECTAMENTE');
	end if;
Exception
	when others then
		dbms_output.put_line('CC_POL_BRILLA_CT585E121007390'||'|'||sqlerrm);
End;
/
