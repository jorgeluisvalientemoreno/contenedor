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

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/valida_categ_cambio_uso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/valida_categ_cambio_uso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/subcategoria_inicial_orden_registro_cambio_uso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/parametros/subcategoria_inicial_orden_registro_cambio_uso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/personalizaciones.pkg_bocambio_de_uso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/paquetes/personalizaciones.pkg_bocambio_de_uso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/sinonimos/personalizaciones.pkg_bocambio_de_uso.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/sinonimos/personalizaciones.pkg_bocambio_de_uso.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/prcreglainiatractsubcat.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/procedimientos/prcreglainiatractsubcat.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121783.sql"
@src/gascaribe/atencion-usuarios/cambio-de-uso/fwcob/ge_object_121783.sql

prompt "Aplicando src/gascaribe/reglas/121057739.sql"
@src/gascaribe/reglas/121057739.sql

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