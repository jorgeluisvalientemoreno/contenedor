create or replace PACKAGE   personalizaciones.pkg_bcldcgpad IS
 TYPE tyrcDiferidos IS RECORD ( nuDiferido   diferido.difecodi%type,
                                nuSaldoDife  diferido.difesape%type,
                                nuProducto   diferido.difenuse%type);

 TYPE tytblDiferidos IS TABLE OF tyrcDiferidos INDEX BY VARCHAR2(20);

 TYPE tyrcContratos IS RECORD ( nuContrato   ldc_contabdi.CONTRATO%type);

 TYPE tytblContratos IS TABLE OF tyrcContratos INDEX BY VARCHAR2(20);

 FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
  PROCEDURE prcObtInfoAboDifexVali ( inuContrato    IN  NUMBER,
                                     onuPerioActual OUT NUMBER,       
                                     odtFechaFin    OUT DATE,
                                     onuCiclo       OUT NUMBER,
                                     onuCantDif     OUT NUMBER,
                                     onuError       OUT NUMBER,
                                     osbError       OUT VARCHAR2);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtInfoAboDifexVali
    Descripcion     : obtienen informacion para la validacion de abono a diferido del contrato
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuContrato    codigo del contrato
    Parametros de salida
     onuPerioActual  periodo de facturacion actual
     odtFechaFin     fecha fin de movimiento
     onuCiclo        ciclo
     onuCantDif      cantidad de diferidos
     onuerror        codigo de error 0 - exito -1 error
     osbError        mensaje de error

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
  FUNCTION fnuObtFacturaxPeriodo ( inuContrato    IN  NUMBER,
                                   inuPerioActual IN  NUMBER) RETURN NUMBER;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtFacturaxPeriodo
    Descripcion     : Obtiene factura recurrente de un periodo y contrato especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuContrato    codigo del contrato
     inuPerioActual periodo de facturacion actual
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
  FUNCTION fnuObtValorConsumo ( inuFactura    IN  NUMBER,
                                inuPerioActual IN  NUMBER) RETURN NUMBER;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtValorConsumo
    Descripcion     : Obtiene consumo de una factura y periodo de facturacion especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuFactura    codigo de la factura 
     inuPerioActual periodo de facturacion actual
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/

   FUNCTION fnuObtCuentaCobro ( inuFactura   IN  NUMBER,
                                inuProducto  IN  NUMBER) RETURN NUMBER;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCuentaCobro
    Descripcion     : Obtiene factura de una factura y producto especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Parametros Entrada
     inuFactura    codigo de la factura 
     inuProducto   codigo del producto
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/

  FUNCTION ftblObtDiferidosaProc ( inuContrato    IN  NUMBER) RETURN tytblDiferidos;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftblObtDiferidosaProc
    Descripcion     : Obtiene consumo de una factura y periodo de faturacion especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Parametros Entrada
     inuContrato    codigo de contrato
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
  
  
  FUNCTION ftblObtContratosaProc ( inuCiclo    IN  NUMBER) RETURN tytblContratos;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftblObtContratosaProc
    Descripcion     : Obtiene contratos a procesar
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Parametros Entrada
     inuCiclo    codigo de ciclo
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
END pkg_bcldcgpad;
/
create or replace PACKAGE BODY  personalizaciones.pkg_bcldcgpad IS

csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3650';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
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

  PROCEDURE prcObtInfoAboDifexVali ( inuContrato    IN  NUMBER,
                                     onuPerioActual OUT NUMBER,
                                     odtFechaFin    OUT DATE,
                                     onuCiclo       OUT NUMBER,
                                     onuCantDif     OUT NUMBER,
                                     onuError       OUT NUMBER,
                                     osbError       OUT VARCHAR2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtInfoAboDifexVali
    Descripcion     : obtienen informacion para la validacion de abono a diferido del contrato
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuContrato    codigo del contrato
    Parametros de salida
     onuPerioActual  periodo de facturacion actual
     odtFechaFin     fecha fin de movimiento
     onuCiclo        ciclo
     onuCantDif      cantidad de diferidos
     onuerror        codigo de error 0 - exito -1 error
     osbError        mensaje de error

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcObtInfoAboDifexVali';

    CURSOR cuCantDiferido IS
    SELECT count(1)
    FROM diferido
    WHERE difesusc = inuContrato
     AND NVL(DIFEENRE,'N') = 'N'
     AND difesape > 0;

    rcPeriodo   perifact%rowtype;

    PROCEDURE prcInicializaValores IS
      csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.prcInicializaValores';
    BEGIN
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       pkg_error.prInicializaError(onuError,osbError);
       onuciclo := NULL;
       onuCantDif := 0;
       onuPerioActual := NULL;
       odtFechaFin := NULL;
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prcInicializaValores;

    PROCEDURE prcCierraCursores IS
      csbMT_NAME1      VARCHAR2(100) := csbMT_NAME || '.prcCierraCursores';
    BEGIN
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       IF cuCantDiferido%ISOPEN THEN    CLOSE cuCantDiferido;  END IF;
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prcCierraCursores;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    prcInicializaValores;
    prcCierraCursores;
    onuciclo := pkg_bccontrato.fnuCicloFacturacion(inuContrato);
    rcPeriodo := pkg_bogestionperiodos.frcObtPeriodoFacturacionActual(onuciclo);

    onuPerioActual := rcPeriodo.pefacodi;
    odtFechaFin    := rcPeriodo.pefaffmo;

    OPEN cuCantDiferido;
    FETCH cuCantDiferido INTO onuCantDif;
    CLOSE cuCantDiferido;

    pkg_traza.trace('onuPerioActual => ' || onuPerioActual, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('odtFechaFin => ' || odtFechaFin, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('onuCantDif => ' || onuCantDif, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(onuError,osbError);
        prcCierraCursores;
        pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(onuError,osbError);
        prcCierraCursores;
        pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
 END prcObtInfoAboDifexVali;
 FUNCTION fnuObtFacturaxPeriodo ( inuContrato    IN  NUMBER,
                                  inuPerioActual IN  NUMBER) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtFacturaxPeriodo
    Descripcion     : Obtiene factura recurrente deun periodo y contrato especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuContrato    codigo del contrato
     inuPerioActual periodo de facturacion actual
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtFacturaxPeriodo';
    nuFactura      NUMBER;
    CURSOR cuObtFacturaActual IS
    SELECT factcodi
    FROM factura
    WHERE factpefa = inuPerioActual
     AND factsusc = inuContrato
     AND factprog = 6;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuPerioActual => ' || inuPerioActual, pkg_traza.cnuNivelTrzDef);

    IF cuObtFacturaActual%ISOPEN THEN   CLOSE cuObtFacturaActual;  END IF;

    OPEN cuObtFacturaActual;
    FETCH cuObtFacturaActual INTO nuFactura;
    CLOSE cuObtFacturaActual;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuFactura;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR ;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR ;
 END fnuObtFacturaxPeriodo;

 FUNCTION fnuObtValorConsumo ( inuFactura    IN  NUMBER,
                               inuPerioActual IN  NUMBER) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtValorConsumo
    Descripcion     : Obtiene consumo de una factura y periodo de faturacion especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 21-01-2025

    Parametros Entrada
     inuFactura    codigo de la factura
     inuPerioActual periodo de facturacion actual
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      21-01-2025   OSF-3650    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtValorConsumo';
    nuConsumo      NUMBER;

    CURSOR cuObtConsumos IS
    SELECT NVL(SUM(NVL(CONSUMO,0)),0)
    FROM (
          SELECT sum(decode(cargsign, 'DB', cargvalo, -cargvalo)) CONSUMO
          FROM cargos, cuencobr
          WHERE cucofact = inuFactura
             AND cargcuco = cucocodi
             AND cargconc in (31, 196)
             AND cargcaca = 15
             AND cargprog = 5
             AND cargdoso NOT LIKE '%-PR%'
          UNION ALL
          SELECT sum(decode(cargsign, 'DB', cargvalo, -cargvalo))
          FROM cargos, cuencobr
          WHERE cucofact = inuFactura
             AND cargcuco = cucocodi
             AND cargconc in (130, 167)
             AND cargpefa = inuPerioActual
             AND cargpeco = ( SELECT MAX(c1.cargpeco)
                              FROM cargos c1
                              WHERE c1.cargconc = 31
                               AND c1.cargcuco = cucocodi
                               AND C1.cargcaca = 15
                               AND C1.cargprog = 5
                               AND C1.cargdoso NOT LIKE '%-PR%'));
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuPerioActual => ' || inuPerioActual, pkg_traza.cnuNivelTrzDef);
    IF cuObtConsumos%ISOPEN THEN   CLOSE cuObtConsumos;   END IF;
    OPEN cuObtConsumos;
    FETCH cuObtConsumos INTO nuConsumo;
    CLOSE cuObtConsumos;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuConsumo;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR ;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR ;
  END fnuObtValorConsumo;

  FUNCTION fnuObtCuentaCobro ( inuFactura   IN  NUMBER,
                               inuProducto  IN  NUMBER) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuObtCuentaCobro
    Descripcion     : Obtiene factura de una factura y producto especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Parametros Entrada
     inuFactura    codigo de la factura
     inuProducto   codigo del producto
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuObtCuentaCobro';
    nuCuenCobr     NUMBER;
    CURSOR cuObtCuentaCobro IS
    SELECT CUCOCODI
    FROM CUENCOBR
    WHERE cuconuse = inuProducto
      AND cucofact = inuFactura;

   BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuProducto => ' || inuProducto, pkg_traza.cnuNivelTrzDef);

    IF cuObtCuentaCobro%ISOPEN THEN  CLOSE cuObtCuentaCobro;  END IF;
    OPEN cuObtCuentaCobro;
    FETCH cuObtCuentaCobro INTO  nuCuenCobr;
    CLOSE cuObtCuentaCobro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuCuenCobr;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR ;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR ;
  END fnuObtCuentaCobro;
  FUNCTION ftblObtDiferidosaProc ( inuContrato    IN  NUMBER) RETURN tytblDiferidos IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftblObtDiferidosaProc
    Descripcion     : Obtiene consumo de una factura y periodo de faturacion especifico
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Parametros Entrada
     inuContrato    codigo de contrato
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.ftblObtDiferidosaProc';

   CURSOR cuObtDiferido IS
   SELECT difecodi, difesape, difenuse
   FROM diferido
   WHERE difesusc = inuContrato
     AND NVL(DIFEENRE,'N') = 'N'
     AND difesape > 0
    ORDER BY difefein, difecodi ;

   v_tytblDiferidos tytblDiferidos;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);

    FOR idx IN cuObtDiferido LOOP
        v_tytblDiferidos(idx.difecodi).nuDiferido := idx.difecodi;
        v_tytblDiferidos(idx.difecodi).nuSaldoDife := idx.difesape;
        v_tytblDiferidos(idx.difecodi).nuProducto := idx.difenuse;
    END LOOP;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN v_tytblDiferidos;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR ;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR ;
 END ftblObtDiferidosaProc;
 
 FUNCTION ftblObtContratosaProc ( inuCiclo    IN  NUMBER) RETURN tytblContratos IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftblObtContratosaProc
    Descripcion     : Obtiene contratos a procesar
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-01-2025

    Parametros Entrada
     inuCiclo    codigo de ciclo
    Parametros de salida

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-01-2025   OSF-3650    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.ftblObtContratosaProc';

    CURSOR cuObtContratos(inuCiclo IN NUMBER) IS
    SELECT  ldc_contabdi.CONTRATO
    FROM ldc_contabdi, suscripc
    WHERE suscripc.susccodi = ldc_contabdi.contrato
         AND suscripc.susccicl = inuCiclo ;
     

   v_tytblContratos tytblContratos;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace('inuCiclo => ' || inuCiclo, pkg_traza.cnuNivelTrzDef);

    FOR idx IN cuObtContratos(inuCiclo) LOOP
        v_tytblContratos(idx.CONTRATO).nuContrato := idx.CONTRATO;
    END LOOP;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN v_tytblContratos;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_error.CONTROLLED_ERROR ;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_error.CONTROLLED_ERROR ;
 END ftblObtContratosaProc;
END pkg_bcldcgpad; 
/
Prompt Otorgando permisos sobre PERSONALIZACIONES.PKG_BCLDCGPAD
BEGIN
    pkg_Utilidades.prAplicarPermisos('PKG_BCLDCGPAD', 'PERSONALIZACIONES');
END;
/