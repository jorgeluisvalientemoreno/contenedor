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

prompt "Aplicando src/gascaribe/revision-periodica/certificados/tablas/ldc_logactcert.sql"
@src/gascaribe/revision-periodica/certificados/tablas/ldc_logactcert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/secuencias/cr_ldc_seqlogactcert.sql"
@src/gascaribe/revision-periodica/certificados/secuencias/cr_ldc_seqlogactcert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/procldcactcert.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/procldcactcert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/ldcactcert.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/ldcactcert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/fwcpb/LDCACTCERT.sql"
@src/gascaribe/revision-periodica/certificados/fwcpb/LDCACTCERT.sql

prompt "Aplicando src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_inscert.sql"
@src/gascaribe/revision-periodica/plazos/trigger/ldc_trg_inscert.sql

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