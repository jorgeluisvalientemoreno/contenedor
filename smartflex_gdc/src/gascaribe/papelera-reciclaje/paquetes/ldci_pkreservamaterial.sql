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
  Eduardo Aguera  02/07/2015  Cambio 8136. proNotificaReservas. Se optimiza consulta de XML utilizando CURSOR con XMLTable para obtener las solicitudes.
  dsaltarin		  02/06/2020  Cambio 380. proEnviarSolicitud. Se cambia la forma del xml para devolver seriales.
  jpinedc         27/05/2024  OSF-2603: Se ajusta proNotificaExepcion  
  jpinedc         15/04/2025  OSF-4245: * Se borra sbPrefijoLDC ya que se obtiene en cursor
                                        * Se borra sbEntrega380 ya que la entrega por caso 0000380 
                                          aplica para GdC
                                        * Se borra sbAplicaE380 ya que tiene valor S para GdC
                                        * Se borra sbAplicaOSF200 ya que OSF-200 aplica para GdC
                                        * Se ajusta proCargaVarGlobal
                                        * Se ajusta proEnviarSolicitud 
                                        * Se ajusta proNotificaDocumentosERP
*/

  -- procedimeinto que notifica las devoluciones pendientes
  PROCEDURE proNotificaDevoluciones;

  -- procedimeinto que notifica las reservas
  PROCEDURE proNotificaReservas;

  -- procedimiento que se ejecutara como JOB para el despacho de solicitudes
  PROCEDURE proNotificaDocumentosERP;

    -- procedimeinto que registra un documento en transito
  PROCEDURE proCreaDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%TYPE,
                            onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                            osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%TYPE);

  PROCEDURE proElimDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%TYPE,
                            onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                            osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%TYPE);

  PROCEDURE proNotificaExepcion(inuDocumento     in NUMBER,
                                isbAsunto        in VARCHAR2,
                                isbMesExcepcion  in VARCHAR2)  ;

  FUNCTION fsbGetDocuTran(inuDOTRDOCU in LDCI_DOCUTRAN.DOTRDOCU%TYPE) RETURN VARCHAR2;

  FUNCTION fsbGETxmlserializados(sboperacion VARCHAR2,nucodumento NUMBER,nuitemspa NUMBER) RETURN VARCHAR2;
  
  FUNCTION fsbGETobtultserial(sbseri VARCHAR2) RETURN VARCHAR2;
  
  FUNCTION fsbGETobtmarcultserial(sbseri VARCHAR2) RETURN VARCHAR2;

END LDCI_PKRESERVAMATERIAL;
/

