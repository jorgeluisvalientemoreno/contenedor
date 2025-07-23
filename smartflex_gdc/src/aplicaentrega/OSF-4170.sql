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

prompt "Aplicando src/gascaribe/cartera/parametros/estacort_no_permi_castigo.sql"
@src/gascaribe/cartera/parametros/estacort_no_permi_castigo.sql

prompt "Aplicando src/gascaribe/cartera/parametros/estprod_no_permi_castigo.sql"
@src/gascaribe/cartera/parametros/estprod_no_permi_castigo.sql

prompt "Aplicando src/gascaribe/cartera/parametros/tipoprod_val_estprod_inclu.sql"
@src/gascaribe/cartera/parametros/tipoprod_val_estprod_inclu.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/ldc_usu_eva_cast.sql"
@src/gascaribe/cartera/sinonimo/ldc_usu_eva_cast.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/personalizaciones.pkg_bcinclusioncastigocartera.sql"
@src/gascaribe/cartera/paquetes/personalizaciones.pkg_bcinclusioncastigocartera.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/personalizaciones.pkg_bcinclusioncastigocartera.sql"
@src/gascaribe/cartera/sinonimo/personalizaciones.pkg_bcinclusioncastigocartera.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/gc_prodprca.sql"
@src/gascaribe/cartera/sinonimo/gc_prodprca.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/personalizaciones.pkg_boinclusioncastigocartera.sql"
@src/gascaribe/cartera/paquetes/personalizaciones.pkg_boinclusioncastigocartera.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/personalizaciones.pkg_boinclusioncastigocartera.sql"
@src/gascaribe/cartera/sinonimo/personalizaciones.pkg_boinclusioncastigocartera.sql

prompt "Aplicando src/gascaribe/cartera/fwcpb/ldc_procinclumas.sql"
@src/gascaribe/cartera/fwcpb/ldc_procinclumas.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/pkg_uildc_procinclumas.sql"
@src/gascaribe/cartera/paquetes/pkg_uildc_procinclumas.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/pkg_uildc_procinclumas.sql"
@src/gascaribe/cartera/sinonimo/pkg_uildc_procinclumas.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.gdo_reporteconsumos.sql"
@src/gascaribe/general/paquetes/adm_person.gdo_reporteconsumos.sql

prompt "Aplicando src/gascaribe/cartera/fwcpb/ldc_procinclumas.sql"
@src/gascaribe/cartera/fwcpb/ldc_procinclumas.sql

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