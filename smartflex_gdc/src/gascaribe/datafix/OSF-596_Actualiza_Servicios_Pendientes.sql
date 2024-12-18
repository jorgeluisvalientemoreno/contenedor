column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = interna
 where l.nuano = 2022
   and l.numes = 8
   and l.solicitud = 185393680;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.ingreso_report + 12000000
 where l.nuano = 2022
   and l.numes = 8
   and l.solicitud = 127108533
   and l.interna > 0;
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.ingreso_report * -1
 where l.nuano = 2022
   and l.numes = 8
   and l.solicitud = 10660546
   and l.ingreso_report > 0;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.ingreso_report * -1
 where l.nuano = 2022
   and l.numes = 8
   and l.solicitud = 10646563
   and l.ingreso_report > 0;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.ingreso_report * -1
 where l.nuano = 2022
   and l.numes = 8
   and l.solicitud = 10653538
   and l.ingreso_report > 0;
--
commit;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/