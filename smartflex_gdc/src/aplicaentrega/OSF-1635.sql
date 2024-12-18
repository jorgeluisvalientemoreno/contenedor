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

prompt "Aplicando src/gascaribe/general/tablas/homologacion_servicios_pkg_estaproc.sql"
@src/gascaribe/general/tablas/homologacion_servicios_pkg_estaproc.sql

prompt "Aplicando src/gascaribe/general/tablas/homologacion_servicios_getcurrentchannel.sql"
@src/gascaribe/general/tablas/homologacion_servicios_getcurrentchannel.sql

prompt "Aplicando src/gascaribe/revision-periodica/configuracion-objeto-accion/proceso_negocio.cartera.sql"
@src/gascaribe/revision-periodica/configuracion-objeto-accion/proceso_negocio.cartera.sql

prompt "Aplicando src/gascaribe/revision-periodica/parametros/meses_persca_autoreco.sql"
@src/gascaribe/revision-periodica/parametros/meses_persca_autoreco.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgeneordeautoreco.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgeneordeautoreco.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/ldc_pkgeneordeautoreco.sql"
@src/gascaribe/revision-periodica/sinonimos/ldc_pkgeneordeautoreco.sql

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