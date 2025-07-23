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

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.funciona.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.funciona.sql

prompt "Aplicando src/gascaribe/general/tipos/adm_person.mo_tytbextrapayments.sql"
@src/gascaribe/general/tipos/adm_person.mo_tytbextrapayments.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.mo_tytbextrapayments.sql"
@src/gascaribe/fnb/sinonimos/adm_person.mo_tytbextrapayments.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_servicio.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_servicio.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.conftain.sql"
@src/gascaribe/cartera/sinonimo/adm_person.conftain.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_session.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_session.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_pericose.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_pericose.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestionperiodos.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestionperiodos.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_cargos.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_cargos.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_cargos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_cargos.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bogestion_contrato.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestion_contrato.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bogestion_contrato.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestion_contrato.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.constants_per.sql"
@src/gascaribe/general/paquetes/personalizaciones.constants_per.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_bogestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_bogestion_producto.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_causcarg.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_causcarg.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_causcarg.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_causcarg.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/procrest.sql"
@src/gascaribe/facturacion/sinonimos/procrest.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_cuencobr.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_cuencobr.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_cuencobr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_cuencobr.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/feullico.sql"
@src/gascaribe/facturacion/sinonimos/feullico.sql

prompt "Aplicando src/gascaribe/general/tipos/adm_person.mo_tyobextrapayments.sql"
@src/gascaribe/general/tipos/adm_person.mo_tyobextrapayments.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.mo_tyobextrapayments.sql"
@src/gascaribe/fnb/sinonimos/adm_person.mo_tyobextrapayments.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.cuotextr.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cuotextr.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_concepto.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_concepto.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_feullico.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_feullico.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_diferido.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_diferido.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_parafact.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_parafact.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_concepto.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_concepto.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_feullico.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_feullico.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_parafact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_parafact.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3846_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-4294_homologacion_servicios.sql

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