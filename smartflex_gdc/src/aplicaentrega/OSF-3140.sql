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

prompt "@src/gascaribe/general/tablas/personalizaciones.parametros.sql"
@src/gascaribe/general/tablas/personalizaciones.parametros.sql

prompt "@src/gascaribe/general/sinonimos/personalizaciones.parametros.sql"
@src/gascaribe/general/sinonimos/personalizaciones.parametros.sql

prompt "@src/gascaribe/general/sinonimos/personalizaciones.proceso_negocio.sql"
@src/gascaribe/general/sinonimos/personalizaciones.proceso_negocio.sql

prompt "@src/gascaribe/general/paquetes/personalizaciones.pkg_parametros.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_parametros.sql

prompt "@src/gascaribe/general/sinonimos/personalizaciones.pkg_parametros.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_parametros.sql

prompt "@src/gascaribe/general/tablas/proceso_negocio.sql"
@src/gascaribe/general/tablas/proceso_negocio.sql

prompt "@src/gascaribe/general/tablas/parametros.sql"
@src/gascaribe/general/tablas/parametros.sql

prompt "@src/gascaribe/general/sinonimos/parametros.sql"
@src/gascaribe/general/sinonimos/parametros.sql

prompt "@src/gascaribe/general/tablas/personalizaciones.log_parametros.sql"
@src/gascaribe/general/tablas/personalizaciones.log_parametros.sql

prompt "@src/gascaribe/general/sinonimos/personalizaciones.pkg_log_parametros.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_log_parametros.sql

prompt "@src/gascaribe/general/framework/fwcea/parametros.sql"
@src/gascaribe/general/framework/fwcea/parametros.sql

prompt "@src/gascaribe/general/framework/fwcea/proceso_negocio.sql"
@src/gascaribe/general/framework/fwcea/proceso_negocio.sql

prompt "@src/gascaribe/general/framework/fwcmd/mdcpgs.sql"
@src/gascaribe/general/framework/fwcmd/mdcpgs.sql

prompt "@src/gascaribe/general/paquetes/personalizaciones.pkg_log_parametros.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_log_parametros.sql

prompt "@src/gascaribe/general/sinonimos/personalizaciones.pkg_log_parametros.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_log_parametros.sql

prompt "@src/gascaribe/general/trigger/personalizaciones.trg_valinfoparametros.sql"
@src/gascaribe/general/trigger/personalizaciones.trg_valinfoparametros.sql

prompt "@src/gascaribe/general/paquetes/adm_person.pkg_parametros.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_parametros.sql

prompt "@src/gascaribe/general/sinonimos/adm_person.pkg_parametros.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_parametros.sql

prompt "@src/gascaribe/general/trigger/trg_valdescprocnegocio.sql"
@src/gascaribe/general/trigger/trg_valdescprocnegocio.sql

prompt "@src/gascaribe/datafix/OSF-3140_inserta_datos_parametros.sql"
@src/gascaribe/datafix/OSF-3140_inserta_datos_parametros.sql

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