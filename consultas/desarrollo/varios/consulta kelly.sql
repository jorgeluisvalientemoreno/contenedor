with clasificador as( select tt.clctclco , tt.clcttitr  from open.ic_clascott tt, open.ic_clascont cl where  cl.clcocodi=tt.clctclco and tt.clcttitr in (10395,12119,10355))
        , cuenta as(select distinct cl.cuenclasifi, cl.cuencosto cuctcodi from open.ldci_cugacoclasi cl, clasificador c where c.clctclco=cl.cuenclasifi )
        , localidades as (
        select /*+ index( lo IX_GE_GEOGRA_LOCATION06 ) index(de PK_GE_GEOGRA_LOCATION)*/de.geograp_location_id depa, de.description desc_depa, lo.geograp_location_id loca, lo.description desc_loca
        from open.ge_geogra_location lo
        inner join open.ge_geogra_location de on de.geograp_location_id=lo.geo_loca_father_id
        where lo.geog_loca_area_type=3)
        , ordenes as(
        
        select o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.operating_unit_id, 
               u.name,
               u.contractor_id,
               i.items_id,
               i.description,
               sum(decode(oi.out_,'N',-1,1)*oi.value) valor_total,
               0 valor_iva,
               ct.clctclco,
               o.external_address_id,
               (select ac.address_id from open.or_order_Activity ac where ac.order_id=o.order_id and rownum=1)  address_id,
               o.defined_contract_id,
               o.legalization_date
        from open.or_order o
        inner join clasificador ct on ct.clcttitr=decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id)
        inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id  and u.es_externa = 'Y'
        inner join open.or_order_items oi on oi.order_id=o.order_id and oi.value!=0
        inner join open.ge_items i on i.items_id=oi.items_id and i.item_classif_id not in (3,8,21)
        inner join open.ge_causal c on c.causal_id=o.causal_id and c.class_causal_id=1
        where o.legalization_Date>='01/08/2020'
          and o.legalization_Date<'01/09/2020'
          and o.order_status_id=8
          and not exists(select null from open.ct_item_novelty n where n.items_id=oi.items_id)
        group by o.order_id,
               o.task_type_id,
               u.operating_unit_id, 
               u.name,
               o.real_task_type_id,
               u.contractor_id,
               i.items_id,
               i.description,
               ct.clctclco,               
               o.external_address_id,
               o.defined_contract_id,
               o.legalization_date
        union
        select o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.operating_unit_id, 
               u.name,
               u.contractor_id,
               i.items_id,
               i.description,
               sum(a.value_reference*liquidation_sign*nvl((select -1 from open.or_related_order r where r.related_order_id=o.order_id and r.rela_order_type_id=15), 1)) valor,
               0 valor_iva,
               ct.clctclco,
               o.external_address_id,
               (select ac.address_id from open.or_order_Activity ac where ac.order_id=o.order_id and rownum=1)  address_id,
               o.defined_contract_id,
               o.legalization_date
        from open.or_order o
        inner join clasificador ct on ct.clcttitr=decode(o.task_type_id,10336, o.real_task_type_id, o.task_type_id)
        inner join open.or_operating_unit u on u.operating_unit_id=o.operating_unit_id  and u.es_externa = 'Y'
        inner join open.or_order_activity a on a.order_id=o.order_id and a.task_type_id=o.task_type_id and a.final_date is null
        inner join open.ct_item_novelty n on n.items_id=a.activity_id
        inner join open.ge_items i on i.items_id=a.activity_id
        inner join open.ge_causal c on c.causal_id=o.causal_id and c.class_causal_id=1
        where o.legalization_Date>='01/08/2020'
          and o.legalization_date<'01/09/2020'
          and o.order_status_id=8
          and exists(select null from open.ct_item_novelty n where n.items_id=a.activity_id)
        group by o.order_id,
               o.task_type_id,
               o.real_task_type_id,
               u.operating_unit_id, 
               u.name,
               u.contractor_id,
               i.items_id,
               i.description,
               ct.clctclco,
               o.external_address_id,
               o.defined_contract_id,
               o.legalization_date)     
        select ot.operating_unit_id unidad,
               ot.name nombre_unidad,
             lo.depa departamento,
             lo.desc_depa,
             lo.loca localidad,
             lo.desc_loca,
             ot.order_id orden,
             decode(ot.task_type_id,10336,ot.real_task_type_id,ot.task_type_id) titr, 
             open.daor_task_type.fsbgetdescription(decode(ot.task_type_id,10336,ot.real_task_type_id,ot.task_type_id)) desc_titr,
             ot.items_id,
             ot.description,
             Round(ot.valor_total) Valor,
             c.cuctcodi cuenta,
             ot.clctclco clasificador,
             ot.legalization_date,
             (select ce.certificate_id from open.ct_order_certifica ce where ce.order_id=ot.order_id) acta
        from ordenes ot
        left join open.ab_address di on di.address_id=nvl(ot.external_address_id,ot.address_id)
        left join localidades lo on lo.loca=di.geograp_location_id
        inner join cuenta c on c.cuenclasifi=ot.clctclco;
