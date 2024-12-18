column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SN-602');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/reconexiones/parametros/tipo_sus_reconec_cambio_estado.sql"
@src/gascaribe/reconexiones/parametros/tipo_sus_reconec_cambio_estado.sql

prompt "Aplicando src/gascaribe/reconexiones/procedimientos/ldc_cambio_estado_prod.sql"
@src/gascaribe/reconexiones/procedimientos/ldc_cambio_estado_prod.sql

prompt "Aplicando src/gascaribe/datafix/SN-602_crear_tipo_suspension.sql"
@src/gascaribe/datafix/SN-602_crear_tipo_suspension.sql




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