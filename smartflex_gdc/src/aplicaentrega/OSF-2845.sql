column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2845"
prompt "-----------------"

prompt "-----paquete LDC_BODIFERIDOSPASOPREPAGO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bodiferidospasoprepago.sql"
@src/gascaribe/cartera/medidores-prepago/paquetes/ldc_bodiferidospasoprepago.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dacc_grace_period.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.dacc_grace_period.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_cc_grace_peri_d_185489.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.seq_cc_grace_peri_d_185489.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.procesos.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.procesos.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_config_contingenc.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.ldc_config_contingenc.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bodiferidospasoprepago.sql"
@src/gascaribe/cartera/medidores-prepago/paquetes/adm_person.ldc_bodiferidospasoprepago.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bodiferidospasoprepago.sql"
@src/gascaribe/cartera/medidores-prepago/sinonimos/adm_person.ldc_bodiferidospasoprepago.sql


prompt "-----paquete LD_PK_ACTLISTPRECOFER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_pk_actlistprecofer.sql"
@src/gascaribe/contratacion/paquetes/ld_pk_actlistprecofer.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_pk_actlistprecofer.sql"
@src/gascaribe/contratacion/paquetes/adm_person.ld_pk_actlistprecofer.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_pk_actlistprecofer.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ld_pk_actlistprecofer.sql


prompt "-----paquete LDC_BCIMPRDOCU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bcimprdocu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bcimprdocu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.sa_boexecutable.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.sa_boexecutable.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bcprocess_schedule.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ge_bcprocess_schedule.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bcimprdocu.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ldc_bcimprdocu.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bcimprdocu.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_bcimprdocu.sql


prompt "-----paquete PKLD_FA_AUDIACE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkld_fa_audiace.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_audiace.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_fa_audidesc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_audidesc.sql

prompt "--->Aplicando creacion de paquete adm_person.pkld_fa_audiace.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_audiace.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkld_fa_audiace.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_audiace.sql


prompt "-----paquete PKLD_FA_BCHISTOCADE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkld_fa_bchistocade.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bchistocade.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_fa_histcade.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_histcade.sql

prompt "--->Aplicando creacion de paquete adm_person.pkld_fa_bchistocade.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bchistocade.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkld_fa_bchistocade.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bchistocade.sql


prompt "-----paquete PKLD_FA_BCLOGPROCDESCPP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN pkld_fa_bclogprocdescpp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/pkld_fa_bclogprocdescpp.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_fa_loprdppe.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_loprdppe.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_fa_loprdppd.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_loprdppd.sql

prompt "--->Aplicando creacion de paquete adm_person.pkld_fa_bclogprocdescpp.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkld_fa_bclogprocdescpp.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.pkld_fa_bclogprocdescpp.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkld_fa_bclogprocdescpp.sql


prompt "-----paquete LD_BCEXECUTEDRELMARKET-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bcexecutedrelmarket.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcexecutedrelmarket.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bcexecutedrelmarket.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcexecutedrelmarket.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bcexecutedrelmarket.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcexecutedrelmarket.sql


prompt "-----paquete LD_BCFNBWARRANTY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bcfnbwarranty.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcfnbwarranty.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_non_ban_fi_item.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_non_ban_fi_item.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_article.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_article.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bcfnbwarranty.sql"
@src/gascaribe/fnb/paquetes/adm_person.ld_bcfnbwarranty.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bcfnbwarranty.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcfnbwarranty.sql


prompt "-----paquete LDC_BCCOMMERCIALSEGMENTFNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bccommercialsegmentfnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccommercialsegmentfnb.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dald_credit_quota.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_credit_quota.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dald_policy_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_policy_historic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dald_quota_block.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_quota_block.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daldc_segment_susc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.daldc_segment_susc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bogeogra_location.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ge_bogeogra_location.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_bcnonbankfinancing.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bcnonbankfinancing.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_policy_by_cred_quot.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_policy_by_cred_quot.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_policy_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_policy_historic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_quota_by_subsc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_by_subsc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ld_quota_historic.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_quota_historic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_segment_susc.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_segment_susc.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.movidife.sql"
@src/gascaribe/fnb/sinonimos/adm_person.movidife.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_bocommercialsegmentfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bocommercialsegmentfnb.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bccommercialsegmentfnb.sql"
@src/gascaribe/fnb/paquetes/adm_person.ldc_bccommercialsegmentfnb.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bccommercialsegmentfnb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_bccommercialsegmentfnb.sql


prompt "-----paquete LD_BCASIGSUBSIDY-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bcasigsubsidy.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcasigsubsidy.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bcasigsubsidy.sql"
@src/gascaribe/fnb/seguros/paquetes/adm_person.ld_bcasigsubsidy.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bcasigsubsidy.sql"
@src/gascaribe/fnb/seguros/sinonimos/adm_person.ld_bcasigsubsidy.sql


prompt "-----paquete DALDCI_TRSOITEM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldci_trsoitem.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldci_trsoitem.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldci_trsoitem.sql"
@src/gascaribe/general/sinonimos/adm_person.ldci_trsoitem.sql

prompt "--->Aplicando creacion de paquete adm_person.daldci_trsoitem.sql"
@src/gascaribe/general/paquetes/adm_person.daldci_trsoitem.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.daldci_trsoitem.sql"
@src/gascaribe/general/sinonimos/adm_person.daldci_trsoitem.sql


prompt "-----paquete EXPRESAR_EN_LETRAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN expresar_en_letras.sql"
@src/gascaribe/papelera-reciclaje/paquetes/expresar_en_letras.sql

prompt "--->Aplicando creacion de paquete adm_person.expresar_en_letras.sql"
@src/gascaribe/general/paquetes/adm_person.expresar_en_letras.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.expresar_en_letras.sql"
@src/gascaribe/general/sinonimos/adm_person.expresar_en_letras.sql


prompt "-----paquete LD_BCGASSUBSCRIPTION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bcgassubscription.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcgassubscription.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dapr_component.sql"
@src/gascaribe/general/sinonimos/adm_person.dapr_component.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bcgassubscription.sql"
@src/gascaribe/general/paquetes/adm_person.ld_bcgassubscription.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bcgassubscription.sql"
@src/gascaribe/general/sinonimos/adm_person.ld_bcgassubscription.sql


prompt "-----paquete LDC_AB_BOADDRESSCHANGE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_ab_boaddresschange.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_ab_boaddresschange.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_address_change.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_address_change.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bcaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bcaddress.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bcaddresschange.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bcaddresschange.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_boaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_boaddress.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_boaddressparser.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_boaddressparser.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_boconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_boconstants.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_boparser.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_boparser.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_boparserwrap.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_boparserwrap.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bopremise.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bopremise.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_boregistropredio.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_boregistropredio.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bosequence.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_change_status.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_change_status.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_module_changer.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_module_changer.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_address_change.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_address_change.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_info_premise.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_info_premise.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_module_changer.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_module_changer.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_predio_tipo_inst.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_predio_tipo_inst.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_premise.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_premise.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dage_object.sql"
@src/gascaribe/general/sinonimos/adm_person.dage_object.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bcgeogra_location.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bcgeogra_location.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bonotification.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bonotification.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bosequence.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bosequence.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.if_boelement.sql"
@src/gascaribe/general/sinonimos/adm_person.if_boelement.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_ab_boaddressparser.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_ab_boaddressparser.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_boaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_boaddress.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pr_bsproduct.sql"
@src/gascaribe/general/sinonimos/adm_person.pr_bsproduct.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ut_java.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_java.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_ab_boaddresschange.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_ab_boaddresschange.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_ab_boaddresschange.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_ab_boaddresschange.sql


prompt "-----paquete LDC_AB_BOPARSER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_ab_boparser.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_ab_boparser.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bcparser.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bcparser.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bogeometria.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bogeometria.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bosegment.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bosegment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_domain.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_domain.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_domain_comp.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_domain_comp.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_domain_values.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_domain_values.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_token_hierarchy.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_token_hierarchy.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_way_by_location.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_way_by_location.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.bd_gramatica.sql"
@src/gascaribe/general/sinonimos/adm_person.bd_gramatica.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_domain.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_domain.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_domain_comp.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_domain_comp.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_segments.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_segments.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_way_by_location.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_way_by_location.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.dabd_gramatica.sql"
@src/gascaribe/general/sinonimos/adm_person.dabd_gramatica.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_bogeneralutil.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_bogeneralutil.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.gr_boconfig_expression.sql"
@src/gascaribe/general/sinonimos/adm_person.gr_boconfig_expression.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_bovalidcross.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_bovalidcross.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ab_way_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ab_way_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daab_domain_values.sql"
@src/gascaribe/general/sinonimos/adm_person.daab_domain_values.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_ab_boparser.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_ab_boparser.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_ab_boparser.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_ab_boparser.sql


prompt "-----paquete LDC_BOCONSTANS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_boconstans.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boconstans.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_boconstans.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_boconstans.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_boconstans.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_boconstans.sql


