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

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_boimpresion_cupon.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_boimpresion_cupon.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.pkg_boimpresion_cupon.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkg_boimpresion_cupon.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/personalizaciones.pkg_boldicu.sql"
@src/gascaribe/ventas/paquetes/personalizaciones.pkg_boldicu.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/personalizaciones.pkg_boldicu.sql"
@src/gascaribe/ventas/sinonimos/personalizaciones.pkg_boldicu.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/pkg_uildicu.sql"
@src/gascaribe/ventas/paquetes/pkg_uildicu.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/pkg_uildicu.sql"
@src/gascaribe/ventas/sinonimos/pkg_uildicu.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fwcpb/ldicu.sql"
@src/gascaribe/atencion-usuarios/fwcpb/ldicu.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.ld_bocouponprinting.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ld_bocouponprinting.sql

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

