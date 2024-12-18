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

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006462.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006462.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006465.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006465.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006466.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006466.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006467.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006467.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006468.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006468.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006469.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006469.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006470.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006470.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006471.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006471.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006472.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006472.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006473.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006473.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006474.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006474.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006475.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006475.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006476.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121006476.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121038651.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121038651.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121067081.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121067081.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121146928.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121146928.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121146932.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121146932.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121146936.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121146936.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121152948.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121152948.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121171952.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121171952.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121171953.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121171953.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121175202.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121175202.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177867.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177867.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177868.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177868.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177870.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177870.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177871.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177871.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177872.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177872.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177873.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121177873.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121207021.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121207021.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121269558.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121269558.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121285637.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121285637.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121310738.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121310738.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fabsct93e121398626.sql"
@src/gascaribe/papelera-reciclaje/funciones/fabsct93e121398626.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gege_exerulval_ct69e121036951.sql"
@src/gascaribe/papelera-reciclaje/funciones/gege_exerulval_ct69e121036951.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gege_exerulval_ct69e121036953.sql"
@src/gascaribe/papelera-reciclaje/funciones/gege_exerulval_ct69e121036953.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/gege_exerulval_ct69e121036955.sql"
@src/gascaribe/papelera-reciclaje/funciones/gege_exerulval_ct69e121036955.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121007987.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121007987.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008829.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008829.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008830.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008830.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008857.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008857.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008858.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008858.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008888.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008888.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008922.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121008922.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036956.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036956.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036957.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036957.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036958.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036958.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036959.sql"
@src/gascaribe/papelera-reciclaje/funciones/ge_exeaction_ct1e121036959.sql 
prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/imim_ct101e121023985.sql"
@src/gascaribe/papelera-reciclaje/funciones/imim_ct101e121023985.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/cc_pol_brilla_ct585e121007389.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/cc_pol_brilla_ct585e121007389.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/cc_pol_brilla_ct585e121007390.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/cc_pol_brilla_ct585e121007390.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/cc_pol_brilla_ct585e121062877.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/cc_pol_brilla_ct585e121062877.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121140861.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121140861.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121140862.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121140862.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121174575.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121174575.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121351826.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fabrct56e121351826.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000675.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000675.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000676.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000676.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000677.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000677.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000896.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000896.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000903.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000903.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000904.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121000904.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121007043.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121007043.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121007046.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121007046.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121047679.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121047679.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176912.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176912.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176913.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176913.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176914.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176914.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176920.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176920.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176922.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176922.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176923.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121176923.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121208347.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121208347.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121208348.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121208348.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121208349.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e121208349.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e21384.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/fwfw_process_ct54e21384.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006664.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006664.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006757.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006757.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006758.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006758.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006759.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121006759.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008788.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008788.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008789.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008789.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008790.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008790.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008791.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008791.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008792.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008792.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008793.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008793.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008794.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008794.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008800.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008800.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008801.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008801.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008802.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008802.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008803.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008803.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008804.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008804.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008805.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008805.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008806.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008806.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008813.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008813.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008814.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008814.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008815.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008815.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008817.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008817.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008818.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008818.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008819.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008819.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008820.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008820.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008824.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008824.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008826.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008826.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008827.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008827.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008837.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008837.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008838.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008838.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008839.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008839.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008841.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008841.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008842.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008842.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008861.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008861.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008862.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008862.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008863.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008863.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008865.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008865.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008866.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121008866.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121061643.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121061643.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121061724.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gc_contractorsct321e121061724.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008756.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008756.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008757.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008757.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008758.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008758.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008759.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008759.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008760.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008760.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008761.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008761.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008763.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008763.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008764.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008764.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008765.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008765.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008766.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008766.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008767.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008767.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008768.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008768.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008769.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008769.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008770.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008770.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008771.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008771.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008772.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008772.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008780.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008780.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008828.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008828.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008845.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008845.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008867.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008867.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008873.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121008873.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121036952.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121036952.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121036954.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121036954.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121122437.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121122437.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121262400.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121262400.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121388989.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/gege_exerulval_ct69e121388989.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ge_exeaction_ct1e121008821.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ge_exeaction_ct1e121008821.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ge_exeaction_ct1e153000786.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ge_exeaction_ct1e153000786.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_eve_comp_ct65e121040041.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_eve_comp_ct65e121040041.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_eve_comp_ct65e121296516.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_eve_comp_ct65e121296516.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121007429.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121007429.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121007430.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121007430.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121007431.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121007431.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121029467.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121029467.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121029468.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121029468.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121029469.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121029469.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121039517.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121039517.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121039518.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121039518.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121039519.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121039519.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121040036.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121040036.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121040037.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121040037.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121040038.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121040038.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121079823.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121079823.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296498.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296498.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296499.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296499.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296500.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296500.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296501.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296501.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296502.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296502.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296503.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296503.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296504.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296504.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296506.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296506.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296508.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296508.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296509.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296509.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296511.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296511.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296512.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296512.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296513.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296513.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296514.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296514.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296515.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121296515.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388977.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388977.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388980.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388980.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388981.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388981.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388983.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388983.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388984.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388984.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388985.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388985.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388987.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388987.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388988.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_initatrib_ct23e121388988.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121079824.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121079824.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121296505.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121296505.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121296507.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121296507.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121296510.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121296510.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388978.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388978.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388979.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388979.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388982.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388982.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388986.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/mo_validattr_ct26e121388986.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042183.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042183.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042184.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042184.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042185.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042185.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042186.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121042186.sql
prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121379978.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/or_sel_tastyp_ct404e121379978.sql



prompt "Aplicando src/gascaribe/general/tablas/personalizaciones.master_personalizaciones.sql"
@src/gascaribe/general/tablas/personalizaciones.master_personalizaciones.sql


prompt "Aplicando src/gascaribe/datafix/OSF-2078.sql"
@src/gascaribe/datafix/OSF-2078.sql







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