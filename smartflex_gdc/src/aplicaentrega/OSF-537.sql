column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/ventas/tablas/Alter_LDC_CONTANVE.sql"
@src/gascaribe/ventas/tablas/Alter_LDC_CONTANVE.sql

prompt "Aplicando src/gascaribe/ventas/tablas/LDC_CONTANVEHIST.sql"
@src/gascaribe/ventas/tablas/LDC_CONTANVEHIST.sql

prompt "Aplicando src/gascaribe/ventas/tablas/LDC_CONTTSFA.sql"
@src/gascaribe/ventas/tablas/LDC_CONTTSFA.sql

prompt "Aplicando src/gascaribe/ventas/tablas/LDC_CONTTSFAHIST.sql"
@src/gascaribe/ventas/tablas/LDC_CONTTSFAHIST.sql

prompt "Aplicando src/gascaribe/ventas/tablas/LDC_INFOTSPR.sql"
@src/gascaribe/ventas/tablas/LDC_INFOTSPR.sql

prompt "Aplicando src/gascaribe/ventas/parametros/LDC_VASANOTI.sql"
@src/gascaribe/ventas/parametros/LDC_VASANOTI.sql

prompt "Aplicando src/gascaribe/ventas/parametros/LDC_EMAILNVPC.sql"
@src/gascaribe/ventas/parametros/LDC_EMAILNVPC.sql

prompt "Aplicando src/gascaribe/ventas/trigger/LDC_TRGHISTCONTTSALD.sql"
@src/gascaribe/ventas/trigger/LDC_TRGHISTCONTTSALD.sql

prompt "Aplicando src/gascaribe/ventas/trigger/LDC_TRGHISTCONTANULA.sql"
@src/gascaribe/ventas/trigger/LDC_TRGHISTCONTANULA.sql

prompt "Aplicando src/gascaribe/ventas/framework/EA/LDC_CONTTSFA.sql"
@src/gascaribe/ventas/framework/EA/LDC_CONTTSFA.sql

prompt "Aplicando src/gascaribe/ventas/framework/EA/LDC_CONTANVE.sql"
@src/gascaribe/ventas/framework/EA/LDC_CONTANVE.sql

prompt "Aplicando src/gascaribe/ventas/framework/MD/LDCCCTSA.sql"
@src/gascaribe/ventas/framework/MD/LDCCCTSA.sql

prompt "Aplicando src/gascaribe/ventas/framework/MD/LDCCCANU.sql"
@src/gascaribe/ventas/framework/MD/LDCCCANU.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/LDC_pkgestionAnulaVenta.sql"
@src/gascaribe/ventas/paquetes/LDC_pkgestionAnulaVenta.sql

prompt "Aplicando src/gascaribe/ventas/framework/OB/GE_OBJECT_121670.sql"
@src/gascaribe/ventas/framework/OB/GE_OBJECT_121670.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/