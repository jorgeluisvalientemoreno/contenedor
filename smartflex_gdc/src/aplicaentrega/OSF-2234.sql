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

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_osf_estaproc.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_estaproc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fnuobtenerlectactual.sql"
@src/gascaribe/papelera-reciclaje/funciones/fnuobtenerlectactual.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.fnuobtenerlectactual.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.fnuobtenerlectactual.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnuobtenerlectactual.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnuobtenerlectactual.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fnuobtenerlectanterior.sql"
@src/gascaribe/papelera-reciclaje/funciones/fnuobtenerlectanterior.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.fnuobtenerlectanterior.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.fnuobtenerlectanterior.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnuobtenerlectanterior.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnuobtenerlectanterior.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fncreculultplanfinan.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncreculultplanfinan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_fncreculultplanfinan.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_fncreculultplanfinan.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_fncreculultplanfinan.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_fncreculultplanfinan.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaprocejecierr.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaprocejecierr.sql

prompt "Aplicando src/gascaribe/Cierre/funciones/adm_person.ldc_fncretornaprocejecierr.sql"
@src/gascaribe/Cierre/funciones/adm_person.ldc_fncretornaprocejecierr.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ldc_fncretornaprocejecierr.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldc_fncretornaprocejecierr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_edad_mes.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_edad_mes.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_edad_mes.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_edad_mes.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_edad_mes.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_edad_mes.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_getedadrp.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_getedadrp.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_getedadrp.sql"
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_getedadrp.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_getedadrp.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_getedadrp.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2234_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2234_actualizar_obj_migrados.sql

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
