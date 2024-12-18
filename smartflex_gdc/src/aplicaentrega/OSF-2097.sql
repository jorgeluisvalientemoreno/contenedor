column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2097                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "--------------------1.FUNCION FRCGETUNIDOPERTECCERT-----------------------" 
prompt "                                                                          " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_trab_cert.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.frcgetunidoperteccert.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.frcgetunidoperteccert.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N frcgetunidoperteccert.sql" 
@src/gascaribe/papelera-reciclaje/funciones/frcgetunidoperteccert.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.frcgetunidoperteccert.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.frcgetunidoperteccert.sql
show errors;

prompt "                                                                          " 
prompt "--------------------2.FUNCION FSBESTADOFINANCIERO-------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.fsbestadofinanciero.sql" 
@src/gascaribe/general/funciones/adm_person.fsbestadofinanciero.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbestadofinanciero.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbestadofinanciero.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbestadofinanciero.sql" 
@src/gascaribe/general/sinonimos/adm_person.fsbestadofinanciero.sql
show errors;

prompt "                                                                          "
prompt "-------------------3.FUNCION FSBEXISTSINSTANSUBSC-------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.fsbexistsinstansubsc.sql" 
@src/gascaribe/general/funciones/adm_person.fsbexistsinstansubsc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbexistsinstansubsc.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbexistsinstansubsc.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbexistsinstansubsc.sql" 
@src/gascaribe/general/sinonimos/adm_person.fsbexistsinstansubsc.sql
show errors;

prompt "                                                                          " 
prompt "--------------------4.FUNCION FSBGETCALIFICACION--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a tabla adm_person.calivaco.sql " 
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.calivaco.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fsbgetcalificacion.sql" 
@src/gascaribe/facturacion/consumos/funciones/adm_person.fsbgetcalificacion.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetcalificacion.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetcalificacion.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetcalificacion.sql" 
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.fsbgetcalificacion.sql
show errors;

prompt "                                                                          " 
prompt "--------------------5.FUNCION FSBGETDEUDORBRILLA--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a tabla adm_person.ld_promissory.sql " 
@src/gascaribe/fnb/sinonimos/adm_person.ld_promissory.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fsbgetdeudorbrilla.sql" 
@src/gascaribe/fnb/funciones/adm_person.fsbgetdeudorbrilla.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetdeudorbrilla.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetdeudorbrilla.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetdeudorbrilla.sql" 
@src/gascaribe/fnb/sinonimos/adm_person.fsbgetdeudorbrilla.sql
show errors;

prompt "                                                                          "
prompt "---------------------6.FUNCION FSBGETESTSOLVENTA--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.fsbgetestsolventa.sql" 
@src/gascaribe/general/funciones/adm_person.fsbgetestsolventa.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetestsolventa.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetestsolventa.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetestsolventa.sql" 
@src/gascaribe/general/sinonimos/adm_person.fsbgetestsolventa.sql
show errors;

prompt "                                                                          " 
prompt "-------------------7.FUNCION FSBGETOBSCONSECNOLECT------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a tabla adm_person.obselect.sql " 
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.obselect.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fsbgetobsconsecnolect.sql" 
@src/gascaribe/facturacion/lecturas_especiales/funciones/adm_person.fsbgetobsconsecnolect.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetobsconsecnolect.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetobsconsecnolect.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetobsconsecnolect.sql" 
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.fsbgetobsconsecnolect.sql
show errors;

prompt "                                                                          " 
prompt "----------------------8.FUNCION FSBGETOBSNOLECT---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.fsbgetobsnolect.sql" 
@src/gascaribe/facturacion/lecturas_especiales/funciones/adm_person.fsbgetobsnolect.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetobsnolect.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetobsnolect.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetobsnolect.sql" 
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.fsbgetobsnolect.sql
show errors;

prompt "                                                                          " 
prompt "--------------------9.FUNCION FSBGETSALEBYORDERVSI------------------------" 
prompt "                                                                          "

prompt "--->Aplicando sinonimo a Función adm_person.fsbgetfnbinfo.sql " 
@src/gascaribe/fnb/sinonimos/adm_person.fsbgetfnbinfo.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.fsbgetsalebyordervsi.sql" 
@src/gascaribe/fnb/funciones/adm_person.fsbgetsalebyordervsi.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetsalebyordervsi.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetsalebyordervsi.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetsalebyordervsi.sql" 
@src/gascaribe/fnb/sinonimos/adm_person.fsbgetsalebyordervsi.sql
show errors;

prompt "                                                                          " 
prompt "-----------------------10.FUNCION FSBGETTIPOCONS--------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fsbgettipocons.sql" 
@src/gascaribe/facturacion/consumos/funciones/adm_person.fsbgettipocons.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgettipocons.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgettipocons.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgettipocons.sql" 
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.fsbgettipocons.sql
show errors;

prompt "                                                                          " 
prompt "-------------------11.FUNCION FSBOBSERVACIONOTPADRE-----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fsbobservacionotpadre.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.fsbobservacionotpadre.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbobservacionotpadre.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbobservacionotpadre.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbobservacionotpadre.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.fsbobservacionotpadre.sql
show errors;

prompt "                                                                          " 
prompt "---------------------12.FUNCION FSBSECTOROPERATIVO------------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fsbsectoroperativo.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.fsbsectoroperativo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbsectoroperativo.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbsectoroperativo.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbsectoroperativo.sq" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.fsbsectoroperativo.sql
show errors;

prompt "                                                                          " 
prompt "-------------------13.FUNCION LDC_ALLOW_GET_INFO_FNB----------------------" 
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.or_oper_unit_classif.sql " 
@src/gascaribe/fnb/sinonimos/adm_person.or_oper_unit_classif.sql
show errors;
prompt "                                                                          "  

prompt "--->Aplicando creación de funcion adm_person.ldc_allow_get_info_fnb.sql" 
@src/gascaribe/fnb/funciones/adm_person.ldc_allow_get_info_fnb.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_allow_get_info_fnb.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_allow_get_info_fnb.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_allow_get_info_fnb.sql" 
@src/gascaribe/fnb/sinonimos/adm_person.ldc_allow_get_info_fnb.sql
show errors;

prompt "                                                                          " 
prompt "---------------14.FUNCION LDCBI_ASSIGN_IOT_METER_READING------------------" 
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldcbi_iot_meter.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_iot_meter.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_order.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_order.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a paquete adm_person.ldc_boasigauto.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_boasigauto.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.ldcbi_assign_iot_meter_reading.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldcbi_assign_iot_meter_reading.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldcbi_assign_iot_meter_reading.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldcbi_assign_iot_meter_reading.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldcbi_assign_iot_meter_reading.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcbi_assign_iot_meter_reading.sql
show errors;

prompt "                                                                          " 
prompt "------------------15.FUNCION LDC_CARTASNOTIFICACION----------------------" 
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_cartasnotificacion.sql" 
@src/gascaribe/facturacion/lecturas_especiales/funciones/adm_person.ldc_cartasnotificacion.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_cartasnotificacion.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_cartasnotificacion.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_cartasnotificacion.sql" 
@src/gascaribe/facturacion/lecturas_especiales/sinonimos/adm_person.ldc_cartasnotificacion.sql
show errors;

prompt "                                                                          " 
prompt "---------------------------ACTUALIZAR REGISTRO----------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando actualización de objetos migrados"
@src/gascaribe/general/sql/OSF-2097_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2097                       "
prompt "--------------------------------------------------------------------------"

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "                                                                          "
prompt "---------------------------RECOMPILAR OBJETOS-----------------------------"
prompt "                                                                          "

prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;