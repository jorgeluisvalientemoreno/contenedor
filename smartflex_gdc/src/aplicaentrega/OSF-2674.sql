column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2674"
prompt "-----------------"

prompt "-----procedimiento PRTEMPORALCHARGE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN prtemporalcharge.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prtemporalcharge.sql


prompt "-----procedimiento PRGENERATEVISITAIDENCERTBYCAT-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN prgeneratevisitaidencertbycat.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prgeneratevisitaidencertbycat.sql


prompt "-----procedimiento LDC_PROCVALDESMONTE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_procvaldesmonte.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procvaldesmonte.sql


prompt "-----procedimiento LDC_PLUGINBORRAMARCA101-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pluginborramarca101.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_pluginborramarca101.sql


prompt "-----procedimiento LDCPROCVALLEGREPPRPTXML-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcprocvallegrepprptxml.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprocvallegrepprptxml.sql


prompt "-----procedimiento LDC_PROCESSLDRPLAM-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_processldrplam.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_processldrplam.sql


prompt "-----procedimiento LDC_LEGALIZAACTIAPOYOCONFIG-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_legalizaactiapoyoconfig.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_legalizaactiapoyoconfig.sql


prompt "-----procedimiento PROCESSLDGAVBR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN processldgavbr.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/processldgavbr.sql


prompt "-----procedimiento LDCFTABLE_PROCESAR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcftable_procesar.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcftable_procesar.sql


prompt "-----procedimiento LDC_REGISTER_DATOS_ACTUALIZAR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_register_datos_actualizar.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_register_datos_actualizar.sql


prompt "-----procedimiento LDC_AJUSTARORDENPAGOANULADO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_ajustarordenpagoanulado.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_ajustarordenpagoanulado.sql


prompt "-----procedimiento LDC_CUPOBRILLA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_cupobrilla.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_cupobrilla.sql


prompt "-----procedimiento PROINFOADICIONALCONTRATO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN proinfoadicionalcontrato.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/proinfoadicionalcontrato.sql


prompt "-----procedimiento LDC_DISTSALDFAVOCLIECAST-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_distsaldfavocliecast.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_distsaldfavocliecast.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gc_prodprca.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.gc_prodprca.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gc_debt_negot_prod.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.gc_debt_negot_prod.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.dagc_debt_negot_charge.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.dagc_debt_negot_charge.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gc_bcdebtnegocharge.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.gc_bcdebtnegocharge.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gc_debt_negot_charge.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.gc_debt_negot_charge.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_gc_debt_negot_p_197149.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.seq_gc_debt_negot_p_197149.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gc_bocastigocartera.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.gc_bocastigocartera.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_gc_debt_negot_c_197160.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.seq_gc_debt_negot_c_197160.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_distsaldfavocliecast.sql"
@src/gascaribe/cartera/saldo-favor/procedimientos/adm_person.ldc_distsaldfavocliecast.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_distsaldfavocliecast.sql"
@src/gascaribe/cartera/saldo-favor/sinonimos/adm_person.ldc_distsaldfavocliecast.sql


prompt "-----procedimiento AJUSTARORDENPAGOANULADO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ajustarordenpagoanulado.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ajustarordenpagoanulado.sql


prompt "-----procedimiento LDC_PRREGISTERNEWCHARGE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_prregisternewcharge.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prregisternewcharge.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_prregisternewcharge.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_prregisternewcharge.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_prregisternewcharge.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_prregisternewcharge.sql


prompt "-----procedimiento LDC_OS_REASSINGORDER-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_os_reassingorder.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_reassingorder.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_bomanageaddress.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_bomanageaddress.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_os_reassingorder.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_os_reassingorder.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_os_reassingorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_os_reassingorder.sql


prompt "-----procedimiento OS_PEPRODSUITRCONNECTN-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN os_peprodsuitrconnectn.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/os_peprodsuitrconnectn.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pe_bsvalprodsuitrconnectn.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pe_bsvalprodsuitrconnectn.sql

prompt "--->Aplicando creacion de procedimiento adm_person.os_peprodsuitrconnectn.sql"
@src/gascaribe/cartera/procedimientos/adm_person.os_peprodsuitrconnectn.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.os_peprodsuitrconnectn.sql"
@src/gascaribe/cartera/sinonimo/adm_person.os_peprodsuitrconnectn.sql


prompt "-----procedimiento LDC_OS_INSADDRESS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_os_insaddress.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_insaddress.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gisosf.ldc_os_insaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.gisosf.ldc_os_insaddress.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_os_insaddress.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_os_insaddress.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_os_insaddress.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_os_insaddress.sql


prompt "-----procedimiento OS_GETQUOTABRILLA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN os_getquotabrilla.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/os_getquotabrilla.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ld_bononbankfirules.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_bononbankfirules.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.gisosf.os_getquotabrilla.sql"
@src/gascaribe/fnb/sinonimos/adm_person.gisosf.os_getquotabrilla.sql

prompt "--->Aplicando creacion de procedimiento adm_person.os_getquotabrilla.sql"
@src/gascaribe/fnb/procedimientos/adm_person.os_getquotabrilla.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.os_getquotabrilla.sql"
@src/gascaribe/fnb/sinonimos/adm_person.os_getquotabrilla.sql


prompt "-----procedimiento LDC_CANCEL_ORDER-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_cancel_order.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_cancel_order.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.dage_message.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.dage_message.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_cancel_order.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_cancel_order.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_cancel_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cancel_order.sql


prompt "-----procedimiento LDC_OS_REGISTERNEWCHARGE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_os_registernewcharge.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_registernewcharge.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_os_registernewcharge.sql"
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_os_registernewcharge.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_os_registernewcharge.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_os_registernewcharge.sql


prompt "-----procedimiento LDC_CAMBIOESTADO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_cambioestado.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_cambioestado.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.daor_order_stat_change.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daor_order_stat_change.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ge_boutilities.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ge_boutilities.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.or_bosequences.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bosequences.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.or_boejecutarorden.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_boejecutarorden.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldc_cambioestado.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_cambioestado.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldc_cambioestado.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cambioestado.sql


prompt "-----procedimiento PROVAPATAPA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN provapatapa.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/provapatapa.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkpara.sql"
@src/gascaribe/general/sinonimos/adm_person.pkpara.sql

prompt "--->Aplicando creacion de procedimiento adm_person.provapatapa.sql"
@src/gascaribe/general/procedimientos/adm_person.provapatapa.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.provapatapa.sql"
@src/gascaribe/general/sinonimos/adm_person.provapatapa.sql


prompt "-----procedimiento LDCPROCCREAREGISTROTRAMTAB-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldcproccrearegistrotramtab.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcproccrearegistrotramtab.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_creatami_revper.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_creatami_revper.sql

prompt "--->Aplicando creacion de procedimiento adm_person.ldcproccrearegistrotramtab.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldcproccrearegistrotramtab.sql

prompt "--->Aplicando creacion sinonimo a nuevo procedimiento adm_person.ldcproccrearegistrotramtab.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldcproccrearegistrotramtab.sql


prompt "-----Script OSF-2674_del_reg_ldc_procedimiento_obj-----"
@src/gascaribe/datafix/OSF-2674_del_reg_ldc_procedimiento_obj.sql

prompt "-----Script OSF-2674_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2674_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2674-----"
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
