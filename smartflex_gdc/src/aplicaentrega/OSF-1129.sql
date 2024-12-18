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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_boorderactivities.sql"
@src/gascaribe/objetos-producto/sinonimos/or_boorderactivities.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_component.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_component.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_motive.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_motive.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/suscripc.sql"
@src/gascaribe/objetos-producto/sinonimos/suscripc.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/servsusc.sql"
@src/gascaribe/objetos-producto/sinonimos/servsusc.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_packages.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_packages.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_subscriber.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_subscriber.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ab_segments.sql"
@src/gascaribe/objetos-producto/sinonimos/ab_segments.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ab_address.sql"
@src/gascaribe/objetos-producto/sinonimos/ab_address.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_items.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_items.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_boorderactivities.sql"
@src/gascaribe/objetos-producto/sinonimos/or_boorderactivities.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/api/adm_person.api_createorder.sql"
@src/gascaribe/gestion-ordenes/api/adm_person.api_createorder.sql

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