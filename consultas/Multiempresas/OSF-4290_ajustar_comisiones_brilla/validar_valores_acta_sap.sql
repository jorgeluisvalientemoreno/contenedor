--validar_valores_acta_sap
select id_items, descripcion_items, sum(valor_total)
from open.ge_detalle_Acta
where id_acta= 242215
and not exists(select null from open.ge_items i where i.items_id=id_items and i.item_classif_id=23)
group by id_items, descripcion_items
