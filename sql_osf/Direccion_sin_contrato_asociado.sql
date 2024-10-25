  select pr_product.product_id  "Producto",ab_address.address_id,
       case when pr_product.product_id is null then 'Sin ocupar'
            when pr_product.product_id is not null then 'Ocupado' end  "Predio ocupado",
       ab_address.geograp_location_id || '-  ' || initcap(ge_geogra_location.display_description)  "Ciudad",
       ab_address.neighborthood_id || '-  ' || initcap(gl.description)  "Barrio",
       ab_address.address_parsed  "Direccion",
       ab_address.estate_number  "Predio",
       ab_premise.premise_type_id ||'- '|| initcap(ab_premise_type.description)  "Tipo de predio",
       case when ab_address.is_urban = 'Y' then 'Si'
            when ab_address.is_urban = 'N' then 'N' end  "Es urbana",
       case when ab_info_premise.is_ring = 'Y' then 'Si'
            when ab_info_premise.is_ring = 'N' then 'No' end  "Esta anillado",
       ab_info_premise.level_risk ||'- '|| initcap(ldc_level_risk.descripcion_riesgo)  "Nivel de riesgo",
       case when ldc_level_risk.es_vendible = 'Y' then 'Si'
            when ldc_level_risk.es_vendible = 'N' then 'No' end  "Es factible",
       case when ldc_info_predio.pno = 0 then 'Sin fraude'
            when ldc_info_predio.pno is null then 'Sin fraude'
            when ldc_info_predio.pno = 1 then 'Con fraude' end  "Predio con fraude",
       ab_premise.category_ ||'- '|| initcap(categori.catedesc)  "Categoria",
       ab_premise.subcategory_ ||'- '|| initcap(open.subcateg.sucadesc)  "Subcategoria"
from open.ab_address
left join open.ab_premise on ab_address.estate_number  = ab_premise.premise_id
left join open.ab_info_premise on ab_info_premise.premise_id = ab_address.estate_number
left join open.ldc_info_predio on ldc_info_predio.premise_id = ab_info_premise.premise_id
left join open.ge_geogra_location on ge_geogra_location.geograp_location_id = ab_address.geograp_location_id
left join ge_geogra_location  gl on gl.geograp_location_id = ab_address.neighborthood_id
left join open.ab_premise_type on ab_premise_type.premise_type_id = ab_premise.premise_type_id
left join open.categori on categori.catecodi = ab_premise.category_
left join open.subcateg on subcateg.sucacate = ab_premise.category_
left join open.ldc_level_risk on ldc_level_risk.nivel_riesgo = ab_info_premise.level_risk
left join open.pr_product on pr_product.address_id = ab_address.address_id
where subcateg.sucacodi = ab_premise.subcategory_
and (select count(1) from open.suscripc where suscripc.susciddi = ab_address.address_id) = 0
and ab_address.address not in ('KR MTTO CL MTTO - 0', 'RECAUDO PAGO NACIONAL', 'KR GENERICA CL GENERICA - 0') and ab_address.address not like '%No existe%'
and ab_premise.premise_type_id is not null
and ab_info_premise.is_ring = 'Y'
and not exists(select null from open.pr_product where pr_product.address_id = ab_address.address_id and pr_product.product_type_id in ('7055','7056'))
and ldc_info_predio.pno is null
and ldc_level_risk.es_vendible = 'Y'
and  pr_product.product_id is null
and ab_premise.category_ = 3
and ab_premise.subcategory_ = 1
and ge_geogra_location.geo_loca_father_id = 2
--and ab_address.address_id = 181988
;
---------------------------------------------------------------------------------------------------------
select a.address_id,
       a.geograp_location_id "Ciudad",
       a.neighborthood_id "Barrio",
       a.address_parsed "Direccion",
       a.estate_number "Predio",
       ap.premise_type_id || '- ' ||
       ap.category_  "Categoria",
       ap.subcategory_  "Subcategoria"
  from ab_address a, ab_premise ap
 where (select count(1) from suscripc b where b.SUSCIDDI = a.address_id) = 0
   and a.address not in ('KR MTTO CL MTTO - 0',
                         'RECAUDO PAGO NACIONAL',
                         'KR GENERICA CL GENERICA - 0',
                         'RECAUDO PAGO NACIONAL')
   and a.address not like '%Borrado de GIS%'
   and a.geograp_location_id not in (8200, 8218)
   and a.geograp_location_id = 201
   and a.estate_number = ap.premise_id
   and ap.subcategory_ = 2
   and ap.category_ = 1
   and (SELECT /*+ index (PR_Product IDX_PR_PRODUCT_09)
                   use_nl_with_index(ps_product_status PK_PS_PRODUCT_STATUS)*/
         count(PRODUCT_ID)
          FROM PR_PRODUCT, PS_PRODUCT_STATUS
        /*+ pr_bcProduct.fnuGetProdByAddrProdType cuGetProduct*/
         WHERE ADDRESS_ID = a.address_id
           AND PRODUCT_TYPE_ID = 7014
           AND PR_PRODUCT.PRODUCT_STATUS_ID =
               PS_PRODUCT_STATUS.PRODUCT_STATUS_ID
           AND IS_ACTIVE_PRODUCT = 'Y' --GE_BOCONSTANTS.CSBYES
           AND ROWNUM = 1) = 0;

