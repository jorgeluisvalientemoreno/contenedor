column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3755"
prompt "-----------------"


prompt "-----PARAMETROS-----" 
prompt "--->Creacion parametro causales_flag_validate"
@src/gascaribe/general/parametros/causales_flag_validate.sql

prompt "--->Creacion parametro tipo_solicitud_flag_validate"
@src/gascaribe/general/parametros/tipo_solicitud_flag_validate.sql

prompt "--->Creacion parametro tipo_unidad_flag_validate"
@src/gascaribe/general/parametros/tipo_unidad_flag_validate.sql

prompt "--->Creacion parametro tipo_sol_permitida_interaccion"
@src/gascaribe/general/parametros/tipo_sol_permitida_interaccion.sql

prompt "--->Creacion parametro med_rec_envio_respuesta_electronica"
@src/gascaribe/general/parametros/med_rec_envio_respuesta_electronica.sql


prompt "-----PROCESOS-----" 

prompt "--->Aplicando borrado LD_BORTAINTERACCION"
@src/gascaribe/atencion-usuarios/interaccion/paquetes/ld_bortainteraccion.sql


prompt "-----PAQUETES-----" 
prompt "--->Aplicando creacion PKG_BCSOLICITUD_INTERACCION"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bcsolicitud_interaccion.sql

prompt "--->Aplicando creacion sinonimo PKG_BCSOLICITUD_INTERACCION"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bcsolicitud_interaccion.sql


prompt "--->Aplicando creacion PKG_BOSOLICITUD_INTERACCION"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bosolicitud_interaccion.sql

prompt "--->Aplicando creacion sinonimo PKG_BCSOLICITUD_INTERACCION"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bosolicitud_interaccion.sql


prompt "--->Aplicando creacion PKG_UISOLICITUD_INTERACCION"
@src/gascaribe/general/paquetes/pkg_uisolicitud_interaccion.sql

prompt "--->Aplicando creacion sinonimo PKG_UISOLICITUD_INTERACCION"
@src/gascaribe/general/sinonimos/pkg_uisolicitud_interaccion.sql


prompt "-----CONFIGURACION OSF-----" 

prompt "--->Aplicando creacion GE_OBJECT_121722"
@src/gascaribe/fwcob/ge_object_121722.sql

prompt "--->Aplicando creacion WF_UNIT_TYPE_19"
@src/gascaribe/flujos/WF_UNIT_TYPE_19.sql

prompt "--->Aplicando creacion PS_PACKAGE_TYPE_268"
@src/gascaribe/tramites/ps_package_type_268.sql

prompt "--->Aplicando creacion Regla 121396069"
@src/gascaribe/reglas/121396069.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-3755-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on