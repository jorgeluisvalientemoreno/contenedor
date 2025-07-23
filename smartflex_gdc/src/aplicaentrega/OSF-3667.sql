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

prompt "Aplicando src/gascaribe/sistema-brilla/parametros/insurance_rate_ii.sql"
@src/gascaribe/sistema-brilla/parametros/insurance_rate_ii.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuprocesoreclamoactivo.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuprocesoreclamoactivo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalordebtsinrecl.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalordebtsinrecl.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bcfinanciacion.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bcfinanciacion.sql

prompt "Aplicando src/gascaribe/sistema-brilla/funciones/personalizaciones.fnureglacobrosegurodeudor.sql"
@src/gascaribe/sistema-brilla/funciones/personalizaciones.fnureglacobrosegurodeudor.sql

prompt "Aplicando src/gascaribe/sistema-brilla/sinonimos/personalizaciones.fnureglacobrosegurodeudor.sql"
@src/gascaribe/sistema-brilla/sinonimos/personalizaciones.fnureglacobrosegurodeudor.sql

prompt "Aplicando src/gascaribe/sistema-brilla/funciones/fnureglaliqsegurodeudorI.sql"
@src/gascaribe/sistema-brilla/funciones/fnureglaliqsegurodeudorI.sql

prompt "Aplicando src/gascaribe/sistema-brilla/funciones/fnureglaliqsegurodeudorII.sql"
@src/gascaribe/sistema-brilla/funciones/fnureglaliqsegurodeudorII.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121742.sql"
@src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121742.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121045.sql"
@src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121045.sql

prompt "Aplicando src/gascaribe/sistema-brilla/fwcob/ge_object_121791.sql"
@src/gascaribe/sistema-brilla/fwcob/ge_object_121791.sql

prompt "Aplicando src/gascaribe/sistema-brilla/fwcob/ge_object_121792.sql"
@src/gascaribe/sistema-brilla/fwcob/ge_object_121792.sql

prompt "Aplicando src/gascaribe/reglas/121063361.sql"
@src/gascaribe/reglas/121063361.sql

prompt "Aplicando src/gascaribe/reglas/121063363.sql"
@src/gascaribe/reglas/121063363.sql

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