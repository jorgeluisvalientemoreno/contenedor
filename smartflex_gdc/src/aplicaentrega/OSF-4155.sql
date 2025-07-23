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

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/hora_no_registro_nego.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/hora_no_registro_nego.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/plan_finan_marca.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/plan_finan_marca.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/plan_finan_una_vez.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/plan_finan_una_vez.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/plan_finan_repesca.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/plan_finan_repesca.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/acti_rest_pl_may_pri_neg_cat_1.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/acti_rest_pl_may_pri_neg_cat_1.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/acti_rest_pl_may_pri_neg_cat_2.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/acti_rest_pl_may_pri_neg_cat_2.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/parametros/mensaje_validacion_gcned.sql"
@src/gascaribe/cartera/negociacion-deuda/parametros/mensaje_validacion_gcned.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_bcld_parameter.sql"
@src/gascaribe/atencion-usuarios/exencion/paquetes/personalizaciones.pkg_bcld_parameter.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/ldc_osf_sesucier.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/ldc_osf_sesucier.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_bccierre_comercial.sql"
@src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_bccierre_comercial.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_bccierre_comercial.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_bccierre_comercial.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_ldc_confplcaes.sql"
@src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_ldc_confplcaes.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_ldc_confplcaes.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_ldc_confplcaes.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/ldc_specials_plan.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/ldc_specials_plan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_ldc_specials_plan.sql"
@src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_ldc_specials_plan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_ldc_specials_plan.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_ldc_specials_plan.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_plandife.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_plandife.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_bcsegmentacioncomercial.sql"
@src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_bcsegmentacioncomercial.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_bcsegmentacioncomercial.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_bcsegmentacioncomercial.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/ldc_plfiaplpro.sqll"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/ldc_plfiaplpro.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/package/adm_person.pkg_ldc_plfiaplpro.sql"
@src/gascaribe/cartera/negociacion-deuda/package/adm_person.pkg_ldc_plfiaplpro.sql

prompt "Aplicando  src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.pkg_ldc_plfiaplpro.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.pkg_ldc_plfiaplpro.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_bosegmentacioncomercial.sql"
@src/gascaribe/cartera/negociacion-deuda/package/personalizaciones.pkg_bosegmentacioncomercial.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_bosegmentacioncomercial.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/personalizaciones.pkg_bosegmentacioncomercial.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql

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