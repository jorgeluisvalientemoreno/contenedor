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

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_boequivalencvalues.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_boequivalencvalues.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_equivalence_set.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_equivalence_set.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ld_subsidy.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ld_subsidy.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_ope_uni_task_type.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_ope_uni_task_type.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.hicaesco.sql"
@src/gascaribe/cartera/sinonimo/adm_person.hicaesco.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkbchicaesco.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkbchicaesco.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.mo_gas_sale_data.sql"
@src/gascaribe/ventas/sinonimos/adm_person.mo_gas_sale_data.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cf_bostatementswf.sql"
@src/gascaribe/general/sinonimos/adm_person.cf_bostatementswf.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_item_work_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ld_item_work_order.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.damo_motive.sql"
@src/gascaribe/general/sinonimos/adm_person.damo_motive.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.dald_non_ba_fi_requ.sql"
@src/gascaribe/fnb/sinonimos/adm_person.dald_non_ba_fi_requ.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbillconst.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbillconst.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.fa_bopoliticaredondeo.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.fa_bopoliticaredondeo.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_per_comercial.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_per_comercial.sql


prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnugettasktypebysubs.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnugettasktypebysubs.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugettasktypebysubs.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugettasktypebysubs.sql

prompt "src/gascaribe/ventas/sinonimos/adm_person.ldc_fnugettasktypebysubs.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnugettasktypebysubs.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fnugetvasuptitr.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fnugetvasuptitr.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetvasuptitr.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetvasuptitr.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fnugetvasuptitr.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fnugetvasuptitr.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fnugetzeroconsper2.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.ldc_fnugetzeroconsper2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetzeroconsper2.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnugetzeroconsper2.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_fnugetzeroconsper2.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.ldc_fnugetzeroconsper2.sql

prompt "Aplicando src/gascaribe/actas/funciones/adm_person.ldc_fnuretactaorden.sql"
@src/gascaribe/actas/funciones/adm_person.ldc_fnuretactaorden.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretactaorden.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretactaorden.sql

prompt "Aplicando src/gascaribe/actas/sinonimos/adm_person.ldc_fnuretactaorden.sql"
@src/gascaribe/actas/sinonimos/adm_person.ldc_fnuretactaorden.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fnuretdepalocacliente.sql"
@src/gascaribe/atencion-usuarios/funciones/adm_person.ldc_fnuretdepalocacliente.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretdepalocacliente.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretdepalocacliente.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fnuretdepalocacliente.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_fnuretdepalocacliente.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnuretinfodatoadicord.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnuretinfodatoadicord.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretinfodatoadicord.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretinfodatoadicord.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuretinfodatoadicord.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuretinfodatoadicord.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnuretinfoordenrutero.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnuretinfoordenrutero.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretinfoordenrutero.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuretinfoordenrutero.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuretinfoordenrutero.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuretinfoordenrutero.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_fnuultestacort.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_fnuultestacort.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuultestacort.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuultestacort.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_fnuultestacort.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_fnuultestacort.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnuvalidacasosinstala.sql"
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnuvalidacasosinstala.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalidacasosinstala.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalidacasosinstala.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnuvalidacasosinstala.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnuvalidacasosinstala.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnuvalidacasosrepara.sql"
@src/gascaribe/revision-periodica/certificados/funciones/adm_person.ldc_fnuvalidacasosrepara.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalidacasosrepara.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalidacasosrepara.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnuvalidacasosrepara.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.ldc_fnuvalidacasosrepara.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnuvaliprocesppago.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnuvaliprocesppago.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvaliprocesppago.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvaliprocesppago.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuvaliprocesppago.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuvaliprocesppago.sql

prompt "Aplicando src/gascaribe/fnb/funciones/adm_person.ldc_fnuvalquoiniart.sql"
@src/gascaribe/fnb/funciones/adm_person.ldc_fnuvalquoiniart.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalquoiniart.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalquoiniart.sql

prompt "Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_fnuvalquoiniart.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_fnuvalquoiniart.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnuvalventcomi.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnuvalventcomi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalventcomi.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalventcomi.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuvalventcomi.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuvalventcomi.sql

prompt "Aplicando src/gascaribe/ventas/funciones/adm_person.ldc_fnuvalventtypack.sql"
@src/gascaribe/ventas/funciones/adm_person.ldc_fnuvalventtypack.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalventtypack.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fnuvalventtypack.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuvalventtypack.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_fnuvalventtypack.sql

prompt "Aplicando src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanoactual.sql"
@src/gascaribe/Cierre/funciones/adm_person.ldcfnu_venanoactual.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldcfnu_venanoactual.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldcfnu_venanoactual.sql

prompt "Aplicando src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanoactual.sql"
@src/gascaribe/Cierre/sinonimos/adm_person.ldcfnu_venanoactual.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2101_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2101_actualizar_obj_migrados.sql

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
