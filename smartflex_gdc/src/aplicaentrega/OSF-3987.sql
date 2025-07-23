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

prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.ciclo_facturacion.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.ciclo_facturacion.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.ciclo_facturacion.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.ciclo_facturacion.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3987_Insertar_ciclos.sql"
@src/gascaribe/datafix/OSF-3987_Insertar_ciclos.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_ciclo_facturacion.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_ciclo_facturacion.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_ciclo_facturacion.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_ciclo_facturacion.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_bopbciem.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_bopbciem.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_bopbciem.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_bopbciem.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/pkg_uipbciem.sql"
@src/gascaribe/multiempresa/paquetes/pkg_uipbciem.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/pkg_uipbciem.sql"
@src/gascaribe/multiempresa/sinonimos/pkg_uipbciem.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcob/ge_object_121797.sql"
@src/gascaribe/multiempresa/fwcob/ge_object_121797.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcob/ge_object_121798.sql"
@src/gascaribe/multiempresa/fwcob/ge_object_121798.sql

prompt "Aplicando src/gascaribe/multiempresa/fwcpb/pbciem.sql"
@src/gascaribe/multiempresa/fwcpb/pbciem.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3987_Insertar_SA_TAB.sql"
@src/gascaribe/datafix/OSF-3987_Insertar_SA_TAB.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_perifact_ciclo_facturacion.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_perifact_ciclo_facturacion.sql



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

