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

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.dacc_sales_financ_cond.sql"
@src/gascaribe/ventas/sinonimos/adm_person.dacc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_numeros.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_numeros.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_specials_plan.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_specials_plan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_planfinmayprior.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_planfinmayprior.sql

prompt "Aplicando src/gascaribe/contratacion/sinonimos/adm_person.ge_tipo_contrato.sql"
@src/gascaribe/contratacion/sinonimos/adm_person.ge_tipo_contrato.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.daciclo.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.daciclo.sql

prompt "src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_uniopecert.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_uniopecert.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fvatelsubscriber.sql"
@src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fvatelsubscriber.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fvatelsubscriber.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fvatelsubscriber.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fvatelsubscriber.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fvatelsubscriber.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_getfinanvalsbypkgtype.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_getfinanvalsbypkgtype.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_getfinanvalsbypkgtype.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_getfinanvalsbypkgtype.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_getfinanvalsbypkgtype.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_getfinanvalsbypkgtype.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_importeenletras.sql"
@src/gascaribe/general/funciones/adm_person.ldc_importeenletras.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_importeenletras.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_importeenletras.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_importeenletras.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_importeenletras.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_plan_prio_finan.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_plan_prio_finan.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_plan_prio_finan.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_plan_prio_finan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_plan_prio_finan.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_plan_prio_finan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_pro_canti_refinanciado"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_pro_canti_refinanciado.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_pro_canti_refinanciado.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_pro_canti_refinanciado.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_pro_canti_refinanciado.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_pro_canti_refinanciado.sql

prompt "Aplicando src/gascaribe/actas/funciones/adm_person.ldc_procconsultaactasabiertas.sql"
@src/gascaribe/actas/funciones/adm_person.ldc_procconsultaactasabiertas.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_procconsultaactasabiertas.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_procconsultaactasabiertas.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/adm_person.ldc_procconsultaactasabiertas.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_procconsultaactasabiertas.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/funciones/adm_person.ldc_procconsultaprodotspno.sql"
@src/gascaribe/perdidas-no-operacionales/funciones/adm_person.ldc_procconsultaprodotspno.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_procconsultaprodotspno.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_procconsultaprodotspno.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_procconsultaprodotspno.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_procconsultaprodotspno.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/funciones/adm_person.ldc_prodsuspend.sql"
@src/gascaribe/cartera/suspensiones/funciones/adm_person.ldc_prodsuspend.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_prodsuspend.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_prodsuspend.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_prodsuspend.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.ldc_prodsuspend.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_prsusprvseg.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_prsusprvseg.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_prsusprvseg.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_prsusprvseg.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prsusprvseg.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prsusprvseg.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.ldc_pruocertificacion.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.ldc_pruocertificacion.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_pruocertificacion.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_pruocertificacion.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pruocertificacion.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pruocertificacion.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_retoracobroreconex.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_retoracobroreconex.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retoracobroreconex.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retoracobroreconex.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_retoracobroreconex.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retoracobroreconex.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_retoractassaldosusp.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_retoractassaldosusp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retoractassaldosusp.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retoractassaldosusp.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_retoractassaldosusp.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retoractassaldosusp.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_retoradeduaafecha.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_retoradeduaafecha.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retoradeduaafecha.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retoradeduaafecha.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_retoradeduaafecha.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retoradeduaafecha.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_retoradeudapresenmes.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_retoradeudapresenmes.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retoradeudapresenmes.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retoradeudapresenmes.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_retoradeudapresenmes.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_retoradeudapresenmes.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2103_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2103_actualizar_obj_migrados.sql

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
