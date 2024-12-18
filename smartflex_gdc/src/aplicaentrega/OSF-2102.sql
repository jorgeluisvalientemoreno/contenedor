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

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_bloq_lega_solicitud.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_bloq_lega_solicitud.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ldc_ciercome.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldc_ciercome.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaunidsolicitud.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaunidsolicitud.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordeasigproc.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_ordeasigproc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boasigauto.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boasigauto.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ut_convert.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_convert.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ta_tariconc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_tariconc.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ta_conftaco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_conftaco.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ta_confcrta.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ta_confcrta.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pktblta_tariconc.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblta_tariconc.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ld_non_ba_fi_requ.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ld_non_ba_fi_requ.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_detalle2_tt_proceso.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_detalle2_tt_proceso.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_sendemail.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_sendemail.sql

prompt "Aplicando src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanodirec.sql"
@src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanodirec.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldcfnu_venanodirec.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldcfnu_venanodirec.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanodirec.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanodirec.sql

prompt "Aplicando src/gascaribe/fnb/seguros/funciones/adm_person.ldc_fnvnombrecontra.sql"
@src/gascaribe/fnb/seguros/funciones/adm_person.ldc_fnvnombrecontra.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnvnombrecontra.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnvnombrecontra.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnvnombrecontra.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnvnombrecontra.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistcontractor.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistcontractor.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_frflistcontractor.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_frflistcontractor.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_frflistcontractor.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_frflistcontractor.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistoperatingunity.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_frflistoperatingunity.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_frflistoperatingunity.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_frflistoperatingunity.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_frflistoperatingunity.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_frflistoperatingunity.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_fsbasignautomaticarevper.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_fsbasignautomaticarevper.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbasignautomaticarevper.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbasignautomaticarevper.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fsbasignautomaticarevper.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_fsbasignautomaticarevper.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbcommenorder.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbcommenorder.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbcommenorder.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbcommenorder.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbcommenorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbcommenorder.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fsbestratovalido.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fsbestratovalido.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbestratovalido.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbestratovalido.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fsbestratovalido.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fsbestratovalido.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fsbexcluirot.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fsbexcluirot.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbexcluirot.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbexcluirot.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fsbexcluirot.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fsbexcluirot.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_fsbgetinfobycrit.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_fsbgetinfobycrit.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetinfobycrit.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetinfobycrit.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_fsbgetinfobycrit.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fsbgetinfobycrit.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fsbgetnewnamelodpd.sql"
@src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fsbgetnewnamelodpd.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetnewnamelodpd.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetnewnamelodpd.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fsbgetnewnamelodpd.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fsbgetnewnamelodpd.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fsbnumformulario.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fsbnumformulario.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbnumformulario.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbnumformulario.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fsbnumformulario.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fsbnumformulario.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbobtordhija.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbobtordhija.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbobtordhija.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbobtordhija.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbobtordhija.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbobtordhija.sql

prompt "Aplicando @src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbttprocesocorreo.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbttprocesocorreo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbttprocesocorreo.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbttprocesocorreo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbttprocesocorreo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbttprocesocorreo.sql

prompt "Aplicando @src/gascaribe/general/interfaz-contable/funciones/adm_person.ldc_fsbvalidaexpresion_ic.sql"
@src/gascaribe/general/interfaz-contable/funciones/adm_person.ldc_fsbvalidaexpresion_ic.sql

prompt "Aplicando @src/gascaribe/papelera-reciclaje/funciones/ldc_fsbvalidaexpresion_ic.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbvalidaexpresion_ic.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_fsbvalidaexpresion_ic.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_fsbvalidaexpresion_ic.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fvaretconsumos.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fvaretconsumos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fvaretconsumos.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fvaretconsumos.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_fvaretconsumos.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_fvaretconsumos.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2102_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2102_actualizar_obj_migrados.sql

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
