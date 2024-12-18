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

prompt "Aplicando src/gascaribe/reglas/121392763.sql"
@src/gascaribe/reglas/121392763.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkservicioschatbot.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkservicioschatbot.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_respuesta_grupo.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldc_respuesta_grupo.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logchatbot.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_logchatbot.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkservicioschatbot.sql"
@src/gascaribe/general/integraciones/paquetes/adm_person.ldci_pkservicioschatbot.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkservicioschatbot.sql"
@src/gascaribe/general/integraciones/sinonimos/adm_person.ldci_pkservicioschatbot.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3037_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-3037_actualizar_obj_migrados.sql

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