column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2760"
prompt "-----------------"

prompt "-----procedimiento LDC_PRGENESOLSACRP-----" 
prompt "--->Aplicando creacion sinonimo dependiente procedimiento adm_person.ldc_prgenerecoacrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgenerecoacrp.sql

prompt "--->Aplicando creacion sinonimo dependiente procedimiento adm_person.ldc_actividad_generada.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_actividad_generada.sql

prompt "--->Aplicando creacion sinonimo dependiente procedimiento adm_person.ldc_activi_by_pack_type.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_activi_by_pack_type.sql

prompt "--->Aplicando creacion procedimiento de esquema ADM_PERSON ldc_prgenesolsacrp.sql"
@src/gascaribe/revision-periodica/plugin/ldc_prgenesolsacrp.sql

prompt "--->Aplicando creacion sinonimo procedimiento adm_person.ldc_prgenesolsacrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgenesolsacrp.sql



prompt "-----Script OSF-2760_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2760_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2760-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
