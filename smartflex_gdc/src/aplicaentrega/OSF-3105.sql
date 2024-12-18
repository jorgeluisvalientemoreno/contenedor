column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3105"
prompt "-----------------"

prompt "-----paquete PKG_FE_VALIDACION_IDENTIFICA-----" 

prompt "--->Aplicando creacion de paquete pkg_fe_validacion_identifica.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.pkg_fe_validacion_identifica.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete pkg_fe_validacion_identifica.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkg_fe_validacion_identifica.sql


prompt "-----paquete FSBVALIDARIDENTIFICACION-----" 

prompt "--->Aplicando creacion de paquete fsbvalidaridentificacion.sql"
@src/gascaribe/atencion-usuarios/funciones/personalizaciones.fsbvalidaridentificacion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete fsbvalidaridentificacion.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.fsbvalidaridentificacion.sql


prompt "-----parametro TIPOS_IDENT_NUMERICAS-----" 

prompt "--->Aplicando creacion parametro TIPOS_IDENT_NUMERICAS"
@src/gascaribe/atencion-usuarios/parametros/tipos_ident_numericas.sql


prompt "-----trigger TRG_VALIDA_IDENT_CLIENTE-----" 

prompt "--->Aplicando creacion de trigger trg_valida_ident_cliente.sql"
@src/gascaribe/atencion-usuarios/triggers/personalizaciones.trg_valida_ident_cliente.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-3105-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

