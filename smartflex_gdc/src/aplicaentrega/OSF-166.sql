column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-166"
prompt "------------------------------------------------------"



prompt "Aplicando src/gascaribe/ventas/comisiones/parametros/COD_UNIDVALDOC_VENTXDEPA.sql"
@src/gascaribe/ventas/comisiones/parametros/COD_UNIDVALDOC_VENTXDEPA.sql


prompt "Aplicando src/gascaribe/ventas/comisiones/parametros/LDC_ACT_COMI_AUT_CONST.sql"
@src/gascaribe/ventas/comisiones/parametros/LDC_ACT_COMI_AUT_CONST.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/parametros/LDC_PLAN_COMM_CONST.sql"
@src/gascaribe/ventas/comisiones/parametros/LDC_PLAN_COMM_CONST.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/parametros/LDC_TIP_SOL_COMM_CONST.sql"
@src/gascaribe/ventas/comisiones/parametros/LDC_TIP_SOL_COMM_CONST.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/parametros/LDC_TIP_SOL_VENT_CONST.sql"
@src/gascaribe/ventas/comisiones/parametros/LDC_TIP_SOL_VENT_CONST.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/parametros/LDC_USU_INTEGRA_CONST.sql"
@src/gascaribe/ventas/comisiones/parametros/LDC_USU_INTEGRA_CONST.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/tablas/LDC_CONF_COMM_AUT_CONT.sql"
@src/gascaribe/ventas/comisiones/tablas/ldc_conf_comm_aut_cont.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/tablas/ldc_comm_aut_cont.sql"
@src/gascaribe/ventas/comisiones/tablas/ldc_comm_aut_cont.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/tablas/LDC_LOG_COMM_AUT_CONT.sql"
@src/gascaribe/ventas/comisiones/tablas/ldc_log_comm_aut_cont.sql

 
prompt "Aplicando src/gascaribe/ventas/comisiones/secuencias/SEQ_LDC_COMM_AUT_CONT.sql"
@src/gascaribe/ventas/comisiones/secuencias/SEQ_LDC_COMM_AUT_CONT.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/secuencias/SEQ_LDC_CONF_COMM_AUT_CONT.sql"
@src/gascaribe/ventas/comisiones/secuencias/SEQ_LDC_CONF_COMM_AUT_CONT.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/secuencias/SEQ_LDC_LOG_COMM_AUT_CONT.sql"
@src/gascaribe/ventas/comisiones/secuencias/SEQ_LDC_LOG_COMM_AUT_CONT.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/secuencias/Permisos.sql"
@src/gascaribe/ventas/comisiones/secuencias/Permisos.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/paquetes/LDC_BOLDCGCAUC.pck"
@src/gascaribe/ventas/comisiones/paquetes/LDC_BOLDCGCAUC.pck

prompt "Aplicando src/gascaribe/ventas/comisiones/paquetes/permisos.sql"
@src/gascaribe/ventas/comisiones/paquetes/permisos.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/triggers/trgLDC_CONF_COMM_AUT_CONT01.trg"
@src/gascaribe/ventas/comisiones/triggers/trgLDC_CONF_COMM_AUT_CONT01.trg

prompt "Aplicando src/gascaribe/ventas/comisiones/procedimientos/LDCGCAUC.prc"
@src/gascaribe/ventas/comisiones/procedimientos/LDCGCAUC.prc

prompt "Aplicando src/gascaribe/ventas/comisiones/procedimientos/permisos.sql"
@src/gascaribe/ventas/comisiones/procedimientos/permisos.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/framework/fwcea/LDC_CONF_COMM_AUT_CONT.sql"
@src/gascaribe/ventas/comisiones/framework/fwcea/LDC_CONF_COMM_AUT_CONT.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/framework/fwcmd/LDCCAUC.sql"
@src/gascaribe/ventas/comisiones/framework/fwcmd/LDCCAUC.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/framework/fwcpb/LDCGCAUC.sql"
@src/gascaribe/ventas/comisiones/framework/fwcpb/LDCGCAUC.sql


prompt "Aplicando src/gascaribe/tramites/PS_PACKAGE_TYPE_100323.sql"
@src/gascaribe/tramites/PS_PACKAGE_TYPE_100323.sql

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