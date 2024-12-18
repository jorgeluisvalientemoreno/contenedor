CREATE OR REPLACE procedure ADM_PERSON.LDC_JOB_DELETE_ALL_INSTANCES as
  ini number := 1 ;
  fin number := 100 ;
  num number := 1;
  proc varchar2(1) := 'N' ;
begin
  while num > 0 loop
    select count(1) into num from instances_to_delete_20221104 where id between ini and fin ;
    for instance_rec in ( select id, package_id from instances_to_delete_20221104 where id between ini and fin and procesado = 'N' ) loop
      ldc_delete_wf_instance( instance_rec.package_id, proc );
      update instances_to_delete_20221104 set procesado = proc where id = instance_rec.id ;
    end loop;
    commit;
    ini := ini + 100;
    fin := fin + 100;
  end loop;
end;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_JOB_DELETE_ALL_INSTANCES', 'ADM_PERSON');
END;
/
