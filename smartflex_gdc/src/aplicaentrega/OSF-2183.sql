column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyy-mm-dd hh24:mi:ss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on size unlimited
set define off
set timing on
execute dbms_application_info.set_action('Aplicando SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "--------------------------------------------------------------------------"
prompt "                         Aplicando Entrega OSF-2183                       "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "

prompt "--------------------------------INICIO------------------------------------"
prompt "                                                                          "

prompt "                                                                          " 
prompt "-------------------1.FUNCION FBLEXISSOLXDIRTIPOXESTADO----------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fblexissolxdirtipoxestado.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fblexissolxdirtipoxestado.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.mo_address.sql " 
@src/gascaribe/general/sinonimos/adm_person.mo_address.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ex.sql " 
@src/gascaribe/general/sinonimos/adm_person.ex.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fblexissolxdirtipoxestado.sql" 
@src/gascaribe/general/funciones/adm_person.fblexissolxdirtipoxestado.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fblexissolxdirtipoxestado.sql" 
@src/gascaribe/general/sinonimos/adm_person.fblexissolxdirtipoxestado.sql
show errors;

prompt "                                                                          " 
prompt "--------------------2.FUNCION FNUGETCONSPROMFACT-------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnugetconspromfact.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnugetconspromfact.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.mecacons.sql " 
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.mecacons.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de funcion adm_person.fnugetconspromfact.sql" 
@src/gascaribe/facturacion/consumos/funciones/adm_person.fnugetconspromfact.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fnugetconspromfact.sql" 
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnugetconspromfact.sql
show errors;

prompt "                                                                          "
prompt "------------------3.FUNCION FNUGETORACLEEDITION------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnugetoracleedition.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnugetoracleedition.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.fnugetoracleedition.sql" 
@src/gascaribe/general/funciones/adm_person.fnugetoracleedition.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fnugetoracleedition.sql" 
@src/gascaribe/general/sinonimos/adm_person.fnugetoracleedition.sql
show errors;

prompt "                                                                          " 
prompt "--------------------4.FUNCION FSBGETFNBINFO--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetfnbinfo.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetfnbinfo.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_fnb_vsi.sql " 
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnb_vsi.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_fnb_deliver_date.sql " 
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnb_deliver_date.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.daab_address.sql " 
@src/gascaribe/fnb/sinonimos/adm_person.daab_address.sql
show errors;
prompt "                                                                          "
    
prompt "--->Aplicando creación de funcion adm_person.fsbgetfnbinfo.sql" 
@src/gascaribe/fnb/funciones/adm_person.fsbgetfnbinfo.sql 
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.fsbgetfnbinfo.sql" 
@src/gascaribe/fnb/sinonimos/adm_person.fsbgetfnbinfo.sql
show errors;

prompt "                                                                          " 
prompt "--------------------5.FUNCION LDC_FNCRECUPERADEUDASVAL--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncrecuperadeudasval.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncrecuperadeudasval.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.total_cart_mes.sql " 
@src/gascaribe/cartera/sinonimo/adm_person.total_cart_mes.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de funcion adm_person.ldc_fncrecuperadeudasval.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_fncrecuperadeudasval.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncrecuperadeudasval.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_fncrecuperadeudasval.sql
show errors;

prompt "                                                                          "
prompt "---------------------6.FUNCION LDC_FNCRETORNALOCACLIENTE--------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncretornalocacliente.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornalocacliente.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_fncretornalocacliente.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fncretornalocacliente.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncretornalocacliente.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornalocacliente.sql
show errors;

prompt "                                                                          " 
prompt "-------------------7.FUNCION LDC_FNCRETORNALOCACONTRATO------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncretornalocacontrato.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornalocacontrato.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_fncretornalocacontrato.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fncretornalocacontrato.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncretornalocacontrato.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornalocacontrato.sql
show errors;

prompt "                                                                          " 
prompt "----------------------8.FUNCION LDC_FNCRETORNAPROCEJECIERR2---------------------------" 
prompt "                                                                          " 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fncretornaprocejecierr2.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaprocejecierr2.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ldc_osf_estaproc.sql " 
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_estaproc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_fncretornaprocejecierr2.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_fncretornaprocejecierr2.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fncretornaprocejecierr2.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaprocejecierr2.sql
show errors;

prompt "                                                                          " 
prompt "--------------------9.FUNCION LDC_FNUGETCANTACTXPROD------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_fnugetcantactxprod.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetcantactxprod.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ld_boconstans.sql " 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ld_boconstans.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_fnugetcantactxprod.sql" 
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fnugetcantactxprod.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_fnugetcantactxprod.sql" 
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fnugetcantactxprod.sql
show errors;

prompt "                                                                          " 
prompt "-----------------------10.FUNCION LDC_TELEFONOS_SUBSC--------------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_telefonos_subsc.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_telefonos_subsc.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando sinonimo a tabla adm_person.ge_subs_phone.sql " 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_subs_phone.sql
show errors;
prompt "                                                                          "
   
prompt "--->Aplicando creación de funcion adm_person.ldc_telefonos_subsc.sql" 
@src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_telefonos_subsc.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_telefonos_subsc.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_telefonos_subsc.sql
show errors;

prompt "                                                                          " 
prompt "-------------------11.FUNCION LDC_VALIDASOLIVENTAFNBMERE-----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_validasoliventafnbmere.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_validasoliventafnbmere.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_validasoliventafnbmere.sql" 
@src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_validasoliventafnbmere.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_validasoliventafnbmere.sql" 
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_validasoliventafnbmere.sql
show errors;

prompt "                                                                          " 
prompt "---------------------12.FUNCION LDC_VALIDATITRSECERT------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_validatitrsecert.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_validatitrsecert.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de funcion adm_person.ldc_validatitrsecert.sql" 
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_validatitrsecert.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.ldc_validatitrsecert.sq" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_validatitrsecert.sql
show errors;

prompt "                                                                          " 
prompt "-------------------13.FUNCION MIC_FUN_SERV_GETPHONESCLIENT----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N mic_fun_serv_getphonesclient.sql" 
@src/gascaribe/papelera-reciclaje/funciones/mic_fun_serv_getphonesclient.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando sinonimo a tabla adm_person.ld_bosubsidy.sql " 
@src/gascaribe/ventas/sinonimos/adm_person.ld_bosubsidy.sql
show errors;
prompt "                                                                          "  

prompt "--->Aplicando creación de funcion adm_person.mic_fun_serv_getphonesclient.sql" 
@src/gascaribe/ventas/funciones/adm_person.mic_fun_serv_getphonesclient.sql
show errors;
prompt "                                                                          "

prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.mic_fun_serv_getphonesclient.sql" 
@src/gascaribe/ventas/sinonimos/adm_person.mic_fun_serv_getphonesclient.sql
show errors;

prompt "                                                                          " 
prompt "---------------14.FUNCION PRFECHAANTERIORPERI------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N prfechaanteriorperi.sql" 
@src/gascaribe/papelera-reciclaje/funciones/prfechaanteriorperi.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando sinonimo a tabla adm_person.ldc_temp_planfaca_sge.sql " 
@src/gascaribe/general/sinonimos/adm_person.ldc_temp_planfaca_sge.sql
show errors;
prompt "                                                                          "  

prompt "--->Aplicando creación de funcion adm_person.prfechaanteriorperi.sql" 
@src/gascaribe/general/funciones/adm_person.prfechaanteriorperi.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.prfechaanteriorperi.sql" 
@src/gascaribe/general/sinonimos/adm_person.prfechaanteriorperi.sql
show errors;

prompt "                                                                          " 
prompt "------------------15.FUNCION SPLIT_CLOB----------------------" 
prompt "                                                                          "

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N split_clob.sql" 
@src/gascaribe/papelera-reciclaje/funciones/split_clob.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creacion de Type adm_person.split_tbl.sql " 
@src/gascaribe/general/tipos/adm_person.split_tbl.sql
show errors;
prompt "                                                                          "  

prompt "--->Aplicando creación de funcion adm_person.split_clob.sql" 
@src/gascaribe/general/funciones/adm_person.split_clob.sql
show errors;
prompt "                                                                          "
 
prompt "--->Aplicando creación de sinonimo a nueva funcion adm_person.split_clob.sql" 
@src/gascaribe/general/sinonimos/adm_person.split_clob.sql
show errors;

prompt "                                                                          " 
prompt "---------------------------ACTUALIZAR REGISTRO----------------------------" 
prompt "                                                                          "
 
prompt "--->Aplicando actualización de objetos migrados"
@src/gascaribe/general/sql/OSF-2183_actualizar_obj_migrados.sql
show errors;

prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                                                                          "
prompt "-------------------------------FINALIZA-----------------------------------"
prompt "                                                                          "
prompt "--------------------------------------------------------------------------"
prompt "                        Fin Aplica Entrega OSF-2183                       "
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