column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2745"
prompt "-----------------"

prompt "-----paquete DALDC_IMCOSEEL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_imcoseel.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_imcoseel.sql


prompt "-----paquete DALDC_IPLI_IO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_ipli_io.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ipli_io.sql


prompt "-----paquete DALDC_ITEM_OBJ-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_item_obj.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_item_obj.sql


prompt "-----paquete DALDC_ITEMS_CONEXIONES-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_items_conexiones.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_items_conexiones.sql


prompt "-----paquete DALDC_LDC_ACTI_UNID_BLOQ-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_ldc_acti_unid_bloq.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ldc_acti_unid_bloq.sql


prompt "-----paquete DALDC_LDC_SCORHIST-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_ldc_scorhist.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_ldc_scorhist.sql


prompt "-----paquete DALDC_LV_LEY_1581-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_lv_ley_1581.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_lv_ley_1581.sql


prompt "-----paquete DALDC_MACOMCTT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_macomctt.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_macomctt.sql


prompt "-----paquete DALDC_PKGMANTGRUPLOCA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_pkgmantgruploca.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_pkgmantgruploca.sql


prompt "-----paquete DALDC_PKGMANTGRUPO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_pkgmantgrupo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_pkgmantgrupo.sql


prompt "-----paquete DALDC_PLANTEMP-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_plantemp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_plantemp.sql


prompt "-----paquete DALDC_PROGRAMAS_VIVIENDA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_programas_vivienda.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_programas_vivienda.sql


prompt "-----paquete DALDC_PROMO_FNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_promo_fnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_promo_fnb.sql


prompt "-----paquete DALDC_PROVEED_INSTAL_FNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_proveed_instal_fnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_proveed_instal_fnb.sql


prompt "-----paquete DALDC_RECLAMOS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_reclamos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_reclamos.sql


prompt "-----paquete DALDC_REGIASOBANC-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_regiasobanc.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_regiasobanc.sql


prompt "-----paquete DALDC_RESOGURE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_resogure.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_resogure.sql


prompt "-----paquete DALDC_RESPUESTA_CAUSAL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_respuesta_causal.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_respuesta_causal.sql


prompt "-----paquete DALDC_RETROACTIVE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_retroactive.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_retroactive.sql


prompt "-----paquete DALDC_TASKACTCOSTPROM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN daldc_taskactcostprom.sql"
@src/gascaribe/papelera-reciclaje/paquetes/daldc_taskactcostprom.sql


prompt "-----Script OSF-2745_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2745_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2745-----"
prompt "-----------------------"
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on

prompt "-----RECOMPILAR OBJETOS-----"
prompt "--->Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;
