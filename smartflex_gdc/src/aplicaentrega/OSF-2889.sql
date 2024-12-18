column dt new_value vdt
column db new_value vdb
select to_char(sysdate,'yyyymmdd_hh24miss') dt, sys_context('userenv','db_name') db from dual;
set serveroutput on
set define off
set timing on
execute dbms_application_info.set_action('APLICANDO SAO');
select to_char(sysdate,'yyyy-mm-dd hh:mi:ss p.m.') fecha_inicio from dual;

prompt "-----------------"
prompt "Aplicando Entrega OSF-2889"
prompt "-----------------"

prompt "-----paquete LDC_PKCC_SCM-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcc_scm.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcc_scm.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bopetitionmgr.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_bopetitionmgr.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_com_seg_plan.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_com_seg_plan.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_wage_scale.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ge_wage_scale.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_subscriber_type.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ge_subscriber_type.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.estafina.sql"
@src/gascaribe/cartera/sinonimo/adm_person.estafina.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_tipo_scoring.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_tipo_scoring.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_bouicommercialsegm.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_bouicommercialsegm.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_cc_scma.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_cc_scma.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.cc_com_seg_prom.sql"
@src/gascaribe/cartera/sinonimo/adm_person.cc_com_seg_prom.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_school_degree.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ge_school_degree.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ge_civil_state.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ge_civil_state.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkcc_scm.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_pkcc_scm.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkcc_scm.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkcc_scm.sql


prompt "-----paquete LDC_PKCOTICOMERCONS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcoticomercons.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcoticomercons.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_ldc_items_cotizacion_com.sql"
@src/gascaribe/ventas/sinonimos/adm_person.seq_ldc_items_cotizacion_com.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_itemscoticomer_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemscoticomer_adic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_coticonstructora_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_coticonstructora_adic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_itemscoticonstru_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemscoticonstru_adic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_itemscotivalfijos_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemscotivalfijos_adic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_itemscotimetraje_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_itemscotimetraje_adic.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_coticomercial_adic.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_coticomercial_adic.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkcoticomercons.sql"
@src/gascaribe/ventas/paquetes/adm_person.ldc_pkcoticomercons.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkcoticomercons.sql"
@src/gascaribe/ventas/sinonimos/adm_person.ldc_pkcoticomercons.sql


prompt "-----paquete LDC_PK_ORCUO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pk_orcuo.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pk_orcuo.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.daor_ope_uni_item_bala.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.daor_ope_uni_item_bala.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pk_orcuo.sql"
@src/gascaribe/gestion-ordenes/paquetes/adm_person.ldc_pk_orcuo.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pk_orcuo.sql"
@src/gascaribe/gestion-ordenes/sinonimos/adm_person.ldc_pk_orcuo.sql


prompt "-----paquete LDC_PK_PRODUCT_VALIDATE-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pk_product_validate.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pk_product_validate.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_perfil_abono_prod.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_perfil_abono_prod.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pk_product_validate.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_pk_product_validate.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pk_product_validate.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pk_product_validate.sql


prompt "-----paquete LDC_PKCONDICIONVISUALIZACION-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcondicionvisualizacion.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcondicionvisualizacion.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkcondicionvisualizacion.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_pkcondicionvisualizacion.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkcondicionvisualizacion.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkcondicionvisualizacion.sql


prompt "-----paquete LDC_PKDUPLIFACT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkduplifact.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkduplifact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.esprsepe.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.esprsepe.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.seq_lotefact.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.seq_lotefact.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_pkdatafixupdeddocu.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkdatafixupdeddocu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldcupdocfactlog.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldcupdocfactlog.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.pkboed_documentmem.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.pkboed_documentmem.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkduplifact.sql"
@src/gascaribe/atencion-usuarios/paquetes/adm_person.ldc_pkduplifact.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkduplifact.sql"
@src/gascaribe/atencion-usuarios/sinonimos/adm_person.ldc_pkduplifact.sql


prompt "-----paquete LDC_PKGAPUSSOTECO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgapussoteco.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgapussoteco.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete adm_person.ldc_contratpendtermi.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_contratpendtermi.sql

prompt "--->Aplicando creacion de paquete adm_person.ldc_pkgapussoteco.sql"
@src/gascaribe/cartera/paquetes/adm_person.ldc_pkgapussoteco.sql

prompt "--->Aplicando creacion sinonimo a nuevo paquete adm_person.ldc_pkgapussoteco.sql"
@src/gascaribe/cartera/sinonimo/adm_person.ldc_pkgapussoteco.sql


prompt "-----paquete LDC_PKCAMPANAFNB-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcampanafnb.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcampanafnb.sql


prompt "-----paquete LDC_PKCARGALDRVOLU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcargaldrvolu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcargaldrvolu.sql


prompt "-----paquete LDC_PKCARTARISEGU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcartarisegu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcartarisegu.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete public.ldc_pkcartarisegu.sql"
@src/gascaribe/papelera-reciclaje/sinonimos/public.ldc_pkcartarisegu.sql


prompt "-----paquete LDC_PKCM_LECTESP8-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcm_lectesp8.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcm_lectesp8.sql


prompt "-----paquete LDC_PKCM_LECTESP9-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcm_lectesp9.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcm_lectesp9.sql


prompt "-----paquete LDC_PKCOMBSOL-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkcombsol.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkcombsol.sql

prompt "--->Aplicando creacion sinonimo dependiente a nuevo paquete public.ldc_pkcombsol.sql"
@src/gascaribe/papelera-reciclaje/sinonimos/public.ldc_pkcombsol.sql


prompt "-----paquete LDC_PKG_LDCMOSACA-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkg_ldcmosaca.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkg_ldcmosaca.sql


prompt "-----paquete LDC_PKG_PROCVALDATOLEGOT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkg_procvaldatolegot.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkg_procvaldatolegot.sql


prompt "-----paquete LDC_PKGENECUPOTOTVENCO-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgenecupototvenco.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgenecupototvenco.sql


prompt "-----paquete LDC_PKGENERANOTAS-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgeneranotas.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgeneranotas.sql


prompt "-----paquete LDC_PKGESTIONSIANTT-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgestionsiantt.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgestionsiantt.sql


prompt "-----paquete LDC_PKGESTIONTATTPR-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkgestiontattpr.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkgestiontattpr.sql


prompt "-----paquete LDC_PKGGECOPRFASIMU-----" 
prompt "--->Aplicando borrado paquete de esquema OPEN ldc_pkggecoprfasimu.sql"
@src/gascaribe/papelera-reciclaje/paquetes/ldc_pkggecoprfasimu.sql


prompt "-----Script OSF-2889_actualizar_obj_migrados-----"
@src/gascaribe/datafix/OSF-2889_actualizar_obj_migrados.sql


prompt "-----------------------"
prompt "-----FINALIZA-----"
prompt "-----------------------"
prompt "-----Fin Aplica Entrega OSF-OSF-2889-----"
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
