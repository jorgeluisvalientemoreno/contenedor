CREATE OR REPLACE PACKAGE LDCI_PKMOVIMATERIAL AS
  /*
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
        FUNCION    : LDCI_PKMOVIMATERIAL
        AUTOR      : Eduardo Aguera
        FECHA      : 26/01/2012
        RICEF      : I004; I018
        DESCRIPCION: Paquete realizar movimientos de isbMateriales para
                                  contratistas/cuadrillas

      Historia de Modificaciones
      Autor          Fecha          Descripcion
      JJJM         09/11/2017     Se crean procedimientos para actualizar bodegas  de activo e inventario
                                  cuando se realicen acpetaciones parciales o totales, rechazos parciales 
                                  o totales de items serializados y no serializados. Y cierre del documento 
                                  inicial cuando se realicen todas las transacciones.
  */

      -- Notifica el movimiento de isbMaterial al front
      PROCEDURE ProNotiMaestroMovMaterial(inuMovMatCodi in  LDCI_INTEMMIT.MMITCODI%type,
                        isbDocFront   in  LDCI_INTEMMIT.MMITNUDO%type,
                        isbPedFront   in  LDCI_INTEMMIT.MMITNUPE%type,
                        isbDocSap     in  LDCI_INTEMMIT.MMITDSAP%type,
                        isbTipoMov    in  LDCI_INTEMMIT.MMITTIMO%type,
                        isbDescMov    in  LDCI_INTEMMIT.MMITDESC%type,
                        isbSigno      in  LDCI_INTEMMIT.MMITNATU%type,
                        isbCliente    in  LDCI_INTEMMIT.MMITCLIE%type,
                        idtFechaDoc   in  LDCI_INTEMMIT.MMITFESA%type,
                        inuValorTotal in  LDCI_INTEMMIT.MMITVTOT%type,
                        idtFechaVenc  in  LDCI_INTEMMIT.MMITFEVE%type);


      -- Notifica el detalle del movimineto
      PROCEDURE proNotiDetalleMovMaterial(inuMovMatCodi    in  LDCI_DMITMMIT.DMITMMIT%type,
                        inuDetMovMatCodi in  LDCI_DMITMMIT.DMITCODI%type,
                        isbMaterial      in  LDCI_DMITMMIT.DMITITEM%type,
                        inuCantidad      in  LDCI_DMITMMIT.DMITCANT%type,
                        inuCantPend      in  LDCI_DMITMMIT.DMITCAPE%type,
                        inuCostoUni      in  LDCI_DMITMMIT.DMITCOUN%type,
                        inuValorUni      in  LDCI_DMITMMIT.DMITVAUN%type,
                        inuPorcIva       in  LDCI_DMITMMIT.DMITPIVA%type,
                        isbNumFac        in  LDCI_DMITMMIT.DMITNUFA%type,
                        isbAlmDest       in  LDCI_DMITMMIT.DMITALDE%type,
                        isbMarca         in  LDCI_DMITMMIT.DMITMARC%type,
                        isbSaliFinal     in  LDCI_DMITMMIT.DMITSAFI%type,
                        isbMarcBorrado   in  LDCI_DMITMMIT.DMITMABO%type,
                        isbItemDoVal     in  VARCHAR2);

      --Notifica el detalle de los isbSeriales
      Procedure ProNotiSerialDetaMovi(inuMovMatCodi    in LDCI_SERIDMIT.SERIMMIT%type,
                      inuDetMovMatCodi in LDCI_SERIDMIT.SERIDMIT%type,
                      inuSeriMatCodi   in LDCI_SERIDMIT.SERICODI%type,
                      isbSerial        in LDCI_SERIDMIT.SERINUME%type);

      -- procedimiento que confirma la solicitud
      procedure proConfirmarSolicitud(inuMovimiento in LDCI_INTEMMIT.MMITCODI%type);

      -- Notifica el movimiento de isbMaterial al front
      PROCEDURE proReprocesaMovimiento(inuMovMatCodi   in  LDCI_INTEMMIT.MMITCODI%type,
                      inuCurrent       in NUMBER,
                      inuTotal         in NUMBER,
                      onuErrorCode    out NUMBER,
                      osbErrorMessage out VARCHAR2);

      PROCEDURE proAsignaMaterialSeriado(isbPosicion     in VARCHAR2,
                         inuCurrent      in NUMBER,
                         inuTotal        in NUMBER,
                         onuErrorCode    out NUMBER,
                         osbErrorMessage out VARCHAR2);

      procedure proGenXMLItemSeriVendido(isbDOVECODI in  LDCI_DOCUVENT.DOVECODI%type,
                           inuITDVPROV in  LDCI_ITEMDOVE.ITDVPROV%type,
                         inuITDVCODI in  LDCI_ITEMDOVE.ITDVCODI%type,
                         isbITDVITEM in  LDCI_ITEMDOVE.ITDVITEM%type,
                         inuITDVOPUN in  LDCI_ITEMDOVE.ITDVOPUN%type,
                         isbTipoMovi in  VARCHAR2,
                         ol_Payload  out CLOB,
                         osbMesjErr  out VARCHAR2);

      procedure proValidaSeriales(inuMovimiento   in  NUMBER,  --138682
                      onuErrorCode    out NUMBER,
                      osbErrorMessage out VARCHAR2);

      -- funcion que retorna la marca
      function fsbGetDescMarca(inuMARCCODI  LDCI_MARCA.MARCCODI%type) return VARCHAR2;

      -- funcion que retorna el material vendido
      function frfGetMovimientoMaterial return LDCI_PKREPODATATYPE.tyRefcursor;


      -- funcion que retorna todos los movimientos
      function frfGetMaterialVendido return LDCI_PKREPODATATYPE.tyRefcursor;

      -- proceso que recorre todas las solicitudes
      --procedure proProcesaSolitudes;
PROCEDURE ldc_actualizabodegasdev(
                                   sbpanrodocumento VARCHAR2
                                  ,nupacantidad     NUMBER
                                  ,sbpaitems        VARCHAR2
                                  ,nupaerror        OUT NUMBER
                                  ,sbpaerror        OUT VARCHAR2
/*************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Actualiza bodega de activo e inventario de items serializados y no-serializados 
                cuando hay aceptacion parcial o total.

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento
   nupacantidad          Cantidad aceptada
   sbpaitems             Nro del items

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

*************************************************************************************************/
);
PROCEDURE ldc_actbodegasdevserrech(
                                    sbpanrodocumento VARCHAR2
                                   ,nuiditemser      NUMBER
                                   ,sbpaitems        VARCHAR2
                                   ,nupaerror        OUT NUMBER
                                   ,sbpaerror        OUT VARCHAR2
/********************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Actualiza bodega de activo e inventario de items serializados cuando hay rechazo parcial 
                o total.

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento
   nupacantidad          Cantidad rechazada
   sbpaitems             Nro del items

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

**********************************************************************************************************/                                   
                                  );
PROCEDURE ldc_actbodegasdevrechnoser(
                                     sbpanrodocumento VARCHAR2
                                    ,sbpaitems        VARCHAR2
                                    ,nupaerror        OUT NUMBER
                                    ,sbpaerror        OUT VARCHAR2
/*************************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Actualiza bodega de activo e inventario de items no serializados cuando hay rechazo parcial 
                o total.

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento
   sbpaitems             Nro del items

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

*************************************************************************************************************/                                     
                                    );
PROCEDURE ldc_cerrardocumentotraslados(nupadocumento NUMBER,nupaerror OUT NUMBER,sbpamensaje OUT VARCHAR2)
 /********************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Cierra el documento inicial cuando se realizan todas las transacciones .

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

**********************************************************************************************************/
 ;

  END LDCI_PKMOVIMATERIAL;
