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


prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_items_tipo_at_val.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_items_tipo_at_val.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ldc_variattr.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ldc_variattr.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_variable.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_variable.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/if_maint_itemser.sql"
@src/gascaribe/gestion-ordenes/sinonimos/if_maint_itemser.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/if_maintenance_exc.sql"
@src/gascaribe/metrologia/sinonimos/if_maintenance_exc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_equivalenc_values.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_equivalenc_values.sql

prompt "Aplicando src/gascaribe/general/sinonimos/or_uni_item_bala_mov.sql"
@src/gascaribe/general/sinonimos/or_uni_item_bala_mov.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_items_gama_item.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_items_gama_item.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/ge_lab_template.sql"
@src/gascaribe/metrologia/sinonimos/ge_lab_template.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_lab_template.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_lab_template.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/if_maint_itseexc_att.sql"
@src/gascaribe/metrologia/sinonimos/if_maint_itseexc_att.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/or_item_pattern.sql"
@src/gascaribe/metrologia/sinonimos/or_item_pattern.sql

prompt "Aplicando src/gascaribe/metrologia/paquetes/adm_person.pkg_or_item_pattern.sql"
@src/gascaribe/metrologia/paquetes/adm_person.pkg_or_item_pattern.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/adm_person.pkg_or_item_pattern.sql"
@src/gascaribe/metrologia/sinonimos/adm_person.pkg_or_item_pattern.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/or_order_act_measure.sql"
@src/gascaribe/metrologia/sinonimos/or_order_act_measure.sql

prompt "Aplicando src/gascaribe/metrologia/paquetes/adm_person.pkg_or_order_act_measure.sql"
@src/gascaribe/metrologia/paquetes/adm_person.pkg_or_order_act_measure.sql

prompt "Aplicando src/gascaribe/metrologia/sinonimos/adm_person.pkg_or_order_act_measure.sql"
@src/gascaribe/metrologia/sinonimos/adm_person.pkg_or_order_act_measure.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcunidadoperativa.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcunidadoperativa.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcunidadoperativa.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_bcunidadoperativa.sql

prompt "Aplicando src/gascaribe/general/materiales/paquetes/adm_person.pkg_ge_items_seriado.sql"
@src/gascaribe/general/materiales/paquetes/adm_person.pkg_ge_items_seriado.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bcpersonal.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bcpersonal.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_position_type.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_position_type.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/or_order_person.sql"
@src/gascaribe/gestion-ordenes/sinonimos/or_order_person.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_task_type.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_task_type.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_task_type.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_task_type.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_boutilidadesnumerico.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_boutilidadesnumerico.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_boutilidadesnumerico.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_boutilidadesnumerico.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/ge_variable_template.sql"
@src/gascaribe/gestion-ordenes/sinonimos/ge_variable_template.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/package/adm_person.pkg_ge_variable_template.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.pkg_ge_variable_template.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ge_variable_template.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ge_variable_template.sql

prompt "Aplicando src/gascaribe/general/paquetes/pkg_truncate_tablas_open.sql"
@src/gascaribe/general/paquetes/pkg_truncate_tablas_open.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3944_insertar_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3944_insertar_homologacion_servicios.sql


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

