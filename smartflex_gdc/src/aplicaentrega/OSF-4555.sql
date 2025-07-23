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

----------------> OSF-4608 

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_boubigeografica.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_boubigeografica.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_empresa.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_empresa.sql

prompt "Aplicando src/gascaribe/ventas/paquetes/adm_person.pkg_ldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/paquetes/adm_person.pkg_ldc_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/ventas/sinonimos/adm_person.pkg_ldc_cotizacion_comercial.sql"
@src/gascaribe/ventas/sinonimos/adm_person.pkg_ldc_cotizacion_comercial.sql

prompt "Aplicando src/gascaribe/multiempresa/paquetes/multiempresa.pkg_boconsultaempresa.sql"
@src/gascaribe/multiempresa/paquetes/multiempresa.pkg_boconsultaempresa.sql

----------------< OSF-4608

prompt "Aplicando src/gascaribe/datafix/OSF-4555_act_sa_executable_licot.sql"
@src/gascaribe/datafix/OSF-4555_act_sa_executable_licot.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/paquetes/ldc_paymentformatticket.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_paymentformatticket.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4555_act_plant_ldc_ceritifcadopagocupon.sql"
@src/gascaribe/datafix/OSF-4555_act_plant_ldc_ceritifcadopagocupon.sql

prompt "Aplicando src/gascaribe/datafix/OSF-4555_act_master_personalizaciones.sql"
@src/gascaribe/datafix/OSF-4555_act_master_personalizaciones.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/paquetes/adm_person.ic_bocompletserviceint_gdca.sql"
@src/gascaribe/general/interfaz-contable/paquetes/adm_person.ic_bocompletserviceint_gdca.sql

prompt "Aplicando src/gascaribe/fnb/paquetes/ld_bononbankfinancing.sql"
@src/gascaribe/fnb/paquetes/ld_bononbankfinancing.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/paquetes/ldc_bcsalescommission.sql"
@src/gascaribe/ventas/comisiones/paquetes/ldc_bcsalescommission.sql

prompt "Aplicando src/gascaribe/ventas/comisiones/paquetes/adm_person.ldc_bcsalescommission_nel.sql"
@src/gascaribe/ventas/comisiones/paquetes/adm_person.ldc_bcsalescommission_nel.sql

prompt "Aplicando src/gascaribe/general/materiales/triggers/adm_person.ldctrgbudi_or_uibm.sql"
@src/gascaribe/general/materiales/triggers/adm_person.ldctrgbudi_or_uibm.sql

prompt "Aplicando src/gascaribe/general/trigger/adm_person.ldc_trg_marca_producto.sql"
@src/gascaribe/general/trigger/adm_person.ldc_trg_marca_producto.sql

prompt "Aplicando src/gascaribe/metrologia/paquetes/ldc_bometrologia.sql"
@src/gascaribe/metrologia/paquetes/ldc_bometrologia.sql

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