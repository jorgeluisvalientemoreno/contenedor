SELECT /*+  ORDERED 
          INDEX(GE_ITEMS_TIPO PK_GE_ITEMS_TIPO) 
            INDEX(GE_ITEMS IX_GE_ITEMS13)
        */

 GE_ITEMS_SERIADO.ID_ITEMS_SERIADO ID_ITEMS_SERIADO,
 decode(GE_ITEMS_SERIADO.ITEMS_ID,
        null,
        null,
        DAGE_ITEMS.fsbGetCode(GE_ITEMS_SERIADO.ITEMS_ID) || ' - ' ||
        DAGE_ITEMS.fsbGetDescription(GE_ITEMS_SERIADO.ITEMS_ID)) ITEMS_ID,
 decode(GE_ITEMS.ID_ITEMS_TIPO,
        null,
        null,
        GE_ITEMS.ID_ITEMS_TIPO || ' - ' ||
        DAGE_ITEMS_TIPO.fsbGetDescripcion(GE_ITEMS.ID_ITEMS_TIPO)) ID_ITEMS_TIPO,
 GE_ITEMS.ITEM_CLASSIF_ID || ' - ' ||
 DAGE_ITEM_CLASSIF.fsbGetDescription(GE_ITEMS.ITEM_CLASSIF_ID) ID_ITEMS_CLASIF,
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
        GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV || ' - ' ||
        DAGE_ITEMS_ESTADO_INV.fsbGetDescripcion(GE_ITEMS_SERIADO.ID_ITEMS_ESTADO_INV)) ID_ITEMS_ESTADO_INV,
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
           FROM ge_item_warranty
          WHERE ge_item_warranty.serie = GE_ITEMS_SERIADO.Serie
            AND ge_item_warranty.is_active = 'Y'),
        GE_ITEMS_SERIADO.FECHA_GARANTIA) FECHA_GARANTIA,
 decode(GE_ITEMS_SERIADO.OPERATING_UNIT_ID,
        null,
        null,
        GE_ITEMS_SERIADO.OPERATING_UNIT_ID || ' - ' ||
        DAOR_Operating_Unit.fsbGetName(GE_ITEMS_SERIADO.OPERATING_UNIT_ID)) OPERATING_UNIT_ID,
 (select NUMERO_SERVICIO
    FROM GE_EMPAQUETAMIENTO
   WHERE GE_EMPAQUETAMIENTO.id_items_seriado =
         GE_ITEMS_SERIADO.id_items_seriado) NUMERO_SERVICIO,
 (select VALID_UNTIL
    FROM OR_ITEM_PATTERN
   WHERE OR_ITEM_PATTERN.id_items_seriado =
         ge_items_seriado.id_items_seriado
     AND OR_ITEM_PATTERN.valid_until >= trunc(sysdate)) VALID_UNTIL,
 (select b.SERIE
    FROM GE_ASSO_SERIAL_ITEMS a, GE_ITEMS_SERIADO b
   WHERE a.SERIAL_ITEMS_ID = b.id_items_seriado
     AND a.asso_serial_items_id = GE_ITEMS_SERIADO.id_items_seriado) SERIAL_ITEMS,
 decode(GE_ITEMS_SERIADO.SUBSCRIBER_ID,
        null,
        null,
        DAGE_subscriber.fsbGetIdentification(GE_ITEMS_SERIADO.SUBSCRIBER_ID)) SUBSCRIBER_ID,
 decode(GE_BOItemsSeriado.fsbIsPattern(GE_ITEMS_SERIADO.ID_ITEMS_SERIADO),
        'Y',
        'Si',
        'No') IS_PATTERN
  FROM GE_ITEMS_SERIADO, GE_ITEMS, GE_ITEMS_TIPO, OR_ITEM_PATTERN
 WHERE GE_ITEMS.id_items_tipo = 20
   and GE_ITEMS_SERIADO.ITEMS_ID = GE_ITEMS.ITEMS_ID
   AND GE_ITEMS.ID_ITEMS_TIPO = GE_ITEMS_TIPO.ID_ITEMS_TIPO
   AND GE_ITEMS_SERIADO.ID_ITEMS_SERIADO =
       OR_ITEM_PATTERN.ID_ITEMS_SERIADO(+)
