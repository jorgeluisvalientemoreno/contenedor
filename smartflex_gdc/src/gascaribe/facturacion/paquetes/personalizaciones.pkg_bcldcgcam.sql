create or replace PACKAGE  personalizaciones.pkg_bcldcgcam IS
  SUBTYPE styConsulta         IS         VARCHAR2(32767);
  SUBTYPE styAtributos        IS         VARCHAR2(32767);
  
    --se retorna periodo
  CURSOR cugetPeriodo(inuPeriodo NUMBER) IS
  SELECT pefacodi,
        pefafege,
        pefadesc,
       pefacicl,
       pefaano,
       pefames,
       to_char(ldc_boconsgenerales.fdtgetsysdate(), ldc_boconsgenerales.fsbgetformatofecha) fecha,
       pefafimo,
       pefaffmo
  FROM perifact
  WHERE pefacodi = inuPeriodo;
  
  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-11-2024   OSF-3540    Creacion
  ***************************************************************************/
  FUNCTION fnuValidaPrecedencia( isbProcesAEje  IN VARCHAR2,
                                 inuPeriodoFact IN NUMBER,
                                 inuCiclo       IN NUMBER) RETURN NUMBER ;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuValidaPrecedencia
    Descripcion     : funcion para validar precedencia del proceso facturacion
                      forma LDCGCAM

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 02-01-2025

    Parametros de Entrada
      isbProcesAEje     Proceso a ejecutar
      inuPeriodoFact    Periodo de facturacion
      inuCiclo          ciclo de facturacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       22-11-2024   OSF-3540    Creacion
  ***************************************************************************/
  FUNCTION  frfConsulta(isbProceso  IN VARCHAR2,
                        isbFechaMov IN VARCHAR2) RETURN CONSTANTS_PER.TYREFCURSOR;
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frfConsulta
        Descripcion     : funcion para retornar resultado de la forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada
           isbProceso   proceso a ejecutar
           isbFechaMov  fecha final de movimiento
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
    ***************************************************************************/
  FUNCTION frcObtPeriodoFacturacion (inuPeriodo IN NUMBER) RETURN cugetPeriodo%ROWTYPE;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtPeriodoFacturacion
    Descripcion     : funcion para retornar un registro del periodo de facturacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2024

    Parametros de Entrada
       inuPeriodo  periodo de facturacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       14-01-2025   OSF-3540    Creacion
    ***************************************************************************/
