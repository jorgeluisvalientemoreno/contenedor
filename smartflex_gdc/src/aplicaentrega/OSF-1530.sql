column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-1530');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/cod_soliinnova_act_estacort.sql"
@src/gascaribe/servicios-nuevos/parametros/cod_soliinnova_act_estacort.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/cod_usuario_activa_estacort.sql"
@src/gascaribe/servicios-nuevos/parametros/cod_usuario_activa_estacort.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/compsesu.sql"
@src/gascaribe/objetos-producto/sinonimos/compsesu.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/procedimientos/personalizaciones.oal_activaproducto.sql"
@src/gascaribe/servicios-nuevos/procedimientos/personalizaciones.oal_activaproducto.sql


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