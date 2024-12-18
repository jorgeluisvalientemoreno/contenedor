create or replace PACKAGE personalizaciones.pkg_bcGestionConsumoDp IS
/***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : pkg_bcGestionConsumoDp
    Descripcion     : Paquete para gestión de desviacionesa

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 19-03-2024

    Modificaciones  :
    =========================================================
    Fecha           Autor       Descripcion
    19-03-2024      LJLB        OSF-2494    Creacion
    24/07/2024      jcatuche    OSF-3018: Se ajusta la función fblValidaProdDesv
    16/09/2024      jcatuche    OSF-3295: Se ajusta la función fblValidaProdDesv
  ***************************************************************************/
  
  FUNCTION fblValidaProdDesv ( inuProducto    IN   NUMBER,
                                inuContrato    IN   NUMBER,
                                inuConsumo     IN   NUMBER,
                                inuPeriFact    IN   NUMBER DEFAULT NULL,
                                inuPericons    IN   NUMBER DEFAULT NULL,
                                idtFechLean    IN   DATE,
                                idtFechLeac    IN   DATE,
                                isbGuardaLog   IN   VARCHAR2 DEFAULT 'S',
                                onuCumpleRegla OUT  NUMBER,
                                osbRowId       OUT  VARCHAR2) RETURN BOOLEAN;
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblValidaProdDesv
    Descripcion     : funcion que retorna si un producto esta desviado o no

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 19-03-2024

    Parametros de Entrada
      inuProducto         codigo del producto
      inuContrato         codigo del contrato
      inuConsumo          metros cubicos consumido
      inuPeriFact         periodo de facturacion actual
      inuPericons         periodo de consumo actual
      idtFechLean         fecha de lectura anterior
      idtFechLeac         fecha de lectura actual
      isbGuardaLog        indica si se guarda informacion en la tabla de desviaciones por producto
    Parametros de Salida
      onuCumpleRegla    devuelve 0 si no cumple regla de desviacion o 1 si cumple con la regla
      osbRowId          rowid del registro de informacion de producto de desviacion
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        19-03-2024   OSF-2494    Creacion
  ***************************************************************************/

    FUNCTION fnuDevuelveCausalOTCritica ( inuProducto    IN   NUMBER,
										  inuPericons    IN   NUMBER) RETURN NUMBER;


