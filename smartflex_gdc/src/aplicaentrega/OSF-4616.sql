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


prompt "Aplicando src/gascaribe/multiempresa/tablas/multiempresa.atributos_empresa.sql"
@src/gascaribe/multiempresa/tablas/multiempresa.atributos_empresa.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.atributos_empresa.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.atributos_empresa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/mo_address.sql"
@src/gascaribe/general/sinonimos/mo_address.sql

prompt "Aplicando src/gascaribe/general/sinonimos/cc_quoted_work.sql"
@src/gascaribe/general/sinonimos/cc_quoted_work.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_atributos_empresa.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_atributos_empresa.sql

prompt "Aplicando src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_atributos_empresa.sql"
@src/gascaribe/multiempresa/sinonimos/multiempresa.pkg_atributos_empresa.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4616_insert_atributos_empresa.sql"
@src/gascaribe/datafix/OSF-4616_insert_atributos_empresa.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_bcimpresioncodigobarras.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bcimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresioncodigobarras.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/paquetes/pkg_bsimpresioncodigobarras.sql"
@src/gascaribe/general/paquetes/pkg_bsimpresioncodigobarras.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_bcimpresioncliente.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_bcimpresioncliente.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_bcimpresioncliente.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_bcimpresioncliente.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresioncliente.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresioncliente.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresioncliente.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresioncliente.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresioncliente.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresioncliente.sql

prompt "Aplicando src/gascaribe/general/paquetes/pkg_bsImpresionCliente.sql"
@src/gascaribe/general/paquetes/pkg_bsImpresionCliente.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pkg_bsImpresionCliente.sql"
@src/gascaribe/general/sinonimos/pkg_bsImpresionCliente.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresionempresa.sql"
@src/gascaribe/general/paquetes/personalizaciones.pkg_boimpresionempresa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresionempresa.sql"
@src/gascaribe/general/sinonimos/personalizaciones.pkg_boimpresionempresa.sql

prompt "Aplicando src/gascaribe/general/paquetes/pkg_bsimpresionempresa.sql"
@src/gascaribe/general/paquetes/pkg_bsimpresionempresa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pkg_bsimpresionempresa.sql"
@src/gascaribe/general/sinonimos/pkg_bsimpresionempresa.sql


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

