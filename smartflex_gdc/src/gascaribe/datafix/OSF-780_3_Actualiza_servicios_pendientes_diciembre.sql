column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  -- CEBE 4158
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = (l.interna + l.carg_x_conex + l.cert_previa) * -1 
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (189354989)
    and l.ingreso_report = 0;
  --
  commit;
  --
  -- CEBE 4101
  update open.LDC_OSF_SERV_PENDIENTE l
    set l.ingreso_report = 4255572 * -1 
  where l.nuano = 2022
    and l.numes in (12)
    and l.solicitud in (180095740)
    and l.interna > 0;
  --
  commit;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/