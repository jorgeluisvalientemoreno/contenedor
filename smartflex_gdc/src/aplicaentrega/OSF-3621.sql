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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_bodata.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_bodata.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/mo_bobillingdatachange.sql"
@src/gascaribe/objetos-producto/sinonimos/mo_bobillingdatachange.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bogestionsolicitudes.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bogestionsolicitudes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bogestionsolicitudes.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bogestionsolicitudes.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcsolicitudes.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcsolicitudes.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcdirecciones.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcdirecciones.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daab_segments.fnugetcategory_.sql"
@src/gascaribe/general/homologacion_servicios/daab_segments.fnugetcategory_.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daab_segments.fnugetsubcategory_.sql"
@src/gascaribe/general/homologacion_servicios/daab_segments.fnugetsubcategory_.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/damo_motive.fnugetcategory_id.sql"
@src/gascaribe/general/homologacion_servicios/damo_motive.fnugetcategory_id.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/damo_motive.fnugetmotive_id.sql"
@src/gascaribe/general/homologacion_servicios/damo_motive.fnugetmotive_id.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/damo_motive.fnugetproduct_id.sql"
@src/gascaribe/general/homologacion_servicios/damo_motive.fnugetproduct_id.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/damo_motive.fnugetsubcategory_id.sql"
@src/gascaribe/general/homologacion_servicios/damo_motive.fnugetsubcategory_id.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_bobillingdatachange.getcategorysbypack.sql"
@src/gascaribe/general/homologacion_servicios/mo_bobillingdatachange.getcategorysbypack.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_bobillingdatachange.getsubcategorysbypack.sql"
@src/gascaribe/general/homologacion_servicios/mo_bobillingdatachange.getsubcategorysbypack.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_bodata.fdtgetvalue.sql"
@src/gascaribe/general/homologacion_servicios/mo_bodata.fdtgetvalue.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_bodata.fnugetvalue.sql"
@src/gascaribe/general/homologacion_servicios/mo_bodata.fnugetvalue.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_bodata.fsbgetvalue.sql"
@src/gascaribe/general/homologacion_servicios/mo_bodata.fsbgetvalue.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/mo_bomotiveactionutil.exectranstatusforrequ.sql"
@src/gascaribe/general/homologacion_servicios/mo_bomotiveactionutil.exectranstatusforrequ.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/or_bolegalizeactivities.fnugetcurrmotive.sql"
@src/gascaribe/general/homologacion_servicios/or_bolegalizeactivities.fnugetcurrmotive.sql

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