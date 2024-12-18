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


prompt "src/gascaribe/general/tablas/personalizaciones.homologacion_servicios.sql"
@src/gascaribe/general/tablas/personalizaciones.homologacion_servicios.sql

prompt "src/gascaribe/general/sql/personalizaciones.idx_con01homol_servicios.sql"
@src/gascaribe/general/sql/personalizaciones.idx_con01homol_servicios.sql

prompt "src/gascaribe/general/sql/personalizaciones.idx_con01homol_servicios.sql"
@src/gascaribe/general/sql/personalizaciones.idx_con02homol_servicios.sql

prompt "src/gascaribe/general/sinonimos/personalizaciones.homologacion_servicios.sql"
@src/gascaribe/general/sinonimos/personalizaciones.homologacion_servicios.sql

prompt "src/gascaribe/datafix/OSF-1752_InsertDatosHomologacionServicios.sql"
@src/gascaribe/datafix/OSF-1752_InsertDatosHomologacionServicios.sql


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