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


prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ut_mailpost.sql"
@src/gascaribe/general/sinonimos/adm_person.ut_mailpost.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.pr_bcproduct.sql"
@src/gascaribe/general/sinonimos/adm_person.pr_bcproduct.sql

prompt " Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_generateautorder.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.os_generateautorder.sql

prompt " Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofw_process.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofw_process.sql

prompt " Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofwlegalizeorderutil.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.or_bofwlegalizeorderutil.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_solinean.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_solinean.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_solemernot.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_solemernot.sql

prompt " Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldc_inpraprov.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_inpraprov.sql

prompt " Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cartdiaria.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ge_activity.sql"
@src/gascaribe/general/sinonimos/adm_person.ge_activity.sql

prompt " Aplicando src/gascaribe/cartera/sinonimo/adm_person.confesco.sql"
@src/gascaribe/cartera/sinonimo/adm_person.confesco.sql

prompt " Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_causal.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.cc_causal.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.mo_bcpackages.sql"
@src/gascaribe/general/sinonimos/adm_person.mo_bcpackages.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfinaorderp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prfinaorderp.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvalidalectura.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prvalidalectura.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prpostfechadoschecks.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prpostfechadoschecks.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procexogena.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procexogena.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/prfinanordenesprp.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/prfinanordenesprp.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_plugsendnotifi.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_plugsendnotifi.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_procliquidaordenestrabajo.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procliquidaordenestrabajo.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcartcastconc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcartcastconc.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_asigcontypresgdc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_asigcontypresgdc.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prexogena.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prexogena.sql

prompt " Aplicando src/gascaribe/cartera/reconexiones/procedimientos/ldc_createsuspcone.sql"
@src/gascaribe/cartera/reconexiones/procedimientos/ldc_createsuspcone.sql

prompt " Aplicando src/gascaribe/cartera/reconexiones/procedimientos/adm_person.ldc_createsuspcone.sql"
@src/gascaribe/cartera/reconexiones/procedimientos/adm_person.ldc_createsuspcone.sql

prompt " Aplicando src/gascaribe/cartera/reconexiones/sinonimos/adm_person.ldc_createsuspcone.sql"
@src/gascaribe/cartera/reconexiones/sinonimos/adm_person.ldc_createsuspcone.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcreasigorden.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_prcreasigorden.sql

prompt " Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prcreasigorden.sql"
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_prcreasigorden.sql

prompt " Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prcreasigorden.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_prcreasigorden.sql

prompt " Aplicando src/gascaribe/fnb/procedimientos/ldc_pasadifeapmplano.sql"
@src/gascaribe/fnb/procedimientos/ldc_pasadifeapmplano.sql

prompt " Aplicando src/gascaribe/fnb/procedimientos/adm_person.ldc_pasadifeapmplano.sql"
@src/gascaribe/fnb/procedimientos/adm_person.ldc_pasadifeapmplano.sql

prompt " Aplicando src/gascaribe/fnb/sinonimos/adm_person.ldc_pasadifeapmplano.sql"
@src/gascaribe/fnb/sinonimos/adm_person.ldc_pasadifeapmplano.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_delete_wf_instance.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_delete_wf_instance.sql

prompt " Aplicando src/gascaribe/general/procedimientos/adm_person.ldc_delete_wf_instance.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_delete_wf_instance.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_delete_wf_instance.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_delete_wf_instance.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_envianotifsolemergencia.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_envianotifsolemergencia.sql

prompt " Aplicando src/gascaribe/operacion-y-mantenimiento/procedimientos/adm_person.ldc_envianotifsolemergencia.sql"
@src/gascaribe/operacion-y-mantenimiento/procedimientos/adm_person.ldc_envianotifsolemergencia.sql

prompt " Aplicando src/gascaribe/operacion-y-mantenimiento/sinonimos/adm_person.ldc_envianotifsolemergencia.sql"
@src/gascaribe/operacion-y-mantenimiento/sinonimos/adm_person.ldc_envianotifsolemergencia.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/pranulasolinego.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/pranulasolinego.sql

prompt " Aplicando src/gascaribe/cartera/procedimientos/adm_person.pranulasolinego.sql"
@src/gascaribe/cartera/procedimientos/adm_person.pranulasolinego.sql

prompt " Aplicando src/gascaribe/cartera/sinonimo/adm_person.pranulasolinego.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pranulasolinego.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcprgennoaprov.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcprgennoaprov.sql

prompt " Aplicando src/gascaribe/ventas/procedimientos/adm_person.ldcprgennoaprov.sql"
@src/gascaribe/ventas/procedimientos/adm_person.ldcprgennoaprov.sql

prompt " Aplicando src/gascaribe/ventas/sinonimos/adm_person.ldcprgennoaprov.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldcprgennoaprov.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proinsertaestaprogv2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proinsertaestaprogv2.sql

prompt " Aplicando src/gascaribe/general/procedimientos/adm_person.ldc_proinsertaestaprogv2.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_proinsertaestaprogv2.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_proinsertaestaprogv2.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proinsertaestaprogv2.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldc_proactualizaestaprogv2.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_proactualizaestaprogv2.sql

prompt " Aplicando src/gascaribe/general/procedimientos/adm_person.ldc_proactualizaestaprogv2.sql"
@src/gascaribe/general/procedimientos/adm_person.ldc_proactualizaestaprogv2.sql

prompt " Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_proactualizaestaprogv2.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_proactualizaestaprogv2.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_osf_castconc.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_osf_castconc.sql

prompt " Aplicando src/gascaribe/objetos-obsoletos/tablas/ldc_liqcontadm.sql"
@src/gascaribe/objetos-obsoletos/tablas/ldc_liqcontadm.sql

prompt " Aplicando src/gascaribe/papelera-reciclaje/tablas/ldc_exogena.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_exogena.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2639_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2639_actualizar_obj_migrados.sql

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