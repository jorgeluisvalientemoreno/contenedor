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

prompt "Aplicando src/gascaribe/cartera/reconexiones/parametros/est_acti_prod_susp.sql"
@src/gascaribe/cartera/reconexiones/parametros/est_acti_prod_susp.sql

prompt "Aplicando src/gascaribe/cartera/reconexiones/parametros/esta_cort_acti_serv_susp.sql"
@src/gascaribe/cartera/reconexiones/parametros/esta_cort_acti_serv_susp.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pr_comp_suspension.sql"
@src/gascaribe/objetos-producto/sinonimos/pr_comp_suspension.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/sqsuspcone.sql"
@src/gascaribe/objetos-producto/sinonimos/sqsuspcone.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/inclcoco.sql"
@src/gascaribe/objetos-producto/sinonimos/inclcoco.sql

prompt "Aplicando src/gascaribe/cartera/reconexiones/paquetes/adm_person.pkg_suspcone.sql"
@src/gascaribe/cartera/reconexiones/paquetes/adm_person.pkg_suspcone.sql
show errors;

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_pr_prod_suspension.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_pr_prod_suspension.sql
show errors;

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_pr_prod_suspension.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_pr_prod_suspension.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_pr_comp_suspension.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_pr_comp_suspension.sql
show errors;

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_pr_comp_suspension.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_pr_comp_suspension.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql
show errors;

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql
show errors;

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_inclusion_cartera.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_inclusion_cartera.sql
show errors;

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_inclusion_cartera.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_inclusion_cartera.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql
show errors;

prompt "Aplicando src/gascaribe/calidad-medicion/procedimientos/personalizaciones.oal_activaproductosuspendido.sql"
@src/gascaribe/calidad-medicion/procedimientos/personalizaciones.oal_activaproductosuspendido.sql
show errors;

prompt "Aplicando src/gascaribe/calidad-medicion/sinonimos/personalizaciones.oal_activaproductosuspendido.sql"
@src/gascaribe/calidad-medicion/sinonimos/personalizaciones.oal_activaproductosuspendido.sql

prompt "Aplicando src/gascaribe/calidad-medicion/procedimientos/personalizaciones.prcactivaproductosuspendido.sql"
@src/gascaribe/calidad-medicion/procedimientos/personalizaciones.prcactivaproductosuspendido.sql
show errors;

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_inclusion_cartera.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_inclusion_cartera.sql
show errors;

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_inclusion_cartera.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_inclusion_cartera.sql

prompt "Aplicando src/gascaribe/calidad-medicion/sinonimos/personalizaciones.prcactivaproductosuspendido.sql"
@src/gascaribe/calidad-medicion/sinonimos/personalizaciones.prcactivaproductosuspendido.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/pktblsuspcone.insrecord.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/pktblsuspcone.insrecord.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_prod_suspension.updactive.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_prod_suspension.updactive.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_prod_suspension.updinactive_date.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_prod_suspension.updinactive_date.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_product.updproduct_status_id.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_product.updproduct_status_id.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_component.updcomponent_status_id.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_component.updcomponent_status_id.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_comp_suspension.updactive.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_comp_suspension.updactive.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_comp_suspension.updinactive_date.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_comp_suspension.updinactive_date.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dacompsesu.updcmssfein.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dacompsesu.updcmssfein.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_component.updcomponent_status_id_1.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_component.updcomponent_status_id_1.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/dapr_component.updservice_date.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/dapr_component.updservice_date.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/pkservsusc.updsesuincl.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/pkservsusc.updsesuincl.sql

prompt "Aplicando src/gascaribe/calidad-medicion/homologacion-servicios/pktblinclcoco.upcanceldate.sql"
@src/gascaribe/calidad-medicion/homologacion-servicios/pktblinclcoco.upcanceldate.sql

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
