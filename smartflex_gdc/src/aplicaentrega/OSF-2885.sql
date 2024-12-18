column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2885"
prompt "-----------------"

prompt "-----paquete PKLD_FA_REFERIDO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkld_fa_referido.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_referido.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_fa_referido.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_referido.sql

prompt "--->Aplicando creacion de paquete adm_person.pkld_fa_referido.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_referido.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkld_fa_referido.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_referido.sql


prompt "-----paquete LDC_PKGENOTADIFE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgenotadife.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgenotadife.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblparafact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblparafact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblnotas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblnotas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_document_type.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ge_document_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktbldiferido.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktbldiferido.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.timoempr.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.timoempr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblcargos.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblcargos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.funciona.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.funciona.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcfunciona.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbcfunciona.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_notas_masivas_log.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_notas_masivas_log.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_notas_masivas.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_notas_masivas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblmovidife.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblmovidife.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgenotadife.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_pkgenotadife.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgenotadife.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_pkgenotadife.sql


prompt "-----paquete LD_BOQUERYFNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_boqueryfnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boqueryfnb.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daps_motive_status.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daps_motive_status.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pagunidat.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pagunidat.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_boqueryfnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_boqueryfnb.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_boqueryfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_boqueryfnb.sql


prompt "-----paquete LD_BOFUN_VALI_ENTI_CO_UN-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bofun_vali_enti_co_un.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bofun_vali_enti_co_un.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bofun_vali_enti_co_un.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bofun_vali_enti_co_un.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bofun_vali_enti_co_un.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bofun_vali_enti_co_un.sql


prompt "-----paquete LD_BOVAR_VALIDATE_CO_UN-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bovar_validate_co_un.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bovar_validate_co_un.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bovar_validate_co_un.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bovar_validate_co_un.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bovar_validate_co_un.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bovar_validate_co_un.sql


prompt "-----paquete PKEXPREG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkexpreg.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkexpreg.sql

prompt "--->Aplicando creacion de paquete adm_person.pkexpreg.sql"
@src/gascaribe/general/paquetes/adm_person.pkexpreg.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkexpreg.sql"
@src/gascaribe/general/sinonimos/adm_person.pkexpreg.sql


prompt "-----paquete LDC_BOARCHIVO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_boarchivo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boarchivo.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_boarchivo.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_boarchivo.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_boarchivo.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_boarchivo.sql


prompt "-----paquete LDC_BOMANAGEADDRESS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bomanageaddress.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bomanageaddress.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bomanageaddress.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_bomanageaddress.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bomanageaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_bomanageaddress.sql


prompt "-----paquete FTP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ftp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ftp.sql

prompt "--->Aplicando creacion de paquete adm_person.ftp.sql"
@src/gascaribe/general/paquetes/adm_person.ftp.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ftp.sql"
@src/gascaribe/general/sinonimos/adm_person.ftp.sql


prompt "-----paquete LD_BOSEQUENCE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bosequence.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bosequence.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ge_subscriber.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ge_subscriber.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_approve_sales_order.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_approve_sales_order.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_asig_subsidy.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_asig_subsidy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_bill_pending_payment.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_bill_pending_payment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_cha_sta_sub_audi.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_cha_sta_sub_audi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_con_uni_budget.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_con_uni_budget.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_detail_liquidation.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_detail_liquidation.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_detail_liqui_seller.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_detail_liqui_seller.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_exec_meth.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_exec_meth.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_item_work_order.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_item_work_order.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_liquidation.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_liquidation.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_liquidation_seller.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_liquidation_seller.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_max_recovery.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_max_recovery.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_move_sub.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_move_sub.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_order_cons_unit.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_order_cons_unit.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_policy.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_policy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_propert_by_article.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_propert_by_article.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_quota_block.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_quota_block.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_quota_by_subsc.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_quota_by_subsc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_record_collect.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_record_collect.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_return_item.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_return_item.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_return_item_detail.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_return_item_detail.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_rev_sub_audit.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_rev_sub_audit.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_sales_withoutsubsidy.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_sales_withoutsubsidy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_sub_remain_deliv.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_sub_remain_deliv.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_subsidy.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_subsidy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_subsidy_concept.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_subsidy_concept.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_subsidy_detail.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_subsidy_detail.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_temp_clob_fact.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_temp_clob_fact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_tmp_max_recovery.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_tmp_max_recovery.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ld_ubication.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ld_ubication.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bosequence.sql"
@src/gascaribe/general/paquetes/adm_person.ld_bosequence.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_bosequence.sql


