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

prompt "Aplicando src/gascaribe/predios/tablas/altldc_infro_predio_osf_653.sql"
@src/gascaribe/predios/tablas/altldc_infro_predio_osf_653.sql

prompt "Aplicando src/gascaribe/predios/paquetes/daldc_info_predio.sql"
@src/gascaribe/predios/paquetes/daldc_info_predio.sql

prompt "Aplicando src/gascaribe/predios/fwcea/ldc_info_predio.sql"
@src/gascaribe/predios/fwcea/ldc_info_predio.sql

prompt "Aplicando src/gascaribe/predios/fwcmd/mpzns.sql"
@src/gascaribe/predios/fwcmd/mpzns.sql

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