CREATE OR REPLACE PACKAGE BODY LDCI_PKRESERVAMATERIAL AS

    csbSP_NAME		CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza    CONSTANT NUMBER(2)    := pkg_traza.fnuNivelTrzDef;
    
    -- Carga variables globales
    sbInputMsgType  LDCI_CARASEWE.CASEVALO%TYPE;
    sbNameSpace     LDCI_CARASEWE.CASEVALO%TYPE;
    sbUrlWS         LDCI_CARASEWE.CASEVALO%TYPE;
    sbUrlDesti      LDCI_CARASEWE.CASEVALO%TYPE;
    sbSoapActi      LDCI_CARASEWE.CASEVALO%TYPE;
    sbProtocol      LDCI_CARASEWE.CASEVALO%TYPE;
    sbHost          LDCI_CARASEWE.CASEVALO%TYPE;
    sbPuerto        LDCI_CARASEWE.CASEVALO%TYPE;
    sbClasSolMat    LDCI_CARASEWE.CASEVALO%TYPE;
    sbClasDevMat    LDCI_CARASEWE.CASEVALO%TYPE;
    sbClasSolHer    LDCI_CARASEWE.CASEVALO%TYPE;
    sbClasDevHer    LDCI_CARASEWE.CASEVALO%TYPE;
    sbDefiSewe      LDCI_DEFISEWE.DESECODI%TYPE;
    sbClasSolMatAct LDCI_DEFISEWE.DESECODI%TYPE; --#OYM_CEV_3429_1
    sbClasDevMatAct LDCI_DEFISEWE.DESECODI%TYPE; --#OYM_CEV_3429_1
    sbLstCentSolInv LDCI_DEFISEWE.DESECODI%TYPE; --#OYM_CEV_5028_1: #ifrs #471: Listado de UO proveedor logistico para solicitud de inventario
    sbLstCentSolAct LDCI_DEFISEWE.DESECODI%TYPE; --#OYM_CEV_5028_1: #ifrs #471: Listado de UO proveedor logistico para solicitud de activos

    sbValidaHerr    varchar2(1);

    PROCEDURE proValidaClaseValoraProvLogis(inuIdProvLogistico    in NUMBER,
                                         sbCLASS_ASSESSMENT_ID out VARCHAR2,
                                         onuErrorCode          out NUMBER,
                                         osbErrorMessage       out VARCHAR2) as
    /*
     PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
     FUNCION    : LDCI_PKRESERVAMATERIAL.proValidaClaseValoraProvLogis
     AUTOR      : Carlos E. Virgen Londoño <carlos.virgen@olsoftware.com>
     FECHA      : 14/11/2014
     RICEF      : OYM_CEV_5028_1
     DESCRIPCION: Valida la clase de valoracion del proveedor  logistico

    Historia de Modificaciones
    Autor     Fecha      Descripcion
    */
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proValidaClaseValoraProvLogis';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);     
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        -- Determina si el proveedor logistico es Activos o Inventarios
        onuErrorCode := 0;
        IF (INSTR(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0
         AND INSTR(LDCI_PKRESERVAMATERIAL.sbLstCentSolAct, inuIdProvLogistico) <> 0) THEN
            onuErrorCode := -1;
            osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa proveedor logistico (' || to_char(inuIdProvLogistico)   ||
                               ') esta configurada como Inventario y Activo. (Forma GEMCSW; Id Servicio WS_RESERVA_MATERIALES, WS_TRASLADO_MATERIALES; Id parametros LST_CENTROS_SOL_INV, LST_CENTROS_SOL_ACT)';
        ELSE
            IF (INSTR(LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, inuIdProvLogistico) <> 0) THEN
               --Clase de valoracion Inventario
               sbCLASS_ASSESSMENT_ID := 'I';
            ELSE
                IF (INSTR(LDCI_PKRESERVAMATERIAL.sbLstCentSolAct, inuIdProvLogistico) <> 0) THEN
                   --Clase de valoracion Activo
                   sbCLASS_ASSESSMENT_ID := 'A';
                ELSE
                    onuErrorCode := -1;
                    osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa proveedor logistico (' || to_char(inuIdProvLogistico)   ||
                                       ') no esta configurada como Inventario o Activo. (Forma GEMCSW; Id Servicio WS_RESERVA_MATERIALES, WS_TRASLADO_MATERIALES; Id parametros LST_CENTROS_SOL_INV, LST_CENTROS_SOL_ACT)';


                END IF;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
    END proValidaClaseValoraProvLogis;

    PROCEDURE proNotificaExepcion(  inuDocumento     in NUMBER,
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
        CURSOR cuGE_ITEMS_DOCUMENTO(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE) IS
         SELECT doc.ID_ITEMS_DOCUMENTO, typ.DESCRIPTION, doc.OPERATING_UNIT_ID, ori.NAME ORINAME, doc.DESTINO_OPER_UNI_ID, des.NAME DESNAME, doc.USER_ID, doc.FECHA, doc.TERMINAL_ID
           FROM GE_ITEMS_DOCUMENTO doc,
                GE_DOCUMENT_TYPE typ,
                OR_OPERATING_UNIT ori,
                OR_OPERATING_UNIT des
          WHERE doc.DOCUMENT_TYPE_ID = typ.DOCUMENT_TYPE_ID
            AND doc.OPERATING_UNIT_ID = ori.OPERATING_UNIT_ID
            AND doc.DESTINO_OPER_UNI_ID = des.OPERATING_UNIT_ID
                    AND ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO;

        --CURSOR datos de la persona
        CURSOR cuGE_PERSON(inuUSER_ID GE_PERSON.USER_ID%TYPE) IS
                SELECT *
                        FROM GE_PERSON g
                        WHERE g.USER_ID = inuUSER_ID;

        -- tipo registro
        reGE_PERSON          cuGE_PERSON%rowtype;
        reGE_ITEMS_DOCUMENTO cuGE_ITEMS_DOCUMENTO%rowtype;
        
        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
    
        sbMensCorreo    VARCHAR2(4000);
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
        -- abre el registro del documento con excepciones
        OPEN cuGE_ITEMS_DOCUMENTO(inuDocumento);
        FETCH cuGE_ITEMS_DOCUMENTO INTO reGE_ITEMS_DOCUMENTO;
        CLOSE cuGE_ITEMS_DOCUMENTO;

        --determina el usuario que esta realizando la operacion
        OPEN cuGE_PERSON(reGE_ITEMS_DOCUMENTO.USER_ID);
        FETCH cuGE_PERSON INTO reGE_PERSON;
        CLOSE cuGE_PERSON;

        IF (reGE_PERSON.E_MAIL IS not null or reGE_PERSON.E_MAIL <> '') THEN

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
              
        ELSE
            sbMensCorreo := 'El usuario ' || reGE_PERSON.PERSON_ID || '-' || reGE_PERSON.NAME_ ||' no tiene configurado el correo electrónico.';

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        => sbRemitente,
                isbDestinatarios    => sbRemitente,
                isbAsunto           => 'Usuario sin correo electrónico ('|| reGE_PERSON.NAME_ || ')',
                isbMensaje          => sbMensCorreo
            );   
        END IF;
        
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
    END proNotificaExepcion;

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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbValidaCadena';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
            
        osbCadena  VARCHAR2(100); -- SD 77654 LJL -- Se almacena la cadena que se va a retornar
        nuLong    NUMBER DEFAULT 0;
        onuErrorCode    GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        osbErrorMessage GE_ERROR_LOG.DESCRIPTION%TYPE;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
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

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                
        RETURN osbCadena;
    
    EXCEPTION
        WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError (onuErrorCode, osbErrorMessage);
          commit;
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

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblValidExistItem';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
            
        blResult    boolean;
        nuCant      number;
        
        CURSOR cuCantLdc_salitemsunidop
        IS
        SELECT count(1)
        FROM ldc_salitemsunidop
        WHERE items_id = inuItem
        AND operating_unit_id = inuUnOP;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        OPEN cuCantLdc_salitemsunidop;
        FETCH cuCantLdc_salitemsunidop INTO nuCant;
        CLOSE cuCantLdc_salitemsunidop;
        
        blResult := nuCant > 0;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN blResult;

    END FBLVALIDEXISTITEM;


    PROCEDURE proCreaDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%TYPE,
                                                      onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                                      osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%TYPE) as
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fblValidExistItem';
              
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        onuErrorCode    := 0;
        osbErrorMessage := null;
        
        -- realiza la insercion sobre la tabla LDCI_DOCUTRAN
        INSERT INTO LDCI_DOCUTRAN(DOTRDOCU,DOTRFECR)
        values (inuDOTRDOCU, SYSDATE);
                
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);                

    EXCEPTION
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END proCreaDocuTran;

    PROCEDURE proElimDocuTran(inuDOTRDOCU      in  LDCI_DOCUTRAN.DOTRDOCU%TYPE,
                                                      onuErrorCode    out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                                      osbErrorMessage out GE_ERROR_LOG.DESCRIPTION%TYPE) as
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proElimDocuTran';
      
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);    
    
        onuErrorCode    := 0;
        osbErrorMessage := null;
        
        -- elimina el registro de la tabla
        DELETE LDCI_DOCUTRAN
        WHERE DOTRDOCU = inuDOTRDOCU;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END proElimDocuTran;

    FUNCTION fsbGetDocuTran(inuDOTRDOCU in LDCI_DOCUTRAN.DOTRDOCU%TYPE)
    RETURN VARCHAR2    IS
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

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbGetDocuTran';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
              
        -- CURSOR del documento en transito
        CURSOR cuDocuTran(inuDOTRDOCU LDCI_DOCUTRAN.DOTRDOCU%TYPE) IS
        SELECT *
        FROM LDCI_DOCUTRAN
        WHERE DOTRDOCU = inuDOTRDOCU;

        sbFlagDocuTran VARCHAR2(1);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);      
    
        sbFlagDocuTran := 'N';
        
        FOR reDocuTran in cuDocuTran(inuDOTRDOCU) LOOP
            sbFlagDocuTran := 'S';
        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
        RETURN sbFlagDocuTran;
        
    END fsbGetDocuTran;

    PROCEDURE proCargaVarGlobal(isbCASECODI in LDCI_CARASEWE.CASECODI%TYPE ) as
    /*
        PROPIEDAD INTELECTUAL DE GASES DE OCCIDENTE S.A E.S.P
        FUNCION    : proCargaVarGlobal
        AUTOR      : OLSoftware / Carlos E. Virgen
        FECHA      : 25/02/2012
        RICEF      : I005; I006
        DESCRIPCION: Limpia y carga las variables globales

        Historia de Modificaciones
        Autor   Fecha       Descripcion
        jpinedc 16/04/2025  Se borran las referencias a sbPrefijoLDC   
    */

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proCargaVarGlobal';

        onuErrorCode      ge_error_log.Error_log_id%TYPE;
        osbErrorMessage   ge_error_log.description%TYPE;
        errorPara01  EXCEPTION;        -- Excepcion que verifica que ingresen los parametros de entrada

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
        
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
        LDCI_PKRESERVAMATERIAL.sbClasSolMatAct := null;
        LDCI_PKRESERVAMATERIAL.sbClasDevMatAct := null;
        LDCI_PKRESERVAMATERIAL.sbLstCentSolInv := null;
        LDCI_PKRESERVAMATERIAL.sbLstCentSolAct := null;
        LDCI_PKRESERVAMATERIAL.sbClasSolHer    := null;
        LDCI_PKRESERVAMATERIAL.sbClasDevHer    := null;
        LDCI_PKRESERVAMATERIAL.sbDefiSewe       := null;

        LDCI_PKRESERVAMATERIAL.sbDefiSewe := isbCASECODI;
        
        -- carga los parametos de la interfaz
        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'INPUT_MESSAGE_TYPE', LDCI_PKRESERVAMATERIAL.sbInputMsgType, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'NAMESPACE', LDCI_PKRESERVAMATERIAL.sbNameSpace, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'WSURL', LDCI_PKRESERVAMATERIAL.sbUrlWS, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'SOAPACTION', LDCI_PKRESERVAMATERIAL.sbSoapActi, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PROTOCOLO', LDCI_PKRESERVAMATERIAL.sbProtocol, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'PUERTO', LDCI_PKRESERVAMATERIAL.sbPuerto, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE errorPara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'HOST', LDCI_PKRESERVAMATERIAL.sbHost, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_MATERIAL', LDCI_PKRESERVAMATERIAL.sbClasSolMat, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_DEVOLUCION_MAT', LDCI_PKRESERVAMATERIAL.sbClasDevMat, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_HERRAMIENTA', LDCI_PKRESERVAMATERIAL.sbClasSolHer, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLS_MOVI_DEVOLUCION_HER', LDCI_PKRESERVAMATERIAL.sbClasDevHer, osbErrorMessage);
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLSM_SOLI_ACT', LDCI_PKRESERVAMATERIAL.sbClasSolMatAct, osbErrorMessage); --#OYM_CEV_3429_1
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'CLSM_DEVO_ACT', LDCI_PKRESERVAMATERIAL.sbClasDevMatAct, osbErrorMessage); --#OYM_CEV_3429_1
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'LST_CENTROS_SOL_INV', LDCI_PKRESERVAMATERIAL.sbLstCentSolInv, osbErrorMessage); --#OYM_CEV_5028_1: #ifrs #471
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKWEBSERVUTILS.proCaraServWeb(isbCASECODI, 'LST_CENTROS_SOL_ACT', LDCI_PKRESERVAMATERIAL.sbLstCentSolAct, osbErrorMessage); --#OYM_CEV_5028_1: #ifrs #471
        IF(osbErrorMessage != '0') THEN
           RAISE Errorpara01;
        END IF;

        LDCI_PKRESERVAMATERIAL.Sburldesti := Lower(LDCI_PKRESERVAMATERIAL.Sbprotocol) || '://' || LDCI_PKRESERVAMATERIAL.Sbhost || ':' || LDCI_PKRESERVAMATERIAL.Sbpuerto || '/' || LDCI_PKRESERVAMATERIAL.Sburlws;
        LDCI_PKRESERVAMATERIAL.sbUrlDesti := trim(LDCI_PKRESERVAMATERIAL.sbUrlDesti);

        sbValidaHerr := nvl(pkg_BCLd_Parameter.fsbObtieneValorCadena('LDC_CUENTA_HERR_DEVOLU'),'N');

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
        
    EXCEPTION
        WHEN Errorpara01 THEN
            Errors.seterror (-1, 'ERROR: [LDCI_PKRESERVAMATERIAL.proCargaVarGlobal]: Cargando el parametro :' || osbErrorMessage);
            commit;
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END proCargaVarGlobal;

    PROCEDURE proEnviarSolicitud
    (
            reserva                in  VARCHAR2,
            isbOperacion           in  VARCHAR2,
            flagherramienta        in  VARCHAR,
            inuProcCodi            in  NUMBER,
            isbCLASS_ASSESSMENT_ID in  LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%TYPE,
            onuErrorCode           out ge_error_log.Error_log_id%TYPE,
            osbErrorMessage        out ge_error_log.description%TYPE
    ) 
    As
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

    Autor       Fecha       Caso        Descripcion.
    carlosvl    17/09/2013  NC-622:     Se ajusta la generacion de la etiqueta "ResFront" para enviarlo del modo
                                        [Letra(s) que identifican la empresa]-[Tipo de Movimiento]-[Numero de la Solicitud]/[Nombre del solicitante]
    carlosvl    25022015    NC-25022015 Se modifica el formato de '9999999999999.99' a '9999999999990.99'
    dsaltarin   02/06/2020  Cambio 380  Se cambia la forma del xml para devolver seriales.
    dsaltarin   01/04/2022  OSF-200     Se envian 3 decimales en la cantidad en lugar de 2
    jpinedc     16/04/2025  OSF-4245    Se reemplaza sbPrefijoLDC por base_admin.empresa. 
                                        Se quita referencia a sbAplicaOSF200 ya que aplica para GdC
    */

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proEnviarSolicitud';
        nuError         NUMBER;
        sbError         VARCHAR2(4000); 
        
        CURSOR cuLDCI_RESERVAMAT(sbRESERVA VARCHAR2) IS
        SELECT RESERVA, UNIDAD_OPE, NAME, CENTRO_COSTO
        FROM LDCI_RESERVAMAT, OR_OPERATING_UNIT
        WHERE OPERATING_UNIT_ID = UNIDAD_OPE
        AND RESERVA = sbRESERVA;
        
        -- variables
        sbErrMens      VARCHAR2(500);
        sbClasMov      LDCI_CARASEWE.CASEVALO%TYPE;
        Sbmens         VARCHAR2(4000);
        onuMesacodi     NUMBER;
        sbcondicionHta VARCHAR2(100);

        --Variables mensajes SOAP
        L_Payload     CLOB;
        l_response    CLOB;
        qryCtx        DBMS_XMLGEN.ctxHandle;
        reLDCI_RESERVAMAT cuLDCI_RESERVAMAT%rowtype;

        -- excepciones
        errorPara01             EXCEPTION;  -- Excepcion que verifica que ingresen los parametros de entrada
        Excepnoprocesoregi      EXCEPTION;   -- Excepcion que valida si proceso registros la consulta
        excepNoProcesoSOAP      EXCEPTION;   -- Excepcion que valida si proceso peticion SOAP
        exce_ValidaCentroCosto  EXCEPTION;
        sbFormato               VARCHAR2(1000);

    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
                
        sbFormato :='9999999999990.999';
        
        -- valida si el campo de reserva esta lleno
        IF (reserva IS not null) THEN
        
            IF (flagherramienta = 'S') THEN
                OPEN cuLDCI_RESERVAMAT(reserva);
                FETCH cuLDCI_RESERVAMAT INTO reLDCI_RESERVAMAT;
                CLOSE cuLDCI_RESERVAMAT;

                IF (reLDCI_RESERVAMAT.CENTRO_COSTO IS null or reLDCI_RESERVAMAT.CENTRO_COSTO = '' or reLDCI_RESERVAMAT.CENTRO_COSTO = '-1') THEN
                  RAISE exce_ValidaCentroCosto;
                END IF;
                
            END IF;

            -- Si es una Reserva
            IF (isbOperacion = 'RES') THEN

                IF (isbCLASS_ASSESSMENT_ID = 'I') THEN
                    sbClasMov := CASE Flagherramienta WHEN 'N' THEN sbClasSolMat WHEN 'S' THEN sbClasSolHer ELSE sbClasSolMat END;
                ELSE
                    IF (isbCLASS_ASSESSMENT_ID = 'A') THEN
                        sbClasMov := CASE Flagherramienta WHEN 'N' THEN sbClasSolMatAct WHEN 'S' THEN sbClasSolHer ELSE sbClasSolMatAct END;
                    END IF;
                END IF;
            ELSE
                IF (isbCLASS_ASSESSMENT_ID = 'I') THEN
                    sbClasMov := CASE Flagherramienta WHEN 'N' THEN sbClasDevMat WHEN 'S' THEN sbClasDevHer ELSE sbClasDevMat END;
                ELSE
                    IF (isbCLASS_ASSESSMENT_ID = 'A') THEN
                        sbClasMov := CASE Flagherramienta WHEN 'N' THEN sbClasDevMatAct WHEN 'S' THEN sbClasDevHer ELSE sbClasDevMatAct END;
                    END IF;
                END IF;
            END IF;
    
            -- Genera el mensaje XML
            Qryctx :=  Dbms_Xmlgen.Newcontext ('SELECT ''' || sbClasMov || ''' As "ClasMov",
              Rs.UNIDAD_OPE As "AlmCont",
              substr(Ba.empresa || ''-'' || ''' || sbClasMov || ''' || ''-'' || Rs.RESERVA || ''/'' || Uo.OPERATING_UNIT_ID || '' '' || Uo.NAME,1,40) As "ResFront",
              decode(:flagHerramienta, ''N'', NULL, ''S'', Rs.Centro_Costo, NULL) "CenCosto",
              CURSOR (SELECT Dt.CODIGO_ITEM As "Material",
                                          trim(to_char(NVL(Dt.CANTIDAD,0),'||sbFormato||')) As "Cantidad",
                                          Dt.CENTRO "CentroSAP",
                                          case
                                             WHEN Dt.COSTO_ERP <= 0 THEN NULL
                                               ELSE  trim(to_char(NVL(Dt.COSTO_ERP, NULL),''9999999999990.99'')) END As "Costo",
                                               CURSOR(  SELECT ldci_pkreservamaterial.fsbgetobtultserial(s.serie)   AS "Serie"
                                                       ,ldci_pkreservamaterial.fsbGETobtmarcultserial(serie) AS "Marca"
                                                                                  FROM or_uni_item_bala_mov k,
                                                                                       ge_items_seriado s
                                                                                WHERE k.id_items_documento = dt.reserva
                                                                                  AND k.items_id           = dt.codigo_item
                                                                                  AND k.movement_type      = ''D''
                                                                                  AND k.id_items_seriado   = s.id_items_seriado
                                                                                  AND rs.clase_mov=''DEV'')  as "Seriales"
                                FROM LDCI_DET_RESERVAMAT Dt, ge_items i
                              WHERE Rs.RESERVA = Dt.RESERVA
                                AND Dt.item_id=i.items_id
                                  AND Dt.ES_HERRAMIENTA = ''' ||Flagherramienta || ''') As "Detalle"
            FROM LDCI_RESERVAMAT Rs, OR_OPERATING_UNIT Uo, BASE_ADMIN ba
            WHERE Rs.RESERVA = ' || to_char(reserva) ||
            'AND Rs.UNIDAD_OPE = Uo.OPERATING_UNIT_ID
            AND Ba.base_administrativa = Uo.admin_base_id');

             -- Asigna el valor de la variable :flagHerramienta
            DBMS_XMLGEN.setBindvalue (qryCtx, 'flagHerramienta', flagHerramienta);

            Dbms_Xmlgen.setRowSetTag(Qryctx, LDCI_PKRESERVAMATERIAL.sbInputMsgType);
            DBMS_XMLGEN.setRowTag(qryCtx, '');
            dbms_xmlgen.setConvertSpecialChars(qryCtx, FALSE);

            l_payload := dbms_xmlgen.getXML(qryCtx);
            l_payload := REPLACE(l_payload,'<NVL_x0028_OPEN.LDCI_PKRESERVAMATERIA>',NULL);
            l_payload := REPLACE(l_payload,'</NVL_x0028_OPEN.LDCI_PKRESERVAMATERIA>',NULL);
            l_payload := l_payload;

            L_Payload := REPLACE(L_Payload, '<Seriales_ROW>', '<Serial>');
            L_Payload := REPLACE(L_Payload, '</Seriales_ROW>', '</Serial>');
            L_Payload := REPLACE(L_Payload, '<Seriales>'||chr(10)||chr(32)||chr(32)||chr(32)||'</Seriales>', '');
            
            --Valida si proceso registros
            IF(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) THEN
                 RAISE excepNoProcesoRegi;
            END IF;

            dbms_xmlgen.closeContext(qryCtx);

            L_Payload := Replace(L_Payload, '<?xml version="1.0"?>');
            l_payload := replace(l_payload, '<Detalle>');
            l_payload := replace(l_payload, '</Detalle>');

            l_payload := replace(l_payload, '<Detalle_ROW>',  '<Detalle>');
            l_payload := replace(l_payload, '</Detalle_ROW>', '</Detalle>');
            L_Payload := Trim(L_Payload);
            pkg_Traza.Trace('[ln395] proEnviarSolicitud L_Payload: ' || chr(13) || L_Payload, csbNivelTraza);

            --Hace el consumo del servicio Web
            LDCI_PKSOAPAPI.Prosetprotocol(LDCI_PKRESERVAMATERIAL.Sbprotocol);

            l_response := LDCI_PKSOAPAPI.fsbSoapSegmentedCall(l_payload,
                                                            LDCI_PKRESERVAMATERIAL.sbUrlDesti,
                                                            LDCI_PKRESERVAMATERIAL.sbSoapActi,
                                                            LDCI_PKRESERVAMATERIAL.sbNameSpace);

            --Valida el proceso de peticion SOAP
            IF (LDCI_PKSOAPAPI.Boolsoaperror Or LDCI_PKSOAPAPI.Boolhttperror) THEN

                LDCI_PKMESAWS.PROCREAMENSENVIO( IDTMESAFECH       => SYSDATE,
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
                RAISE excepNoProcesoSOAP;
                
            ELSE

                LDCI_PKMESAWS.PROACTUESTAPROC(  INUPROCCODI     => inuProcCodi,
                                                IDTPROCFEFI     => sysdate,
                                                ISBPROCESTA     => 'F',
                                                ONUERRORCODE    => ONUERRORCODE,
                                                OSBERRORMESSAGE => OSBERRORMESSAGE);

                LDCI_PKMESAWS.PROCREAMENSENVIO( IDTMESAFECH       => SYSDATE,
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
            END IF;
            
        END IF;
        
        onuErrorCode := 0;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
    EXCEPTION
        WHEN exce_ValidaCentroCosto THEN
            onuErrorCode := -1;
            osbErrorMessage := '[LDCI_PKRESERVAMATERIAL.proEnviarSolicitud] La unidad operativa (' || to_char(reLDCI_RESERVAMAT.UNIDAD_OPE) || reLDCI_RESERVAMAT.NAME   || ') y Num Reserva ('||to_char(reLDCI_RESERVAMAT.RESERVA) ||') no tiene configurado el Centro de Costo o esta configurado en el Centro de Costo -1. (Forma GEMCUO)';
            Errors.seterror (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace('[691]' || osbErrorMessage,csbNivelTraza);
            commit;
            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(reserva), 'Valida configuración centro de costo por unidad operativa',  osbErrorMessage);

        WHEN excepNoProcesoRegi THEN
            osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proEnviarSolicitud]: La consulta no ha arrojo registros: ' || chr(13) || DBMS_UTILITY.format_error_backtrace;
            onuErrorCode:= -1;
            Errors.seterror (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace('[698]' || osbErrorMessage,csbNivelTraza);
            commit;

        WHEN excepNoProcesoSOAP THEN
            osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proEnviarSolicitud]: Ocurrio un error en procesamiento SOAP.' || Dbms_Utility.Format_Error_Backtrace;
            onuErrorCode:= -1;
            Errors.seterror (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace('[706]' || osbErrorMessage,csbNivelTraza);
            commit;
            
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace('[712]' || osbErrorMessage,csbNivelTraza);
            commit;            
    END proEnviarSolicitud;

    FUNCTION fnuObtenerClasificacionItem(Itemid Number, itemcode varchar2)
    RETURN Number As
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

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuObtenerClasificacionItem';
          
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
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
           
        -- carga item
        API_GET_ITEM(Itemid, itemcode, Oclxmlitemsdata, Onuerrorcode, Osberrormessage);
        
        IF Onuerrorcode = 0 THEN
            /* PROCESAR XML Y OBTENER CLASIFICACION*/
            doc     := DBMS_XMLDOM.newDOMDocument(Oclxmlitemsdata);
            ndoc    := DBMS_XMLDOM.makeNode(doc);

            Dbms_Xmldom.Writetobuffer(Ndoc, Buf);

            docelem := DBMS_XMLDOM.getDocumentElement(doc);

            -- Access element
            Nodelist  := Dbms_Xmldom.Getelementsbytagname(Docelem, 'ITEM_CLASS');
            Node      := Dbms_Xmldom.Item(Nodelist, 0);
            Childnode := Dbms_Xmldom.Getfirstchild(Node);
            resultado := to_number(Dbms_Xmldom.Getnodevalue(Childnode));
            
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        -- retorna clasificacion de item
        RETURN Resultado;
        
    EXCEPTION
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END fnuObtenerClasificacionItem;

    FUNCTION fnuExisteDocumento(Sbdocuemento Varchar2)
    RETURN Number IS
    
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuExisteDocumento';
            
        Resultado Number := -1;
        onuErrorCode      ge_error_log.Error_log_id%TYPE;
        osbErrorMessage   ge_error_log.description%TYPE;

        CURSOR Cudocumento IS
        SELECT *
        FROM Ldci_Reservamat
        WHERE Reserva = Sbdocuemento;

        recCudocumento Cudocumento%rowtype;
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        /*abrir CURSOR y valdar*/
        OPEN Cudocumento;
        FETCH Cudocumento INTO Reccudocumento;
        CLOSE Cudocumento;

        IF Reccudocumento.Reserva IS NOT NULL THEN
            Resultado := 0;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN resultado;
        
    EXCEPTION
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END fnuExisteDocumento;

    FUNCTION fnuExisteDocumentoitem(Sbdocuemento in Varchar2,
                                   sbCodItem    in VARCHAR2) RETURN Number IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuExisteDocumentoitem';
                                   
        Resultado Number := -1;
        onuErrorCode      ge_error_log.Error_log_id%TYPE;
        osbErrorMessage   ge_error_log.description%TYPE;
        
        -- CURSOR
        CURSOR Cudocumento IS
        SELECT *
        FROM LDCI_DET_RESERVAMAT WHERE Reserva = Sbdocuemento AND Codigo_Item = sbCodItem;
        recCudocumento Cudocumento%rowtype;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        /*abrir CURSOR y valdar*/
        OPEN Cudocumento;
        FETCH Cudocumento INTO Reccudocumento;
        CLOSE Cudocumento;

        IF Reccudocumento.Reserva IS NOT NULL THEN
            Resultado := 0;
        END IF;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
        RETURN Resultado;
        
    EXCEPTION
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END fnuExisteDocumentoitem;

    PROCEDURE proNotificaDevoluciones As
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

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnuExisteDocumentoitem';
        
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
        sbReferencia            LDCI_RESERVAMAT.RESERVA%TYPE;
        Nucosto                 Number;
        nuIduniopera            Number;
        nuDocumento           NUMBER;
        Nuclassitem             number;
        sbFlagHta               varchar2(1);
        nuDatos               number;
        sbCECOCODI            LDCI_CECOUNIOPER.CECOCODI%TYPE;
        nuCantMate            number;
        nuCantHerr            number;
        onuProcCodi           NUMBER;
        icbProcPara           CLOB;
        sbCLASS_ASSESSMENT_ID LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%TYPE;

        -- definicion de cursores
        -- CURSOR de las unidades operativas
        CURSOR Cuunidadesoper IS
            SELECT distinct Opeu.OPERATING_UNIT_ID  as PROVEEDOR_LOGISTICO,
                   Opeu.OPER_UNIT_CODE     as PROVEEDOR_CODE
           FROM GE_ITEMS_DOCUMENTO Docu, OR_OPERATING_UNIT Opeu
          WHERE Opeu.OPER_UNIT_CLASSIF_ID = 11
            AND Docu.DESTINO_OPER_UNI_ID = Opeu.OPERATING_UNIT_ID
            AND Docu.DOCUMENT_TYPE_ID = 105
            AND Docu.ID_ITEMS_DOCUMENTO not in (SELECT DOTRDOCU FROM LDCI_DOCUTRAN);

        recCuunidadesoper Cuunidadesoper%rowtype;

        -- CURSOR de los items en transito
        CURSOR cuTRANSIT_ITEM(clXML in CLOB) IS
                SELECT ITEMS.*
                    FROM XMLTable('/TRANSIT_ITEMS/ITEMS' PASSING XMLType(clXML)
                        COLUMNS row_num FOR ordinality,
                                "ITEM_CODE"       NUMBER PATH 'ITEM_CODE',
                                        "ITEM_ID"         NUMBER PATH 'ITEM_ID',
                                        "ITEM_CLASSIF_ID"  NUMBER PATH 'ITEM_CLASSIF_ID',
                                        "TRANSIT_QUANTITY" NUMBER PATH 'TRANSIT_QUANTITY',
                                        "VALUE"           NUMBER PATH 'VALUE',
                                        "DOCUMENT_ID"      NUMBER PATH 'DOCUMENT_ID',
                                        "ORIG_OPER_UNIT"   NUMBER PATH 'ORIG_OPER_UNIT',
                                        "TARG_OPER_UNIT"   NUMBER PATH 'TARG_OPER_UNIT') AS ITEMS;

        -- CURSOR del centro de costo
        CURSOR cuLDCI_CECOUNIOPER(inuID_ITEMS_DOCUMENTO GE_ITEMS_DOCUMENTO.ID_ITEMS_DOCUMENTO%TYPE) IS
        SELECT DOCU.OPERATING_UNIT_ID   as UNIDAD_OPERATIVA,
                    CECO.CECOCODI            as CENTRO_COSTO
              FROM GE_ITEMS_DOCUMENTO DOCU,
                        LDCI_CECOUNIOPER CECO
            WHERE Docu.ID_ITEMS_DOCUMENTO = inuID_ITEMS_DOCUMENTO
                AND CECO.OPERATING_UNIT_ID = DOCU.OPERATING_UNIT_ID
                ;

        --- CURSOR temporal
        CURSOR cuLDCI_RESERVAMAT(nuPROVEEDOR_LOG LDCI_RESERVAMAT.PROVEEDOR_LOG%TYPE) IS
        SELECT RESERVA
        FROM LDCI_RESERVAMAT
        WHERE PROVEEDOR_LOG = nuPROVEEDOR_LOG;

        -- excepciones
        exce_proEnviarSolicitud    EXCEPTION;
        exce_ValidaCentroCosto     EXCEPTION;
        exce_OS_GET_TRANSIT_ITEM   EXCEPTION;
        exce_ValidaClaseValoracion EXCEPTION;

        CURSOR cuCantHerrMateReservados( isbReserva VARCHAR2)
        IS
        SELECT sum(decode(i.item_classif_id,3,1,0)) herra, sum(decode(i.item_classif_id, 3,0,1)) mate
        FROM LDCI_DET_RESERVAMAT r, ge_items i
        WHERE r.reserva= isbReserva
        AND r.item_id=i.items_id;        
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        -- carga las variables requeridas para las solicitudes
        proCargaVarGlobal('WS_TRASLADO_MATERIALES');

        -- obtienes los items en transito;
        FOR Reccuunidadesoper In Cuunidadesoper LOOP
            pkg_Traza.Trace('[Reccuunidadesoper.PROVEEDOR_LOGISTICO]' || Reccuunidadesoper.PROVEEDOR_LOGISTICO,csbNivelTraza);

            Iclxmlsearchtransit := '<?xml version="1.0"?><SEARCH_TRANSIT_ITEM><OPERATING_UNIT>' || Reccuunidadesoper.PROVEEDOR_LOGISTICO ||'</OPERATING_UNIT></SEARCH_TRANSIT_ITEM>';

            API_GET_TRANSIT_ITEM(ICLXMLSEARCHTRANSIT, OCLXMLTRANSITITEMS, ONUERRORCODE, OSBERRORMESSAGE);
        
            IF Onuerrorcode = 0 THEN

                -- inicializa el control de las solicitudes mezcladas
                nuCantMate := 0;
                nuCantHerr := 0;
                sbReferencia := null;

                FOR reTRANSIT_ITEM in cuTRANSIT_ITEM(oclXmltransititems) LOOP

                    -- VALIDAR SI EXISTE REGISTRO
                    IF fnuExisteDocumento(to_char(reTRANSIT_ITEM.DOCUMENT_ID)) != 0 THEN

                        -- carga la informacion del centro de costo
                        OPEN cuLDCI_CECOUNIOPER(reTRANSIT_ITEM.DOCUMENT_ID);
                        FETCH cuLDCI_CECOUNIOPER INTO nuidUniopera, sbCECOCODI/*, sbCLASS_ASSESSMENT_ID caso ca 200-798*/ /*--#OYM_CEV_3429_1*/;
                        CLOSE cuLDCI_CECOUNIOPER;

                        --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
                        proValidaClaseValoraProvLogis(Reccuunidadesoper.PROVEEDOR_LOGISTICO,
                                                    sbCLASS_ASSESSMENT_ID,
                                                    onuErrorCode,
                                                    osbErrorMessage);
                                            
                        IF (onuErrorCode <> 0) THEN
                          nuDocumento  := reTRANSIT_ITEM.DOCUMENT_ID;
                          RAISE exce_ValidaClaseValoracion;
                        END IF;

                        IF (sbCECOCODI IS null or sbCECOCODI = '') THEN
                            nuDocumento  := reTRANSIT_ITEM.DOCUMENT_ID;
                            nuIduniopera := reTRANSIT_ITEM.TARG_OPER_UNIT;
                        END IF;

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
                        INSERT INTO LDCI_RESERVAMAT (RESERVA,
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
                    
                    END IF; -- IF fnuExisteDocumento(Sbreferencia) != 0 THEN

                    -- Valia que el documento no este en transito para no ser reenviado
                    IF ( LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(reTRANSIT_ITEM.DOCUMENT_ID) <> 'S') THEN
                        -- determina la cantidad de materiales / herrameintas en la solcitud
                        IF (reTRANSIT_ITEM.ITEM_CLASSIF_ID = 3) THEN
                            sbFlagHta := 'S';
                            nuCantHerr  := nuCantHerr + 1;
                        ELSE
                            nuCantMate  := nuCantMate + 1;
                        END IF;
                    END IF;

                    pkg_Traza.Trace('#NC-XXX [ln821] ---------------------------------------',csbNivelTraza);
                    pkg_Traza.Trace('#NC-XXX [ln822] nuCantMate: ' || nuCantMate,csbNivelTraza);
                    pkg_Traza.Trace('#NC-XXX [ln823] nuCantHerr: ' || nuCantHerr,csbNivelTraza);
                    pkg_Traza.Trace('#NC-XXX [ln823] DOCUMENT_ID: ' || reTRANSIT_ITEM.DOCUMENT_ID,csbNivelTraza);
                    pkg_Traza.Trace('#NC-XXX [ln823] ITEM_ID: ' || reTRANSIT_ITEM.ITEM_ID,csbNivelTraza);
                    pkg_Traza.Trace('#NC-XXX [ln823] fsbGetDocuTran: ' || LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(reTRANSIT_ITEM.DOCUMENT_ID),csbNivelTraza);
                    pkg_Traza.Trace('#NC-XXX [ln824] ---------------------------------------',csbNivelTraza);

                    IF fnuExisteDocumentoitem(to_char(reTRANSIT_ITEM.DOCUMENT_ID), to_char(reTRANSIT_ITEM.ITEM_CODE))  != 0 THEN
                        /* CREAR DETALLE */
                        INSERT INTO LDCI_DET_RESERVAMAT ( RESERVA,
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
                    ELSE
                    
                        -- si el item es seriado incrementa la cantidad segun el numero de items a devolver
                        IF (reTRANSIT_ITEM.ITEM_CLASSIF_ID = 21) THEN
                            pkg_Traza.Trace('----------------------------------------------------------------------------------',csbNivelTraza);
                            pkg_Traza.Trace('[reTRANSIT_ITEM.ITEM_CODE]' || reTRANSIT_ITEM.ITEM_CODE,csbNivelTraza);
                            pkg_Traza.Trace('[reTRANSIT_ITEM.ITEM_CLASSIF_ID]' || reTRANSIT_ITEM.ITEM_CLASSIF_ID,csbNivelTraza);
                            pkg_Traza.Trace('[reTRANSIT_ITEM.TRANSIT_QUANTITY]' || reTRANSIT_ITEM.TRANSIT_QUANTITY,csbNivelTraza);
                            pkg_Traza.Trace('[reTRANSIT_ITEM.VALUE]' || reTRANSIT_ITEM.VALUE,csbNivelTraza);

                            -- realiza le update a la tabla LDCI_DET_RESERVAMAT
                            update LDCI_DET_RESERVAMAT set CANTIDAD  = CANTIDAD  + reTRANSIT_ITEM.TRANSIT_QUANTITY,
                             COSTO_OS  = COSTO_OS  + reTRANSIT_ITEM.VALUE,
                            COSTO_ERP = COSTO_ERP + reTRANSIT_ITEM.VALUE
                            WHERE RESERVA = reTRANSIT_ITEM.DOCUMENT_ID
                            AND ITEM_ID = reTRANSIT_ITEM.ITEM_CODE;
                        END IF;
                    END IF;
                END LOOP;

                FOR reLDCI_RESERVAMAT in cuLDCI_RESERVAMAT(Reccuunidadesoper.PROVEEDOR_LOGISTICO) LOOP

                    BEGIN

                        IF sbValidaHerr = 'S' THEN

                            OPEN cuCantHerrMateReservados(reLDCI_RESERVAMAT.RESERVA);
                            FETCH cuCantHerrMateReservados INTO nuCantHerr,  nuCantMate;
                            CLOSE cuCantHerrMateReservados;
                            
                        END IF;

                        IF (LDCI_PKRESERVAMATERIAL.fsbGetDocuTran(to_number(reLDCI_RESERVAMAT.RESERVA)) <> 'S') THEN
                            -- valia si la solicitud tiene mezcla de materiales y herramientas
                            IF (nuCantMate <> 0 AND nuCantHerr <> 0) THEN
                                -- solicitud de herramientas
                                proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'S', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                                IF Onuerrorcode <> 0 THEN
                                    RAISE exce_proEnviarSolicitud;
                                END IF;

                                -- solicitud de materiales
                                proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'N', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                                IF Onuerrorcode <> 0 THEN
                                    RAISE exce_proEnviarSolicitud;
                                END IF;
                            
                            END IF;

                            -- solicitud de solo materiales
                            IF (nuCantMate <> 0 AND nuCantHerr = 0) THEN
                                -- solicitud de materiales
                                proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'N', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                                IF Onuerrorcode <> 0 THEN
                                    RAISE exce_proEnviarSolicitud;
                                END IF;
                            END IF;

                            -- solicitud de solo herramientas
                            IF (nuCantMate = 0 AND nuCantHerr <> 0) THEN
                                -- solicitud de herramientas
                                proEnviarSolicitud(reLDCI_RESERVAMAT.RESERVA, 'DEV', 'S', onuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);
                                IF Onuerrorcode <> 0 THEN
                                    RAISE exce_proEnviarSolicitud;
                                END IF;
                            END IF;

                            -- crea el documento en transito
                            LDCI_PKRESERVAMATERIAL.proCreaDocuTran(to_number(reLDCI_RESERVAMAT.RESERVA), onuErrorCode, osbErrorMessage);

                            IF Onuerrorcode = 0 THEN
                                commit;
                            ELSE
                                RAISE exce_proEnviarSolicitud;
                            END IF;
                        
                        ELSE
                            commit;
                        END IF;
                        
                    EXCEPTION
                        WHEN exce_proEnviarSolicitud THEN
                            pkg_Traza.Trace('[1174 exce_proEnviarSolicitud]' || osbErrorMessage,csbNivelTraza);
                            Errors.seterror (onuErrorCode, osbErrorMessage);
                            commit;
                        WHEN exce_ValidaClaseValoracion THEN
                            onuErrorCode := -1;
                            pkg_Traza.Trace('[1174 exce_ValidaClaseValoracion]' || osbErrorMessage,csbNivelTraza);
                            Errors.seterror (onuErrorCode, osbErrorMessage);
                            commit;
                            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida clase de valoracion (Valoracion Separada)',  osbErrorMessage);

                        WHEN exce_ValidaCentroCosto THEN
                            pkg_Traza.Trace('[1174 exce_ValidaCentroCosto]' || osbErrorMessage,csbNivelTraza);
                            onuErrorCode := -1;
                            osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa (' || to_char(nuIduniopera)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
                            Errors.seterror (onuErrorCode, osbErrorMessage);
                            commit;
                            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida configuración centro de costo por unidad operativa',  osbErrorMessage);

                        WHEN OTHERS THEN
                            pkg_Error.setError;
                            pkg_Error.getError (onuErrorCode, osbErrorMessage);
                            commit;
                    END;

                END LOOP;

            ELSE
                RAISE exce_OS_GET_TRANSIT_ITEM;
            END IF;
        
        END LOOP;

        DELETE FROM LDCI_DET_RESERVAMAT;
        DELETE FROM LDCI_RESERVAMAT;
        commit;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
           
    EXCEPTION
        WHEN exce_proEnviarSolicitud THEN
            pkg_Traza.Trace('[1174 exce_proEnviarSolicitud]' || osbErrorMessage,csbNivelTraza);
            Errors.seterror (onuErrorCode, osbErrorMessage);
            commit;

        WHEN exce_ValidaClaseValoracion THEN
           onuErrorCode := -1;
           pkg_Traza.Trace('[1174 exce_ValidaClaseValoracion]' || osbErrorMessage,csbNivelTraza);
           Errors.seterror (onuErrorCode, osbErrorMessage);
           commit;
           LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida clase de valoracion (Valoracion Separada)',  osbErrorMessage);

        WHEN exce_ValidaCentroCosto THEN
            pkg_Traza.Trace('[1174 exce_ValidaCentroCosto]' || osbErrorMessage,csbNivelTraza);
            onuErrorCode := -1;
            osbErrorMessage := '[proNotificaDevoluciones] La unidad operativa (' || to_char(nuIduniopera)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
            Errors.seterror (onuErrorCode, osbErrorMessage);
            commit;
            LDCI_PKRESERVAMATERIAL.proNotificaExepcion(nuDocumento, 'Valida configuración centro de costo por unidad operativa',  osbErrorMessage);

        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
            pkg_Traza.Trace('[1190_SQLERRM]' || SQLERRM,csbNivelTraza);
    END proNotificaDevoluciones;

    PROCEDURE proConfirmarReserva(Reserva       in  VARCHAR2,
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

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proConfirmarReserva';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);
              
        -- define variables
        L_Payload     clob;
        Qryctx        Dbms_Xmlgen.Ctxhandle;
        Sberrmens Varchar2(500);
        
        -- excepciones
        Excepnoprocesoregi  EXCEPTION;   -- Excepcion que valida si proceso registros la consulta
        exce_OS_SET_REQUEST_CONF EXCEPTION;
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        -- inicializa la variable de retorno
        onuErrorCode := 0;

        -- Genera el mensaje XML
        Qryctx :=  Dbms_Xmlgen.Newcontext ('SELECT RS.RESERVA    As "DOCUMENT_ID",
                                                                                            RS.UNIDAD_OPE As "OPERATING_UNIT_ID",
                                                                                            CURRENT_DATE as "DELIVERYDATE",
                                                                          CURSOR (SELECT /*DT.ITEM_ID #NC:1534 1535 1536*/ ITEM.CODE as "ITEM_CODE",
                                                                                                        DT.CANTIDAD As "QUANTITY",
                                                                                                        DT.COSTO_OS as "COST"
                                                                                          FROM LDCI_DET_RESERVAMAT Dt, GE_ITEMS ITEM
                                                                                          WHERE RS.RESERVA = DT.RESERVA
                                                                                            AND DT.ITEM_ID = ITEM.ITEMS_ID /*#NC:1534 1535 1536*/ ) As "ITEMS"
                                                                          FROM LDCI_RESERVAMAT Rs
                                                                          WHERE RS.RESERVA = ' || reserva );

        Dbms_Xmlgen.Setrowsettag(Qryctx, 'REQUEST_CONF');
        --DBMS_XMLGEN.setRowTag(qryCtx, '');
        Dbms_Xmlgen.setNullHandling(qryCtx, 0);

        l_payload := dbms_xmlgen.getXML(qryCtx);

        --Valida si proceso registros
        IF(DBMS_XMLGEN.getNumRowsProcessed(qryCtx) = 0) THEN
             RAISE excepNoProcesoRegi;
        END IF;

        dbms_xmlgen.closeContext(qryCtx);

        L_Payload := Replace(L_Payload, '<ROW>', '<DOCUMENT>');
        L_Payload := Replace(L_Payload, '</DELIVERYDATE>', '</DELIVERYDATE>' ||chr(13) || '</DOCUMENT>');
        L_Payload := Replace(L_Payload, '</ROW>','');

        l_payload := replace(l_payload, '<ITEMS_ROW>',  '<ITEM>');
        l_payload := replace(l_payload, '</ITEMS_ROW>', '</ITEM>');
        L_Payload := Trim(L_Payload);

        -- hace el llamado al API
        API_SET_REQUEST_CONF(L_Payload, onuErrorCode , osbErrorMessage);
        pkg_Traza.Trace('[1186.proConfirmarReserva.API_SET_REQUEST_CONF << L_Payload] ' || chr(13) || L_Payload, csbNivelTraza);
        pkg_Traza.Trace('[1186.proConfirmarReserva.API_SET_REQUEST_CONF >> onuErrorCode] ' || onuErrorCode, csbNivelTraza);
        pkg_Traza.Trace('[1186.proConfirmarReserva.API_SET_REQUEST_CONF >> osbErrorMessage] ' || osbErrorMessage, csbNivelTraza);

        IF (onuErrorCode <> 0) THEN
            RAISE exce_OS_SET_REQUEST_CONF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN exce_OS_SET_REQUEST_CONF THEN
            Errors.seterror (onuErrorCode, osbErrorMessage);
            commit;

        WHEN excepNoProcesoRegi THEN
            onuErrorCode := -1;
            osbErrorMessage := 'ERROR: [LDCI_PKRESERVAMATERIAL.proConfirmarReserva]: La consulta no ha arrojo registros' || Dbms_Utility.Format_Error_Backtrace;
            Errors.seterror (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << osbErrorMessage1] ' || chr(13) || osbErrorMessage,csbNivelTraza);
            commit;
            
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            pkg_Traza.Trace('[1186.proConfirmarReserva.OS_SET_REQUEST_CONF << osbErrorMessage2] ' || chr(13) || osbErrorMessage, csbNivelTraza);
            commit;
    END proConfirmarReserva;

    PROCEDURE proProcesaReserva
    (
        Items_Documento_Id  in VARCHAR2,
        inuProcCodi         in NUMBER,
        onuErrorCode        out GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        osbErrorMessage     out GE_ERROR_LOG.DESCRIPTION%TYPE
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
        carlos.virgen <carlos.virgen@olsoftware.com>  20-08-2014 #NC:1456,1457,1458: Mejora Validación del centro de costo, solicitud de herramienta
        carlos.virgen<carlos.virgen@olsoftware.com>   13-11-2014 #OYM_CEV_5028_1: #ifrs #471: Se desactiva la version inicial de la clase de valoracion.
        oparra                                        02-03-2017 CA. 200-638 -  Requisiciones automáticas
        */
        
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proProcesaReserva';

        Osbrequest Varchar2(32000);
        Nuoperunitid Number;
        Nuerpoperunitid Number;

        Docitem       Dbms_Xmldom.Domdocument;
        Ndocitem      Dbms_Xmldom.Domnode;
        Docelemitem   Dbms_Xmldom.Domelement;
        Nodeitem      Dbms_Xmldom.Domnode;

        nuJob_id        number;
        nuUser_id       number;
        nuUnidadOper    number;

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

        sbOPER_UNIT_CODE OR_OPERATING_UNIT.OPER_UNIT_CODE%TYPE;
        sbCECOCODI       LDCI_CECOUNIOPER.CECOCODI%TYPE;
        sbCLASS_ASSESSMENT_ID LDCI_CLVAUNOP.CLASS_ASSESSMENT_ID%TYPE; --#OYM_CEV_3429_1

        -- CURSOR de la unidad operativa
        CURSOR cuUnidadOperativa(inuOPERATING_UNIT_ID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE) IS
          SELECT OPER_UNIT_CODE
            FROM OR_OPERATING_UNIT
            WHERE OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

        -- CURSOR del centro de costo
        CURSOR cuLDCI_CECOUNIOPER(isbCECOCODI LDCI_CECOUNIOPER.CECOCODI%TYPE) IS
        SELECT CECOCODI
                FROM LDCI_CECOUNIOPER
              WHERE OPERATING_UNIT_ID = isbCECOCODI;

        --#OYM_CEV_3429_1: CURSOR de la clase de valoracion por unidad operativa
        CURSOR cuLDCI_CLVAUNOP(inuOPERATING_UNIT_ID LDCI_CLVAUNOP.OPERATING_UNIT_ID%TYPE) IS  --#OYM_CEV_3429_1
        SELECT CLASS_ASSESSMENT_ID
          FROM LDCI_CLVAUNOP
         WHERE OPERATING_UNIT_ID = inuOPERATING_UNIT_ID;

        exce_proEnviarSolicitud    EXCEPTION;
        exce_proConfirmarReserva   EXCEPTION;
        exce_OS_GET_REQUEST        EXCEPTION;
        exce_ValidaCentroCosto     EXCEPTION;
        exce_ValidaClaseValoracion EXCEPTION;    --#OYM_CEV_3429_1

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
        
        -- CA. 200-638: obetener valor parametro
        nuJob_id    := pkg_BCLd_Parameter.fnuObtieneValorNumerico('LDC_ID_USARIOJOB');

        -- inicializa variable de salida
        onuErrorcode := 0;
        -- llamado original al API de OPEN
        API_GET_REQUEST(to_number(Items_Documento_Id), Osbrequest,
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
          OPEN cuUnidadOperativa(nuerpoperunitid);
          FETCH cuUnidadOperativa INTO sbOPER_UNIT_CODE;
          CLOSE cuUnidadOperativa;

          -- carga la informacion del centro de costo
          OPEN cuLDCI_CECOUNIOPER(Nuoperunitid);
          FETCH cuLDCI_CECOUNIOPER INTO sbCECOCODI;
          CLOSE cuLDCI_CECOUNIOPER;

          Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'DATE');
          Nodedummy := Dbms_Xmldom.Item(Nodelistitem, 0);

          --#OYM_CEV_5028_1: Determina si el proveedor logistico es Activos o Inventarios
          proValidaClaseValoraProvLogis(nuERPOperUnitId,
                                        sbCLASS_ASSESSMENT_ID,
                                        onuErrorCode,
                                        osbErrorMessage);
          IF (onuErrorCode <> 0) THEN
              RAISE exce_ValidaClaseValoracion;
          END IF; --IF (onuErrorCode <> 0) THEN

            /*GUARDAR CABECERA DE LA RESERVA*/
          INSERT INTO LDCI_RESERVAMAT (RESERVA, UNIDAD_OPE, ALMACEN_CON, CLASE_MOV, CENTRO_COSTO, FECHA_ENTREGA)
                 values (Items_Documento_Id, Nuoperunitid, nuerpoperunitid, 'PRU', sbCECOCODI, CURRENT_DATE);

          Nodelistitem := Dbms_Xmldom.Getelementsbytagname(Docelemitem, 'ITEM');
          nuCantMate := 0;
          nuCantHerr := 0;
                            -- recorre los items
          FOR Contadoritem In 1..Dbms_Xmldom.Getlength(Nodelistitem) LOOP
                Nodeitem := Dbms_Xmldom.Item(Nodelistitem, Contadoritem - 1);
                /*OBTENGO ELMENTOS DE ITEM*/
                Nodelisteleitem := Dbms_Xmldom.Getchildnodes(Nodeitem);


                Nodedummy := Dbms_Xmldom.Item(Nodelisteleitem, 0);
                nuitemid  := to_number(Dbms_Xmldom.Getnodevalue(Dbms_Xmldom.Getfirstchild(nodedummy)));

                /* para saber si es una herramienta la clasificacion del item es 3 */
                Nuclassitem := fnuObtenerClasificacionItem(Nuitemid, null);

                IF Nuclassitem = 3 THEN
                    /* ES UNA HERRAMIENTA*/
                    Sbflaghta := 'S';
                    nuCantHerr := nuCantHerr + 1;
                ELSE
                      nuCantMate := nuCantMate + 1;
                END IF; -- IF Nuclassitem = 3 THEN

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

                IF (nuUser_id = nuJob_id) THEN

                    IF (fblValidExistItem(nuitemid,nuUnidadOper)) THEN

                        INSERT INTO LDCI_DET_RESERVAMAT (Reserva, Item_Id, Codigo_Item, Cantidad, Costo_Os, Costo_Erp, Centro, Es_Herramienta)
                        values (Items_Documento_Id, nuitemid, sbitemcode, nuitemcant, nuitemcosto, null, sbOPER_UNIT_CODE, decode(Nuclassitem, 3, 'S', 'N'));

                        -- actualizar cupo en la tabla de pedidos
                        update ge_items_request
                        set confirmed_amount = 0,
                            confirmed_cost = 0
                        WHERE items_id = nuitemid
                        AND id_items_documento = Items_Documento_Id;

                    END IF;

                ELSE
                /** Fin validacion CA 200-638  **/

                    INSERT INTO LDCI_DET_RESERVAMAT (Reserva, Item_Id, Codigo_Item, Cantidad, Costo_Os, Costo_Erp, Centro, Es_Herramienta)
                    values (Items_Documento_Id, nuitemid, sbitemcode, nuitemcant, nuitemcosto, null, sbOPER_UNIT_CODE, decode(Nuclassitem, 3, 'S', 'N'));

                END IF;

          END LOOP;--FOR Contadoritem In 1..Dbms_Xmldom.Getlength(Nodelistitem) LOOP
          DBMS_XMLDOM.freeDocument(docitem);

          IF Onuerrorcode = 0 THEN
                -- valida si la solicitud tiene mezcla de materiales y herramientas
                IF (nuCantMate <> 0 AND nuCantHerr <> 0) THEN
                        -- solicitud de herramintas
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'S', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
                        IF (Onuerrorcode) <> 0 THEN
                              RAISE exce_proEnviarSolicitud;
                        END IF;
                        
                        -- solicitu de materiales
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'N', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
                        IF (Onuerrorcode) <> 0 THEN
                              RAISE exce_proEnviarSolicitud;
                        END IF;
                END IF;

                -- solicitud de solo materiales
                IF (nuCantMate <> 0 AND nuCantHerr = 0) THEN
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'N', inuProcCodi, sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/, Onuerrorcode, Osberrormessage);
                        IF (Onuerrorcode) <> 0 THEN
                              RAISE exce_proEnviarSolicitud;
                        END IF;
                END IF;

                -- solicitud de solo herramientas
                IF (nuCantMate = 0 AND nuCantHerr <> 0) THEN
                        proEnviarSolicitud(Items_Documento_Id, 'RES', 'S', inuProcCodi , sbCLASS_ASSESSMENT_ID /*#OYM_CEV_3429_1*/,Onuerrorcode, Osberrormessage);

                        IF (Onuerrorcode) <> 0 THEN
                              RAISE exce_proEnviarSolicitud;
                        END IF;
                END IF;

                IF (Onuerrorcode) = 0 THEN
                      -- hace la confirmacion de la solicitud llamado al API OS_SET_REQUEST_CONF
                      proConfirmarReserva(Items_Documento_Id, inuProcCodi, Onuerrorcode, Osberrormessage);
                      IF (Onuerrorcode) = 0 THEN
                        commit;
                      ELSE
                        -- guarda la excepcion
                        RAISE exce_proConfirmarReserva ;
                      END IF;
                ELSE
                      -- guarda la excepcion
                      RAISE exce_proEnviarSolicitud;
                END IF;
         ELSE
                -- guarda la excepcion
                RAISE exce_OS_GET_REQUEST;
         END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
    EXCEPTION
        WHEN exce_proConfirmarReserva THEN
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit;

        WHEN exce_proEnviarSolicitud THEN
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit;

        WHEN exce_OS_GET_REQUEST THEN
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit;

        WHEN exce_ValidaClaseValoracion THEN
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit;
          LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(Items_Documento_Id), 'Valida configuración centro de costo por unidad operativa',  osbErrorMessage);

        WHEN exce_ValidaCentroCosto THEN
           onuErrorCode := -1;
           osbErrorMessage := '[proNotificaReservas] La unidad operativa (' || to_char(Nuoperunitid)   || ') no tiene configurado el Centro de Costo. (Forma GEMCUO)';
          Errors.seterror (onuErrorCode, osbErrorMessage);
          commit;
          LDCI_PKRESERVAMATERIAL.proNotificaExepcion(to_number(Items_Documento_Id), 'Valida configuración centro de costo por unidad operativa',  osbErrorMessage);

        WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError (onuErrorCode, osbErrorMessage);
          commit;
    END proProcesaReserva;

    PROCEDURE proNotificaReservas As
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
    Eduardo Aguera  02/07/2015  Cambio 8136. Se optimiza consulta de XML utilizando CURSOR con XMLTable para obtener las solicitudes.
    */

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proNotificaReservas';
            
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
        -- CURSOR de las unidades operativas
        CURSOR cuUnidadOperativa IS
                SELECT OPERATING_UNIT_ID, OPER_UNIT_CODE
                    FROM OR_OPERATING_UNIT
                    WHERE OPER_UNIT_CLASSIF_ID = 11;

        reUnidadOperativa cuUnidadOperativa%rowtype;

        -- CURSOR de las solicitudes
        CURSOR cuREQUEST_REG(clXML in CLOB) IS
          SELECT REQUEST.*
          FROM XMLTable('/REQUESTS_REG/ITEMS_DOCUMENTO_ID' PASSING XMLType(clXML)
                        COLUMNS
                        ITEMS_DOCUMENTO_ID NUMBER PATH '.'
                       ) AS REQUEST;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        -- carga las variables requeridas para las solicitudes
        proCargaVarGlobal('WS_RESERVA_MATERIALES');

        -- recorre las unidades operativas de tipo 17 - CUARDILLA
        FOR reUnidadOperativa in cuUnidadOperativa LOOP
        
            -- carga las solicitudes
            API_GET_REQUESTS_REG(reUnidadOperativa.OPERATING_UNIT_ID,
                                OSBREQUESTSREGS,
                                ONUERRORCODE,
                                OSBERRORMESSAGE);
         
            -- recorre el listado de las reservas pendientes
            FOR reREQUEST_REG in cuREQUEST_REG(OSBREQUESTSREGS) LOOP

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
            END LOOP;-- FOR Contador In 1..Dbms_Xmldom.Getlength(Nodelist) LOOP

        END LOOP; -- FOR reUnidadOperativa in cuUnidadOperativa LOOP

        -- elimina los registros de la tabla de procesamiento
        DELETE FROM LDCI_DET_RESERVAMAT;
        DELETE FROM LDCI_RESERVAMAT;
        commit;
     
        -- libera el archivo XML
        DBMS_XMLDOM.freeDocument(doc);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
            
    EXCEPTION
        WHEN OTHERS  THEN
            pkg_Error.setError;
            pkg_Error.getError (onuErrorCode, osbErrorMessage);
            commit;
    END proNotificaReservas;

    PROCEDURE proNotificaDocumentosERP As
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

    Autor        Fecha       Caso       Descripcion.
    dsaltarin   01/04/2022   OSF-200    Se carga variable global sbAplicaOSF200 
                                        para validar si la entrega aplicar 
                                        para la gasera.
    jpinedc     16/04/2025   OSF-4245   Se quita referencias a sbAplicaOSF200 ya 
                                        que OSF-200 aplica para GdC
    */
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proNotificaDocumentosERP';
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);  
            
        LDCI_PKRESERVAMATERIAL.proNotificaReservas;
        LDCI_PKRESERVAMATERIAL.proNotificaDevoluciones;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);  
                    
    END proNotificaDocumentosERP;
  
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbGETobtultserial';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);   
        
        sbvaserie    ge_items_seriado.serie%TYPE;
        sbvaseriesap ldci_seridmit.seriestr%TYPE;

        CURSOR cuSerieSAP
        IS
        SELECT serie_sap
        FROM
        (
            SELECT t.serimmit,t.serinume,t.seriestr serie_sap,m.mmitfecr
            FROM ldci_seridmit t,ldci_intemmit m
            WHERE t.serinume = sbvaserie
            AND t.serimmit = m.mmitcodi
            ORDER BY m.mmitfecr DESC
        )
        WHERE ROWNUM = 1;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        sbvaserie := TRIM(sbseri);
        
        OPEN cuSerieSAP;
        FETCH cuSerieSAP INTO sbvaseriesap;
        CLOSE cuSerieSAP;
        
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
        
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbGETobtmarcultserial';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
    
        sbvaserie       ge_items_seriado.serie%TYPE;
        sbvasbmarcadesc ldci_marca.marcdesc%TYPE;
        
        CURSOR cuDescMarca
        IS
        SELECT (SELECT mc.marcdesc FROM ldci_marca mc WHERE mc.marccodi = marca_)
        FROM
        (
            SELECT marca_
            FROM
            (
                SELECT t.serimmit,t.serinume,t.serimarc marca_,t.seriestr serie_sap,m.mmitfecr
                FROM ldci_seridmit t,ldci_intemmit m
                WHERE t.serinume = sbvaserie
                AND t.serimmit = m.mmitcodi
                ORDER BY m.mmitfecr DESC
            )
            WHERE rownum = 1
        ) ;
        
    BEGIN
    
        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
            
        sbvaserie := TRIM(sbseri);
        
        OPEN cuDescMarca;
        FETCH cuDescMarca INTO sbvasbmarcadesc;
        CLOSE cuDescMarca;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
          
        RETURN sbvasbmarcadesc;
    
    EXCEPTION
        WHEN OTHERS THEN
            sbvasbmarcadesc := 'NULO';
            RETURN sbvasbmarcadesc;
    END fsbGETobtmarcultserial;

    FUNCTION fsbGETxmlserializados(sboperacion VARCHAR2,nucodumento NUMBER,nuitemspa NUMBER) RETURN VARCHAR2 AS
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
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fsbGETxmlserializados';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);  
        
        qryCtx     dbms_xmlgen.ctxhandle;
        L_Payload  CLOB;
        rfConsulta CONSTANTS_PER.TYREFCURSOR;
        l_offset   NUMBER DEFAULT 1;
        nuconta    NUMBER(15) DEFAULT 0;
        
        CURSOR cuCantMovDecrPorDocumento
        IS
        SELECT COUNT(1)
        FROM(
         SELECT ldci_pkreservamaterial.fsbgetobtultserial(s.serie)   AS "Serie"
               ,ldci_pkreservamaterial.fsbGETobtmarcultserial(serie) AS "Marca"
           FROM or_uni_item_bala_mov  k
               ,ge_items_seriado s
          WHERE k.id_items_documento = nucodumento
            AND k.items_id           = nuitemspa
            AND k.movement_type      = 'D'
            AND k.id_items_seriado   = s.id_items_seriado
        )
        WHERE "Serie" <> 'NULO' AND "Marca" <> 'NULO';        
        
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        L_Payload := NULL;
                        
        IF sboperacion = 'DEV' THEN
        
            nuconta := 0;
            
            OPEN cuCantMovDecrPorDocumento;
            FETCH cuCantMovDecrPorDocumento INTO nuconta;
            CLOSE cuCantMovDecrPorDocumento;
                                    
            IF nuconta >= 1 THEN
            
                OPEN rfConsulta FOR
                SELECT ldci_pkreservamaterial.fsbgetobtultserial(s.serie)   AS "Serie"
                ,ldci_pkreservamaterial.fsbGETobtmarcultserial(serie) AS "Marca"
                FROM or_uni_item_bala_mov  k
                ,ge_items_seriado s
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
                
            END IF;
            
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
                
        RETURN L_Payload;
        
    END fsbGETxmlserializados;
    
END LDCI_PKRESERVAMATERIAL;
/

