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

prompt "Grant execute sobre open.UT_TRACE a personalizaciones"
grant execute on open.UT_TRACE to personalizaciones;

prompt "Creando sinónimo privado personalizaciones.UT_TRACE"
create or replace synonym personalizaciones.UT_TRACE for open.UT_TRACE;

prompt "Creando sinónimo privado personalizaciones.EX"
create or replace synonym personalizaciones.EX for open.EX;

prompt "Grant execute sobre open.EX a personalizaciones"
grant execute on open.EX to personalizaciones;

prompt "Creando sinónimo privado personalizaciones.ERRORS"
create or replace synonym personalizaciones.ERRORS for open.ERRORS;

prompt "Grant execute sobre open.ERRORS a personalizaciones"
grant execute on open.ERRORS to personalizaciones;

prompt "Grant delete sobre open.LDC_BLOQ_LEGA_SOLICITUD a personalizaciones"
Grant delete on open.LDC_BLOQ_LEGA_SOLICITUD to personalizaciones;

prompt "Grant delete sobre open.LDC_ORDER a personalizaciones"
Grant delete on open.LDC_ORDER to personalizaciones;

prompt "Aplicando src/gascaribe/tipos/tstringtable.sql"
@src/gascaribe/general/tipos/tstringtable.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/constants_per.sql"
@src/gascaribe/general/paquetes/constants_per.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_bcconsgenerales.sql"
@src/gascaribe/general/paquetes/ldc_bcconsgenerales.sql

prompt "Aplicando src/gascaribe/revision-periodica/tablas/ldc_aud_bloq_lega_sol.sql"
@src/gascaribe/revision-periodica/tablas/ldc_aud_bloq_lega_sol.sql

prompt "Aplicando src/gascaribe/revision-periodica/tablas/ldc_logerrleorresu.sql"
@src/gascaribe/revision-periodica/tablas/ldc_logerrleorresu.sql

prompt "Aplicando src/gascaribe/revision-periodica/llaves_primarias/pkldc_logerrleorresu.sql"
@src/gascaribe/revision-periodica/llaves_primarias/pkldc_logerrleorresu.sql

prompt "Aplicando src/gascaribe/revision-periodica/indices/idx_ldc_logerrleorresu_1.sql"
@src/gascaribe/revision-periodica/indices/idx_ldc_logerrleorresu_1.sql

prompt "Aplicando src/gascaribe/revision-periodica/secuencias/seq_ldc_logerrleorresu.sql"
@src/gascaribe/revision-periodica/secuencias/seq_ldc_logerrleorresu.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/ldc_trg_seq_logerrleorresu.sql"
@src/gascaribe/revision-periodica/triggers/ldc_trg_seq_logerrleorresu.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgldcgesterrrp_per.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgldcgesterrrp_per.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgldcgesterrrp.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgldcgesterrrp.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/ldc_pkgrepegelerecoysusp.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgrepegelerecoysusp.sql

prompt "Aplicando src/gascaribe/revision-periodica/schedules/job_borraerrasigordrp.sql"
@src/gascaribe/revision-periodica/schedules/job_borraerrasigordrp.sql

prompt "Aplicando src/gascaribe/revision-periodica/suspension/paquetes/dropldc_pkgestioncasurp2.sql"
@src/gascaribe/revision-periodica/suspension/paquetes/dropldc_pkgestioncasurp2.sql

prompt "Aplicando src/gascaribe/revision-periodica/fwcob/ge_object_120301.sql"
@src/gascaribe/revision-periodica/fwcob/ge_object_120301.sql

prompt "Aplicando src/gascaribe/revision-periodica/fwcpb/ldcgesterrrp.sql"
@src/gascaribe/revision-periodica/fwcpb/ldcgesterrrp.sql

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