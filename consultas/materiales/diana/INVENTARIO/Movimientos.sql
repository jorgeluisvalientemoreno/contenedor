SELECT 
 i.items_id ||'-'||i.description item, uoo.operating_unit_id ||'-'|| uoo.name UO_ORIGEN, DECODE(uod.operating_unit_id, 1, null, uod.operating_unit_id ||'-'|| uod.name) UO_DESTINO, 
cm.item_moveme_caus_id ||'-'|| cm.description causal_movimiento, m.movement_type tipo_movimiento, m.amount cantidad, DECODE(m.movement_type, 'N',null, 'D', m.amount*-1, 'I', m.amount) CANTIDAD_SIGNO, m.total_value valor, m.user_id usuario, m.move_date fecha_movimiento, eii.id_items_estado_inv ||'-'|| eii.descripcion estado_antes_item, eif.id_items_estado_inv ||'-'|| eif.descripcion estado_despues_item,m.id_items_seriado, s.serie,
d.*, ds.*
FROM open.or_uni_item_bala_mov m, open.ge_items i, open.or_operating_unit uoo, open.or_operating_unit uod, open.or_item_moveme_caus cm, open.ge_items_estado_inv eii, open.ge_items_estado_inv eif, open.ge_items_seriado s,
(SELECT TO_CHAR(d.id_items_documento) id_items_documento, dt.document_type_id ||'-'|| dt.description tipo_documento, c.causal_id ||'-'|| c.description causal, d.documento_externo, d.fecha, DECODE(d.estado, 'R','REGISTRADO', 'A', 'ABIERTO', 'C','CERRADO', 'E','EXPORTADO') estado, d.comentario
FROM open.ge_items_documento d, open.ge_document_type dt, open.ge_causal c
WHERE d.causal_id = c.causal_id(+) AND d.document_type_id = dt.document_type_id) d,
(SELECT TO_CHAR(d.id_items_documento) id_items_documento, dt.document_type_id ||'-'|| dt.description tipo_documento, c.causal_id ||'-'|| c.description causal, d.documento_externo, d.fecha, DECODE(d.estado, 'R','REGISTRADO', 'A', 'ABIERTO', 'C','CERRADO', 'E','EXPORTADO') estado, d.comentario
FROM open.ge_items_documento d, open.ge_document_type dt, open.ge_causal c
WHERE d.causal_id = c.causal_id(+) AND d.document_type_id = dt.document_type_id) ds 
WHERE i.items_id = m.items_id AND m.operating_unit_id = uoo.operating_unit_id AND NVL(m.target_oper_unit_id, 1) = uod.operating_unit_id AND cm.item_moveme_caus_id = m.item_moveme_caus_id AND m.init_inv_stat_items = eii.id_items_estado_inv(+) AND m.id_items_estado_inv = eif.id_items_estado_inv(+)
AND s.id_items_seriado(+) = m.id_items_seriado AND m.id_items_documento = d.id_items_documento(+) AND m.support_document = ds.id_items_documento(+) AND m.move_date >= TO_DATE('31-12-2014','dd-mm-yyyy')
--con valor
AND m.operating_unit_id = 3121 AND m.items_id = 10004070
;

SELECT * FROM Open.ge_items_Seriado WHERE serie ='X-3192235-15'; 