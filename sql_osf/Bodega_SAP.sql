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
   and serinume = 'S-77132156-22'
 WHERE D.ID_ITEMS_DOCUMENTO = REQU.ID_ITEMS_DOCUMENTO
   and dmititem = 10006967
--and operating_unit_id in (:UNIDAD)
--UNION
/*SELECT NULL,
      MMITNUPE PEDIDO,
      'P' TIPO,
      TRSMFECR FECHA_REGISTRO,
      MMITFECR FECHA_DESPACHO,
      DECODE(TRSMESTA,1,'CREADO',2, 'ENVIADO',3,'RECIBIDO',4,'ANULADO'),
      TRSMUNOP,
      (select oou.name from open.or_operating_unit oou where oou.operating_unit_id =TRSMUNOP and rownum = 1),
      TRSMPROV,
      (select oou.name from open.or_operating_unit oou where oou.operating_unit_id =TRSMPROV and rownum = 1),
      MMITDSAP,
      TSITITEM,
      (select gi.description from open.ge_items gi where gi.items_id=ITEMS_ID and rownum = 1) DESC_ITEM,
      TSITCANT,
      decode(mmitnatu,'+',1,-1)*DMITCANT,
      decode(mmitnatu,'+',1,-1)*DMITVAUN,
      ORDER_ID,
      DECODE(MMITESTA,1,'NO PROCESADO','PROCESADO') ESTADO,
      TRSMOBSE
 FROM OPEN.LDCI_TRANSOMA,
      OPEN.LDCI_TRSOITEM,
      OPEN.LDCI_INTEMMIT,
      OPEN.LDCI_DMITMMIT
WHERE TRSMCODI = TSITSOMA
  AND MMITNUPE = 'GDC-' || TRSMCODI
  AND TSITITEM=DMITITEM
  AND DMITMMIT = MMITCODI
  AND TRSMCODI=decode(&DOCUMENTO,-1,trsmcodi,&DOCUMENTO)
  --AND MMITTIMO!='STA'
  and dmititem = 10006967
  --AND TRSMUNOP IN (:UNIDAD)*/
