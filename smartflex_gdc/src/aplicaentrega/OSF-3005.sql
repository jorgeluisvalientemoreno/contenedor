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

prompt "Aplicando src/gascaribe/general/sinonimos/ct_order_certifica.sql"
@src/gascaribe/general/sinonimos/ct_order_certifica.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_acta.sql"
@src/gascaribe/general/sinonimos/ge_acta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_actas_aplica_proc_ofert.sql"
@src/gascaribe/general/sinonimos/ldc_actas_aplica_proc_ofert.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_reporte_ofert_escalo.sql"
@src/gascaribe/general/sinonimos/ldc_reporte_ofert_escalo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_uni_act_ot.sql"
@src/gascaribe/general/sinonimos/ldc_uni_act_ot.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_generapaqueten1.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_generapaqueten1.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_generapaqueten1.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_generapaqueten1.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ct_order_certifica.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ct_order_certifica.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ct_order_certifica.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ct_order_certifica.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ge_acta.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ge_acta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ge_acta.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ge_acta.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_actas_aplica_proc_ofer.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_actas_aplica_proc_ofer.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_actas_aplica_proc_ofer.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_actas_aplica_proc_ofer.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_reporte_ofert_escalo.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_reporte_ofert_escalo.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_reporte_ofert_escalo.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_reporte_ofert_escalo.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_uni_act_ot.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_uni_act_ot.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_uni_act_ot.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_uni_act_ot.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_or_related_order.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_or_related_order.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_or_related_order.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_or_related_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_activity.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_activity.sql

prompt "Ejecutando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql

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