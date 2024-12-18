set serveroutput on size unlimited
set linesize 1000
set timing on
execute dbms_application_info.set_action('APLICANDO OSF-2174');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

COLUMN instancia new_val instancia format a20;
COLUMN fecha_ejec new_val fecha_ejec format a20;
COLUMN esquema new_val esquema format a20;
COLUMN ejecutado_por new_val ejecutado_por format a20;
COLUMN usuario_so new_val usuario_so format a35;
COLUMN fecha_fin new_val fecha_fin format a25

DEFINE CASO=OSF-2174

SELECT SYS_CONTEXT('USERENV', 'DB_NAME') instancia,
   TO_CHAR(SYSDATE, 'yyyymmdd_hh24miss') fecha_ejec,
   SYS_CONTEXT('USERENV','CURRENT_SCHEMA') esquema,
   USER ejecutado_por,
   SYS_CONTEXT('USERENV', 'OS_USER') usuario_so
FROM DUAL;

PROMPT
PROMPT =========================================
PROMPT  ****   Información de Ejecución    ****
PROMPT =========================================
PROMPT Instancia        : &instancia
PROMPT Fecha ejecución  : &fecha_ejec
PROMPT Usuario DB       : &ejecutado_por
PROMPT Usuario O.S      : &usuario_so
PROMPT Esquema          : &esquema
PROMPT CASO             : &CASO
PROMPT =========================================
PROMPT

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/interfaz-contable/parametros/email_notif_acta_contabil_fnb.sql"
@src/gascaribe/general/interfaz-contable/parametros/email_notif_acta_contabil_fnb.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/bi_boserviciosdotnet.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/bi_boserviciosdotnet.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/ge_bodatabaseconnection.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/ge_bodatabaseconnection.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/ge_boschedule.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/ge_boschedule.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/ldci_actacont.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/ldci_actacont.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/ldci_carasewe.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/ldci_carasewe.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/ldci_pkinterfazactas.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/ldci_pkinterfazactas.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/ldci_pkinterfazactas.sql"
@src/gascaribe/general/interfaz-contable/paquetes/ldci_pkinterfazactas.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_boconexionbd.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_boconexionbd.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_boconexionbd.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_boconexionbd.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_bointerfazactas.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_bointerfazactas.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_bointerfazactas.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_bointerfazactas.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_boschedule.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.pkg_boschedule.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_boschedule.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkg_boschedule.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/personalizaciones.pkg_contabilizaactasaut.sql"
@src/gascaribe/general/interfaz-contable/paquetes/personalizaciones.pkg_contabilizaactasaut.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/personalizaciones.pkg_contabilizaactasaut.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/personalizaciones.pkg_contabilizaactasaut.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_contabiliza_sap.sql"
@src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_contabiliza_sap.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/prc_actasfnb_contabiliza_sap.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/prc_actasfnb_contabiliza_sap.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_reversa_he.sql"
@src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_reversa_he.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/prc_actasfnb_reversa_he.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/prc_actasfnb_reversa_he.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_reversa_rc.sql"
@src/gascaribe/general/interfaz-contable/procedimientos/prc_actasfnb_reversa_rc.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/prc_actasfnb_reversa_rc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/prc_actasfnb_reversa_rc.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/fwcob/ge_object_121765.sql"
@src/gascaribe/general/interfaz-contable/fwcob/ge_object_121765.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/fwcob/ge_object_121766.sql"
@src/gascaribe/general/interfaz-contable/fwcob/ge_object_121766.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/fwcob/ge_object_121767.sql"
@src/gascaribe/general/interfaz-contable/fwcob/ge_object_121767.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;

PROMPT **** FIN EJECUCIÓN ****
PROMPT CASO             : &CASO
PROMPT Fecha fin        : &fecha_fin
PROMPT =========================================

set timing off
set serveroutput off
quit
/