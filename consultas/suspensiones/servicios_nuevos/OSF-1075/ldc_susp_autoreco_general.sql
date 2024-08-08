select a.sarecodi,
       a.saresesu,
       ss.sesuesco,
      ec.coecfact  "Facturable",
       a.saresape,
       a.sarecons,
       a.sareacti,
       a.sarepeva,
       a.sareaure,
       a.sarefege,
       a.sareuser,
       a.sarefepr,
       a.sarecicl,
       a.sareorde,
       a.sareacor,
       a.saredepa,
       a.sareloca,
       a.saresect,
       a.sareclie,
       a.sarecont,
       a.sareespr,
       a.saredire,
       a.sarecate,
       a.sareleac,
       a.sarelean,
       a.sarelesu,
       a.sarefesu,
       a.sarettsu,
       a.sareorsu,
       a.saremarc,
       a.saremult,
       a.sareplma,
       a.sareproc,
       p.product_status_id,
       ps.suspension_type_id "Tipo_Susp",
       ps.active             "Activa",
      p.suspen_ord_act_id   "Orden_susp",
       ps.aplication_date    "Fecha_Aplicacion",
       ac.task_type_id        "tt_susp",
       ac.activity_id         "Act_susp",
       initcap (i.description)         "Desc_act_susp"
from ldc_susp_autoreco  a
inner join servsusc ss on ss.sesunuse = a.saresesu
inner join confesco  ec on ec.coecserv = ss.sesuserv and ss.sesuesco = ec.coeccodi
inner join pr_product p on p.product_id = ss.sesunuse
left join pr_prod_suspension ps on p.product_id = ps.product_id
left join or_order_activity  ac on ac.order_activity_id = p.suspen_ord_act_id
left join ge_items  i on i.items_id = ac.activity_id
where a.sareproc = 7
and ps.active = 'Y'

--and   ss.sesuesco in (select ec.coeccodi from confesco  ec  where ec.coecserv = ss.sesuserv and ec.coecfact = 'S')
