column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO OSF-1478');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/sinonimos/ge_causal.sql"
@src/gascaribe/general/sinonimos/ge_causal.sql

prompt "Aplicando src/gascaribe/servicios-asociados/configuracion-objeto-accion/proceso_negocio.facturacion.sql"
@src/gascaribe/servicios-asociados/configuracion-objeto-accion/proceso_negocio.facturacion.sql

prompt "Aplicando src/gascaribe/servicios-asociados/parametros/categ_industria_reg.sql"
@src/gascaribe/servicios-asociados/parametros/categ_industria_reg.sql

prompt "Aplicando src/gascaribe/servicios-asociados/parametros/categ_industria_reg.sql"
@src/gascaribe/servicios-asociados/parametros/categ_industria_reg.sql

prompt "Aplicando src/gascaribe/servicios-asociados/parametros/formato_industria_no_reg.sql"
@src/gascaribe/servicios-asociados/parametros/formato_industria_no_reg.sql

prompt "Aplicando src/gascaribe/general/notification/permisos/permisos.sql"
@src/gascaribe/general/notification/permisos/permisos.sql

prompt "Aplicando src/gascaribe/servicios-asociados/sinonimos/open.ldc_boutilities.sql"
@src/gascaribe/servicios-asociados/sinonimos/open.ldc_boutilities.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bccontrato.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bccontrato.sql

prompt "Aplicando src/gascaribe/servicios-asociados/plugin/oal_cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/plugin/oal_cambiocategoriaprod.sql

prompt "Aplicando src/gascaribe/servicios-asociados/sinonimos/personalizaciones.oal_cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/sinonimos/personalizaciones.oal_cambiocategoriaprod.sql

prompt "Aplicando src/gascaribe/servicios-asociados/plugin/cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/plugin/cambiocategoriaprod.sql

prompt "Aplicando src/gascaribe/servicios-asociados/sinonimos/open.cambiocategoriaprod.sql"
@src/gascaribe/servicios-asociados/sinonimos/open.cambiocategoriaprod.sql

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