------------------------------------------------------------------
select *
  from ab_address a, ab_premise ap
 where (select count(1) from suscripc b where b.SUSCIDDI = a.address_id) = 0
   and a.address not in ('KR MTTO CL MTTO - 0',
                         'RECAUDO PAGO NACIONAL',
                         'KR GENERICA CL GENERICA - 0',
                         'RECAUDO PAGO NACIONAL')
   and a.address not like '%Borrado de GIS%'
   and a.geograp_location_id not in (8200, 8218)
   and a.geograp_location_id = 201
   and a.estate_number = ap.premise_id
   and ap.subcategory_ = 2
   and ap.category_ = 1
   and (SELECT /*+ index (PR_Product IDX_PR_PRODUCT_09)
                                                                                   use_nl_with_index(ps_product_status PK_PS_PRODUCT_STATUS)
                                                                                   */
         count(PRODUCT_ID)
          FROM PR_PRODUCT, PS_PRODUCT_STATUS
        /*+ pr_bcProduct.fnuGetProdByAddrProdType cuGetProduct*/
         WHERE ADDRESS_ID = a.address_id
           AND PRODUCT_TYPE_ID = 7014
           AND PR_PRODUCT.PRODUCT_STATUS_ID =
               PS_PRODUCT_STATUS.PRODUCT_STATUS_ID
           AND IS_ACTIVE_PRODUCT = 'Y' --GE_BOCONSTANTS.CSBYES
           AND ROWNUM = 1) = 0
   and (SELECT /*+ INDEX(a IDX_MO_PACKAGES_024) */
         count(1) --A.*, A.ROWID
          FROM MO_PACKAGES A
         WHERE A.PACKAGE_TYPE_ID in
               (PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_SOLICITUD_DE_INTERNA_329'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_VENTA_DE_GAS_POR_FORMULARIO_271'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_LBC_VENTA_COTIZADA_100229'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_FORMULARIO_IFRS_100249'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_INTERNA_IFRS_100259'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_COTIZADA_IFRS_100272')) --INUPACKTYPEID
           AND EXISTS (SELECT /*+ INDEX(b PK_PS_MOTIVE_STATUS) USE_NL(a b) */
                 'x'
                  FROM PS_MOTIVE_STATUS B
                 WHERE B.MOTIVE_STATUS_ID = A.MOTIVE_STATUS_ID
                   AND B.IS_FINAL_STATUS = 'N'
                   AND ROWNUM = 1)
           AND EXISTS (SELECT /*+ INDEX(b IDX_MO_MOTIVE_02) INDEX(c PK_PR_PRODUCT) USE_NL(a b) USE_NL(b c) */
                 'x'
                  FROM MO_MOTIVE B, PR_PRODUCT C
                 WHERE B.PACKAGE_ID = A.PACKAGE_ID
                   AND B.PRODUCT_ID = C.PRODUCT_ID
                   AND C.ADDRESS_ID = a.address_id
                   AND ROWNUM = 1)) = 0;

--------------

