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

prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_inscert.sql"
@src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_inscert.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/tabla/alt_ldc_plazos_cert_id_producto.sql"
@src/gascaribe/revision-periodica/plazos/tabla/alt_ldc_plazos_cert_id_producto.sql

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