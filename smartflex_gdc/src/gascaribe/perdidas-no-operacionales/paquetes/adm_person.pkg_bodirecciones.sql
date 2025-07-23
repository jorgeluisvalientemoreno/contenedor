CREATE OR REPLACE PACKAGE adm_person.pkg_bodirecciones IS
  /*******************************************************************************
      Fuente=Propiedad Intelectual de Gases del Caribe
      pkg_bodirecciones
      Autor       :   Jorge Valiente
      Fecha       :   29-01-2024
      Descripcion :   Paquete con los metodos para manejo de informacion de generacion
                      de ordenes del venta de servicios de ingenieria
  
      Modificaciones  :
      Autor                   Fecha        Caso       Descripcion
      Jorge Valiente         29-01-2024    OSF-1993   Creacion
      Luis Valencia          13-02-2024    OSF-3984   Se agrega el procedimiento
                                                      prcActuCategoriaySubcategoria
  *******************************************************************************/
  -- Retorna la causal de la orden
  FUNCTION fsbVersion RETURN VARCHAR2;

  FUNCTION fnuProductoPorDireccion(inuDireccion    number,
                                   inuTipoProducto number) RETURN number;

  --Servicio para retornar el ciclo configurado en el segmento de la direccion
  FUNCTION fnuObtieneCicloPorDireccion(inuDireccion number) RETURN number;

  --Metodo para obtener el ciclo configurado en la direccion por GIS o ya sea por OSF.
  FUNCTION fnuObtieneCicloVentas(inuCodigoDirecion number) RETURN number;

  --Actualiza categoria y subcategoría en ab_premise
  PROCEDURE prcActuCategoriaySubcategoria 
  (
      inuContrato         IN  servsusc.sesususc%TYPE,
      inuCategoria        IN  servsusc.sesucate%TYPE,
      inuSubcategoria     IN  servsusc.sesusuca%TYPE
  );

END pkg_bodirecciones;
/

