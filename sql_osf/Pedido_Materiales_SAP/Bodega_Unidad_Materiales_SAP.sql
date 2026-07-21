SELECT D.ID_ITEMS_DOCUMENTO RESERVA,
       MMITNUPE PEDIDO,
       'R' TIPO,
       FECHA FECHA_REGISTRO,
       MMITFECR FECHA_DESPACHO,
       DECODE(ESTADO, 'A', 'ABIERTO', 'C', 'CERRADO') ESTADO,
       OPERATING_UNIT_ID UNIDAD_ORIGEN,
       (select oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = OPERATING_UNIT_ID
           and rownum = 1) NOMBRE_UNI,
       DESTINO_OPER_UNI_ID PROVEEDOR,
       (select oou.name
          from open.or_operating_unit oou
         where oou.operating_unit_id = DESTINO_OPER_UNI_ID
           and rownum = 1) NOMBRE_PROV,
       MMITDSAP DOCU_SAP,
       ITEMS_ID ITEM,
       (select gi.description
          from open.ge_items gi
         where gi.items_id = ITEMS_ID
           and rownum = 1) DESC_ITEM,
       REQUEST_AMOUNT CANT_SOLI,
       nvl(decode(mmitnatu, '+', 1, -1) * DMITCANT, 0) CANT_DESPACH,
       nvl(decode(mmitnatu, '+', 1, -1) * DMITCOUN, 0) COSTO_UNI,
       NULL ORDEN,
       DECODE(MMITESTA,
              1,
              DECODE(MMITINTE, 0, 'CREADO', 'CON ERROR'),
              'PROCESADO') ESTADO_INTERFAZ,
       D.COMENTARIO
  FROM OPEN.GE_ITEMS_DOCUMENTO D, OPEN.GE_ITEMS_REQUEST REQU
  LEFT JOIN OPEN.LDCI_INTEMMIT
    ON MMITNUDO = to_char(REQU.ID_ITEMS_DOCUMENTO) -- || ''
  LEFT JOIN OPEN.LDCI_DMITMMIT
    ON REQU.ITEMS_ID = DMITITEM
   and MMITCODI = DMITMMIT
  LEFT JOIN open.ldci_seridmit
    on mmitcodi = serimmit
   and dmitcodi = seridmit
   and dmitmmit = serimmit
   and serinume = 'K-126641-24'
 WHERE D.ID_ITEMS_DOCUMENTO = REQU.ID_ITEMS_DOCUMENTO
   and dmititem = 10011386
   and OPERATING_UNIT_ID in (3979, 1773)
   and DESTINO_OPER_UNI_ID in (3979, 1773)
 order by FECHA desc
