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

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_ordenes_rp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_ordenes_rp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_cuadrebodegasactivo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_cuadrebodegasactivo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccuadrebodega.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proccuadrebodega.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_filltable.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_filltable.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_ftable.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_ftable.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldci_preplicacecoloca.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldci_preplicacecoloca.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_jobfechavigentes.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_jobfechavigentes.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenaprovisioncosto.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenaprovisioncosto.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenareporteconsumvaluni.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_llenareporteconsumvaluni.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_revokeorder.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_os_revokeorder.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcalcar.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcalcar.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcalidadcartera.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcalidadcartera.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgenerecoacrp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prgenerecoacrp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procconuni.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procconuni.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procllenaindicadorcartera.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procllenaindicadorcartera.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procpvco.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procpvco.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_progenprocartera.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_progenprocartera.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcprovcart.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprovcart.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_revocar_orden.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_revocar_orden.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_searchfile_sendemail.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_searchfile_sendemail.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldrefa.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldrefa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/pro_graba_log_hilos.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pro_graba_log_hilos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/prregfacporprod.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prregfacporprod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcireplicaceco.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcireplicaceco.sql

prompt "Aplicando src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgenerecoacrp.sql"
@src/gascaribe/revision-periodica/procedimientos/adm_person.ldc_prgenerecoacrp.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgenerecoacrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_prgenerecoacrp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_regfacprod.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_regfacprod.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_osf_provcost.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_provcost.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/total_cart_mes_conc.sql"
@src/gascaribe/papelera-reciclaje/tablas/total_cart_mes_conc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/total_cart_mes_conc_refi.sql"
@src/gascaribe/papelera-reciclaje/tablas/total_cart_mes_conc_refi.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_fundesarrollo.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_fundesarrollo.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_log_pb_hilos.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_log_pb_hilos.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_calidad_cartera.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_calidad_cartera.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_osf_repoconsumos.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_repoconsumos.sql

prompt "Aplicando src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_121603.sql"
@src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_121603.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/schedules/job_cuadres_bobegas.sql"
@src/gascaribe/papelera-reciclaje/schedules/job_cuadres_bobegas.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2741_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2677_actualizar_obj_migrados.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2677_actualizar_obs_ejecutable.sql"
@src/gascaribe/datafix/OSF-2677_actualizar_obs_ejecutable.sql

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