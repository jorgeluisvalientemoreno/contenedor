column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO 461');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/contratos_omitir_nit_generico.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/contratos_omitir_nit_generico.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.contratos_omitir_nit_gene_log.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/tablas/personalizaciones.contratos_omitir_nit_gene_log.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.contratos_omitir_nit_gene_log.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.contratos_omitir_nit_gene_log.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/contratos_omitir_nit_generico.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/contratos_omitir_nit_generico.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/trigger/personalizaciones.trg_inslogcontexcege.sql"
@src/gascaribe/facturacion/facturacion_electronica/trigger/personalizaciones.trg_inslogcontexcege.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_contrato_omitir_nitgene.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_contrato_omitir_nitgene.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_contrato_omitir_nitgene.sql"
@src/gascaribe/facturacion/facturacion_electronica/sinonimos/personalizaciones.pkg_contrato_omitir_nitgene.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcea/contratos_omitir_nit_generico.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcea/contratos_omitir_nit_generico.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdcocg.sql"
@src/gascaribe/facturacion/facturacion_electronica/fwcmd/mdcocg.sql


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