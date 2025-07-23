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


prompt "Aplicando src/gascaribe/contabilidad/tablas/ldci_tipointerfaz.sql"
@src/gascaribe/contabilidad/tablas/ldci_tipointerfaz.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcea/ldci_tipointerfaz.sql"
@src/gascaribe/contabilidad/fwcea/ldci_tipointerfaz.sql

prompt "Aplicando src/gascaribe/contabilidad/tablas/ldci_registrainterfaz.sql"
@src/gascaribe/contabilidad/tablas/ldci_registrainterfaz.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcea/ldci_registrainterfaz.sql"
@src/gascaribe/contabilidad/fwcea/ldci_registrainterfaz.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4202_actualiza_ldci_registrainterfaz.sql"
@src/gascaribe/datafix/OSF-4202_actualiza_ldci_registrainterfaz.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcmd/ldclctoi.sql"
@src/gascaribe/contabilidad/fwcmd/ldclctoi.sql

prompt "Aplicando src/gascaribe/contabilidad/paquetes/pkg_uildcigintmesro.sql"
@src/gascaribe/contabilidad/paquetes/pkg_uildcigintmesro.sql

prompt "Aplicando src/gascaribe/contabilidad/sinonimos/pkg_uildcigintmesro.sql"
@src/gascaribe/contabilidad/sinonimos/pkg_uildcigintmesro.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcpb/ldcigintmesro.sql"
@src/gascaribe/contabilidad/fwcpb/ldcigintmesro.sql

prompt "Aplicando src/gascaribe/contabilidad/paquetes/pkg_uildcigintro.sql"
@src/gascaribe/contabilidad/paquetes/pkg_uildcigintro.sql

prompt "Aplicando src/gascaribe/contabilidad/sinonimos/pkg_uildcigintro.sql"
@src/gascaribe/contabilidad/sinonimos/pkg_uildcigintro.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcpb/ldcigintro.sql"
@src/gascaribe/contabilidad/fwcpb/ldcigintro.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcmd/ldcitipinterf.sql"
@src/gascaribe/contabilidad/fwcmd/ldcitipinterf.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcmd/ldcreginter.sql"
@src/gascaribe/contabilidad/fwcmd/ldcreginter.sql


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

