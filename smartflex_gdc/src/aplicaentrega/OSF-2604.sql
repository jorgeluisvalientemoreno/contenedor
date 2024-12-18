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

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_repintecontable.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_repintecontable.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcirepintcontl.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcirepintcontl.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/paquetes/ldc_repleyventaateclie.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldc_repleyventaateclie.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_repleyventaateclie1.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_repleyventaateclie1.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_repplanoateclie.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_repplanoateclie.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/pkg_emails.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkg_emails.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bcpreliquidaciongc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcpreliquidaciongc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/pbpgc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pbpgc.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/ldc_managementemailfnb.sql"
@src/gascaribe/fnb/paquetes/ldc_managementemailfnb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ld_boportafolio.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boportafolio.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_daveing.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_daveing.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_daveingtemp.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_daveingtemp.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_logproc.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_logproc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.mo_data_for_order.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_data_for_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_generavtingvis.sql"
@src/gascaribe/gestion-ordenes/package/ldc_generavtingvis.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/adm_person.ldc_generavtingvis.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.ldc_generavtingvis.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_generavtingvis.sql"
@src/gascaribe/general/sinonimos/ldc_generavtingvis.sql

prompt "Aplicando src/gascaribe/general/paquetes/ldc_pkgestionitems.sql"
@src/gascaribe/general/paquetes/ldc_pkgestionitems.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/ldc_pkggenordadmoviles.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkggenordadmoviles.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2604_upd_ge_items_description.sql"
@src/gascaribe/datafix/OSF-2604_upd_ge_items_description.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2604_actualizar_obj_migrados.sql" 
@src/gascaribe/general/sql/OSF-2604_actualizar_obj_migrados.sql

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