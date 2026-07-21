--requisiones pendientes 
select *
  from open.ldci_intemmit
 inner join open.ldci_dmitmmit
    on dmitmmit = mmitcodi
 where mmitdsap is not null
   and mmitnudo is not null
   and mmitfecr >= '01/12/2025'
   and mmitesta = 1;

--Informacion de cierre de materiales e ítems en OSF  

select op.name, sum(total_costs)
  from open.LDC_OSF_SALBITEMP o, open.or_operating_unit op
 where op.OPERATING_UNIT_ID = o.OPERATING_UNIT_ID
   and nuano = 2025
   and numes = 12
 group by op.name;

--reporte proviene del cristal ldrbai
select COD_UNID_OPER,
       (select oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = COD_UNID_OPER) DESCRIPCION_UNIDAD_OPERATIVA,
       COD_ITEM,
       (select gi.description
          from open.ge_items gi
         where gi.items_id = COD_ITEM) DESCRIPCION_ITEM,
       CANT_EXIST_BODEGA,
       COSTO_BODEGA,
       CANT_EXIST_ACTIVO,
       COST_PROM_ACTIVO,
       CANT_EXIST_INVEN,
       COST_PROM_INVEN,
       FEC_CORTE
  from open.LDC_OSF_LDCRBAI
 where fec_corte = '01/01/2026'
 order by fec_corte, COD_UNID_OPER, COD_ITEM;

--Este archivo con la consulta permite validar los movimientos y contrastarlos con los archivos 200 y 300
--Esta consulta sirve para validar los movimientos y contrastarlos con los archvios 200 y 300
-- En archivo 200 estan los movimientos de inventario (1773,1774,1775)
-- En el archivo 300 estan los movimientos de inventario (1931,1932,1933)
WITH base AS
 (SELECT o.order_id,
         oi.items_id,
         o.operating_unit_id,
         NULL                 item_moveme_caus_id,
         NULL                 movement_type,
         oi.legal_item_amount amount,
         o.legalization_date  move_date,
         oi.value             total_value
    FROM open.or_order o, open.or_order_items oi, open.ge_items g
   WHERE oi.order_id = o.order_id
     AND g.items_id = oi.items_id
     AND trunc(legalization_date) between '01/12/2025' and '31/12/2025'
     AND item_classif_id in (3, 8, 21)
     AND o.order_status_id = 8
     AND oi.value != 0
     and nvl(out_, 'Y') = 'Y')
SELECT items_id,
       operating_unit_id,
       item_moveme_caus_id,
       movement_type,
       amount,
       move_date,
       decode(movement_type, 'D', total_value * -1, total_value) total_value
  FROM open.or_uni_item_bala_mov
 WHERE movement_type in ('I', 'D')
   and trunc(move_date) between '01/12/2025' and '31/12/2025'
   and item_moveme_caus_id in (15, 16)
   AND target_oper_unit_id in (1931, 1932, 1933)
   AND total_value > 0
UNION
SELECT items_id,
       operating_unit_id,
       item_moveme_caus_id,
       movement_type,
       amount,
       move_date,
       decode(movement_type, 'D', total_value * -1, total_value) total_value
  FROM open.or_uni_item_bala_mov
 WHERE movement_type in ('I', 'D')
   and item_moveme_caus_id in (20)
   AND target_oper_unit_id in (1931, 1932, 1933)
   AND (trunc(move_date) between '01/12/2025' and '31/12/2025' or exists
        (select null
           from open.ldci_intemmit
          where trunc(mmitfecr) between '01/12/2025' and '31/12/2025'
            and mmittimo = 'Z02'
            and mmitnudo = to_char(id_items_documento)))
   AND total_value > 0
UNION
SELECT bs.items_id,
       operating_unit_id,
       item_moveme_caus_id,
       movement_type,
       amount,
       move_date,
       total_value + nvl(round(lia.costo_final, 0), 0) total_value
  FROM base bs, open.ldc_log_items_modif_sin_acta lia
 WHERE bs.order_id = lia.orden_id
   AND bs.items_id = lia.item_id
   AND nvl(lia.fecha_modif, '01/01/1900') =
       (select nvl(max(l2.fecha_modif), '01/01/1900')
          from open.ldc_log_items_modif_sin_acta l2
         where lia.orden_id = l2.orden_id(+)
           and lia.item_id = l2.item_id(+));

