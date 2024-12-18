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


prompt  "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.dage_acta.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.dage_acta.sql

prompt  "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_tempomensajeweb.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_tempomensajeweb.sql

prompt  "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_log_trace_seq.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_log_trace_seq.sql

prompt  "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_configuracionrq.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_configuracionrq.sql

prompt  "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_pkldccfa.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_pkldccfa.sql

prompt  "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.seq_ldc_certificados_oia_log.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.seq_ldc_certificados_oia_log.sql

prompt  "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_certificados_oia_log.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_certificados_oia_log.sql

prompt  "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_log_trace.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_log_trace.sql

prompt  "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_bccontracttasktype.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_bccontracttasktype.sql

prompt  "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_comment_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_comment_type.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bolockorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bolockorder.sql

prompt  "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.dage_contrato.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.dage_contrato.sql

prompt  "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_boexternalservices.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_boexternalservices.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prbloqueaorden.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prbloqueaorden.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccuadrebodega.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccuadrebodega.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_provalipermordintcons.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provalipermordintcons.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvaluserlega.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvaluserlega.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/prc_seguimiento_cobol.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prc_seguimiento_cobol.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_pr_muestra_de_consumos.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pr_muestra_de_consumos.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccrearegsergprograma.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccrearegsergprograma.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/os_billinginfo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/os_billinginfo.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_buscadeudorori.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_buscadeudorori.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltycartera_c.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progeneranoveltycartera_c.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_suspendacomcontr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_suspendacomcontr.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_actconcceroultplafi2_temp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_actconcceroultplafi2_temp.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_vallistprecvigunitofer.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_vallistprecvigunitofer.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/assignorderaction.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/assignorderaction.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.assignorderaction.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.assignorderaction.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.assignorderaction.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.assignorderaction.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/log_certificados_oia.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/log_certificados_oia.sql

prompt  "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/adm_person.log_certificados_oia.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/adm_person.log_certificados_oia.sql

prompt  "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.log_certificados_oia.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.log_certificados_oia.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_chang_contract_order.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_chang_contract_order.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_chang_contract_order.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_chang_contract_order.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_chang_contract_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_chang_contract_order.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_val_tiemp_fin_eje_ord.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_val_tiemp_fin_eje_ord.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_val_tiemp_fin_eje_ord.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_val_tiemp_fin_eje_ord.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_val_tiemp_fin_eje_ord.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_val_tiemp_fin_eje_ord.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/procostoorden.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/procostoorden.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.procostoorden.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.procostoorden.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.procostoorden.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.procostoorden.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_assign_order.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_assign_order.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_assign_order.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_assign_order.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_assign_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_assign_order.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_validarfechacierremasivo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_validarfechacierremasivo.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_validarfechacierremasivo.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_validarfechacierremasivo.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_validarfechacierremasivo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_validarfechacierremasivo.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proregistrapagoacta.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proregistrapagoacta.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_proregistrapagoacta.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_proregistrapagoacta.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_proregistrapagoacta.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_proregistrapagoacta.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_execactionbytryleg.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_execactionbytryleg.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_execactionbytryleg.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_execactionbytryleg.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_execactionbytryleg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_execactionbytryleg.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_provalidaitemsleguonl.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provalidaitemsleguonl.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_provalidaitemsleguonl.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_provalidaitemsleguonl.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_provalidaitemsleguonl.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_provalidaitemsleguonl.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_log.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcbi_log.sql

prompt  "Aplicando src/gascaribe/general/procedimientos/adm_person.ldcbi_log.sql"
@src/gascaribe/general/procedimientos/adm_person.ldcbi_log.sql

prompt  "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcbi_log.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcbi_log.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_setvaliduserlega.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_setvaliduserlega.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_logorpelegavaluser.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_logorpelegavaluser.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_seguimiento_cobol.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_seguimiento_cobol.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_mues_consumos.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_mues_consumos.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_seguimiento_programa.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_seguimiento_programa.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2671_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2671_actualizar_obj_migrados.sql

prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql


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