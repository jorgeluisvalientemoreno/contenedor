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

prompt "Aplicando src/gascaribe/cartera/liquidacion/parametros/ACT_GC_CASTIGADOS.sql"
@src/gascaribe/cartera/liquidacion/parametros/ACT_GC_CASTIGADOS.sql

prompt "Aplicando src/gascaribe/cartera/liquidacion/parametros/TT_GC_CARTERA.sql"
@src/gascaribe/cartera/liquidacion/parametros/TT_GC_CARTERA.sql

prompt "Aplicando src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca.sql

prompt "Aplicando src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca_hilos.sql"
@src/gascaribe/cartera/liquidacion/procedimientos/procreasigoreca_hilos.sql

prompt "Aplicando src/gascaribe/cartera/liquidacion/paquetes/ldc_pkg_calc_gest_cartera.sql"
@src/gascaribe/cartera/liquidacion/paquetes/ldc_pkg_calc_gest_cartera.sql

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