Declare
	nuExiste number;
	sbSql    varchar2(4000);
	cursor cuExiste is
	select count(1) existe
	from dba_procedures d
	where owner = 'OPEN'
	  and object_name= 'GC_CONTRACTORSCT321E121008842'
	  and not exists( select null from gr_config_expression c where c.object_name=d.object_name)
	  and not exists( select null from dba_dependencies c where c.referenced_owner=d.object_name);
Begin
	open cuExiste;
	fetch cuExiste into nuExiste;
	close cuExiste;
	if nuExiste>0 then
		sbSql := 'drop procedure GC_CONTRACTORSCT321E121008842';
		execute immediate sbSql;
		dbms_output.put_line('GC_CONTRACTORSCT321E121008842'||'|'||'BORRADO CORRECTAMENTE');
	end if;
Exception
	when others then
		dbms_output.put_line('GC_CONTRACTORSCT321E121008842'||'|'||sqlerrm);
End;
/
