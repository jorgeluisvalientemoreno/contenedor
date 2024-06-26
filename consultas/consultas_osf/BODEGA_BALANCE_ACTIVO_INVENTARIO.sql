select (select gi.items_id || ' - ' || gi.description
          from open.ge_items gi
         where gi.items_id = a.items_id) Item,
       (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = a.operating_unit_id) unidad_operativa,
       a.quota,
       a.balance,
       a.total_costs,
       a.occacional_quota,
       a.transit_in,
       a.transit_out
  from open.or_ope_uni_item_bala a
 where a.operating_unit_id = 4247
   and a.items_id = 10004070;

select a.id_items_seriado,
       a.items_id,
       a.serie,
       a.estado_tecnico,
       (select b.id_items_estado_inv || ' - ' || b.descripcion
          from OPEN.GE_ITEMS_ESTADO_INV b
         where b.id_items_estado_inv = a.id_items_estado_inv) Estado_Inventario,
       a.costo,
       a.subsidio,
       a.propiedad,
       a.fecha_ingreso,
       a.fecha_salida,
       a.fecha_reacon,
       a.fecha_baja,
       a.fecha_garantia,
       a.operating_unit_id,
       a.numero_servicio,
       a.subscriber_id
  from open.ge_items_seriado a
 where a.serie in ('MA-1909',
                   'MA-1912',
                   'MA-1936',
                   'MA-1907',
                   'MA-1901',
                   'MA-1917',
                   'MA-1898',
                   'MA-1900',
                   'MA-1902',
                   'MA-1822',
                   'MA-1913',
                   'MA-1911',
                   'MA-1899',
                   'MA-1914',
                   'MA-1903')
   --and a.operating_unit_id not in 4247
   and a.items_id = 10004070
      --and a.serie in ('J-51807-19')
   and (a.operating_unit_id = 4247 or a.operating_unit_id is null);

select *
  from open.ldc_inv_ouib a
 where a.operating_unit_id = 4247
   and a.items_id = 10004070;

select *
  from open.ldc_act_ouib a
 where a.operating_unit_id = 4247
   and a.items_id = 10004070;

select a.uni_item_bala_mov_id,
       (select gi.items_id || ' - ' || gi.description
          from open.ge_items gi
         where gi.items_id = a.items_id) Item,
       (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = a.operating_unit_id) unidad_operativa_origen,
       (select b.item_moveme_caus_id || ' - ' || b.description
          from OPEN.OR_ITEM_MOVEME_CAUS b
         where b.item_moveme_caus_id = a.item_moveme_caus_id) CODIGO_CAUSA_MOVIMIENTO_ITEM,
       decode(a.movement_type,
              'I',
              'I - Aumenta',
              'D',
              'D - Disminuye',
              'N',
              'N - Neutro') Tipo_Movimiento,
       a.amount Cantidad,
       a.comments Comentario,
       a.move_date Fecha_Movimiento,
       a.terminal,
       a.user_id,
       a.support_document Documento_Soporte,
       (select oou.operating_unit_id || ' - ' || oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = a.target_oper_unit_id) unidad_operativa_destino,
       a.total_value,
       a.id_items_documento DOC_RELACIONADO_AL_DOCUMENTO,
       a.id_items_seriado Item_Seriado,
       (select c.id_items_estado_inv || ' - ' || c.descripcion
          from OPEN.GE_ITEMS_ESTADO_INV c
         where c.id_items_estado_inv = a.id_items_estado_inv) ESTADO_FINAL_INVENTARIO,
       a.valor_venta,
       (select d.id_items_estado_inv || ' - ' || d.descripcion
          from OPEN.GE_ITEMS_ESTADO_INV d
         where d.id_items_estado_inv = a.init_inv_stat_items) ESTADO_INICIAL_INVENTARIO
  from open.or_uni_item_bala_mov a
 where a.id_items_seriado in (2354314)
 order by a.id_items_seriado desc, a.move_date desc;

