create or replace PACKAGE ldc_bssreglasproclecturas IS
/**************************************************************************************************************************************
    Propiedad intelectual de PETI (c).
    Unidad         : LDC_BSSReglasProcLecturas
    Descripcion    : Paquete para procesar las lecturas de critica y determinar el consumo y
                  calificacion a asignar
    Autor          : Jhon Jairo Soto
    Fecha          : 28-01-2013
    Metodos
    Nombre         :
    Parametros         Descripcion
    ============  ===================
    Historia de Modificaciones
    Fecha           Autor               Modificacion
    ==========      =========           ====================
    22-12-2020      OL-Software         CA 222 Se adiciona la logica para que se valide los promedios de consumo
                                        cuando hubo cambio de medidor para la generacion de critica
    23-08-2021      horbath             CA 827: se modificaron los procedimientos pranalecturanormal y  prlecturacritica
    21-02-2022      hahenao.Horbath     CA875:
                                        Se modifican los procedimientos pranalecturanormal y  prlecturacritica
                                        para adicionar validacion de existencia de ordenes de CM pendientes para generar la critica.
    10-05-2022      John Jairo Jimenez  OSF-72
                                        Se adiciona logica para que se generen las ordenes o solicituda por observacion de lectura
                                        de acuerdo a configuración y validación de la tabla : LDC_OBLEACTI
    19-05-2022      John Jairo Jimenez  OSF-72
                                        Se valida para que la solicitud VSI no se genere para usuarios castigados.--
    21/07/2023      jcatuchemvm         OSF-1366: Se ajustan los siguientes métodos
                                            [prlecturacritica]
                                            [pranalecturanormal]
                                            [procalificavariacionconsumo]
                                            [prGeneraActiviObNlect]
                                            [prlecturaretiro]

                                        Se crea nueva función, que es usada de forma general en varios procedimientos
                                            [fnuultconsprom]

                                        Se agrega constante nuorden donde se almacena el número de la orden que se procesa.
                                        La variable sbmarcaCambMedidor pasa a ser una variable global para que pueda ser consultada desde procalificavariacionconsumo
                                        Se actualizan llamados a métodos errors por los correspondientes en pkg_error
                                        Se  eliminan los raise después de un llamado pkg_error.setErrorMessage, ya que este lo contiene
                                        Se eliminan los esquemas en llamados a métodos o tablas de open.
                                        Se eliminan variables que no son usadas
                                        Se mejora trazabilidad del paquete
                                        Se elimina codigo comentado o que no aplica a la fecha según FBLAPLICAENTREGAXCASO
    04/08/2023      jcatuchemvm         OSF-1086: Se ajustan los siguientes métodos
                                            [prGeneraActiviObNlect]
                                            [prlecturacritica]
                                            [pranalecturanormal]
                                            [prReglasAVCIndustriales]
                                            [fnuvalidaconsumoscero]
                                            [prgeneracritica]

                                        Se crea la siguiente función privada.
                                            [fnuObtieneConsumosPrevios]

                                        Se crea cursor cuValidaOrdenAbiertasCM para validar órdenes abiertas de cambio de medidor
                                        basado en los atributos de cambio de medidor
                                        Se define la variable nuExisteOrd como global para ser gestionada desde prGeneraActiviObNlect
                                        Se eliminan variables que no son usadas en el paquete o en sus procedimientos.
                                        Se cambia llamado a parámetro COD_ACT_CAMBIO_MEDIDOR en ld_parameter por COD_ATRB_CAMBIO_MEDIDOR en parametros.
    18-09-2023      jcatuchemvm         OSF-1440: Se ajusta los procedimientos
                                            [prReglasAVCIndustriales]
                                            [prEstablecerConsumo]
                                            [prGeneraActiviObNlect]

                                        A nivel general, se elimina codigo que ya no aplica, se estandariza la traza, se eliminan esquemas de los llamados a métodos y sentencias.
                                        Se cambian definiciones dage_causal.fnugetclass_causal_id por pkg_bcordenes.fnuobtieneclasecausal, dapr_product.fnugetproduct_status_id por pkg_bcproducto.fnuestadoproducto,
                                        or_bolegalizeorder.fnugetcurrentorder por pkg_bcordenes.fnuobtenerotinstancialegal, damo_packages.fsbgetcomment_ por pkg_bcsolicitudes.fsbgetcomentario,
                                        dapr_product.fnugetaddress_id por pkg_bcproducto.fnuiddireccinstalacion, ge_bopersonal.fnugetcurrentchannel por pkg_bopersonal.fnugetpuntoatencionid,
                                        ge_bopersonal.fnugetpersonid por pkg_bopersonal.fnugetpersonaid, ldc_boutilities.splitstrings por regexp_substr, pkbcsuscripc.fnugetsubscriberid por pkg_bccontrato.fnuidcliente,
                                        pktblservsusc.fnugetsuscription por pkg_bcproducto.fnucontrato, dald_parameter.fsbgetvalue_chain por pkg_bcld_parameter.fsbobtienevalorcadena, dald_parameter.fnugetnumeric_value por
                                        pkg_bcld_parameter.fnuobtienevalornumerico
    12-07-2024      jcatuche            OSF-2494: Se ajuste el método
                                            [prCalificaConsumoDesvPobl]
    24/07/2024      jcatuche            OSF-3009 Se ajusta el método
                                            [prlecturacritica]
                                            [pranalecturanormal]
                                            [prCalificaConsumoDesvPobl]
                                            [procalificavariacionconsumo]
    12/08/2024       jcatuche           OSF-3095 Se ajusta el método  
                                            [prlecturacritica]
    20/08/2024      jcatuche            OSF-3181 Se ajustan los métodos
                                            [prCalificaConsumoDesvPobl]
                                            [pranalecturanormal]
                                            [prlecturacritica]
                                            [prAnaLecturaIndustriales]
                                            [prReglasAVCIndustriales]
                                            
                                        Se crean los métodos internos
                                            [prConsDifLectAnt]
                                            [prConsDifLectAntFactCorr]
                                            
                                        A nivel general se define nueva constante para la regla 3017, consumo nulo y la variable nuanacrit pasa a ser una variable global. 
                                        Se definen nuevas variables globales dtfechafincons, nuconsecutivolect y nuConsPendLiqu
**************************************************************************************************************************************/
    FUNCTION fsbTieneCambMedidor
    (
        inuproducto elmesesu.emsssesu%TYPE,
        inupeco     pericose.pecscons%TYPE
    ) RETURN VARCHAR2;

    FUNCTION fnuinvalidconsprom
    (
        inuproduct  IN servsusc.sesunuse%TYPE,
        inuperiodos IN NUMBER
    ) RETURN NUMBER;

    FUNCTION fnuvecesconsumoestimado(inuproducto IN servsusc.sesunuse%TYPE)  RETURN NUMBER;

    FUNCTION fnuvalidaconsumoscero(inuproducto IN servsusc.sesunuse%TYPE) RETURN NUMBER;

    PROCEDURE prlecturacritica ( nucausanolect IN NUMBER,
                                 sbindicalect  IN VARCHAR2 );

    PROCEDURE pranalecturanormal ( nucausanolect IN NUMBER,
                                   sbindicalect  VARCHAR2  );

    PROCEDURE prlecturaretiro ( sbindicalect IN VARCHAR2,
                                sbindtardia  IN VARCHAR2    );

    PROCEDURE prgeneracritica (   inuactivityid   IN ge_items.items_id%TYPE,
                                isbordercomment IN or_order_comment.order_comment%TYPE,
                                inuproducto     IN servsusc.sesunuse%TYPE,
                                idtfechaestima  IN DATE,
                                inuperiodo      IN pericose.pecscons%TYPE,
                                inuleccons      IN lectelme.leemcons%TYPE   );

    FUNCTION fsbtieneorden12620abierta(inuproducto servsusc.sesunuse%TYPE) RETURN VARCHAR;

    FUNCTION fnucountserialreadobsperiod(inusearchedobservation IN lectelme.leemoble%TYPE --,
                                         --isbIncludeHistoricData  in  varchar2
                                         ) RETURN NUMBER;

    FUNCTION fnucountserialreadobsperiod2 (  inusearchedobservation  IN lectelme.leemoble%TYPE,
                                             inusearchedobservation2 IN lectelme.leemoble%TYPE   ) RETURN NUMBER;

    FUNCTION fnucountserialreadobsperiod3  (  inusearchedobservation  IN lectelme.leemoble%TYPE,
                                            inusearchedobservation2 IN lectelme.leemoble%TYPE   ) RETURN NUMBER;

    PROCEDURE procalificavariacionconsumo
    (
        inupericonsumo         conssesu.cosspecs%TYPE, -- Período de consumo
        inuconsumoactual       IN OUT conssesu.cosscoca%TYPE, -- Consumo actual
        isbmarcaprompropio     CHAR, -- Indica si tiene consumo promedio propio
        isbtienelectura        CHAR, -- Indica si se está legalizando con lectura
        inuconsumopromedioopen hicoprpm.hcppcopr%TYPE, -- Consumo promedio
        inuproducto            conssesu.cosssesu%TYPE, -- Producto
        inucategoria           pr_product.category_id%TYPE, -- Categoría
        inusubcategoria        pr_product.subcategory_id%TYPE, -- Subcategoría
        onucalificacion        OUT calivaco.cavccodi%TYPE -- Calificación
    );

    PROCEDURE prEstablecerConsumo
    (
        sbTipo            IN VARCHAR2,
        nuConsumo         IN FLOAT,
        nuCalificacion    IN NUMBER,
        boGeneraRelectura IN BOOLEAN
    );

    PROCEDURE prValidaPromedios
    (
        ionuconsprom        IN OUT FLOAT,
        iosbfunconsprom     IN OUT VARCHAR2,
        iosbmarcaprompropio IN OUT VARCHAR2,
        ionuconssub         IN OUT FLOAT,
        iosbmarcapromsubcat IN OUT VARCHAR2,
        isbfunconssub       IN VARCHAR2
    );

    PROCEDURE prAnaLecturaIndustriales;

    FUNCTION fnucantotgeneradas(inuproducto conssesu.cosssesu%TYPE -- Producto
                                ) RETURN NUMBER;

    PROCEDURE prReglasAVCIndustriales
    (
        sbindicalect        IN VARCHAR2,
        nucausanolect       IN lectelme.leemoble%TYPE,
        nuconsact           IN conssesu.cosscoca%TYPE,
        nucalificacion      IN calivaco.cavccodi%TYPE, -- Calificacion devuelta
        rccurrentreading    IN OUT lectelme%ROWTYPE, -- Lectura procesada
        rcorder             IN OUT daor_order.styOR_order, -- Orden
        rcproduct           IN OUT servsusc%ROWTYPE, -- Producto
        nuactivity          IN OUT remevaco.rmvcacti%TYPE, -- Escenario / Actividad
        rcactiverule        IN OUT remevaco%ROWTYPE, -- Regla que se esta ejecutando
        rcconsumptionperiod IN OUT pericose%ROWTYPE -- Periodo de Consumo
    );

    PROCEDURE prObtConsRecup
    (
        nuproducto          IN conssesu.cosssesu%TYPE,
        nuPeriodoConsumo    IN conssesu.cosspecs%TYPE,
        onuvolRecuperado    OUT NOCOPY conssesu.cosscoca%TYPE, --Consumo Recuperado Proyectado Periodo (Parametro)
        osbFlagRecuperacion OUT NOCOPY VARCHAR2,
        onuPeriodosRecup    OUT NUMBER, --Numero de Periodos Recuperados
        onuconsumoAct       OUT NOCOPY conssesu.cosscoca%TYPE, --Consumo Periodo Actual
        onuconsumo1         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo2         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo3         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo4         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo5         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo6         OUT NOCOPY conssesu.cosscoca%TYPE
    );

    FUNCTION fsbttsusp (inuprod pr_product.product_id%TYPE) RETURN BOOLEAN;

    FUNCTION fnuultconsprom(inuProducto servsusc.sesunuse%TYPE) RETURN NUMBER;

    FUNCTION prGetRecurrenciaObseNlec(inuConsRegla IN NUMBER) RETURN NUMBER;
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prGetRecurrenciaObseNlec
        Descripcion    : Funcion que devuelve el numero de recurrecia de observaciones de no lectura
        Autor          : Luis Javier Lopez / Horbath
        Caso           : OSF-654
        Fecha          : 15/11/2022
        Parametros              Descripcion
        ============         ===================
          inuConsRegla         consecutivo de la regla
        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
    ********************************************************************************/

     PROCEDURE prGeneraActiviObNlect(inuConsRegla IN NUMBER,
                                   inuCausanolect IN NUMBER,
                                   inuProducto  IN NUMBER,
                                   isbCritica   IN VARCHAR2,
								   idtFechaFin    IN 	DATE,
								   inuperioCons   IN 	NUMBER,
								   inuConsLect    IN  	NUMBER);
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prGeneraActiviObNlect
        Descripcion    : proceso que genera actividad por observcion de no lectura
        Autor          : Luis Javier Lopez / Horbath
        Caso           : OSF-654
        Fecha          : 15/11/2022
        Parametros              Descripcion
        ============         ===================
          inuConsRegla         consecutivo de la regla
        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
    ********************************************************************************/
	PROCEDURE prCalificaConsumoDesvPobl
    (
        inuProducto            IN  servsusc.sesunuse%type,
        inuPerioFact           IN  perifact.pefacodi%type,
        inuconsumoactual       IN  conssesu.cosscoca%type,
        isbmarcaprompropio     IN  VARCHAR2,
        inuEstadoProd          IN  pr_product.product_status_id%type,
        inuconsumopromIndi     IN  hicoprpm.hcppcopr%TYPE,
        inucategoria           IN  pr_product.category_id%TYPE,
        idtFechLean             IN  lectelme.leemfela%type,
        idtFechLeac            IN  lectelme.leemfele%type,
        isbTipoProc            IN  VARCHAR2,
        onuCalificacion        OUT NUMBER
    );
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prCalificaConsumoDesvPobl
        Descripcion    : proceso que devuelva calificacion de consumo segun nueva resolucion
        Autor          : Luis Javier Lopez / Horbath
        Caso           : OSF-2494
        Fecha          : 01/04/2024

        Parametros de Entrada
          inuProducto           Codigo del producto
          inuPerioFact          codigo del periodo
          inuconsumoactual      Consumo actual
          isbmarcaprompropio    Indica si tiene consumo promedio propio
          inuEstadoProd         estado del producto
          inuconsumopromIndi    Consumo promedio individual
          inucategoria          Categoria
          idtFechLean            fecha de lectura anterior
          idtFechLeac           fecha de lectura actual
          isbTipoProc           tipo de proceso L- Lectura, R - Relectura

        Parametros de Salida
          onuCalificacion        codigo de la calificacion

        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
        01/04/2024          LJLB            Creacion
    ********************************************************************************/
END ldc_bssreglasproclecturas;
/
create or replace PACKAGE BODY ldc_bssreglasproclecturas IS
/************************************************************************************************************************************************************
      Propiedad intelectual de PETI (c).
      Unidad         : LDC_BSSREGLASPROCLECTURAS
      Descripcion    : Paquete para procesar las lecturas y determinar el consumo y calificacion a asignar.
      Autor          : Jhon Jairo Soto
      Fecha          : 28/01/2013
      Metodos
      Nombre         :
      Parametros         Descripcion
      ============  ===================
      Historia de Modificaciones
      Fecha             Autor             Modificacion
      =========         =========         ====================
      8/06/2017         Oscar Ospino P.   CA 200-1202 Se crea funcion FnObtenerCalificacionRangos para validar desviacion en Productos con
                                          Metodo de Analisis de Variacion Consumos Industriales.
                                          Se crea proceso prAnaLecturaIndustriales para analisis de Consumos de Industriales.
      24/01/2017        Oscar Ospino P.   Se modifican Reglas 2028, 2002, 2003 y proceo ProCalificaVariacionConsumo. Se Adicionan Reglas 2031,2032
                                          Se agregan funciones y Variables a nivel de Paquete para permitir la reutilizacion del codigo
                                          en los procesos de Lectura, Relectura y demas.
                                          Funciones:
                                           FnuInvalidConsProm, FnuVecesConsumoEstimado y FnuValidaConsumosCero a nivel.
                                          Variables:
                                           sbmarcapromsubcat,sbprodnuevo,nuhistvalida,nuhistvalida2,sbprocesoactual,nuperiodceroconsec
      24-10-2016        Sandra Muñoz      CA 200-639. Se modifica el procedimiento proCalificaVariacionConsumo
      06-10-2016        Sandra Muñoz      CA 200-639. Se unifican los cambios del requerimiento 200-389 con
                                          el ca 200-639
                                          Se crea la función fnuCantOTPeriodAnt
                                          Se crea el procedimiento proCalificaVariacionConsumo
                                          Se modifica el procedimiento prAnaLecturaNormal
      07-07-2016        Oscar Ospino P.   CA 200-389 | Modificacion Proceso PrAnaLecturaNormal
                                          Se agregan validaciones adicionales sobre reglas de Lectura 2001,2002,2013
     21-09-2015       Sandra Muñoz      ARA8687.
                                        * Se modifica el procedimiento
                                        prLecturaCritica
                      * Se crean las funciones fsbAplicaEntega
                      y fsbTieneOrden12620Abierta
       19/02/2014       Jsoto             Solicitudes de Aranda 2843
       04/06/2014       Jsoto             Se cambia la funcion con la cual se obtiene el consumo promedio individual
                                          de CM_BOESTIMATESERVICES.CALCINDIVIDAVERAGECONS
                                          por CM_BOESTIMATESERVICES.GETINDIVIDAVERAGECONS
       22/05/2017       LFren             Se modifica regla 4 se controla que si el producto no tiene consumo promedio propio ni por subcategoria, se genere entonces la ot 12619
                                          Se modifica la regla 24, se coloca en comentarios la parte que dice que el consumo del mes trasanterior(nucanmescero2) debe ser diferente de cero.
                                          Se modifica Regla 8, se le coloco condicional que el usuario no puede ser nuevo para que ingrese a la regla.
                                          Se modifica Regla 31, se coloco que valide que el consumo anterior es un consumo valido nucanmescero=1
                                          Se modifica las reglas 2006 y 2023 se coloca asignacion de consumo calculado en vez de promedio
    26/07/2019        HB                 Cambio 38 - Se modifican reglas 2002 de lectura y 2015 de relectura
    24-03-2020        F.Castro           CA 373 Se implementa logica para nueva regla de lectura 34 (Contingencia
                                           Fuerza Mayor)
    22-12-2020    OL-Software          CA 222 Se adiciona la logica para que se valide los promedios de consumo
                                            cuando hubo cambio de medidor para la generacion de critica
    10-05-2022    John Jairo Jimenez     OSF-72
                                            Se adiciona logica para que se generen las ordenes o solicituda por observacion de lectura
                                            de acuerdo a configuración y validación de la tabla : LDC_OBLEACTI
    19-05-2022    John Jairo Jimenez     OSF-72
                                            Se valida para que la solicitud VSI no se genere para usuarios castigados.
************************************************************************************************************************************************************/
    --Constantes del paquete
    -- Para el control de traza:
    csbPaquete          CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';           -- Constante para nombre del paquete
    csbNivelTraza       CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;    -- Nivel de traza para este paquete.
    csbInicio           CONSTANT VARCHAR2(4)        := pkg_traza.fsbINICIO;         -- Indica inicio de método
    csbFin              CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN;            -- Indica Fin de método ok
    csbFin_Erc          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERC;        -- Indica fin de método con error controlado
    csbFin_Err          CONSTANT VARCHAR2(4)        := pkg_traza.fsbFIN_ERR;        -- Indica fin de método con error no controlado

    csbFE               CONSTANT VARCHAR2(20)   := 'Finaliza con error: ';
    csbFEC              CONSTANT VARCHAR2(35)   := 'Finaliza con error controlado: ';
    csbformato          CONSTANT VARCHAR2(25)   := 'DD/MM/YYYY HH24:MI:SS';

    --Variables globales
    sbAtribCM           VARCHAR2(4000)          :=  pkg_parametros.fsbGetValorCadena('COD_ATRB_CAMBIO_MEDIDOR');
    nuanacrit           ge_items.items_id%TYPE  := pkg_bcld_parameter.fnuobtienevalornumerico('ACTIVI_ORD_CRITIC');

    --CA 200-389 Ing. Oscar Ospino P. | Ludycom S.A
    sbCodAtribuLectu VARCHAR2(4000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CODATRIBLECT');

	 --constantes de nuevas reglas de consumo
    cnuRegla3001  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3001');
    cnuRegla3002  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3002');
    cnuRegla3003  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3003');
    cnuRegla3004  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3004');
    cnuRegla3005  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3005');
    cnuRegla3006  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3006');
    cnuRegla3007  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3007');
    cnuRegla3008  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3008');
    cnuRegla3009  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3009');
    cnuRegla3010  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3010');
    cnuRegla3011  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3011');
    cnuRegla3012  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3012');
    cnuRegla3013  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3013');
    cnuRegla3014  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3014');
    cnuRegla3015  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3015');
    cnuRegla3016  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3016');
    cnuRegla3017  CONSTANT NUMBER := pkg_parametros.fnugetvalornumerico('REGLA_CONSUMO_3017');
    --BOMARCAPROMSUBCAT
      CURSOR cuGetLectura(inuorden IN NUMBER) IS
       SELECT nvl(decode(s.capture_order,1, value_1,2,value_2,3, value_3, 4, value_4, 5,value_5, 6, value_6, 7,value_7, 8,value_8, 9,value_9,10,value_10,11,value_11,12,value_12,13, value_13, 14,value_14, 15, value_15, 16, value_16,17, value_17, 18, value_18, 19, value_19, 20,value_20, 'NA'),0) lectura
        FROM or_tasktype_add_data d,
            ge_attrib_set_attrib s,
            ge_attributes A,
            or_requ_data_value r ,
            or_order o
        WHERE d.task_type_id = o.task_type_id
        AND d.attribute_set_id = s.attribute_set_id
        AND s.attribute_id = a.attribute_id
        AND r.attribute_set_id = d.attribute_set_id
        AND r.order_id = o.order_id
        AND o.order_id = inuorden
        AND d.active = 'Y'
        AND A.attribute_id in ( SELECT to_number(regexp_substr(sbCodAtribuLectu,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS atributos
                                    FROM dual
                                  CONNECT BY regexp_substr(sbCodAtribuLectu, '[^,]+', 1, LEVEL) IS NOT NULL) ;

    CURSOR cuValidaOrdenAbiertasCM(inuproducto in number) IS
    WITH AtribCM AS
    (
        SELECT a.cm cm1,LEAD(cm,1,-1) OVER (ORDER BY cm) cm2,ROW_NUMBER() OVER (ORDER BY cm) row_lst
        FROM
        (
            SELECT TO_NUMBER(REGEXP_SUBSTR(sbAtribCM,'[^,]+', 1, LEVEL)) cm
            FROM   dual
            CONNECT BY regexp_substr(sbAtribCM, '[^,]+', 1, LEVEL) IS NOT NULL
        ) a
    ),
    TaskTypeCM AS
    (

        SELECT /*+ index ( ti IX_OR_TASK_TYPES_ITEMS01 ) use_nl ( ti ia )
        index ( ia PK_GE_ITEMS_ATTRIBUTES )*/
        UNIQUE task_type_id
        FROM or_task_types_items ti, ge_items_attributes ia, AtribCM atb
        WHERE ia.items_id = ti.items_id
        AND atb.row_lst = 1
        AND
        (
            attribute_1_id = atb.cm1 or attribute_2_id = atb.cm1 or attribute_3_id = atb.cm1 or attribute_4_id = atb.cm1
        )
        AND
        (
            attribute_1_id = atb.cm2 or attribute_2_id = atb.cm2 or attribute_3_id = atb.cm2 or attribute_4_id = atb.cm2
        )
    )
    SELECT 'S'
    FROM or_order o, or_order_activity oa,TaskTypeCM t
    WHERE o.order_id = oa.order_id
    and o.task_type_id = t.task_type_id
    and oa.product_id = inuproducto
    and o.order_status_id not in (8, 12);



   -- nusession NUMBER := userenv('sessionid');
    gsbpaquete CONSTANT VARCHAR2(30) := 'LDC_BSSREGLASPROCLECTURAS';
    nuMesesLiqui NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_NUMMESESVAL');
    nuPorcDesv  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_PORCDESVLECT');
    nuMesesValidar    NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_NUMESESAVALI'); -- se alamcena numero de meses a validar
    --< CA 200-1063 >--


    --Declaracion de Variables Generales
    sbmarcaprompropio       VARCHAR2(2) := 'S';
    sbmarcapromsubcat       VARCHAR2(1);    --Indicador de Promedio de Subcategoria Valido (>0)
    sbmarcaCambMedidor      VARCHAR2(1);    --Flag que indica si se ha realizado cambio de medidor en el periodo ()
    sbprodnuevo             VARCHAR2(1);    --Flag Usuario Nuevo
    nuperiodo_consumo         pericose.pecscons%TYPE; --Periodo de consumo
    nuconssubnoproy         NUMBER;         --Consumo promedio subcategoria no proyectado
    sbfunconsprom           conssesu.cossfufa%TYPE; --función consumo promedio
    sbfunconssub            conssesu.cossfufa%TYPE; --función consumo promedio subcategoría
    dtfechafincons          pericose.pecsfecf%TYPE; --fecha final periodo
    nuconsecutivolect       lectelme.leemcons%TYPE; --consecutivo de lectelme
    nuConsPendLiqu          NUMBER;         --Cantidad de consumos pendientes de liquidar
    nuhistvalida            NUMBER := 0;    --Indicador Nro Consumos validos en los ultimos 6 periodos sin incluir el Actual
    nuhistvalida2           NUMBER := 0;    --Indicador Nro Consumos validos en los ultimos 2 periodos sin incluir el Actual
    sbprocesoactual         VARCHAR2(50);   --Indicador para el proceso ProCalificaVariacionConsumo para validar si es LECTURA o RELECTURA
    nuperiodceroconsec      NUMBER;         --Numero de Periodos consecutivos hacia atras con consumos en cero o Negativo(Error)
    nuorden                 NUMBER;         --Almacena el número de la orden que se procesa
    nuExisteOrd             NUMBER;         --Contabiliza órdenes generadas
    sberror                 VARCHAR2(4000);
    nuerror                 NUMBER;

    --Parametros
    num3maxnvores           NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('M3_MAX_NVO_USU_RES');
    num3maxnvocom           NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('M3_MAX_NVO_USU_COM');
    nuparam_max_cons_est    NUMBER := ge_boparameter.fnuvalornumerico('CM_AVG_CONS_PER_NUM');
    nuvecesconsestimado     NUMBER := cm_boconslogicservice.fnugetconsmethodcount(3); -- 3-Metodo Estimado

    --Periodos a validar a Castigados para generar OT Relectura
    nuparam_period_cero_cast NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('PER_CERO_VAL_SUSP_CAST');

    -----------------------------------------
    --  Métodos privadas
    -----------------------------------------
    FUNCTION fnuObtieneConsumosPrevios
    (
        inuProducto IN servsusc.sesunuse%TYPE,
        inuTipoCons IN tipocons.tconcodi%TYPE,
        inuPeriCons IN pericose.pecscons%TYPE,
        inuPeriodos IN NUMBER
    ) RETURN NUMBER;
    
    PROCEDURE prConsDifLectAnt
    (   
        onuConsumo  OUT NUMBER, 
        osbFuncion  OUT NOCOPY conssesu.cossfufa%TYPE,
        onuMetodo   OUT NOCOPY conssesu.cossmecc%TYPE
    );       
    
    PROCEDURE prConsDifLectAntFactCorr
    (   
        onuConsumo  OUT NUMBER, 
        osbFuncion  OUT NOCOPY conssesu.cossfufa%TYPE,
        onuMetodo   OUT NOCOPY conssesu.cossmecc%TYPE
    );       

    /*****************************************************************
    Propiedad intelectual de Gases de occidente.
    Nombre del Paquete: fsbTieneCambMedidor
    Descripcion:        Indica si tiene cambio de Medidor en el Periodo
    Parametros:
    inuproducto:        Servicio Suscrito
    inupeco:            Periodo de Consumo
    Autor : Oscar Ospino P.
    Fecha : 19/07/2017 CA 200-1202
    Historia de Modificaciones
    DD-MM-YYYY      <Autor>.            Modificacion
    -----------     -----------------   -------------------------------------
    19/07/2017      Oscar Ospino P.     Creacion
    ******************************************************************/
    FUNCTION fsbTieneCambMedidor
    (
        inuproducto elmesesu.emsssesu%TYPE,
        inupeco     pericose.pecscons%TYPE
    ) RETURN VARCHAR2 IS

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fsbTieneCambMedidor';
        nucant      NUMBER := 0;
        sbCambio    CHAR(1) := 'N';

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproducto <= '||inuproducto,csbNivelTraza);
        pkg_traza.trace('inupeco     <= '||inupeco,csbNivelTraza);

        SELECT COUNT(1)
        INTO nucant
        FROM elmesesu e
        WHERE e.emsssesu = inuproducto
              AND EXISTS
         (SELECT *
               FROM pericose p, servsusc s
               WHERE p.pecscico = s.sesucicl
                     AND s.sesunuse = e.emsssesu
                     AND p.pecscons = inupeco
                     AND e.emssfein BETWEEN p.pecsfeci AND p.pecsfecf)
         AND EXISTS ( SELECT 1 
                      FROM elmesesu s1 
                      WHERE s1.emsssesu = inuproducto AND s1.emsselme <> E.emsselme );

        IF nucant > 0 THEN
            sbCambio := 'S';
        END IF;

        pkg_traza.trace('return => '||sbCambio,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN sbCambio;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace('return => '||sbCambio,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN sbCambio;
    END;
    /*****************************************************************
    Propiedad intelectual de GASES DE OCCIDENTE (c).
    Unidad         : proTieneOrden12620Abierta
    Descripcion    : Permite identificar si un producto tiene una orden 12620 en
                     proceso (Registrada, asignada, bloqueada, Ejecutada)
    Autor          : Sandra Muñoz
    Fecha          : 28/01/2013
    Parametros              Descripcion
    ============         ===================
    inuProducto          Producto
    Fecha             Autor             Modificacion
    =========       =========           ====================
    20-10-2015      Sandra Muñoz        Ara8687. Creacion
    ******************************************************************/
    FUNCTION fsbtieneorden12620abierta(inuproducto servsusc.sesunuse%TYPE)
        RETURN VARCHAR IS

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fsbtieneorden12620abierta';

        nupaso                  NUMBER; -- Paso ejecutado
        nucantidadotabiertas    NUMBER; -- cantidad de ordenes 12620 abiertas
        sbOrden                 CHAR(1) := 'N';
        nutipotrabajo           ld_parameter.numeric_value%TYPE; -- Tipo de trabajo 12620
        nuitem                  ld_parameter.numeric_value%TYPE; -- Item codigo
        nuestadoregistradoorden ld_parameter.numeric_value%TYPE; -- Estado registrado de una orden
        nuestadoasignadaorden   ld_parameter.numeric_value%TYPE; -- Estado asignado de una orden
        nuestadobloqueadaorden  ld_parameter.numeric_value%TYPE; -- Estado bloqueada de una orden
        nuestadoejecutadaorden  ld_parameter.numeric_value%TYPE; -- Estado bloqueada de una orden


    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproducto <= '||inuproducto,csbNivelTraza);

        -- Parametros
        nutipotrabajo           := pkg_bcld_parameter.fnuobtienevalornumerico('TITR_REVIS_TEC_REVIS_CONSUMO');
        nuitem                  := pkg_bcld_parameter.fnuobtienevalornumerico('ITEM_REVIS_POR_DESV_DE_CONSUMO');
        nuestadoregistradoorden := pkg_bcld_parameter.fnuobtienevalornumerico('COD_STATUS_REG');
        nuestadoasignadaorden   := pkg_bcld_parameter.fnuobtienevalornumerico('COD_ESTADO_ASIGNADA_OT');
        nuestadobloqueadaorden  := pkg_bcld_parameter.fnuobtienevalornumerico('COD_ESTA_BLOQ');
        nuestadoejecutadaorden  := pkg_bcld_parameter.fnuobtienevalornumerico('COD_ESTADO_OT_EJE');

        -- Buscar si el producto tiene una orden 12620 abierta en estado
        -- Registrada, asignada, bloqueada o Ejecutada

        SELECT COUNT(1)
        INTO nucantidadotabiertas
        FROM or_order oo, or_order_activity ooa
        WHERE oo.task_type_id = nutipotrabajo
              AND EXISTS (SELECT 1
               FROM or_order_items ooi
               WHERE ooi.order_id = oo.order_id
                     AND ooi.items_id = nuitem)
              AND ooa.order_id = oo.order_id
              AND
              oo.order_status_id IN
              (nuestadoregistradoorden, nuestadoasignadaorden, nuestadobloqueadaorden, nuestadoejecutadaorden)
              AND ooa.product_id = inuproducto;

        IF nucantidadotabiertas > 0 THEN
            sbOrden := 'S';
        END IF;

        pkg_traza.trace('return => '||sbOrden,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN sbOrden;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace('return => '||sbOrden,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN sbOrden;
    END;

    --Funcion para obtener el numero de PROMEDIOS NO VALIDOS
    FUNCTION fnuinvalidconsprom
    (
        inuproduct  IN servsusc.sesunuse%TYPE,
        inuperiodos IN NUMBER
    ) RETURN NUMBER IS
    /*****************************************************************
    Propiedad intelectual de GASES DE OCCIDENTE (c).
    Unidad         : FnuInvalidConsProm
    Descripcion    : Obtener el numero de veces que el producto ha tenido promedio cero o nulo en los
                     N periodos especificados.
    Autor          : Oscar Ospino P
    Fecha          : 20/01/2017
    Parametros              Descripcion
    ============         ===================
    inuProducto          Producto
    Fecha             Autor             Modificacion
    =========       =========           ====================
    20-01-2017      Oscar Ospino P        CA 200-1036 Creacion
    ******************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnuinvalidconsprom';

        --Promedios Invalidos del producto en los ultimos 6 periodos (Sin incluir el actual)
        CURSOR cnuultconsprom IS
            SELECT COUNT(prom)
            FROM (SELECT peco, prom
                  FROM (SELECT c.hcpppeco peco, nvl(c.hcppcopr, 0) prom
                        FROM hicoprpm c
                        WHERE c.hcppsesu = inuproduct
                              AND c.hcpppeco < (select pc.pecscons
                                                from pericose pc
                                               where pc.pecsfecf = (select max(t.pecsfecf)
                                                                      from PERICOSE t
                                                                     where t.pecscico in
                                                                           (select ss.sesucicl
                                                                              from servsusc ss
                                                                             where ss.sesunuse = inuproduct)
                                                                       and t.pecsproc = 'S'
                                                                       and t.pecsflav = 'S')
                                                 and pc.pecscico in
                                                     (select ss.sesucicl
                                                        from servsusc ss
                                                       where ss.sesunuse = inuproduct)
                                                  AND rownum = 1)
                              /*(SELECT MAX(c1.hcpppeco)
                                   FROM hicoprpm c1
                                   WHERE c1.hcppsesu = inuproduct)*/
                        ORDER BY c.hcpppeco DESC)
                  WHERE rownum <= inuperiodos)
            WHERE prom IS NULL
                  OR prom <= 0;

        --Declaraciones Variables
        nudato    NUMBER(15, 3) := 0;
        nupaso    VARCHAR2(32000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproduct  <= '||inuproduct,csbNivelTraza);
        pkg_traza.trace('inuperiodos <= '||inuperiodos,csbNivelTraza);

        OPEN cnuultconsprom;
        FETCH cnuultconsprom
            INTO nudato;
        CLOSE cnuultconsprom;
        nudato := nvl(nudato, 0);

        pkg_traza.trace('return => '||nudato,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nudato;

    EXCEPTION
        WHEN no_data_found THEN
            pkg_traza.trace('Producto no tiene consumos promedio invalidos en los ult. ' ||
                                 inuperiodos || ' periodos!.',csbNivelTraza);
            pkg_traza.trace('return => '||nvl(nudato,0),csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RETURN nvl(nudato, 0);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error al obtener el numero de consumos promedio invalidos en los ult. ' ||
                                 inuperiodos || ' periodos!.',csbNivelTraza);
            pkg_traza.trace('Paso: ' || nupaso || ' | Detalle: ' ||
                                 sbError,csbNivelTraza);
            pkg_traza.trace('return => '||nvl(nudato,0),csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN nvl(nudato, 0);
    END fnuinvalidconsprom;

    FUNCTION fnuvecesconsumoestimado(inuproducto IN servsusc.sesunuse%TYPE)
        RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de GASES DE OCCIDENTE (c).
        Unidad         : FnuVecesConsumoEstimado
        Descripcion    : Obtener el numero de veces que se ha estimado el consumo con una misma funcion de calculo
        Autor          : Oscar Ospino P
        Fecha          : 20/01/2017
        Parametros              Descripcion
        ============         ===================
        inuProducto          Producto
        Fecha             Autor             Modificacion
        =========       =========           ====================
        20-01-2017      Oscar Ospino P        CA 200-1036 Creacion
        ******************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnuvecesconsumoestimado';

        --Declaraciones Variables
        cnubil_mecc_estimado CONSTANT mecacons.mecccodi%TYPE := 3; --Metodo de Consumo Estimado
        nuveces_cons_est NUMBER; --Variable de Retorno
        nuconspromnoval  NUMBER; --Numero de Promedios validos ult 6 periodos
        nupaso           NUMBER := 0;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproducto <= '||inuproducto,csbNivelTraza);

        pkg_traza.trace('Obtener el numero de veces que se ha estimado el consumo con una misma funcion de calculo', csbNivelTraza);
        --obtener cant. veces con consumo estimado
        nupaso := 20;
        SELECT cossnvec
        INTO nuveces_cons_est
        FROM conssesu c
        WHERE cosssesu IN (inuproducto)
              AND cossmecc = cnubil_mecc_estimado
              AND cosspecs IN
              (SELECT MAX(cosspecs)
                   FROM conssesu c, perifact pf
                   WHERE cosssesu IN (inuproducto)
                         AND c.cosspefa = pf.pefacodi
                        --No tiene en cuenta el periodo actual
                         AND NOT (pf.pefames = to_char(SYSDATE, 'mm') AND
                          pf.pefaano = to_char(SYSDATE, 'yyyy')));

        pkg_traza.trace('inuproducto: ' || inuproducto, csbNivelTraza);

        pkg_traza.trace('Periodos del Producto con Promedio Propio No Valido: ' ||
                       nuconspromnoval, csbNivelTraza);

        pkg_traza.trace('Numero maximos de estimaciones permitidas con la misma funcion : ' ||
                       nuparam_max_cons_est, csbNivelTraza);

        pkg_traza.trace('nuveces_cons_est: ' || nuveces_cons_est, csbNivelTraza);

        nupaso := 30;
        IF nuveces_cons_est >= nuparam_max_cons_est THEN
            nupaso := 40;
            pkg_traza.trace('Periodos estimados es mayor que el parametro!!!.', csbNivelTraza);
        ELSE
            nupaso := 50;
            pkg_traza.trace('Periodos estimados es menor que el parametro. OK', csbNivelTraza);
        END IF;

        pkg_traza.trace('nupaso ' || nupaso, csbNivelTraza);
        nuveces_cons_est := nvl(nuveces_cons_est, 0);

        pkg_traza.trace('return => '||nuveces_cons_est,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuveces_cons_est;

    EXCEPTION
        WHEN no_data_found THEN
            pkg_traza.trace('Producto no tiene consumos estimados en los ult. 6 periodos!.', csbNivelTraza);
            pkg_traza.trace('return => '||nvl(nuveces_cons_est,0),csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RETURN nvl(nuveces_cons_est, 0);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error al obtener el numero de veces que se ha estimado el consumo con una misma funcion de calculo.', csbNivelTraza);
            pkg_traza.trace('Paso: ' || nupaso || ' | Detalle: ' || sbError, csbNivelTraza);
            pkg_traza.trace('return => '||nvl(nuveces_cons_est,0),csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN nvl(nuveces_cons_est, 0);
    END fnuvecesconsumoestimado;

    FUNCTION fnuvalidaconsumoscero(inuproducto IN servsusc.sesunuse%TYPE)
        RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de GASES DE OCCIDENTE (c).
        Unidad         : FnuValidaConsumosCero
        Descripcion    : Obtener el numero de periodos que el consumo ha sido facturado en 0-Cero de manera consecutiva
                         sin incluir el periodo actual
        Autor          : Oscar Ospino P
        Fecha          : 23/01/2017
        Parametros              Descripcion
        ============         ===================
        inuProducto          Producto
        Fecha             Autor             Modificacion
        =========       =========           ====================
        04/08/2023      jcatuchemvm         OSF-1086: Se ajusta cursor cuData para considerar solo los consumos liquidados
        23-01-2017      Oscar Ospino P      CA 200-1036 Creacion
        ******************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnuvalidaconsumoscero';

        CURSOR cudata IS
            SELECT c.cosspecs periodo, SUM(nvl(c.cosscoca, 0)) consumo
            FROM conssesu c
            WHERE c.cossflli = 'S'
                  AND c.cosssesu = inuproducto
                  AND c.cosspecs IN (SELECT c1.cosspecs
                                     FROM (SELECT DISTINCT c.cosssesu, c.cosspecs
                                           FROM conssesu c
                                           WHERE c.cosssesu = inuproducto
                                                 AND c.cossflli = 'S'
                                            ORDER BY c.cosssesu, c.cosspecs DESC) c1
                                     WHERE rownum <= 6)
            GROUP BY c.cosspecs
            ORDER BY c.cosspecs DESC;
        nupecocerocons NUMBER := 0; --Periodos consecutivos en Cero


    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproducto <= '||inuproducto,csbNivelTraza);

        pkg_traza.trace('--< Cuento los periodos en 0-cero o Negativo >-- ', csbNivelTraza);

        FOR rcdata IN cudata
        LOOP
            --Cuento los periodos en 0-cero o Negativo (Error)
            IF rcdata.consumo <= 0 THEN
                pkg_traza.trace('Periodo: ' || rcdata.periodo || ' | Consumo: ' ||
                               rcdata.consumo, csbNivelTraza);
                nupecocerocons := nupecocerocons + 1;
            ELSE
                --Si el consumo es valido en algun periodo, sale del cursor
                pkg_traza.trace('--< el consumo es valido en algun periodo, sale del cursor >-- ', csbNivelTraza);
                EXIT;
            END IF;
        END LOOP;

        pkg_traza.trace('return => '||nupecocerocons,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nupecocerocons;

    EXCEPTION
        WHEN no_data_found THEN
            pkg_traza.trace('Error: Producto aun no tiene consumos facturados!.', csbNivelTraza);
            pkg_traza.trace('return => '||nvl(nupecocerocons,0),csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RETURN nvl(nupecocerocons, 0);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('Error al contar los periodos facturados con consumo en 0-Cero. '||sbError, csbNivelTraza);
            pkg_traza.trace('return => '||nvl(nupecocerocons,0),csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN nvl(nupecocerocons, 0);
    END;

    /*****************************************************************
      Propiedad intelectual de PETI (c).
      Unidad         : PrLecturaCritica
      Descripcion    : Procedimiento para procesar lecturas del proceso de relectura
      Autor          : Jhon Jairo Soto
      Fecha          : 28/01/2013
      Parametros              Descripcion
      ============         ===================
      Fecha             Autor               Modificacion
      =========         =========           ====================
        21-10-2015      Sandra Muñoz        ARA8687. Se modifica el procedimiento
                                            para que antes de cada llamado al
                                            procedimiento CM_BOCONSLOGICSERVICE.GENERATEJOBORDER,
                                            valide que no exista una OT abierta
                                            (Estados de Orden: Registrada, asignada,
                                            bloqueada, Ejecutada) con el procedimiento
                                            fsbTieneOrden12620Abierta, si es asi,
                                            se genere la orden, de lo contrario,
                                            no se genere la orden para el producto.
        20140527        jsoto               Se realizan cambios para el manejo de situaciones de instalacion de medidor
                                            de forma tardia. (ordenes de venta)
                                            Se asignara consumo promedio cuando el producto tenga actividades de cambio de
                                            medidor pendientes de legalizacion.
                                            Si hay legalizacion de instalacion tardia el consumo actual sera prorrateado
                                            a la cantidad de dias del periodo de consumo para efectos de validaciones y
                                            comparaciones dentro de la regla.
        16-Julio-2014   Jorge Valiente      RNP 666:  Colocar parametro de cantidad de obervaciones de lecturas definidas en las gaseras
        20140901        jsoto               Se realizan adecuaciones RQ  team  2017 Se suprimen condiciones donde se realizaba
                                            el llamado al programa CM_BOCALCCONSUMPSERVS.READDIFANDCORRECTFACTOR con parametro de
                                            cero meses de recuperacion ya que el producto de OPEN incluyo funcionalidad en FOVC FAMC
                                            para manejo de consumos recuperados en lectura y/o relectura.
                                            Se suprime el llamado a CM_BOConsLogicService.CleanEngMemBySource porque ya no es necesario
                                            recalcular el consumo con cero o seis meses de recuperacion.
                                            Se usa el parametro CANT_MESES_RECUPERAR_CONSUMO = 6 para usar en el calculo de consumo
        04-12-2015      Pedro Castro        PJC DESARROLLO: Se configuran nuevas reglas con base a las nuevas calificaciones de relectura
        17-01-2017      Oscar Ospino P.     CA 200-1063 Correcion de Inconsistencias con Promedios Individuales y de Subcategoria, Calificacion Usuarios Nuevos
                                            Se Adicionan Reglas 2032
        26-07-2019      Horbath             CA 38 se modifica regla 2015
        22-07-2020      josh brito          CA 314, Ajuste 456: se modifico la sentencia de la funcion FNUULTCONSPROM que esta en el procedimiento PRLECTURACRITICA para que
                                            obtenga correctamente el consumo promedio individual del producto y no genere critica en la regla 15
                                            al tener observacion de no lectura
        27-07-2020      josh brito          CA 314, Ajuste 276: Se modifica la logica de la forma 2019, la cual verificar la categoría de este y en caso de
                                            ser 2-COMERCIAL, se debe verificar si en los 15 dñas calendario anteriores a la toma de lectura se ha generado
                                            y se encuentra en estado legalizada o pendiente por legalizar una orden con el tipo de trabajo 12620.
                                            En caso de no existir, se debe generar automáticamente una orden asociada con este tipo de trabajo en la regla 19.
        30-07-2020      josh brito          CA 314, Ajuste 314: 1. Crear parámetro NRO_VECES_OBS_RELECTURA13 de tipo numérico, inicializado en 3 para la regla 13
        14-05-2021      LJLB                CA 222 se genera critica por cambio de medidor
        23-08-2021      Horbath             CA 827 se modifica regla 2013, para generar  una orden ???12130 - VERIFICAR CLIENTE FUERA DE RUTA???
                                            si la observación de lectura es igual a ???No se encuentra predio???, si esta observación es consecutiva en los últimos 3 periodos,
                                            si no tiene una orden 12130 activa o si la última orden de este tipo es legaliza hace más de 5 días.
        21-02-2022      hahenao.HORBATH     CA875
                                            *Se adiciona validacion de existencia de ordenes de CM pendientes para generar la critica
        21-07-2023      jcatuchemvm         OSF-1366: Se valida si hubo cambio de medidor y existe consumo promedio por subcategoria, para enviarlo como
                                            consumo promedio open en el llamado a procalificavariacionconsumo.
                                            Se inicializa variable globarl nuorden con el numero de la orden que se gestiona.
                                            Se elimina definición de variable sbmarcapromsubcat ya que esta pasa a ser una variable global.
                                            Se elimina definición de función privada fnuultconsprom ya que se define de forma general en el paquete
                                            Por cambio de alcance, el promedio por subcategoria enviado es el no proyectado en días de consumo. Ref Monica Olivella
                                            Se elimina condición de validación consumo actual vs consumo existente en el periodo para poderlo sumar. Ahora se suma todo
                                            el consumo del periodo sin validaciones. Ref Monica Olivella corrección OSF-1039
        04/08/2023      jcatuchemvm         OSF-1086: Se cambia llamado a cursor cuValidaordeAbiertas por cuValidaOrdenAbiertasCM
                                            Se agrega llamado fnuObtieneConsumosPrevios para consulta alterna de históricos de consumos, el cual
                                            no tiene en cuenta los consumos pendientes por liquidar, entre ellos los recuperados. Se conserva el llamado
                                            original de open cm_boestimateservices.getnthprevconsumption, el cual internamente hace validaciones adicionales
                                            Se ajustan las reglas 2017, 2023, 2024 eliminando la validación de órdenes de cambio de medidor pendientes para la entrada a la regla
                                            y se adiciona logica para creación de orden de crítica si existe orden de cambio  de medidor pendiente.
		16/05/2024		LJLB                se adiciona logica para desviacion poblacional
		24/07/2024      jcatuche            OSF-3009: Se adiciona llamado a fnuultconsprom para sobrescribir el consumo promedio nuconsprom
                                            Se elimina definición de variable nuperiodo_consumo ya que esta pasa a ser una variable global.    
                                            Se elimina definición de variable nuconssubnoproy ya que esta pasa a ser una variable global.
                                            Se elimina definición de variable sbfunconsprom ya que esta pasa a ser una variable global.
                                            Se elimina definición de variable sbfunconssub ya que esta pasa a ser una variable global.
                                            Se elimina lógica del caso OSF-1366, el procedimiento prCalificaConsumoDesvPobl ya integra este ajuste 
                                            Se elimina validación de promedios y se centraliza mediante prValidaPromedios
                                            Se agrega traza de finalizacion de ejecucion del procedimiento antes del return por estandarización
        12/08/2024      jcatuche            OSF-3095: Se ajusta regla 2013 para que opere similar a la 2013 en cuanto a las validaciónes para asignación de consumo.
                                            Se elimina la validación de consumos históricos nuhistvalida2.
        19/09/2024      jcatuche            OSF-3181: Se agrega validación de consumo nulo antes de enviar a validar la desviación. 
                                            Se agrega llamado a prConsDifLectAntFactCorr para obtener consumo sugerido por diferencia de lecturas
                                            Se elimina definición de variable local nuanacrit, se agrega inicialización de variable global dtfechafincons y nuconsecutivolect
	******************************************************************/
    PROCEDURE prlecturacritica
    (
        nucausanolect IN NUMBER,
        sbindicalect  IN VARCHAR2
    )
    IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prlecturacritica';
        nuconsant     NUMBER := 0;
        sbfunconsant  VARCHAR2(100);
        numetconsant  mecacons.mecccodi%TYPE;
        nuconsprom    NUMBER := 0;
        numetconsprom mecacons.mecccodi%TYPE;
        nuconssub     NUMBER := 0;
        numetconssub  mecacons.mecccodi%TYPE;
        nuconsprom1   NUMBER := 0;
        nuconsact     NUMBER := 0;
        sbfunconsact  VARCHAR2(100);
        numetconsact  mecacons.mecccodi%TYPE;
        nuconsumo     NUMBER := 0;
        sbfunman      VARCHAR2(100);
        numetman      mecacons.mecccodi%TYPE;
        nuobsmedret   obselect.oblecodi%TYPE;
        nuobsmedret2  obselect.oblecodi%TYPE;
        nuobsmeddif   obselect.oblecodi%TYPE;
        nuobsdemol    obselect.oblecodi%TYPE;
        nuobsnoinst   obselect.oblecodi%TYPE;

        --Inicio CA 200-389
        nucuentaobs NUMBER;
        --Fin CA 200-389

        nutrabdesv           or_task_type.task_type_id%TYPE;
        nutrabrelectura      or_task_type.task_type_id%TYPE;
        nudiasusnuevo        NUMBER;
        numtsmax             NUMBER;
        calificacion         VARCHAR2(100);
        prioridad            VARCHAR2(100);
        inudiscovertype      NUMBER;
        inuvalue             NUMBER;
        inuinformer          NUMBER;
        isbcomment           VARCHAR2(100);
        nucategori           categori.catecodi%TYPE;
        nusubcategori        subcateg.sucacodi%TYPE;
        isbordercomment      VARCHAR2(200);
        nuestcorte           servsusc.sesuesco%TYPE;
        nuestprod            pr_product.product_status_id%TYPE;
        inuobser             NUMBER;
        conslectnormal       NUMBER;
        lectura_actual       lectelme.leemleto%TYPE;
        lectura_normal       lectelme.leemleto%TYPE;
        lectura_anterior     lectelme.leemleto%TYPE;
        num_producto         servsusc.sesunuse%TYPE;
        nucalificacion       conssesu.cosscavc%TYPE;
        nuestadopr           pr_product.product_status_id%TYPE;
        orccurrentreading    lectelme%ROWTYPE; -- Lectura que se está procesando
        orcorder             daor_order.styor_order; -- Orden que se legaliza
        orcproduct           servsusc%ROWTYPE; -- Producto que se está procesando
        onuactivity          remevaco.rmvcacti%TYPE; --Escenario / Actividad
        orcactiverule        remevaco%ROWTYPE; -- Regla que se está ejecutando
        orcconsumptionperiod pericose%ROWTYPE; -- Período de Consumo
        nucons1              NUMBER;
        nucons2              NUMBER;
        nucons3              NUMBER;
        nucons4              NUMBER;
        nucons5              NUMBER;
        nucons6              NUMBER;
        sbfuncons1           VARCHAR2(100);
        numetcons1           mecacons.mecccodi%TYPE;
        sbfuncons2           VARCHAR2(100);
        numetcons2           mecacons.mecccodi%TYPE;
        sbfuncons3           VARCHAR2(100);
        numetcons3           mecacons.mecccodi%TYPE;
        sbfuncons4           VARCHAR2(100);
        numetcons4           mecacons.mecccodi%TYPE;
        sbfuncons5           VARCHAR2(100);
        numetcons5           mecacons.mecccodi%TYPE;
        sbfuncons6           VARCHAR2(100);
        numetcons6           mecacons.mecccodi%TYPE;
        sbactsuspension      VARCHAR2(2000);
        sbactconlect         VARCHAR2(2000);
        numoticate           NUMBER;
        numtsconsprom        NUMBER;
        sbcausa3vez          VARCHAR2(2);
        nugencritica         NUMBER;
        nuprimlect           NUMBER := 0;
        sbestafina           servsusc.sesuesfn%TYPE;
        sbordenpend          VARCHAR2(2);
        sblegtardia          VARCHAR2(2);
        nucantmesesrec       NUMBER;
        nuactivitytypeid     ge_items.items_id%TYPE;
        nuporcpromind        NUMBER(10, 2);

		--CA 875
        sbPend          VARCHAR2(1);
        nuProductId     pr_product.product_id%type;

        -- Para obtener consumo calculado con el proceso de lectura normal
        CURSOR cuconsumolectnormal
        (
            producto IN servsusc.sesunuse%TYPE,
            periodo  IN conssesu.cosspecs%TYPE
        ) IS
            SELECT nvl(cosscoca, 0) cosscoca, cosscavc
            FROM vw_cmprodconsumptions
            WHERE cosssesu = producto
                  AND cosspecs = periodo
                  AND cossmecc = 1; -- metodo de calculo
        reg_consumolectnormal cuconsumolectnormal%ROWTYPE;

        -- Inicio CA 314, Ajuste 276: -- Se agrega cursor para buscar las ordenes en especifico
        CURSOR cuOrdenReg19(
               num_producto number
        )
        IS
         SELECT  COUNT(*)
          FROM or_order ORD,
               or_order_activity ORDA
         WHERE orda.product_id = num_producto
           AND ord.order_id = orda.order_id
           AND ord.task_type_id = 12620
          AND (   ( trunc(ord.legalization_date) BETWEEN (select trunc(max(felect) - 15 ) from
                                                                 (SELECT MAX(le.LEEMFELE) felect
                                                                    FROM lectelme LE
                                                                   WHERE le.leemsesu = num_producto
                                                                  union
                                                                  select max(h.hlemfele) felect
                                                                    from HILEELME h, or_order_activity a
                                                                   where h.hlemdocu=a.order_activity_id
                                                                     and a.product_id = num_producto))
                                                     AND (select trunc(max(felect))  from
                                                                (SELECT MAX(le.LEEMFELE) felect
                                                                   FROM lectelme LE
                                                                  WHERE le.leemsesu = num_producto
                                                                 union
                                                                  select max(h.hlemfele) felect
                                                                    from HILEELME h, or_order_activity a
                                                                   where h.hlemdocu=a.order_activity_id
                                                                     and a.product_id = num_producto)))
                                               OR (ord.order_status_id in (0,5)) );
        CURSOR cunuevacalificacion IS
            SELECT consecutivo, codigo_calificacion
            FROM ldc_calificacion_cons
            WHERE activo = 'Y'
                  AND proceso = 'R'
            ORDER BY prioridad ASC;
        nucantot NUMBER;
        CURSOR cuexisteordengenerada
        (
            inuproducto   servsusc.sesunuse%TYPE, -- PRODUCTO
            nutipotrabajo or_task_type.task_type_id%TYPE, -- TIPO DE TRABAJO
            nuitem        or_order_items.items_id%TYPE
        ) -- ACTIVIDAD
        IS
            SELECT COUNT(1)
            FROM or_order oo, or_order_activity ooa
            WHERE oo.task_type_id = nutipotrabajo
                  AND EXISTS (SELECT 1
                   FROM or_order_items ooi
                   WHERE ooi.order_id = oo.order_id
                         AND ooi.items_id = nuitem)
                  AND ooa.order_id = oo.order_id
                  AND oo.order_status_id IN (0, 1, 5, 6)
                  AND ooa.product_id = inuproducto;
        nuvecesobsrelect NUMBER;
		nuvecesobsrelect13 NUMBER; -- CA 314, Ajuste 314
        nuVecesObs  NUMBER;
        nuregla13      NUMBER(2);
        nuregla14      NUMBER(2);
        nuregla15      NUMBER(2);
        nuregla16      NUMBER(2);
        nuregla17      NUMBER(2);
        nuregla18      NUMBER(2);
        nuregla19      NUMBER(2);
        nuregla21      NUMBER(2);
        nuregla23      NUMBER(2);
        nuregla24      NUMBER(2);
        nuregla26      NUMBER(2);
        nuregla27      NUMBER(2);
        nuregla32      NUMBER(2);
        nuregla33      NUMBER(2);
        isbordcom      VARCHAR2(1000);
        nucanmescero   NUMBER(2);
        nucanmescero2  NUMBER(2);
        nucanmescero3  NUMBER(2);
        nuvalconsumo   NUMBER(8);
        nuvalconsumo2  NUMBER(8);
        nuvalconsumo3  NUMBER(8);
        nupricerocalif NUMBER(4);
        nusegcerocalif NUMBER(4);
        nuExiste number;

        --<Inicio CA 200-1202>--

        sbmarcaRecuperado   VARCHAR2(1) := 'N'; --Flag que indica si se ha recuperado el consumo en la variable nuvolrecupproy
        nuvolrecupproy      conssesu.cosscoca%TYPE := 0; --Volumen Recuperado Proyectado en el Periodo Actual
        nuconsFactActual    conssesu.cosscoca%TYPE; --Consumo por metodo 4-Facturado Periodo Actual
        nuconsFact1         conssesu.cosscoca%TYPE; --Consumo por metodo 4-Facturado Periodo anterior
        nuconsFact2         conssesu.cosscoca%TYPE;
        nuconsFact3         conssesu.cosscoca%TYPE;
        nuconsFact4         conssesu.cosscoca%TYPE;
        nuconsFact5         conssesu.cosscoca%TYPE;
        nuconsFact6         conssesu.cosscoca%TYPE; --Consumo por metodo 4-Facturado Periodo mas antiguo
        nuPeriodosRecup     NUMBER := 0; --Almacena el numero de Periodos Recuperado
        --<Fin CA 200-1202>-
        
        
        nuObsNoEncPredio  NUMBER:= pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_NO_ENC_PREDIO');
        nuValiOrde   NUMBER;
        CURSOR cu_validordenesVisitaxMes (nuProducto IN NUMBER, nuActividad IN NUMBER) IS
        SELECT oo.legalization_date
        FROM or_order oo, or_order_activity oa
        WHERE oa.activity_id  = nuActividad
        AND oa.product_id  = nuProducto
        AND oo.order_status_id   = 8
        AND pkg_bcordenes.fnuobtieneclasecausal(oo.causal_id) = 1
        AND oo.legalization_date BETWEEN add_months(sysdate, -nuMesesLiqui) AND sysdate
        AND oo.order_id  = oa.order_id;

        dtFechaLega DATE;
        sbexisteOrdeLe VARCHAR2(1);
        blgeneraVisita  BOOLEAN;
        nuconsumoAnterior NUMBER;
        numetodoAnte number;
        nuconsFactTotal   NUMBER;
        cursor cugetConsumoAnte(inuproducto  NUMBER, inuperiactual NUMBER) IS
        select COSSSUMA, COSSMECC
         from vw_cmprodconsumptions c1
         where c1.cosspecs in (select p2.pecscons
                                from perifact p1, pericose p2
                               where p2.pecsfecf between p1.pefafimo and p1.pefaffmo
                                 and p2.pecscico = p1.pefacicl
                                 and p1.pefacodi = pkbillingperiodmgr.fnugetperiodprevious(inuperiactual))
           and cosssesu = inuproducto;

		onuCumpleRegla      NUMBER := 0;
        blProdDesviado      BOOLEAN := FALSE;
        sbRowId             VARCHAR2(4000);
        -- Funcion mediante la cual valido  antes de asignar la calificacion de consumo promedio si es promedio del usuario y si es mayor al parametro
        -- para que la calificacion asignada genere critica
        FUNCTION fnuvalidocalificacion
        (
            nuvalorcal IN NUMBER, -- Valor Calificacion preasignada
            nuvalormts IN NUMBER, -- Metros maximos contenidos en el parametro para la categoria
            nuvalorcon IN conssesu.cosscoca%TYPE, -- unidades de Consumo promedio que se van liquidar
            sbvalormar IN VARCHAR2 -- Marca Si es consumo promedio del usuario (S) o de la subcategoria (N)
        ) RETURN NUMBER IS
            nuvalor NUMBER;
        BEGIN
            IF nuvalorcon > nuvalormts
               AND sbvalormar = 'N' THEN
                nuvalor := 140;
            ELSE
                nuvalor := nuvalorcal;
            END IF;
            RETURN nuvalor;
        END;

        -- ESTADO DEL PRODUCTO ES DIFERENTE A SUSPENDIDO?
        FUNCTION fsbestcortnopermit(nusesuesco pr_product.product_status_id%TYPE)
            RETURN BOOLEAN IS
            CURSOR cuestadostecsusp IS
                SELECT regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('ESTAD_SUSP_PRODUCT'),'[^,]+',1,LEVEL) AS column_value
                FROM dual
                CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('ESTAD_SUSP_PRODUCT'),'[^,]+',1,LEVEL) IS NOT NULL;
            nufound NUMBER(1) := 0;
        BEGIN
            FOR i IN cuestadostecsusp
            LOOP
                IF nusesuesco NOT IN (i.column_value) THEN
                    nufound := 1;
                ELSE
                    nufound := 2;
                    EXIT;
                END IF;
            END LOOP;
            IF nufound = 1 THEN
                RETURN TRUE; --  SI ES DIFERENTE DE SUSPENDIDO
            ELSE
                RETURN FALSE; -- NO ES DIFERENTE DE SUSPENDIDO
            END IF;
        END;

        FUNCTION fsbobs1(nuobs NUMBER) RETURN BOOLEAN IS
            CURSOR cuobs IS
                SELECT regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('COD_OBS_1'),'[^,]+',1,LEVEL) AS column_value
                FROM dual
                CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('COD_OBS_1'),'[^,]+',1,LEVEL) IS NOT NULL;
            nufound NUMBER(1) := 0;
        BEGIN
            FOR i IN cuobs
            LOOP
                IF nuobs IN (i.column_value) THEN
                    nufound := 1;
                    EXIT;
                ELSE
                    nufound := 2;
                END IF;
            END LOOP;
            IF nufound = 1 THEN
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;
        END;

        FUNCTION fsbobs2(nuobs NUMBER) RETURN BOOLEAN IS
            CURSOR cuobs IS
                SELECT regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('COD_OBS_2'),'[^,]+',1,LEVEL) AS column_value
                FROM dual
                CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('COD_OBS_2'),'[^,]+',1,LEVEL) IS NOT NULL;
            nufound NUMBER(1) := 0;
        BEGIN
            FOR i IN cuobs
            LOOP
                IF nuobs IN (i.column_value) THEN
                    nufound := 1;
                    EXIT;
                ELSE
                    nufound := 2;
                END IF;
            END LOOP;
            IF nufound = 1 THEN
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;
        END;

        FUNCTION fnucaliflect
        (
            nuproduct servsusc.sesunuse%TYPE,
            nuperiodo pericose.pecscons%TYPE
        ) RETURN NUMBER IS
            nudato NUMBER(4) := 0;
            CURSOR cnucaliflect IS
                SELECT c.cosscavc
                FROM conssesu c
                WHERE c.cosssesu = nuproduct
                      AND c.cosspecs = nuperiodo
                      AND
                      c.cosscavc IN (SELECT codigo_calificacion
                                     FROM ldc_calificacion_cons
                                     WHERE activo = 'Y'
                                           AND proceso = 'L')
                      AND rownum = 1;
        BEGIN
            OPEN cnucaliflect;
            FETCH cnucaliflect
                INTO nudato;
            CLOSE cnucaliflect;
            nudato := nvl(nudato, 0);
            RETURN nudato;
        END;

        FUNCTION ldc_fnuvalidaOrdeVisita ( inuproducto IN pr_product.product_id%type,
                                          isbEstadoFina IN VARCHAR2,
                                           inuActividad IN NUMBER  ) RETURN NUMBER IS
          /*****************************************************************
          Propiedad intelectual de gdc
          Unidad         : ldc_fnuvalidaOrdeVisita
          Descripcion    : valida si se puede o no crear orden visita a producto
          Autor          : Elkin alvarez
          Fecha          : 25-02-2018
          Entrada   Descripcion
          inuproducto    numero de producto
          isbEstadoFina   estado finaciero del producto
          inuActividad   actividad de visita
          Historia de Modificaciones
		  DD-MM-YYYY    <Autor>               Modificacion
		  -----------  -------------------    -------------------------------------
          /*****************************************************************/
          nuValor NUMBER;
          --se valida si el producto no tiene ordne visita pendiente y su ultima fue hace mas de 6 meses
          CURSOR cuValidaOrdeVis IS
          SELECT 'X'
            FROM (
                   SELECT  add_months(max(Oo.Legalization_Date), nuMesesValidar) fecha
                   FROM or_order oo, or_order_activity ooa
                   WHERE  Ooa.Activity_Id = inuActividad
                      AND ooa.order_id = oo.order_id
                      AND pkg_bcordenes.fnuobtieneclasecausal (oo.causal_id) = 1
                      AND ooa.product_id = inuproducto
                      AND NOT EXISTS ( SELECT 1
                                        FROM or_order o, or_order_Activity oa
                                        WHERE o.order_id = oa.order_id
                                         AND oa.product_id = ooa.product_id
                                         AND Oa.Activity_Id = inuActividad
                                         AND o.order_status_id NOT IN ( SELECT Os.Order_Status_Id
                                                                        FROM Or_Order_Status os
                                                                        WHERE Os.Is_Final_Status = 'Y'))
                      )
            WHERE fecha <= sysdate;
           --se valida si el producto aun no se le han registrado ordenes de visita
           CURSOR cuValidaExisOrde IS
            SELECT 'X'
            FROM or_order o, or_order_Activity oa
            WHERE o.order_id = oa.order_id
             AND oa.product_id = inuproducto
             AND Oa.Activity_Id = inuActividad
             AND o.order_status_id NOT IN (12);
            sbDatos VARCHAR2(1);

        BEGIN

            --se valida que el producto no este castigado
            IF isbEstadoFina = 'C' THEN
                RETURN nuValor;
            END IF;

            --se valida que el producto no tenga ordens pendient de visita y su ultima legalizada con exito sea mayor a 6 meses
            OPEN cuValidaOrdeVis;
            FETCH cuValidaOrdeVis INTO sbDatos;
            IF cuValidaOrdeVis%NOTFOUND THEN
              --si no existen ordene generadas se envia 0 - Cumple
              OPEN cuValidaExisOrde;
              FETCH cuValidaExisOrde INTO sbDatos;
              IF cuValidaExisOrde%NOTFOUND THEN
                 nuValor := 0;
              END IF;
              CLOSE cuValidaExisOrde;
            ELSE
                nuValor := 0; --producto cumple con la validacion
            END IF;

            CLOSE cuValidaOrdeVis;

            RETURN nuValor;
        EXCEPTION
          WHEN OTHERS THEN
              RETURN 0;
        END ldc_fnuvalidaOrdeVisita;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('nucausanolect   <= '||nucausanolect,csbNivelTraza);
        pkg_traza.trace('sbindicalect    <= '||sbindicalect,csbNivelTraza);

        --Inicialización de variables
        sbmarcaCambMedidor := 'N';
        nuExisteOrd := 0;
        nuconssubnoproy := 0;
        sbfunconsprom := null;
        sbfunconssub := null;
        nuperiodo_consumo := null;
        dtfechafincons := null;
        nuconsecutivolect := null;
        nuConsPendLiqu := null;


        -- Parametros
        nuobsmedret     := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_MEDIDOR_RETIRADO');
        nuobsmedret2    := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_MEDIDOR_RETIRADO2');
        nuobsdemol      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_DEMOLIDA');
        nuobsmeddif     := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_MEDIDOR_DIFERENTE');
        nuobsnoinst     := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_SIN_INSTALACION');
        nutrabdesv      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_TRAB_DESVIACION');
        nudiasusnuevo   := pkg_bcld_parameter.fnuobtienevalornumerico('DIAS_USUARIO_NUEVO');
        sbactsuspension := pkg_bcld_parameter.fsbobtienevalorcadena('ACTIVIDADES_SUSPENSION');
        sbactconlect    := pkg_bcld_parameter.fsbobtienevalorcadena('ACTIVIDADES_CON_LECTURA');
        numoticate      := pkg_bcld_parameter.fnuobtienevalornumerico('MOTIVO_CAMBIO_CATEGO');
        numtsconsprom   := pkg_bcld_parameter.fnuobtienevalornumerico('MTS_EVALUAR_CONS_PROMEDIO');
        isbordercomment := 'Verificar dirección, medidor, lectura, uso del servicio, red interna, equipos conectados y hacer prueba, se promedia por tercer vez consecutiva';
        nucantmesesrec  := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_MESES_RECUPERAR_CONSUMO');
        nuporcpromind   := pkg_bcld_parameter.fnuobtienevalornumerico('PORCENT_PROM_INDIVID');
        nupricerocalif  := pkg_bcld_parameter.fnuobtienevalornumerico('CALIF_PRIMER_CERO_LEC');
        nusegcerocalif  := pkg_bcld_parameter.fnuobtienevalornumerico('CALIF_SEGUND_CERO_LEC');

        -- PJC DESARROLLO Se cargan los 7 parametros asociados a cada regla de relectura configurada en LDC_CALIFICACION_CONS
        nuregla13 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_CANT_REIT_IGUALOBS1');
        nuregla14 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_CANT_REIT_IGUALOBS2');
        nuregla15 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_FALTA_MEDID');
        nuregla16 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_FALMED_CAREIT_IGUALOBS');
        nuregla17 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_ACT_PEND');
        nuregla18 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_CALIF_NORMAL');
        nuregla19 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_CALIF_NONORMAL');
        nuregla21 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_PRODSUSP_SINCERO');
        nuregla23 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_PRIMCONSUM_ULT6MESES');
        nuregla24 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_SECONSCERO_ULT6MESES');
        nuregla26 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_USU_RESIDENC');
        nuregla27 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_NINGUNA_REGLA');
        nuregla32 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_NO_PROMPROP_NO_PROMLOC');
        nuregla33 := pkg_bcld_parameter.fnuobtienevalornumerico('RELECT_PROD_NVO_CONS_NORMAL');
        
        cm_boconslogicservice.getproductservicesatus(nuestcorte, nuestprod);

        pkg_traza.trace('CM_BOCONSLOGICSERVICE.GETPRODUCTSERVICESATUS -->' ||
                       nuestcorte || '-' || nuestprod, csbNivelTraza);

        -- Obtener datos de lectura y consumos asociados al producto
        lectura_actual := cm_boconslogicservice.fnugetcurrentreading(); -- Lectura que se esta procesando (Relectura)

        pkg_traza.trace('Lectura_actual -->' || lectura_actual, csbNivelTraza);

        lectura_normal := cm_boconslogicservice.fnugetlasthistoricread(); -- Lectura cargada en el proceso inicial (normal)

        pkg_traza.trace('Lectura_normal -->' || lectura_normal, csbNivelTraza);

        lectura_anterior := cm_boconslogicservice.fnugetpreviusreading(); --Lectura Anterior con la cual se esta realizando el calculo de consumo

        pkg_traza.trace('Lectura_anterior -->' ||
                       lectura_anterior, csbNivelTraza);
        cm_boestimateservices.getindividaveragecons(nuconsprom, sbfunconsprom, numetconsprom); -- Consumo promedio de los ultimos 6 meses

        pkg_traza.trace('CM_BOESTIMATESERVICES.GETINDIVIDAVERAGECONS -->' ||
                       nuconsprom || '-' || sbfunconsprom || '-' ||
                       numetconsprom, csbNivelTraza);

        nuconssubnoproy := LDC_PKGCONPR.fnuinfoavgconsofsubcat('LOC'); --Consumo por subcategoria sin proyeccion a los dias de consumo
        pkg_traza.trace('LDC_PKGCONPR.FNUINFOAVGCONSOFSUBCAT nuConsSubNoProy-->' ||
                       nuconssubnoproy, csbNivelTraza);

        LDC_PKGCONPR.getaverageconsofsubcat('LOC', nuconssub, sbfunconssub, numetconssub); -- Consumo promedio del estrato del usuario proyectado con los dias de consumo
        pkg_traza.trace('LDC_PKGCONPR.GETAVERAGECONSOFSUBCAT -->' ||
                       nuconssub || '-' || sbfunconssub || '-' || numetconssub, csbNivelTraza);

        cm_boconslogicservice.getcategorysubcategory(nucategori, nusubcategori); --obtener categoria y subcategoria del usuario

        pkg_traza.trace('CM_BOCONSLOGICSERVICE.GETCATEGORYSUBCATEGORY -->' ||
                       nucategori || '-' || nusubcategori, csbNivelTraza);

        cm_boestimateservices.getpreviousconsumption(nuconsant, sbfunconsant, numetconsant); -- Obtener consumo mes anterior

        pkg_traza.trace('CM_BOESTIMATESERVICES.GETPREVIOUSCONSUMPTION -->' ||
                       nuconsant || '-' || sbfunconsant || '-' || numetconsant, csbNivelTraza);

        -- Historico de los seis ultimos Consumos del producto
        cm_boestimateservices.getnthprevconsumption(1, nucons1, sbfuncons1, numetcons1);
        cm_boestimateservices.getnthprevconsumption(2, nucons2, sbfuncons2, numetcons2);
        cm_boestimateservices.getnthprevconsumption(3, nucons3, sbfuncons3, numetcons3);
        cm_boestimateservices.getnthprevconsumption(4, nucons4, sbfuncons4, numetcons4);
        cm_boestimateservices.getnthprevconsumption(5, nucons5, sbfuncons5, numetcons5);
        cm_boestimateservices.getnthprevconsumption(6, nucons6, sbfuncons6, numetcons6); --Consumo mas antiguo

        -- Se obtiene los datos del producto, lectura, periodo, orden de la instancia de OPEN para el producto que se esta procesando
        cm_boconsumptionengine.getenginememorydata(orccurrentreading, -- out nocopy lectelme%rowtype,  -- Lectura que se está procesando
                                                   orcorder, --out nocopy daor_order.styOR_order, -- Orden que se legaliza
                                                   orcproduct, --out nocopy servsusc%rowtype, -- Producto que se está procesando
                                                   onuactivity, --out nocopy remevaco.rmvcacti%type, --Escenario / Actividad
                                                   orcactiverule, -- out nocopy remevaco%rowtype, -- Regla que se está ejecutando
                                                   orcconsumptionperiod --out nocopy pericose%rowtype -- Período de Consumo
                                                   );

        num_producto := orcproduct.sesunuse; -- Producto que se esta procesando
        nuorden      := orcorder.order_id;
        
        nuconsprom := fnuultconsprom(num_producto);
        pkg_traza.trace('fnuultconsprom -->' ||nuconsprom, csbNivelTraza);

        --Funcionalidad alterna para obtener los consumos históricos liquidados.
        nucons1 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,1);
        nucons2 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,2);
        nucons3 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,3);
        nucons4 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,4);
        nucons5 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,5);
        nucons6 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,6);

        -- Determinar si tiene historia valida con los consumos obtenidos en el historico
        SELECT decode(nucons1, 0, 0, -1, 0, 1) +
               decode(nucons2, 0, 0, -1, 0, 1) +
               decode(nucons3, 0, 0, -1, 0, 1) +
               decode(nucons4, 0, 0, -1, 0, 1) +
               decode(nucons5, 0, 0, -1, 0, 1) +
               decode(nucons6, 0, 0, -1, 0, 1)
        INTO nuhistvalida
        FROM dual;

        SELECT decode(nucons1, 0, 0, -1, 0, 1) +
               decode(nucons2, 0, 0, -1, 0, 1)
        INTO nuhistvalida2
        FROM dual;

        SELECT decode(nucons1, 0, 0, -1, 0, 1) INTO nucanmescero FROM dual;
        SELECT decode(nucons2, 0, 0, -1, 0, 1) INTO nucanmescero2 FROM dual;
        SELECT decode(nucons3, 0, 0, -1, 0, 1) INTO nucanmescero3 FROM dual;

        pkg_traza.trace('Num_producto -->' || num_producto, csbNivelTraza);
        pkg_traza.trace('nuorden -->' || nuorden, csbNivelTraza);

        nuperiodo_consumo := orcconsumptionperiod.pecscons; -- Periodo de consumo del producto que se esta procesando
        pkg_traza.trace('nuperiodo_consumo -->' ||nuperiodo_consumo, csbNivelTraza);
        
        dtfechafincons := orcconsumptionperiod.pecsfecf;
        nuconsecutivolect := orccurrentreading.leemcons;

        nuestadopr := pkg_bcproducto.fnuestadoproducto(num_producto); -- Obtener el estado del producto

        sbestafina := orcproduct.sesuesfn; -- Obtener el estado financiero del producto

        pkg_traza.trace('nuEstadoPr - sbEstaFina -->' ||
                       nuestadopr || '-' || sbestafina, csbNivelTraza);

        IF nucategori = 2 -- Categoria Comercial (2)
         THEN
            numtsmax := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_METROS_MAXIMO_COM');
        ELSE
            numtsmax := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_METROS_MAXIMO_RES');
        END IF;

        --El consumo promedio calculado con la funcion de OPEN se usa en varias funciones por lo tanto debe obtener un valor valido
        --para el producto, si el producto no tiene consumo promedio, le asignamos a la variable el promedio de la subcategoria
        --para el resto del proceso
        nuconsprom1 := nuconsprom;
        --< CA 200-1063 >--
        sbprocesoactual    := 'RELECTURA'; -->> Para Proceso ProCalificaVariacionConsumo
        nuperiodceroconsec := fnuvalidaconsumoscero(num_producto); --< CA 200-1063 Parte 3>--

        IF nuconsprom IS NULL OR nuconsprom <= 0 THEN
            nuconsprom1 := 0; 
        END IF;
        
        --Verifica si el promedio de la subcategoria es valido
        prValidaPromedios(nuconsprom,sbfunconsprom,sbmarcaprompropio,nuconssub,sbmarcapromsubcat,sbfunconssub);
        
        
        pkg_traza.trace('nudiasusnuevo -->' ||
                       nudiasusnuevo || '-' || cm_boconslogicservice.fnugetdayssinceinstall(), csbNivelTraza);

        -- Establecer si el producto es Nuevo
        IF cm_boconslogicservice.fnugetdayssinceinstall() <= nudiasusnuevo THEN
            sbprodnuevo := 'S';
        ELSE
            sbprodnuevo := 'N';
        END IF;
        -- Fin CA 200-1063 --

        IF cuconsumolectnormal%ISOPEN THEN
            CLOSE cuconsumolectnormal;
        END IF;

        -- Obetener el consumo y la calificacion del proceso con lectura normal
        OPEN cuconsumolectnormal(num_producto, nuperiodo_consumo);
        FETCH cuconsumolectnormal
            INTO reg_consumolectnormal;

        conslectnormal := reg_consumolectnormal.cosscoca;
        nucalificacion := reg_consumolectnormal.cosscavc;

        CLOSE cuconsumolectnormal;

        pkg_traza.trace('consLectnormal - nuCalificacion -->' ||
                       conslectnormal || '-' || nucalificacion, csbNivelTraza);

        --CA 200-1063 -Parte 1
        --Se valida el top de Consumos Estimados para cambio de Funcion de Calculo
        pkg_traza.trace('nuvecesconsestimado OPEN: ' ||
                       nuvecesconsestimado, csbNivelTraza);

        nuvecesconsestimado := fnuvecesconsumoestimado(orcproduct.sesunuse);

        pkg_traza.trace('nuvecesconsestimado Funcion Pkt: ' ||
                       nuvecesconsestimado, csbNivelTraza);

        IF nuvecesconsestimado >= nuparam_max_cons_est
           AND sbmarcapromsubcat = 'S' THEN
            --Se asigna Funcion de Promedio Subcategoria
            sbfunconsprom := sbfunconssub;
            IF sbmarcaprompropio = 'N' THEN
                --Se asigna el Prom. de Subcateg si es valido
                nuconsprom := nuconssub;
            END IF;
            pkg_traza.trace('CA 200-1063 | Notas-SAO397466| cambio de Funcion de Calculo (' ||
                           sbfunconsprom || ') por (' || sbfunconssub || ')' ||
                           chr(10) ||
                           'Evitar que se deje de calcular el Promedio Individual.' ||
                           sbfunconsact, csbNivelTraza);
        END IF;

        pkg_traza.trace('sbfunconsprom -->' ||
                       sbfunconsprom, csbNivelTraza);
        pkg_traza.trace('sbfunconsSub -->' || sbfunconssub, csbNivelTraza);
        nuvecesobsrelect := pkg_bcld_parameter.fnuobtienevalornumerico('NRO_VECES_OBS_RELECTURA'); -- PJC DESARROLLO
        nuvecesobsrelect13 := pkg_bcld_parameter.fnuobtienevalornumerico('NRO_VECES_OBS_RELECTURA13'); -- CA 314, Ajuste 314

        nuvalconsumo  := pkg_bcld_parameter.fnuobtienevalornumerico('CONSUMO_VALIDO');
        nuvalconsumo2 := pkg_bcld_parameter.fnuobtienevalornumerico('CONSUMO_VALIDO2');
        nuvalconsumo3 := pkg_bcld_parameter.fnuobtienevalornumerico('CONSUMO_VALIDO3');

        --Verifica si existe ordenes pendientes de actividades de cambio de medidor
        IF cuValidaOrdenAbiertasCM%ISOPEN THEN
           CLOSE cuValidaOrdenAbiertasCM;
        END IF;

        OPEN cuValidaOrdenAbiertasCM(num_producto);
        FETCH cuValidaOrdenAbiertasCM INTO sbordenpend;

        IF cuValidaOrdenAbiertasCM%NOTFOUND THEN
           sbordenpend :='N';
        END IF;

        CLOSE cuValidaOrdenAbiertasCM;

        -- Consumo por diferencia de lecturas con factor de correccion con recuperacion de consumo
        cm_bocalcconsumpservs.readdifandcorrectfactor(nucantmesesrec, nuconsumo, sbfunconsact, numetconsact);
        pkg_traza.trace('nuCantMesesRec -->' ||
                       nucantmesesrec || ' nuConsumo -->' || nuconsumo ||
                       ' sbFunConsAct -->' || sbfunconsact ||
                       ' nuMetConsAct -->' || numetconsact||
                       ' sbordenpend -->'||sbordenpend, csbNivelTraza);
        pkg_traza.trace('nuValConsumo -->' || nuvalconsumo, csbNivelTraza);
        pkg_traza.trace('nuValConsumo2 -->' ||
                       nuvalconsumo2, csbNivelTraza);

        --Obtiene el Flag que valida si hay cambio de medidor en el periodo actual --<CA200-1202>--
        sbmarcaCambMedidor := fsbTieneCambMedidor(num_producto, nuperiodo_consumo);
        IF sbmarcaCambMedidor = 'S' THEN
            pkg_traza.trace('Consumo Actual -->' ||
                           nuconsumo, csbNivelTraza);
            --Se acualiza el consumo actual por consumos registrados en el periodo por la lectura de retiro del medidor (nuconsFactActual)
            SELECT SUM(COSSCOCA) INTO nuconsFactTotal
            FROM CONSSESU
            WHERE COSSSESU = num_producto
              AND COSSPECS = nuperiodo_consumo
              AND COSSMECC = 4   ;

            nuconsumo := nuconsumo + nvl(nuconsFactTotal, 0);

            pkg_traza.trace('sbmarcaCambMedidor -->' ||
                           sbmarcaCambMedidor||' nuconsFactTotal '||nuconsFactTotal, csbNivelTraza);
            pkg_traza.trace('Nuevo Consumo Actual tras cambio Medidor -->' ||
                           nuconsumo, csbNivelTraza);
        END IF;

        IF sbindicalect = 'S' THEN
            sbRowId  := NULL;
            
            if nuconsumo is null then
                prConsDifLectAntFactCorr(nuconsumo,sbfunconsact,numetconsact);
            end if;
            --se realiza proceso para desviacion poblacional
            blProdDesviado := pkg_bcGestionConsumoDp.fblValidaProdDesv (  num_producto,
                                                                          orcproduct.sesususc,
                                                                          nuconsumo,
                                                                          orccurrentreading.leempefa,
                                                                          nuperiodo_consumo,
                                                                          orccurrentreading.leemfela,
                                                                          orccurrentreading.leemfele,
                                                                          'S',
                                                                          onuCumpleRegla,
                                                                          sbRowId);

            IF blProdDesviado OR onuCumpleRegla = 0 THEN
               calificacion := null;
               --se valida calificacion
               prCalificaConsumoDesvPobl( num_producto,
                                          orccurrentreading.leempefa,
                                          nuconsumo,
                                          sbmarcaprompropio,
                                          nuestadopr,
                                          nuconsprom,
                                          nucategori,
                                          orccurrentreading.leemfela,
                                          orccurrentreading.leemfele,
                                          'R',
                                          calificacion);

               IF calificacion = cnuRegla3014 THEN
                  isbordcom := 'Orden generada por proceso de reglas';
                  prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
               END IF;

            ELSE
                calificacion := cnuRegla3008;
            END IF;

            IF calificacion IS NULL THEN
               pkg_error.setErrorMessage(isbMsgErrr => 'No se encontro calificacion para el producto' );
            END IF;
            --se realiza calificacion nueva
            cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
            cm_boconslogicservice.setmanualqualification(sbfunconsact, calificacion);
            IF sbRowId IS NOT NULL THEN
                pkg_info_producto_desvpobl.prActCalifiProdDesvpobl(sbRowId, calificacion);
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
            RETURN;
        END IF;
        
        
        procalificavariacionconsumo(inupericonsumo => nuperiodo_consumo, inuconsumoactual => nuconsumo, isbmarcaprompropio => sbmarcaprompropio, isbtienelectura => sbindicalect, inuconsumopromedioopen => nuconsprom, inuproducto => num_producto, inucategoria => nucategori, inusubcategoria => nusubcategori, onucalificacion => calificacion);
        pkg_traza.trace('CM_BOCONSLOGICSERVICE.REVIEWCONSUSINGRANK -->' || '-' ||
                       nuconsprom1 || '-' || 'PC' || '-' || sbfunconsact || '-' ||
                       calificacion || '-' || prioridad, csbNivelTraza);
        pkg_traza.trace('--<nucons1 | Consumo Mes 1>-- ' || nucons1, csbNivelTraza);
        pkg_traza.trace('--<nucons2 | Consumo Mes 2>-- ' || nucons2, csbNivelTraza);
        pkg_traza.trace('--<nucons3 | Consumo Mes 3>-- ' || nucons3, csbNivelTraza);
        pkg_traza.trace('--<nucons4 | Consumo Mes 4>-- ' || nucons4, csbNivelTraza);
        pkg_traza.trace('--<nucons5 | Consumo Mes 5>-- ' || nucons5, csbNivelTraza);
        pkg_traza.trace('--<nucons6 | Consumo Mes 6>-- ' || nucons6, csbNivelTraza);
        pkg_traza.trace('[nuhistvalida - nuhistvalida2] => [' ||
                       nuhistvalida || '-' || nuhistvalida2 || ']>--', csbNivelTraza);
        pkg_traza.trace('--<nucanmescero | Consumo Mes Anterior>-- ' ||
                       nucanmescero, csbNivelTraza);
        pkg_traza.trace('--<nucanmescero2 | Consumo Segundo Mes Anterior>-- ' ||
                       nucanmescero2, csbNivelTraza);
        pkg_traza.trace('--<nucanmescero3 | Consumo Tercer Mes Anterior>-- ' ||
                       nucanmescero3, csbNivelTraza);

        --Se Obtienen los Consumos que han sido recuperados
        ldc_bssreglasproclecturas.prObtConsRecup(num_producto, nuperiodo_consumo, nuvolrecupproy, sbmarcaRecuperado, nuPeriodosRecup, nuconsFactActual, nuconsFact1, nuconsFact2, nuconsFact3, nuconsFact4, nuconsFact5, nuconsFact6);
        pkg_traza.trace('--<Volumen Recuperado Proyectado Periodo ACtual>-- ' ||
                       nuvolrecupproy, csbNivelTraza);
        pkg_traza.trace('--<Numero Per. Recuperados>-- ' || nuPeriodosRecup, csbNivelTraza);
        pkg_traza.trace('--<Flag Marca Recuperado>-- ' || sbmarcaRecuperado, csbNivelTraza);
        pkg_traza.trace('--<*** Consumos Facturados sin Recuperacion ***>-- ', csbNivelTraza);
        pkg_traza.trace('--<nuconsFact1 | Consumo Mes 1>-- ' || nuconsFact1, csbNivelTraza);
        pkg_traza.trace('--<nuconsFact2 | Consumo Mes 2>-- ' || nuconsFact2, csbNivelTraza);
        pkg_traza.trace('--<nuconsFact3 | Consumo Mes 3>-- ' || nuconsFact3, csbNivelTraza);
        pkg_traza.trace('--<nuconsFact4 | Consumo Mes 4>-- ' || nuconsFact4, csbNivelTraza);
        pkg_traza.trace('--<nuconsFact5 | Consumo Mes 5>-- ' || nuconsFact5, csbNivelTraza);
        pkg_traza.trace('--<nuconsFact6 | Consumo Mes 6>-- ' || nuconsFact6, csbNivelTraza);
        pkg_traza.trace('--<-------------------------------------------->-- ', csbNivelTraza);
        pkg_traza.trace('--<Inicia Cursor de Validacion de Reglas de Critica>-- ', csbNivelTraza);

        FOR i IN cunuevacalificacion
        LOOP
            pkg_traza.trace('Cursor cunuevacalificacion Regla ' ||
                           i.consecutivo, csbNivelTraza);
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla13 THEN
                nuVecesObs := prGetRecurrenciaObseNlec(i.consecutivo);
                IF sbindicalect = 'N' AND fsbobs1(nucausanolect)
                   AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod(nucausanolect) + 1) > nuVecesObs
                THEN --CA 314, Ajuste 314
                    pkg_traza.trace('Genera actividades adicionales prGeneraActiviObNlect', csbNivelTraza);
                    prGeneraActiviObNlect
                    ( 
                        i.consecutivo,
                        nucausanolect,
                        num_producto,
                        'T',
                        dtfechafincons,
                        nuperiodo_consumo,
                        nuconsecutivolect
                    );
                    
                    IF 
                    (
                        sbestafina = 'C' OR
                        ( 
                            sbestafina <> 'C' AND 
                            nucanmescero = 0 AND nucanmescero2 = 0 AND --por recomendacion de Monica Olivella
                            nucanmescero3 = 0
                        )
                    ) --lmfg
                    THEN
                        --Si Castigado con Ultimos 3 Meses Consumo 0-Cero
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                       sbfunman || '-' || numetman, csbNivelTraza);
                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    ELSE
                        IF sbmarcaprompropio = 'S' OR
                            sbmarcapromsubcat = 'S' THEN
                            cm_boestimateservices.assignconsuption(sbfunconsprom);
                            cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion);
                        ELSE
                            cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                            pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                           sbfunman || '-' || numetman, csbNivelTraza);
                            cm_boestimateservices.assignconsuption(sbfunman);
                            cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL

                            isbordcom := 'Orden generada por proceso de reglas';

                            OPEN cuexisteordengenerada(num_producto, 12619, nuanacrit);
                            FETCH cuexisteordengenerada        INTO nucantot;

                            IF nucantot = 0  THEN
                                --Genera Critica si el promedio actual supera el Factor% del Ultimo Promedio registrado del producto
                                --y si no tiene ni promedio propio ni por subcategoria
                                isbordcom := 'Orden generada por proceso de reglas';
                                prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                                nuExisteOrd := 1;
                                nucantot := 1;
                                
                                pkg_traza.trace('ejecuto generacion de critica - POR PROMEDIO INDIVIDUAL', csbNivelTraza);
                                
                           END IF;
                           CLOSE cuexisteordengenerada;
                        END IF;
                    END IF;
                    
                    pkg_traza.trace('entro regla nuRegla13: ' ||i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                    
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla14 THEN
                nuVecesObs := prGetRecurrenciaObseNlec(i.consecutivo);
                IF sbindicalect = 'N' AND fsbobs2(nucausanolect)
                   AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod(nucausanolect) + 1) >= nuVecesObs
                THEN
                    nuactivitytypeid := pkg_bcld_parameter.fnuobtienevalornumerico('ACTIVI_REVTEC_CONSUM');
                    isbordcom        := 'Orden generada por proceso de reglas';

                    -- Inicio 200_639
                    nucantot := fnucantotgeneradas(inuproducto => num_producto);
                    -- Fin 200-389

                    IF nucantot = 0 THEN
                        --sse valida si no existe ordenes pendientes o menores a 6 meses
                        nuValiOrde := ldc_fnuvalidaOrdeVisita ( num_producto,
                                                                 sbestafina,
                                                                 nuactivitytypeid);
                        --inicio CA 200-389
                       IF nuValiOrde = 0 THEN
                            --Actualizo el estado del proceso
                            --Si el estado de corte es 5-Suspension total o el Estado Financiero es C-Castigado
                            --No se genera la Orden de Revision de Consumo (Critica)
                            IF nuestcorte <> 5 AND sbestafina <> 'C' THEN
                                --se llama proceso para generar orden de visita
                                prGeneraActiviObNlect( i.consecutivo,
                                                         nucausanolect,
                                                         num_producto,
                                                         'N',
                                                         dtfechafincons,
                                                         nuperiodo_consumo,
                                                         nuconsecutivolect);
                            END IF;
                        END IF;
                        --Fin CA 200-389

                    END IF;

                    IF nuestcorte <> 5 AND sbestafina <> 'C' THEN
                        --se llama proceso para generar orden de visita
                        prGeneraActiviObNlect( i.consecutivo,
                                               nucausanolect,
                                               num_producto,
                                               'S',
                                               dtfechafincons,
                                               nuperiodo_consumo,
                                               nuconsecutivolect);
                    END IF;

                    cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                    pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                   sbfunman || '-' || numetman, csbNivelTraza);
                    cm_boestimateservices.assignconsuption(sbfunman);
                    cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla14: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla15 THEN

                nuVecesObs := prGetRecurrenciaObseNlec(i.consecutivo);

                IF sbindicalect = 'N' AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod(nucausanolect) + 1) <= nuVecesObs THEN

                    IF (sbestafina = 'C' OR
                       nuestprod = 2 --estado de corte en coment. segun Monica Oli
                       or ( nuestprod = 1
                        and nucanmescero = 0 AND nucanmescero2 = 0 AND
                        nucanmescero3 = 0) ) -- lmfg
                    THEN
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                       sbfunman || '-' || numetman, csbNivelTraza);
                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        ---------
                        -- Cambio 38: si est prod suspendido y la ult act de susp es de los tt del parametro TT_SUSP_REGLA_2002
                    ELSE
                        IF sbmarcaprompropio = 'S' OR
                            sbmarcapromsubcat = 'S' THEN

                            --Si entra aqui, deberia tener consumo promedio por tener consumos validos en periodos anteriores (200-1202)
                            cm_boestimateservices.assignconsuption(sbfunconsprom);
                            cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion);

                            pkg_traza.trace('ejecuto generacion de critica - POR PROMEDIO INDIVIDUAL', csbNivelTraza);
                        ELSE
                            cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO

                            pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                     sbfunman || '-' || numetman, csbNivelTraza);

                            cm_boestimateservices.assignconsuption(sbfunman);
                            cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                            isbordcom := 'Orden generada por proceso de reglas';

                            OPEN cuexisteordengenerada(num_producto, 12619, nuanacrit);
                            FETCH cuexisteordengenerada        INTO nucantot;
                            IF nucantot = 0    THEN
                                --Genera Critica si el promedio actual supera el Factor% del Ultimo Promedio registrado del producto
                                --y si no tiene ni promedio propio ni por subcategoria
                                isbordcom := 'Orden generada por proceso de reglas';
                                prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                                nuExisteOrd := 1;
                                nucantot := 1;

                                pkg_traza.trace('ejecuto generacion de critica - POR PROMEDIO INDIVIDUAL', csbNivelTraza);
                            END IF;
                            CLOSE cuexisteordengenerada;
                        END IF;
                    END IF;

                    IF orcproduct.sesucate = 2 THEN
                        prGeneraActiviObNlect( i.consecutivo,
                                                 nucausanolect,
                                                 num_producto,
                                                  'T',
                                                 dtfechafincons,
                                                 nuperiodo_consumo,
                                                 nuconsecutivolect);
                    END IF;

                    pkg_traza.trace('entro regla nuRegla15: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla16 THEN
                --CA 200-1202 Regla deshabilitada
                IF sbindicalect = 'N' THEN
                    IF nuhistvalida2 >= 1 THEN
                        cm_boestimateservices.assignconsuption(sbfunconsprom);
                        cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion);

                        IF sbmarcaprompropio = 'N' THEN
                            isbordcom := 'Orden generada por proceso de reglas';
                            prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                            nuExisteOrd := 1;
                            pkg_traza.trace('ejecuto generacion de critica', csbNivelTraza);
                        ELSE
                            IF (fnuultconsprom(num_producto) * nuporcpromind) < nuconsprom1 THEN
                                isbordcom := 'Orden generada por proceso de reglas';
                                --CM_BOCONSLOGICSERVICE.GENERATEJOBORDER(nuAnaCrit,isbOrdCom); -- Genero OT de critica 12619 con actividad 102010
                                prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                                nuExisteOrd := 1;

                                pkg_traza.trace('ejecuto generacion de critica - POR PROMEDIO INDIVIDUAL', csbNivelTraza);

                            END IF;
                        END IF;
                    ELSE
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO

                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                       sbfunman || '-' || numetman, csbNivelTraza);

                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    END IF;

                    pkg_traza.trace('entro regla nuRegla16: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla17 THEN
                IF sbindicalect = 'S'
                AND nuconsumo = 0
                AND nucanmescero = 0
                AND nucanmescero2 = 0 THEN
                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);

                    pkg_traza.trace('entro regla nuRegla17: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --Validación para generación de crítica
                    IF sbordenpend = 'S' THEN
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        pkg_traza.trace('Ejecutó generación de crítica por orden pendiente CM', csbNivelTraza);
                        nuExisteOrd := 1;
                    END IF;

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla18 THEN
                IF sbindicalect = 'S'
                AND calificacion = 1 THEN
                    cm_boestimateservices.assignconsuption(sbfunconsact);
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);

                    pkg_traza.trace('entro regla nuRegla18: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla19 THEN
                IF sbindicalect = 'S' AND calificacion <> 1 THEN

                    pkg_traza.trace('entro regla nuRegla19: ' || i.codigo_calificacion, csbNivelTraza);

                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);
                    cm_boestimateservices.assignconsuption(sbfunconsact);
                    isbordcom := 'Orden generada por proceso de reglas';
                    prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                    nuExisteOrd := 1;

                    pkg_traza.trace('ejecuto generacion de critica', csbNivelTraza);
                    --CURSOR NUS LA CATEGORIA DEL PRODUCTO  num_producto
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla21 THEN
                IF sbindicalect = 'S'
               AND NOT fsbestcortnopermit(nuestprod)
               AND nuconsumo <> 0 THEN
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);
                    cm_boestimateservices.assignconsuption(sbfunconsact);

                    pkg_traza.trace('entro regla nuRegla21: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla23 THEN
                IF sbindicalect = 'S'
                AND fsbestcortnopermit(nuestprod)
                AND nuconsumo = 0
                AND nucanmescero = 1 THEN
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);
                    cm_boestimateservices.assignconsuption(sbfunconsact);

                    pkg_traza.trace('entro regla nuRegla23: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --Validación para generación de crítica
                    IF sbordenpend = 'S' THEN
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        pkg_traza.trace('Ejecutó generación de crítica por orden pendiente CM', csbNivelTraza);
                        nuExisteOrd := 1;
                    END IF;

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla24 THEN
                IF sbindicalect = 'S'
                AND fsbestcortnopermit(nuestprod)
                AND nuconsumo = 0
                AND nucanmescero = 0 /*And nucanmescero2 = 1*/
                THEN
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);
                    cm_boestimateservices.assignconsuption(sbfunconsact);

                    pkg_traza.trace('entro regla nuRegla24: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --Validación para generación de crítica
                    IF sbordenpend = 'S' THEN
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        pkg_traza.trace('Ejecutó generación de crítica por orden pendiente CM', csbNivelTraza);
                        nuExisteOrd := 1;
                    END IF;

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla26 THEN
                IF orcproduct.sesucate = 1
                AND nuconsumo > nuvalconsumo THEN
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);
                    cm_boestimateservices.assignconsuption(sbfunconsact);
                    isbordcom := 'Orden generada por proceso de reglas';
                    prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                    nuExisteOrd := 1;

                    pkg_traza.trace('ejecuto generacion de critica', csbNivelTraza);
                    pkg_traza.trace('entro regla nuRegla26: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla27 THEN
                cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL

                pkg_traza.trace('entro regla nuRegla27: ' ||
                               i.codigo_calificacion, csbNivelTraza);

                prGeneraActiviObNlect( i.consecutivo,
                                       nucausanolect,
                                       num_producto,
                                       'T',
                                       dtfechafincons,
                                       nuperiodo_consumo,
                                       nuconsecutivolect);
                EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla32 THEN
                IF calificacion = nuregla32 THEN
                    IF sbindicalect = 'S'
                    AND (sbmarcaprompropio = 'N' AND
                    sbmarcapromsubcat = 'N') THEN
                        --TIENE LECTURA NO PROM PROPIO NI PROM SUBCATEGORIA
                        --< Calificar consumo como 1-Normal >--
                        calificacion := 1;
                        cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('--< Calificar consumo como 1-Normal | Diferencia de Lecturas >-- | sbfunconsact: ' ||
                                       sbfunconsact, csbNivelTraza);
                        IF
                        (
                            (orcproduct.sesucate = 1 AND nuconsumo > num3maxnvores) OR
                            --Es Comercial y el consumo Actual es menor al parametro M3_MAX_NVO_USU_COM
                            (orcproduct.sesucate = 2 AND nuconsumo > num3maxnvocom   )
                        ) THEN

                            --< Genera Orden de Critica >--
                            isbordcom := 'Orden generada por proceso de reglas';
                            prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                            nuExisteOrd := 1;

                            pkg_traza.trace('--< Genera Orden de Critica >--', csbNivelTraza);

                        END IF;

                        pkg_traza.trace('entro regla nuRegla32: ' ||
                                       i.codigo_calificacion, csbNivelTraza);
                        EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                    END IF;
                END IF;
            END IF;
            ----------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla33 THEN

                pkg_traza.trace('sbindicalect ' || sbindicalect, csbNivelTraza);
                pkg_traza.trace('sbprodnuevo ' || sbprodnuevo, csbNivelTraza);
                pkg_traza.trace('nuconsumo ' || nuconsumo, csbNivelTraza);

                IF sbindicalect = 'S'
                AND sbprodnuevo = 'S'
                AND nuconsumo  >= 0 THEN

                    IF
                    (
                        (orcproduct.sesucate = 1 AND
                            (
                                (nuconsumo <= num3maxnvores AND sbmarcapromsubcat = 'N') OR
                                (calificacion = 1 AND sbmarcapromsubcat = 'S')
                            )
                        ) OR
                        --Es Comercial y el consumo Actual es menor al parametro M3_MAX_NVO_USU_COM
                        (orcproduct.sesucate = 2 AND
                           (
                                (nuconsumo <= num3maxnvocom  AND sbmarcapromsubcat = 'N') OR
                                (calificacion = 1 AND sbmarcapromsubcat = 'S')
                            )
                        )
                    ) THEN

                        pkg_traza.trace('--< Ingreso nuconsact <= num3maxnvo(res com): ' ||
                                           nuconsact || '>--', csbNivelTraza);
                        --< Calificar consumo como 1-Normal >--
                        calificacion := 1;
                        cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('--< Calificar consumo como 1-Normal | Diferencia de Lecturas >--', csbNivelTraza);
                    ELSE
                        --< Calificar consumo como 1-Normal >--
                        pkg_traza.trace('--< Ingreso nuconsact > num3maxnvo(res com): ' ||
                                       nuconsact || '>--', csbNivelTraza);
                        calificacion := 1;
                        cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('--< Calificar consumo como 1-Normal | Diferencia de Lecturas >--', csbNivelTraza);

                        --< Genera critica >--
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        nuExisteOrd := 1;
                        pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);
                    END IF;

                    pkg_traza.trace('entro regla nuRegla33: ' ||
                                       i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluo por esta regla y aplico, Deja de evaluarlo
                END IF;
            END IF;
        END LOOP;

        pkg_traza.trace('--<Fin Cursor de Validacion de Reglas de Critica>-- ', csbNivelTraza);

        --INICIO CA 222
        IF nuExisteOrd = 0 THEN
            nuProductId := num_producto;

            SELECT COUNT(1) INTO nuExiste
            FROM LDC_CTRLLECTURA t
            WHERE t.NUM_PRODUCTO = nuProductId
            AND t.FLAG_PROCESADO = 'N';

            IF nuExiste > 0 THEN
                --Inicio CA 875
                --Se identifica si el producto tiene ordenes de CM pendientes
                sbPend := ldc_fsbGetPendOrdersCM(nuProductId);

                --Se valida si no existen ordenes pendientes para generar la critica
                IF (sbPend = 'N') THEN

                    UPDATE LDC_CTRLLECTURA t SET FLAG_PROCESADO = 'S',t.PROCESO='CM', t.FEHAPROCESO=sysdate
                    WHERE  t.NUM_PRODUCTO = nuProductId and t.flag_procesado='N';

                    prgeneracritica
                    (
                        nuanacrit,
                        'GENERACION DE CRITICA POR CAMBIO DE MEDIDOR',
                        nuProductId,
                        dtfechafincons,
                        nuperiodo_consumo,
                        nuconsecutivolect
                    );
                END IF;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;

    END prlecturacritica;

    FUNCTION fnucantotgeneradas(inuproducto conssesu.cosssesu%TYPE -- Producto
                                ) RETURN NUMBER IS
        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.
        Nombre del Paquete: fnucantotgeneradas
        Descripción:        Devuelve la cantidad de ordenes según el tipo de trabajo, estados y
                            periodos anteriores indicados por parametro.
        Autor    : Migue Angel Lopez
        Fecha    : 24-04-2017 CA200-1101
        Historia de Modificaciones
        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        04-10-2016   Migue Angel Lopez      Creacion
        ***********************************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnucantotgeneradas';

        nucantidadordenes   NUMBER; -- Cantidad de órdenes
        nuparmetodoconsumo  ld_parameter.numeric_value%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico( 'COD_MET_CON_FACT'); -- Método de cálculo consumo facturado
        nupartipotrabajo    ld_parameter.numeric_value%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico( 'TITR_REVIS_TEC_REVIS_CONSUMO'); -- Tipo de Trabajo de las órdenes a buscar
        nuparcantperant     NUMBER; -- Cantidad de periodos anteriores  al actual
        nuparestordenes     ld_parameter.numeric_value%TYPE; -- Estados de las órdenes a buscar separados por ?|?

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuproducto   <= '||inuproducto,csbNivelTraza);

        BEGIN
            nuparcantperant := pkg_bcld_parameter.fnuobtienevalornumerico( 'NUM_PER_REVIS_CONSUMO');
        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'No fue posible consultar el parámetro NUM_PER_REVIS_CONSUMO. '||SQLERRM;
                Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        END;

        IF nuparcantperant IS NULL THEN
            sberror := 'El parámetro NUM_PER_REVIS_CONSUMO no tiene valor';
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        END IF;

        BEGIN
            nuparestordenes := pkg_bcld_parameter.fnuobtienevalornumerico('ESTADO_CERRADO');
        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'No fue posible consultar el parámetro ESTADO_CERRADO. '||SQLERRM;
                Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        END;

        IF nuparestordenes IS NULL THEN
            sberror := 'El parámetro ESTADO_CERRADO no tiene valor';
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        END IF;

        SELECT COUNT(1)
        INTO nucantidadordenes
        FROM or_order oo, or_order_activity ooa
        WHERE oo.task_type_id = nupartipotrabajo
              AND -- Revisión técnica de consumo
              oo.order_id = ooa.order_id
              AND ooa.product_id = inuproducto
              AND ooa.order_id = oo.order_id
              AND nuparestordenes > oo.order_status_id; -- Estados ingresados por parámetro

        pkg_traza.trace('return => '||nucantidadordenes,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nucantidadordenes;

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END  fnucantotgeneradas;

    FUNCTION fnuobtieneregla(isbnombreregla ld_parameter.parameter_id%TYPE -- Código de la regla
                             ) RETURN NUMBER IS
        /*****************************************************************
        Propiedad intelectual de PETI (c).
        Unidad         : fnuObtieneRegla
        Descripcion    : Obtiene el código de una regla
        Autor          : Sandra Muñoz
        Fecha          : 20-10-2016
        Fecha             Autor             Modificacion
        =========       =========           ====================
        20-10-2016      Sandra Muñoz        CA200-639. Creación
        *****************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnuobtieneregla';

        nuregla         ld_parameter.numeric_value%TYPE; -- Código de la regla

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('isbnombreregla <= '||isbnombreregla,csbNivelTraza);

        BEGIN
            nuregla := pkg_bcld_parameter.fnuobtienevalornumerico(isbnombreregla);
        EXCEPTION
            WHEN OTHERS THEN
                Pkg_Error.setErrorMessage( isbMsgErrr => 'No fue posible consultar el parámetro '||isbnombreregla || '. ' || SQLERRM);
        END;

        IF nuregla IS NULL THEN
            Pkg_Error.setErrorMessage( isbMsgErrr => 'El parámetro ' || isbnombreregla ||' no tiene valor');
        END IF;

        pkg_traza.trace('return => '||nuregla,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuregla;

    EXCEPTION
        WHEN pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.CONTROLLED_ERROR;
    END fnuobtieneregla;

    PROCEDURE procalificavariacionconsumo
    (
        inupericonsumo         conssesu.cosspecs%TYPE, -- Período de consumo
        inuconsumoactual       IN OUT conssesu.cosscoca%TYPE, -- Consumo actual
        isbmarcaprompropio     CHAR, -- Indica si tiene consumo promedio propio
        isbtienelectura        CHAR, -- Indica si se está legalizando con lectura
        inuconsumopromedioopen hicoprpm.hcppcopr%TYPE, -- Consumo promedio
        inuproducto            conssesu.cosssesu%TYPE, -- Producto
        inucategoria           pr_product.category_id%TYPE, -- Categoría
        inusubcategoria        pr_product.subcategory_id%TYPE, -- Subcategoría
        onucalificacion        OUT calivaco.cavccodi%TYPE -- Calificación
    ) IS
        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.
        Nombre del Paquete: proCalificaVariacionConsumo
        Descripción:        Devuelve la calificación de variación de consumos
        Autor    : Sandra Muñoz
        Fecha    : 16-08-2016 CA200-639
        Historia de Modificaciones
        DD-MM-YYYY    <Autor>.              Modificación
        -----------  -------------------    -------------------------------------
        21/08/2024   jcatuche               OSF-3009: Se asigna consumo subcategoria no proyectado cuando se presenta cambio de medidor con recuperación de consumos
                                            Se asigna usando la variable global nuconssubnoproy
                                            Se asigna 
        21-07-2023   jcatuchemvm            OSF-1366: Se crea cursor cuRecuperacionRetiro para contabilizar consumos recuperados
                                            Si hay cambio de medidor, consumo promedio por subcategoria y recuperación de consumos,
                                            se usa el consumo promedio por subcategoria para estimar la desviación.
                                            Se elimina cursor para el calculo del promedio promedio propio, y se agrega llamado a fnuultconsprom
                                            para la consecución del consumo desde hicoprpm
        20-01-2017   Oscar Ospino P.        CA 200-1063. Se agregan validacion de Lectura y de usuario nuevo
        25-11-2016   Sandra Muñoz           CA 200-639. Corrección de la fórmula
        24-10-2016   Sandra Muñoz           CA 200-639. Se ajusta el procedimiento para que soporte la aplicación
                                            de las reglas 28, 29 y 30
        06-10-2016   Sandra Muñoz           CA 200-639. Se controla que si no se puede obtener valor de la subcategoría
                                            se le asigne una regla nueva
        26-08-2016   Sandra Muñoz           CA 200-639. Se completa el mensaje de error cuando no se encuentra
                                            consumo promedio para la localidad.
        16-08-2016   Sandra Muñoz           Creación
        ***********************************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'procalificavariacionconsumo';
        nuconsactualvsconsprom  NUMBER; -- Relación del consumo actual frente al consumo promedio
        nuregla28               ld_parameter.numeric_value%TYPE; -- Regla 28
        nuregla29               ld_parameter.numeric_value%TYPE; -- Regla 29
        nuregla30               ld_parameter.numeric_value%TYPE; -- Regla 30
        nuconsumopromedio       hicoprpm.hcppcopr%TYPE; -- Consumo promedio con el que se realizará el cálculo de la calificación
        sbdevuelvecalificacion  CHAR(1) := 'S'; -- Indica si devuelve calificación
        nupaso                  VARCHAR2(32000);
        nuconsact               conssesu.cosscoca%TYPE := inuconsumoactual; --Se asigna el consumo actual

        cursor cuRecuperacionRetiro is
        select * from
        (
            select /*+ index ( a IDX_OR_ORDER_ACTIVITY_010) use_nl ( a o )
            index ( o pk_or_order ) */
            a.order_id,a.order_activity_id,a.product_id,a.status,o.created_Date,o.legalization_date,o.task_type_id,
            nvl(
            (
                select count(*)
                from conssesu,lectelme
                where leemsesu = a.product_id
                and leemclec = 'R'
                and leemdocu = a.order_activity_id
                and cosssesu = leemsesu
                and cosselme = leemelme
                and cossmecc = 5
                and cossfere between o.legalization_Date-10/86400 and o.legalization_Date+10/86400
            ),0) recuperados,
            row_number() over (order by o.order_id desc) row_num
            from or_order_activity a, or_order o, pericose
            where a.product_id = inuproducto
            and o.order_status_id = 8
            and pecscons = inupericonsumo
            and o.legalization_date > pecsfeci
            and o.order_id = a.order_id
            and exists
            (
                SELECT /*+ index ( ti IX_OR_TASK_TYPES_ITEMS01 ) use_nl ( ti ia )
                index ( ia PK_GE_ITEMS_ATTRIBUTES )*/
                'x'
                FROM or_task_types_items ti, ge_items_attributes ia
                WHERE ti.task_type_id = o.task_type_id
                AND ia.items_id = ti.items_id
                AND
                (
                    attribute_1_id = 400021 or attribute_2_id = 400021 or attribute_3_id = 400021 or attribute_4_id = 400021
                )
                AND
                (
                    attribute_1_id = 400022 or attribute_2_id = 400022 or attribute_3_id = 400022 or attribute_4_id = 400022
                )
            )
        )
        where row_num = 1
        ;

        rcRecuperacionRetiro    cuRecuperacionRetiro%rowtype;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuPeriConsumo          <= ' || inupericonsumo, csbNivelTraza);
        pkg_traza.trace('inuconsumoactual        <= ' || nuconsact, csbNivelTraza);
        pkg_traza.trace('isbmarcaprompropio      <= '||isbmarcaprompropio,csbNivelTraza);
        pkg_traza.trace('isbTieneLectura         <= ' || isbtienelectura, csbNivelTraza);
        pkg_traza.trace('inuConsumoPromedioOpen  <= ' || inuconsumopromedioopen, csbNivelTraza);
        pkg_traza.trace('inuProducto             <= ' || inuproducto, csbNivelTraza);
        pkg_traza.trace('inuCategoria            <= ' || inucategoria, csbNivelTraza);
        pkg_traza.trace('inuSubCategoria         <= ' || inusubcategoria, csbNivelTraza);

        pkg_traza.trace('Tiene Prom. Propio          ' || sbmarcaprompropio, csbNivelTraza);
        pkg_traza.trace('Tiene Prom. Subcategoria    ' || sbmarcapromsubcat, csbNivelTraza);
        pkg_traza.trace('Producto es Nuevo:          ' || sbprodnuevo, csbNivelTraza);
        pkg_traza.trace('nuPeriodCeroConsec          ' || nuperiodceroconsec, csbNivelTraza);
        pkg_traza.trace('nuVecesConsEstimado         ' || nuvecesconsestimado, csbNivelTraza);

        nupaso := 'ProCalifVarCons | ';

        --OSF-366
        IF sbmarcaCambMedidor = 'S' AND sbmarcapromsubcat = 'S' THEN
            rcRecuperacionRetiro := null;
            OPEN cuRecuperacionRetiro;
            FETCH cuRecuperacionRetiro INTO  rcRecuperacionRetiro;
            CLOSE cuRecuperacionRetiro;

            IF NVL(rcRecuperacionRetiro.recuperados,0) > 0 THEN
                nupaso := nupaso || '|0';
                nuconsumopromedio := nuconssubnoproy;
                sbfunconsprom := sbfunconssub;

                pkg_traza.trace('Promedio por Categoria por cambio de medidor y consumos recuperados:   ' ||
                           nuconsumopromedio, csbNivelTraza);
            END IF;
        END IF;

        IF NVL(nuconsumopromedio,0) = 0 THEN

            -- consumo propio Calculado para la calificacion
            BEGIN
                nupaso := nupaso || '|1';

                nuconsumopromedio := fnuultconsprom(inuproducto);

            EXCEPTION
                WHEN OTHERS THEN
                    nupaso            := nupaso || '|2';
                    nuconsumopromedio := 0;
            END;

            pkg_traza.trace('Promedio Individual Calculado Internamente desde hicoprpm:   ' ||
                           nuconsumopromedio, csbNivelTraza);
        END IF;

        IF nuconsumopromedio <= 0
        OR nuconsumopromedio IS NULL THEN
            nupaso := nupaso || '|3';
            --Si el producto no tiene Promedio en el ultimo periodo, se asigna el obtenido por la funcion de OSF
            nuconsumopromedio := inuconsumopromedioopen;

            pkg_traza.trace('Se usa Prom. Indiv obtenido del parametro de entrada inuconsumopromedioopen: ' ||
                           nuconsumopromedio, csbNivelTraza);
        END IF;

        IF nuconsumopromedio <= 0 THEN
            nupaso            := nupaso || '|4';
            sbmarcaprompropio := 'N';
        ELSE
            nupaso            := nupaso || '|5';
            sbmarcaprompropio := 'S';
        END IF;

        pkg_traza.trace('Nuevo valor Flag Tiene Prom. Propio:   ' ||
                       sbmarcaprompropio, csbNivelTraza);

        pkg_traza.trace('--<sbprocesoactual :   ' || sbprocesoactual ||
                       '>--', csbNivelTraza);

        --Valida si hay lectura y el consumo es valido
        IF isbtienelectura = 'S'
        AND nuconsact >= 0 THEN

            nupaso := nupaso || '|10';

            --Valida Promedio Propio
            IF sbmarcaprompropio = 'S'
            OR sbmarcapromsubcat = 'S' THEN

                onucalificacion := NULL;

                IF sbprodnuevo = 'S' THEN
                    nupaso                 := nupaso || '|15';
                    sbdevuelvecalificacion := 'S';
                ELSE
                    --calculo el % de variacion del consumo basado en Rangos (Prom. ya viene asignado )
                    nupaso                 := nupaso || '|16';
                    sbdevuelvecalificacion := 'S';
                END IF;
            ELSE
                --Si no hay promedios o el consumo actual es negativo, no se evalua por Rangos
                --Si , se califica como Desviado Inferior
                nupaso := nupaso || '|17';

                IF sbprocesoactual = 'LECTURA' THEN
                    nupaso          := nupaso || '|20';
                    onucalificacion := 28;
                ELSIF sbprocesoactual = 'RELECTURA' THEN
                    nupaso          := nupaso || '|25';
                    onucalificacion := 32;
                ELSIF sbprocesoactual = 'INDUSTRIAL' THEN
                    nupaso          := nupaso || '|26';
                    onucalificacion := 4;
                END IF;

                sbdevuelvecalificacion := 'S';
            END IF;
        ELSE
            --No Hay Lectura - Se Valida Promedio Propio
            IF sbmarcaprompropio = 'S'
            OR sbmarcapromsubcat = 'S' THEN
                nupaso := nupaso || '|30';
                --calculo el % de variacion del consumo basado en Rangos (Prom. ya viene asignado )
                nuconsact              := 0; --Consumo actual se indica 0-Cero para que el rango sea desviado inferior (-100%)
                onucalificacion        := NULL;
                sbdevuelvecalificacion := 'S';
            ELSE
                --Si no hay promedios o el consumo actual es negativo, no se evalua por Rangos
                IF sbprocesoactual = 'LECTURA' THEN
                    nupaso                 := nupaso || '|35';
                    onucalificacion        := 28;
                    sbdevuelvecalificacion := 'N';
                ELSIF sbprocesoactual = 'RELECTURA' THEN
                    nupaso                 := nupaso || '|40';
                    onucalificacion        := 32;
                    sbdevuelvecalificacion := 'N';
                END IF;
            END IF;
        END IF;

        --< CA 200-1063 >--
        nupaso := nupaso || '|100';

        --Traza con los Pasos del Proceso
        pkg_traza.trace(nupaso,csbNivelTraza);

        IF onucalificacion IS NULL
        AND sbdevuelvecalificacion = 'S' THEN
            -- Si No se fija ninguna calificación, se busca por rango
            nupaso := nupaso || '|110';

            -- Obtener la relación de variación de consumo
            pkg_traza.trace('nuConsumoPromedio (para obtener la relación) ' ||
                           nuconsumopromedio, csbNivelTraza);

            BEGIN
                -- 25-11-2016 - Sandra Muñoz. Corrección de la fórmula
                --nuConsActualVsConsProm := round(nuconsact * 100 / nuConsumoPromedio, 3);
                if nuconsumopromedio = 0 then
                  nuconsactualvsconsprom := 0;
                else
                nuconsactualvsconsprom := round((nuconsact - nuconsumopromedio) /
                                                nuconsumopromedio * 100); --lmfg por sugerencia de oop se quito el redondeo a 3
                end if;

                pkg_traza.trace('nuConsActualVsConsProm ' ||
                               nuconsactualvsconsprom, csbNivelTraza);

            EXCEPTION
                WHEN OTHERS THEN
                    sberror := 'Error al calcular formula del % de Variacion Consumo | Consumo Actual ' ||
                               nuconsact || ' | Promedio ConsumoPromedio ' ||
                               nuconsumopromedio ||
                               ' | nuConsActualVsConsProm ' ||
                               nuconsactualvsconsprom;
                    Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
            END;

            -- Obtener la calificación
            nupaso := nupaso || '|120';

            DECLARE

                sbcalificacion_desc calivaco.cavcdesc%TYPE; -- Descripción

            BEGIN

                SELECT cavccodi, calivaco.cavcdesc
                INTO onucalificacion, sbcalificacion_desc
                FROM caravaco, racavaco, calivaco
                WHERE rcvccrvc = crvccodi -- Join Clases con Rangos
                      AND cavccodi = rcvccavc -- Join Rangos con Calificación
                      AND crvccate = inucategoria
                      AND crvcsuca = inusubcategoria
                      AND nuconsumopromedio BETWEEN crvcraci AND
                      crvcracf
                      AND --lmfg por sugerencia de OOP
                      nuconsactualvsconsprom BETWEEN rcvcrain AND
                      rcvcrafi;
                pkg_traza.trace('sbCalificacion_desc ' || sbcalificacion_desc, csbNivelTraza);
                pkg_traza.trace('onuCalificacion ' || onucalificacion, 20);

            EXCEPTION
                WHEN too_many_rows THEN
                    sberror := 'Se encontraron varias calificaciones que coinciden con la categoría ' ||
                               inucategoria || ', subcategoría ' ||
                               inusubcategoria || ', consumo promedio ' ||
                               nuconsumopromedio ||
                               ', relación de consumo promedio vs consumo actual ' ||
                               nuconsactualvsconsprom || nupaso;
                    Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
                WHEN no_data_found THEN
                    sberror := 'No se encontraron calificaciones que coinciden con la categoría ' ||
                               inucategoria || ', subcategoría ' ||
                               inusubcategoria || ', Promedio ' ||
                               nuconsumopromedio || ', Promedio Subcat' ||
                               nuconsumopromedio || ', Flag Promedio Propio ' ||
                               sbmarcaprompropio || ', Flag Promedio Subcateg ' ||
                               sbmarcapromsubcat ||
                               ', relación de consumo promedio vs consumo actual ' ||
                               nuconsactualvsconsprom || nupaso;
                    Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
                WHEN OTHERS THEN
                    sberror := 'No posible consultar la calificación de la variación de consumo con la categoría ' ||
                               inucategoria || ', subcategoría ' ||
                               inusubcategoria || ', consumo promedio ' ||
                               nuconsumopromedio ||
                               ', relación de consumo promedio vs consumo actual ' ||
                               nuconsactualvsconsprom || '. ' || SQLERRM ||
                               nupaso;
                    Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
            END;
        END IF;

        inuconsumoactual := nuconsact;

        --Traza con los Pasos del Proceso
        pkg_traza.trace(nupaso,csbNivelTraza);

        nupaso := '';

        pkg_traza.trace('inuconsumoactual    => ' || inuconsumoactual, csbNivelTraza);
        pkg_traza.trace('onuCalificacion     => ' || onucalificacion,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            Pkg_Error.getError( nuerror, sberror );
            sberror := csbFEC||csbMetodo||
                       ' | Paso (' || nupaso || ')' || chr(10) || 'Detalle: ' ||
                       sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            nupaso := 0;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            Pkg_Error.getError( nuerror, sberror );
            sberror := csbFE||csbMetodo||
                       ' | Paso (' || nupaso || ')' || chr(10) || 'Detalle: ' ||
                       sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            nupaso := 0;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
    END procalificavariacionconsumo;

    PROCEDURE prAnaLecturaIndustriales IS
        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.
        Nombre del Paquete: prAnaLecturaIndustriales
        Descripción:        Instancia los datos en Memoria y los envia a procesar por las reglas AVC
        Autor    : Oscar Ospino P.
        Fecha    : 14-06-2017 CA 200-1202
        Historia de Modificaciones
        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        14-06-2017      Oscar Ospino P.     Creacion
        25/07/2024      jcatuche            OSF-3009: Se agrega traza de finalizacion de ejecucion del procedimiento antes del return por estandarización
        20/09/2024      jcatuche            OSF-3181: Se elimina definición de variable local nuanacrit, se agrega inicialización de variable global dtfechafincons y nuconsecutivolect
        ***********************************************************************************************/
        --Constantes
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prAnaLecturaIndustriales';

        --Variables instanciadas en Memoria
        orccurrentreading    lectelme%ROWTYPE; -- Lectura que se está procesando
        orcorder             daor_order.styOR_order; -- Orden que se legaliza
        orcproduct           servsusc%ROWTYPE; -- Producto que se está procesando
        onuactivity          remevaco.rmvcacti%TYPE; -- Escenario / Actividad
        orcactiverule        remevaco%ROWTYPE; -- Regla que se está ejecutando
        orcconsumptionperiod pericose%ROWTYPE; -- Período de Consumo
        --Variables AVC
        nuconsprom    conssesu.cosscoca%TYPE;
        numetconsprom mecacons.mecccodi%TYPE;
        nuconssub    conssesu.cosscoca%TYPE := 0;
        numetconssub mecacons.mecccodi%TYPE;
        nuconsact    conssesu.cosscoca%TYPE;
        sbfunconsact conssesu.cossfufa%TYPE;
        numetconsact mecacons.mecccodi%TYPE := CM_BOConstants.cnuBIL_MECC_DIF_LECTURA;
        --Variables
        sbindicalectura VARCHAR2(1); -- Indica si tiene lectura valida
        nucausanolect   lectelme.leemoble%TYPE; --Observacion de No Lectura 1
        nucausanolect2  lectelme.leemoble%TYPE; --Observacion de No Lectura 2
        nucausanolect3  lectelme.leemoble%TYPE; --Observacion de No Lectura 3
        --Variables Devueltas por el proceso
        nucalificacion calivaco.cavccodi%TYPE; -- Calificacion devuelta
        --Variables Parametros
        nucantmesesrec NUMBER(1) := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_MESES_RECUPERAR_CONSUMO'); --Meses para Recuperar Consumos
        --Variables Utilitarias
        nupaso  NUMBER := 0;

		blProdDesviado  BOOLEAN := FALSE;
        onuCumpleRegla  NUMBER := 0;
        isbordcom       VARCHAR2(1000) := 'Orden generada por proceso de reglas prAnaLecturaIndustriales (Industriales)';
        nuestadopr      NUMBER;
        sbRowId         VARCHAR2(4000);
    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);

        sbmarcaCambMedidor := 'N';
        sbfunconsprom := null;
        sbfunconssub := null;
        nuperiodo_consumo := null;
        dtfechafincons := null;
        nuconsecutivolect := null;
        nuConsPendLiqu := null;

        --Obtener Indicador de Lectura Tomada
        nupaso          := 1;
        sbindicalectura := CM_BOCONSLOGICSERVICE.FSBCURRENTREADING();

        --Se obtiene la observacion de No Lectura
        nupaso := 2;
        CM_BOCONSLOGICSERVICE.GETPRIORITYNOREADOBS(nucausanolect, nucausanolect2, nucausanolect3);

        --Obtenemos datos instanciados en memoria por OPEN  para el proceso
        nupaso := 5;
        cm_boconsumptionengine.getenginememorydata(orccurrentreading, -- out nocopy lectelme%rowtype,  -- Lectura que se está procesando
                                                   orcorder, --out nocopy daor_order.styOR_order, -- Orden que se legaliza
                                                   orcproduct, --out nocopy servsusc%rowtype, -- Producto que se está procesando
                                                   onuactivity, --out nocopy remevaco.rmvcacti%type, --Escenario / Actividad
                                                   orcactiverule, -- out nocopy remevaco%rowtype, -- Regla que se está ejecutando
                                                   orcconsumptionperiod --out nocopy pericose%rowtype -- Período de Consumo
                                                   );

        nuorden := orcorder.order_id;
        pkg_traza.trace('nuorden -->' || nuorden, csbNivelTraza);
        
        nuperiodo_consumo := orcconsumptionperiod.pecscons;
        pkg_traza.trace('nuperiodo_consumo -->' || nuperiodo_consumo, csbNivelTraza);
        
        dtfechafincons := orcconsumptionperiod.pecsfecf;
        nuconsecutivolect := orccurrentreading.leemcons;
        
        -- Obtener Consumo por diferencia de lecturas con factor de correccion con recuperacion de consumo
        --Se obtienen tambien la funcion y el metodo de calculo
        nupaso := 8;
        cm_bocalcconsumpservs.readdifandcorrectfactor(nucantmesesrec, nuconsact, sbfunconsact, numetconsact);

        pkg_traza.trace('Lectura Actual ' || orccurrentreading.leemleto ||
                       '>--', csbNivelTraza);
        pkg_traza.trace('Consumo Actual ' || nuconsact || '>--', csbNivelTraza);
        pkg_traza.trace('Funcion Actual ' || sbfunconsact || '>--', csbNivelTraza);
        pkg_traza.trace('Metodo Actual ' || numetconsact || '>--', csbNivelTraza);

        -- Obtener consumo promedio individual
        nupaso := 10;
        cm_boestimateservices.getindividaveragecons(nuconsprom, sbfunconsprom, numetconsprom);

        pkg_traza.trace('--<Promedio Individual ' || nuconsprom || '- Funcion ' ||
                       sbfunconsprom || '- Metodo ' || numetconsprom || '>--', csbNivelTraza);

        -- Consumo por subcategoria proyectado a los dias de consumo
        nupaso := 15;
        LDC_PKGCONPR.getaverageconsofsubcat('LOC', nuconssub, sbfunconssub, numetconssub); -- Consumo promedio del estrato del usuario proyectado con los dias de consumo

        --cm_boestimateservices.getaverageconsofsubcat('LOC', nuconssub, sbfunconssub, numetconssub);
        pkg_traza.trace('Promedio Subcategoria -->' || nuconssub ||
                       '- Funcion ' || sbfunconssub || '- Metodo ' ||
                       numetconssub, csbNivelTraza);

        --Valida consumo propio y de Subcategoria
        nupaso := 18;
        prValidaPromedios(nuconsprom, sbfunconsprom, sbmarcaprompropio, nuconssub, sbmarcapromsubcat, sbfunconssub);

		nuestadopr := pkg_bcproducto.fnuestadoproducto(orcproduct.sesunuse); -- Obtener el estado del producto

        IF sbindicalectura = 'S' THEN
            sbRowId  := NULL;
            --se realiza proceso para desviacion poblacional
            blProdDesviado := pkg_bcGestionConsumoDp.fblValidaProdDesv (  orcproduct.sesunuse,
                                                                          orcproduct.sesususc,
                                                                          nuconsact,
                                                                          orccurrentreading.leempefa,
                                                                          nuperiodo_consumo,
                                                                          orccurrentreading.leemfela,
                                                                          orccurrentreading.leemfele,
                                                                          'S',
                                                                          onuCumpleRegla,
                                                                          sbRowId);

            --si el producto esta desviado o no cumple la regla de desviacion ingresa al proceso de calificacion actual
            IF blProdDesviado OR onuCumpleRegla = 0 THEN
                nucalificacion := null;
               --se valida calificacion
               prCalificaConsumoDesvPobl( orcproduct.sesunuse,
                                          orccurrentreading.leempefa,
                                          nuconsact,
                                          sbmarcaprompropio,
                                          nuestadopr,
                                          nuconsprom,
                                          orcproduct.sesucate,
                                          orccurrentreading.leemfela,
                                          orccurrentreading.leemfele,
                                          'L',
                                          nucalificacion);

                IF nucalificacion = cnuRegla3007 THEN
                    prgeneracritica(nuanacrit, isbordcom, orcproduct.sesunuse, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                END IF;
            ELSE
                nucalificacion := cnuRegla3001;
            END IF;

            --se realiza calificacion nueva
              cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
              cm_boconslogicservice.setmanualqualification(sbfunconsact, nucalificacion);
              IF sbRowId IS NOT NULL THEN
                 pkg_info_producto_desvpobl.prActCalifiProdDesvpobl(sbRowId, nucalificacion);
              END IF;
              pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
              RETURN;
        END IF;
        --Obtenemos la calificacion Evaluada
        nupaso          := 20;
        sbprocesoactual := 'INDUSTRIAL';
        procalificavariacionconsumo(nuperiodo_consumo, nuconsact, sbmarcaprompropio, sbindicalectura, nuconsprom, orcproduct.sesunuse, orcproduct.sesucate, orcproduct.sesusuca, nucalificacion);

        --  procalificavariacionconsumo(Periodo de consumo, Consumo actual, isbmarcaprompropio, isbtienelectura, inuconsumopromedioopen, inuproducto, inucategoria, inusubcategoria, onucalificacion)
        nupaso := 30;

        --Se envia para asignar el consumo y calificacion segun el AVC.
        prReglasAVCIndustriales(sbindicalectura, nucausanolect, nuconsact, nucalificacion, orccurrentreading, orcorder, orcproduct, onuactivity, orcactiverule, orcconsumptionperiod);

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuerror, sberror);
            sberror := csbFEC||csbMetodo|| ' | Paso (' ||
                       nupaso || ')' || 'Detalle: ' || sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            nupaso := 0;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_Error.getError(nuerror, sberror);
            sberror := csbFE||csbMetodo|| ' | Paso (' ||
                       nupaso || ')' || 'Detalle: ' || sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            nupaso := 0;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
    END prAnaLecturaIndustriales;

    PROCEDURE prValidaPromedios
    (
        ionuconsprom        IN OUT FLOAT,
        iosbfunconsprom     IN OUT VARCHAR2,
        iosbmarcaprompropio IN OUT VARCHAR2,
        ionuconssub         IN OUT FLOAT,
        iosbmarcapromsubcat IN OUT VARCHAR2,
        isbfunconssub       IN VARCHAR2
    ) IS
        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.
        Nombre del Paquete: prValidaPromedios
        Descripción:        Valida promedio individual y promedio de subcategoria
        Autor    : Oscar Ospino P.
        Fecha    : 14-06-2017 CA200-1202
        Historia de Modificaciones
        DD-MM-YYYY    <Autor>.              Modificacion
        -----------  -------------------    -------------------------------------
        14-06-2017   Oscar Ospino P.        Creacion
        ***********************************************************************************************/
        --Constantes
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prValidaPromedios';
        --Variables

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('ionuconsprom           <= '||ionuconsprom,csbNivelTraza);
        pkg_traza.trace('iosbfunconsprom        <= '||iosbfunconsprom,csbNivelTraza);
        pkg_traza.trace('iosbmarcaprompropio    <= '||iosbmarcaprompropio,csbNivelTraza);
        pkg_traza.trace('ionuconssub            <= '||ionuconssub,csbNivelTraza);
        pkg_traza.trace('iosbmarcapromsubcat    <= '||iosbmarcapromsubcat,csbNivelTraza);
        pkg_traza.trace('isbfunconssub          <= '||isbfunconssub,csbNivelTraza);

        --Verifica si el promedio de la subcategoria es valido
        IF ionuconssub IS NULL
           OR ionuconssub <= 0 THEN
            ionuconssub         := 0;
            iosbmarcapromsubcat := 'N';
        ELSE
            iosbmarcapromsubcat := 'S';
        END IF;

        --Verifica si el promedio del Producto es valido
        IF ionuconsprom IS NULL
         OR ionuconsprom <= 0 THEN
            ionuconsprom        := 0;
            iosbmarcaprompropio := 'N';
            IF iosbmarcapromsubcat = 'S' THEN
                --Si no hay promedio propio y el Prom. de Subcateg es valido, se asigna
                ionuconsprom    := ionuconssub;
                iosbfunconsprom := isbfunconssub;
            END IF;
        ELSE
            iosbmarcaprompropio := 'S';
        END IF;

        pkg_traza.trace('ionuconsprom          => '||ionuconsprom,csbNivelTraza);
        pkg_traza.trace('iosbfunconsprom       => '||iosbfunconsprom,csbNivelTraza);
        pkg_traza.trace('iosbmarcaprompropio   => '||iosbmarcaprompropio,csbNivelTraza);
        pkg_traza.trace('ionuconssub           => '||ionuconssub,csbNivelTraza);
        pkg_traza.trace('iosbmarcapromsubcat   => '||iosbmarcapromsubcat,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION

        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            raise Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prValidaPromedios;

    FUNCTION prGetRecurrenciaObseNlec(inuConsRegla IN NUMBER) RETURN NUMBER IS
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prGetRecurrenciaObseNlec
        Descripcion    : Funcion que devuelve el numero de recurrecia de observaciones de no lectura
        Autor          : Luis Javier Lopez / Horbath
        Caso           : OSF-654
        Fecha          : 15/11/2022
        Parametros              Descripcion
        ============         ===================
          inuConsRegla         consecutivo de la regla
        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
    ********************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prGetRecurrenciaObseNlec';
        nuRecuObse LDC_RECROBLE.REOBREOB%type := -1;

        CURSOR cugetRecuObse IS
        SELECT nvl(REOBREOB, -1)
        FROM LDC_RECROBLE
        WHERE REOBCODI = inuConsRegla;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuConsRegla <= '||inuConsRegla,csbNivelTraza);

        IF cugetRecuObse%ISOPEN THEN
            CLOSE cugetRecuObse;
        END IF;

        OPEN cugetRecuObse;
        FETCH cugetRecuObse INTO nuRecuObse;
        CLOSE cugetRecuObse;

        pkg_traza.trace('return => '||nuRecuObse,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuRecuObse;

    EXCEPTION
        WHEN OTHERS THEN
            Pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace('return => '||nuRecuObse,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN nuRecuObse;
   END prGetRecurrenciaObseNlec;

   PROCEDURE prGeneraActiviObNlect(inuConsRegla   IN 	NUMBER,
                                   inuCausanolect IN 	NUMBER,
                                   inuProducto    IN 	NUMBER,
                                   isbCritica     IN 	VARCHAR2,
								   idtFechaFin    IN 	DATE,
								   inuperioCons   IN 	NUMBER,
								   inuConsLect    IN  	NUMBER
								   ) IS
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prGeneraActiviObNlect
        Descripcion    : proceso que genera actividad por observcion de no lectura
        Autor          : Luis Javier Lopez / Horbath
        Caso           : OSF-654
        Fecha          : 15/11/2022
        Parametros              Descripcion
        ============         ===================
          inuConsRegla         consecutivo de la regla
        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
        14/05/2024          jcatuche        OSF-1440: Se agrega llamado pkg_xml_soli_vsi.getSolicitudVSI para inicializar xml de VSI
        04/08/2023          jcatuchemvm     OSF-1086: Se ajusta cursor cugetEstaSuspen ya que no esta teniendo en cuenta el producto
                                            Se crea cursor  cuValidaordeAbiertas para validar órdenes pendientes de tipos de trabajo de suspensión
                                            Se crea cursor cuValidaTipoSuspension para validar el tipo de suspensión del producto vs
                                            los tipos de suspensión para excluir.
        21/07/2023          jcatuchemvm     OSF-1366: Actualización llamados os_registerrequestwithxml por api_registerRequestByXml,
                                            or_boorderactivities.createactivity por api_createorder
    ********************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prGeneraActiviObNlect';
        nmordenexito    number;
        nuDireccion     number;
        sbObsNolect     VARCHAR2(4000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_LISTOBSAVALSUSP');
        sbTitrValidar   VARCHAR2(4000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_LISTITROBLEC');
        sbTitrsusp      VARCHAR2(4000) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_LISTITROBLECSUSP');
        sbExiteOrdpend  VARCHAR2(1);
        sbIsSusp        VARCHAR2(1);

       -- Configuración observación de lectura por actividad
        CURSOR cu_activobselect(nmcuoblecodi obselect.oblecodi%TYPE) IS
         SELECT o.oblecodi
               ,o.actividad
               ,o.period_conse
               ,o.dias_gen_ot
               ,o.medio_recepcion
               ,CAUSAL_EXITO
               ,ACTIVIDAD_CRITICA
               ,ESTACORTE
               ,TIPO_SUSPENSION
               ,GEN_RELECTURA
           FROM ldc_obleacti o
          WHERE o.oblecodi = nmcuoblecodi
            AND NVL(CAUSAL_EXITO,'N') = DECODE(isbCritica, 'T', NVL(CAUSAL_EXITO,'N'), isbCritica )
            AND o.REGLOBLE = inuConsRegla;

        -- Consulta existencia de ordenes de la actividad y producto pasado por parametro
        CURSOR cu_validordenes(nmcuactividad NUMBER,nmcuproducto NUMBER,nucuDiasMin NUMBER) IS
         SELECT nvl(SUM(cantidad),0) total
           FROM(
                SELECT COUNT(1) cantidad
                  FROM or_order oo, or_order_activity oa
                 WHERE oa.activity_id     = nmcuactividad
                   AND oa.product_id      = nmcuproducto
                   AND oo.order_status_id NOT IN(8,12)
                   AND oo.order_id        = oa.order_id
                 UNION ALL
                SELECT COUNT(1)
                  FROM or_order oo, or_order_activity oa
                 WHERE oa.activity_id                   = nmcuactividad
                   AND oa.product_id                    = nmcuproducto
                   AND oo.order_status_id               = 8
                   AND (SYSDATE - oo.legalization_date) <= nucuDiasMin
                   AND oo.order_id                      = oa.order_id
                 );

        CURSOR cu_validordenesPend(nmcuactividad NUMBER,nmcuproducto NUMBER) IS
        SELECT COUNT(1) cantidad
        FROM or_order oo, or_order_activity oa
        WHERE oa.activity_id     = nmcuactividad
        AND oa.product_id      = nmcuproducto
        AND oo.order_status_id NOT IN(8,12)
        AND oo.order_id        = oa.order_id;

        CURSOR cu_validordenesLegExito (nmcuactividad NUMBER,nmcuproducto NUMBER,nucuDiasMin NUMBER) IS
        SELECT max(oo.order_id) orden
        FROM or_order oo, or_order_activity oa
        WHERE oa.activity_id                   = nmcuactividad
        AND oa.product_id                    = nmcuproducto
        AND oo.order_status_id               = 8
        AND pkg_bcordenes.fnuobtieneclasecausal(oo.causal_id) = 1
        AND (SYSDATE - oo.legalization_date) <= nucuDiasMin
        AND oo.order_id                      = oa.order_id;

        CURSOR cuEstadoCort IS
        SELECT sesuesco
        FROM servsusc
        WHERE sesunuse = inuProducto;

        CURSOR cuValidaordeAbiertas(inuproducto in number, isbtitr in varchar2) IS
        SELECT 'S'
        FROM or_order o, or_order_activity oa
        WHERE o.order_id = oa.order_id
        and o.task_type_id in
        (
            SELECT to_number(regexp_substr(isbtitr, '[^,]+', 1, LEVEL)) AS estacort FROM dual
            CONNECT BY regexp_substr(isbtitr, '[^,]+', 1, LEVEL) IS NOT NULL
        )
        and oa.product_id = inuproducto
        and o.order_status_id not in (8, 12);


        CURSOR cugetEstaSuspen IS
        SELECT 'S'
        FROM pr_product p, or_order_activity oa
        WHERE p.product_id = inuProducto
        AND p.product_id = oa.product_id
        AND p.product_status_id = 2
        AND oa.ORDER_ACTIVITY_ID = SUSPEN_ORD_ACT_ID
        AND oa.task_type_id in
        (
            SELECT to_number(regexp_substr(sbTitrsusp, '[^,]+', 1, LEVEL)) AS titr FROM dual
            CONNECT BY regexp_substr(sbTitrsusp, '[^,]+', 1, LEVEL) IS NOT NULL
        )
        ;

        CURSOR cuValidaTipoSuspension (isbTipoSuspension IN VARCHAR2) IS
        SELECT
        CASE WHEN INACTIVE_DATE IS NULL THEN existe ELSE 0 END nuexiste,product_status_id,suspension_type_id
        FROM
        (
            SELECT UNIQUE FIRST_VALUE(PRODUCT_ID) OVER (ORDER BY PROD_SUSPENSION_ID DESC) PRODUCT_ID,
            FIRST_VALUE(SUSPENSION_TYPE_ID) OVER (ORDER BY PROD_SUSPENSION_ID DESC) SUSPENSION_TYPE_ID,
            FIRST_VALUE(INACTIVE_DATE) OVER (ORDER BY PROD_SUSPENSION_ID DESC) INACTIVE_DATE,
            FIRST_VALUE(ACTIVE) OVER (ORDER BY PROD_SUSPENSION_ID DESC) ACTIVE,
            (SELECT PRODUCT_STATUS_ID FROM PR_PRODUCT P WHERE P.PRODUCT_ID = S.PRODUCT_ID) PRODUCT_STATUS_ID,
            INSTR(','||isbTipoSuspension||',',','||FIRST_VALUE(SUSPENSION_TYPE_ID) OVER (ORDER BY PROD_SUSPENSION_ID DESC)||',') existe
            FROM PR_PROD_SUSPENSION S
            WHERE product_id  = inuProducto
        )
        ;

        rcValidaTipoSuspension      cuValidaTipoSuspension%ROWTYPE;



        nulectura           NUMBER;
        nuGeneroCrit        NUMBER;
        nugeneraCritica     NUMBER;
        nuactividadgene     NUMBER;
        nuactividadCritica  NUMBER;
        nmvalidaexist       NUMBER(3);
        nuEstadocorte       NUMBER;
        dtFecha             DATE;
        sbRequestXML1       VARCHAR2(32767);
        nuPersonId          ge_person.person_id%TYPE;
        nuPtoAtncn          mo_packages.operating_unit_id%TYPE;
        sbSubscriberId      ge_subscriber.subscriber_id%TYPE;
        sbComment           mo_packages.comment_%TYPE;
        nuContratoId        suscripc.susccodi%TYPE;
        nuActividad         ge_items.items_id%TYPE;
        nuPackageId         mo_packages.package_id%TYPE;
        nuMotiveId          mo_motive.motive_id%TYPE;
        nuOrderIdout        or_order.order_id%TYPE;
        nuOrderActIdout     or_order_activity.order_activity_id%TYPE;
        nmvacantobsper      NUMBER;
        isbordcom           VARCHAR2(1000);
        nuAddressId         NUMBER;
        nuExiste            NUMBER;
        nuExisteObse        NUMBER;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuConsRegla    <= '||inuConsRegla,csbNivelTraza);
        pkg_traza.trace('inuCausanolect  <= '||inuCausanolect,csbNivelTraza);
        pkg_traza.trace('inuProducto     <= '||inuProducto,csbNivelTraza);
        pkg_traza.trace('isbCritica      <= '||isbCritica,csbNivelTraza);
        pkg_traza.trace('idtFechaFin     <= '||to_char(idtFechaFin,csbFormato),csbNivelTraza);
        pkg_traza.trace('inuperioCons    <= '||inuperioCons,csbNivelTraza);
        pkg_traza.trace('inuConsLect     <= '||inuConsLect,csbNivelTraza);

        sbExiteOrdpend := null;
        nuEstadocorte := null;
        IF cuEstadoCort%ISOPEN THEN
            CLOSE cuEstadoCort;
        END IF;

        OPEN cuEstadoCort;
        FETCH cuEstadoCort INTO nuEstadocorte;
        CLOSE cuEstadoCort;

        SELECT COUNT(1) INTO nuExisteObse
        FROM (
            SELECT to_number(regexp_substr(sbObsNolect,
                                                         '[^,]+',
                                                         1,
                               LEVEL)) AS OBSENOLECT
              FROM dual
            CONNECT BY regexp_substr(sbObsNolect, '[^,]+', 1, LEVEL) IS NOT NULL)
        WHERE Inucausanolect = OBSENOLECT;

        IF nuExisteObse > 0 THEN
            IF cuValidaordeAbiertas%ISOPEN THEN
                CLOSE cuValidaordeAbiertas;
            END IF;

            OPEN cuValidaordeAbiertas(inuProducto, sbTitrValidar);
            FETCH cuValidaordeAbiertas INTO sbExiteOrdpend;
            CLOSE cuValidaordeAbiertas;

            IF sbExiteOrdpend = 'S' THEN
                pkg_traza.trace('Producto ya tiene cambio de medidor no creo nueva orden ', csbNivelTraza);
                RETURN;
            END IF;

            OPEN cugetEstaSuspen;
            FETCH cugetEstaSuspen INTO sbIsSusp;
            CLOSE cugetEstaSuspen;

            IF sbIsSusp = 'S' THEN
                pkg_traza.trace('Producto esta suspendido por algun tipo de trabajo configurado en el parametro  LDC_LISTITROBLECSUSP', csbNivelTraza);
                RETURN;
            END IF;
        END IF;

        pkg_traza.trace('nuEstadocorte : '||nuEstadocorte, csbNivelTraza);

        FOR jk IN cu_activobselect(Inucausanolect) LOOP
            IF jk.ESTACORTE IS NOT NULL THEN
                SELECT COUNT(1) INTO nuExiste
                FROM (SELECT to_number(regexp_substr(jk.ESTACORTE,
                                                   '[^,]+',
                                                   1,
                                                   LEVEL)) AS estacort
                      FROM dual
                    CONNECT BY regexp_substr(jk.ESTACORTE, '[^,]+', 1, LEVEL) IS NOT NULL)
                WHERE estacort = nuEstadocorte;

                pkg_traza.trace('Estado de Corte     : '||nuEstadocorte, csbNivelTraza);
                pkg_traza.trace('Estado de CorteEx   : '||jk.ESTACORTE, csbNivelTraza);
                pkg_traza.trace('nuexiste            : '||nuExiste, csbNivelTraza);

                IF  nuExiste > 0 THEN

                    pkg_traza.trace('Termina validación de la observación por estado de corte', csbNivelTraza);
                    EXIT;

                END IF;

            END IF;

            IF jk.TIPO_SUSPENSION IS NOT NULL THEN

                IF cuValidaTipoSuspension%ISOPEN THEN
                    CLOSE cuValidaTipoSuspension;
                END IF;

                rcValidaTipoSuspension := NULL;
                OPEN cuValidaTipoSuspension(jk.TIPO_SUSPENSION);
                FETCH cuValidaTipoSuspension INTO rcValidaTipoSuspension;
                CLOSE cuValidaTipoSuspension;

                pkg_traza.trace('Product_status_id   : '||NVL(rcValidaTipoSuspension.product_status_id,0), csbNivelTraza);
                pkg_traza.trace('Suspension_type_id  : '||NVL(rcValidaTipoSuspension.suspension_type_id,0), csbNivelTraza);
                pkg_traza.trace('Tipo Suspensión Ex  : '||jk.TIPO_SUSPENSION, csbNivelTraza);
                pkg_traza.trace('nuexiste            : '||NVL(rcValidaTipoSuspension.nuexiste,0), csbNivelTraza);

                --Validación de producto suspendido y con registros en pr_prod_suspension
                IF NVL(rcValidaTipoSuspension.product_status_id,0) = 2 THEN

                    IF rcValidaTipoSuspension.nuexiste  > 0 THEN

                        pkg_traza.trace('Termina validación de la observación por tipo de suspensión', csbNivelTraza);
                        EXIT;

                    END IF;

                END IF;

            END IF;

            nugeneraCritica := 0;
            nuactividadCritica := null;
            nuactividadgene := null;
            nmordenexito := null;

            IF cm_boconslogicservice.fsbexistsoncurrreadobs(jk.oblecodi) = 'S' THEN
                nmvacantobsper := (ldc_bssreglasproclecturas.fnucountserialreadobsperiod(jk.oblecodi) + 1);

                pkg_traza.trace('nmvacantobsper :'||nmvacantobsper , csbNivelTraza);
                pkg_traza.trace('jk.period_conse : '||jk.period_conse , csbNivelTraza);

                IF nmvacantobsper >= jk.period_conse THEN

                    pkg_traza.trace('jk.actividad   : '||jk.actividad, csbNivelTraza);
                    pkg_traza.trace('inuProducto   : '||inuProducto, csbNivelTraza);
                    pkg_traza.trace('jk.dias_gen_ot : '||jk.dias_gen_ot, csbNivelTraza);

                    IF jk.CAUSAL_EXITO = 'S' THEN

                        OPEN cu_validordenesPend(jk.actividad, inuProducto);
                        FETCH cu_validordenesPend INTO nmvalidaexist;
                        CLOSE cu_validordenesPend;

                        IF nmvalidaexist = 0 THEN
                            IF cu_validordenesLegExito%ISOPEN THEN
                                CLOSE cu_validordenesLegExito;
                            END IF;

                            OPEN cu_validordenesLegExito(jk.actividad,inuProducto,jk.dias_gen_ot);
                            FETCH cu_validordenesLegExito INTO nmordenexito;
                            CLOSE cu_validordenesLegExito;

                            IF nvl(nmordenexito,0) > 0 THEN
                                nulectura := 0;

                                IF cuGetLectura%ISOPEN THEN
                                    CLOSE cuGetLectura;
                                END IF;

                                OPEN cuGetLectura(nmordenexito);
                                FETCH cuGetLectura INTO nulectura;

                                IF cuGetLectura%NOTFOUND THEN
                                    nulectura := 0;
                                END IF;

                                CLOSE cuGetLectura;

                                IF nulectura > 0 THEN
                                    nugeneraCritica := 1;
                                    nuactividadCritica :=  jk.ACTIVIDAD_CRITICA;
                                END IF;
                            END IF;
                        END IF;
                    ELSE
                        OPEN cu_validordenes(jk.actividad,inuProducto,jk.dias_gen_ot);
                        FETCH cu_validordenes INTO nmvalidaexist;
                        CLOSE cu_validordenes;
                    END IF;

                    nmvalidaexist := nvl(nmvalidaexist,0);

                    pkg_traza.trace('72.8. nmvalidaexist : '||to_char(nmvalidaexist), csbNivelTraza);

                    IF nmvalidaexist = 0 THEN
                        isbordcom := 'Orden creada por proceso automatico de reglas de facturacion. '||to_char(Inucausanolect)||' - '||daobselect.fsbgetobledesc(Inucausanolect)||'. Se solicita verificacion del estado del CM, Gasodomesticos y lecturas.';

                        pkg_traza.trace('72.9. isbordcom : '||isbordcom, csbNivelTraza);

                        nucontratoid   := pkg_bcproducto.fnucontrato(inuProducto);
                        pkg_traza.trace('72.10. nucontratoid : '||nucontratoid, csbNivelTraza);
                        sbsubscriberid := pkg_bccontrato.fnuidcliente(nuContratoId);
                        nuDireccion    := pkg_bcproducto.fnuiddireccinstalacion(inuProducto);

                        pkg_traza.trace('72.10. nuDireccion : '||nuDireccion, csbNivelTraza);
                        pkg_traza.trace('72.11. sbsubscriberid : '||sbsubscriberid, csbNivelTraza);
                        pkg_traza.trace('72.12. jk.medio_recepcion : '||jk.medio_recepcion, csbNivelTraza);

                        IF nvl(jk.medio_recepcion,-1) = -1  THEN

                            pkg_traza.trace('72.13. api_createorder', csbNivelTraza);

                            IF nugeneraCritica = 1 THEN
                                IF nuactividadCritica IS NOT NULL THEN
                                    nuactividadgene := nuactividadCritica;
                                    prgeneracritica(nuactividadgene, isbordcom, inuProducto, idtFechaFin, inuperioCons, inuConsLect);
                                END IF;
                            ELSE
                                nuactividadgene := jk.actividad;
                                IF nuactividadgene IS NOT NULL THEN

                                    Pkg_Error.prInicializaError(nuerror, sberror);

                                    api_createorder
                                    (
                                        inuitemsid          => nuactividadgene,
                                        inupackageid        => NULL,
                                        inumotiveid         => NULL,
                                        inucomponentid      => NULL,
                                        inuinstanceid       => NULL,
                                        inuaddressid        => nuDireccion,
                                        inuelementid        => NULL,
                                        inusubscriberid     => sbsubscriberid,
                                        inusubscriptionid   => nucontratoid,
                                        inuproductid        => inuProducto,
                                        inuoperunitid       => NULL,
                                        idtexecestimdate    => NULL,
                                        inuprocessid        => NULL,
                                        isbcomment          => isbordcom,
                                        iblprocessorder     => NULL,
                                        inupriorityid       => NULL,
                                        inuordertemplateid  => NULL,
                                        isbcompensate       => NULL,
                                        inuconsecutive      => NULL,
                                        inurouteid          => NULL,
                                        inurouteconsecutive => NULL,
                                        inulegalizetrytimes => 0,
                                        isbtagname          => NULL,
                                        iblisacttogroup     => NULL,
                                        inurefvalue         => NULL,
                                        inuactionid         => NULL,
                                        ionuorderid         => nuOrderIdout,
                                        ionuorderactivityid => nuOrderActIdout,
                                        onuErrorCode        => nuerror,
                                        osbErrorMessage     => sberror
                                    );

                                    IF nuerror != constants_per.OK THEN
                                        raise Pkg_Error.CONTROLLED_ERROR;
                                    end if;
                                END IF;
                            END IF;

                            pkg_traza.trace('72.14. nuOrderIdout : '||nuOrderIdout||' nuOrderActIdout : '||nuOrderActIdout, csbNivelTraza);

                        ELSIF nvl(jk.medio_recepcion,-1) <> -1  THEN
                            dtFecha        := SYSDATE;

                            pkg_traza.trace('72.16. dtFecha : '||dtFecha, csbNivelTraza);

                            nupersonid     := pkg_bopersonal.fnugetpersonaid;

                            pkg_traza.trace('72.17. nupersonid : '||nupersonid, csbNivelTraza);

                            nuPtoAtncn     := pkg_bopersonal.fnugetpuntoatencionid(nupersonid);

                            pkg_traza.trace('72.18. nuPtoAtncn : '||nuPtoAtncn, csbNivelTraza);

                            nuAddressId    := pkg_bcproducto.fnuiddireccinstalacion(inuProducto);

                            pkg_traza.trace('72.19. nuAddressId : '||nuAddressId, csbNivelTraza);

                            sbrequestxml1  := NULL;
                            pkg_traza.trace('72.20. sbrequestxml1 ', csbNivelTraza);

                            sbRequestXML1  := pkg_xml_soli_vsi.getSolicitudVSI
                            (
                                nucontratoid,
                                jk.medio_recepcion,
                                isbordcom,
                                inuProducto,
                                sbsubscriberid,
                                nupersonid,
                                nuPtoAtncn,
                                dtFecha,
                                nuAddressId,
                                nuAddressId,
                                jk.actividad
                            );

                            nupackageid    := NULL;
                            numotiveid     := NULL;

                            Pkg_Error.prInicializaError(nuerror, sberror);

                            api_registerRequestByXml
                            (
                                sbrequestxml1
                                ,nupackageid
                                ,numotiveid
                                ,nuerror
                                ,sberror
                            );

                            pkg_traza.trace('72.21 nupackageid : '||nupackageid||' numotiveid : '||numotiveid||' sberror : '||sberror, csbNivelTraza);
                            pkg_traza.trace('72.22  numotiveid : '||numotiveid||' sberror : '||sberror, csbNivelTraza);

                            IF nuerror <> constants_per.OK then
                                ROLLBACK;
                                RAISE Pkg_Error.CONTROLLED_ERROR;
                            END IF;
                        END IF;
                    END IF;
                END IF;
            END IF;

            --Generación de Relectura según configuración flag GEN_RELECTURA
            pkg_traza.trace('Configuración Relectura para la Observación de No Lectura : ['||NVL(jk.GEN_RELECTURA,'N')||']', csbNivelTraza);
            IF NVL(jk.GEN_RELECTURA,'N') = 'S' THEN

                pkg_traza.trace('Genera orden de Relectura', csbNivelTraza);
                cm_boconslogicservice.generaterereadingorder();
                nuExisteOrd := 1;

            END IF;

        END LOOP;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prGeneraActiviObNlect;

	FUNCTION fsbestcortnopermit(nusesuesco pr_product.product_status_id%TYPE)
            RETURN BOOLEAN IS

            CURSOR cuestadostecsusp IS
                SELECT regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('ESTAD_SUSP_PRODUCT'),'[^,]+',1,LEVEL) AS column_value
                FROM dual
                CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('ESTAD_SUSP_PRODUCT'),'[^,]+',1,LEVEL) IS NOT NULL;

            nufound NUMBER(1) := 0;

        BEGIN
            FOR i IN cuestadostecsusp
            LOOP
                IF nusesuesco NOT IN (i.column_value) THEN
                    nufound := 1;
                ELSE
                    nufound := 2;
                    EXIT;
                END IF;
            END LOOP;

            IF nufound = 1 THEN
                RETURN TRUE; --  SI ES DIFERENTE DE SUSPENDIDO
            ELSE
                RETURN FALSE; -- NO ES DIFERENTE DE SUSPENDIDO
            END IF;

        END;
    PROCEDURE pranalecturanormal
    (
        nucausanolect IN NUMBER,
        sbindicalect  IN VARCHAR2
    ) IS
   /**************************************************************************************************************************************************************************************************
        Propiedad intelectual de PETI (c).
        Unidad         : PrAnaLecturaNormal
        Descripcion    : Procedimiento para procesar lecturas cargadas en el proceso inicial (lectura normal)
        Autor          : Jhon Jairo Soto
        Fecha          : 28/01/2013
        Parametros              Descripcion
        ============         ===================
        Fecha           Autor               Modificacion
        =========       =========           ====================
        20140527        jsoto               Se realizan cambios para el manejo de situaciones de instalacion de medidor
                                            de forma tardia. (ordenes de venta)
                                            Se asignara consumo promedio cuando el producto tenga actividades de cambio de
                                            medidor pendientes de legalizacion.
                                            Si hay legalizacion de instalacion tardia el consumo actual sera prorrateado
                                            a la cantidad de dias del periodo de consumo para efectos de validaciones y
                                            comparaciones dentro de la regla.
        20140901        jsoto               Se realizan adecuaciones RQ  team  2017 Se suprimen condiciones donde se realizaba
                                            el llamado al programa CM_BOCALCCONSUMPSERVS.READDIFANDCORRECTFACTOR con parametro de
                                            cero meses de recuperacion ya que el producto de OPEN incluyo funcionalidad en FOVC FAMC
                                            para manejo de consumos recuperados en lectura y/o relectura.
                                            Se suprime el llamado a CM_BOConsLogicService.CleanEngMemBySource porque ya no es necesario
                                            recalcular el consumo con cero o seis meses de recuperacion.
                                            Se crean los parametros CANT_MESES_RECUPERAR_CONSUMO = 6 para usar en el calculo de consumo
                                            y GEN_RELECTURA_DESV_DEBAJO para definir si se desea (S)  no (N) enviar a relectura los consumos
                                            calificados como desviados por debajo (4)
        04-12-2015      Pedro Castro        PJC DESARROLLO: Se configuran nuevas reglas con base a las nuevas calificaciones de lectura
        07-07-2016      Oscar Ospino P.     CA 200-389 | Modificacion Proceso PrAnaLecturaNormal
                                            Se agregan validaciones adicionales sobre reglas de Lectura 2001,2002,2013
                                            NuRegla1: validación del Estado de Corte y el Estado Financiero del producto
                                                (nuEstCorte<>5-Suspension Total, sbEstaFina<>C-Castigado)
                                            NuRegla2 y NuRegla3:
                                                      validación del Consumo anterior, Estado de Corte y Estado Financiero del
                                                      producto
                                                      (nuCons1=0-Consumo Periodo Anterior Cero,
                                                      nuEstCorte<>5-Suspension Total,
                                                      sbEstaFina<>C-Castigado)
                                            Nota: Se crea la variable MSGLOG para monitorear el proceso usando la tabla LDC_OSF_ESTAPROC
        26-08-2016     Sandra Muñoz         CA-200-639. Se calcula la calificación sin usar la función de open,
                                            posteriormente se corrige el consumo actual enviado como parámetro usando
                                            el calculado por open, ya que allá se contempla el caso donde la lectura actual
                                            o anterior está vacía
        06-10-2016     Sandra Muñoz         CA 200-639. Se toman los cambios del requerimiento 200-389 para
                                            unificarlo con el 200-639.
                                            Se hace uso de la función fnuCantOTPereiodoAnt
        25-11-2016     Sandra Muñoz         CA 200-639. Valida si se crea consumo, sino debe impedirse la legalización
        17-01-2017     Oscar Ospino P.      CA 200-1063 Correcion de Inconsistencias con Promedios Individuales y de Subcategoria, Calificacion Usuarios Nuevos
                                            Se modifican Reglas 2028, 2002, 2003 y proceo ProCalificaVariacionConsumo.
                                            Se Adicionan Reglas 2031
        25-01-2019      ELAL                Se quita genracion detipo de trabajo de suspension 10346 y se adiciona creacion de actividad
                                            10043  de relectura
        25-02-2019      ELAL                CA 200-2416 se modifica regla 2001 para validar estado del producto y que no exista orden
                                            1260 al momento d egenerar otra
        26-07-2019      Horbath             CA 38 se modifica regla 2002
        24-03-2020      F.Castro            CA 373 Se implementa logica para nueva regla de lectura 34 (Contingencia
                                            Fuerza Mayor)
        22-12-2020      OL-Software         CA 222 Se adiciona la logica para que se valide los promedios de consumo
                                            cuando hubo cambio de medidor para la generacion de critica.
		23-08-2021      Horbath             CA 827 se modifica regla 2004, para generar  una orden 10043 ??? Toma de relectura si la observación de lectura es igual a No se encuentra predio
											y si no se crea una orden de este mismo tipo
        21-02-2022      hahenao.HORBATH     CA875
                                            *Se adiciona validacion de existencia de ordenes de CM pendientes para generar la critica
        10-05-2022      John Jairo Jimenez  OSF-72
                                            Se adiciona logica para que se generen las ordenes o solicituda por observacion de lectura
                                            de acuerdo a configuración y validación de la tabla : LDC_OBLEACTI
        19-05-2022      John Jairo Jimenez  OSF-72
                                            Se valida para que la solicitud VSI no se genere para usuarios castigados.
        11/08/2022      LJLB                OSF-489: se realiza proceso de generacion de actividades teniendo en cuenta la configuracion
                                            de la forma LDCACGEOL
        16/11/2022      LJLB                OSF-654: se realiza proceso para generar actividades por reglas y observacion
        21-07-2023      jcatuchemvm         OSF-1366: Se valida si hubo cambio de medidor y existe consumo promedio por subcategoria, para enviarlo como
                                            consumo promedio open en el llamado a procalificavariacionconsumo.
                                            Se inicializa variable globarl nuorden con el numero de la orden que se gestiona.
                                            Se elimina definición de variable sbmarcapromsubcat ya que esta pasa a ser una variable global.
                                            Se elimina definición de función privada fnuultconsprom ya que se define de forma general en el paquete
                                            Por cambio de alcance, el promedio por subcategoria enviado es el no proyectado en días de consumo. Ref Monica Olivella
                                            Se elimina condición de validación consumo actual vs consumo existente en el periodo para poderlo sumar. Ahora se suma todo
                                            el consumo del periodo sin validaciones. Ref Monica Olivella corrección OSF-1039
        04/08/2023      jcatuchemvm         OSF-1086: Se cambia llamado a cursor cuValidaordeAbiertas por cuValidaOrdenAbiertasCM
                                            Se agrega llamado fnuObtieneConsumosPrevios para consulta alterna de históricos de consumos, el cual
                                            no tiene en cuenta los consumos pendientes por liquidar, entre ellos los recuperados. Se conserva el llamado
                                            original de open cm_boestimateservices.getnthprevconsumption, el cual internamente hace validaciones adicionales.
                                            Se ajustan las reglas 2006, 2007, 2008 eliminando la validación de órdenes de cambio de medidor pendientes para la entrada a la regla.
                                            Para las reglas 2007 y 2008 se adiciona logica para creación de orden de crítica si existe orden de cambio  de medidor pendiente.
		15/05/2024       LJLB               OSF-2494: se coloca logica para Resolucion CREG 105 007 de 2024.
		24/07/2024      jcatuche            OSF-3009: Se elimina definición de variable nuperiodo_consumo ya que esta pasa a ser una variable global.   
                                            Se elimina definición de variable nuconssubnoproy ya que esta pasa a ser una variable global.
                                            Se elimina definición de variable sbfunconsprom ya que esta pasa a ser una variable global.
                                            Se elimina definición de variable sbfunconssub ya que esta pasa a ser una variable global.
                                            Se elimina lógica del caso OSF-1366, el procedimiento prCalificaConsumoDesvPobl ya integra este ajuste
                                            Se elimina validación de promedios y se centraliza mediante prValidaPromedios                                           
                                            Se agrega traza de finalizacion de ejecucion del procedimiento antes del return por estandarización
        20/09/2024      jcatuche            OSF-3181: Se agrega lógica para la regla 3017, llamado a prConsDifLectAntFactCorr para generar consumo sugerido
                                            Se elimina definición de variable local nuanacrit, se agrega inicialización de variable global dtfechafincons y nuconsecutivolect
   **************************************************************************************************************************************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'pranalecturanormal';
        nuconsant            NUMBER := 0;
        sbfunconsant         VARCHAR2(100);
        numetconsant         mecacons.mecccodi%TYPE;
        nuconsact            NUMBER := 0;
        sbfunconsact         VARCHAR2(100);
        numetconsact         mecacons.mecccodi%TYPE;
        nuconsprom           NUMBER := 0;
        numetconsprom        mecacons.mecccodi%TYPE;
        nuconssub            NUMBER := 0;
        numetconssub         mecacons.mecccodi%TYPE;
        sbfunman             VARCHAR2(100);
        numetman             mecacons.mecccodi%TYPE;
        nuobsmedret          obselect.oblecodi%TYPE;
        nuobsmedret2         obselect.oblecodi%TYPE;
        nuobsdemol           obselect.oblecodi%TYPE;
        nuobsnoinst          obselect.oblecodi%TYPE;
        nutrabdesv           or_task_type.task_type_id%TYPE;
        nutrabrelectura      or_task_type.task_type_id%TYPE;
        nudiasusnuevo        NUMBER;
        numtsmax             NUMBER;
        numtsmaxreg13        NUMBER;
        nucalifica           VARCHAR2(100);
        nuprioridad          VARCHAR2(100);
        inudiscovertype      NUMBER;
        inuvalue             NUMBER;
        inuinformer          NUMBER;
        isbcomment           VARCHAR2(100);
        nucategori           categori.catecodi%TYPE;
        nusubcategori        subcateg.sucacodi%TYPE;
        isbordercomment      VARCHAR2(200);
        nuestcorte           servsusc.sesuesco%TYPE;
        nuestprod            pr_product.product_status_id%TYPE;
        nucons1              NUMBER := 0;
        nucons2              NUMBER := 0;
        nucons3              NUMBER := 0;
        sbfuncons1           VARCHAR2(100);
        numetcons1           mecacons.mecccodi%TYPE;
        sbfuncons2           VARCHAR2(100);
        numetcons2           mecacons.mecccodi%TYPE;
        sbfuncons3           VARCHAR2(100);
        numetcons3           mecacons.mecccodi%TYPE;
        sbestafina           servsusc.sesuesfn%TYPE;
        num_producto         servsusc.sesunuse%TYPE;
        nucampresion         NUMBER := 0;
        orccurrentreading    lectelme%ROWTYPE; -- Lectura que se está procesando
        orcorder             daor_order.styor_order; -- Orden que se legaliza
        orcproduct           servsusc%ROWTYPE; -- Producto que se está procesando
        onuactivity          remevaco.rmvcacti%TYPE; --Escenario / Actividad
        orcactiverule        remevaco%ROWTYPE; -- Regla que se está ejecutando
        orcconsumptionperiod pericose%ROWTYPE; -- Período de Consumo
        numoticate           NUMBER;
        sbcausafuga          VARCHAR2(2);
        sbgenrelconscero     VARCHAR2(2);
        nuprimlect           NUMBER := 0;
        nucontpres           NUMBER := 0;
        nuvalpres1           NUMBER;
        nuvalpres2           NUMBER;
        nuaddressid          pr_product.address_id%TYPE;
        nugeographid         ab_address.neighborthood_id%TYPE;
        nulocalidad          ge_geogra_location.geo_loca_father_id%TYPE;
        sbordenpend          VARCHAR2(2);
        sblegtardia          VARCHAR2(2);
        nucantmesesrec       NUMBER;
        sbgenrelecdebajo     VARCHAR2(2);
        nuestproduct         NUMBER;
        nuporcpromind        NUMBER(10, 2);
        
        --Inicio CA 200-389
        nucuentaobsmedret NUMBER;
        nucuentaobsdemol  NUMBER;
        nucuentaobsnoinst NUMBER;
        --Fin CA 200-389

         CURSOR cu_validordenesVisita (nuProducto IN NUMBER, nuActividad IN NUMBER) IS
        SELECT max(oo.order_id) orden
         FROM or_order oo, or_order_activity oa
        WHERE oa.activity_id                   = nuActividad
          AND oa.product_id                    = nuProducto
          AND oo.order_status_id               = 8
          AND pkg_bcordenes.fnuobtieneclasecausal(oo.causal_id) = 1
          AND oo.legalization_date BETWEEN sysdate - 30 AND sysdate
          AND oo.order_id  = oa.order_id;

        --<Inicio CA 200-1202>--

        sbmarcaRecuperado  VARCHAR2(1) := 'N'; --Flag que indica si se ha recuperado el consumo en la variable nuvolrecupproy
        nuvolrecupproy     conssesu.cosscoca%TYPE := 0; --Volumen Recuperado Proyectado en el Periodo Actual
        nuconsFactActual   conssesu.cosscoca%TYPE; --Consumo por metodo 4-Facturado Periodo Actual
        nuconsFact1        conssesu.cosscoca%TYPE; --Consumo por metodo 4-Facturado Periodo anterior
        nuconsFact2        conssesu.cosscoca%TYPE;
        nuconsFact3        conssesu.cosscoca%TYPE;
        nuconsFact4        conssesu.cosscoca%TYPE;
        nuconsFact5        conssesu.cosscoca%TYPE;
        nuconsFact6        conssesu.cosscoca%TYPE; --Consumo por metodo 4-Facturado Periodo mas antiguo
        nuPeriodosRecup    NUMBER := 0; --Almacena el numero de Periodos Recuperado
        --<Fin CA 200-1202>--

		nuValor           NUMBER := 1; --se alamcena valor a retornar
		nuObsNoEncPredio  NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_NO_ENC_PREDIO'); --caso: 827
		nuActTomaRelec    NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('COD_ACT_TOMA_RELECT');

        --CA 875
        sbPend            VARCHAR2(1);
        nuProductId       pr_product.product_id%type;

        CURSOR cucm_vavafaco(nuproducto IN servsusc.sesunuse%TYPE) IS
            SELECT *
            FROM cm_vavafaco
            WHERE vvfcsesu = nuproducto
                  AND vvfcvafc = 'PRESION_OPERACION'
            ORDER BY vvfcfeiv DESC;
        reg_cm_vavafaco cucm_vavafaco%ROWTYPE;
        /* PJC DESARROLLO */
        nucantot NUMBER;

        CURSOR cuexisteordengenerada
        (
            inuproducto   servsusc.sesunuse%TYPE, -- PRODUCTO
            nutipotrabajo or_task_type.task_type_id%TYPE, -- TIPO DE TRABAJO
            nuitem        or_order_items.items_id%TYPE
        ) -- ACTIVIDAD
        IS
            SELECT COUNT(1)
            FROM or_order oo, or_order_activity ooa
            WHERE oo.task_type_id = nutipotrabajo
                  AND EXISTS (SELECT 1
                   FROM or_order_items ooi
                   WHERE ooi.order_id = oo.order_id
                         AND ooi.items_id = nuitem)
                  AND ooa.order_id = oo.order_id
                  AND oo.order_status_id IN (0, 1, 5, 6)
                  AND ooa.product_id = inuproducto;

        CURSOR cunuevacalificacion IS
            SELECT consecutivo, codigo_calificacion
            FROM ldc_calificacion_cons
            WHERE activo = 'Y'
                  AND proceso = 'L'
            ORDER BY prioridad ASC;

        nuvecesobslect NUMBER;
        nuhistvalida   NUMBER := 0;
        nucons4        NUMBER;
        nucons5        NUMBER;
        nucons6        NUMBER;
        sbfuncons4     VARCHAR2(100);
        numetcons4     mecacons.mecccodi%TYPE;
        sbfuncons5     VARCHAR2(100);
        numetcons5     mecacons.mecccodi%TYPE;
        sbfuncons6     VARCHAR2(100);
        numetcons6     mecacons.mecccodi%TYPE;
        nuvalconsumo   NUMBER(8);
        nuvalconsumo2  NUMBER(8);
        nuoblefuerazmayor ld_parameter.numeric_value%TYPE; --CA373
        isbordcom      VARCHAR2(1000);
        nuprimescero   NUMBER(2);
        nusegmescero   NUMBER(2);
        nutermescero   NUMBER(2);
        nuregla1       NUMBER(2);
        nuregla2       NUMBER(2);
        nuregla3       NUMBER(2);
        nuregla4       NUMBER(2);
        nuregla5       NUMBER(2);
        nuregla6       NUMBER(2);
        nuregla7       NUMBER(2);
        nuregla8       NUMBER(2);
        nuregla9       NUMBER(2);
        nuregla10      NUMBER(2);
        nuregla11      NUMBER(2);
        nuregla12      NUMBER(2);
        nuregla20      NUMBER(2);
        nuregla22      NUMBER(2);
        nuregla25      NUMBER(2);
        nuconsFactTotal  number := 0;
        nuregla28      ld_parameter.numeric_value%TYPE;
        nuregla29      ld_parameter.numeric_value%TYPE;
        nuregla30      ld_parameter.numeric_value%TYPE;
        nuregla31      ld_parameter.numeric_value%TYPE;
        nuregla34      ld_parameter.numeric_value%TYPE;

        -- Inicio CA 200-389
        nuparttrevisionconsumo     ld_parameter.numeric_value%TYPE := pkg_bcld_parameter.fnuobtienevalornumerico('TITR_REVIS_TEC_REVIS_CONSUMO');
        nuparcantperrevision       ld_parameter.numeric_value%TYPE;
        sbparestadosordenesrevcons ld_parameter.numeric_value%TYPE;
        nuparreglasubsinconsprom   ld_parameter.numeric_value%TYPE;
        -- Fin CA 200-389

        nupaso VARCHAR2(32000);
        nulectura number;
        nuactivitytypeid ge_items.items_id%TYPE;
        csbEntrega2002386 CONSTANT VARCHAR2(30) := 'BSS_FACT_ELAL_2002386_1'; --TICKET 200-2386 ELAL --se almacena nombre de la entrega
        nuActividadRelec   NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_ACTITOMRELE');--TICKET 200-2386 ELAL -- se almacena codigo de actividad de relectura
        sbcategoriaAGenAc   VARCHAR2(30) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CATEGERELE');--TICKET 200-2386 ELAL -- se almacena codigo de categoria a generar actividad de relectura
        sbdato  VARCHAR2(1); --TICKET 200-2386 ELAL --se alamcena si exise o no la categoria
        dtFechaEjecucionOrden       OR_order.execution_final_date%type;
        nmordenexito    NUMBER;
        nuExiste 		NUMBER;

        --TICKET 200-2386 ELAL -- se cosnulta si la categoria esta configurada para generar relectura
        CURSOR cuValidacatego IS
         SELECT 'X'
         FROM (SELECT regexp_substr(sbcategoriaAGenAc,'[^,]+',1,LEVEL) AS cate
                FROM dual
                CONNECT BY regexp_substr(sbcategoriaAGenAc,'[^,]+',1,LEVEL) IS NOT NULL)
          WHERE cate = orcproduct.SESUCATE AND sbestafina <> 'C';

        nuValiOrde   NUMBER:= 0;--TICKET 200-2416 ELAL-- se almacena valor de validacion de orden de visita
        nuPeriFactAnt NUMBER;

        --INICIO OSF-654
        nuRecurrObse NUMBER;
           --FIN OSF-654
		onuCumpleRegla  NUMBER := 0;
        blProdDesviado  BOOLEAN := FALSE;
        sbRowId         VARCHAR2(4000);


        FUNCTION fsbverifotrevis0 RETURN BOOLEAN IS

            nuproducto servsusc.sesunuse%TYPE;
            nudato     NUMBER := 0;
            nufound    NUMBER(1) := 0;

            CURSOR cuotrevcerocreated IS
                SELECT COUNT(1)
                FROM or_order_activity oa, or_order o
                WHERE o.task_type_id = 12688
                      AND o.order_status_id IN (0, 5)
                      AND o.order_id = oa.order_id
                      AND oa.product_id = nuproducto;

        BEGIN

            nuproducto := orcproduct.sesunuse;
            OPEN cuotrevcerocreated;

            FETCH cuotrevcerocreated
                INTO nudato;
            IF nudato > 0 THEN
                nufound := 1;
            ELSE
                nufound := 2;
            END IF;

            CLOSE cuotrevcerocreated;

            IF nufound = 1 THEN
                RETURN TRUE;
            ELSE
                RETURN FALSE;
            END IF;

        END;

    BEGIN

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('nuCausaNoLect   <= ' || nucausanolect, csbNivelTraza);
        pkg_traza.trace('sbIndicaLect    <= ' || sbindicalect, csbNivelTraza);

        --Inicialización de variables
        sbmarcaCambMedidor := 'N';
        nuExisteOrd := 0;
        nuconssubnoproy := 0;
        sbfunconsprom := null;
        sbfunconssub := null;
        nuperiodo_consumo := null;
        dtfechafincons := null;
        nuconsecutivolect := null;
        nuConsPendLiqu := null;


        /*pkg_traza.trace('--<'||'Estado del Producto >--' ||
                       nuestprod, csbNivelTraza);
        pkg_traza.trace('--<'||'Estado de Corte >--' ||
                       nuestcorte, csbNivelTraza);*/
        nupaso := ' | * PrAnaLecturaNormal * | ';

        -- Obtenemos los parametros
        nuobsmedret := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_MEDIDOR_RETIRADO');
        pkg_traza.trace('nuobsmedret -->' || nuobsmedret, csbNivelTraza);

        nuobsmedret2 := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_MEDIDOR_RETIRADO2');
        pkg_traza.trace('nuobsmedret2 -->' || nuobsmedret2, csbNivelTraza);

        nuobsdemol := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_DEMOLIDA');
        pkg_traza.trace('nuobsdemol -->' || nuobsdemol, csbNivelTraza);

        nuobsnoinst := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBS_SIN_INSTALACION');
        pkg_traza.trace('nuobsnoinst -->' || nuobsnoinst, csbNivelTraza);

        nutrabdesv := pkg_bcld_parameter.fnuobtienevalornumerico('COD_TRAB_DESVIACION');
        pkg_traza.trace('nutrabdesv -->' || nutrabdesv, csbNivelTraza);

        nutrabrelectura := pkg_bcld_parameter.fnuobtienevalornumerico('COD_TRAB_RELECTURA');
        pkg_traza.trace('nutrabrelectura -->' ||
                       nutrabrelectura, csbNivelTraza);

        nudiasusnuevo := pkg_bcld_parameter.fnuobtienevalornumerico('DIAS_USUARIO_NUEVO');
        pkg_traza.trace('nudiasusnuevo -->' || nudiasusnuevo, csbNivelTraza);

        isbordercomment  := 'ORDEN DE RELECTURA GENERADA POR PROCESO DE ANALISIS DE VARIACION';
        numoticate       := pkg_bcld_parameter.fnuobtienevalornumerico('MOTIVO_CAMBIO_CATEGO');
        sbgenrelconscero := pkg_bcld_parameter.fsbobtienevalorcadena('GEN_RELECTURA_CONS_CERO');
        pkg_traza.trace('sbGenRelConsCero -->' ||
                       sbgenrelconscero, csbNivelTraza);

        nucantmesesrec   := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_MESES_RECUPERAR_CONSUMO');
        sbgenrelecdebajo := pkg_bcld_parameter.fsbobtienevalorcadena('GEN_RELECTURA_DESV_DEBAJO');
        pkg_traza.trace('sbGenRelecdebajo -->' ||
                       sbgenrelecdebajo, csbNivelTraza);

        nuvecesobslect := pkg_bcld_parameter.fnuobtienevalornumerico('NRO_VECES_OBS_LECTURA'); -- PJC DESARROLLO
        pkg_traza.trace('nuVeceSObsLect -->' ||
                       nuvecesobslect, csbNivelTraza);

        nuporcpromind      := pkg_bcld_parameter.fnuobtienevalornumerico('PORCENT_PROM_INDIVID');
        nuoblefuerazmayor  := pkg_bcld_parameter.fnuobtienevalornumerico('LDC_OBSELEMA'); -- CA373

        -- PJC DESARROLLO Se cargan los 12 parametros asociados a cada regla de lectura configurada en LDC_CALIFICACION_CONS
        nuregla1  := pkg_bcld_parameter.fnuobtienevalornumerico('NOLECT_FALTA_MED_REITERAD');
        nuregla2  := pkg_bcld_parameter.fnuobtienevalornumerico('NOLECT_FALTA_MED');
        nuregla3  := pkg_bcld_parameter.fnuobtienevalornumerico('NOLECT_CON_MED_REITERAD');
        nuregla4  := pkg_bcld_parameter.fnuobtienevalornumerico('NOLECT_CON_MED');
        nuregla5  := pkg_bcld_parameter.fnuobtienevalornumerico('LECTRANGO_ANORM_CON_ACTPEND');
        nuregla6  := pkg_bcld_parameter.fnuobtienevalornumerico('LECTRANGO_ANORM_SIN_ACTPEND');
        nuregla7  := pkg_bcld_parameter.fnuobtienevalornumerico('LECTRANGO_ANORM_CONCERO6MES');
        nuregla8  := pkg_bcld_parameter.fnuobtienevalornumerico('LECTRAN_ANORM_SIN_ACTPEND3VEZ');
        nuregla9  := pkg_bcld_parameter.fnuobtienevalornumerico('LECT_RANGOANOR_MAS3CONSCERO');
        nuregla10 := pkg_bcld_parameter.fnuobtienevalornumerico('LECT_RANGOANOR_CONSNOCERO');
        nuregla11 := pkg_bcld_parameter.fnuobtienevalornumerico('LECT_PRODSUSP_CONSCERO');
        nuregla12 := pkg_bcld_parameter.fnuobtienevalornumerico('LECT_PRODSUSP_SINCERO');
        nuregla20 := pkg_bcld_parameter.fnuobtienevalornumerico('LECT_RANGOUNO');
        nuregla22 := pkg_bcld_parameter.fnuobtienevalornumerico('LEC_USU_RESIDENC');
        nuregla25 := pkg_bcld_parameter.fnuobtienevalornumerico('LECT_NINGUNA_REGLA');
        nuregla34 := pkg_bcld_parameter.fnuobtienevalornumerico('CONTINGENCIA_FUERZA_MAYOR');

        -- Regla 28: No tiene consumo propio y la localidad no tiene consumo promedio o no se puede
        -- obtener de allá
        nuregla28 := fnuobtieneregla(isbnombreregla => 'NOLECT_NO_PROMPROP_NO_PROMLOC');
        pkg_traza.trace('nuregla28 ' || nuregla28, csbNivelTraza);

        -- Regla 29: Tiene lectura y consumo promedio propio negativo
        nuregla29 := fnuobtieneregla(isbnombreregla => 'LECT_PROMPROP_NEGATIVO');
        pkg_traza.trace('nuregla29 ' || nuregla29, csbNivelTraza);

        -- Regla 30: No tiene lectura y tiene consumo promedio propio negativo
        nuregla30 := fnuobtieneregla(isbnombreregla => 'NOLECT_PROMPROP_NEGATIVO');
        pkg_traza.trace('nuregla30 ' || nuregla30, csbNivelTraza);

        --< CA 200-1063 >--
        sbprocesoactual := 'LECTURA'; -->> Para Proceso ProCalificaVariacionConsumo
        -- Regla 31: Productos con Lectura pero sin Historia Valida (Nuevos)
        nuregla31 := fnuobtieneregla(isbnombreregla => 'LECT_PROD_NVO_CONS_NORMAL');
        pkg_traza.trace('nuregla31 ' || nuregla31, csbNivelTraza);

        --< Fin CA 200-1063 >--
        nuestproduct := pkg_bcld_parameter.fnuobtienevalornumerico('ESTAD_SUSP_PRODUCTO');
        cm_boconslogicservice.getproductservicesatus(nuestcorte, nuestprod);
        pkg_traza.trace('ICM_BOCONSLOGICSERVICE.GETPRODUCTSERVICESATUS -->' ||
                       nuestcorte || '-' || nuestprod, csbNivelTraza);

        -- Obtenemos datos de consumos y lecturas para el producto
        cm_boestimateservices.getpreviousconsumption(nuconsant, sbfunconsant, numetconsant); -- Obtener consumo mes anterior
        pkg_traza.trace('CM_BOESTIMATESERVICES.GETPREVIOUSCONSUMPTION -->' ||
                       nuconsant || '-' || sbfunconsant || '-' || numetconsant, csbNivelTraza);

        cm_boconslogicservice.getcategorysubcategory(nucategori, nusubcategori); --obtener categoria y subcategoria
        pkg_traza.trace('CM_BOCONSLOGICSERVICE.GETCATEGORYSUBCATEGORY -->' ||
                       nucategori || '-' || nusubcategori, csbNivelTraza);

        cm_boestimateservices.getindividaveragecons(nuconsprom, sbfunconsprom, numetconsprom); -- obtener consumo promedio individual
        pkg_traza.trace('CM_BOESTIMATESERVICES.GETINDIVIDAVERAGECONS -->' ||
                       nuconsprom || '-' || sbfunconsprom || '-' ||
                       numetconsprom, csbNivelTraza);

        nuconssubnoproy := LDC_PKGCONPR.fnuinfoavgconsofsubcat('LOC'); --Consumo por subcategoria sin proyeccion a los dias de consumo
        pkg_traza.trace('LDC_PKGCONPR.FNUINFOAVGCONSOFSUBCAT nuConsSubNoProy-->' ||
                       nuconssubnoproy, csbNivelTraza);

        LDC_PKGCONPR.getaverageconsofsubcat('LOC', nuconssub, sbfunconssub, numetconssub); -- Consumo promedio del estrato del usuario proyectado con los dias de consumo
        pkg_traza.trace('LDC_PKGCONPR.getaverageconsofsubcat -->' ||
                       nuconssub || '-' || sbfunconssub || '-' || numetconssub, csbNivelTraza);

        --Obtenemos datos instanciados en memoria por OPEN  para el proceso
        cm_boconsumptionengine.getenginememorydata(orccurrentreading, -- out nocopy lectelme%rowtype,  -- Lectura que se está procesando
                                                   orcorder, --out nocopy daor_order.styOR_order, -- Orden que se legaliza
                                                   orcproduct, --out nocopy servsusc%rowtype, -- Producto que se está procesando
                                                   onuactivity, --out nocopy remevaco.rmvcacti%type, --Escenario / Actividad
                                                   orcactiverule, -- out nocopy remevaco%rowtype, -- Regla que se está ejecutando
                                                   orcconsumptionperiod --out nocopy pericose%rowtype -- Período de Consumo
                                                   );
        num_producto := orcproduct.sesunuse;
        sbestafina   := orcproduct.sesuesfn;
        nuorden      := orcorder.order_id;

        pkg_traza.trace('Num_producto -->' || num_producto, csbNivelTraza);
        pkg_traza.trace('sbEstaFina -->' || sbestafina, csbNivelTraza);
        pkg_traza.trace('nuorden -->' || nuorden, csbNivelTraza);

        nuperiodo_consumo := orcconsumptionperiod.pecscons; -- Periodo de consumo del producto que se esta procesando
        pkg_traza.trace('nuperiodo_consumo -->' ||nuperiodo_consumo, csbNivelTraza);
        
        dtfechafincons := orcconsumptionperiod.pecsfecf;
        nuconsecutivolect := orccurrentreading.leemcons;

        --El consumo promedio calculado con la funcion de OPEN se usa en varias funciones por lo tanto debe obtener un valor valido
        --para el producto, si el producto no tiene consumo promedio, le asignamos a la variable el promedio de la subcategoria
        --para el resto del proceso

        --< CA 200-1063 >--
        nuperiodceroconsec := fnuvalidaconsumoscero(num_producto); --< CA 200-1063 Parte 3>--

        --Verifica si el promedio de la subcategoria es valido
        prValidaPromedios(nuconsprom,sbfunconsprom,sbmarcaprompropio,nuconssub,sbmarcapromsubcat,sbfunconssub);
       
        -- Establecer si el producto es Nuevo
        IF cm_boconslogicservice.fnugetdayssinceinstall() <= nudiasusnuevo THEN
            sbprodnuevo := 'S';
        ELSE
            sbprodnuevo := 'N';
        END IF;
        -- Fin CA 200-1063 --

        IF nucategori = 2 -- comercial
        THEN
            numtsmax      := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_METROS_MAXIMO_COM');
            numtsmaxreg13 := pkg_bcld_parameter.fnuobtienevalornumerico('FACT_MTS_MAX_COMER');
        ELSE
            numtsmax      := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_METROS_MAXIMO_RES');
            numtsmaxreg13 := pkg_bcld_parameter.fnuobtienevalornumerico('FACT_MTS_MAX_RESID');
        END IF;

        nuvalconsumo  := pkg_bcld_parameter.fnuobtienevalornumerico('CONSUMO_VALIDO');
        nuvalconsumo2 := pkg_bcld_parameter.fnuobtienevalornumerico('CONSUMO_VALIDO2');

        -- Historico de los seis ultimos Consumos del producto
        cm_boestimateservices.getnthprevconsumption(1, nucons1, sbfuncons1, numetcons1);
        cm_boestimateservices.getnthprevconsumption(2, nucons2, sbfuncons2, numetcons2);
        cm_boestimateservices.getnthprevconsumption(3, nucons3, sbfuncons3, numetcons3);
        cm_boestimateservices.getnthprevconsumption(4, nucons4, sbfuncons4, numetcons4);
        cm_boestimateservices.getnthprevconsumption(5, nucons5, sbfuncons5, numetcons5);
        cm_boestimateservices.getnthprevconsumption(6, nucons6, sbfuncons6, numetcons6); --Consumo mas antiguo

        --Funcionalidad alterna para obtener los consumos históricos liquidados.
        nucons1 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,1);
        nucons2 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,2);
        nucons3 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,3);
        nucons4 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,4);
        nucons5 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,5);
        nucons6 := fnuObtieneConsumosPrevios(num_producto,orcactiverule.rmvctico,orcconsumptionperiod.pecscons,6);

        -- Determinar si tiene historia valida con los consumos obtenidos en el historico
        SELECT decode(nucons1, 0, 0, -1, 0, 1) +
               decode(nucons2, 0, 0, -1, 0, 1) +
               decode(nucons3, 0, 0, -1, 0, 1) +
               decode(nucons4, 0, 0, -1, 0, 1) +
               decode(nucons5, 0, 0, -1, 0, 1) +
               decode(nucons6, 0, 0, -1, 0, 1)
        INTO nuhistvalida
        FROM dual;
        SELECT decode(nucons1, 0, 0, -1, 0, 1) +
               decode(nucons2, 0, 0, -1, 0, 1)
        INTO nuhistvalida2
        FROM dual;

        SELECT decode(nucons1, 0, 0, -1, 0, 1) INTO nuprimescero FROM dual;
        SELECT decode(nucons2, 0, 0, -1, 0, 1) INTO nusegmescero FROM dual;
        SELECT decode(nucons3, 0, 0, -1, 0, 1) INTO nutermescero FROM dual;

        --CA 200-1063 -Parte 1
        --Se valida el top de Consumos Estimados para cambio de Funcion de Calculo
        pkg_traza.trace('nuvecesconsestimado OPEN: ' ||
                               nuvecesconsestimado, csbNivelTraza);

        nuvecesconsestimado := fnuvecesconsumoestimado(orcproduct.sesunuse);
        pkg_traza.trace('nuvecesconsestimado Funcion Pkt: ' ||
                               nuvecesconsestimado, csbNivelTraza);

        IF nuvecesconsestimado >= nuparam_max_cons_est
        AND sbmarcapromsubcat = 'S' THEN
            --Se asigna Funcion de Promedio Subcategoria
            sbfunconsprom := sbfunconssub;

            IF sbmarcaprompropio = 'N' THEN
                --Se asigna el Prom. de Subcateg si es valido
                nuconsprom := nuconssub;
            END IF;

            pkg_traza.trace('CA 200-1063 | Notas-SAO397466| cambio de Funcion de Calculo (' ||
                       sbfunconsprom || ') por (' || sbfunconssub || ')' ||
                       chr(10) ||
                       'Evitar que se deje de calcular el Promedio Individual.' ||
                       sbfunconsact, csbNivelTraza);

        END IF;
        --Fin CA 200-1063

        -- Consumo por diferencia de lecturas con factor de correccion con recuperacion de consumos (nuCantMesesRec)
        cm_bocalcconsumpservs.readdifandcorrectfactor(nucantmesesrec, nuconsact, sbfunconsact, numetconsact);
        pkg_traza.trace('nuCantMesesRec -->' ||
                       nucantmesesrec || ' nuConsAct -->' || nuconsact ||
                       ' sbFunConsAct -->' || sbfunconsact ||
                       ' nuMetConsAct -->' || numetconsact, csbNivelTraza);

        nuconsact := round(nuconsact);
        pkg_traza.trace('Consumo Actual Redondeado nuConsAct -->' ||
                       nuconsact || ' sbFunConsAct -->' || sbfunconsact ||
                       ' nuMetConsAct -->' || numetconsact, csbNivelTraza);
        pkg_traza.trace('--< Inicia CA200-1202>--', csbNivelTraza);

        --Obtiene el Flag que valida si hay cambio de medidor en el periodo actual --<CA200-1202>--
        sbmarcaCambMedidor := fsbTieneCambMedidor(num_producto, nuperiodo_consumo);
        --Se Obtienen los Consumos que han sido recuperados  --<CA200-1202>--
        --La funcion tambien obtienen los consumos facturados de Conssesu sin validar recuperaciones (nuconsFactActual,nuconsFact01-6)
        ldc_bssreglasproclecturas.prObtConsRecup(num_producto, nuperiodo_consumo, nuvolrecupproy, sbmarcaRecuperado, nuPeriodosRecup, nuconsFactActual, nuconsFact1, nuconsFact2, nuconsFact3, nuconsFact4, nuconsFact5, nuconsFact6);
        pkg_traza.trace('nuvolrecupproy -->' ||
                       nuvolrecupproy, csbNivelTraza);

        pkg_traza.trace('nuconsFactActual -->' ||
                       nuconsFactActual, csbNivelTraza);

        pkg_traza.trace('nuconsFact1 -->' || nuconsFact1, csbNivelTraza);
        pkg_traza.trace('nuconsFact2 -->' || nuconsFact2, csbNivelTraza);
        pkg_traza.trace('nuconsFact3 -->' || nuconsFact3, csbNivelTraza);
        pkg_traza.trace('nuconsFact4 -->' || nuconsFact4, csbNivelTraza);
        pkg_traza.trace('nuconsFact5 -->' || nuconsFact5, csbNivelTraza);
        pkg_traza.trace('nuconsFact6 -->' || nuconsFact6, csbNivelTraza);
        pkg_traza.trace('nuPeriodosRecup -->' ||
                       nuPeriodosRecup, csbNivelTraza);

        pkg_traza.trace('CASO 222 CAMBIO_MEDIDOR: '||sbmarcaCambMedidor, csbNivelTraza);
        pkg_traza.trace('CASO 222 nuperiodo_consumo: '||nuperiodo_consumo, csbNivelTraza);
        IF sbmarcaCambMedidor = 'S' THEN
            pkg_traza.trace('Consumo Actual -->' ||
                           nuconsact, csbNivelTraza);

            --Se acualiza el consumo actual por consumos registrados en el periodo por la lectura de retiro del medidor (nuconsFactActual)
            SELECT SUM(COSSCOCA) INTO nuconsFactTotal
            FROM CONSSESU
            WHERE COSSSESU = num_producto
              AND COSSPECS = nuperiodo_consumo
              AND COSSMECC = 4      ;

            nuconsact := nuconsact + nvl(nuconsFactTotal, 0);

            pkg_traza.trace('sbmarcaCambMedidor -->' ||
                           sbmarcaCambMedidor||' nuconsFactTotal '||nuconsFactTotal, csbNivelTraza);
            pkg_traza.trace('Nuevo Consumo Actual tras cambio Medidor -->' ||
                           nuconsact, csbNivelTraza);

        END IF;

        pkg_traza.trace('--< Fin CA200-1202>--', csbNivelTraza);

        -- CA200-639. Evaluacion de rangos, Retorna si esta normal o desviado
        pkg_traza.trace('nuConsProm -->' || nuconsprom ||
                           ' sbFunConsAct -->' || sbfunconsact ||
                           ' nuCalifica -->' || nucalifica ||
                           ' nuPrioridad -->' || nuprioridad ||
                           ' Consumo antes de procalifica--> ' || nuconsact, csbNivelTraza);

		IF sbindicalect = 'S' THEN
            sbRowId  := NULL;
            --se realiza proceso para desviacion poblacional
            blProdDesviado := pkg_bcGestionConsumoDp.fblValidaProdDesv (  num_producto,
                                                                          orcproduct.sesususc,
                                                                          nuconsact,
                                                                          orccurrentreading.leempefa,
                                                                          nuperiodo_consumo,
                                                                          orccurrentreading.leemfela,
                                                                          orccurrentreading.leemfele,
                                                                          'S',
                                                                          onuCumpleRegla,
                                                                          sbRowId);

            --si el producto esta desviado o no cumple la regla de desviacion ingresa al proceso de calificacion actual
            IF blProdDesviado OR onuCumpleRegla = 0 THEN

                nucalifica := null;
                --se valida calificacion
                prCalificaConsumoDesvPobl( num_producto,
                                           orccurrentreading.leempefa,
                                           nuconsact,
                                           sbmarcaprompropio,
                                           nuestprod,
                                           nuconsprom,
                                           nucategori,
                                           orccurrentreading.leemfela,
                                           orccurrentreading.leemfele,
                                           'L',
                                           nucalifica);
                                           
                IF nucalifica = cnuRegla3017 THEN
                    -- Consumo sugerido por diferencia de lectura anterior con factor de correccion sin recuperación de consumo
                    prConsDifLectAntFactCorr(nuconsact, sbfunconsact, numetconsact);  
                    --Genera relectura 
                    pkg_traza.trace('Genera Relectura', csbNivelTraza);
                    cm_boconslogicservice.generaterereadingorder();                
                ELSIF nucalifica = cnuRegla3007 AND sbmarcaprompropio = constants_per.csbsi AND nuConsPendLiqu > 0 THEN
                    isbordcom := 'Orden generada por proceso de reglas';
                    prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
               ELSIF nucalifica = cnuRegla3007 THEN
                    --Genera relectura 
                    pkg_traza.trace('Genera Relectura', csbNivelTraza);
                    cm_boconslogicservice.generaterereadingorder();
                 END IF;
            ELSE
                --se realiza calificacion nueva
                nucalifica := cnuRegla3001;
            END IF;

            IF nucalifica IS NULL THEN
               pkg_error.setErrorMessage(isbMsgErrr => 'No se encontro calificacion para el producto' );
            END IF;
            
            cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
            cm_boconslogicservice.setmanualqualification(sbfunconsact, nucalifica);
            IF sbRowId IS NOT NULL THEN
               pkg_info_producto_desvpobl.prActCalifiProdDesvpobl(sbRowId, nucalifica);
            END IF;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
            RETURN;
        END IF;
        procalificavariacionconsumo(inupericonsumo => nuperiodo_consumo, inuconsumoactual => nuconsact, -- Se usa el consumo actual calculado por open.
                                            isbmarcaprompropio => sbmarcaprompropio, isbtienelectura => sbindicalect, inuconsumopromedioopen => nuconsprom, inuproducto => num_producto, inucategoria => nucategori, inusubcategoria => nusubcategori, onucalificacion => nucalifica);

        pkg_traza.trace('nuConsProm -->' || nuconsprom ||
                           ' sbFunConsAct -->' || sbfunconsact ||
                           ' nuCalifica -->' || nucalifica ||
                           ' nuPrioridad -->' || nuprioridad ||
                           ' Consumo después de procalifica--> ' || nuconsact, csbNivelTraza);

        --Verifica si existe ordenes pendientes de actividades de cambio de medidor
        IF cuValidaOrdenAbiertasCM%ISOPEN THEN
           CLOSE cuValidaOrdenAbiertasCM;
        END IF;

        OPEN cuValidaOrdenAbiertasCM(num_producto);
        FETCH cuValidaOrdenAbiertasCM INTO sbordenpend;
        IF cuValidaOrdenAbiertasCM%NOTFOUND THEN
           sbordenpend :='N';
        END IF;

        CLOSE cuValidaOrdenAbiertasCM;

        pkg_traza.trace('Tiene orden Cambio Medidor pendiente  => ' || sbordenpend, csbNivelTraza);

        FOR i IN cunuevacalificacion
        LOOP
            pkg_traza.trace('i.consecutivo ' || i.consecutivo, csbNivelTraza);
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla1 THEN

               --INICIO OSF-654
               nuRecurrObse := prGetRecurrenciaObseNlec(i.consecutivo);
               --FIN OSF-654

                nuactivitytypeid := NULL;

                IF sbindicalect = 'N'
                AND
                (cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret) = 'S' OR
                cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret2) = 'S')
                AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod2(nuobsmedret, nuobsmedret2) + 1 ) >=
                nuRecurrObse THEN
                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion);

                    IF nuestcorte <> 5
                    AND sbestafina <> 'C' THEN
                        --cm_boconslogicservice.generatejoborder(nuactivitytypeid, isbordcom); -- Genero OT de critica 12620 con actividad 4000980
                        pkg_traza.trace('ejecuto generacion tipo trabajo 12620', csbNivelTraza);
                    END IF;

                    cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                    pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                   sbfunman || '-' || numetman, csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunman);
                    cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla1: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --se llama proceso para generar orden de visita
                    prGeneraActiviObNlect( i.consecutivo,
                                           nucausanolect,
                                           num_producto,
                                           'T',
                                           dtfechafincons,
                                           nuperiodo_consumo,
                                           nuconsecutivolect);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla2 THEN
                --INICIO OSF-654
                nuRecurrObse := prGetRecurrenciaObseNlec(i.consecutivo);
                --FIN OSF-654
                IF sbindicalect = 'N'
                   AND
                   (cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret) = 'S' OR
                   cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret2) = 'S')
                   AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod2(nuobsmedret, nuobsmedret2) + 1 ) <
                   nuRecurrObse THEN

                    --Sin Lectura con Observacion por Falta de Medidor
                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    IF (sbestafina = 'C' OR
                       (nuestprod  = 2 AND sbestafina <> 'C'   )
                       ) THEN

                        --5-Suspension total o C-Castigado y Consumo Cero ultimos N Periodos >>> Aplica Consumo 0 y No se genera Relectura
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman);
                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                       sbfunman || '-' || numetman, csbNivelTraza);
                        -- Cambio 38: si est prod suspendido y la ult act de susp es de los tt del parametro TT_SUSP_REGLA_2002

                    ELSIF  nuestprod = 1 and  nuperiodceroconsec >= nuparam_period_cero_cast then

                        --2-Est Prod Susp y ult activ de susp es de tt de parametro >>> Aplica Consumo 0 y No se genera Relectura
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman);
                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                       sbfunman || '-' || numetman, csbNivelTraza);

                    ELSE
                        --Productos Con Conexion | Suspendidos o Castigados con Consumo valido
                        --ASIGNA CONSUMO PROMEDIO y Genera Relectura
                        cm_boestimateservices.assignconsuption(sbfunconsprom);
                        cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.assignconsuption -->' ||
                                       sbfunconsprom, csbNivelTraza);

                        --< Genera Relectura >--
                        cm_boconslogicservice.generaterereadingorder();
                        nuExisteOrd := 1;
                        pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);

                    END IF;

                    --Fin CA 200-389
                    pkg_traza.trace('entro regla nuRegla2: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --se llama proceso para generar orden de visita
                    prGeneraActiviObNlect( i.consecutivo,
                                         nucausanolect,
                                         num_producto,
                                         'T',
                                       dtfechafincons,
                                       nuperiodo_consumo,
                                       nuconsecutivolect);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla3 THEN
               --INICIO OSF-654
               nuRecurrObse := prGetRecurrenciaObseNlec(i.consecutivo);
               --FIN OSF-654
                IF sbindicalect = 'N'
                   AND
                   (cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret) = 'N' AND
                   cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret2) = 'N')
                   AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod3(nuobsmedret, nuobsmedret2) + 1 ) <= nuRecurrObse THEN
                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);
                    IF (sbestafina = 'C' OR
                       nuestprod  = 2 OR ( nuestprod = 1 AND nuperiodceroconsec >= nuparam_period_cero_cast)) --lmfg
                     THEN
                        --5-Suspension total o C-Castigado y Consumo Cero ultimos N Periodos >>> Aplica Consumo 0 y No se genera Relectura
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman);
                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                       sbfunman || '-' || numetman, csbNivelTraza);

                    ELSE
                        --Productos Con Conexion | Suspendidos o Castigados con Consumo valido
                        --ASIGNA CONSUMO PROMEDIO y Genera Relectura
                        cm_boestimateservices.assignconsuption(sbfunconsprom);
                        cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.assignconsuption -->' ||
                                       sbfunconsprom, csbNivelTraza);

                        --< Genera Relectura >--
                        cm_boconslogicservice.generaterereadingorder();
                        nuExisteOrd := 1;
                        pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);

                    END IF;

                    --se llama proceso para generar orden de visita
                    prGeneraActiviObNlect( i.consecutivo,
                                           nucausanolect,
                                           num_producto,
                                           'T',
                                           dtfechafincons,
                                           nuperiodo_consumo,
                                           nuconsecutivolect);
                    pkg_traza.trace('entro regla nuRegla3: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla4 THEN

                --INICIO OSF-654
                nuRecurrObse := prGetRecurrenciaObseNlec(i.consecutivo);
                --FIN OSF-654

                IF sbindicalect = 'N' AND (cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret) = 'N'
                AND cm_boconslogicservice.fsbexistsoncurrreadobs(nuobsmedret2) = 'N')
                AND (ldc_bssreglasproclecturas.fnucountserialreadobsperiod3(nuobsmedret, nuobsmedret2) + 1 ) >
                    nuRecurrObse THEN
                    pkg_traza.trace('entro regla nuRegla4: entrega 72.0', csbNivelTraza);
                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    nuactivitytypeid := pkg_bcld_parameter.fnuobtienevalornumerico('ACTIVI_SUSP_ADMIN');

                    --se llama proceso para generar orden de visita
                    prGeneraActiviObNlect( i.consecutivo,
                                         nucausanolect,
                                         num_producto,
                                         'T',
                                           dtfechafincons,
                                           nuperiodo_consumo,
                                           nuconsecutivolect);

                   --TICKET 200-2386 ELAL --Se valida si la entrega 200-2386 aplica para la gasera
                    IF (sbestafina = 'C' OR
                     (
                      sbestafina <> 'C' AND --estado de corte en coment. Monica O.
                      nuperiodceroconsec >= nuparam_period_cero_cast)
                      ) --lmfg
                    THEN

                        --Si Castigado con Ultimos 3 Meses Consumo 0-Cero
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                     sbfunman || '-' || numetman, csbNivelTraza);

                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    ELSE
                        IF sbmarcaprompropio = 'S'
                        OR sbmarcapromsubcat = 'S' THEN

                            --Se Valida Promedio Propio y de Subcategoria
                            cm_boestimateservices.assignconsuption(sbfunconsprom); -- ASIGNA CONSUMO PROMEDIO
                            cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        ELSE
                            cm_boestimateservices.establishconsumption(0, sbfunman, numetman); --APLICA CONSUMO CERO
                            pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                           sbfunman || '-' || numetman, csbNivelTraza);

                            cm_boestimateservices.assignconsuption(sbfunman);
                            cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                            isbordcom := 'Orden generada por proceso de reglas';

                            OPEN cuexisteordengenerada(num_producto, 12619, nuanacrit);
                            FETCH cuexisteordengenerada        INTO nucantot;
                            IF nucantot = 0   THEN
                                --Genera Critica si el promedio actual supera el Factor% del Ultimo Promedio registrado del producto
                                --y si no tiene ni promedio propio ni por subcategoria
                                isbordcom := 'Orden generada por proceso de reglas';
                                prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                                nuExisteOrd := 1;
                                nucantot := 1;
                                pkg_traza.trace('ejecuto generacion de critica - POR PROMEDIO INDIVIDUAL', csbNivelTraza);

                            END IF;

                            CLOSE cuexisteordengenerada;
                        END IF;
                    END IF;

                    pkg_traza.trace('entro regla nuRegla4:  '||cm_boconslogicservice.fsbexistsoncurrreadobs(nuObsNoEncPredio), csbNivelTraza);
                    pkg_traza.trace('entro regla nuRegla4: ' ||i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla5 THEN
                IF sbindicalect = 'S'
                    AND fsbestcortnopermit(nuestprod)
                    AND nucalifica <> 1
                    AND (sbordenpend = 'S' ) THEN

                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                               ' | Calificacion: ' ||
                               i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsprom); -- ASIGNA CONSUMO PROMEDIO
                    cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL

                    --se llama proceso para generar orden de visita
                    prGeneraActiviObNlect( i.consecutivo,
                                      nucausanolect,
                                      num_producto,
                                      'T',
                                      dtfechafincons,
                                      nuperiodo_consumo,
                                      nuconsecutivolect);

                    IF sbmarcaprompropio = 'N' THEN
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        pkg_traza.trace('ejecuto generacion de critica', csbNivelTraza);

                    ELSE
                        IF (fnuultconsprom(num_producto) * nuporcpromind) < nuconsprom THEN
                            isbordcom := 'Orden generada por proceso de reglas';
                            prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                            pkg_traza.trace('ejecuto generacion de critica - POR PROMEDIO INDIVIDUAL', csbNivelTraza);

                        END IF;
                    END IF;
                    pkg_traza.trace('entro regla nuRegla5: ' ||
                               i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla6 THEN
                IF sbindicalect = 'S'
                AND fsbestcortnopermit(nuestprod)
                AND nuconsact = 0
                AND nuprimescero = 1 THEN
                    --Tiene Lectura, Estado Corte <> Suspendido, No tiene OT cambio de medidor, Consumo Actual Cero
                    pkg_traza.trace('Procesada en Regla ' ||
                                       i.consecutivo ||
                                       ' | Calificacion: ' ||
                                       i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact ); --lmfg asigna consumo calculado   no ASIGNA CONSUMO PROMEDIO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact , i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    cm_boconslogicservice.generaterereadingorder(); -- GENERA RELECTURA
                    nuExisteOrd := 1;
                    pkg_traza.trace('entro regla nuRegla6: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla7 THEN
                IF sbindicalect = 'S'
                AND fsbestcortnopermit(nuestprod)
                AND nuconsact = 0
                AND nuprimescero = 0
                AND nusegmescero = 1 THEN

                    --Tiene Lectura, Estado Corte <> Suspend, No Act Cambio Med, 2do Mes Cero, Consumo Actual Cero
                    pkg_traza.trace('Procesada en Regla ' ||
                                   i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('Generada Relectura: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --Validación para generación de crítica
                    IF sbordenpend = 'S' THEN
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        pkg_traza.trace('Ejecutó generación de crítica por orden pendiente CM', csbNivelTraza);
                        nuExisteOrd := 1;
                    END IF;

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla8 THEN
                IF sbindicalect = 'S'
                AND fsbestcortnopermit(nuestprod)
                AND nuconsact = 0
                AND nuprimescero = 0
                AND nusegmescero = 0
                THEN
                    pkg_traza.trace('Procesada en Regla csentrega2001202 ' ||
                       i.consecutivo ||
                       ' | Calificacion: ' ||
                       i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla8: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    --Validación para generación de crítica
                    IF sbordenpend = 'S' THEN
                        isbordcom := 'Orden generada por proceso de reglas';
                        prgeneracritica(nuanacrit, isbordcom, num_producto, dtfechafincons, nuperiodo_consumo, nuconsecutivolect);
                        pkg_traza.trace('Ejecutó generación de crítica por orden pendiente CM', csbNivelTraza);
                        nuExisteOrd := 1;
                    END IF;

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla9 THEN
                IF sbindicalect = 'S'
                    AND fsbestcortnopermit(nuestprod)
                    AND nucalifica <> 1
                    AND sbordenpend = 'N'
                    AND nuconsact = 0
                    AND nuprimescero = 0
                    AND nusegmescero = 0
                    AND fsbverifotrevis0 = FALSE THEN
                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion);
                    pkg_traza.trace('entro regla nuRegla9: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla10 THEN

                IF sbindicalect = 'S'
                AND nucalifica <> 1
                THEN

                    pkg_traza.trace('Procesada en Regla ' ||
                                       i.consecutivo ||
                                       ' | Calificacion: ' ||
                                       i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    cm_boconslogicservice.generaterereadingorder(); -- GENERA RELECTURA
                    nuExisteOrd := 1;
                    pkg_traza.trace('Generada Relectura', csbNivelTraza);

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla11 THEN
                IF sbindicalect = 'S'
                AND NOT fsbestcortnopermit(nuestprod)
                AND nuconsact = 0 THEN

                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla11: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla12 THEN

                IF sbindicalect = 'S'
                AND NOT fsbestcortnopermit(nuestprod)
                AND nuconsact <> 0 THEN

                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    IF nuprimescero = 0 THEN
                        cm_boconslogicservice.generaterereadingorder(); -- GENERA RELECTURA
                        nuExisteOrd := 1;
                    ELSIF orcproduct.sesucate = 1 AND nuconsact > nuvalconsumo THEN
                        cm_boconslogicservice.generaterereadingorder(); -- GENERA RELECTURA
                        nuExisteOrd := 1;
                    ELSIF orcproduct.sesucate = 2 AND nuconsact > nuvalconsumo2 THEN
                        cm_boconslogicservice.generaterereadingorder(); -- GENERA RELECTURA
                        nuExisteOrd := 1;
                    END IF;

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla12: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla20 THEN
                IF sbindicalect = 'S'
                AND nucalifica = 1 THEN

                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla20: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla22 THEN
                IF orcproduct.sesucate = 1
                AND nuconsact > nuvalconsumo THEN

                    pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                                   ' | Calificacion: ' ||
                                   i.codigo_calificacion,csbNivelTraza);

                    cm_boconslogicservice.generaterereadingorder(); -- GENERA RELECTURA
                    nuExisteOrd := 1;
                    cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                    cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                    pkg_traza.trace('entro regla nuRegla22: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                END IF;
            END IF;
            --CA 200-1101 se cambia posicion de la condicion para que sea la ultima en ser evaluada
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla25 THEN
                pkg_traza.trace('Procesada en Regla ' || i.consecutivo ||
                               ' | Calificacion: ' ||
                               i.codigo_calificacion,csbNivelTraza);

                cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                pkg_traza.trace('entro regla nuRegla25: ' ||
                               i.codigo_calificacion, csbNivelTraza);
                EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla28 THEN

                IF nucalifica = nuregla28 THEN

                    pkg_traza.trace('entro regla nuRegla28: ' ||
                                   i.codigo_calificacion, csbNivelTraza);

                    IF sbindicalect = 'S'
                    AND (sbmarcaprompropio = 'N' AND
                    sbmarcapromsubcat = 'N') THEN

                        cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL

                        --TIENE LECTURA NO PROM PROPIO NI PROM SUBCATEGORIA
                        IF ((orcproduct.sesucate = 1 AND
                        ( nuconsact <= num3maxnvores
                        )) OR
                        --Es Comercial y el consumo Actual es menor al parametro M3_MAX_NVO_USU_COM
                        (orcproduct.sesucate = 2 AND
                        (nuconsact <= num3maxnvocom
                        )
                        )) THEN

                            --< Calificar consumo como 1-Normal >--
                            nucalifica := 1;

                            pkg_traza.trace('--< Calificar consumo como 1-Normal | Diferencia de Lecturas >-- | sbfunconsact: ' ||
                                         sbfunconsact, csbNivelTraza);
                        ELSE

                            --< Genera Relectura >--
                            cm_boconslogicservice.generaterereadingorder();
                            nuExisteOrd := 1;
                            pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);

                        END IF;
                        EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                    END IF;
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla29 THEN
                IF nucalifica IN ( nuregla29, nuregla30) THEN

                    -- Asigna consumo por diferencia de lecturas
                    IF  sbindicalect = 'S' THEN

                        IF ((orcproduct.sesucate = 1 AND
                        ( nuconsact <= num3maxnvores AND sbmarcapromsubcat = 'N'
                        OR nuconsact <= nuconssub AND sbmarcapromsubcat = 'S')
                        ) OR
                        --Es Comercial y el consumo Actual es menor al parametro M3_MAX_NVO_USU_COM
                        (orcproduct.sesucate = 2 AND
                        (nuconsact <= num3maxnvocom  AND sbmarcapromsubcat = 'N'
                        OR nuconsact <= nuconssub AND sbmarcapromsubcat = 'S')
                        )) THEN

                            cm_boestimateservices.assignconsuption(sbfunconsact);
                            cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL

                        ELSE

                            --< Genera Relectura >--
                            cm_boconslogicservice.generaterereadingorder();
                            nuExisteOrd := 1;

                        END IF;

                        pkg_traza.trace('aplicá regla 29', csbNivelTraza);
                        EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                    END IF;
                END IF;
            END IF;
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla31 THEN
                IF sbindicalect = 'S'
                AND sbprodnuevo = 'S'
                AND nuconsact >= 0 THEN
                    pkg_traza.trace('--< parametro M3_MAX_NVO_USU_RES: ' ||
                                   num3maxnvores || '>--', csbNivelTraza);

                    pkg_traza.trace('--< parametro M3_MAX_NVO_USU_COM: ' ||
                                   num3maxnvocom || '>--', csbNivelTraza);

                    pkg_traza.trace('--< Categoria: ' ||
                                   orcproduct.sesucate || '>--', csbNivelTraza);

                    pkg_traza.trace('--< Consumo Actual: ' || nuconsact ||
                                   '>--', csbNivelTraza);

                    --Es Residencial y el consumo Actual es menor al parametro M3_MAX_NVO_USU_RES ?
                    IF ((orcproduct.sesucate = 1 AND
                    ( (nuconsact <= num3maxnvores AND sbmarcapromsubcat = 'N')
                    OR (nucalifica = 1 AND sbmarcapromsubcat = 'S') )
                    ) OR
                    --Es Comercial y el consumo Actual es menor al parametro M3_MAX_NVO_USU_COM
                    (orcproduct.sesucate = 2 AND
                    ( (nuconsact <= num3maxnvocom  AND sbmarcapromsubcat = 'N')
                    OR (nuCalifica = 1  AND sbmarcapromsubcat = 'S'))
                    )) THEN
                        pkg_traza.trace('--< Ingreso nuconsact <= num3maxnvo(res com): ' ||
                                       nuconsact || '>--', csbNivelTraza);

                        --< Calificar consumo como 1-Normal >--
                        nucalifica := 1;
                        cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('--< Calificar consumo como 1-Normal | Diferencia de Lecturas >--', csbNivelTraza);

                    ELSE

                        --< Calificar consumo como 1-Normal >--
                        pkg_traza.trace('--< Ingreso nuconsact > num3maxnvo(res com): ' ||
                                       nuconsact || '>--', csbNivelTraza);

                        nucalifica := 1;
                        cm_boestimateservices.assignconsuption(sbfunconsact); -- ASIGNA CONSUMO CALCULADO
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('--< Calificar consumo como 1-Normal | Diferencia de Lecturas >--', csbNivelTraza);

                        --< Genera Relectura >--
                        cm_boconslogicservice.generaterereadingorder();
                        nuExisteOrd := 1;
                        pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);

                    END IF;
                    pkg_traza.trace('entro regla nuRegla31: ' ||
                                   i.codigo_calificacion, csbNivelTraza);
                    EXIT; -- Si ya lo evaluo por esta regla y aplico, Deja de evaluarlo
                END IF;
            END IF;
            -- CAMBIO 373
            --------------------------------------------------------------------------------------------------
            IF i.consecutivo = nuregla34 THEN

                if nucausanolect = nuoblefuerazmayor then

                    if orcproduct.sesucate = 2 then -- genera relectura

                        --< Genera Relectura >--
                        cm_boconslogicservice.generaterereadingorder();
                        nuExisteOrd := 1;
                        pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);
                        --  EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                    end if;

                    nuRecurrObse := prGetRecurrenciaObseNlec(i.consecutivo);

                    if nuestcorte = 5 or
                    nuperiodceroconsec >= 2 or
                    ldc_bssreglasproclecturas.fnucountserialreadobsperiod2(nuobsmedret, nuobsmedret2) >= nuRecurrObse then

                        -- asigna cons 0
                        cm_boestimateservices.establishconsumption(0, sbfunman, numetman);
                        cm_boestimateservices.assignconsuption(sbfunman);
                        cm_boconslogicservice.setmanualqualification(sbfunman, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.ESTABLISHCONSUMPTION -->' ||
                                sbfunman || '-' || numetman, csbNivelTraza);

                    else
                        --ASIGNA CONSUMO PROMEDIO
                        cm_boestimateservices.assignconsuption(sbfunconsprom);
                        cm_boconslogicservice.setmanualqualification(sbfunconsprom, i.codigo_calificacion); -- APLICA CALIFICACION ACTUAL
                        pkg_traza.trace('CM_BOESTIMATESERVICES.assignconsuption -->' || sbfunconsprom, csbNivelTraza);

                    end if;
                    EXIT; -- Si ya lo evaluá por esta regla y aplicá, termina de evaluarlo
                end if;
            END IF;
        END LOOP;

        --INICIO CA 222
        IF nuExisteOrd = 0 THEN
            pkg_traza.trace('CnuExisteOrd -->' ||nuExisteOrd, csbNivelTraza);
            nuProductId := num_producto;

            SELECT COUNT(1) INTO nuExiste
            FROM LDC_CTRLLECTURA t
            WHERE t.NUM_PRODUCTO = nuProductId
            AND t.FLAG_PROCESADO = 'N';

            IF nuExiste > 0 THEN

                --Inicio CA 875
                --Se identifica si el producto tiene ordenes de CM pendientes
                sbPend := ldc_fsbGetPendOrdersCM(nuProductId);

                --Se valida si no existen ordenes pendientes para generar la critica
                IF (sbPend = 'N') THEN

                   UPDATE LDC_CTRLLECTURA t SET FLAG_PROCESADO = 'S', t.proceso='CM', t.fehaproceso=SYSDATE
                   WHERE  t.NUM_PRODUCTO = nuProductId and t.flag_procesado='N';

                    prgeneracritica
                    (
                        nuanacrit,
                        'GENERACION DE CRITICA POR CAMBIO DE MEDIDOR',
                        nuProductId,
                        dtfechafincons,
                        nuperiodo_consumo,
                        nuconsecutivolect
                    );

                END IF;
            END IF;
        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END pranalecturanormal;

    /**************************************************************************
        Propiedad Intelectual de PETI
        Funcion     :  PrLecturaRetiro
        Descripcion :  Procedimiento para recuperación de consumo en caso de cambio de medidor
        Fecha       : 28-01-2013
        Historia de Modificaciones
          Fecha               Autor                Modificación
        =========           =========          ====================
       09-12-2013         Sayra Ocoró       * Se incluye validación para ejecutar la regla cuando la la solicitud de la OT
                                              se generó a partir de una OT de ADC.
                                            * Soluciona NC 1534.
       17-12-2013         Sayra Ocoró       * Soluciona NC 1534_3
       14-04-2014         Sayra Ocoró       * Aranda 3411: Se cambia de lugar el end if.
       30-04-2014         Sayra Ocoró       *Aranda 3411_2 Se adicionan dos métodos de OPEN para recuperación de consumo por
                                              legalización tardía.
       27-05-2014         jsoto              Se suprimen las acciones para cuando el tipo de lectura es de instalacion
                                             estas acciones seran contempladas dentro de las reglas de lectura y relectura.
       05/05/2015         Jorge Valiente     Cambio 7228: Recorrer el texto relacionado con el comentario qeu contiene el codigo
       06/10/2023         jcatuchemvm        OSF-1366: Se cambia el llamado daor_order_activity.fnugetpackage_id por el personalizado
                                             pkg_bcordenes.fnuObtieneSolicitud agregando validación para hacerlo equivalente
    **************************************************************************/
    PROCEDURE prlecturaretiro
    (
        sbindicalect IN VARCHAR2,
        sbindtardia  IN VARCHAR2
    ) IS
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prlecturaretiro';
        nucausaactual           or_order.causal_id%TYPE;
        nucausapadre            or_order.causal_id%TYPE;
        nuconssub               NUMBER;
        numetconssub            mecacons.mecccodi%TYPE;
        isbrecovercurrentperiod VARCHAR2(2);
        nuconsact               NUMBER;
        sbfunconsact            VARCHAR2(100);
        numetconsact            mecacons.mecccodi%TYPE;
        sbfunconsrec            VARCHAR2(100);
        numetconsrec            mecacons.mecccodi%TYPE;
        tipo_lectura            VARCHAR2(2);
        nucantmesesrec          NUMBER;
        nuorderactivityidcurrent or_order_activity.order_activity_id%TYPE;
        nupackagesid             mo_packages.package_id%TYPE;
        nuorderactivityidadc     or_order_activity.order_activity_id%TYPE;
        sbpackagecomment         mo_packages.comment_%TYPE;
        nuorderidadc             or_order.order_id%TYPE;
        nuposition               NUMBER := 0;
        nucausal1                ld_parameter.numeric_value%TYPE;
        nucausal2                ld_parameter.numeric_value%TYPE;
        nuobsempa                ld_parameter.numeric_value%TYPE;
        nuobspint                ld_parameter.numeric_value%TYPE;
        nuobsilegible            ld_parameter.numeric_value%TYPE;

        ---cambio 7228 variables
        nucantidad       NUMBER;
        sbnumber         VARCHAR2(1) := 'S';
        nuot             NUMBER;
        nupackagecomment NUMBER;
        ---fin cambio 7228
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('sbindicalect    <= '||sbindicalect,csbNivelTraza);
        pkg_traza.trace('sbindtardia     <= '||sbindtardia,csbNivelTraza);

        -- Obtenemos parametros
        nucausal1      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CAUSAL_1_REC_CONSUMO');
        nucausal2      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_CAUSAL_2_REC_CONSUMO');
        nuobsempa      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBSER_MED_EMPANADO_AVC');
        nuobspint      := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBSER_MED_PINTADO_AVC');
        nuobsilegible  := pkg_bcld_parameter.fnuobtienevalornumerico('COD_OBSER_MED_ILEGIBLE_AVC');
        nucantmesesrec := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_MESES_RECUPERAR_CONSUMO');
        tipo_lectura := cm_boconslogicservice.fsbgetreadingcausal(); -- Instalación [I], de Retiro [R], de Facturación [F] o de Trabajo [T].
        pkg_traza.trace('tipo_lectura -->' || tipo_lectura, csbNivelTraza);

        --Modificación 09-12-2013
        --Obtener solicitud de ot
        nuorderactivityidcurrent := ldc_bcfinanceot.fnugetactivityid(pkg_bcordenes.fnuobtenerotinstancialegal);
        pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => nuOrderActivityIdCurrent => ' ||
                       nuorderactivityidcurrent, csbNivelTraza);

        nupackagesid := pkg_bcordenes.fnuObtieneSolicitud(pkg_bcordenes.fnuobtenerotinstancialegal);

        if nupackagesid is null then
            pkg_error.setErrorMessage( isbMsgErrr => 'El registro or_order_activity no existe para la orden '||pkg_bcordenes.fnuobtenerotinstancialegal);
        end if;

        pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => nuPackagesId => ' ||
                       nupackagesid, csbNivelTraza);

        --Obtener comentario de la solicitud
        sbpackagecomment := pkg_bcsolicitudes.fsbgetcomentario(nupackagesid);
        pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => sbPackageComment => ' ||
                       sbpackagecomment, csbNivelTraza);

        nuposition := instr(sbpackagecomment, 'OT ADC NO. ');
        pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => nuPosition => ' ||
                       nuposition, csbNivelTraza);

        --Validar comentario
        --Aranda 3411 -
        IF nuposition > 0 THEN
            nuposition       := nuposition + length('OT ADC NO. ');
            sbpackagecomment := substr(sbpackagecomment, nuposition, length(sbpackagecomment));
            pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => sbPackageComment => ' ||
                           sbpackagecomment, csbNivelTraza);


            ---codigo para recorrer el comentario de la solicitud y obtener el codigo de la OT ADC
            nucantidad := 1;
            pkg_traza.trace('Control: ' || sbnumber, csbNivelTraza);

            WHILE sbnumber = 'S'
            LOOP
                BEGIN
                    -- Recorrer la cadena carater x caracter para establecer el numero de la OT ADC
                    SELECT to_number(substr(sbpackagecomment, (instr(sbpackagecomment, 'OT ADC NO. ') +
                                             length('OT ADC NO. ')), nucantidad))
                    INTO nuot
                    FROM dual;
                    --variable para obtener el codigo real a utilizar
                    nupackagecomment := nuot;
                    IF nucantidad > 15 THEN
                        sbnumber := 'N';
                    END IF;
                    nucantidad := nucantidad + 1;
                    pkg_traza.trace('Orden: ' || nupackagecomment, csbNivelTraza);
                EXCEPTION
                    WHEN OTHERS THEN
                        sbnumber := 'N';
                END;
            END LOOP;

            pkg_traza.trace('Control: ' || sbnumber, csbNivelTraza);

            ---fin codigo para recorrer comentario de OT ADC
            IF nvl(nupackagecomment, 0) <> 0 THEN
                nuorderidadc := nupackagecomment; --to_number(sbPackageComment);
            ELSE
                nuorderidadc := 0;
            END IF;

            --fin cambio 7228
            --NC XXX
            --nuCausapadre
            --C XX
            pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => nuOrderIdADC => ' ||
                           nuorderidadc, csbNivelTraza);

            nuorderactivityidadc := ldc_bcfinanceot.fnugetactivityid(nuorderidadc);
            pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => nuOrderActivityIdADC => ' ||
                           nuorderactivityidadc, csbNivelTraza);

            ---Relacionar order_activity_id ORIGIN_ACTIVITY_ID = order_activity_id_ADC
            IF nuorderactivityidadc > 0 THEN

                daor_order_activity.updorigin_activity_id(nuorderactivityidcurrent, nuorderactivityidadc);
                pkg_traza.trace('Inicio LDC_BSSREGLASPROCLECTURAS.PrLecturaRetiro => SE ACTUALIZó REGISTRO', csbNivelTraza);

            END IF;
        END IF;

        --Fin Aranda 3411
        --Fin Modificación 09-12-2013

        IF sbindicalect = 'S'
        AND tipo_lectura = 'R' -- Si tiene indicador de lectura y es de retiro
        THEN

            pkg_traza.trace('sbindtardia -->' ||  sbindtardia, csbNivelTraza);

            IF sbindtardia = 'N' -- Si fue legalizada en forma tardia
            THEN
                cm_boconslogicservice.getreadingordercausal(nucausaactual, nucausapadre);
                pkg_traza.trace('nuCausapadre -->' ||
                               nucausapadre, csbNivelTraza);

                pkg_traza.trace('sbIndtardia -->' ||
                               sbindtardia, csbNivelTraza);

                IF nucausapadre IN (nucausal1, nucausal2) -- Medidor golpeado, Medidor deteriorado
                THEN
                    pkg_traza.trace('nuCausaActual -->' ||
                                   nucausaactual, csbNivelTraza);

                    isbrecovercurrentperiod := 'N';
                    nuconssub := LDC_PKGCONPR.fnuinfoavgconsofsubcat('LOC'); --Consumo por subcategoria sin proyeccion a los dias de consumo
                    cm_boconslogicservice.recoverzeroconsumption(5, isbrecovercurrentperiod, nuconssub, 150, sbfunconsrec, numetconsrec); -- 5: cantidad meses a recuperar, 150: Calificacion Consumo recuperado
                    cm_boestimateservices.assignconsuption(sbfunconsrec); --Asigna consumo promedio;
                    cm_boconslogicservice.setmanualqualification(sbfunconsrec, 150); -- Calificacion de recuperado

                ELSE
                    IF -- Si existe observacion de lectura
                    cm_boconslogicservice.fsbexistsonprevreadobs(nuobsempa) = 'S' -- EMPAÑADO O SUCIO
                    OR
                    cm_boconslogicservice.fsbexistsonprevreadobs(nuobspint) = 'S' -- PINTADO
                    OR
                    cm_boconslogicservice.fsbexistsonprevreadobs(nuobsilegible) = 'S' --ILEGIBLE
                    THEN
                        pkg_traza.trace('Existe Observacionn 37, 67, 11 -->' ||
                                       nucausaactual, csbNivelTraza);

                        NULL; -- Caso 2 DAA-157099
                    ELSE
                        pkg_traza.trace('Calcula Consumo, Asigna Consumo, Calificacion 1', csbNivelTraza);

                        cm_bocalcconsumpservs.readdifandcorrectfactor(nucantmesesrec, nuconsact, sbfunconsact, numetconsact); -- Consumo por diferencia de lecturas con factor de correccion
                        cm_boestimateservices.assignconsuption(sbfunconsact); --Asigna consumo promedio;
                        cm_boconslogicservice.setmanualqualification(sbfunconsact, 1); -- Calificacion normal
                    END IF;
                END IF;
            ELSE
                NULL; -- Caso 3 DAA-157099
                --Aranda 3411_3 07-05-2014
                pkg_traza.trace('sbIndtardia  Caso 3 - Retiro-->' ||
                               sbindtardia, csbNivelTraza);

                cm_bocalcconsumpservs.readdifandcorrectfactor(nucantmesesrec, nuconsact, sbfunconsact, numetconsact); -- Consumo por diferencia de lecturas con factor de correccion
                --CM_BOCONSLOGICSERVICE.LATEFORWARDRECOVERY (5, 'N', 1, sbfunconsact, numetconsact);
                cm_boestimateservices.assignconsuption(sbfunconsact); --Asigna consumo promedio;
                cm_boconslogicservice.setmanualqualification(sbfunconsact, 1); -- Calificacion normal
            END IF;
        ELSE
            --CA 200-1101 - se habilita esta parte para casos en que se legalice lectura antes del cambio de medidor
            -- JJSU 20140527:  En el caso de registro de lectura de instalacion no se realizara ninguna accion desde esta regla
            NULL;
            --Caso 4
            IF sbIndicaLect = 'S'
            AND tipo_lectura = 'I'
            AND sbIndtardia = 'S' THEN
                pkg_traza.trace('sbIndicaLect = S  y  tipo_lectura = I y sbIndtardia = S', csbNivelTraza);

                CM_BOCONSLOGICSERVICE.LATEFORWARDRECOVERY(5, 'S', 150, sbfunConsRec, nuMetConsRec); -- 5: cantidad meses a recuperar, 150: Calificacion Consumo recuperado
                --30-04-2014 Aranda 3411_2
                CM_BOESTIMATESERVICES.ASSIGNCONSUPTION(sbfunConsRec); --Asigna consumo promedio;
                CM_BOCONSLOGICSERVICE.SETMANUALQUALIFICATION(sbfunConsRec, 150); -- Calificacion de recuperado
            ELSE
                pkg_traza.trace('sbIndicaLect <> S  y  tipo_lectura <> I y sbIndtardia <> S', csbNivelTraza);

                NULL;
            END IF;
        END IF;
        -- end if;
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prlecturaretiro;

    PROCEDURE prgeneracritica
    (
        inuactivityid   IN ge_items.items_id%TYPE,
        isbordercomment IN or_order_comment.order_comment%TYPE,
        inuproducto     IN servsusc.sesunuse%TYPE,
        idtfechaestima  IN DATE,
        inuperiodo      IN pericose.pecscons%TYPE,
        inuleccons      IN lectelme.leemcons%TYPE
    ) IS
        /**************************************************************************
            Propiedad Intelectual de Gases del Cariba S.A. E.S.P
            Procedimiento     :  PrGeneraCritica
            Descripcion       :  Genera la critica
            Fecha             :  05-04-2016
            autor             :  Francisco Romero (Ludycom S.A.)
            Historia de Modificaciones
              Fecha               Autor                Modificación
            =========           =========          ====================
            21/07/2023          jcatuchemvm         OSF-1366: Actualización llamados cm_boordersutil.fnugenerate por api_createorder,
                                                    or_boordercomment.addcomment por api_addordercomment
            21/06/2017          Oscar Ospino P.     Ca 200-1202 Mejorar Control de Excepciones para
                                                    mostrarlos en la traza
        **************************************************************************/
        --Constantes
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prgeneracritica';

        -- Gestion de Errores
        nupaso  NUMBER := 0;
        -- Código de Orden
        nuorderid or_order_activity.order_id%TYPE;
        -- Código de Actividad
        nuorderactivity or_order_activity.order_activity_id%TYPE;
    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuactivityid   <= '||inuactivityid,csbNivelTraza);
        pkg_traza.trace('isbordercomment <= '||isbordercomment,csbNivelTraza);
        pkg_traza.trace('inuproducto     <= '||inuproducto,csbNivelTraza);
        pkg_traza.trace('idtfechaestima  <= '||to_char(idtfechaestima,csbFormato),csbNivelTraza);
        pkg_traza.trace('inuperiodo      <= '||inuperiodo,csbNivelTraza);
        pkg_traza.trace('inuleccons      <= '||inuleccons,csbNivelTraza);

        nupaso    := 5;

        api_createorder
        (
            inuitemsid          => inuactivityid,   -- Actividad
            inupackageid        => NULL,
            inumotiveid         => NULL,
            inucomponentid      => NULL,
            inuinstanceid       => NULL,
            inuaddressid        => pkg_bcproducto.fnuiddireccinstalacion(inuproducto),
            inuelementid        => NULL,
            inusubscriberid     => NULL,
            inusubscriptionid   => NULL,
            inuproductid        => inuProducto,     -- Producto
            inuoperunitid       => NULL,
            idtexecestimdate    => idtfechaestima,  -- Fecha estimada de ejecución, Pecsfecf
            inuprocessid        => NULL,
            isbcomment          => '-',
            iblprocessorder     => TRUE,
            inupriorityid       => NULL,            -- Prioridad
            inuordertemplateid  => NULL,
            isbcompensate       => NULL,
            inuconsecutive      => NULL,
            inurouteid          => NULL,
            inurouteconsecutive => NULL,
            inulegalizetrytimes => 0,
            isbtagname          => NULL,
            iblisacttogroup     => NULL,
            inurefvalue         => NULL,
            inuactionid         => NULL,
            ionuorderid         => nuorderid,
            ionuorderactivityid => nuorderactivity,
            onuErrorCode        => nuerror,
            osbErrorMessage     => sberror
        );

        IF nuerror != constants_per.OK THEN
            raise Pkg_Error.CONTROLLED_ERROR;
        end if;

        -- Se le agrega un comentario a la orden generada --
        nupaso := 10;

        api_addordercomment
        (
            nuorderid, -- ID de la orden
            or_boconstants.cnugeneraltype, -- Tipo de comentario
            isbordercomment, -- Comentario,
            nuerror,
            sberror
        );

        IF nuerror != constants_per.OK THEN
            raise Pkg_Error.CONTROLLED_ERROR;
        end if;

        pkg_traza.trace('-<<Orden de Trabajo Generada [' || nuorderid || ']>>-', csbNivelTraza);

        --Se crea el registro en CM_ORDECRIT
        nupaso := 15;
        INSERT INTO cm_ordecrit
            (orcrorde, orcrsesu, orcrpeco, orcrtico, orcrlect, orcrnofu, orcrobpa)
        VALUES
            (nuorderid, inuproducto, inuperiodo, 1, inuleccons, 'N', NULL);

        pkg_traza.trace('-<Orden de Trabajo Registrada en CM_ORDECRIT!>--', csbNivelTraza);

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            --Traza con los Pasos del Proceso
            pkg_traza.trace('--<Ultimo paso ejecutado: ' || nupaso || '>--', csbNivelTraza);
            nupaso := 0;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            --Traza con los Pasos del Proceso
            pkg_traza.trace('--<Ultimo paso ejecutado: ' || nupaso || '>--', csbNivelTraza);
            nupaso := 0;
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END prgeneracritica;

    FUNCTION fnucountserialreadobsperiod(inusearchedobservation IN lectelme.leemoble%TYPE --,
                                         --isbIncludeHistoricData  in  varchar2
                                         ) RETURN NUMBER IS

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnucountserialreadobsperiod';
        ---------------
        -- Variables --
        ---------------
        rccurrentreading    lectelme%ROWTYPE;
        rcorder             daor_order.styor_order;
        rcproduct           servsusc%ROWTYPE;
        nuactivity          remevaco.rmvcacti%TYPE;
        rcactiverule        remevaco%ROWTYPE;
        rcconsumptionperiod pericose%ROWTYPE;
        sbserial      VARCHAR2(1);
        nuserialcount NUMBER;
        sbmsgerr      VARCHAR2(2000);

        CURSOR cureadings
        (
            inuproduct              IN lectelme.leemsesu%TYPE,
            inumeasureelement       IN lectelme.leemelme%TYPE,
            inuconsumptiontype      IN lectelme.leemtcon%TYPE,
            inuconsumptionperiod    IN lectelme.leempecs%TYPE,
            isbincludecurrentperiod IN VARCHAR2
        ) IS
            SELECT leempecs, SUM(obs) obs, MAX(pecsfeci) pecsfeci
            FROM (SELECT /*+ leading(lectelme) index(lectelme IX_LECTELME07)  use_nl_with_index(pericose pk_pericose) */
                   leempecs,
                   SUM(CASE
                           WHEN (inusearchedobservation IN
                                (leemoble, leemobsb, leemobsc)) THEN
                            1
                           ELSE
                            0
                       END) obs,
                   MAX(pecsfeci) pecsfeci
                  FROM lectelme, pericose
                  WHERE leemclec = cm_boconstants.csbcaus_lect_bill -- Solo lecturas de Facturacion
                        AND pecscons = leempecs
                        AND
                        pecsfeci <=
                        nvl((SELECT /*+ PUSH_SUBQ */
                             decode(isbincludecurrentperiod, 'S', pecsfeci, pecsfeci - 1)
                            FROM pericose
                            WHERE pecscons = inuconsumptionperiod), pecsfeci)
                        AND leemsesu = inuproduct -- [p1] Producto
                        AND leemelme = inumeasureelement -- [p2] Elemento Medicion
                        AND leemtcon = inuconsumptiontype -- [p3] Tipo de Consumo
                  GROUP BY leempecs)
            GROUP BY leempecs
            ORDER BY pecsfeci DESC;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inusearchedobservation <= '||inusearchedobservation,csbNivelTraza);

        -------------------------------------------------------------
        -- Obiene informacion instanciada por el motor de consumos --
        -------------------------------------------------------------
        cm_boconsumptionengine.getenginememorydata(rccurrentreading, rcorder, rcproduct, nuactivity, rcactiverule, rcconsumptionperiod);
        sbserial      := 'S';
        nuserialcount := 0;

        FOR rgreadings IN cureadings(rcproduct.sesunuse, rccurrentreading.leemelme, rcactiverule.rmvctico, rcconsumptionperiod.pecscons, cm_bcmeasconsumptions.csbdonot_include_curr_per)
        LOOP
            IF sbserial = 'S' THEN
                IF nvl(rgreadings.obs, 0) > 0 THEN
                    nuserialcount := nuserialcount + 1;
                ELSE
                    sbserial := 'N';
                    EXIT;
                END IF;
            END IF;
        END LOOP;

        pkg_traza.trace('return => '||nuserialcount,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuserialcount;

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END fnucountserialreadobsperiod;

    /**************************************************************************
        Propiedad Intelectual de Gases del Cariba S.A. E.S.P
        Funcion     :  fnuCountSerialReadObsPeriod2
        Descripcion :  Devuelve la cantidad de observaciones consecutivas de lecturas (1 por periodo como max)
                       teniendo en cuenta un segundo parametro es decir trabaja con 9 y 3
        Fecha       :  15-03-2016
        autor       :  Francisco Romero (Ludycom)
        Historia de Modificaciones
          Fecha               Autor                Modificación
        =========           =========          ====================
    **************************************************************************/
    FUNCTION fnucountserialreadobsperiod2
    (
       inusearchedobservation  IN lectelme.leemoble%TYPE,
       inusearchedobservation2 IN lectelme.leemoble%TYPE
    ) RETURN NUMBER IS

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnucountserialreadobsperiod2';
        ---------------
        -- Variables --
        ---------------
        rccurrentreading    lectelme%ROWTYPE;
        rcorder             daor_order.styor_order;
        rcproduct           servsusc%ROWTYPE;
        nuactivity          remevaco.rmvcacti%TYPE;
        rcactiverule        remevaco%ROWTYPE;
        rcconsumptionperiod pericose%ROWTYPE;
        sbserial      VARCHAR2(1);
        nuserialcount NUMBER;
        sbmsgerr      VARCHAR2(2000);

        CURSOR cureadings
        (inuproduct              IN lectelme.leemsesu%TYPE,
         inumeasureelement       IN lectelme.leemelme%TYPE,
         inuconsumptiontype      IN lectelme.leemtcon%TYPE,
         inuconsumptionperiod    IN lectelme.leempecs%TYPE,
         isbincludecurrentperiod IN VARCHAR2
        ) IS
            SELECT leempecs, SUM(obs) obs, MAX(pecsfeci) pecsfeci
            FROM (SELECT /*+ leading(lectelme) index(lectelme IX_LECTELME07) use_nl_with_index(pericose pk_pericose) */
                   leempecs,
                   SUM(CASE
                           WHEN (inusearchedobservation IN
                                (leemoble, leemobsb, leemobsc)) THEN
                            1
                           ELSE
                            (CASE
                                WHEN (inusearchedobservation2 IN
                                     (leemoble, leemobsb, leemobsc)) THEN
                                 1
                                ELSE
                                 0
                            END)
                       END) obs,
                   MAX(pecsfeci) pecsfeci
                  FROM lectelme, pericose
                  WHERE leemclec = cm_boconstants.csbcaus_lect_bill -- Solo lecturas de Facturacion
                        AND pecscons = leempecs
                        AND
                        pecsfeci <=
                        nvl((SELECT /*+ PUSH_SUBQ */
                             decode(isbincludecurrentperiod, 'S', pecsfeci, pecsfeci - 1)
                            FROM pericose
                            WHERE pecscons = inuconsumptionperiod), pecsfeci)
                        AND leemsesu = inuproduct -- [p1] Producto
                        AND leemelme = inumeasureelement -- [p2] Elemento Medicion
                        AND leemtcon = inuconsumptiontype -- [p3] Tipo de Consumo
                  GROUP BY leempecs)
            GROUP BY leempecs
            ORDER BY pecsfeci DESC;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inusearchedobservation  <= '||inusearchedobservation,csbNivelTraza);
        pkg_traza.trace('inusearchedobservation2 <= '||inusearchedobservation2,csbNivelTraza);
        -------------------------------------------------------------
        -- Obiene informacion instanciada por el motor de consumos --
        -------------------------------------------------------------
        cm_boconsumptionengine.getenginememorydata(rccurrentreading, rcorder, rcproduct, nuactivity, rcactiverule, rcconsumptionperiod);
        sbserial      := 'S';
        nuserialcount := 0;

        FOR rgreadings IN cureadings(rcproduct.sesunuse, rccurrentreading.leemelme, rcactiverule.rmvctico, rcconsumptionperiod.pecscons, cm_bcmeasconsumptions.csbdonot_include_curr_per)
        LOOP

            IF sbserial = 'S' THEN

                IF nvl(rgreadings.obs, 0) > 0 THEN
                    nuserialcount := nuserialcount + 1;
                ELSE
                    sbserial := 'N';
                    EXIT;
                END IF;

            END IF;

        END LOOP;

        pkg_traza.trace('return => '||nuserialcount,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuserialcount;

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END fnucountserialreadobsperiod2;

    /**************************************************************************
        Propiedad Intelectual de Gases del Caribe S.A. E.S.P
        Funcion     :  fnuCountSerialReadObsPeriod3
        Descripcion :  Devuelve la cantidad de observaciones consecutivas de NO lecturas (1 por periodo como max)
                       teniendo en cuenta un segundo parametro es decir trabaja con 9 y 3
        Fecha       :  22-12-2015
        autor       :  Jesus Vivero (Ludycom)
        Historia de Modificaciones
          Fecha               Autor                Modificación
        =========           =========          ====================
    **************************************************************************/
    FUNCTION fnucountserialreadobsperiod3
    (
        inusearchedobservation  IN lectelme.leemoble%TYPE,
        inusearchedobservation2 IN lectelme.leemoble%TYPE
    ) RETURN NUMBER IS

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnucountserialreadobsperiod3';
        ---------------
        -- Variables --
        ---------------
        rccurrentreading    lectelme%ROWTYPE;
        rcorder             daor_order.styor_order;
        rcproduct           servsusc%ROWTYPE;
        nuactivity          remevaco.rmvcacti%TYPE;
        rcactiverule        remevaco%ROWTYPE;
        rcconsumptionperiod pericose%ROWTYPE;
        sbserial      VARCHAR2(1);
        nuserialcount NUMBER;
        sbmsgerr      VARCHAR2(2000);

        CURSOR cureadings
        (
            inuproduct              IN lectelme.leemsesu%TYPE,
            inumeasureelement       IN lectelme.leemelme%TYPE,
            inuconsumptiontype      IN lectelme.leemtcon%TYPE,
            inuconsumptionperiod    IN lectelme.leempecs%TYPE,
            isbincludecurrentperiod IN VARCHAR2
        ) IS
            SELECT leempecs, SUM(obs) obs, MAX(pecsfeci) pecsfeci
            FROM (SELECT /*+ leading(lectelme) index(lectelme IX_LECTELME07) use_nl_with_index(pericose pk_pericose) */
                   leempecs,
                   SUM(CASE
                           WHEN ((leemoble IS NULL AND leemobsb IS NULL AND
                                leemobsc IS NULL) OR
                                (76 IN (leemoble, leemobsb, leemobsc))) THEN
                            0
                           ELSE
                            (CASE
                                WHEN (inusearchedobservation IN
                                     (leemoble, leemobsb, leemobsc)) THEN
                                 0
                                ELSE
                                 (CASE
                                     WHEN (inusearchedobservation2 IN
                                          (leemoble, leemobsb, leemobsc)) THEN
                                      0
                                     ELSE
                                      1
                                 END)
                            END)
                       END) obs,
                   MAX(pecsfeci) pecsfeci
                  FROM lectelme, pericose
                  WHERE leemclec = cm_boconstants.csbcaus_lect_bill -- Solo lecturas de Facturacion
                        AND pecscons = leempecs
                        AND
                        pecsfeci <=
                        nvl((SELECT /*+ PUSH_SUBQ */
                             decode(isbincludecurrentperiod, 'S', pecsfeci, pecsfeci - 1)
                            FROM pericose
                            WHERE pecscons = inuconsumptionperiod), pecsfeci)
                        AND leemsesu = inuproduct -- [p1] Producto
                        AND leemelme = inumeasureelement -- [p2] Elemento Medicion
                        AND leemtcon = inuconsumptiontype -- [p3] Tipo de Consumo
                  GROUP BY leempecs)
            GROUP BY leempecs
            ORDER BY pecsfeci DESC;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inusearchedobservation  <= '||inusearchedobservation,csbNivelTraza);
        pkg_traza.trace('inusearchedobservation2 <= '||inusearchedobservation2,csbNivelTraza);

        -------------------------------------------------------------
        -- Obiene informacion instanciada por el motor de consumos --
        -------------------------------------------------------------
        cm_boconsumptionengine.getenginememorydata(rccurrentreading, rcorder, rcproduct, nuactivity, rcactiverule, rcconsumptionperiod);
        sbserial      := 'S';
        nuserialcount := 0;

        FOR rgreadings IN cureadings(rcproduct.sesunuse, rccurrentreading.leemelme, rcactiverule.rmvctico, rcconsumptionperiod.pecscons, cm_bcmeasconsumptions.csbdonot_include_curr_per)
        LOOP

            IF sbserial = 'S' THEN

                IF nvl(rgreadings.obs, 0) > 0 THEN
                    nuserialcount := nuserialcount + 1;
                ELSE
                    sbserial := 'N';
                    EXIT;
                END IF;

            END IF;

        END LOOP;

        pkg_traza.trace('return => '||nuserialcount,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuserialcount;


    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END fnucountserialreadobsperiod3;

    /*****************************************************************
      Propiedad Intelectual de Gases del Caribe S.A. E.S.P
      Unidad         : prReglasAVCIndustriales
      Descripcion    : Procedimiento para asignar el consumo y calificación según AVC.
      Autor          : Desconocido
      Fecha          : XX/XX/XXXX
      Parametros              Descripcion
      ============         ===================
      Fecha             Autor               Modificacion
      =========         =========           ====================
        XX/XX/XXXX      Desconocido         Creación
        04/08/2023      jcatuchemvm         OSF-1086: Se agrega llamado fnuObtieneConsumosPrevios para consulta alterna de históricos de consumos, el cual
                                            no tiene en cuenta los consumos pendientes por liquidar, entre ellos los recuperados. Se conserva el llamado
                                            original de open cm_boestimateservices.getnthprevconsumption, el cual internamente hace validaciones adicionales
        18-09-2023      jcatuchemvm         OSF-1440: Se agrega validación de observación de no lectura para estimar y generar crítica
        20/09/2024      jcatuche            OSF-3181: Se elimina definición de variable local nuanacrit
    ******************************************************************/
    PROCEDURE prReglasAVCIndustriales
    (
        sbindicalect        IN VARCHAR2,
        nucausanolect       IN lectelme.leemoble%TYPE,
        nuconsact           IN conssesu.cosscoca%TYPE,
        nucalificacion      IN calivaco.cavccodi%TYPE, -- Calificacion devuelta
        rccurrentreading    IN OUT lectelme%ROWTYPE, -- Lectura procesada
        rcorder             IN OUT daor_order.styOR_order, -- Orden
        rcproduct           IN OUT servsusc%ROWTYPE, -- Producto
        nuactivity          IN OUT remevaco.rmvcacti%TYPE, -- Escenario / Actividad
        rcactiverule        IN OUT remevaco%ROWTYPE, -- Regla que se esta ejecutando
        rcconsumptionperiod IN OUT pericose%ROWTYPE -- Periodo de Consumo
    ) IS
        --Variables/Constantes Gestion de Errores
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prReglasAVCIndustriales';
        nupaso          NUMBER := 0;

        --Variables Parametros
        numesesrecup    NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_MESES_RECUPERAR_CONSUMO'); --Meses para Recuperar Consumos
        isbordcom       VARCHAR2(1000) := 'Orden generada por proceso de reglas AVC (Industriales)';
        sbObservaciones VARCHAR2 (4000) := pkg_parametros.fsbGetValorCadena('OBSERVACIONES_NLECTURA_LECTESP');
        sbValidaObse    VARCHAR2(1);
        nucons1         conssesu.cosscoca%type;
        nucons2         conssesu.cosscoca%type;
        nucons3         conssesu.cosscoca%type;
        nucons4         conssesu.cosscoca%type;
        nucons5         conssesu.cosscoca%type;
        sbfuncons1      conssesu.COSSFUFA%type;
        sbfuncons2      conssesu.COSSFUFA%type;
        sbfuncons3      conssesu.COSSFUFA%type;
        sbfuncons4      conssesu.COSSFUFA%type;
        sbfuncons5      conssesu.COSSFUFA%type;
        numetcons1      conssesu.cossmecc%type;
        numetcons2      conssesu.cossmecc%type;
        numetcons3      conssesu.cossmecc%type;
        numetcons4      conssesu.cossmecc%type;
        numetcons5      conssesu.cossmecc%type;

        nuEstadoProd    NUMBER;
        blGeneraCritica BOOLEAN;

        CURSOR cuGetEstadoprod(nuproducto IN servsusc.sesunuse%type) IS
        SELECT PRODUCT_STATUS_ID
        FROM pr_product
        WHERE product_id = nuproducto;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('sbindicalect    <= '||sbindicalect,csbNivelTraza);
        pkg_traza.trace('nucausanolect   <= '||nucausanolect,csbNivelTraza);
        pkg_traza.trace('nuconsact       <= '||nuconsact,csbNivelTraza);
        pkg_traza.trace('nucalificacion  <= '||nucalificacion,csbNivelTraza);
        pkg_traza.trace('leemcons        <= '||rccurrentreading.leemcons,csbNivelTraza);
        pkg_traza.trace('order_id        <= '||rcorder.order_id,csbNivelTraza);
        pkg_traza.trace('sesunuse        <= '||rcproduct.sesunuse,csbNivelTraza);
        pkg_traza.trace('nuactivity      <= '||nuactivity,csbNivelTraza);
        pkg_traza.trace('rmvccons        <= '||rcactiverule.rmvccons,csbNivelTraza);
        pkg_traza.trace('pecscons        <= '||rcconsumptionperiod.pecscons,csbNivelTraza);

        sbValidaObse := 'N';
        BEGIN
            IF sbindicalect = 'S' THEN
                nupaso := 5;
                --Establecer consumo por Diferencia de Lecturas
                ldc_bssreglasproclecturas.prEstablecerConsumo('DIF', nuconsact, nucalificacion, FALSE);

            ELSE
                IF NVL(INSTR(','||sbObservaciones||',',','||nucausanolect||','),0) = 0 THEN

                    nupaso := 10;
                    --Establecer consumo Cero
                    pkg_traza.trace('--<Llama Proceso asigna Consumo Cero>--', csbNivelTraza);
                    ldc_bssreglasproclecturas.prEstablecerConsumo('CERO', nuconsact, nucalificacion, FALSE);

                ELSE
                    nupaso := 13;
                    --Establece consumo promedio
                    pkg_traza.trace('--<Llama Proceso asigna Consumo Promedio>--', csbNivelTraza);
                    ldc_bssreglasproclecturas.prEstablecerConsumo('PROM', nuconsact, nucalificacion, FALSE);
                    sbValidaObse := 'S';
                END IF;

            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                sberror := 'Error al EstablecerConsumo ';
                pkg_traza.trace(sberror, csbNivelTraza);
                RAISE Pkg_Error.CONTROLLED_ERROR; --No se hace setError antes ya que prEstablecer Consumo lo hace
        END;

        pkg_traza.trace('--<Categoria Producto: ' ||
                       nvl(to_char(rcproduct.sesucate), 'NULL') || '>--', csbNivelTraza);

        --Valida Categoria Industrial para generar critica cuando es Desviado
        IF rcproduct.sesucate IN (3) THEN
            --Valida la observación
            IF sbValidaObse = 'N' THEN
                nupaso := 15;
                IF nucalificacion = 1 THEN
                    pkg_traza.trace('--<Calificacion Normal - sin Desviacion>--', csbNivelTraza);
                    blGeneraCritica := FALSE;
                    nupaso := 20;
                ELSE
                    pkg_traza.trace('--<Desviacion! >>> Genera Critica 12619>--', csbNivelTraza);

                    nupaso := 25;
                    blGeneraCritica := TRUE;
                    cm_boestimateservices.getnthprevconsumption(1, nucons1, sbfuncons1, numetcons1);
                    cm_boestimateservices.getnthprevconsumption(2, nucons2, sbfuncons2, numetcons2);
                    cm_boestimateservices.getnthprevconsumption(3, nucons3, sbfuncons3, numetcons3);
                    cm_boestimateservices.getnthprevconsumption(4, nucons4, sbfuncons4, numetcons4);
                    cm_boestimateservices.getnthprevconsumption(5, nucons5, sbfuncons5, numetcons5);

                    --Funcionalidad alterna para obtener los consumos históricos liquidados.
                    nucons1 := fnuObtieneConsumosPrevios(rcproduct.sesunuse,rcactiverule.rmvctico,rcconsumptionperiod.pecscons,1);
                    nucons2 := fnuObtieneConsumosPrevios(rcproduct.sesunuse,rcactiverule.rmvctico,rcconsumptionperiod.pecscons,2);
                    nucons3 := fnuObtieneConsumosPrevios(rcproduct.sesunuse,rcactiverule.rmvctico,rcconsumptionperiod.pecscons,3);
                    nucons4 := fnuObtieneConsumosPrevios(rcproduct.sesunuse,rcactiverule.rmvctico,rcconsumptionperiod.pecscons,4);
                    nucons5 := fnuObtieneConsumosPrevios(rcproduct.sesunuse,rcactiverule.rmvctico,rcconsumptionperiod.pecscons,5);

                    IF cuGetEstadoprod%ISOPEN THEN
                       CLOSE cuGetEstadoprod;
                    END IF;

                    OPEN cuGetEstadoprod(rcproduct.sesunuse);
                    FETCH cuGetEstadoprod INTO nuEstadoProd;
                    CLOSE cuGetEstadoprod;

                    pkg_traza.trace('--< nuEstadoProd: ' ||
                                   nuEstadoProd ||
                                   ' | nucons5: ' ||
                                  nucons5 ||
                                   ' | nucons4: '||
                                   nucons4||
                                    ' | nucons3: '||
                                   nucons3||
                                    ' | nucons2: '||
                                   nucons2||
                                    ' | nucons1: '||
                                   nucons1||
                                   '>--', csbNivelTraza);

                    pkg_traza.trace('--< Fecha Final Pericose: ' ||
                                   nvl(to_char(rcconsumptionperiod.pecsfecf), 'NULL') ||
                                   ' | Consecutivo Lectura (Lectelme.leemcons): ' ||
                                   nvl(to_char(rccurrentreading.leemcons), 'NULL') ||
                                   ' | nuEstadoProd: '||
                                   nuEstadoProd||
                                   '>--', csbNivelTraza);

                    IF nuEstadoProd = 2 AND nuconsact = 0 THEN
                       blGeneraCritica := FALSE;
                    ELSIF nuEstadoProd = 1 AND ( NVL(round(nuconsact,0),0) + NVL(round(nucons2,0),0) + NVL(round(nucons3,0),0) + NVL(round(nucons4,0),0) + NVL(round(nucons5,0),0) ) = 0 THEN
                       blGeneraCritica := FALSE;
                    END IF;
                END IF;
            ELSE
                blGeneraCritica := TRUE;
            END IF;

            IF blGeneraCritica THEN

                BEGIN
                    prgeneracritica(nuanacrit, isbordcom, rcproduct.sesunuse, rcconsumptionperiod.pecsfecf, rcconsumptionperiod.pecscons, rccurrentreading.leemcons);
                EXCEPTION
                    WHEN OTHERS THEN
                        sberror := 'Error al generar OT de Critica 12619 - Actividad ' ||nuanacrit;
                        pkg_traza.trace(sberror, csbNivelTraza);
                        RAISE Pkg_Error.CONTROLLED_ERROR; --No se hace setError antes ya que prgeneracritica lo hace
                END;

            END IF;

        END IF;

        pkg_traza.trace('leemcons    => '||rccurrentreading.leemcons,csbNivelTraza);
        pkg_traza.trace('order_id    => '||rcorder.order_id,csbNivelTraza);
        pkg_traza.trace('sesunuse    => '||rcproduct.sesunuse,csbNivelTraza);
        pkg_traza.trace('nuactivity  => '||nuactivity,csbNivelTraza);
        pkg_traza.trace('rmvccons    => '||rcactiverule.rmvccons,csbNivelTraza);
        pkg_traza.trace('pecscons    => '||rcconsumptionperiod.pecscons,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuerror, sberror);
            sberror := csbFEC||csbMetodo|| ' | Paso (' ||
                       nupaso || ')' || 'Detalle: ' || sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            nupaso := 0;
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            sberror := csbFE||csbMetodo|| ' | Paso (' ||
                       nupaso || ')' || 'Detalle: ' || sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            nupaso := 0;
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror);
    END prReglasAVCIndustriales;

    /*****************************************************************
      Propiedad Intelectual de Gases del Caribe S.A. E.S.P
      Unidad         : prEstablecerConsumo
      Descripcion    : Procedimiento para establecer consumo
      Autor          : Desconocido
      Fecha          : XX/XX/XXXX
      Parametros              Descripcion
      ============         ===================
      Fecha             Autor               Modificacion
      =========         =========           ====================

        18-09-2023      jcatuchemvm         OSF-1440: Se ajusta descripción constante csbOBTECOPP y csbOBTECOPP obteniendola desde el paquete cm_boestimateservices.
        XX/XX/XXXX      Desconocido         Creación
    ******************************************************************/
    PROCEDURE prEstablecerConsumo
    (
        sbTipo            IN VARCHAR2,
        nuConsumo         IN FLOAT,
        nuCalificacion    IN NUMBER,
        boGeneraRelectura IN BOOLEAN
    ) IS
        --Constantes
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prEstablecerConsumo';

        -- Funciones de Calculo de Consumos
        ------------------------------------------------------------------------------------------------
        -- Calcular consumo por Diferencia de Lecturas
        csbCALCCODL CONSTANT conssesu.cossfufa%TYPE := 'CALCCODL - Calcular Consumo por Diferencia de Lecturas';
        -- CALCCOLA - Calcular Consumo por Lectura Anterior --
        csbCALCCOLA CONSTANT conssesu.cossfufa%TYPE := 'CALCCOLA - Calcular Consumo por Lectura Anterior';
        -- Calcular consumo por Diferencia de Lecturas aplicando factor de Correccion
        csbCONSDLFC CONSTANT conssesu.cossfufa%TYPE := 'CONSDLFC - Consumo por Diferencia de Lecturas aplicando Factor de Correccion';
        -- Calcular consumo por Lectura anterior aplicando factor de Correccion
        csbCONSLAFC CONSTANT conssesu.cossfufa%TYPE := 'CONSLAFC - Consumo por Lectura anterior aplicando Factor de Correccion';
        -- Obtener consumo promedio subcategaria
        csbOBTECOPS CONSTANT conssesu.cossfufa%TYPE := cm_boestimateservices.CSBOBTECOPS;
        -- Obtener Consumo Promedio Individual de los ultimos meses parametrizados
        csbOBTECOPP CONSTANT conssesu.cossfufa%TYPE := cm_boestimateservices.CSBOBTECOPP;
        -- Calcular el consumo promedio Individual de los ultimos N periodos
        csbCALCCOPN CONSTANT conssesu.cossfufa%TYPE := 'CALCCOPN - Calcular el consumo promedio Individual de los ultimos N periodos';
        -- Calcular el consumo promedio estacional de los ultimos N periodos
        csbCALCCPEN CONSTANT conssesu.cossfufa%TYPE := 'CALCCPEN - Calcular el consumo promedio estacional de los ultimos N periodos';
        -- Obtener Estimacion Consumo por Carga Instalada
        csbOBTEESCI CONSTANT conssesu.cossfufa%TYPE := 'OBTEESCI - Obtener Estimacion Consumo por Carga Instalada';
        -- Obtener Consumo Aforado
        csbOBTECOAF CONSTANT conssesu.cossfufa%TYPE := 'OBTECOAF - Obtener Consumo Aforado';
        -- Obtener Enesimo Consumo Facturado Anterior
        csbOBTEENCF CONSTANT conssesu.cossfufa%TYPE := 'OBTEENCF - Obtener Enesimo Consumo Facturado Anterior';
        -- Obtener consumo facturado anterior
        csbOBTECOFA CONSTANT conssesu.cossfufa%TYPE := 'OBTECOFA - Obtener consumo facturado anterior';
        -- Ajustar consumo por dias de Ocupacion
        csbAJUSDIUS CONSTANT conssesu.cossfufa%TYPE := 'AJUSDIUS - Ajuste por Dias de Uso del Servicio';
        -- Establece manualmente el consumo
        csbESTACONS CONSTANT conssesu.cossfufa%TYPE := 'ESTACONS - Establecer Consumo Manualmente';
        -- Obtener Consumo Aforado por Numero de Dias
        csbOBTECAND CONSTANT conssesu.cossfufa%TYPE := 'OBTECAND - Obtener Consumo Aforado por Numero de Dias';
        ------------------------------------------------------------------------------------------------
        -- Gestion de Errores
        nupaso  NUMBER := 0;

        --Variables Parametros
        numesesrecup NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('CANT_MESES_RECUPERAR_CONSUMO'); --Meses para Recuperar Consumos

        --Variables
        nuconsact conssesu.cosscoca%TYPE := nuConsumo; --Consumo Actual
        sbFuncion conssesu.cossfufa%TYPE;
        nuMetodo  conssesu.cossmecc%TYPE;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('sbTipo              <= '||sbTipo,csbNivelTraza);
        pkg_traza.trace('nuConsumo           <= '||nuConsumo,csbNivelTraza);
        pkg_traza.trace('nuCalificacion      <= '||nuCalificacion,csbNivelTraza);
        pkg_traza.trace('boGeneraRelectura   <= '||(case when boGeneraRelectura then 'True' else 'False' end),csbNivelTraza);

        IF upper(sbTipo) = 'DIF' THEN

            pkg_traza.trace('--< DIF -->Diferencia de Lecturas => COnsumo Actual >--', csbNivelTraza);

            nupaso := 5;
            cm_bocalcconsumpservs.readdifandcorrectfactor(numesesrecup, nuconsact, sbFuncion, nuMetodo);
            cm_boestimateservices.assignconsuption(sbFuncion); -- ASIGNA CONSUMO CALCULADO
            cm_boconslogicservice.setmanualqualification(sbFuncion, nuCalificacion);
        ELSIF upper(sbTipo) = 'CERO' THEN

            pkg_traza.trace('--< CERO -->Establece COnsumo Cero con Metodo Manual >--', csbNivelTraza);

            nupaso := 10;
            cm_boestimateservices.establishconsumption(0, sbFuncion, nuMetodo);
            cm_boestimateservices.assignconsuption(sbFuncion);
            cm_boconslogicservice.setmanualqualification(sbFuncion, nuCalificacion); -- APLICA CALIFICACION ACTUAL
        ELSIF upper(sbTipo) = 'PROM' THEN

            pkg_traza.trace('--< PROM -->ASIGNA CONSUMO PROMEDIO >--', csbNivelTraza);

            nupaso := 15;
            cm_boestimateservices.assignconsuption(csbOBTECOPP);
            cm_boconslogicservice.setmanualqualification(csbOBTECOPP, nuCalificacion); -- APLICA CALIFICACION ACTUAL
        ELSIF upper(sbTipo) = 'PROMSUCA' THEN

            pkg_traza.trace('--< PROM -->ASIGNA CONSUMO PROMEDIO SUBCATEGORIA >--', csbNivelTraza);

            nupaso := 20;
            cm_boestimateservices.assignconsuption(csbOBTECOPS);
            cm_boconslogicservice.setmanualqualification(csbOBTECOPS, nuCalificacion); -- APLICA CALIFICACION ACTUAL
        ELSE
            nupaso  := 25;
            sberror := 'No se indico un tipo de accion valido para establecer el consumo.';
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror );

        END IF;

        IF boGeneraRelectura = TRUE THEN
            pkg_traza.trace('--< Genera Relectura >--', csbNivelTraza);

            nupaso := 30;
            cm_boconslogicservice.generaterereadingorder();

        END IF;

        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuerror, sberror);
            sberror := csbFEC||csbMetodo|| ' | Paso (' ||
                       nupaso || ')' || 'Detalle: ' || sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            nupaso := 0;
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            sberror := csbFE||csbMetodo|| ' | Paso (' ||
                       nupaso || ')' || 'Detalle: ' || sberror;
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            nupaso := 0;
            Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
    END prEstablecerConsumo;

    PROCEDURE prObtConsRecup
    (
        nuproducto          IN conssesu.cosssesu%TYPE,
        nuPeriodoConsumo    IN conssesu.cosspecs%TYPE,
        onuvolRecuperado    OUT NOCOPY conssesu.cosscoca%TYPE, --Consumo Recuperado Proyectado a Periodo Actual(Parametro)
        osbFlagRecuperacion OUT NOCOPY VARCHAR2,
        onuPeriodosRecup    OUT NUMBER, --Numero de Periodos Recuperados
        onuconsumoAct       OUT NOCOPY conssesu.cosscoca%TYPE, --Consumo Periodo Actual
        onuconsumo1         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo2         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo3         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo4         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo5         OUT NOCOPY conssesu.cosscoca%TYPE,
        onuconsumo6         OUT NOCOPY conssesu.cosscoca%TYPE
    ) IS
        /***********************************************************************************************
        Propiedad intelectual de Gases del Caribe.
        Nombre del Paquete: prObtConsRecup
        Descripcion:        Proceso para obtener el consumo recuperado proyectado segun el consumo del Periodo
                            registrado con Metodo 1 (Diferencia de Lecturas)
        Autor    : Oscar Ospino P CA 200-1202
        Fecha    : 16-07-2017
        Historia de Modificaciones
        DD-MM-YYYY    <Autor>.              dModificación
        -----------  --------------------    -------------------------------------
        16-07-2017   Oscar Ospino P         Creacion
        ***********************************************************************************************/
        --Constantes
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'prObtConsRecup';

        --Variables
        nupefaRecupera          perifact.pefacodi%TYPE; --Periodo Facturacion Recuperado (Mes Anterior)
        nupecoRecupera          pericose.pecscons%TYPE; --Periodo Consumo Recuperado (Mes Anterior)
        nuconsrecuppefa         conssesu.cosscoca%TYPE; --Consumo Recuperado (Mes Anterior)
        nudiasConsRecupera      conssesu.cossdico%TYPE; --Dias Consumo Recuperado (Mes Anterior)
        nudiasConsPeriodoAct    conssesu.cossdico%TYPE; --Dias Consumo Periodo Actual
        nuConsumoDiarioEstimado conssesu.cosscoca%TYPE; --Factor diario Consumo Recuperado

        --Control de Excepciones/traza
        sbMsg   VARCHAR2(4000);
        nupaso  NUMBER := 0;

        --Cursores
        CURSOR cuRecupera IS
        --Obtengo los Consumos Recuperados (Metodo 5)
            SELECT ROWNUM ID, pefa, peco, consumo_rec, diasconsumo, volumenRec
            FROM (SELECT c.cosspefa pefa,
                         c.cosspecs peco,
                         c.cosscoca consumo_rec,
                         c.cossdico diasconsumo,
                         TRUNC(c.cosscoca / c.cossdico, 10) volumenRec
                  FROM conssesu c
                  WHERE C.COSSSESU = nuproducto
                        AND c.cossmecc = 5
                        AND --Metodo Recuperado
                        c.cosspecs <= nuPeriodoConsumo
                        AND EXISTS (SELECT *
                         FROM conssesu c2
                         WHERE C2.COSSSESU = nuproducto
                               AND c2.cosspecs = nuPeriodoConsumo
                               AND c2.cossfufa LIKE '%CONSDLFC%'
                               AND c2.cossmecc = 1
                               AND c.cossfere BETWEEN c2.cossfere AND
                               c2.cossfere + 5 / 24 / 3600) --intervalo de N segundos desde la Fecha del 1er registro por Metodo 1-Dif. de Lectura en el Periodo actual
                        AND NOT EXISTS
                   (SELECT *
                         FROM conssesu c4
                         WHERE C4.COSSSESU = nuproducto
                               AND c4.cosspecs = nuPeriodoConsumo
                               AND c4.cossmecc = 5)
                  GROUP BY rownum,
                           c.cosspefa,
                           c.cosspecs,
                           c.cosscoca,
                           c.cossdico
                  ORDER BY C.COSSPEFA DESC);

        CURSOR CudiasPeriodoConsumo IS
        --Dias Consumo Periodo Actual
            SELECT MAX(c.cossdico) dias
            FROM conssesu c
            WHERE C.COSSSESU = nuproducto
                  AND --Consumo por Diferencia de Lecturas
                  c.cosspecs = nuPeriodoConsumo;

        CURSOR cuConsFacturado IS
            SELECT ROWNUM - 1 id, a.*
            FROM (SELECT DISTINCT c.cosspefa pefa,
                                  c.cosspecs peco,
                                  (SELECT nvl(SUM(c2.cosscoca), 0) Consumo_facturado
                                   FROM conssesu c2
                                   WHERE C2.COSSSESU = nuproducto
                                         AND c2.cossmecc = 4
                                         AND --Metodo Facturado
                                         c2.cosspecs = c.cosspecs) Consumo_facturado
                  FROM conssesu c
                  WHERE C.COSSSESU = nuproducto
                        AND c.cosspecs <= nuPeriodoConsumo
                  ORDER BY C.COSSPEFA DESC) a
            WHERE ROWNUM <= 7;
        rcRecupera cuRecupera%ROWTYPE;
        rcdpact    CudiasPeriodoConsumo%ROWTYPE;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('nuproducto          <= '||nuproducto,csbNivelTraza);
        pkg_traza.trace('nuPeriodoConsumo    <= '||nuPeriodoConsumo,csbNivelTraza);

        osbFlagRecuperacion := 'N';
        nupaso := 5;

        FOR rcconsfact IN cuConsFacturado
        LOOP

            --Se actualizan las variables de salida (Consumo de Meses anteriores) si se vieron afectadas por alguna recuperacion
            IF rcconsfact.ID = 0 THEN
                onuconsumoAct := rcconsfact.Consumo_facturado; --nuConsumoAct - Periodo Actual
            ELSIF rcconsfact.ID = 1 THEN
                onuconsumo1 := rcconsfact.Consumo_facturado; --nuConsumo1 - Periodo Anterior
            ELSIF rcconsfact.ID = 2 THEN
                onuconsumo2 := rcconsfact.Consumo_facturado;
            ELSIF rcconsfact.ID = 3 THEN
                onuconsumo3 := rcconsfact.Consumo_facturado;
            ELSIF rcconsfact.ID = 4 THEN
                onuconsumo4 := rcconsfact.Consumo_facturado;
            ELSIF rcconsfact.ID = 5 THEN
                onuconsumo5 := rcconsfact.Consumo_facturado;
            ELSIF rcconsfact.ID = 6 THEN
                onuconsumo6 := rcconsfact.Consumo_facturado; --nuConsumo6 - Periodo mas antiguo

            END IF;
        END LOOP;

        --Dias Consumo Periodo Actual
        nupaso := 10;

        FOR rcdpact IN CudiasPeriodoConsumo
        LOOP
            nudiasConsPeriodoAct := rcdpact.dias;
        END LOOP;

        pkg_traza.trace(''||nudiasConsPeriodoAct,csbNivelTraza);

        /*If nudiasConsPeriodoAct Is Null Or nudiasConsPeriodoAct = 0 Then
          --Ojo esto funciona con las Relecturas
          sberror := 'Error al obtener el numero de dias de Consumo del periodo actual. Validar consumo Facturado/Registrado';
          pkg_traza.trace(sberror, csbNivelTraza);
          Pkg_Error.setErrorMessage( isbMsgErrr => sberror );
          Raise Pkg_Error.CONTROLLED_ERROR;
        End If;*/
        nupaso := 15;

        FOR rcRecupera IN cuRecupera
        LOOP
            nupefaRecupera          := rcRecupera.pefa;
            nupecoRecupera          := rcRecupera.peco;
            nuconsrecuppefa         := rcRecupera.consumo_rec;
            nudiasConsRecupera      := rcRecupera.diasconsumo;
            nuConsumoDiarioEstimado := rcRecupera.volumenRec;
            onuPeriodosRecup        := nvl(onuPeriodosRecup, 0) + 1;
            osbFlagRecuperacion     := 'S';
        END LOOP;

        onuPeriodosRecup := nvl(onuPeriodosRecup, 0);
        --Valido que hayan datos en las variables del Cursor cuRecupera
        nupaso := 20;

        IF nupefaRecupera IS NULL
        OR nupecoRecupera IS NULL
        OR nuconsrecuppefa IS NULL
        OR nudiasConsRecupera IS NULL
        OR nuConsumoDiarioEstimado IS NULL THEN

            sberror             := 'Error al obtener el volumen recuperado del periodo anterior.';
            osbFlagRecuperacion := 'N';
            pkg_traza.trace(sberror, csbNivelTraza);
        END IF;

        nupaso := 25;

        IF nudiasConsPeriodoAct > 0
        AND nuConsumoDiarioEstimado > 0 THEN

            --Calculo el Volumen recuperado proyectado para el Periodo anterior al pasado por parametro
            onuvolRecuperado    := nudiasConsPeriodoAct *
                                   nuConsumoDiarioEstimado;
            osbFlagRecuperacion := 'S';
        ELSE
            osbFlagRecuperacion := 'N';
        END IF;

        onuvolRecuperado := trunc(nvl(onuvolRecuperado, 0));

        nupaso := 30;

        sbMsg  := sbMsg || chr(10) || 'Flag Tiene Vol Recuperado' || ' | ' ||
                  osbFlagRecuperacion;

        sbMsg  := sbMsg || chr(10) || 'Per. Fact Recuperado' || ' | ' ||
                  'Per. Consumo Recuperado' || ' | ' ||
                  'Consumo Recuperado Periodo' || ' | ' || 'Dias Recuperados' ||
                  ' | ' || 'Consumo Diario Estimado';

        sbMsg  := sbMsg || chr(10) || nupefaRecupera || ' | ' || nupecoRecupera ||
                  ' | ' || nuconsrecuppefa || ' | ' || nudiasConsRecupera ||
                  ' | ' || nuConsumoDiarioEstimado;

        sbMsg  := sbMsg || chr(10) || '--<Vol. Recuperado Proyectado' || ' | ' ||
                  onuvolRecuperado || '>--';

        pkg_traza.trace(sbMsg, csbNivelTraza);

        pkg_traza.trace('onuvolRecuperado    => '||onuvolRecuperado,csbNivelTraza);
        pkg_traza.trace('osbFlagRecuperacion => '||osbFlagRecuperacion,csbNivelTraza);
        pkg_traza.trace('onuPeriodosRecup    => '||onuPeriodosRecup,csbNivelTraza);
        pkg_traza.trace('onuconsumoAct       => '||onuconsumoAct,csbNivelTraza);
        pkg_traza.trace('onuconsumo1         => '||onuconsumo1,csbNivelTraza);
        pkg_traza.trace('onuconsumo2         => '||onuconsumo2,csbNivelTraza);
        pkg_traza.trace('onuconsumo3         => '||onuconsumo3,csbNivelTraza);
        pkg_traza.trace('onuconsumo4         => '||onuconsumo4,csbNivelTraza);
        pkg_traza.trace('onuconsumo5         => '||onuconsumo5,csbNivelTraza);
        pkg_traza.trace('onuconsumo6         => '||onuconsumo6,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);

    EXCEPTION
        WHEN Pkg_Error.CONTROLLED_ERROR THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            --Traza con los Pasos del Proceso
            pkg_traza.trace('--<Ultimo paso ejecutado: ' || nupaso || '>--', csbNivelTraza);
            pkg_traza.trace(sbMsg, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Erc);
            RAISE Pkg_Error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            --Traza con los Pasos del Proceso
            pkg_traza.trace('--<Ultimo paso ejecutado: ' || nupaso || '>--', csbNivelTraza);
            pkg_traza.trace(sbMsg, csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RAISE Pkg_Error.CONTROLLED_ERROR;
    END;

-------- Cambio 38 -----------------------------------------------------------------------------------
    FUNCTION fsbttsusp (inuprod pr_product.product_id%TYPE) RETURN BOOLEAN IS

        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fsbttsusp';

        CURSOR cuttsusp IS
         select a.task_type_id
           from pr_product p, or_order_activity a
          where p.suspen_ord_act_id = a.order_activity_id
            and p.product_id =  inuprod
            and a.task_type_id in
            (
                SELECT regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('TT_SUSP_REGLA_2002'),'[^|]+',1,LEVEL) AS column_value
                FROM dual
                CONNECT BY regexp_substr(pkg_bcld_parameter.fsbobtienevalorcadena ('TT_SUSP_REGLA_2002'),'[^|]+',1,LEVEL) IS NOT NULL
            );
            nufound NUMBER(1) := 0;
            nuttsusp or_order_activity.task_type_id%type;

        blSuspendido        BOOLEAN;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuprod <= '||inuprod,csbNivelTraza);

        open cuttsusp;
        fetch cuttsusp into nuttsusp;

        if cuttsusp%notfound then
            nufound := 2;
        else
            nufound := 1;
        end if;

        IF nufound = 1 THEN
            blSuspendido := TRUE; --  SI ES DIFERENTE DE SUSPENDIDO
        ELSE
            blSuspendido := FALSE; -- NO ES DIFERENTE DE SUSPENDIDO
        END IF;

        pkg_traza.trace('return => '||(case when blSuspendido then 'True' else 'False' end),csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN blSuspendido;

    EXCEPTION
        WHEN others THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            pkg_traza.trace('return => False',csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN FALSE;
    END fsbttsusp;

    FUNCTION fnuultconsprom(inuProducto servsusc.sesunuse%TYPE) RETURN NUMBER IS
        /***********************************************************************************************
            Propiedad intelectual de Gases del Caribe.
            Nombre del Paquete  : fnuultconsprom
            Descripcion         : Obtiene el último consumo promedio por producto
            Autor               : Juan Gabriel Catuche Girón
            Fecha               : 31/07/2023

            Parametros          Descripción
            ============        ===================
            inuProducto         Producto

            Historia de Modificaciones
            DD/MM/YYYY      <Autor>.                Modificación
            -----------     --------------------    -------------------------------------
            31/07/2023      jcatuchemvm             Creacion
        ***********************************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnuultconsprom';

        nudato NUMBER(15, 3) := 0;

        CURSOR cnuultconsprom IS
            SELECT c.hcppcopr
            FROM hicoprpm c
            WHERE c.hcppsesu = inuProducto
                  AND
                  c.hcpppeco = (select pc.pecscons
                                            from pericose pc
                                           where pc.pecsfecf = (select max(t.pecsfecf)
                                                                  from PERICOSE t
                                                                 where t.pecscico in
                                                                       (select ss.sesucicl
                                                                          from servsusc ss
                                                                         where ss.sesunuse = inuProducto)
                                                                   and t.pecsproc = 'S'
                                                                   and t.pecsflav = 'S')
                                             and pc.pecscico in
                                                 (select ss.sesucicl
                                                    from servsusc ss
                                                   where ss.sesunuse = inuProducto)
                                              AND rownum = 1)
                  AND rownum = 1;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto,csbNivelTraza);

        IF cnuultconsprom%ISOPEN THEN
            CLOSE cnuultconsprom;
        END IF;

        OPEN cnuultconsprom;
        FETCH cnuultconsprom INTO nudato;
        CLOSE cnuultconsprom;

        nudato := nvl(nudato, 0);

        pkg_traza.trace('return => '||nudato,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nudato;

    END fnuultconsprom;

    FUNCTION fnuObtieneConsumosPrevios
    (
        inuProducto IN servsusc.sesunuse%TYPE,
        inuTipoCons IN tipocons.tconcodi%TYPE,
        inuPeriCons IN pericose.pecscons%TYPE,
        inuPeriodos IN NUMBER
    ) RETURN NUMBER IS
        /***********************************************************************************************
            Propiedad intelectual de Gases del Caribe.
            Nombre del Paquete  : fnuObtieneConsumosPrevios
            Descripcion         : Obtiene consumos anteriores sin tener en cuenta los consumos recuperados
                                Solo se consideran los consumos liquidados
            Autor               : Juan Gabriel Catuche Girón
            Fecha               : 09/08/2023

            Parametros          Descripción
            ============        ===================
            inuProducto         Producto
            inuTipoCons         Tipo de consumo
            inuPeriCons         Periodo de consumo
            inuPeriodos         # Periodos a consultar

            Historia de Modificaciones
            DD/MM/YYYY      <Autor>.                Modificación
            -----------     --------------------    -------------------------------------
            09/08/2023      jcatuchemvm             Creación
        ***********************************************************************************************/
        csbMetodo   CONSTANT VARCHAR2(100) := csbPaquete||'fnuObtieneConsumosPrevios';

        CURSOR cuObtieneConsumos IS
        SELECT cosssesu,cosspecs,SUM(NVL(cosscoca,0)) cosssuma
        FROM conssesu,pericose
        WHERE cosspecs = pecscons
        AND cosssesu = inuProducto
        AND cosstcon+0 = NVL(inuTipoCons,cosstcon)
        AND cossflli = 'S'
        AND pecsfeci <=
        NVL
        (
            (
                SELECT /*+ PUSH_SUBQ */
                pecsfeci-1
                FROM pericose
                WHERE pecscons = inuPeriCons
            ),
            pecsfeci
        )
        GROUP BY cosssesu,cosspecs
        ORDER BY cosspecs DESC;

        Type tytbConsumo is table of cuObtieneConsumos%ROWTYPE INDEX BY binary_integer;
        tbConsumos          tytbConsumo;
        nuConsumo           conssesu.cosscoca%TYPE;

    BEGIN
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbInicio);
        pkg_traza.trace('inuProducto <= '||inuProducto,csbNivelTraza);
        pkg_traza.trace('inuTipoCons <= '||inuTipoCons,csbNivelTraza);
        pkg_traza.trace('inuPeriCons <= '||inuPeriCons,csbNivelTraza);
        pkg_traza.trace('inuPeriodos <= '||inuPeriodos,csbNivelTraza);

        IF cuObtieneConsumos%ISOPEN THEN
            CLOSE cuObtieneConsumos;
        END IF;

        tbConsumos.DELETE;
        OPEN cuObtieneConsumos;
        --Obtiene los consumos históricos según inuPeriodos
        IF inuPeriodos IS NOT NULL AND inuPeriodos > 0 THEN
            FETCH cuObtieneConsumos BULK COLLECT INTO tbConsumos LIMIT inuPeriodos+1;
        ELSE
            nuConsumo := -1;
        END IF;

        CLOSE cuObtieneConsumos;

        IF tbConsumos.COUNT > 0 OR NVL(nuConsumo,0) != -1 THEN
            --Valida el consumo requerido
            IF tbConsumos.EXISTS(inuPeriodos) THEN
                pkg_traza.trace('Existe el consumo histórico para el periodo enésimo ['||inuPeriodos||']',csbNivelTraza);
                nuConsumo := tbConsumos(inuPeriodos).cosssuma;
            ELSE
                pkg_traza.trace('No existe el consumo histórico para el periodo enésimo ['||inuPeriodos||']',csbNivelTraza);
                nuConsumo := NULL;
            END IF;
        ELSE
            pkg_traza.trace('No existen consumos históricos o no se proporcionó un número de periodos valido');
        END IF;

        nuConsumo := nvl(nuConsumo, 0);

        pkg_traza.trace('return => '||nuConsumo,csbNivelTraza);
        pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin);
        RETURN nuConsumo;

    EXCEPTION
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: '||sbError,csbNivelTraza);
            nuConsumo := 0;
            pkg_traza.trace('return => '||nuConsumo,csbNivelTraza);
            pkg_traza.trace(csbMetodo, csbNivelTraza, csbFin_Err);
            RETURN nuConsumo;
    END fnuObtieneConsumosPrevios;

	PROCEDURE prCalificaConsumoDesvPobl( inuProducto            IN  servsusc.sesunuse%type,
                                        inuPerioFact           IN  perifact.pefacodi%type,
                                        inuconsumoactual       IN  conssesu.cosscoca%TYPE,
                                        isbmarcaprompropio     IN  VARCHAR2,
                                        inuEstadoProd          IN  pr_product.product_status_id%type,
                                        inuconsumopromIndi     IN  hicoprpm.hcppcopr%TYPE,
                                        inucategoria           IN  pr_product.category_id%TYPE,
                                        idtFechLean            IN  lectelme.leemfela%type,
                                        idtFechLeac            IN  lectelme.leemfele%type,
                                        isbTipoProc            IN  VARCHAR2,
                                        onuCalificacion        OUT NUMBER) IS
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prCalificaConsumoDesvPobl
        Descripcion    : proceso que devuelva calificacion de consumo segun nueva resolucion
        Autor          : Luis Javier Lopez / Horbath
        Caso           : OSF-2494
        Fecha          : 01/04/2024

        Parametros de Entrada
          inuProducto           Codigo del producto
          inuPerioFact          codigo del periodo
          inuconsumoactual      Consumo actual
          isbmarcaprompropio    Indica si tiene consumo promedio propio
          inuEstadoProd         estado del producto
          inuconsumopromIndi    Consumo promedio individual
          inucategoria          Categoria
          idtFechLean           fecha de lectura anterior
          idtFechLeac           fecha de lectura actual
          isbTipoProc           tipo de proceso L- Lectura, R - Relectura
        Parametros de Salida
         onuCalificacion        codigo de la calificacion

        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
        01/04/2024          LJLB            Creacion
        12/07/2024          jcatuche        OSF-2494: Se agrega validación por parámetro para restringir llamado a 
                                            procedimiento prGeneraOrdenVeriConCero encargado de generar ordenes de verificación por consumo cero
        24/07/2024          jcatuche        OSF-3009: Se agrega la lógica del caso OSF-1366 para usar consumo promedio por sucategoría no proyectado 
                                            cuando existe cambio de medidor y se presentan recuperaciones de consumo por el cambio de medidor.
        20/09/2024          jcatuche        OSF-3181: Se agrega lógica para la regla 3017 y 3007, se agrega cursor cuValidaConsPendientes para verificar consumos
                                            pendientes de liquidar, los cuales afectan el consumo promedio propio en las reglas que hacen uso del promedio
     ********************************************************************************/
	 csbMet   CONSTANT VARCHAR2(100) := csbPaquete||'prCalificaConsumoDesvPobl';

     nuCateResidencial   NUMBER;
     nuCateComercial     NUMBER;
     nuCateIndustrial    NUMBER;
     nuMetroCateResi     NUMBER;
     nuMetroCateComer    NUMBER;
     nuMetroCateIndu     NUMBER;
     nuMetCateResProm    NUMBER;
     nuMetCateComerProm  NUMBER;
     nuPorcLimInfResi    NUMBER;
     nuPorcLimSupResi    NUMBER;
     nuPorcLimInfCome    NUMBER;
     nuPorcLimSupCome    NUMBER;
     nuPorcLimInfIndu    NUMBER;
     nuPorcLimSupIndu    NUMBER;
     nuConsActuavsProm   NUMBER;
     sbDatos             VARCHAR2(1);
     nuDiasConsumo       NUMBER;
     nuConsPromVa        NUMBER;
     nuMesesAntResi      NUMBER;
     nuMesesAntCome      NUMBER;
     nuMesesValiResi     NUMBER;
     nuMesesValiCome     NUMBER;
     nuActividadResi     NUMBER;
     nuActividadCome     NUMBER;
     dtFechaIniAnti      DATE;
     sbGeneraRevision    VARCHAR2(200);
     nuconsumopromedio   hicoprpm.hcppcopr%TYPE; -- Consumo promedio con el que se realizará el cálculo de la calificación

    cursor cuRecuperacionRetiro is
    select * from
    (
        select /*+ index ( a IDX_OR_ORDER_ACTIVITY_010) use_nl ( a o )
        index ( o pk_or_order ) */
        a.order_id,a.order_activity_id,a.product_id,a.status,o.created_Date,o.legalization_date,o.task_type_id,
        nvl(
        (
            select count(*)
            from conssesu,lectelme
            where leemsesu = a.product_id
            and leemclec = 'R'
            and leemdocu = a.order_activity_id
            and cosssesu = leemsesu
            and cosselme = leemelme
            and cossmecc = 5
            and cossfere between o.legalization_Date-10/86400 and o.legalization_Date+10/86400
        ),0) recuperados,
        row_number() over (order by o.order_id desc) row_num
        from or_order_activity a, or_order o, pericose
        where a.product_id = inuproducto
        and o.order_status_id = 8
        and pecscons = nuperiodo_consumo
        and o.legalization_date > pecsfeci
        and o.order_id = a.order_id
        and exists
        (
            SELECT /*+ index ( ti IX_OR_TASK_TYPES_ITEMS01 ) use_nl ( ti ia )
            index ( ia PK_GE_ITEMS_ATTRIBUTES )*/
            'x'
            FROM or_task_types_items ti, ge_items_attributes ia
            WHERE ti.task_type_id = o.task_type_id
            AND ia.items_id = ti.items_id
            AND
            (
                attribute_1_id = 400021 or attribute_2_id = 400021 or attribute_3_id = 400021 or attribute_4_id = 400021
            )
            AND
            (
                attribute_1_id = 400022 or attribute_2_id = 400022 or attribute_3_id = 400022 or attribute_4_id = 400022
            )
        )
    )
    where row_num = 1
    ;
    
    rcRecuperacionRetiro    cuRecuperacionRetiro%rowtype;
    
    CURSOR cugetCalificacion IS
     SELECT ldc_calificacion_cons.codigo_calificacion
     FROM ldc_calificacion_cons
     WHERE ldc_calificacion_cons.activo = constants_per.csbyes
       AND ldc_calificacion_cons.proceso = isbTipoProc
       AND ldc_calificacion_cons.tiene_lectura = constants_per.csbyes
       AND ldc_calificacion_cons.codigo_calificacion NOT IN (cnuRegla3001, cnuRegla3008)
    ORDER BY prioridad ASC;

    nuPorceSusp NUMBER;

    CURSOR cuValidaSusp IS
    WITH infosuspencion AS
     ( SELECT CASE WHEN inactive_date IS NULL THEN
            NVL(( SELECT MAX(hcetfech)
                 FROM hicaespr
                 WHERE hcetnuse = pr_prod_suspension.product_id
                  AND hcetepan = 2
                  AND hcetepac = 1
                  AND hcetfech >  register_date), idtFechLeac)
           ELSE
               inactive_date
           END fechafinsusp,
           ( TRUNC(idtFechLeac) - (TRUNC(idtFechLean) + 1 ))  + 1 dias_consu,
          register_date
       FROM pr_prod_suspension
       WHERE pr_prod_suspension.product_id = inuProducto
         AND pr_prod_suspension.register_date BETWEEN  (TRUNC(idtFechLean) + 1)  AND idtFechLeac
    )
    SELECT round(( TRUNC(fechafinsusp) - TRUNC(register_date) ) / dias_consu * 100,0)  porce
    FROM infosuspencion;

    --valida que el usuario cumpla con la antiguedad
    CURSOR cuValidaAntiguedad IS
    SELECT 'X'
    FROM servsusc
    WHERE sesunuse = inuProducto
     AND sesufein < dtFechaIniAnti ;

    sbAplicaAnt   VARCHAR2(1);
    
    CURSOR cuValidaConsPendientes IS
    select count(*) from conssesu c
    where cosssesu = inuProducto
    and cossflli = 'N'
    and cossmecc = 4
    and cosspefa < inuPerioFact
    and not exists
    (
        select 'x' from conssesu b
        where b.cosssesu  = c.cosssesu
        and b.cossflli = 'N'
        and b.cossfere = c.cossfere
        and b.cossmecc = 5
    )
    and nvl((select sesuesfn from servsusc where sesunuse = cosssesu),'D') != 'C'
    ;
    
    
    PROCEDURE prCargarParametros IS
      csbMet1       CONSTANT VARCHAR2(150) := csbMet||'.prCargarParametros';
    BEGIN
       pkg_traza.trace(csbMet1, csbNivelTraza, csbInicio);
       nuCateResidencial   := pkg_parametros.fnugetvalornumerico('CATEGORIA_RESIDENCIAL');
       nuCateComercial     := pkg_parametros.fnugetvalornumerico('CATEGORIA_COMERCIAL');
       nuMetroCateResi     := pkg_parametros.fnugetvalornumerico('METROS_MAX_CATERESI');
       nuMetroCateComer    := pkg_parametros.fnugetvalornumerico('METROS_MAX_CATECOME');
       nuMetroCateIndu     := pkg_parametros.fnugetvalornumerico('METROS_MAX_CATEINDU');
       nuPorcLimInfResi    := pkg_parametros.fnugetvalornumerico('PORC_LIMINFERIOR_RESI');
       nuPorcLimSupResi    := pkg_parametros.fnugetvalornumerico('PORC_LIMSUPERIOR_RESI');
       nuPorcLimInfCome    := pkg_parametros.fnugetvalornumerico('PORC_LIMINFERIOR_COME');
       nuPorcLimSupCome    := pkg_parametros.fnugetvalornumerico('PORC_LIMSUPERIOR_COME');
       nuPorcLimInfIndu    := pkg_parametros.fnugetvalornumerico('PORC_LIMINFERIOR_INDU');
       nuPorcLimSupIndu    := pkg_parametros.fnugetvalornumerico('PORC_LIMSUPERIOR_INDU');
       nuMetCateResProm    := pkg_parametros.fnugetvalornumerico('METROS_MAX_SINPROMCATERESI');
       nuMetCateComerProm  := pkg_parametros.fnugetvalornumerico('METROS_MAX_SINPROMCATECOME');
       nuCateIndustrial    := pkg_parametros.fnugetvalornumerico('CATEGORIA_INDUSTRIAL');
       nuMesesAntResi      := pkg_parametros.fnugetvalornumerico('MESES_ANTI_RESIDENCIAL');
       nuMesesAntCome      := pkg_parametros.fnugetvalornumerico('MESES_ANTI_COMERCIAL');
       nuMesesValiResi     := pkg_parametros.fnugetvalornumerico('MESES_VALIDACION_ORDERESI');
       nuMesesValiCome     := pkg_parametros.fnugetvalornumerico('MESES_VALIDACION_ORDECOME');
       nuActividadResi     := pkg_parametros.fnugetvalornumerico('ACTIVIDAD_VERI_RESIDENCIAL');
       nuActividadCome     := pkg_parametros.fnugetvalornumerico('ACTIVIDAD_VERI_COMERCIAL');
       sbGeneraRevision    := pkg_parametros.fsbGetValorCadena('GENERA_REVISION_CONSUMOCERO');

      pkg_traza.trace(csbMet1, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMet1, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);

            pkg_traza.trace(csbMet1, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prCargarParametros;


    PROCEDURE prGeneraOrdenVeriConCero IS
      csbMet1          CONSTANT VARCHAR2(150) := csbMet||'.prGeneraOrdenVeriConCero';
      nuOrderIdout     or_order.order_id%type;
      nuOrderActIdout  or_order_activity.order_activity_id%type;
      sbComenOrden     or_order_comment.order_comment%type := 'Orden generada por consumo cero - reglas de consumo ['||onuCalificacion||']';
      nuCliente        suscripc.suscclie%type;
      nuContrato       suscripc.susccodi%type;
      nuDireccion      pr_product.address_id%type;
      nuactividadgene  ge_items.items_id%type;
      dtFechaMaxLeg    or_order.legalization_date%type;
      sbExiste         VARCHAR2(1);

      CURSOR cuValidaOrdenVeri IS
      SELECT 'X'
      FROM or_order_activity, or_order
      WHERE or_order_activity.product_id = inuProducto
       AND or_order_activity.activity_id = nuactividadgene
       AND or_order_activity.order_id = or_order.order_id
       AND (or_order.order_status_id NOT IN ( SELECT or_order_status.order_status_id
                                             FROM or_order_status
                                             WHERE or_order_status.is_final_status = constants_per.csbyes)
          OR (or_order.order_status_id = pkg_gestionordenes.cnuordencerrada
              AND  pkg_bcordenes.fnuObtieneClaseCausal(or_order.causal_id) = pkg_gestionordenes.cnucausalexito
              AND or_order.legalization_date >= dtFechaMaxLeg) );

    BEGIN
       pkg_traza.trace(csbMet1, csbNivelTraza, csbInicio);

       IF inucategoria = nuCateResidencial THEN
          nuactividadgene := nuActividadResi;
          dtFechaMaxLeg   := add_months(trunc(idtFechLeac), -nuMesesValiResi);
       ELSIF inucategoria = nuCateComercial THEN
          nuactividadgene := nuActividadCome;
          dtFechaMaxLeg   := add_months(trunc(idtFechLeac), -nuMesesValiCome);
       END IF;
       pkg_traza.trace('nuactividadgene    <= '||nuactividadgene,csbNivelTraza);
       pkg_traza.trace('dtFechaMaxLeg    <= '||dtFechaMaxLeg,csbNivelTraza);

       IF cuValidaOrdenVeri%ISOPEN THEN CLOSE cuValidaOrdenVeri; END IF;

       sbExiste := NULL;

       OPEN cuValidaOrdenVeri;
       FETCH cuValidaOrdenVeri INTO sbExiste;
       CLOSE cuValidaOrdenVeri;
       pkg_traza.trace('sbExiste    <= '||NVL(sbExiste,'N'),csbNivelTraza);

       IF sbExiste IS NULL THEN
           nuContrato   := pkg_bcproducto.fnucontrato(inuProducto);
           nuCliente := pkg_bccontrato.fnuidcliente(nuContrato);
           nuDireccion    := pkg_bcproducto.fnuiddireccinstalacion(inuProducto);
           pkg_traza.trace('nuContrato    <= '||nuContrato,csbNivelTraza);
           pkg_traza.trace('nuCliente    <= '||nuCliente,csbNivelTraza);
           pkg_traza.trace('nuDireccion    <= '||nuDireccion,csbNivelTraza);

           api_createorder(  inuitemsid          => nuactividadgene,
                            inupackageid        => NULL,
                            inumotiveid         => NULL,
                            inucomponentid      => NULL,
                            inuinstanceid       => NULL,
                            inuaddressid        => nuDireccion,
                            inuelementid        => NULL,
                            inusubscriberid     => nuCliente,
                            inusubscriptionid   => nuContrato,
                            inuproductid        => inuProducto,
                            inuoperunitid       => NULL,
                            idtexecestimdate    => NULL,
                            inuprocessid        => NULL,
                            isbcomment          => sbComenOrden,
                            iblprocessorder     => NULL,
                            inupriorityid       => NULL,
                            inuordertemplateid  => NULL,
                            isbcompensate       => NULL,
                            inuconsecutive      => NULL,
                            inurouteid          => NULL,
                            inurouteconsecutive => NULL,
                            inulegalizetrytimes => 0,
                            isbtagname          => NULL,
                            iblisacttogroup     => NULL,
                            inurefvalue         => NULL,
                            inuactionid         => NULL,
                            ionuorderid         => nuOrderIdout,
                            ionuorderactivityid => nuOrderActIdout,
                            onuErrorCode        => nuerror,
                            osbErrorMessage     => sberror
                        );

            IF nuerror != constants_per.OK THEN
                RAISE Pkg_Error.CONTROLLED_ERROR;
            END IF;
            pkg_traza.trace('nuOrderIdout    <= '||nuOrderIdout,csbNivelTraza);
           pkg_traza.trace('nuOrderActIdout    <= '||nuOrderActIdout,csbNivelTraza);
       END IF;

       pkg_traza.trace(csbMet1, csbNivelTraza, csbFin);
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMet1, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMet1, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prGeneraOrdenVeriConCero;
  BEGIN
    pkg_traza.trace(csbMet, csbNivelTraza, csbInicio);
    pkg_traza.trace('inuconsumoactual    <= '||inuconsumoactual,csbNivelTraza);
    pkg_traza.trace('isbmarcaprompropio  <= '||isbmarcaprompropio,csbNivelTraza);
    pkg_traza.trace('inuEstadoProd     <= '||inuEstadoProd,csbNivelTraza);
    pkg_traza.trace('inuconsumopromIndi    <= '||inuconsumopromIndi,csbNivelTraza);
    pkg_traza.trace('inucategoria     <= '||inucategoria,csbNivelTraza);
    pkg_traza.trace('idtFechLean     <= '||idtFechLean,csbNivelTraza);
    pkg_traza.trace('idtFechLeac     <= '||idtFechLeac,csbNivelTraza);


    pkg_traza.trace('cnuRegla3001    <= '||cnuRegla3001||' cnuRegla3002    <= '||cnuRegla3002,csbNivelTraza);
    pkg_traza.trace('cnuRegla3003    <= '||cnuRegla3003||' cnuRegla3004    <= '||cnuRegla3004,csbNivelTraza);
    pkg_traza.trace('cnuRegla3005    <= '||cnuRegla3005||' cnuRegla3006    <= '||cnuRegla3006,csbNivelTraza);
    pkg_traza.trace('cnuRegla3007    <= '||cnuRegla3007||' cnuRegla3008    <= '||cnuRegla3008,csbNivelTraza);
    pkg_traza.trace('cnuRegla3009    <= '||cnuRegla3009||' cnuRegla3010    <= '||cnuRegla3010,csbNivelTraza);
    pkg_traza.trace('cnuRegla3011    <= '||cnuRegla3011||' cnuRegla3012    <= '||cnuRegla3012,csbNivelTraza);
    pkg_traza.trace('cnuRegla3013    <= '||cnuRegla3013||' cnuRegla3014    <= '||cnuRegla3014,csbNivelTraza);
    pkg_traza.trace('cnuRegla3015    <= '||cnuRegla3015||' cnuRegla3016    <= '||cnuRegla3016,csbNivelTraza);
    pkg_traza.trace('cnuRegla3017    <= '||cnuRegla3017,csbNivelTraza);

    prCargarParametros;

    pkg_traza.trace('nuCateResidencial    <= '||nuCateResidencial, csbNivelTraza);
    pkg_traza.trace('nuCateComercial    <= '||nuCateComercial, csbNivelTraza);
    pkg_traza.trace('nuMetroCateResi    <= '||nuMetroCateResi, csbNivelTraza);
    pkg_traza.trace('nuMetroCateComer    <= '||nuMetroCateComer, csbNivelTraza);
    pkg_traza.trace('nuMetroCateIndu    <= '||nuMetroCateIndu, csbNivelTraza);
    pkg_traza.trace('nuPorcLimInfResi    <= '||nuPorcLimInfResi, csbNivelTraza);
    pkg_traza.trace('nuPorcLimSupResi    <= '||nuPorcLimSupResi, csbNivelTraza);
    pkg_traza.trace('nuPorcLimInfCome    <= '||nuPorcLimInfCome, csbNivelTraza);
    pkg_traza.trace('nuPorcLimSupCome    <= '||nuPorcLimSupCome, csbNivelTraza);
    pkg_traza.trace('nuPorcLimInfIndu    <= '||nuPorcLimInfIndu, csbNivelTraza);
    pkg_traza.trace('nuPorcLimSupIndu    <= '||nuPorcLimSupIndu, csbNivelTraza);
    pkg_traza.trace('nuMetCateResProm    <= '||nuMetCateResProm, csbNivelTraza);
    pkg_traza.trace('nuMetCateComerProm    <= '||nuMetCateComerProm, csbNivelTraza);

    pkg_traza.trace('nuMesesAntResi    <= '||nuMesesAntResi, csbNivelTraza);
    pkg_traza.trace('nuMesesAntCome    <= '||nuMesesAntCome, csbNivelTraza);
    pkg_traza.trace('nuMesesValiResi    <= '||nuMesesValiResi, csbNivelTraza);
    pkg_traza.trace('nuMesesValiCome    <= '||nuMesesValiCome, csbNivelTraza);
    pkg_traza.trace('nuActividadResi    <= '||nuActividadResi, csbNivelTraza);
    pkg_traza.trace('nuActividadCome    <= '||nuActividadCome, csbNivelTraza);
    
    pkg_traza.trace('sbGeneraRevision    <= '||sbGeneraRevision, csbNivelTraza);
    
    nuconsumopromedio := inuconsumopromIndi;
    --OSF-1366
    IF sbmarcaCambMedidor = 'S' and sbmarcapromsubcat = 'S' THEN
        rcRecuperacionRetiro := null;
        OPEN cuRecuperacionRetiro;
        FETCH cuRecuperacionRetiro INTO  rcRecuperacionRetiro;
        CLOSE cuRecuperacionRetiro;

        IF NVL(rcRecuperacionRetiro.recuperados,0) > 0 THEN
            
            nuconsumopromedio := nuconssubnoproy;

            pkg_traza.trace('Promedio por sub-categoría por cambio de medidor y consumos recuperados: '||
                       nuconsumopromedio, csbNivelTraza);
        END IF;
    END IF;  
    
    --Valida consumos pendientes de liquidar 
    nuConsPendLiqu := null;
    IF cuValidaConsPendientes%ISOPEN THEN CLOSE cuValidaConsPendientes; END IF;
    open cuValidaConsPendientes;
    fetch cuValidaConsPendientes into nuConsPendLiqu;
    close cuValidaConsPendientes;
    
    pkg_traza.trace('Cantidad consumos pendientes de liquidar: '||nuConsPendLiqu, csbNivelTraza);

    FOR reg IN cugetCalificacion LOOP
        pkg_traza.trace('Evalua calificación: '||reg.codigo_calificacion, csbNivelTraza);
        onuCalificacion := reg.codigo_calificacion;
        nuConsActuavsProm := null;
        
        --regla 3002 el usuario tiene estado de producto suspendido y su consumo es cero
        IF reg.codigo_calificacion IN (cnuRegla3002, cnuRegla3009) AND  inucategoria <> nuCateIndustrial THEN
            IF inuconsumoactual = 0 AND NOT fsbestcortnopermit(inuEstadoProd) THEN
               EXIT;
            END IF;
        ELSIF reg.codigo_calificacion IN (cnuRegla3003, cnuRegla3010)  THEN
             IF isbmarcaprompropio = constants_per.csbsi
                AND ((inuconsumoactual < nuMetroCateResi AND nuconsumopromedio < nuMetroCateResi AND inucategoria = nuCateResidencial )
                  OR (inuconsumoactual < nuMetroCateComer AND nuconsumopromedio < nuMetroCateComer AND inucategoria = nuCateComercial)
                  OR (inuconsumoactual < nuMetroCateIndu AND nuconsumopromedio < nuMetroCateIndu AND inucategoria = nuCateIndustrial)) 
                AND nuConsPendLiqu = 0 THEN
                  EXIT;
             END IF;
        ELSIF reg.codigo_calificacion IN (cnuRegla3004, cnuRegla3011)  THEN
             nuConsPromVa := NULL;
             IF isbmarcaprompropio = constants_per.csbsi AND nuConsPendLiqu = 0 THEN
                nuConsPromVa := nuconsumopromedio;
             END IF;

             IF nuConsPromVa IS NOT NULL THEN
                IF nuConsPromVa = 0 THEN
                  nuConsActuavsProm := 0;
                ELSE
                  nuConsActuavsProm := ROUND((inuconsumoactual - nuConsPromVa) / nuConsPromVa * 100);
                END IF;

                pkg_traza.trace('nuConsActuavsProm    <= '||nuConsActuavsProm||' Regla ['||reg.codigo_calificacion||']', csbNivelTraza);
                IF ((nuConsActuavsProm BETWEEN -nuPorcLimInfResi AND nuPorcLimSupResi  AND inucategoria = nuCateResidencial)
                  OR ( nuConsActuavsProm BETWEEN -nuPorcLimInfCome AND nuPorcLimSupCome  AND inucategoria = nuCateComercial)
                  OR ( nuConsActuavsProm BETWEEN -nuPorcLimInfIndu AND nuPorcLimSupIndu  AND inucategoria = nuCateIndustrial))  THEN
                    EXIT;
                END IF;
             END IF;
        ELSIF reg.codigo_calificacion IN (cnuRegla3005, cnuRegla3012) THEN
             IF isbmarcaprompropio = constants_per.csbsi AND nuConsPendLiqu = 0 THEN

                sbDatos := NULL;
                nuPorceSusp := null;
                IF cuValidaSusp%ISOPEN THEN
                   CLOSE cuValidaSusp;
                END IF;

                OPEN cuValidaSusp;
                FETCH cuValidaSusp INTO nuPorceSusp;
                CLOSE cuValidaSusp;

                IF nuPorceSusp IS NULL THEN
                   pkg_traza.trace(' Producto no suspendido en el periodo ', csbNivelTraza);
                   CONTINUE;
                END IF;

                pkg_traza.trace(' nuPorceSusp => '||nuPorceSusp, csbNivelTraza);

                IF nuconsumopromedio = 0 THEN
                  nuConsActuavsProm := 0;
                ELSE
                  nuConsActuavsProm := ROUND((inuconsumoactual - nuconsumopromedio) / nuconsumopromedio * 100);
                END IF;
                pkg_traza.trace('nuConsActuavsProm  <= '||nuConsActuavsProm||' Regla ['||reg.codigo_calificacion||']', csbNivelTraza);

                IF nuConsActuavsProm < 0 THEN
                    IF ( nuPorceSusp >= ABS(nuConsActuavsProm)  )  THEN
                          EXIT;
                    END IF;
                END IF;
             END IF;
        ELSIF reg.codigo_calificacion IN (cnuRegla3006, cnuRegla3013) AND  inucategoria <> nuCateIndustrial THEN
           IF isbmarcaprompropio = constants_per.csbno  AND (( inuconsumoactual < nuMetCateResProm AND inucategoria = nuCateResidencial)
              OR (inuconsumoactual < nuMetCateComerProm AND inucategoria = nuCateComercial)) THEN
              EXIT;
           END IF;
        ELSIF reg.codigo_calificacion IN (cnuRegla3015, cnuRegla3016) AND  inucategoria <> nuCateIndustrial THEN
           IF isbmarcaprompropio = constants_per.csbno AND inuconsumoactual = 0 THEN
              IF cuValidaAntiguedad%ISOPEN THEN CLOSE cuValidaAntiguedad; END IF;
               dtFechaIniAnti := null;
               dtFechaIniAnti      := add_months(trunc(idtFechLeac), - (CASE when inucategoria = nuCateResidencial THEN nuMesesAntResi
                                                                         WHEN inucategoria = nuCateComercial THEN nuMesesAntCome
                                                                         END));
              pkg_traza.trace('dtFechaIniAnti    <= '||dtFechaIniAnti, csbNivelTraza);
              sbAplicaAnt := NULL;
              OPEN cuValidaAntiguedad;
              FETCH cuValidaAntiguedad INTO sbAplicaAnt;
              CLOSE cuValidaAntiguedad;

               pkg_traza.trace('sbAplicaAnt    <= '||NVL(sbAplicaAnt,'N'), csbNivelTraza);
              --valido que no tenga orden pendiente
              IF sbAplicaAnt IS NOT NULL THEN
              
                IF nvl(sbGeneraRevision,'N') = 'S' then
                    prGeneraOrdenVeriConCero;
                END IF;
                
                EXIT;
                
              END IF;

           END IF;
        ELSIF reg.codigo_calificacion = cnuRegla3017 THEN
            IF inuconsumoactual IS NULL THEN
                EXIT;
            END IF;
        ELSIF reg.codigo_calificacion IN (cnuRegla3007, cnuRegla3014)  THEN
              EXIT;
        END IF;
    END LOOP;
    pkg_traza.trace('onuCalificacion    <= '||onuCalificacion, csbNivelTraza);
    pkg_traza.trace(csbMet, csbNivelTraza, csbFin);

  EXCEPTION
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
        pkg_traza.trace(csbMet, csbNivelTraza, csbFin_Erc);
        RAISE pkg_Error.Controlled_Error;
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
         pkg_traza.trace(csbMet, csbNivelTraza, csbFin_Err);
        RAISE pkg_Error.Controlled_Error;
  END prCalificaConsumoDesvPobl;
  
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prConsDifLectAnt
        Descripcion    : Procedimiento encargado de calcular consumo por diferencia de lectura anterior
        Autor          : Juan Gabriel Catuche Girón
        Caso           : OSF-3181
        Fecha          : 20/09/2024

        Parametros de Entrada
            NA
        Parametros de Salida
            onuConsumo            Consumo calculado
            osbFuncion            Función de cálculo del consumo
            onuMetodo             Método de calculo de consumo

        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
        20/09/2024          jcatuche        OSF-3181: Creacion        
    ********************************************************************************/
    PROCEDURE prConsDifLectAnt
    (   
        onuConsumo  OUT NUMBER, 
        osbFuncion  OUT NOCOPY conssesu.cossfufa%TYPE,
        onuMetodo   OUT NOCOPY conssesu.cossmecc%TYPE
    ) IS
        csbMet      CONSTANT VARCHAR2(100) := csbPaquete||'prConsDifLectAnt';
        csbCONSDLFC CONSTANT CONSSESU.COSSFUFA%TYPE := CM_BOCalcConsumpServs.CSBCONSDLFC;
        tbConsumos  CM_BOCONSUMPTIONENGINE.TYTBUPLOADEDCONS;
        rcConsumos  CM_BOCONSUMPTIONENGINE.TYRCCONSUMPTION;
        
    BEGIN
        pkg_traza.trace(csbMet, csbNivelTraza, csbInicio);
        
        cm_bocalcconsumpservs.CONSBYPREREADCORRFACT(onuConsumo, osbFuncion, onuMetodo);
        pkg_traza.trace('cm_bocalcconsumpservs.CONSBYPREREADCORRFACT => ['||onuConsumo||']['||osbFuncion||']['||onuMetodo||']', csbNivelTraza);
        
        tbConsumos := CM_BOConsumptionEngine.FTBGETREGCONSMEMORYDATA(osbFuncion);
        pkg_traza.trace('CM_BOConsumptionEngine.FTBGETREGCONSMEMORYDATA ['||tbConsumos.count||']', csbNivelTraza);
        
        pkg_traza.trace('CM_BOCONSUMPTIONENGINE.CLEANMEMORYBYSOURCE', csbNivelTraza);
        CM_BOCONSUMPTIONENGINE.CLEANMEMORYBYSOURCE(osbFuncion);
        
        if tbConsumos.count > 0 then
            rcConsumos := tbConsumos(tbConsumos.first);
            
            osbFuncion := csbCONSDLFC;
            rcConsumos.SBCALCFUNC := osbFuncion;
            
            pkg_traza.trace('CM_BOCONSUMPTIONENGINE.REGISTERCONSUMPTION => ['||osbFuncion||']', csbNivelTraza);
            CM_BOCONSUMPTIONENGINE.REGISTERCONSUMPTION(rcConsumos,osbFuncion);
        end if;
        
        pkg_traza.trace(csbMet, csbNivelTraza, csbFin);        
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMet, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMet, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prConsDifLectAnt;
    
    /**************************************************************************************************************************************************************************************************
       Propiedad intelectual de GDC
        Unidad         : prConsDifLectAntFactCorr
        Descripcion    : Procedimiento encargado de calcular consumo por diferencia de lectura anterior
                        con factor de corrección
        Autor          : Juan Gabriel Catuche Girón
        Caso           : OSF-3181
        Fecha          : 20/09/2024

        Parametros de Entrada
            NA
        Parametros de Salida
            onuConsumo            Consumo calculado
            osbFuncion            Función de cálculo del consumo
            onuMetodo             Método de calculo de consumo

        Historial de modificaciones
        =========================================
        Fecha               Autor           Modificaciones
        ===============     ==========      ============================
        20/09/2024          jcatuche        OSF-3181: Creacion        
    ********************************************************************************/
    PROCEDURE prConsDifLectAntFactCorr
    (   
        onuConsumo  OUT NUMBER, 
        osbFuncion  OUT NOCOPY conssesu.cossfufa%TYPE,
        onuMetodo   OUT NOCOPY conssesu.cossmecc%TYPE
    ) IS
        csbMet   CONSTANT VARCHAR2(100) := csbPaquete||'prConsDifLectAntFactCorr';
    BEGIN
    
        pkg_traza.trace(csbMet, csbNivelTraza, csbInicio);
        
        prConsDifLectAnt(onuConsumo,osbFuncion,onuMetodo);
        CM_BOCONSCORRFACTTOOLS.CALCCORRECTIONFACTOR(osbFuncion,onuConsumo);
        
        pkg_traza.trace('onuConsumo => '||onuConsumo, csbNivelTraza);
        pkg_traza.trace('osbFuncion => '||osbFuncion, csbNivelTraza);
        pkg_traza.trace('onuMetodo  => '||onuMetodo, csbNivelTraza);
        pkg_traza.trace(csbMet, csbNivelTraza, csbFin); 
               
    EXCEPTION
        WHEN pkg_Error.Controlled_Error  THEN
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
            pkg_traza.trace(csbMet, csbNivelTraza, csbFin_Erc);
            RAISE pkg_Error.Controlled_Error;
        WHEN OTHERS THEN
            pkg_Error.setError;
            pkg_Error.getError(nuError, sbError);
            pkg_traza.trace('sbError: ' || sbError, csbNivelTraza);
             pkg_traza.trace(csbMet, csbNivelTraza, csbFin_Err);
            RAISE pkg_Error.Controlled_Error;
    END prConsDifLectAntFactCorr;
BEGIN

    pkg_traza.trace('Llamado inicial al paquete '||csbPaquete||'...',csbNivelTraza);

END ldc_bssreglasproclecturas;
/