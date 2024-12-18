column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "------------------------------------------------------"
prompt "Aplicando Entrega OSF-50"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/parametros/insldc_acti_new_warranty.sql"
@src/gascaribe/servicios-asociados/areas-comunes/parametros/ldc_acti_new_warranty.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/parametros/insldc_email_reg_notif.sql"
@src/gascaribe/servicios-asociados/areas-comunes/parametros/ldc_email_reg_notif.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/parametros/insldc_task_type_warranty.sql"
@src/gascaribe/servicios-asociados/areas-comunes/parametros/ldc_task_type_warranty.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/parametros/insldc_tolerancia_items_coti.sql"
@src/gascaribe/servicios-asociados/areas-comunes/parametros/ldc_tolerancia_items_coti.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/tablas/ldc_flag_garantia.sql"
@src/gascaribe/servicios-asociados/areas-comunes/tablas/ldc_flag_garantia.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/tablas/comenldc_flag_garantia.sql"
@src/gascaribe/servicios-asociados/areas-comunes/tablas/comenldc_flag_garantia.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/tablas/permisos.sql"
@src/gascaribe/servicios-asociados/areas-comunes/tablas/permisos.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/paquetes/pgk_ldcauto1.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pgk_ldcauto1.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/paquetes/pkg_ldcgridldcaplac.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pkg_ldcgridldcaplac.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/framework/giras/LDCAPLAC.sql"
@src/gascaribe/servicios-asociados/areas-comunes/framework/giras/LDCAPLAC.sql


prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/