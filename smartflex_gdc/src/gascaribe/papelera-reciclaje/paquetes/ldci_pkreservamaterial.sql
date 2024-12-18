CREATE OR REPLACE PACKAGE LDCI_PKRESERVAMATERIAL AS
/*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
   FUNCION    : LDCI_PKRESERVAMATERIAL
   AUTOR      : Mauricio Fernando Ortiz
   FECHA      : 12/12/2012
   RICEF      : I005; I006
   DESCRIPCION: Paquete que permite realizar reserva de materiales

  Historia de Modificaciones
  Autor           Fecha       Descripcion
  Eduardo Aguera  02/07/2015  Cambio 8136. proNotificaReservas. Se optimiza consulta de XML utilizando cursor con XMLTable para obtener las solicitudes.
  dsaltarin		  02/06/2020  Cambio 380. proEnviarSolicitud. Se cambia la forma del xml para devolver seriales.
  jpinedc         27/05/2024  OSF-2603: Se ajusta proNotificaExepcion  
*/

  -- procedimeinto que notifica las devoluciones pendientes
  procedure proNotificaDevoluciones;

  -- procedimeinto que notifica las reservas
  procedure proNotificaReservas;

  -- procedimiento que se ejecutara como JOB para el despacho de solicitudes
  procedure proNotificaDocumentosERP;

    -- procedimeinto que registra un documento en transito
  procedure proCreaDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%type,
                            onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%type,
                            osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%type);

  procedure proElimDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%type,
                            onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%type,
                            osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%type);

  procedure proNotificaExepcion(inuDocumento     in NUMBER,
                                isbAsunto        in VARCHAR2,
                                isbMesExcepcion  in VARCHAR2)  ;

  function fsbGetDocuTran(inuDOTRDOCU in LDCI_DOCUTRAN.DOTRDOCU%type) return VARCHAR2;

  Function fsbGETxmlserializados(sboperacion VARCHAR2,nucodumento NUMBER,nuitemspa NUMBER) Return VARCHAR2;
  Function fsbGETobtultserial(sbseri VARCHAR2) Return VARCHAR2;
  FUNCTION fsbGETobtmarcultserial(sbseri VARCHAR2) RETURN VARCHAR2;

END LDCI_PKRESERVAMATERIAL;
/

CREATE OR REPLACE PACKAGE BODY LDCI_PKRESERVAMATERIAL AS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
  -- Carga variables globales
  sbInputMsgType  LDCI_CARASEWE.CASEVALO%type;
  sbNameSpace     LDCI_CARASEWE.CASEVALO%type;
  sbUrlWS         LDCI_CARASEWE.CASEVALO%type;
  sbUrlDesti      LDCI_CARASEWE.CASEVALO%type;
  sbSoapActi      LDCI_CARASEWE.CASEVALO%type;
  sbProtocol      LDCI_CARASEWE.CASEVALO%type;
  sbHost          LDCI_CARASEWE.CASEVALO%type;
  sbPuerto        LDCI_CARASEWE.CASEVALO%type;
  sbClasSolMat    LDCI_CARASEWE.CASEVALO%type;
  sbClasDevMat    LDCI_CARASEWE.CASEVALO%type;
  sbClasSolHer    LDCI_CARASEWE.CASEVALO%type;
  sbClasDevHer    LDCI_CARASEWE.CASEVALO%type;
  sbPrefijoLDC    LDCI_CARASEWE.CASEVALO%type;
  sbDefiSewe      LDCI_DEFISEWE.DESECODI%type;
  sbClasSolMatAct LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_3429_1
  sbClasDevMatAct LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_3429_1
  sbLstCentSolInv LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_5028_1: #ifrs #471: Listado de UO proveedor logistico para solicitud de inventario
  sbLstCentSolAct LDCI_DEFISEWE.DESECODI%type; --#OYM_CEV_5028_1: #ifrs #471: Listado de UO proveedor logistico para solicitud de activos
  sbEntrega380		ldc_versionentrega.nombre_entrega%type :='0000380';
  sbAplicaE380    varchar2(1);
  sbValidaHerr    varchar2(1);
  sbAplicaOSF200  varchar2(1) := 'N';

  procedure proValidaClaseValoraProvLogis(inuIdProvLogistico    in NUMBER,
                                         sbCLASS_ASSESSMENT_ID out VARCHAR2,
                                         onuErrorCode          out NUMBER,
                                         osbErrorMessage       out VARCHAR2) as
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKRESERVAMATERIAL.proValidaClaseValoraProvLogis
     AUTOR      : Carlos E. Virgen Londo?o <carlos.virgen@olsoftware.com>
     FECHA      : 14/11/2014
     RICEF      : OYM_CEV_5028_1
     DESCRIPCION: Valida la clase de valoracion del proveedor  logistico

    Historia de Modificaciones
    Autor     Fecha      Descripcion
  */

  begin
        --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
        onuErrorCode := 0;
        if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0
         and instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolAct, inuIdProvLogistico) <> 0) then
            onuErrorCode := -1;
            osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa proveedor logistico (' || to_char(inuIdProvLogistico)   ||
                               ') esta configurada como Inventario y Activo. (Forma GEMCSW; Id Servicio WS_RESERVA_MATERIALES, WS_TRASLADO_MATERIALES; Id parametros LST_CENTROS_SOL_INV, LST_CENTROS_SOL_ACT)';
        else
            if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0) then
               --Clase de valoracion Inventario
               sbCLASS_ASSESSMENT_ID := 'I';
            else
                if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolAct, inuIdProvLogistico) <> 0) then
                   --Clase de valoracion Activo
                   sbCLASS_ASSESSMENT_ID := 'A';
                else
                    onuErrorCode := -1;
                    osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa proveedor logistico (' || to_char(inuIdProvLogistico)   ||
                                       ') no esta configurada como Inventario o Activo. (Forma GEMCSW; Id Servicio WS_RESERVA_MATERIALES, WS_TRASLADO_MATERIALES; Id parametros LST_CENTROS_SOL_INV, LST_CENTROS_SOL_ACT)';


                end if;--if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0) then
            end if;--if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0) then
        end if; -- if (instr(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0 ...

  end proValidaClaseValoraProvLogis;

  procedure proNotificaExepcion(inuDocumento     in NUMBER,
                                 isbAsunto        in VARCHAR2,
                                                              isbMesExcepcion  in VARCHAR2) as
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          FUNCION    : proNotificaExepcion
          AUTOR      : Carlos Eduardo Virgen Londono
          FECHA      : 26/01/2012
          RICEF      :
          DESCRIPCION: Notifica excepciones por correo eletronico

        Historia de Modificaciones
        Autor    Fecha       Descripcion
        carlosvl 12/08/2011  Se hace la validacion de datos.
        jpinedc  27/05/2024  OSF-2603: Se ajusta proNotificaExepcion  
      */
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proNotificaExepcion';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
    
        -- define cursores
        cursor cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
         select doc.ID_ITEMS_DOCUMENTO, typ.DESCRIPTION, doc.OPERATING_UNIT_ID, ori.NAME ORINAME, doc.DESTINO_OPER_UNI_ID, des.NAME DESNAME, doc.USER_ID, doc.FECHA, doc.TERMINAL_ID
           from GE_ITEMS_DOCUMENTO doc,
                GE_DOCUMENT_TYPE typ,
                OR_OPERATING_UNIT ori,
                OR_OPERATING_UNIT des
          where doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
            and doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID
            and doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
                    and ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

        --cursor datos de la persona
        cursor cuGE_PERSON(inuUSER_ID GE_PERSON.USER_ID%type) is
                select *
                        from GE_PERSON g
                        where g.USER_ID = inuUSER_ID;

        -- tipo registro
        reGE_PERSON          cuGE_PERSON%rowtype;
        reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;
        
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
        sbMensCorreo    VARCHAR2(4000);
        
    begin

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        -- abre el registro del documento con excepciones
        open cuGE_ITEMS_DOCUMENTO(inuDocumento);
        fetch cuGE_ITEMS_DOCUMENTO into reGE_ITEMS_DOCUMENTO;
        close cuGE_ITEMS_DOCUMENTO;

        --determina el usuario que esta realizando la operacion
        open cuGE_PERSON(reGE_ITEMS_DOCUMENTO.USER_ID);
        fetch cuGE_PERSON into reGE_PERSON;
        close cuGE_PERSON;

        if (reGE_PERSON.E_MAIL is not null or reGE_PERSON.E_MAIL <> '') then

            -- genera el cuerpo del correo
            sbMensCorreo := sbMensCorreo ||'<html><body>';
            sbMensCorreo := sbMensCorreo ||'<table  border="1px" width="100%">';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td colspan="2"><h1>' || isbAsunto || '<h1></td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Documento de solicitud</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || inuDocumento || ' - ' || reGE_ITEMS_DOCUMENTO.DESCRIPTION || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Fecha</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || to_char(reGE_ITEMS_DOCUMENTO.FECHA, 'DD/MM/YYYY HH:MM:SS') || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<td><b>Unidad Operativa Origen</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reGE_ITEMS_DOCUMENTO.OPERATING_UNIT_ID || '-' || reGE_ITEMS_DOCUMENTO.ORINAME || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<td><b>Unidad Operativa Destino</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reGE_ITEMS_DOCUMENTO.DESTINO_OPER_UNI_ID || '-' || reGE_ITEMS_DOCUMENTO.DESNAME || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Usuario</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reGE_PERSON.NAME_ || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';
            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Terminal</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || reGE_ITEMS_DOCUMENTO.TERMINAL_ID || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'<tr>';
            sbMensCorreo := sbMensCorreo ||'<td><b>Mensaje</b></td>';
            sbMensCorreo := sbMensCorreo ||'<td>' || isbMesExcepcion || '</td>';
            sbMensCorreo := sbMensCorreo ||'</tr>';

            sbMensCorreo := sbMensCorreo ||'</table>';
            sbMensCorreo := sbMensCorreo ||'</html></body>';
            
            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => reGE_PERSON.E_MAIL,
                isbAsunto           => isbAsunto,
                isbMensaje          => sbMensCorreo
            );        
              
        else
            sbMensCorreo := 'El usuario ' || reGE_PERSON.PERSON_ID || '-' || reGE_PERSON.NAME_ ||' no tiene configurado el correo electrónico.';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Usuario sin correo electrónico ('|| reGE_PERSON.NAME_ || ')',
                isbMensaje          => sbMensCorreo
            );   
        end if;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);         

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);        
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError => ' || sbError, csbNivelTraza );
            RAISE pkg_error.Controlled_Error;
    end proNotificaExepcion;


    FUNCTION fsbValidaCadena(isbCadena VARCHAR2) RETURN VARCHAR2 IS
    /*
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
        FUNCION    : ProNotiMaestroMovMaterial
        AUTOR      : Carlos Eduardo Virgen Londono
        FECHA      : 26/01/2012
        RICEF      : I005; I006
        DESCRIPCION: Realiza la insercion de un movimiento de isbMaterial
                contratistas/cuadrillas

      Historia de Modificaciones
      Autor    Fecha       Descripcion
      carlosvl 12/08/2011  Se hace la validacion de datos.
    */
      osbCadena  VARCHAR2(100); -- SD 77654 LJL -- Se almacena la cadena que se va a retornar
      nuLong    NUMBER DEFAULT 0;
      onuErrorCode    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
      osbErrorMessage GE_ERROR_LOG.DESCRIPTION%TYPE;
    BEGIN
        nuLong    := LENGTH(isbCadena);
        osbCadena := NULL;
        IF nuLong >= 50 THEN
        nuLong := 49;
        END IF;
        FOR j IN 1..nuLong LOOP
        IF substr(isbCadena,j,1) IN('A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z','1','2','3','4','5','6','7','8','9','0','/') THEN
        osbCadena := osbCadena||substr(upper(isbCadena),j,1);
      ELSE
        osbCadena := osbCadena||' ';
      END IF;
        END LOOP;
        RETURN osbCadena;
    EXCEPTION
        WHEN OTHERS THEN
          pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
          Errors.seterror;
          Errors.geterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;
    END fsbValidaCadena;


    -- CA. 200-638
    -- valida si existe item configurada en la forma LDCITUNRA (saldos por UO)
    FUNCTION fblValidExistItem
    (
        inuItem     number,
        inuUnOP     number
    )
    RETURN boolean
    IS
        blResult    boolean;
        nuCant      number;

    BEGIN

        select count(1)
        into nuCant
        from ldc_salitemsunidop
        where items_id = inuItem
        and operating_unit_id = inuUnOP;

        if (nuCant > 0) then
            blResult    := true;
        elsif (nuCant = 0) then
            blResult    := false;
        end if;

        return blResult;

    end FBLVALIDEXISTITEM;


  procedure proCreaDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%type,
                                                      onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%type,
                                                      osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%type) as
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          FUNCION    : proCreaDocuTran
          AUTOR      : Carlos Eduardo Virgen Londono
          FECHA      : 26/01/2012
          RICEF      : I005; I006
          DESCRIPCION: Realiza el registro en la tabla de documentos en transito

        Historia de Modificaciones
        Autor    Fecha       Descripcion
        carlosvl 12/08/2011  Se hace la validacion de datos.
      */
  begin
         onuErrorCode    := 0;
              osbErrorMessage := null;
         -- realiza la insercion sobre la tabla LDCI_DOCUTRAN
         insert into LDCI_DOCUTRAN(DOTRDOCU,DOTRFECR)
                values (inuDOTRDOCU, SYSDATE);

  exception
    when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
    end proCreaDocuTran;

  procedure proElimDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%type,
                                                      onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%type,
                                                      osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%type) as
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          FUNCION    : proElimDocuTran
          AUTOR      : Carlos Eduardo Virgen Londono
          FECHA      : 26/01/2012
          RICEF      : I005; I006
          DESCRIPCION: Elimina un documento en transtisto

        Historia de Modificaciones
        Autor    Fecha       Descripcion
        carlosvl 12/08/2011  Se hace la validacion de datos.
      */
  begin
         onuErrorCode    := 0;
              osbErrorMessage := null;
         -- elimina el registro de la tabla
         delete LDCI_DOCUTRAN
                where DOTRDOCU = inuDOTRDOCU;

  exception
    when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
    end proElimDocuTran;

  function fsbGetDocuTran(inuDOTRDOCU in LDCI_DOCUTRAN.DOTRDOCU%type)
        return VARCHAR2    is
      /*
          PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
          FUNCION    : fsbGetDocuTran
          AUTOR      : Carlos Eduardo Virgen Londono
          FECHA      : 26/01/2012
          RICEF      : I005; I006
          DESCRIPCION: Retorna un mensaje que indica si existe o n un documento en transito

        Historia de Modificaciones
        Autor    Fecha       Descripcion
        carlosvl 12/08/2011  Se hace la validacion de datos.
      */
    -- cursor del documento en transito
       cursor cuDocuTran(inuDOTRDOCU LDCI_DOCUTRAN.DOTRDOCU%type) is
          select *
             from LDCI_DOCUTRAN
            where DOTRDOCU = inuDOTRDOCU;

        sbFlagDocuTran VARCHAR2(1);
    begin
        sbFlagDocuTran := 'N';
      for reDocuTran in cuDocuTran(inuDOTRDOCU) loop
            sbFlagDocuTran := 'S';
        end loop;-- for reDocuTran in cuDocuTran(inuDOTRDOCU) loop

        return sbFlagDocuTran;
    end fsbGetDocuTran;

  procedure proCargaVarGlobal(isbCASECODI in LDCI_CARASEWE.CASECODI%type) as
  /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : proCargaVarGlobal
     AUTOR      : OLSoftware / Carlos E. Virgen
     FECHA      : 25/02/2012
     RICEF      : I005; I006
     DESCRIPCION: Limpia y carga las variables globales

    Historia de Modificaciones
    Autor   Fecha   Descripcion
  */

    onuErrorCode      ge_error_log.Error_log_id%TYPE;
    osbErrorMessage   ge_error_log.description%TYPE;
  errorPara01  EXCEPTION;        -- Excepcion que verifica que ingresen los parametros de entrada

  begin
      LDCI_PKRESERVAMATERIAL.sbInputMsgType  := null;
      LDCI_PKRESERVAMATERIAL.sbNameSpace     := null;
      LDCI_PKRESERVAMATERIAL.sbUrlWS         := null;
      LDCI_PKRESERVAMATERIAL.sbUrlDesti      := null;
      LDCI_PKRESERVAMATERIAL.sbSoapActi      := null;
      LDCI_PKRESERVAMATERIAL.sbProtocol      := null;
      LDCI_PKRESERVAMATERIAL.sbHost          := null;
      LDCI_PKRESERVAMATERIAL.sbPuerto        := null;
      LDCI_PKRESERVAMATERIAL.sbClasSolMat    := null;
      LDCI_PKRESERVAMATERIAL.sbClasDevMat    := null;
      LDCI_PKRESERVAMATERIAL.sbClasSolMatAct := null; --#OYM_CEV_3429_1
      LDCI_PKRESERVAMATERIAL.sbClasDevMatAct := null; --#OYM_CEV_3429_1
      LDCI_PKRESERVAMATERIAL.sbLstCentSolInv := null; --#OYM_CEV_5028_1: #ifrs #471
      LDCI_PKRESERVAMATERIAL.sbLstCentSolAct := null; --#OYM_CEV_5028_1: #ifrs #471
      LDCI_PKRESERVAMATERIAL.sbClasSolHer    := null;
      LDCI_PKRESERVAMATERIAL.sbClasDevHer    := null;
      LDCI_PKRESERVAMATERIAL.sbPrefijoLDC    := null;
      LDCI_PKRESERVAMATERIAL.sbDefiSewe       := null;


      LDCI_PKRESERVAMATERIAL.sbDefiSewe := isbCASECODI;
      -- carga los parametos de la interfaz
      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'INPUT_MESSAGE_TYPE', LDCI_PKRESERVAMATERIAL.sbInputMsgType, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'NAMESPACE', LDCI_PKRESERVAMATERIAL.sbNameSpace, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'WSURL', LDCI_PKRESERVAMATERIAL.sbUrlWS, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'SOAPACTION', LDCI_PKRESERVAMATERIAL.sbSoapActi, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PROTOCOLO', LDCI_PKRESERVAMATERIAL.sbProtocol, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PUERTO', LDCI_PKRESERVAMATERIAL.sbPuerto, osbErrorMessage);
      if(osbErrorMessage != '0') then
           RAISE errorPara01;
      end if;--if(osbErrorMessage != '0') then

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'HOST', LDCI_PKRESERVAMATERIAL.sbHost, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_MATERIAL', LDCI_PKRESERVAMATERIAL.sbClasSolMat, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_DEVOLUCION_MAT', LDCI_PKRESERVAMATERIAL.sbClasDevMat, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_HERRAMIENTA', LDCI_PKRESERVAMATERIAL.sbClasSolHer, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_DEVOLUCION_HER', LDCI_PKRESERVAMATERIAL.sbClasDevHer, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PREFIJO_LDC', LDCI_PKRESERVAMATERIAL.sbPrefijoLDC, osbErrorMessage);
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;


      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLSM_SOLI_ACT', LDCI_PKRESERVAMATERIAL.sbClasSolMatAct, osbErrorMessage); --#OYM_CEV_3429_1
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLSM_DEVO_ACT', LDCI_PKRESERVAMATERIAL.sbClasDevMatAct, osbErrorMessage); --#OYM_CEV_3429_1
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;


      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'LST_CENTROS_SOL_INV', LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, osbErrorMessage); --#OYM_CEV_5028_1: #ifrs #471
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'LST_CENTROS_SOL_ACT', LDCI_PKRESERVAMATERIAL.sbLstCentSolAct, osbErrorMessage); --#OYM_CEV_5028_1: #ifrs #471
      if(osbErrorMessage != '0') then
           Raise Errorpara01;
      end if;

      LDCI_PKRESERVAMATERIAL.Sburldesti := Lower(LDCI_PKRESERVAMATERIAL.Sbprotocol) || '://' || LDCI_PKRESERVAMATERIAL.Sbhost || ':' || LDCI_PKRESERVAMATERIAL.Sbpuerto || '/' || LDCI_PKRESERVAMATERIAL.Sburlws;
      LDCI_PKRESERVAMATERIAL.sbUrlDesti := trim(LDCI_PKRESERVAMATERIAL.sbUrlDesti);

      --380
      If fblAplicaEntregaxCaso(sbEntrega380) Then
         sbAplicaE380:='S';
      Else
         sbAplicaE380:='N';
      End If;
      sbValidaHerr := nvl(open.dald_parameter.fsbGetValue_Chain('LDC_CUENTA_HERR_DEVOLU',NULL),'N');
      --380


  Exception
    When Errorpara01 then
      Errors.seterror (-1, 'ERROR: [LDCI_PKRESERVAMATERIAL.proCargaVarGlobal]: Cargando el parametro :' || osbErrorMessage);
      commit; --rollback;
    when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  end proCargaVarGlobal;

