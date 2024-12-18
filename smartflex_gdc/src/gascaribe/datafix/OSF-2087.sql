column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
execute dbms_application_info.set_action('APLICANDO DATAFIX');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

begin
  update pr_product set product_status_id =3, retire_date= sysdate where product_id in (52721092, 52721097, 52740020 );
  update servsusc   set sesuesco = 92, sesufere=sysdate where sesunuse in (52721092, 52721097, 52740020 );
  update pr_component set component_status_id = 9 where product_id in (52721092, 52721097, 52740020 );
  update compsesu   set cmssescm = 9, cmssfere = sysdate where cmsssesu in (52721092, 52721097, 52740020 );
  commit;
end;
/

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
set serveroutput off
quit
/