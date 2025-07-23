column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"


prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.sucursal_bancaria.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.sucursal_bancaria.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.sucursal_bancaria.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.sucursal_bancaria.sql

prompt "Aplicando src/gascaribe/multiempresa/datafix/OSF-4134_insertar_sucursal_bancaria.sql"
@src/gascaribe/multiempresa/datafix/OSF-4134_insertar_sucursal_bancaria.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_sucursal_bancaria.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_sucursal_bancaria.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_sucursal_bancaria.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_sucursal_bancaria.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_boconsultaempresa.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_boconsultaempresa.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_sucubanc_empresa.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_sucubanc_empresa.sql


prompt "------------------------------------------------------"
prompt "Fin Aplica Entrega V1.0"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/

