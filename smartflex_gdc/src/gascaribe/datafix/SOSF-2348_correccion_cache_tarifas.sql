column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

declare
  nuExiste number;
begin

  delete ta_indetabu 
  where intainde= '547-|41|2|1'
  and intataco=1942;
  dbms_output.put_line('Registro eliminado correctamente');
  commit;

  select count(1)
    into nuExiste
    from open.ta_indetabu
  where intataco=2568
    and intainde='547-|41|2|1';
  if nuExiste = 0 then
    insert into ta_indetabu(intainde, intataco) values('547-|41|2|1',2568);
    commit;
    dbms_output.put_line('Registro insertado correctamente');
  else
    dbms_output.put_line('Ya existe el registro');
  end if;
Exception 
 When others then 
    rollback;
    dbms_output.put_line('Error: '||sqlerrm);
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/