prompt "-----paquete LDC_PKG_CHANGSTATESOLICI-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkg_changstatesolici.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkg_changstatesolici.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pr_boretire.sql"
@src/gascaribe/general/sinonimos/adm_person.pr_boretire.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_boactionparameter.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_boactionparameter.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_bccomponent.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bccomponent.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_bostatusparameter.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bostatusparameter.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pr_boconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.pr_boconstants.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ps_motive_type.sql"
@src/gascaribe/general/sinonimos/adm_person.ps_motive_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bobundlingprocess.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_bobundlingprocess.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_boactioncontroller.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_boactioncontroller.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_bcmotive.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bcmotive.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daps_product_status.sql"
@src/gascaribe/general/sinonimos/adm_person.daps_product_status.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ps_motive_action.sql"
@src/gascaribe/general/sinonimos/adm_person.ps_motive_action.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_bouncompositionconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bouncompositionconstants.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ps_bomotivetype.sql"
@src/gascaribe/general/sinonimos/adm_person.ps_bomotivetype.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_action_module.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_action_module.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.mo_boconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_boconstants.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkg_changstatesolici.sql"
@src/gascaribe/general/paquetes/adm_person.ldc_pkg_changstatesolici.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkg_changstatesolici.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pkg_changstatesolici.sql


prompt "-----paquete DAPE_TASK_TYPE_TAX-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN dape_task_type_tax.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dape_task_type_tax.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pe_task_type_tax.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pe_task_type_tax.sql

prompt "--->Aplicando creacion de paquete adm_person.dape_task_type_tax.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.dape_task_type_tax.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.dape_task_type_tax.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dape_task_type_tax.sql


prompt "-----paquete LD_BCEXECCONUNISEGDEG-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bcexecconunisegdeg.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcexecconunisegdeg.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bcexecconunisegdeg.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ld_bcexecconunisegdeg.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bcexecconunisegdeg.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_bcexecconunisegdeg.sql


prompt "-----paquete LD_UNIT_OPER_INDUS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_unit_oper_indus.sql"
@src/gascaribe/gestion-ordenes/package/ld_unit_oper_indus.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkstatusexeprogrammgr.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkstatusexeprogrammgr.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_unit_oper_indus.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ld_unit_oper_indus.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_unit_oper_indus.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_unit_oper_indus.sql


prompt "-----paquete LDC_BCREVOKEOTS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bcrevokeots.sql"
@src/gascaribe/gestion-ordenes/package/ldc_bcrevokeots.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_log_pamot.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_log_pamot.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ut_mail.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ut_mail.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bcrevokeots.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_bcrevokeots.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bcrevokeots.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_bcrevokeots.sql


prompt "-----paquete LD_BCAPPROVE_SALES_ORDER-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bcapprove_sales_order.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcapprove_sales_order.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bcapprove_sales_order.sql"
@src/gascaribe/ventas/paquetes/adm_person.ld_bcapprove_sales_order.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bcapprove_sales_order.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_bcapprove_sales_order.sql


prompt "-----paquete LD_BCLEGALIZESALE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ld_bclegalizesale.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bclegalizesale.sql

prompt "--->Aplicando creacion de paquete adm_person.ld_bclegalizesale.sql"
@src/gascaribe/ventas/paquetes/adm_person.ld_bclegalizesale.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ld_bclegalizesale.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_bclegalizesale.sql


prompt "-----paquete LDC_BCSALESCOMMISSION_NEL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_bcsalescommission_nel.sql"
@src/gascaribe/ventas/comisiones/paquetes/ldc_bcsalescommission_nel.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_operating_zone.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.or_operating_zone.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.fa_uiprocesosfact.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.fa_uiprocesosfact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_comi_tarifa_nel.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_comi_tarifa_nel.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ta_taricopr.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ta_taricopr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daor_operating_sector.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.daor_operating_sector.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_vent_exc_comision.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_vent_exc_comision.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_comision_plan_nel.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_comision_plan_nel.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.or_zona_base_adm.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.or_zona_base_adm.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ta_vigetacp.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ta_vigetacp.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ldc_vent_exc_comision.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.seq_ldc_vent_exc_comision.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_or_order_comment.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.seq_or_order_comment.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_info_oper_unit_nel.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_info_oper_unit_nel.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daor_extern_systems_id.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.daor_extern_systems_id.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_log_salescomission.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_log_salescomission.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkg_or_item_detail.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_pkg_or_item_detail.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bcsalescommission_nel.sql"
@src/gascaribe/ventas/comisiones/paquetes/adm_person.ldc_bcsalescommission_nel.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bcsalescommission_nel.sql"
@src/gascaribe/ventas/comisiones/sinonimos/adm_person.ldc_bcsalescommission_nel.sql


prompt "-----Script OSF-2845_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2845_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2845-----"
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
