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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_packages_asso.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_packages_asso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/parametro/tipo_solicitud_valida_interaccion.sql"
@src/gascaribe/atencion-usuarios/reclamos/parametro/tipo_solicitud_valida_interaccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/parametro/medio_recepcion_valida_interaccion.sql"
@src/gascaribe/atencion-usuarios/reclamos/parametro/medio_recepcion_valida_interaccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/funciones/personalizaciones.fnu_InteraccionConReclamo.sql"
@src/gascaribe/atencion-usuarios/reclamos/funciones/personalizaciones.fnu_InteraccionConReclamo.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/sinonimos/personalizaciones.fnu_InteraccionConReclamo.sql"
@src/gascaribe/atencion-usuarios/reclamos/sinonimos/personalizaciones.fnu_InteraccionConReclamo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/funciones/fnu_uiinteraccionconreclamo.sql"
@src/gascaribe/atencion-usuarios/reclamos/funciones/fnu_uiinteraccionconreclamo.sql
show errors;

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/sinonimos/fnu_uiinteraccionconreclamo.sql"
@src/gascaribe/atencion-usuarios/reclamos/sinonimos/fnu_uiinteraccionconreclamo.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/reclamos/fwcob/ge_object_121755.sql"
@src/gascaribe/atencion-usuarios/reclamos/fwcob/ge_object_121755.sql

prompt "Aplicando src/gascaribe/flujos/WF_UNIT_TYPE_19.sql"
@src/gascaribe/flujos/WF_UNIT_TYPE_19.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit