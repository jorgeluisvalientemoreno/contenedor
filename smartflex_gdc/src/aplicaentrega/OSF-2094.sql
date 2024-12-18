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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_boconstants.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_boconstants.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_bofinancing.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_bofinancing.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/gi_boerrors.sql"
@src/gascaribe/objetos-producto/sinonimos/gi_boerrors.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pkbillingperiodmgr.sql"
@src/gascaribe/objetos-producto/sinonimos/pkbillingperiodmgr.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_organizat_area.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_organizat_area.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_pointat_act.sql"
@src/gascaribe/general/sinonimos/ldc_pointat_act.sql

prompt "Aplicando src/gascaribe/general/sinonimos/dald_parameter.sql"
@src/gascaribe/general/sinonimos/dald_parameter.sql

prompt "Aplicando @src/gascaribe/objetos-producto/sinonimos/constants.sql"
@src/gascaribe/objetos-producto/sinonimos/constants.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ldci_infgestotmov.sql"
@src/gascaribe/general/integraciones/sinonimos/ldci_infgestotmov.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/fnugetbestfinancingplan.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/fnugetbestfinancingplan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/fnugetnumcuoneg.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/fnugetnumcuoneg.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/fnugetcantconsmetcalc.sql"
@src/gascaribe/facturacion/funciones/fnugetcantconsmetcalc.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/fnugetcoprfact.sql"
@src/gascaribe/facturacion/funciones/fnugetcoprfact.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/fnugetnprevperifact.sql"
@src/gascaribe/facturacion/funciones/fnugetnprevperifact.sql

prompt "Aplicando src/gascaribe/fnb/funciones/fblvalidnumfactmin.sql"
@src/gascaribe/fnb/funciones/fblvalidnumfactmin.sql

prompt "Aplicando src/gascaribe/general/funciones/fnugetapplyact.sql"
@src/gascaribe/general/funciones/fnugetapplyact.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/fnugetorderfinished.sql"
@src/gascaribe/gestion-ordenes/funciones/fnugetorderfinished.sql

prompt "Aplicando src/gascaribe/ventas/funciones/fdtgetduedate.sql"
@src/gascaribe/ventas/funciones/fdtgetduedate.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/fnuGetNPrevPeriod.sql"
@src/gascaribe/facturacion/funciones/fnuGetNPrevPeriod.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.fnugetbestfinancingplan.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.fnugetbestfinancingplan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.fnugetnumcuoneg.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.fnugetnumcuoneg.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.fnugetcantconsmetcalc.sql"
@src/gascaribe/facturacion/funciones/adm_person.fnugetcantconsmetcalc.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.fnugetcoprfact.sql"
@src/gascaribe/facturacion/funciones/adm_person.fnugetcoprfact.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.fnugetnprevperifact.sql"
@src/gascaribe/facturacion/funciones/adm_person.fnugetnprevperifact.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.fblvalidnumfactmin.sql"
@src/gascaribe/fnb/funciones/adm_person.fblvalidnumfactmin.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.fnugetapplyact.sql"
@src/gascaribe/general/funciones/adm_person.fnugetapplyact.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.fnugetorderfinished.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.fnugetorderfinished.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.fdtgetduedate.sql"
@src/gascaribe/ventas/funciones/adm_person.fdtgetduedate.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.fnuGetNPrevPeriod.sql"
@src/gascaribe/facturacion/funciones/adm_person.fnuGetNPrevPeriod.sql


prompt "Aplicando src/gascaribe/ventas/sinonimos/fdtgetduedate.sql"
@src/gascaribe/ventas/sinonimos/fdtgetduedate.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/fnugetorderfinished.sql"
@src/gascaribe/gestion-ordenes/sinonimos/fnugetorderfinished.sql

prompt "Aplicando src/gascaribe/general/sinonimos/fnugetapplyact.sql"
@src/gascaribe/general/sinonimos/fnugetapplyact.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/fblvalidnumfactmin.sql"
@src/gascaribe/fnb/sinonimos/fblvalidnumfactmin.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/fnugetnprevperiod.sql"
@src/gascaribe/facturacion/sinonimos/fnugetnprevperiod.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/fnugetnprevperifact.sql"
@src/gascaribe/facturacion/sinonimos/fnugetnprevperifact.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/fnugetcoprfact.sql"
@src/gascaribe/facturacion/sinonimos/fnugetcoprfact.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/fnugetcantconsmetcalc.sql"
@src/gascaribe/facturacion/sinonimos/fnugetcantconsmetcalc.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/fnugetnumcuoneg.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/fnugetnumcuoneg.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/fnugetbestfinancingplan.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/fnugetbestfinancingplan.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2094_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2094_actualizar_obj_migrados.sql

prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql

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