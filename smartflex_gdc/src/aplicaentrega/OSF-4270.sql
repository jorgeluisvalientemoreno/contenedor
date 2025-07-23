column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-4270"
prompt "-----------------"

prompt "-----PAQUETES-----" 
prompt "Modificacion paquete pkg_bccomponentes" 
@src/gascaribe/general/paquetes/adm_person.pkg_bccomponentes.sql

prompt "Modificacion paquete pkg_componente_producto" 
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql

prompt "Modificacion paquete pkg_pr_comp_suspension"
@src/gascaribe/general/paquetes/adm_person.pkg_pr_comp_suspension.sql

prompt "Modificacion paquete pkg_pr_prod_suspension"
@src/gascaribe/general/paquetes/adm_person.pkg_pr_prod_suspension.sql

prompt "Modificacion paquete pkg_producto"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql

prompt "Creacion paquete pkg_mo_suspension"
@src/gascaribe/general/paquetes/adm_person.pkg_mo_suspension.sql
@src/gascaribe/general/sinonimos/adm_person.pkg_mo_suspension.sql

prompt "Creacion paquete pkg_mo_suspension_comp"
@src/gascaribe/general/paquetes/adm_person.pkg_mo_suspension_comp.sql
@src/gascaribe/general/sinonimos/adm_person.pkg_mo_suspension_comp.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-4270-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on