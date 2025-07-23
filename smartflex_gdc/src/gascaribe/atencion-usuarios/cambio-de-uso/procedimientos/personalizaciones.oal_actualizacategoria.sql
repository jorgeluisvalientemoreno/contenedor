CREATE OR REPLACE PROCEDURE personalizaciones.oal_actualizacategoria(inuOrden            IN NUMBER,
                                                                     inuCausal           IN NUMBER,
                                                                     inuPersona          IN NUMBER,
                                                                     idtFechIniEje       IN DATE,
                                                                     idtFechaFinEje      IN DATE,
                                                                     isbDatosAdic        IN VARCHAR2,
                                                                     isbActividades      IN VARCHAR2,
                                                                     isbItemsElementos   IN VARCHAR2,
                                                                     isbLecturaElementos IN VARCHAR2,
                                                                     isbComentariosOrden IN VARCHAR2) IS

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : oal_actualizacategoria
    Descripcion     : servicio para atender solicitud.
    Autor           : Jorge Valiente
    Fecha           : 18-02-2025
  
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  csbMetodo     VARCHAR2(70) := 'oal_actualizacategoria';
  nuErrorCode   NUMBER; -- se almacena codigo de error
  sbMensError   VARCHAR2(2000); -- se almacena descripcion del error
  nuNivelTrzDef NUMBER := pkg_traza.cnuNivelTrzDef;
  sbINICIO      VARCHAR2(100) := pkg_traza.csbINICIO;
  sbFIN         VARCHAR2(100) := pkg_traza.csbFIN;

  nuClasificadorCausal NUMBER;
  nuSolicitud          NUMBER;
  nuTipoSolicitud      NUMBER;

  onuCategoriaActual      NUMBER;
  onuCategriaNueva        NUMBER;
  onuSubcategoriaAnterior NUMBER;
  onuSubcategoriaNueva    NUMBER;

  nuProducto             NUMBER;
  nuDireccion            NUMBER;
  nuSegmento             NUMBER;
  nuCategoriaSegmento    NUMBER;
  nuSubCategoriaSegmento NUMBER;
  nuContrato             NUMBER;

  nuCATEGORIA_RESIDENCIAL NUMBER;
  nuCATEGORIA_COMERCIAL   NUMBER;

  sbXMLActDatosPredio constants_per.tipo_xml_sol%TYPE;

  nuPackageId NUMBER;
  nuMotiveId  NUMBER;

  nuMedioRecepcion    NUMBER;
  nuContacto          NUMBER;
  nuRelacionPredio    NUMBER;
  sbResolucion        VARCHAR2(50);
  sbFlagDocumentacion VARCHAR2(1);
  sbComentario        VARCHAR2(2000);

  nuErrorTramite          NUMBER := 0;
  sbCorreos               VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('CORREO_VERIFICACION_ESTRATO');
  sbAsuntoCorreo          VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('ASUNTO_CORREO_VERIFICACION_ESTRATO');
  sbMensajeCorreo         VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('MENSAJE_CORREO_VERIFICACION_ESTRATO');
  sbDepartamento          VARCHAR2(4000);
  sbDepartamentoCorreos   VARCHAR2(4000);
  sbCorreoDestino         VARCHAR2(4000);
  rfDataParametro         constants_per.tyrefcursor;
  tbDataCorreos           pkg_boutilidadescadenas.tytbCadenaSeparada;
  nuDepartamentoDireccion NUMBER;
  sbMensajeComplemento    VARCHAR2(4000) := ', orden de trabajo: ORDENAU, contrato: CONTRATOCU';
  nuActividad             NUMBER := pkg_parametros.fnuGetValorNumerico('ACTIVIDAD_VERIFICACION_ESTRATO_ACTUAL');
  ionuOrderId             NUMBER;
  ionuActivity            NUMBER;
  sbRemitente             ld_parameter.value_chain%TYPE := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');
  sbIndice                VARCHAR2(4000);

