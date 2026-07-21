SELECT D.ID_ITEMS_DOCUMENTO RESERVA,
       MMITDSAP DOCU_SAP,
       MMITNUPE PEDIDO,
       FECHA FECHA_REGISTRO,
       MMITFECR FECHA_DESPACHO,
       DECODE(ESTADO, 'A', 'ABIERTO', 'C', 'CERRADO') ESTADO,
       OPERATING_UNIT_ID UNIDAD_ORIGEN,
       --OPEN.DAOR_OPERATING_UNIT.FSBGETNAME(OPERATING_UNIT_ID, null) 
       NULL                NOMBRE_UNI,
       DESTINO_OPER_UNI_ID PROVEEDOR,
       --OPEN.DAOR_OPERATING_UNIT.FSBGETNAME(DESTINO_OPER_UNI_ID, null) 
       NULL     NOMBRE_PROV,
       ITEMS_ID ITEM,
       --OPEN.DAGE_ITEMS.FSBGETDESCRIPTION(ITEMS_ID, null) 
       NULL DESC_ITEM,
       REQUEST_AMOUNT CANT_SOLI,
       nvl(decode(mmitnatu, '+', 1, -1) * DMITCANT, 0) CANT_DESPACH,
       nvl(decode(mmitnatu, '+', 1, -1) * DMITCOUN, 0) COSTO_UNI,
       NULL ORDEN,
       ci.mmitesta || '-' ||
       decode(ci.mmitesta, 1, 'CREADA', 2, 'PROCESADA', 3, 'CON ERRORES') estado_interfaz,
       ci.mmitinte intentos_interfaz,
       TRANSLATE(ci.mmitmens, CHR(13) || CHR(10) || CHR(9), '   ') mensaje_interfaz
  FROM OPEN.GE_ITEMS_DOCUMENTO D, OPEN.GE_ITEMS_REQUEST REQU
  LEFT JOIN OPEN.LDCI_INTEMMIT CI
    ON MMITNUDO = REQU.ID_ITEMS_DOCUMENTO || ''
  LEFT JOIN OPEN.LDCI_DMITMMIT
    ON REQU.ITEMS_ID = DMITITEM
   AND MMITCODI = DMITMMIT
 WHERE 1 = 1
   and DOCUMENT_TYPE_ID = 102
   AND D.ID_ITEMS_DOCUMENTO = REQU.ID_ITEMS_DOCUMENTO
      --AND D.ID_ITEMS_DOCUMENTO = decode(:DOCUMENTO, -1, D.ID_ITEMS_DOCUMENTO, :DOCUMENTO)
      --AND ci.mmitesta = 1
      --AND ci.mmitinte > 0
   AND FECHA BETWEEN
       TO_DATE(&FECHA_INICIAL || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
       TO_DATE(&FECHA_FINAL || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
 ORDER BY FECHA desc;
SELECT NULL,
       MMITNUPE PEDIDO,
       'P' TIPO,
       TRSMFECR FECHA_REGISTRO,
       MMITFECR FECHA_DESPACHO,
       DECODE(TRSMESTA,
              1,
              'CREADO',
              2,
              'ENVIADO',
              3,
              'RECIBIDO',
              4,
              'ANULADO'),
       TRSMUNOP,
       --OPEN.DAOR_OPERATING_UNIT.FSBGETNAME(TRSMUNOP, null),
       TRSMPROV,
       --OPEN.DAOR_OPERATING_UNIT.FSBGETNAME(TRSMPROV, null),
       MMITDSAP,
       TSITITEM,
       --OPEN.DAGE_ITEMS.FSBGETDESCRIPTION(TSITITEM, null) DESC_ITEM,
       decode(mmitnatu, '+', 1, -1) * TSITCANT,
       DMITCANT,
       DMITVAUN,
       ORDER_ID,
       ci.mmitesta || '-' ||
       decode(ci.mmitesta, 1, 'CREADA', 2, 'PROCESADA', 3, 'CON ERRORES') estado_interfaz,
       ci.mmitinte intentos_interfaz,
       TRANSLATE(ci.mmitmens, CHR(13) || CHR(10) || CHR(9), '   ') mensaje_interfaz
  FROM OPEN.LDCI_TRANSOMA,
       OPEN.LDCI_TRSOITEM,
       OPEN.LDCI_INTEMMIT CI,
       OPEN.LDCI_DMITMMIT
 WHERE TRSMCODI = TSITSOMA
   AND MMITNUPE LIKE '%' || TRSMCODI || '%'
   AND TSITITEM = DMITITEM
   AND DMITMMIT = MMITCODI
      --AND TRSMCODI = decode(:DOCUMENTO, -1, TRSMCODI, :DOCUMENTO)
      --AND ci.mmitesta = 1
      --AND ci.mmitinte > 0
   AND TRSMFECR BETWEEN
       TO_DATE(&FECHA_INICIAL || ' 00:00:00', 'DD/MM/YYYY HH24:MI:SS') AND
       TO_DATE(&FECHA_FINAL || ' 23:59:59', 'DD/MM/YYYY HH24:MI:SS')
--AND MMITTIMO != 'STA'
 ORDER BY TRSMFECR desc;
