create or replace PACKAGE PKG_UIACOTESDO IS
  FUNCTION frfConsulta RETURN constants_per.tyrefcursor; 
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfConsulta
    Descripción     : proceso que retorna información para PB ACODESCO

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parámetros de Entrada
    
    Parámetros de Salida
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    
  ***************************************************************************/
  PROCEDURE prcObjeto (	inuOrderId        IN  OR_ORDER.ORDER_ID%TYPE,
                        inuCurrent        IN  NUMBER,
                        inuTotal          IN  NUMBER,
                        onuErrorCode      OUT NUMBER,
                        osbErrorMessage   OUT VARCHAR
                        );
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripción     : proceso que procesa la información para PB ACODESCO

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parámetros de Entrada
        inuOrderId     Identificador de la orden.
        inuCurrent     Registro actual.
        inuTotal       Total de registros
    Parámetros de Salida
        onuErrorCode   Código de error.
        osbErrorMess   Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

END PKG_UIACOTESDO;
/
create or replace PACKAGE BODY PKG_UIACOTESDO IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-3576';


  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripción     : Retona el identificador del último caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripción
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  FUNCTION frfConsulta RETURN constants_per.tyrefcursor IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : frfConsulta
      Descripción     : proceso que retorna información para PB ACOTESCO

      Autor           : Jhon Jairo Soto
      Fecha           : 07-11-2024

      Parámetros de Entrada
      
      Parámetros de Salida
      
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
      
    ***************************************************************************/
    
      csbMT_NAME      VARCHAR2(200) := csbSP_NAME || 'frfConsulta';

      --Variables Usadas Durante el Proceso
      cnuNull_Attribute   CONSTANT NUMBER := 2126;
      sbUnidadOperativa   ge_boInstanceControl.stysbValue;
      sbEstadoDocum       ge_boInstanceControl.stysbValue;
      sbFechaInicial      ge_boInstanceControl.stysbValue;
      sbFechaFinal        ge_boInstanceControl.stysbValue;
      sbTipoTrabajo       ge_boInstanceControl.stysbValue;
      rfCursor            constants_per.tyRefCursor;

      nuUnidadOperativa   or_order.operating_unit_id%TYPE;
      nuTipoTrabajo       or_order.task_type_id%TYPE;
      dtFechaInicial      DATE;
      dtFechaFinal        DATE;
      nuError		 		      NUMBER;  
      sbError	 			      VARCHAR2(2000);

  BEGIN


      pkg_Traza.trace(csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbInicio);

      -- Se obtienen datos de la forma
      sbUnidadOperativa   := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER','OPERATING_UNIT_ID');
      sbEstadoDocum       := ge_boInstanceControl.fsbGetFieldValue('LDC_DOCUORDER','STATUS_DOCU');
      sbFechaInicial      := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER','EXEC_INITIAL_DATE');
      sbFechaFinal        := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER','LEGALIZATION_DATE');
      sbTipoTrabajo       := ge_boInstanceControl.fsbGetFieldValue('OR_ORDER','TASK_TYPE_ID');

      ------------------------------------------------
      -- Required Attributes
      ------------------------------------------------
      --Se validan campo nulos

      IF (sbUnidadOperativa IS NULL) THEN
          pkg_Error.SetErrorMessage(cnuNull_Attribute, 'Unidad Operativa Nula');
      END IF;

      IF (sbEstadoDocum IS NULL) then
        pkg_Error.SetErrorMessage(cnuNull_Attribute, 'Estado Orden (Actual)');
      END IF;


      pkg_Traza.trace('sbUnidadOperativa: '   ||sbUnidadOperativa);
      pkg_Traza.trace('sbEstadoDocum: '       ||sbEstadoDocum);
      pkg_Traza.trace('sbFechaInicial: '      ||sbFechaInicial);
      pkg_Traza.trace('sbFechaFinal: '        ||sbFechaFinal);
      pkg_Traza.trace('sbTipoTrabajo: '       ||sbTipoTrabajo);
      

      nuUnidadOperativa := TO_NUMBER(sbUnidadOperativa);
      nuTipoTrabajo     := TO_NUMBER(sbTipoTrabajo);
      dtFechaInicial    := TO_DATE(sbFechaInicial);
      dtFechaFinal      := TO_DATE(sbFechaFinal);



      rfCursor := pkg_boacotesdo.frcConsultaDocumentosOT( nuUnidadOperativa,
                                                      sbEstadoDocum,
                                                      dtFechaInicial,
                                                      dtFechaFinal,
                                                      nuTipoTrabajo);

      pkg_Traza.trace( csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbFIN);

      RETURN rfCursor;
    
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_Traza.trace('sbError: ' || sbError, pkg_Traza.cnuNivelTrzDef);
      pkg_Traza.trace(csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_Traza.trace('sbError: ' || sbError, pkg_Traza.cnuNivelTrzDef);
      pkg_Traza.trace(csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END frfConsulta;
  
  PROCEDURE prcObjeto (	inuOrderId        IN  OR_ORDER.ORDER_ID%TYPE,
                        inuCurrent        IN  NUMBER,
                        inuTotal          IN  NUMBER,
                        onuErrorCode      OUT NUMBER,
                        osbErrorMessage   OUT VARCHAR
							        ) IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : proceso que procesa la información para PB ACODESCO

    Autor           : Jhon Jairo Soto
    Fecha           : 07-11-2024

    Parámetros de Entrada
        inuOrderId     Identificador de la orden.
        inuCurrent     Registro actual.
        inuTotal       Total de registros
    Parámetros de Salida
        onuErrorCode   Código de error.
        osbErrorMess   Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/
    -- Nombre de este método
    csbMT_NAME            VARCHAR2(200) := csbSP_NAME || 'prcObjeto';
	
	
    --Variables Generales
    cnuNull_Attribute 	  CONSTANT NUMBER := 2126;
    sbUnidadOperativa     ge_boinstancecontrol.stysbvalue;
    sbEstadoDocum         ge_boinstancecontrol.stysbvalue;
    sbFechaInicial        ge_boinstancecontrol.stysbvalue;
    sbFechaFinal          ge_boinstancecontrol.stysbvalue;
    sbTipoTrabajo         ge_boinstancecontrol.stysbvalue;
    sbNuevoEstado         ge_boinstancecontrol.stysbvalue;
    

	
  BEGIN
    pkg_Traza.trace( csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbINICIO);
 
    pkg_Traza.trace('inuOrderId: ' || inuOrderId);
    pkg_Traza.trace('inuCurrent: ' || inuCurrent);
    pkg_Traza.trace('inuTotal: '  || inuTotal);
	
    -- Obtenemos los datos de la forma
    sbNuevoEstado := ge_boinstancecontrol.fsbgetfieldvalue('OR_ORDER','APPOINTMENT_CONFIRM');
    
    ------------------------------------------------
    -- Required Attributes
    ------------------------------------------------
    --Validamos que el nuevo estado no sea nulo (no puede ser nulo pues es el dato que se va a actualizar)
    IF (sbNuevoEstado IS NULL) THEN
      pkg_Error.SetErrorMessage(cnuNull_Attribute, 'Nuevo Estado');
    END IF;

    pkg_Traza.trace('sbNuevoEstado: '     ||sbNuevoEstado);

	  pkg_boacotesdo.prcProcesaAcotesdo(inuOrderId,sbNuevoEstado);

    pkg_Traza.trace(csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbFIN);
	 
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_Traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_Traza.cnuNivelTrzDef);
      pkg_Traza.trace(csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_Traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_Traza.cnuNivelTrzDef);
      pkg_Traza.trace(csbMT_NAME, pkg_Traza.cnuNivelTrzDef, pkg_Traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END prcObjeto;

END PKG_UIACOTESDO;
/
BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_UIACOTESDO', 'OPEN');
END;
/    

