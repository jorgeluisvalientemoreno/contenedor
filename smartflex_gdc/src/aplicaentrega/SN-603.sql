column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO TRG_RESTRICT_LEGALIZA_SERVNUEV');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"
prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_LEGALIZA_SERVNUEV.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_LEGALIZA_SERVNUEV.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_OR_ORDER_CXC.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_OR_ORDER_CXC.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_CXC_CERTIFICADO.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_CXC_CERTIFICADO.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/parametro/trg_restrict_legaliza_servnuev.sql"
@src/gascaribe/servicios-nuevos/parametro/trg_restrict_legaliza_servnuev.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/