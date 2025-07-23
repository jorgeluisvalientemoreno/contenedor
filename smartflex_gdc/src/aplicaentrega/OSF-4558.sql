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

prompt "Aplicando src/gascaribe/datafix/OSF-4558_act_sa_executable_ldciaclotitr.sql"
@src/gascaribe/datafix/OSF-4558_act_sa_executable_ldciaclotitr.sql

prompt "Aplicando src/gascaribe/contabilidad/tablas/fk_actiubgttra_drop.sql"
@src/gascaribe/contabilidad/tablas/fk_actiubgttra_drop.sql

-- Agrega la columna ldci_activoencurso.sociedad
prompt "Aplicando src/gascaribe/general/integraciones/tablas/ldci_activoencurso.sql"
@src/gascaribe/general/integraciones/tablas/ldci_activoencurso.sql

-- Agrega la columna ACBGSOCI - Sociedad
prompt "Aplicando src/gascaribe/contabilidad/tablas/ldci_actiubgttra.sql"
@src/gascaribe/contabilidad/tablas/ldci_actiubgttra.sql

-- Actualiza ldci_actiubgttra.ACBGSOCI = 'GDCA'
prompt "Aplicando src/gascaribe/datafix/OSF-4558_act_ldci_actiubgttra_acbgsoci.sql"
@src/gascaribe/datafix/OSF-4558_act_ldci_actiubgttra_acbgsoci.sql

prompt "Aplicando src/gascaribe/general/integraciones/fwcea/ldci_activoencurso.sql"
@src/gascaribe/general/integraciones/fwcea/ldci_activoencurso.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcea/ldci_actiubgttra.sql"
@src/gascaribe/contabilidad/fwcea/ldci_actiubgttra.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgactivoencurso.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkgactivoencurso.sql

prompt "Aplicando src/gascaribe/general/integraciones/fwcmd/ldciactivo.sql"
@src/gascaribe/general/integraciones/fwcmd/ldciactivo.sql

prompt "Aplicando src/gascaribe/contabilidad/fwcmd/ldciactloctra.sql"
@src/gascaribe/contabilidad/fwcmd/ldciactloctra.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_ldci_actiubgttra_val_empr.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_ldci_actiubgttra_val_empr.sql

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