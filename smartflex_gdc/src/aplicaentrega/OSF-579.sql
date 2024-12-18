column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega 268"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_CAUSLEGCRIT.sql"
@src/gascaribe/facturacion/reglas-critica/sql/LDC_CAUSLEGCRIT.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/sql/LDC_IDREGLAEXCL.sql"
@src/gascaribe/facturacion/reglas-critica/sql/LDC_IDREGLAEXCL.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/paquetes/LDC_PKGESTIONLEGORDCRI.sql"
@src/gascaribe/facturacion/reglas-critica/paquetes/LDC_PKGESTIONLEGORDCRI.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/fwcob/GE_OBJECT_121676.sql"
@src/gascaribe/facturacion/reglas-critica/fwcob/GE_OBJECT_121676.sql

prompt "Aplicando src/gascaribe/facturacion/reglas-critica/fwcpb/LDCLOCRI.sql"
@src/gascaribe/facturacion/reglas-critica/fwcpb/LDCLOCRI.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/