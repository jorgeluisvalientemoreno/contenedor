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

prompt "Aplicando src/gascaribe/gestion-contratista/api/adm_person.api_registernovelty.sql"
@src/gascaribe/gestion-contratista/api/adm_person.api_registernovelty.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/ldc_boventasfnb.sql"
@src/gascaribe/fnb/paquetes/ldc_boventasfnb.sql

-- Se modifica creación de permisos
prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bcfinanceot.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcfinanceot.sql

-- Se modifica para crear los permisos con el paquete de utilidades
prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_bcfinanceot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_bcfinanceot.sql

--Inicio programas para ejecutar métodos del esquema Open
prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.fnuobtprimeractividad.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.fnuobtprimeractividad.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.fnuobtprimeractividad.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.fnuobtprimeractividad.sql
-- Fin programas para ejecutar métodos del esquema Open

prompt "Aplicando src/gascaribe/actas/ofertados/adm_person.ldc_progeneranoveltyofertados.sql"
@src/gascaribe/actas/ofertados/adm_person.ldc_progeneranoveltyofertados.sql

prompt "Aplicando src/gascaribe/actas/ofertados/personalizaciones.ldc_progeneranoveltyofertados.sql"
@src/gascaribe/actas/ofertados/personalizaciones.ldc_progeneranoveltyofertados.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/personalizaciones.ldc_progeneranoveltyofertados.sql"
@src/gascaribe/actas/sinonimos/personalizaciones.ldc_progeneranoveltyofertados.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2204_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-2204_homologacion_servicios.sql

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