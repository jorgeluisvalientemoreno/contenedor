column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2581"
prompt "-----------------"

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.concbali.sql" 
@src/gascaribe/general/sinonimos/adm_person.concbali.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldcconford.sql" 
@src/gascaribe/general/sinonimos/adm_person.ldcconford.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_xsl_template.sql" 
@src/gascaribe/general/sinonimos/adm_person.ge_xsl_template.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ge_notification.sql" 
@src/gascaribe/general/sinonimos/adm_person.ge_notification.sql

prompt "Aplicando src/gascaribe/facturacion/reportes/procedimientos/adm_person.ldc_prgapycar.sql" 
@src/gascaribe/facturacion/reportes/procedimientos/adm_person.ldc_prgapycar.sql

prompt "Aplicando src/gascaribe/facturacion/procedimientos/ldc_prgeaudpre.sql" 
@src/gascaribe/facturacion/procedimientos/ldc_prgeaudpre.sql

prompt "Aplicando src/gascaribe/contratacion/procedimientos/ldc_prnotificafincontrato.sql" 
@src/gascaribe/contratacion/procedimientos/ldc_prnotificafincontrato.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pronotiorden.sql" 
@src/gascaribe/gestion-ordenes/procedure/adm_person.ldc_pronotiorden.sql


prompt "----- procedimiento LDC_PRRECAMORA-----" 

prompt "Aplicando borrado de procedimiento en esquema anterior O P E N ldc_prrecamora.sql" 
@src/gascaribe/facturacion/procedimientos/ldc_prrecamora.sql

prompt "Creacion sinonimos dependientes"

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_cargobasrm.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_cargobasrm.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.conftain.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.conftain.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_datacargos.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_datacargos.sql

prompt "Aplicando creacion de procedimiento adm_person.ldc_prrecamora.sql" 
@src/gascaribe/facturacion/procedimientos/adm_person.ldc_prrecamora.sql

prompt "Aplicando creacion de sinonimo a nueva procedimiento adm_person.ldc_prrecamora.sql" 
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_prrecamora.sql

prompt "-----Script OSF-2581_actualizar_obj_migrados-----" 
@src/gascaribe/datafix/OSF-2581_actualizar_obj_migrados.sql

prompt "Aplicando src/gascaribe/datafix/OSF-2581_borra_Plugin_LDC_PRVALIDALECTURA.sql" 
@src/gascaribe/datafix/OSF-2581_borra_Plugin_LDC_PRVALIDALECTURA.sql

prompt "Aplicando borrado de procedimiento en esquema anterior O P E N ldc_ruteroscrm.sql" 
@src/gascaribe/ventas/paquetes/ldc_ruteroscrm.sql

prompt "Aplicando src/gascaribe/facturacion/notificaciones/LDC_TRGNOTITERMPROC.trg"
@src/gascaribe/facturacion/notificaciones/LDC_TRGNOTITERMPROC.trg

prompt "Aplicando src/gascaribe/facturacion/triggers/ldc_trgvalterfidf.sql"
@src/gascaribe/facturacion/triggers/ldc_trgvalterfidf.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/ldccreatetramitereconexionxml.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/ldccreatetramitereconexionxml.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_maestromaterial.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_maestromaterial.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazlistprecsap.sql"
@src/gascaribe/general/integraciones/paquetes/ldci_pkinterfazlistprecsap.sql

prompt "Aplicando src/gascaribe/contratacion/procedimientos/ldcreasco.sql"
@src/gascaribe/contratacion/procedimientos/ldcreasco.sql

prompt "Aplicando src/gascaribe/recaudos/triggers/ldctrg_bss_sucubanc.sql"
@src/gascaribe/recaudos/triggers/ldctrg_bss_sucubanc.sql

prompt "Aplicando src/gascaribe/cartera/procedimientos/pbacucartot.sql"
@src/gascaribe/cartera/procedimientos/pbacucartot.sql

prompt "Aplicando borrado de procedimiento en esquema anterior O P E N pbacucartotk.sql" 
@src/gascaribe/papelera-reciclaje/procedimientos/pbacucartotk.sql

prompt "Aplicando src/gascaribe/servicios-asociados/areas-comunes/paquetes/pkg_ldcgridldcaplac.sql"
@src/gascaribe/servicios-asociados/areas-comunes/paquetes/pkg_ldcgridldcaplac.sql

prompt "Aplicando src/gascaribe/direccion-digital/procedimientos/pravanzasecuenciainstanci.sql"
@src/gascaribe/direccion-digital/procedimientos/pravanzasecuenciainstanci.sql

prompt "Aplicando src/gascaribe/cartera/procedimientos/procnotiftasaintvenc.sql"
@src/gascaribe/cartera/procedimientos/procnotiftasaintvenc.sql

prompt "Aplicando src/gascaribe/contratacion/trigger/trgactulistnove.sql"
@src/gascaribe/contratacion/trigger/trgactulistnove.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"


select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on


prompt "-----RECOMPILAR OBJETOS-----"
prompt "Aplicando recompilar objetos"
@src/test/recompilar-objetos.sql
show errors;