END pkg_bcGestionConsumoDp;  
/
create or replace PACKAGE BODY   personalizaciones.pkg_bcGestionConsumoDp IS
  -- Constantes para el control de la traza
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3295';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);
  nuDiasNormalizar    parametros.valor_numerico%type := pkg_parametros.fnugetvalornumerico('NUMERO_DIAS_NORMALIZAR');


   FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 19-03-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB        19-03-2024   OSF-2494    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  FUNCTION fnuDevuelveConsNormal ( inuConsumo     IN   NUMBER,
                                   inuDiasCons    IN   NUMBER) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuDevuelveConsNormal
    Descripcion     : funcion que retorna consumo normalizado

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 19-03-2024

    Parametros de Entrada
     inuConsumo          metros cubicos consumido
      inuDiasCons         dias de consumo
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        19-03-2024  OSF-2494    Creacion
    ***************************************************************************/
    csbMT_NAME       VARCHAR2(100) := csbSP_NAME || '.fnuDevuelveConsNormal';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN (CASE WHEN inuDiasCons =  0 THEN 0 ELSE (inuConsumo / inuDiasCons * nuDiasNormalizar) END);
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
  END fnuDevuelveConsNormal;

  FUNCTION fblValidaProdDesv ( inuProducto    IN   NUMBER,
                               inuContrato    IN   NUMBER,
                               inuConsumo     IN   NUMBER,
                               inuPeriFact    IN   NUMBER DEFAULT NULL,
                               inuPericons    IN   NUMBER DEFAULT NULL,
                               idtFechLean    IN   DATE,
                               idtFechLeac    IN   DATE,
                               isbGuardaLog   IN   VARCHAR2 DEFAULT 'S',
                               onuCumpleRegla OUT  NUMBER,
                               osbRowId       OUT  VARCHAR2) RETURN BOOLEAN IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblValidaProdDesv
    Descripcion     : funcion que retorna si un producto esta desviado o no

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 19-03-2024

    Parametros de Entrada
      inuProducto         codigo del producto
      inuContrato         codigo del contrato
      inuConsumo          metros cubicos consumido
      inuPeriFact         periodo de facturacion actual
      inuPericons         periodo de consumo actual
      idtFechLean         fecha de lectura anterior
      idtFechLeac         fecha de lectura actual
      isbGuardaLog        indica si se guarda informacion en la tabla de desviaciones por producto
    Parametros de Salida
      onuCumpleRegla    devuelve 0 si no cumple regla de desviacion o 1 si cumple con la regla
      osbRowId          rowid del registro de informacion de producto de desviacion
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        19-03-2024  OSF-2494    Creacion
    jcatuche    24-07-2024  OSF-3018    Se ajusta cursor cuGetInfoDesviacion adicionando validación de cossdias cero para evitar error división por cero
    jcatuche    16/09/2024  OSF-3295    Se añade validación para periodos con consumos liquidados, si el periodo no tiene todos los consumos liquidados no se tiene en cuenta
                                        Sub consulta consumos del query cuGetInfoDesviacion
  ***************************************************************************/
    csbMT_NAME         VARCHAR2(100) := csbSP_NAME || '.fblValidaProdDesv';
    blProdDesviado     BOOLEAN;
    nuConsuNormalizado NUMBER;

    nuMesesConsVali     parametros.valor_numerico%type := pkg_parametros.fnugetvalornumerico('NUMERO_MESES_CONSVALI');
    nuMetodoDifLect     parametros.valor_numerico%type := pkg_parametros.fnugetvalornumerico('METODO_CONS_DIFELECT');
    nuNumCalLimSupe     parametros.valor_numerico%type := pkg_parametros.fnugetvalornumerico('NUMERO_CALC_LIMISUPERIOR');
    sbFormulaDifLect    parametros.valor_cadena%type := pkg_parametros.fsbgetvalorcadena('FORMULA_CONS_DIFELECT');
    nuMesesCalcConsVal  parametros.valor_numerico%type := pkg_parametros.fnugetvalornumerico('MESES_CONS_CONSVALI');

    dtFechaIniAnti   DATE  := add_months(idtFechLeac, -nuMesesConsVali);
    sbExiste         VARCHAR2(1);
    nuDiasConsumo    NUMBER;

    regInfoProdDesvpobl     pkg_info_producto_desvpobl.styInfoProductoDesvpobl;
    regInfoProdDesvpoblNull pkg_info_producto_desvpobl.styInfoProductoDesvpobl;

    CURSOR cuValidaAntiguedad IS
    SELECT 'X'
    FROM servsusc
    WHERE sesunuse = inuProducto
     AND sesufein <= dtFechaIniAnti;

    CURSOR CudiasPeriodoConsumo IS
    SELECT (trunc(idtFechLeac) - (trunc(idtFechLean) + 1 ) )  + 1
    FROM dual;

    CURSOR cuGetInfoDesviacion IS
    WITH periodos AS
    ( SELECT *
      FROM (
            SELECT pa.pefacodi
            FROM perifact pa, perifact a
            WHERE pa.pefacodi <> ( inuPeriFact)
             AND pa.pefaffmo BETWEEN add_months(a.pefafimo, -nuMesesCalcConsVal) AND a.pefafimo
              AND pa.pefacicl = a.pefacicl
              AND a.pefacodi= inuPeriFact
            ORDER BY pa.pefaffmo DESC)
            WHERE ROWNUM<= nuMesesCalcConsVal),
     consumos AS
           (
            SELECT  cossfere, (nvl(cosssuma, 0) / (case when nvl(cossdias,0) = 0 then cossdico else cossdias end) * nuDiasNormalizar)  consumo_normalizado,
                    nvl(cosssuma, 0) consumo_normal
            FROM vw_cmprodconsumptions
            WHERE  cossmecc = nuMetodoDifLect
                 AND cosssesu = inuProducto
                 AND cossfufa LIKE sbFormulaDifLect||'%'
                 AND cosspefa IN (SELECT * FROM periodos)
                 AND nvl(cosssuma, 0) > 0
                 AND nvl(calcflli,'N') = 'S'
            ORDER BY cossfere DESC),
     UltimosConsumoVali AS
            ( SELECT consumo_normalizado
              FROM consumos
              WHERE  ROWNUM <= nuMesesConsVali
            ) ,
     ConsumoAProcesar AS (
            SELECT AVG(consumo_normalizado) consumo_promedio,
                   STDDEV_POP(consumo_normalizado) desviacion
            FROM UltimosConsumoVali
            HAVING COUNT(1) = nuMesesConsVali)
    SELECT consumo_promedio,
           desviacion,
           (desviacion * nuNumCalLimSupe + consumo_promedio) Limite_superior,
           CASE WHEN (consumo_promedio - desviacion * nuNumCalLimSupe) < 0 THEN
                   0
                ELSE
                    consumo_promedio - desviacion * nuNumCalLimSupe
           END limite_inferior
    FROM ConsumoAProcesar;

    rgInfoDesviacion      cuGetInfoDesviacion%rowtype;
    rgInfoDesviacionnull  cuGetInfoDesviacion%rowtype;
    v_styInfoProdDesvpobl pkg_info_producto_desvpobl.styInfoProdDesvpobl;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuGetInfoDesviacion%ISOPEN THEN
           CLOSE cuGetInfoDesviacion;
        END IF;

        IF cuValidaAntiguedad%ISOPEN THEN
           CLOSE cuValidaAntiguedad;
        END IF;

        IF CudiasPeriodoConsumo%ISOPEN THEN
           CLOSE CudiasPeriodoConsumo;
        END IF;

        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

    PROCEDURE prInicializaValores IS
      csbMT_NAME1      VARCHAR2(150) := csbSP_NAME || '.prInicializaValores';
    BEGIN
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       onuCumpleRegla := 0;
       rgInfoDesviacion := rgInfoDesviacionnull;
       regInfoProdDesvpobl := regInfoProdDesvpoblnull;
       sbExiste  := NULL;
       blProdDesviado := FALSE;
       nuConsuNormalizado := 0;
       nuDiasConsumo := 0;
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prInicializaValores;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuProducto => ' || inuProducto, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuConsumo => ' || inuConsumo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuPeriFact => ' || inuPeriFact, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuPericons => ' || inuPericons, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' idtFechLeac => ' || idtFechLeac, pkg_traza.cnuNivelTrzDef);

    pkg_traza.trace(' isbGuardaLog => ' || isbGuardaLog, pkg_traza.cnuNivelTrzDef);
    prCloseCursor;
    --se inicia producto como que no cumple la regla
    prInicializaValores;

    pkg_traza.trace(' dtFechaIniAnti => ' || dtFechaIniAnti, pkg_traza.cnuNivelTrzDef);
    --se valida si el producto cumple los meses de antiguedad en la empresa
    OPEN cuValidaAntiguedad;
    FETCH cuValidaAntiguedad INTO sbExiste;
    IF cuValidaAntiguedad%NOTFOUND THEN
       CLOSE cuValidaAntiguedad;
        pkg_traza.trace(' No Cumple antiguedad, salgo del proceso.', pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
       RETURN blProdDesviado;
    END IF;
    CLOSE cuValidaAntiguedad;

    OPEN cuGetInfoDesviacion;
    FETCH cuGetInfoDesviacion INTO rgInfoDesviacion;
    IF cuGetInfoDesviacion%NOTFOUND THEN
        CLOSE cuGetInfoDesviacion;
        pkg_traza.trace(' No Cumple con los consumos validos, salgo del proceso.', pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN blProdDesviado;
    END IF;
    CLOSE cuGetInfoDesviacion;

    OPEN CudiasPeriodoConsumo;
    FETCH CudiasPeriodoConsumo INTO nuDiasConsumo;
    CLOSE CudiasPeriodoConsumo;
    pkg_traza.trace(' nuDiasConsumo => '||nuDiasConsumo, pkg_traza.cnuNivelTrzDef);
    nuConsuNormalizado := fnuDevuelveConsNormal(inuConsumo, nuDiasConsumo);

    blProdDesviado     := NOT (nuConsuNormalizado BETWEEN rgInfoDesviacion.limite_inferior AND rgInfoDesviacion.Limite_superior);
    onuCumpleRegla     := 1;
    regInfoProdDesvpobl.tipo_desviacion := constants_per.csbno;
    IF blProdDesviado THEN
       IF nuConsuNormalizado < rgInfoDesviacion.limite_inferior THEN
           regInfoProdDesvpobl.tipo_desviacion := 'D';
       ELSE
          regInfoProdDesvpobl.tipo_desviacion := 'A';
       END IF;
    END IF;

    IF isbGuardaLog = constants_per.csbsi THEN
       v_styInfoProdDesvpobl := pkg_info_producto_desvpobl.frcGetInfoProdDesvpobl( inuContrato,
                                                                                   inuPeriFact,
                                                                                   inuPericons);

       IF v_styInfoProdDesvpobl.id_reg IS NOT NULL THEN
          pkg_info_producto_desvpobl.prActEstadoProdDesvpobl(v_styInfoProdDesvpobl.id_reg, 'I');
       END IF;
       regInfoProdDesvpobl.producto               := inuProducto;
       regInfoProdDesvpobl.contrato               := inuContrato;
       regInfoProdDesvpobl.periodo_facturacion    := inuPeriFact;
       regInfoProdDesvpobl.periodo_consumo        := inuPericons;
       regInfoProdDesvpobl.consumo_actual         := nuConsuNormalizado;
       regInfoProdDesvpobl.consumo_promedio       := rgInfoDesviacion.consumo_promedio;
       regInfoProdDesvpobl.desviacion_poblacional := rgInfoDesviacion.desviacion;
       regInfoProdDesvpobl.fecha_registro         := sysdate;
       --se inserta registro
       pkg_info_producto_desvpobl.prInsInfoProdDesvpobl( regInfoProdDesvpobl, osbRowId);

    END IF;

    IF blProdDesviado THEN
        pkg_traza.trace(' Producto Desviado ', pkg_traza.cnuNivelTrzDef);
    ELSE
      pkg_traza.trace(' Producto No Desviado ', pkg_traza.cnuNivelTrzDef);
    END IF;
    pkg_traza.trace(' nuConsuNormalizado => ' || nuConsuNormalizado, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' onuCumpleRegla => ' || onuCumpleRegla, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN blProdDesviado;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_error.geterror(nuError,sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      prCloseCursor;
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       prCloseCursor;
       RAISE pkg_error.CONTROLLED_ERROR;
  END fblValidaProdDesv;


  FUNCTION fnuDevuelveCausalOTCritica ( inuProducto    IN   NUMBER,
										inuPericons    IN   NUMBER) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuDevuelveCausalOTCritica
    Descripcion     : funcion que retorna causal de legalización de la orden de critica (si existe) del periodo

    Autor           : Jhon Soto
    Fecha           : 25-06-2024

    Parametros de Entrada
     inuProducto        Id de producto
     inuPericons        periodo de consumo actual
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    JSOTO       25-06-2024  OSF-2494    Creacion
   ***************************************************************************/
    csbMT_NAME       	VARCHAR2(100) := csbSP_NAME || '.fnuDevuelveCausalOTCritica';
	nuCausalOtCritica	NUMBER := NULL;

	CURSOR cuCausalOtCritica IS
      SELECT b.causal_id
      FROM cm_ordecrit a, or_order b
      WHERE a.orcrorde = b.order_id
      AND a.orcrsesu = inuProducto
      AND a.orcrpeco = inuPericons
	  AND b.order_status_id = pkg_gestionordenes.cnuordencerrada;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

	OPEN cuCausalOtCritica;
	FETCH cuCausalOtCritica INTO nuCausalOtCritica;
    IF cuCausalOtCritica%NOTFOUND THEN
       CLOSE cuCausalOtCritica;
        pkg_traza.trace(' No tiene una orden de critica para el periodo de consumo.', pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
       RETURN nuCausalOtCritica;
    END IF;
    CLOSE cuCausalOtCritica;	

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    RETURN nuCausalOtCritica;

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
  END fnuDevuelveCausalOTCritica;

END pkg_bcGestionConsumoDp;
/
BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_BCGESTIONCONSUMODP', 'PERSONALIZACIONES'); 
END;
/