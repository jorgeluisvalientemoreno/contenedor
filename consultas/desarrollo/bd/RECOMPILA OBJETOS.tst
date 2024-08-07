PL/SQL Developer Test script 3.0
27
BEGIN
  FOR cur_rec IN (SELECT owner,
                         object_name,
                         object_type,
                         DECODE(object_type, 'PACKAGE', 1,
                                             'PACKAGE BODY', 2, 2) AS recompile_order
                  FROM   dba_objects
                  WHERE  object_type IN ('PACKAGE', 'PACKAGE BODY')
                  AND    status != 'VALID'
                  AND OWNER='OPEN'
				  AND OBJECT_NAME='LDC_PKINFOAUDITORIA'
                  ORDER BY 4)
  LOOP
    BEGIN
      IF cur_rec.object_type = 'PACKAGE' THEN
        EXECUTE IMMEDIATE 'ALTER ' || cur_rec.object_type || 
            ' "' || cur_rec.owner || '"."' || cur_rec.object_name || '" COMPILE';
      ElSE
        EXECUTE IMMEDIATE 'ALTER PACKAGE "' || cur_rec.owner || 
            '"."' || cur_rec.object_name || '" COMPILE BODY';
      END IF;
    EXCEPTION
      WHEN OTHERS THEN
        DBMS_OUTPUT.put_line(cur_rec.object_type || ' : ' || cur_rec.owner || 
                             ' : ' || cur_rec.object_name);
    END;
  END LOOP;
END;
0
0


select 'alter '||decode(object_type,'PACKAGE BODY','PACKAGE',object_type)|| ' ' || owner ||'.'||object_name || ' compile'||decode(object_type,'PACKAGE BODY',' BODY;',';') COMPILA_OBJETO
  from dba_objects
 where status = 'INVALID';

 begin 
    sys.utl_recomp.recomp_parallel(2);
end;
/


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