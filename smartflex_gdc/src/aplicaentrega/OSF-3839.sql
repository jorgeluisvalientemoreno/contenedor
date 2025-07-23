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

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_boutilidadescadenas.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_boutilidadescadenas.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.pkg_boutilidadescadenas.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkg_boutilidadescadenas.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_cc_quotation.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_cc_quotation.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.pkg_cc_quotation.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkg_cc_quotation.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_plandife.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_plandife.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.pkg_plandife.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkg_plandife.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_cc_sales_financ_cond.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_cc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.pkg_cc_sales_financ_cond.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkg_cc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql

prompt "Aplicando src/gascaribe/ventas/homologaciones/dacc_quotation.sql"
@src/gascaribe/ventas/homologaciones/dacc_quotation.sql

prompt "Aplicando src/gascaribe/ventas/homologaciones/dacc_sales_financ_cond.sql"
@src/gascaribe/ventas/homologaciones/dacc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/ventas/homologaciones/pktblplandife.sql"
@src/gascaribe/ventas/homologaciones/pktblplandife.sql

prompt "Aplicando src/gascaribe/ventas/homologaciones/ut_string.findparametervalue.sql"
@src/gascaribe/ventas/homologaciones/ut_string.findparametervalue.sql

prompt "Aplicando src/gascaribe/ventas/homologaciones/cc_boaccounts.generateaccountbypack.sql"
@src/gascaribe/ventas/homologaciones/cc_boaccounts.generateaccountbypack.sql

prompt "Aplicando src/gascaribe/ventas/homologaciones/cc_bofinancing.financingorder.sql"
@src/gascaribe/ventas/homologaciones/cc_bofinancing.financingorder.sql

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