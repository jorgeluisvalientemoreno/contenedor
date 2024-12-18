column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2181                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "-------------------1.FUNCION LDC_CALCULAEDADMORAPROD----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_calculaedadmoraprod.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_calculaedadmoraprod.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_calculaedadmoraprod.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_calculaedadmoraprod.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_calculaedadmoraprod.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_calculaedadmoraprod.sql
show errors;

prompt "                                                                          " 
prompt "--------------------2.FUNCION LDC_CANTASIGNADA-------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_cantasignada.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_cantasignada.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_cm_lectesp_crit.sql " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cm_lectesp_crit.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.or_order_items.sql " 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_order_items.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_cantasignada.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_cantasignada.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_cantasignada.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cantasignada.sql
show errors;

prompt "                                                                          "
prompt "------------------3.FUNCION LDC_CONSULTACERTVIGTEC------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_consultacertvigtec.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_consultacertvigtec.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_certificado.sql " 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_certificado.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_consultacertvigtec.sql" 
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_consultacertvigtec.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_consultacertvigtec.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_consultacertvigtec.sql
show errors;

prompt "                                                                          " 
prompt "--------------------4.FUNCION LDC_CONSULTACERTVIGTECFE--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_consultacertvigtecfe.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_consultacertvigtecfe.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de funcion adm_person.ldc_consultacertvigtecfe.sql" 
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_consultacertvigtecfe.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_consultacertvigtecfe.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_consultacertvigtecfe.sql
show errors;

prompt "                                                                          " 
prompt "--------------------5.FUNCION LDC_FINPROXCONS--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_finproxcons.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_finproxcons.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de funcion adm_person.ldc_finproxcons.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_finproxcons.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_finproxcons.sql" 
@src/gascaribe/ventas/sinonimos/adm_person.ldc_finproxcons.sql
show errors;

prompt "                                                                          "
prompt "---------------------6.FUNCION LDC_FNC_ESTADO_CORTE--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnc_estado_corte.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnc_estado_corte.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de funcion adm_person.ldc_fnc_estado_corte.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fnc_estado_corte.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnc_estado_corte.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fnc_estado_corte.sql
show errors;

prompt "                                                                          " 
prompt "-------------------7.FUNCION LDC_FNCRETORDENPADRE------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncretordenpadre.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretordenpadre.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de funcion adm_person.ldc_fncretordenpadre.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fncretordenpadre.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncretordenpadre.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fncretordenpadre.sql
show errors;

prompt "                                                                          " 
prompt "----------------------8.FUNCION LDC_FNCRETORNAEDADCONSUL---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncretornaedadconsul.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaedadconsul.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando sinonimo a tabla adm_person.bases_datos_osf.sql " 
@src/gascaribe/general/sinonimos/adm_person.bases_datos_osf.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.ldc_fncretornaedadconsul.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fncretornaedadconsul.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncretornaedadconsul.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaedadconsul.sql
show errors;

prompt "                                                                          " 
prompt "--------------------9.FUNCION LDC_FNCRETORNAUNIDSOLICITUD------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncretornaunidsolicitud.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaunidsolicitud.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_fncretornaunidsolicitud.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fncretornaunidsolicitud.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncretornaunidsolicitud.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fncretornaunidsolicitud.sql
show errors;

prompt "                                                                          " 
prompt "-----------------------10.FUNCION LDC_FNU_CUENTAS_FECHA--------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnu_cuentas_fecha.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnu_cuentas_fecha.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_fnu_cuentas_fecha.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_fnu_cuentas_fecha.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnu_cuentas_fecha.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnu_cuentas_fecha.sql
show errors;

prompt "                                                                          " 
prompt "-------------------11.FUNCION LDC_FNUESTADOPERIODO-----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnuestadoperiodo.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuestadoperiodo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_prometcub.sql " 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_prometcub.sql
show errors;
prompt "                                                                          " 
 
prompt "--->Aplicando sinonimo a tabla adm_person.ldc_catmetcub.sql " 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_catmetcub.sql
show errors;
prompt "                                                                          " 
 
prompt "--->Aplicando creación de funcion adm_person.ldc_fnuestadoperiodo.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_fnuestadoperiodo.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnuestadoperiodo.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnuestadoperiodo.sql
show errors;

prompt "                                                                          " 
prompt "---------------------12.FUNCION LDC_FNUGETCATHIST------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnugetcathist.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetcathist.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_snapshotcreg_b.sql " 
@src/gascaribe/general/sinonimos/adm_person.ldc_snapshotcreg_b.sql
show errors;
prompt "                                                                          " 
 
prompt "--->Aplicando creación de funcion adm_person.ldc_fnugetcathist.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fnugetcathist.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnugetcathist.sq" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fnugetcathist.sql
show errors;

prompt "                                                                          " 
prompt "-------------------13.FUNCION LDC_FNUGETCATHIST_C----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnugetcathist_c.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetcathist_c.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando sinonimo a tabla adm_person.ldc_snapshotcreg_c.sql " 
@src/gascaribe/general/sinonimos/adm_person.ldc_snapshotcreg_c.sql
show errors;
prompt "                                                                          "  

prompt "--->Aplicando creación de funcion adm_person.ldc_fnugetcathist_c.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fnugetcathist_c.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnugetcathist_c.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fnugetcathist_c.sql
show errors;

prompt "                                                                          " 
prompt "---------------14.FUNCION LDC_FNUGETINIQUOTA------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnugetiniquota.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetiniquota.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_usucuoinind.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_usucuoinind.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_plandife.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_plandife.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_osf_sesucier.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_osf_sesucier.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a funcion adm_person.finanprioritygdc.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.finanprioritygdc.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a funcion adm_person.fnucuotainicialcom.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.fnucuotainicialcom.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando sinonimo a paquete adm_person.gc_bodebtmanagement.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.gc_bodebtmanagement.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.ldc_fnugetiniquota.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_fnugetiniquota.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnugetiniquota.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fnugetiniquota.sql
show errors;

prompt "                                                                          " 
prompt "------------------15.FUNCION LDC_FNUGETULTIMOBLOQUEO----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnugetultimobloqueo.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetultimobloqueo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_asigna_unidad_rev_per.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_asigna_unidad_rev_per.sql
show errors;
prompt "                                                                          " 

prompt "--->Aplicando creación de funcion adm_person.ldc_fnugetultimobloqueo.sql" 
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnugetultimobloqueo.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnugetultimobloqueo.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnugetultimobloqueo.sql
show errors;

prompt "                                                                          " 
prompt "---------------------------ACTUALIZAR REGISTRO----------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando actualización de objetos migrados"
@src/gascaribe/general/sql/OSF-2181_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2181                       "
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