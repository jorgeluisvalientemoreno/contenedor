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

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_uni_act_ot.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_uni_act_ot.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_reporte_ofert_escalo.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_reporte_ofert_escalo.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_actas_aplica_proc_ofer.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_actas_aplica_proc_ofer.sql

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