column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO IN-867');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega V1.0"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/datafix/IN-867_Parametros.sql"
@src/gascaribe/datafix/IN-867_Parametros.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkwebservutils.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkwebservutils.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkrestapi.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkrestapi.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrestapi.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkrestapi.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/personalizaciones.ldci_pkg_bointegragis.sql"
@src/gascaribe/general/integraciones/paquetes/personalizaciones.ldci_pkg_bointegragis.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.ldci_pkg_bointegragis.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.ldci_pkg_bointegragis.sql

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