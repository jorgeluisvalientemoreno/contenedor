column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-3612"
prompt "-----------------"


prompt "-----DATAFIX-----" 
prompt "--->Aplicando creacion LOG_DUPLICADO_FACTURAS"
@src/gascaribe/datafix/OSF-3612_diu_homologacion_servicios.sql


prompt "-----FUNCIONES-----" 

prompt "--->Aplicando creacion sinonimo FNUOBTVALORTARIFAVALORFIJO"
@src/gascaribe/general/sinonimos/fnuobtvalortarifavalorfijo.sql

prompt "--->Aplicando creacion FNUOBTVALORTARIFAVALORFIJO"
@src/gascaribe/general/funciones/adm_person.fnuobtvalortarifavalorfijo.sql

prompt "--->Aplicando creacion sinonimo FNUOBTVALORTARIFAVALORFIJO"
@src/gascaribe/general/sinonimos/adm_person.fnuobtvalortarifavalorfijo.sql


prompt "-----PAQUETES-----" 
prompt "--->Aplicando creacion PKG_BOGESTION_INSTANCIAS"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestion_instancias.sql

prompt "--->Aplicando creacion sinonimo PKG_BOGESTION_INSTANCIAS"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestion_instancias.sql


prompt "--->Aplicando creacion sinonimo GE_NOTIFICATION_LOG"
@src/gascaribe/general/sinonimos/ge_notification_log.sql

prompt "--->Aplicando creacion PKG_BOGESTION_NOTIFICACIONES"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestion_notificaciones.sql

prompt "--->Aplicando creacion sinonimo PKG_BOGESTION_NOTIFICACIONES"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestion_notificaciones.sql


prompt "--->Aplicando creacion PKG_GE_NOTIFICATION"
@src/gascaribe/general/paquetes/adm_person.pkg_ge_notification.sql

prompt "--->Aplicando creacion sinonimo PKG_GE_NOTIFICATION"
@src/gascaribe/general/sinonimos/adm_person.pkg_ge_notification.sql


prompt "--->Aplicando creacion PKG_BOGESTIONSOLICITUDES"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestionsolicitudes.sql


prompt "--->Aplicando creacion PKG_OR_ORDER_ITEMS"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_items.sql



prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-3612-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on