/
CREATE OR REPLACE PACKAGE BODY LDCI_PKMOVIMATERIAL AS

  csbSP_NAME       CONSTANT VARCHAR2(35) := $$PLSQL_UNIT||'.';

  /*
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
        FUNCION    : LDCI_PKMOVIMATERIAL
        AUTOR      : Eduardo Aguera
        FECHA      : 26/01/2012
        RICEF      : I004; I018
        DESCRIPCION: Paquete realizar movimientos de isbMateriales para
                              contratistas/cuadrillas

      Historia de Modificaciones
      Autor         Fecha                   Descripcion
      JJJM         09/11/2017     Se crean procedimientos para actualizar bodegas  de activo e inventario
                                  cuando se realicen acpetaciones parciales o totales, rechazos parciales 
                                  o totales de items serializados y no serializados. Y cierre del documento 
                                  inicial cuando se realicen todas las transacciones.

      MABG  06/11/2020    Se modifica el cursor cuWS_MOVIMIENTO_MATERIAL para tener 
                  en cuenta las nuevos atributos MARCA_VM, REFERENCIA_VM, MODELO_VM CASO 31
  */

      -- cursor de las clases de movimientos, parametros definidos en LDCI_CARASEWE
      cursor cuClaseMovi is
            select sbMoviMate, sbMoviHerr, sbDevoMate, sbDevoHerr, sbClasSolMatAct, sbClasDevMatAct
                from (select CASEVALO sbMoviMate
                    from LDCI_CARASEWE
                  where CASEDESE = 'WS_RESERVA_MATERIALES'
                      and CASECODI = 'CLS_MOVI_MATERIAL'),
                (select CASEVALO sbMoviHerr
                    from LDCI_CARASEWE
                    where CASEDESE = 'WS_RESERVA_MATERIALES'
                  and CASECODI = 'CLS_MOVI_HERRAMIENTA'),
                (select CASEVALO sbDevoMate
                    from LDCI_CARASEWE
                    where CASEDESE = 'WS_RESERVA_MATERIALES'
                  and CASECODI = 'CLS_MOVI_DEVOLUCION_MAT'),
                (select CASEVALO sbDevoHerr
                    from LDCI_CARASEWE
                    where CASEDESE = 'WS_RESERVA_MATERIALES'
                  and CASECODI = 'CLS_MOVI_DEVOLUCION_HER'),
                (select CASEVALO sbClasSolMatAct --#OYM_CEV_3429_1
                    from LDCI_CARASEWE
                    where CASEDESE = 'WS_RESERVA_MATERIALES'
                  and CASECODI = 'CLSM_SOLI_ACT'),
                (select CASEVALO sbClasDevMatAct --#OYM_CEV_3429_1
                    from LDCI_CARASEWE
                    where CASEDESE = 'WS_RESERVA_MATERIALES'
                  and CASECODI = 'CLSM_DEVO_ACT');

      -- cursor de la configuraicon de la definicon LDCI_CARASEWE "WS_MOVIMIENTO_MATERIAL"
      -- #NC-2227: Se agrega el parametro ATT_MARCA_TECHNICAL_NAME
      -- #FAC_CEV_3655_1: Se agrega el parametro ATT_MAXVALUE_TECHNICAL_NAME #TODO: Valida el nombre del parametro
      -- #MABG modificacion caso 31
      cursor cuWS_MOVIMIENTO_MATERIAL is
          ------------ inicio caso 31 ---------------
          select PROVEEDOR_LOGISTICO, ATT_MARCA_TECHNICAL_NAME, ATT_MAXVALUE_TECHNICAL_NAME, 
               ATT_MODELO_VM_TECHNICAL_NAME, ATT_REFERENCIA_VM_TEC_NAME, ATT_MARCA_VM_TECHNICAL_NAME
            from
            (select CASEVALO PROVEEDOR_LOGISTICO
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

          -------------- fin caso 31


      -- variable de tipo rowtype basada en el cursor cuClaseMovi
      reClaseMovi cuClaseMovi%rowtype;
      reWS_MOVIMIENTO_MATERIAL cuWS_MOVIMIENTO_MATERIAL%rowtype;

   function fsbGetDescMarca(inuMARCCODI  LDCI_MARCA.MARCCODI%type)  return VARCHAR2 as
          -- cursor de la marca
          cursor cuLDCI_MARCA(inuMARCCODI  LDCI_MARCA.MARCCODI%type) is
            select MARCCODI, MARCDESC
                from LDCI_MARCA
              where MARCCODI = inuMARCCODI;

          reLDCI_MARCA cuLDCI_MARCA%rowtype;
        begin

          open cuLDCI_MARCA(inuMARCCODI);
          fetch cuLDCI_MARCA into reLDCI_MARCA;
          if (cuLDCI_MARCA%NOTFOUND) then
            close cuLDCI_MARCA;
            open cuLDCI_MARCA(-1);
            fetch cuLDCI_MARCA into reLDCI_MARCA;
            close cuLDCI_MARCA;
          end if; --if (cuLDCI_MARCA%NOTFOUND) then
          close cuLDCI_MARCA;

          return reLDCI_MARCA.MARCDESC;
      end fsbGetDescMarca;

   function fsbAtrTopeMedidor(inuRMMAMARC in LDCI_REMEMARC.RMMAMARC%type,
                                inuRMMACODI in LDCI_REMEMARC.RMMACODI%type) return VARCHAR2 as
          /*
            * Propiedad Intelectual Gases de Occidente SA ESP
            *
            * Script  : LDCI_PKMOVIMATERIAL.fsbAtrTopeMedidor
            * RICEF   : #FAC_CEV_3655_1
            * Autor   : OLSoftware / carlos.virgen <carlos.virgen@olsoftware.com>
            * Fecha   : 27-05-2014
            * Descripcion : Retorna el tope de medidor segun la configuracion de referencia por marca

            *
            * Historia de Modificaciones
            * Autor          Fecha      Descripcion
            * carlos.virgen  23-05-2014 Version inicial
          **/
          -- cursor referencia por marca
          cursor cuLDCI_REMEMARC(inuMarca    in LDCI_REMEMARC.RMMAMARC%type,
                              inuRefMarca in LDCI_REMEMARC.RMMACODI%type) is
            select RMMAMARC,
                        RMMACODI,
                        RMMACAAR,
                        RMMAQMAX,
                        RMMAQMIN,
                        RMMACCDM,
                        RMMAMPOP,
                        RMMAVMRM,
                        RMMATCLE,
                        RMMAAVUT,
                        RMMAAGME,
                        RMMADCSA,
                        RMMADCME,
                        RMMANDME,
                        RMMAFAME
                from LDCI_REMEMARC
              where RMMAMARC = inuMarca
                and RMMACODI = inuRefMarca;

          reLDCI_REMEMARC cuLDCI_REMEMARC%rowtype;
        begin

          open cuLDCI_REMEMARC(inuRMMAMARC, inuRMMACODI);
          fetch cuLDCI_REMEMARC into reLDCI_REMEMARC;
          if (cuLDCI_REMEMARC%NOTFOUND) then
            close cuLDCI_REMEMARC;
            open cuLDCI_REMEMARC(-1, -1);
            fetch cuLDCI_REMEMARC into reLDCI_REMEMARC;
          end if;
          close cuLDCI_REMEMARC;

          return reLDCI_REMEMARC.RMMANDME;
      end fsbAtrTopeMedidor;

      function fnuGetCodigoInternoItem(isbCODE in GE_ITEMS.CODE%type) return NUMBER  AS
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          PAQUETE       : LDCI_PKMOVIMATERIAL.fnuGetCodigoInternoItem
          AUTOR         : OLSoftware / Carlos E. Virgen
          FECHA         : 19/03/2013
          RICEF : I020,I038,I039,I040
          DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de movimientos de material

        Historia de Modificaciones
        Autor   Fecha      Descripcion

      */
    nuCodInterno NUMBER;
      cursor cuGE_ITEMS(isbCODE GE_ITEMS.CODE%type) is
        select ITEMS_ID
             from GE_ITEMS
              where CODE =  isbCODE;
      BEGIN
          -- carga el cursor para deteminar el item
          open cuGE_ITEMS(isbCODE);
          fetch cuGE_ITEMS into nuCodInterno;
          close cuGE_ITEMS;

          return nuCodInterno;
      END fnuGetCodigoInternoItem;

      function fclGetXMLAttributes(inuMovimiento in NUMBER,
                                   inuPosicion   in NUMBER,
                                                               inuSerial     in NUMBER,
                                                               isbDocSAP     in VARCHAR2,
                                                               isbSerialSAP  in VARCHAR2,
                                                               isbOrigen     in VARCHAR2)
            return CLOB is
      /*
        * Propiedad Intelectual Gases de Occidente SA ESP
        *
        * Script  : LDCI_PKMOVIMATERIAL.fclGetXMLAttributes
        * Tiquete : I032
        * Autor   : OLSoftware / Carlos E. Virgen Londo??A?o
        * Fecha   : 09-04-2013
        * Descripcion : Retorna el promedio de consumo
        *
        * Historia de Modificaciones
        * Autor                                        Fecha            Descripcion
        * carlosvl<carlos.virgen@olsoftware.com>       05-02-2014       #NC-42079: Se valida si el item seriado hace manejo de la estructura SAP en el serial
        *                                                                           Si maneja la esctructura debe calcula la descripcion de la marca de lo contrario no.
          OLSOFTWARE                   15/10/2020   Caso 31 se modifica los cursores cuItemSeriadoConsumo y cuItemSeriadoVenta para agregar el campo 
                                        DMITMARC que hace referencia al campo modelo de la tabla LDCI_DMITMMIT y ese campo sera agregado 
                                        a la varible oclXMLAttributes que es el retorna la funcion con la informacion XML.
      **/

         -- #NC-42079: carlosvl: 05-02-2014: Cursor para validar el la estructura
         cursor cuLDCI_CONTESSE(sbCOESCOSA LDCI_CONTESSE.COESCOSA%type) is
        select      'S'
          from LDCI_CONTESSE
                  where COESCOSA = sbCOESCOSA;

      -- cursor del item seriado (Asignacion por requisicion)
            cursor cuItemSeriadoConsumo(inuMovimiento NUMBER, inuPosicion NUMBER,inuSerial NUMBER) is
              select DMITITEM,  DMITCOIN, SERINUME,SERIESTR,SERIMARC,SERIANO,SERICAJA,SERIREMA,SERITIEN,DMITMARC 
                                from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser
                                where Det.DMITMMIT = inuMovimiento
                                    and Det.DMITCODI = inuPosicion
                                    and Mov.MMITCODI = Det.DMITMMIT
                                    and Ser.SERIMMIT = Det.DMITMMIT
                                    and Ser.SERIDMIT = Det.DMITCODI
                                    and Ser.SERICODI = inuSerial;

      -- cursor del item seriado (Asignacion por venta)
            cursor cuItemSeriadoVenta(isbDocSAP VARCHAR2, isbSerialSAP VARCHAR2) is
              select DMITITEM,  DMITCOIN, SERINUME,SERIESTR,SERIMARC,SERIANO,SERICAJA,SERIREMA,SERITIEN,DMITMARC 
                from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser
                where Mov.MMITDSAP = isbDocSAP
                  and Mov.MMITCODI = Det.DMITMMIT
                  and Ser.SERIMMIT = Det.DMITMMIT
                  and Ser.SERIDMIT = Det.DMITCODI
                  and Ser.SERINUME = isbSerialSAP;

            -- Cursor del promedio de consumo
            cursor cuAttributes(inuITEMS_ID GE_ITEMS.ITEMS_ID%type) is
                  select att.TECHNICAL_NAME as "TECHNICAL_NAME",
                                1 as "VALUE"
                      from GE_ENTITY_ATTRIBUTES att,
                                GE_ITEMS_TIPO_ATR tiit_att,
                                GE_ATTRIBUTES_TYPE ti_att,
                                GE_ITEMS item
                    where att.ENTITY_ATTRIBUTE_ID  = tiit_att.ENTITY_ATTRIBUTE_ID
                        and ti_att.ATTRIBUTE_TYPE_ID = att.ATTRIBUTE_TYPE_ID
                        and tiit_att.ID_ITEMS_TIPO   = item.ID_ITEMS_TIPO
                        and item.ITEMS_ID            = inuITEMS_ID
                        and tiit_att.REQUERIDO       = 'Y';

            sbCrtlEstrSerial VARCHAR2(1) := 'N'; -- -- #NC-42079: carlosvl: 05-02-2014: Flag para el control de la estructura
            oclXMLAttributes CLOB;
            reItemSeriado cuItemSeriadoConsumo%rowtype;
            sbDebug3655 VARCHAR2(200);

            ------ variables caso 31 -----------
            nuCaso       varchar2(30):='0000031';
            ------------------------------------
      begin

          ut_trace.trace('inicia fclGetXMLAttributes',16);
          ut_trace.trace('inuMovimiento: ' || inuMovimiento,17);
          ut_trace.trace('inuPosicion: ' || inuPosicion,17);
          ut_trace.trace('inuSerial: ' || inuSerial,17);
          ut_trace.trace('isbDocSAP: ' || isbDocSAP,17);
          ut_trace.trace('isbSerialSAP: ' || isbSerialSAP,17);
          ut_trace.trace('isbOrigen: ' || isbOrigen,17);

        -- inicializa el mensaje XML
          oclXMLAttributes := null;
          oclXMLAttributes := '<ATTRIBUTES>' || chr(13);


          -- carga el item seriado mas los atributos llegados por interfaz
          if (isbOrigen = 'CONSUMO') then
              open cuItemSeriadoConsumo(inuMovimiento, inuPosicion,inuSerial);
              fetch cuItemSeriadoConsumo into reItemSeriado;
              close cuItemSeriadoConsumo;
          else
                if (isbOrigen = 'VENTA') then
               ut_trace.trace(' if (isbOrigen = VENTA) then: isbDocSAP: ' || isbDocSAP,17);
               ut_trace.trace(' if (isbOrigen = VENTA) then: isbSerialSAP: ' || isbSerialSAP,17);
                    open cuItemSeriadoVenta(isbDocSAP, isbSerialSAP);
                    fetch cuItemSeriadoVenta into reItemSeriado;
                    close cuItemSeriadoVenta;
                end if;--if (isbOrigen = 'VENTA') then
          end if;--if (isbOrigen = 'CONSUMO') then

          -- #NC-42079: carlosvl: 05-02-2014:  Valida el listado de los items con seriales estructurados
          open cuLDCI_CONTESSE(reItemSeriado.DMITITEM);
          fetch cuLDCI_CONTESSE into sbCrtlEstrSerial;
          close cuLDCI_CONTESSE;

          ut_trace.trace('sbCrtlEstrSerial: ' || sbCrtlEstrSerial,17);
          ut_trace.trace('reItemSeriado.SERIMARC: ' || reItemSeriado.SERIMARC,17);
          ut_trace.trace('reItemSeriado.DMITCOIN: ' || reItemSeriado.DMITCOIN,17);

          -- recorre los atributos obligatorios
          for reAttributes in cuAttributes(reItemSeriado.DMITCOIN) loop

            ut_trace.trace('reAttributes.TECHNICAL_NAME: ' || reAttributes.TECHNICAL_NAME,17);
            ut_trace.trace('reItemSeriado.SERIMARC: ' || reItemSeriado.SERIMARC,17);
            ut_trace.trace('reItemSeriado.SERIREMA: ' || reItemSeriado.SERIREMA,17);
            -- #NC-2227: Se agrega la comparacion con el valor del parametro reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME
            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME
                    and sbCrtlEstrSerial = 'S' /*#NC-42079: carlosvl: 05-02-2014: Valida si controla estructura*/) then
                  oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '-' || fsbGetDescMarca(reItemSeriado.SERIMARC) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_TECHNICAL_NAME
                    and sbCrtlEstrSerial = 'N') then
                  oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '-' || fsbGetDescMarca(-1) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            -- #FAC_CEV_3655_1: Se agrega la comparacion con el valor del parametro reWS_MOVIMIENTO_MATERIAL.ATT_MAXVALUE_TECHNICAL_NAME (Tope de medidor)
            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MAXVALUE_TECHNICAL_NAME
                    and sbCrtlEstrSerial = 'S') then
                  oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || fsbAtrTopeMedidor(reItemSeriado.SERIMARC, reItemSeriado.SERIREMA) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MAXVALUE_TECHNICAL_NAME
                    and sbCrtlEstrSerial = 'N') then
                  oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || fsbAtrTopeMedidor(-1, -1) || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            ------- caso 31 ------
            --------- ATRIBUTO MODELO_VM ---------------
            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MODELO_VM_TECHNICAL_NAME
                  and sbCrtlEstrSerial = 'S') then
                oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.DMITMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MODELO_VM_TECHNICAL_NAME
                  and sbCrtlEstrSerial = 'N') then
                oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.DMITMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            --------- ATRIBUTO REFERENCIA_VM ---------------
            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_REFERENCIA_VM_TEC_NAME
                  and sbCrtlEstrSerial = 'S') then
                oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIREMA  || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_REFERENCIA_VM_TEC_NAME
                  and sbCrtlEstrSerial = 'N') then
                oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIREMA || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            --------- ATRIBUTO MARCA_VM ---------------
            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_VM_TECHNICAL_NAME
                  and sbCrtlEstrSerial = 'S') then
                oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;

            if (reAttributes.TECHNICAL_NAME = reWS_MOVIMIENTO_MATERIAL.ATT_MARCA_VM_TECHNICAL_NAME
                  and sbCrtlEstrSerial = 'N') then
                oclXMLAttributes := oclXMLAttributes || '  <' || reAttributes.TECHNICAL_NAME || '>' || reItemSeriado.SERIMARC || '</' || reAttributes.TECHNICAL_NAME || '>' || chr(13);
            end if;
            ------- fin caso 31 ------

          end loop;--for reAttributes in cuAttributes(reItemSeriado.DMITCOIN) loop

          -- Cierra las etiquetas XML
          oclXMLAttributes := oclXMLAttributes || '</ATTRIBUTES>';

          -- Retorna el XML con los atibutos
          return oclXMLAttributes;
          ut_trace.trace('termina fclGetXMLAttributes',16);
      end fclGetXMLAttributes;

      function frfGetMovimientoMaterial return LDCI_PKREPODATATYPE.tyRefcursor  AS
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          PAQUETE       : LDCI_PKMOVIMATERIAL.frfGetMovimientoMaterial
          AUTOR         : OLSoftware / Carlos E. Virgen
          FECHA         : 19/03/2013
          RICEF : I020,I038,I039,I040
          DESCRIPCION: Paquete que permite encapsula las operaciones de consulta de movimientos de material

        Historia de Modificaciones
        Autor   Fecha      Descripcion

      */
          -- variables
          orfMoviMaterial LDCI_PKREPODATATYPE.tyRefcursor  ;
          nuMovimiento    LDCI_INTEMMIT.MMITCODI%type;
          sbDocSolicitud  LDCI_INTEMMIT.MMITNUDO%type;
          nuEstado        LDCI_INTEMMIT.MMITESTA%type;
          sbDocuSAP       LDCI_INTEMMIT.MMITDSAP%type;
          dtFechaCreacion LDCI_INTEMMIT.MMITFECR%type;
          dtFechaInicial  LDCI_INTEMMIT.MMITFECR%type;
          dtFechaFinal    LDCI_INTEMMIT.MMITFECR%type;
          -- reMovimiento    LDCI_PKREPODATATYPE.tyMoviMaterialRecord;

          sbMMITCODI ge_boInstanceControl.stysbValue;
          sbMMITNUDO ge_boInstanceControl.stysbValue;
          sbMMITDSAP ge_boInstanceControl.stysbValue;
          sbMMITFECR ge_boInstanceControl.stysbValue;
          sbMMITESTA ge_boInstanceControl.stysbValue;

      BEGIN
              -- carga los parametros del proceso
              sbMMITCODI := ge_boInstanceControl.fsbGetFieldValue ('LDCI_INTEMMIT', 'MMITCODI');
              sbMMITNUDO := ge_boInstanceControl.fsbGetFieldValue ('LDCI_INTEMMIT', 'MMITNUDO');
              sbMMITDSAP := ge_boInstanceControl.fsbGetFieldValue ('LDCI_INTEMMIT', 'MMITDSAP');
              sbMMITFECR := ge_boInstanceControl.fsbGetFieldValue ('LDCI_INTEMMIT', 'MMITFECR');
              sbMMITESTA := ge_boInstanceControl.fsbGetFieldValue ('LDCI_INTEMMIT', 'MMITESTA');

              -- valida los parametros de entrada
              nuMovimiento    := nvl(to_number(sbMMITCODI),-1);
              sbDocSolicitud  := nvl(sbMMITNUDO,'-1');
              nuEstado        := nvl(to_number(sbMMITESTA),0);
              sbDocuSAP       := nvl(sbMMITDSAP,'-1');
              dtFechaCreacion := nvl(to_date(sbMMITFECR),sysdate - 365);


            -- carga el cusor referenciado
            open orfMoviMaterial for
              select MMITCODI as "Movimiento",
                                      MMITNUDO  as "Documento de Solicitud",
                    MMITDSAP  as "Documento despacho SAP",
                    MMITTIMO as "Tipo de movimiento",
                    MMITDESC as "Descripcion",
                    MMITNATU as "Naturaleza",
                    MMITFESA as "Fecha documento SAP",
                      MMITESTA as "Estado",
                    MMITINTE as "Intentos",
                    MMITFECR as "Fecha de creacion",
                    MMITMENS as "Mensaje de procesamiento"
                  from LDCI_INTEMMIT
                where MMITCODI = decode(nuMovimiento, -1, MMITCODI, nuMovimiento)
                    and MMITNUDO = decode(sbDocSolicitud, '-1', MMITNUDO, sbDocSolicitud)
                    and MMITESTA = decode(nuEstado, 0, MMITESTA, nuEstado)
                    and MMITDSAP = decode(sbDocuSAP, '-1', MMITDSAP, sbDocuSAP)
                                and MMITFECR >= dtFechaCreacion;

            return orfMoviMaterial;
      EXCEPTION
            when pkg_error.CONTROLLED_ERROR then
              raise;

            when OTHERS then
              Errors.setError;
              raise pkg_error.CONTROLLED_ERROR;
      END frfGetMovimientoMaterial;

      function frfGetMaterialVendido return LDCI_PKREPODATATYPE.tyRefcursor  AS
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          PAQUETE       : LDCI_PKMOVIMATERIAL.frfGetMaterialVendido
          AUTOR         : OLSoftware / Carlos E. Virgen
          FECHA         : 19/03/2013
          RICEF : I064
          DESCRIPCION: Paquete que retorna el material vendido

        Historia de Modificaciones
        Autor   Fecha      Descripcion

      */
          -- variables
          cnuNULL_ATTRIBUTE constant number := 2126;
          orfMoviMaterial LDCI_PKREPODATATYPE.tyRefcursor;
          sbDocuVenta     LDCI_DOCUVENT.DOVECODI%type;
          nuProveedor     number;
          nuUnidadOpe     LDCI_ITEMDOVE.ITDVOPUN%type;


          sbDOVECODI ge_boInstanceControl.stysbValue;
          sbITDVPROV ge_boInstanceControl.stysbValue;

          sbITDVCODI ge_boInstanceControl.stysbValue;
          sbITDVITEM ge_boInstanceControl.stysbValue;
          sbITDVCANT ge_boInstanceControl.stysbValue;
          sbITDVCAPE ge_boInstanceControl.stysbValue;
          sbITDVCOUN ge_boInstanceControl.stysbValue;
          sbITDVVAUN ge_boInstanceControl.stysbValue;
          sbITDVPIVA ge_boInstanceControl.stysbValue;
          sbITDVMARC ge_boInstanceControl.stysbValue;
          sbITDVSAFI ge_boInstanceControl.stysbValue;
          sbITDVMABO ge_boInstanceControl.stysbValue;
          sbITDVVALO ge_boInstanceControl.stysbValue;
          sbITDVOPUN ge_boInstanceControl.stysbValue;
          sbITDVSERI ge_boInstanceControl.stysbValue;
          sbDOVECLIE ge_boInstanceControl.stysbValue;--#NC-YYYYYX

      BEGIN
              -- carga los parametros del proceso
              sbDOVECODI := ge_boInstanceControl.fsbGetFieldValue ('LDCI_DOCUVENT', 'DOVECODI');
              sbITDVPROV := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ITEMDOVE', 'ITDVPROV');
              sbITDVOPUN := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ITEMDOVE', 'ITDVOPUN');
          sbDOVECLIE := ge_boInstanceControl.fsbGetFieldValue ('LDCI_DOCUVENT', 'DOVECLIE'); --#NC-YYYYYX

            ------------------------------------------------
            -- Required Attributes
            ------------------------------------------------
            if (sbDOVECODI is null) then
                    Errors.SetError (cnuNULL_ATTRIBUTE, 'NUMERO DOCUMENTO SAP');
                    raise pkg_error.CONTROLLED_ERROR;
            end if;

            if (sbITDVPROV is null) then
                    Errors.SetError (cnuNULL_ATTRIBUTE, 'UNIDAD OPERATIVA PROVEEDOR LOG???STICO');
                    raise pkg_error.CONTROLLED_ERROR;
            end if;

            if (sbITDVOPUN is null) then
                    Errors.SetError (cnuNULL_ATTRIBUTE, 'C???DIGO UNIDAD OPERATIVA');
                    raise pkg_error.CONTROLLED_ERROR;
            end if;

            if (sbDOVECLIE is null) then --#NC-YYYYYX
                    Errors.SetError (cnuNULL_ATTRIBUTE, 'NIT DEL CLIENTE');
                    raise pkg_error.CONTROLLED_ERROR;
            end if;


            -- carga el cusor referenciado
            open orfMoviMaterial for
                select DOVECODI || '|' || ITDVCODI || '|' || sbITDVOPUN || '|' || sbITDVPROV as "POSICION",
                            ITDVITEM  as "MATERIAL",
                            DESCRIPTION as "DESCRIPCION",
                            ITDVCANT  as "CANTIDAD DE MATERIAL",
                            ITDVVAUN  as "VALOR UNITARIO",
                            ITDVSERI  as "SERIE DEL ELEMENTO",
                            ITDVMARC  as "MARCA DEL MATERIAL",
                            ITDVSAFI  as "MARCA SALIDA FINAL",
                            ITDVMABO  as "MARCA BORRADO",
                            ITDVVALO  as "VALORACION N NUEVO / U USADO"
                    from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
                  where DOVECODI = sbDOVECODI
                      and DOVECODI = ITDVDOVE
                      and CODE = ITDVITEM  --#OYM_CEV_2740_1  ITEMS_ID --> CODE
                      and ITDVOPUN is null;

            return orfMoviMaterial;
      EXCEPTION
            when pkg_error.CONTROLLED_ERROR then
              raise;

            when OTHERS then
              Errors.setError;
              raise pkg_error.CONTROLLED_ERROR;
      END frfGetMaterialVendido;

      PROCEDURE ProNotiMaestroMovMaterial(inuMovMatCodi in LDCI_INTEMMIT.MMITCODI%type,
                                                                            isbDocFront   in  LDCI_INTEMMIT.MMITNUDO%type,
                                                                            isbPedFront   in  LDCI_INTEMMIT.MMITNUPE%type,
                                                                            isbDocSap     in  LDCI_INTEMMIT.MMITDSAP%type,
                                                                            isbTipoMov    in  LDCI_INTEMMIT.MMITTIMO%type,
                                                                            isbDescMov    in  LDCI_INTEMMIT.MMITDESC%type,
                                                                            isbSigno      in  LDCI_INTEMMIT.MMITNATU%type,
                                                                            isbCliente    in  LDCI_INTEMMIT.MMITCLIE%type,
                                                                            idtFechaDoc   in  LDCI_INTEMMIT.MMITFESA%type,
                                                                            inuValorTotal in  LDCI_INTEMMIT.MMITVTOT%type,
                                                                            idtFechaVenc  in  LDCI_INTEMMIT.MMITFEVE%type) As

      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : ProNotiMaestroMovMaterial
            AUTOR      : Eduardo Aguera
            FECHA      : 26/01/2012
            RICEF      : I004; I018
            DESCRIPCION: Realiza la insercion de un movimiento de isbMaterial
                                      contratistas/cuadrillas

          Historia de Modificaciones
          Autor    Fecha       Descripcion
          carlosvl 12/08/2011  Se hace la validacion de datos.
          carlosvl 17/09/2013  #NC-622: Se ajusta el procesamiento del identificador Front con el formato
                                              [Letra(s) que identifican la empresa]-[Tipo de Movimiento]-[Numero de la Solicitud]/[Nombre del solicitante]
                                              Ejemplo: GDO-Z03-335/995 JACK SPARROW
  */
          sbData varchar2(200) := '';
          excepNoDocuFront  EXCEPTION;  -- Excepcion: No llega el documento FRONT.
          excepNoDocuSAP    EXCEPTION;  -- Excepcion: No llega el documento SAP.
          excepNoisbTipoMovi    EXCEPTION;  -- Excepcion: No llega el Tipo Movimiento.
          excepNoSignMovi   EXCEPTION;  -- Excepcion: No llega el isbSigno Movimiento.
          excepNoFechDocu   EXCEPTION;  -- Excepcion: No llega el Fecha Documento.
          excepNoFechVenc   EXCEPTION;  -- Excepcion: No llega el Fecha Vencimiento.
      Begin
          --<< Valida que los datos lleguen con valores
          if (isbDocFront is null and isbPedFront is null) then
            RAISE excepNoDocuFront;
          end if;

          if (isbDescMov != 'INTSTATUSPEDIDO') then
                  if (isbTipoMov is null) then
                    RAISE excepNoisbTipoMovi;
                  end if;--if (isbTipoMov is null) then

                  if (isbSigno is null) then
                    RAISE excepNoSignMovi;
                  end if;--if (isbSigno is null) then
          end if;--if (isbDescMov = 'INTSTATUSPEDIDO') then
          -->>

          -- Realiza la insercion del movimiento
          Insert Into LDCI_INTEMMIT (MMITCODI,
                                                              MMITNUDO,
                                                              MMITNUPE,
                                                              MMITDSAP,
                                                              MMITTIMO,
                                                              MMITDESC,
                                                              MMITNATU,
                                                              MMITCLIE,
                                                              MMITFESA,
                                                              MMITVTOT,
                                                              MMITESTA,
                                                              MMITFEVE)
                                              values (inuMovMatCodi,
                                                              --#NC-622: carlosvl: 17/09/2013: Se remplaza el codigo  substr(trim(isbDocFront), 4, instr(trim(isbDocFront), '/', 1, 1) - 4) , por :
                                                              substr(trim(isbDocFront), instr(trim(isbDocFront), '-', 1, 2) + 1, instr(trim(isbDocFront), '/', 1, 1) - instr(trim(isbDocFront), '-', 1, 2) - 1),
                                                              isbPedFront,
                                                              isbDocSap,
                                                              decode(isbDescMov, 'INTSTATUSPEDIDO', 'STA',isbTipoMov),
                                                              isbDescMov,
                                                              decode(isbDescMov, 'INTSTATUSPEDIDO', '=',isbSigno),
                                                              isbCliente,
                                                              idtFechaDoc,
                                                              inuValorTotal,
                                                              '1',
                                                              idtFechaVenc);
      Exception
          when excepNoSignMovi then
              Raise_Application_Error(-20100, 'Error: No ha llegado isbSigno de Movimiento.');

          when excepNoisbTipoMovi then
              Raise_Application_Error(-20100, 'Error: No ha llegado Tipo de Movimiento.');

          when excepNoDocuFront then
              Raise_Application_Error(-20100, 'Error: No ha llegado el documento FRONT.');

          when excepNoDocuSAP then
              Raise_Application_Error(-20100, 'Error: No ha llegado el documento SAP.');

          When Others Then
              Raise_Application_Error(-20100, 'Error no controlado: '|| Sqlerrm || ' - ' || Dbms_Utility.Format_Error_Backtrace);
      End ProNotiMaestroMovMaterial;

      PROCEDURE proNotiDetalleMovMaterial(inuMovMatCodi    in  LDCI_DMITMMIT.DMITMMIT%type,
                                                                            inuDetMovMatCodi in  LDCI_DMITMMIT.DMITCODI%type,
                                                                            isbMaterial      in  LDCI_DMITMMIT.DMITITEM%type,
                                                                            inuCantidad      in  LDCI_DMITMMIT.DMITCANT%type,
                                                                            inuCantPend      in  LDCI_DMITMMIT.DMITCAPE%type,
                                                                            inuCostoUni      in  LDCI_DMITMMIT.DMITCOUN%type,
                                                                            inuValorUni      in  LDCI_DMITMMIT.DMITVAUN%type,
                                                                            inuPorcIva       in  LDCI_DMITMMIT.DMITPIVA%type,
                                                                            isbNumFac        in  LDCI_DMITMMIT.DMITNUFA%type,
                                                                            isbAlmDest       in  LDCI_DMITMMIT.DMITALDE%type,
                                                                            isbMarca         in  LDCI_DMITMMIT.DMITMARC%type,
                                                                            isbSaliFinal     in  LDCI_DMITMMIT.DMITSAFI%type,
                                                                            isbMarcBorrado   in  LDCI_DMITMMIT.DMITMABO%type,
                                                                            isbItemDoVal     in  VARCHAR2)
      As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proNotiDetalleMovMaterial
            AUTOR      : Eduardo Aguera
            FECHA      : 26/01/2012
            RICEF      : I004; I018
            DESCRIPCION: Realiza la insercion del detalle del movimiento

          Historia de Modificaciones
          Autor    Fecha      Descripcion
      */
          sbData varchar2(200) := '';
          nuDMITCOIN number;

          -- Cursor del encabezado del movimiento para detemrinar el status
          cursor cuLdcIntemmit(vDMITMMIT LDCI_DMITMMIT.DMITMMIT%type) is
            select *
                from LDCI_INTEMMIT
              where MMITCODI = vDMITMMIT;

          rtLdcIntemmit cuLdcIntemmit%rowtype; -- Cursor del encabezado del movimiento para detemrinar el estatus
      Begin

          --Select LDCI_SEQDMITMMIT.Nextval Into inuDetMovMatCodi From Dual;

          Sbdata:= inuMovMatCodi || ', ' || inuDetMovMatCodi || ', '|| isbMaterial || ',  '|| inuCantidad || ', ' || inuCostoUni;
          Sbdata:= Sbdata || ', ' || inuValorUni || ', ' || inuPorcIva || ', ' || isbNumFac || ', ' || isbAlmDest || ', ' || isbMarca || ', ' ||
                   isbSaliFinal || ', ' || isbMarcBorrado || ', ' || isbItemDoVal;

          -- Carga el encabezado del movimiento
          open cuLdcIntemmit(inuMovMatCodi);
          fetch cuLdcIntemmit into rtLdcIntemmit;
          close cuLdcIntemmit;

          nuDMITCOIN := fnuGetCodigoInternoItem(isbMaterial);

          -- Realiza la insercion en el detalle del movimiento de isbMaterial
          insert into LDCI_DMITMMIT (DMITMMIT,
                                                              DMITCODI,
                                                              DMITCOIN,
                                                              DMITITEM,
                                                              DMITCANT,
                                                              DMITCOUN,
                                                              DMITCAPE,
                                                              DMITVAUN,
                                                              DMITPIVA,
                                                              DMITNUFA,
                                                              DMITALDE,
                                                              DMITMARC,
                                                              DMITSAFI,
                                                              DMITMABO,
                                                              DMITVALO)
                                                              values
                                                            (inuMovMatCodi,
                                                              inuDetMovMatCodi,
                                                              nuDMITCOIN,
                                                              isbMaterial,
                                                              nvl(inuCantidad,0),
                                                              nvl(inuCostoUni,0),
                                                              nvl(inuCantPend,0),
                                                              nvl(inuValorUni,0),
                                                              nvl(inuPorcIva,0),
                                                              isbNumFac,
                                                              isbAlmDest,
                                                              isbMarca,
                                                              decode(isbSaliFinal, NULL, 'P','X','C', isbSaliFinal),
                                                              isbMarcBorrado,
                                                              decode(isbItemDoVal, 'USADO', 'U', 'N'));
      Exception
          When Others Then
              Raise_Application_Error(-20100, '[LDCI_1000768] Error insertando detalle [ '|| sbData|| ']: '|| Sqlerrm || Dbms_Utility.Format_Error_Backtrace);
      END proNotiDetalleMovMaterial;

      Procedure ProNotiSerialDetaMovi(inuMovMatCodi    in LDCI_SERIDMIT.SERIMMIT%type,
                      inuDetMovMatCodi in LDCI_SERIDMIT.SERIDMIT%type,
                      inuSeriMatCodi   in LDCI_SERIDMIT.SERICODI%type,
                      isbSerial        in LDCI_SERIDMIT.SERINUME%type) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : ProNotiSerialDetaMovi
            AUTOR      : Eduardo Aguera
            FECHA      : 26/01/2012
            RICEF      : I004; I018
            DESCRIPCION: Realiza la insercion del detalle del movimiento

          Historia de Modificaciones
          Autor    Fecha       Descripcion
          carlosvl 02-03-2015  138682: Registro de la referencia por marca
      */

        -- cursor para validar el la estructura
        cursor cuLDCI_CONTESSE(sbCOESCOSA LDCI_CONTESSE.COESCOSA%type) is
         select     'S'
           from LDCI_CONTESSE
          where COESCOSA = sbCOESCOSA;

        -- cursor para cargar la informacion de la posicion a validar
        cursor cuLDCI_DMITMMIT(nuDMITMMIT LDCI_DMITMMIT.DMITMMIT%type, nuDMITCODI LDCI_DMITMMIT.DMITCODI%type) is
            select *
              from LDCI_DMITMMIT
            where DMITMMIT = nuDMITMMIT
                and DMITCODI = nuDMITCODI;


        reLDCI_DMITMMIT       cuLDCI_DMITMMIT%rowtype;
          sbMESG VARCHAR2(4000);
        sbCrtlEstrSerial VARCHAR2(1) := 'N';
        excepProcesaSerial EXCEPTION; --138682
      Begin

          open cuLDCI_DMITMMIT(inuMovMatCodi,inuDetMovMatCodi);
          fetch cuLDCI_DMITMMIT into reLDCI_DMITMMIT;
          close cuLDCI_DMITMMIT;

          -- valida el listado de los items con seriales estructurados
          open cuLDCI_CONTESSE(reLDCI_DMITMMIT.DMITITEM);
          fetch cuLDCI_CONTESSE into sbCrtlEstrSerial;
          close cuLDCI_CONTESSE;

          if (sbCrtlEstrSerial = 'S') then
              -- procesa el serial y lo almacena
            LDCI_PKMATSERIALIZADO.PROSETSERIE(SBESTRSERI => isbSerial, SBMESG => SBMESG);

            INSERT INTO LDCI_SERIDMIT(SERIMMIT,
                          SERIDMIT,
                          SERICODI,
                          SERINUME,
                          SERIESTR,
                          SERIMARC,
                          SERIANO,
                          SERICAJA,
                          SERIREMA,
                          SERITIEN  )
                        VALUES
                        (INUMOVMATCODI,
                          INUDETMOVMATCODI,
                          INUSERIMATCODI,
                          LDCI_PKMATSERIALIZADO.fsbGetSerial,
                          LDCI_PKMATSERIALIZADO.fsbGetEstr,
                          LDCI_PKMATSERIALIZADO.fsbGetMarca,
                          LDCI_PKMATSERIALIZADO.fsbGetAno,
                          LDCI_PKMATSERIALIZADO.fsbGetCaja,
                          LDCI_PKMATSERIALIZADO.fsbRefMarc,
                          LDCI_PKMATSERIALIZADO.fsbTipoEnt);
          else
            -- almacena el serial tal como llega
            INSERT INTO LDCI_SERIDMIT(SERIMMIT,
                        SERIDMIT,
                        SERICODI,
                        SERINUME,
                        SERIESTR)
                      VALUES
                      (INUMOVMATCODI,
                        INUDETMOVMATCODI,
                        INUSERIMATCODI,
                        isbSerial,
                        isbSerial);
          end if;--if (sbCrtlEstrSerial = 'S') then

      Exception
         When excepProcesaSerial Then
           Raise_Application_Error(-20100, '[LDCI_1000863] Error insertando seriales ITEM ' || reLDCI_DMITMMIT.DMITITEM || ' SERIE ' || isbSerial || ' Err: ' || SBMESG);
         When Others Then
           Raise_Application_Error(-20100, '[LDCI_1000863] Error insertando seriales ITEM ' || reLDCI_DMITMMIT.DMITITEM || ' SERIE ' || isbSerial || ' ' || Sqlerrm);
      END ProNotiSerialDetaMovi;

      procedure proValidaSeriales(inuMovimiento   in  NUMBER,
                    onuErrorCode    out NUMBER,
                    osbErrorMessage out VARCHAR2) As
    /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          FUNCION    : LDCI_PKMOVIVENTMATE.proValidaSeriales
          AUTOR      : OLSoftware / Carlos E. Virgen
          FECHA      : 01-10-2013
          RICEF      : 138682
          DESCRIPCION: Valida que los seriales asignados tenga asigana marca y refrencia de lo contrario genera una excepci??n.

        Historia de Modificaciones
        Autor         Fecha        Descripcion
    */

      -- cursor para validar el la estructura
      cursor cuLDCI_CONTESSE(sbCOESCOSA LDCI_CONTESSE.COESCOSA%type) is
       select     'S'
         from LDCI_CONTESSE
        where COESCOSA = sbCOESCOSA;

      --Cursor: Listado de seriales por movimiento de material
      cursor cuMovimientoSerial(inuMovimiento NUMBER) is
        select MMITCODI, MMITNUDO, MMITNUPE, DMITITEM,LDCI_SERIDMIT.*
          from LDCI_INTEMMIT, LDCI_DMITMMIT, LDCI_SERIDMIT
         where MMITCODI = MMITCODI
           and MMITCODI = DMITMMIT
           and SERIMMIT = MMITCODI
           and DMITCODI = SERIDMIT
           and MMITCODI = inuMovimiento /*Id del movimiento de material*/;

      -- Cursor: Lista la informaci??n de la Marca
      cursor cuMarca (nuMarca LDCI_MARCA.MARCCODI%type) is
        select MARCCODI MARCA, MARCDESC DESCRIPCION
            from   LDCI_MARCA
          where  MARCCODI = nuMarca;

      -- Cursor: Lista la informaci??n de la Marca
      cursor cuRefMarca(inuMarca LDCI_MARCA.MARCCODI%type, inuRefMarca LDCI_REMEMARC.RMMACODI%type) is --138682: Cursor de la referencia por marca
        select MARCCODI MARCA, MARCDESC DESCRIPCION, RMMACODI REF_MARCA, RMMANDME TOPE
         from LDCI_MARCA, LDCI_REMEMARC
        where RMMAMARC =  MARCCODI
          and MARCCODI = inuMarca
          and RMMACODI = inuRefMarca;

      --Cursor: Valida cantidad de serial con respecto al numero de seriales asignados
      cursor cuValidaCantidadSerial(inuMovimiento NUMBER) is
        select DMITITEM ITEM, DMITCANT CANTIDAD, count(SERIDMIT) CANTIDAD_SERIALES
          from LDCI_INTEMMIT, LDCI_DMITMMIT, LDCI_SERIDMIT
         where MMITCODI = MMITCODI
           and MMITCODI = DMITMMIT
           and SERIMMIT = MMITCODI
           and DMITCODI = SERIDMIT
           and MMITCODI = inuMovimiento /*Id del movimiento de material*/
        group by DMITITEM,DMITCANT;

      nuCodigoMarca    LDCI_MARCA.MARCCODI%type;
      nuCodRefMarca    LDCI_REMEMARC.RMMACODI%type;--138682: C??digo de la refrencia por marca
      reRefMarca       cuRefMarca%rowtype;
      reMarca          cuMarca%rowtype;
      sbCrtlEstrSerial VARCHAR2(1);

      excepValidaCantSerial EXCEPTION;
      begin
       onuErrorCode    := 0;
       osbErrorMessage := NULL;

       --Valida la cantidad de serial
       for reValidaCantidadSerial in cuValidaCantidadSerial(inuMovimiento) loop
       if (reValidaCantidadSerial.CANTIDAD <> reValidaCantidadSerial.CANTIDAD_SERIALES) then
          osbErrorMessage := 'Item: ' || reValidaCantidadSerial.ITEM || ', el total de seriales asignados no es igual a la cantidad despachada.' || chr(13) ||
                           'Cantidad: ' || reValidaCantidadSerial.CANTIDAD || ' Total seriales: ' || reValidaCantidadSerial.CANTIDAD_SERIALES;
        RAISE excepValidaCantSerial;
       end if;--if (reValidaCantidadSerial.CANTIDAD <> reValidaCantidadSerial.CANTIDAD_SERIALES) then
       end loop;--for loop reValidaCantidadSerial in cuValidaCantidadSerial loop


       -- Valida la Marca y la Ref. por Marca
       for reMovimientoSerial in cuMovimientoSerial(inuMovimiento) loop
        sbCrtlEstrSerial := NULL;

        open cuLDCI_CONTESSE(reMovimientoSerial.DMITITEM);
        fetch cuLDCI_CONTESSE into sbCrtlEstrSerial;
        close cuLDCI_CONTESSE;

        if (sbCrtlEstrSerial = 'S') then

          nuCodigoMarca := nvl(to_number(substr(reMovimientoSerial.SERIESTR, 1, 2)),-1);
          nuCodRefMarca := nvl(to_number(substr(reMovimientoSerial.SERIESTR, length(reMovimientoSerial.SERIESTR) - 3, 2)),-1);


            if (nuCodigoMarca <> -1 and nuCodRefMarca <> -1) then
            -- Se obtiene la letra correspondiente a la marca
            open cuMarca (nuCodigoMarca);
            fetch cuMarca into reMarca;
            if (cuMarca%notfound) then

               osbErrorMessage := osbErrorMessage || 'Serie:' || reMovimientoSerial.SERIESTR || ' Marca:' || nuCodigoMarca || ' no encontrada';
               exit;
            end if;--if (cuMarca%notfound) then
            close cuMarca;


            open cuRefMarca (nuCodigoMarca, nuCodRefMarca); --138682: Abre el cursor de la referencia por marca
            fetch cuRefMarca into reRefMarca;
            if (cuRefMarca%notfound) then

               osbErrorMessage := osbErrorMessage || 'Serie:' || reMovimientoSerial.SERIESTR || ', Ref:' || nuCodRefMarca || ' no encontrada';
               exit;
            end if;--if (cuRefMarca%notfound) then
            close cuRefMarca;

          else
            osbErrorMessage := osbErrorMessage || 'Serie:' || reMovimientoSerial.SERIESTR || ' Marca o Ref. Marca tiene valor nulo';
            exit;
            end if;--if (nuCodigoMarca <> -1 and nuCodRefMarca <> -1) then

        end if;--if (sbCrtlEstrSerial = 'S') then

       end loop;--for cuMovimientoSerial in cuMovimientoSerial loop

      exception

        When excepValidaCantSerial Then
          onuErrorCode    := -1;
          osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proValidaSeriales.]:' || osbErrorMessage;
        When Others Then
          onuErrorCode    := -1;
          osbErrorMessage := '[LDCI_PKMOVIVENTMATE.proValidaSeriales]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
      end proValidaSeriales;

      procedure proActualizaMovimiento(inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
                                                                      isbTipo     in VARCHAR2,
                                                                      isMMITMENS  in  VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proActualizaMovimiento
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004; I018
            DESCRIPCION: Actualiza la tabla LDCI_INTEMMIT

          Historia de Modificaciones
          Autor   Fecha   Descripcion
      */
        cursor cuLDCI_INTEMMIT(inuMovimiento LDCI_INTEMMIT.MMITCODI%type) is
          select *
              from LDCI_INTEMMIT
            where MMITCODI = inuMovimiento;

        reLDCI_INTEMMIT cuLDCI_INTEMMIT%rowtype;
      begin
              rollback;

              open cuLDCI_INTEMMIT(inuMMITCODI);
              fetch cuLDCI_INTEMMIT into reLDCI_INTEMMIT;
              close cuLDCI_INTEMMIT;

              if (isbTipo = 'INTENTO') then
                  update LDCI_INTEMMIT set MMITMENS = isMMITMENS,
                                                      MMITINTE = MMITINTE + 1
                        where MMITCODI = inuMMITCODI;

                  LDCI_PKRESERVAMATERIAL.proNotificaExepcion(reLDCI_INTEMMIT.MMITNUDO,
                                                               'Excepcion de procesamiento movimiento de material (Req. Material), Mov. Ref. ' || nvl(reLDCI_INTEMMIT.MMITDSAP, 'N/A'),
                                         isMMITMENS);
              end if;--if (isbTipo = 'INTENTO') then

              if (isbTipo = 'CONFIRMADO') then
                  update LDCI_INTEMMIT set MMITESTA = 2
                        where MMITCODI = inuMMITCODI;
              end if;--if (isbTipo = 'CONFIRMADO') then

              if (isbTipo = 'CERRAERR') then
                  update LDCI_INTEMMIT set MMITESTA = 3,
                                                                    MMITMENS = isMMITMENS
                        where MMITCODI = inuMMITCODI;
              end if;--if (isbTipo = 'CERRAERR') then

            commit;
      end proActualizaMovimiento;

      procedure proSetRequestConf(inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
                                                            isbMMITTIMO in  LDCI_INTEMMIT.MMITTIMO%type,
                                                            inuDMITCODI in   LDCI_DMITMMIT.DMITCODI%type,
                                                            isbDMITITEM in   LDCI_DMITMMIT.DMITITEM%type,
                                                            ol_Payload  out CLOB,
                                                            osbMesjErr  out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proSetRequestConf
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004
            DESCRIPCION: genera el XML al API OS_SET_REQUEST_CONF

          Historia de Modificaciones
          Autor   Fecha   Descripcion
      */

        -- define variables
        qryCtx        DBMS_XMLGEN.ctxHandle;

        -- define excepciones
        excepNoProcesoRegi exception;
      begin
      -- genera el XML del encabezado
            -- valida el tipo de movimiento
            if(isbMMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
              -- tipos de movimiento Z01 Salida de Material / Z03 Salida de Herramientas
              qryCtx :=  Dbms_Xmlgen.Newcontext ('select
                                  cursor(select MMITNUDO     as "DOCUMENT_ID",
                                                    OPERATING_UNIT_ID as "OPERATING_UNIT_ID",
                                                    CURRENT_DATE as "DELIVERYDATE"
                                              from LDCI_INTEMMIT, GE_ITEMS_DOCUMENTO
                                                where MMITCODI = ' || to_char(inuMMITCODI) || '
                                                    and ID_ITEMS_DOCUMENTO = MMITNUDO) as "DOCUMENT",
                                  cursor (select DMITITEM /*DMITCOIN*/ as "ITEM_CODE" ,
                                                    decode(DMITSAFI, ''C'', 0, ''P'',nvl(DMITCAPE,0), nvl(DMITCAPE,0)) as "QUANTITY",
                                                   decode(DMITSAFI, ''C'', 0, ''P'',nvl(DMITCAPE,0), nvl(DMITCAPE,0)) * DMITCOUN as "COST"
                                          from LDCI_DMITMMIT
                                        where DMITMMIT = ' || to_char(inuMMITCODI) || '
                                      and  DMITCODI = :inuDMITCODI
                                      and DMITITEM = :isbDMITITEM) as "ITEMS" from dual');
            else
                    if(isbMMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/,reClaseMovi.sbDevoHerr)) then
                          -- tipos de movimiento Z02 Devolucion de Material / Z04 Devolucion de Herramientas
                          qryCtx :=  Dbms_Xmlgen.Newcontext ('select
                                              cursor(select MMITNUDO     as "DOCUMENT_ID",
                                                        OPERATING_UNIT_ID as "OPERATING_UNIT_ID",
                                                        CURRENT_DATE as "DELIVERYDATE"
                                                    from LDCI_INTEMMIT, GE_ITEMS_DOCUMENTO
                                                  where MMITCODI = ' || to_char(inuMMITCODI) || '
                                                      and ID_ITEMS_DOCUMENTO = MMITNUDO) as "DOCUMENT",
                                              cursor (select DMITITEM /*DMITCOIN*/ as "ITEM_CODE" ,
                                                    nvl(DMITCANT,0) + nvl(DMITCAPE,0) as "QUANTITY",
                                                    (nvl(DMITCANT,0) + nvl(DMITCAPE,0)) * DMITCOUN as "COST"
                                                      from LDCI_DMITMMIT
                                                    where DMITMMIT = ' || to_char(inuMMITCODI) || '
                                                  and  DMITCODI = :inuDMITCODI
                                                  and DMITITEM = :isbDMITITEM) as "ITEMS" from dual');
                    end if;--if(isbMMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
            end if;--if(isbMMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbMoviHerr)) then

            -- define las variables cl contexto qryCtx
            -- Asigna el valor de la variable :isbTipoRejeTras
            DBMS_XMLGEN.setBindvalue (qryCtx, 'inuDMITCODI', inuDMITCODI);
            DBMS_XMLGEN.setBindvalue (qryCtx, 'isbDMITITEM', isbDMITITEM);

            DBMS_XMLGEN.setRowSetTag(qryCtx, 'REQUEST_CONF');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            ol_Payload := dbms_xmlgen.getXML(qryCtx);
            --Valida si proceso registros
            if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
                      RAISE excepNoProcesoRegi;
            end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

            dbms_xmlgen.closeContext(qryCtx);
            ol_Payload := replace(ol_Payload, '<DOCUMENT_ROW>',  '');
            ol_Payload := replace(ol_Payload, '</DOCUMENT_ROW>',  '');
            ol_Payload := replace(ol_Payload, '<ITEMS_ROW>',  '<ITEM>');
            ol_Payload := replace(ol_Payload, '</ITEMS_ROW>', '</ITEM>');
            ol_Payload := trim(ol_Payload);

      Exception
          WHEN excepNoProcesoRegi THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proSetRequestConf]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
          When Others Then
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proSetRequestConf]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proSetRequestConf;

      procedure proGenXMLItemSeriVendido(isbDOVECODI in  LDCI_DOCUVENT.DOVECODI%type,
                                                                          inuITDVPROV in  LDCI_ITEMDOVE.ITDVPROV%type,
                                                                          inuITDVCODI in  LDCI_ITEMDOVE.ITDVCODI%type,
                                                                          isbITDVITEM in  LDCI_ITEMDOVE.ITDVITEM%type,
                                                                          inuITDVOPUN in  LDCI_ITEMDOVE.ITDVOPUN%type,
                                                                          isbTipoMovi in  VARCHAR2,
                                                                          ol_Payload  out CLOB,
                                                                          osbMesjErr  out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proGenXMLItemSeriVendido
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 01-10-2013
            RICEF      : I064
            DESCRIPCION: genera el XML al API API_LOADACCEPT_ITEMS

          Historia de Modificaciones
          Autor         Fecha        Descripcion
          carlos.virgen 27-05-2014   #FAC_CEV_3655_1: Ajuste para se ingresen los elementos seriados con costo cero
      */
       -- cursor de la posici??A?n vendida
       cursor cuLDCI_ITEMDOVE(isbITDVDOVE in  LDCI_ITEMDOVE.ITDVDOVE%type, inuITDVCODI in  LDCI_ITEMDOVE.ITDVCODI%type) is
          select ITDVDOVE, ITDVSERI
              from LDCI_ITEMDOVE
              where ITDVDOVE = isbITDVDOVE
                and ITDVCODI = inuITDVCODI;

        -- define variables
        qryCtx        DBMS_XMLGEN.ctxHandle;
        reLDCI_ITEMDOVE cuLDCI_ITEMDOVE%rowtype;

        -- define excepciones
        excepNoProcesoRegi exception;
      begin
            -- Si el tipo de movimiento es I, indica que incrementara en bodega y coloca la cantidad positiva
            if (isbTipoMovi = 'I') then
                    -- genera el XML con cantidad positiva
                    --#FAC_CEV_3655_1: Se ajusta la consulta del nuevo contexto para que el campo COST sea cero
                    qryCtx :=  Dbms_Xmlgen.Newcontext ('select :inuITDVPROV as "OPERUNIT_ORIGIN_ID",
                                                                                                        :inuITDVOPUN as "OPERUNIT_TARGET_ID",
                                                                                                        to_char(DOVEFESA, ''DD/MM/YYYY'') as "DATE",
                                                                                                        DOVECODI as "DOCUMENT",
                                                                                                        DOVECODI as "REFERENCE",
                                                                                                        ITDVITEM /*ITDVCOIN*/ as "ITEM_CODE",
                                                                                                        nvl(ITDVCANT * decode(DOVENATU, ''+'',  1, ''-'', -1), 0) as "QUANTITY",
                                                                                                        0   /*ITDVVAUN*/ as "COST",
                                                                                                        ITDVVALO as "STATUS",
                                                                                                        ITDVSERI as "SERIE",
                                                                                                        ''ATTRIBUTES'' as "ATTRIBUTES"
                                                                                              from LDCI_DOCUVENT, LDCI_ITEMDOVE
                                                                                            where DOVECODI = :isbDOVECODI
                                                                                                and ITDVCODI = :inuITDVCODI
                                                                                                and DOVECODI = ITDVDOVE');

                    -- asigna las valores para la consulta
                    DBMS_XMLGEN.setBindvalue (qryCtx, 'isbDOVECODI', isbDOVECODI);
                    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuITDVPROV', inuITDVPROV);
                    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuITDVCODI', inuITDVCODI);
                    DBMS_XMLGEN.setBindvalue (qryCtx, 'inuITDVOPUN', inuITDVOPUN);

            end if;--if (isbTipoMovi = 'I') then

            DBMS_XMLGEN.setRowSetTag(qryCtx, 'ITEMS_LOADACEPT');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            ol_Payload := dbms_xmlgen.getXML(qryCtx);
            --Valida si proceso registros
            if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
                      RAISE excepNoProcesoRegi;
            end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

            dbms_xmlgen.closeContext(qryCtx);

            open cuLDCI_ITEMDOVE(isbDOVECODI, inuITDVCODI);
            fetch cuLDCI_ITEMDOVE into reLDCI_ITEMDOVE;
            close cuLDCI_ITEMDOVE;

            -- determina los atributos del item seriado
            ol_Payload := replace(ol_Payload, '<ATTRIBUTES>ATTRIBUTES</ATTRIBUTES>',  nvl(fclGetXMLAttributes(null,
                                                                                                       null,
                                                                                                                                                                                                  null,
                                                                                                                                                                                                  reLDCI_ITEMDOVE.ITDVDOVE,
                                                                                                                                                                                                  reLDCI_ITEMDOVE.ITDVSERI,
                                                                                                                                                                                                  'VENTA'),''));


            ol_Payload := trim(ol_Payload);
      Exception
      WHEN excepNoProcesoRegi THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLItemSeriVendido]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
          When Others Then
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLItemSeriVendido]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proGenXMLItemSeriVendido;

      procedure proGenXMLAceptItemSeriado(inuDMITMMIT in  LDCI_DMITMMIT.DMITMMIT%type,
                                                                            inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
                                                                            inuSERICODI in  LDCI_SERIDMIT.SERICODI%type,
                                                                            isbTipoMovi in  VARCHAR2,
                                                                            ol_Payload  out CLOB,
                                                                            osbMesjErr  out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proGenXMLAceptItemSeriado
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004
            DESCRIPCION: genera el XML al API API_LOADACCEPT_ITEMS

          Historia de Modificaciones
          Autor   Fecha   Descripcion
      */
        -- cursor del item seriado
        cursor cuItemSeriado(inuDMITMMIT in  LDCI_DMITMMIT.DMITMMIT%type,
                                                inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
                                                inuSERICODI in  LDCI_SERIDMIT.SERICODI%type) is
              select  Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
                            Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
                            Mov.MMITFESA as "DATE",
                            Mov.MMITDSAP as "DOCUMENT",
                            Mov.MMITDSAP as "REFERENCE",
                            Det.DMITITEM as "ITEM_CODE",
                            1 as "QUANTITY",
                            Det.DMITCOUN as "COST",
                            Det.DMITVALO as "STATUS",
                            Ser.SERINUME as "SERIE"
              from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser, GE_ITEMS_DOCUMENTO Doc
              where Det.DMITCODI = inuMMITCODI
                  and Det.DMITMMIT = inuDMITMMIT
                  and Mov.MMITCODI = Det.DMITMMIT
                  and Ser.SERIMMIT = Det.DMITMMIT
                  and Ser.SERIDMIT = Det.DMITCODI
                  and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
                  and Ser.SERICODI = inuSERICODI;

        -- variables de tipo registro
        reItemSeriado cuItemSeriado%rowtype;
        -- define variables
        qryCtx        DBMS_XMLGEN.ctxHandle;

        -- define excepciones
        excepNoProcesoRegi exception;
      begin

            -- Si el tipo de movimiento es I, indica que incrementara en bodega y coloca la cantidad positiva
            if (isbTipoMovi = 'I') then
                    -- genera el XML con cantidad positiva
                    qryCtx :=  Dbms_Xmlgen.Newcontext ('select Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
                                          Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
                                          to_char(Mov.MMITFESA,''DD/MM/YYYY'') as "DATE",
                                          Mov.MMITDSAP as "DOCUMENT",
                                          Mov.MMITDSAP as "REFERENCE",
                                          Det.DMITITEM /*Det.DMITCOIN*/ as "ITEM_CODE",
                                          1 as "QUANTITY",
                                          Det.DMITCOUN as "COST",
                                          Det.DMITVALO as "STATUS",
                                          Ser.SERINUME as "SERIE",
                                          ''ATTRIBUTES'' as "ATTRIBUTES"
                            from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser, GE_ITEMS_DOCUMENTO Doc
                            where Det.DMITCODI = ' || to_char(inuMMITCODI) || '
                                and Det.DMITMMIT = ' || to_char(inuDMITMMIT) || '
                                and Mov.MMITCODI = Det.DMITMMIT
                                and Ser.SERIMMIT = Det.DMITMMIT
                                and Ser.SERIDMIT = Det.DMITCODI
                                and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
                                and Ser.SERICODI = ' || to_char(inuSERICODI));
            end if;--if (isbTipoMovi = 'I') then

            -- Si el tipo de movimiento es D, indica que disminuye en bodega y coloca la cantidad negativa
            if (isbTipoMovi = 'D') then
                  -- genera el XML con cantidad negativa
                  qryCtx :=  Dbms_Xmlgen.Newcontext ('select Doc.DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
                                        Doc.OPERATING_UNIT_ID as "OPERUNIT_TARGET_ID",
                                        to_char(Mov.MMITFESA,''DD/MM/YYYY'') as "DATE",
                                        Mov.MMITDSAP as "DOCUMENT",
                                        Mov.MMITDSAP as "REFERENCE",
                                        Det.DMITITEM /*Det.DMITCOIN*/ as "ITEM_CODE",
                                        -1 as "QUANTITY",
                                        Det.DMITCOUN as "COST",
                                        Det.DMITVALO as "STATUS",
                                        Ser.SERINUME as "SERIE",
                                        ''ATTRIBUTES'' as "ATTRIBUTES"
                          from LDCI_INTEMMIT Mov, LDCI_DMITMMIT Det, LDCI_SERIDMIT Ser, GE_ITEMS_DOCUMENTO Doc
                          where Det.DMITCODI = ' || to_char(inuMMITCODI) || '
                              and Det.DMITMMIT = ' || to_char(inuDMITMMIT) || '
                              and Mov.MMITCODI = Det.DMITMMIT
                              and Ser.SERIMMIT = Det.DMITMMIT
                              and Ser.SERIDMIT = Det.DMITCODI
                              and Doc.ID_ITEMS_DOCUMENTO = Mov.MMITNUDO
                              and Ser.SERICODI = ' || to_char(inuSERICODI));
            end if;--if (isbTipoMovi = 'D') then

            -- Si el tipo de movimiento es R, indica que sera removido de la bodega del proveedor logistico y coloca la cantidad negativa
            -- Esta condicion aparece para el caso de una devolucion de material serializado aceptada y que necesita ser anuladaa
            if (isbTipoMovi = 'R')  then
                  -- #TODO Se debe
                  null;
            end if;--if (isbTipoMovi = 'R')

            DBMS_XMLGEN.setRowSetTag(qryCtx, 'ITEMS_LOADACEPT');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            ol_Payload := dbms_xmlgen.getXML(qryCtx);
            --Valida si proceso registros
            if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
                      RAISE excepNoProcesoRegi;
            end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

            dbms_xmlgen.closeContext(qryCtx);

            ol_Payload := replace(ol_Payload, '<ATTRIBUTES>ATTRIBUTES</ATTRIBUTES>',  nvl(fclGetXMLAttributes(inuDMITMMIT,
                                                                                                       inuMMITCODI,
                                                                                                                                                                                                  inuSERICODI,
                                                                                                                                                                                                  null,
                                                                                                                                                                                                  null,
                                                                                                                                                                                                  'CONSUMO'),''));


            ol_Payload := trim(ol_Payload);
      Exception
      WHEN excepNoProcesoRegi THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAceptItemSeriado]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
          When Others Then
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAceptItemSeriado]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proGenXMLAceptItemSeriado;

      procedure proGenXMLAceptItem(inuMMITCODI in  LDCI_INTEMMIT.MMITCODI%type,
                                                              inuDMITCODI in  LDCI_DMITMMIT.DMITCODI%type,
                                                              isbDMITITEM in  LDCI_DMITMMIT.DMITITEM%type,
                                                              isbTipoMovi in  VARCHAR2,
                                                              ol_Payload  out CLOB,
                                                              osbMesjErr  out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proGenXMLAceptItem
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004
            DESCRIPCION: genera el XML al API API_LOADACCEPT_ITEMS

          Historia de Modificaciones
          Autor   Fecha   Descripcion
      */

        -- define variables
        qryCtx        DBMS_XMLGEN.ctxHandle;

        -- define excepciones
        excepNoProcesoRegi exception;
      begin
            if (isbTipoMovi = 'I') then
                    -- genera el XML con la cantidad positiva
                    qryCtx :=  Dbms_Xmlgen.Newcontext ('select  DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
                                          OPERATING_UNIT_ID        as "OPERUNIT_TARGET_ID",
                                          to_char(MMITFESA,''DD/MM/YYYY'') as "DATE",
                                          MMITDSAP                 as "DOCUMENT",
                                          MMITDSAP                 as "REFERENCE",
                                          DMITITEM /*DMITCOIN */    as "ITEM_CODE",
                                          DMITCANT                 as "QUANTITY",
                                          DMITCANT * DMITCOUN      as "COST",
                                          DMITVALO                 as "STATUS"
                            from LDCI_INTEMMIT, LDCI_DMITMMIT, GE_ITEMS_DOCUMENTO
                          where DMITCODI = ' || to_char(inuDMITCODI) || '
                              and DMITMMIT = ' || to_char(inuMMITCODI) || '
                              and DMITITEM = ' || isbDMITITEM || '
                              and DMITMMIT = MMITCODI
                              and ID_ITEMS_DOCUMENTO = MMITNUDO');
            else
                    -- genera el XML con la cantidad negativa
                    qryCtx :=  Dbms_Xmlgen.Newcontext ('select  DESTINO_OPER_UNI_ID as "OPERUNIT_ORIGIN_ID",
                                          OPERATING_UNIT_ID        as "OPERUNIT_TARGET_ID",
                                          to_char(MMITFESA,''DD/MM/YYYY'') as "DATE",
                                          MMITDSAP                 as "DOCUMENT",
                                          MMITDSAP                 as "REFERENCE",
                                          DMITITEM  /*DMITCOIN*/    as "ITEM_CODE",
                                          DMITCANT * -1            as "QUANTITY",
                                          DMITCANT * DMITCOUN      as "COST",
                                          DMITVALO                 as "STATUS"
                            from LDCI_INTEMMIT, LDCI_DMITMMIT, GE_ITEMS_DOCUMENTO
                          where DMITCODI = ' || to_char(inuDMITCODI) || '
                              and DMITMMIT = ' || to_char(inuMMITCODI) || '
                              and DMITITEM = ' || isbDMITITEM || '
                              and DMITMMIT = MMITCODI
                              and ID_ITEMS_DOCUMENTO = MMITNUDO');

            end if;--if (isbTipoMovi = 'I') then

            DBMS_XMLGEN.setRowSetTag(qryCtx, 'ITEMS_LOADACEPT');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            ol_Payload := dbms_xmlgen.getXML(qryCtx);
            --Valida si proceso registros
            if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
                      RAISE excepNoProcesoRegi;
            end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

            dbms_xmlgen.closeContext(qryCtx);
            ol_Payload := trim(ol_Payload);

      Exception
      WHEN excepNoProcesoRegi THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAceptItem]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
          When Others Then
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAceptItem]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proGenXMLAceptItem;

      procedure proGenXMLAcepTrasItemSeri(inuMMITCODI     in  LDCI_INTEMMIT.MMITCODI%type,
                        inuDMITCODI     in  LDCI_DMITMMIT.DMITCODI%type,
                        inuSERICODI     in  LDCI_SERIDMIT.SERICODI%type,
                        isbRejectItem   in VARCHAR2,
                        isbTipoRejeTras in VARCHAR2,
                        ol_Payload      out CLOB,
                        osbMesjErr      out VARCHAR2) As
      /*
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
      FUNCION    : proGenXMLAcepTrasItemSeri
      AUTOR      : OLSoftware / Carlos E. Virgen
      FECHA      : 15-01-2013
      RICEF      : I004
      DESCRIPCION: genera el XML al API API_ACCEPT_ITEM

      Historia de Modificaciones
      Autor                                   Fecha   Descripcion
      carlosvl <carlos.virgen@olsoftware.com> 30-04-2015 #6848: Se implementa la asignacion parametro       <ID_ITEM_DOCUMENTO></ID_ITEM_DOCUMENTO>
      */

        -- define variables
        qryCtx        DBMS_XMLGEN.ctxHandle;

        -- define excepciones
        excepNoProcesoRegi exception;
      begin

        qryCtx :=  Dbms_Xmlgen.Newcontext ('select
                          cursor(select DESTINO_OPER_UNI_ID as "OPERATING_UNIT",
                              DMITITEM /*DMITCOIN*/  as "ITEM_CODE",
                              SERINUME as "SERIE",
                              1        as "QUANTITY",
                              MMITDSAP as "SUPPORT_DOCUMENT",
                                                            ID_ITEMS_DOCUMENTO as "ID_ITEM_DOCUMENTO" /*6848: Agrega  campo*/
                            from LDCI_INTEMMIT, LDCI_DMITMMIT, LDCI_SERIDMIT, GE_ITEMS_DOCUMENTO
                          where DMITCODI = ' || to_char(inuDMITCODI) || '
                              and DMITMMIT = ' || to_char(inuMMITCODI) || '
                              and SERICODI = ' || to_char(inuSERICODI)  || '
                              and MMITCODI = DMITMMIT
                              and SERIMMIT = DMITMMIT
                              and SERIDMIT = DMITCODI
                              and ID_ITEMS_DOCUMENTO = MMITNUDO) as "ITEM" from DUAL');

        -- valida si acepta o rechaza un item isbRejectItem [A]cepta / [R]echaza
        if (isbRejectItem = 'A') then
          DBMS_XMLGEN.setRowSetTag(qryCtx, 'ACEPT_ITEM');
        else
          if (isbRejectItem = 'R') then
            DBMS_XMLGEN.setRowSetTag(qryCtx, 'REJECT_ITEM');
          end if;--if (isbRejectItem = 'R') then
        end if;--if (isbRejectItem = 'A') then

        DBMS_XMLGEN.setRowTag(qryCtx, '');
        ol_Payload := dbms_xmlgen.getXML(qryCtx);

        --Valida si proceso registros
        if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
          RAISE excepNoProcesoRegi;
        end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

        dbms_xmlgen.closeContext(qryCtx);
        ol_Payload := replace(ol_Payload, '<ITEM_ROW>',  '');
        ol_Payload := replace(ol_Payload, '</ITEM_ROW>',  '');
        ol_Payload := trim(ol_Payload);

      Exception
        WHEN excepNoProcesoRegi THEN
          osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAcepTrasItemSeri]: La consulta no ha arrojo registros';
        When Others Then
          osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAcepTrasItemSeri]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
      end proGenXMLAcepTrasItemSeri;--proGenXMLAcepTrasItemSeri;

      procedure proGenXMLRejectTrasItemSeri(inuID_ITEMS_DOCUMENTO in  NUMBER,
                                isbSERIE              in  VARCHAR2,                                   isbDOCSAP             in  VARCHAR2,                                   ol_Payload            out CLOB,                                   osbMesjErr            out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proGenXMLRejectTrasItemSeri
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 18-12-2013
            RICEF      : NC-2229
            DESCRIPCION: genera el XML al API REJECT_ITEM

            Historia de Modificaciones
            Autor                                   Fecha      Descripcion
            carlosvl <carlos.virgen@olsoftware.com> 30-04-2015 #6848: Se implementa la asignacion parametro       <ID_ITEM_DOCUMENTO></ID_ITEM_DOCUMENTO>
      */

        -- define variables
        qryCtx        DBMS_XMLGEN.ctxHandle;

        -- define excepciones
        excepNoProcesoRegi exception;
      begin

            qryCtx :=  Dbms_Xmlgen.Newcontext ('select
                                                                                                cursor
                                                                                                (
                                                                                                    select  /*+ LEADING(OR_UNI_ITEM_BALA_MOV)
                          INDEX(OR_UNI_ITEM_BALA_MOV IDX_OR_UNI_ITEM_BALA_MOV01)
                          INDEX(GE_ITEMS_SERIADO PK_GE_ITEMS_SERIADO)
                          INDEX(GE_ITEMS PK_GE_ITEMS)
                          INDEX(GE_ITEMS_DOCUMENTO PK_GE_ITEMS_DOCUMENTO)*/
                          OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID as "OPERATING_UNIT",
                          GE_ITEMS.CODE as "ITEM_CODE",
                          OR_UNI_ITEM_BALA_MOV.AMOUNT as "QUANTITY",
                          :isbDOCSAP as "SUPPORT_DOCUMENT",
                          GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO as "ID_ITEM_DOCUMENTO" /*6848: Agrega nuevo campo*/,
                          GE_ITEMS_SERIADO.SERIE
                      from  OR_UNI_ITEM_BALA_MOV,
                                  OR_OPE_UNI_ITEM_BALA,
                                  GE_ITEMS_SERIADO,
                                  GE_ITEMS,
                                  GE_ITEMS_DOCUMENTO
                    where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
                        and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
                        and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
                        and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = ''N'' --OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE
                        and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
                        and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = '' ''
                        and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
                        and  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO = :inuID_ITEMS_DOCUMENTO
                        and  GE_ITEMS_SERIADO.SERIE = :isbSERIE
                  ) as "ITEM"
                        from DUAL');

            -- Asigna el valor de la variable :isbTipoRejeTras
            DBMS_XMLGEN.setBindvalue (qryCtx, 'inuID_ITEMS_DOCUMENTO', inuID_ITEMS_DOCUMENTO);
            DBMS_XMLGEN.setBindvalue (qryCtx, 'isbSERIE', isbSERIE);
            DBMS_XMLGEN.setBindvalue (qryCtx, 'isbDOCSAP', isbDOCSAP);

            -- valida si acepta o rechaza un item isbRejectItem [A]cepta / [R]echaza
            DBMS_XMLGEN.setRowSetTag(qryCtx, 'REJECT_ITEM');
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            ol_Payload := dbms_xmlgen.getXML(qryCtx);
            --Valida si proceso registros
            if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
                      RAISE excepNoProcesoRegi;
            end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

            dbms_xmlgen.closeContext(qryCtx);
            ol_Payload := replace(ol_Payload, '<ITEM_ROW>',  '');
            ol_Payload := replace(ol_Payload, '</ITEM_ROW>',  '');
            ol_Payload := trim(ol_Payload);

      Exception
      WHEN excepNoProcesoRegi THEN
          osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLRejectTrasItemSeri]: La consulta no ha arrojo registros' || DBMS_UTILITY.format_error_backtrace;
      When Others Then
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLRejectTrasItemSeri]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proGenXMLRejectTrasItemSeri;--proGenXMLRejectTrasItemSeri;

      procedure proGenXMLAcepTrasItem(inuMMITCODI     in  LDCI_INTEMMIT.MMITCODI%type,
                      inuDMITCODI     in  LDCI_DMITMMIT.DMITCODI%type,
                      isbDMITITEM     in  LDCI_DMITMMIT.DMITITEM%type,
                      isbRejectItem   in VARCHAR2,
                      isbTipoRejeTras in VARCHAR2,
                      ol_Payload      out CLOB,
                      osbMesjErr      out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proGenXMLAcepTrasItem
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004
            DESCRIPCION: genera el XML al API API_ACCEPT_ITEM

          Historia de Modificaciones
          Autor                                   Fecha   Descripcion
                    carlosvl <carlos.virgen@olsoftware.com> 30-04-2015 #6848: Se implementa la asignacion parametro       <ID_ITEM_DOCUMENTO></ID_ITEM_DOCUMENTO>
      */

      -- define variables
      qryCtx        DBMS_XMLGEN.ctxHandle;

      -- define excepciones
      excepNoProcesoRegi exception;
      begin
      -- genera el XML
      qryCtx :=  Dbms_Xmlgen.Newcontext ('select
                      cursor(select DESTINO_OPER_UNI_ID as "OPERATING_UNIT",
                              DMITITEM /*DMITCOIN*/ as "ITEM_CODE",
                              decode(:isbTipoRejeTras,''T'', DMITCANT, ''P'', DMITCAPE, ''R'', DMITCAPE, DMITCANT) as "QUANTITY",
                              MMITDSAP as "SUPPORT_DOCUMENT",
                              ID_ITEMS_DOCUMENTO as "ID_ITEM_DOCUMENTO" /*6848: Agrega nuevo campo*/
                          from LDCI_INTEMMIT, LDCI_DMITMMIT, GE_ITEMS_DOCUMENTO
                              where DMITCODI = ' || to_char(inuDMITCODI) || '
                              and DMITMMIT = ' || to_char(inuMMITCODI) || '
                              and DMITITEM = ' || isbDMITITEM || '
                              and MMITCODI = DMITMMIT
                              and ID_ITEMS_DOCUMENTO = MMITNUDO) as "ITEM"
                        from DUAL');

      -- Asigna el valor de la variable :isbTipoRejeTras
      DBMS_XMLGEN.setBindvalue (qryCtx, 'isbTipoRejeTras', isbTipoRejeTras);

      -- valida si acepta o rechaza un item isbRejectItem [A]cepta / [R]echaza
      if (isbRejectItem = 'A') then
        DBMS_XMLGEN.setRowSetTag(qryCtx, 'ACEPT_ITEM');
      else
        if (isbRejectItem = 'R') then
        DBMS_XMLGEN.setRowSetTag(qryCtx, 'REJECT_ITEM');
        end if;--if (isbRejectItem = 'R') then
      end if;--if (isbRejectItem = 'A') then

      DBMS_XMLGEN.setRowTag(qryCtx, '');
      ol_Payload := dbms_xmlgen.getXML(qryCtx);
      --Valida si proceso registros
      if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
        RAISE excepNoProcesoRegi;
      end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

      dbms_xmlgen.closeContext(qryCtx);
      ol_Payload := replace(ol_Payload, '<ITEM_ROW>',  '');
      ol_Payload := replace(ol_Payload, '</ITEM_ROW>',  '');
      ol_Payload := trim(ol_Payload);

      Exception
        WHEN excepNoProcesoRegi THEN
          osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAcepTrasItem]: La consulta no ha arrojo registros';
        When Others Then
          osbMesjErr := '[LDCI_PKMOVIMATERIAL.proGenXMLAcepTrasItem]:' || chr(13) ||  'Error no controlado: ' || SQLERRM;
      end proGenXMLAcepTrasItem;--proGenXMLAcepTrasItem;

      procedure proAcepTrastItem(inuMovimiento in  LDCI_INTEMMIT.MMITCODI%type,
                                                          osbMesjErr    out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proAcepTrastItem
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004
            DESCRIPCION: genera el XML al API API_ACCEPT_ITEM

          Historia de Modificaciones
          Autor    Fecha      Descripcion
          carlosvl 16-10-2013 #NC-933   - Validacion para el item con cantidad cero y marca de borrado
          carlosvl 16-10-2013 #NC-2228  - NC:En la anulaci??A?n de un movimiento en SAP, cre??A? un registro en OSF con un c??A?digo nuevo
                                          AJ:Se valida que en la anulacion de un traslado item seriado, este se encuentre en poder de una unidad operativa
                                                                    clasificacion 11-Proveedor Logistico

          carlosvl 16-10-2013 #NC-2229  - NC: Rechazo en SAP por la forma Reserva gener??A? mensaje de Error
                                        - AJ: Se debe validar el indicador de salida final para determina el traslado parcial de una devolucion


      */

        -- define cursores
        -- #NC-2229:19-12-2013:carlos.virgen: Cursor para extraer la informacion del item
        cursor cuGE_ITEMS(isbCODE VARCHAR2) is
        select ITEMS_ID, DESCRIPTION, ITEM_CLASSIF_ID, ID_ITEMS_TIPO, CODE
            from GE_ITEMS
          where CODE = isbCODE;

        -- #NC-2229:19-12-2013:carlos.virgen: Cursor para determinar los items en transito
        cursor cuItemSeriadoTransito(inuID_ITEMS_DOCUMENTO  NUMBER, isbITEM_CODE VARCHAR2) is
          select  /*+ LEADING(OR_UNI_ITEM_BALA_MOV)
              INDEX(OR_UNI_ITEM_BALA_MOV IDX_OR_UNI_ITEM_BALA_MOV01)
              INDEX(GE_ITEMS_SERIADO PK_GE_ITEMS_SERIADO)
              INDEX(GE_ITEMS PK_GE_ITEMS)
              INDEX(GE_ITEMS_DOCUMENTO PK_GE_ITEMS_DOCUMENTO)*/
              GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO,
              TRUNC(MOVE_DATE) MOVE_DATE,
              GE_ITEMS.ITEMS_ID||' - '||GE_ITEMS.DESCRIPTION DESCRIPTION,
              GE_ITEMS.CODE CODE,
              OR_UNI_ITEM_BALA_MOV.AMOUNT,
              OR_UNI_ITEM_BALA_MOV.TOTAL_VALUE,
              GE_ITEMS_SERIADO.SERIE,
              OR_UNI_ITEM_BALA_MOV.TARGET_OPER_UNIT_ID OPERATING_UNIT_ID,
              OR_UNI_ITEM_BALA_MOV.USER_ID,
              OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID TARGET_OPER_UNIT_ID,
              GE_ITEMS_SERIADO.ID_ITEMS_SERIADO Iditemser
          from  OR_UNI_ITEM_BALA_MOV,
            OR_OPE_UNI_ITEM_BALA,
            GE_ITEMS_SERIADO,
            GE_ITEMS,
            GE_ITEMS_DOCUMENTO
          where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
          and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
          and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
          and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' --OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE
          and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
          and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = ' '
          and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
          and  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO
          and  GE_ITEMS.CODE = isbITEM_CODE;

        --#6848: Cursor del item en transito
        cursor cuItemNoSeriadoTransito(inuID_ITEMS_DOCUMENTO NUMBER, isbITEM_CODE VARCHAR2) is
          select  /*+ LEADING(OR_UNI_ITEM_BALA_MOV)
              INDEX(OR_UNI_ITEM_BALA_MOV IDX_OR_UNI_ITEM_BALA_MOV01)
              INDEX(GE_ITEMS_SERIADO PK_GE_ITEMS_SERIADO)
              INDEX(GE_ITEMS PK_GE_ITEMS)
              INDEX(GE_ITEMS_DOCUMENTO PK_GE_ITEMS_DOCUMENTO)*/
              count(*) EXISTE
          from  OR_UNI_ITEM_BALA_MOV,
            OR_OPE_UNI_ITEM_BALA,
            GE_ITEMS_SERIADO,
            GE_ITEMS,
            GE_ITEMS_DOCUMENTO
          where  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = GE_ITEMS.ITEMS_ID
            and  OR_UNI_ITEM_BALA_MOV.ITEMS_ID = OR_OPE_UNI_ITEM_BALA.ITEMS_ID
            and  OR_UNI_ITEM_BALA_MOV.OPERATING_UNIT_ID = OR_OPE_UNI_ITEM_BALA.OPERATING_UNIT_ID
            and  OR_UNI_ITEM_BALA_MOV.MOVEMENT_TYPE = 'N' --OR_BOITEMSMOVE.CSBNEUTRALMOVETYPE
            and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_DOCUMENTO = GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO
            and  OR_UNI_ITEM_BALA_MOV.SUPPORT_DOCUMENT = ' '
            and  OR_UNI_ITEM_BALA_MOV.ID_ITEMS_SERIADO = GE_ITEMS_SERIADO.ID_ITEMS_SERIADO (+)
            and  GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO
            and  GE_ITEMS.CODE = isbITEM_CODE;

        -- #NC-2228: cursor para validar si un item seriado se encuenta en poder de una unidad operativa proveedor logistico
        cursor cuCHECK_GE_ITEMS_SERIADO(isbSERIE GE_ITEMS_SERIADO.SERIE%type) is
          select its.ITEMS_ID, its.SERIE, its.OPERATING_UNIT_ID, uop.OPER_UNIT_CLASSIF_ID
              from GE_ITEMS_SERIADO its, OR_OPERATING_UNIT uop
            where its.SERIE = isbSERIE
                and uop.OPERATING_UNIT_ID = its.OPERATING_UNIT_ID
                and uop.OPER_UNIT_CLASSIF_ID = 11;


          -- cursor del detalle del movimeinto de material
          cursor cuDetalleMovimiento(inuDMITMMIT LDCI_DMITMMIT.DMITMMIT%type) is
            select MMITCODI, MMITNUDO, MMITTIMO, MMITNATU, MMITDSAP, LDCI_DMITMMIT.*
              from LDCI_INTEMMIT,LDCI_DMITMMIT
            where DMITMMIT = MMITCODI
              and MMITCODI = inuDMITMMIT;

           -- cursor para detemrinar si una posicion tiene detalle de seriales o no
           cursor cuCuentaisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
                  inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
          select count(*)
              from LDCI_SERIDMIT
            where SERIMMIT = inuSERIMMIT
                and SERIDMIT = inuSERIDMIT;

          -- cursor para listar el detalle de seriales
          cursor cuDetalleisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
                        inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
              select SERIMMIT,SERIDMIT,SERICODI, SERINUME
                  from LDCI_SERIDMIT
                where SERIMMIT = inuSERIMMIT
                    and SERIDMIT = inuSERIDMIT
                  order by SERIMMIT,SERIDMIT,SERICODI;

          -- cursor del documento. Usado para determinar el tipo del documento
          cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
              select ID_ITEMS_DOCUMENTO, DOCUMENT_TYPE_ID, OPERATING_UNIT_ID, DESTINO_OPER_UNI_ID
                  from GE_ITEMS_DOCUMENTO
                where ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

          -- cursor para determinar si el numero de serie ya esta asignado (Caso de anulacion de un despacho)
          cursor cuGE_ITEMS_SERIADO(isbSERIE            in GE_ITEMS_SERIADO.SERIE%type,
                        inuOPERATING_UNIT_ID in GE_ITEMS_SERIADO.OPERATING_UNIT_ID%type)   is
              select SERIE, OPERATING_UNIT_ID
                from GE_ITEMS_SERIADO
                where SERIE = isbSERIE
                    and OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

          -- registro de   cuGE_ITEMS_SERIADO
          reGE_ITEMS_SERIADO  cuGE_ITEMS_SERIADO%rowtype;
          -- registro de cuGE_ITEMS_DOCUMENTO
          reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;
          -- #NC-2228 registro de cuGE_ITEMS_SERIADO
          reCHECK_GE_ITEMS_SERIADO cuCHECK_GE_ITEMS_SERIADO%rowtype;
          -- #NC-2229 registro de cuGE_ITEMS
          reGE_ITEMS cuGE_ITEMS%rowtype;

          -- define variables
          l_Payload      CLOB;
          nuisbSeriales  NUMBER;
          nuErrorCode    NUMBER;
          sbRejectItem   VARCHAR2(1);
          sbTipoRejeTras VARCHAR2(1);   -- flag tipo rechazo de tralado [T]otal ; [P]Parcial ; [N]o aplica
          onuTipoItemId  NUMBER;
          onuItemsGamaId NUMBER;
          sbAPI          VARCHAR2(100);
          sbITEM         VARCHAR2(18);
          sbSERIE        VARCHAR2(20);
          nuItemEnTransito NUMBER; --#6848
          sbProcesaItem    VARCHAR2(1); --#6848 flag para determinar si procesa o no el item [S]i / [N]o

          -- define excepciones
          excepNoProcesoRegi           exception;
          excepAPI_ACCEPT_ITEM          exception;
          excep_OS_ITEMMOVEOPERUNIT    exception;
          excep_OS_SET_MOVE_ITEM       exception;
          excepAPI_LOADACCEPT_ITEMS   exception;
                excep_CHECK_GE_ITEMS_SERIADO exception; -- #NC-2228
      begin

          -- recorre los items de la solicitud
          for reDetalleMovimiento in cuDetalleMovimiento(inuMovimiento) loop
                   -- registra el item que se esta procesando
                sbITEM        := reDetalleMovimiento.DMITITEM;
                sbSERIE       := 'N.A.';
                nuErrorCode   := 0; --#6848 Inicializa la variable de salida
                sbProcesaItem := 'S'; --#6848 Inicializa la variable de procesamiento

                -- carga el documento para determina las unidades operativas involucradas
                open cuGE_ITEMS_DOCUMENTO(to_number(reDetalleMovimiento.MMITNUDO));
                fetch cuGE_ITEMS_DOCUMENTO into reGE_ITEMS_DOCUMENTO;
                close cuGE_ITEMS_DOCUMENTO;

                sbRejectItem   := 'A';
                sbTipoRejeTras := 'N';

                --NC-933: Valida la marca de borrado para cuando la cantidad es mayor que cero
                -- valida si se rechaza la posicion o si es aceptada
                if (reDetalleMovimiento.DMITMABO is not null or reDetalleMovimiento.DMITMABO <> ''
                    and reDetalleMovimiento.DMITCANT <> 0
                        and reDetalleMovimiento.DMITCAPE = 0) then
                    sbRejectItem   := 'R';
                    sbTipoRejeTras := 'T';
                end if; --if ((reDetalleMovimiento.DMITMABO <> null or reDetalleMovimiento.DMITMABO <> ''...)

                -- #NC-2229:19-12-2013:carlos.virgen: Rechazo total realizado desde la opci??A?n reserva de SAP
                if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITCAPE = 0
                        and (reDetalleMovimiento.DMITSAFI = 'C' or reDetalleMovimiento.DMITMABO is not null)) then
                    sbRejectItem   := 'R';
                    sbTipoRejeTras := 'T';
                end if;--if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C'

                --NC-933: Valida la marca de borrado para cuando la cantidad es menor que cero y cantidad pendiente es mayor que cero
                -- valida si se rechaza la posicion o si es aceptada
                if (reDetalleMovimiento.DMITMABO is not null or reDetalleMovimiento.DMITMABO <> ''
                    and reDetalleMovimiento.DMITCANT = 0
                        and reDetalleMovimiento.DMITCAPE <> 0) then
                    sbRejectItem   := 'R';
                    sbTipoRejeTras := 'R';
                end if; --if ((reDetalleMovimiento.DMITMABO <> null or reDetalleMovimiento.DMITMABO <> ''...)

                -- Determina si el traslado es parcial y se rechaza una parte de el
                if (reDetalleMovimiento.DMITCANT <> 0 and reDetalleMovimiento.DMITSAFI = 'C'
                        and reDetalleMovimiento.DMITCAPE <> 0) then
                    sbRejectItem   := 'R';
                    sbTipoRejeTras := 'P';
                end if;--if (reDetalleMovimiento.DMITCANT <> 0 and reDetalleMovimiento.DMITSAFI = 'C'

                -- Rechazo total realizado desde la opci??A?n MIGO de SAP
                if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C'
                        and reDetalleMovimiento.DMITCAPE <> 0) then
                    sbRejectItem   := 'R';
                    sbTipoRejeTras := 'R';
                end if;--if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C'


                --#6848: Valida si la posicion queda pendiente
                if (reDetalleMovimiento.DMITCANT = 0   --#6848
                    and reDetalleMovimiento.DMITSAFI = 'P'
                  and reDetalleMovimiento.DMITCAPE <> 0
                  and reDetalleMovimiento.DMITMABO is null) then

                  sbProcesaItem := 'N'; --#6848 Inicializa la variable de procesamiento
                end if;--if (reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'P'

                if (sbProcesaItem = 'S') then --#6848: Valida si debe procesar o no el item

                  -- determina si el item es isbSerializado
                  open cuCuentaisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI);
                  fetch cuCuentaisbSeriales into nuisbSeriales;
                  close cuCuentaisbSeriales;

                  --#NC-2229:19-12-2013:carlos.virgen: Determina si el item procesao es seriado o no
                  open cuGE_ITEMS(reDetalleMovimiento.DMITITEM);
                  fetch cuGE_ITEMS into reGE_ITEMS;
                  close cuGE_ITEMS;

                  -- valida si el item tiene isbSeriales
                  if (reGE_ITEMS.ITEM_CLASSIF_ID = 21) then
                    if (nuisbSeriales <> 0 and sbTipoRejeTras in ('N','P')) then
                      -- recorre los isbSeriales para generar el XML
                      for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI) loop
                                sbSERIE := reDetalleisbSeriales.SERINUME;
                                -- valida el tipo de movimiento Z02 Devolucion Material / Z04 Devolucion de Herramienta
                                if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
                                        -- genera xml para los items isbSerializados
                                        proGenXMLAcepTrasItemSeri(reDetalleisbSeriales.SERIMMIT,
                                                    reDetalleisbSeriales.SERIDMIT,
                                                    reDetalleisbSeriales.SERICODI,
                                                    'A',  --#NC-2229:19-12-2013:carlos.virgen: Se cambia sbRejectItem por 'A'
                                                    sbTipoRejeTras,
                                                    l_Payload,
                                                    osbMesjErr);

                                        -- valida si pudo generar el XML para el llamado API_LOADACCEPT_ITEMS
                                        if (osbMesjErr is not null) then
                                            raise excepNoProcesoRegi;
                                        end if;--if (osbMesjErr is not null) then

                                        --#NC-2229:19-12-2013:carlos.virgen: Se hace el llamado al API API_ACCEPT_ITEM para aceptar total o parcialmente
                                        sbAPI := 'API_ACCEPT_ITEM';
                                        API_ACCEPT_ITEM(l_Payload,nuErrorCode, osbMesjErr);
                                        -- valida si API_ACCEPT_ITEM se ejecuto con exito
                                         if nuErrorCode = 0 then
                                         ldc_actualizabodegasdev(
                                                                 reDetalleMovimiento.mmitnudo
                                                                ,1
                                                                ,reDetalleMovimiento.dmititem
                                                                ,nuErrorCode
                                                                ,osbMesjErr
                                                                );
                                         IF nuErrorCode = 0 THEN
                                          ldc_cerrardocumentotraslados(reDetalleMovimiento.mmitnudo,nuErrorCode,osbMesjErr);
                                         END IF;
                                        end if;
                                        if (nuErrorCode <> 0) then
                                            raise excepAPI_ACCEPT_ITEM;
                                        end if;--if (onuErrorCode <> 0) then
                                  else
                                        -- tipo de movimiento Z01 Movimiento de Material / Z03 Movimiento de Heramientas (Anulacion de Traslados / Devolucion)
                                        if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
                                            -- ini:#NC-2228 valida que un proveedor logistico tenga en su poder el serial que se esta procesando
                                            open cuCHECK_GE_ITEMS_SERIADO(reDetalleisbSeriales.SERINUME);
                                            fetch cuCHECK_GE_ITEMS_SERIADO into reCHECK_GE_ITEMS_SERIADO;

                                            -- si el item seriado existe en bodega del proveedor logistico, procede a moverlo a la bodega de unidad operativa
                                            if (cuCHECK_GE_ITEMS_SERIADO%FOUND) then
                                                -- Mueve el serial del proveedor logistico a la unidad operativa
                                                /* Version haciendo uso del API :API_LOADACCEPT_ITEMS
                                                -- Genera el XML para el API API_LOADACCEPT_ITEMS, indicando que suma al inventario*/
                                                proGenXMLAceptItemSeriado(reDetalleisbSeriales.SERIMMIT,
                                                              reDetalleisbSeriales.SERIDMIT,
                                                              reDetalleisbSeriales.SERICODI,
                                                              'I',
                                                              l_Payload,
                                                              osbMesjErr);
                                                -- valida si API_LOADACCEPT_ITEMS se ejecuto con exito
                                                if (osbMesjErr is not null) then
                                                    raise excepNoProcesoRegi;
                                                end if;--if (osbMesjErr is not null) then

                                                API_LOADACCEPT_ITEMS(l_Payload,nuErrorCode, osbMesjErr);
                                                -- valida si API_LOADACCEPT_ITEMS se ejecuto con exito
                                                if (nuErrorCode <> 0) then
                                                    raise excepAPI_LOADACCEPT_ITEMS;
                                                end if;--if (onuErrorCode <> 0) then
                                                close cuCHECK_GE_ITEMS_SERIADO;
                                            else
                                                close cuCHECK_GE_ITEMS_SERIADO;
                                                raise excep_CHECK_GE_ITEMS_SERIADO;
                                            end if;--if (cuCHECK_GE_ITEMS_SERIADO%FOUND) then
                                            -- eof:#NC-2228 valida que un proveedor logistico tenga en su poder el serial que se esta procesando
                                        end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then
                                end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
                            end loop; --for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITMMIT) loop
                    end if;--if (nuisbSeriales <> 0 and sbTipoRejeTras in ('N','P')) then

                    --ini:#NC-2229:19-12-2013:carlos.virgen: Valida si el rechazo si tiene marca de concluido para rechazar la cantidad pendiente
                      -- procesa tralado parcial y rechazo de la cantida pendiente
                    if (sbRejectItem = 'R' and sbTipoRejeTras in ('R','P','T')) then
                    -- recorre el detalle de los items seriados que se van a rechazar
                        for reItemSeriadoTransito in cuItemSeriadoTransito(reDetalleMovimiento.MMITNUDO, reDetalleMovimiento.DMITITEM) loop
                           -- genera el XML para hacer la ejeucion del REJECT
                                  proGenXMLRejectTrasItemSeri(reItemSeriadoTransito.ID_ITEMS_DOCUMENTO,
                                                reItemSeriadoTransito.SERIE,
                                                reDetalleMovimiento.MMITDSAP,
                                                l_Payload,
                                                osbMesjErr);
                                  if (osbMesjErr is not null) then
                                      raise excepNoProcesoRegi;
                                  end if;--if (osbMesjErr is not null) then

                                  sbAPI := 'API_REJECT_ITEM';
                                  API_REJECT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
                                  IF nuErrorCode = 0 then
                                    ldc_actbodegasdevserrech(
                                                             reDetalleMovimiento.mmitnudo
                                                            ,reItemSeriadoTransito.Iditemser
                                                            ,reDetalleMovimiento.dmititem
                                                            ,nuErrorCode
                                                            ,osbMesjErr
                                                            );
                                  IF nuErrorCode = 0 THEN
                                   ldc_cerrardocumentotraslados(reDetalleMovimiento.mmitnudo,nuErrorCode,osbMesjErr);
                                  END IF;
                                 END IF;
                                  -- valida si API_ACCEPT_ITEM / API_REJECT_ITEM se ejecuto con exito
                                  if (nuErrorCode <> 0) then
                                      raise excepAPI_ACCEPT_ITEM;
                                  end if;--if (onuErrorCode <> 0) then
                        end loop;--for reItemSeriadoTransito in cuItemSeriadoTransito loop ...
                    end if;--if (sbRejectItem = 'R' and sbTipoRejeTras in ('R','P','T')) then
                    --eof:#NC-2229:19-12-2013:carlos.virgen: Valida si el rechazo si tiene marca de concluido para rechazar la cantidad pendiente
                  else
                      -- valida el tipo de movimiento Z02 Devolucion Material / Z04 Devolucion de Herramienta
                      if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
                          -- procesa una aceptacion de tralado o un rechazo total del tralado
                            if (sbTipoRejeTras in ('N', 'T', 'R')) then
                                -- genera xml para los item no isbSerialziados
                                proGenXMLAcepTrasItem(inuMovimiento,
                                          reDetalleMovimiento.DMITCODI,
                                          reDetalleMovimiento.DMITITEM,
                                          sbRejectItem,
                                          sbTipoRejeTras,
                                          l_Payload,
                                          osbMesjErr);

                                -- valida si pudo generar el XML para el llamado API_LOADACCEPT_ITEMS
                                if (osbMesjErr is not null) then
                                    raise excepNoProcesoRegi;
                                end if;--if (osbMesjErr is not null) then

                                nuItemEnTransito := 0; --#6848
                                open cuItemNoSeriadoTransito(reDetalleMovimiento.MMITNUDO, reDetalleMovimiento.DMITITEM);--#6848
                                fetch cuItemNoSeriadoTransito into nuItemEnTransito;--#6848
                                close cuItemNoSeriadoTransito;--#6848

                                -- valida si acepta el item o lo rechaza
                                -- acepta el item para el traslado
                                if (sbRejectItem = 'A') then
                                  -- hace el llamado al API para hacer el ingreso del item
                                  sbAPI := 'API_ACCEPT_ITEM';
                                  API_ACCEPT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
                                  IF nuErrorCode = 0 then
                                   ldc_actualizabodegasdev(
                                                            reDetalleMovimiento.mmitnudo
                                                           ,reDetalleMovimiento.dmitcant
                                                           ,reDetalleMovimiento.dmititem
                                                           ,nuErrorCode
                                                           ,osbMesjErr
                                                           );
                                    IF nuErrorCode = 0 THEN
                                     ldc_cerrardocumentotraslados(reDetalleMovimiento.mmitnudo,nuErrorCode,osbMesjErr);
                                   END IF;
                                  END IF;
                                else
                                  -- rechaza el tralado del item
                                  if (sbRejectItem = 'R') then
                                    -- hace el llamado al API para hacer el ingreso del item
                                    sbAPI := 'API_REJECT_ITEM';

                                    if (nuItemEnTransito <> 0) then --#6848: Validar si el item esta en transito. Si esta en transito ejecuta API, sino no.
                                      API_REJECT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
                                      if nuErrorCode = 0 then
                                       ldc_actbodegasdevrechnoser(
                                                                  reDetalleMovimiento.mmitnudo
                                                                 ,reDetalleMovimiento.dmititem
                                                                 ,nuErrorCode
                                                                 ,osbMesjErr
                                                                );
                                      IF nuErrorCode = 0 THEN
                                       ldc_cerrardocumentotraslados(reDetalleMovimiento.mmitnudo,nuErrorCode,osbMesjErr);
                                      END IF;
                                      end if;
                                    end if;--if (nuItemEnTransito <> 0) then
                                  end if;--if (sbRejectItem = 'R') then
                                end if;--if (sbRejectItem = 'A') then

                                -- valida si API_ACCEPT_ITEM / API_REJECT_ITEM se ejecuto con exito
                                if (nuErrorCode <> 0) then
                                    raise excepAPI_ACCEPT_ITEM;
                                end if;--if (onuErrorCode <> 0) then
                          end if;--if (sbTipoRejeTras in ('N','T')) then

                          -- procesa tralado parcial y rechazo de la cantida pendiente
                          if (sbTipoRejeTras = 'P') then
                              -- acepta la cantidad enviada
                              -- genera xml para los item no isbSerialziados
                              proGenXMLAcepTrasItem(inuMovimiento,
                                        reDetalleMovimiento.DMITCODI,
                                        reDetalleMovimiento.DMITITEM,
                                        'A',
                                        'N',
                                        l_Payload,
                                        osbMesjErr);

                              -- valida si pudo generar el XML para el llamado API_LOADACCEPT_ITEMS
                              if (osbMesjErr is not null) then
                                raise excepNoProcesoRegi;
                              end if;--if (osbMesjErr is not null) then

                              -- hace el llamado al API para hacer el ingreso del item
                              sbAPI := 'API_ACCEPT_ITEM';
                              API_ACCEPT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
                              if nuErrorCode = 0 then
                               ldc_actualizabodegasdev(
                                                       reDetalleMovimiento.mmitnudo
                                                      ,reDetalleMovimiento.dmitcant
                                                      ,reDetalleMovimiento.dmititem
                                                      ,nuErrorCode
                                                      ,osbMesjErr
                                                      );
                               IF nuErrorCode = 0 THEN
                                ldc_cerrardocumentotraslados(reDetalleMovimiento.mmitnudo,nuErrorCode,osbMesjErr);
                               END IF;
                              end if;

                              -- valida si API_ACCEPT_ITEM / API_REJECT_ITEM se ejecuto con exito
                              if (nuErrorCode <> 0) then
                                    raise excepAPI_ACCEPT_ITEM;
                              end if;--if (onuErrorCode <> 0) then

                              -- rechaza la cantidad pendiente
                              -- genera xml para los item no isbSerialziados
                              proGenXMLAcepTrasItem(inuMovimiento,
                                        reDetalleMovimiento.DMITCODI,
                                        reDetalleMovimiento.DMITITEM,
                                        sbRejectItem,
                                        sbTipoRejeTras,
                                        l_Payload,
                                        osbMesjErr);

                              -- valida si pudo generar el XML para el llamado API_LOADACCEPT_ITEMS
                              if (osbMesjErr is not null) then
                                raise excepNoProcesoRegi;
                              end if;--if (osbMesjErr is not null) then

                              sbAPI := 'API_REJECT_ITEM';
                              -- hace el llamado al API para hacer el ingreso del item
                              API_REJECT_ITEM(l_Payload, nuErrorCode, osbMesjErr);
                              IF nuErrorCode = 0 then
                               ldc_actbodegasdevrechnoser(
                                                          reDetalleMovimiento.mmitnudo
                                                         ,reDetalleMovimiento.dmititem
                                                         ,nuErrorCode
                                                         ,osbMesjErr
                                                         );
                               IF nuErrorCode = 0 THEN
                                ldc_cerrardocumentotraslados(reDetalleMovimiento.mmitnudo,nuErrorCode,osbMesjErr);
                               END IF;
                              end if;
                              -- valida si API_ACCEPT_ITEM / API_REJECT_ITEM se ejecuto con exito
                              if (nuErrorCode <> 0) then
                                    raise excepAPI_ACCEPT_ITEM;
                              end if;--if (onuErrorCode <> 0) then
                          end if;-- if (sbTipoRejeTras = 'P') then
                      else
                          -- tipo de movimiento Z01 Movimiento de Material / Z03 Movimiento de Heramientas (Anulacion de Traslados / Devolucion)
                          if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
                                -- Genera el XML para el API API_LOADACCEPT_ITEMS, indicando que suma al inventario
                                proGenXMLAceptItem(inuMovimiento,
                                          reDetalleMovimiento.DMITCODI,
                                          reDetalleMovimiento.DMITITEM,
                                          'I',
                                          l_Payload,
                                          osbMesjErr);

                                if (osbMesjErr is not null) then
                                      raise excepNoProcesoRegi;
                                end if;--if (osbMesjErr is not null) then

                                -- hace el llamado al API para hacer el ingreso del item
                                API_LOADACCEPT_ITEMS(l_Payload, nuErrorCode, osbMesjErr);
                                -- valida si API_LOADACCEPT_ITEMS se ejecuto con exito
                                if (nuErrorCode <> 0) then
                                      raise excepAPI_LOADACCEPT_ITEMS;
                                end if;--if (onuErrorCode <> 0) then

                          end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then
                      end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
                  end if; -- if (reGE_ITEMS.ITEM_CLASSIF_ID = 21) then
                end if;--if (sbProcesaItem = 'S') then
          end loop;-- for reDetalleMovimiento in cuDetalleMovimiento loop

      Exception
        WHEN excep_CHECK_GE_ITEMS_SERIADO THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.CHECK_GE_ITEMS_SERIADO]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                          chr(13) || ' El ITEM no se encuentra asignado en poder de una Unida Operativa de clase Proveedor Logistico.';

        WHEN excepAPI_LOADACCEPT_ITEMS THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.API_LOADACCEPT_ITEMS]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                          chr(13) || ' Error de ejecucion del API: ' || osbMesjErr;

        WHEN excep_OS_SET_MOVE_ITEM THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.OS_SET_MOVE_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                          chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

        WHEN excep_OS_ITEMMOVEOPERUNIT THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.OS_ITEMMOVEOPERUNIT]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                          chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

        WHEN excepNoProcesoRegi THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.excepNoProcesoRegi]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                              chr(13) || 'Error generando el XML: ' || osbMesjErr;

        WHEN excepAPI_ACCEPT_ITEM THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.API_ACCEPT_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                              chr(13) || 'Error de ejecucion del API('|| sbAPI ||'): ' || osbMesjErr;

        WHEN OTHERS THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAcepTrastItem.Others]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                              chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proAcepTrastItem;

      procedure proAceptItem(inuMovimiento in  LDCI_INTEMMIT.MMITCODI%type,
                                                  osbMesjErr    out VARCHAR2) As
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : proAceptItem
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 15-01-2013
            RICEF      : I004
            DESCRIPCION: genera el XML al API OS_SET_REQUEST_CONF

          Historia de Modificaciones
          Autor   Fecha       Descripcion
        carlosvl 11-09-2013  #NC-629: Se valida las marcas de salida final y marca de borrado.
      */
        -- define cursores
        -- cusro que carga el detalle de la posicion involucrada en un movimiento
        cursor cuDetalleMovimiento(inuDMITMMIT LDCI_DMITMMIT.DMITMMIT%type) is
            select MMITCODI, MMITNUDO, MMITTIMO, MMITNATU, MMITDSAP, LDCI_DMITMMIT.*
                from LDCI_INTEMMIT,LDCI_DMITMMIT
              where DMITMMIT = MMITCODI
                  and MMITCODI = inuDMITMMIT;

      -- cursor que determina si la posicion tiene seriales realcionados
      cursor cuCuentaisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
                                                      inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
          select count(*)
              from LDCI_SERIDMIT
            where SERIMMIT = inuSERIMMIT
                and SERIDMIT = inuSERIDMIT;


      -- cursor que muestra la informacion de los seriales relacionados a la posicion
      cursor cuDetalleisbSeriales(inuSERIMMIT LDCI_SERIDMIT.SERIMMIT%type,
                                                              inuSERIDMIT LDCI_SERIDMIT.SERIDMIT%type) is
          select SERIMMIT,SERIDMIT,SERICODI, SERINUME
              from LDCI_SERIDMIT
            where SERIMMIT = inuSERIMMIT
                and SERIDMIT = inuSERIDMIT
          order by SERIMMIT,SERIDMIT,SERICODI;

      -- cursor del documento. Usado para determinar el tipo del documento
      cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
        select ID_ITEMS_DOCUMENTO, DOCUMENT_TYPE_ID, OPERATING_UNIT_ID, DESTINO_OPER_UNI_ID
            from GE_ITEMS_DOCUMENTO
          where ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

      -- cursor para determinar si el numero de serie ya esta asignado (Caso de anulacion de un despacho)
      cursor cuGE_ITEMS_SERIADO(isbSERIE              in GE_ITEMS_SERIADO.SERIE%type,
                                                          inuOPERATING_UNIT_ID in GE_ITEMS_SERIADO.OPERATING_UNIT_ID%type)   is
        select SERIE, OPERATING_UNIT_ID
          from GE_ITEMS_SERIADO
          where SERIE = isbSERIE
              and OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

        -- registro de   cuGE_ITEMS_SERIADO
        reGE_ITEMS_SERIADO  cuGE_ITEMS_SERIADO%rowtype;

      -- registro de cuGE_ITEMS_DOCUMENTO
      reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;

        -- define variables
        l_Payload      CLOB;
        nuisbSeriales  NUMBER;
        nuErrorCode    NUMBER;
        onuTipoItemId  NUMBER;
        onuItemsGamaId NUMBER;
        sbITEM         VARCHAR2(18);
        sbSERIE        VARCHAR2(20);

        -- define excepciones
        excepNoProcesoRegi        exception;
        excepAPI_LOADACCEPT_ITEMS  exception;
        excep_proSetRequestConf   exception;
        excep_OS_SET_REQUEST_CONF exception;
        excep_OS_ITEMMOVEOPERUNIT exception;
        excep_OS_SET_MOVE_ITEM    exception;
        excep_OS_ACCEPT_ITEM      exception;
      begin


          -- recorre los items de la solicitud
          for reDetalleMovimiento in cuDetalleMovimiento(inuMovimiento) loop
          sbITEM  := reDetalleMovimiento.DMITITEM;

                    --11-09- 2013: #NC-629: carlosvl: Se agrega condificon para cuando DMITSAFI = 'P' and DMITMABO is null o DMITMABO is not null
                    -- valida si la posicion ha sido rechazada o marcada en salida final con cantidad cero
                    if(reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C' and reDetalleMovimiento.DMITMABO is null
                          or reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'C' and reDetalleMovimiento.DMITMABO is not null
                          or reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'P' and reDetalleMovimiento.DMITMABO is null
                          or reDetalleMovimiento.DMITCANT = 0 and reDetalleMovimiento.DMITSAFI = 'P' and reDetalleMovimiento.DMITMABO is not null) then


                            -- se acepta la posicion rechazada y libera el cupo
                            -- genera el XML para OS_SET_REQUEST_CONF
                            proSetRequestConf(inuMovimiento,
                                                                reDetalleMovimiento.MMITTIMO,
                                                                reDetalleMovimiento.DMITCODI,
                                                                reDetalleMovimiento.DMITITEM,
                                                                l_Payload,
                                                                osbMesjErr);



                            if (osbMesjErr is not null) then
                                raise excep_proSetRequestConf;
                            end if;--if (osbMesjErr is not null) then

                            -- hace el llamado del API para confirmar isbMaterial faltante
                            OS_SET_REQUEST_CONF(l_Payload, nuErrorCode,osbMesjErr);

                            if (osbMesjErr is not null) then
                                raise excep_OS_SET_REQUEST_CONF;
                            end if;--if (osbMesjErr is not null) then
                    else
                      -- carga el documento para determina las unidades operativas involucradas
                      open cuGE_ITEMS_DOCUMENTO(to_number(reDetalleMovimiento.MMITNUDO));
                      fetch cuGE_ITEMS_DOCUMENTO into reGE_ITEMS_DOCUMENTO;
                      close cuGE_ITEMS_DOCUMENTO;

                            --  la posicion no fue rechazada y se procede a cargarla al inventario
                      -- determina si el item es isbSerializado

                      open cuCuentaisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI);
                      fetch cuCuentaisbSeriales into nuisbSeriales;
                      close cuCuentaisbSeriales;

                      -- valisa si el item tiene isbSeriales
                      if (nuisbSeriales <> 0) then
                          -- recorre los isbSeriales para generar el XML
                          for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITCODI) loop
                sbSERIE := reDetalleisbSeriales.SERINUME;
                                -- hace la carga al inventario de items no seriados (tipos de movimiento Z01 Salida de Material / Z03 Salida de Herramientas)
                                if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then

                                        -- Genera el XML para el API API_LOADACCEPT_ITEMS, indicando que suma al inventario
                                        proGenXMLAceptItemSeriado(reDetalleisbSeriales.SERIMMIT,
                                                                                            reDetalleisbSeriales.SERIDMIT,
                                                                                            reDetalleisbSeriales.SERICODI,
                                                                                            'I',
                                                                                            l_Payload,
                                                                                            osbMesjErr);
                                else
                                      if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
                                          -- Genera el XML para el API API_LOADACCEPT_ITEMS, indicando que suma al inventario
                                          proGenXMLAceptItemSeriado(reDetalleisbSeriales.SERIMMIT,
                                                                                              reDetalleisbSeriales.SERIDMIT,
                                                                                              reDetalleisbSeriales.SERICODI,
                                                                                              'D',
                                                                                              l_Payload,
                                                                                              osbMesjErr);
                                      end if;-- if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
                                end if;--if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then

                                -- valida si pudo generar el XML para el llamado API_LOADACCEPT_ITEMS
                                if (osbMesjErr is not null) then
                                    raise excepNoProcesoRegi;
                                end if;--if (osbMesjErr is not null) then

                                -- hace el llamado al API para hacer el ingreso del item
                                API_LOADACCEPT_ITEMS(l_Payload,nuErrorCode, osbMesjErr);
                                -- valida si API_LOADACCEPT_ITEMS se ejecuto con exito
                                if (nuErrorCode <> 0) then
                                    raise excepAPI_LOADACCEPT_ITEMS;
                                end if;--if (onuErrorCode <> 0) then
                          end loop; --for reDetalleisbSeriales in cuDetalleisbSeriales(inuMovimiento, reDetalleMovimiento.DMITMMIT) loop
                      else
                 -- procesamiento de items no seriados
                                  if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate, reClaseMovi.sbClasSolMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbMoviHerr)) then
                                              -- Genera el XML para el API API_LOADACCEPT_ITEMS, indicando que suma al inventario
                                              proGenXMLAceptItem(inuMovimiento,
                                                                                  reDetalleMovimiento.DMITCODI,
                                                                                  reDetalleMovimiento.DMITITEM,
                                                                                  'I',
                                                                                  l_Payload,
                                                                                  osbMesjErr);
                                  else
                                            if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbClasDevMatAct /*#OYM_CEV_3429_1*/, reClaseMovi.sbDevoHerr)) then
                                                    -- Genera el XML para el API API_LOADACCEPT_ITEMS, indicando que resta del inventario
                                                    proGenXMLAceptItem(inuMovimiento,
                                                                                          reDetalleMovimiento.DMITCODI,
                                                                                          reDetalleMovimiento.DMITITEM,
                                                                                          'D',
                                                                                          l_Payload,
                                                                                          osbMesjErr);
                                            end if; --if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbDevoMate, reClaseMovi.sbDevoHerr)) then
                                  end if; --if(reDetalleMovimiento.MMITTIMO in (reClaseMovi.sbMoviMate,reClaseMovi.sbMoviHerr)) then

                                  -- valida si pudo generar el XML para el llamado API_LOADACCEPT_ITEMS
                                  if (osbMesjErr is not null) then
                                        raise excepNoProcesoRegi;
                                  end if;--if (osbMesjErr is not null) then

                                  -- hace el llamado al API para hacer el ingreso del item
                                  API_LOADACCEPT_ITEMS(l_Payload, nuErrorCode, osbMesjErr);
                                  -- valida si API_LOADACCEPT_ITEMS se ejecuto con exito
                                  if (nuErrorCode <> 0) then
                                        raise excepAPI_LOADACCEPT_ITEMS;
                                  end if;--if (onuErrorCode <> 0) then
                      end if; -- if (nuisbSeriales <> 0) then

                      -- realiza la confimacion del saldo pendiente
                      -- genera el XML para OS_SET_REQUEST_CONF
                      proSetRequestConf(inuMovimiento,
                                                          reDetalleMovimiento.MMITTIMO,
                                                          reDetalleMovimiento.DMITCODI,
                                                          reDetalleMovimiento.DMITITEM,
                                                          l_Payload,
                                                          osbMesjErr);

                      if (osbMesjErr is not null) then
                          raise excep_proSetRequestConf;
                      end if;--if (osbMesjErr is not null) then

                      -- hace el llamado del API para confirmar isbMaterial faltante
                      OS_SET_REQUEST_CONF(l_Payload, nuErrorCode,osbMesjErr);
                      if (osbMesjErr is not null) then
                          raise excep_OS_SET_REQUEST_CONF;
                      end if;--if (osbMesjErr is not null) then
                    end if;-- if(reDetalleMovimiento.DMITCAPE = 0 and ...
      end loop;-- for reDetalleMovimiento in cuDetalleMovimiento loop

      Exception
            WHEN excep_OS_ACCEPT_ITEM THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.OS_ACCEPT_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                    chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

            WHEN excep_OS_SET_MOVE_ITEM THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.OS_SET_MOVE_ITEM]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                    chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

            WHEN excep_OS_ITEMMOVEOPERUNIT THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.OS_ITEMMOVEOPERUNIT]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                    chr(13) || 'Error de ejecucion del API: ' || osbMesjErr;

            WHEN excep_proSetRequestConf THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.proSetRequestConf]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                    chr(13) || 'Error generando el XML: ' || osbMesjErr;

            WHEN excep_OS_SET_REQUEST_CONF THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.OS_SET_REQUEST_CONF]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                    chr(13) || 'Error cargando el item (OS_SET_REQUEST_CONF): ' || osbMesjErr;

            WHEN excepNoProcesoRegi THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.NoProcesoRegi]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                                  chr(13) || 'Error generando el XML: ' || osbMesjErr;

            WHEN excepAPI_LOADACCEPT_ITEMS THEN
                      osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.API_LOADACCEPT_ITEMS]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                    chr(13) || 'Error cargando el item (API_LOADACCEPT_ITEMS): ' || osbMesjErr;

            WHEN OTHERS THEN
                  osbMesjErr := '[LDCI_PKMOVIMATERIAL.proAceptItem.Others]: Procesando ITEM:' || sbITEM || ' SERIE: ' || sbSERIE ||
                                chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proAceptItem;

      procedure proCreaEncabezadoDocVenta(isbDOVECODI in VARCHAR2,
                                                                            isbDOVETIMO in VARCHAR2,
                                                                            isbDOVEDESC in VARCHAR2,
                                                                            isbDOVENATU in VARCHAR2,
                                                                            isbDOVECLIE in VARCHAR2,
                                                                            idtDOVEFESA in DATE,
                                                                            inuDOVEVTOT in NUMBER,
                                                                            idtDOVEFEVE in DATE,
                                                                            osbMesException out VARCHAR2) as
          /*
                PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
                FUNCION    : LDCI_PKMOVIMATERIAL.proCreaEncabezadoDocVenta
                AUTOR      : OLSoftware / Carlos E. Virgen
                FECHA      : 24-09-2013
                RICEF      : I064
                DESCRIPCION: Crea un registro en la tabla LDCI_DOCUVENT con la informaci??A?n del movimiento de venta

              Historia de Modificaciones
              Autor    Fecha       Descripcion
              carlosvl 24-09-2013  Crea el procedimiento
          */
      begin
            -- realiza la insercion del encabezado del documento de venta
            insert into LDCI_DOCUVENT(DOVECODI,
                                                              DOVETIMO,
                                                              DOVEDESC,
                                                              DOVENATU,
                                                              DOVECLIE,
                                                              DOVEFESA,
                                                              DOVEVTOT,
                                                              DOVEESTA,
                                                              DOVEINTE,
                                                              DOVEFEVE) values
                                                              (isbDOVECODI,
                                                              isbDOVETIMO,
                                                              isbDOVEDESC,
                                                              isbDOVENATU,
                                                              isbDOVECLIE,
                                                              idtDOVEFESA,
                                                              inuDOVEVTOT,
                                                              '1',
                                                              0,
                                                              idtDOVEFEVE);
      exception
          when others then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proCreaEncabezadoDocVenta]: Registro [' || isbDOVECODI || ']' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proCreaEncabezadoDocVenta;

      procedure proCreaPosicionesDocVenta(inuDMITMMIT in LDCI_DMITMMIT.DMITMMIT%type,
                                                                            inuITDVOPUN in NUMBER,
                                                                            inuITDVPROV in NUMBER,
                                                                            osbMesException out VARCHAR2) as
          /*
                PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
                FUNCION    : LDCI_PKMOVIMATERIAL.proCreaPosicionesDocVenta
                AUTOR      : OLSoftware / Carlos E. Virgen
                FECHA      : 24-09-2013
                RICEF      : I064
                DESCRIPCION: Crea un registro en la tabla LDCI_ITEMDOVE con la informaci??A?n del movimiento de venta

              Historia de Modificaciones
              Autor    Fecha       Descripcion
              carlosvl 24-09-2013  Crea el procedimiento
          */
            nuITDVCODI LDCI_ITEMDOVE.ITDVCODI%type;
            nuITDVCOIN LDCI_ITEMDOVE.ITDVCOIN%type;
            -- Cursor de los items seriados
            cursor cuItemSeriado(inuMMITCODI LDCI_INTEMMIT.MMITCODI%type) is
            -- lista la informacion de los seriales de un  movimiento
                  select MMITDSAP, LDCI_DMITMMIT.*, LDCI_SERIDMIT.*
                      from LDCI_INTEMMIT,LDCI_DMITMMIT, LDCI_SERIDMIT
                    where MMITCODI = inuMMITCODI
                        and MMITCODI = DMITMMIT
                        and SERIMMIT = MMITCODI
                        and DMITCODI = SERIDMIT;
      begin
            -- inicializa la posicion del detalle
            nuITDVCODI := 1;
            -- recorre las posiciones con seriales del movimiento e inserta los seriales vendidos
            for reItemSeriado in cuItemSeriado(inuDMITMMIT) loop

        nuITDVCOIN := fnuGetCodigoInternoItem(reItemSeriado.DMITITEM);
                -- realiza la insercion del item
                insert into LDCI_ITEMDOVE(ITDVDOVE,
                                                                  ITDVCODI,
                                                                  ITDVCOIN,
                                                                  ITDVITEM,
                                                                  ITDVCANT,
                                                                  ITDVCAPE,
                                                                  ITDVCOUN,
                                                                  ITDVVAUN,
                                                                  ITDVPIVA,
                                                                  ITDVMARC,
                                                                  ITDVSAFI,
                                                                  ITDVMABO,
                                                                  ITDVVALO,
                                                                  ITDVOPUN,
                                                                  ITDVPROV,
                                                                  ITDVSERI) values
                                                                (reItemSeriado.MMITDSAP,
                                                                  nuITDVCODI,
                                                                nuITDVCOIN,
                                                                  reItemSeriado.DMITITEM,
                                                                  1,
                                                                  0,
                                                                  reItemSeriado.DMITCOUN,
                                                                  reItemSeriado.DMITVAUN,
                                                                  reItemSeriado.DMITPIVA,
                                                                  reItemSeriado.DMITMARC,
                                                                  reItemSeriado.DMITSAFI,
                                                                  reItemSeriado.DMITMABO,
                                                                  reItemSeriado.DMITVALO,
                                                                  inuITDVOPUN,
                                                                  inuITDVPROV,
                                                                  reItemSeriado.SERINUME);


                --incrementa la posicion
                nuITDVCODI := nuITDVCODI + 1;
            end loop;--for reItemSeriado in cuItemSeriado(inuDMITMMIT) loop
      exception
          when others then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proCreaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proCreaPosicionesDocVenta;

      procedure proAsignaPosicionesDocVenta(isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type,
                                                                                inuITDVOPUN in NUMBER,
                                                                                inuITDVPROV in NUMBER,
                                                                                osbMesException out VARCHAR2) as
          /*
                PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
                FUNCION    : LDCI_PKMOVIMATERIAL.proAsignaPosicionesDocVenta
                AUTOR      : OLSoftware / Carlos E. Virgen
                FECHA      : 24-09-2013
                RICEF      : I064
                DESCRIPCION: Asigna los elementos seriados de un movimiento de material vendido

              Historia de Modificaciones
              Autor    Fecha       Descripcion
              carlosvl 24-09-2013  Crea el procedimiento
          */
            -- definicion de variables
            ol_Payload  CLOB;
            nuErrorCode NUMBER;

            -- Cursor de los items seriados
            cursor cuLDCI_ITEMDOVE(isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type) is
                select ITDVCODI,
                            ITDVITEM,
                            ITDVCANT,
                            ITDVCAPE,
                            ITDVCOUN,
                            ITDVVAUN,
                            ITDVPIVA,
                            ITDVMARC,
                            ITDVSERI,
                            ITDVSAFI,
                            ITDVMABO,
                            ITDVVALO
                    from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
                  where DOVECODI = isbITDVDOVE
                      and DOVECODI = ITDVDOVE
                      and CODE = ITDVITEM; --#OYM_CEV_2740_1  ITEMS_ID --> CODE
            --exepciones
            excep_proGenXMLItemSeriVendido exception;
            excepAPI_LOADACCEPT_ITEMS       exception;
      begin
            -- recorre las posiciones del documento de venta y llama el API API_LOADACCEPT_ITEMS
            for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop

                -- Genera el XML para hacer la asignaci??A?n del elemento seriado
                proGenXMLItemSeriVendido(isbITDVDOVE,
                                                                  inuITDVPROV,
                                                                  rgLDCI_ITEMDOVE.ITDVCODI,
                                                                  rgLDCI_ITEMDOVE.ITDVITEM,
                                                                  inuITDVOPUN,
                                                                  'I',
                                                                  ol_Payload,
                                                                  osbMesException);

                if (osbMesException is not null) then
                      raise excep_proGenXMLItemSeriVendido;
                end if;--if (osbMesException is not null) then

                -- Carga el serial a la unidad operativa destinada
                API_LOADACCEPT_ITEMS(ol_Payload, nuErrorCode, osbMesException);

                if (nuErrorCode <> 0) then
                      raise excepAPI_LOADACCEPT_ITEMS;
                end if;--if (nuErrorCode <> 0) then

            end loop;--for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop
      exception
          when excep_proGenXMLItemSeriVendido then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proAsignaPosicionesDocVenta.excep_proGenXMLItemSeriVendido]:' || chr(13) ||  'Excepcion API: ' || osbMesException || ' | '||  DBMS_UTILITY.format_error_backtrace;

          when excepAPI_LOADACCEPT_ITEMS then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proAsignaPosicionesDocVenta.excepAPI_LOADACCEPT_ITEMS]:' || chr(13) ||  'Excepcion API: ' || osbMesException || ' | '||  DBMS_UTILITY.format_error_backtrace;

          when others then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proAsignaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proAsignaPosicionesDocVenta;

      procedure proDesasignaPosicionesDocVenta(isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type,
                                                                                      inuITDVOPUN in NUMBER,
                                                                                      inuITDVPROV in NUMBER,
                                                                                      osbMesException out VARCHAR2) as
          /*
                PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
                FUNCION    : LDCI_PKMOVIMATERIAL.proDesasignaPosicionesDocVenta
                AUTOR      : OLSoftware / Carlos E. Virgen
                FECHA      : 24-09-2013
                RICEF      : I064
                DESCRIPCION: Desasigna los elementos seriados de un movimiento de material vendido

              Historia de Modificaciones
              Autor    Fecha       Descripcion
              carlosvl 24-09-2013  Crea el procedimiento
          */
            -- definicion de variables
            sbITDVITEM LDCI_ITEMDOVE.ITDVITEM%type;
            sbITDVSERI LDCI_ITEMDOVE.ITDVSERI%type;
            ol_Payload  CLOB;
            nuErrorCode NUMBER;

            -- cursor del item seriado
            cursor cuGE_ITEMS_SERIADO(inuITEMS_ID GE_ITEMS_SERIADO.ITEMS_ID%type, isbSERIE GE_ITEMS_SERIADO.SERIE%type) is
                select ITEMS_ID, SERIE, OPERATING_UNIT_ID
                    from GE_ITEMS_SERIADO
                  where SERIE = isbSERIE;

            -- Cursor de los items seriados
            cursor cuLDCI_ITEMDOVE(isbITDVDOVE in LDCI_ITEMDOVE.ITDVDOVE%type) is
                select ITDVCODI,
                            ITDVITEM,
                            ITDVCANT,
                            ITDVCAPE,
                            ITDVCOUN,
                            ITDVVAUN,
                            ITDVPIVA,
                            ITDVMARC,
                            ITDVSERI,
                            ITDVSAFI,
                            ITDVMABO,
                            ITDVVALO
                    from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
                  where DOVECODI = isbITDVDOVE
                      and DOVECODI = ITDVDOVE
                      and CODE = ITDVITEM; --#OYM_CEV_2740_1  ITEMS_ID --> CODE

            -- variables tipo registro
            reGE_ITEMS_SERIADO cuGE_ITEMS_SERIADO%rowtype;
            --exepciones
            excep_proGenXMLItemSeriVendido exception;
            excepAPI_LOADACCEPT_ITEMS       exception;
            excep_ITEM_SERIADO             exception;
      begin
            -- recorre las posiciones del documento de venta y llama el API API_LOADACCEPT_ITEMS
            for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop
                -- consulta el item seriado
                open cuGE_ITEMS_SERIADO(rgLDCI_ITEMDOVE.ITDVITEM, rgLDCI_ITEMDOVE.ITDVSERI);
                fetch cuGE_ITEMS_SERIADO into reGE_ITEMS_SERIADO;
                if(cuGE_ITEMS_SERIADO%ROWCOUNT = 1) then
                      -- Genera el XML para hacer la asignaci??A?n del elemento seriado
                      proGenXMLItemSeriVendido(isbITDVDOVE,
                                                                        inuITDVPROV,
                                                                        rgLDCI_ITEMDOVE.ITDVCODI,
                                                                        rgLDCI_ITEMDOVE.ITDVITEM,
                                                                        reGE_ITEMS_SERIADO.OPERATING_UNIT_ID,
                                                                        'I',
                                                                        ol_Payload,
                                                                        osbMesException);

                      if (osbMesException is not null) then
                            sbITDVITEM := rgLDCI_ITEMDOVE.ITDVITEM;
                            sbITDVSERI := rgLDCI_ITEMDOVE.ITDVSERI;
                            raise excep_proGenXMLItemSeriVendido;
                      end if;--if (osbMesException is not null) then

                      -- Carga el serial a la unidad operativa destinada
                      API_LOADACCEPT_ITEMS(ol_Payload, nuErrorCode, osbMesException);

                      if (nuErrorCode <> 0) then
                            raise excepAPI_LOADACCEPT_ITEMS;
                      end if;--if (nuErrorCode <> 0) then

                      -- actualiza la posici??A?n asignando el elemento seriado
                      update LDCI_ITEMDOVE set ITDVPROV = inuITDVPROV, ITDVOPUN = reGE_ITEMS_SERIADO.OPERATING_UNIT_ID
                        where   ITDVDOVE = isbITDVDOVE
                            and ITDVCODI = rgLDCI_ITEMDOVE.ITDVCODI;
                else
                      raise excep_ITEM_SERIADO;
                end if;--if(cuGE_ITEMS_SERIADO%ROWCOUNT = 1) then
                close cuGE_ITEMS_SERIADO;

            end loop;--for rgLDCI_ITEMDOVE in cuLDCI_ITEMDOVE(isbITDVDOVE) loop
      exception
          when excep_ITEM_SERIADO then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proDesasignaPosicionesDocVenta.excep_ITEM_SERIADO]:' || chr(13) || 'El elemento seriado [ITEM: ' || sbITDVITEM ||
                                                    '] [SERIE: ' || sbITDVSERI || '] no se encuentra registrado.'||  DBMS_UTILITY.format_error_backtrace;
          when excep_proGenXMLItemSeriVendido then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proDesasignaPosicionesDocVenta.excep_proGenXMLItemSeriVendido]:' || chr(13) ||  'Excepcion API: ' || osbMesException || ' | '||  DBMS_UTILITY.format_error_backtrace;

          when excepAPI_LOADACCEPT_ITEMS then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proDesasignaPosicionesDocVenta.excepAPI_LOADACCEPT_ITEMS]:' || chr(13) ||  'Excepcion API: ' || osbMesException || ' | '||  DBMS_UTILITY.format_error_backtrace;

          when others then
              osbMesException := '[LDCI_PKMOVIMATERIAL.proDesasignaPosicionesDocVenta]:' || chr(13) ||  'Error no controlado: ' || SQLERRM || ' | '||  DBMS_UTILITY.format_error_backtrace;
      end proDesasignaPosicionesDocVenta;

      procedure proConfirmarSolicitud(inuMovimiento in LDCI_INTEMMIT.MMITCODI%type) As
        /*
              PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
              FUNCION    : proConfirmarSolicitud
              AUTOR      : OLSoftware / Carlos E. Virgen
              FECHA      : 15-01-2013
              RICEF      : I004; I018
              DESCRIPCION: Toma los datos de la interfaz y le asigna a los datos al API OS_SET_REQUEST_CONF
        
            Historia de Modificaciones
              Autor               Fecha           Descripcion
              Jorge Valiente      01/FEB/2024     OSF-2141: Nueva logica validar un traslado de un ?tem seriado a SAP y 
                                                            retirar la relacion del ?tem seriado con unidad operativa.
        */
      
        onuErrorCode GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        -- define cursores
        -- cursor de los movimientos de material
        cursor cuMoviSolicitud(inuMMITCODI in LDCI_INTEMMIT.MMITCODI%type) is
          select *
            from LDCI_INTEMMIT
           where MMITCODI = decode(inuMMITCODI, -1, MMITCODI, inuMMITCODI)
             and MMITESTA = 1
             and MMITINTE <= 3
           order by MMITCODI asc;
      
        -- cursor del documento. Usado para determinar el tipo del documento
        cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
          select ID_ITEMS_DOCUMENTO, DOCUMENT_TYPE_ID
            from GE_ITEMS_DOCUMENTO
           where ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;
      
        cursor cuGE_CONTRATISTA(isbIDENTIFICATION GE_SUBSCRIBER.IDENTIFICATION%type) is
          select su.IDENTIFICATION,
                 CO.NOMBRE_CONTRATISTA,
                 UO.OPERATING_UNIT_ID,
                 UO.NAME
            from GE_CONTRATISTA co, OR_OPERATING_UNIT uo, GE_SUBSCRIBER su
           where co.ID_CONTRATISTA = uo.CONTRACTOR_ID
             and su.SUBSCRIBER_ID = co.SUBSCRIBER_ID
             and su.IDENTIFICATION = isbIDENTIFICATION;
      
        cursor cuCOUTN_OR_OPERATING_UNIT(isbIDENTIFICATION GE_SUBSCRIBER.IDENTIFICATION%type) is --#OYM_CEV_2740_1
          select count(*) COUNT_OR_OPERATING_UNIT
            from GE_CONTRATISTA co, OR_OPERATING_UNIT uo, GE_SUBSCRIBER su
           where co.ID_CONTRATISTA = uo.CONTRACTOR_ID
             and su.SUBSCRIBER_ID = co.SUBSCRIBER_ID
             and su.IDENTIFICATION = isbIDENTIFICATION;
      
        -- registro de cuGE_ITEMS_DOCUMENTO
        reGE_ITEMS_DOCUMENTO      cuGE_ITEMS_DOCUMENTO%rowtype;
        reGE_CONTRATISTA          cuGE_CONTRATISTA%rowtype;
        reCOUTN_OR_OPERATING_UNIT cuCOUTN_OR_OPERATING_UNIT%rowtype; --#OYM_CEV_2740_1
        nuMMITCODI                NUMBER; --138682
      
        -- define variables
        l_Payload   CLOB;
        nuErrorCode NUMBER;
        osbMesjErr  GE_ERROR_LOG.DESCRIPTION%type;
      
        --OSF-2141 Cursor para identificar si el traslado realizado a SAP es un Z02 (Traslado Inventario) o Z14 (Traslado Activo).
        cursor cuItemSeriado(inuSERIMMIT      LDCI_SERIDMIT.SERIMMIT%type,
                             isbDevoMate      Varchar2,
                             isbClasDevMatAct Varchar2) is
          select *
            from LDCI_INTEMMIT
           inner join LDCI_DMITMMIT
              on DMITMMIT = MMITCODI
             and MMITTIMO in (isbDevoMate, isbClasDevMatAct)
           inner join LDCI_SERIDMIT
              on SERIMMIT = MMITCODI
             and SERIDMIT = Dmitcodi
           inner join ge_items_seriado gis
              on gis.items_id = LDCI_DMITMMIT.DMITITEM
             and gis.serie = Serinume
             and gis.operating_unit_id is not null
           where MMITCODI = inuSERIMMIT;
      
        rfcuItemSeriado cuItemSeriado%rowtype;
      
        csbMetodo CONSTANT VARCHAR2(100) := csbsp_name ||
                                            '.proConfirmarSolicitud'; --Nombre del metodo en la traza
        ----------------------
      
      begin
        
        pkg_traza.trace(csbMetodo,pkg_traza.cnuNivelTrzDef,pkg_traza.csbINICIO);
      
        -- carga la configuracion de las diferentes clase de movimiento
        open cuClaseMovi;
        fetch cuClaseMovi
          into reClaseMovi;
        close cuClaseMovi;
      
        open cuWS_MOVIMIENTO_MATERIAL;
        fetch cuWS_MOVIMIENTO_MATERIAL
          into reWS_MOVIMIENTO_MATERIAL;
        close cuWS_MOVIMIENTO_MATERIAL;
      
        -- recorre los movimientos cuMoviSolicitud
        for reMoviSolicitud in cuMoviSolicitud(inuMovimiento) loop
          nuMMITCODI := reMoviSolicitud.MMITCODI; --138682
          -- Valida si el movimiento a procesar es de venta o de requisicion
          -- Si el campo MMITNUDO no es nulo, es por que el movimiento es de requisicion
          if (reMoviSolicitud.MMITNUDO is not null and
             reMoviSolicitud.MMITCLIE is null) then
          
            LDCI_PKMOVIMATERIAL.proValidaSeriales(reMoviSolicitud.MMITCODI, --138682
                                                  onuErrorCode,
                                                  osbMesjErr);
          
            if (osbMesjErr is not null) then
              --138682
              --actualiza el registro para
              proActualizaMovimiento(reMoviSolicitud.MMITCODI,
                                     'INTENTO',
                                     osbMesjErr);
            else
              -- determina el tipo de movimiento
              open cuGE_ITEMS_DOCUMENTO(to_number(reMoviSolicitud.MMITNUDO));
              fetch cuGE_ITEMS_DOCUMENTO
                into reGE_ITEMS_DOCUMENTO;
              close cuGE_ITEMS_DOCUMENTO;
            
              -- valida el tipo de movimiento
              -- si es un movimiento de suministro
              if (reGE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID = 102) then
                -- acepta los items entregados
                proAceptItem(reMoviSolicitud.MMITCODI, osbMesjErr);
              
                if (osbMesjErr is not null) then
                  --actualiza el registro para
                  proActualizaMovimiento(reMoviSolicitud.MMITCODI,
                                         'INTENTO',
                                         osbMesjErr);
                else
                  -- confirma la operacion
                  commit;
                  -- cierra el movimiento
                  proActualizaMovimiento(reMoviSolicitud.MMITCODI,
                                         'CONFIRMADO',
                                         osbMesjErr);
                end if; --if (osbMesjErr is not null) then
              else
                -- si es un movimiento de traslado de material / devolucion
                if (reGE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID = 105) then
                  -- acepta traslado de items
                  proAcepTrastItem(reMoviSolicitud.MMITCODI, osbMesjErr);
                  -- valida si la transaccion es exitosa
                  if (osbMesjErr is not null) then
                    proActualizaMovimiento(reMoviSolicitud.MMITCODI,
                                           'INTENTO',
                                           osbMesjErr);
                  else
                    -- elimina documento en transito
                    LDCI_PKRESERVAMATERIAL.proElimDocuTran(to_number(reMoviSolicitud.MMITNUDO),
                                                           onuErrorCode,
                                                           osbMesjErr);
                    -- confirma la operacion
                  
                    ---Inicio OSF-2141 Retira unidad opertaiva de item seriado proveniente de un Z02(Traeslado) o Z14(Anulacion)
                    pkg_traza.trace('Data de parametros de entrada del cursor cuItemSeriado(nuMMITCODI[' ||
                                    nuMMITCODI ||
                                    '],reClaseMovi.sbDevoMate[' ||
                                    reClaseMovi.sbDevoMate ||
                                    '],reClaseMovi.sbClasDevMatAct[' ||
                                    reClaseMovi.sbClasDevMatAct || '])',
                                    pkg_traza.cnuNivelTrzDef);
                  
                    for rfcuItemSeriado in cuItemSeriado(nuMMITCODI,
                                                         reClaseMovi.sbDevoMate,
                                                         reClaseMovi.sbClasDevMatAct) loop
                      pkg_traza.trace('Codigo intefaz [' || nuMMITCODI ||
                                      '] TIPO DE MOVIMIENTO [' ||
                                      rfcuItemSeriado.Mmittimo || ']',
                                      pkg_traza.cnuNivelTrzDef);
                      pkg_traza.trace('El item [' ||
                                      rfcuItemSeriado.Dmititem ||
                                      '] tiene una serie [' ||
                                      rfcuItemSeriado.Serinume ||
                                      '] con unidad operativa[' ||
                                      rfcuItemSeriado.Operating_Unit_Id ||
                                      ']. Esta unidad operativa sera retirada de ge_items_seriado',
                                      pkg_traza.cnuNivelTrzDef);
                      pkg_ge_items_seriado.prcRetirarUnidadOperativa(rfcuItemSeriado.Dmititem,
                                                                     rfcuItemSeriado.Serinume);
                    end loop;
                    ----Fin OSF-2141
                  
                    commit;
                    -- cierra el movimiento
                    proActualizaMovimiento(reMoviSolicitud.MMITCODI,
                                           'CONFIRMADO',
                                           osbMesjErr);
                  end if; -- if (osbMesjErr is not null) then
                end if; --if (reGE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID = 102) then
              end if; --if (reGE_ITEMS_DOCUMENTO.DOCUMENT_TYPE_ID = 102) then
            end if; --if (reMoviSolicitud.MMITNUDO is not null and reMoviSolicitud.MMITCLIE is null) then
          end if; --if (osbMesjErr is not null) then --138682
        
        end loop; -- for reMoviSolicitud in cuMoviSolicitud loop
        
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      
      Exception
        When Others Then
          proActualizaMovimiento(nuMMITCODI, 'INTENTO', SQLERRM); --138682
          pkErrors.NotifyError(pkErrors.fsbLastObject, SQLERRM, osbMesjErr);
          pkg_Error.setError;
          pkg_Error.getError(onuErrorCode, osbMesjErr);
      end proConfirmarSolicitud;

      -- Notifica el movimiento de isbMaterial al front
      PROCEDURE proReprocesaMovimiento(inuMovMatCodi   in  LDCI_INTEMMIT.MMITCODI%type,
                                                                      inuCurrent       in NUMBER,
                                                                      inuTotal         in NUMBER,
                                                                      onuErrorCode    out NUMBER,
                                                                      osbErrorMessage out VARCHAR2)  is
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : LDCI_PKMOVIMATERIAL.proReprocesaMovimiento
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 04-04-2013
            RICEF      : I004; I018
            DESCRIPCION: Toma los datos de la interfaz y le asigna a los datos al API OS_SET_REQUEST_CONF

          Historia de Modificaciones
          Autor   Fecha   Descripcion
      */
      begin
          ut_trace.trace('inicia proReprocesaMovimiento',15);
          ut_trace.trace('inicia inuMovMatCodi: ' || inuMovMatCodi ,16);
          ut_trace.trace('inicia inuCurrent   : ' || inuCurrent ,16);
          ut_trace.trace('inicia inuTotal     : ' || inuTotal ,16);
          ut_trace.trace('finaliza proReprocesaMovimiento',15);
      exception
          when pkg_error.CONTROLLED_ERROR then
                raise;

          when OTHERS then
                Errors.setError;
                raise pkg_error.CONTROLLED_ERROR;
      end proReprocesaMovimiento;


      -- Notifica el movimiento de isbMaterial al front
      PROCEDURE proAsignaMaterialSeriado(isbPosicion     in VARCHAR2,
                                                                          inuCurrent       in NUMBER,
                                                                          inuTotal         in NUMBER,
                                                                          onuErrorCode    out NUMBER,
                                                                          osbErrorMessage out VARCHAR2)  is
      /*
            PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
            FUNCION    : LDCI_PKMOVIMATERIAL.proAsignaMaterialSeriado
            AUTOR      : OLSoftware / Carlos E. Virgen
            FECHA      : 04-04-2013
            RICEF      : I064
            DESCRIPCION: Toma los datos de la interfaz y le asigna a los datos al API OS_SET_REQUEST_CONF

          Historia de Modificaciones
          Autor   Fecha   Descripcion
      */
          cnuNULL_ATTRIBUTE constant number := 2126;
          nuErrorCode NUMBER;
          ol_Payload CLOB;
          sb_Payload VARCHAR2(3000);
          osbMesjErr VARCHAR2(2000);

          -- definicion de cursores
          -- cusor de la posicion
          cursor cuPosicion(isbPosicion VARCHAR2) is
              select * from
                (select rownum CODIGO,
                                trim(regexp_substr(isbPosicion,'[^|]+', 1, level)) VALOR
                    from dual
                      connect by regexp_substr(isbPosicion, '[^|]+', 1, level) is not null)
              PIVOT (MAX(VALOR)  FOR (CODIGO) IN (1 as DOC, 2 as POS, 3 as UNIDAD_OPERATIVA,4 as PROVEEDOR));

          -- cursor de la posicion vendida
          cursor cuLDCI_ITEMDOVE(isbDOVECODI LDCI_DOCUVENT.DOVECODI%type,
                                                      inuITDVCODI LDCI_ITEMDOVE.ITDVCODI%type) is
                      select ITDVCODI,
                                  ITDVITEM,
                                  ITDVCANT,
                                  ITDVCAPE,
                                  ITDVCOUN,
                                  ITDVVAUN,
                                  ITDVPIVA,
                                  ITDVMARC,
                                  ITDVSERI,
                                  ITDVSAFI,
                                  ITDVMABO,
                                  ITDVVALO
                  from LDCI_DOCUVENT, LDCI_ITEMDOVE, GE_ITEMS
                where DOVECODI = isbDOVECODI
                    and ITDVCODI = inuITDVCODI
                    and DOVECODI = ITDVDOVE
                    and CODE = ITDVITEM;  --#OYM_CEV_2740_1 ITEMS_ID --> CODE

          -- variables tipo registro
          reLDCI_ITEMDOVE cuLDCI_ITEMDOVE%rowtype;
          rePosicion        cuPosicion%rowtype;
      begin
     --FAC_CEV_3655_1
     open cuWS_MOVIMIENTO_MATERIAL;
     fetch cuWS_MOVIMIENTO_MATERIAL into reWS_MOVIMIENTO_MATERIAL;
     close cuWS_MOVIMIENTO_MATERIAL;

          nuErrorCode := 0;

          open cuPosicion(isbPosicion);
          fetch cuPosicion into rePosicion;
          close cuPosicion;

          ------------------------------------------------
          -- Required Attributes
          ------------------------------------------------
          if (rePosicion.DOC is null) then
                  Errors.SetError (cnuNULL_ATTRIBUTE, 'NUMERO DOCUMENTO SAP');
                  raise pkg_error.CONTROLLED_ERROR;
          end if;

          if (rePosicion.PROVEEDOR is null) then
                  Errors.SetError (cnuNULL_ATTRIBUTE, 'UNIDAD OPERATIVA PROVEEDOR LOG???STICO');
                  raise pkg_error.CONTROLLED_ERROR;
          end if;

          if (rePosicion.UNIDAD_OPERATIVA is null) then
                  Errors.SetError (cnuNULL_ATTRIBUTE, 'C???DIGO UNIDAD OPERATIVA');
                  raise pkg_error.CONTROLLED_ERROR;
          end if;

          ut_trace.trace('inicia proAsignaMaterialSeriado',15);
          ut_trace.trace('inicia rePosicion.DOC             : ' || rePosicion.DOC ,16);
          ut_trace.trace('inicia rePosicion.POS             : ' || rePosicion.POS ,16);
          ut_trace.trace('inicia rePosicion.PROVEEDOR       : ' || rePosicion.PROVEEDOR ,16);
          ut_trace.trace('inicia rePosicion.UNIDAD_OPERATIVA: ' || rePosicion.UNIDAD_OPERATIVA ,16);
          ut_trace.trace('inicia inuCurrent     : ' || inuCurrent ,16);
          ut_trace.trace('inicia inuTotal       : ' || inuTotal ,16);


          open cuLDCI_ITEMDOVE(rePosicion.DOC, rePosicion.POS);
          fetch cuLDCI_ITEMDOVE into reLDCI_ITEMDOVE;
          close cuLDCI_ITEMDOVE;

          ut_trace.trace('call proGenXMLItemSeriVendido : ' ,16);

          -- genera el XML para el acep item
          proGenXMLItemSeriVendido(rePosicion.DOC,
                                                            rePosicion.PROVEEDOR,
                                                            rePosicion.POS,
                                                            reLDCI_ITEMDOVE.ITDVITEM,
                                                            rePosicion.UNIDAD_OPERATIVA,
                                                            'I',
                                                            ol_Payload,
                                                            osbMesjErr);

          sb_Payload := ol_Payload;
          ut_trace.trace('out proGenXMLItemSeriVendido : ' ,16);
          ut_trace.trace('ol_Payload : ' || chr(13) || sb_Payload ,16);
          ut_trace.trace('osbMesjErr : ' || chr(13) || osbMesjErr ,16);


          if (osbMesjErr is not null) then
                Errors.SetError (cnuNULL_ATTRIBUTE, osbMesjErr);
                raise pkg_error.CONTROLLED_ERROR;
          end if;--if (osbMesjErr is not null) then

          -- Carga el serial a la unidad operativa destinada
          API_LOADACCEPT_ITEMS(ol_Payload, nuErrorCode, osbMesjErr);

          -- valida si API_LOADACCEPT_ITEMS se ejecuto con exito
          if (nuErrorCode <> 0) then
                Errors.SetError (cnuNULL_ATTRIBUTE, osbMesjErr);
                raise pkg_error.CONTROLLED_ERROR;
          end if;--if (onuErrorCode <> 0) then

          -- actualiza la posici??A?n asignando el elemento seriado
          update LDCI_ITEMDOVE set ITDVPROV = rePosicion.PROVEEDOR, ITDVOPUN = rePosicion.UNIDAD_OPERATIVA
            where   ITDVDOVE = rePosicion.DOC
                and ITDVCODI = rePosicion.POS ;
          ut_trace.trace('finaliza proAsignaMaterialSeriado',15);

      exception
          when pkg_error.CONTROLLED_ERROR then
                raise;

          when OTHERS then
                Errors.setError;
                raise pkg_error.CONTROLLED_ERROR;
      end proAsignaMaterialSeriado;
