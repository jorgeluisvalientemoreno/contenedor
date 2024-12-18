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

prompt "Aplicando src/gascaribe/facturacion/parametros/codigo_programa_genera_factura_excluido_generar_pdf_pbifse.sql"
@src/gascaribe/facturacion/parametros/codigo_programa_genera_factura_excluido_generar_pdf_pbifse.sql

prompt "Aplicando src/gascaribe/facturacion/parametros/confexme_factura_servicio_pbifse.sql"
@src/gascaribe/facturacion/parametros/confexme_factura_servicio_pbifse.sql

prompt "Aplicando src/gascaribe/facturacion/parametros/concepto_iva_factura_servicio_pbifse.sql"
@src/gascaribe/facturacion/parametros/concepto_iva_factura_servicio_pbifse.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcimpre_fact_servi.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcimpre_fact_servi.sql
show errors;

prompt "Aplicando src/gascaribe/facturacion/sinonimos/pkg_bcimpre_fact_servi.sql"
@src/gascaribe/facturacion/sinonimos/pkg_bcimpre_fact_servi.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_boimpre_fact_servi.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_boimpre_fact_servi.sql
show errors;

prompt "Aplicando src/gascaribe/facturacion/sinonimos/pkg_boimpre_fact_servi.sql"
@src/gascaribe/facturacion/sinonimos/pkg_boimpre_fact_servi.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/pkg_uiimpre_fact_servi.sql"
@src/gascaribe/facturacion/paquetes/pkg_uiimpre_fact_servi.sql
show errors;

prompt "Aplicando src/gascaribe/facturacion/sinonimos/pkg_uiimpre_fact_servi.sql"
@src/gascaribe/facturacion/sinonimos/pkg_uiimpre_fact_servi.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/pkg_uipbifse.sql"
@src/gascaribe/facturacion/paquetes/pkg_uipbifse.sql
show errors;

prompt "Aplicando src/gascaribe/facturacion/sinonimos/pkg_uipbifse.sql"
@src/gascaribe/facturacion/sinonimos/pkg_uipbifse.sql

prompt "Aplicando src/gascaribe/facturacion/fwcpb/pbifse.sql"
@src/gascaribe/facturacion/fwcpb/pbifse.sql

prompt "Aplicando src/gascaribe/facturacion/fced/confexme_59.sql"
@src/gascaribe/facturacion/fced/confexme_59.sql

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