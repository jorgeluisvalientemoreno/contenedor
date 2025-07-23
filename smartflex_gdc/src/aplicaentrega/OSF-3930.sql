column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3930"
prompt "-----------------"

prompt "-----SINONIMOS-----" 

prompt "--->Creacion sinonimo personalizaciones.pkg_bcfmaco"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_reglas_registroquejas.sql


prompt "-----OBJETOS-----" 

prompt "--->Creacion sinonimo personalizaciones.pkg_bcfmaco"
@src/gascaribe/atencion-usuarios/paquetes/pkg_reglas_registroquejas.sql


prompt "-----PARAMETROS-----" 

prompt "--->Creacion parametro direc_respuesta_regis_quejas"
@src/gascaribe/atencion-usuarios/parametros/direc_respuesta_regis_quejas.sql


prompt "-----PSCRE-----" 
@src/gascaribe/tramites/ps_package_type_100030.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-3930-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on