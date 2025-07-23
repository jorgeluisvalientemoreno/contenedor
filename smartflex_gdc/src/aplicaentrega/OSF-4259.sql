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

-- Ini alter tabla ldci_motipedi
prompt "Aplicando src/gascaribe/general/materiales/tablas/ldci_motipedi.sql"
@src/gascaribe/general/materiales/tablas/ldci_motipedi.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.ldci_motipedi.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.ldci_motipedi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4259_act_ldci_motipedi_empresa.sql"
@src/gascaribe/datafix/OSF-4259_act_ldci_motipedi_empresa.sql

prompt "Aplicando src/gascaribe/general/materiales/fwcea/ldci_motipedi.sql"
@src/gascaribe/general/materiales/fwcea/ldci_motipedi.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_motipedi.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_motipedi.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_motipedi.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_motipedi.sql

prompt "Aplicando src/gascaribe/general/materiales/md/ldcimotipedi.sql"
@src/gascaribe/general/materiales/md/ldcimotipedi.sql
-- Fin alter tabla ldci_motipedi

-- Ini alter tabla ldci_oficvent
prompt "Aplicando src/gascaribe/general/materiales/tablas/ldci_oficvent.sql"
@src/gascaribe/general/materiales/tablas/ldci_oficvent.sql


prompt "Aplicando src/gascaribe/general/materiales/sinonimos/ldci_oficvent.sql"
@src/gascaribe/general/materiales/sinonimos/ldci_oficvent.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4259_act_ldci_oficvent_empresa.sql"
@src/gascaribe/datafix/OSF-4259_act_ldci_oficvent_empresa.sql

prompt "Aplicando src/gascaribe/general/materiales/fwcea/ldci_oficvent.sql"
@src/gascaribe/general/materiales/fwcea/ldci_oficvent.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_oficvent.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_oficvent.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_oficvent.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_oficvent.sql

prompt "Aplicando src/gascaribe/general/materiales/md/ldcioficvent.sql"
@src/gascaribe/general/materiales/md/ldcioficvent.sql
-- Fin alter tabla ldci_oficvent

-- Ini paquete acceso a datos ldci_transoma
prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_transoma.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_transoma.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_transoma.sql
-- Fin paquete acceso a datos ldci_transoma

-- Ini maestro-detalle ldcisoma
prompt "Aplicando src/gascaribe/general/materiales/fwcea/ldci_transoma.sql"
@src/gascaribe/general/materiales/fwcea/ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/md/ldcisoma.sql"
@src/gascaribe/general/materiales/md/ldcisoma.sql
-- Fin maestro-detalle ldcisoma

-- Ini ajustes ldci_pkpedidoventamaterial
prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_empresa.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_empresa.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/ldci_pkpedidoventamaterial.sql"
@src/gascaribe/general/materiales/paquetes/ldci_pkpedidoventamaterial.sql
-- Fin ajustes ldci_pkpedidoventamaterial

-- Ini alter tabla ldci_motidepe
prompt "Aplicando src/gascaribe/general/materiales/tablas/ldci_motidepe.sql"
@src/gascaribe/general/materiales/tablas/ldci_motidepe.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/ldci_motidepe.sql"
@src/gascaribe/general/materiales/sinonimos/ldci_motidepe.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4259_act_ldci_motidepe_empresa.sql"
@src/gascaribe/datafix/OSF-4259_act_ldci_motidepe_empresa.sql

prompt "Aplicando src/gascaribe/general/materiales/fwcea/ldci_motidepe.sql"
@src/gascaribe/general/materiales/fwcea/ldci_motidepe.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_motidepe.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldci_motidepe.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_motidepe.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.pkg_ldci_motidepe.sql

prompt "Aplicando src/gascaribe/general/materiales/md/ldcimotidepe.sql"
@src/gascaribe/general/materiales/md/ldcimotidepe.sql
-- Fin alter tabla ldcimotidepe

-- Ini ajustes forma MD LDCIDEMA
prompt "Aplicando src/gascaribe/general/materiales/sinonimos/ldci_intemmit.sql"
@src/gascaribe/general/materiales/sinonimos/ldci_intemmit.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/ldci_transoma.sql"
@src/gascaribe/general/materiales/sinonimos/ldci_transoma.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/personalizaciones.pkg_bcldcidema.sql"
@src/gascaribe/general/materiales/paquetes/personalizaciones.pkg_bcldcidema.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/personalizaciones.pkg_bcldcidema.sql"
@src/gascaribe/general/materiales/sinonimos/personalizaciones.pkg_bcldcidema.sql
-- Fin ajustes forma MD LDCIDEMA

-- Ini Triggers para validaciones de las formas LDCISOMA y LDCIDEMA
prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_ldci_transoma_val_empresa.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_ldci_transoma_val_empresa.sql

prompt "Aplicando src/gascaribe/multiempresa/triggers/multiempresa.trg_ldci_trsoitem_val_habilitado.sql"
@src/gascaribe/multiempresa/triggers/multiempresa.trg_ldci_trsoitem_val_habilitado.sql
-- Fin Triggers para validaciones de las formas LDCISOMA y LDCIDEMA

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