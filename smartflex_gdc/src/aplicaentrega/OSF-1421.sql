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

prompt "Aplicando src/gascaribe/servicios-asociados/funciones/ldc_fnuGetLecturaSuger.sql"
@src/gascaribe/servicios-asociados/funciones/ldc_fnuGetLecturaSuger.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cm_ordecrit.sql"
@src/gascaribe/objetos-producto/sinonimos/cm_ordecrit.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/hicoprpm.sql"
@src/gascaribe/objetos-producto/sinonimos/hicoprpm.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/procejec.sql"
@src/gascaribe/objetos-producto/sinonimos/procejec.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/ldc_coprsuca.sql"
@src/gascaribe/facturacion/sinonimos/ldc_coprsuca.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/ldc_pkfaac.sql"
@src/gascaribe/facturacion/sinonimos/ldc_pkfaac.sql

prompt "Aplicando src/gascaribe/servicios-asociados/funciones/adm_person.fnu_lecturasugerida.sql"
@src/gascaribe/servicios-asociados/funciones/adm_person.fnu_lecturasugerida.sql

prompt "Aplicando src/gascaribe/servicios-asociados/sinonimos/adm_person.fnu_lecturasugerida.sql"
@src/gascaribe/servicios-asociados/sinonimos/adm_person.fnu_lecturasugerida.sql

prompt "Aplicando src/gascaribe/servicios-asociados/sinonimos/ldc_prlecturaval.sql"
@src/gascaribe/servicios-asociados/sinonimos/ldc_prlecturaval.sql

prompt "Aplicando src/gascaribe/servicios-asociados/plugin/ldc_prlecturaval.sql"
@src/gascaribe/servicios-asociados/plugin/ldc_prlecturaval.sql

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