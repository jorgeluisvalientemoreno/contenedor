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

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_conc_unid_medida_dian.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_conc_unid_medida_dian.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_conc_unid_medida_dian.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_conc_unid_medida_dian.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck

prompt "Aplicando src/gascaribe/datafix/OSF-3707_se_actualiza_flag_conceptonergiasolar.sql"
@src/gascaribe/datafix/OSF-3707_se_actualiza_flag_conceptonergiasolar.sql

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