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
        inuDireccion        Codigo Motivo
        
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

END pkg_bocambio_de_uso;
/
BEGIN
  -- OSF-3541
  pkg_Utilidades.prAplicarPermisos(UPPER('pkg_bocambio_de_uso'),
                                   UPPER('PERSONALIZACIONES'));
END;
/
