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

prompt "Aplicando src/gascaribe/general/sinonimos/or_route_zone.sql"
@src/gascaribe/general/sinonimos/or_route_zone.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcdirecciones.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcdirecciones.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcproducto.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcproducto.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/confesco.sql"
@src/gascaribe/facturacion/sinonimos/confesco.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/pkbobillprintutilities.sql"
@src/gascaribe/facturacion/sinonimos/pkbobillprintutilities.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofacturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofacturacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bofacturacion.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bofacturacion.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4480_Ins_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-4480_Ins_homologacion_servicios.sql

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