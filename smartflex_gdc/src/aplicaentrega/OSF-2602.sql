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

prompt  "Aplicando src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121536.sql"
@src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121536.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121535.sql"
@src/gascaribe/papelera-reciclaje/fwcob/GE_OBJECT_121535.sql

prompt  "Aplicando src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_121168.sql"
@src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_121168.sql

prompt  "Aplicando src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_120257.sql"
@src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_120257.sql

prompt  "Aplicando src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_120256.sql"
@src/gascaribe/objetos-obsoletos/fwcob/GE_OBJECT_120256.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgestflujventas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgestflujventas.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_ctcontratos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_ctcontratos.sql

prompt  "Aplicando src/gascaribe/gestion-ordenes/package/ldc_pkgotssincobsingar.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkgotssincobsingar.sql

prompt  "Aplicando src/gascaribe/facturacion/consumos/paquetes/ldc_pkactcoprsuca.sql"
@src/gascaribe/facturacion/consumos/paquetes/ldc_pkactcoprsuca.sql

prompt  "Aplicando src/gascaribe/atencion-usuarios/paquetes/ldc_pkcrmsoligestion.sql"
@src/gascaribe/atencion-usuarios/paquetes/ldc_pkcrmsoligestion.sql

prompt  "Aplicando src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pkgestiontaritran.sql

prompt  "Aplicando src/gascaribe/recaudos/paquetes/ldc_borecaudos.sql"
@src/gascaribe/recaudos/paquetes/ldc_borecaudos.sql

prompt  "Aplicandosrc/gascaribe/facturacion/paquetes/ldc_pkggecoprfa.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkggecoprfa.sql

prompt  "Aplicando src/gascaribe/servicios-nuevos/paquete/ldc_pkgestnuesqservnue.sql"
@src/gascaribe/servicios-nuevos/paquete/ldc_pkgestnuesqservnue.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/triggers/trg_after_pagosvum.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_after_pagosvum.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_pkventaunmillon.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkventaunmillon.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcmex.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcmex.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcscl.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcscl.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldcscc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldcscc.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldccbl.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldccbl.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/procedimientos/ldccus.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldccus.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boreportecartbrilla.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boreportecartbrilla.sql

prompt  "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_boconcil_usu_fact.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_boconcil_usu_fact.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2602_actualizar_obs_ejecutable.sql"
@src/gascaribe/datafix/OSF-2602_actualizar_obs_ejecutable.sql

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