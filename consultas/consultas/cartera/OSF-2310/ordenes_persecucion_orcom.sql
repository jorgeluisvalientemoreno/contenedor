with task_type_parameter as (select to_number(regexp_substr(ldc_bcConsGenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','TIPOS_TRABAJO_PERSECUCION'), '[^,]+', 1, level)) as task_type_id
                             from dual
                             connect by regexp_substr(ldc_bcConsGenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','TIPOS_TRABAJO_PERSECUCION'), '[^,]+', 1, level) is not null),
order_orcom as (select oa.product_id as "PRODUCTO",
                       s.sesuesco as "ESTADO CORTE",
                       s.sesuesfn as "ESTADO FINANCIERO",
                       o.order_id as "ORDEN", 
                       o.task_type_id ||' : '|| initcap(tt.description) as "TIPO DE TRABAJO",
                       o.order_status_id ||' : '|| oe.description as "ESTADO",
                       sum(nvl(cc.cucosacu,0)) as "SALDO PENDIENTE",
                       case when o.task_type_id in (select task_type_id from task_type_parameter) then 'Si'
                            else 'No' end as "TIPO DE TRABAJO EN PARAMETRO"
                       from open.or_order  o
                       inner join open.or_order_status oe on oe.order_status_id = o.order_status_id
                       inner join open.or_task_type tt on tt.task_type_id = o.task_type_id
                       inner join open.or_order_activity  oa on oa.order_id = o.order_id
                       inner join open.servsusc  s on s.sesunuse = oa.product_id 
                       inner join open.cuencobr  cc on cc.cuconuse = oa.product_id 
                       where o.order_status_id in (5)
                       and not exists (select null from open.ldc_susp_persecucion  sp
                                       where sp.susp_persec_order_id = o.order_id)
                       and not exists (select null from open.or_related_order 
                                       where or_related_order.related_order_id = o.order_id)                        
                       and o.task_type_id in (select task_type_id from task_type_parameter)
                       and s.sesunuse = 7057694
                       group by o.order_id, s.sesuesco, s.sesuesfn, o.order_status_id ||' : '|| oe.description, 
                                o.task_type_id ||' : '|| initcap(tt.description), oa.product_id,
                                o.task_type_id
)
select * 
from order_orcom;
