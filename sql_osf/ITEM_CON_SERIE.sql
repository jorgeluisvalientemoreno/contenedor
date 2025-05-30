select gis.id_items_seriado SERIADO,
       GI.ITEMS_ID || ' - ' || GI.DESCRIPTION Item,
       gis.serie SERIE,
       decode(gis.estado_tecnico,
              'N',
              'N - NUEVO',
              'R',
              'R - REACONDICIONADO',
              'D',
              'D - DAÑADO',
              gis.estado_tecnico) estado_tecnico,
       gis.id_items_estado_inv || ' - ' || giei.descripcion Estado_Inventario,
       DECODE(gis.propiedad,
              'E',
              'E - EMPRESA',
              'T',
              'T - TERCERO',
              'C',
              'C - TRAIDO POR CLIENTE',
              'V',
              'V - VENDIDO AL CLIENTE',
              gis.propiedad) Propietario,
       gis.fecha_ingreso fecha_ingreso,
       gis.fecha_salida fecha_salida,
       gis.fecha_reacon fecha_reacondicionado,
       gis.fecha_baja fecha_baja,
       gis.fecha_garantia fecha_garantia,
       gis.operating_unit_id || ' - ' || UNIDADASOCIADA.NAME unidad_asociada,
       gis.subscriber_id || ' - ' || trim(gs.subscriber_name) || ' ' ||
       trim(gs.subs_last_name) Cliente
  from open.GE_ITEMS GI
  left join open.ge_items_seriado gis
    on gis.items_id = GI.items_id
  left join open.GE_ITEMS_ESTADO_INV giei
    on giei.id_items_estado_inv = gis.id_items_estado_inv
  left join open.or_operating_unit UNIDADASOCIADA
    on UNIDADASOCIADA.OPERATING_UNIT_ID = gis.operating_unit_id
  left join OPEN.GE_SUBSCRIBER gs
    on gs.subscriber_id = gis.subscriber_id
 where gi.items_id = 10006967
-- and gis.id_items_seriado = 1951115
--gis.serie = 'IT-3401094205-12'
;