Procedure proEnviarSolicitud(reserva                in  VARCHAR2,
                             isbOperacion           in  VARCHAR2,
                             flagherramienta        in  VARCHAR,
                             inuProcCodi            in  NUMBER,
                             isbCLASS_ASSESSMENT_ID in  LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%type, --#OYM_CEV_3429_1
                             onuErrorCode           out ge_error_log.Error_log_id%TYPE,
                             osbErrorMessage        out ge_error_log.description%TYPE) As

  /*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

   PROCEDIMIENTO : proEnviarSolicitud
       AUTOR : MAURICIO FERNANDO ORTIZ
       FECHA : 10/12/2012
     RICEF         : I005; I006
   DESCRIPCION    : Procedimiento para enviar la interfaz

   Parametros de Entrada
   reserva in varchar2
   flagherramienta in varchar

   Parametros de Salida
     onuErrorCode out number
     osbErrorMessage out varchar
   Historia de Modificaciones

   Autor        Fecha   Descripcion.
  carlosvl 17/09/2013  NC-622: Se ajusta la generacion de la etiqueta "ResFront" para enviarlo del modo
                         [Letra(s) que identifican la empresa]-[Tipo de Movimiento]-[Numero de la Solicitud]/[Nombre del solicitante]
  carlosvl 25022015    NC-25022015: Se modifica el formato de '9999999999999.99' a '9999999999990.99'
  dsaltarin 02/06/2020  Cambio 380. Se cambia la forma del xml para devolver seriales.
  dsaltarin 01/04/2022  OSF-200. Se envian 3 decimales en la cantidad en lugar de 2
  */
   cursor cuLDCI_RESERVAMAT(sbRESERVA VARCHAR2) is  --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
        select RESERVA, UNIDAD_OPE, NAME, CENTRO_COSTO
            from LDCI_RESERVAMAT, OR_OPERATING_UNIT
            where OPERATING_UNIT_ID = UNIDAD_OPE
                and RESERVA = sbRESERVA;
  -- variables
    sbErrMens      VARCHAR2(500);
    sbClasMov      LDCI_CARASEWE.CASEVALO%type;
    Sbmens         VARCHAR2(4000);
    onuMesacodi     NUMBER;
    sbcondicionHta VARCHAR2(100);

    --Variables mensajes SOAP
    L_Payload     CLOB;
    l_response    CLOB;
    qryCtx        DBMS_XMLGEN.ctxHandle;
    reLDCI_RESERVAMAT cuLDCI_RESERVAMAT%rowtype; --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta

  -- excepciones
    errorPara01             EXCEPTION;  -- Excepcion que verifica que ingresen los parametros de entrada
    Excepnoprocesoregi      EXCEPTION;   -- Excepcion que valida si proceso registros la consulta
    excepNoProcesoSOAP      EXCEPTION;   -- Excepcion que valida si proceso peticion SOAP
    exce_ValidaCentroCosto  EXCEPTION;   --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
    sbFormato               VARCHAR2(1000);

