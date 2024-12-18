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

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Tablas/LDC_TIPCAUS_IMPAPAR.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Tablas/LDC_TIPCAUS_IMPAPAR.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Tablas/LDC_TIPCAU_CAUS_IMPPAR.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Tablas/LDC_TIPCAU_CAUS_IMPPAR.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Secuencia/SEQ_LDC_TIPCAU_CAUS_IMPPAR.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Secuencia/SEQ_LDC_TIPCAU_CAUS_IMPPAR.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Fwcea/LDC_TIPCAUS_IMPAPAR.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Fwcea/LDC_TIPCAUS_IMPAPAR.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Fwcea/LDC_TIPCAU_CAUS_IMPPAR.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Fwcea/LDC_TIPCAU_CAUS_IMPPAR.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Fwcmd/LDCCOTICACAUS.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Fwcmd/LDCCOTICACAUS.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Pscre/PS_PACKAGE_TYPE_100039.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Framework/Pscre/PS_PACKAGE_TYPE_100039.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Dbs/datos.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Dbs/datos.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/ge_database_version.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/ge_database_version.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/Pagos-Parciales/Version.sql"
@src/gascaribe/atencion-usuarios/Pagos-Parciales/Version.sql


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