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

prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.empresa.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.empresa.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4268_act_empresa_organizacion_venta.sql"
@src/gascaribe/datafix/OSF-4268_act_empresa_organizacion_venta.sql

prompt "Aplicando src/gascaribe/multiempresa/vista/vw_contratista.sql"
@src/gascaribe/multiempresa/vista/vw_contratista.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcea/vw_contratista.sql"
@src/gascaribe/multiempresa/fwcea/vw_contratista.sql

prompt "Aplicando src/gascaribe/multiempresa/vista/vw_base_admin.sql"
@src/gascaribe/multiempresa/vista/vw_base_admin.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcea/vw_base_admin.sql"
@src/gascaribe/multiempresa/fwcea/vw_base_admin.sql

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