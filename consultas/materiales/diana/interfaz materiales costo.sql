SELECT ot.order_id numero_orden, 
       open.ldci_pkinterfazactas.fvaGetCuGaCoClasi(o.order_id) cuenta,
       DECODE(SIGN(Sum(OT.Value)), 1, 'D', 'C') SIGNOS,
       Abs(Sum(Decode(o.charge_status,
                      3,
                      (OT.Value),
                      ((OT.Value + (OT.Value * 0.16)))))) VALOR,
       (select GEO_LOCA_FATHER_ID
          from open.ge_geogra_location
         WHERE GEOGRAP_LOCATION_ID = ad.geograp_location_id) depto,
       (select l.geograp_location_id||'-'||l.description from open.ge_geogra_location l where l.geograp_location_id=ad.geograp_location_id)  localidad,
       (select t.task_type_id||'-'||t.description
       from open.or_task_type t
       where t.task_type_id=
       (Decode(open.ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id),
              0,
              O.task_type_id,
              open.ldci_pkinterfazactas.fnuGetTipoTrab(o.order_id)))) tipotrabajo,
       gi.item_classif_id ,
       ot.items_id item,
       (select description from OPEN.ge_items where items_id = ot.items_id) descritem,
        open.ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id) clasificador,
       o.charge_status ESTADO
  FROM open.OR_ORDER          O,
       open.OR_ORDER_ITEMS    OT,
       open.GE_ITEMS          GI,
       open.or_order_activity orac,
       open.ab_address        ad,
       open.or_operating_unit ou
 WHERE Trunc(O.LEGALIZATION_DATE) BETWEEN ('01/feb/2015') AND
       ('28/feb/2015')
   AND OT.ORDER_ID = O.ORDER_ID
   AND OT.VALUE <> 0
   AND GI.ITEMS_ID = OT.ITEMS_ID
   AND GI.ITEM_CLASSIF_ID IN
       (SELECT item_classif_id
          FROM open.ge_item_classif
         WHERE ',' || ',8,21,' || ',' LIKE '%,' || item_classif_id || ',%')
   and o.order_id = orac.order_id
   and orac.address_id = ad.address_id
   AND ou.OPERATING_UNIT_ID = o.operating_unit_id
--  AND ou.es_externa = 'N'
--  AND o.order_id = 3673219
 GROUP BY ot.order_id,
          open.ldci_pkinterfazactas.fvaGetCuGaCoClasi(o.order_id),
          ad.geograp_location_id,
          O.task_type_id,
          ot.items_id,
          gi.item_classif_id,
          open.ldci_pkinterfazactas.fvaGetClasifi(O.task_type_id),
          ot.items_id,
          o.charge_status,
          o.order_id
