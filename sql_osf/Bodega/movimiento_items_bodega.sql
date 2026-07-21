SELECT gis.id_items_seriado,
       gis.items_id || ' - ' || gi.description item,
       gis.serie,
       gis.estado_tecnico,
       gis.id_items_estado_inv || ' - ' || giei.descripcion ESTADO_SERIADO,
       gis.costo,
       gis.subsidio,
       gis.propiedad || ' - ' ||
       decode(gis.propiedad,
              'E',
              '(E)MPRESA',
              'T',
              '(T)ERCERO',
              'C',
              'TRAIDO POR (C)LIENTE',
              'V',
              '(V)ENDIDO AL CLIENTE') PROPIEDAD,
       gis.fecha_ingreso,
       gis.fecha_salida,
       gis.fecha_reacon,
       gis.fecha_baja,
       gis.fecha_garantia,
       gis.operating_unit_id,
       gis.numero_servicio,
       gis.subscriber_id,
       a.uni_item_bala_mov_id,
       a.items_id,
       a.operating_unit_id,
       a.item_moveme_caus_id,
       a.movement_type || ' - ' ||
       decode(a.movement_type,
              'I',
              'I:[AUMENTA]',
              'D',
              'D:[DISMINUYE]',
              'N',
              'N:[NEUTRO]') TIPO_MOVIMIENTO,
       a.amount,
       a.comments,
       a.move_date,
       a.terminal,
       a.user_id,
       a.support_document,
       a.target_oper_unit_id,
       a.total_value,
       a.id_items_documento,
       a.id_items_seriado,
       a.id_items_estado_inv || ' - ' || gieim.descripcion ESTADO_DESTINO_INVENTARIO,
       a.valor_venta,
       a.init_inv_stat_items || ' - ' || gieis.descripcion ESTADO_NICIAL_INVENTARIO
  FROM open.or_uni_item_bala_mov a,
       open.ge_items_seriado     gis,
       OPEN.GE_ITEMS_ESTADO_INV  giei,
       OPEN.GE_ITEMS_ESTADO_INV  gieim,
       OPEN.GE_ITEMS_ESTADO_INV  gieis,
       open.ge_items             gi
 WHERE 1 = 1
   --and a.movement_type = 'N'
   --AND a.item_moveme_caus_id IN (20, 6)
      --AND a.support_document = ' '
   and a.operating_unit_id in (1773,3979)
   and a.target_oper_unit_id in (1773,3979)
   and gis.id_items_seriado = a.id_items_seriado
      --and gis.operating_unit_id != 799
   and gis.id_items_estado_inv = giei.id_items_estado_inv
   and a.id_items_estado_inv = gieim.id_items_estado_inv
   and a.init_inv_stat_items = gieis.id_items_estado_inv
   and gi.items_id = a.items_id
   and gis.serie = 'K-126641-24'
 order by a.move_date desc;
