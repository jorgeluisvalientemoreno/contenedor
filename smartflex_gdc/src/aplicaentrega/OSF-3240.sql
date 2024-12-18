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

prompt "Aplicando src/gascaribe/general/integraciones/tablas/personalizaciones.conc_unid_medida_dian.sql"
@src/gascaribe/general/integraciones/tablas/personalizaciones.conc_unid_medida_dian.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/correo_receptor_por_defecto.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/correo_receptor_por_defecto.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/sql/parametros/activar_envio_mail_fael.sql"
@src/gascaribe/facturacion/facturacion_electronica/sql/parametros/activar_envio_mail_fael.sql

prompt "Aplicando src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql"
@src/gascaribe/facturacion/facturacion_electronica/paquetes/personalizaciones.pkg_bcfactuelectronicagen.sql

prompt "Aplicando src/gascaribe/datafix/OSF_3240_actualiza_concepto_unidad.sql"
@src/gascaribe/datafix/OSF_3240_actualiza_concepto_unidad.sql

prompt "Aplicando src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck"
@src/gascaribe/facturacion/spool/paquete/ldc_pkgprocefactspoolfac.pck


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
