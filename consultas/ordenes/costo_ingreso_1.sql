with base as(select /*+ INDEX (o IDX_ORDENES_COSTO_INGRESO)  */
       o.order_id, o.task_type_id,o.operating_unit_id, o.legalization_date, o.clctclco,
       o.clcodesc, o.concept, o.product_id, o.package_id, o.actividad, o.cuenta,
       (select category_id from open.pr_product p where p.product_id=o.product_id) cate
from open.ldc_ordenes_costo_ingreso o
where o.nuano=2018
  and o.numes=10
  and not exists(select null from open.ct_order_certifica c where c.order_id=o.order_id)
  ),
 base2 as( 
 select base.*,
        u.name, 
        u.contractor_id,
        u.es_externa,
        c.nombre_contratista,
        (select lc.cuctdesc from open.ldci_cuentacontable lc where lc.cuctcodi = base.cuenta) Nom_Cuenta,
        (select catedesc from  open.categori where catecodi=base.cate) Nom_cate,
        'SIN_ACTA' TIPO,
        nvl((select 'S' from open.ct_item_novelty n where n.items_id=base.actividad),'N') es_novedad
 from base
 inner join open.or_operating_unit u on u.operating_unit_id=base.operating_unit_id
 left join open.ge_contratista c on c.id_contratista=u.contractor_id
 ),
 base3 as(
 select base2.order_id, 
       base2.task_type_id,
       base2.operating_unit_id,
       base2.name,  
       base2.legalization_date, 
       base2.clctclco,
       base2.clcodesc, 
       base2.concept, 
       base2.product_id, 
       base2.package_id, 
       base2.actividad, 
       base2.cuenta,
       base2.cate,
       base2.es_externa,
       base2.contractor_id,
       base2.nombre_contratista,
       base2.Nom_Cuenta,
       base2.TIPO,
       base2.es_novedad,
       base2.Nom_cate,
       sum(oi.value) costo
 from open.base2
 inner join open.or_order_items oi on oi.order_id=base2.order_id
 inner join open.ge_items i on i.items_id=oi.items_id and i.item_classif_id not in (3,8,21)
 group by base2.order_id, 
       base2.task_type_id,
       base2.operating_unit_id,
       base2.name,  
       base2.legalization_date, 
       base2.clctclco,
       base2.clcodesc, 
       base2.concept, 
       base2.product_id, 
       base2.package_id, 
       base2.actividad, 
       base2.cuenta,
       base2.cate,
       base2.es_externa,
       base2.contractor_id,
       base2.Nom_Cuenta,
       base2.TIPO,
       base2.es_novedad,
       base2.Nom_cate,
       base2.nombre_contratista),
base4 as(       
select base3.tipo,
       base3.order_id orden, 
       base3.task_type_id titr,
       decode(base3.es_externa,'Y',base3.contractor_id, base3.operating_unit_id) contratista,
       nvl(base3.nombre_contratista,base3.name) nombre,
       base3.legalization_date fec_lega, 
       base3.clctclco,
       base3.clcodesc, 
       base3.concept, 
       base3.product_id,
       base3.package_id, 
       base3.actividad, 
       base3.cuenta,
       base3.cate,
       decode(base3.es_externa,'Y', base3.costo,0) costo, 
       0 Iva,
       base3.Nom_cate,
       null factura,
       null  fecha,
       null acta,
       base3.Nom_Cuenta,
       CASE WHEN base3.concept IS NOT null 
         and base3.package_id is not null  
         AND base3.es_novedad ='N'
         and base3.concept NOT IN (19,30,291,674) 
         and base3.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) 
         and ca.cargcodo=base3.order_id THEN
             ca.cargvalo
          ELSE
            0 
         END Ingreso,
       CASE WHEN base3.concept IS NOT  null 
        and base3.package_id is not null
        AND base3.es_novedad ='N'
        AND base3.concept NOT IN (19,30,291,674) 
        AND base3.task_type_id NOT IN (10495,12149,12151,10622,10624,12150,12152,12153) 
        and ca.cargcodo!=base3.order_id THEN
            ca.cargvalo
        ELSE
         0 
        END Ing_Otro/*,
            (select count(1) from open.hicaesco h
         where h.hcecfech >= to_date('01/10/2018','dd/mm/yyyy') --to_date('01/04/2016 00:00:00','dd/mm/yyyy hh24:mi:ss')
           and h.hcecfech <= to_date('31/10/2018','dd/mm/yyyy') --to_date('30/04/2016 23:59:59','dd/mm/yyyy hh24:mi:ss'
           and h.hcecserv = 7014 and h.hcecnuse = base3.product_id and h.hcececan = 96 and h.hcececac = 1) Estado*/
from base3
left join open.cargos ca on ca.cargnuse=base3.product_id and ca.cargconc=base3.concept and ca.cargcaca IN (41,53) and ca.cargsign='DB' and ca.cargtipr='A' and ca.cargdoso='PP-'||base3.package_id and ca.cargcuco!=-1
left join open.cuencobr co on co.cucocodi=ca.cargcuco and co.cucofact!=-1
left join open.factura fa on fa.factcodi=co.cucofact and fa.factfege >= to_date('01/10/2018','dd/mm/yyyy') AND fa.factfege <= to_date('31/10/2018','dd/mm/yyyy')
)
select base4.tipo,
       base4.orden, 
       base4.titr,
       base4.contratista,
       base4.nombre,
       base4.fec_lega, 
       base4.clctclco,
       base4.clcodesc, 
       base4.concept, 
       base4.product_id,
       base4.package_id, 
       base4.actividad, 
       base4.cuenta,
       base4.cate,
       base4.costo,
       base4.Iva,
       base4.Nom_cate,
       null factura,
       null  fecha,
       null acta,
       base4.Nom_Cuenta,
       sum(Ingreso) Ingreso,
       sum(Ing_Otro) Ing_Otro
from base4   
group by     base4.tipo,
       base4.orden, 
       base4.titr,
       base4.contratista,
       base4.nombre,
       base4.fec_lega, 
       base4.clctclco,
       base4.clcodesc, 
       base4.concept, 
       base4.product_id,
       base4.package_id, 
       base4.actividad, 
       base4.cuenta,
       base4.cate,
       base4.costo,
       base4.Iva,
       base4.Nom_cate,
       base4.Nom_Cuenta
