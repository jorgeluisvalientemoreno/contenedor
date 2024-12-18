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


prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/personalizaciones.fsbencriptacadena.sql"
@src/gascaribe/atencion-usuarios/funciones/personalizaciones.fsbencriptacadena.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.fsbencriptacadena.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.fsbencriptacadena.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/personalizaciones.fsbencriptadireccion.sql"
@src/gascaribe/atencion-usuarios/funciones/personalizaciones.fsbencriptadireccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.fsbencriptadireccion.sql"
@src/gascaribe/atencion-usuarios/sinonimos/personalizaciones.fsbencriptadireccion.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/fsbgetcadenaencriptada.sql"
@src/gascaribe/atencion-usuarios/funciones/fsbgetcadenaencriptada.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/fsbgetcadenaencriptada.sql"
@src/gascaribe/atencion-usuarios/sinonimos/fsbgetcadenaencriptada.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121759.sql"
@src/gascaribe/fwcob/ge_object_121759.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/pkg_boinfodatosformatos.sql"
@src/gascaribe/atencion-usuarios/paquetes/pkg_boinfodatosformatos.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pkg_boinfodatosformatos.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pkg_boinfodatosformatos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_crmestadocuenta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_crmestadocuenta.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fced/confexme_16.sql"
@src/gascaribe/atencion-usuarios/fced/confexme_16.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/fced/confexme_107.sql"
@src/gascaribe/atencion-usuarios/fced/confexme_107.sql


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