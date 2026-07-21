select --sbMoviMate,
--sbMoviHerr,
 sbDevoMate,
 --sbDevoHerr,
 --sbClasSolMatAct,
 sbClasDevMatAct
  from (select CASEVALO sbMoviMate
          from open.LDCI_CARASEWE
         where CASEDESE = 'WS_RESERVA_MATERIALES'
           and CASECODI = 'CLS_MOVI_MATERIAL'),
       (select CASEVALO sbMoviHerr
          from open.LDCI_CARASEWE
         where CASEDESE = 'WS_RESERVA_MATERIALES'
           and CASECODI = 'CLS_MOVI_HERRAMIENTA'),
       (select CASEVALO sbDevoMate
          from open.LDCI_CARASEWE
         where CASEDESE = 'WS_RESERVA_MATERIALES'
           and CASECODI = 'CLS_MOVI_DEVOLUCION_MAT'),
       (select CASEVALO sbDevoHerr
          from open.LDCI_CARASEWE
         where CASEDESE = 'WS_RESERVA_MATERIALES'
           and CASECODI = 'CLS_MOVI_DEVOLUCION_HER'),
       (select CASEVALO sbClasSolMatAct --#OYM_CEV_3429_1
          from open.LDCI_CARASEWE
         where CASEDESE = 'WS_RESERVA_MATERIALES'
           and CASECODI = 'CLSM_SOLI_ACT'),
       (select CASEVALO sbClasDevMatAct --#OYM_CEV_3429_1
          from open.LDCI_CARASEWE
         where CASEDESE = 'WS_RESERVA_MATERIALES'
           and CASECODI = 'CLSM_DEVO_ACT');

select PROVEEDOR_LOGISTICO,
       ATT_MARCA_TECHNICAL_NAME,
       ATT_MAXVALUE_TECHNICAL_NAME,
       ATT_MODELO_VM_TECHNICAL_NAME,
       ATT_REFERENCIA_VM_TEC_NAME,
       ATT_MARCA_VM_TECHNICAL_NAME
  from (select CASEVALO PROVEEDOR_LOGISTICO
          from LDCI_CARASEWE
         where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
           and CASECODI = 'PROVEEDOR_LOGISTICO'),
       
       (select CASEVALO ATT_MARCA_TECHNICAL_NAME
          from LDCI_CARASEWE
         where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
           and CASECODI = 'ATT_MARCA_TECHNICAL_NAME'),
       
       (select CASEVALO ATT_MAXVALUE_TECHNICAL_NAME
          from LDCI_CARASEWE
         where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
           and CASECODI = 'ATT_MAXVALUE_TECHNICAL_NAME'),
       
       (select CASEVALO ATT_MODELO_VM_TECHNICAL_NAME
          from LDCI_CARASEWE
         where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
           and CASECODI = 'ATT_MODELO_VM_TECHNICAL_NAME'),
       
       (select CASEVALO ATT_REFERENCIA_VM_TEC_NAME
          from LDCI_CARASEWE
         where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
           and CASECODI = 'ATT_REFERENCIA_VM_TEC_NAME'),
       
       (select CASEVALO ATT_MARCA_VM_TECHNICAL_NAME
          from LDCI_CARASEWE
         where CASEDESE = 'WS_MOVIMIENTO_MATERIAL'
           and CASECODI = 'ATT_MARCA_VM_TECHNICAL_NAME');

select *
  from open.LDCI_INTEMMIT
 where mmitdsap = '413050413'
--MMITCODI = decode(&inuMMITCODI, -1, MMITCODI, &inuMMITCODI)
--and MMITESTA = 1
--and 
--MMITINTE <= 3
 order by MMITCODI asc;

select DMITITEM ITEM, DMITCANT CANTIDAD, count(SERIDMIT) CANTIDAD_SERIALES
  from OPEN.LDCI_INTEMMIT, OPEN.LDCI_DMITMMIT, OPEN.LDCI_SERIDMIT
 where MMITCODI = MMITCODI
   and MMITCODI = DMITMMIT
   and SERIMMIT = MMITCODI
   and DMITCODI = SERIDMIT
