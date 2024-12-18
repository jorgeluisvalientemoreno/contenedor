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

prompt "Aplicando src/gascaribe/fwcob/ge_object_121736.sql"
@src/gascaribe/fwcob/ge_object_121736.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121737.sql"
@src/gascaribe/fwcob/ge_object_121737.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121743.sql"
@src/gascaribe/fwcob/ge_object_121743.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121745.sql"
@src/gascaribe/fwcob/ge_object_121745.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121747.sql"
@src/gascaribe/fwcob/ge_object_121747.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121749.sql"
@src/gascaribe/fwcob/ge_object_121749.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121750.sql"
@src/gascaribe/fwcob/ge_object_121750.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121751.sql"
@src/gascaribe/fwcob/ge_object_121751.sql

prompt "Aplicando src/gascaribe/fwcob/ge_object_121752.sql"
@src/gascaribe/fwcob/ge_object_121752.sql

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