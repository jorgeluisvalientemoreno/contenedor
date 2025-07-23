CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOACOTESDO
IS
/***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : PKG_BOACOTESDO
  Descripcion     : Paquete de gestion para PB ACODESCO

  Autor           : Jhon Jairo Soto
  Fecha           : 07-11-2024

  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  =========================================================
  Autor       Fecha       Caso       Descripcion
  
***************************************************************************/

  --------------------------------------------
  -- Funciones y Procedimientos
  --------------------------------------------

  FUNCTION fsbVersion
  RETURN VARCHAR2;


  /*****************************************************************
  Propiedad intelectual de Gases del Caribe (c).

  Unidad         : prcProcesaAcotesdo
  Descripcion    : Proceso para actualizar las ordenes por estado de documentos.
  Autor          : Jhon Jairo Soto
  Fecha          : 07/11/2024

  Parametros de entrada
  inuOrderId	 		Id de la orden
  isbNuevoEstado 	Estado de la orden
  Fecha             Autor                Modificacion
  =========       =========             ====================

  ******************************************************************/
  PROCEDURE prcProcesaAcotesdo	(	
                                inuOrderId	 		  IN or_order.order_id%TYPE,
                                isbNuevoEstado 	  IN ldc_docuorder.status_docu%TYPE
                                );
  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : frcConsultaDocumentosOT
  Descripcion     : Función para consultar las órdenes por estado de documentos.

  Autor           : Jhon Jairo Soto
  Fecha           : 07-11-2024

  Parametros de Entrada
  inuOrderId	 		Codigo de la orden
  isbNuevoEstado 	Nuevo estado para pasar los documentos

  Parametros de Salida

  Modificaciones  :
  =========================================================
  Autor       Fecha       Caso       Descripcion

  ***************************************************************************/
  FUNCTION frcConsultaDocumentosOT (
                                inuUnidadOperativa  IN NUMBER,
                                isbEstadoDocu       IN VARCHAR2,
                                idtFechaInicial     IN DATE,
                                idtFechaFinal       IN DATE,
                                inuTipoTrabajo      IN NUMBER
                              )
  RETURN constants_per.tyRefCursor;

END PKG_BOACOTESDO;
/

CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOACOTESDO 
IS
/***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : PKG_BOACOTESDO
  Descripcion     : Paquete gestion PB ACOTESDO

  Autor           : Jhon Jairo Soto
  Fecha           : 07-11-2024

  Parametros de Entrada
  
  Parametros de Salida
  
  Modificaciones  :
  =========================================================
  Autor       Fecha       Caso       Descripcion
  
***************************************************************************/

  --------------------------------------------
  -- Constantes 
  --------------------------------------------


  csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3576';
  csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
  cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
  csbInicio   		    CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;
  cnuGeneric_Error 	  CONSTANT NUMBER := 2741;
  
  -----------------------------------
  -- Variables privadas del package
  -----------------------------------    
  nuError		 		      NUMBER;  
  sbError	 			      VARCHAR2(2000);

  FUNCTION fsbVersion
  RETURN VARCHAR2
  IS
  BEGIN
      RETURN CSBVERSION;
  END fsbVersion;


  FUNCTION frcConsultaDocumentosOT (
                                inuUnidadOperativa  IN NUMBER,
                                isbEstadoDocu       IN VARCHAR2,
                                idtFechaInicial     IN DATE,
                                idtFechaFinal       IN DATE,
                                inuTipoTrabajo      IN NUMBER
                              )
  RETURN constants_per.tyRefCursor IS

  --Variables Usadas Durante el Proceso
  csbMT_NAME      	    VARCHAR2(70) := csbSP_NAME || 'frcConsultaDocumentosOT';
  rfCursor              constants_per.tyRefCursor;
  nuError		 	          NUMBER;  
  sbError	 		          VARCHAR2(1000);


  BEGIN

  pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

  rfCursor := pkg_bcacotesdo.frcconsultadinamica (inuUnidadOperativa,
                                                  isbEstadoDocu,
                                                  idtFechaInicial,
                                                  idtFechaFinal,
                                                  inuTipoTrabajo);

  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  -- Retornamos el Cursor
  RETURN rfCursor;

  EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    RAISE pkg_Error.Controlled_Error;
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbError);
    pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    RAISE pkg_Error.Controlled_Error;
  END frcConsultaDocumentosOT;


  /*****************************************************************
  Propiedad intelectual de Gases del Caribe (c).

  Unidad         : prcProcesaAcotesdo
  Descripcion    : Proceso para actualizar las ordenes por estado de documentos.
  Autor          : Jhon Jairo Soto
  Fecha          : 07/11/2024

  Parametros de entrada
  inuOrderId	 		Código de la orden
  isbNuevoEstado 	Nuevo estado para documentos

  Fecha             Autor                Modificacion
  =========       =========             ====================

  ******************************************************************/
  PROCEDURE prcProcesaAcotesdo	(	
                                  inuOrderId	 		IN or_order.order_id%TYPE,
                                  isbNuevoEstado 	IN ldc_docuorder.status_docu%TYPE
                                )
  IS

    csbMT_NAME  	VARCHAR2(200) := csbSP_NAME || 'prcProcesaAcotesdo';

        --Variables Generales
    cnuNull_Attribute 	  CONSTANT NUMBER := 2126;
    sbUser                ldc_audocuorder.usuario%TYPE;
    sbTerminal            ldc_audocuorder.terminal%TYPE;
    nuUser                sa_user.user_id%TYPE;
    sbEstadoAnt           ldc_docuorder.status_docu%TYPE;
    nuError		 		        NUMBER;  
    sbMensaje	 		        VARCHAR2(2000);
  BEGIN

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

    nuUser := 	pkg_Session.getUserId;
    pkg_traza.trace('nuUser: ' || nuUser );

    sbTerminal := pkg_Session.fsbgetTerminal;
    pkg_traza.trace('sbTerminal: ' || sbTerminal );

    sbUser     := pkg_Session.fsbGetPersonByUserId(nuUser);
    pkg_traza.trace('sbUser: ' || sbUser );

    if sbUser is null then
      sbUser := '1 - ADMINISTRADOR DEL SISTEMA OPEN';
    end if;

    sbUser	:= substr(nuUser || ' - ' || sbUser, 1, 100);
    sbEstadoAnt := pkg_LDC_DOCUORDER.fsbObtSTATUS_DOCU(inuOrderId);
      
    pkg_traza.trace('sbEstadoAnt: ' || sbEstadoAnt);
              
    --Si el estado anterior es igual al nuevo mandamos error
    IF (sbEstadoAnt = isbNuevoEstado) THEN
      pkg_Error.SetErrorMessage(isbMsgErrr => 'Estado Actual y Nuevo Estado, No pueden ser iguales');
    END IF;

    --Validamos los cambios permidos
    IF (isbNuevoEstado = 'EP') THEN

      IF (sbEstadoAnt <> 'CO') THEN

        pkg_Error.SetErrorMessage(isbMsgErrr => 'Para pasar al estado [EN PODER DE LA EMPRESA], el documento debe estar en estado [EN PODER DE CONTRATISTA]');

      ELSE
        -- Actualizamos el estado
        
        pkg_LDC_DOCUORDER.prActEstado(inuOrderId,isbNuevoEstado, sysdate);
        
        pkg_traza.trace('Se agregara registro de auditoria');

        -- Agregamos registros a la tabla de auditoria
        
        pkg_ldc_audocuorder.prInsRegistro(
                                            sbUser,
                                            sbTerminal,
                                            sysdate,
                                            inuOrderId,
                                            sbEstadoAnt,
                                            isbNuevoEstado
                                          );

      END IF;

    END IF;

    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

  EXCEPTION
  WHEN pkg_Error.Controlled_Error THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbMensaje);
    pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNVLTRC);
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC); 
    RAISE pkg_Error.Controlled_Error;
  WHEN others THEN
    pkg_Error.setError;
    pkg_Error.getError(nuError, sbMensaje);
    pkg_traza.trace('nuError: ' || nuError || ' sbMensaje: ' || sbMensaje, cnuNVLTRC);
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
    RAISE pkg_Error.Controlled_Error;
  END prcProcesaAcotesdo;

END PKG_BOACOTESDO;
/

BEGIN
  pkg_utilidades.prAplicarPermisos(upper('PKG_BOACOTESDO'),'PERSONALIZACIONES'); 
END;
/

