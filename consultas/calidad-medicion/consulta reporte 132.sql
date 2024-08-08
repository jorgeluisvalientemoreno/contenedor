with categorias as(select column_value catecodi
                            from table(ldc_boutilities.splitstrings(dald_parameter.fsbGetValue_Chain('CATEGORIAVPM', null),','))),
     cambiomed as(select ti.task_type_id
                 from open.ge_items_attributes ia , open.or_task_types_items ti 
                where (attribute_1_id = 400022 or attribute_2_id = 400022 or attribute_3_id = 400022  or attribute_4_id = 400022)                                 
                  and (attribute_1_id = 400021 or attribute_2_id = 400021 or attribute_3_id = 400021  or attribute_4_id = 400021)
                  and ti.items_id=ia.items_id
                  union
                  select to_number(column_value)
                            from table(open.ldc_boutilities.splitstrings(open.dald_parameter.fsbgetvalue_chain('PARTTNOPERVPM',NULL),','))
                            
                  ),
base as (                  
select p.product_id,
       p.category_id,
       p.product_status_id,
       p.address_id,
       p.subscription_id,
       se.sesufein,
       v.fecha_vpm,
       round(months_between(sysdate, v.fecha_vpm)) edad_vigencia
from ldc_vpm  v
inner join open.pr_product p on v.product_id=p.product_id and p.product_status_id in (1) and p.category_id in (select catecodi from categorias)
inner join open.servsusc se on se.sesunuse=v.product_id and sesuesco not in (5)
where not exists(select null from open.pr_prod_suspension s where s.product_id=p.product_id and active='Y')
  and round(months_between(sysdate, v.fecha_vpm))>= 60
  and v.product_id not in (select PRODUCTO from open.REGMEDIVSI)),
ordenes as(
select o.order_id, o.task_type_id,oa.product_id from open.or_order o
inner join open.or_order_activity oa on o.order_id=oa.order_id and oa.task_type_id in (select cm.task_type_id from cambiomed cm) and oa.status!='F'
where o.order_status_id in (-1,0,1,11,18,19,20,5,6,7)
  and o.task_type_id in (select cm.task_type_id from cambiomed cm)
  and oa.product_id in (select ba.product_id from base ba))
select lo.geo_loca_father_id codigo_departamento,
       open.dage_geogra_location.fsbgetdescription(lo.geo_loca_father_id, null) descripcion_departamento,
       lo.geograp_location_id codigo_localidad,
       lo.description descripcion_localidad,
       sg.operating_sector_id codigo_sector_oper,
       daor_operating_sector.fsbgetdescription(sg.operating_sector_id, null) descripcion_sector_oper,
       b.edad_vigencia,
       b.category_id codigo_categoria,
       open.pktblcategori.fsbgetdescription(b.category_id) descripcion_categoria,
       (select c.hcppcopr from open.hicoprpm c where c.hcppsesu = b.product_id  and c.hcpppeco =(select max(c1.hcpppeco) from open.hicoprpm c1 where c1.hcppsesu = b.product_id) and rownum = 1) consumo_promedio,
       b.subscription_id contrato,
       b.product_id producto,
       (select gs.subscriber_name || ' ' || gs.subs_last_name from ge_subscriber gs where gs.subscriber_id = (select s.suscclie from suscripc s where s.susccodi = b.subscription_id)) nombre,
       el.emsscoem medidor,
       b.sesufein  fecha_instalacion,
       el.emssfein fecha_medidor,
       di.address_parsed direccion,
       di.neighborthood_id codigo_barrio,
       open.dage_geogra_location.fsbgetdescription(di.neighborthood_id, null) desripcion_barrio,
       b.product_status_id estado_producto,
       b.fecha_vpm
from base b
inner join open.ab_address di on di.address_id=b.address_id
inner join open.ge_geogra_location lo on lo.geograp_location_id= di.geograp_location_id
inner join open.ab_segments sg on sg.segments_id = di.segment_id
inner join open.elmesesu el on el.emsssesu=b.product_id and sysdate between el.emssfein and el.emssfere
where product_id not in (select o.product_id from ordenes o )

--5996
                 
