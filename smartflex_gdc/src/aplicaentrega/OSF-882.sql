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

prompt "Creando execute sobre open.constants a personalizaciones"
grant execute on open.constants to personalizaciones;

prompt "Creando sinonimo privado personalizaciones.constants"
create or replace synonym personalizaciones.constants for open.constants;

prompt "Grant execute sobre open.DALD_PARAMETER a personalizaciones"
grant execute on open.DALD_PARAMETER to personalizaciones;

prompt "Grant execute sobre open.PKCONSTANTE a personalizaciones"
grant execute on open.PKCONSTANTE to personalizaciones;

prompt "Creando sinónimo privado personalizaciones.PKCONSTANTE"
create or replace synonym personalizaciones.PKCONSTANTE for open.PKCONSTANTE;

prompt "Grant execute sobre open.PKERRORS a personalizaciones"
grant execute on open.PKERRORS to personalizaciones;

prompt "Creando sinónimo privado personalizaciones.PKERRORS"
create or replace synonym personalizaciones.PKERRORS for open.PKERRORS;

prompt "Grant select, insert, delete on open.suscripc to personalizaciones"
Grant select, insert, delete on open.suscripc to personalizaciones;

prompt "Grant select, insert, delete on open.mo_packages to personalizaciones"
Grant select, insert, delete on open.mo_packages to personalizaciones;

prompt "Grant select, insert, delete on open.ge_message to personalizaciones"
Grant select, insert, delete on open.ge_message to personalizaciones;

prompt "Grant select, insert, delete on open.mo_motive to personalizaciones"
Grant select, insert, delete on open.mo_motive to personalizaciones;

prompt "Grant select, insert, delete on open.ps_package_type to personalizaciones"
Grant select, insert, delete on open.ps_package_type to personalizaciones;

prompt "Grant select, insert, delete on open.PS_MOTIVE_STATUS to personalizaciones"
Grant select, insert, delete on open.PS_MOTIVE_STATUS to personalizaciones;

prompt "Grant select, insert, delete on open.or_order to personalizaciones"
Grant select, insert, delete on open.or_order to personalizaciones;

prompt "Grant select, insert, delete on open.or_order_activity to personalizaciones"
Grant select, insert, delete on open.or_order_activity to personalizaciones;

prompt "Grant select, insert, delete on open.ge_causal to personalizaciones"
Grant select, insert, delete on open.ge_causal to personalizaciones;

prompt "Grant select, insert, delete on open.ge_class_causal to personalizaciones"
Grant select, insert, delete on open.ge_class_causal to personalizaciones;

prompt "Grant select, insert, delete on open.pr_product to personalizaciones"
Grant select, insert, delete on open.pr_product to personalizaciones;

prompt "Grant select, insert, delete on open.servsusc to personalizaciones"
Grant select, insert, delete on open.servsusc to personalizaciones;

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