END pkg_bcldcgcam;
/
create or replace PACKAGE BODY personalizaciones.pkg_bcldcgcam IS
  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3540';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);
  sbCiclo             VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_CICLEXPCA');
  sbdateformat VARCHAR2(100):= LDC_BOCONSGENERALES.FSBGETFORMATOFECHA;

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-11-2024   OSF-3540    Creacion
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

  FUNCTION fnuValidaPrecedencia( isbProcesAEje  IN VARCHAR2,
                                 inuPeriodoFact IN NUMBER,
                                 inuCiclo       IN NUMBER) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuValidaPrecedencia
    Descripcion     : funcion para validar precedencia del proceso facturacion
                      forma LDCGCAM

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 02-01-2025

    Parametros de Entrada
      isbProcesAEje     Proceso a ejecutar
      inuPeriodoFact    Periodo de facturacion
      inuCiclo          ciclo de facturacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       22-11-2024   OSF-3540    Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fnuValidaPrecedencia';
     nuAplicaPrec    NUMBER := 1;
     sbExisteEje     VARCHAR2(1);

     CURSOR cuValidaPrece IS
     SELECT pp.PROCCODI procreque
     FROM cocoprci, procesos po, procesos pp
     WHERE cocoprci.ccpcinpr = po.proccons
         AND po.proccodi = isbProcesAEje
         AND cocoprci.ccpccicl = inuCiclo
         AND pp.proccons = cocoprci.ccpcprre ;

     CURSOR cuExisteEjec(isbProceReque IN VARCHAR2) IS
     SELECT 'X'
     FROM procejec
     WHERE procejec.prejcope = inuPeriodoFact
         AND PREJPROG = isbProceReque
         AND PREJESPR = 'T';

     CURSOR cuValidaAuditoria(isbProceso IN VARCHAR) IS
     SELECT 'X'
     FROM LDC_VALIDGENAUDPREVIAS pf
     WHERE pf.PROCESO = isbProceso
        AND pf.COD_PEFACODI =inuPeriodoFact;

    PROCEDURE prCloseCursor IS
     csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prCloseCursor';
    BEGIN
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        IF cuExisteEjec%ISOPEN THEN
            CLOSE cuExisteEjec;
        END IF;
        IF cuValidaAuditoria%ISOPEN THEN
           CLOSE cuValidaAuditoria;
        END IF;
        pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    END prCloseCursor;

  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     FOR reg IN cuValidaPrece LOOP
       prCloseCursor;
       sbExisteEje := NULL;
       pkg_traza.trace(' Proceso Requerido => ' || reg.procreque, pkg_traza.cnuNivelTrzDef);
       OPEN cuExisteEjec(reg.procreque);
       FETCH cuExisteEjec INTO sbExisteEje;
       CLOSE cuExisteEjec;

       IF sbExisteEje IS NULL THEN
          nuAplicaPrec := 0;
       ELSIF isbProcesAEje = 'FGCA' THEN
          sbExisteEje := NULL;
          OPEN cuValidaAuditoria('AUDPREV');
          FETCH cuValidaAuditoria INTO sbExisteEje;
          IF cuValidaAuditoria%NOTFOUND THEN
              nuAplicaPrec := 0;
          END IF;
          CLOSE cuValidaAuditoria;
       ELSIF isbProcesAEje = 'FGCC' THEN
          sbExisteEje := NULL;
          OPEN cuValidaAuditoria('AUDPOST');
          FETCH cuValidaAuditoria INTO sbExisteEje;
          IF cuValidaAuditoria%NOTFOUND THEN
              nuAplicaPrec := 0;
          END IF;
          CLOSE cuValidaAuditoria;
       END IF;
       pkg_traza.trace(' nuAplicaPrec => ' || nuAplicaPrec, pkg_traza.cnuNivelTrzDef);

     END LOOP;
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     RETURN nuAplicaPrec;
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RETURN nuAplicaPrec;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RETURN nuAplicaPrec;
  END fnuValidaPrecedencia;

  FUNCTION fstyObtAtributos RETURN  styAtributos IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fstyObtAtributos
        Descripcion     : funcion para retornar atributos de la consulta de la
                          forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
    ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fstyObtAtributos';
     sbAtributosPeriodo  styAtributos;
   BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

     --se agregan atributos
     pkg_boutilidades.pradicionatributos('    p.pefacodi', '"Periodo"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('    p.PEFADESC', '"Descripcion"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('    p.PEFACICL', '"Ciclo"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('  (SELECT cicldesc FROM ciclo c WHERE C.CICLCODI=  p.PEFACICL)', '"Descripcion_Ciclo"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('    p.PEFAFIMO', '"Fecha_Inicio_Movimiento"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('    p.PEFAFFMO', '"Fecha_final_Movimiento"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('    p.PEFAFEPA', '"Fecha_Pago"', sbAtributosPeriodo);
     pkg_boutilidades.pradicionatributos('   p.PEFAFEGE', '"Fecha_Generacion"', sbAtributosPeriodo);
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

     RETURN sbAtributosPeriodo;
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
  END fstyObtAtributos;
  FUNCTION FRFOBTPERIFGCC Return CONSTANTS_PER.TYREFCURSOR IS
  /**************************************************************************
      Autor       : Horbath
      Proceso     : FRFOBTPERIFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es FGCC

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.FRFOBTPERIFGCC';
    rfresult        CONSTANTS_PER.TYREFCURSOR;

    sbattributesperiodo styAtributos;
    sbfrom              styConsulta;
    sqlPeriodos        styConsulta;

  BEGIN
     --se agregan atributos
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

     sbattributesperiodo := fstyOBTAtributos;

     sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                    '  FROM PERIFACT P '|| chr(10) ||
                    ' WHERE  trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10)||'
                        AND p.pefacicl not in ('||sbCiclo||')
						AND p.pefaactu = ''S''
                        AND pkg_bcldcgcam.fnuValidaPrecedencia(''FGCC'',p.pefacodi,p.pefacicl) = 1
                        AND NOT EXISTS ( SELECT 1
                                         FROM PROCEJEC
                                         WHERE PREJCOPE =P.pefacodi
                                           and PREJPROG = ''FGCC'')
                        AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 2 )';
     pkg_traza.trace('sqlPeriodos '||sqlPeriodos, pkg_traza.cnuNivelTrzDef);
     OPEN rfresult FOR sqlPeriodos ;

     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    return rfresult;
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
 end FRFOBTPERIFGCC;

 FUNCTION 	FRFOBTPERIFIDF(isbFechaMov IN VARCHAR2) Return CONSTANTS_PER.TYREFCURSOR IS
 /**************************************************************************
  Autor       : Horbath
  Proceso     : FRFOBTPERIFIDF
  Fecha       : 2020-13-11
  Ticket      : 461
  Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es FIDF

  Parametros Entrada

  Valor de salida

  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  26/07/2021   LJLB       CA 696 se valida si la fecha final de movimiento es no nula
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.FRFOBTPERIFIDF';
    rfresult CONSTANTS_PER.TYREFCURSOR;

    sbattributesperiodo styAtributos;
    sbfrom              styConsulta;
    sqlPeriodos         styConsulta;

  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     pkg_traza.trace('isbFechaMov => '||isbFechaMov, pkg_traza.cnuNivelTrzDef);
     sbattributesperiodo := fstyOBTAtributos;

     sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                    '  FROM PERIFACT P '|| chr(10);

       IF isbFechaMov IS NOT NULL  THEN
         sqlPeriodos := sqlPeriodos||  ' WHERE  trunc(P.pefaffmo)  = TRUNC(to_date('''||isbFechaMov||''','''||sbdateformat||'''))'|| chr(10);
       ELSE
          sqlPeriodos := sqlPeriodos|| ' WHERE  trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10);
       END IF;

       sqlPeriodos :=  sqlPeriodos||' AND p.pefaactu = ''S''
                      AND p.pefacicl not in ('||sbCiclo||')
                                                AND NOT  EXISTS  ( SELECT 1
                                                                  FROM ESTAPROG
                                                                  WHERE ESPRPEFA = P.pefacodi
                                                                   AND ESPRPROG LIKE ''FIDF%''
                                               and ESPRPORC <> 100
                                                     )
                      AND pkg_bcldcgcam.fnuValidaPrecedencia(''FIDF'',p.pefacodi,p.pefacicl) = 1
                      AND EXISTS ( SELECT 1
                                   FROM PROCEJEC
                                    WHERE PREJCOPE =P.pefacodi
                                       AND PREJPROG = ''FGDP''
                                       AND PREJESPR = ''T'')
                        AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 3 )';
      pkg_traza.trace('sqlPeriodos '||sqlPeriodos, pkg_traza.cnuNivelTrzDef);
      OPEN rfresult FOR sqlPeriodos ;

      return rfresult;
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
 end FRFOBTPERIFIDF;

 FUNCTION 	FRFOBTPERIFCPE(isbFechaMov IN VARCHAR2) Return CONSTANTS_PER.TYREFCURSOR IS
  /**************************************************************************
      Autor       : Horbath
      Proceso     : FRFOBTPERIFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es fcpe

      Parametros Entrada
        isbFechaMov    fecha final de movimiento
      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
       26/07/2021   LJLB       CA 696 se valida si la fecha final de movimiento es no nula
    ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.FRFOBTPERIFCPE';
    rfresult CONSTANTS_PER.TYREFCURSOR;

    sbattributesperiodo styAtributos;
    sbfrom              styConsulta;
    sqlPeriodos         styConsulta;

  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     sbattributesperiodo := fstyOBTAtributos;

     sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                    '  FROM PERIFACT P '|| chr(10);

      IF isbFechaMov IS NOT NULL  THEN
         sqlPeriodos := sqlPeriodos||  ' WHERE  trunc(P.pefaffmo)  = TRUNC(to_date('''||isbFechaMov||''','''||sbdateformat||'''))'|| chr(10);
      ELSE
         sqlPeriodos := sqlPeriodos|| ' WHERE  trunc(P.pefaffmo)  = to_date('''||trunc(sysdate)||''','''||sbdateformat||''')'|| chr(10);
      END IF;

      sqlPeriodos :=  sqlPeriodos|| ' AND p.pefaactu = ''S''
						AND p.pefacicl not in ('||sbCiclo||')
                        AND NOT EXISTS ( SELECT 1
                                         FROM PROCEJEC
                                         WHERE PREJCOPE =P.pefacodi
                                           and PREJPROG = ''FCPE'' )
					    AND pkg_bcldcgcam.fnuValidaPrecedencia(''FCPE'',p.pefacodi,p.pefacicl) = 1
                        AND EXISTS ( SELECT 1
									 FROM PROCEJEC
									 WHERE PREJCOPE =P.pefacodi
									   and PREJPROG = ''FGDP''
									   AND PREJESPR = ''T'')
                        AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 4 )';
      pkg_traza.trace('sqlPeriodos '||sqlPeriodos, pkg_traza.cnuNivelTrzDef);
      OPEN rfresult FOR sqlPeriodos ;

      RETURN rfresult;
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
 end FRFOBTPERIFCPE;

 FUNCTION 	FRFOBTPERIFGCA Return CONSTANTS_PER.TYREFCURSOR IS
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios
      Proceso     : FRFGETPERIFGCA
      Fecha       : 2024-02-01
      Ticket      : OSF-3640
      Descripcion : funcion que se encarga de llenar PB [LDCGCAM] cuando proceso es FGCA

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
       2024-02-01   LJLB       Creacion
    ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.FRFOBTPERIFGCA';
    rfresult CONSTANTS_PER.TYREFCURSOR;

    sbattributesperiodo styAtributos;
    sbfrom              styConsulta;
    sqlPeriodos         styConsulta;
    sbwhere             styConsulta;
    nuPais              NUMBER := PKG_BCLD_PARAMETER.fnuObtieneValorNumerico('CODIGO_PAIS');
    nuDiasRetraso       NUMBER := pkg_parametros.fnuGetValorNumerico('DIAS_RETRASO_FGCA');
  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     sbattributesperiodo := fstyOBTAtributos;
     pkg_traza.trace('nuPais => '||nuPais, pkg_traza.cnuNivelTrzDef);
     pkg_traza.trace('nuDiasRetraso => '||nuDiasRetraso, pkg_traza.cnuNivelTrzDef);
 	sbwhere := '  WHERE trunc(P.pefaffmo)  = (SELECT date_
                                                FROM (
                                                        SELECT date_  , rownum id_num
                                                        FROM ge_calendar
                                                        WHERE country_id = '||nuPais||'
                                                         AND day_type_id = 1
                                                         AND date_ > trunc(sysdate)
                                                         ORDER BY date_)
                                                WHERE id_num = '||nuDiasRetraso||')'|| chr(10)||'
					   AND p.pefaactu = ''S''
					   AND p.pefacicl not in ('||sbCiclo||')
                       AND pkg_bcldcgcam.fnuValidaPrecedencia(''FGCA'',p.pefacodi,p.pefacicl) = 1
					   AND NOT EXISTS ( SELECT 1
										 FROM PROCEJEC
										 WHERE PREJCOPE =P.pefacodi
										   and PREJPROG = ''FGCA'')
						AND NOT EXISTS (SELECT 1 FROM LDC_PERIPROG WHERE PEPRPEFA = P.pefacodi AND PEPRFLAG = ''N'' and PROCESO = 1 )';


       sbfrom := ' PERIFACT P';

       pkg_traza.trace('sbattributesperiodo '||sbattributesperiodo, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace('sbfrom '||sbfrom, pkg_traza.cnuNivelTrzDef);

       sqlPeriodos := ' SELECT '||sbattributesperiodo|| chr(10) ||
                      '  FROM '||sbfrom|| chr(10) ||
                       sbwhere;

      pkg_traza.trace('sqlPeriodos '||sqlPeriodos, pkg_traza.cnuNivelTrzDef);
      OPEN rfresult FOR sqlPeriodos ;

      RETURN rfresult;
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
 end FRFOBTPERIFGCA;

  FUNCTION  frfConsulta(isbProceso  IN VARCHAR2,
                        isbFechaMov IN VARCHAR2) RETURN CONSTANTS_PER.TYREFCURSOR IS
  /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frfConsulta
        Descripcion     : funcion para retornar resultado de la forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada
           isbProceso   proceso a ejecutar
           isbFechaMov  fecha final de movimiento
        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
    ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frfConsulta';
      rfResultado CONSTANTS_PER.TYREFCURSOR;
    BEGIN
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	   pkg_traza.trace(' isbProceso => ' || isbProceso, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace(' isbFechaMov => ' || isbFechaMov, pkg_traza.cnuNivelTrzDef);
       IF isbProceso = 1 THEN
          rfResultado := FRFOBTPERIFGCA;
       ELSIF isbProceso = 2 THEN
          rfResultado := FRFOBTPERIFGCC;
       ELSIF isbProceso = 3 THEN
          rfResultado := FRFOBTPERIFIDF(isbFechaMov);
       ELSE
          rfResultado :=  FRFOBTPERIFCPE(isbFechaMov);
       END IF;
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
       RETURN rfResultado;
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
   END frfConsulta;
   
   FUNCTION frcObtPeriodoFacturacion (inuPeriodo IN NUMBER) RETURN cugetPeriodo%ROWTYPE IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcObtPeriodoFacturacion
    Descripcion     : funcion para retornar un registro del periodo de facturacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2024

    Parametros de Entrada
       inuPeriodo  periodo de facturacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       14-01-2025   OSF-3540    Creacion
    ***************************************************************************/
     csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.frcObtPeriodoFacturacion';
     regPeriodo  cugetPeriodo%ROWTYPE;
      
   BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	 pkg_traza.trace(' inuPeriodo => ' || inuPeriodo, pkg_traza.cnuNivelTrzDef);
     --se obtienen datos del periodo
     IF cugetPeriodo%ISOPEN THEN  CLOSE cugetPeriodo; END IF;

     OPEN cugetPeriodo(inuPeriodo);
     FETCH cugetPeriodo INTO regPeriodo;
     CLOSE cugetPeriodo;
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     RETURN regPeriodo;
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
   END frcObtPeriodoFacturacion;
END pkg_bcldcgcam;  
/  
PROMPT OTORGA PERMISOS ESQUEMA sobre pkg_bcldcgcam
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BCLDCGCAM', 'PERSONALIZACIONES'); 
END;
/