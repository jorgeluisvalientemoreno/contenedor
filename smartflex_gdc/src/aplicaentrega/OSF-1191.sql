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

prompt "Aplicando Bajando Ejecutores"
@src/ejecutores/bajar-ejecutores.sql


prompt "Aplicando src/gascaribe/tipo-producto/SERVICIO_7057.sql"
@src/gascaribe/tipo-producto/SERVICIO_7057.sql


prompt "Aplicando src/gascaribe/nuevas-energias/procedimiento/pr_registerrequestenergy.sql"
@src/gascaribe/nuevas-energias/procedimiento/pr_registerrequestenergy.sql


prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121726.sql"
@src/gascaribe/fwcob/GE_OBJECT_121726.sql



prompt "Aplicando src/gascaribe/tramites/ps_package_type_100316.sql"
@src/gascaribe/tramites/ps_package_type_100316.sql

prompt "Aplicando src/gascaribe/nuevas-energias/plan-comercial/59-energia-solar-residencial.sql"
@src/gascaribe/nuevas-energias/plan-comercial/59-energia-solar-residencial.sql

prompt "Aplicando src/gascaribe/nuevas-energias/plan-comercial/60-energia-solar-no-residencial.sql"
@src/gascaribe/nuevas-energias/plan-comercial/60-energia-solar-no-residencial.sql

prompt "Aplicando src/gascaribe/nuevas-energias/condicion-visualizacion/sa_tab_tramite_100316.sql"
@src/gascaribe/nuevas-energias/condicion-visualizacion/sa_tab_tramite_100316.sql

prompt "Aplicando src/gascaribe/datafix/OSF-1191_configurar_ciclos_servicio_7057.sql"
@src/gascaribe/datafix/OSF-1191_configurar_ciclos_servicio_7057.sql


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