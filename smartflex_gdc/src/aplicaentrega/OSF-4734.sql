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

prompt "Aplicando src/gascaribe/facturacion/parametros/codigo_pais.sql"
@src/gascaribe/facturacion/parametros/codigo_pais.sql

prompt "Aplicando src/gascaribe/facturacion/parametros/codigo_empresa.sql"
@src/gascaribe/facturacion/parametros/codigo_empresa.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ta_confcrta.sql"
@src/gascaribe/objetos-producto/sinonimos/ta_confcrta.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ta_deficrbt.sql"
@src/gascaribe/objetos-producto/sinonimos/ta_deficrbt.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ta_deficrta.sql"
@src/gascaribe/objetos-producto/sinonimos/ta_deficrta.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bctarifas.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bctarifas.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bctarifas.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bctarifas.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_botarifas.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_botarifas.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_botarifas.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_botarifas.sql

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