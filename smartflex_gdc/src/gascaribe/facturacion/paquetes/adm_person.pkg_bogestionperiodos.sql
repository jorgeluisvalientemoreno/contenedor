create or replace package            ADM_PERSON.pkg_bogestionperiodos IS
  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 24-12-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB        24-12-2024   OSF-3741    Creacion
  ***************************************************************************/
  PROCEDURE prcValiPeriodoConsConf ( inuciclo	  IN	ciclo.ciclcodi%TYPE,
                                     inucontrato  IN	suscripc.susccodi%TYPE DEFAULT -1,
                                     inuPeriFact  IN	perifact.pefacodi%TYPE );
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcValiPeriodoConsConf
    Descripcion     : proceso valida que haya un periodo de consumo configurado para el ciclo y periodo de facturacion
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 24-12-2024

    Parametros Entrada
       inuciclo       ciclo de facturacion
       inucontrato    contrato
       inuPeriFact    periodo de facturacion
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB        24-12-2024   OSF-3741    Creacion
  ***************************************************************************/
   PROCEDURE prcObtPeriodoFactSigu ( inuPeriFact	  IN	perifact.pefacodi%TYPE,
                                     onuPeriFaSigu	  OUT	perifact.pefacodi%TYPE );
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtPeriodoFactSigu
    Descripcion     : proceso que obtiene el siguiente periodo de facturacion, teniendo en cuenta el ingresado
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 26-12-2024

    Parametros Entrada
       inuPeriFact    periodo de facturacion
    Parametros de salida
       onuPeriFaSigu    periodo de facturacion siguiente
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
     LJLB        24-12-2024   OSF-3741    Creacion
  ***************************************************************************/
    -- Retorna periodo de facturación actual
    FUNCTION frcObtPeriodoFacturacionActual  (  inuciclo  IN ciclo.ciclcodi%TYPE  )   RETURN perifact%ROWTYPE;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frcObtPeriodoFacturacionActual
        Descripcion     : Obtiene periodo de facturación actual
        Autor           : Luis Felipe Valencia
        Fecha           : 13-01-2025
    
        Parametros Entrada
           inuciclo       ciclo de facturacion
        Parametros de salida
    
        Modificaciones  :
        Autor       Fecha         Caso       Descripcion
         fvalencia   13-01-2025   OSF-3741  Creacion
  ***************************************************************************/

   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtienePeriodoConsumoActual
    Descripcion     : Obtiene perido de consumo actual
    Fecha           : 21-03-2025

    Parametros Entrada

    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    fvalencia  21-03-2025   OSF-3846    Creacion
  ***************************************************************************/
  PROCEDURE prcObtienePeriodoConsumoActual 
  ( 
      inuciclo	         IN	ciclcons.cicocodi%TYPE,
      InuCodigoperiodo	IN	perifact.pefacodi%TYPE,
      onuPeriodoConsumo	OUT pericose.pecscons%TYPE,
      isbServicio IN  servicio.servtico%TYPE DEFAULT 'V',
      isbTipoPer  IN  concepto.concticc%TYPE DEFAULT constants_per.CSBCONSUMO
   ) ;
