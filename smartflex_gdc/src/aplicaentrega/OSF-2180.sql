column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2126"
prompt "-----------------"


prompt "-----1.FUNCION FDTFECHA-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fdtfecha.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fdtfecha.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fdtfecha.sql" 
@src/gascaribe/general/funciones/adm_person.fdtfecha.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fdtfecha.sql" 
@src/gascaribe/general/sinonimos/adm_person.fdtfecha.sql
show errors;

 
prompt "-----2.FUNCION FNCVALICERTTECNASIGNACIRE-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fncvalicerttecnasignacire.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fncvalicerttecnasignacire.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fncvalicerttecnasignacire.sql" 
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.fncvalicerttecnasignacire.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fncvalicerttecnasignacire.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.fncvalicerttecnasignacire.sql
show errors;


prompt "-----3.FUNCION FNCVALIDACERTTECNASIGNACI-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fncvalidacerttecnasignaci.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fncvalidacerttecnasignaci.sql
show errors;
 
prompt "--->Aplicando creacion de funcion adm_person.fncvalidacerttecnasignaci.sql" 
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.fncvalidacerttecnasignaci.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fncvalidacerttecnasignaci.sql" 
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.fncvalidacerttecnasignaci.sql
show errors;

 
prompt "-----4.FUNCION FNUAPLICAENTREGA-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.fblaplicaentrega.sql" 
@src/gascaribe/general/sinonimos/adm_person.fblaplicaentrega.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnuaplicaentrega.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnuaplicaentrega.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnuaplicaentrega.sql" 
@src/gascaribe/general/funciones/adm_person.fnuaplicaentrega.sql 
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnuaplicaentrega.sql" 
@src/gascaribe/general/sinonimos/adm_person.fnuaplicaentrega.sql
show errors;


prompt "-----5.FUNCION FNUEXISTE_MEDIDOR_ROLLOUT-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnuexiste_medidor_rollout.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnuexiste_medidor_rollout.sql
show errors;
 
prompt "--->Aplicando creacion de funcion adm_person.fnuexiste_medidor_rollout.sql" 
@src/gascaribe/general/funciones/adm_person.fnuexiste_medidor_rollout.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnuexiste_medidor_rollout.sql" 
@src/gascaribe/general/sinonimos/adm_person.fnuexiste_medidor_rollout.sql
show errors;

 
prompt "-----6.FUNCION FNUGETTTOTRECONE-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnugetttotrecone.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnugetttotrecone.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnugetttotrecone.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.fnugetttotrecone.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnugetttotrecone.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.fnugetttotrecone.sql
show errors;

 
prompt "-----7.FUNCION FNU_LDC_GETSALDCONC-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnu_ldc_getsaldconc.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnu_ldc_getsaldconc.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnu_ldc_getsaldconc.sql" 
@src/gascaribe/facturacion/funciones/adm_person.fnu_ldc_getsaldconc.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnu_ldc_getsaldconc.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.fnu_ldc_getsaldconc.sql
show errors;


prompt "-----8.FUNCION FNUCUOTAINICIALCOM-----" 
 
prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnucuotainicialcom.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnucuotainicialcom.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnucuotainicialcom.sql" 
@src/gascaribe/facturacion/diferidos/funciones/adm_person.fnucuotainicialcom.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnucuotainicialcom.sql" 
@src/gascaribe/facturacion/diferidos/sinonimos/adm_person.fnucuotainicialcom.sql
show errors;

 
prompt "-----9.FUNCION FNUSUBS935-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnusubs935.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnusubs935.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnusubs935.sql" 
@src/gascaribe/facturacion/funciones/adm_person.fnusubs935.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnusubs935.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.fnusubs935.sql
show errors;

 
prompt "-----10.FUNCION FNUTIPOSUSPROLLOUT-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnutiposusprollout.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnutiposusprollout.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnutiposusprollout.sql" 
@src/gascaribe/general/funciones/adm_person.fnutiposusprollout.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnutiposusprollout.sql" 
@src/gascaribe/general/sinonimos/adm_person.fnutiposusprollout.sql
show errors;

 
prompt "-----11.FUNCION FNUVALIDAACTIVIDADROLUNIDAD-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.or_rol_unidad_trab.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_rol_unidad_trab.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.or_excep_act_unitrab.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_excep_act_unitrab.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.or_actividades_rol.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_actividades_rol.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnuvalidaactividadrolunidad.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnuvalidaactividadrolunidad.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnuvalidaactividadrolunidad.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.fnuvalidaactividadrolunidad.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnuvalidaactividadrolunidad.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.fnuvalidaactividadrolunidad.sql
show errors;

 
prompt "-----12.FUNCION fnuvalpropersca-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.sa_executable.sql" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.sa_executable.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fnuvalpropersca.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fnuvalpropersca.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fnuvalpropersca.sql" 
@src/gascaribe/revision-periodica/funciones/adm_person.fnuvalpropersca.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fnuvalpropersca.sq" 
@src/gascaribe/revision-periodica/sinonimos/adm_person.fnuvalpropersca.sql
show errors;

 
prompt "-----13.FUNCION FSBEDADCARTDIFERIDOS----------------------" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbedadcartdiferidos.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbedadcartdiferidos.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fsbedadcartdiferidos.sql" 
@src/gascaribe/cartera/funciones/adm_person.fsbedadcartdiferidos.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fsbedadcartdiferidos.sql" 
@src/gascaribe/cartera/sinonimo/adm_person.fsbedadcartdiferidos.sql
show errors;

 
prompt "-----14.FUNCION FSBGETMTSTUBERIAHIJAS-----" 

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsbgetmtstuberiahijas.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsbgetmtstuberiahijas.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fsbgetmtstuberiahijas.sql" 
@src/gascaribe/gestion-ordenes/funciones/adm_person.fsbgetmtstuberiahijas.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fsbgetmtstuberiahijas.sql" 
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.fsbgetmtstuberiahijas.sql
show errors;

 
prompt "-----15.FUNCION FSFUNCIONVALLDCISOMA-----" 

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ldci_motipedi.sql" 
@src/gascaribe/general/materiales/sinonimos/adm_person.ldci_motipedi.sql
show errors;

prompt "--->Aplicando creacion de sinonimo objeto interno adm_person.ex.sql" 
@src/gascaribe/general/materiales/sinonimos/adm_person.ex.sql
show errors;

prompt "--->Aplicando borrado de funcion en esquema anterior O P E N fsfuncionvalldcisoma.sql" 
@src/gascaribe/papelera-reciclaje/funciones/fsfuncionvalldcisoma.sql
show errors;

prompt "--->Aplicando creacion de funcion adm_person.fsfuncionvalldcisoma.sql" 
@src/gascaribe/general/materiales/funciones/adm_person.fsfuncionvalldcisoma.sql
show errors;

prompt "--->Aplicando creacion de sinonimo a nueva funcion adm_person.fsfuncionvalldcisoma.sql" 
@src/gascaribe/general/materiales/sinonimos/adm_person.fsfuncionvalldcisoma.sql
show errors;

 
prompt "-----ACTUALIZAR REGISTRO-----" 

prompt "--->Aplicando actualizacion de objetos migrados"
@src/gascaribe/general/sql/OSF-2180_act_obj_mig.sql
show errors;


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-2180-----"
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