prompt "-----paquete LD_BOUTILFLOW-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_boutilflow.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_boutilflow.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bcreglasclasifica.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_bcreglasclasifica.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daor_sched_available.sql"
@src/gascaribe/general/sinonimos/adm_person.daor_sched_available.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkgenerateindbill.sql"
@src/gascaribe/general/sinonimos/adm_person.pkgenerateindbill.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_sched_available.sql"
@src/gascaribe/general/sinonimos/adm_person.or_sched_available.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_boadminorder.sql"
@src/gascaribe/general/sinonimos/adm_person.or_boadminorder.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_actividad.sql"
@src/gascaribe/general/sinonimos/adm_person.or_actividad.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_boutilflow.sql"
@src/gascaribe/general/paquetes/adm_person.ld_boutilflow.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_boutilflow.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_boutilflow.sql


prompt "-----paquete LDC_REPORTESCONSULTA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_reportesconsulta.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_reportesconsulta.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dacc_commercial_plan.sql"
@src/gascaribe/general/sinonimos/adm_person.dacc_commercial_plan.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pr_timeout_component.sql"
@src/gascaribe/general/sinonimos/adm_person.pr_timeout_component.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_subs_referen_data.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_subs_referen_data.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_tasktype_add_data.sql"
@src/gascaribe/general/sinonimos/adm_person.or_tasktype_add_data.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcelemmedi.sql"
@src/gascaribe/general/sinonimos/adm_person.pkbcelemmedi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.banco.sql"
@src/gascaribe/general/sinonimos/adm_person.banco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_fin_req_concept.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_fin_req_concept.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblciclo.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblciclo.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_phone_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_phone_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbclectelme.sql"
@src/gascaribe/general/sinonimos/adm_person.pkbclectelme.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblelemmedi.sql"
@src/gascaribe/general/sinonimos/adm_person.pktblelemmedi.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ticubanc.sql"
@src/gascaribe/general/sinonimos/adm_person.ticubanc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bosubscriber.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bosubscriber.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_attrib_set_attrib.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_attrib_set_attrib.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_mot_promotion.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_mot_promotion.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_reportesconsulta.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_reportesconsulta.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_reportesconsulta.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_reportesconsulta.sql


prompt "-----paquete LDC_EMAIL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_email.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_email.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dage_parameter.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_parameter.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_email.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_email.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_email.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_email.sql


prompt "-----paquete IC_BOCOMPLETSERVICEINT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ic_bocompletserviceint.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ic_bocompletserviceint.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcconcepto.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkbcconcepto.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblservempr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblservempr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.servempr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.servempr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ic_docugene.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_docugene.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkbcic_docugene.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkbcic_docugene.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkboprocessconcurrencectrl.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkboprocessconcurrencectrl.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkboaccountinginterface.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pkboaccountinginterface.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ic_bopromoproducts.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_bopromoproducts.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblservicio.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblservicio.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ic_bccompletserviceint.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_bccompletserviceint.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.openfltr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.openfltr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblterccobr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblterccobr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_geogra_loca_type.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ge_geogra_loca_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.tmp_cargproc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.tmp_cargproc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblic_movimien.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblic_movimien.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ic_tipodoco.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_tipodoco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ic_bocompletserviceint_gdca.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_bocompletserviceint_gdca.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.terccobr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.terccobr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktblconcterc.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktblconcterc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pktmpchargesmgr.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.pktmpchargesmgr.sql

prompt "--->Aplicando creacion de paquete adm_person.ic_bocompletserviceint.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.ic_bocompletserviceint.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ic_bocompletserviceint.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ic_bocompletserviceint.sql


prompt "-----paquete LDC_PKGASIGNARCONT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgasignarcont.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgasignarcont.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daldc_contfema.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.daldc_contfema.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_conftitrregapo.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_conftitrregapo.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_contfema.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_contfema.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_logprescont.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_logprescont.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgasignarcont.sql"
@src/gascaribe/gestion-contratista/paquetes/adm_person.ldc_pkgasignarcont.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgasignarcont.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_pkgasignarcont.sql


prompt "-----paquete LDC_PKGENERATRAMITERP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgeneratramiterp.sql"
@src/gascaribe/revision-periodica/paquetes/ldc_pkgeneratramiterp.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgeneratramiterp.sql"
@src/gascaribe/revision-periodica/paquetes/adm_person.ldc_pkgeneratramiterp.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgeneratramiterp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgeneratramiterp.sql


prompt "-----paquete LDC_BCCOTIZACIONCOMERCIAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bccotizacioncomercial.sql"
@src/gascaribe/ventas/paquetes/ldc_bccotizacioncomercial.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dacc_quot_financ_cond.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dacc_quot_financ_cond.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_itemscoticomer_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemscoticomer_adic.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bccotizacioncomercial.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bccotizacioncomercial.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bccotizacioncomercial.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bccotizacioncomercial.sql


prompt "-----paquete LDC_BCPROYECTOCONSTRUCTORA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bcproyectoconstructora.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcproyectoconstructora.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bcproyectoconstructora.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_bcproyectoconstructora.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bcproyectoconstructora.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_bcproyectoconstructora.sql


prompt "-----Script OSF-2885_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2885_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2885-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
