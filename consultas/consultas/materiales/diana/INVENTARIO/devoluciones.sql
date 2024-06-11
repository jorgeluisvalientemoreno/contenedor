SELECT i.mmitcodi cod_interfaz, m.id_items_documento doc_osf, d.fecha fecha_osf, i.mmitdsap doc_sap, i.mmitfecr fecha_mensaje, i.mmitesta estado_interfaz,  i.mmittimo tipo_doc_sap, d.document_type_id tipo_doc_osf, d.operating_unit_id unidad_operativa_origen, d.destino_oper_uni_id unidad_operativa_destino,
m.items_id item, SUM(m.amount) cantidad_devuelta, SUM(m.total_value) valor_devuelto, i.dmitcant cantidad_aceptada, i.dmitcape cantidad_pendiente, i.dmitcoun , i.dmitcant ,i.dmitcoun * i.dmitcant valor_aceptado
FROM (SELECT a.mmitcodi, a.mmitnudo, a.mmitdsap, a.mmitfecr, a.mmitesta, a.mmittimo, b.dmititem, b.dmitcant, b.dmitcape, b.dmitcoun, b.dmitvaun  FROM open.ldci_intemmit a, open.ldci_dmitmmit b WHERE a.mmitcodi = b.dmitmmit) i, open.ge_items_documento d, open.or_uni_item_bala_mov m
WHERE 
i.mmitnudo(+) = TO_CHAR(m.id_items_documento) AND
d.destino_oper_uni_id IN(1600, 1601, 1602, 1660, 1661, 1662) AND
m.id_items_documento = d.id_items_documento AND m.movement_type = 'D' AND i.dmititem(+) = m.items_id
AND d.document_type_id = 105
AND i.mmitdsap = 4900113842
GROUP BY i.mmitcodi, m.id_items_documento, d.fecha, i.mmitdsap, i.mmitfecr, i.mmitesta, m.items_id, i.mmittimo, d.document_type_id, d.operating_unit_id, d.destino_oper_uni_id, i.dmitcant, i.dmitcape, i.dmitcoun, i.dmitvaun;

SELECT i.mmitcodi cod_interfaz, m.id_items_documento doc_osf, d.fecha fecha_osf, i.mmitdsap doc_sap, i.mmitfecr fecha_mensaje, i.mmitesta estado_interfaz,  i.mmittimo tipo_doc_sap, d.document_type_id tipo_doc_osf, d.operating_unit_id unidad_operativa_origen, d.destino_oper_uni_id unidad_operativa_destino,
m.items_id item, SUM(m.amount) cantidad_devuelta, SUM(m.total_value) valor_devuelto, i.dmitcant cantidad_aceptada, i.dmitcape cantidad_pendiente, i.dmitcoun , i.dmitcant ,i.dmitcoun * i.dmitcant valor_aceptado
FROM (SELECT a.mmitcodi, a.mmitnudo, a.mmitdsap, a.mmitfecr, a.mmitesta, a.mmittimo, b.dmititem, b.dmitcant, b.dmitcape, b.dmitcoun, b.dmitvaun  FROM open.ldci_intemmit a, open.ldci_dmitmmit b WHERE a.mmitcodi = b.dmitmmit) i, open.ge_items_documento d, open.or_uni_item_bala_mov m
WHERE 
i.mmitnudo(+) = TO_CHAR(m.id_items_documento) AND
d.destino_oper_uni_id IN(1600, 1601, 1602, 1660, 1661, 1662) AND
m.id_items_documento = d.id_items_documento AND m.movement_type = 'D' AND i.dmititem(+) = m.items_id
AND d.document_type_id = 104
GROUP BY i.mmitcodi, m.id_items_documento, d.fecha, i.mmitdsap, i.mmitfecr, i.mmitesta, m.items_id, i.mmittimo, d.document_type_id, d.operating_unit_id, d.destino_oper_uni_id, i.dmitcant, i.dmitcape, i.dmitcoun, i.dmitvaun
;


SELECT * FROM open.or_uni_item_bala_mov WHERE operating_unit_id IN(3007,1602) AND items_id =  10006337; 

SELECT * FROM open.or_uni_item_bala_mov WHERE id_items_documento IN(12902);

SELECT * FROM open.ge_items_documento WHERE id_items_documento IN(94688,94745,94679,113200,61841,94739,61842,115833,113196,35259,94690,94744);

SELECT * FROM open.ge_items_documento WHERE documento_externo IN();

SELECT * FROM open.ldci_intemmit WHERE mmitnupe IN('94688','94745','94679','113200','61841','94739','61842','115833','113196','35259','94690','94744');

SELECT * FROM open.ldci_intemmit WHERE mmitdsap ='4900113842';

SELECT * FROM Open.ldci_dmitmmit WHERE dmitmmit = 6616; 
SELECT * FROM OPen.ge_document_type;

SELECT MAX(created_date), sysdate FROM open.or_order;

SELECT * FROM open.ge_error_log WHERE error_log_id = 265872727;