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

-- Inicio Creación sinonimos privados objetos OPEN
prompt "Aplicando src/gascaribe/general/sinonimos/aucamcons.sql"
@src/gascaribe/general/sinonimos/aucamcons.sql

prompt "Aplicando src/gascaribe/general/sinonimos/fa_apromofa.sql"
@src/gascaribe/general/sinonimos/fa_apromofa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/gc_boconstants.sql"
@src/gascaribe/general/sinonimos/gc_boconstants.sql

prompt "Aplicando src/gascaribe/general/sinonimos/hicaespr.sql"
@src/gascaribe/general/sinonimos/hicaespr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_instance.sql"
@src/gascaribe/general/sinonimos/ldcbi_instance.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_mo_motive.sql"
@src/gascaribe/general/sinonimos/ldcbi_mo_motive.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_notas.sql"
@src/gascaribe/general/sinonimos/ldcbi_notas.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_comment.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_comment.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_items.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_items.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_person.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_person.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_order_stat_change.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_order_stat_change.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_or_related_order.sql"
@src/gascaribe/general/sinonimos/ldcbi_or_related_order.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_pagos.sql"
@src/gascaribe/general/sinonimos/ldcbi_pagos.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_pr_product.sql"
@src/gascaribe/general/sinonimos/ldcbi_pr_product.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_servsusc.sql"
@src/gascaribe/general/sinonimos/ldcbi_servsusc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldcbi_suscripc.sql"
@src/gascaribe/general/sinonimos/ldcbi_suscripc.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldci_package_camunda_log.sql"
@src/gascaribe/general/sinonimos/ldci_package_camunda_log.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldci_seqhicaespr.sql"
@src/gascaribe/general/sinonimos/ldci_seqhicaespr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldci_servnuev_evidenci_gestion.sql"
@src/gascaribe/general/sinonimos/ldci_servnuev_evidenci_gestion.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldci_servnuev_log_or_order.sql"
@src/gascaribe/general/sinonimos/ldci_servnuev_log_or_order.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_boregistroproducto.sql"
@src/gascaribe/general/sinonimos/ldc_boregistroproducto.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_confplcaes.sql"
@src/gascaribe/general/sinonimos/ldc_confplcaes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tasktype_contype_hist.sql"
@src/gascaribe/general/sinonimos/ldc_tasktype_contype_hist.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_tmp_ot_gis.sql"
@src/gascaribe/general/sinonimos/ldc_tmp_ot_gis.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ld_parameter_innova.sql"
@src/gascaribe/general/sinonimos/ld_parameter_innova.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pkexecutedprocessmgr.sql"
@src/gascaribe/general/sinonimos/pkexecutedprocessmgr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pkld_fa_bcapplicationpdd.sql"
@src/gascaribe/general/sinonimos/pkld_fa_bcapplicationpdd.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pksessionmgr.sql"
@src/gascaribe/general/sinonimos/pksessionmgr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/seq_ge_error_log.sql"
@src/gascaribe/general/sinonimos/seq_ge_error_log.sql

prompt "Aplicando src/gascaribe/general/sinonimos/seq_ldc_usuarios_actualiza_cl.sql"
@src/gascaribe/general/sinonimos/seq_ldc_usuarios_actualiza_cl.sql

prompt "Aplicando src/gascaribe/general/sinonimos/so_boerrors.sql"
@src/gascaribe/general/sinonimos/so_boerrors.sql

prompt "Aplicando src/gascaribe/general/sinonimos/so_execution_status.sql"
@src/gascaribe/general/sinonimos/so_execution_status.sql

prompt "Aplicando src/gascaribe/general/sinonimos/so_operative_solution.sql"
@src/gascaribe/general/sinonimos/so_operative_solution.sql

prompt "Aplicando src/gascaribe/general/sinonimos/sq_ldc_tasktype_contype_hist.sql"
@src/gascaribe/general/sinonimos/sq_ldc_tasktype_contype_hist.sql
-- Fin Creación sinonimos privados objetos OPEN

