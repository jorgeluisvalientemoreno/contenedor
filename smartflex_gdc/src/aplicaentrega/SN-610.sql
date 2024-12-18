column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO INT-114');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"



prompt "Aplicando src/gascaribe/facturacion/cargo-fijo/num_dias_instala_cobra_cfijo.sql"
@src/gascaribe/facturacion/cargo-fijo/num_dias_instala_cobra_cfijo.sql

prompt "Aplicando src/gascaribe/facturacion/cargo-fijo/ldc_fsbcertificadosn.sql"
@src/gascaribe/facturacion/cargo-fijo/ldc_fsbcertificadosn.sql

prompt "Aplicando src/gascaribe/fwcob/GE_OBJECT_121681.sql"
@src/gascaribe/fwcob/GE_OBJECT_121681.sql

prompt "Aplicando src/gascaribe/reglas/cargo-fijo/121007312.sql"
@src/gascaribe/reglas/cargo-fijo/121007312.sql

prompt "Aplicando src/gascaribe/reglas/cargo-fijo/121113994.sql"
@src/gascaribe/reglas/cargo-fijo/121113994.sql

prompt "Aplicando src/gascaribe/reglas/cargo-fijo/121114014.sql"
@src/gascaribe/reglas/cargo-fijo/121114014.sql



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