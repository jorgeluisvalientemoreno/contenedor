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

-- Ini sinonimos privados
prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/daor_order_items.sql"
@src/gascaribe/gestion-ordenes/sinonimos/daor_order_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_log_items_modif_sin_acta.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_log_items_modif_sin_acta.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_act_ouib.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_act_ouib.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_tt_tb.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_tt_tb.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/or_ope_uni_item_bala.sql"
@src/gascaribe/gestion-ordenes/sinonimos/or_ope_uni_item_bala.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ge_item_classif.sql"
@src/gascaribe/general/sinonimos/ge_item_classif.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_or_order_items_temp.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_or_order_items_temp.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkgasignarcont.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pkgasignarcont.sql
-- Fin sinonimos privados

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_ldc_ciercome.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_ldc_ciercome.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_ldc_ciercome.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_ldc_ciercome.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_items.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_items.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcitems.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcitems.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestionitems.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestionitems.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bogestionitems.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bogestionitems.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ct_order_certifica.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ct_order_certifica.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_ope_uni_item_bala.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_ope_uni_item_bala.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_ope_uni_item_bala.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_ope_uni_item_bala.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldc_act_ouib.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldc_act_ouib.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldc_inv_ouib.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ldc_inv_ouib.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ge_item_classif.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ge_item_classif.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ge_item_classif.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ge_item_classif.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_log_items_modif_sin_ac.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_log_items_modif_sin_ac.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_log_items_modif_sin_ac.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_log_items_modif_sin_ac.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_or_order_items_temp.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_or_order_items_temp.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_or_order_items_temp.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_or_order_items_temp.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcordenes.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_session.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_session.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bogestion_ordenes.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_activity.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_order_activity.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4042_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-4042_homologacion_servicios.sql

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