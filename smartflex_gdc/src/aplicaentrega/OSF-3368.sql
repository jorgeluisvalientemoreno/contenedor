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

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_asigna_unidad_rev_per.sql"
@src/gascaribe/general/sinonimos/ldc_asigna_unidad_rev_per.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_marca_producto.sql"
@src/gascaribe/general/sinonimos/ldc_marca_producto.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_asigna_unidad_rev_per.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_asigna_unidad_rev_per.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_asigna_unidad_rev_per.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_asigna_unidad_rev_per.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/personalizaciones.pkg_boasigna_unidad_rev_per.sql"
@src/gascaribe/revision-periodica/paquetes/personalizaciones.pkg_boasigna_unidad_rev_per.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/personalizaciones.pkg_boasigna_unidad_rev_per.sql"
@src/gascaribe/revision-periodica/sinonimos/personalizaciones.pkg_boasigna_unidad_rev_per.sql

prompt "Aplicando src/gascaribe/revision-periodica/procedimientos/prreglabuscaunidadreparaciones.sql"
@src/gascaribe/revision-periodica/procedimientos/prreglabuscaunidadreparaciones.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121763.sql"
@src/gascaribe/fwcob/GE_OBJECT_121763.sql

prompt "Aplicando src/gascaribe/reglas/121386275.sql"
@src/gascaribe/reglas/121386275.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/tablas/idx_ldc_asigna_unidad_rev_p_01.sql"
@src/gascaribe/revision-periodica/certificados/tablas/idx_ldc_asigna_unidad_rev_p_01.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/trg_ult_ot_rp.sql"
@src/gascaribe/revision-periodica/triggers/trg_ult_ot_rp.sql

-- Se entrega el export PS_PACKAGE_TYPE_100294.sql pero no se aplica

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