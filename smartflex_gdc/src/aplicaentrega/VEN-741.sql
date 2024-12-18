column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/servicios-nuevos/plugins/ldci_cre_car_ava_obr_ven_con.sql"
@src/gascaribe/servicios-nuevos/plugins/ldci_cre_car_ava_obr_ven_con.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/plugins/insert_ldc_procedimiento_obj.sql"
@src/gascaribe/servicios-nuevos/plugins/insert_ldc_procedimiento_obj.sql

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
