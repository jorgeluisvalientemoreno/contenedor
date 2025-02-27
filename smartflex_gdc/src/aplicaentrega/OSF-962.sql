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

prompt "Aplicando src/gascaribe/revision-periodica/parametros/procautoreco_sn.sql"
@src/gascaribe/revision-periodica/parametros/procautoreco_sn.sql

prompt "Aplicando src/gascaribe/revision-periodica/parametros/tolerancia_dife_autorecone_sn.sql"
@src/gascaribe/revision-periodica/parametros/tolerancia_dife_autorecone_sn.sql

prompt "Aplicando src/gascaribe/revision-periodica/tablas/ldc_susp_autoreco.sql"
@src/gascaribe/revision-periodica/tablas/ldc_susp_autoreco.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgeneordeautoreco.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgeneordeautoreco.sql

prompt "Aplicando src/gascaribe/revision-periodica/fwcgr/gopc.sql"
@src/gascaribe/revision-periodica/fwcgr/gopc.sql

prompt "Aplicando src/gascaribe/revision-periodica/vistas/vw_consulta_autoreconectadossn.sql"
@src/gascaribe/revision-periodica/vistas/vw_consulta_autoreconectadossn.sql

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