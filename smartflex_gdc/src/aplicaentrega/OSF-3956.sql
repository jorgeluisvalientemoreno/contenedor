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

prompt "Aplicando src/gascaribe/multiempresa/parametros/tipo_producto_no_marca_empresa.sql"
@src/gascaribe/multiempresa/parametros/tipo_producto_no_marca_empresa.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_empresa.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_empresa.sql

prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.contrato.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.contrato.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_contrato.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_contrato.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_ins_pr_product.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_ins_pr_product.sql

prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.auditoria_contrato.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.auditoria_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.auditoria_contrato.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.auditoria_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_auditoria_contrato.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_auditoria_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_auditoria_contrato.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_auditoria_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_auditoria_contrato.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_auditoria_contrato.sql

prompt "Aplicando src/gascaribe/multiempresa/OSF-3956_ins_contrato.sql"
@src/gascaribe/multiempresa/datafix/OSF-3956_ins_contrato.sql

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