Begin
  if sbAplicaOSF200 ='S' then
      sbFormato :='9999999999990.999';
  else
      sbFormato :='9999999999990.99';
  end if;
  -- valida si el campo de reserva esta lleno
  if (reserva is not null) then
      if (flagherramienta = 'S') then --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
            open cuLDCI_RESERVAMAT(reserva);
            fetch cuLDCI_RESERVAMAT into reLDCI_RESERVAMAT;
            close cuLDCI_RESERVAMAT;

            if (reLDCI_RESERVAMAT.CENTRO_COSTO is null or reLDCI_RESERVAMAT.CENTRO_COSTO = '' or reLDCI_RESERVAMAT.CENTRO_COSTO = '-1') then
              raise exce_ValidaCentroCosto;
      end if; --if (reLDCI_RESERVAMAT.CENTRO_COSTO ...
        end if; --if (flagherramienta = 'S')

        -- Si es una Reserva
    if (isbOperacion = 'RES') then

            if (isbCLASS_ASSESSMENT_ID = 'I') then --#OYM_CEV_3429_1: Valida la clase de valoracion INVENTARIO
                    select decode(Flagherramienta, 'N', LDCI_PKRESERVAMATERIAL.sbClasSolMat, 'S', LDCI_PKRESERVAMATERIAL.sbClasSolHer, LDCI_PKRESERVAMATERIAL.sbClasSolMat) into sbClasMov
                        from dual;
                else
                        if (isbCLASS_ASSESSMENT_ID = 'A') then --#OYM_CEV_3429_1: Valida la clase de valoracion ACTIVO
                            select decode(Flagherramienta, 'N', LDCI_PKRESERVAMATERIAL.sbClasSolMatAct, 'S', LDCI_PKRESERVAMATERIAL.sbClasSolHer, LDCI_PKRESERVAMATERIAL.sbClasSolMatAct) into sbClasMov
                                from dual;
                        end if;--if (isbCLASS_ASSESSMENT_ID = 'A')
            end if;--if (isbCLASS_ASSESSMENT_ID = 'I') then
    else
            if (isbCLASS_ASSESSMENT_ID = 'I') then --#OYM_CEV_3429_1: Valida la clase de valoracion INVENTARIO
                    select decode(Flagherramienta, 'N', LDCI_PKRESERVAMATERIAL.sbClasDevMat, 'S', LDCI_PKRESERVAMATERIAL.sbClasDevHer, LDCI_PKRESERVAMATERIAL.sbClasDevMat) into sbClasMov
                        from dual;
                else
                        if (isbCLASS_ASSESSMENT_ID = 'A') then --#OYM_CEV_3429_1: Valida la clase de valoracion ACTIVO
                            select decode(Flagherramienta, 'N', LDCI_PKRESERVAMATERIAL.sbClasDevMatAct, 'S', LDCI_PKRESERVAMATERIAL.sbClasDevHer, LDCI_PKRESERVAMATERIAL.sbClasDevMatAct) into sbClasMov
                                from dual;
                        end if;--if (isbCLASS_ASSESSMENT_ID = 'A') then
            end if;--if (isbCLASS_ASSESSMENT_ID = 'I') then
    end if;--if (isbOperacion = 'RES') then
    -- Genera el mensaje XML
	if sbAplicaE380 = 'N'   then

		Qryctx :=  Dbms_Xmlgen.Newcontext ('Select ''' || sbClasMov || ''' As "ClasMov",
			  Rs.UNIDAD_OPE As "AlmCont",
			  substr(:sbPrefijoLDC || ''-'' || ''' || sbClasMov || ''' || ''-'' || Rs.RESERVA || ''/'' || Uo.OPERATING_UNIT_ID || '' '' || Uo.NAME,1,40) As "ResFront",
			  decode(:flagHerramienta, ''N'', NULL, ''S'', Rs.Centro_Costo, NULL) "CenCosto",
			  CURSOR (Select Dt.CODIGO_ITEM As "Material",
										  trim(to_char(NVL(Dt.CANTIDAD,0),'||sbFormato||')) As "Cantidad",
										  Dt.CENTRO "CentroSAP",
										  case
											 when Dt.COSTO_ERP <= 0 then NULL
											   else  trim(to_char(NVL(Dt.COSTO_ERP, NULL),''9999999999990.99'')) end As "Costo",
											   NVL(OPEN.LDCI_PKRESERVAMATERIAL.fsbGETxmlserializados(''DEV'',Dt.RESERVA,Dt.CODIGO_ITEM),NULL)
								From LDCI_DET_RESERVAMAT Dt
							  Where Rs.RESERVA = Dt.RESERVA
							  and Dt.ES_HERRAMIENTA = ''' ||Flagherramienta || ''') As "Detalle"
				  From LDCI_RESERVAMAT Rs, OR_OPERATING_UNIT Uo
				  where Rs.RESERVA = ' || to_char(reserva) ||
				  'and Rs.UNIDAD_OPE = Uo.OPERATING_UNIT_ID');
	else
		Qryctx :=  Dbms_Xmlgen.Newcontext ('Select ''' || sbClasMov || ''' As "ClasMov",
          Rs.UNIDAD_OPE As "AlmCont",
          substr(:sbPrefijoLDC || ''-'' || ''' || sbClasMov || ''' || ''-'' || Rs.RESERVA || ''/'' || Uo.OPERATING_UNIT_ID || '' '' || Uo.NAME,1,40) As "ResFront",
          decode(:flagHerramienta, ''N'', NULL, ''S'', Rs.Centro_Costo, NULL) "CenCosto",
          CURSOR (Select Dt.CODIGO_ITEM As "Material",
                                      trim(to_char(NVL(Dt.CANTIDAD,0),'||sbFormato||')) As "Cantidad",
                                      Dt.CENTRO "CentroSAP",
                                      case
                                         when Dt.COSTO_ERP <= 0 then NULL
                                           else  trim(to_char(NVL(Dt.COSTO_ERP, NULL),''9999999999990.99'')) end As "Costo",
                                           cursor(  select ldci_pkreservamaterial.fsbgetobtultserial(s.serie)   AS "Serie"
                                                   ,ldci_pkreservamaterial.fsbGETobtmarcultserial(serie) AS "Marca"
                                                                              from or_uni_item_bala_mov k,
                                                                                   open.ge_items_seriado s
                                                                            where k.id_items_documento = dt.reserva
                                                                              AND k.items_id           = dt.codigo_item
                                                                              AND k.movement_type      = ''D''
                                                                              AND k.id_items_seriado   = s.id_items_seriado
                                                                              and rs.clase_mov=''DEV'')  as "Seriales"
                            From LDCI_DET_RESERVAMAT Dt, open.ge_items i
                          Where Rs.RESERVA = Dt.RESERVA
                            and Dt.item_id=i.items_id
                              and Dt.ES_HERRAMIENTA = ''' ||Flagherramienta || ''') As "Detalle"
      From LDCI_RESERVAMAT Rs, OR_OPERATING_UNIT Uo
      where Rs.RESERVA = ' || to_char(reserva) ||
      'and Rs.UNIDAD_OPE = Uo.OPERATING_UNIT_ID');
	end if;


     -- Asigna el valor de la variable :flagHerramienta
    DBMS_XMLGEN.setBindvalue (qryCtx, 'flagHerramienta', flagHerramienta);
    DBMS_XMLGEN.setBindvalue (qryCtx, 'sbPrefijoLDC', LDCI_PKRESERVAMATERIAL.sbPrefijoLDC);

    Dbms_Xmlgen.setRowSetTag(Qryctx, LDCI_PKRESERVAMATERIAL.sbInputMsgType);
    DBMS_XMLGEN.setRowTag(qryCtx, '');
    --Dbms_Xmlgen.setNullHandling(qryCtx, 0);
    dbms_xmlgen.setConvertSpecialChars(qryCtx, FALSE);

    l_payload := dbms_xmlgen.getXML(qryCtx);
    l_payload := REPLACE(l_payload,'<NVL_x0028_OPEN.LDCI_PKRESERVAMATERIA>',NULL);
    l_payload := REPLACE(l_payload,'</NVL_x0028_OPEN.LDCI_PKRESERVAMATERIA>',NULL);
    l_payload := l_payload;

    if sbAplicaE380 = 'S' then
       L_Payload := REPLACE(L_Payload, '<Seriales_ROW>', '<Serial>');
	     L_Payload := REPLACE(L_Payload, '</Seriales_ROW>', '</Serial>');
	     L_Payload := REPLACE(L_Payload, '<Seriales>'||chr(10)||chr(32)||chr(32)||chr(32)||'</Seriales>', '');
    end if;
    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
    l_payload := replace(l_payload, '<Detalle>');
    l_payload := replace(l_payload, '</Detalle>');

    l_payload := replace(l_payload, '<Detalle_ROW>',  '<Detalle>');
    l_payload := replace(l_payload, '</Detalle_ROW>', '</Detalle>');
    --L_Payload := '<urn:NotificarOrdenesLectura>' || L_Payload || '</urn:NotificarOrdenesLectura>';
    L_Payload := Trim(L_Payload);
    --dbms_output.put_line('[ln395] proEnviarSolicitud L_Payload: ' || chr(13) || L_Payload);


    --Hace el consumo del servicio Web
    LDCI_PKSOAPAPI.Prosetprotocol(LDCI_PKRESERVAMATERIAL.Sbprotocol);


    l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
                                                                                                            LDCI_PKRESERVAMATERIAL.sbUrlDesti,
                                                                                                            LDCI_PKRESERVAMATERIAL.sbSoapActi,
                                                                                                            LDCI_PKRESERVAMATERIAL.sbNameSpace);


    --Valida el proceso de peticion SOAP
    If (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) Then

              LDCI_PKMESAWS.PROCREAMENSENVIO(IDTMESAFECH       => SYSDATE,
                                                                            ISBMESADEFI       => LDCI_PKRESERVAMATERIAL.sbDefiSewe,
                                                                            INUMESAESTADO     => -1,
                                                                            INUMESAPROC       => inuProcCodi,
                                                                            ICBMESAXMLENV     => null,
                                                                            ICDMESAXMLPAYLOAD => L_Payload,
                                                                            INUMESATAMLOT     => 1,
                                                                            INUMESALOTACT     => 1,
                                                                            ONUMESACODI       => onuMesacodi,
                                                                            ONUERRORCODE      => onuErrorCode,
                                                                            OSBERRORMESSAGE   => osbErrorMessage);
       raise excepNoProcesoSOAP;
        else

                LDCI_PKMESAWS.PROACTUESTAPROC(INUPROCCODI     => inuProcCodi,
                                                                            IDTPROCFEFI     => sysdate,
                                                                            ISBPROCESTA     => 'F',
                                                                            ONUERRORCODE    => ONUERRORCODE,
                                                                            OSBERRORMESSAGE => OSBERRORMESSAGE);

                LDCI_PKMESAWS.PROCREAMENSENVIO(IDTMESAFECH       => SYSDATE,
                                                                              ISBMESADEFI       => LDCI_PKRESERVAMATERIAL.sbDefiSewe,
                                                                              INUMESAESTADO     => 1,
                                                                              INUMESAPROC       => inuProcCodi,
                                                                              ICBMESAXMLENV     => null,
                                                                              ICDMESAXMLPAYLOAD => L_Payload,
                                                                              INUMESATAMLOT     => 1,
                                                                              INUMESALOTACT     => 1,
                                                                              ONUMESACODI       => onuMesacodi,
                                                                              ONUERRORCODE      => onuErrorCode,
                                                                              OSBERRORMESSAGE   => osbErrorMessage);
    end if; -- If (LDCI_PKSOAPAPI.Boolsoaperror ...
   end if;--if (reserva is not null) then
   onuErrorCode := 0;
Exception

  when exce_ValidaCentroCosto then --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Validaci??n del centro de costo, solicitud de herramienta
       onuErrorCode := -1;
       osbErrorMessage := '[LDCI_PKRESERVAMATERIAL.proEnviarSolicitud] La unidad operativa (' || to_char(reLDCI_RESERVAMAT.UNIDAD_OPE) || reLDCI_RESERVAMAT.NAME   || ') y Num Reserva ('||to_char(reLDCI_RESERVAMAT.RESERVA) ||') no tiene configurado el Centro de Costo o esta configurado en el Centro de Costo -1. (Forma GEMCUO)';
      Errors.seterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[691]' || osbErrorMessage);
      commit; --rollback;
            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(reserva), 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

  WHEN excepNoProcesoRegi THEN
        osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proEnviarSolicitud]: La consulta no ha arrojo registros: ' || chr(13) || DBMS_UTILITY.format_error_backtrace;
        onuErrorCode:= -1;
        Errors.seterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[698]' || osbErrorMessage);
        commit; --rollback;

    WHEN excepNoProcesoSOAP THEN
        osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proEnviarSolicitud]: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;
        onuErrorCode:= -1;
        Errors.seterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[706]' || osbErrorMessage);
        commit; --rollback;
  when others  then
        pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
        Errors.seterror;
        Errors.geterror (onuErrorCode, osbErrorMessage);
--dbms_output.put_line('[712]' || osbErrorMessage);
        commit; --rollback;
End proEnviarSolicitud;

Function fnuObtenerClasificacionItem(Itemid Number, itemcode varchar2)
  Return Number As
  /*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

       FUNCION : fnuObtenerClasificacionItem
       AUTOR : MAURICIO FERNANDO ORTIZ
       FECHA : 10/12/2012
     RICEF         : I005; I006
   DESCRIPCION   : Procedimiento para enviar la interfaz

   Parametros de Entrada
    Itemid Number
    itemcode varchar2

   Parametros de Salida

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
  */
    doc       DBMS_XMLDOM.DOMDocument;
    ndoc      DBMS_XMLDOM.DOMNode;
    docelem   DBMS_XMLDOM.DOMElement;
    node      DBMS_XMLDOM.DOMNode;
    childnode DBMS_XMLDOM.DOMNode;
    Nodelist  Dbms_Xmldom.Domnodelist;
    Buf             Varchar2(2000);
    oclXMLItemsData CLOB;
    Onuerrorcode    ge_error_log.Error_log_id%TYPE;
    Osberrormessage ge_error_log.description%TYPE;
    resultado       number;
  Begin
     -- carga item
     OS_GET_ITEM(Itemid, itemcode, Oclxmlitemsdata, Onuerrorcode, Osberrormessage);
     If Onuerrorcode = 0 Then
       /* PROCESAR XML Y OBTENER CLASIFICACION*/
        -- Create DOMDocument handle
        doc     := DBMS_XMLDOM.newDOMDocument(Oclxmlitemsdata);
        ndoc    := DBMS_XMLDOM.makeNode(doc);

        Dbms_Xmldom.Writetobuffer(Ndoc, Buf);

        docelem := DBMS_XMLDOM.getDocumentElement(doc);

        -- Access element
        Nodelist  := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEM_CLASS');
        Node      := Dbms_Xmldom.Item(Nodelist, 0);
        Childnode := Dbms_Xmldom.Getfirstchild(Node);
        resultado := to_number(Dbms_Xmldom.Getnodevalue(Childnode));
     End If; -- If Onuerrorcode = 0 Then

     -- retorna clasificacion de item
     Return Resultado;
  exception
  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  end fnuObtenerClasificacionItem;

  Function fnuExisteDocumento(Sbdocuemento Varchar2)
    Return Number Is
    Resultado Number := -1;
        onuErrorCode      ge_error_log.Error_log_id%TYPE;
        osbErrorMessage   ge_error_log.description%TYPE;

    Cursor Cudocumento Is
      Select *
        From Ldci_Reservamat
       Where Reserva = Sbdocuemento;

    recCudocumento Cudocumento%rowtype;
  Begin
    /*abrir cursor y valdar*/
    Open Cudocumento;
    Fetch Cudocumento Into Reccudocumento;

    If Cudocumento%Found Then
      Resultado := 0;
    end if;
    close Cudocumento;

    return resultado;
  exception
  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  end fnuExisteDocumento;

   Function fnuExisteDocumentoitem(Sbdocuemento in Varchar2,
                                   sbCodItem    in VARCHAR2) Return Number Is
    Resultado Number := -1;
    onuErrorCode      ge_error_log.Error_log_id%TYPE;
    osbErrorMessage   ge_error_log.description%TYPE;
  -- cursor
    Cursor Cudocumento Is
     Select *
     From LDCI_DET_RESERVAMAT Where Reserva = Sbdocuemento and Codigo_Item = sbCodItem;
    recCudocumento Cudocumento%rowtype;
  Begin
    /*abrir cursor y valdar*/
    Open Cudocumento;
    Fetch Cudocumento Into Reccudocumento;

    If Cudocumento%Found Then
      Resultado := 0;
    end if;
    close Cudocumento;

    Return Resultado;
  exception
  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  end fnuExisteDocumentoitem;

Procedure proNotificaDevoluciones As
    /*
      PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

      FUNCION : proNotificaDevoluciones
      AUTOR : MAURICIO FERNANDO ORTIZ
      FECHA : 10/12/2012
      RICEF      :  I006
      DESCRIPCION : Procedimiento para notificar devoluciones
      Parametros de Entrada
      Parametros de Salida
      Historia de Modificaciones
      Autor                                       Fecha       Descripcion.
            carlos.virgen<carlos.virgen@olsoftware.com> 30-09-2014  #OYM_CEV_5028_1: Se ajusta el envio del importe del costo al momento de notificar una devolucion de material
            carlos.virgen<carlos.virgen@olsoftware.com> 13-11-2014  #OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
            carlos.virgen<carlos.virgen@olsoftware.com> 10-03-2015  #144122: Ajuste ORA-30185: salida demasiado grande para caber en el buffer. Manejo variable "Bufitem"


    */

    -- definicion de variables
    Iclxmlsearchtransit   Clob;
    Oclxmltransititems    Clob;
    Onuerrorcode          ge_error_log.Error_log_id%TYPE;
    osbErrorMessage       ge_error_log.description%TYPE;
    Docitem               Dbms_Xmldom.Domdocument;
    Ndocitem              Dbms_Xmldom.Domnode;
    Docelemitem             Dbms_Xmldom.Domelement;
    Nodeitem                Dbms_Xmldom.Domnode;
    Nodelistitem            Dbms_Xmldom.Domnodelist;
    Nodelisteleitem        Dbms_Xmldom.Domnodelist;
    Nodedummy              Dbms_Xmldom.Domnode;
    Bufitem                 Varchar2(32767);
    clBufitem                 CLOB; --#144122: Se implementa variable clob para el procesamiento del XML
    sbItemcode              varchar2(60);
    Nucantidad              Number;
    sbReferencia            LDCI_RESERVAMAT.RESERVA%type;
    Nucosto                 Number;
    nuIduniopera            Number;
    nuDocumento           NUMBER;
    Nuclassitem             number;
    sbFlagHta               varchar2(1);
    nuDatos               number;
    sbCECOCODI            LDCI_CECOUNIOPER.CECOCODI%type;
    nuCantMate            number;
    nuCantHerr            number;
    onuProcCodi           NUMBER;
    icbProcPara           CLOB;
    sbCLASS_ASSESSMENT_ID LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%type; --#OYM_CEV_3429_1

    -- definicion de cursores
    -- cursor de las unidades operativas
    Cursor Cuunidadesoper Is
        select distinct Opeu.OPERATING_UNIT_ID  as PROVEEDOR_LOGISTICO,
               Opeu.OPER_UNIT_CODE     as PROVEEDOR_CODE
       from GE_ITEMS_DOCUMENTO Docu, OR_OPERATING_UNIT Opeu
      where Opeu.OPER_UNIT_CLASSIF_ID = 11
        and Docu.DESTINO_OPER_UNI_ID = Opeu.OPERATING_UNIT_ID
        and Docu.DOCUMENT_TYPE_ID = 105
        and Docu.ID_ITEMS_DOCUMENTO not in (select DOTRDOCU from LDCI_DOCUTRAN);

/*        select Docu.ID_ITEMS_DOCUMENTO as DOCUMENTO,
                   Docu.OPERATING_UNIT_ID  as UNIDAD_OPERATIVA,
                    Opeu.OPERATING_UNIT_ID  as PROVEEDOR_LOGISTICO,
                    Opeu.OPER_UNIT_CODE     as PROVEEDOR_CODE,
                    Docu.DOCUMENT_TYPE_ID     as TIPO_DOCUMENTO
      from GE_ITEMS_DOCUMENTO Docu, OR_OPERATING_UNIT Opeu
      where Opeu.OPER_UNIT_CLASSIF_ID = 11
        and Docu.DESTINO_OPER_UNI_ID = Opeu.OPERATING_UNIT_ID
        and Docu.DOCUMENT_TYPE_ID = 105
        and Docu.ID_ITEMS_DOCUMENTO not in (select DOTRDOCU from LDCI_DOCUTRAN)
        order by Opeu.OPERATING_UNIT_ID , Docu.ID_ITEMS_DOCUMENTO;*/

    recCuunidadesoper Cuunidadesoper%rowtype;

        -- cursor de los items en transito
      cursor cuTRANSIT_ITEM(clXML in CLOB) is
                SELECT ITEMS.*
                    FROM XMLTable('/TRANSIT_ITEMS/ITEMS' PASSING XMLType(clXML)
                        COLUMNS row_num for ordinality,
                                "ITEM_CODE"       NUMBER PATH 'ITEM_CODE',
                                        "ITEM_ID"         NUMBER PATH 'ITEM_ID',
                                        "ITEM_CLASSIF_ID"  NUMBER PATH 'ITEM_CLASSIF_ID',
                                        "TRANSIT_QUANTITY" NUMBER PATH 'TRANSIT_QUANTITY',
                                        "VALUE"           NUMBER PATH 'VALUE',
                                        "DOCUMENT_ID"      NUMBER PATH 'DOCUMENT_ID',
                                        "ORIG_OPER_UNIT"   NUMBER PATH 'ORIG_OPER_UNIT',
                                        "TARG_OPER_UNIT"   NUMBER PATH 'TARG_OPER_UNIT') AS ITEMS;

    -- cursor del centro de costo
    cursor cuLDCI_CECOUNIOPER(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%type) is
      select DOCU.OPERATING_UNIT_ID   as UNIDAD_OPERATIVA,
                    CECO.CECOCODI            as CENTRO_COSTO/*,
                    CLVA.CLASS_ASSESSMENT_ID as CLASE_VALORACION  200-798*/  --#OYM_CEV_3429_1
              from GE_ITEMS_DOCUMENTO DOCU,
                        LDCI_CECOUNIOPER CECO/*,
                        LDCI_CLVAUNOP    CLVA ca 200-798*/ --#OYM_CEV_3429_1
            where Docu.ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO
                and CECO.OPERATING_UNIT_ID = DOCU.OPERATING_UNIT_ID
                --and CLVA.OPERATING_UNIT_ID = DOCU.OPERATING_UNIT_ID ca 200-798
                ;  --#OYM_CEV_3429_1

    --- cursor temporal
    cursor cuLDCI_RESERVAMAT(nuPROVEEDOR_LOG LDCI_RESERVAMAT.PROVEEDOR_LOG%type) is
      select RESERVA
        from LDCI_RESERVAMAT
          where PROVEEDOR_LOG = nuPROVEEDOR_LOG;

    -- excepciones
    exce_proEnviarSolicitud    exception;
    exce_ValidaCentroCosto     exception;
    exce_OS_GET_TRANSIT_ITEM   exception;
  exce_ValidaClaseValoracion exception;    --#OYM_CEV_3429_1
Begin
   -- carga las variables requeridas para las solicitudes
   proCargaVarGlobal('WS_TRASLADO_MATERIALES');

   -- obtienes los items en transito;
   For Reccuunidadesoper In Cuunidadesoper Loop
   --dbms_output.put_line('[Reccuunidadesoper.PROVEEDOR_LOGISTICO]' || Reccuunidadesoper.PROVEEDOR_LOGISTICO);


    Iclxmlsearchtransit := '<?xml version="1.0"?><SEARCH_TRANSIT_ITEM><OPERATING_UNIT>' || Reccuunidadesoper.PROVEEDOR_LOGISTICO ||'</OPERATING_UNIT></SEARCH_TRANSIT_ITEM>';

    OS_GET_TRANSIT_ITEM(ICLXMLSEARCHTRANSIT, OCLXMLTRANSITITEMS, ONUERRORCODE, OSBERRORMESSAGE);
    If Onuerrorcode = 0 Then
                                  --#144122 Se comenta el bloque de codigo que generar la excepcion
                      /* extrae los items en transito
                      Docitem     := Dbms_Xmldom.Newdomdocument(Oclxmltransititems);
                      ndocitem    := DBMS_XMLDOM.makeNode(docitem);

                      Dbms_Xmldom.Writetobuffer(Ndocitem, Bufitem);


                      Docelemitem := Dbms_Xmldom.Getdocumentelement(Docitem);

                      Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'ITEMS');
                      nuDatos := dbms_xmldom.getlength(Nodelistitem);

                      if (nuDatos <> 0) then*/

                      -- inicializa el control de las solicitudes mezcladas
                      nuCantMate := 0;
                      nuCantHerr := 0;
                      sbReferencia := null;
                              for reTRANSIT_ITEM in cuTRANSIT_ITEM(oclXmltransititems) loop

                                      -- VALIDAR SI EXISTE REGISTRO
                                      If fnuExisteDocumento(to_char(reTRANSIT_ITEM.DOCUMENT_ID)) != 0 Then

                                                  -- carga la informacion del centro de costo
                                                  open cuLDCI_CECOUNIOPER(reTRANSIT_ITEM.DOCUMENT_ID);
                                                  fetch cuLDCI_CECOUNIOPER into nuidUniopera, sbCECOCODI/*, sbCLASS_ASSESSMENT_ID caso ca 200-798*/ /*--#OYM_CEV_3429_1*/;
                                                  close cuLDCI_CECOUNIOPER;

                                                  --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
                                                  proValidaClaseValoraProvLogis(Reccuunidadesoper.PROVEEDOR_LOGISTICO,
                                                                                sbCLASS_ASSESSMENT_ID,
                                                                                onuErrorCode,
                                                                                osbErrorMessage);
                                                  if (onuErrorCode <> 0) then
                                                      nuDocumento  := reTRANSIT_ITEM.DOCUMENT_ID;
                                                      raise exce_ValidaClaseValoracion;
                                                  end if; --if (onuErrorCode <> 0) then

                                                  /*#OYM_CEV_5028_1: #ifrs #471: Se desactiva la validacion de la clase de valoracion
                                                  if (sbCLASS_ASSESSMENT_ID is null or sbCLASS_ASSESSMENT_ID = '') then --#OYM_CEV_3429_1: Valida la clase de valoracion
                                                      nuDocumento  := reTRANSIT_ITEM.DOCUMENT_ID;
                                                      nuIduniopera := reTRANSIT_ITEM.TARG_OPER_UNIT;
                                                      raise exce_ValidaClaseValoracion;
                                                  end if;--if (sbCLASS_ASSESSMENT_ID is not null or sbCLASS_ASSESSMENT_ID <> '') then*/

                                                  if (sbCECOCODI is null or sbCECOCODI = '') then
                                                      nuDocumento  := reTRANSIT_ITEM.DOCUMENT_ID;
                                                      nuIduniopera := reTRANSIT_ITEM.TARG_OPER_UNIT;
                                                      --raise exce_ValidaCentroCosto; --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Se comenta la validacion anterior
                                                  end if;--if (sbCECOCODI is not null or sbCECOCODI <> '') then

                                                  icbProcPara:= '  <PARAMETROS>
                                                                                  <PARAMETRO>
                                                                                      <NOMBRE>DOCUMENT_ID</NOMBRE>
                                                                                      <VALOR>' || reTRANSIT_ITEM.DOCUMENT_ID || '</VALOR>
                                                                                  </PARAMETRO>
                                                                                  <PARAMETRO>
                                                                                      <NOMBRE>PROVEEDOR_LOGISTICO</NOMBRE>
                                                                                      <VALOR>' || Reccuunidadesoper.PROVEEDOR_LOGISTICO || '</VALOR>
                                                                                  </PARAMETRO>
                                                                                </PARAMETROS>';



                                                  -- crea el identificado de proceso para la interfaz
                                                  LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => 'WS_TRASLADO_MATERIALES',
                                                                                ICBPROCPARA     => icbProcPara,
                                                                                IDTPROCFEIN     => SYSDATE,
                                                                                ISBPROCESTA     => 'P',
                                                                                ISBPROCUSUA     => null,
                                                                                ISBPROCTERM     => null,
                                                                                ISBPROCPROG     => null,
                                                                                ONUPROCCODI     => onuProcCodi,
                                                                                ONUERRORCODE    => ONUERRORCODE,
                                                                                OSBERRORMESSAGE => OSBERRORMESSAGE);

                                                  /*SI NO EXISTE, CREAR CABECERA*/
                                                  /*GUARDAR CABECERA DE LA RESERVA*/
                                                  Insert Into LDCI_RESERVAMAT (RESERVA,
                                                                                UNIDAD_OPE,
                                                                                ALMACEN_CON,
                                                                                CLASE_MOV,
                                                                                CENTRO_COSTO,
                                                                                FECHA_ENTREGA,
                                                                                PROVEEDOR_LOG)
                                                                VALUES (to_char(reTRANSIT_ITEM.DOCUMENT_ID),
                                                                              reTRANSIT_ITEM.TARG_OPER_UNIT,
                                                                              reTRANSIT_ITEM.TARG_OPER_UNIT,
                                                                              'DEV',
                                                                              sbCECOCODI,
                                                                              CURRENT_DATE,
                                                                              Reccuunidadesoper.PROVEEDOR_LOGISTICO);

                                                    -- asigna el documento procesado
                                                    sbReferencia := to_char(reTRANSIT_ITEM.DOCUMENT_ID);
                                      end if; -- If fnuExisteDocumento(Sbreferencia) != 0 Then

                   -- Valia que el documento no este en transito para no ser reenviado
                   if ( LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(reTRANSIT_ITEM.DOCUMENT_ID) <> 'S') then
                     -- determina la cantidad de materiales / herrameintas en la solcitud
                     If (reTRANSIT_ITEM.ITEM_CLASSIF_ID = 3) Then
                         sbFlagHta := 'S';
                         nuCantHerr  := nuCantHerr + 1;
                     else
                         nuCantMate  := nuCantMate + 1;
                     end if; -- If (reTRANSIT_ITEM.ITEM_CLASSIF_ID = 3) Then
                   end if;--if ( LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(reTRANSIT_ITEM.DOCUMENT_ID) <> 'S') then

--dbms_output.put_line('#NC-XXX [ln821] ---------------------------------------');
--dbms_output.put_line('#NC-XXX [ln822] nuCantMate: ' || nuCantMate);
--dbms_output.put_line('#NC-XXX [ln823] nuCantHerr: ' || nuCantHerr);
--dbms_output.put_line('#NC-XXX [ln823] DOCUMENT_ID: ' || reTRANSIT_ITEM.DOCUMENT_ID);
--dbms_output.put_line('#NC-XXX [ln823] ITEM_ID: ' || reTRANSIT_ITEM.ITEM_ID);
--dbms_output.put_line('#NC-XXX [ln823] fsbGetDocuTran: ' || LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(reTRANSIT_ITEM.DOCUMENT_ID));
--dbms_output.put_line('#NC-XXX [ln824] ---------------------------------------');

                   -- NC-10902013: carlosvl: 10-09-2013: Se hace el cambio para enviar a consultar ITEM_CODE y no ITEM_ID
           --If fnuExisteDocumentoitem(to_char(reTRANSIT_ITEM.DOCUMENT_ID), to_char(reTRANSIT_ITEM.ITEM_ID))  != 0 Then
           If fnuExisteDocumentoitem(to_char(reTRANSIT_ITEM.DOCUMENT_ID), to_char(reTRANSIT_ITEM.ITEM_CODE))  != 0 Then
            /* CREAR DETALLE */
            Insert Into LDCI_DET_RESERVAMAT ( RESERVA,
                            ITEM_ID,
                            CODIGO_ITEM,
                            CANTIDAD,
                            COSTO_OS,
                            COSTO_ERP,
                            CENTRO,
                            ES_HERRAMIENTA)
                          values (reTRANSIT_ITEM.DOCUMENT_ID,
                              reTRANSIT_ITEM.ITEM_CODE /*ITEM_ID*/,
                              reTRANSIT_ITEM.ITEM_CODE /*ITEM_ID*/,
                              reTRANSIT_ITEM.TRANSIT_QUANTITY,
                              reTRANSIT_ITEM.VALUE, --#OYM_CEV_5028_1 : reTRANSIT_ITEM.TRANSIT_QUANTITY * reTRANSIT_ITEM.VALUE
                              reTRANSIT_ITEM.VALUE, --#OYM_CEV_5028_1 : reTRANSIT_ITEM.TRANSIT_QUANTITY * reTRANSIT_ITEM.VALUE
                              Reccuunidadesoper.PROVEEDOR_CODE,
                              decode(reTRANSIT_ITEM.ITEM_CLASSIF_ID, 3, 'S', 'N'));
           Else
            -- si el item es seriado incrementa la cantidad segun el numero de items a devolver
            if (reTRANSIT_ITEM.ITEM_CLASSIF_ID = 21) then
--dbms_output.put_line('----------------------------------------------------------------------------------');
--dbms_output.put_line('[reTRANSIT_ITEM.ITEM_CODE]' || reTRANSIT_ITEM.ITEM_CODE);
--dbms_output.put_line('[reTRANSIT_ITEM.ITEM_CLASSIF_ID]' || reTRANSIT_ITEM.ITEM_CLASSIF_ID);
--dbms_output.put_line('[reTRANSIT_ITEM.TRANSIT_QUANTITY]' || reTRANSIT_ITEM.TRANSIT_QUANTITY);
--dbms_output.put_line('[reTRANSIT_ITEM.VALUE]' || reTRANSIT_ITEM.VALUE);

            -- realiza le update a la tabla LDCI_DET_RESERVAMAT
            update LDCI_DET_RESERVAMAT set CANTIDAD  = CANTIDAD  + reTRANSIT_ITEM.TRANSIT_QUANTITY,
             COSTO_OS  = COSTO_OS  + reTRANSIT_ITEM.VALUE, --#OYM_CEV_5028_1 : reTRANSIT_ITEM.TRANSIT_QUANTITY * reTRANSIT_ITEM.VALUE
            COSTO_ERP = COSTO_ERP + reTRANSIT_ITEM.VALUE  --#OYM_CEV_5028_1 : reTRANSIT_ITEM.TRANSIT_QUANTITY * reTRANSIT_ITEM.VALUE
            where RESERVA = reTRANSIT_ITEM.DOCUMENT_ID
            and ITEM_ID = reTRANSIT_ITEM.ITEM_CODE /*ITEM_ID*/;
            end if;--if (reTRANSIT_ITEM.ITEM_CLASSIF_ID = 21) then
           END IF; -- If fnuExisteDocumentoitem(Sbreferencia, Sbitemcode)  != 0 Then

         end loop;--for reTRANSIT_ITEM in cuTRANSIT_ITEM(oclXmltransititems) loop

               for reLDCI_RESERVAMAT in cuLDCI_RESERVAMAT(Reccuunidadesoper.PROVEEDOR_LOGISTICO) loop

               BEGIN
               --380
               If sbValidaHerr = 'S' Then
                 select sum(decode(i.item_classif_id,3,1,0)) herra, sum(decode(i.item_classif_id, 3,0,1)) mate
                   into nuCantHerr,  nuCantMate
                 from open.LDCI_DET_RESERVAMAT r, open.ge_items i
                 where r.reserva=reLDCI_RESERVAMAT.RESERVA
                   and r.item_id=i.items_id;
               End If;
               --380
          if (LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(to_number(reLDCI_RESERVAMAT.RESERVA)) <> 'S') then
                -- valia si la solicitud tiene mezcla de materiales y herramientas
                if (nuCantMate <> 0 and nuCantHerr <> 0) then
                  -- solicitud de herramientas
                  proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'S', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                  If Onuerrorcode <> 0 Then --#NC:1456,1457,1458:
                    raise exce_proEnviarSolicitud;
                  End If; -- If Onuerrorcode = 0 Then

                  -- solicitud de materiales
                  proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'N', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                  If Onuerrorcode <> 0 Then --#NC:1456,1457,1458:
                    raise exce_proEnviarSolicitud;
                  End If; -- If Onuerrorcode = 0 Then
                end if; -- if (nuCantMate <> 0 and nuCantHerr <> 0) then

                -- solicitud de solo materiales
                if (nuCantMate <> 0 and nuCantHerr = 0) then
                  -- solicitud de materiales
                  proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'N', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                  If Onuerrorcode <> 0 Then --#NC:1456,1457,1458:
                    raise exce_proEnviarSolicitud;
                  End If; -- If Onuerrorcode = 0 Then
                end if;--if (nuCantMate <> 0 and nuCantHerr = 0) then

                -- solicitud de solo herramientas
                if (nuCantMate = 0 and nuCantHerr <> 0) then
                  -- solicitud de herramientas
                  proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'S', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                  If Onuerrorcode <> 0 Then --#NC:1456,1457,1458:
                    raise exce_proEnviarSolicitud;
                  End If; -- If Onuerrorcode = 0 Then
                end if;--if (nuCantMate = 0 and nuCantHerr <> 0) then

                -- crea el documento en transito
                LDCI_PKRESERVAMATERIAL.proCreaDocuTran(to_number(reLDCI_RESERVAMAT.RESERVA), onuErrorCode, osbErrorMessage);

                If Onuerrorcode = 0 Then
                  commit;
                Else
                  raise exce_proEnviarSolicitud;
                END IF; -- If Onuerrorcode = 0 Then
          else
                commit;
          end if;-- if (LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(to_number(sbReferencia)) <> 'S') then
          exception
  when exce_proEnviarSolicitud then
--dbms_output.put_line('[1174 exce_proEnviarSolicitud]' || osbErrorMessage);
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

  when exce_ValidaClaseValoracion then --#OYM_CEV_3429_1
       onuErrorCode := -1;
--dbms_output.put_line('[1174 exce_ValidaClaseValoracion]' || osbErrorMessage);
       Errors.seterror (onuErrorCode, osbErrorMessage);
       commit; --rollback;
       LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida clase de valoracion (Valoracion Separada)',  osbErrorMessage);

  when exce_ValidaCentroCosto then
--dbms_output.put_line('[1174 exce_ValidaCentroCosto]' || osbErrorMessage);
       onuErrorCode := -1;
       osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa (' || to_char(nuIduniopera)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

  when others then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit;
    END;

           end loop;--for reLDCI_RESERVAMAT in cuLDCI_RESERVAMAT(Reccuunidadesoper.PROVEEDOR_LOGISTICO) loop

                              --DBMS_XMLDOM.freeDocument(docitem); #144122: Se comenta el codigo
                      --end if;--if (nuDatos <> 0) then                    #144122: Se comenta el codigo
    else
      raise exce_OS_GET_TRANSIT_ITEM;
    END IF; -- If Onuerrorcode = 0 Then
   end loop; -- For Reccuunidadesoper In Cuunidadesoper Loop

   delete from LDCI_DET_RESERVAMAT;
   delete from LDCI_RESERVAMAT;
   commit;
exception
  when exce_proEnviarSolicitud then
--dbms_output.put_line('[1174 exce_proEnviarSolicitud]' || osbErrorMessage);
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

  when exce_ValidaClaseValoracion then --#OYM_CEV_3429_1
       onuErrorCode := -1;
--dbms_output.put_line('[1174 exce_ValidaClaseValoracion]' || osbErrorMessage);
       Errors.seterror (onuErrorCode, osbErrorMessage);
       commit; --rollback;
       LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida clase de valoracion (Valoracion Separada)',  osbErrorMessage);

  when exce_ValidaCentroCosto then
--dbms_output.put_line('[1174 exce_ValidaCentroCosto]' || osbErrorMessage);
       onuErrorCode := -1;
       osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa (' || to_char(nuIduniopera)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

  when others then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
--dbms_output.put_line('[1190_SQLERRM]' || SQLERRM);

END proNotificaDevoluciones;


Procedure proConfirmarReserva(Reserva       in  VARCHAR2,
                                                          inuProcCodi   in  NUMBER,
                             onuErrorCode out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                    osbErrorMessage Out ge_error_log.description%TYPE) As
/*
 PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

    FUNCION : proConfirmarReserva
    AUTOR : MAURICIO FERNANDO ORTIZ
    FECHA : 10/12/2012
    RICEF      : I005
    DESCRIPCION : Procedimiento para confirmar reservas en el sistema smartflex

 Parametros de Entrada
    Reserva In varchar2
 Parametros de Salida
   Nucodigo Out Number
   Sbmsj Out Varchar
 Historia de Modificaciones

 Autor                                       Fecha       Descripcion.
 carlos.virgen<carlos.virgen@olsfotware.com> 28-08-2014  #NC:1534 1535 1536: se coloca el codigo de homoloacion en la consulta GE_ITEMS.CODE
  */
 -- define variables
 L_Payload     clob;
 Qryctx        Dbms_Xmlgen.Ctxhandle;
 Sberrmens Varchar2(500);

 -- excepciones
 Excepnoprocesoregi  Exception;   -- Excepcion que valida si proceso registros la consulta
 exce_OS_SET_REQUEST_CONF exception;
Begin
   -- inicializa la variable de retorno
   onuErrorCode := 0;

   -- Genera el mensaje XML
      Qryctx :=  Dbms_Xmlgen.Newcontext ('Select RS.RESERVA    As "DOCUMENT_ID",
                                                                                            RS.UNIDAD_OPE As "OPERATING_UNIT_ID",
                                                                                            CURRENT_DATE as "DELIVERYDATE",
                                                                          Cursor (Select /*DT.ITEM_ID #NC:1534 1535 1536*/ ITEM.CODE as "ITEM_CODE",
                                                                                                        DT.CANTIDAD As "QUANTITY",
                                                                                                        DT.COSTO_OS as "COST"
                                                                                          From LDCI_DET_RESERVAMAT Dt, GE_ITEMS ITEM
                                                                                          Where RS.RESERVA = DT.RESERVA
                                                                                            and DT.ITEM_ID = ITEM.ITEMS_ID /*#NC:1534 1535 1536*/ ) As "ITEMS"
                                                                          From LDCI_RESERVAMAT Rs
                                                                          where RS.RESERVA = ' || reserva );

    Dbms_Xmlgen.Setrowsettag(Qryctx, 'REQUEST_CONF');
    --DBMS_XMLGEN.setRowTag(qryCtx, '');
    Dbms_Xmlgen.setNullHandling(qryCtx, 0);

    l_payload := dbms_xmlgen.getXML(qryCtx);

    --Valida si proceso registros
    if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then
         RAISE excepNoProcesoRegi;
    end if;--if(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) then

    dbms_xmlgen.closeContext(qryCtx);

    L_Payload := Replace(L_Payload, '<ROW>', '<DOCUMENT>');
    L_Payload := Replace(L_Payload, '</DELIVERYDATE>', '</DELIVERYDATE>' ||chr(13) || '</DOCUMENT>');
    L_Payload := Replace(L_Payload, '</ROW>','');

    l_payload := replace(l_payload, '<ITEMS_ROW>',  '<ITEM>');
    l_payload := replace(l_payload, '</ITEMS_ROW>', '</ITEM>');
    L_Payload := Trim(L_Payload);

     -- hace el llamado al API
    OS_SET_REQUEST_CONF(L_Payload, onuErrorCode , osbErrorMessage);
        --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << L_Payload] ' || chr(13) || L_Payload);
        --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF >> onuErrorCode] ' || onuErrorCode);
        --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF >> osbErrorMessage] ' || osbErrorMessage);

        if (onuErrorCode <> 0) then
              raise exce_OS_SET_REQUEST_CONF;
        end if;--if (onuErrorCode <> 0) then

EXCEPTION
 WHEN exce_OS_SET_REQUEST_CONF THEN
      Errors.seterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;

 WHEN excepNoProcesoRegi THEN
       onuErrorCode := -1;
       osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proConfirmarReserva]: La consulta no ha arrojo registros' || Dbms_Utility.Format_Error_Backtrace;
       Errors.seterror (onuErrorCode, osbErrorMessage);
       --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << osbErrorMessage1] ' || chr(13) || osbErrorMessage);
       commit; --rollback;

 when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      --dbms_output.put_line('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << osbErrorMessage2] ' || chr(13) || osbErrorMessage);
      commit; --rollback;

end proConfirmarReserva;


    PROCEDURE proProcesaReserva
    (
        Items_Documento_Id  in VARCHAR2,
        inuProcCodi         in NUMBER,
        onuErrorCode        out GE_ERROR_LOG.ERROR_LOG_ID%type,
        osbErrorMessage     out GE_ERROR_LOG.DESCRIPTION%type
    )
    AS
        /*
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

        FUNCION : proProcesaReserva
        AUTOR : MAURICIO FERNANDO ORTIZ
        FECHA : 10/12/2012
        RICEF      : I005
        DESCRIPCION : Procedimiento para procesar una reserva pendiente de notificacion al ERP

        Parametros de Entrada
        Items_Documento_Id varchar2
        Parametros de Salida
        onuErrorCode Out Number
        osbErrorMessage Out Varchar2
        Historia de Modificaciones

        Autor                                         Fecha       Descripcion.
        carlos.virgen <carlos.virgen@olsoftware.com>  20-08-2014 #NC:1456,1457,1458: Mejora Validaci??n del centro de costo, solicitud de herramienta
        carlos.virgen<carlos.virgen@olsoftware.com>   13-11-2014 #OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
        oparra                                        02-03-2017 CA. 200-638 -  Requisiciones autom?ticas
        */

        Osbrequest Varchar2(32000);
        Nuoperunitid Number;
        Nuerpoperunitid Number;
        --Dtdate date;

        Docitem       Dbms_Xmldom.Domdocument;
        Ndocitem      Dbms_Xmldom.Domnode;
        Docelemitem   Dbms_Xmldom.Domelement;
        Nodeitem      Dbms_Xmldom.Domnode;

        -- CA. 200-638
        nuJob_id        number;
        nuUser_id       number;
        nuUnidadOper    number;
        --

        Nuitemid    number(15);
        Sbitemcode  varchar2(60);
        Sbitemdesc  varchar2(100);
        Nuitemcant  number;
        Nuitemcosto number;
        Nuclassitem number;
        nuCantMate  number := 0;
        nuCantHerr  number := 0;

        sbFlagHta varchar2(1);

        oclXMLItemsData CLOB;

        Nodelistitem  Dbms_Xmldom.Domnodelist;
        Bufitem       Varchar2(32767);

        contadorItem Number(10);
        Nodelisteleitem  Dbms_Xmldom.Domnodelist;
        nodedummy Dbms_Xmldom.Domnode;

        sbOPER_UNIT_CODE OR_OPERATING_UNIT.OPER_UNIT_CODE%type;
        sbCECOCODI       LDCI_CECOUNIOPER.CECOCODI%type;
        sbCLASS_ASSESSMENT_ID LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%type; --#OYM_CEV_3429_1

        -- cursor de la unidad operativa
        Cursor cuUnidadOperativa(inuOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%type) Is
          Select OPER_UNIT_CODE
            From OR_OPERATING_UNIT
            Where OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

        -- cursor del centro de costo
        cursor cuLDCI_CECOUNIOPER(isbCECOCODI LDCI_CECOUNIOPER.CECOCODI%type) is
        select CECOCODI
                from LDCI_CECOUNIOPER
              where OPERATING_UNIT_ID = isbCECOCODI;

        --#OYM_CEV_3429_1: Cursor de la clase de valoracion por unidad operativa
        cursor cuLDCI_CLVAUNOP(inuOPERATING_UNIT_ID LDCI_CLVAUNOP.OPERATING_UNIT_ID%type) is  --#OYM_CEV_3429_1
        select CLASS_ASSESSMENT_ID
          from LDCI_CLVAUNOP
         where OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

        exce_proEnviarSolicitud    exception;
        exce_proConfirmarReserva   exception;
        exce_OS_GET_REQUEST        exception;
        exce_ValidaCentroCosto     exception;
        exce_ValidaClaseValoracion exception;    --#OYM_CEV_3429_1

    BEGIN

        -- CA. 200-638: obetener valor parametro
        nuJob_id    := dald_parameter.fnugetnumeric_value('LDC_ID_USARIOJOB');

        -- inicializa variable de salida
        onuErrorcode := 0;
        -- llamado original al API de OPEN
        OS_GET_REQUEST(to_number(Items_Documento_Id), Osbrequest,
                                Onuerrorcode, Osberrormessage);
            -- Create DOMDocument handle
          Docitem     := Dbms_Xmldom.Newdomdocument(Osbrequest);
          ndocitem    := DBMS_XMLDOM.makeNode(docitem);
          Dbms_Xmldom.Writetobuffer(Ndocitem, Bufitem);
          docelemitem := DBMS_XMLDOM.getDocumentElement(docitem);

          -- Access element
          Nodelistitem    := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'OPERATING_UNIT_ID');
          Nodedummy       := Dbms_Xmldom.Item(Nodelistitem, 0);
          Nuoperunitid    := To_Number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy)));
          Nodelistitem    := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'OPER_UNIT_ERP_ID');
          Nodedummy       := Dbms_Xmldom.Item(Nodelistitem, 0);
          nuerpoperunitid := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));

          -- determina el codigo del centro de distribucion
          open cuUnidadOperativa(nuerpoperunitid);
          fetch cuUnidadOperativa into sbOPER_UNIT_CODE;
          close cuUnidadOperativa;

          -- carga la informacion del centro de costo
          open cuLDCI_CECOUNIOPER(Nuoperunitid);
          fetch cuLDCI_CECOUNIOPER into sbCECOCODI;
          close cuLDCI_CECOUNIOPER;

          /*#OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
          open cuLDCI_CLVAUNOP(Nuoperunitid); --#OYM_CEV_3429_1: Carga el valor de la clase de valoracion
          fetch cuLDCI_CLVAUNOP into sbCLASS_ASSESSMENT_ID;
          close cuLDCI_CLVAUNOP;*/

          Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'DATE');
          Nodedummy := Dbms_Xmldom.Item(Nodelistitem, 0);
          --dtdate  := to_date(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)), 'DD/MM/YYYY');

          --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
          proValidaClaseValoraProvLogis(nuERPOperUnitId,
                                        sbCLASS_ASSESSMENT_ID,
                                        onuErrorCode,
                                        osbErrorMessage);
          if (onuErrorCode <> 0) then
              raise exce_ValidaClaseValoracion;
          end if; --if (onuErrorCode <> 0) then

          /*#OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
          if (sbCLASS_ASSESSMENT_ID is null or sbCLASS_ASSESSMENT_ID = '') then --#OYM_CEV_3429_1: Valida la clase de valoracion
              raise exce_ValidaClaseValoracion;
          end if;--if (sbCLASS_ASSESSMENT_ID is not null or sbCLASS_ASSESSMENT_ID <> '') then*/

        -- valida que la unidad operativa tenga configurado el centro de costo
        --if (sbCECOCODI is not null or sbCECOCODI <> '') then --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Se comenta la validacion anteriro
            /*GUARDAR CABECERA DE LA RESERVA*/
          insert into LDCI_RESERVAMAT (RESERVA, UNIDAD_OPE, ALMACEN_CON, CLASE_MOV, CENTRO_COSTO, FECHA_ENTREGA)
                 values (Items_Documento_Id, Nuoperunitid, nuerpoperunitid, 'PRU', sbCECOCODI, CURRENT_DATE);

          Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'ITEM');
          nuCantMate := 0;
          nuCantHerr := 0;
                            -- recorre los items
          For Contadoritem In 1..Dbms_Xmldom.Getlength(Nodelistitem) Loop
                Nodeitem := Dbms_Xmldom.Item(Nodelistitem, Contadoritem - 1);
                /*OBTENGO ELMENTOS DE ITEM*/
                Nodelisteleitem := Dbms_Xmldom.Getchildnodes(Nodeitem);


                Nodedummy := Dbms_Xmldom.Item(Nodelisteleitem, 0);
                nuitemid  := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));

                /* ejecutar os_get_item*/
                /* para saber si es una herramienta la clasificacion del item es 3 */
                Nuclassitem := fnuObtenerClasificacionItem(Nuitemid, null);
                --os_get_item(nuitemid, null, oclXMLItemsData, Onuerrorcode, Osberrormessage);

                If Nuclassitem = 3 Then
                    /* ES UNA HERRAMIENTA*/
                    Sbflaghta := 'S';
                    nuCantHerr := nuCantHerr + 1;
                Else
                      nuCantMate := nuCantMate + 1;
                End If; -- If Nuclassitem = 3 Then

                Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 1);
                sbitemcode  := Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy));
                Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 2);
                sbitemdesc  := Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy));
                Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 4);
                nuitemcant  := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(Nodedummy)));
                Nodedummy   := Dbms_Xmldom.Item(Nodelisteleitem, 5);
                nuitemcosto := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));


                /** validacion CA 200-638  **/
                -- obtener usuario que realiza el movimiento
                nuUser_id       := dage_items_documento.fnugetuser_id(Items_Documento_Id);
                -- obtiene la unidad operativa de la reserva
                nuUnidadOper    :=  dage_items_documento.fnugetoperating_unit_id(Items_Documento_Id);

                if (nuUser_id = nuJob_id) then

                    if (fblValidExistItem(nuitemid,nuUnidadOper)) then

                        insert into LDCI_DET_RESERVAMAT (Reserva, Item_Id, Codigo_Item, Cantidad, Costo_Os, Costo_Erp, Centro, Es_Herramienta)
                        values (Items_Documento_Id, nuitemid, sbitemcode, nuitemcant, nuitemcosto, null, sbOPER_UNIT_CODE, decode(Nuclassitem, 3, 'S', 'N'));

                        -- actualizar cupo en la tabla de pedidos
                        update ge_items_request
                        set confirmed_amount = 0,
                            confirmed_cost = 0
                        where items_id = nuitemid
                        and id_items_documento = Items_Documento_Id;

                    end if;

                else
                /** Fin validacion CA 200-638  **/

                    insert into LDCI_DET_RESERVAMAT (Reserva, Item_Id, Codigo_Item, Cantidad, Costo_Os, Costo_Erp, Centro, Es_Herramienta)
                    values (Items_Documento_Id, nuitemid, sbitemcode, nuitemcant, nuitemcosto, null, sbOPER_UNIT_CODE, decode(Nuclassitem, 3, 'S', 'N'));

                end if;

          end loop;--For Contadoritem In 1..Dbms_Xmldom.Getlength(Nodelistitem) Loop
          DBMS_XMLDOM.freeDocument(docitem);

          If Onuerrorcode = 0 Then
                -- valida si la solicitud tiene mezcla de materiales y herramientas
                if (nuCantMate <> 0 and nuCantHerr <> 0) then
                        -- solicitud de herramintas
                        --dbms_lock.sleep(15);
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'S', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
                        If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
                              raise exce_proEnviarSolicitud;
                        End If; -- If (Onuerrorcode) = 0 Then;

                        -- solicitu de materiales
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'N', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
                        If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
                              raise exce_proEnviarSolicitud;
                        End If; -- If (Onuerrorcode) = 0 Then;
                end if; -- if (nuCantMate <> 0 and nuCantHerr <> 0) then

                -- solicitud de solo materiales
                if (nuCantMate <> 0 and nuCantHerr = 0) then
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'N', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
                        If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
                              raise exce_proEnviarSolicitud;
                        End If; -- If (Onuerrorcode) = 0 Then;
                end if;--if (nuCantMate <> 0 and nuCantHerr = 0) then

                -- solicitud de solo herramientas
                if (nuCantMate = 0 and nuCantHerr <> 0) then
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'S', inuProcCodi , sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);

                        If (Onuerrorcode) <> 0 Then --#NC:1456,1457,1458:
                              raise exce_proEnviarSolicitud;
                        End If; -- If (Onuerrorcode) = 0 Then;
                end if;--if (nuCantMate = 0 and nuCantHerr <> 0) then

                If (Onuerrorcode) = 0 Then
                      -- hace la confirmacion de la solicitud llamado al API OS_SET_REQUEST_CONF
                      proConfirmarReserva(Items_Documento_Id, inuProcCodi, Onuerrorcode, Osberrormessage);
                      If (Onuerrorcode) = 0 Then
                        commit;
                      Else
                        -- guarda la excepcion
                        raise exce_proConfirmarReserva ;
                      End If; -- If (Onuerrorcode) = 0 Then;
                Else
                      -- guarda la excepcion
                      raise exce_proEnviarSolicitud;
                End If; -- If (Onuerrorcode) = 0 Then;
         Else
                -- guarda la excepcion
                raise exce_OS_GET_REQUEST;
         End If; -- If Onuerrorcode = 0 Then;

        --#NC:1456,1457,1458: 20-08-2014: carlos.virgen: Mejora Se comenta la validacion anteriro
         --#NC:1456,1457,1458 else
             -- guarda la excepcion
          --#NC:1456,1457,1458   raise exce_ValidaCentroCosto;
        --#NC:1456,1457,1458 end if;--if (sbCECOCODI is not null or sbCECOCODI <> '') then

    EXCEPTION
        When exce_proConfirmarReserva THEN
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;

        When exce_proEnviarSolicitud THEN

          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;

        When exce_OS_GET_REQUEST THEN
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;

        When exce_ValidaClaseValoracion THEN --#OYM_CEV_3429_1
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;
          LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(Items_Documento_Id), 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

        When exce_ValidaCentroCosto THEN
           onuErrorCode := -1;
           osbErrorMessage := '[proNotificaReservas] La unidad operativa (' || to_char(Nuoperunitid)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;
                LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(Items_Documento_Id), 'Valida configuraci??n centro de costo por unidad operativa',  osbErrorMessage);

        When Others THEN
          pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
          Errors.seterror;
          Errors.geterror (onuErrorCode, osbErrorMessage);
          commit; --rollback;
    END proProcesaReserva;


  Procedure proNotificaReservas As
   /*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

  FUNCION : proNotificaReservas
  AUTOR : MAURICIO FERNANDO ORTIZ
  FECHA : 10/12/2012
  RICEF      : I005
  DESCRIPCION : Procedimiento general par ala notificacion de reservas

   Parametros de Entrada

   Parametros de Salida

   Historia de Modificaciones
   Autor           Fecha       Descripcion.
   Eduardo Aguera  02/07/2015  Cambio 8136. Se optimiza consulta de XML utilizando cursor con XMLTable para obtener las solicitudes.


  */
        Inuopeuniterp_Id   NUMBER(15);
        Osbrequestsregs    VARCHAR2(32000);
        Onuerrorcode       NUMBER(15);
        OSBERRORMESSAGE    ge_error_log.description%TYPE;
        doc                DBMS_XMLDOM.DOMDocument;
        ndoc               DBMS_XMLDOM.DOMNode;
        docelem            DBMS_XMLDOM.DOMElement;
        node               DBMS_XMLDOM.DOMNode;
        childnode          DBMS_XMLDOM.DOMNode;
        Nodelist           Dbms_Xmldom.Domnodelist;
        Buf                Varchar2(2000);
        ITEMS_DOCUMENTO_ID number(15);
        Contador           Number(10);
        Osbrequest         Varchar2(32000);
        Nuoperunitid       Number;
        Nuerpoperunitid    Number;
        --Dtdate             date;
        Docitem            Dbms_Xmldom.Domdocument;
        Ndocitem           Dbms_Xmldom.Domnode;
        Docelemitem        Dbms_Xmldom.Domelement;
        Nodeitem           Dbms_Xmldom.Domnode;
        Nuitemid           Number(15);
        Sbitemcode         Varchar2(60);
        Sbitemdesc         Varchar2(100);
        Nuitemcant         number;
        Nuitemcosto        Number;
        Nuclassitem        Number;
        sbFlagHta          varchar2(1);
        oclXMLItemsData    CLOB;
        Nodelistitem       Dbms_Xmldom.Domnodelist;
        Bufitem            Varchar2(32767);
        contadorItem       Number(10);
        Nodelisteleitem    Dbms_Xmldom.Domnodelist;
        nodedummy          Dbms_Xmldom.Domnode;
        onuProcCodi        NUMBER;
        icbProcPara        CLOB;

        -- definicion de cursores
        -- cursor de las unidades operativas
        cursor cuUnidadOperativa Is
                Select OPERATING_UNIT_ID, OPER_UNIT_CODE
                    From OR_OPERATING_UNIT
                    Where OPER_UNIT_CLASSIF_ID = 11;

        reUnidadOperativa cuUnidadOperativa%rowtype;


        -- cursor de las solicitudes
        cursor cuREQUEST_REG(clXML in CLOB) is
          SELECT REQUEST.*
          FROM XMLTable('/REQUESTS_REG/ITEMS_DOCUMENTO_ID' PASSING XMLType(clXML)
                        COLUMNS
                        ITEMS_DOCUMENTO_ID NUMBER PATH '.'
                       ) AS REQUEST;


  Begin
    -- carga las variables requeridas para las solicitudes
    proCargaVarGlobal('WS_RESERVA_MATERIALES');


    -- recorre las unidades operativas de tipo 17 - CUARDILLA
    for reUnidadOperativa in cuUnidadOperativa loop
        -- carga las solicitudes
        OS_GET_REQUESTS_REG(reUnidadOperativa.OPERATING_UNIT_ID,
                            OSBREQUESTSREGS,
                            ONUERRORCODE,
                            OSBERRORMESSAGE);

        -- Create DOMDocument handle
    /*
        doc     := DBMS_XMLDOM.newDOMDocument(Osbrequestsregs);
        ndoc    := DBMS_XMLDOM.makeNode(doc);

        Dbms_Xmldom.Writetobuffer(Ndoc, Buf);
        docelem := DBMS_XMLDOM.getDocumentElement(doc);

        -- Access element
        Nodelist := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEMS_DOCUMENTO_ID');
        */ --8136 EDUAGU: Se comentarea esta seccion para optimizar procesamiento XML
    IF not fblAplicaEntrega('SAP_SD_VBG_200798_1') then

        doc     := DBMS_XMLDOM.newDOMDocument(Osbrequestsregs);
        ndoc    := DBMS_XMLDOM.makeNode(doc);

        Dbms_Xmldom.Writetobuffer(Ndoc, Buf);
        docelem := DBMS_XMLDOM.getDocumentElement(doc);

        -- Access element
        Nodelist := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEMS_DOCUMENTO_ID');

     end if;
        -- recorre el listado de las reservas pendientes
        For reREQUEST_REG in cuREQUEST_REG(OSBREQUESTSREGS) loop
          --For Contador In 1..Dbms_Xmldom.Getlength(Nodelist) Loop


          -- extrae el codigo de la reserva a procesar
          --Node               := Dbms_Xmldom.Item(Nodelist, Contador - 1);
          --Childnode          := Dbms_Xmldom.Getfirstchild(Node);
          --Items_Documento_Id := to_number(Dbms_Xmldom.Getnodevalue(Childnode));
          Items_Documento_Id := reREQUEST_REG.ITEMS_DOCUMENTO_ID;

              icbProcPara:= '<PARAMETROS>
                                                    <PARAMETRO>
                                                        <NOMBRE>ITEMS_DOCUMENTO_ID</NOMBRE>
                                                        <VALOR>' || Items_Documento_Id ||'</VALOR>
                                                    </PARAMETRO>
                                                    <PARAMETRO>
                                                        <NOMBRE>OPERATING_UNIT_ID</NOMBRE>
                                                        <VALOR>' || reUnidadOperativa.OPERATING_UNIT_ID ||'</VALOR>
                                                    </PARAMETRO>
                                                </PARAMETROS>';


                   -- crea el identificado de proceso para la interfaz
                    LDCI_PKMESAWS.PROCREAESTAPROC(ISBPROCDEFI     => 'WS_RESERVA_MATERIALES',
                                                                                ICBPROCPARA     => icbProcPara,
                                                                                IDTPROCFEIN     => SYSDATE,
                                                                                ISBPROCESTA     => 'P',
                                                                                ISBPROCUSUA     => null,
                                                                                ISBPROCTERM     => null,
                                                                                ISBPROCPROG     => null,
                                                                                ONUPROCCODI     => onuProcCodi,
                                                                                ONUERRORCODE    => ONUERRORCODE,
                                                                                OSBERRORMESSAGE => OSBERRORMESSAGE);

          /*Procesar reserva, carga maestro, detalle, confirmar items y enviar*/
          proProcesaReserva(Items_Documento_Id, onuProcCodi, Onuerrorcode, Osberrormessage );

          /*si hay herramientas enviar y confirmar herramientas*/
        End Loop;-- For Contador In 1..Dbms_Xmldom.Getlength(Nodelist) Loop

    end loop; -- for reUnidadOperativa in cuUnidadOperativa loop

  -- elimina los registros de la tabla de procesamiento
    delete from LDCI_DET_RESERVAMAT;
    delete from LDCI_RESERVAMAT;
     commit;
        -- libera el archivo XML
    DBMS_XMLDOM.freeDocument(doc);
  exception
  when others  then
      pkErrors.NotifyError (pkErrors.fsbLastObject, SQLERRM, osbErrorMessage);
      Errors.seterror;
      Errors.geterror (onuErrorCode, osbErrorMessage);
      commit; --rollback;
  END proNotificaReservas;


  Procedure proNotificaDocumentosERP As
   /*
   PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A. E.S.P

    FUNCION : LDCI_PKRESERVAMATERIAL.proNotificaDocumentosERP
    AUTOR : MAURICIO FERNANDO ORTIZ
    FECHA : 10/12/2012
    RICEF      : I005; I006
    DESCRIPCION : Procedimiento general par la notificacion de reservas y
                  devoluciones de material

   Parametros de Entrada

   Parametros de Salida

   Historia de Modificaciones

   Autor        Fecha       Descripcion.
   dsaltarin   01/04/2022   OSF-200 Se carga variable global sbAplicaOSF200 para validar si la entrega aplicar para la gasera.
  */
  Begin
    if fblaplicaentregaxcaso('OSF-200') then
       sbAplicaOSF200 :='S';
    else
       sbAplicaOSF200 :='N';
    end if;
    LDCI_PKRESERVAMATERIAL.proNotificaReservas;
    LDCI_PKRESERVAMATERIAL.proNotificaDevoluciones;
  end proNotificaDocumentosERP;
FUNCTION fsbGETobtultserial(sbseri VARCHAR2) RETURN VARCHAR2 AS
/********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-06-01
    Descripcion : Obtenemos el ultimo serial despachado

    Parametros Entrada
     sboperacion  Operacion si es Devolucion o Reserva
     nucodumento  Documento
     nuitemspa    Item's seriados

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*********************************************************************************************************/
 sbvaserie    ge_items_seriado.serie%TYPE;
 sbvaseriesap ldci_seridmit.seriestr%TYPE;
BEGIN
 sbvaserie := TRIM(sbseri);
 BEGIN
  SELECT serie_sap INTO sbvaseriesap
    FROM(
         SELECT t.serimmit,t.serinume,t.seriestr serie_sap,m.mmitfecr
           FROM ldci_seridmit t,ldci_intemmit m
          WHERE t.serinume = sbvaserie
            AND t.serimmit = m.mmitcodi
          ORDER BY m.mmitfecr DESC
         )
   WHERE ROWNUM = 1;
 EXCEPTION
  WHEN no_data_found THEN
   sbvaseriesap := 'NULO';
 END;
 RETURN sbvaseriesap;
EXCEPTION
 WHEN OTHERS THEN
  sbvaseriesap := 'NULO';
  RETURN sbvaseriesap;
END fsbGETobtultserial;
FUNCTION fsbGETobtmarcultserial(sbseri VARCHAR2) RETURN VARCHAR2 AS
  /********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-06-01
    Descripcion : Obtenemos la marca del ultimo serial despachado

    Parametros Entrada
     sboperacion  Operacion si es Devolucion o Reserva
     nucodumento  Documento
     nuitemspa    Item's seriados

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*********************************************************************************************************/
 sbvaserie       ge_items_seriado.serie%TYPE;
 sbvasbmarcadesc ldci_marca.marcdesc%TYPE;
BEGIN
 sbvaserie := TRIM(sbseri);
 BEGIN
 SELECT (SELECT mc.marcdesc FROM ldci_marca mc WHERE mc.marccodi = marca_) INTO sbvasbmarcadesc
   FROM(
        SELECT marca_
          FROM(
               SELECT t.serimmit,t.serinume,t.serimarc marca_,t.seriestr serie_sap,m.mmitfecr
                 FROM ldci_seridmit t,ldci_intemmit m
                WHERE t.serinume = sbvaserie
                  AND t.serimmit = m.mmitcodi
                ORDER BY m.mmitfecr DESC
               )
         WHERE rownum = 1
        ) ;
 EXCEPTION
  WHEN no_data_found THEN
   sbvasbmarcadesc := 'NULO';
 END;
 RETURN sbvasbmarcadesc;
EXCEPTION
 WHEN OTHERS THEN
  sbvasbmarcadesc := 'NULO';
  RETURN sbvasbmarcadesc;
END fsbGETobtmarcultserial;
Function fsbGETxmlserializados(sboperacion VARCHAR2,nucodumento NUMBER,nuitemspa NUMBER) Return VARCHAR2 AS
/********************************************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2018-03-22
    Descripcion : Genera XML para los item's seriados que se envian SAP para las devoluciones

    Parametros Entrada
     sboperacion  Operacion si es Devolucion o Reserva
     nucodumento  Documento
     nuitemspa    Item's seriados

    Valor de salida

   HISTORIA DE MODIFICACIONES
     FECHA        AUTOR   DESCRIPCION
*********************************************************************************************************/
qryCtx     dbms_xmlgen.ctxhandle;
L_Payload  CLOB;
rfConsulta Constants.tyRefCursor;
l_offset   NUMBER DEFAULT 1;
nuconta    NUMBER(15) DEFAULT 0;
BEGIN
 IF sboperacion = 'DEV' THEN
  nuconta := 0;
  SELECT COUNT(1) INTO nuconta
    FROM(
         SELECT ldci_pkreservamaterial.fsbgetobtultserial(s.serie)   AS "Serie"
               ,ldci_pkreservamaterial.fsbGETobtmarcultserial(serie) AS "Marca"
           FROM or_uni_item_bala_mov  k
               ,open.ge_items_seriado s
          WHERE k.id_items_documento = nucodumento
            AND k.items_id           = nuitemspa
            AND k.movement_type      = 'D'
            AND k.id_items_seriado   = s.id_items_seriado
        )
   WHERE "Serie" <> 'NULO' AND "Marca" <> 'NULO';
  L_Payload := NULL;
  IF nuconta >= 1 THEN
   OPEN rfConsulta for
    SELECT ldci_pkreservamaterial.fsbgetobtultserial(s.serie)   AS "Serie"
          ,ldci_pkreservamaterial.fsbGETobtmarcultserial(serie) AS "Marca"
      FROM or_uni_item_bala_mov  k
          ,open.ge_items_seriado s
     WHERE k.id_items_documento = nucodumento
       AND k.items_id           = nuitemspa
       AND k.movement_type      = 'D'
       AND k.id_items_seriado   = s.id_items_seriado;
    qryCtx := Dbms_Xmlgen.Newcontext(rfConsulta);
    Dbms_Xmlgen.setNullHandling(qryCtx, 2);
    l_payload := dbms_xmlgen.getXML(qryCtx);
    dbms_xmlgen.closeContext(qryCtx);
    L_Payload := REPLACE(L_Payload, '<?xml version="1.0"?>');
    L_Payload := REPLACE(L_Payload, '<ROWSET', '<Seriales');
    L_Payload := REPLACE(L_Payload, '</ROWSET>', '</Seriales>');
    L_Payload := REPLACE(L_Payload, '<ROW>', '<Serial>');
    L_Payload := REPLACE(L_Payload, '</ROW>', '</Serial>');
    L_Payload := TRIM(L_Payload);
   /* LOOP
     EXIT WHEN l_offset > dbms_lob.getlength(L_Payload);
     dbms_output.put_line( dbms_lob.substr( L_Payload, 255, l_offset ) );
     l_offset := l_offset + 255;
    END LOOP;*/
    RETURN L_Payload;
  ELSE
   RETURN L_Payload;
  END IF;
 END IF;
END fsbGETxmlserializados;
End LDCI_PKRESERVAMATERIAL;
/

