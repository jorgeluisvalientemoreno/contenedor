column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-3440"
prompt "------------------------------------------------------"


prompt "Aplicando @src/gascaribe/ventas/paquetes/ldc_asigdircontructoras.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_asigdircontructoras.sql
show errors;

prompt "@src/gascaribe/gestion-ordenes/paquetes/ldc_bogenorapoadic.sql"
@src/gascaribe/gestion-ordenes/paquetes/ldc_bogenorapoadic.sql
show errors;

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/