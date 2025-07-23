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

prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.contratista.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.contratista.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.contratista.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.contratista.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3970_Insertar_contratistas.sql"
@src/gascaribe/datafix/OSF-3970_Insertar_contratistas.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_contratista.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_contratista.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_contratista.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_contratista.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_bopbcoem.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_bopbcoem.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_bopbcoem.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_bopbcoem.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/pkg_uipbcoem.sql"
@src/gascaribe/multiempresa/paquetes/pkg_uipbcoem.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/pkg_uipbcoem.sql"
@src/gascaribe/multiempresa/sinonimos/pkg_uipbcoem.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcob/ge_object_121794.sql"
@src/gascaribe/multiempresa/fwcob/ge_object_121794.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcob/ge_object_121795.sql"
@src/gascaribe/multiempresa/fwcob/ge_object_121795.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcpb/pbcoem.sql"
@src/gascaribe/multiempresa/fwcpb/pbcoem.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3970_Insertar_SA_TAB.sql"
@src/gascaribe/datafix/OSF-3970_Insertar_SA_TAB.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_ge_contrato_contratista.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_ge_contrato_contratista.sql


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

