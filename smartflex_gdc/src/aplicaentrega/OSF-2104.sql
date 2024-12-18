column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2104"
prompt "-----------------"


prompt "-----1.FUNCION LDC_RETORNAINTMOFI -----" 

prompt "--->Aplicando creacion de sinonimo objeto interna adm_person.ldc_osf_castconc.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_osf_castconc.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornaintmofi.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornaintmofi.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retornaintmofi.sql" 
@src/gascaribe/cartera/funciones/adm_person.ldc_retornaintmofi.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornaintmofi.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retornaintmofi.sql
show errors;


prompt "-----2.FUNCION LDC_RETORNAMEEDADMORA -----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornameedadmora.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornameedadmora.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retornameedadmora.sql" 
@src/gascaribe/cartera/funciones/adm_person.ldc_retornameedadmora.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornameedadmora.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retornameedadmora.sql
show errors;


prompt "-----3.FUNCION LDC_RETORNAAUI_NIVEL-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ldc_getaiu.sql" 
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_getaiu.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornaaui_nivel.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornaaui_nivel.sql
show errors;
 
prompt "--->Aplicando creacion de funcion adm_person.ldc_retornaaui_nivel.sql" 
@src/gascaribe/contratacion/funciones/adm_person.ldc_retornaaui_nivel.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornaaui_nivel.sql" 
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_retornaaui_nivel.sql
show errors;


prompt "-----4.FUNCION LDC_RETORNAFLAGASOUNIDPER-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornaflagasounidper.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornaflagasounidper.sql
show errors;
 
prompt "--->Aplicando creacion de funcion adm_person.ldc_retornaflagasounidper.sql" 
@src/gascaribe/contratacion/funciones/adm_person.ldc_retornaflagasounidper.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornaflagasounidper.sql" 
@src/gascaribe/contratacion/sinonimos/adm_person.ldc_retornaflagasounidper.sql
show errors;


prompt "-----5.FUNCION LDC_RETORAFECHMORFECHA-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.dbms_output.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.dbms_output.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.plitblm.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.plitblm.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ex.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ex.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retorafechmorfecha.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retorafechmorfecha.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retorafechmorfecha.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_retorafechmorfecha.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retorafechmorfecha.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_retorafechmorfecha.sql
show errors;


prompt "-----6.FUNCION LDC_RETORNACONCIDECAJE-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ca_detadocu.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ca_detadocu.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ca_document.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ca_document.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornaconcidecaje.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornaconcidecaje.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retornaconcidecaje.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_retornaconcidecaje.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornaconcidecaje.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_retornaconcidecaje.sql
show errors;


prompt "-----7.FUNCION LDC_RETORNACUPONCONCIDECAJE-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.concilia.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.concilia.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornacuponconcidecaje.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornacuponconcidecaje.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retornacuponconcidecaje.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_retornacuponconcidecaje.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornacuponconcidecaje.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_retornacuponconcidecaje.sql
show errors;


prompt "-----8.FUNCION LDC_RETORNADIFEROSINIESTRO-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ld_detail_liquidation.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ld_detail_liquidation.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornadiferosiniestro.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornadiferosiniestro.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retornadiferosiniestro.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_retornadiferosiniestro.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornadiferosiniestro.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_retornadiferosiniestro.sql
show errors;


prompt "-----9.FUNCION LDC_RETORNAPROMED-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_retornapromed.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornapromed.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_retornapromed.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_retornapromed.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_retornapromed.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_retornapromed.sql
show errors;


prompt "-----10.FUNCION LDC_SBRETORNACODDANE-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.daldc_equiva_localidad.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.daldc_equiva_localidad.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_sbretornacoddane.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_sbretornacoddane.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_sbretornacoddane.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ldc_sbretornacoddane.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_sbretornacoddane.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_sbretornacoddane.sql
show errors;


prompt "-----11.FUNCION LD_FA_FNU_AREA_TYPE-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ld_fa_paragene.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_paragene.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ld_fa_fnu_area_type.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ld_fa_fnu_area_type.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ld_fa_fnu_area_type.sql" 
@src/gascaribe/facturacion/funciones/adm_person.ld_fa_fnu_area_type.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ld_fa_fnu_area_type.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ld_fa_fnu_area_type.sql
show errors;
 

