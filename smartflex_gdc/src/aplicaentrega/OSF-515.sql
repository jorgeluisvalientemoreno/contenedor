column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/cartera/impedimentos/procedimientos/ldc_validaimpedimentos.sql"
@src/gascaribe/cartera/impedimentos/procedimientos/ldc_validaimpedimentos.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_52115.sql"
@src/gascaribe/fwcob/GE_OBJECT_52115.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_52334.sql"
@src/gascaribe/fwcob/GE_OBJECT_52334.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100333.sql"
@src/gascaribe/tramites/ps_package_type_100333.sql

prompt "Aplicando src/gascaribe/tramites/ps_package_type_100240.sql"
@src/gascaribe/tramites/ps_package_type_100240.sql

prompt "Aplicando src/gascaribe/reglas/ActualizaRegla_LDC_RECONEXION_GAS_CARIBE.sql"
@src/gascaribe/reglas/ActualizaRegla_LDC_RECONEXION_GAS_CARIBE.sql

prompt "Aplicando src/gascaribe/cartera/reconexiones/procedimientos/revreconproduct.sql"
@src/gascaribe/cartera/reconexiones/procedimientos/revreconproduct.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/