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

prompt "Aplicando src/gascaribe/datafix/OSF-3897_4_Actualiza_Tarifas.sql"
@src/gascaribe/datafix/OSF-3897_4_Actualiza_Tarifas.sql

prompt "Aplicando src/gascaribe/facturacion/tablas/alter_tmp_producto_procsub.sql"
@src/gascaribe/facturacion/tablas/alter_tmp_producto_procsub.sql

prompt "Aplicando src/gascaribe/facturacion/procedimientos/prc_llenainformacion_produsubs.sql"
@src/gascaribe/facturacion/procedimientos/prc_llenainformacion_produsubs.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3897_job_genera_proceso.sql"
@src/gascaribe/datafix/OSF-3897_job_genera_proceso.sql

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