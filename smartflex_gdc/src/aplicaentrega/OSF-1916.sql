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

prompt "Aplicando src/gascaribe/general/integraciones/tablas/personalizaciones.equi_tipo_identfael.sql"
@src/gascaribe/general/integraciones/tablas/personalizaciones.equi_tipo_identfael.sql

prompt "Aplicando src/gascaribe/general/integraciones/tablas/personalizaciones.factura_electronica.sql"
@src/gascaribe/general/integraciones/tablas/personalizaciones.factura_electronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/tablas/personalizaciones.periodo_factelect.sql"
@src/gascaribe/general/integraciones/tablas/personalizaciones.periodo_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.equi_tipo_identfael.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.equi_tipo_identfael.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.factura_electronica.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.factura_electronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.periodo_factelect.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.periodo_factelect.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_equi_localidad.sql"
@src/gascaribe/general/sinonimos/ldc_equi_localidad.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/consecut.sql"
@src/gascaribe/objetos-producto/sinonimos/consecut.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/pktblrepoinco.sql"
@src/gascaribe/objetos-producto/sinonimos/pktblrepoinco.sql

prompt "Aplicandosrc/gascaribe/objetos-producto/sinonimos/pktblreportes.sql"
@src/gascaribe/objetos-producto/sinonimos/pktblreportes.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/repoinco.sql"
@src/gascaribe/objetos-producto/sinonimos/repoinco.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/seq.sql"
@src/gascaribe/objetos-producto/sinonimos/seq.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/ldc_pecofact.sql"
@src/gascaribe/facturacion/sinonimos/ldc_pecofact.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_reportes_inco.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_reportes_inco.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_reportes_inco.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_reportes_inco.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_factura.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_factura.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_factura.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_factura.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_bcfactelectronica.sql"
@src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_bcfactelectronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_bofactelectronica.sql"
@src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_bofactelectronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/pkg_uirfel.sql"
@src/gascaribe/general/integraciones/paquetes/pkg_uirfel.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_bcfactelectronica.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_bcfactelectronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_bofactelectronica.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_bofactelectronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_uirfel.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_uirfel.sql

prompt "Aplicando src/gascaribe/general/sql/configuracion_.proceso_negocio.sql"
@src/gascaribe/general/sql/configuracion_proceso_negocio.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.ciclo_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.ciclo_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.cons_numeauto_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.cons_numeauto_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.estado_actu_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.estado_actu_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.estado_reenvio_facele.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.estado_reenvio_facele.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.password_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.password_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.plantilla_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.plantilla_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.token_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.token_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.usuario_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.usuario_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.cod_empresa_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.cod_empresa_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/personalizaciones.prefijo_factelect.sql"
@src/gascaribe/general/integraciones/sql/personalizaciones.prefijo_factelect.sql

prompt "Aplicando src/gascaribe/general/integraciones/sql/configuracion_equitipoiden.sql"
@src/gascaribe/general/integraciones/sql/configuracion_equitipoiden.sql

prompt "Aplicando src/gascaribe/general/integraciones/fwcpb/rfel.sql"
@src/gascaribe/general/integraciones/fwcpb/rfel.sql

prompt "Aplicando src/gascaribe/general/integraciones/job/job_factuelect_enersolar.sql"
@src/gascaribe/general/integraciones/job/job_factuelect_enersolar.sql

prompt "Aplicando src/gascaribe/general/sinonimos/personalizaciones.proceso_negocio.sql"
@src/gascaribe/general/sinonimos/personalizaciones.proceso_negocio.sql

prompt "Aplicando src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_factura_electronica.sql"
@src/gascaribe/general/integraciones/paquetes/personalizaciones.pkg_factura_electronica.sql

prompt "Aplicando src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_factura_electronica.sql"
@src/gascaribe/general/integraciones/sinonimos/personalizaciones.pkg_factura_electronica.sql


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