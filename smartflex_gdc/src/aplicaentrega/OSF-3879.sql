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


prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_ldci_mesaenvws.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_ldci_mesaenvws.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_ldci_mesaenvws.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_ldci_mesaenvws.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_ldci_actacont.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_ldci_actacont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_ldci_actacont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_ldci_actacont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_ldci_registrainterfaz.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_ldci_registrainterfaz.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_ldci_registrainterfaz.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_ldci_registrainterfaz.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3879_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3879_homologacion_servicios.sql

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