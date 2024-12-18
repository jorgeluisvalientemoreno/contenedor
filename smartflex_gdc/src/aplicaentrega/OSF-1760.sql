column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0 OSF-1760" 
prompt "------------------------------------------------------"


prompt "Aplicando paquete pk_ldclodpd.sql"
@src/gascaribe/general/paquetes/pk_ldclodpd.sql
show errors; 


prompt "Aplicando sinónimo open.pk_ldclodpd.sql"
@src/gascaribe/general/sinonimos/open.pk_ldclodpd.sql

prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0 OSF-1760"
prompt "------------------------------------------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit