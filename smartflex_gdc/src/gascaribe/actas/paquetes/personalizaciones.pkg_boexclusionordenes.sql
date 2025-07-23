CREATE OR REPLACE PACKAGE personalizaciones.pkg_boexclusionordenes IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_boexclusionordenes
      Autor       :   Jorge Valiente
      Fecha       :   11/02/2025
      Descripcion :   Paquete para el manejo de ordenes que seran exluidas de acta
      Modificaciones  :
      Autor       Fecha       Caso    Descripcion
  
  *******************************************************************************/

  --Metodo para validar configuracion de bloqueo de pago de orden con documento pendiente y tipo de trabajo
  FUNCTION fsbValConfOrdenXTipoTrabajo(inuTipoTrabajo NUMBER,
                                       inuOrden       NUMBER) RETURN VARCHAR2;

  --Metodo para validar orden asociada a documentacion y si sera excluida de acta
  FUNCTION fsbValOrdenXEstadoDocumento(inuOrden NUMBER) RETURN VARCHAR2;

  --Metodo para excluir orden de acta
  PROCEDURE prcExcluirOrdenEstadoDocumento(inuOrden NUMBER);

END pkg_boexclusionordenes;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_boexclusionordenes IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  cnuNVLTRC  CONSTANT NUMBER(2) := pkg_traza.cnuNivelTrzDef;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Funcion     : fsbValConfOrdenXTipoTrabajo
  Descripcion : Metodo para validar configuracion de bloqueo de pago de orden con documento pendiente y tipo de trabajo
  Autor       : Sebastian Tapias
  Fecha       : 19-01-2025
  
  Parametros de Entrada
             inuTipoTrabajo  NUMBER
             inuOrden        NUMBER
  
  Parametros de Salida
             S --> Se bloquea pago por Tipo Trabajo configurado
             N --> No bloquea pago por Tipo Trabajo configuracion
                  
  Modificaciones  :
    Fecha               Autor                Modificacion
  =========           =========          ====================
  ***************************************************************************/
  FUNCTION fsbValConfOrdenXTipoTrabajo(inuTipoTrabajo NUMBER,
                                       inuOrden       NUMBER) RETURN VARCHAR2 IS
  
    csbMT_NAME      VARCHAR2(70) := csbSP_NAME ||
                                    'fsbValConfOrdenXTipoTrabajo';
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
  
    sbExcluyeOrden VARCHAR2(1) := 'N'; -- Variable de Retorno
  
    sbBloqueoPago     ldc_titrdocu.block_pago%TYPE := null;
    sbEstadoDocumento ldc_docuorder.status_docu%TYPE := null;
    sbEstaCO          ldc_docuorder.status_docu%TYPE := 'CO';
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Tipo de trabajo: ' || inuTipoTrabajo, cnuNVLTRC);
    pkg_traza.trace('Orden: ' || inuOrden, cnuNVLTRC);
  
    --Obtiene configuracion de BLOQUEA PAGO A CONTRATISTA -- Y: SI N: NO
    sbBloqueoPago := pkg_ldc_titrdocu.fsbObtBLOCK_PAGO(inuTipoTrabajo);
    pkg_traza.trace('Bloquea Pago [' || sbBloqueoPago ||
                    '] para el tipo de trabajo [' || inuTipoTrabajo ||
                    '] configurado en ldc_titrdocu',
                    cnuNVLTRC);
  
    --Valida si el BLOQUEA PAGO A CONTRATISTA esta activo
    IF (sbBloqueoPago = constants_per.CSBYES) THEN
    
      --Obtiene estado de la orden a validar de la configuracion ESTADO DOCUMENTOS X ORDEN  (ldc_docuorder)
      sbEstadoDocumento := pkg_ldc_docuorder.fsbObtSTATUS_DOCU(inuOrden);
    
      pkg_traza.trace('Estado Documento: ' || sbEstadoDocumento, cnuNVLTRC);
    
      -- Validamos si el estado de la documentacion de la orden es CO (En poder de contratista)
      IF (sbEstadoDocumento = sbEstaCO) THEN
        sbExcluyeOrden := 'S';
      END IF;
    
    END IF;
  
    pkg_traza.trace('Valor a Retornar: ' || sbExcluyeOrden, cnuNVLTRC);
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
  
    RETURN(sbExcluyeOrden);
  
  EXCEPTION
  
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RETURN(sbExcluyeOrden);
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RETURN(sbExcluyeOrden);
    
  END fsbValConfOrdenXTipoTrabajo;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Funcion     : fsbValOrdenXEstadoDocumento
  Descripcion : Metodo para validar orden asociada a documentacion y si sera excluida de acta
  Autor       : Sebastian Tapias
  Fecha       : 31-07-2017
  
  Parametros de Entrada
             inuOrden  Orden
  
  Parametros de Salida
             S --> Se debe excluir el acta
             N --> No se debe hacer nada
                  
  Modificaciones  :
    Fecha               Autor                Modificacion
  =========           =========          ====================
  18/01/2021          Olsoftware         Caso 615. Se agrega una validacion para saber si la orden que se procesara
                                         es una orden de novedad o no, si llega a ser de novedad no se realizar��
                                         ningun proceso
  10/02/2025          Jorge Valiente     OSF-3957: Se aplica logica de pautas de desarrollo y Homologaciones.
  ***************************************************************************/
  FUNCTION fsbValOrdenXEstadoDocumento(inuOrden NUMBER) RETURN VARCHAR2 IS
  
    csbMT_NAME      VARCHAR2(70) := csbSP_NAME ||
                                    'fsbValOrdenXEstadoDocumento';
    onuErrorCode    NUMBER;
    osbErrorMessage VARCHAR2(4000);
  
    sbExcluyeActa VARCHAR2(1) := 'N'; -- Variable de Retorno
    nuTipoTrabajo or_order.task_type_id%TYPE := null;
  
    nuOrdenPadre      or_related_order.related_order_id%TYPE;
  
    --Variable para establecer si se excluye o no orden del acta
    blIncioExclusion BOOLEAN := TRUE;
  
    nuSolicitudOrdenHija  NUMBER;
    nuSolicitudOrdenPadre NUMBER;
    sbNovedad             VARCHAR2(1) := 'N';
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
  
    -- Valida si la orden es una orden de novedad
    sbNovedad := pkg_bcordenes.fblobteneresnovedad(inuOrden);
    pkg_traza.trace('NOVEDAD [Y/N]: ' || sbNovedad, cnuNVLTRC);
    IF sbNovedad = 'Y' THEN
      blIncioExclusion := FALSE;
    END IF;
  
    pkg_traza.trace('Orden: ' || inuOrden, cnuNVLTRC);
  
    pkg_traza.trace('Valida si la orden sera validada para exclusion',
                    cnuNVLTRC);
  
    --Valida variable para establecer si exclute orden
    IF blIncioExclusion = TRUE THEN
    
      --Obtenemos el ipo de trabajo de la orden a excluir de acta
      nuTipoTrabajo := pkg_bcordenes.fnuobtienetipotrabajo(inuOrden);
      pkg_traza.trace('Tipo de trabajo: ' || nuTipoTrabajo, cnuNVLTRC);
    
      ---Validamos que el tipo de trabajo no sea NULO
      IF (nuTipoTrabajo is not null) THEN
      
        --Validamos que el tipo de trabajo exista en la configuracion DOCUMENTOS SOLICITADOS X TIPO DE TRABAJO (ldc_titrdocu)
        IF pkg_ldc_titrdocu.fblExiste(nuTipoTrabajo) = TRUE THEN
        
          sbExcluyeActa := fsbValConfOrdenXTipoTrabajo(nuTipoTrabajo,
                                                       inuOrden);
        
        ELSE
        
          --Si el tipo de trabajo de la orden no esta en la configuracion DOCUMENTOS SOLICITADOS X TIPO DE TRABAJO (ldc_titrdocu)
          --se realizara la valdacion de la configuracion del tipo de trabajo por la orden padre.
          pkg_traza.trace('Tipo de Trabajo[' || nuTipoTrabajo ||
                          '] de la orden[' || inuOrden ||
                          '] NO existe en ldc_titrdocu - Se buscara Por la orden Padre',
                          cnuNVLTRC);
        
          --Obtiene la orden padre de la orden Hija
          nuOrdenPadre := pkg_or_related_order.fnuObtOrdenPadre(inuOrden);
          pkg_traza.trace('Orden Padre: ' || nuOrdenPadre, cnuNVLTRC);
        
          ---Validar si existe una orden padre con relacion a la orden a excluir de acta
          IF NVL(nuOrdenPadre, 0) <> 0 THEN
          
            --Validar Solicitud Orden Padre y Solicitud Orden Hija
            nuSolicitudOrdenHija := PKG_BCORDENES.fnuObtieneSolicitud(inuOrden);
            pkg_traza.trace('Solicitud Orden hija: ' ||
                            nuSolicitudOrdenHija,
                            cnuNVLTRC);
          
            nuSolicitudOrdenPadre := PKG_BCORDENES.fnuObtieneSolicitud(nuOrdenPadre);
            pkg_traza.trace('Solicitud Orden Padre: ' ||
                            nuSolicitudOrdenPadre,
                            cnuNVLTRC);
          
            IF nvl(nuSolicitudOrdenHija, 0) = 0 THEN
              blIncioExclusion := FALSE;
            ELSIF nuSolicitudOrdenHija <> nuSolicitudOrdenPadre THEN
              blIncioExclusion := FALSE;
            END IF;
            -----------------------------------------------------------
            IF blIncioExclusion = TRUE THEN
            
              --Obtenemos el tipo de trabajo de la orden padre
              nuTipoTrabajo := pkg_bcordenes.fnuobtienetipotrabajo(nuOrdenPadre);
            
              pkg_traza.trace('Tipo de Trabajo[' || nuTipoTrabajo ||
                              '] de orden padre',
                              cnuNVLTRC);
            
              -- Si el tipo de trabajo de la orden padre no es nulo.
              IF (nuTipoTrabajo is not null) THEN
              
                sbExcluyeActa := fsbValConfOrdenXTipoTrabajo(nuTipoTrabajo,
                                                             nuOrdenPadre);
              
              END IF; --Fin IF (nuTipoTrabajo is not null) THEN
            
            END IF; --Fin IF blIncioExclusion = TRUE THEN
          
          END IF; --Fin IF NVL(nuOrdenPadre, 0) > 0 THEN
        
        END IF; --Fin IF pkg_ldc_titrdocu.fblExiste(nuTipoTrabajo) = TRUE THEN
      
      END IF; --Fin IF (nuTipoTrabajo is not null) THEN
    
    END IF; --Fin IF blIncioExclusion = TRUE THEN
  
    pkg_traza.trace('Valor a Retornar: ' || sbExcluyeActa, cnuNVLTRC);
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
  
    RETURN(sbExcluyeActa);
  
  EXCEPTION
  
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
      RETURN(sbExcluyeActa);
    
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
      RETURN(sbExcluyeActa);
    
  END fsbValOrdenXEstadoDocumento;

  /***************************************************************************
  Propiedad Intelectual de Gases del Caribe
  Programa        : prcExcluirOrdenEstadoDocumento
  Descripcion     : Metodo para excluir orden de acta
  Autor           : Jorge Valiente
  Fecha           : 08/02/2025
  
  Parametros de Entrada
             inuOrden  Orden  
             
  
  Modificaciones  :
  Autor       Fecha       Caso     Descripcion
  ***************************************************************************/
  PROCEDURE prcExcluirOrdenEstadoDocumento(inuOrden NUMBER) IS
    -- Nombre de este metodo
    csbMT_NAME  VARCHAR2(70) := csbSP_NAME ||
                                'prcExcluirOrdenEstadoDocumento';
    nuErrorCode NUMBER; -- se almacena codigo de error
    sbMensError VARCHAR2(2000); -- se almacena descripcion del error
  
    sbValOrdenXEstadoDocumento VARCHAR2(1) := 'N';
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
  
    sbValOrdenXEstadoDocumento := fsbValOrdenXEstadoDocumento(inuOrden);
    pkg_traza.trace('Orden[' || inuOrden || '] Excluida[' ||
                    sbValOrdenXEstadoDocumento || ']',
                    cnuNVLTRC);
  
    IF sbValOrdenXEstadoDocumento = 'S' THEN
      pkg_bogestionexclusionordenes.prcexcluirordenpordias(1,
                                                           1297,
                                                           'Pendiente por entregar documentos');
    END IF;
  
    pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error => ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuErrorCode, sbMensError);
      pkg_traza.trace('Error => ' || sbMensError, cnuNVLTRC);
      pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
  END prcExcluirOrdenEstadoDocumento;

END pkg_boexclusionordenes;
/
BEGIN
  pkg_utilidades.prAplicarPermisos(upper('pkg_boexclusionordenes'),
                                   upper('personalizaciones'));
END;
/
