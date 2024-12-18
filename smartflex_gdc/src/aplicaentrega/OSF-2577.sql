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

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_pararepe.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pararepe.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/ldc_ordentramiterp.sql"
@src/gascaribe/revision-periodica/sinonimos/ldc_ordentramiterp.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/adm_person.pkg_ldc_ordentramiterp.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.pkg_ldc_ordentramiterp.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.pkg_ldc_ordentramiterp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.pkg_ldc_ordentramiterp.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/personalizaciones.pkg_bcldc_pararepe.sql"
@src/gascaribe/revision-periodica/paquetes/personalizaciones.pkg_bcldc_pararepe.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/personalizaciones.pkg_bcldc_pararepe.sql"
@src/gascaribe/revision-periodica/sinonimos/personalizaciones.pkg_bcldc_pararepe.sql

prompt "Aplicando src/gascaribe/revision-periodica/plugin/ldc_suspporrpusuvenc.sql"
@src/gascaribe/revision-periodica/plugin/ldc_suspporrpusuvenc.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daldc_ordentramiterp.insrecord.sql"
@src/gascaribe/general/homologacion_servicios/daldc_ordentramiterp.insrecord.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daldc_pararepe.fsbgetparavast.sql"
@src/gascaribe/general/homologacion_servicios/daldc_pararepe.fsbgetparavast.sql

prompt "Aplicando src/gascaribe/general/homologacion_servicios/daldc_pararepe.fnugetparevanu.sql"
@src/gascaribe/general/homologacion_servicios/daldc_pararepe.fnugetparevanu.sql

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