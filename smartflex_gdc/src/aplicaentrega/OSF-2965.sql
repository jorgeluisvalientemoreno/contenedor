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

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/pr_2812.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pr_2812.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/pr_2837.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pr_2837.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/prdatafix635.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prdatafix635.sql 

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H1.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H1.sql  

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H2.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H2.sql  

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H3.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H3.sql   

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H4.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H4.sql    

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H5.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H5.sql   

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H6.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H6.sql    

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H7.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H7.sql    

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H8.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H8.sql     

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H9.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H9.sql    

prompt "Aplicando src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H10.sql"
@src/gascaribe/facturacion/tarifa_transitoria/procedimiento/PRDATAFIX635_H10.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/prexeupdatebrujula.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prexeupdatebrujula.sql  

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/prupdatebrujula.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prupdatebrujula.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao456560_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao456560_p01_e01.sql  

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao457493_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao457493_p01_e01.sql   

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao460769_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao460769_p01_e01.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao460769_p02_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao460769_p02_e01.sql  

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e02.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e02.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e03.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e03.sql 

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e04.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e04.sql  

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e05.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e05.sql  

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e06.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao464794_p01_e06.sql  

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao469244_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao469244_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao469837_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao469837_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao472531_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao472531_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao472531_p01_e02.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao472531_p01_e02.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao474383_p01_e02.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao474383_p01_e02.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao474383_p01_e03.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao474383_p01_e03.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao475308_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao475308_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao478465_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao478465_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao479674_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao479674_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao479674_p01_e02.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao479674_p01_e02.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao484879_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao484879_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao485226_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao485226_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao487346_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao487346_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao488936_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao488936_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao496277_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao496277_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao505535_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao505535_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao512497_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao512497_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao547566_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gd_sao547566_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gdc_sao547566_p01_e03.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gdc_sao547566_p01_e03.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/so_gdc_sao548565_p01_e01.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/so_gdc_sao548565_p01_e01.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/tmp_cambiar_instancia_negativo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/tmp_cambiar_instancia_negativo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/tmp_practdiferido.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/tmp_practdiferido.sql

prompt "Aplicando src/gascaribe/sistema-brilla/trunc_ld_quota_by_subsc_temp.sql"
@src/gascaribe/sistema-brilla/trunc_ld_quota_by_subsc_temp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/truncate_table_ldcbi.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/truncate_table_ldcbi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2965_act_obj_mig.sql"
@src/gascaribe/datafix/OSF-2965_act_obj_mig.sql

prompt "Recompilando objetos invalidos"
@src/test/recompilar-objetos.sql

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