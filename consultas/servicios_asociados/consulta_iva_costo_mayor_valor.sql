with acta as (
select id_acta, nombre, fecha_creacion, extern_pay_date
from open.ge_acta
where id_tipo_Acta=1
and extern_pay_date>='01/01/2019'
and extern_pay_date<'01/02/2019'
)
,detalle as(
select acta.id_acta,
       acta.fecha_creacion,
       acta.extern_pay_Date,
       acta.nombre,
       d.id_orden,
       l.celocebe,
       sum(decode(d.id_items, 4001293,0, d.valor_total)) valor_acta,
       sum(decode(d.id_items, 4001293,d.valor_total, 0)) valor_iva
from acta
inner join open.ge_detalle_Acta d on d.id_acta=acta.id_acta
inner join open.ge_items i on i.items_id=d.id_items
inner join open.ldci_centbeneloca l on l.celoloca=d.geograp_location_id
where (i.item_classif_id!=23 or i.items_id in (4001293))
group by acta.id_acta,
       acta.fecha_creacion,
       acta.extern_pay_Date,
       acta.nombre,
       d.id_orden,
       l.celocebe)
, base as(
select detalle.id_acta,
       detalle.fecha_creacion,
       detalle.extern_pay_Date,
       detalle.nombre,
       detalle.id_orden,
       detalle.valor_acta,
       detalle.valor_iva,
       o.task_type_id,
       (select description from open.or_task_type t where t.task_type_id=o.task_type_id) desc_titr,
       CT.CUENCOSTO,
       CT.CUENGASTO,
       cl.clctclco,
       celocebe,
       NVL((SELECT CASE WHEN G.TTIVCICO IS NULL THEN 'S' ELSE 'N' END FROM OPEN.ldci_titrindiva G WHERE G.TTIVTITR=O.TASK_TYPE_ID),'N') SUMA
from detalle
inner join open.or_order o on o.order_id=detalle.id_orden
LEFT JOIN OPEN.IC_CLASCOTT CL ON CL.CLCTTITR=O.TASK_TYPE_ID
LEFT JOIN OPEN.LDCI_CUGACOCLASI CT ON CT.CUENCLASIFI=CL.CLCTCLCO)
SELECT base.id_acta,
       base.fecha_creacion,
       base.extern_pay_Date,
       base.nombre,
       base.id_orden,
       base.valor_acta,
       base.valor_iva,
       base.task_type_id,
       base.desc_titr,
       base.CUENCOSTO,
       base.CUENGASTO,
       base.clctclco,
       base.SUMA,
       celocebe,
       case when suma='S' then base.valor_Acta+valor_iva else base.valor_Acta  end valor_con_iva_mayor ,
       (select distinct substr(ccc.ccbgceco, 5, 2) ceco from open.ldci_cecoubigetra ccc where  ccc.ccbgtitr=base.task_type_id) ceco
from base;
