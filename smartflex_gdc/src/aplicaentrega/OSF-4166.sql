column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.cc_com_seg_plan.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_com_seg_plan.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.cc_com_seg_prom.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_com_seg_prom.sql 

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.cc_tipo_scoring.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_tipo_scoring.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ge_wage_scale.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ge_wage_scale.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_com_seg_fea_val.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_com_seg_fea_val.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_com_seg_finan.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_com_seg_finan.sql

prompt "Aplicando ssrc/gascaribe/general/sinonimos/adm_person.cc_commercial_segm.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_commercial_segm.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_subscriber_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_subscriber_type.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.cc_bscommercialsegm.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_bscommercialsegm.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.estafina.sql"
@src/gascaribe/cartera/sinonimo/adm_person.estafina.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_bogestion_segmentacion.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_bogestion_segmentacion.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_bogestion_segmentacion.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_bogestion_segmentacion.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4166_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-4166_homologacion_servicios.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/