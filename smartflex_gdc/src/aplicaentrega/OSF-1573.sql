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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_bopersonal.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_bopersonal.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.constants_per.sql"
@src/gascaribe/general/paquetes/personalizaciones.constants_per.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.constants_per.sql"
@src/gascaribe/general/sinonimos/personalizaciones.constants_per.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bopersonal.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bopersonal.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_bopersonal.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_bopersonal.sql

prompt "Aplicando src/gascaribe/revision-periodica/paquetes/personalizaciones.pkg_xml_soli_rev_periodica.sql"
@src/gascaribe/revision-periodica/paquetes/personalizaciones.pkg_xml_soli_rev_periodica.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/personalizaciones.pkg_xml_soli_rev_periodica.sql"
@src/gascaribe/revision-periodica/sinonimos/personalizaciones.pkg_xml_soli_rev_periodica.sql


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