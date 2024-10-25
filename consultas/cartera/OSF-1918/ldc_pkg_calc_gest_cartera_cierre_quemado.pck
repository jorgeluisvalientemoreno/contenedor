CREATE OR REPLACE PACKAGE ldc_pkg_calc_gest_cartera IS
  /******************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon / Horbath Technologies
        Fecha       : 01/02/2019
        Ticket      : 200-2272
        Descripcion : Registra modificaciones de registros de la tabla LDC_TARIFAS_GESTCART a la tabla de auditoria : LDC_TARIFAS_GESTCART_AUDI.


            HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
    15/07/2019    200-2704        Elkin Alvarez     Se modifican los procedimientos ldc_procliquidacion, ldc_procinimetamin, ldc_procnormalizados, ldc_proccalcvalorpagar.
                                                    Se crea nuevo procedimiento ldc_legaordergestcart
    26/08/2019    200-2704        Elkin Alvarez     Se actualiza logica de todos lor procedimientos existentes y se adicionan los procedimientos ldc_proActuTarifa, PrcLiquidaProdRecup y la funcion fnugetRecaudo
    15/10/2019    0000141(v8)     HORBATH           Se actualiza logica de todos los procedimientos existentes para manejar tener en cuenta la configuracion de metas y tarifas por grupo de categoria.
	09/05/2022  	OSF-266		  CGONZALEZ			Se modifican los servicios <ldc_procliquidacion><ldc_procinicmeta><ldc_procinimetamin>
													<ldc_procnormalizados><ldc_legaordergestcart_hilos>
    15/07/2022  	OSF-428		  CGONZALEZ			Se modifica el servicio <ldc_procnormalizados>
	11/08/2023		OSF-1389	  jerazomvm			Se modifican los servicios:
														- PrcLiquidaProdRecup
														- ldc_legaordergestcart_hilos
														- LDC_geneasilegaact
														- ldc_procliquidacion
														- ldc_procinicmeta
														- ldc_procinimetamin
														- ldc_procnormalizados
    30/11/2023		OSF-1918	  jpinedc			Se modifica ldc_legaordergestcart_hilos
  *******************************************************************************************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2;

  --PROCEDURE ldc_procliquidacion(nupaano NUMBER,nupames NUMBER);
  PROCEDURE ldc_procliquidacion(dtfechaini DATE,
                                dtfechafin DATE,
                                nupaano    NUMBER,
                                nupames    NUMBER,
                                sbForma    VARCHAR2);
  PROCEDURE ldc_procinicmeta(nupaanoact NUMBER,
                             nupamesact NUMBER,
                             dtpafein   DATE,
                             dtpafefi   DATE);
  PROCEDURE ldc_procinimetamin(nupaanoact NUMBER,
                               nupamesact NUMBER,
                               dtpafein   DATE,
                               dtpafefi   DATE);
  FUNCTION fnugetRecaudo(nuProducto IN NUMBER,
                         dtpafein   DATE,
                         dtpafefi   DATE) RETURN NUMBER;
  PROCEDURE ldc_procnormalizados(nuanoact NUMBER,
                                 numesact NUMBER,
                                 dtpafein DATE,
                                 dtpafefi DATE);
  PROCEDURE ldc_proActuTarifa(nuanoact IN NUMBER,
                              numesact IN NUMBER,
                              nuOk     OUT NUMBER,
                              sberror  OUT VARCHAR2);
  PROCEDURE PrcLiquidaProdRecup(nuanoact NUMBER,
                                numesact NUMBER,
                                onuok    OUT NUMBER,
                                sbError  OUT VARCHAR2);
  FUNCTION ldc_proccalcvalorpagar(nuunitoper NUMBER,
                                  tipoprod   NUMBEr,
                                  nuanoact   NUMBER,
                                  numesact   NUMBER) RETURN NUMBER;
  PROCEDURE ldc_legaordergestcart(nuanoact NUMBER,
                                  numesact NUMBER,
                                  dtpafein DATE,
                                  dtpafefi DATE,
                                  onuok    OUT NUMBER,
                                  sbError  OUT VARCHAR2);
  --
  PROCEDURE ldc_legaordergestcart_hilos(INUHILO    NUMBER,
                                        INUSESION  NUMBER,
                                        nuanoact   NUMBER,
                                        numesact   NUMBER,
                                        sbdtpafein VARCHAR2,
                                        sbdtpafefi VARCHAR2);
  --
  PROCEDURE LDC_geneasilegaact(nuproducto    IN NUMBER,
                               nuUnidad      IN NUMBER,
                               nucausal      IN NUMBER,
                               nuPersonaLega IN NUMBER,
                               nuactividad   IN NUMBER,
                               nuvalor       IN NUMBER,
                               onuOrden      OUT NUMBER,
                               onuok         OUT NUMBER,
                               sbError       OUT VARCHAR2);

  PROCEDURE proRegistraLog(sbProceso  IN LDC_LOGPROC.LOPRPROC%TYPE,
                           dtFecha    IN LDC_LOGPROC.LOPRFEGE%TYPE,
                           nuProducto IN LDC_LOGPROC.LOPRPROD%TYPE,
                           sbError    IN LDC_LOGPROC.LOPRERRO%TYPE,
                           nuSesion   IN LDC_LOGPROC.LOPRSESI%TYPE,
                           sbUsuario  IN LDC_LOGPROC.LOPRUSUA%TYPE);

END ldc_pkg_calc_gest_cartera;
/
CREATE OR REPLACE PACKAGE BODY ldc_pkg_calc_gest_cartera IS
  /******************************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon / Horbath Technologies
    Fecha       : 01/02/2019
    Ticket      : 200-2272
    Descripcion : Registra modificaciones de registros de la tabla LDC_TARIFAS_GESTCART a la tabla de auditoria : LDC_TARIFAS_GESTCART_AUDI.


            HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
    26/08/2019      200-2704      Elkin Alvarez     Se actualiza orden,llamado y logica de ejecucion de procedimientos
    15/10/2019      0000141       HORBATH           Se actualiza calculo de metas y tarifas teniendo en cuenta la configuracion por grupo de categorias
    24/10/2019      0000141(v8)   HORBATH (EHG)     Se Optimiza el proceso con manejo de Hilos. (OPT) OK++++(28)++ ldc_pkg_calc_gest_cartera.ldc_legaordergestcart_hilos OK++
	09/05/2022  	OSF-266		  CGONZALEZ			Se modifica el cursor Cu_UniOper para tener en cuenta los tipos de trabajos configurados
													en el parametro TT_GC_CARTERA
	14/08/2022		OSF-1389	  jerazomvm			1. Se ajusta el bloque de errores al estandar pkg_error
													2. Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
														SELECT to_number(regexp_substr(variable,
																		 '[^,]+',
																		 1,
																		 LEVEL)) AS alias
														FROM dual
														CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
  *******************************************************************************************************************************************************/
    csbSP_NAME      CONSTANT VARCHAR2(35)	:= $$PLSQL_UNIT||'.';
    csbNivelTraza   CONSTANT NUMBER(2)      := pkg_traza.fnuNivelTrzDef;
    csbVersion      VARCHAR2(10)            := 'OSF-1918';

    gnuTSess         NUMBER                  := PKG_SESSION.fnuGetSesion;
    gsbParUser       VARCHAR2(30)            := PKG_SESSION.GetUser;

    /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona la ultima WO que hizo cambios en el paquete
    Autor           : Lubin Pineda - MVM
    Fecha           : 06-12-2023
    Modificaciones  :
    Autor       Fecha       Caso    Descripcion
    jpinedc     06-12-2023  OSF-1918 Creacion
    ***************************************************************************/
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END fsbVersion;

    PROCEDURE ldc_procliquidacion(dtfechaini DATE,
                                dtfechafin DATE,
                                nupaano    NUMBER,
                                nupames    NUMBER,
                                sbForma    VARCHAR2)
    IS

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_procliquidacion';

        sbproceso  VARCHAR2(100)  := 'LDC_PROCLIQUIDACION'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        sbTt_Gc_Cartera		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('TT_GC_CARTERA', NULL);

        sbMensErrorT VARCHAR2(4000) := 'LA UNIDAD OPERATIVA NO CUENTA CON TARIFAS DEFINIDAS';
        sbMensErrorM VARCHAR2(4000) := 'LA UNIDAD OPERATIVA NO CUENTA CON METAS DEFINIDAS';
        sbMensErrorP VARCHAR2(4000) := 'NO EXISTE UNA PRELIQUIDACION PREVIA PARA EL CIERRE';

        sbError VARCHAR(4000);
        nuError  NUMBER;

        CantReg NUMBER;
        Tipo    VARCHAR2(1);
        NumReg  NUMBER;

        CURSOR Cu_UniOper IS
        SELECT DISTINCT o.operating_unit_id IdUniOper
        FROM or_order o, gc_coll_mgmt_pro_det x, ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                                                     '[^,]+',
                                                                     1,
                                                                     LEVEL)) AS columna
                                                  FROM dual
                                                  CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt
        WHERE o.task_type_id = TT.columna
        AND trunc(o.created_date) BETWEEN dtfechaini AND dtfechafin
        AND o.order_id = x.order_id
        AND o.ORDER_STATUS_ID = 5;

        CURSOR cuLDC_METAMENSUAL( inuUnidad NUMBER)
        IS
        SELECT COUNT(METAUNIOP) cantidad, 'M' dato
        FROM LDC_METAMENSUAL m
        WHERE m.METAUNIOP = inuUnidad
        AND SYSDATE BETWEEN m.META_FINICIAL AND m.META_FFINAL;

        CURSOR culdc_tarifas_gestcart( inuUnidad NUMBER)
        IS
        SELECT COUNT(unidad_operativa) cantidad, 'T' dato
        FROM ldc_tarifas_gestcart t
        WHERE t.unidad_operativa = inuUnidad
        AND SYSDATE BETWEEN t.fecha_inicial_vig AND t.fecha_final_vig;

        CURSOR culdc_metas_cont_gestcobr ( inuAno NUMBER, inuMes NUMBER)
        IS
        SELECT COUNT(*) cantidad
        FROM ldc_metas_cont_gestcobr t
        WHERE t.ano = inuAno
        AND t.mes = inuMes;

        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME || 'ldc_procliquidacion.prCierraCursores';
        BEGIN

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio);

            IF cuLDC_METAMENSUAL%ISOPEN THEN
                CLOSE cuLDC_METAMENSUAL;
            END IF;

            IF culdc_tarifas_gestcart%ISOPEN THEN
                CLOSE culdc_tarifas_gestcart;
            END IF;

            IF culdc_metas_cont_gestcobr%ISOPEN THEN
                CLOSE culdc_metas_cont_gestcobr;
            END IF;

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin);

       END prCierraCursores;

    BEGIN

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio);

	    prCierraCursores;

	    pkg_Traza.trace('dtfechaini: ' 	|| dtfechaini || chr(10) ||
                        'dtfechafin: ' 	|| dtfechafin || chr(10) ||
                        'nupaano: ' 	|| nupaano || chr(10) ||
                        'nupames: ' 	|| nupames || chr(10) ||
                        'sbForma: ' 	|| sbForma, csbNivelTraza);


        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        FOR i IN Cu_UniOper LOOP

            CantReg := 0;
            Tipo    := 0;

            OPEN cuLDC_METAMENSUAL( i.IdUniOper );
            FETCH cuLDC_METAMENSUAL INTO CantReg, Tipo;
            CLOSE cuLDC_METAMENSUAL;

            IF (Tipo = 'M' AND CantReg = 0) THEN
                proRegistraLog('VALIDACION 200-2704',
                               SYSDATE,
                               i.IdUniOper,
                               sbMensErrorM,
                               gnutsess,
                               gsbparuser);
            END IF;

            CantReg := 0;
            Tipo    := 0;

            OPEN culdc_tarifas_gestcart( i.IdUniOper );
            FETCH culdc_tarifas_gestcart INTO CantReg, Tipo;
            CLOSE culdc_tarifas_gestcart;

            IF (Tipo = 'T' AND CantReg = 0) THEN
                proRegistraLog('VALIDACION 200-2704',
                               SYSDATE,
                               i.IdUniOper,
                               sbMensErrorT,
                               gnutsess,
                               gsbparuser);
            END IF;

        END LOOP;

        IF (sbForma = 'P') THEN

            ldc_procinicmeta(nupaano, nupames, dtfechaini, dtfechafin);
            ldc_procinimetamin(nupaano, nupames, dtfechaini, dtfechafin);
            ldc_procnormalizados(nupaano, nupames, dtfechaini, dtfechafin);
            ldc_proActuTarifa(nupaano, nupames, nuError, sbError);

        END IF;

        IF (sbForma = 'C') THEN

            --se valida que exista una preliquidacion, antes de generar el cierre del proceso de gestion de cartera
            OPEN culdc_metas_cont_gestcobr ( nupaano, nupames );
            FETCH culdc_metas_cont_gestcobr INTO NumReg;
            CLOSE culdc_metas_cont_gestcobr;

            IF (NumReg > 0) THEN
                ldc_proActuTarifa(nupaano, nupames, nuError, sbError);
                PrcLiquidaProdRecup(nupaano, nupames, nuError, sbError);
                ldc_legaordergestcart(nupaano,
                                      nupames,
                                      dtfechaini,
                                      dtfechafin,
                                      nuError,
                                      sbError);
            END IF;

            IF (NumReg <= 0) THEN
                proRegistraLog('VALIDACION 141',
                               SYSDATE,
                               141,
                               sbMensErrorP,
                               gnutsess,
                               gsbparuser);
            END IF;
        END IF;

        pkg_estaproc.practualizaestaproc(isbproceso => sbproceso);

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin);

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERC);
            pkg_Error.getError( nuerror,sberror);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            prCierraCursores;
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERR);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror  );
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            prCierraCursores;
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            RAISE pkg_error.CONTROLLED_ERROR;
    END ldc_procliquidacion;

    PROCEDURE ldc_procinicmeta(nupaanoact NUMBER,
                             nupamesact NUMBER,
                             dtpafein   DATE,
                             dtpafefi   DATE) IS

    /******************************************************************************************************************************************************
      Autor       : John Jairo Jimenez Marimon / Horbath Technologies
          Fecha       : 01/02/2019
          Ticket      : 200-2272
          Descripcion : Registra cartera asignada y calculo de las metas.


              HISTORIAL DE MODIFICACIONES
      =========     =========   =========         	====================
        Fecha       Ticket      Autor               Modificacion
      ==========	=========   =========  			====================
      26/08/2019    200-2704    EMAN              	se cambia tipo de producto por el codigo del grupo
      15/10/2019    0000141     HORBATH      		Se actualiza calculo de metas teniendo en cuenta la configuracion por grupo de categorias
      22/04/2021    0000595_1   HORBATH (DANVAL)  	Se modifica el Cursor CUDATOS, se agrega el inicio y el fin del periodo anterior al mes seleccionado
	  09/05/2022  	OSF-266		CGONZALEZ			Se modifica el cursor cudatos para tener en cuenta los tipos de trabajos configurados
													en el parametro TT_GC_CARTERA
	  15/08/2023	OSF-1389	jerazomvm			Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
													SELECT to_number(regexp_substr(variable,
																	 '[^,]+',
																	 1,
																	 LEVEL)) AS alias
													FROM dual
													CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    *******************************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_procinicmeta';

        sbproceso   VARCHAR2(100)  := 'ldc_procinicmeta'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        nuerror     NUMBER;
        sberror     VARCHAR2(4000);

        sbmensa   VARCHAR(100);
        sbTt_Gc_Cartera		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('TT_GC_CARTERA', NULL);

        CURSOR cudatos(dtcufein    DATE,
                       dtcufefi    DATE,
                       dtpafeinant DATE, --Cambio 595_1
                       dtpafefiant DATE) IS --Cambio 595_1
          SELECT o.OPERATING_UNIT_ID unidad_operativa,
                 GT.GRTIGRUP tipo_producto,
                 (SELECT a.GRUPO_CATEGORIA
                    FROM LDC_METAMENSUAL a, LDC_GRUPOS b
                   WHERE a.GRUPO_CATEGORIA = b.GRUPCODI
                     AND (a.METAPROD = gt.GRTIGRUP AND
                         a.METAUNIOP = o.OPERATING_UNIT_ID AND
                         Trunc(a.META_FINICIAL) >=
                         To_Date(dtpafeinant, 'dd/mm/yyyy hh24:mi:ss') AND --Cambio 595_1
                         Trunc(a.META_FFINAL) <=
                         To_Date(dtpafefiant, 'dd/mm/yyyy hh24:mi:ss'))) grupo_categoria, --Cambio 595_1
                 gt.GRTIGRUP grupo,
                 Count(x.PRODUCT_ID) producto,
                 NVL(Sum(x.TOTAL_DEBT), 0) total_cartera
            FROM OR_ORDER             o,
                 GC_COLL_MGMT_PRO_DET x,
                 PR_PRODUCT           p,
                 LDC_GRUPTIPR         gt,
                 ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS columna
                   FROM dual
                   CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt
           WHERE o.ORDER_ID = x.ORDER_ID
             AND x.PRODUCT_ID = p.PRODUCT_ID
             AND gt.GRTITIPR = p.PRODUCT_TYPE_ID
             AND (o.TASK_TYPE_ID = tt.columna AND
                 Trunc(o.CREATED_DATE) BETWEEN
                 To_Date(dtpafein, 'dd/mm/yyyy hh24:mi:ss')
                 AND To_Date(dtpafefi, 'dd/mm/yyyy hh24:mi:ss') AND
                 o.ORDER_STATUS_ID = 5)
           GROUP BY o.OPERATING_UNIT_ID, gt.GRTIGRUP;

        dtFechaCalculadaI date;
        dtFechaCalculadaF date;

  BEGIN

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

	    pkg_Traza.trace(    'nupaanoact: ' 	|| nupaanoact || chr(10) ||
                            'nupamesact: ' 	|| nupamesact || chr(10) ||
                            'dtpafein: ' 	|| dtpafein || chr(10) ||
                            'dtpafefi: ' 	|| dtpafefi, csbNivelTraza
                         );

        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        DELETE FROM ldc_metas_cont_gestcobr
        WHERE ano = nupaanoact
        AND mes = nupamesact;
        COMMIT;

        pkg_Traza.trace('Eliminando datos en ldc_metas_cont_gestcobr donde el a?o es: ' || nupaanoact || ' y el mes: ' || nupamesact, csbNivelTraza);

        --595_1
        --Calculo del mes anterior al del periodo seleccionado
        dtFechaCalculadaI := add_months(dtpafein, -1);
        dtFechaCalculadaF := dtpafein - 1;
        --
        FOR i IN cudatos(dtpafein,
                         dtpafefi,
                         dtFechaCalculadaI,
                         dtFechaCalculadaF)
        LOOP --595_1 Se a gregar?n las dos nuevas referencias
            INSERT INTO ldc_metas_cont_gestcobr
            (
                ano,
                mes,
                unidad_operativa,
                grupo,
                cant_usuarios_entregados,
                deuda_entregada,
                meta_usuarios,
                meta_minima,
                porc_part_memin_meta,
                meta_deuda,
                usuarios_recuperados,
                deuda_normalizada,
                porc_cumpl_usua,
                porc_cumpl_dinero,
                total_recaudado,
                fecha_registro,
                usuario,
                grupo_categoria
            )
            VALUES
            (
                nupaanoact,
                nupamesact,
                i.unidad_operativa,
                i.grupo,
                i.producto,
                i.total_cartera,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                0,
                SYSDATE,
                USER,
                i.grupo_categoria
             );

            sbmensa := 'Proceso termino Ok.';

            pkg_Traza.trace('Insertando datos en ldc_metas_cont_gestcobr, Proceso termino Ok.', csbNivelTraza);

            COMMIT;
        END LOOP;

        pkg_estaproc.practualizaestaproc( sbProceso );

        pkg_Traza.trace('Fin LDC_PKG_CALC_GEST_CARTERA.ldc_procinicmeta nupaanoact', csbNivelTraza);

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN );

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERC);
            pkg_Error.getError( nuerror,sberror);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERR);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror  );
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            RAISE pkg_error.CONTROLLED_ERROR;
    END ldc_procinicmeta;

    PROCEDURE ldc_procinimetamin(nupaanoact NUMBER,
                               nupamesact NUMBER,
                               dtpafein   DATE,
                               dtpafefi   DATE) IS
    /***************************************************************************************************************************************************
      Autor       : John Jairo Jimenez Marimon / Horbath Technologies
          Fecha       : 01/02/2019
          Ticket      : 200-2272
          Descripcion : Registra meta maxima y minima.


              HISTORIAL DE MODIFICACIONES
      =========       =========     =========         ====================
        Fecha          Ticket         Autor               Modificacion
      =========       =========     =========         ====================
      15/07/2019      200-2704    Elkin Alvarez   	Se modifica calculo de la meta de usuarios y cartera a recuperar, de acuerdo a lo configurado en el parametro FORMA_CALC_META.
													Se aplica redondeo de decimales en los calculos,teniendo en cuenta la cantidad de decimales definidos en el parametro PARAM_NUM_DECIMALES.
      26/08/2019      200-2704    Elkin Alvarez   	Se cambia el calculo de las metas para que sea por grupos de tipo de producto y unidad operativa
      15/10/2019      0000141     HORBATH    		Se actualiza calculo de metas teniendo en cuenta la configuracion por grupo de categorias
      22/04/2021      0000595_1   HORBATH (DANVAL)  Se modifica el Cursor CUDATOS, se agrega el inicio y el fin del periodo anterior al mes seleccionado
	  09/05/2022  	  OSF-266	  CGONZALEZ			Se modifica el cursor cudatos para tener en cuenta los tipos de trabajos configurados
													en el parametro TT_GC_CARTERA
	  15/08/2023	  OSF-1389	  jerazomvm			Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
													SELECT to_number(regexp_substr(variable,
																	 '[^,]+',
																	 1,
																	 LEVEL)) AS alias
													FROM dual
													CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    *****************************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_procinimetamin';

        sbproceso   VARCHAR2(100)  := 'ldc_procinimetamin'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nuerror     NUMBER;
        sberror     VARCHAR2(4000);

        sbmensa    VARCHAR(100);
        sbCalMet   VARCHAR2(100) := dald_parameter.fsbGetValue_Chain('FORMA_CALC_META', NULL); --CA 200-2704
        nuCanDec   NUMBER := dald_parameter.fnuGetNumeric_Value('PARAM_NUM_DECIMALES', NULL);
        sbTt_Gc_Cartera		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('TT_GC_CARTERA', NULL);
        nuMetaUsu  NUMBER;
        nuMetaCart NUMBER;
        nuGrupCat  NUMBER;

        CURSOR cudatos(dtcufein    DATE,
                       dtcufefi    DATE,
                       dtpafeinant DATE, --Cambio 595_1
                       dtpafefiant DATE) IS --Cambio 595_1
          SELECT o.OPERATING_UNIT_ID unidad_operativa,
                 GT.GRTIGRUP tipo_producto,
                 (SELECT a.GRUPO_CATEGORIA
                    FROM LDC_METAMENSUAL a, LDC_GRUPOS b
                   WHERE a.GRUPO_CATEGORIA = b.GRUPCODI
                     AND (a.METAPROD = gt.GRTIGRUP AND
                         a.METAUNIOP = o.OPERATING_UNIT_ID AND
                         Trunc(a.META_FINICIAL) >=
                         To_Date(dtpafeinant, 'dd/mm/yyyy hh24:mi:ss') AND --Cambio 595_1
                         Trunc(a.META_FFINAL) <=
                         To_Date(dtpafefiant, 'dd/mm/yyyy hh24:mi:ss'))) grupo_categoria, --Cambio 595_1
                 gt.GRTIGRUP grupo,
                 Count(x.PRODUCT_ID) producto,
                 NVL(Sum(x.TOTAL_DEBT), 0) total_cartera
            FROM OR_ORDER             o,
                 GC_COLL_MGMT_PRO_DET x,
                 PR_PRODUCT           p,
                 LDC_GRUPTIPR         gt,
                 ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS columna
                   FROM dual
                   CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt
           WHERE o.ORDER_ID = x.ORDER_ID
             AND x.PRODUCT_ID = p.PRODUCT_ID
             AND gt.GRTITIPR = p.PRODUCT_TYPE_ID
             AND (o.TASK_TYPE_ID = tt.columna AND
                 Trunc(o.CREATED_DATE) BETWEEN
                 To_Date(dtpafein, 'dd/mm/yyyy hh24:mi:ss') AND
                 To_Date(dtpafefi, 'dd/mm/yyyy hh24:mi:ss') AND
                 o.ORDER_STATUS_ID = 5)
           GROUP BY o.OPERATING_UNIT_ID, gt.GRTIGRUP;

        CURSOR cuMetas(nuOperUni  NUMBER,
                       nuTipoProd NUMBER,
                       dtcufein   DATE,
                       dtcufefi   DATE) IS
          SELECT a.META_USUARIOS, a.META_CARTERA, a.GRUPO_CATEGORIA
            FROM LDC_METAMENSUAL a
           WHERE a.METAUNIOP = nuOperUni
             AND a.METAPROD = nuTipoProd
             AND trunc(a.META_FINICIAL) >= dtcufein
             AND trunc(a.META_FFINAL) <= dtcufefi;

        dtFechaCalculadaI date;
        dtFechaCalculadaF date;

        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME || 'ldc_procinimetamin.prCierraCursores';
        BEGIN

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

            IF cuMetas%ISOPEN THEN
                CLOSE cuMetas;
            END IF;

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );

        END prCierraCursores;

    BEGIN

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

	    prCierraCursores;

	    pkg_Traza.trace(' nupaanoact: ' 	|| nupaanoact || chr(10) ||
                        'nupamesact: ' 	|| nupamesact || chr(10) ||
                        'dtpafein: ' 	|| dtpafein || chr(10) ||
                        'dtpafefi: ' 	|| dtpafefi, csbNivelTraza);

        -- Se inicia log del programa
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        --595_1
        --Calculo del mes anterior al del periodo seleccionado
        dtFechaCalculadaI := add_months(dtpafein, -1);
        dtFechaCalculadaF := dtpafein - 1;
        --
        FOR i IN cudatos(dtpafein,
                         dtpafefi,
                         dtFechaCalculadaI,
                         dtFechaCalculadaF)
        LOOP --595_1 Se agregar?n las dos nuevas referencias

            pkg_Traza.trace('El valor del parametro FORMA_CALC_META es: ' || sbCalMet, csbNivelTraza);

            --Validamos el valor configurado en el paramtero FORMA_CALC_META y dependiendo de este (A o M) se calculan las metas.
            IF (UPPER(sbCalMet) = 'A') THEN
                UPDATE ldc_metas_cont_gestcobr s
                SET s.meta_usuarios       =
                     (i.producto) + ROUND((i.producto *
                                          (dald_parameter.fnuGetNumeric_Value('PARAM_PORC_META_GESTCOBR') / 100)),
                                          nuCanDec),
                     s.meta_minima          = i.producto,
                     s.meta_deuda          =
                     (i.total_cartera) + ROUND((i.total_cartera *
                                               (dald_parameter.fnuGetNumeric_Value('PARAM_PORC_META_GESTCOBR') / 100)),
                                               nuCanDec),
                     s.porc_part_memin_meta = ROUND(((i.producto /
                                                    s.cant_usuarios_entregados) * 100),
                                                    nuCanDec)
                WHERE s.ano = nupaanoact
                AND s.mes = nupamesact
                AND s.unidad_operativa = i.unidad_operativa
                AND s.grupo = i.tipo_producto;

                sbmensa := 'Proceso termino Ok.';

                pkg_Traza.trace('Proceso termino Ok, con el valor del parametro en A', csbNivelTraza);

                COMMIT;

            END IF;

            IF (UPPER(sbCalMet) = 'M') THEN

              OPEN cuMetas(i.unidad_operativa,
                           i.tipo_producto,
                           dtpafein,
                           dtpafefi);
              FETCH cuMetas INTO nuMetaUsu, nuMetaCart, nuGrupCat;
              IF cuMetas%NOTFOUND THEN
                nuMetaUsu  := 0;
                nuMetaCart := 0;
              END IF;
              CLOSE cuMetas;

              UPDATE ldc_metas_cont_gestcobr s
                 SET s.meta_usuarios        = ROUND((i.producto *
                                                    (nuMetaUsu / 100)),
                                                    nuCanDec) --Redondeo de decimales CA 200-2704
                    ,
                     s.meta_minima          = i.producto,
                     s.meta_deuda           = ROUND((i.total_cartera *
                                                    (nuMetaCart / 100)),
                                                    nuCanDec) --Redondeo de decimales CA 200-2704
                    ,
                     s.porc_part_memin_meta = ROUND(((i.producto /
                                                    s.cant_usuarios_entregados) * 100),
                                                    nuCanDec) --Redondeo de decimales CA 200-2704
                    ,
                     s.porc_met_usu         = nuMetaUsu,
                     s.porc_met_cart        = nuMetaCart
               WHERE s.ano = nupaanoact
                 AND s.mes = nupamesact
                 AND s.unidad_operativa = i.unidad_operativa
                 AND s.grupo_categoria = nuGrupCat
                 AND s.grupo = i.tipo_producto;

              sbmensa := 'Proceso termino Ok.';

              pkg_Traza.trace('Proceso termino Ok, con el valor del parametro en M', csbNivelTraza);
              COMMIT;
            END IF;

        END LOOP;

        pkg_estaproc.practualizaestaproc( sbProceso );

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );


    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERC);
            pkg_Error.getError( nuerror,sberror);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            prCierraCursores;
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERR);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror  );
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            prCierraCursores;
            RAISE pkg_error.CONTROLLED_ERROR;
    END ldc_procinimetamin;

    FUNCTION fnugetRecaudo(nuProducto IN NUMBER,
                         dtpafein   DATE,
                         dtpafefi   DATE) RETURN NUMBER IS
    /*************************************************************************************************************************************
        Autor       : Elkin alvarez / Horbath Technologies
        Fecha       : 26/08/2019
        Ticket      : 200-2704
        Descripcion : obtener valor recaudo

       Datos de Entrada
        nuProducto      producto
        dtpafein        fecha de inicio
        dtpafefi        fecha final

      Datos de salida
        recaudo del producto

             HISTORIAL DE MODIFICACIONES
     =========       =========     =========         ====================
       Fecha          Ticket         Autor               Modificacion
     =========       =========     =========         ====================
    **************************************************************************************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'fnugetRecaudo';
        nuError         NUMBER;
        sbError         VARCHAR2(4000);

        nuRecaudo NUMBER;

        --Se obtiene primer pago al producto
        CURSOR cuPagosProd IS
        SELECT VALOR
        FROM
        (
            SELECT trunc(cargfecr), NVL(sum(NVL(cargvalo, 0)), 0) VALOR
            FROM cargos CI
            WHERE CI.cargnuse = nuProducto
            AND trunc(CI.cargfecr) BETWEEN dtpafein AND dtpafefi
            AND CI.cargsign = 'PA'
            GROUP BY trunc(cargfecr)
            ORDER BY trunc(cargfecr) asc
        )
        WHERE ROWNUM = 1;

        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME || 'fnugetRecaudo.prCierraCursores';
        BEGIN

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

            IF cuPagosProd%ISOPEN THEN
                CLOSE cuPagosProd;
            END IF;

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );

        END prCierraCursores;

    BEGIN

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

	    prCierraCursores;

        --se carga recaudo del producto
        open cuPagosProd;
        fetch cuPagosProd into nuRecaudo;
        close cuPagosProd;

        nuRecaudo := nvl(nuRecaudo,0);

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );

        RETURN nuRecaudo;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            prCierraCursores;
            RETURN 0;
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin_Err );
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            prCierraCursores;
            RETURN 0;
    END fnugetRecaudo;

    PROCEDURE ldc_procnormalizados(nuanoact NUMBER,
                                 numesact NUMBER,
                                 dtpafein DATE,
                                 dtpafefi DATE) IS
    /*************************************************************************************************************************************
    Autor       : John Jairo Jimenez Marimon / Horbath Technologies
        Fecha       : 01/02/2019
        Ticket      : 200-2272
        Descripcion : Registra usuarios normalizados.


            HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
    13/07/2019      200-2704 	ELKIN ALVAREZ  		Se aplica redondeo de calculos, teniendo en cuenta el numero de decimales definidos en el parametro PARAM_NUM_DECIMALES
     12/08/2019     200-2704    EMAN           		se cambia tipo de producto por el codigo del grupo
    15/10/2019      0000141     HORBATH      		Se actualiza calculo de metas y tarifas teniendo en cuenta la configuracion por grupo de categorias
    22/04/2021      0000595_1   HORBATH (DANVAL)  	Se modifica el Cursor CUDETAPROD, se agrega el inicio y el fin del periodo anterior al mes seleccionado
	22/04/2021      0000846_1   HORBATH   			Se modificara la subconsulta del campo deuda deuda_normalizada  del cursor cuDetaProd
	09/05/2022  	OSF-266		CGONZALEZ			Se modifica el cursor cuDetaProd para tener en cuenta los tipos de trabajos configurados
													en el parametro TT_GC_CARTERA
    15/07/2022  	OSF-428		  CGONZALEZ			Se modifica el cursor cuDetaProd para buscar la categoria y subcategoria del producto en el cierre del mes anterior
	15/08/2023		OSF-1389	jerazomvm			Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
													SELECT to_number(regexp_substr(variable,
																	 '[^,]+',
																	 1,
																	 LEVEL)) AS alias
													FROM dual
													CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    **************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_procnormalizados';

        sbproceso   VARCHAR2(100)  := 'ldc_procnormalizados'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');
        nuerror     NUMBER;
        sberror     VARCHAR2(4000);

        sbmensa   VARCHAR(100);
        nutotreca NUMBER(18, 2);

        --Obtenemos el numero de decimales para aplicar el redondeo (CA 200-2704)
        nuCanDec NUMBER := dald_parameter.fnuGetNumeric_Value('PARAM_NUM_DECIMALES',NULL);

        nuEdmode NUMBER := dald_parameter.fnuGetNumeric_Value('EDAD_MORA_DEU_NORMA',NULL); ---- caso:846
        sbTt_Gc_Cartera		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('TT_GC_CARTERA', NULL);

        --se consultan productos recuperados
        CURSOR cuDetaProd(dtcufein    DATE,
                          dtcufefi    DATE,
                          dtcufeinant DATE, --Cambio 595_1
                          dtcufefiant DATE) IS --Cambio 595_1
          SELECT nuanoact,
                 numesact,
                 grupo,
                 producto,
                 categoria,
                 subcategoria,
                 grupo_categoria,
                 (select D.GEOGRAP_LOCATION_ID
                    from ab_address d
                   where d.ADDRESS_ID = direccion) localidad,
                 unidad_operativa,
                 deuda_normalizada,
                 0 recaudo
            FROM (SELECT o.operating_unit_id unidad_operativa,
                         GRTIGRUP grupo,
                         P.PRODUCT_ID producto,
                         l.categoria, --595_1 P.CATEGORY_ID categoria
                         l.subcategoria, --595_1 P.SUBCATEGORY_ID subcategoria
                         (SELECT a.grupo_categoria
                            from ldc_metamensual a, ldc_grupos b, ldc_grucat c
                           WHERE a.grupo_categoria = b.grupcodi
                             and b.grupcodi = c.grupcodi
                             and c.cod_categoria = l.categoria --595_1 p.category_id
                             and a.metaprod = gt.grtigrup
                             and a.metauniop = o.operating_unit_id
                             and trunc(a.meta_finicial) >= dtcufeinant --595_1
                             and trunc(a.meta_ffinal) <= dtcufefiant) grupo_categoria --595_1
                        ,
                         p.address_id direccion -- ,(select 1 from )
                        ,
                         nvl((SELECT count(producto)
                               FROM ldc_osf_sesucier
                              WHERE nuano = 2024
                                AND numes = 4
                                AND producto = x.product_id
                                AND edad <= 60
                                AND estado_financiero <> 'C'
                                AND area_servicio = area_servicio),
                             0) usuario_normalizado,
                         NVL((SELECT nvl(r.deuda_no_corriente, 0) +
                                    nvl(r.SESUSAPE, 0)
                               FROM ldc_osf_sesucier r
                              WHERE nuano = decode((4-1),0,(2024-1),2024) -- caso:846
                                AND numes = decode((4-1),0,12,(4-1)) -- caso:846
                                AND producto = x.product_id
                                AND edad >= nuEdmode -- caso:846
                                AND area_servicio = area_servicio),
                             0) deuda_normalizada
                    FROM or_order             o,
                         gc_coll_mgmt_pro_det x,
                         pr_product           p,
                         ldc_gruptipr              gt,
                         ldc_osf_sesucier          l, --595_1 se agrego la tabla ldc_osf_sesucier
                         ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                            '[^,]+',
                                            1,
                                            LEVEL)) AS columna
                           FROM dual
                           CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt
                   WHERE o.task_type_id = tt.columna
                   AND o.ORDER_STATUS_ID = 5
                   AND trunc(o.created_date) BETWEEN dtcufein AND dtcufefi
                   AND o.order_id = x.order_id
                   AND x.product_id = p.product_id
                   and p.product_type_id = GT.GRTITIPR
                   and p.product_id = l.producto
                   and l.nuano = decode((4-1),0,(2024-1),2024)
                   and l.numes = decode((4-1),0,12,(4-1))
                     --
                  )
           WHERE usuario_normalizado >= 1;

        TYPE tblProdRecu IS TABLE OF cuDetaProd%rowtype;

        vTblProdRecu tblProdRecu;
        limit_in     INTEGER := 100;

        --se calcula resumen
        CURSOR cuResumen IS
          SELECT d.grupo_categoria grupo_categoria,
                 d.gruptitr grupo,
                 d.unidad_operativa,
                 count(producto) usuario_normalizado,
                 sum(nvl(d.deuda_normalizada, 0)) deuda_normalizada,
                 sum(nvl(d.recaudo, 0)) recaudo
            FROM ldc_deta_prodrecu d
           WHERE d.nuano = nuanoact
             AND d.numes = numesact
           GROUP BY d.grupo_categoria, d.gruptitr, d.unidad_operativa;

        Finicio DATE;
        Ffin    DATE;

        dtFechaCalculadaI date;
        dtFechaCalculadaF date;

  BEGIN

	    pkg_Traza.trace(csbMetodo ,csbNivelTraza, pkg_Traza.csbInicio);

	    pkg_Traza.trace('nuanoact: ' 	|| nuanoact || chr(10) ||
                        'numesact: ' 	|| numesact || chr(10) ||
                        'dtpafein: ' 	|| dtpafein || chr(10) ||
                        'dtpafefi: ' 	|| dtpafefi, csbNivelTraza);

        -- Se inicia log del programa
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        delete from ldc_deta_prodrecu
         where nuano = nuanoact
           and numes = numesact;
        commit;

        --se llena detalle de productos recuerados
        -- Recorremos los productos

        Finicio := to_date('01/' || numesact || '/' || nuanoact);
        Ffin    := last_day(Finicio);

        --595_1
        --Calculo del mes anterior al del periodo seleccionado
        dtFechaCalculadaI := add_months(dtpafein, -1);
        dtFechaCalculadaF := dtpafein - 1;
        --
        OPEN cuDetaProd(dtpafein,
                        dtpafefi,
                        dtFechaCalculadaI,
                        dtFechaCalculadaF); --595_1 se agregar?n las 2 nuevas referencias
        LOOP
            FETCH cuDetaProd BULK COLLECT INTO vTblProdRecu LIMIT limit_in;

            FOR i IN 1 .. vTblProdRecu.count LOOP

                vTblProdRecu(i).recaudo := fnugetRecaudo(vTblProdRecu(i).producto,
                                                         Finicio,
                                                         Ffin);

            END LOOP;

            pkg_Traza.trace('Insertando en tabla detalle', csbNivelTraza);
            FORALL i IN 1 .. vTblProdRecu.count

            INSERT INTO ldc_deta_prodrecu
            VALUES
              (vTblProdRecu(i).nuanoact,
               vTblProdRecu(i).numesact,
               vTblProdRecu(i).grupo,
               vTblProdRecu(i).producto,
               vTblProdRecu(i).categoria,
               vTblProdRecu(i).subcategoria,
               vTblProdRecu(i).localidad,
               vTblProdRecu(i).unidad_operativa,
               vTblProdRecu(i).deuda_normalizada,
               vTblProdRecu(i).recaudo,
               vTblProdRecu(i).grupo_categoria);

            EXIT WHEN cuDetaProd%NOTFOUND;

        END LOOP;

        COMMIT;

        FOR i IN cuResumen LOOP

            pkg_Traza.trace('Actualizando tabla resumen', csbNivelTraza);

            -- Obtenemos el valor recaudado
            nutotreca := I.RECAUDO;

            pkg_Traza.trace('Actualizando registros tabla resumen', csbNivelTraza);
            UPDATE ldc_metas_cont_gestcobr s
               SET s.usuarios_recuperados = i.usuario_normalizado,
                   s.deuda_normalizada    = i.deuda_normalizada,
                   s.porc_cumpl_usua      = DECODE(s.meta_usuarios,
                                                   0,
                                                   0,
                                                   ROUND(((i.usuario_normalizado /
                                                         s.meta_usuarios) * 100),
                                                         nuCanDec)) --Redondeo de decimales CA 200-2704
                  ,
                   s.porc_cumpl_dinero    = DECODE(s.meta_deuda,
                                                   0,
                                                   0,
                                                   ROUND(((i.deuda_normalizada /
                                                         s.meta_deuda) * 100),
                                                         nuCanDec)) --Redondeo de decimales CA 200-2704
                  ,
                   s.total_recaudado      = nvl(nutotreca, 0)
             WHERE s.ano = nuanoact
               AND s.mes = numesact
               AND s.unidad_operativa = i.unidad_operativa
               AND s.grupo = i.grupo
               AND s.grupo_categoria = i.grupo_categoria;
            sbmensa := 'Proceso termino Ok.';

            pkg_Traza.trace('Proceso termino Ok.', csbNivelTraza);
            COMMIT;

        END LOOP;

        pkg_estaproc.practualizaestaproc( sbProceso );

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERC);
            pkg_Error.getError( nuerror,sberror);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERR);
            pkg_error.seterror;
            pkg_error.geterror(nuerror, sberror  );
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            RAISE pkg_error.CONTROLLED_ERROR;
  END ldc_procnormalizados;

  PROCEDURE ldc_proActuTarifa(nuanoact IN NUMBER,
                              numesact IN NUMBER,
                              nuOk     OUT NUMBER,
                              sberror  OUT VARCHAR2) IS
    /*************************************************************************************************************************************
        Autor       : Elkin alvarez / Horbath Technologies
        Fecha       : 26/08/2019
        Ticket      : 200-2704
        Descripcion : obtener y actualizar tarifas a liquidar

       Datos de Entrada
        nuanoact      anio
        numesact        mes

       Datos de salida
        nuOk indicador de error (0 correcto , -1 error )
        sberror mensaje de error

      HISTORIAL DE MODIFICACIONES
     =========       =========     =========         ====================
       Fecha          Ticket         Autor               Modificacion
     =========       =========     =========         ====================
    **************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_proActuTarifa';

        sbproceso   VARCHAR2(100)  := 'ldc_proActuTarifa'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        CURSOR cuObtenerTarifa IS
          WITH usuarios AS
           (SELECT unidad_operativa,
                   m.GRUPO,
                   m.grupo_categoria,
                   case
                     when m.GRUPO <> 1 and g.grgeusgas = 'S' THEN
                      (SELECT mi.cant_usuarios_entregados
                         FROM ldc_metas_cont_gestcobr mi
                        where mi.ano = nuanoact
                          AND mi.mes = numesact
                          and mi.unidad_operativa = m.unidad_operativa
                          and mi.GRUPO = 1)
                     ELSE
                      cant_usuarios_entregados
                   END cant_usuarios_entregados,
                   usuarios_recuperados,
                   TOTAL_RECAUDADO,
                   CASE
                     WHEN porc_cumpl_usua > porc_cumpl_dinero THEN
                      porc_cumpl_usua
                     ELSE
                      porc_cumpl_dinero
                   END porc
              FROM ldc_metas_cont_gestcobr m, LDC_GRUPGECA g
             WHERE ano = nuanoact
               AND mes = numesact
               and g.GRGECODI = m.GRUPO)
          SELECT u.usuarios_recuperados * t.valor preliquidacon,
                 u.grupo,
                 u.grupo_categoria,
                 u.unidad_operativa,
                 t.tipo_tarifa,
                 t.valor tarifa
            FROM ldc_tarifas_gestcart t, usuarios u
           WHERE t.GRUPTIPR = u.grupo
             AND t.grupo_categoria = u.grupo_categoria
             AND t.unidad_operativa = u.unidad_operativa
             AND SYSDATE BETWEEN t.fecha_inicial_vig AND t.fecha_final_vig
             AND t.tipo_tarifa = 'U'
             AND u.cant_usuarios_entregados BETWEEN t.rango_inicial AND
                 t.rango_final
             AND u.porc BETWEEN t.rango_inicump AND t.rango_fincump
          UNION ALL
          SELECT (u.total_recaudado * (t.valor / 100)) preliquidacon,
                 u.grupo,
                 u.grupo_categoria,
                 u.unidad_operativa,
                 t.tipo_tarifa,
                 t.valor tarifa
            FROM ldc_tarifas_gestcart t, usuarios u
           WHERE t.GRUPTIPR = u.grupo AND t.grupo_categoria = u.grupo_categoria AND
           t.unidad_operativa = u.unidad_operativa AND
           SYSDATE BETWEEN t.fecha_inicial_vig AND t.fecha_final_vig AND
           t.tipo_tarifa = 'P' AND
           u.cant_usuarios_entregados BETWEEN t.rango_inicial AND
           t.rango_final AND u.porc BETWEEN t.rango_inicump AND
           t.rango_fincump;

        nuTotal   NUMBER := 0;
        nuGrupo   NUMBER;
        nuUnidad  NUMBER;

    BEGIN
        pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );
        pkg_Traza.trace('nuanoact: ' || nuanoact || chr(10) ||
                        'numesact: ' || numesact, csbNivelTraza);


        pkg_Traza.trace('se actualizan tarifas y preliquidacion', csbNivelTraza);

        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        --se actualizan tarifas y preliquidacion

        FOR reg IN cuObtenerTarifa LOOP

            --Se setean variables
            nuGrupo  := reg.grupo;
            nuUnidad := reg.UNIDAD_OPERATIVA;

            IF (nuGrupo IS NOT NULL AND nuGrupo <> reg.grupo) OR
             (nuUnidad IS NOT NULL AND nuUnidad <> reg.UNIDAD_OPERATIVA) THEN
            --se actualiza el campo de total con el campo nuTotal

                UPDATE ldc_metas_cont_gestcobr
                   SET PRELIQ_TOTAL = nuTotal
                 WHERE ANO = nuanoact
                   AND MES = numesact
                   AND UNIDAD_OPERATIVA = reg.UNIDAD_OPERATIVA
                   AND GRUPO = reg.grupo;
                nuTotal := 0;
                pkg_Traza.trace('Saliendo del total generarl ' || nuTotal, csbNivelTraza);
            END IF;

            IF reg.tipo_tarifa = 'U' THEN
                --se actualizn los campos de tarifas usuario, preliquidacion de usuario
                UPDATE ldc_metas_cont_gestcobr
                   SET TARIFA_USUARIO = reg.tarifa, PRELIQ_USU = reg.preliquidacon
                 WHERE ANO = nuanoact
                   AND MES = numesact
                   AND UNIDAD_OPERATIVA = reg.UNIDAD_OPERATIVA
                   AND GRUPO = reg.grupo
                   AND GRUPO_CATEGORIA = reg.grupo_categoria;
                nuTotal := nuTotal + REG.preliquidacon;

            ELSE
                --se actualizan los campos de tarifas cartera, preliquidacion de cartera
                UPDATE ldc_metas_cont_gestcobr
                   SET TARIFA_CARTERA = reg.tarifa, PRELIQ_CART = reg.preliquidacon
                 WHERE ANO = nuanoact
                   AND MES = numesact
                   AND UNIDAD_OPERATIVA = reg.UNIDAD_OPERATIVA
                   AND GRUPO = reg.grupo
                   AND GRUPO_CATEGORIA = reg.grupo_categoria;
                nuTotal := nuTotal + REG.preliquidacon;

            END IF;
        END LOOP;

        UPDATE ldc_metas_cont_gestcobr
           SET PRELIQ_TOTAL = PRELIQ_USU + PRELIQ_CART
         WHERE ANO = nuanoact
           AND MES = numesact;

        pkg_estaproc.practualizaestaproc( sbProceso );

        pkg_Traza.trace('Finaliza LDC_PKG_CALC_GEST_CARTERA.ldc_proActuTarifa nuOk: ' 	|| nuOk || chr(10) ||
                                                                            'sberror: ' || sberror, csbNivelTraza);
        COMMIT;
        nuOk := 0;

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );


    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERC);
            pkg_Error.getError( nuOk,sberror);
            pkg_Traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERR);
            pkg_error.seterror;
            pkg_error.geterror(nuOk, sberror  );
            pkg_Traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
    END ldc_proActuTarifa;

    PROCEDURE PrcLiquidaProdRecup(nuanoact NUMBER,
                                numesact NUMBER,
                                onuok    OUT NUMBER,
                                sbError  OUT VARCHAR2) IS
    /***********************************************************************************************************************************
    Autor       : Elkin Alvarez / Horbath Technologies
        Fecha       : 26/08/2019
        Ticket      : 200-2704
        Descripcion : Procedimiento para la creacion, liquidacion y legalizacion de las ordenes de productos recuperados.


            HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
	11/08/2023		OSF-1389	 jerazomvm			Caso OSF-1389:
													1. Se cambia el llamado del API OS_LEGALIZEORDERS, por el API API_LEGALIZEORDERS
													2. Se cambia el llamado del API OS_ASSIGN_ORDER, por el API api_assign_order
													3. Se cambia el llamado del API OS_CREATEORDERACTIVITIES por el API api_createorder
    15/10/2019    0000141      HORBATH      Se actualiza calculo de metas y tarifas teniendo en cuenta la configuracion por grupo de categorias
    **************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'PrcLiquidaProdRecup';

        sbproceso   VARCHAR2(100)  := 'PrcLiquidaProdRecup'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        onuerror NUMBER;
        msgerror varchar2(4000);

        nuerrorcode    number;
        sberrormessage varchar2(2000);

        ionuOrderId   			OR_ORDER.ORDER_ID%type;
        ionuOrderactivityid		or_order_activity.order_activity_id%type;

        tUsuario NUMBER;
        tCart    NUMBER;

        nuPersonaLega NUMBER := dald_parameter.fnuGetNumeric_Value('PERSON_LEGA_ORDCART',
                                                                   NULL);
        nuCauLiq      NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_CAUSAL_LIQUIDACION',
                                                                   NULL);

        --Obtenemos las posibles causales de legalizacion de las ordenes de gestion de cartera
        sbDirGen       VARCHAR(4000) := dald_parameter.fnuGetNumeric_Value('LDC_DIR_GENERICA',
                                                                           NULL);
        nuActiGas      NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_ACTIVIDAD_GAS',
                                                                    NULL);
        nuActiBrilla   NUMBER := dald_parameter.fnuGetNumeric_Value('LDC_ACTIVIDAD_BRILLA',
                                                                    NULL);
        nuactividadgen NUMBER;

        --Obtenemos los items de legalizacion de los tipos de producto
        nuItemIdUsu  NUMBER := dald_parameter.fnuGetNumeric_Value('ITEM_USUARIOS',
                                                                  NULL);
        nuItemIdCart NUMBER := dald_parameter.fnuGetNumeric_Value('ITEM_CARTERA',
                                                                  NULL);

        IdListaCostoCart    NUMBER;
        CostoItemCart       NUMBER;
        PrecioVentaItemCart NUMBER;

        IdListaCostoUsu    NUMBER;
        CostoItemUsu       NUMBER;
        PrecioVentaItemUsu NUMBER;

        CantUsu     NUMBER;
        CantCart    NUMBER;
        ActividadId NUMBER;
        IdAddress   NUMBER;

        sbCadenaLegalizacion    CONSTANTS_PER.TIPO_XML_SOL%TYPE;

        --Cursor de ordenes de gestion de cartera recuperadas
        CURSOR cuOrderRec IS
          SELECT unidad_operativa,
                 localidad,
                 gruptitr grupo_producto,
                 grupo_categoria grupo_categoria,
                 COUNT(producto) usu_recu,
                 sum(nvl(deuda_normalizada, 0)) deuda_normalizada,
                 sum(nvl(recaudo, 0)) recaudo
            FROM ldc_deta_prodrecu
           WHERE nuano = nuanoact
             AND numes = numesact
           GROUP BY localidad, unidad_operativa, gruptitr, grupo_categoria;

        CURSOR cuTarifa(uniOpe NUMBER, GruProd NUMBER, GruCat NUMBER) IS
          SELECT tarifa_usuario, tarifa_cartera
            FROM ldc_metas_cont_gestcobr
           WHERE unidad_operativa = uniOpe
             AND grupo = GruProd
             AND grupo_categoria = GruCat
             AND ano = nuanoact
             AND mes = numesact;

        CURSOR cuAddress(direccion VARCHAR, localidad NUMBER) IS
          select a.address_id
            from ab_address a
           where a.geograp_location_id = localidad
             AND a.ADDRESS like '%' || direccion || '%';

        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME || 'PrcLiquidaProdRecup.prCierraCursores';
        BEGIN

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

            IF cuTarifa%ISOPEN THEN
                CLOSE cuTarifa;
            END IF;

            IF cuAddress%ISOPEN THEN
                CLOSE cuAddress;
            END IF;

            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFin );

        END prCierraCursores;

    BEGIN

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

        pkg_Traza.trace('nuanoact: ' || nuanoact || chr(10) ||
                         'numesact: ' || numesact, csbNivelTraza);

        -- Se inicia log del programa
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        --Se obtienen el costo del item por recuperacion de cartera
        api_ObtenerCostoItemLista(nuItemIdCart,
                                                   SYSDATE,
                                                   null,
                                                   null,
                                                   null,
                                                   null,
                                                   IdListaCostoCart,
                                                   CostoItemCart,
                                                   PrecioVentaItemCart,
                                                   onuok,
                                                   sbError);

        IF onuok <> 0 THEN
            RAISE pkg_Error.Controlled_Error;
        END IF;

        --Se obtienen el costo del item por recuperacion de usuarios
        Api_ObtenerCostoItemLista(nuItemIdUsu,
                                                   SYSDATE,
                                                   null,
                                                   null,
                                                   null,
                                                   null,
                                                   IdListaCostoUsu,
                                                   CostoItemUsu,
                                                   PrecioVentaItemUsu,
                                                   onuok,
                                                   sbError
                                                   );

        IF onuok <> 0 THEN
            RAISE pkg_Error.Controlled_Error;
        END IF;

        --Recorremos el cursor de producto recuperados por unidad operativa y localidad
        FOR i IN cuOrderRec LOOP

            onuerror       := null;
            msgerror       := null;
            tUsuario       := NULL;
            tCart          := NULL;
            ActividadId    := NULL;
            nuactividadgen := NULL;
            IdAddress      := NULL;

            --Se obtienen las tarifas con las que se liquidaran usuarios y cartera recuperada
            open cuTarifa(i.unidad_operativa,
                        i.grupo_producto,
                        i.grupo_categoria);
            fetch cuTarifa into tUsuario, tCart;
            IF cuTarifa%NOTFOUND THEN
                tUsuario := 0;
                tCart    := 0;
            END IF;
            close cuTarifa;

            --Se obtiene la direccion generica correspondiente a la localidad
            OPEN cuAddress(sbDirGen, i.localidad);
            FETCH cuAddress INTO IdAddress;
            CLOSE cuAddress;

            --Se valida el grupo de producto al que pertenezca y dependiendo del mismo se asocia la actividad correspondiente
            IF i.grupo_producto = 1 THEN
                nuactividadgen := nuActiGas;
            else
                nuactividadgen := nuActiBrilla;
            end if;

            ionuOrderId    		:= NULL;
            ionuOrderactivityid	:= NULL;
            nuerrorcode    		:= NULL;
            sberrormessage 		:= NULL;

            --Se crean las ordenes de liquidacion de cartera por unidad operativa y localidad
            api_createorder(nuactividadgen,
                          null,
                          null,
                          null,
                          null,
                          IdAddress,
                          null,
                          null,
                          null,
                          null,
                          null,
                          SYSDATE + 0.00138,
                          null,
                          'Orden de liquidacion de cartera por unidad operativa y localidad',
                          null,
                          null,
                          null,
                          null,
                          null,
                          null,
                          null,
                          0,
                          null,
                          null,
                          null,
                          null,
                          ionuOrderId,
                          ionuOrderactivityid,
                          nuerrorcode,
                          sberrormessage
                         );

            pkg_Traza.trace('Sale api_createorder ionuOrderId: ' 		 	|| ionuOrderId 			|| chr(10) ||
                          'ionuOrderactivityid: ' 	|| ionuOrderactivityid 	|| chr(10) ||
                          'nuerrorcode: ' 			|| nuerrorcode 			|| chr(10) ||
                          'sberrormessage: ' 		|| sberrormessage, csbNivelTraza);

            --Se valida si la orden fue creada correctamente
            IF nuerrorcode = 0 THEN

                nuerrorcode    := NULL;
                sberrormessage := NULL;

                pkg_Traza.trace('Ingresa api_assign_order inuOrder: ' || ionuOrderId || chr(10) ||
                                'inuOperatingUnit: ' || i.unidad_operativa, csbNivelTraza);

                --Se asigna la orden de liquidacion a la unidad operativa correspondiente
                api_assign_order(ionuOrderId,
                                i.unidad_operativa,
                                nuerrorcode,
                                sberrormessage);

                pkg_Traza.trace('Sale api_assign_order onuErrorCode: ' 		|| nuerrorcode || chr(10) ||
                                'osbErrorMessage: ' || sberrormessage, csbNivelTraza);

                --Se valida si se asigno correctamente la oden
                IF nuerrorcode = 0 THEN

                    cantUsu  := 0;
                    CantCart := 0;

                    CantUsu  := (i.usu_recu * tUsuario) / CostoItemUsu;
                    CantCart := (i.recaudo * (tCart / 100)) / CostoItemCart;

                    pkg_cadena_legalizacion.prSetDatosBasicos
                    (
                        ionuOrderId,
                        nuCauLiq,
                        nuPersonaLega,
                        1277,
                        'Orden Legalizada por proceso ldc_legaordergestcart'
                    );

                    pkg_cadena_legalizacion.prAgregaActividadOrden;

                    pkg_cadena_legalizacion.prAgregaItem
                    (
                        nuItemIdUsu,   --inuItem         NUMBER,
                        CantUsu     ,   --inuCantLega     NUMBER,
                        'Y'         ,   --isbInstala      VARCHAR2,
                        NULL            --isbCodElemento  VARCHAR2
                    );

                    pkg_cadena_legalizacion.prAgregaItem
                    (
                        nuItemIdCart,   --inuItem         NUMBER,
                        CantCart    ,   --inuCantLega     NUMBER,
                        'Y'         ,   --isbInstala      VARCHAR2,
                        NULL            --isbCodElemento  VARCHAR2
                    );

                    sbCadenaLegalizacion := pkg_cadena_legalizacion.fsbCadenaLegalizacion;

                    --se legaliza orden de trabajo
                    API_LEGALIZEORDERS(sbCadenaLegalizacion,
                                    SYSDATE,
                                    SYSDATE,
                                    null,
                                    onuerror,
                                    msgerror
                                    );

                    dbms_lock.sleep(2);

                    --Se valida la correcta legalizacion de la orden
                    IF onuerror = 0 THEN
                        COMMIT;
                    ELSE
                        -- se registran los log de errores
                        proRegistraLog('PrcLiquidaProdRecup 200-2704',
                                       SYSDATE,
                                       ionuOrderId,
                                       msgerror,
                                       gnutsess,
                                       gsbparuser);
                        onuok   := onuerror;
                        sbError := msgerror;
                        ROLLBACK;

                    END IF;
                ELSE
                    -- se registran los log de errores
                    proRegistraLog('PrcLiquidaProdRecup 200-2704',
                                 SYSDATE,
                                 ionuOrderId,
                                 sberrormessage,
                                 gnutsess,
                                 gsbparuser);
                    onuok   := nuerrorcode;
                    sbError := sberrormessage;
                    ROLLBACK;

                END IF;

            ELSE
                -- se registran los log de errores
                proRegistraLog('PrcLiquidaProdRecup 200-2704',
                               SYSDATE,
                               IdAddress,
                               sberrormessage,
                               gnutsess,
                               gsbparuser);
                onuok   := nuerrorcode;
                sbError := sberrormessage;
                ROLLBACK;
            END IF;

        END LOOP;

        IF onuok IS NULL THEN
            onuok := 0;
        END IF;

        if onuok = 0 then
            sbError := 'Proceso termino Ok.';
        end if;

        pkg_estaproc.practualizaestaproc( sbProceso );

	    pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbInicio );

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERC);
            pkg_Error.getError( onuok,sberror);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            prCierraCursores;
        WHEN OTHERS THEN
            pkg_Traza.trace(csbMetodo, csbNivelTraza, pkg_Traza.csbFIN_ERR);
            pkg_error.seterror;
            pkg_error.geterror(onuok, sberror  );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
            prCierraCursores;
    END PrcLiquidaProdRecup;

    FUNCTION ldc_proccalcvalorpagar(nuunitoper NUMBER,
                                  tipoprod   NUMBER,
                                  nuanoact   NUMBER,
                                  numesact   NUMBER) RETURN NUMBER IS
    /*************************************************************************************************************************************
          Autor       : John Jairo Jimenez Marimon / Horbath Technologies
          Fecha       : 01/02/2019
          Ticket      : 200-2272
          Descripcion : Funcioon para el calculo del valor de la orden a pagar dependiendo del % maximo de cumplimiento.


              HISTORIAL DE MODIFICACIONES
      =========       =========     =========         ====================
        Fecha          Ticket         Autor               Modificacion
      =========       =========     =========         ====================

    **************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_proccalcvalorpagar';

        rgproductos ldc_metas_cont_gestcobr%ROWTYPE;
        nuvalor     NUMBER;
        nuvalortot  NUMBER;
        nuporc      NUMBER(10, 5);
        nuvalorporc NUMBER(10);

        nuError     NUMBER;
        sbError     VARCHAR2(4000);

        CURSOR culdc_metas_cont_gestcobr
        IS
        SELECT *
        FROM ldc_metas_cont_gestcobr s
        WHERE s.ano = nuanoact
        AND s.mes = numesact
        AND s.unidad_operativa = nuunitoper
        AND s.grupo = tipoprod;

        CURSOR culdc_tarifas_gestcart( isbTipo_Tarifa VARCHAR2)
        IS
        SELECT d.valor
        FROM ldc_tarifas_gestcart d
        WHERE d.GRUPTIPR = rgproductos.grupo
        AND d.tipo_tarifa = isbTipo_Tarifa --'U'
        AND nuporc BETWEEN d.rango_inicial AND d.rango_final
        AND nuporc BETWEEN d.rango_inicump AND d.rango_fincump;

        PROCEDURE prCierraCursores
        IS
            csbMetodo        CONSTANT VARCHAR2(105) := csbSP_NAME || 'ldc_proccalcvalorpagar.prCierraCursores';
        BEGIN

            pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbInicio);

            IF culdc_metas_cont_gestcobr%ISOPEN THEN
                CLOSE culdc_metas_cont_gestcobr;
            END IF;

            pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbFin);

        END prCierraCursores;

    BEGIN

        pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbInicio);

        prCierraCursores;

        OPEN culdc_metas_cont_gestcobr;
        FETCH culdc_metas_cont_gestcobr INTO rgproductos;
        CLOSE culdc_metas_cont_gestcobr;

        IF rgproductos.porc_cumpl_usua >= rgproductos.porc_cumpl_dinero THEN
            nuporc := rgproductos.porc_cumpl_usua;
        ELSE
            nuporc := rgproductos.porc_cumpl_dinero;
        END IF;


        OPEN culdc_tarifas_gestcart('U');
        FETCH culdc_tarifas_gestcart INTO nuValor;
        CLOSE culdc_tarifas_gestcart;

        nuvalor := NVL( nuvalor, 0);

        OPEN culdc_tarifas_gestcart('P');
        FETCH culdc_tarifas_gestcart INTO nuvalorporc;
        CLOSE culdc_tarifas_gestcart;

        IF nuvalorporc IS NULL THEN
            nuvalor := 0;
        END IF;

        nuvalortot := (nuvalor * rgproductos.meta_usuarios) +
                      (rgproductos.total_recaudado * (nuvalorporc / 100));

        pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbFin);

        RETURN nuvalortot;

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            prCierraCursores;
            RETURN 0;
        WHEN OTHERS THEN
            pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbFin_Err);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            prCierraCursores;
            RETURN 0;
    END ldc_proccalcvalorpagar;

    --Metodo principal de legalizacion
    PROCEDURE ldc_legaordergestcart(nuanoact NUMBER,
                                  numesact NUMBER,
                                  dtpafein DATE,
                                  dtpafefi DATE,
                                  onuok    OUT NUMBER,
                                  sbError  OUT VARCHAR2) IS
    /***********************************************************************************************************************************
    Autor       : Elkin Alvarez / Horbath Technologies
    Fecha       : 15/07/2019
    Ticket      : 200-2704
    Descripcion : Procedimiento para la legalizacion de las ordenes de gestion de cartera.


            HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
    24/10/2019      0000141(v8)   HORBATH (EHG)     Se Optimiza el proceso con manejo de Hilos. (OPT) OK++
    **************************************************************************************************************************************/

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_legaordergestcart';

        sbproceso   VARCHAR2(100)  := 'ldc_legaordergestcart'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        DTFECHA DATE;
        X       NUMBER;

        sbdtpafein VARCHAR2(50);
        sbdtpafefi VARCHAR2(50);

        sbWhat     VARCHAR2(2000);

    BEGIN

        pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbInicio);

        --Se limpia las tablas temporales del proceso de optimizacion.(opt)
        DELETE FROM LDC_TEMP_CIERRECARTERA_HILOS;
        COMMIT;

        -- Se inicia log del programa
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        --Se llena la tabla temporal de hilos LDC_TEMP_CIERRECARTERA_HILOS y se establecen los registros en estado (C = Creado).

        FOR I IN 0 .. 9 LOOP
            INSERT INTO LDC_TEMP_CIERRECARTERA_HILOS
            (HILO, NUSESION, FECHA_INICIAL, FECHA_FINAL, OBSERVACION, STATUS)
            VALUES
            (I, gNUTSESS, SYSDATE, NULL, 'INICIO', 'C');
            COMMIT;
        END LOOP;

        --Se corren los hilos y se establecen los registros de la tabla temporal de hilos LDC_TEMP_CIERRECARTERA_HILOS en estado (P = Procesado) y (T = Terminado).

        sbdtpafein := TO_CHAR(dtpafein, 'dd/mm/yyyy HH24:MI:SS');

        ut_trace.trace('sbdtpafein|' || sbdtpafein , csbNivelTraza);

        sbdtpafefi := TO_CHAR(dtpafefi, 'dd/mm/yyyy HH24:MI:SS');

        ut_trace.trace('sbdtpafefi|' || sbdtpafefi , csbNivelTraza);

        ut_trace.trace('TO_CHAR(gNUTSESS)|' || TO_CHAR(gNUTSESS) , csbNivelTraza);

        ut_trace.trace('TO_CHAR(NUANOACT)|' || TO_CHAR(NUANOACT) , csbNivelTraza);

        ut_trace.trace('TO_CHAR(NUMESACT)|' || TO_CHAR(NUMESACT), csbNivelTraza);


        FOR I IN 0 .. 9 LOOP

            DTFECHA := (sysdate);

            ut_trace.trace('DTFECHA|' || TO_CHAR(DTFECHA,'dd/mm/yyyy hh24:mi:ss'), csbNivelTraza);

            ut_trace.trace('hIlo|' || I, csbNivelTraza);

            sbWhat := 'BEGIN ldc_pkg_calc_gest_cartera.ldc_legaordergestcart_hilos(' ||
                          I || ',' ||
                          gNUTSESS || ',' ||
                          NUANOACT || ',' ||
                          NUMESACT || ',' ||
                          '''' || sbdtpafein || '''' || ',' ||
                          '''' || sbdtpafefi || '''' ||
                          '); END;';

            ut_trace.trace('sbWhat|' || sbWhat, csbNivelTraza);

            DBMS_JOB.SUBMIT(x, sbWhat, DTFECHA);

            COMMIT;

        END LOOP;

        pkg_estaproc.practualizaestaproc( sbProceso );

        pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbFin);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbFin_Erc);
            pkg_Error.getError(onuok, sbError);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
        WHEN OTHERS THEN
            pkg_Traza.trace( csbMetodo, csbNivelTraza, pkg_Traza.csbFin_Err);
            pkg_Error.setError;
            pkg_Error.getError(onuok, sbError);
            pkg_traza.trace( 'sbError => ' || sbError,  csbNivelTraza );
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
    END ldc_legaordergestcart;

  --Metodo de legalizacion implementando hilos en su ejecucion
  PROCEDURE ldc_legaordergestcart_hilos(INUHILO    NUMBER,
                                        INUSESION  NUMBER,
                                        nuanoact   NUMBER,
                                        numesact   NUMBER,
                                        sbdtpafein VARCHAR2,
                                        sbdtpafefi VARCHAR2) IS
    /***********************************************************************************************************************************
    Autor       : Elkin Alvarez / Horbath Technologies
    Fecha       : 15/07/2019
    Ticket      : 200-2704
    Descripcion : Procedimiento para la legalizacion de las ordenes de gestion de cartera.


            HISTORIAL DE MODIFICACIONES
    =========       =========     =========         ====================
      Fecha          Ticket         Autor               Modificacion
    =========       =========     =========         ====================
    24/10/2019      0000141(v8)   HORBATH (EHG)     Se Optimiza el proceso (ldc_legaordergestcart) con manejo de Hilos y se crea el metodo (ldc_legaordergestcart_hilos). (OPT) OK++
	09/05/2022  	OSF-266		  CGONZALEZ			Se modifican los cursores cuOrderR y cuOrderNR para tener en cuenta los tipos de trabajos configurados
													en el parametro TT_GC_CARTERA
	11/08/2023		OSF-1389	 jerazomvm			Caso OSF-1389:
													1. Se cambia el llamado del API OS_LEGALIZEORDERS, por el API API_LEGALIZEORDERS
													2. Se cambia el llamado del API OS_ASSIGN_ORDER, por el API api_assign_order
													3. Se reemplaza la separacion de cadena LDC_BOUTILITIES.SPLITSTRINGS por
														SELECT to_number(regexp_substr(variable,
																		 '[^,]+',
																		 1,
																		 LEVEL)) AS alias
														FROM dual
														CONNECT BY regexp_substr(variable, '[^,]+', 1, LEVEL) IS NOT NULL
    30/11/2023		OSF-1918	  jpinedc			Se modifica cuOrderR agregando con union all cursor para productos
                                                    con edad_catera mayor a 90 dias, con reclamos pendiente por valor total
                                                    y sin cuentas con saldo posteriores con saldo exceptuando las no
                                                    vencidas
    **************************************************************************************************************************************/
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'ldc_legaordergestcart';

        sbproceso   VARCHAR2(100)  := 'ldc_legaordergestcart_hilos'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        onuerror NUMBER;
        msgerror varchar2(4000);

        onuok   NUMBER;
        sbError varchar2(4000);

        dtpafein DATE;
        dtpafefi DATE;

        sbTt_Gc_Cartera		ld_parameter.value_chain%type	:=	DALD_PARAMETER.FSBGETVALUE_CHAIN('TT_GC_CARTERA', NULL);

        --Cursor para obtener la persona que esta legalizando
        cursor cu_personlega(nuOrder_Id NUMBER) is
          SELECT PERSON_ID FROM or_order_person WHERE ORDER_ID = nuOrder_Id;

        --Obtenemos las posibles causales de legalizacion de las ordenes de gestion de cartera
        nuCauProdR NUMBER := dald_parameter.fnuGetNumeric_Value('CAUSAL_USUARECU',
                                                                NULL);
        --nuCauProdA     NUMBER :=dald_parameter.fnuGetNumeric_Value('CAUSAL_USUABON',NULL);
        nuCauProdNR NUMBER := dald_parameter.fnuGetNumeric_Value('CAUSAL_USUANREC',
                                                                 NULL);

        --Obtenemos la edad de mora a tener en cuenta
        nuEdadMora    NUMBER := dald_parameter.fnuGetNumeric_Value('PARAM_EDAD_MORA',
                                                                   NULL);

        nuPersonaLega NUMBER := dald_parameter.fnuGetNumeric_Value('PERSON_LEGA_ORDCART',
                                                                   NULL);

        sbCadenaLegalizacion    CONSTANTS_PER.TIPO_XML_SOL%TYPE;

        --Cursor de ordenes de gestion de cartera recuperadas -(Opt. Con hilos)
        CURSOR cuOrderR(dtcufein DATE, dtcufefi DATE) IS
            WITH minCuCoRecl AS
            (
                SELECT ccm.cuconuse, MIN(cucocodi) cucocodi
                FROM cuencobr ccm
                WHERE (nvl( ccm.cucovare,0 ) + nvl(ccm.cucovrap,0)) > 0
                AND ccm.cucofeve < sysdate
                GROUP BY ccm.cuconuse
            ),
            minCuCoNoVenc AS
            (
                SELECT ccnv.cuconuse, MIN(cucocodi) cucocodi
                FROM cuencobr ccnv
                WHERE ccnv.cucofeve > sysdate
                GROUP BY ccnv.cuconuse
            )
          SELECT o.order_id
            FROM or_order             o,
                 gc_coll_mgmt_pro_det x,
                 pr_product           p,
                 ldc_osf_sesucier,
                 ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS columna
                   FROM dual
                   CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt
           WHERE o.task_type_id = tt.columna
             AND trunc(o.created_date) BETWEEN dtcufein AND dtcufefi
             AND o.order_id = x.order_id
             AND o.ORDER_STATUS_ID = 5
             AND x.product_id = p.product_id
             AND o.operating_unit_id in
                 (select distinct unidad_operativa
                    from ldc_metas_cont_gestcobr r
                   where r.ano = nuanoact
                     and r.mes = numesact
                     and r.meta_usuarios > 0
                     and r.meta_deuda > 0
                     and r.tarifa_usuario is not null
                     and r.tarifa_cartera is not null)
             AND nuano = 2024--nuanoact
             AND numes = 4--numesact
             AND producto = x.product_id
             AND edad <= nuEdadMora
             AND area_servicio = area_servicio
             AND (estado_financiero <> 'C' OR (estado_financiero = 'C' AND (SELECT SESUESFN FROM SERVSUSC WHERE SESUNUSE = x.product_id) <> 'C'))
             AND SUBSTR(TO_CHAR(o.order_id), LENGTH(TO_CHAR(o.order_id) - 1), 1) =
                 TO_CHAR(INUHILO)
            UNION ALL
            SELECT od.order_id
            FROM or_order             od,
                 gc_coll_mgmt_pro_det x,
                 pr_product           pr,
                 ldc_osf_sesucier     ci,
                 ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS columna
                   FROM dual
                   CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt,
                minCuCoRecl,
                minCuCoNoVenc
            WHERE od.task_type_id = tt.columna
             AND trunc(od.created_date) BETWEEN dtcufein AND dtcufefi
             AND od.order_id = x.order_id
             AND od.ORDER_STATUS_ID = 5
             AND x.product_id = pr.product_id
             AND od.operating_unit_id in
                 (select distinct unidad_operativa
                    from ldc_metas_cont_gestcobr r
                   where r.ano = nuanoact
                     and r.mes = numesact
                     and r.meta_usuarios > 0
                     and r.meta_deuda > 0
                     and r.tarifa_usuario is not null
                     and r.tarifa_cartera is not null)
             AND nuano = 2024--nuanoact
             AND numes = 5--numesact
             AND ci.producto = x.product_id
             AND ci.edad > nuEdadMora
             AND ci.area_servicio = ci.area_servicio
             AND (ci.estado_financiero <> 'C' OR (ci.estado_financiero = 'C' AND (SELECT SESUESFN FROM SERVSUSC WHERE SESUNUSE = x.product_id) <> 'C'))
             AND SUBSTR(TO_CHAR(od.order_id), LENGTH(TO_CHAR(od.order_id) - 1), 1) =
                 TO_CHAR(INUHILO)
            AND minCuCoRecl.cuconuse = pr.product_id
            AND minCuCoNoVenc.cuconuse(+) = pr.product_id
            and NOT EXISTS
            (
                SELECT '1'
                FROM cuencobr cci
                WHERE cci.cuconuse = pr.product_id
                AND cci.cucocodi > minCuCoRecl.cucocodi
                AND cci.cucocodi < nvl(minCuCoNoVenc.cucocodi,9999999999999999)
                AND NVL( cci.cucosacu, 0 ) > 0
                AND NVL( cci.cucovaab, 0 ) = 0
            );

        --Cursor de ordenes de gestion de cartera no recuperadas
        CURSOR cuOrderNR(dtcufein DATE, dtcufefi DATE) IS
          SELECT o.order_id
            FROM or_order             o,
                 gc_coll_mgmt_pro_det x,
                 pr_product           p,
                 ldc_osf_sesucier,
                 ((SELECT to_number(regexp_substr(sbTt_Gc_Cartera,
                                    '[^,]+',
                                    1,
                                    LEVEL)) AS columna
                   FROM dual
                   CONNECT BY regexp_substr(sbTt_Gc_Cartera, '[^,]+', 1, LEVEL) IS NOT NULL)) tt
           WHERE o.task_type_id = tt.columna
             AND trunc(o.created_date) BETWEEN dtcufein AND dtcufefi
             AND o.order_id = x.order_id
             AND o.ORDER_STATUS_ID = 5
             AND x.product_id = p.product_id
             AND o.operating_unit_id in
                 (select distinct unidad_operativa
                    from ldc_metas_cont_gestcobr r
                   where r.ano = nuanoact
                     and r.mes = numesact
                     and r.meta_usuarios > 0
                     and r.meta_deuda > 0
                     and r.tarifa_usuario is not null
                     and r.tarifa_cartera is not null)
             and nuano = 2024--nuanoact
             AND numes = 5--numesact
             AND producto = x.product_id
             AND (edad > nuEdadMora or ((SELECT SESUESFN FROM SERVSUSC WHERE SESUNUSE = x.product_id) = 'C'))
             AND area_servicio = area_servicio
             AND SUBSTR(TO_CHAR(o.order_id), LENGTH(TO_CHAR(o.order_id) - 1), 1) =
                 TO_CHAR(INUHILO);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);

        pkg_traza.trace('INUHILO: ' 	|| INUHILO 		|| chr(10) ||
                        'INUSESION: ' 	|| INUSESION 	|| chr(10) ||
                        'nuanoact: ' 	|| nuanoact 	|| chr(10) ||
                        'numesact: ' 	|| numesact 	|| chr(10) ||
                        'sbdtpafein: ' 	|| sbdtpafein 	|| chr(10) ||
                        'sbdtpafefi: ' 	|| sbdtpafefi, csbNivelTraza);

        --Se convierten las fechas recibidas de String a Date
        Begin
            dtpafein := trunc(TO_DATE(sbdtpafein, 'dd/mm/yyyy HH24:MI:SS'));
            dtpafefi := trunc(TO_DATE(sbdtpafefi, 'dd/mm/yyyy HH24:MI:SS'));
        Exception
          when others then
            null;
        End;

        --EHG--Se actualizan a estado (P = Procesado), los registros de la tabla temporal LDC_TEMP_CIERRECARTERA_HILOS.
        UPDATE LDC_TEMP_CIERRECARTERA_HILOS
           SET STATUS = 'P'
         WHERE NUSESION = INUSESION
           AND HILO = INUHILO;
        COMMIT;

        -- Se inicia log del programa
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        --Recorremos el cursor de ordenes de gestion de cartera que fueron recuperadas
        FOR i IN cuOrderR(dtpafein, dtpafefi) LOOP

            BEGIN
                onuerror := null;
                msgerror := null;

                pkg_cadena_legalizacion.prSetDatosBasicos
                (
                    i.order_id,
                    nuCauProdR,
                    nuPersonaLega,
                    1277,
                    'Orden Legalizada por proceso ldc_legaordergestcart'
                );

                pkg_cadena_legalizacion.prAgregaActividadOrden;

                sbCadenaLegalizacion := pkg_cadena_legalizacion.fsbCadenaLegalizacion;

                --se legaliza orden de trabajo
                API_LEGALIZEORDERS(sbCadenaLegalizacion,
                                  SYSDATE,
                                  SYSDATE,
                                  null,
                                  onuerror,
                                  msgerror
                                  );

                dbms_lock.sleep(2);

                IF onuerror = 0 THEN
                    COMMIT;
                ELSE
                    -- se registran los log de errores
                    proRegistraLog
                    (
                        'LEGA_PROD_R 200-2704',
                        SYSDATE,
                        i.order_id,
                        msgerror,
                        gnutsess,
                        gsbparuser
                    );
                    onuok   := onuerror;
                    sbError := msgerror;
                    ROLLBACK;
                END IF;

            EXCEPTION
                WHEN OTHERS THEN
                NULL;
            END;
        END LOOP;

        --Recorremos el cursor de ordenes de gestion de cartera que NO fueron recuperadas
        FOR i IN cuOrderNR(dtpafein, dtpafefi) LOOP
            BEGIN
                onuerror := null;
                msgerror := null;

                pkg_cadena_legalizacion.prSetDatosBasicos
                (
                    i.order_id,
                    nuCauProdNR,
                    nuPersonaLega,
                    1277,
                    'Orden Legalizada por proceso ldc_legaordergestcart'
                );

                pkg_cadena_legalizacion.prAgregaActividadOrden;

                sbCadenaLegalizacion := pkg_cadena_legalizacion.fsbCadenaLegalizacion;

                --se legaliza orden de trabajo
                API_LEGALIZEORDERS(sbCadenaLegalizacion,
                                  SYSDATE,
                                  SYSDATE,
                                  null,
                                  onuerror,
                                  msgerror
                              );

                dbms_lock.sleep(2);

                IF onuerror = 0 THEN
                    COMMIT;
                ELSE
                    -- se registran los log de errores
                    proRegistraLog('LEGA_PROD_NR 200-2704',
                                 SYSDATE,
                                 i.order_id,
                                 msgerror,
                                 gnutsess,
                                 gsbparuser);
                      onuok   := onuerror;
                    sbError := msgerror;
                    ROLLBACK;
            END IF;

            EXCEPTION
                WHEN OTHERS THEN
                    NULL;
            END;
        END LOOP;

        --Actualiza el estado de los registros procesados en la tabla temporal de Hilos LDC_TEMP_CIERRECARTERA_HILOS y los establece en T (Terminado).
        UPDATE LDC_TEMP_CIERRECARTERA_HILOS
           SET STATUS      = 'T',
               OBSERVACION = 'TERMINADO OK LDC_TEMP_CIERRECARTERA_HILOS.'
         WHERE NUSESION = INUSESION
           AND HILO = INUHILO;
        COMMIT;
        ---

        IF onuok IS NULL THEN
            onuok := 0;
        END IF;

        if onuok = 0 then
            sbError := 'Proceso termino Ok. - Hilo: ' || INUHILO || ', Sesion: ' ||
                     INUSESION;
        end if;

        pkg_estaproc.practualizaestaproc( sbProceso );

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
            pkg_Error.getError(onuok,sbError);
            pkg_traza.trace('sbError => ' || sbError );
            sbError := sbError || '- Hilo: ' || INUHILO || ', Sesion: ' ||
                     INUSESION;
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(onuok,sbError);
            pkg_traza.trace('sbError => ' || sbError );
            sbError := sbError || '- Hilo: ' || INUHILO || ', Sesion: ' ||
                     INUSESION;
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
    END ldc_legaordergestcart_hilos;

    PROCEDURE LDC_geneasilegaact(nuproducto    IN NUMBER,
                               nuUnidad      IN NUMBER,
                               nucausal      IN NUMBER,
                               nuPersonaLega IN NUMBER,
                               nuactividad   IN NUMBER,
                               nuvalor       IN NUMBER,
                               onuOrden      OUT NUMBER,
                               onuok         OUT NUMBER,
                               sbError       OUT VARCHAR2) IS
    --******************************************************************************************************************************************************
    --** EMPRESA              :HORBATH TECNOLOGIES
    --** OBJETO               :LDC_geneasilegaact
    --** PROPOSITO            :Registra actividad asiga y legaliza
    --** AUTOR                :John Jairo Jimenez Marimon
    --** FECHA CREACION       :01/02/2019
    --*******************************************************************************************************************************************************
        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'LDC_geneasilegaact';

        sbproceso   VARCHAR2(100)  := 'LDC_geneasilegaact'||TO_CHAR(SYSDATE,'DDMMYYYYHH24MISS');

        onuerror  NUMBER;

        nuActividadid NUMBER;

        nuactivityId	or_order_activity.order_activity_id%type;

        sbCadenaLegalizacion CONSTANTS_PER.TIPO_XML_SOL%TYPE;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

        pkg_traza.trace('nuproducto: ' 	|| nuproducto 	 || chr(10) ||
                       'nuUnidad: ' 	|| nuUnidad 	 || chr(10) ||
                       'nucausal: ' 	|| nucausal 	 || chr(10) ||
                       'nuPersonaLega: '|| nuPersonaLega || chr(10) ||
                       'nuvalor: ' 		|| nuvalor, csbNivelTraza);


        -- Se inicia log del programa
        pkg_estaproc.prinsertaestaproc( sbproceso , 1);

        --se genera orden de trabajo
        api_createorder(nuactividad,
                        NULL,
                        NULL,
                        NULL,
                        NULL,
                        PKG_BCPRODUCTO.FNUIDDIRECCINSTALACION(nuproducto),
                        NULL,
                        NULL,
                        NULL,
                        nuproducto,
                        NULL,
                        SYSDATE,
                        NULL,
                        'Orden de Gestio de Cobro Generada',
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
                        nuvalor,
                        NULL,
                        onuOrden,
                        nuactivityId,
                        onuerror,
                        sbError
                        );

        pkg_Traza.trace('Sale api_createorder onuOrden: ' 		|| onuOrden 	|| chr(10) ||
                        'nuactivityId: '	|| nuactivityId || chr(10) ||
                        'onuerror: ' 		|| onuerror 	|| chr(10) ||
                        'sbError: ' 		|| sbError, csbNivelTraza);

        IF onuerror = 0 THEN
            onuerror := null;
            sbError  := null;

            pkg_Traza.trace('Ingresa api_assign_order inuOrder: ' 		   || onuOrden || chr(10) ||
                            'inuOperatingUnit: ' || nuUnidad, csbNivelTraza);

            --se asigna orden de trabajo
            api_assign_order(onuOrden,
            nuUnidad,
            onuerror,
            sbError);

            pkg_Traza.trace('Sale api_assign_order onuErrorCode: '    || onuerror || chr(10) ||
                             'osbErrorMessage: ' || sbError, csbNivelTraza);

            IF onuerror = 0 THEN
                dbms_lock.sleep(2);
                nuActividadid := Daor_Order_Activity.Fnugetorder_Activity_Id(onuOrden,
                                                                         NULL);

                pkg_cadena_legalizacion.prSetDatosBasicos
                (
                    onuOrden,
                    nucausal,
                    nuPersonaLega,
                    1277,
                    'Orden Legalizada por proceso LDC_GENEASILEGAACT'
                );

                pkg_cadena_legalizacion.prAgregaActividadOrden;

                sbCadenaLegalizacion := pkg_cadena_legalizacion.fsbCadenaLegalizacion;

                --se legaliza orden de trabajo
                API_LEGALIZEORDERS(sbCadenaLegalizacion,
                              SYSDATE,
                              SYSDATE,
                              null,
                              onuerror,
                              sbError
                              );

                dbms_lock.sleep(2);

                IF onuerror <> 0 THEN
                    onuok := -1;
                END IF;
            ELSE
                onuok := -1;
            END IF;
        ELSE
            onuok := -1;
        END IF;

        IF onuok IS NULL THEN
            onuok := 0;
        END IF;

        pkg_estaproc.practualizaestaproc( sbProceso );

        pkg_traza.trace('onuOrden: '	|| onuOrden	|| chr(10) ||
                       'onuok: ' 		|| onuok 	|| chr(10) ||
                       'sbError: ' 		|| sbError, csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFin);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFin_Erc);
            pkg_Error.getError(onuok,sbError);
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFin_Err);
            pkg_Error.setError;
            pkg_Error.getError(onuok,sbError);
            pkg_estaproc.practualizaestaproc( sbproceso, 'Error ', sberror  );
    END LDC_geneasilegaact;

    PROCEDURE proRegistraLog(sbProceso  IN LDC_LOGPROC.LOPRPROC%TYPE,
                           dtFecha    IN LDC_LOGPROC.LOPRFEGE%TYPE,
                           nuProducto IN LDC_LOGPROC.LOPRPROD%TYPE,
                           sbError    IN LDC_LOGPROC.LOPRERRO%TYPE,
                           nuSesion   IN LDC_LOGPROC.LOPRSESI%TYPE,
                           sbUsuario  IN LDC_LOGPROC.LOPRUSUA%TYPE) IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Fecha       : 2017-04-01
      Ticket      : 200-991
      Descripcion : Proceso que genera log de errores

      Parametros Entrada
      sbProceso  nombre del proceso
      dtFecha    fecha de generacion
      nuProducto producto
      sbError    mensaje de error
      nuSesion   numero de sesion
      sbUsuario  usuario

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
        sbError1 VARCHAR2(4000);
        PRAGMA AUTONOMOUS_TRANSACTION;

        csbMetodo        CONSTANT VARCHAR2(70) := csbSP_NAME || 'proRegistraLog';

        nuError         NUMBER;
        sbError2        VARCHAR2(4000);

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbInicio);

        INSERT INTO LDC_LOGPROC
          (LOPRPROC, LOPRFEGE, LOPRPROD, LOPRERRO, LOPRSESI, LOPRUSUA)
        VALUES
          (sbProceso,
           dtFecha,
           nuProducto,
           substr(sbError, 1, 3999),
           nuSesion,
           sbUsuario);
        COMMIT;

        pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFin);

    EXCEPTION
        WHEN pkg_error.Controlled_Error THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError2);
            pkg_traza.trace( 'sbError2 => ' || sbError2,  csbNivelTraza );
            sbError1 := substr(sbError || ' Error no controlado ' || sbError2,
                         1,
                         3999);

            INSERT INTO LDC_LOGPROC
            (LOPRPROC, LOPRFEGE, LOPRPROD, LOPRERRO, LOPRSESI, LOPRUSUA)
            VALUES
            (sbProceso, dtFecha, nuProducto, sbError1, nuSesion, sbUsuario);
            COMMIT;
        WHEN OTHERS THEN
            pkg_traza.trace(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
            pkg_error.setError;
            pkg_Error.getError(nuError,sbError2);
            pkg_traza.trace( 'sbError2 => ' || sbError2,  csbNivelTraza );
            sbError1 := substr(sbError || ' Error no controlado ' || sbError2,
                         1,
                         3999);

            INSERT INTO LDC_LOGPROC
            (LOPRPROC, LOPRFEGE, LOPRPROD, LOPRERRO, LOPRSESI, LOPRUSUA)
            VALUES
            (sbProceso, dtFecha, nuProducto, sbError1, nuSesion, sbUsuario);
            COMMIT;

  END proRegistraLog;
END ldc_pkg_calc_gest_cartera;
/