/*
select *
  from (select a.uni_item_bala_mov_id,
               (select gi.items_id || ' - ' || gi.description
                  from open.ge_items gi
                 where gi.items_id = a.items_id) Item,
               (select oou.operating_unit_id || ' - ' || oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = a.operating_unit_id) unidad_operativa_origen,
               (select b.item_moveme_caus_id || ' - ' || b.description
                  from OPEN.OR_ITEM_MOVEME_CAUS b
                 where b.item_moveme_caus_id = a.item_moveme_caus_id) CODIGO_CAUSA_MOVIMIENTO_ITEM,
               decode(a.movement_type,
                      'I',
                      'I - Aumenta',
                      'D',
                      'D - Disminuye',
                      'N',
                      'N - Neutro') Tipo_Movimiento,
               a.amount Cantidad,
               a.comments Comentario,
               a.move_date Fecha_Movimiento,
               a.terminal,
               a.user_id,
               a.support_document Documento_Soporte,
               (select oou.operating_unit_id || ' - ' || oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = a.target_oper_unit_id) unidad_operativa_destino,
               a.total_value,
               a.id_items_documento DOC_RELACIONADO_AL_DOCUMENTO,
               a.id_items_seriado Item_Seriado,
               (select c.id_items_estado_inv || ' - ' || c.descripcion
                  from OPEN.GE_ITEMS_ESTADO_INV c
                 where c.id_items_estado_inv = a.id_items_estado_inv) ESTADO_FINAL_INVENTARIO,
               a.valor_venta,
               (select d.id_items_estado_inv || ' - ' || d.descripcion
                  from OPEN.GE_ITEMS_ESTADO_INV d
                 where d.id_items_estado_inv = a.init_inv_stat_items) ESTADO_INICIAL_INVENTARIO
          from open.or_uni_item_bala_mov a
         where a.movement_type = 'I'
           and a.operating_unit_id = 4247
           and a.items_id = 10004070
           and a.id_items_seriado = 2354314
        union all
        select a.uni_item_bala_mov_id,
               (select gi.items_id || ' - ' || gi.description
                  from open.ge_items gi
                 where gi.items_id = a.items_id) Item,
               (select oou.operating_unit_id || ' - ' || oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = a.operating_unit_id) unidad_operativa_origen,
               (select b.item_moveme_caus_id || ' - ' || b.description
                  from OPEN.OR_ITEM_MOVEME_CAUS b
                 where b.item_moveme_caus_id = a.item_moveme_caus_id) CODIGO_CAUSA_MOVIMIENTO_ITEM,
               decode(a.movement_type,
                      'I',
                      'I - Aumenta',
                      'D',
                      'D - Disminuye',
                      'N',
                      'N - Neutro') Tipo_Movimiento,
               a.amount Cantidad,
               a.comments Comentario,
               a.move_date Fecha_Movimiento,
               a.terminal,
               a.user_id,
               a.support_document Documento_Soporte,
               (select oou.operating_unit_id || ' - ' || oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = a.target_oper_unit_id) unidad_operativa_destino,
               a.total_value,
               a.id_items_documento DOC_RELACIONADO_AL_DOCUMENTO,
               a.id_items_seriado Item_Seriado,
               (select c.id_items_estado_inv || ' - ' || c.descripcion
                  from OPEN.GE_ITEMS_ESTADO_INV c
                 where c.id_items_estado_inv = a.id_items_estado_inv) ESTADO_FINAL_INVENTARIO,
               a.valor_venta,
               (select d.id_items_estado_inv || ' - ' || d.descripcion
                  from OPEN.GE_ITEMS_ESTADO_INV d
                 where d.id_items_estado_inv = a.init_inv_stat_items) ESTADO_INICIAL_INVENTARIO
          from open.or_uni_item_bala_mov a
         where a.movement_type = 'D'
           and a.operating_unit_id = 4247
           and a.items_id = 10004070
           and a.id_items_seriado = 2354314
        union all
        select a.uni_item_bala_mov_id,
               (select gi.items_id || ' - ' || gi.description
                  from open.ge_items gi
                 where gi.items_id = a.items_id) Item,
               (select oou.operating_unit_id || ' - ' || oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = a.operating_unit_id) unidad_operativa_origen,
               (select b.item_moveme_caus_id || ' - ' || b.description
                  from OPEN.OR_ITEM_MOVEME_CAUS b
                 where b.item_moveme_caus_id = a.item_moveme_caus_id) CODIGO_CAUSA_MOVIMIENTO_ITEM,
               decode(a.movement_type,
                      'I',
                      'I - Aumenta',
                      'D',
                      'D - Disminuye',
                      'N',
                      'N - Neutro') Tipo_Movimiento,
               a.amount Cantidad,
               a.comments Comentario,
               a.move_date Fecha_Movimiento,
               a.terminal,
               a.user_id,
               a.support_document Documento_Soporte,
               (select oou.operating_unit_id || ' - ' || oou.name
                  from open.or_operating_unit oou
                 where oou.operating_unit_id = a.target_oper_unit_id) unidad_operativa_destino,
               a.total_value,
               a.id_items_documento DOC_RELACIONADO_AL_DOCUMENTO,
               a.id_items_seriado Item_Seriado,
               (select c.id_items_estado_inv || ' - ' || c.descripcion
                  from OPEN.GE_ITEMS_ESTADO_INV c
                 where c.id_items_estado_inv = a.id_items_estado_inv) ESTADO_FINAL_INVENTARIO,
               a.valor_venta,
               (select d.id_items_estado_inv || ' - ' || d.descripcion
                  from OPEN.GE_ITEMS_ESTADO_INV d
                 where d.id_items_estado_inv = a.init_inv_stat_items) ESTADO_INICIAL_INVENTARIO
          from open.or_uni_item_bala_mov a
         where a.movement_type = 'N'
           and a.operating_unit_id = 4247
           and a.items_id = 10004070
           and a.id_items_seriado = 2354314)
 order by Fecha_Movimiento desc;

  select 'I', sum(a.amount)
    from open.or_uni_item_bala_mov a
   where a.movement_type = 'I'
     and a.operating_unit_id = 4247
     and a.items_id = 10004070
     and a.id_items_seriado = 2354314
  union all
  select 'D', sum(a.amount)
    from open.or_uni_item_bala_mov a
   where a.movement_type = 'D'
     and a.operating_unit_id = 4247
     and a.items_id = 10004070
     and a.id_items_seriado = 2354314
  union all
  select 'N', sum(a.amount)
    from open.or_uni_item_bala_mov a
   where a.movement_type = 'N'
     and a.operating_unit_id = 4247
     and a.items_id = 10004070
     and a.id_items_seriado = 2354314;

 --*/

SELECT *
  FROM OPEN.LDC_OSF_LDCRBAI a
 where a.cod_unid_oper = 4247
   and a.cod_item = 10004070
   and a.fec_corte >= '01/01/2022'
 order by a.fec_corte desc;
SELECT *
  FROM OPEN.ldc_osf_salbitemp a
 where a.items_id = 10004070
   and a.operating_unit_id = 4247
   and a.nuano >= 2022
 order by a.numes desc, a.nuano desc;

select *
  from open.ge_items_documento a
 where a.id_items_documento in (1352279)
 order by a.fecha desc
