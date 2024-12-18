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

prompt "Aplicando src/gascaribe/datafix/OSF-2579_genera_saldo_a_favor_L2_abril_4.sql"
@src/gascaribe/datafix/OSF-2579_genera_saldo_a_favor_L2_abril_4.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2579_reconstruye_PA_mal_aplicados_abril_4.sql"
@src/gascaribe/datafix/OSF-2579_reconstruye_PA_mal_aplicados_abril_4.sql

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