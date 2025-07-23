column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  -- Actualizo saldo de items en bodega 799
  UPDATE conssesu set cossflli ='N', 
                    cosscons = null
  WHERE rowid in ('ACAq59AFzAAIBijAAt','ACAq59AFzAAICNBAAD','ACAq59AFzAAIBT2AAp','ACAq59AFzAAIBSDAAa');

commit;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/