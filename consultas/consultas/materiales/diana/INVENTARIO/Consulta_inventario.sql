SELECT b.items_id, it.description, b.operating_unit_id, UO.NAME nombre, CASE NVL(uo.contractor_id,0) WHEN 0 THEN 'N' ELSE 'S' END Es_contratista,  b.total_costs costo_general, b.balance balance_general, b.transit_in transito_entrada, b.transit_out transito_salida,  i.total_costs costo_inventario, i.balance balance_inventario, i.transit_in transito_entrada_inventario, i.transit_out transito_salida_inventario, a.total_costs costo_activo, a.balance balance_activo, a.transit_in transito_entrada_activo, a.transit_out transito_salida_activo,
--b.total_costs - NVL(NVL(DECODE(a.total_costs, 0,null,a.total_costs), i.total_costs), b.total_costs) diferencia_costos, b.balance - NVL(NVL(a.balance, i.balance), b.balance) diferencia_balance, b.transit_in - NVL(NVL(a.transit_in, i.transit_in), b.transit_in) diferencia_transito_in, b.transit_out - NVL(NVL(a.transit_out, i.transit_out), b.transit_out) diferencia_transito_out
b.total_costs - NVL(a.total_costs,0) - NVL(i.total_costs,0) diferencia_costo, b.balance - NVL(a.balance,0) - NVL(i.balance ,0) diferencia_balance, b.transit_in - NVL(a.transit_in,0) - NVL(i.transit_in,0) diferencia_transito_in, b.transit_out - NVL(a.transit_out,0) - NVL(i.transit_out,0) diferencia_transito_salida
FROM open.OR_OPE_UNI_ITEM_BALA b, open.ldc_inv_ouib i, open.ldc_act_ouib a, open.ge_items it, open.or_operating_unit uo 
WHERE b.items_id = it.items_id AND  uo.operating_unit_id = b.operating_unit_id AND
b.operating_unit_id = i.operating_unit_id(+) AND i.items_id(+) = b.items_id AND b.operating_unit_id = a.operating_unit_id(+) AND a.items_id(+) = b.items_id 
AND b.operating_unit_id = 1533 AND b.items_id  IN(10000369);
-------------------------
SELECT b.items_id, it.description, b.operating_unit_id, UO.NAME nombre, CASE NVL(uo.contractor_id,0) WHEN 0 THEN 'N' ELSE 'S' END Es_contratista,  b.total_costs costo_general, b.balance balance_general, b.transit_in transito_entrada, b.transit_out transito_salida,  i.total_costs costo_inventario, i.balance balance_inventario, i.transit_in transito_entrada_inventario, i.transit_out transito_salida_inventario, a.total_costs costo_activo, a.balance balance_activo, a.transit_in transito_entrada_activo, a.transit_out transito_salida_activo,
--b.total_costs - NVL(NVL(DECODE(a.total_costs, 0,null,a.total_costs), i.total_costs), b.total_costs) diferencia_costos, b.balance - NVL(NVL(a.balance, i.balance), b.balance) diferencia_balance, b.transit_in - NVL(NVL(a.transit_in, i.transit_in), b.transit_in) diferencia_transito_in, b.transit_out - NVL(NVL(a.transit_out, i.transit_out), b.transit_out) diferencia_transito_out
b.total_costs - NVL(a.total_costs,0) - NVL(i.total_costs,0) diferencia_costo, b.balance - NVL(a.balance,0) - NVL(i.balance ,0) diferencia_balance, b.transit_in - NVL(a.transit_in,0) - NVL(i.transit_in,0) diferencia_transito_in, b.transit_out - NVL(a.transit_out,0) - NVL(i.transit_out,0) diferencia_transito_salida
FROM open.OR_OPE_UNI_ITEM_BALA b, open.ldc_inv_ouib i, open.ldc_act_ouib a, open.ge_items it, open.or_operating_unit uo 
WHERE b.items_id = it.items_id AND  uo.operating_unit_id = b.operating_unit_id AND
b.operating_unit_id = i.operating_unit_id(+) AND i.items_id(+) = b.items_id AND b.operating_unit_id = a.operating_unit_id(+) AND a.items_id(+) = b.items_id AND 
(b.items_id >=10000000 AND b.items_id NOT IN(100003024,100003025,100003026,100003027,10000593,
10001230,
10001233,
10001234,
10001300,
10001683,
10002011,
10002017,
10003538,
10003810,
10003883,
10004070,
10004071,
10004145,
10004146,
10006391,
10001666)) AND
(b.total_costs - NVL(a.total_costs,0) - NVL(i.total_costs,0) <> 0 OR b.balance - NVL(a.balance,0) - NVL(i.balance ,0) <> 0 --OR b.transit_in - NVL(a.transit_in,0) - NVL(i.transit_in,0) <>0 OR b.transit_out - NVL(a.transit_out,0) - NVL(i.transit_out,0) <> 0
)
;

--------------
SELECT distinct task_type_id FROM open.or_uni_item_bala_mov m, open.ge_items_documento d, open.or_order o WHERE d.documento_externo = O.order_id AND  m.items_id In(10000593,
10001230,
10001233,
10001234,
10001300,
10001683,
10002011,
10002017,
10003538,
10003810,
10003883,
10004070,
10004071,
10004145,
10004146,
10006391,
10001666
)
AND m.item_moveme_caus_id = 4 AND m.id_items_documento = d.id_items_documento; 

SELECT * FROM open.ldc_tt_tb WHERE task_type_id IN(12152,12143,12150,10534,12153);

SELECT * FROM open.or_task_type WHERE task_type_id IN(12152,12143,12150,10534,12153);

SELECT * FROM open.ldc_inv_ouib WHERE items_id IN(SELECT distinct items_id FROM open.ge_items_seriado);

SELECT * FROM open.ldc_act_ouib WHERE items_id IN(SELECT distinct items_id FROM open.ge_items_seriado);

SELECT *  FROM open.ldc_inv_ouib WHERE items_id <=10000000 OR items_id IN(100003024,100003025,100003026,100003027);

SELECT * FROM open.ge_items WHERe items_id IN(10000593,10001230,
10001233,
10001234,
10001300,
10001683,
10002011,
10002017,
10003538,
10003810,
10003883,
10004070,
10004071,
10004145,
10004146,
10006391,
10001666,
10002017,
10004145,
10001233,
10001230,
10004070,
10004071
);

SELECT items_id
FROM open.ge_items WHERE item_classif_id = 21 AND id_items_tipo = 20;

SELECT open.DALD_PARAMETER.fsbGetValue_Chain('COD_TIP_TRAB_CAM_MED', NULL) FROM dual;

