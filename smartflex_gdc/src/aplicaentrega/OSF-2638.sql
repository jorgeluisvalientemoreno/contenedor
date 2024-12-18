column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2638"
prompt "-----------------"

prompt "-----procedimiento LDC_CREA_TRAMITE_SER_ING-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_crea_tramite_ser_ing.sql" 
@src/gascaribe/perdidas-no-operacionales/procedimientos/ldc_crea_tramite_ser_ing.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_crea_tramite_ser_ing.sql" 
@src/gascaribe/perdidas-no-operacionales/procedimientos/adm_person.ldc_crea_tramite_ser_ing.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldc_crea_tramite_ser_ing.sql" 
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_crea_tramite_ser_ing.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldc_otrev_items_especiales.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_otrev_items_especiales.sql


prompt "-----procedimiento LDC_OSSEXCLUYEPNO-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_ossexcluyepno.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_ossexcluyepno.sql

prompt "--->Aplicando creacion de sinonimo dependiente adm_person.dafm_possible_ntl.sql" 
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.dafm_possible_ntl.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_ossexcluyepno.sql" 
@src/gascaribe/perdidas-no-operacionales/procedimientos/adm_person.ldc_ossexcluyepno.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldc_ossexcluyepno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_ossexcluyepno.sql


prompt "-----procedimiento LDC_PRBORRAVISITAFALLIDA-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prborravisitafallida.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prborravisitafallida.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prborravisitafallida.sql" 
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prborravisitafallida.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldc_prborravisitafallida.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prborravisitafallida.sql


prompt "-----procedimiento LDC_PROLIBERAELEMENTOMEDICION-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_proliberaelementomedicion.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proliberaelementomedicion.sql

prompt "--->Aplicando creacion de sinonimo dependiente adm_person.ge_items_estado_inv.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_items_estado_inv.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_proliberaelementomedicion.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_proliberaelementomedicion.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldc_proliberaelementomedicion.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proliberaelementomedicion.sql


prompt "-----procedimiento LDC_VALIDA_FECHA_EJECUCION-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_valida_fecha_ejecucion.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_valida_fecha_ejecucion.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_valida_fecha_ejecucion.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_valida_fecha_ejecucion.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldc_valida_fecha_ejecucion.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_valida_fecha_ejecucion.sql


prompt "-----procedimiento LDCORGESCOBPREJUCOND-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcorgescobprejucond.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcorgescobprejucond.sql

prompt "--->Aplicando creacion de sinonimo dependiente adm_person.ldc_config_gest_cobr.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_config_gest_cobr.sql
prompt "--->Aplicando creacion de sinonimo dependiente adm_person.ldc_prio_tipo_prod_gestcobr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_prio_tipo_prod_gestcobr.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcorgescobprejucond.sql"
@src/gascaribe/cartera/procedimientos/adm_person.ldcorgescobprejucond.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldcorgescobprejucond.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldcorgescobprejucond.sql


prompt "-----procedimiento LDCPROCREATRAMITESRP-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprocreatramitesrp.sql"
@src/gascaribe/revision-periodica/procedimientos/ldcprocreatramitesrp.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprocreatramitesrp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldcprocreatramitesrp.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldcprocreatramitesrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcprocreatramitesrp.sql


prompt "-----procedimiento LDCPROLISTACAUSAL-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcprolistacausal.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprolistacausal.sql

prompt "--->Aplicando creacion de sinonimo dependiente adm_person.mo_boconstants.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_boconstants.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcprolistacausal.sql"
@src/gascaribe/general/procedimientos/adm_person.ldcprolistacausal.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.ldcprolistacausal.sql"
@src/gascaribe/general/sinonimos/adm_person.ldcprolistacausal.sql


prompt "-----procedimiento OS_VISITPACKAGES-----" 
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N os_visitpackages.sql"
@src/gascaribe/ventas/procedimientos/os_visitpackages.sql

prompt "--->Aplicando creacion de sinonimo dependiente adm_person.ld_shopkeeper.sql" 
@src/gascaribe/ventas/sinonimos/adm_person.ld_shopkeeper.sql
prompt "--->Aplicando creacion de sinonimo dependiente adm_person.dage_subscriber_type.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dage_subscriber_type.sql
prompt "--->Aplicando creacion de sinonimo dependiente adm_person.ld_bononbankfinancing.sql" 
@src/gascaribe/ventas/sinonimos/adm_person.ld_bononbankfinancing.sql

prompt "--->Aplicando creacion de procedimiento adm_person.os_visitpackages.sql"
@src/gascaribe/ventas/procedimientos/adm_person.os_visitpackages.sql

prompt "--->Aplicando creacion de sinonimo a nuevo procedimiento adm_person.os_visitpackages.sql"
@src/gascaribe/ventas/sinonimos/adm_person.os_visitpackages.sql


prompt "-----procedimiento LDC_ACTFECPERGRADIFE-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_actfecpergradife.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_actfecpergradife.sql


prompt "-----procedimiento LDC_ASIGCONTYPRESGDC2-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_asigcontypresgdc2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_asigcontypresgdc2.sql


prompt "-----procedimiento LDC_AUXICIERREVARIOS-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_auxicierrevarios.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_auxicierrevarios.sql


prompt "-----procedimiento LDC_CAMBIOESTDLICE-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_cambioestdlice.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_cambioestdlice.sql


prompt "-----procedimiento LDC_OPERATING_UNIT-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_operating_unit.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_operating_unit.sql


prompt "-----procedimiento LDC_PRGENESOLSACRP-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prgenesolsacrp.sql"
@src/gascaribe/revision-periodica/plugin/ldc_prgenesolsacrp.sql


prompt "-----procedimiento LDCCREAFLUJOSRPSUSADMAR-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldccreaflujosrpsusadmar.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldccreaflujosrpsusadmar.sql


prompt "-----procedimiento LDCPROCCREAMARCAASIGAUTO-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldcproccreamarcaasigauto.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcproccreamarcaasigauto.sql


prompt "-----procedimiento LDC_LLENASUBSIDIOCIERRE_TT-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_llenasubsidiocierre_tt.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenasubsidiocierre_tt.sql

prompt "--->Aplicando borrado de tabla ldc_osf_subsidio_tt.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_subsidio_tt.sql


prompt "-----procedimiento LDC_ENVIAMAILCERTVENCE-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N ldc_enviamailcertvence.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_enviamailcertvence.sql


prompt "-----funcion ADM_PERSON.LDC_CONSULTACERTVIGTECFE-----"
prompt "--->Aplicando borrado de funcion en esquema anterior O P E N adm_person.ldc_consultacertvigtecfe.sql"
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_consultacertvigtecfe.sql


prompt "-----funcion ADM_PERSON.LDC_CONSULTACERTVIGTEC-----"
prompt "--->Aplicando borrado de funcion en esquema anterior O P E N adm_person.ldc_consultacertvigtec.sql"
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_consultacertvigtec.sql


prompt "-----funcion ADM_PERSON.FRCGETUNIDOPERTECCERT-----"
prompt "--->Aplicando borrado de funcion en esquema anterior O P E N adm_person.frcgetunidoperteccert.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.frcgetunidoperteccert.sql


prompt "-----procedimiento PROGUARDAASIGOTTEC-----"
prompt "--->Aplicando borrado de procedimiento en esquema anterior O P E N proguardaasigottec.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/proguardaasigottec.sql


prompt "-----Script OSF-2638_actualizar_obj_migrados-----" 
@src/gascaribe/datafix/OSF-2638_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-2638-----"
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