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

prompt "Aplicando src/gascaribe/general/sinonimos/rc_boannulpayments.sql"
@src/gascaribe/general/sinonimos/rc_boannulpayments.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pr_component_retire.sql"
@src/gascaribe/general/sinonimos/pr_component_retire.sql

prompt "Aplicando src/gascaribe/general/sinonimos/rc_boanullpayments.sql"
@src/gascaribe/general/sinonimos/rc_boanullpayments.sql

prompt "Aplicando src/gascaribe/general/sinonimos/rc_detatrba.sql"
@src/gascaribe/general/sinonimos/rc_detatrba.sql

prompt "Aplicando src/gascaribe/general/sinonimos/pktraslatepositivebalance.sql"
@src/gascaribe/general/sinonimos/pktraslatepositivebalance.sql

prompt "Aplicando src/gascaribe/general/sinonimos/seq_pr_component_retire.sql"
@src/gascaribe/general/sinonimos/seq_pr_component_retire.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_infotspr.sql"
@src/gascaribe/general/sinonimos/ldc_infotspr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_contanve.sql"
@src/gascaribe/general/sinonimos/ldc_contanve.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_solianeco.sql"
@src/gascaribe/general/sinonimos/ldc_solianeco.sql

prompt "Aplicando src/gascaribe/general/sinonimos/concilia.sql"
@src/gascaribe/general/sinonimos/concilia.sql

prompt "Aplicando src/gascaribe/general/sinonimos/ldc_conttsfa.sql"
@src/gascaribe/general/sinonimos/ldc_conttsfa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/cc_sales_financ_cond.sql"
@src/gascaribe/general/sinonimos/cc_sales_financ_cond.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcordenes.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.pkg_bcordenes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_producto.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_bccomponentes.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_bccomponentes.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/adm_person.pkg_componente_producto.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_pr_component_retire.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_pr_component_retire.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_pr_component_retire.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_pr_component_retire.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql"
@src/gascaribe/servicios-nuevos/paquetes/personalizaciones.pkg_gestion_producto.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_solianeco.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_solianeco.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_solianeco.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_solianeco.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_bogestion_pagos.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_bogestion_pagos.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_infotspr.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_infotspr.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_infotspr.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_infotspr.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_ldc_conttsfa.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_ldc_conttsfa.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_ldc_conttsfa.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_ldc_conttsfa.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_financiacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfinanciacion.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bofinanciacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bofinanciacion.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bofinanciacion.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkgmanejosolicitudes.sql"
@src/gascaribe/general/paquetes/adm_person.pkgmanejosolicitudes.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_cupon.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_cupon.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_pagos.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_pagos.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.pkg_pagos.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.pkg_pagos.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_concilia.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_concilia.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.pkg_concilia.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.pkg_concilia.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_gestionpagos.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_gestionpagos.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.pkg_gestionpagos.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.pkg_gestionpagos.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3893_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3893_homologacion_servicios.sql

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