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

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_utilzip.sql"
@src/gascaribe/general/sinonimos/ldc_utilzip.sql

prompt "Aplicando src/gascaribe/recaudos/procedimientos/adm_person.generatefiledebitauto.sql"
@src/gascaribe/recaudos/procedimientos/adm_person.generatefiledebitauto.sql

prompt "Aplicando src/gascaribe/general/procedimientos/ldc_export_report_excel.sql"
@src/gascaribe/general/procedimientos/ldc_export_report_excel.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgestordecarta.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgestordecarta.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/adm_person.ldc_pkgestordecarta.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.ldc_pkgestordecarta.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgestordecarta.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgestordecarta.sql

prompt "Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pcompressfile.sql" 
@src/gascaribe/general/procedimientos/ldc_pcompressfile.sql

prompt "Aplicando src/gascaribe/contabilidad/paquetes/ldc_pkvalida_tt_local.sql"
@src/gascaribe/contabilidad/paquetes/ldc_pkvalida_tt_local.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pkvalida_tt_local.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_pkvalida_tt_local.sql

prompt "Aplicando creacion de procedimiento adm_person.ldc_pcompressfile.sql" 
@src/gascaribe/general/procedimientos/adm_person.ldc_pcompressfile.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pcompressfile.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_pcompressfile.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2375_act_obj_mig.sql" 
@src/gascaribe/datafix/OSF-2375_act_obj_mig.sql

prompt "Aplicando src/test/recompilar-objetos.sql" 
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