CREATE OR REPLACE PACKAGE BODY ADM_PERSON.pkg_bodirecciones IS

  -- Constantes para el control de la traza
  csbSP_NAME    CONSTANT VARCHAR2(100) := $$PLSQL_UNIT;
  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  -- Identificador del ultimo caso que hizo cambios
  csbVersion CONSTANT VARCHAR2(15) := 'OSF-3984';

  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe

  Programa        : fsbVersion
  Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor         : Jorge Valiente
    Fecha         : 29-01-2024

    Modificaciones  :
    Autor                   Fecha        Caso       Descripcion
    Jorge Valiente         29-01-2024    OSF-1993   Creacion
  ***************************************************************************/
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fnuProductoPorDireccion
      Descripcion     : funcion que valida si la actividad a generar esta
                        parametrizada por tipo de trabajo
      Autor           : Jorge Valiente
      Fecha           : 29-01-2024
      Parametros de Entrada
          inuProducto             Producto
          inuActividad         codigo de la actividad
      Parametros de Salida
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso      Descripcion
  Jorge Valiente  06/08/2024  OSF-3076  Reemplazar el servicio PR_BOProduct.fnuPrInAddrByProdTy por el
                                        servicio PR_BOProduct.fnugetprodbyaddrprodtype
  ***************************************************************************/
  FUNCTION fnuProductoPorDireccion(inuDireccion    number,
                                   inuTipoProducto number) RETURN number IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuProductoPorDireccion';

    sbError VARCHAR2(4000);
    nuError NUMBER;

    nuProducto number := 0;
  BEGIN
    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    pkg_traza.trace('Codigo Direccion: ' || inuDireccion,
                    pkg_traza.cnuNivelTrzDef);

    nuProducto := PR_BOProduct.fnugetprodbyaddrprodtype(inuDireccion,
                                                        inuTipoProducto);

    RETURN nuProducto;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      RAISE pkg_Error.Controlled_Error;
      --Validacion de error no controlado
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END fnuProductoPorDireccion;

  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fnuObtieneCicloPorDireccion
      Descripcion     : Servicio para retornar el ciclo configurado en la direccion
      Autor           : Jorge Valiente
      Fecha           : 16-10-2024
      Parametros de Entrada
          inuDireccion            Codigo Direccion
      Parametros de Salida
          nuCiclo                 Ciclo
      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso      Descripcion
  ***************************************************************************/
  FUNCTION fnuObtieneCicloPorDireccion(inuDireccion number) RETURN number IS
    csbMetodo CONSTANT VARCHAR2(70) := csbSP_NAME ||
                                       'fnuObtieneCicloPorDireccion';

    sbError VARCHAR2(4000);
    nuError NUMBER;

    nuCiclo number := 0;
  BEGIN

    pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

    pkg_traza.trace('Codigo Direccion: ' || inuDireccion,
                    pkg_traza.cnuNivelTrzDef);

    nuCiclo := AB_BOADDRESS.FNUGETCICLFACT(inuDireccion);

    pkg_traza.trace('Servicio AB_BOADDRESS.FNUGETCICLFACT retorna el Ciclo: ' ||
                    nuCiclo,
                    pkg_traza.cnuNivelTrzDef);

    RETURN nuCiclo;

  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      return(-1);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace('Error: ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      return(-1);
  END fnuObtieneCicloPorDireccion;

  FUNCTION fnuObtieneCicloVentas(inuCodigoDirecion number)

   RETURN NUMBER IS

    /*****************************************************************
    Propiedad intelectual de GDC.

    Unidad         : fnuObtieneCicloVentas
    Descripcion    : Metodo para obtener el ciclo configurado en la direccion por GIS o ya sea por OSF.
    Autor          : Jorge Valiente
    Fecha          : 16-10-2024
    Caso           : OSF-3054

    Parametros           Descripcion
    ============         ===================
    inuCodigoDirecion     Codigo de direccion

    Historia de Modificaciones
    Fecha         Autor                         Modificacion
    ===============================================================
    ******************************************************************/

    csbMetodo CONSTANT VARCHAR2(100) := 'fnuObtieneCicloVentas'; --nombre del metodo

    --Cursor para obtener datos del predio con relacion a la direccion
    cursor cuDataDireccion is
      select AB_PREMISE.category_                  Categoria,
             AB_PREMISE.subcategory_               SubCategoria,
             AB_ADDRESS.Geograp_Location_Id        Localidad,
             ge_geogra_location.geo_loca_father_id Departamento
        from AB_ADDRESS, AB_PREMISE, ge_geogra_location
       where AB_ADDRESS.ADDRESS_ID = inuCodigoDirecion
         and AB_ADDRESS.Estate_Number = AB_PREMISE.PREMISE_ID
         and ge_geogra_location.geograp_location_id =
             AB_ADDRESS.Geograp_Location_Id;

    rfDataDireccion cuDataDireccion%rowtype;

    cursor cuExisteDato(inuDato number, isbValorParametro varchar2) is
      select count(1)
        from dual
       where inuDato in
             (SELECT to_number(regexp_substr(isbValorParametro,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS column_value
                FROM dual
              CONNECT BY regexp_substr(isbValorParametro, '[^,]+', 1, LEVEL) IS NOT NULL);

    nuExisteCategoria number := 0;
    nuExisteError     number := 0;

    --Varaible para establecer categorias que obtendra ciclo configurado en GIS
    sbCategoriaVentaGasCotizada varchar2(4000) := pkg_parametros.fsbGetValorCadena('CATEGORIA_VENTA_GAS_COTIZADA_CICLO_GIS');
    --Varaible para establecer error que permite continuar con la venta de gas cotizada
    sbCodigoErrorVentaGasCotizada varchar2(4000) := pkg_parametros.fsbGetValorCadena('CODIGO_ERROR_PERMITE_VENTA_GAS_COTIZADA_CICLO_GIS');

    inuDepartamento number;
    inuCategoria    number;
    inuSubCategoria number;
    oclRespuesta    clob;
    onuCodError     number;
    osbMensajeError varchar2(4000);
    nuCiclo         number := -1;

    --Cadena constante cuando el resultado del servicio de integraciones con GIS es exitso.
    sbExitoMensaje varchar2(4000) := 'SUCCESS - "CICLO":';

    OnuErrorCode    number;
    OsbErrorMessage varchar2(4000);

    nuNivelTraza number := pkg_traza.cnuNivelTrzDef;
    
    procedure prCloseCursor is
    /*****************************************************************
        Propiedad intelectual de GDC.
    
        Unidad         : prCloseCursor
        Descripcion    : Metodo para cerrar los cursores
        Autor          : Jorge Valiente
        Fecha          : 16-10-2024
        Caso           : OSF-3054
    
        Parametros           Descripcion
        ============         ===================
    
        Historia de Modificaciones
        Fecha         Autor                         Modificacion
    ===============================================================
    ******************************************************************/  
      csbMetodo1 CONSTANT VARCHAR2(100) := csbMetodo||'.prCloseCursor'; --nombre del metodo
    begin 
         pkg_traza.trace(csbMetodo1, nuNivelTraza, pkg_traza.csbINICIO);
         if cuDataDireccion%isopen then close cuDataDireccion; end if;        
         if cuExisteDato%isopen then close cuExisteDato; end if;
        pkg_traza.trace(csbMetodo1, nuNivelTraza, pkg_traza.csbFIN);    
    end prCloseCursor;

  BEGIN

    pkg_traza.trace(csbMetodo, nuNivelTraza, pkg_traza.csbINICIO);

    pkg_traza.trace('Codigo Direccion:  ' || inuCodigoDirecion,
                    nuNivelTraza);
     
    prCloseCursor;
    
    --Cursor para obtener data de la direccion relacionada a la venta de gas cotizada
    open cuDataDireccion;
    fetch cuDataDireccion
      into rfDataDireccion;
    if cuDataDireccion%found then

      inuDepartamento := rfDataDireccion.Departamento;
      inuCategoria    := rfDataDireccion.Categoria;
      inuSubCategoria := rfDataDireccion.Subcategoria;

      pkg_traza.trace('Departamento:  ' || inuDepartamento, nuNivelTraza);
      pkg_traza.trace('Categoria:  ' || inuCategoria, nuNivelTraza);
      pkg_traza.trace('Subcategoria:  ' || inuSubCategoria, nuNivelTraza);

      --Cursor para validar si la categoria esta configurada en el parametro
      open cuExisteDato(inuCategoria, sbCategoriaVentaGasCotizada);
      fetch cuExisteDato    into nuExisteCategoria;
      close cuExisteDato;

      pkg_traza.trace('Existe codigo Categoria en parametro:  ' ||
                      nuExisteCategoria,
                      nuNivelTraza);

      if nuExisteCategoria = 1 then

        LDCI_PKG_BOINTEGRAGIS.prcObtenerCiclo(inuDepartamento,
                                              inuCategoria,
                                              inuSubCategoria,
                                              oclRespuesta,
                                              onuCodError,
                                              osbMensajeError);

        pkg_traza.trace('Codigo Error:  ' || onuCodError, nuNivelTraza);
        pkg_traza.trace('Mensaje Error:  ' || osbMensajeError,
                        nuNivelTraza);

        if onuCodError = 0 then

          --Sustrae el ciclo proveniente de una cadena desde el servicio de integraciones si es exitoso.
          nuCiclo := SUBSTR(osbMensajeError, length(sbExitoMensaje) + 1);
          pkg_traza.trace('Ciclo GIS: ' || nuCiclo, nuNivelTraza);

        else

          --Cursor para validar si el error permitira continuar con la venta de gas cotizada con el ciclo configurado en OSF
          open cuExisteDato(onuCodError, sbCodigoErrorVentaGasCotizada);
          fetch cuExisteDato
            into nuExisteError;
          close cuExisteDato;

          pkg_traza.trace('Existe codigo error en parametro:  ' ||
                          nuExisteError,
                          nuNivelTraza);

          if nuExisteError = 1 then
            nuCiclo := pkg_bodirecciones.fnuObtieneCicloPorDireccion(inuCodigoDirecion);
            pkg_traza.trace('Ciclo OSF: ' || nuCiclo, nuNivelTraza);
          else            
            Pkg_Error.SetErrorMessage(onuCodError, osbMensajeError);
          end if;

        end if;
      else
        nuCiclo := pkg_bodirecciones.fnuObtieneCicloPorDireccion(inuCodigoDirecion);
        pkg_traza.trace('Ciclo OSF: ' || nuCiclo, nuNivelTraza);
      end if;
    else      
      Pkg_Error.SetErrorMessage(isbMsgErrr => 'La direccion no tiene configurado predio y/o segmento');
    end if;

    close cuDataDireccion;

    pkg_traza.trace(csbMetodo, nuNivelTraza, pkg_traza.csbFIN);

    RETURN(nuCiclo);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      prCloseCursor;
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      
      RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      prCloseCursor;
      pkg_traza.trace(csbMetodo,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
  END fnuObtieneCicloVentas;


  /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcActuCategoriaySubcategoria  
      Descripcion     : Actualiza cartegoria y subcategoria de ab_premise
      Autor           : 
      Fecha           : 13/02/2025
      Parametros de Entrada
      inuContrato     Código del contrato,
      inuCategoria    Código de la categoría,
      inuSubcategoria Código de la subcategoria

      Parametros de Salida        
      Modificaciones  :
      =========================================================
      Autor               Fecha               Descripción
      felipe.valencia     13/02/2025          OSF-3984: Creación
  ***************************************************************************/
  PROCEDURE prcActuCategoriaySubcategoria 
  (
      inuContrato         IN  servsusc.sesususc%TYPE,
      inuCategoria        IN  servsusc.sesucate%TYPE,
      inuSubcategoria     IN  servsusc.sesusuca%TYPE
  )
  IS
      sbError             VARCHAR2(4000);
      nuError             NUMBER;   
      csbMetodo           CONSTANT VARCHAR2(100) := csbSP_NAME||'prcActuCategoriaySubcategoria';
      
      tbproductos         pkg_bcproducto.tytbsbtProducto;
      nuIndice            NUMBER;        
      nuPredio            NUMBER;
  BEGIN
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);    

      pkg_traza.trace('inuContrato: ' || inuContrato, pkg_traza.cnuNivelTrzDef); 
      pkg_traza.trace('inuCategoria: ' || inuCategoria, pkg_traza.cnuNivelTrzDef);   
      pkg_traza.trace('inuSubcategoria: ' || inuSubcategoria, pkg_traza.cnuNivelTrzDef); 

      tbproductos := pkg_bcproducto.ftbObtProductosPorContrato(inuContrato);
      
      nuIndice := tbproductos.first;
      LOOP
          EXIT WHEN nuIndice IS NULL;
          
          nuPredio := pkg_bcInfoPredio.fnuObtienePredio(tbproductos(nuIndice).address_id);
          
          IF ( inuCategoria IS NOT NULL)THEN
              pkg_ab_premise.prAcCATEGORY_(nuPredio, inuCategoria);
              pkg_ab_premise.prAcSUBCATEGORY_(nuPredio,inuSubcategoria);
          ELSE
              pkg_ab_premise.prAcSUBCATEGORY_(nuPredio,inuSubcategoria);
          END IF;
          
          nuIndice := tbproductos.next( nuIndice );
      END LOOP;
      pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
      WHEN pkg_Error.Controlled_Error  THEN
          pkg_Error.getError(nuError, sbError);
          pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
          RAISE pkg_Error.Controlled_Error;
      WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError(nuError, sbError);
          pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
          RAISE pkg_Error.Controlled_Error;
  END prcActuCategoriaySubcategoria;
END pkg_bodirecciones;
/

BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_BODIRECCIONES', 'ADM_PERSON');
END;
/    