--Agrupado por reserva
SELECT  i.mmitnudo doc_osf, i.mmitdsap doc_sap, i.mmitfecr fecha_documento, i.mmitesta estado_interfaz, i.mmittimo tipo_doc_sap, d.document_type_id tipo_doc_osf, d.operating_unit_id unidad_operativa_origen, d.destino_oper_uni_id unidad_operativa_destino,  SUM(m.total_value) valor, 'R' Movimiento
FROM open.ge_items_documento d, open.or_uni_item_bala_mov m, open.ldci_intemmit i 
WHERE m.item_moveme_caus_id = 15 AND d.id_items_documento = m.id_items_documento AND d.estado = 'C' AND d.documento_externo LIKE '49%' AND i.mmitdsap = TO_CHAR(d.documento_externo) 
GROUP BY  i.mmitnudo , i.mmitdsap , i.mmitfecr, i.mmitesta , i.mmittimo , d.operating_unit_id , d.destino_oper_uni_id, d.document_type_id;

--Con detalle por item
SELECT i.mmitcodi cod_interfaz, i.mmitnudo doc_osf, d.fecha fecha_osf, i.mmitdsap doc_sap, i.mmitfecr fecha_mensaje, i.mmitesta estado_interfaz,  i.mmittimo tipo_doc_sap, d.document_type_id tipo_doc_osf, d.operating_unit_id unidad_operativa_origen, d.destino_oper_uni_id unidad_operativa_destino,
m.items_id item, m.amount cantidad, m.total_value valor
FROM open.ge_items_documento d, open.or_uni_item_bala_mov m, open.ldci_intemmit i 
WHERE m.item_moveme_caus_id = 15 AND d.id_items_documento = m.id_items_documento AND d.estado = 'C' AND d.documento_externo LIKE '49%' AND i.mmitdsap = TO_CHAR(d.documento_externo) 

