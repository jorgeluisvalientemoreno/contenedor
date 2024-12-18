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

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pktblpericose.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pktblpericose.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbcpericose.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbcpericose.sql

prompt "Aplicando src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_encuesta.sql"
@src/gascaribe/perdidas-no-operacionales/sinonimos/adm_person.ldc_encuesta.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.daldc_pararepe.sql"
@src/gascaribe/general/sinonimos/adm_person.daldc_pararepe.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_osf_conf_bloqact.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_osf_conf_bloqact.sql

prompt "Aplicando src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_subs_phone.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ge_subs_phone.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.pkbcfactura.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.pkbcfactura.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/sinonimos/adm_person.ldc_capilocafaco.sql"
@src/gascaribe/operacion-y-mantenimiento/sinonimos/adm_person.ldc_capilocafaco.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_boformatofactura.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_boformatofactura.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_commercial_segm.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_commercial_segm.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_com_seg_fea_val.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_com_seg_fea_val.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.cc_com_seg_finan.sql"
@src/gascaribe/general/sinonimos/adm_person.cc_com_seg_finan.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/sinonimos/adm_person.ldc_plfiaplpro.sql"
@src/gascaribe/cartera/Financiacion/sinonimos/adm_person.ldc_plfiaplpro.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_pararepe.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pararepe.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.dapr_product.sql"
@src/gascaribe/general/sinonimos/adm_person.dapr_product.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgestionlegaorrp.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.ldc_pkgestionlegaorrp.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pr_bosuspendcriterions.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pr_bosuspendcriterions.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pktblconfcose.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pktblconfcose.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pksuspconnservice.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pksuspconnservice.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pkbovalidsuspcrit.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.pkbovalidsuspcrit.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_pk_parametros_vistas.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_pk_parametros_vistas.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_respuesta.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_respuesta.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_centrobenef.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_centrobenef.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_segmento.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_segmento.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_pkinterfazsap.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldci_pkinterfazsap.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_frcgetfacturabyprog.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_frcgetfacturabyprog.sql

prompt "Aplicando src/gascaribe/facturacion/funciones/adm_person.ldc_frcgetfacturabyprog.sql"
@src/gascaribe/facturacion/funciones/adm_person.ldc_frcgetfacturabyprog.sql

prompt "Aplicando src/gascaribe/facturacion/sinonimos/adm_person.ldc_frcgetfacturabyprog.sql"
@src/gascaribe/facturacion/sinonimos/adm_person.ldc_frcgetfacturabyprog.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbretornanombmes.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbretornanombmes.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fsbretornanombmes.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fsbretornanombmes.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fsbretornanombmes.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fsbretornanombmes.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbvalidacasosinstala.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbvalidacasosinstala.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbvalidacasosinstala.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbvalidacasosinstala.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbvalidacasosinstala.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbvalidacasosinstala.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_funcuotpaiddf.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_funcuotpaiddf.sql

prompt "Aplicando src/gascaribe/cartera/funciones/adm_person.ldc_funcuotpaiddf.sql"
@src/gascaribe/cartera/funciones/adm_person.ldc_funcuotpaiddf.sql

prompt "Aplicando src/gascaribe/cartera/sinonimo/adm_person.ldc_funcuotpaiddf.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_funcuotpaiddf.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_funfechintemp.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_funfechintemp.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/funciones/adm_person.ldc_funfechintemp.sql"
@src/gascaribe/operacion-y-mantenimiento/funciones/adm_person.ldc_funfechintemp.sql

prompt "Aplicando src/gascaribe/operacion-y-mantenimiento/sinonimos/adm_person.ldc_funfechintemp.sql"
@src/gascaribe/operacion-y-mantenimiento/sinonimos/adm_person.ldc_funfechintemp.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retornaplanfinmayprior.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornaplanfinmayprior.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/funciones/adm_person.ldc_retornaplanfinmayprior.sql"
@src/gascaribe/cartera/Financiacion/funciones/adm_person.ldc_retornaplanfinmayprior.sql

prompt "Aplicando src/gascaribe/cartera/Financiacion/sinonimos/adm_person.ldc_retornaplanfinmayprior.sql"
@src/gascaribe/cartera/Financiacion/sinonimos/adm_person.ldc_retornaplanfinmayprior.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fblgeneratramiterepara.sql"
@src/gascaribe/papelera-reciclaje/funciones/fblgeneratramiterepara.sql

