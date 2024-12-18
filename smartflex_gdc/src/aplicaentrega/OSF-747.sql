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

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP2.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP2.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP3.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP3.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP4.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP4.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP5.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP5.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP6.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP6.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP7.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP7.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP8.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP8.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP9.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP9.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP10.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP10.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP11.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP11.sql

prompt "Aplicando src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP12.sql"
@src/gascaribe/cartera/reportes/tablas/altLDC_CARTDIARIA_TMP12.sql

prompt "Aplicando src/gascaribe/cartera/reportes/paquetes/ldc_pk_cartera_diaria.sql"
@src/gascaribe/cartera/reportes/paquetes/ldc_pk_cartera_diaria.sql

prompt "Aplicando src/gascaribe/cartera/reportes/procedimiento/ldc_actescureportecart.sql"
@src/gascaribe/cartera/reportes/procedimiento/ldc_actescureportecart.sql

prompt "Aplicando src/gascaribe/cartera/reportes/procedimiento/ldc_proccartlinea.sql"
@src/gascaribe/cartera/reportes/procedimiento/ldc_proccartlinea.sql

prompt "Aplicando src/gascaribe/cartera/reportes/giras/LDRREBACADI.sql"
@src/gascaribe/cartera/reportes/giras/LDRREBACADI.sql

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