BEGIN

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbINICIO);

  pkg_traza.trace('Orden: ' || inuOrden, nuNivelTrzDef);
  pkg_traza.trace('Causal: ' || inuCausal, nuNivelTrzDef);
  pkg_traza.trace('Persona: ' || inuPersona, nuNivelTrzDef);
  pkg_traza.trace('FechIniEje: ' || idtFechIniEje, nuNivelTrzDef);
  pkg_traza.trace('FechaFinEje: ' || idtFechaFinEje, nuNivelTrzDef);
  pkg_traza.trace('DatosAdic: ' || isbDatosAdic, nuNivelTrzDef);
  pkg_traza.trace('Actividades: ' || isbActividades, nuNivelTrzDef);
  pkg_traza.trace('ItemsElementos: ' || isbItemsElementos, nuNivelTrzDef);
  pkg_traza.trace('LecturaElementos: ' || isbLecturaElementos,
                  nuNivelTrzDef);
  pkg_traza.trace('ComentariosOrden: ' || isbComentariosOrden,
                  nuNivelTrzDef);

  --Obtener la clasificación (clase) de la causal
  nuClasificadorCausal := pkg_bcordenes.fnuobtieneclasecausal(inuCausal);
  pkg_traza.trace('Clasificacion Causal: ' || nuClasificadorCausal,
                  nuNivelTrzDef);

  --Si la clasificación de la causal es de 1 - éxito
  IF nuClasificadorCausal = 1 THEN
  
    --Obtener solicitud de la orden
    nuSolicitud := pkg_bcordenes.fnuObtieneSolicitud(inuOrden);
    pkg_traza.trace('Solicitud: ' || nuSolicitud, nuNivelTrzDef);
  
    --Obtener Tipo de solicitud 
    nuTipoSolicitud := pkg_bcsolicitudes.fnuGetTipoSolicitud(nuSolicitud);
    pkg_traza.trace('Tipo Solicitud: ' || nuTipoSolicitud, nuNivelTrzDef);
  
    --Obtener Nueva Categoria de la solicitud
    pkg_boGestionSolicitudes.prcObtCategoriasPorSolicitud(nuSolicitud,
                                                          onuCategoriaActual,
                                                          onuCategriaNueva);
    pkg_traza.trace('Categoria Actual: ' || onuCategoriaActual,
                    nuNivelTrzDef);
    pkg_traza.trace('Nueva Categoria: ' || onuCategriaNueva, nuNivelTrzDef);
  
    --Obtener Nueva SubCategoria de la orden legalizada
    pkg_boGestionSolicitudes.prcObtSubCategoriaPorSolicitud(nuSolicitud,
                                                            onuSubcategoriaAnterior,
                                                            onuSubcategoriaNueva);
    pkg_traza.trace('SubCategoria Actual: ' || onuSubcategoriaAnterior,
                    nuNivelTrzDef);
    pkg_traza.trace('Nueva SubCategoria: ' || onuSubcategoriaNueva,
                    nuNivelTrzDef);
  
    --Obtener producto de la solicitud    
    nuProducto := pkg_bcsolicitudes.fnuGetProducto(nuSolicitud);
    pkg_traza.trace('Producto: ' || nuProducto, nuNivelTrzDef);
  
    --Obtener dirección del producto   
    nuDireccion := pkg_bcproducto.fnuIdDireccInstalacion(nuProducto);
    pkg_traza.trace('Direccion: ' || nuDireccion, nuNivelTrzDef);
  
    --Obtener departamento de la direccion
    nuDepartamentoDireccion := pkg_bcdirecciones.fnugetubicageopadre(pkg_bcdirecciones.fnugetlocalidad(nuDireccion));
    pkg_traza.trace('Departamento de la direccion: ' ||
                    nuDepartamentoDireccion,
                    nuNivelTrzDef);
  
    --Obtener Contrato 
    nuContrato := pkg_bcproducto.fnuContrato(nuProducto);
    pkg_traza.trace('Contrato: ' || nuContrato, nuNivelTrzDef);
  
    --Obtener segmento de la dirección 
    nuSegmento := pkg_bcdirecciones.fnuGetSegmento_id(nuDireccion);
    pkg_traza.trace('Segmento: ' || nuSegmento, nuNivelTrzDef);
  
    --Obtener la Categoría del segmento    
    nuCategoriaSegmento := pkg_bcdirecciones.fnuObtCategoriaSegmento(nuSegmento);
    pkg_traza.trace('Categoria Segmento: ' || nuCategoriaSegmento,
                    nuNivelTrzDef);
  
    --Obtener la Subcategoría del segmento   
    nuSubCategoriaSegmento := pkg_bcdirecciones.fnuObtSubCategoriaSegmento(nuSegmento);
    pkg_traza.trace('SubCategoria Segmento: ' || nuSubCategoriaSegmento,
                    nuNivelTrzDef);
  
    --Obtener codigo de la categoria residencial de parametro
    nuCATEGORIA_RESIDENCIAL := pkg_parametros.fnuGetValorNumerico('CATEGORIA_RESIDENCIAL');
    pkg_traza.trace('Parametro CATEGORIA_RESIDENCIAL: ' ||
                    nuCATEGORIA_RESIDENCIAL,
                    nuNivelTrzDef);
  
    --Obtener codigo de la categoria comercial de parametro
    nuCATEGORIA_COMERCIAL := pkg_parametros.fnuGetValorNumerico('CATEGORIA_COMERCIAL');
    pkg_traza.trace('Parametro CATEGORIA_COMERCIAL: ' ||
                    nuCATEGORIA_COMERCIAL,
                    nuNivelTrzDef);
  
    --Obtener codigo del medio de recepcion de parametro
    nuMedioRecepcion := pkg_parametros.fnuGetValorNumerico('MERE_ACTUALIZACION_DATOS_PREDIO');
    pkg_traza.trace('Medio Recepcion: ' || nuMedioRecepcion, nuNivelTrzDef);
  
    --Obtener codigo del contacto
    nuContacto := pkg_bcsolicitudes.fnuGetContacto(nuSolicitud);
    pkg_traza.trace('Contacto: ' || nuContacto, nuNivelTrzDef);
  
    --Obtener codigo de la relacion con el predio que genero la solicitud 
    nuRelacionPredio := pkg_bcsolicitudes.fnuObtRelacionConPredio(nuSolicitud);
    pkg_traza.trace('Contacto: ' || nuContacto, nuNivelTrzDef);
  
    --Obtener codigo de resolucion
    sbResolucion := pkg_bcsolicitudes.fsbObtResolucion(nuSolicitud);
    pkg_traza.trace('Resolucion: ' || sbResolucion, nuNivelTrzDef);
  
    --Obtener FLAG de documentacion
    sbFlagDocumentacion := pkg_bcsolicitudes.fsbObtFlagDocumentacion(nuSolicitud);
    pkg_traza.trace('Flag Documentacion: ' || sbFlagDocumentacion,
                    nuNivelTrzDef);
  
    --Obtener comentario de solicitud
    sbComentario := pkg_bcsolicitudes.fsbGetComentario(nuSolicitud);
    pkg_traza.trace('sbComentario: ' || sbComentario, nuNivelTrzDef);
  
    --Estabelcer si debe o no recibir numero de resolucion
    IF (onuCategoriaActual = nuCATEGORIA_COMERCIAL) THEN
      sbResolucion := NULL;
    END IF;
    pkg_traza.trace('Resolucion despues de validacion: ' || sbResolucion,
                    nuNivelTrzDef);
  
    --Si la nueva categoría del trámite de cambio de uso existe en el parámetro CATEGORIA_RESIDENCIAL, 
    --y la Nueva Subcategoría es diferente a la Subcategoría del segmento
    --se realizará el llamado del servicio XML para generar el trámite Actualizar Datos del Predio.
    IF nuCATEGORIA_RESIDENCIAL = onuCategriaNueva THEN
    
      IF onuSubcategoriaNueva <> nuSubCategoriaSegmento THEN
      
        sbXMLActDatosPredio := pkg_xml_soli_aten_cliente.getSolitudActualizaDatosPredio(nuContrato, --inuContratoId 
                                                                                        nuMedioRecepcion, --inuMedioRecepcionId
                                                                                        nuContacto, --inuContactoId 
                                                                                        nuDireccion, --inuDireccion 
                                                                                        sbComentario, --isbComentario 
                                                                                        nuRelacionPredio, --inuRelaSoliPredio 
                                                                                        nuDireccion, --inuDirecInstalacion
                                                                                        nuDireccion, --inuDirecEntregaFact
                                                                                        NULL, ---inuDirecInstaSoli 
                                                                                        NULL, --inuDirecEntFacSoli 
                                                                                        onuSubcategoriaNueva, --inuSubcategoria
                                                                                        sbResolucion, --inuResolucion        
                                                                                        sbFlagDocumentacion, --isbDocumentacion    
                                                                                        NULL --inuRespuesta  
                                                                                        );
      
        pkg_traza.trace('sbXMLActDatosPredio:' || sbXMLActDatosPredio,
                        nuNivelTrzDef);
      
        api_registerRequestByXml(sbXMLActDatosPredio,
                                 nuPackageId,
                                 nuMotiveId,
                                 nuErrorCode,
                                 sbMensError);
      
        pkg_traza.trace('Solicitud: ' || nuPackageId, nuNivelTrzDef);
        pkg_traza.trace('Motivo: ' || nuMotiveId, nuNivelTrzDef);
        pkg_traza.trace('Codigo Error: ' || nuErrorCode, nuNivelTrzDef);
        pkg_traza.trace('Mensaje Error: ' || sbMensError, nuNivelTrzDef);
      
        IF nuErrorCode <> 0 THEN
          nuErrorTramite := 1;
          pkg_traza.trace('Generara orden autonoma - Error: ' ||
                          sbMensError,
                          nuNivelTrzDef);
        END IF;
      END IF; --IF onuSubcategoriaNueva <> nuSubCategoriaSegmento THEN
    
    END IF; --IF nuCATEGORIA_RESIDENCIAL = onuCategriaNueva THEN
  
    pkg_traza.trace('Inicia actualizacion de Categoria y SubCategoria con el contrato a OSF y GIS',
                    nuNivelTrzDef);
  
    pkg_bogestion_instancias.prcCreaInstancia(pkg_bogestion_instancias.csbWorkInstance);
  
    pkg_bogestion_instancias.prcAdicionarAtributo(pkg_bogestion_instancias.csbWorkInstance,
                                                  NULL,
                                                  'PS_PACKAGE_TYPE',
                                                  'PACKAGE_TYPE_ID',
                                                  nuTipoSolicitud);
  
    pkg_gestion_producto.prcActuaCateySubcaPorContrato(nuContrato,
                                                       onuCategriaNueva,
                                                       onuSubcategoriaNueva);
  
    pkg_traza.trace('El tramite Actualiza Datos Predio Genero Error 0-No 1-Si: ' ||
                    nuErrorTramite,
                    nuNivelTrzDef);
    IF nuErrorTramite = 1 THEN
    
      --Generacion de Orden Autonoma
      sbAsuntoCorreo  := replace(sbAsuntoCorreo, 'CONTRATOCU', nuContrato);
      sbMensajeCorreo := replace(sbMensajeCorreo,
                                 'SUBSOL',
                                 onuSubcategoriaNueva);
      sbMensajeCorreo := replace(sbMensajeCorreo,
                                 'SUBSEG',
                                 nuSubCategoriaSegmento);
    
      pkg_traza.trace('Actividad: ' || nuActividad, nuNivelTrzDef);
    
      API_CREATEORDER(nuActividad,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      nuDireccion,
                      NULL,
                      NULL,
                      nuContrato,
                      nuProducto,
                      NULL,
                      SYSDATE + (1 / 24 / 60),
                      NULL,
                      sbMensajeCorreo,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      NULL,
                      0,
                      NULL,
                      ionuOrderId,
                      ionuActivity,
                      nuErrorCode,
                      sbMensError);
    
      pkg_traza.trace('Nueva Orden: ' || ionuOrderId, nuNivelTrzDef);
      pkg_traza.trace('Nueva Actividad: ' || ionuActivity, nuNivelTrzDef);
      pkg_traza.trace('Codigo Error: ' || nuErrorCode, nuNivelTrzDef);
      pkg_traza.trace('Mensaje Error: ' || sbMensError, nuNivelTrzDef);
    
      sbMensajeComplemento := replace(sbMensajeComplemento,
                                      'ORDENAU',
                                      ionuOrderId);
      sbMensajeComplemento := replace(sbMensajeComplemento,
                                      'CONTRATOCU',
                                      nuContrato);
    
      sbMensajeCorreo := sbMensajeCorreo || sbMensajeComplemento;
    
      --Valida creacion de orden autonoma
      IF nuErrorCode = 0 THEN
      
        rfDataParametro := pkg_bcutilidadescadenas.frfObtDataCon3Separadores(sbCorreos,
                                                                             '|',
                                                                             ';',
                                                                             ',');
        LOOP
          FETCH rfDataParametro
            INTO sbDepartamento, sbDepartamentoCorreos;
        
          EXIT WHEN rfDataParametro%NOTFOUND;
        
          IF nuDepartamentoDireccion = TO_NUMBER(sbDepartamento) THEN
            pkg_traza.trace('Departamento: ' || sbDepartamento ||
                            ' - Correos: ' || sbDepartamentoCorreos,
                            nuNivelTrzDef);
          
            tbDataCorreos := pkg_boutilidadescadenas.ftbObtCadenaSeparada(sbDepartamentoCorreos,
                                                                          ',');
          
            pkg_traza.trace('Asunto: ' || sbAsuntoCorreo, nuNivelTrzDef);
            pkg_traza.trace('Mensaje: ' || sbMensajeCorreo, nuNivelTrzDef);
          
            -- Recorremos la tabla
            sbIndice := tbDataCorreos.FIRST;
            WHILE sbIndice IS NOT NULL LOOP
              pkg_Correo.prcEnviaCorreo(isbRemitente     => sbRemitente,
                                        isbDestinatarios => tbDataCorreos(sbIndice),
                                        isbAsunto        => sbAsuntoCorreo,
                                        isbMensaje       => sbMensajeCorreo);
              sbIndice := tbDataCorreos.NEXT(sbIndice);
            END LOOP; --Ciclo tbDataCorreos
          
          END IF;
        
        END LOOP; --Ciclo rfDataParametro
      
      ELSE
      
        pkg_error.setErrorMessage(isbMsgErrr => sbMensError);
      
      END IF; --IF nuErrorCode = 0 THEN
    
    END IF;
  
    pkg_traza.trace('Fin actualizacion de Categoria y SubCategoria con el contrato a OSF y GIS',
                    nuNivelTrzDef);
  
  END IF; --IF nuClasificadorCausal = 1 THEN

  pkg_traza.trace(csbMetodo, nuNivelTrzDef, sbFIN);

EXCEPTION

  WHEN PKG_ERROR.CONTROLLED_ERROR THEN
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, nuNivelTrzDef);
    pkg_traza.trace(csbMetodo, nuNivelTrzDef, pkg_traza.csbFIN_ERC);
    raise pkg_error.CONTROLLED_ERROR;
  
  WHEN OTHERS THEN
    pkg_Error.setError;
    pkg_Error.getError(nuErrorCode, sbMensError);
    pkg_traza.trace('Error: ' || sbMensError, nuNivelTrzDef);
    pkg_traza.trace(csbMetodo, nuNivelTrzDef, pkg_traza.csbFIN_ERR);
    raise pkg_error.CONTROLLED_ERROR;
  
END;
/
BEGIN
  pkg_utilidades.praplicarpermisos('OAL_ACTUALIZACATEGORIA',
                                   'PERSONALIZACIONES');
END;
/
