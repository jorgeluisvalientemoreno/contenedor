column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0 OSF-1764" 
prompt "------------------------------------------------------"


prompt "Aplicando paquete ldc_pkgeneratramiterp.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgeneratramiterp.sql
show errors; 

prompt "Aplicando sinónimo open.ldc_pkgeneratramiterp.sql"
@src/gascaribe/revision-periodica/sinonimos/open.ldc_pkgeneratramiterp.sql

prompt "Insertando servicio en HOMOLOGACION_SERVICIOS"
@src/gascaribe/datafix/OSF-1764_Ajuste_upd_homologacion_servicios.sql


prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0 OSF-1764"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit