CREATE OR REPLACE PACKAGE personalizaciones.pkg_bocambio_de_uso AS

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe y Efigas
      Autor : jvaliente
      Descr : Paquete manejo datos relacionados al tramite de cambio de uso
      Tabla : pkg_bocambio_de_uso
      Caso  : OSF-3541
      Fecha : 20/11/2024 11:06:35
  ***************************************************************************/

  --Servicio para obtener la SubCategoria del lado de manzana configurada en el segmento de la direccion
  FUNCTION fnuObtieneSubCategoria(inuMotivo NUMBER) RETURN number;

  -- Servicio para obtener la respuesta si requiere o no visita a campo
  FUNCTION fnuRequiereVisitaCampo(inuPACKAGE_ID NUMBER) RETURN NUMBER;

END pkg_bocambio_de_uso;
/
CREATE OR REPLACE PACKAGE BODY personalizaciones.pkg_bocambio_de_uso AS

  csbSP_NAME    CONSTANT VARCHAR2(35) := $$PLSQL_UNIT || '.';
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtieneSubCategoria
    Descripcion     : Servicio para obtener la SubCategoria a Inicializar
    Autor           : Jorge Valiente
    Fecha           : 20-11-2024
  
    Parametros
      Entrada
        inuMotivo           Codigo Motivo
        
      Salida
        nuSubcategoria      Codigo de SubCategoria
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuObtieneSubCategoria(inuMotivo NUMBER) RETURN NUMBER IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtieneSubCategoria';
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    nuDireccion       NUMBER;
    nuExisteCategoria NUMBER;
  
    --Variables para DATA de segmento
    nuSegmento       NUMBER;
    nuCatSegmento    NUMBER;
    nuSubCatSegmento NUMBER;
  
    --Variables para DATA de motivo
    nuSubCatMotivo NUMBER;
    nuCatMotivo    NUMBER;
    nuProducto     NUMBER;
  
    --Variables para DATA de Solicitud
    nuSolicitud NUMBER;
  
    nuSubcategoria NUMBER := pkg_parametros.fnuGetValorNumerico('SUBCATEGORIA_INICIAL_ORDEN_REGISTRO_CAMBIO_USO');
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Motivo: ' || inuMotivo, csbNivelTraza);
  
    nuCatMotivo := pkg_bcsolicitudes.fnuObtCategoriaDeMotivo(inuMotivo);
    pkg_traza.trace('Categoria[' || nuCatMotivo ||
                    '] relacionada al Motivo',
                    csbNivelTraza);
  
    nuSubCatMotivo := pkg_bcsolicitudes.fnuObtSubCategoriaDeMotivo(inuMotivo);
    pkg_traza.trace('SubCategoria[' || nuSubCatMotivo ||
                    '] relacionada al Motivo',
                    csbNivelTraza);
  
    --Establece si existe el valor en el parametro
    nuExisteCategoria := pkg_parametros.fnuValidaSiExisteCadena('VALIDA_CATEG_CAMBIO_USO',
                                                                ',',
                                                                nuCatMotivo);
  
    pkg_traza.trace('Existe Categoria Motivo en el parametro VALIDA_CATEG_CAMBIO_USO: ' ||
                    nuExisteCategoria,
                    csbNivelTraza);
  
    --Valida existencia de la categoria en el parametro
    IF nuExisteCategoria = 0 THEN
      nuSubcategoria := nuSubCatMotivo;
    ELSE
    
      --Obtiene solicitud del motivo
      nuSolicitud := pkg_bcsolicitudes.fnuGetSolicitudDelMotivo(inuMotivo);
      pkg_traza.trace('Solicitud[' || nuSolicitud || '] del motivo',
                      csbNivelTraza);
    
      --Obtiene producto de la solicitud
      nuProducto := pkg_bcsolicitudes.fnuGetProducto(nuSolicitud);
      pkg_traza.trace('Producto[' || nuProducto || '] de la solicitud',
                      csbNivelTraza);
    
      --Obtiene direccion del producto
      nuDireccion := pkg_bcproducto.fnuIdDireccInstalacion(nuProducto);
      pkg_traza.trace('Codigo Direccion[' || nuDireccion ||
                      '] del prodcuto',
                      csbNivelTraza);
    
      --Obtiene segemento de la direccion
      nuSegmento := pkg_bcdirecciones.fnuGetSegmento_id(nuDireccion);
      pkg_traza.trace('Codigo Segmento[' || nuSegmento ||
                      '] de la direccion',
                      csbNivelTraza);
    
      --Obtiene Categoria del segemento
      nuCatSegmento := pkg_bcdirecciones.fnuObtCategoriaSegmento(nuSegmento);
      pkg_traza.trace('Categoria[' || nuCatSegmento || '] del segmento',
                      csbNivelTraza);
    
      IF nuCatMotivo = nuCatSegmento then
      
        --Obtiene Subcategoria del segemento
        nuSubCatSegmento := pkg_bcdirecciones.fnuObtSubCategoriaSegmento(nuSegmento);
        pkg_traza.trace('SubCategoria[' || nuSubCatSegmento ||
                        '] del segmento',
                        csbNivelTraza);
      
        --Valida si la subcategoria del motivo iguala la subcategoria del segmento
        IF nuSubCatMotivo = nuSubCatSegmento THEN
          nuSubcategoria := nuSubCatMotivo;
        END IF;
      
      END IF;
    
    END IF;
  
    pkg_traza.trace('Subcaterogia Retornada: ' || nuSubcategoria,
                    csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN nuSubcategoria;
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RETURN null;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error => ' || sbError, csbNivelTraza);
      RETURN null;
  END fnuObtieneSubCategoria;

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuRequiereVisitaCampo
    Descripcion     : Servicio para obtener la respuesta si requiere o no visita a campo
    Autor           : Jorge Valiente
    Fecha           : 29-11-2024
  
    Parametros
      Entrada
        inuPACKAGE_ID        Codigo solicitud
        
      Salida
        nuRealizo_Visita     1 ? Requiere Visita
                             0 - No Requiere Visita
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  FUNCTION fnuRequiereVisitaCampo(inuPackage_Id NUMBER) RETURN NUMBER IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuRequiereVisitaCampo';
    nuError          NUMBER;
    sbError          VARCHAR2(4000);
    sbRealizo_Visita VARCHAR2(1);
    nuRealizo_Visita NUMBER := 1;
  
    nuMedioRecepcion       NUMBER;
    nuExisteMedioRecepcion NUMBER;
    nuExisteCategoria      NUMBER;
    nuMotivo               NUMBER;
    nuCategoriaMotivo      NUMBER;
  
    sbREALIZO_VISITA_EN_CAMPO VARCHAR2(50) := 'REALIZO_VISITA_EN_CAMPO';
  
  BEGIN
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pkg_traza.trace('Solicitud: ' || inuPackage_Id, csbNivelTraza);
  
    nuMotivo := pkg_bcsolicitudes.fnuObtenerMotivoDeSolicitud(inuPackage_Id);
    pkg_traza.trace('Motivo: ' || nuMotivo, csbNivelTraza);
  
    nuCategoriaMotivo := pkg_bcsolicitudes.fnuObtCategoriaDeMotivo(nuMotivo);
    pkg_traza.trace('Categoria Inicial: ' || nuCategoriaMotivo,
                    csbNivelTraza);
  
    --Establece si existe el valor en el parametro
    nuExisteCategoria := pkg_parametros.fnuValidaSiExisteCadena('VALIDA_CATEG_CAMBIO_USO',
                                                                ',',
                                                                nuCategoriaMotivo);
  
    IF nuExisteCategoria > 0 THEN
    
      nuMedioRecepcion := pkg_bcsolicitudes.fnuGetMedioRecepcion(inuPackage_Id);
      pkg_traza.trace('Medio de Recepcion: ' || nuMedioRecepcion,
                      csbNivelTraza);
    
      nuExisteMedioRecepcion := pkg_parametros.fnuValidaSiExisteCadena('MEDIO_RECEPCION_VALIDA_VISITA_CAMPO',
                                                                       ',',
                                                                       nuMedioRecepcion);
      IF nuExisteMedioRecepcion > 0 THEN
      
        sbRealizo_Visita := pkg_info_adicional_solicitud.fsbObtVALOR(inuPackage_Id,
                                                                     sbREALIZO_VISITA_EN_CAMPO);
        pkg_traza.trace('Realizo visita: ' || sbRealizo_Visita,
                        csbNivelTraza);
        IF sbRealizo_Visita = 'S' THEN
          nuRealizo_Visita := 0;
        END IF; --Fin de IF sbRealizo_Visita <> 'N' THEN
      
      END IF; --Fin de validacion IF nuExisteMedioRecepcion > 0 THEN
    
    END IF; --Fin de validacion IF nuExisteCategoria > 0 THEN
  
    pkg_traza.trace('Valor retornado: ' || nuRealizo_Visita, csbNivelTraza);
  
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
    RETURN nuRealizo_Visita;
  
  EXCEPTION
    WHEN pkg_error.Controlled_Error THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      pkg_error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError => ' || sbError, csbNivelTraza);
      RAISE pkg_error.Controlled_Error;
  END fnuRequiereVisitaCampo;

END pkg_bocambio_de_uso;
/
BEGIN
  -- OSF-3541
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_bocambio_de_uso'),
                                   UPPER('PERSONALIZACIONES'));
END;
/
