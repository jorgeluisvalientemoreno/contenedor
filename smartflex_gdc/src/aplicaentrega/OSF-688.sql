column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/tablas/LDC_CONTABDI.sql
@src/gascaribe/facturacion/plan_piloto/tablas/LDC_CONTABDI.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/tablas/LDC_CONTABDILOG.sql
@src/gascaribe/facturacion/plan_piloto/tablas/LDC_CONTABDILOG.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/sql/LDC_VALOR_AMORTIZA.sql
@src/gascaribe/facturacion/plan_piloto/sql/LDC_VALOR_AMORTIZA.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/sql/LDC_PORCENT_AMORTIZA_CONS.sql
@src/gascaribe/facturacion/plan_piloto/sql/LDC_PORCENT_AMORTIZA_CONS.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/framework/fwcea/LDC_CONTABDI.sql
@src/gascaribe/facturacion/plan_piloto/framework/fwcea/LDC_CONTABDI.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/framework/fwcmd/LDCCCAD.sql
@src/gascaribe/facturacion/plan_piloto/framework/fwcmd/LDCCCAD.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/paquetes/LDC_PKGESTIONABONDECONS.sql
@src/gascaribe/facturacion/plan_piloto/paquetes/LDC_PKGESTIONABONDECONS.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/procedimientos/LDCGPAD.sql
@src/gascaribe/facturacion/plan_piloto/procedimientos/LDCGPAD.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/framework/fwcpb/LDCGPAD.sql
@src/gascaribe/facturacion/plan_piloto/framework/fwcpb/LDCGPAD.sql

prompt "Aplicando src/gascaribe/facturacion/plan_piloto/disparadores/LDC_TRGLOGCONTABDI.sql
@src/gascaribe/facturacion/plan_piloto/disparadores/LDC_TRGLOGCONTABDI.sql



prompt "------------------------------------------------------"
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