-- Inicio Borrado de triggers en OPEN papelera
prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgafterinscuencobr.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgafterinscuencobr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaftinserteservsusc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaftinserteservsusc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaftupdateservsusc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaftupdateservsusc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaf_ab_address.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaf_ab_address.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgairld_pagos.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgairld_pagos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiudrsinlocamere.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiudrsinlocamere.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgaiudrsinmercrele.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgaiudrsinmercrele.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauallocatequotebalance.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauallocatequotebalance.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauallocatequoteesfn.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauallocatequoteesfn.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgauld_applicationpdd.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgauld_applicationpdd.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgau_or_order.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgau_or_order.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbdrldc_tasktype_contype.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbdrldc_tasktype_contype.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbdropersolexecut.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbdropersolexecut.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbdropersolinstal.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbdropersolinstal.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbirconssesu.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbirconssesu.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgburor_operating_unit.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgburor_operating_unit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbusetaccountingdate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbusetaccountingdate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgbusetpaymentdate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgbusetpaymentdate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trginsertldc_tasktype_contype.sql"
@src/gascaribe/papelera-reciclaje/triggers/trginsertldc_tasktype_contype.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgldc_after_reg_espro.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgldc_after_reg_espro.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgprcertificate.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgprcertificate.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trgupordervalue.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgupordervalue.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ins_sucubanc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ins_sucubanc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_mo_motive.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_mo_motive.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_notas.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_notas.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_comment.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_comment.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_items.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_items.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_person.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_person.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_stat_change.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_order_stat_change.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_related_order.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_or_related_order.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_pagos.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_pagos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_pr_product.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_pr_product.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_servsusc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_servsusc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_suscripc.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ldcbi_suscripc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_mo_packages_99.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_mo_packages_99.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_ot_previa_instid.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_ot_previa_instid.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_restrict_servnuev_evidenci.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_restrict_servnuev_evidenci.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_solicitud_faju99.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_solicitud_faju99.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_upd_after_diferido.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_upd_after_diferido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_validabodega.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_validabodega.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_valid_plan_comer.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_valid_plan_comer.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_valid_pr_product.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_valid_pr_product.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_val_mov_bodega.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_val_mov_bodega.sql
-- Fin Borrado de triggers en OPEN papelera

-- Inicio Borrado de triggers en OPEN carpetas de funcionalidades
prompt "Aplicando src/gascaribe/contratacion/trigger/trgactulistnove.sql"
@src/gascaribe/contratacion/trigger/trgactulistnove.sql

prompt "Aplicando src/gascaribe/cartera/insolvencia/triggers/trgauchgsubstype.sql"
@src/gascaribe/cartera/insolvencia/triggers/trgauchgsubstype.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/trigger/trgfinanprioritygdc.sql"
@src/gascaribe/cartera/negociacion-deuda/trigger/trgfinanprioritygdc.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_OR_ORDER_CXC.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_OR_ORDER_CXC.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_CXC_CERTIFICADO.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_CXC_CERTIFICADO.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_LEGALIZA_SERVNUEV.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_LEGALIZA_SERVNUEV.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_SERVNUEV.sql"
@src/gascaribe/servicios-nuevos/triggers/TRG_RESTRICT_SERVNUEV.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/trg_ult_ot_rp.sql"
@src/gascaribe/revision-periodica/triggers/trg_ult_ot_rp.sql

prompt "Aplicando src/gascaribe/general/general_log/triggers/trgauchangestatfinan.sql"
@src/gascaribe/general/general_log/triggers/trgauchangestatfinan.sql

prompt "Aplicando src/gascaribe/general/general_log/triggers/trgauchangestatsusp.sql"
@src/gascaribe/general/general_log/triggers/trgauchangestatsusp.sql
-- Fin Borrado de triggers en OPEN carpetas funcionalidades

