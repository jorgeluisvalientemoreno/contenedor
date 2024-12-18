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

prompt "Aplicando src/gascaribe/ventas/tablas/Alter_LDC_SOLIANECO.sql"
@src/gascaribe/ventas/tablas/Alter_LDC_SOLIANECO.sql

prompt "Aplicando src/gascaribe/ventas/tablas/LDC_CONTANVE.sql"
@src/gascaribe/ventas/tablas/LDC_CONTANVE.sql

prompt "Aplicando src/gascaribe/ventas/parametros/LDC_VATRPROHI.sql"
@src/gascaribe/ventas/parametros/LDC_VATRPROHI.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/LDC_pkgestionAnulaVenta.sql"
@src/gascaribe/ventas/paquetes/LDC_pkgestionAnulaVenta.sql

prompt "Aplicando src/gascaribe/ventas/framework/OB/GE_OBJECT_121665.sql"
@src/gascaribe/ventas/framework/OB/GE_OBJECT_121665.sql

prompt "Aplicando src/gascaribe/ventas/sql/configuracion.sql"
@src/gascaribe/ventas/sql/configuracion.sql


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