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


prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/pagare.sql"
@src/gascaribe/atencion-usuarios/sinonimos/pagare.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/gc_debt_negot_prod.sql"
@src/gascaribe/cartera/sinonimo/gc_debt_negot_prod.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/cuencuag.sql"
@src/gascaribe/cartera/sinonimo/cuencuag.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/rc_bcpaymentqueries.sql"
@src/gascaribe/recaudos/sinonimos/rc_bcpaymentqueries.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/pkbccuencuag.sql"
@src/gascaribe/recaudos/sinonimos/pkbccuencuag.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_bogestion_pagos.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_bogestion_pagos.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.pkg_bogestion_pagos.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.pkg_bogestion_pagos.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/sq_cupon_cuponume.sql"
@src/gascaribe/recaudos/sinonimos/sq_cupon_cuponume.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.seq_ge_proc_sche_detail.sql"
@src/gascaribe/general/sinonimos/adm_person.seq_ge_proc_sche_detail.sql

prompt "Aplicando src/gascaribe/recaudos/paquetes/adm_person.pkg_cupon.sql"
@src/gascaribe/recaudos/paquetes/adm_person.pkg_cupon.sql

prompt "Aplicando src/gascaribe/recaudos/sinonimos/adm_person.pkg_cupon.sql"
@src/gascaribe/recaudos/sinonimos/adm_person.pkg_cupon.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_gc_debt_negotiation.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_gc_debt_negotiation.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_gc_debt_negotiation.sql

prompt "Aplicando src/gascaribe/cartera/paquetes/adm_person.pkg_cc_financing_request.sql"
@src/gascaribe/cartera/paquetes/adm_person.pkg_cc_financing_request.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.pkg_cc_financing_request.sql"
@src/gascaribe/cartera/sinonimo/adm_person.pkg_cc_financing_request.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_factura.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_factura.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql"
@src/gascaribe/facturacion/paquetes/personalizaciones.pkg_bcfacturacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bcfacturacion.sql"
@src/gascaribe/facturacion/sinonimos/personalizaciones.pkg_bcfacturacion.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_boflujos.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_boflujos.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.pkg_boflujos.sql"
@src/gascaribe/general/sinonimos/adm_person.pkg_boflujos.sql

prompt "Aplicando src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/paquetes/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestion_facturacion.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkg_bogestion_facturacion.sql

prompt "Aplicando src/gascaribe/general/paquetes/personalizaciones.constants_per.sql"
@src/gascaribe/general/paquetes/personalizaciones.constants_per.sql

prompt "Aplicando src/gascaribe/general/paquetes/adm_person.pkg_gestionsecuencias.sql"
@src/gascaribe/general/paquetes/adm_person.pkg_gestionsecuencias.sql

prompt "Aplicando src/gascaribe/datafix/OSF-3740_insertar_homologacion_servicios.sql"
@src/gascaribe/datafix/OSF-3740_insertar_homologacion_servicios.sql



prompt "Aplicando src/test/recompilar-objetos.sql"
@src/test/recompilar-objetos.sql


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

