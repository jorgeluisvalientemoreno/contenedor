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

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/tablas/LDC_BI_PROC_CRITICA_CONSUMO.sql"
@src/gascaribe/facturacion/reglas-critica/sql/tablas/LDC_BI_PROC_CRITICA_CONSUMO.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/paquetes/LDC_PKGESTIONLEGORDCRI.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/LDC_PKGESTIONLEGORDCRI.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/procedimientos/LDCLOCRI.sql"
@src/gascaribe/facturacion/reglas-critica/procedimientos/LDCLOCRI.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/fwcpb/LDCLOCRI.sql"
@src/gascaribe/facturacion/reglas-critica/fwcpb/LDCLOCRI.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_UNIOPEFOVC.sql"
@src/gascaribe/facturacion/reglas-critica/sql/LDC_UNIOPEFOVC.sql


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