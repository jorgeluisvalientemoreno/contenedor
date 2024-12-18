column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

-- This is a new line in master / 2

prompt "------------------------------------------------------"
prompt "Aplicando Entrega"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/revision-periodica/certificados/configuracion-objeto-accion/proceso_negocio.revision_periodica.sql"
@src/gascaribe/revision-periodica/certificados/configuracion-objeto-accion/proceso_negocio.revision_periodica.sql

prompt "------------------------------------------------------"
prompt "Parametros"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.causal_controlado_escape_centro_medicion.sql"
@src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.causal_controlado_escape_centro_medicion.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.dato_adicional_observacion_defecto_cdm.sql"
@src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.dato_adicional_observacion_defecto_cdm.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.dato_adicional_defecto_en_cdm_rp.sql"
@src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.dato_adicional_defecto_en_cdm_rp.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.grupo_dato_adicional_defecto_en_cdm_rp.sql"
@src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.grupo_dato_adicional_defecto_en_cdm_rp.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.medio_recepcion_defecto_cdm.sql"
@src/gascaribe/revision-periodica/certificados/parametros/personalizaciones.medio_recepcion_defecto_cdm.sql

prompt "------------------------------------------------------"
prompt "Sinonimos"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/cc_orga_area_seller.sql"
@src/gascaribe/objetos-producto/sinonimos/cc_orga_area_seller.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/ge_reception_type.sql"
@src/gascaribe/objetos-producto/sinonimos/ge_reception_type.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_ope_uni_rece_type.sql"
@src/gascaribe/objetos-producto/sinonimos/or_ope_uni_rece_type.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order_comment.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order_comment.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_requ_data_value.sql"
@src/gascaribe/objetos-producto/sinonimos/or_requ_data_value.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_operating_unit.sql"
@src/gascaribe/objetos-producto/sinonimos/or_operating_unit.sql

prompt "Aplicando src/gascaribe/objetos-producto/sinonimos/or_order.sql"
@src/gascaribe/objetos-producto/sinonimos/or_order.sql

prompt "------------------------------------------------------"
prompt "Procedimiento api_registrodanoproductoxml"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/general/procedimientos/adm_person.api_registrodanoproductoxml.sql"
@src/gascaribe/general/procedimientos/adm_person.api_registrodanoproductoxml.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm.api_registrodanoproductoxml.sql"
@src/gascaribe/general/sinonimos/adm.api_registrodanoproductoxml.sql

prompt "------------------------------------------------------"
prompt "Paquete pkg_dato_adicional"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/gestion-ordenes/package/adm_person.pkg_dato_adicional.sql"
@src/gascaribe/gestion-ordenes/package/adm_person.pkg_dato_adicional.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm.pkg_dato_adicional.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm.pkg_dato_adicional.sql

prompt "------------------------------------------------------"
prompt "Procedimiento oal_certificado_dano_producto"
prompt "------------------------------------------------------"

prompt "Aplicando src/gascaribe/revision-periodica/certificados/procedimientos/personalizaciones.oal_certificado_dano_producto.sql"
@src/gascaribe/revision-periodica/certificados/procedimientos/personalizaciones.oal_certificado_dano_producto.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/personalizaciones.oal_certificado_dano_producto.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/personalizaciones.oal_certificado_dano_producto.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/configuracion-objeto-accion/oal_certificado_dano_producto.sql"
@src/gascaribe/revision-periodica/certificados/configuracion-objeto-accion/oal_certificado_dano_producto.sql

prompt "----------------------------------------------------"
prompt "Fin Aplica Entrega Cambio en Master"
prompt "------------------------------------------------------"

commit;

select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_fin from dual;
prompt Fin Proceso!!
set timing off
set serveroutput off
set define on
quit
/