-- and MMITCODI = &inuMovimiento /*Id del movimiento de material*/
 group by DMITITEM, DMITCANT;

select MMITCODI, MMITNUDO, MMITNUPE, DMITITEM, OPEN.LDCI_SERIDMIT.*
  from OPEN.LDCI_INTEMMIT, OPEN.LDCI_DMITMMIT, OPEN.LDCI_SERIDMIT
 where MMITCODI = MMITCODI
   and MMITCODI = DMITMMIT
   and SERIMMIT = MMITCODI
   and DMITCODI = SERIDMIT
   and MMITCODI = &inuMovimiento /*Id del movimiento de material*/
;

select 'S' from LDCI_CONTESSE where COESCOSA = &sbCOESCOSA;

select MARCCODI MARCA, MARCDESC DESCRIPCION
  from LDCI_MARCA
 where MARCCODI = &nuMarca;

select MARCCODI MARCA,
       MARCDESC DESCRIPCION,
       RMMACODI REF_MARCA,
       RMMANDME TOPE
  from open.LDCI_MARCA, open.LDCI_REMEMARC
 where RMMAMARC = MARCCODI
   and MARCCODI = &inuMarca
   and RMMACODI = &inuRefMarca;

select ID_ITEMS_DOCUMENTO, DOCUMENT_TYPE_ID
  from GE_ITEMS_DOCUMENTO
 where ID_ITEMS_DOCUMENTO = &inuID_ITEMS_DOCUMENTO;

select MMITCODI, MMITNUDO, MMITTIMO, MMITNATU, MMITDSAP, LDCI_DMITMMIT.*
  from LDCI_INTEMMIT, LDCI_DMITMMIT
 where DMITMMIT = MMITCODI
   and MMITCODI = &inuDMITMMIT;

-- carga el documento para determina las unidades operativas involucradas
select ID_ITEMS_DOCUMENTO,
       DOCUMENT_TYPE_ID,
       OPERATING_UNIT_ID,
       DESTINO_OPER_UNI_ID
  from GE_ITEMS_DOCUMENTO
 where ID_ITEMS_DOCUMENTO = &inuID_ITEMS_DOCUMENTO;

select * --count(*)
  from LDCI_SERIDMIT
 where SERIMMIT = &inuSERIMMIT
   and SERIDMIT = &inuSERIDMIT;

-- recorre los isbSeriales para generar el XML
select SERIMMIT, SERIDMIT, SERICODI, SERINUME
  from LDCI_SERIDMIT
 where SERIMMIT = &inuSERIMMIT
   and SERIDMIT = &inuSERIDMIT
 order by SERIMMIT, SERIDMIT, SERICODI;

-- if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
-- Si el tipo de movimiento es D, indica que disminuye en bodega y coloca la cantidad negativa
--if (isbTipoMovi = 'D') then
select Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
       Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
       to_char(Mov.MMITFESA, 'DD/MM/YYYY') as "DATE",
       Mov.MMITDSAP as "DOCUMENT",
       Mov.MMITDSAP as "REFERENCE",
       Det.DMITITEM /*Det.DMITCOIN*/ as "ITEM_CODE",
       -1 as "QUANTITY",
       Det.DMITCOUN as "COST",
       Det.DMITVALO as "STATUS",
       Ser.SERINUME as "SERIE",
       'ATTRIBUTES' as "ATTRIBUTES"
  from LDCI_INTEMMIT      Mov,
       LDCI_DMITMMIT      Det,
       LDCI_SERIDMIT      Ser,
       GE_ITEMS_DOCUMENTO Doc
 where Det.DMITCODI = to_char(&inuMMITCODI)
   and Det.DMITMMIT = to_char(&inuDMITMMIT)
   and Mov.MMITCODI = Det.DMITMMIT
   and Ser.SERIMMIT = Det.DMITMMIT
   and Ser.SERIDMIT = Det.DMITCODI
   and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
   and Ser.SERICODI = to_char(&inuSERICODI);

select * from LDCI_INTEMMIT where MMITCODI = &inuMovimiento;
