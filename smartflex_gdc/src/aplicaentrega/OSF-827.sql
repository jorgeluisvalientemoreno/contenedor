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

prompt "Aplicando src/gascaribe/facturacion/spool/parametros/LDC_ACTICAR_NOTI_INI.sql"
@src/gascaribe/facturacion/spool/parametros/LDC_ACTICAR_NOTI_INI.sql

prompt "Aplicando src/gascaribe/facturacion/spool/parametros/LDC_ACTICAR_SEG_NOTI.sql"
@src/gascaribe/facturacion/spool/parametros/LDC_ACTICAR_SEG_NOTI.sql

prompt "Aplicando src/gascaribe/facturacion/spool/parametros/LDC_MES_NOTIFICA_INI_RP.sql"
@src/gascaribe/facturacion/spool/parametros/LDC_MES_NOTIFICA_INI_RP.sql

prompt "Aplicando src/gascaribe/facturacion/spool/parametros/LDC_MES_SEGUNDA_NOTI_RP.sql"
@src/gascaribe/facturacion/spool/parametros/LDC_MES_SEGUNDA_NOTI_RP.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgosffacture.sql"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgosffacture.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgestordecarta.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgestordecarta.sql

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