--En archivo 200 están los movimientos de inventario (1773,1774,1775)
--En el archivo 300 están los movimientos de inventario (1931,1932,1933)

-- Bsuca todas las ordenes legalizadas del ipo de trabajo 10764, que no tienen un movimiento en or_uni_item_bala_mov y que tenga alguna modificación de item atraves de aiosa, miosa
-- Sino en cuentra el movimient, se realiza un insert or_uni_item_bala_mov para que el movimiento pueda llegar a SAP a traves de la interfaz
select *
  from (with base as (select o.order_id,
                             o.task_type_id,
                             o.operating_unit_id,
                             (select c.user_id
                                from open.or_order_stat_change c
                               where c.order_id = o.order_id
                                 and c.final_status_id = 8) usuario,
                             o.legalization_date,
                             i.items_id,
                             i.description,
                             oi.legal_item_amount,
                             oi.value,
                             oi.serie,
                             oi.out_,
                             oi.serial_items_id id_items_seriado,
                             (select id_items_documento
                                from open.ge_items_documento
                               where documento_externo = to_char(o.order_id)) id_items_documento
                        from open.or_order o
                       inner join open.or_order_items oi
                          on oi.order_id = o.order_id
                         and oi.value != 0
                         and nvl(out_, 'Y') = 'Y'
                       inner join open.ge_items i
                          on i.items_id = oi.items_id
                         and i.item_classif_id in (3, 8, 21)
                       where o.order_status_id = 8
                         and o.task_type_id = 10764
                         and trunc(o.legalization_Date) <= '31/12/2025'), base2 as (select base.order_id,
                                                                                           base.task_type_id,
                                                                                           base.legalization_date,
                                                                                           base.items_id,
                                                                                           base.description,
                                                                                           base.legal_item_amount,
                                                                                           nvl(round(base.value,
                                                                                                     0),
                                                                                               0) value,
                                                                                           base.serie,
                                                                                           base.out_,
                                                                                           base.operating_unit_id,
                                                                                           base.usuario,
                                                                                           mov.id_items_documento,
                                                                                           nvl(round(mov.amount,
                                                                                                     0),
                                                                                               0) amount,
                                                                                           nvl(round(mov.total_value,
                                                                                                     0),
                                                                                               0) total_value,
                                                                                           base.id_items_seriado id_items_seriado,
                                                                                           base.id_items_documento base_id_items_documento
                                                                                      from base
                                                                                      left join (select d.id_items_documento,
                                                                                                       d.documento_externo,
                                                                                                       d.fecha,
                                                                                                       m.items_id,
                                                                                                       m.id_items_seriado,
                                                                                                       (select serie
                                                                                                          from open.ge_items_seriado s
                                                                                                         where s.id_items_seriado =
                                                                                                               m.id_items_seriado) serie,
                                                                                                       m.amount,
                                                                                                       m.total_value
                                                                                                  from open.ge_items_documento d
                                                                                                 inner join open.or_uni_item_bala_mov m
                                                                                                    on m.id_items_documento =
                                                                                                       d.id_items_documento
                                                                                                 where d.document_type_id = 118) mov
                                                                                        on mov.documento_externo =
                                                                                           to_char(base.order_id)
                                                                                       and mov.items_id =
                                                                                           base.items_id
                                                                                       and nvl(mov.serie,
                                                                                               '-') =
                                                                                           nvl(base.serie,
                                                                                               '-')
                                                                                       and nvl(mov.id_items_seriado,
                                                                                               -1) =
                                                                                           nvl(base.id_items_seriado,
                                                                                               -1))
         select bs.*,
                nvl(round(lia.cantidad_final, 0), 0) cantidad_final,
                nvl(round(lia.costo_final, 0), 0) costo_final
           from base2 bs, open.LDC_LOG_ITEMS_MODIF_SIN_ACTA lia
          where bs.order_id = lia.orden_id(+)
            and bs.items_id = lia.item_id(+)
            and nvl(lia.fecha_modif, '01/01/1900') =
                (select nvl(max(l2.fecha_modif), '01/01/1900')
                   from open.LDC_LOG_ITEMS_MODIF_SIN_ACTA l2
                  where lia.orden_id = l2.orden_id(+)
                    and lia.item_id = l2.item_id(+))) tb_
          where abs(tb_.value - tb_.total_value - tb_.costo_final) != 0;
