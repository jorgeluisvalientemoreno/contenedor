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

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/ldci_itemtmp.sql"
@src/gascaribe/general/integraciones/sinonimos/ldci_itemtmp.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/ldci_contesse.sql"
@src/gascaribe/general/integraciones/sinonimos/ldci_contesse.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/ldci_materecu.sql"
@src/gascaribe/general/integraciones/sinonimos/ldci_materecu.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcgamaitems.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcgamaitems.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcgamaitems.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcgamaitems.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcgamaitems.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcgamaitems.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcunidadesmedida.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcunidadesmedida.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcunidadesmedida.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcunidadesmedida.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.pkg_ldci_itemtmp.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.pkg_ldci_itemtmp.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.pkg_ldci_itemtmp.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.pkg_ldci_itemtmp.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.pkg_ldci_contesse.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.pkg_ldci_contesse.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.pkg_ldci_contesse.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.pkg_ldci_contesse.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.pkg_ldci_materecu.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.pkg_ldci_materecu.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.pkg_ldci_materecu.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.pkg_ldci_materecu.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_bcmaestromateriales.sql"
@src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_bcmaestromateriales.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_bcmaestromateriales.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_bcmaestromateriales.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_maestromaterial.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_maestromaterial.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/personalizaciones.tgr_bi_ge_tiems_request.sql"
@src/gascaribe/general/materiales/triggers/personalizaciones.tgr_bi_ge_tiems_request.sql

prompt "Aplicando src/gascaribe/general/materiales/md/ldcisoma.sql"
@src/gascaribe/general/materiales/md/ldcisoma.sql

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