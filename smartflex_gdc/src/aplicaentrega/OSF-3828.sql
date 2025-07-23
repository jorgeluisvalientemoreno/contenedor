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

-- Ini 14/01/2025
prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/ldc_logerrlegservnuev.sql"
@src/gascaribe/servicios-nuevos/sinonimos/ldc_logerrlegservnuev.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cancel_order.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_cancel_order.sql
-- Fin 14/01/2025

-- Ini 08/01/2025
prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_certificado_cambest.sql" 
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_certificado_cambest.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_certificado_cambest.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_certificado_cambest.sql 

prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_unidad_certif.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_unidad_certif.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_unidad_certif.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_unidad_certif.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_bloq_lega_solicitud.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_bloq_lega_solicitud.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_bloq_lega_solicitud.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_bloq_lega_solicitud.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_ordeasigproc.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_ldc_ordeasigproc.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_ordeasigproc.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_ldc_ordeasigproc.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_plazos_cert.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_plazos_cert.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_plazos_cert.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_pr_prod_suspension.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_pr_prod_suspension.sql

-- Fin 08/01/2025

-- Ini 09/01/2025

prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_marcaprodrepa.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_marcaprodrepa.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_marcaprodrepa.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_marcaprodrepa.sql


prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_temp_data_values.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_temp_data_values.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_temp_data_values.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_temp_data_values.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_ldc_logerrlegservnuev.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_ldc_logerrlegservnuev.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkg_ldc_logerrlegservnuev.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.pkg_ldc_logerrlegservnuev.sql
-- Fin 09/01/2025

-- Ini 10/01/2025
prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_certificados_oia.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_certificados_oia.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_certificados_oia"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_certificados_oia.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/ldc_defectos_oia.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/ldc_defectos_oia.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_defectos_oia.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_ldc_defectos_oia.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_defectos_oia.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_ldc_defectos_oia.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_operating_unit.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_or_operating_unit.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_operating_unit.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.pkg_or_operating_unit.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquete/personalizaciones.pkg_xml_soli_serv_nuevos.sql"
@src/gascaribe/servicios-nuevos/paquete/personalizaciones.pkg_xml_soli_serv_nuevos.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bcserviciosnuevos.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_bcserviciosnuevos.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bcserviciosnuevos.sql"
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_bcserviciosnuevos.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_boserviciosnuevos.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_boserviciosnuevos.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_boserviciosnuevos.sql"-- AQUI
@src/gascaribe/servicios-nuevos/sinonimos/personalizaciones.pkg_boserviciosnuevos.sql
-- Fin 10/01/2025

-- Ini 20/01/2025
prompt "Aplicando src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_bogestioncertificados.sql"
@src/gascaribe/revision-periodica/certificados/paquetes/adm_person.pkg_bogestioncertificados.sql

prompt "Aplicando src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_bogestioncertificados.sql"
@src/gascaribe/revision-periodica/certificados/sinonimos/adm_person.pkg_bogestioncertificados.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3828_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3828_homologacion_servicios.sql
-- Fin 20/01/2025

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