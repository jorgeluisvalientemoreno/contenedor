select *
from open.ldc_au_cflot c
where exists(select null from open.or_order_items oi, open.ge_items i where oi.order_id=c.order_id and i.items_id=oi.items_id and i.item_classif_id in (3,8,21))