prompt "-----12.FUNCION NUTRAEUTLLECTFACT-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N nutraeutllectfact.sql" 
@src/gascaribe/papelera-reciclaje/funciones/nutraeutllectfact.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.nutraeutllectfact.sql" 
@src/gascaribe/facturacion/funciones/adm_person.nutraeutllectfact.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.nutraeutllectfact.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.nutraeutllectfact.sql
show errors; 
 

prompt "-----13.FUNCION OBTENERSALDORED-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N obtenersaldored.sql" 
@src/gascaribe/papelera-reciclaje/funciones/obtenersaldored.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.obtenersaldored.sql" 
@src/gascaribe/facturacion/funciones/adm_person.obtenersaldored.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.obtenersaldored.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.obtenersaldored.sql
show errors;  
 

prompt "-----14.FUNCION LDC_TELE_PREFIJO-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.dual.sql" 
@src/gascaribe/general/sinonimos/adm_person.dual.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.daab_address.sql" 
@src/gascaribe/general/sinonimos/adm_person.daab_address.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ge_subs_phone.sql" 
@src/gascaribe/general/sinonimos/adm_person.ge_subs_phone.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_tele_prefijo.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_tele_prefijo.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_tele_prefijo.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_tele_prefijo.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_tele_prefijo.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_tele_prefijo.sql
show errors;   
 
 
prompt "-----15.FUNCION LDC_TIPO_DE_TELEF-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_tipo_de_telef.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_tipo_de_telef.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_tipo_de_telef.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_tipo_de_telef.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_tipo_de_telef.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_tipo_de_telef.sql
show errors;  
 

prompt "-----16.FUNCION LDC_VALIDAORDENINSTANCE-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_validaordeninstance.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_validaordeninstance.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_validaordeninstance.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_validaordeninstance.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_validaordeninstance.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_validaordeninstance.sql
show errors;  


prompt "-----17.FUNCION LDC_VISUALCONDTER-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ld_boconstans.sql" 
@src/gascaribe/general/sinonimos/adm_person.ld_boconstans.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_visualcondter.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_visualcondter.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_visualcondter.sql" 
@src/gascaribe/general/funciones/adm_person.ldc_visualcondter.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_visualcondter.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldc_visualcondter.sql
show errors;  


prompt "-----18.FUNCION usu_normalizado_vigente-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N usu_normalizado_vigente.sql" 
@src/gascaribe/papelera-reciclaje/funciones/usu_normalizado_vigente.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.usu_normalizado_vigente.sql" 
@src/gascaribe/general/funciones/adm_person.usu_normalizado_vigente.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.usu_normalizado_vigente.sql" 
@src/gascaribe/general/sinonimos/adm_person.usu_normalizado_vigente.sql
show errors;  
 
 
prompt "-----19.FUNCION LDC_SHOW_PAYMENT_ORDERS-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.daor_operating_unit.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daor_operating_unit.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_show_payment_orders.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_show_payment_orders.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_show_payment_orders.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_show_payment_orders.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_show_payment_orders.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_show_payment_orders.sql
show errors;   
 

prompt "-----20.FUNCION LDC_TECNICOS_CERTIFICADO-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N ldc_tecnicos_certificado.sql" 
@src/gascaribe/papelera-reciclaje/funciones/ldc_tecnicos_certificado.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.ldc_tecnicos_certificado.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_tecnicos_certificado.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.ldc_tecnicos_certificado.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_tecnicos_certificado.sql
show errors;  


prompt "-----21.FUNCION SBDATEMAXUNO-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N sbdatemaxuno.sql" 
@src/gascaribe/papelera-reciclaje/funciones/sbdatemaxuno.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.sbdatemaxuno.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.sbdatemaxuno.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.sbdatemaxuno.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.sbdatemaxuno.sql
show errors;  

 
prompt "-----ACTUALIZAR REGISTRO-----" 

prompt "--->Aplicando actualizacion de objetos migrados"
@src/gascaribe/general/sql/OSF-2104_actualizar_obj_migrados.sql
show errors;


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-2104-----"
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