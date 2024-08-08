declare
cursor cuInvalidos is
select owner,object_name, 'alter '||decode(object_type,'PACKAGE BODY','PACKAGE',object_type)|| ' ' || owner ||'.'||object_name || ' compile'||decode(object_type,'PACKAGE BODY',' BODY','') COMPILA_OBJETO
  from dba_objects
 where status = 'INVALID'
 and owner in ('OPEN','PERSONALIZACIONES','ADM_PERSON');
begin
  for reg in cuInvalidos loop 
    begin
      execute immediate reg.COMPILA_OBJETO;
    exception 
      when others then
        dbms_output.put_line(reg.owner||'.'||reg.object_name||': '||sqlerrm);
    end;
  end loop;
end;
/
