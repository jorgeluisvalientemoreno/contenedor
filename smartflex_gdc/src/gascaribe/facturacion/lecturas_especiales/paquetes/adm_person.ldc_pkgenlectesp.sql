CREATE OR REPLACE PACKAGE adm_person.LDC_PKGENLECTESP
IS
    /**************************************************************************
        Autor       : HB
        Fecha       : 2020-01-23
        Descripcion : Funcionalidad para generar nuevo tipo de trabajo de lecturas a contratos de los ciclos especiales (CA90)

        Parametros Entrada


        Valor de salida


       HISTORIA DE MODIFICACIONES
         FECHA        AUTOR           DESCRIPCION
        25/06/2024  PAcosta             OSF-2878: Cambio de esquema ADM_PERSON 
        20-05-2021  Horbath.CA633       Se modifica el procedimiento prGeneraOrden
        13-06-2023  cgonzalez		    OSF-1203: Se modifica el servicio prGeneraLecturas
        17-07-2023  jcatuchemvm         OSF-1258: Ajuste por encapsulamiento de procedimientos open
                                            [prGeneraOrden]     
                                        Se actualizan llamados a métodos errors por los
                                        correspondientes en pkg_error     
        19-02-2024  jcatuchemvm         OSF-2350: Se ajusta la siguiente función
                                            [fnuExisOrdLec]
                                            [prGeneraOrden]
                                        A nivel general, se eliminan los esquemas en los llamados a objetos de la base de datos,
                                        se cambian los llamados  a  pkConstante.tyRefCursor por constants_per.tyrefcursor,
                                        ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid, dapr_product.fnugetaddress_id por pkg_bcproducto.fnuiddireccinstalacion,
                                        dapr_product.fnugetsubscription_id por pkg_bcproducto.fnucontrato
                                        Estandarización de traza y corrección de cursores select into 
                                        
    ***************************************************************************/


    ------------------
    -- Constantes
    ------------------

    -----------------------
    -- Variables
    -----------------------
    nuConfiguracion   NUMBER;

    nuSesion          NUMBER (15);
    dtFechaProc       DATE;
    nuOrdenLog        NUMBER (5) := 0;
    sbUsuario         VARCHAR2 (10);

    nupefacicl        perifact.pefacicl%TYPE;
    nupefaano         perifact.pefaano%TYPE;
    nupefames         perifact.pefames%TYPE;
    nupefafimo        perifact.pefafimo%TYPE;
    nupefaffmo        perifact.pefaffmo%TYPE;
    nupecscons        pericose.pecscons%TYPE;

    nucontlei         NUMBER := 0;
    nucontgene        NUMBER := 0;
    nuconterro        NUMBER := 0;
    nucontaleg        NUMBER := 0;
    nucontlega        NUMBER := 0;
    nucontlerr        NUMBER := 0;


    FUNCTION GetCursorCiclos
        RETURN constants_per.tyrefcursor;

    PROCEDURE prGeneraLecturas (inuCodiPefa           NUMBER,
                                InuActReg             NUMBER,
                                InuTotalReg           NUMBER,
                                OnuErrorCode      OUT NUMBER,
                                OsbErrorMessage   OUT VARCHAR2);

    FUNCTION fnuValidaPeriodo (inupefa IN servsusc.sesususc%TYPE)
        RETURN NUMBER;

    PROCEDURE prGeneraOrden (inunuse   IN servsusc.sesunuse%TYPE,
                             inupefa   IN perifact.pefacodi%TYPE);

    FUNCTION fnu_GetDatosPeriodo (inupefa perifact.pefacodi%TYPE)
        RETURN NUMBER;

    FUNCTION fnu_GetFlagLecPerAnt
        RETURN VARCHAR2;

    FUNCTION fnuExisOrdLec (inunuse          servsusc.sesunuse%TYPE,
                            inutipotrab   IN or_order.task_type_id%TYPE)
        RETURN VARCHAR2;

    PROCEDURE pro_grabalog (isbobse VARCHAR2);
