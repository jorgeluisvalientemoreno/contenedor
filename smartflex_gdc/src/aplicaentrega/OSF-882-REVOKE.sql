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

prompt "REVOKE ALL ON open.suscripc FROM PERSONALIZACIONES"
REVOKE ALL ON open.suscripc FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.mo_packages FROM PERSONALIZACIONES"
REVOKE ALL ON open.mo_packages FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.ge_message FROM PERSONALIZACIONES"
REVOKE ALL ON open.ge_message FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.mo_motive FROM PERSONALIZACIONES"
REVOKE ALL ON open.mo_motive FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.ps_package_type FROM PERSONALIZACIONES"
REVOKE ALL ON open.ps_package_type FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.PS_MOTIVE_STATUS FROM PERSONALIZACIONES"
REVOKE ALL ON open.PS_MOTIVE_STATUS FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.or_order FROM PERSONALIZACIONES"
REVOKE ALL ON open.or_order FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.or_order_activity FROM PERSONALIZACIONES"
REVOKE ALL ON open.or_order_activity FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.ge_causal FROM PERSONALIZACIONES"
REVOKE ALL ON open.ge_causal FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.ge_class_causal FROM PERSONALIZACIONES"
REVOKE ALL ON open.ge_class_causal FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.pr_product FROM PERSONALIZACIONES"
REVOKE ALL ON open.pr_product FROM PERSONALIZACIONES;

prompt "REVOKE ALL ON open.servsusc FROM PERSONALIZACIONES"
REVOKE ALL ON open.servsusc FROM PERSONALIZACIONES;

prompt "Aplicando src/gascaribe/ventas/tablas/ldc_approved_requests.sql"
@src/gascaribe/ventas/tablas/ldc_approved_requests.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/paquetes/ldc_aplicagrants_osf882.sql"
@src/gascaribe/ventas/comisiones/paquetes/ldc_aplicagrants_osf882.sql

prompt "Aplicando src/gascaribe/ventas/parametros/tipo_sol_req_aprob_anul.sql"
@src/gascaribe/ventas/parametros/tipo_sol_req_aprob_anul.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/ldc_pkgapprovedRequests.sql"
@src/gascaribe/ventas/paquetes/ldc_pkgapprovedRequests.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/ldc_uiapprovedRequests.sql"
@src/gascaribe/ventas/paquetes/ldc_uiapprovedRequests.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/paquetes/ldc_bcsalescommission.sql"
@src/gascaribe/ventas/comisiones/paquetes/ldc_bcsalescommission.sql

prompt "Aplicando src/gascaribe/ventas/framework/PB/LDCAPANUL.sql"
@src/gascaribe/ventas/framework/PB/LDCAPANUL.sql

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