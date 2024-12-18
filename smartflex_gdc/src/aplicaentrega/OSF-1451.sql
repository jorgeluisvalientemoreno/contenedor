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

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_person.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_person.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/au_audit_policy_log.sql"
@src/gascaribe/objetos-producto/sinonimos/au_audit_policy_log.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/sistema.sql"
@src/gascaribe/objetos-producto/sinonimos/sistema.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_items_seriado.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_items_seriado.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ps_package_type.sql"
@src/gascaribe/objetos-producto/sinonimos/ps_package_type.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ta_vigetaco.sql"
@src/gascaribe/objetos-producto/sinonimos/ta_vigetaco.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/diferido.sql"
@src/gascaribe/objetos-producto/sinonimos/diferido.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_task_type.sql"
@src/gascaribe/objetos-producto/sinonimos/or_task_type.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_task_types_items.sql"
@src/gascaribe/objetos-producto/sinonimos/or_task_types_items.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_contratista.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_contratista.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pagos.sql"
@src/gascaribe/objetos-producto/sinonimos/pagos.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_message.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_message.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/estacort.sql"
@src/gascaribe/objetos-producto/sinonimos/estacort.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/sa_user.sql"
@src/gascaribe/objetos-producto/sinonimos/sa_user.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_geogra_location.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_geogra_location.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order_status.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order_status.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_directory.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_directory.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pericose.sql"
@src/gascaribe/objetos-producto/sinonimos/pericose.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/categori.sql"
@src/gascaribe/objetos-producto/sinonimos/categori.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/plandife.sql"
@src/gascaribe/objetos-producto/sinonimos/plandife.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_acta.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_acta.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cuencobr.sql"
@src/gascaribe/objetos-producto/sinonimos/cuencobr.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_parameter.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_parameter.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/elmesesu.sql"
@src/gascaribe/objetos-producto/sinonimos/elmesesu.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_related_order.sql"
@src/gascaribe/objetos-producto/sinonimos/or_related_order.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_financing_request.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_financing_request.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_attention_data.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_attention_data.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/au_log_policy.sql"
@src/gascaribe/objetos-producto/sinonimos/au_log_policy.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/servicio.sql"
@src/gascaribe/objetos-producto/sinonimos/servicio.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_log_process.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_log_process.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/subcateg.sql"
@src/gascaribe/objetos-producto/sinonimos/subcateg.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ab_premise.sql"
@src/gascaribe/objetos-producto/sinonimos/ab_premise.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/lectelme.sql"
@src/gascaribe/objetos-producto/sinonimos/lectelme.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order_items.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order_items.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/factura.sql"
@src/gascaribe/objetos-producto/sinonimos/factura.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ciclo.sql"
@src/gascaribe/objetos-producto/sinonimos/ciclo.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_process_schedule.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_process_schedule.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/rangliqu.sql"
@src/gascaribe/objetos-producto/sinonimos/rangliqu.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ic_cartcoco.sql"
@src/gascaribe/objetos-producto/sinonimos/ic_cartcoco.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_contrato.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_contrato.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_oper_unit_persons.sql"
@src/gascaribe/objetos-producto/sinonimos/or_oper_unit_persons.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cargos.sql"
@src/gascaribe/objetos-producto/sinonimos/cargos.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cupon.sql"
@src/gascaribe/objetos-producto/sinonimos/cupon.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_unit_cost_ite_lis.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_unit_cost_ite_lis.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_entity.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_entity.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/estaprog.sql"
@src/gascaribe/objetos-producto/sinonimos/estaprog.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/concepto.sql"
@src/gascaribe/objetos-producto/sinonimos/concepto.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/perifact.sql"
@src/gascaribe/objetos-producto/sinonimos/perifact.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/notas.sql"
@src/gascaribe/objetos-producto/sinonimos/notas.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/conssesu.sql"
@src/gascaribe/objetos-producto/sinonimos/conssesu.sql
prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_quotation.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_quotation.sql


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