prompt "Aplicando src/gascaribe/revision-periodica/funciones/adm_person.fblgeneratramiterepara.sql"
@src/gascaribe/revision-periodica/funciones/adm_person.fblgeneratramiterepara.sql

prompt "Aplicando src/gascaribe/revision-periodica/sinonimos/adm_person.fblgeneratramiterepara.sql"
@src/gascaribe/revision-periodica/sinonimos/adm_person.fblgeneratramiterepara.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fsbvalcritadicreconex.sql"
@src/gascaribe/papelera-reciclaje/funciones/fsbvalcritadicreconex.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/funciones/adm_person.fsbvalcritadicreconex.sql"
@src/gascaribe/cartera/suspensiones/funciones/adm_person.fsbvalcritadicreconex.sql

prompt "Aplicando src/gascaribe/cartera/suspensiones/sinonimos/adm_person.fsbvalcritadicreconex.sql"
@src/gascaribe/cartera/suspensiones/sinonimos/adm_person.fsbvalcritadicreconex.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaotencueconccero.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fncretornaotencueconccero.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.ldc_fncretornaotencueconccero.sql"
@src/gascaribe/general/funciones/adm_person.ldc_fncretornaotencueconccero.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaotencueconccero.sql"
@src/gascaribe/general/sinonimos/adm_person.ldc_fncretornaotencueconccero.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbactiv_bloq_osf.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbactiv_bloq_osf.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbactiv_bloq_osf.sql"
@src/gascaribe/gestion-ordenes/funciones/adm_person.ldc_fsbactiv_bloq_osf.sql

prompt "Aplicando src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbactiv_bloq_osf.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_fsbactiv_bloq_osf.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_fsbretornarespprenencues.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_fsbretornarespprenencues.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbretornarespprenencues.sql"
@src/gascaribe/servicios-nuevos/funciones/adm_person.ldc_fsbretornarespprenencues.sql

prompt "Aplicando src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbretornarespprenencues.sql"
@src/gascaribe/servicios-nuevos/sinonimos/adm_person.ldc_fsbretornarespprenencues.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_retornaareaservicio.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_retornaareaservicio.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/funciones/adm_person.ldc_retornaareaservicio.sql"
@src/gascaribe/general/interfaz-contable/funciones/adm_person.ldc_retornaareaservicio.sql

prompt "Aplicando src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_retornaareaservicio.sql"
@src/gascaribe/general/interfaz-contable/sinonimos/adm_person.ldc_retornaareaservicio.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fnuobtperconsante.sql"
@src/gascaribe/papelera-reciclaje/funciones/fnuobtperconsante.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/funciones/adm_person.fnuobtperconsante.sql"
@src/gascaribe/facturacion/consumos/funciones/adm_person.fnuobtperconsante.sql

prompt "Aplicando src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnuobtperconsante.sql"
@src/gascaribe/facturacion/consumos/sinonimos/adm_person.fnuobtperconsante.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/ldc_planfinmayprior.sql"
@src/gascaribe/papelera-reciclaje/funciones/ldc_planfinmayprior.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_planfinmayprior.sql"
@src/gascaribe/cartera/negociacion-deuda/funciones/adm_person.ldc_planfinmayprior.sql

prompt "Aplicando src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_planfinmayprior.sql"
@src/gascaribe/cartera/negociacion-deuda/sinonimos/adm_person.ldc_planfinmayprior.sql

prompt "Aplicando src/gascaribe/papelera-reciclaje/funciones/fnugetitemosf_rollout.sql"
@src/gascaribe/papelera-reciclaje/funciones/fnugetitemosf_rollout.sql

prompt "Aplicando src/gascaribe/general/funciones/adm_person.fnugetitemosf_rollout.sql"
@src/gascaribe/general/funciones/adm_person.fnugetitemosf_rollout.sql

prompt "Aplicando src/gascaribe/general/sinonimos/adm_person.fnugetitemosf_rollout.sql"
@src/gascaribe/general/sinonimos/adm_person.fnugetitemosf_rollout.sql

prompt "Aplicando src/gascaribe/general/sql/OSF-2184_actualizar_obj_migrados.sql"
@src/gascaribe/general/sql/OSF-2184_actualizar_obj_migrados.sql

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