select pr_product.product_id "Producto",
       ab_address.address_id,
       case
         when pr_product.product_id is null then
          'Sin ocupar'
         when pr_product.product_id is not null then
          'Ocupado'
       end "Predio ocupado",
       ab_address.geograp_location_id || '-  ' ||
       initcap(ge_geogra_location.display_description) "Ciudad",
       ab_address.neighborthood_id || '-  ' || initcap(gl.description) "Barrio",
       ab_address.address_parsed "Direccion",
       ab_address.estate_number "Predio",
       ab_premise.premise_type_id || '- ' ||
       initcap(ab_premise_type.description) "Tipo de predio",
       case
         when ab_address.is_urban = 'Y' then
          'Si'
         when ab_address.is_urban = 'N' then
          'N'
       end "Es urbana",
       case
         when ab_info_premise.is_ring = 'Y' then
          'Si'
         when ab_info_premise.is_ring = 'N' then
          'No'
       end "Esta anillado",
       ab_info_premise.level_risk || '- ' ||
       initcap(ldc_level_risk.descripcion_riesgo) "Nivel de riesgo",
       case
         when ldc_level_risk.es_vendible = 'Y' then
          'Si'
         when ldc_level_risk.es_vendible = 'N' then
          'No'
       end "Es factible",
       case
         when ldc_info_predio.pno = 0 then
          'Sin fraude'
         when ldc_info_predio.pno is null then
          'Sin fraude'
         when ldc_info_predio.pno = 1 then
          'Con fraude'
       end "Predio con fraude",
       ab_premise.category_ || '- ' || initcap(categori.catedesc) "Categoria",
       ab_premise.subcategory_ || '- ' || initcap(open.subcateg.sucadesc) "Subcategoria"
  from open.ab_address
  left join open.ab_premise
    on ab_address.estate_number = ab_premise.premise_id
  left join open.ab_info_premise
    on ab_info_premise.premise_id = ab_address.estate_number
  left join open.ldc_info_predio
    on ldc_info_predio.premise_id = ab_info_premise.premise_id
  left join open.ge_geogra_location
    on ge_geogra_location.geograp_location_id =
       ab_address.geograp_location_id
  left join ge_geogra_location gl
    on gl.geograp_location_id = ab_address.neighborthood_id
   and gl.geograp_location_id = 201
  left join open.ab_premise_type
    on ab_premise_type.premise_type_id = ab_premise.premise_type_id
  left join open.categori
    on categori.catecodi = ab_premise.category_
  left join open.subcateg
    on subcateg.sucacate = ab_premise.category_
  left join open.ldc_level_risk
    on ldc_level_risk.nivel_riesgo = ab_info_premise.level_risk
  left join open.pr_product
    on pr_product.address_id = ab_address.address_id
 where subcateg.sucacodi = ab_premise.subcategory_
   and (select count(1)
          from open.suscripc
         where suscripc.susciddi = ab_address.address_id) = 0
   and ab_address.address not in
       ('KR MTTO CL MTTO - 0',
        'RECAUDO PAGO NACIONAL',
        'KR GENERICA CL GENERICA - 0')
   and ab_premise.premise_type_id is not null
   and ab_info_premise.is_ring = 'Y'
   and not exists
 (select null
          from open.pr_product
         where pr_product.address_id = ab_address.address_id
           and pr_product.product_type_id in ('7055', '7056'))
   and ldc_info_predio.pno is null
   and ldc_level_risk.es_vendible = 'Y'
   and pr_product.product_id is null
   and ab_premise.category_ = 1
   and ab_premise.subcategory_ = 2
   and (SELECT /*+ index (PR_Product IDX_PR_PRODUCT_09)
                                                                                   use_nl_with_index(ps_product_status PK_PS_PRODUCT_STATUS)
                                                                                   */
         count(PRODUCT_ID)
          FROM PR_PRODUCT, PS_PRODUCT_STATUS
        /*+ pr_bcProduct.fnuGetProdByAddrProdType cuGetProduct*/
         WHERE ADDRESS_ID = ab_address.address_id
           AND PRODUCT_TYPE_ID = 7014
           AND PR_PRODUCT.PRODUCT_STATUS_ID =
               PS_PRODUCT_STATUS.PRODUCT_STATUS_ID
           AND IS_ACTIVE_PRODUCT = 'Y' --GE_BOCONSTANTS.CSBYES
           AND ROWNUM = 1) = 0
   and (SELECT /*+ INDEX(a IDX_MO_PACKAGES_024) */
         count(1) --A.*, A.ROWID
          FROM MO_PACKAGES A
         WHERE A.PACKAGE_TYPE_ID in
               (PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_SOLICITUD_DE_INTERNA_329'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_VENTA_DE_GAS_POR_FORMULARIO_271'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_LBC_VENTA_COTIZADA_100229'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_FORMULARIO_IFRS_100249'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_INTERNA_IFRS_100259'),
                PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME('P_COTIZADA_IFRS_100272')) --INUPACKTYPEID
           AND EXISTS (SELECT /*+ INDEX(b PK_PS_MOTIVE_STATUS) USE_NL(a b) */
                 'x'
                  FROM PS_MOTIVE_STATUS B
                 WHERE B.MOTIVE_STATUS_ID = A.MOTIVE_STATUS_ID
                   AND B.IS_FINAL_STATUS = 'N'
                   AND ROWNUM = 1)
           AND EXISTS (SELECT /*+ INDEX(b IDX_MO_MOTIVE_02) INDEX(c PK_PR_PRODUCT) USE_NL(a b) USE_NL(b c) */
                 'x'
                  FROM MO_MOTIVE B, PR_PRODUCT C
                 WHERE B.PACKAGE_ID = A.PACKAGE_ID
                   AND B.PRODUCT_ID = C.PRODUCT_ID
                   AND C.ADDRESS_ID = ab_address.address_id
                   AND ROWNUM = 1)) = 0
   and rownum = 1;