END LDC_PKGENLECTESP;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGENLECTESP
IS
    /**************************************************************************
        Autor       : HB
        Fecha       : 2020-01-23
        Descripcion : Funcionalidad para Generacion de Lecturas a Ciclos Especiales (CA90)



       HISTORIA DE MODIFICACIONES
         FECHA        AUTOR           DESCRIPCION
         20-05-2021   Horbath.CA633   Se modifica el procedimiento prGeneraOrden
		 13-06-2023   cgonzalez		  OSF-1203: Se modifica el servicio prGeneraLecturas
    ***************************************************************************/
    csbPaquete              CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre del paquete    
    csbNivelTraza           CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este paquete. 
    csbInicio               CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin                  CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado
    
    nuError                 NUMBER;
    sbError                 VARCHAR2(4000);


    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : GetCursorCiclos
      Descripcion    : Retorna cursor a la forma LECTESPGELE

      Autor          :
      Fecha          :

      Parametros         Descripci?n
      ============   ===================


      Historia de Modificaciones
      Fecha            Autor                    Modificaci?n
      =========      =========                ====================


    ******************************************************************/
    FUNCTION GetCursorCiclos
        RETURN constants_per.tyrefcursor
    IS
        csbMetodo       CONSTANT VARCHAR2(100) := csbPaquete||'GetCursorCiclos';
        rfcursor        constants_per.tyrefcursor;
        nuTipoCiclo     ge_boInstanceControl.stysbValue;
        nuValidate      NUMBER;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        /*obtener los valores ingresados en la aplicacion PB */
        nuTipoCiclo :=
            ge_boInstanceControl.fsbGetFieldValue ('LDC_CM_LECTESP_TPCL',
                                                   'TIPOCICL_ID');


        /*Se valida el ingreso de los datos*/
        IF nuTipoCiclo IS NULL
        THEN
            Pkg_Error.SetErrorMessage(Ld_Boconstans.cnuGeneric_Error,
                             'Debe ingresar Tipo de Ciclo');
            RAISE Pkg_Error.CONTROLLED_ERROR;
        END IF;



        OPEN rfcursor FOR
              SELECT PEFACODI        COD_PERIODO,
                     PEFACICL        CICLO,
                     PEFAANO         ANO,
                     PEFAMES         MES,
                     P.PEFAFIMO      FECH_INI_MOV,
                     P.PEFAFFMO      FECH_FIN_MOV,
                     P.PEFAACTU      PER_ACTUAL,
                     PC.PECSFECI     FECH_INI_CONSUMO,
                     PC.PECSFECF     FECH_FIN_CONSUMO,
                     PC.PECSPROC     LECT_GENERADA
                FROM PERIFACT           P,
                     PERICOSE           PC,
                     LDC_CM_LECTESP_CICL LE,
                     CICLCONS           CC
               WHERE     PC.PECSFECF BETWEEN P.PEFAFIMO AND P.PEFAFFMO
                     AND P.PEFACICL = PC.PECSCICO
                     AND PEFACICL = LE.PECSCICO
                     AND CC.CICOCODI = PC.PECSCICO
                     AND P.PEFAACTU = 'S'
                     AND PC.PECSPROC = 'N'
                     AND CC.CICOGELE = 'N'
                     AND LE.PECSTPCI = nuTipoCiclo
            ORDER BY PEFACICL;
            
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN rfcursor;
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END GetCursorCiclos;

    /*****************************************************************
      Propiedad intelectual de Open International Systems (c).

      Unidad         : prGeneraLecturas

      Historia de Modificaciones
      Fecha            Autor                    Modificaci?n
      =========      =========                ====================
	  13-06-2023     cgonzalez		    OSF-1203: Se modifica para procesar productos en estado de corte diferente de 96, estado 
										de producto no sea 3, 15, 16 y que tengan medidor asociado
    ******************************************************************/
    PROCEDURE prGeneraLecturas (inuCodiPefa           NUMBER,
                                InuActReg             NUMBER,
                                InuTotalReg           NUMBER,
                                OnuErrorCode      OUT NUMBER,
                                OsbErrorMessage   OUT VARCHAR2)
    IS
        csbMetodo       CONSTANT VARCHAR2(100) := csbPaquete||'prGeneraLecturas';
        nuValida         NUMBER;
        nuDatPer         NUMBER;
        --
        sbcommit         VARCHAR2 (1) := 'N';
        nuErrorCode      NUMBER;
        sbErrorMessage   VARCHAR2 (4000);
        nuciclo          servsusc.sesucicl%TYPE;
        nuptodtotales    NUMBER := 0;
		sbEstaCort		 VARCHAR2(200) := ldc_bcconsgenerales.fsbValorColumna('LD_PARAMETER', 'VALUE_CHAIN', 'PARAMETER_ID', 'ESTACORT_LECTESPGELE');
    
        CURSOR cuCuentaProd IS
            SELECT COUNT (1)
              FROM PERIFACT P, SERVSUSC, PR_PRODUCT
             WHERE     PEFACODI = inuCodiPefa
                   AND PEFACICL = SESUCICL
                   AND SESUSERV = 7014
                   AND SESUESCO IN
                           (SELECT c.coeccodi
                              FROM confesco c
                             WHERE c.coecserv = 7014 
							 AND c.coecfact = 'S'
							 AND c.coeccodi NOT IN (SELECT to_number(regexp_substr(sbEstaCort, '[^,]+', 1, LEVEL)) AS estacort
													FROM dual
													CONNECT BY regexp_substr(sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL))
				   AND EXISTS (SELECT 'X' FROM elmesesu WHERE sesunuse = emsssesu AND SYSDATE BETWEEN emssfein AND emssfere)
				   AND sesunuse = product_id
				   AND product_status_id NOT IN (3, 15, 16);

        CURSOR cuProductos IS
            SELECT SESUNUSE, SESUCICL
              FROM PERIFACT P, SERVSUSC, PR_PRODUCT
             WHERE     PEFACODI = inuCodiPefa
                   AND PEFACICL = SESUCICL
                   AND SESUSERV = 7014
                   AND SESUESCO IN
                           (SELECT c.coeccodi
                              FROM confesco c
                             WHERE c.coecserv = 7014 
							 AND c.coecfact = 'S'
							 AND c.coeccodi NOT IN (SELECT to_number(regexp_substr(sbEstaCort, '[^,]+', 1, LEVEL)) AS estacort
													FROM dual
													CONNECT BY regexp_substr(sbEstaCort, '[^,]+', 1, LEVEL) IS NOT NULL))
				   AND EXISTS (SELECT 'X' FROM elmesesu WHERE sesunuse = emsssesu AND SYSDATE BETWEEN emssfein AND emssfere)
				   AND sesunuse = product_id
				   AND product_status_id NOT IN (3, 15, 16);
				  
        CURSOR cuSesion IS
        SELECT SYSDATE, USERENV ('SESSIONID'), USER
        FROM DUAL;
				   
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuCodiPefa    <= '||inuCodiPefa, csbNivelTraza);
        pkg_traza.trace('InuActReg      <= '||InuActReg, csbNivelTraza);
        pkg_traza.trace('InuTotalReg    <= '||InuTotalReg, csbNivelTraza);
        
        IF cuSesion%ISOPEN THEN 
            CLOSE cuSesion;
        END IF;

        open cuSesion;
        fetch cuSesion into dtFechaProc, nusesion, sbusuario;
        close cuSesion;

        nuDatPer := fnu_GetDatosPeriodo (inuCodiPefa);
        pkg_traza.trace ('nuDatPer: ' || nuDatPer,csbNivelTraza);

        IF nuDatPer != 0
        THEN
            pro_grabalog ('Error buscando datos del periodo ' || inuCodiPefa);
            RETURN;
        END IF;

        pro_grabalog (
            'Inicio Generacion Lecturas del Periodo ' || inuCodiPefa);

        nuValida := fnuValidaPeriodo (inuCodiPefa);
        pkg_traza.trace ('nuValida: ' || nuValida,csbNivelTraza);

        IF nuValida = 0
        THEN
            --Inicializa contadores
            nucontlei   := 0;
            nucontgene  := 0;
            nuconterro  := 0;
            nucontaleg  := 0;
            nucontlega  := 0;
            nucontlerr  := 0;
    
            OPEN cuCuentaProd;
            FETCH cuCuentaProd INTO nuptodtotales;

            IF cuCuentaProd%NOTFOUND
            THEN
                nuptodtotales := 0;
            END IF;

            CLOSE cuCuentaProd;

            pkg_traza.trace ('nuptodtotales: '|| nuptodtotales,csbNivelTraza);

            FOR rg IN cuProductos
            LOOP
                nuciclo := rg.sesucicl;
                nucontlei := nucontlei + 1;
                prGeneraOrden (rg.sesunuse, inuCodiPefa);
            END LOOP;
        END IF;

        -- actualiza flag de lectura
        IF (nuptodtotales > 0) AND (nucontlei = nucontgene + nucontlega)
        THEN
            UPDATE pericose
               SET pecsproc = 'S'
             WHERE pecscons = nupecscons;

            COMMIT;
        END IF;

        pro_grabalog (
               'Fin Generacion Lecturas del Periodo '
            || inuCodiPefa
            || '. Prod Leidos: '
            || nucontlei
            || ' Ordenes Generadas a procesar: '
            || nucontgene
            || ' Ordenes a Generar que tuvieron error: '
            || nuconterro
            || ' Ordenes Generadas a Cerrar: '
            || nucontaleg
            || ' Ordenes Cerradas: '
            || nucontlega
            || ' Ordenes a Cerrar que tuvieron error: '
            || nucontlerr);
            
        pkg_traza.trace('OnuErrorCode       => '||OnuErrorCode, csbNivelTraza);
        pkg_traza.trace('OsbErrorMessage    => '||OsbErrorMessage, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR
        THEN
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            pro_grabalog (
                   'Error en Generacion Lecturas del Periodo '
                || inuCodiPefa
                || ': '
                || sbError);
                
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            pro_grabalog (
                   'Error en Generacion Lecturas del Periodo '
                || inuCodiPefa
                || ': '
                || sbError);
            
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prGeneraLecturas;

    FUNCTION fnuValidaPeriodo (inupefa IN servsusc.sesususc%TYPE)
        RETURN NUMBER
    IS
        /************************
        Historial de Modificaciones
         Autor        Fecha            Observacion
         LJLB         08/06/2022       CA OSF-346 se quita validacion de periodo de consumo anterior
        *************/
        csbMetodo       CONSTANT VARCHAR2(100) := csbPaquete||'fnuValidaPeriodo';
        sbMensErr   VARCHAR2 (4000) := NULL;
        nuGenerar   NUMBER;

        CURSOR cuPeriodo IS
            SELECT PEFACODI        COD_PERIODO,
                   PEFACICL        CICLO,
                   PEFAANO         ANO,
                   PEFAMES         MES,
                   P.PEFAFIMO      FECH_INI_MOV,
                   P.PEFAFFMO      FECH_FIN_MOV,
                   P.PEFAACTU      PER_ACTUAL,
                   PC.PECSCONS,
                   PC.PECSFECI     FECH_INI_CONSUMO,
                   PC.PECSFECF     FECH_FIN_CONSUMO,
                   PEFAACTU,
                   PC.PECSPROC,
                   CICOGELE
              FROM PERIFACT             P,
                   PERICOSE             PC,
                   LDC_CM_LECTESP_CICL  LE,
                   CICLCONS             CC
             WHERE     PC.PECSFECF BETWEEN P.PEFAFIMO AND P.PEFAFFMO
                   AND P.PEFACICL = PC.PECSCICO
                   AND PEFACICL = LE.PECSCICO
                   AND CC.CICOCODI = PC.PECSCICO
                   AND PEFACODI = inupefa;

        rgPeri      cuPeriodo%ROWTYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inupefa    <= '||inupefa, csbNivelTraza);
        
        OPEN cuPeriodo;
        FETCH cuPeriodo INTO rgPeri;

        IF cuPeriodo%NOTFOUND
        THEN
            rgPeri.Cod_Periodo := NULL;
        END IF;

        CLOSE cuPeriodo;

        IF rgPeri.Cod_Periodo IS NULL
        THEN
            sbMensErr :=
                   'Periodo de Fact '
                || rgperi.cod_periodo
                || ' No Existe'
                || CHR (13);
            nuGenerar := 1;
        ELSIF NVL (rgPeri.Pefaactu, 'N') != 'S'
        THEN
            sbMensErr :=
                   'Periodo de Fact '
                || rgperi.cod_periodo
                || ' del Ciclo '
                || rgperi.ciclo
                || ' No es el p??riodo actual'
                || CHR (13);
            nuGenerar := 1;
        ELSIF NVL (rgPeri.Cicogele, 'N') = 'S'
        THEN
            sbMensErr :=
                   'Al Periodo de Consumo '
                || rgperi.pecscons
                || ' del Ciclo '
                || rgperi.ciclo
                || ' se le generan lecturas normales'
                || CHR (13);
            nuGenerar := 1;
        ELSIF NVL (rgPeri.Pecsproc, 'N') = 'S'
        THEN
            sbMensErr :=
                   'Al Periodo de Consumo '
                || rgperi.pecscons
                || ' del Ciclo '
                || rgperi.ciclo
                || ' Ya se le ejecuto generacion de Lecturas'
                || CHR (13);
            nuGenerar := 1;
        ELSIF TRUNC (SYSDATE) NOT BETWEEN rgPeri.Fech_Ini_Mov
                                      AND rgPeri.Fech_Fin_Mov
        THEN
            sbMensErr :=
                   'Fecha Actual no esta en el rango de fechas del Periodo de Fact '
                || rgperi.cod_periodo;
            nuGenerar := 1;
        /* CA OSF-346
          elsif fnu_GetFlagLecPerAnt = 'N' then
            sbMensErr := 'aL Periodo de consumo anterior no se le ha generado proceso de Lecturas';
            nuGenerar := 1; */
        ELSE
            nuGenerar := 0;
        END IF;

        IF nuGenerar = 1
        THEN
            pro_grabalog (sbMensErr);
        END IF;
        
        pkg_traza.trace('nuGenerar  => '||nuGenerar, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuGenerar;
    EXCEPTION
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            sbMensErr :=
                   sbMensErr
                || 'Error en Periodo de Fact '
                || inupefa
                || ': '
                || sbError;
            pro_grabalog (sbMensErr);
            
            nuGenerar := -1;
            pkg_traza.trace('nuGenerar  => '||nuGenerar, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN nuGenerar;
    END fnuValidaPeriodo;

    /*****************************************************************
      Propiedad intelectual de PETI (c).

      Unidad         : prGeneraOrden
      Descripcion    : Genera la orden y la legaliza
      Autor          : Horbath
      Fecha          : 23/09/2020

      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      20/05/2021       Horbath.CA633      Se elimina el nuItemaLeg de la cadena de legalizacion
      17/07/2023       jcatuchemvm        OSF-1258: Actualización llamados OS_LEGALIZEORDERS por API_LEGALIZEORDERS,
                                          OS_ASSIGN_ORDER por api_assign_order, OS_CREATEORDERACTIVITIES por api_createorder
      23/02/2024       jcatuchemvm        OSF-2350 se ajusta llamado api_createorder para incluir el producto y el contrato 
    ******************************************************************/

    PROCEDURE prGeneraOrden (inunuse   IN servsusc.sesunuse%TYPE,
                             inupefa   IN perifact.pefacodi%TYPE)
    IS
        csbMetodo           CONSTANT VARCHAR2(100) := csbPaquete||'prGeneraOrden';
        sbMensErr           VARCHAR2 (4000);
        nuAddress           ab_Address.Address_Id%TYPE;
        nuTipotrab          or_task_type.task_type_id%TYPE;
        nuActividad         ge_items.items_id%TYPE;
        nuUnidOp            or_operating_unit.operating_unit_id%TYPE;
        nuCausal            ge_Causal.Causal_Id%TYPE;
        nuactividadot       or_order_activity.order_activity_id%TYPE;
        nuItemaLeg          LD_PARAMETER.NUMERIC_VALUE%TYPE
            := DALD_PARAMETER.fnuGetNumeric_Value ('COD_ACT_LEC', NULL);

        nupersonid           NUMBER := pkg_bopersonal.fnugetpersonaid;
        sbdatosadicionales   VARCHAR2 (200) := '';
        ISBDATAORDER         VARCHAR2 (2000);
        sbDescLeg            VARCHAR2 (2000) := NULL;
        nuCantLeg            NUMBER := 1;
        idtExeInitialDate    DATE := SYSDATE;
        idtExeFinalDate      DATE := SYSDATE;
        idtChangeDate        DATE := SYSDATE;

        idtexecdate          or_order.exec_estimate_date%TYPE := SYSDATE + 30;
        isbcomment           or_order_activity.comment_%TYPE
                                 := 'Orden de Lectura Ciclos Especiales';
        nuReferenceValue     or_order_activity.value_reference%TYPE := 0;
        ionuOrderId          or_order.order_id%TYPE;
        ionuOrderActivityId  or_order_activity.order_activity_id%type;
        onuErrorCode         NUMBER;
        osbErrorMessage      VARCHAR2 (4000);

        rcOrder              daor_order.styOR_order;

        CURSOR cuAdress IS
            SELECT p.address_id
              FROM pr_product p
             WHERE p.product_id = inunuse;

        CURSOR cuTipoTrab IS
            SELECT tc.task_type_id
              FROM perifact P, LDC_CM_LECTESP_CICL C, LDC_CM_LECTESP_TPCL TC
             WHERE     p.pefacodi = inupefa
                   AND p.pefacicl = c.pecscico
                   AND c.pecstpci = tc.tipocicl_id;

        CURSOR cuActividad (inutiptrab or_task_type.task_type_id%TYPE)
        IS
            SELECT TI.ITEMS_ID
              FROM OR_TASK_TYPES_ITEMS TI, GE_ITEMS I
             WHERE     TI.TASK_TYPE_ID = inutiptrab
                   AND TI.ITEMS_ID = I.ITEMS_ID
                   AND I.ITEM_CLASSIF_ID = 2;

        CURSOR cuContratoEsp IS
            SELECT t.unidad_op_id, t.causal_id
              FROM LDC_CM_LECTESP_CONTNL t
             WHERE t.contrato_id = (SELECT sesususc
                                      FROM servsusc
                                     WHERE sesunuse = inunuse);

        CURSOR cuActividadOt (nuorden or_order.order_id%TYPE)
        IS
            SELECT ooa.order_activity_id
              FROM or_order_activity ooa
             WHERE ooa.order_id = nuOrden;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inunuse    <= '||inunuse, csbNivelTraza);
        pkg_traza.trace('inupefa    <= '||inupefa, csbNivelTraza);

        nuAddress := pkg_bcproducto.fnuiddireccinstalacion (inunuse);

        pkg_traza.trace ('nuAddress: ' || nuAddress,csbNivelTraza);

        IF NVL (nuAddress, -1) = -1
        THEN
            sbMensErr :=
                'No se encontro address_id para el producto ' || inunuse;
            pro_grabalog (sbMensErr);
            nuconterro := nuconterro + 1;
            RETURN;
        END IF;

        -- busca tipo de trabajo
        OPEN cuTipoTrab;
        FETCH cuTipoTrab INTO nuTipotrab;

        IF cuTipoTrab%NOTFOUND
        THEN
            nuTipotrab := -1;
        END IF;

        CLOSE cuTipoTrab;

        pkg_traza.trace ('nuTipotrab: ' || nuTipotrab,csbNivelTraza);

        IF NVL (nuTipotrab, -1) = -1
        THEN
            sbMensErr :=
                   'No se encontro Tipo de Trabajo a Generar para el producto '
                || inunuse;
            pro_grabalog (sbMensErr);
            nuconterro := nuconterro + 1;
            RETURN;
        END IF;

        -- busca actividad
        OPEN cuActividad (nuTipotrab);
        FETCH cuActividad INTO nuActividad;

        IF cuActividad%NOTFOUND
        THEN
            nuActividad := -1;
        END IF;

        CLOSE cuActividad;

        pkg_traza.trace ('nuActividad: ' || nuActividad,csbNivelTraza);

        IF NVL (nuActividad, -1) = -1
        THEN
            sbMensErr :=
                   'No se encontro Actividad para el Tipo de Trabajo '
                || nuTipotrab
                || '(Producto '
                || inunuse;
            pro_grabalog (sbMensErr);
            nuconterro := nuconterro + 1;
            RETURN;
        END IF;

        IF fnuExisOrdLec (inunuse, nuTipotrab) = 'S'
        THEN
            sbMensErr :=
                   'Ya existe una orden en el periodo para el Producto '
                || inunuse;
            pro_grabalog (sbMensErr);
            nucontgene := nucontgene + 1;
            RETURN;
        END IF;

        pkg_traza.trace ('fnuExisOrdLec: N',csbNivelTraza);


        api_createorder
        (
          inuItemsid          => nuActividad,
          inuPackageid        => null,
          inuMotiveid         => null,
          inuComponentid      => null,
          inuInstanceid       => null,
          inuAddressid        => nuAddress,
          inuElementid        => null,
          inuSubscriberid     => null,
          inuSubscriptionid   => pkg_bcproducto.fnucontrato (inunuse),
          inuProductid        => inunuse,
          inuOperunitid       => null,
          idtExecestimdate    => SYSDATE + 0.00138,
          inuProcessid        => null,
          isbComment          => isbcomment,
          iblProcessorder     => true,
          inuRefvalue         => nuReferenceValue,
          ionuOrderid         => ionuOrderId,
          ionuOrderactivityid => ionuOrderActivityId,
          onuErrorCode        => onuErrorCode,
          osbErrorMessage     => osbErrorMessage
        );

        pkg_traza.trace ('Crea orden - onuErrorCode: '|| onuErrorCode|| ' osbErrorMessage: '|| osbErrorMessage,csbNivelTraza);

        IF onuErrorCode <> 0
        THEN
            sbMensErr :=
                   'Error creando orden para producto '
                || inunuse
                || '. '
                || osbErrorMessage;
            pro_grabalog (sbMensErr);
            nuconterro := nuconterro + 1;
            ROLLBACK;
            RETURN;
        ELSE
            OPEN cuContratoEsp;
            FETCH cuContratoEsp INTO nuUnidOp, nuCausal;

            IF cuContratoEsp%NOTFOUND
            THEN
                nuUnidOp := -1;
            END IF;

            CLOSE cuContratoEsp;

            pkg_traza.trace ('nuUnidOp: '|| nuUnidOp|| ' nuCausal: '|| nuCausal,csbNivelTraza);

            IF NVL (nuUnidOp, -1) != -1
            THEN
                nucontaleg := nucontaleg + 1;
                api_assign_order (ionuOrderId,
                                 nuUnidOp,
                                 onuErrorCode,
                                 osbErrorMessage);

                pkg_traza.trace ('Asigna orden - onuErrorCode: '|| onuErrorCode|| ' osbErrorMessage: '|| osbErrorMessage,csbNivelTraza);


                IF osberrormessage IS NOT NULL
                THEN
                    sbMensErr :=
                           'Error asignando orden '
                        || ionuOrderId
                        || ' para el producto '
                        || inunuse
                        || '. '
                        || osbErrorMessage;
                    pro_grabalog (sbMensErr);
                    nucontlerr := nucontlerr + 1;
                    ROLLBACK;
                    RETURN;
                ELSE
                    -- Se busca la actividad de la orden
                    OPEN cuActividadOt (ionuOrderId);
                    FETCH cuActividadOt INTO nuactividadot;

                    IF cuActividadOt%NOTFOUND
                    THEN
                        nuactividadot := -1;
                    END IF;

                    CLOSE cuActividadOt;

                    IF NVL (nuactividadot, -1) = -1
                    THEN
                        sbMensErr :=
                               'No se encontro Actividad para la Orden '
                            || ionuOrderId
                            || '(Producto '
                            || inunuse;
                        pro_grabalog (sbMensErr);
                        nucontlerr := nucontlerr + 1;
                        ROLLBACK;
                        RETURN;
                    ELSE
                        -- CA633 - Se elimina el item de legalizacionw
                        ISBDATAORDER :=
                               ionuOrderId
                            || '|'
                            || nucausal
                            || '|'
                            || nupersonid
                            || '|'
                            || sbdatosadicionales
                            || '|'
                            || nuactividadot
                            || '>1 ;READING>'
                            || '>>;COMMENT1>>>;COMMENT2>>>;COMMENT3>>>|||'
                            || sbDescLeg;

                        pkg_traza.trace ('Legaliza orden - ISBDATAORDER: '|| ISBDATAORDER,csbNivelTraza);

                        api_legalizeorders (ISBDATAORDER,
                                           SYSDATE - 0.00138,
                                           SYSDATE,
                                           SYSDATE,
                                           onuErrorCode,
                                           osbErrorMessage);

                        pkg_traza.trace ('Legaliza orden - onuErrorCode: '|| onuErrorCode|| ' osbErrorMessage: '|| osbErrorMessage,csbNivelTraza);

                        IF (onuErrorCode <> 0)
                        THEN
                            sbMensErr :=
                                   'Error legalizando orden '
                                || ionuOrderId
                                || ' para producto '
                                || inunuse
                                || '. '
                                || osbErrorMessage;
                            pro_grabalog (sbMensErr);
                            nucontlerr := nucontlerr + 1;
                            ROLLBACK;
                            RETURN;
                        ELSE
                            nucontlega := nucontlega + 1;
                            COMMIT;
                        END IF;
                    END IF;
                END IF;
            ELSE
                nucontgene := nucontgene + 1;
                COMMIT;
            END IF;
        END IF;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            sbMensErr :=
                   'Error creando orden para producto '
                || inunuse
                || '. '
                || sbError;
            ROLLBACK;
            
            pro_grabalog (sbMensErr);
            nuconterro := nuconterro + 1;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
    END prGeneraOrden;

    FUNCTION fnu_GetDatosPeriodo (inupefa perifact.pefacodi%TYPE)
        RETURN NUMBER
    IS
        csbMetodo  CONSTANT VARCHAR2(100) := csbPaquete||'fnu_GetDatosPeriodo';
        nureturn   NUMBER := 0;

        CURSOR cuDatosPeri IS
            SELECT pefacicl,
                   pefaano,
                   pefames,
                   p.pefafimo,
                   p.pefaffmo,
                   pc.pecscons
              FROM PERIFACT P, PERICOSE PC
             WHERE     PC.PECSFECF BETWEEN P.PEFAFIMO AND P.PEFAFFMO
                   AND P.PEFACICL = PC.PECSCICO
                   AND pefacodi = inupefa;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inupefa    <= '||inupefa, csbNivelTraza);
        
        OPEN cuDatosPeri;

        FETCH cuDatosPeri
            INTO nupefacicl,
                 nupefaano,
                 nupefames,
                 nupefafimo,
                 nupefaffmo,
                 nupecscons;

        IF cuDatosPeri%NOTFOUND
        THEN
            nureturn := 1;
        ELSE
            nureturn := 0;
        END IF;

        CLOSE cuDatosPeri;
        
        pkg_traza.trace('nureturn  => '||nureturn, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN (nureturn);
    EXCEPTION
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            nureturn := -1;
            pkg_traza.trace('nureturn  => '||nureturn, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN (nureturn);
    END fnu_GetDatosPeriodo;

    FUNCTION fnu_GetFlagLecPerAnt
        RETURN VARCHAR2
    IS
        csbMetodo       CONSTANT VARCHAR2(100) := csbPaquete||'fnu_GetFlagLecPerAnt';
        sbproc   VARCHAR2 (1);

        CURSOR cuPerAnt IS
              SELECT pecsproc
                FROM pericose pc
               WHERE pc.pecscico = nupefacicl AND pc.pecscons < nupecscons
            ORDER BY pc.pecscons DESC;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        
        OPEN cuPerAnt;
        FETCH cuPerAnt INTO sbproc;

        IF cuPerAnt%NOTFOUND
        THEN
            sbproc := 'S';
        END IF;

        CLOSE cuPerAnt;
        
        pkg_traza.trace('sbproc  => '||NVL (sbproc, 'N'), csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN (NVL (sbproc, 'N'));
    EXCEPTION
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            sbproc := 'S';
            pkg_traza.trace('sbproc  => '||sbproc, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN (sbproc);
    END fnu_GetFlagLecPerAnt;
    
    /*****************************************************************
      Propiedad Intelectual de Gases del Caribe S.A. E.S.P
      Unidad         : fnuExisOrdLec
      Descripcion    : Función que valida si existe una orden de lectura creada entre las fecha de los periodos de facturación
      Autor          : Desconocido
      Fecha          : xx/xx/xxxx
      Parametros              Descripcion
      ============         ===================
      Fecha             Autor               Modificacion
      =========         =========           ====================
        19/02/2024      jcatuchemvm         OSF-2350: Se agrega validación de parámetro ACTIVIDAD_LECTESPGELE para determinar existencia de orden de lectura
        xx/xx/xx        Desconocido         Creación
    ******************************************************************/
    FUNCTION fnuExisOrdLec (inunuse       IN servsusc.sesunuse%TYPE,
                            inutipotrab   IN or_order.task_type_id%TYPE)
        RETURN VARCHAR2
    IS
        csbMetodo               CONSTANT VARCHAR2(100) := csbPaquete||'fnuExisOrdLec';
        sbActividadLectEsp      VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('ACTIVIDAD_LECTESPGELE');
        nuorden     or_order.order_id%TYPE;
        sbExiste    VARCHAR2 (1);
        sbValida    VARCHAR2 (1);

        CURSOR cuOrdLec IS
            SELECT o.order_id
              FROM or_order o, or_order_activity a
             WHERE     o.order_id = a.order_id
                    AND a.product_id = inunuse
                    AND o.task_type_id = inutipotrab
                    AND o.created_date >= nupefafimo
                    AND o.created_date < nupefaffmo + 1
                    AND o.order_status_id != 12
                    AND 
                    (
                        (
                            sbValida = 'S' AND
                            a.activity_id in 
                            (
                                SELECT to_number(regexp_substr(sbActividadLectEsp,'[^,]+',1,LEVEL)) AS actividad
                                FROM dual
                                CONNECT BY regexp_substr(sbActividadLectEsp, '[^,]+', 1, LEVEL) IS NOT NULL
                            )
                        ) OR
                        (
                           sbValida != 'S' AND
                           a.activity_id = a.activity_id
                        )
                    );
                    
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inunuse        <= '||inunuse, csbNivelTraza);
        pkg_traza.trace('inutipotrab    <= '||inutipotrab, csbNivelTraza);
        
        --Valida si parámetro nulo
        IF sbActividadLectEsp is null OR sbActividadLectEsp = '' THEN
            sbValida := 'N';
        ELSE
            sbValida := 'S';
        END IF;
        
        OPEN cuOrdLec;
        FETCH cuOrdLec INTO nuorden;

        IF cuOrdLec%NOTFOUND
        THEN
            sbExiste := 'N';
        ELSE
            sbExiste := 'S';
        END IF;

        CLOSE cuOrdLec;
        
        pkg_traza.trace('sbExiste  => '||sbExiste, csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN sbExiste;
    EXCEPTION
        WHEN OTHERS
        THEN
            Pkg_Error.SetError;
            pkg_Error.getError(nuError,sbError);
            pkg_traza.trace('sbError: '||sbError, csbNivelTraza);
            
            sbExiste := 'E';
            pkg_traza.trace('sbExiste  => '||sbExiste, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN (sbExiste);
    END fnuExisOrdLec;

    PROCEDURE pro_grabalog (isbobse VARCHAR2)
    IS
        PRAGMA AUTONOMOUS_TRANSACTION;
    BEGIN
        nuOrdenLog := nuOrdenLog + 1;

        INSERT INTO LDC_CM_LOG_GELEESP (sesion,
                                        fecha_proceso,
                                        ciclo,
                                        ano,
                                        mes,
                                        orden,
                                        usuario,
                                        observacion)
             VALUES (nusesion,
                     dtFechaProc,
                     nupefacicl,
                     nupefaano,
                     nupefames,
                     nuOrdenLog,
                     sbUsuario,
                     isbobse);

        COMMIT;
    END pro_grabalog;
END LDC_PKGENLECTESP;
/
PROMPT Otorgando permisos de ejecucion a LDC_PKGENLECTESP
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_PKGENLECTESP', 'ADM_PERSON');
END;
/