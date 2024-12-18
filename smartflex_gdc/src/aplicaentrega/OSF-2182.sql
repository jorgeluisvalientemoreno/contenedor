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

prompt "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_item_novelty.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ct_item_novelty.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_bonotificaciones.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_bonotificaciones.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.gw_boerrors.sql"
@src/gascaribe/general/sinonimos/adm_person.gw_boerrors.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_reportesconsulta.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_reportesconsulta.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_bcperiodicreview.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_bcperiodicreview.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_ctrllectura.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_ctrllectura.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.or_ope_uni_item_bala.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.or_ope_uni_item_bala.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnurealizaventa.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnurealizaventa.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnurealizaventa.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnurealizaventa.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnurealizaventa.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnurealizaventa.sql

prompt "Aplicando @src/gascaribe/papelera-reciclaje/funciones/ldc_fnurealizaventaweb.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnurealizaventaweb.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnurealizaventaweb.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnurealizaventaweb.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnurealizaventaweb.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnurealizaventaweb.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuulotproducto.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuulotproducto.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnuulotproducto.sql"
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnuulotproducto.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnuulotproducto.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnuulotproducto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuunitraconecoatci.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuunitraconecoatci.sql

prompt "Aplicando src/gascaribe/gestion-contratista/funciones/adm_person.ldc_fnuunitraconecoatci.sql"
@src/gascaribe/gestion-contratista/funciones/adm_person.ldc_fnuunitraconecoatci.sql

prompt "Aplicando src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_fnuunitraconecoatci.sql"
@src/gascaribe/gestion-contratista/sinonimos/adm_person.ldc_fnuunitraconecoatci.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvisualizaorplo.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvisualizaorplo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fnuvisualizaorplo.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fnuvisualizaorplo.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fnuvisualizaorplo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fnuvisualizaorplo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbdatoadicional.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbdatoadicional.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbdatoadicional.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbdatoadicional.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbdatoadicional.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbdatoadicional.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbdeptoperifact.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbdeptoperifact.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_fsbdeptoperifact.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_fsbdeptoperifact.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_fsbdeptoperifact.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fsbdeptoperifact.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetordercoments.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetordercoments.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbgetordercoments.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbgetordercoments.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbgetordercoments.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbgetordercoments.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetpendorderscm.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbgetpendorderscm.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_fsbgetpendorderscm.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_fsbgetpendorderscm.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_fsbgetpendorderscm.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_fsbgetpendorderscm.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbvalidaactiv_bloq.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbvalidaactiv_bloq.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbvalidaactiv_bloq.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbvalidaactiv_bloq.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbvalidaactiv_bloq.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbvalidaactiv_bloq.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_funvalidatransitunoper.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_funvalidatransitunoper.sql

prompt "Aplicando src/gascaribe/general/materiales/funciones/adm_person.ldc_funvalidatransitunoper.sql"
@src/gascaribe/general/materiales/funciones/adm_person.ldc_funvalidatransitunoper.sql

prompt "Aplicando src/gascaribe/general/materiales/sinonimos/adm_person.ldc_funvalidatransitunoper.sql"
@src/gascaribe/general/materiales/sinonimos/adm_person.ldc_funvalidatransitunoper.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_getvaluerp.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_getvaluerp.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_getvaluerp.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_getvaluerp.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_getvaluerp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_getvaluerp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldcprbloporval.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldcprbloporval.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldcprbloporval.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldcprbloporval.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprbloporval.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldcprbloporval.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_pro_esta_refinanciado.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_pro_esta_refinanciado.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_pro_esta_refinanciado.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_pro_esta_refinanciado.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_pro_esta_refinanciado.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pro_esta_refinanciado.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_ret_fecha_aten_anul.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_ret_fecha_aten_anul.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_ret_fecha_aten_anul.sql"
@src/gascaribe/general/funciones/adm_person.ldc_ret_fecha_aten_anul.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_ret_fecha_aten_anul.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_ret_fecha_aten_anul.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2182_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2182_actualizar_obj_migrados.sql

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
