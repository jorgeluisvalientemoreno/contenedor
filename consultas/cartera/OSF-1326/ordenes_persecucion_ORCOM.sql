with task_type_parameter as (select to_number(regexp_substr(ldc_bcConsGenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','TIPOS_TRABAJO_PERSECUCION'), '[^,]+', 1, level)) as task_type_id
                             from dual
                             connect by regexp_substr(ldc_bcConsGenerales.fsbValorColumna('OPEN.LD_PARAMETER','VALUE_CHAIN','PARAMETER_ID','TIPOS_TRABAJO_PERSECUCION'), '[^,]+', 1, level) is not null),
order_orcom as (select or_order.order_id as "ORDEN", 
                       or_order.order_status_id ||' : '|| or_order_status.description as "ESTADO",
                       or_order.task_type_id ||' : '|| initcap(or_task_type.description) as "TIPO DE TRABAJO",
                       or_order_activity.product_id as "PRODUCTO",
                       sum(nvl(cuencobr.cucosacu,0)) as "SALDO PENDIENTE",
                       case when or_order.task_type_id in (select task_type_id from task_type_parameter) then 'Si'
                            else 'No' end as "TIPO DE TRABAJO EN PARAMETRO"
                       from open.or_order
                       inner join open.or_order_status on or_order_status.order_status_id = or_order.order_status_id
                       inner join open.or_task_type on or_task_type.task_type_id = or_order.task_type_id
                       inner join open.or_order_activity on or_order_activity.order_id = or_order.order_id
                       inner join open.cuencobr on cuencobr.cuconuse = or_order_activity.product_id 
                       where or_order.order_status_id in (0,5)
                       and not exists (select null from open.ldc_susp_persecucion
                                       where ldc_susp_persecucion.susp_persec_order_id = or_order.order_id)
                       and not exists (select null from open.or_related_order
                                       where or_related_order.related_order_id = or_order.order_id)                        
                       and or_order.task_type_id in (select task_type_id from task_type_parameter)
                       group by or_order.order_id, or_order.order_status_id ||' : '|| or_order_status.description, 
                                or_order.task_type_id ||' : '|| initcap(or_task_type.description), or_order_activity.product_id,
                                or_order.task_type_id
)
select * 
from order_orcom;