PROCEDURE ldc_actualizabodegasdev(
                                   sbpanrodocumento VARCHAR2
                                  ,nupacantidad     NUMBER
                                  ,sbpaitems        VARCHAR2
                                  ,nupaerror        OUT NUMBER
                                  ,sbpaerror        OUT VARCHAR2
/*************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Actualiza bodega de activo e inventario de items serializados y no-serializados 
                cuando hay aceptacion parcial o total.

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento
   nupacantidad          Cantidad aceptada
   sbpaitems             Nro del items

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

*************************************************************************************************/                                  
                                 ) IS
  --------------
  -- Variable
  --------------
  nuoperunittarget  or_uni_item_bala_mov.target_oper_unit_id%Type;
  nunidadorigen     or_uni_item_bala_mov.operating_unit_id%type;
  nucausaltraslado  ge_items_documento.causal_id%TYPE;
  nucantidadmov     or_uni_item_bala_mov.amount%TYPE;
  nuvaitem          or_uni_item_bala_mov.items_id%TYPE;
  sbtipobod         varchar2(1);
  nuiddocumento     ge_items_documento.id_items_documento%TYPE;
  -- Cursor datos del documento
 CURSOR cudatosdocu(nucuiddocumento NUMBER) IS
  SELECT d.*
    FROM ge_items_documento d,or_operating_unit u
   WHERE d.id_items_documento   = nucuiddocumento
     AND u.oper_unit_classif_id = 11
     AND d.document_type_id     = 105
     AND d.destino_oper_uni_id  = u.operating_unit_id;

 --Cursor que Valida si la casual es de inventario  o de traslado
  Cursor cuvalcausal(nucausal ge_causal.causal_id%Type) Is
    Select 'I' AS tipo
      From ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_INVENTARIO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    Union
    Select 'A' AS  tipo
      From ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_ACTIVO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    --INICIO CA200-930
       UNION
      SELECT 'G' AS TIPO
      FROM  GE_CAUSAL
      WHERE  causal_id IN
                    ( SELECT TO_NUMBER(COLUMN_VALUE)
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.fsbGetValue_Chain('CODIGO_TRASLADO_GENERAL',NULL),',')
                        )
                    )
      AND causal_id = nuCausal;
