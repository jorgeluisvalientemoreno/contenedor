column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-1376');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-1376"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/ldc_estaprotiposusp_sac.sql"
@src/gascaribe/servicios-nuevos/parametros/ldc_estaprotiposusp_sac.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/ldc_estprod_sac.sql"
@src/gascaribe/servicios-nuevos/parametros/ldc_estprod_sac.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/parametros/ldc_tiposuspension_sac.sql"
@src/gascaribe/servicios-nuevos/parametros/ldc_tiposuspension_sac.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pr_prod_suspension.sql"
@src/gascaribe/objetos-producto/sinonimos/pr_prod_suspension.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pr_product.sql"
@src/gascaribe/objetos-producto/sinonimos/pr_product.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.fboestadotiposuspen.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.fboestadotiposuspen.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.fboestadotiposuspen.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.fboestadotiposuspen.sql

prompt "src/gascaribe/servicios-nuevos/funciones/open.ldc_fbsestadotiposuspen.sql"
@src/gascaribe/servicios-nuevos/funciones/open.ldc_fbsestadotiposuspen.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/open.ldc_fbsestadotiposuspen.sql"
@src/gascaribe/servicios-nuevos/sinonimos/open.ldc_fbsestadotiposuspen.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/fwcob/ge_object_121727.sql"
@src/gascaribe/servicios-nuevos/fwcob/ge_object_121727.sql

prompt "Aplicando src/gascaribe/tramites/PS_PACKAGE_TYPE_100323.sql"
@src/gascaribe/tramites/PS_PACKAGE_TYPE_100323.sql

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