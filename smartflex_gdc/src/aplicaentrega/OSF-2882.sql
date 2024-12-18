column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2882"
prompt "-----------------"

prompt "-----procedimiento LDC_BOENCUESTA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_boencuesta.sql"
@src/gascaribe/objetos-obsoletos/ldc_boencuesta.sql


prompt "-----procedimiento LDC_ENCUESTA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_encuesta.sql"
@src/gascaribe/papelera-reciclaje/tablas/ldc_encuesta.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_encuesta.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_encuesta.sql


prompt "-----procedimiento ADM_PERSON.LDC_FNCRETORNAOTENCUECONCCERO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN adm_person.ldc_fncretornaotencueconccero.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fncretornaotencueconccero.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_fncretornaotencueconccero.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaotencueconccero.sql


prompt "-----procedimiento ADM_PERSON.LDC_FSBRETORNARESPPRENENCUES-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN adm_person.ldc_fsbretornarespprenencues.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbretornarespprenencues.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_fsbretornarespprenencues.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbretornarespprenencues.sql


prompt "-----procedimiento LDC_PK_PARAMETROS_VISTAS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pk_parametros_vistas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pk_parametros_vistas.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo procedimiento adm_person.ldc_pk_parametros_vistas.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pk_parametros_vistas.sql


prompt "-----procedimiento LDC_PROCREPAVC-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_procrepavc.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrepavc.sql


prompt "-----procedimiento LDC_PROCREPAVC_AUTOMATICO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_procrepavc_automatico.sql"
@src/gascaribe/papelera-reciclaje/procedimientos/ldc_procrepavc_automatico.sql


prompt "-----procedimiento LDCI_PKGESTINFOADOT-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldci_pkgestinfoadot.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkgestinfoadot.sql


prompt "-----procedimiento LDCI_PKINFOADICIONALENCU-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldci_pkinfoadicionalencu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadicionalencu.sql


prompt "-----procedimiento LDCI_PKINFOADIOTLECT-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldci_pkinfoadiotlect.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldci_pkinfoadiotlect.sql


prompt "-----procedimiento TRG_BI_LDC_ENCUESTA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN trg_bi_ldc_encuesta.sql"
@src/gascaribe/papelera-reciclaje/triggers/trg_bi_ldc_encuesta.sql


prompt "-----procedimiento TRGAFTERENCUESTA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN trgafterencuesta.sql"
@src/gascaribe/papelera-reciclaje/triggers/trgafterencuesta.sql


prompt "-----Script OSF-2882_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2882_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2882-----"
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
