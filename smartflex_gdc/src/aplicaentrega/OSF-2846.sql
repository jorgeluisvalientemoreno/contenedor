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


prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ic_bslisimprovrev.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ic_bslisimprovrev.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_actucierre.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_actucierre.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/ldc_pkfaac.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkfaac.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_dssnapshotcreg_b.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_dssnapshotcreg_b.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b2.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b3.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b3.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_bventa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_bventa.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b_esp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_b_esp.sql

prompt "Aplicando src/gascaribe/servicios-asociados/funciones/adm_person.fnu_lecturasugerida.sql"
@src/gascaribe/servicios-asociados/funciones/adm_person.fnu_lecturasugerida.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcargavolumenfact.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcargavolumenfact.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_c.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_bccreg_c.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkfaac3.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkfaac3.sql

prompt "Aplicando src/gascaribe/facturacion/procedimientos/ldc_prgeaudpre.sql"
@src/gascaribe/facturacion/procedimientos/ldc_prgeaudpre.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldrpcre.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldrpcre.sql

prompt "Aplicando src/gascaribe/migracion-gasplus-osf/procedimientos/practmateriales.sql"
@src/gascaribe/migracion-gasplus-osf/procedimientos/practmateriales.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/venps.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/venps.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldacre.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldacre.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcfaac.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcfaac.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_gc_debt_negot_charge_bi.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_gc_debt_negot_charge_bi.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2846_actualizar_obj_migrados.sql"
@src/gascaribe/datafix/OSF-2846_actualizar_obj_migrados.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2846_actualizar_obs_ejecutable.sql"
@src/gascaribe/datafix/OSF-2846_actualizar_obs_ejecutable.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2846_cancela_programaciones.sql"
@src/gascaribe/datafix/OSF-2846_cancela_programaciones.sql

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
