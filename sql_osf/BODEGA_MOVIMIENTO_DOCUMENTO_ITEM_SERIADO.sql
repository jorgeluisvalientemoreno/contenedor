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
   and a.movement_type = 'N'
   AND a.item_moveme_caus_id IN (20, 6)
      --AND a.support_document = ' '
   and a.operating_unit_id = 4559
   and a.target_oper_unit_id = 4560
   and gis.id_items_seriado = a.id_items_seriado
      --and gis.operating_unit_id != 799
   and gis.id_items_estado_inv = giei.id_items_estado_inv
   and a.id_items_estado_inv = gieim.id_items_estado_inv
   and a.init_inv_stat_items = gieis.id_items_estado_inv
   and gi.items_id = a.items_id
 order by a.move_date asc;

select *
  from open.ge_items_documento d
 where d.id_items_documento in (1339611, 1378953)
--and d.estado = 'A'
;
select *
  from open.or_uni_item_bala_mov m
 where m.id_items_documento in (1378953, 1339611)
   and m.movement_type = 'N'
   and m.id_items_seriado in (2506005, 2405295);
