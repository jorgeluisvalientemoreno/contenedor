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

prompt "Aplicando src/gascaribe/gestion-ordenes/configuracion-objeto-accion/proceso_negocio.gestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/configuracion-objeto-accion/proceso_negocio.gestion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/parametros/personalizaciones.persona_legaliza_cartera.sql"
@src/gascaribe/gestion-ordenes/parametros/personalizaciones.persona_legaliza_cartera.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_pkordenes.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkordenes.sql

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