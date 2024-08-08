SELECT uoo.operating_unit_id codigo_uo, uoo.name nombre_uo, i.items_id item,  i.description nombre_item, DECODE(m.movement_type,  'D', m.amount*-1, 'I', m.amount) CANTIDAD, DECODE(m.movement_type, 'D', m.total_value*-1, 'I', m.total_value) valor, cm.item_moveme_caus_id ||'-'|| cm.description causa, m.move_date fecha_movimiento,
eii.id_items_estado_inv ||'-'|| eii.descripcion estado_antes_item, eif.id_items_estado_inv ||'-'|| eif.descripcion estado_despues_item,m.id_items_seriado, s.serie
,d.id_items_documento documento_soporte, d.tipo_documento, d.causal, d.documento_externo, d.fecha, d.estado, d.comentario
,ds.id_items_documento documento_asociado, ds.tipo_documento tipo_documento_a, ds.causal causal_a, ds.documento_externo documento_externo_a, ds.fecha fecha_a, ds.estado estado_a, ds.comentario comentario_a
FROM open.or_uni_item_bala_mov m, open.ge_items i, open.or_operating_unit uoo, open.or_operating_unit uod, open.or_item_moveme_caus cm, open.ge_items_estado_inv eii, open.ge_items_estado_inv eif, open.ge_items_seriado s,
(SELECT TO_CHAR(d.id_items_documento) id_items_documento, dt.document_type_id ||'-'|| dt.description tipo_documento, c.causal_id ||'-'|| c.description causal, d.documento_externo, d.fecha, DECODE(d.estado, 'R','REGISTRADO', 'A', 'ABIERTO', 'C','CERRADO', 'E','EXPORTADO') estado, d.comentario
FROM open.ge_items_documento d, open.ge_document_type dt, open.ge_causal c
WHERE d.causal_id = c.causal_id(+) AND d.document_type_id = dt.document_type_id) d,
(SELECT TO_CHAR(d.id_items_documento) id_items_documento, dt.document_type_id ||'-'|| dt.description tipo_documento, c.causal_id ||'-'|| c.description causal, d.documento_externo, d.fecha, DECODE(d.estado, 'R','REGISTRADO', 'A', 'ABIERTO', 'C','CERRADO', 'E','EXPORTADO') estado, d.comentario
FROM open.ge_items_documento d, open.ge_document_type dt, open.ge_causal c
WHERE d.causal_id = c.causal_id(+) AND d.document_type_id = dt.document_type_id) ds 
WHERE i.items_id = m.items_id AND m.operating_unit_id = uoo.operating_unit_id AND NVL(m.target_oper_unit_id, 1) = uod.operating_unit_id AND cm.item_moveme_caus_id = m.item_moveme_caus_id AND m.init_inv_stat_items = eii.id_items_estado_inv(+) AND m.id_items_estado_inv = eif.id_items_estado_inv(+)
AND s.id_items_seriado(+) = m.id_items_seriado AND m.id_items_documento = d.id_items_documento(+) AND m.support_document = ds.id_items_documento(+) AND m.move_date <= TO_DATE('31-12-2014','dd-mm-yyyy') AND m.movement_type != 'N'
UNION ALL
SELECT
uo.operating_unit_id codigo_uo, uo.name nombre_uo, i.items_id item,  i.description nombre_item, b.balance*-1 cantidad, b.total_costs *-1 valor, 'Inventario', null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null,null
FROM open.or_ope_uni_item_bala b, open.ge_items i, open.or_operating_unit uo
WHERE b.items_id = i.items_id AND uo.operating_unit_id = b.operating_unit_id AND (b.balance != 0 OR b.total_costs != 0)
;