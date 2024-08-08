--Existencias
SELECT
uo.operating_unit_id codigo_uo, uo.name nombre_uo, i.items_id item,  i.description nombre_item, b.balance*-1 cantidad, b.total_costs *-1 valor, 'Inventario'
FROM open.or_ope_uni_item_bala b, open.ge_items i, open.or_operating_unit uo
WHERE b.items_id = i.items_id AND uo.operating_unit_id = b.operating_unit_id AND (b.balance != 0 OR b.total_costs != 0)
;

