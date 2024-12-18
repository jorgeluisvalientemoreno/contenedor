column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin

delete open.LDC_OSF_SERV_PENDIENTE l
 where l.nuano = 2022
   and l.numes in (9)
   and l.solicitud in (185596665,190147145,188723076,184078434,180096702,190546173,185890574,185890574,186304647);
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = -2480000
 where l.nuano = 2022
   and l.numes in (9)
   and l.product_id = 52234396;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = -216000000
 where l.nuano = 2022
   and l.numes in (9)
   and l.product_id = 51953263
   and l.interna > 0;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = l.ingreso_report * -1
 where l.nuano = 2022
   and l.numes in (9)
   and l.product_id = 50737317
   and l.ingreso_report > 0;
--
commit;
--
update open.LDC_OSF_SERV_PENDIENTE l
   set l.ingreso_report = -59280000
 where l.nuano = 2022
   and l.numes in (9)
   and l.solicitud in (185409327)
   and l.Interna > 0;
--
commit;

end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/