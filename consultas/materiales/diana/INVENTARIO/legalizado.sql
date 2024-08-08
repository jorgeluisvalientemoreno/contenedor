--Legalizado
SELECT o.order_id doc_osf, m.items_id, o.task_type_id ||'-'|| tt.description tt, null doc_sap, o.legalization_date fecha_documento, null estado_interfaz, null tipo_doc_sap, 'Orden' tipo_doc_osf, o.operating_unit_id unidad_operativa_origen, null unidad_operativa_destino,  SUM(m.total_value) valor, 'L' Movimientos, cc.cicomes mes 
FROM open.or_uni_item_bala_mov m, open.ge_items_documento d, open.or_order o, open.or_task_type tt, open.ldc_ciercome cc
WHERE 
m.item_moveme_caus_id = 4 AND d.id_items_documento = m.id_items_documento AND to_char(o.order_id) = d.documento_externo AND tt.task_type_id = o.task_type_id
AND o.legalization_date BETWEEN cc.cicofein AND cc.cicofech
GROUP BY o.order_id, m.items_id, o.operating_unit_id, m.id_items_documento, o.legalization_date, o.task_type_id ||'-'|| tt.description, cc.cicomes
HAVING SUM(m.total_value) <> 0
;
alter session set current_schema = open;
--Interfaz
  SELECT o.order_id, ot.items_id, ot.legal_item_amount cantidad,  Abs(Sum(Decode(o.charge_status, 3, (OT.Value), ((OT.Value))))) VALOR,
        Decode(ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id),0, O.task_type_id,ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id)) tipo_trabajo, count(distinct orac.order_activity_id) cantidad_oa,
        ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id) clasificador, ldci_pkinterfazsap.fvaGetCebeNoCat(ad.geograp_location_id) centbene, cc.cicoano año, cc.cicomes mes 
    FROM open.OR_ORDER O, open.OR_ORDER_ITEMS OT, open.GE_ITEMS GI, open.or_order_activity orac, open.ab_address ad, open.or_operating_unit ou, open.ldc_ciercome cc
   WHERE Trunc(O.LEGALIZATION_DATE) BETWEEN cc.cicofein AND cc.cicofech AND cc.cicoano = 2015 --AND cc.cicomes = 9
     AND OT.ORDER_ID = O.ORDER_ID
     AND OT.VALUE <> 0
     AND GI.ITEMS_ID = OT.ITEMS_ID
     AND GI.ITEM_CLASSIF_ID IN (SELECT item_classif_id
                            FROM ge_item_classif
                           WHERE ',8,21,' LIKE
                                 '%,' || item_classif_id || ',%')
     and o.order_id = orac.order_id
     and orac.address_id = ad.address_id
     AND ou.OPERATING_UNIT_ID = o.operating_unit_id
     GROUP BY ad.geograp_location_id,O.task_type_id,ot.items_id,  o.order_id, ot.legal_item_amount, cc.cicoano, cc.cicomes;