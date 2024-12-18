column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/compensaciones/parametros/CAT_SIN_TIEM_COMP.sql"
@src/gascaribe/operacion-y-mantenimiento/compensaciones/parametros/cat_sin_tiem_comp.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/compensaciones/tablas/LDC_DAMAGE_PRODUCT_SIN_TIEM_COM.sql"
@src/gascaribe/operacion-y-mantenimiento/compensaciones/tablas/ldc_damage_product_sin_tiem_com.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/compensaciones/triggers/LDC_INSTT_DAMAGE_PRODUCT.sql"
@src/gascaribe/operacion-y-mantenimiento/compensaciones/triggers/ldc_instt_damage_product.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/