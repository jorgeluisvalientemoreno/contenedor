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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_loadaccept_items.sql"
@src/gascaribe/objetos-producto/sinonimos/os_loadaccept_items.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/os_setcustworkdata.sql"
@src/gascaribe/objetos-producto/sinonimos/os_setcustworkdata.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_attendfinanrequest.sql"
@src/gascaribe/objetos-producto/sinonimos/os_attendfinanrequest.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_addrequestaddress.sql"
@src/gascaribe/objetos-producto/sinonimos/os_addrequestaddress.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_registernewcharge.sql"
@src/gascaribe/objetos-producto/sinonimos/os_registernewcharge.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_register_ntl.sql"
@src/gascaribe/objetos-producto/sinonimos/os_register_ntl.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_getperiodrevmaxdate.sql"
@src/gascaribe/objetos-producto/sinonimos/os_getperiodrevmaxdate.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_upditempatt.sql"
@src/gascaribe/objetos-producto/sinonimos/os_upditempatt.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_pegencontractobligat.sql"
@src/gascaribe/objetos-producto/sinonimos/os_pegencontractobligat.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_queryproddebtbyconc.sql"
@src/gascaribe/objetos-producto/sinonimos/os_queryproddebtbyconc.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_additemsorder.sql"
@src/gascaribe/objetos-producto/sinonimos/os_additemsorder.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_upditempatt.sql"
@src/gascaribe/objetos-producto/sinonimos/os_upditempatt.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/os_setcommercialsegment.sql"
@src/gascaribe/objetos-producto/sinonimos/os_setcommercialsegment.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/api/adm_person.api_additemsorder.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_additemsorder.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/api/adm_person.api_loadaccept_items.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_loadaccept_items.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/api/adm_person.api_upditempatt.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_upditempatt.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_additemsorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_additemsorder.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_loadaccept_items.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_loadaccept_items.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_upditempatt.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.api_upditempatt.sql

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