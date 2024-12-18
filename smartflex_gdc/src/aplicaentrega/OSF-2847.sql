column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2847"
prompt "-----------------"

prompt "-----procedimiento CC_BOFINSAMPLEDETAIL-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN cc_bofinsampledetail.sql"
@src/gascaribe/papelera-reciclaje/paquetes/cc_bofinsampledetail.sql


prompt "-----procedimiento DL_COMMON_VARIABLES-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN dl_common_variables.sql"
@src/gascaribe/papelera-reciclaje/paquetes/dl_common_variables.sql


prompt "-----procedimiento FREC_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN frec_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/frec_.sql


prompt "-----procedimiento GDO_REPORCOMPVINCULACION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN gdo_reporcompvinculacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdo_reporcompvinculacion.sql


prompt "-----procedimiento GDO_REPORTECONSUMOS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN gdo_reporteconsumos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdo_reporteconsumos.sql


prompt "-----procedimiento GDO_REPORTEOYM-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN gdo_reporteoym.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdo_reporteoym.sql


prompt "-----procedimiento GDO_REPORTESFACTURACION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN gdo_reportesfacturacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/gdo_reportesfacturacion.sql


prompt "-----procedimiento GE_BODAOPACKAGEGENERATOR-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ge_bodaopackagegenerator.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ge_bodaopackagegenerator.sql


prompt "-----procedimiento GE_OBJECT_19109_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ge_object_19109_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ge_object_19109_.sql


prompt "-----procedimiento GE_OBJECT_19110_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ge_object_19110_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ge_object_19110_.sql


prompt "-----procedimiento GE_OBJECT_49282_-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ge_object_49282_.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ge_object_49282_.sql


prompt "-----procedimiento LD_BCAPROVE_RANDOM-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bcaprove_random.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcaprove_random.sql


prompt "-----procedimiento LD_BCCONFIGURATIONNOTIFICATION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bcconfigurationnotification.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcconfigurationnotification.sql


prompt "-----procedimiento LD_BCEXECUTEDBUDGE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bcexecutedbudge.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcexecutedbudge.sql


prompt "-----procedimiento LD_BCPROCESS_BLOCKED-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bcprocess_blocked.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcprocess_blocked.sql


prompt "-----procedimiento LD_BOCOUPONPRINTINGCM-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bocouponprintingcm.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bocouponprintingcm.sql


prompt "-----procedimiento LD_BCFACTURACION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bcfacturacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bcfacturacion.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_ldc_aprfmle.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_aprfmle.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.seq_ldc_aprfmaco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.seq_ldc_aprfmaco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_ussfmle.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_ussfmle.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_ussfmaco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_ussfmaco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_usafmle.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_usafmle.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_usafmaco.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_usafmaco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_aprfmle2.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_aprfmle2.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_aprfmaco2.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_aprfmaco2.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.aucalect.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.aucalect.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bodiferidospasoprepago.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ld_bcfacturacion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bodiferidospasoprepago.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_bcfacturacion.sql


prompt "-----procedimiento LD_BOCOUPONPRINTING-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ld_bocouponprinting.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ld_bocouponprinting.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pktblcupon.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblcupon.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkboed_documentmem.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkboed_documentmem.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.pkbced_formato.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbced_formato.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_bodiferidospasoprepago.sql"
@src/gascaribe/facturacion/paquetes/adm_person.ld_bocouponprinting.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_bodiferidospasoprepago.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ld_bocouponprinting.sql


prompt "-----Script OSF-2847_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2847_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2847-----"
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
