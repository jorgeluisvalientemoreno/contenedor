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

prompt "Aplicando src/gascaribe/datafix/OSF-2764_marcar_objetos.sql"
@src/gascaribe/datafix/OSF-2764_marcar_objetos.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/direcciones_n.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/direcciones_n.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/masterdirecciones.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/masterdirecciones.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/pr_ab_address_n.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/pr_ab_address_n.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/pr_ab_address_t.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/pr_ab_address_t.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/pr_ab_address.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/pr_ab_address.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/pr_direcciones_n.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/pr_direcciones_n.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/procquitaespaciososf.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/procquitaespaciososf.sql

prompt "Aplicando src/gascaribe/objetos-obsoletos/procedimientos/os_emergency_order.sql"
@src/gascaribe/objetos-obsoletos/procedimientos/os_emergency_order.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148798.sql"
@src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148798.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148799.sql"
@src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148799.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148800.sql"
@src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148800.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148801.sql"
@src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148801.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148802.sql"
@src/gascaribe/papelera-reciclaje/funciones/gcfifa_ct49e121148802.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_detallefact_surtigas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_detallefact_surtigas.sql


prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcontrolnotificaintegra.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkcontrolnotificaintegra.sql

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