-- Inicio Creacion de triggers en ADM_PERSON en carpeta general
prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgafterinscuencobr.sql"
@src/gascaribe/general/trigger/adm_person.trgafterinscuencobr.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgaftinserteservsusc.sql"
@src/gascaribe/general/trigger/adm_person.trgaftinserteservsusc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgaftupdateservsusc.sql"
@src/gascaribe/general/trigger/adm_person.trgaftupdateservsusc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgaf_ab_address.sql"
@src/gascaribe/general/trigger/adm_person.trgaf_ab_address.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgairld_pagos.sql"
@src/gascaribe/general/trigger/adm_person.trgairld_pagos.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgaiudrsinlocamere.sql"
@src/gascaribe/general/trigger/adm_person.trgaiudrsinlocamere.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgaiudrsinmercrele.sql"
@src/gascaribe/general/trigger/adm_person.trgaiudrsinmercrele.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgauallocatequotebalance.sql"
@src/gascaribe/general/trigger/adm_person.trgauallocatequotebalance.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgauallocatequoteesfn.sql"
@src/gascaribe/general/trigger/adm_person.trgauallocatequoteesfn.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgauld_applicationpdd.sql"
@src/gascaribe/general/trigger/adm_person.trgauld_applicationpdd.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgau_or_order.sql"
@src/gascaribe/general/trigger/adm_person.trgau_or_order.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbdrldc_tasktype_contype.sql"
@src/gascaribe/general/trigger/adm_person.trgbdrldc_tasktype_contype.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbdropersolexecut.sql"
@src/gascaribe/general/trigger/adm_person.trgbdropersolexecut.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbdropersolinstal.sql"
@src/gascaribe/general/trigger/adm_person.trgbdropersolinstal.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbirconssesu.sql"
@src/gascaribe/general/trigger/adm_person.trgbirconssesu.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgburor_operating_unit.sql"
@src/gascaribe/general/trigger/adm_person.trgburor_operating_unit.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbusetaccountingdate.sql"
@src/gascaribe/general/trigger/adm_person.trgbusetaccountingdate.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgbusetpaymentdate.sql"
@src/gascaribe/general/trigger/adm_person.trgbusetpaymentdate.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trginsertldc_tasktype_contype.sql"
@src/gascaribe/general/trigger/adm_person.trginsertldc_tasktype_contype.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgldc_after_reg_espro.sql"
@src/gascaribe/general/trigger/adm_person.trgldc_after_reg_espro.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgprcertificate.sql"
@src/gascaribe/general/trigger/adm_person.trgprcertificate.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trgupordervalue.sql"
@src/gascaribe/general/trigger/adm_person.trgupordervalue.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ins_sucubanc.sql"
@src/gascaribe/general/trigger/adm_person.trg_ins_sucubanc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_mo_motive.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_mo_motive.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_notas.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_notas.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_comment.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_comment.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_items.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_items.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_person.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_person.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_stat_change.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_order_stat_change.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_related_order.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_or_related_order.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_pagos.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_pagos.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_pr_product.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_pr_product.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_servsusc.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_servsusc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ldcbi_suscripc.sql"
@src/gascaribe/general/trigger/adm_person.trg_ldcbi_suscripc.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_mo_packages_99.sql"
@src/gascaribe/general/trigger/adm_person.trg_mo_packages_99.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_ot_previa_instid.sql"
@src/gascaribe/general/trigger/adm_person.trg_ot_previa_instid.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_restrict_servnuev_evidenci.sql"
@src/gascaribe/general/trigger/adm_person.trg_restrict_servnuev_evidenci.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_solicitud_faju99.sql"
@src/gascaribe/general/trigger/adm_person.trg_solicitud_faju99.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_upd_after_diferido.sql"
@src/gascaribe/general/trigger/adm_person.trg_upd_after_diferido.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_validabodega.sql"
@src/gascaribe/general/trigger/adm_person.trg_validabodega.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_valid_plan_comer.sql"
@src/gascaribe/general/trigger/adm_person.trg_valid_plan_comer.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_valid_pr_product.sql"
@src/gascaribe/general/trigger/adm_person.trg_valid_pr_product.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.trg_val_mov_bodega.sql"
@src/gascaribe/general/trigger/adm_person.trg_val_mov_bodega.sql
-- Fin Creacion de triggers en ADM_PERSON en carpeta general

-- Inicio Creacion de triggers en ADM_PERSON en carpetas de funcionalidades
prompt "Aplicando src/gascaribe/contratacion/trigger/adm_person.trgactulistnove.sql"
@src/gascaribe/contratacion/trigger/adm_person.trgactulistnove.sql

prompt "Aplicando src/gascaribe/cartera/insolvencia/triggers/adm_person.trgauchgsubstype.sql"
@src/gascaribe/cartera/insolvencia/triggers/adm_person.trgauchgsubstype.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/trigger/adm_person.trgfinanprioritygdc.sql"
@src/gascaribe/cartera/negociacion-deuda/trigger/adm_person.trgfinanprioritygdc.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.trg_or_order_cxc.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.trg_or_order_cxc.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.trg_restrict_cxc_certificado.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.trg_restrict_cxc_certificado.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.trg_restrict_legaliza_servnuev.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.trg_restrict_legaliza_servnuev.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/triggers/adm_person.trg_restrict_servnuev.sql"
@src/gascaribe/servicios-nuevos/triggers/adm_person.trg_restrict_servnuev.sql

prompt "Aplicando src/gascaribe/revision-periodica/triggers/adm_person.trg_ult_ot_rp.sql"
@src/gascaribe/revision-periodica/triggers/adm_person.trg_ult_ot_rp.sql

prompt "Aplicando src/gascaribe/general/general_log/triggers/adm_person.trgauchangestatfinan.sql"
@src/gascaribe/general/general_log/triggers/adm_person.trgauchangestatfinan.sql

prompt "Aplicando src/gascaribe/general/general_log/triggers/adm_person.trgauchangestatsusp.sql"
@src/gascaribe/general/general_log/triggers/adm_person.trgauchangestatsusp.sql
-- Inicio Creacion de triggers en ADM_PERSON en carpetas de funcionalidades

-- Inicio actualización Master_Personalizaciones
prompt "Aplicando src/gascaribe/datafix/OSF-3453_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-3453_act_obj_mig.sql
-- Fin actualización Master_Personalizaciones

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