BEGIN
 nuiddocumento   := to_number(TRIM(sbpanrodocumento));
 FOR i IN cudatosdocu(nuiddocumento) LOOP
  nuoperunittarget := i.destino_oper_uni_id;
  nunidadorigen    := i.operating_unit_id;
  nuvaitem         := to_number(TRIM(sbpaitems));
  nucausaltraslado := i.causal_id;
  nucantidadmov    := nupacantidad;
   OPEN cuvalcausal(nucausaltraslado);
  FETCH cuvalcausal INTO sbtipobod;
     IF cuvalcausal%FOUND THEN
      IF sbtipobod = 'I' THEN
       -- Bodega Origen inventario
       UPDATE ldc_inv_ouib
          SET transit_out       = nvl(transit_out,0) - nvl(nucantidadmov,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nunidadorigen;
         -- Bodega destino inventario
       UPDATE ldc_inv_ouib
          SET transit_in        = nvl(transit_in,0) - nvl(nucantidadmov,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nuoperunittarget;
      ELSIF sbtipobod = 'A' THEN
        -- Bodega Origen activo
       UPDATE ldc_act_ouib
          SET transit_out       = nvl(transit_out,0) - nvl(nucantidadmov,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nunidadorigen;
       -- Bodega destino activo
       UPDATE ldc_act_ouib
          SET transit_in         = nvl(transit_in,0) - nvl(nucantidadmov,0)
         WHERE items_id          = nuvaitem
           AND operating_unit_id = nuoperunittarget;
      END IF;
     END IF;
    CLOSE cuvalcausal;
 END LOOP;
 nupaerror := 0;
 sbpaerror := NULL;
EXCEPTION
 WHEN OTHERS THEN
  nupaerror := -1;
  sbpaerror := 'LDC_ACTUALIZABODEGASDEV '||SQLERRM;
END ldc_actualizabodegasdev;
PROCEDURE ldc_actbodegasdevserrech(
                                    sbpanrodocumento VARCHAR2
                                   ,nuiditemser      NUMBER
                                   ,sbpaitems        VARCHAR2
                                   ,nupaerror        OUT NUMBER
                                   ,sbpaerror        OUT VARCHAR2
/********************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Actualiza bodega de activo e inventario de items serializados cuando hay rechazo parcial 
                o total.

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento
   nupacantidad          Cantidad rechazada
   sbpaitems             Nro del items

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

**********************************************************************************************************/                                   
                                  ) IS
  --------------
  -- Variable
  --------------
  nuoperunittarget  or_uni_item_bala_mov.target_oper_unit_id%Type;
  nunidadorigen     or_uni_item_bala_mov.operating_unit_id%type;
  nucausaltraslado  ge_items_documento.causal_id%TYPE;
  nucantidadmov     or_uni_item_bala_mov.amount%TYPE;
  nuvaitem          or_uni_item_bala_mov.items_id%TYPE;
  sbtipobod         varchar2(1);
  nuiddocumento     ge_items_documento.id_items_documento%TYPE;
  nuvalorunitario   or_uni_item_bala_mov.total_value%TYPE;
  nuvabalance       ldc_inv_ouib.balance%TYPE;
 -- Cursor datos del documento
 CURSOR cudatosdocu(nucuiddocumento NUMBER) IS
  SELECT d.*
    FROM ge_items_documento d,or_operating_unit u
   WHERE d.id_items_documento   = nucuiddocumento
     AND u.oper_unit_classif_id = 11
     AND d.document_type_id     = 105
     AND d.destino_oper_uni_id  = u.operating_unit_id;

 --Cursor que Valida si la casual es de inventario  o de traslado
  Cursor cuvalcausal(nucausal ge_causal.causal_id%Type) Is
    Select 'I' AS tipo
      From ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_INVENTARIO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    Union
    Select 'A' AS  tipo
      From ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_ACTIVO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    --INICIO CA200-930
       UNION
      SELECT 'G' AS tipo
      FROM  ge_causal
      WHERE  causal_id IN
                    ( SELECT to_number(column_value)
                       FROM TABLE
                        (ldc_boutilities.splitstrings(
                            dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_GENERAL',NULL),',')
                        )
                    )
      AND causal_id = nuCausal;
BEGIN
 nuiddocumento   := to_number(TRIM(sbpanrodocumento));
 FOR i IN cudatosdocu(nuiddocumento) LOOP
  nuoperunittarget := i.destino_oper_uni_id;
  nunidadorigen    := i.operating_unit_id;
  nuvaitem         := to_number(TRIM(sbpaitems));
  nucausaltraslado := i.causal_id;
  nucantidadmov    := 0;
  nuvalorunitario  := 0;
  nuvabalance      := 0;
  BEGIN
    SELECT xy.amount,xy.total_value INTO nucantidadmov,nuvalorunitario
      FROM or_uni_item_bala_mov xy
     WHERE xy.id_items_documento = i.id_items_documento
       AND xy.id_items_seriado   = nuiditemser
       AND xy.movement_type      = 'N';
   EXCEPTION
    WHEN no_data_found THEN
     nucantidadmov   := 0;
     nuvalorunitario := 0;
   END;
   nuvabalance := nucantidadmov;
   OPEN cuvalcausal(nucausaltraslado);
  FETCH cuvalcausal INTO sbtipobod;
     IF cuvalcausal%FOUND THEN
      IF sbtipobod = 'I' THEN
       -- Bodega Origen inventario
       UPDATE ldc_inv_ouib
          SET transit_out       = nvl(transit_out,0) - nvl(nucantidadmov,0)
             ,total_costs       = nvl(total_costs,0) + nvl(nuvalorunitario,0)
             ,balance           = nvl(balance,0)     + nvl(nuvabalance,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nunidadorigen;
         -- Bodega destino inventario
       UPDATE ldc_inv_ouib
          SET transit_in        = nvl(transit_in,0) - nvl(nucantidadmov,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nuoperunittarget;
      ELSIF sbtipobod = 'A' THEN
        -- Bodega Origen activo
       UPDATE ldc_act_ouib
          SET transit_out       = nvl(transit_out,0) - nvl(nucantidadmov,0)
             ,total_costs       = nvl(total_costs,0) + nvl(nuvalorunitario,0)
             ,balance           = nvl(balance,0)     + nvl(nuvabalance,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nunidadorigen;
       -- Bodega destino activo
       UPDATE ldc_act_ouib
          SET transit_in         = nvl(transit_in,0) - nvl(nucantidadmov,0)
         WHERE items_id          = nuvaitem
           AND operating_unit_id = nuoperunittarget;
      END IF;
     END IF;
    CLOSE cuvalcausal;
 END LOOP;
 nupaerror := 0;
 sbpaerror := NULL;
EXCEPTION
 WHEN OTHERS THEN
  nupaerror := -1;
  sbpaerror := 'LDC_ACTBODEGASDEVSERRECH '||SQLERRM;
END ldc_actbodegasdevserrech;
PROCEDURE ldc_actbodegasdevrechnoser(
                                     sbpanrodocumento VARCHAR2
                                    ,sbpaitems        VARCHAR2
                                    ,nupaerror        OUT NUMBER
                                    ,sbpaerror        OUT VARCHAR2
/*************************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Actualiza bodega de activo e inventario de items no serializados cuando hay rechazo parcial 
                o total.

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento
   sbpaitems             Nro del items

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

*************************************************************************************************************/                                    
                                    ) IS
  --------------
  -- Variable
  --------------
  nuoperunittarget  or_uni_item_bala_mov.target_oper_unit_id%Type;
  nunidadorigen     or_uni_item_bala_mov.operating_unit_id%type;
  nucausaltraslado  ge_items_documento.causal_id%TYPE;
  nucantidadmov     or_uni_item_bala_mov.amount%TYPE;
  nuvaitem          or_uni_item_bala_mov.items_id%TYPE;
  sbtipobod         varchar2(1);
  nuiddocumento     ge_items_documento.id_items_documento%TYPE;
  nuvalorunitario   or_uni_item_bala_mov.total_value%TYPE;
  nuvabalance       ldc_inv_ouib.balance%TYPE;
  nucontaitemseri   NUMBER(8);
  sbusuario         VARCHAR2(100);

  -- Cursor datos del documento
 CURSOR cudatosdocu(nucuiddocumento NUMBER) IS
  SELECT d.*
    FROM ge_items_documento d,or_operating_unit u
   WHERE d.id_items_documento   = nucuiddocumento
     AND u.oper_unit_classif_id = 11
     AND d.document_type_id     = 105
     AND d.destino_oper_uni_id  = u.operating_unit_id;

 --Cursor que Valida si la casual es de inventario  o de traslado
  Cursor cuvalcausal(nucausal ge_causal.causal_id%Type) Is
    Select 'I' AS tipo
      From ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_INVENTARIO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    Union
    Select 'A' AS  tipo
      From ge_causal
     Where causal_id In
           (Select to_number(column_value)
              From Table(ldc_boutilities.splitstrings(dald_parameter.fsbgetvalue_chain('CODIGO_TRASLADO_ACTIVO',
                                                                                       Null),
                                                      ',')))
       And causal_id = nucausal
    --INICIO CA200-930
       UNION
      SELECT 'G' AS TIPO
      FROM  GE_CAUSAL
      WHERE  causal_id IN
                    ( SELECT TO_NUMBER(COLUMN_VALUE)
                       FROM TABLE
                        (LDC_BOUTILITIES.SPLITSTRINGS(
                            DALD_PARAMETER.fsbGetValue_Chain('CODIGO_TRASLADO_GENERAL',NULL),',')
                        )
                    )
      AND causal_id = nuCausal;
BEGIN
 nuiddocumento   := to_number(TRIM(sbpanrodocumento));
 FOR i IN cudatosdocu(nuiddocumento) LOOP
  nuoperunittarget := i.destino_oper_uni_id;
  nunidadorigen    := i.operating_unit_id;
  nuvaitem         := to_number(TRIM(sbpaitems));
  nucausaltraslado := i.causal_id;
  nucantidadmov    := 0;
  nuvalorunitario  := 0;
  nuvabalance      := 0;
  BEGIN
   SELECT xy.amount,xy.total_value INTO nucantidadmov,nuvalorunitario
     FROM or_uni_item_bala_mov xy
    WHERE xy.uni_item_bala_mov_id =(
                                    SELECT MAX(ouibm.uni_item_bala_mov_id)
                                      FROM or_uni_item_bala_mov ouibm
                                     WHERE ouibm.items_id           = nuvaitem
                                       AND ouibm.operating_unit_id  = nuoperunittarget
                                       AND ouibm.movement_type      = 'N'
                                       AND ouibm.id_items_documento = nuiddocumento
                                    );
   EXCEPTION
    WHEN no_data_found THEN
     nucantidadmov   := 0;
     nuvalorunitario := 0;
   END;
   nuvabalance := nucantidadmov;
   OPEN cuvalcausal(nucausaltraslado);
  FETCH cuvalcausal INTO sbtipobod;
     IF cuvalcausal%FOUND THEN
      IF sbtipobod = 'I' THEN
       -- Bodega Origen inventario
       UPDATE ldc_inv_ouib
          SET transit_out       = nvl(transit_out,0) - nvl(nucantidadmov,0)
             ,total_costs       = nvl(total_costs,0) + nvl(nuvalorunitario,0)
             ,balance           = nvl(balance,0)     + nvl(nuvabalance,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nunidadorigen;
         -- Bodega destino inventario
       UPDATE ldc_inv_ouib
          SET transit_in        = nvl(transit_in,0) - nvl(nucantidadmov,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nuoperunittarget;
      ELSIF sbtipobod = 'A' THEN
        -- Bodega Origen activo
       UPDATE ldc_act_ouib
          SET transit_out       = nvl(transit_out,0) - nvl(nucantidadmov,0)
             ,total_costs       = nvl(total_costs,0) + nvl(nuvalorunitario,0)
             ,balance           = nvl(balance,0)     + nvl(nuvabalance,0)
        WHERE items_id          = nuvaitem
          AND operating_unit_id = nunidadorigen;
       -- Bodega destino activo
       UPDATE ldc_act_ouib
          SET transit_in         = nvl(transit_in,0) - nvl(nucantidadmov,0)
         WHERE items_id          = nuvaitem
           AND operating_unit_id = nuoperunittarget;
      END IF;
     END IF;
    CLOSE cuvalcausal;
 END LOOP;
 nupaerror := 0;
 sbpaerror := NULL;
EXCEPTION
 WHEN OTHERS THEN
  nupaerror := -1;
  sbpaerror := 'LDC_ACTBODEGASDEVRECHNOSER '||SQLERRM;
END ldc_actbodegasdevrechnoser;
PROCEDURE ldc_cerrardocumentotraslados(nupadocumento NUMBER,nupaerror OUT NUMBER,sbpamensaje OUT VARCHAR2) IS
 /********************************************************************************************************
  Autor       : John Jairo Jimenez Marimon
  Fecha       : 2017-11-09
  Descripcion : Cierra el documento inicial cuando se realizan todas las transacciones .

  Parametros Entrada
   sbpanrodocumento      Nro Documento del moviento

  Valor de salida   
   nupaerror             Nro del error generado
   sbpaerror             Descripcion del error

 HISTORIA DE MODIFICACIONES
   FECHA        AUTOR   DESCRIPCION

**********************************************************************************************************/  
 nucontatotalmov       NUMBER(8);
 nucontatotalmovCcero  NUMBER(8);
 nucontatotaldocmov    NUMBER(8);
BEGIN
 nupaerror   := 0;
 sbpamensaje := NULL;
 nucontatotalmov       := 0;
 nucontatotalmovCcero  := 0;
 nucontatotaldocmov    := 0;
-- Total movimientos neutro del documento de soporte
 SELECT COUNT(1) INTO nucontatotalmov
   FROM or_uni_item_bala_mov l
  WHERE l.id_items_documento = nupadocumento
    AND l.movement_type = 'N';
-- Total movimientos neutros con documento de soporte cero
 SELECT COUNT(1) INTO nucontatotalmovCcero
   FROM or_uni_item_bala_mov c
  WHERE c.id_items_documento = nupadocumento
    AND c.movement_type = 'N'
    AND TRIM(c.support_document) = '0';
 -- Total movimientos neutros con documento de soporte cerrados
 SELECT COUNT(1) INTO nucontatotaldocmov
   FROM or_uni_item_bala_mov d
  WHERE d.id_items_documento = nupadocumento
    AND d.movement_type = 'N'
    AND TRIM(d.support_document) <> '0'
    AND TRIM(d.support_document) IN(SELECT to_char(g.id_items_documento)
                                      FROM ge_items_documento g
                                     WHERE to_char(g.id_items_documento) = TRIM(d.support_document)
                                       AND g.estado = 'C');
 IF nucontatotalmov = (nucontatotalmovCcero + nucontatotaldocmov) THEN
  UPDATE ge_items_documento f
     SET f.estado = 'C'
   WHERE f.id_items_documento = nupadocumento;
 END IF;
 nupaerror   := 0;
 sbpamensaje := NULL;
EXCEPTION
 WHEN OTHERS THEN
  nupaerror   := -1;
  sbpamensaje := SQLERRM;
END ldc_cerrardocumentotraslados;
END LDCI_PKMOVIMATERIAL;
/
