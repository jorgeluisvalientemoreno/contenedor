column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2596"
prompt "-----------------"


prompt "-----1.procedimiento LDCPROCREVERSAMARCACAUSFALL-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprocreversamarcacausfall.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprocreversamarcacausfall.sql


prompt "-----2.procedimiento PRINITCOPRSUCA-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N prinitcoprsuca.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/prinitcoprsuca.sql


prompt "-----3.procedimiento LDC_PRUODEFECTO-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pruodefecto.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pruodefecto.sql

 
prompt "-----4.procedimiento LDC_PRONOTIORDEN-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_pronotiorden.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pronotiorden.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldcconford.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcconford.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.dage_reception_type.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dage_reception_type.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ge_notification.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_notification.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ge_xsl_template.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_xsl_template.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_pronotiorden.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pronotiorden.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_pronotiorden.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pronotiorden.sql


prompt "-----5.procedimiento LDCPRRECAFEC-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprrecafec.sql" 
@src/gascaribe/gestion-ordenes/procedure/ldcprrecafec.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.dage_person.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dage_person.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_camfec.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_camfec.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.seq_camfec.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.seq_camfec.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_usercafec.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_usercafec.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprrecafec.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprrecafec.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldcprrecafec.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprrecafec.sql


prompt "-----6.procedimiento LDCPROVALDTADCERTOIA-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprovaldtadcertoia.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprovaldtadcertoia.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprovaldtadcertoia.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprovaldtadcertoia.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldcprovaldtadcertoia.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprovaldtadcertoia.sql


prompt "-----7.procedimiento LDCPRMETODESTRATIFICACION-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprmetodestratificacion.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprmetodestratificacion.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_tipo_metod_estrat.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipo_metod_estrat.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_solici_cam_dat_pred.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_solici_cam_dat_pred.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_tipo_metod_estrat_loc.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tipo_metod_estrat_loc.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprmetodestratificacion.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldcprmetodestratificacion.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldcprmetodestratificacion.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprmetodestratificacion.sql


prompt "-----8.procedimiento LDCI_VALIDA_CERTIF_OIA-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldci_valida_certif_oia.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_valida_certif_oia.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_conf_causal_tipres_cert.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_conf_causal_tipres_cert.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldci_valida_certif_oia.sql" 
@src/gascaribe/revision-periodica/certificados/procedimientos/adm_person.ldci_valida_certif_oia.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldci_valida_certif_oia.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldci_valida_certif_oia.sql


prompt "-----9.procedimiento LDC_VAL_CAUS_APELACION-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_val_caus_apelacion.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_val_caus_apelacion.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.daps_package_type.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.daps_package_type.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_val_caus_apelacion.sql" 
@src/gascaribe/atencion-usuarios/procedimientos/adm_person.ldc_val_caus_apelacion.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_val_caus_apelacion.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_val_caus_apelacion.sql


prompt "-----10.procedimiento PRTEMPORALCHARGES-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N prtemporalcharges.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/prtemporalcharges.sql

prompt "--->Aplicando creacion de procedimiento adm_person.prtemporalcharges.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.prtemporalcharges.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.prtemporalcharges.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.prtemporalcharges.sql


prompt "-----11.procedimiento LDC_REGPROGESAC-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_regprogesac.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_regprogesac.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.seq_progen_sac_rp.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.seq_progen_sac_rp.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_regprogesac.sql" 
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_regprogesac.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_regprogesac.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_regprogesac.sql


prompt "-----12.procedimiento ldc_prvpmupdatefecha-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvpmupdatefecha.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvpmupdatefecha.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_vpm.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_vpm.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prvpmdata.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvpmdata.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prvpmupdatefecha.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prvpmupdatefecha.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prvpmupdatefecha.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvpmupdatefecha.sql


prompt "-----13.procedimiento LDC_VALIDAITEMTITR-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_validaitemtitr.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_validaitemtitr.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_validaitemtitr.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_validaitemtitr.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_validaitemtitr.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_validaitemtitr.sql


prompt "-----14.procedimiento LDC_PROVALIREGENSERVNUEVOS-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_provaliregenservnuevos.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_provaliregenservnuevos.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_provaliregenservnuevos_pr.sql" 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_provaliregenservnuevos_pr.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_provaliregenservnuevos.sql" 
@src/gascaribe/servicios-nuevos/procedimientos/adm_person.ldc_provaliregenservnuevos.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_provaliregenservnuevos.sql" 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_provaliregenservnuevos.sql


prompt "-----15.procedimiento LDC_PRVALIDAITEMCOTIZADO-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvalidaitemcotizado.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvalidaitemcotizado.sql

prompt "Creacion sinonimos dependientes"

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_itemcoti_ldcriaic.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_itemcoti_ldcriaic.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_itemadic_ldcriaic.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_itemadic_ldcriaic.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_itemcotiinte_ldcriaic.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_itemcotiinte_ldcriaic.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prvalidaitemcotizado.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prvalidaitemcotizado.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prvalidaitemcotizado.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvalidaitemcotizado.sql


prompt "-----16.procedimiento PROCGENERACUPON_BCOLOMBIA-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N procgeneracupon_bcolombia.sql" 
@src/gascaribe/recaudos/procedimientos/procgeneracupon_bcolombia.sql

prompt "--->Aplicando creacion de procedimiento adm_person.procgeneracupon_bcolombia.sql" 
@src/gascaribe/recaudos/procedimientos/adm_person.procgeneracupon_bcolombia.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.procgeneracupon_bcolombia.sql" 
@src/gascaribe/recaudos/sinonimos/adm_person.procgeneracupon_bcolombia.sql


prompt "-----17.procedimiento LDC_PRVALDATCAMBORDER-----" 

prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prvaldatcamborder.sql" 
@src/gascaribe/gestion-ordenes/procedure/ldc_prvaldatcamborder.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prvaldatcamborder.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prvaldatcamborder.sql

prompt "--->Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prvaldatcamborder.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prvaldatcamborder.sql


prompt "-----Script OSF-2596_actualizar_obj_migrados-----" 

@src/gascaribe/datafix/OSF-2596_actualizar_obj_migrados.sql



prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-2596-----"
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