END pkg_bogestionperiodos;
/
create or replace package body   ADM_PERSON.pkg_bogestionperiodos IS
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-4294';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 24-12-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB        24-12-2024   OSF-3741    Creacion
  ***************************************************************************/
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN csbVersion;
     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
   END fsbVersion;
  PROCEDURE prcValiPeriodoConsConf ( inuciclo	  IN	ciclo.ciclcodi%TYPE,
                                     inucontrato  IN	suscripc.susccodi%TYPE DEFAULT -1,
                                     inuPeriFact  IN	perifact.pefacodi%TYPE ) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcValiPeriodoConsConf
    Descripcion     : proceso valida que haya un periodo de consumo configurado para el ciclo y periodo de facturacion
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 24-12-2024

    Parametros Entrada
       inuciclo       ciclo de facturacion
       inucontrato    contrato
       inuPeriFact    periodo de facturacion
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB        24-12-2024   OSF-3741    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.prcValiPeriodoConsConf';
  BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuciclo => ' || inuciclo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inucontrato => ' || inucontrato, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuPeriFact => ' || inuPeriFact, pkg_traza.cnuNivelTrzDef);
        PKBCPERICOSE.VALCNSMPRDCONFIG ( inuciclo,
                                        inucontrato,
                                        inuPeriFact );
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

     EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
   END prcValiPeriodoConsConf;
   PROCEDURE prcObtPeriodoFactSigu ( inuPeriFact	  IN	perifact.pefacodi%TYPE,
                                     onuPeriFaSigu	  OUT	perifact.pefacodi%TYPE ) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtPeriodoFactSigu
    Descripcion     : proceso que obtiene el siguiente periodo de facturacion, teniendo en cuenta el ingresado
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 26-12-2024

    Parametros Entrada
       inuPeriFact    periodo de facturacion
    Parametros de salida
       onuPeriFaSigu    periodo de facturacion siguiente
    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
     LJLB        24-12-2024   OSF-3741    Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.prcObtPeriodoFactSigu';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuPeriFact => ' || inuPeriFact, pkg_traza.cnuNivelTrzDef);
    pkbillingperiodmgr.getnextbillperiod(inuPeriFact, onuPeriFaSigu);
    pkg_traza.trace('onuPeriFaSigu => ' || onuPeriFaSigu, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR;
   END prcObtPeriodoFactSigu;
   
    FUNCTION frcObtPeriodoFacturacionActual (   inuciclo  IN ciclo.ciclcodi%TYPE  )   RETURN perifact%ROWTYPE
    IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtPeriodoFacturacionActual
    Descripcion     : Obtiene periodo de facturación actual
    Autor           : Luis Felipe Valencia
    Fecha           : 13-01-2025

    Parametros Entrada
       inuciclo       ciclo de facturacion
    Parametros de salida

    Modificaciones  :
    Autor       Fecha         Caso       Descripcion
     fvalencia   13-01-2025   OSF-3741  Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.frcObtPeriodoFacturacionActual';
    rcPeriodo       perifact%ROWTYPE;  
  BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuciclo => ' || inuciclo, pkg_traza.cnuNivelTrzDef);
        
        rcPeriodo := pkBillingPeriodMgr.frcGetAccCurrentPeriod(inuciclo);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        
        RETURN rcPeriodo;
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN rcPeriodo;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN rcPeriodo;
   END frcObtPeriodoFacturacionActual;

  PROCEDURE prcObtienePeriodoConsumoActual 
  ( 
      inuciclo	         IN	ciclcons.cicocodi%TYPE,
      InuCodigoperiodo	IN	perifact.pefacodi%TYPE,
      onuPeriodoConsumo	OUT pericose.pecscons%TYPE,
      isbServicio IN  servicio.servtico%TYPE DEFAULT 'V',
      isbTipoPer  IN  concepto.concticc%TYPE DEFAULT constants_per.CSBCONSUMO
   ) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtienePeriodoConsumoActual
    Descripcion     : Obtiene perido de consumo actual
    Fecha           : 21-03-2025

    Parametros Entrada

    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    fvalencia  21-03-2025   OSF-3846    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.prcObtienePeriodoConsumoActual';
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace('inuciclo => ' || inuciclo, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('InuCodigoperiodo => ' || InuCodigoperiodo, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('isbServicio => ' || isbServicio, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace('isbTipoPer => ' || isbTipoPer, pkg_traza.cnuNivelTrzDef);
      pkBCPericose.GetCacheConsPerByBillPer
      (
         inuciclo,
         InuCodigoperiodo,
         onuPeriodoConsumo,
         isbServicio,
         isbTipoPer          
      );
      pkg_traza.trace('onuPeriodoConsumo => ' || onuPeriodoConsumo, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

   EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
         pkg_error.geterror(nuError,sbError);
         pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
         RAISE pkg_error.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         pkg_error.setError;
         pkg_error.geterror(nuError,sbError);
         pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
         pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
         RAISE pkg_error.CONTROLLED_ERROR;
   END prcObtienePeriodoConsumoActual;
END pkg_bogestionperiodos;  
/
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOGESTIONPERIODOS','ADM_PERSON');
END;
/