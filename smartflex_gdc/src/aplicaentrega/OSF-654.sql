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

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/tablas/LDC_RECROBLE.sql
@src/gascaribe/facturacion/reglas-critica/sql/tablas/LDC_RECROBLE.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/tablas/LDC_OBLEACTI.sql"
@src/gascaribe/facturacion/reglas-critica/sql/tablas/LDC_OBLEACTI.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/fwcea/LDC_RECROBLE.sql
@src/gascaribe/facturacion/reglas-critica/fwcea/LDC_RECROBLE.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/fwcea/LDC_OBLEACTI.sql"
@src/gascaribe/facturacion/reglas-critica/fwcea/LDC_OBLEACTI.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/md/delLDCACGEOL.sql
@src/gascaribe/facturacion/reglas-critica/md/delLDCACGEOL.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/md/ldcacgeol.sql
@src/gascaribe/facturacion/reglas-critica/md/ldcacgeol.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/paquetes/ldc_bssreglasproclecturas.sql
@src/gascaribe/facturacion/reglas-critica/paquetes/ldc_bssreglasproclecturas.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/paquetes/ldc_pkgconpr.sql
@src/gascaribe/facturacion/reglas-critica/paquetes/ldc_pkgconpr.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/OSF-654Configuracion.sql
@src/gascaribe/facturacion/reglas-critica/sql/OSF-654Configuracion.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_LISTOBSAVALSUSP.sql
@src/gascaribe/facturacion/reglas-critica/sql/LDC_LISTOBSAVALSUSP.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_LISTITROBLECSUSP.sql
@src/gascaribe/facturacion/reglas-critica/sql/LDC_LISTITROBLECSUSP.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_LISTITROBLEC.sql
@src/gascaribe/facturacion/reglas-critica/sql/LDC_LISTITROBLEC.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_CODATRIBLECT.sql
@src/gascaribe/facturacion/reglas-critica/sql/LDC_CODATRIBLECT.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/COD_ACT_CAMBIO_MEDIDOR.sql
@src/gascaribe/facturacion/reglas-critica/sql/COD_ACT_CAMBIO_MEDIDOR.sql


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