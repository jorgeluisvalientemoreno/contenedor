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

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bccontrato.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bccontrato.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_bogestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_bogestion_producto.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3816_Ins_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3816_Ins_homologacion_servicios.sql

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