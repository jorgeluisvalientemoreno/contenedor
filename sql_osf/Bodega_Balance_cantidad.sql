SELECT /*+  ORDERED 
          INDEX(GE_ITEMS_TIPO PK_GE_ITEMS_TIPO) 
            INDEX(GE_ITEMS_SERIADO IDX_GE_ITEMS_SERIADO_01)
            INDEX(GE_ITEMS IX_GE_ITEMS13)
        */
 (GE_ITEMS.ITEMS_ID || ' - ' || GE_ITEMS.description) ITEMS_ID,
 count(1) cantidad,
 sum(GE_ITEMS_SERIADO.COSTO) COSTO
  FROM open.GE_ITEMS_SERIADO,
       open.GE_ITEMS,
       open.GE_ITEMS_TIPO,
       open.OR_ITEM_PATTERN
 WHERE GE_ITEMS_SERIADO.ITEMS_ID = GE_ITEMS.ITEMS_ID
   AND GE_ITEMS.ID_ITEMS_TIPO = GE_ITEMS_TIPO.ID_ITEMS_TIPO
   AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
       OR_ITEM_PATTERN.ID_ITEMS_SERIADO(+)
   and GE_ITEMS_SERIADO.Items_Id = 10004070
   and GE_ITEMS_SERIADO.Operating_Unit_Id = 4247
 group by (GE_ITEMS.ITEMS_ID || ' - ' || GE_ITEMS.description);
   
SELECT /*+  ORDERED 
          INDEX(GE_ITEMS_TIPO PK_GE_ITEMS_TIPO) 
            INDEX(GE_ITEMS_SERIADO IDX_GE_ITEMS_SERIADO_01)
            INDEX(GE_ITEMS IX_GE_ITEMS13)
        */
 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO ID_ITEMS_SERIADO,
 decode(GE_ITEMS_SERIADO.ITEMS_ID,
        null,
        null,
        (select gi.ITEMS_ID || ' - ' || gi.description
           from open.ge_items gi
          where gi.items_id = GE_ITEMS_SERIADO.ITEMS_ID)) ITEMS_ID,
 decode(GE_ITEMS.ID_ITEMS_TIPO,
        null,
        null,
        (select git.ID_ITEMS_TIPO || ' - ' || git.Descripcion
           from open.GE_ITEMS_TIPO git
          where git.id_items_tipo = GE_ITEMS.ID_ITEMS_TIPO)) ID_ITEMS_TIPO,
 (select GE_ITEMS.ITEM_CLASSIF_ID || ' - ' || gic.Description
    from open.GE_ITEM_CLASSIF gic
   where gic.item_classif_id = GE_ITEMS.ITEM_CLASSIF_ID) ID_ITEMS_CLASIF,
 GE_ITEMS_SERIADO.SERIE SERIE,
 decode(GE_ITEMS_SERIADO.ESTADO_TECNICO,
        'N',
        'Nuevo',
        'R',
        'Reacondicionado',
        'D',
        'Da¿ado') ESTADO_TECNICO,
 decode(GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV,
        null,
        null,
        (select gis.ID_ITEMS_ESTADO_INV || ' - ' || gis.descripcion
           from open.GE_ITEMS_ESTADO_INV gis
          where gis.id_items_estado_inv =
                GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV)) ID_ITEMS_ESTADO_INV,
 GE_ITEMS_SERIADO.COSTO COSTO,
 GE_ITEMS_SERIADO.SUBSIDIO SUBSIDIO,
 decode(GE_ITEMS_SERIADO.PROPIEDAD,
        'E',
        'Empresa',
        'T',
        'Tercero',
        'C',
        'Cliente',
        'V',
        'Vendido al cliente') PROPIEDAD,
 GE_ITEMS_SERIADO.FECHA_INGRESO FECHA_INGRESO,
 GE_ITEMS_SERIADO.FECHA_SALIDA FECHA_SALIDA,
 GE_ITEMS_SERIADO.FECHA_REACON FECHA_REACON,
 decode(GE_ITEMS_SERIADO.FECHA_GARANTIA,
        null,
        (SELECT /*+ INDEX (ge_item_warranty IDX_GE_ITEM_WARRANTY01)*/
          max(ge_item_warranty.final_warranty_date)
           FROM open.ge_item_warranty
          WHERE ge_item_warranty.serie = GE_ITEMS_SERIADO.Serie
            AND ge_item_warranty.is_active = 'Y'),
        GE_ITEMS_SERIADO.FECHA_GARANTIA) FECHA_GARANTIA,
 decode(GE_ITEMS_SERIADO.OPERATING_UNIT_ID,
        null,
        null,
        (select oou.OPERATING_UNIT_ID || ' - ' || oou.name
           from open.or_operating_unit oou
          where oou.operating_unit_id = GE_ITEMS_SERIADO.OPERATING_UNIT_ID)) OPERATING_UNIT_ID,
 (select NUMERO_SERVICIO
    FROM open.GE_EMPAQUETAMIENTO
   WHERE GE_EMPAQUETAMIENTO.id_items_seriado =
         GE_ITEMS_SERIADO.id_items_seriado) NUMERO_SERVICIO,
 (select VALID_UNTIL
    FROM open.OR_ITEM_PATTERN
   WHERE OR_ITEM_PATTERN.id_items_seriado =
         ge_items_seriado.id_items_seriado
     AND OR_ITEM_PATTERN.valid_until >= trunc(sysdate)) VALID_UNTIL,
 (select b.SERIE
    FROM open.GE_ASSO_SERIAL_ITEMS a, open.GE_ITEMS_SERIADO b
   WHERE a.SERIAL_ITEMS_ID = b.id_items_seriado
     AND a.asso_serial_items_id = GE_ITEMS_SERIADO.id_items_seriado) SERIAL_ITEMS,
 decode(GE_ITEMS_SERIADO.SUBSCRIBER_ID,
        null,
        null,
        (select gs.identification
           from open.GE_subscriber gs
          where gs.subscriber_id = GE_ITEMS_SERIADO.SUBSCRIBER_ID)) SUBSCRIBER_ID
  FROM open.GE_ITEMS_SERIADO,
       open.GE_ITEMS,
       open.GE_ITEMS_TIPO,
       open.OR_ITEM_PATTERN
 WHERE GE_ITEMS_SERIADO.ITEMS_ID = GE_ITEMS.ITEMS_ID
   AND GE_ITEMS.ID_ITEMS_TIPO = GE_ITEMS_TIPO.ID_ITEMS_TIPO
   AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
       OR_ITEM_PATTERN.ID_ITEMS_SERIADO(+)
   and GE_ITEMS_SERIADO.Items_Id = 10004070
   and GE_ITEMS_SERIADO.Operating_Unit_Id = 4247;

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

select *
  from open.ldc_inv_ouib a
 where a.operating_unit_id = 4247
   and a.items_id = 10004070;

select *
  from open.ldc_act_ouib a
 where a.operating_unit_id = 4247
   and a.items_id = 10004070;

--select * from open.ge_items_seriado gis where gis.serie = 'C-77132155-22'
