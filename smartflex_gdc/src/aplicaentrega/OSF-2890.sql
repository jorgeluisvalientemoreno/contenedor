column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2890"
prompt "-----------------"

prompt "-----procedimiento LDC_PKGGECOPRFAV2-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkggecoprfav2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkggecoprfav2.sql


prompt "-----procedimiento LDC_PKGGECOPRFAV3-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkggecoprfav3.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkggecoprfav3.sql


prompt "-----procedimiento LDC_PKGGECOPRFAV4-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkggecoprfav4.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkggecoprfav4.sql


prompt "-----procedimiento LDC_PKGGENORDADMOVILES-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkggenordadmoviles.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkggenordadmoviles.sql


prompt "-----procedimiento LDC_PKGLIQUIDANOREGULADOS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgliquidanoregulados.sql"
@src/gascaribe/facturacion/paquetes/ldc_pkgliquidanoregulados.sql


prompt "-----procedimiento LDC_PKGMIGRAATRIBUINSTANCIA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgmigraatribuinstancia.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgmigraatribuinstancia.sql


prompt "-----procedimiento LDC_PKGOSFFACTURE2-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgOSFFacture2.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgOSFFacture2.sql


prompt "-----procedimiento LDC_PKGRENORMOV-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgrenormov.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgrenormov.sql


prompt "-----procedimiento LDC_PKGREVERDIFERIDO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkgreverdiferido.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgreverdiferido.sql


prompt "-----procedimiento LDC_PKITEMSSERIADOS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkitemsseriados.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkitemsseriados.sql


prompt "-----procedimiento LDC_PKLDCCAIPA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkldccaipa.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkldccaipa.sql


prompt "-----procedimiento LDC_PKLDCCO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkldcco.sql"
@src/gascaribe/gestion-ordenes/package/ldc_pkldcco.sql


prompt "-----procedimiento LDC_PKLDCRPACERP-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkldcrpacerp.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkldcrpacerp.sql


prompt "-----procedimiento LDC_PKLDRBDTV-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkldrbdtv.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkldrbdtv.sql


prompt "-----procedimiento LDC_PKLDRERLE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkldrerle.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkldrerle.sql


prompt "-----procedimiento LDC_PKMETROSCUBICOS-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkmetroscubicos.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkmetroscubicos.sql


prompt "-----procedimiento LDC_PKORMUSUARIOSSINFACTURA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkormusuariossinfactura.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkormusuariossinfactura.sql


prompt "-----procedimiento LDC_PKTARIFATRANSITORIA-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pktarifatransitoria.sql"
@src/gascaribe/facturacion/tarifa_transitoria/paquete/ldc_pktarifatransitoria.sql


prompt "-----procedimiento LDC_PKTRASFNB_3-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pktrasfnb_3.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pktrasfnb_3.sql


prompt "-----procedimiento LDC_PKTRDIFSUBACTE-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pktrdifsubacte.sql"
@src/gascaribe/facturacion/paquetes/ldc_pktrdifsubacte.sql


prompt "-----procedimiento LDC_PKUTILORM-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_pkutilorm.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkutilorm.sql


prompt "-----procedimiento LDC_REMARCAPRODUCTO-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_remarcaproducto.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_remarcaproducto.sql


prompt "-----procedimiento LDC_REPLEYFACTURACION-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_repleyfacturacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_repleyfacturacion.sql


prompt "-----procedimiento LDC_REPLEYSEGAUD-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_repleysegaud.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_repleysegaud.sql


prompt "-----procedimiento LDC_REPORTE_LEY-----" 
prompt "--->Aplicando borrado procedimiento de esquema OPEN ldc_reporte_ley.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_reporte_ley.sql


prompt "-----Script OSF-2890_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2890_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2890-----"
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
