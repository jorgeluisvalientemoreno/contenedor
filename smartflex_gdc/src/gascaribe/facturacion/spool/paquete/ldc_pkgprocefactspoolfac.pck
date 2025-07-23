create or replace PACKAGE ldc_pkgprocefactspoolfac IS
 /*******************************************************************************************************
    Propiedad intelectual de Gases del Caribe S.A (c).

    Unidad         : ldc_pkgprocefactspoolfac
    Descripcion    : Paquete para acoplar los procesos de facturaci?n
                   que se utilizaran en el spool de facturaci?n
    Autor          : John Jairo Jimenez Marimon
    Fecha          : 11/07/2022

    Historia de Modificaciones
        DD-MM-YYYY      <Autor>.                Modificacion
        -----------     -------------------     ------------------------------------
        03/02/2025		LJLB				OSF-3707: se agrega logica de unidades por concepto
        13/12/2023      felipe.valencia         OSF-1939: se modifca para agregar función
                                                fsb_valida_imprime_factura y se modfican estandares tecnicos
        26-07-2023		jpinedc (MVM) 	        OSF-1462: Se modifica el servicio RfConcepParcial
        26-07-2023		cgonzalez (Horbath) 	OSF-1367: Se modifica el servicio RfConcepParcial
		04-11-2022      jcatuchemvm             OSF-660: Se ajusta procedimiento
                                                    [RfConcepParcial]
        11-07-2022      John Jairo Jimenez      Creacion


*******************************************************************************************************/
gsbTotal                VARCHAR2(50);
gsbIVANoRegulado        VARCHAR2(50);
gsbSubtotalNoReg        VARCHAR2(50);
gsbCargosMes            VARCHAR2(50);
gnuConcNumber           NUMBER;
glPackage_Cupon_id      ld_cupon_causal.package_id%TYPE := NULL;
glCupon_Cupon_id        ld_cupon_causal.cuponume%TYPE := NULL;
glCausal_Cupon_id       ld_cupon_causal.causal_id%TYPE := NULL;
glPackage_type_Cupon_id NUMBER := 0;
-----------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fsbVersion RETURN VARCHAR2;
FUNCTION fsbVersion RETURN VARCHAR2;

PROCEDURE rfdatoslecturas
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosLecturas
  Descripcion :   Obtiene los datos de las lecturas y medidor
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
**************************************************************************/
(
 sbFactcodi  ge_boInstanceControl.stysbValue
,sbfactpefa  ge_boInstanceControl.stysbValue
,blNRegulado BOOLEAN
,nuSesunuse  servsusc.sesunuse%TYPE
,nucicloc    NUMBER
,orfcursor OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfrangosconsumo
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfRangosConsumo
  Descripcion :   Obtiene los rangos tarifarios liquidados en consumos
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
**************************************************************************/
(
sbFactcodi  ge_boInstanceControl.stysbValue
,sbFactsusc  ge_boInstanceControl.stysbValue
,blNRegulado BOOLEAN
,sbaplicanet ge_boInstanceControl.stysbValue
,orfcursor OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfgetvalcostcompvalid
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   rfGetValCostCompValid
  Descripcion :   Obtiene los componentes del costo
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
**************************************************************************/
(
 nuProducto   servsusc.sesunuse%TYPE
,blNoRegulada BOOLEAN
,orfcursor OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatoscodbarras
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosCodBarras
  Descripcion :   Obtiene el codigo de barras
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
**************************************************************************/
(
 sbFactcodi  ge_boInstanceControl.stysbValue
,orfcursor OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosCuenxCobrTt
/*****************************************************************
 Propiedad intelectual de GDC (c).

 Unidad         : RfDatosCuenxCobrTt
 Descripcion    : funcion que devuelve el valor por cobrar de la tarifa transitoria

 Autor          : Luis Javier Lopez Barrios / Horbath

 Parametros           Descripcion
 ============         ===================
 inuSusccodi          contrato

 Fecha             Autor             Modificacion
 =========       =========           ====================
   ******************************************************************/
(
 sbFactsusc ge_boInstanceControl.stysbValue
,orfcursor  OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfconcepparcial
/******************************************************************************************
 Propiedad intelectual de PETI (c).

 Unidad         : RfConcepParcial
 Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
 Autor          : Gabriel Gamarra - Horbath Technologies

 Parametros           Descripcion
 ============         ===================

 orfcursor            Retorna los datos

 Fecha           Autor               Modificacion
 =========       =========           ====================
 11/11/2014      ggamarra           Creacion.
*******************************************************************************************/
(
 sbFactcodi  ge_boInstanceControl.stysbValue
,sbFactsusc  ge_boInstanceControl.stysbValue
,blnregulado BOOLEAN
,orfcursor   OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosConceptos
/**************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosConceptosspool
  Descripcion :   Obtiene los datos de los conceptos liquidados en la factura
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
  **************************************************************************/
(
 blNRegulado      BOOLEAN
,orfcursordatconc OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosimpresiondig
/****************************************************************************************************
 Propiedad intelectual de GDC (c).

 Unidad         : rfdatosimpresiondig
 Descripcion    : proceso que devuelve si un producto tiene financiacion de cartera especiales
 Ticket         : 820

 Autor          : John Jairo Jimenez Marimon

 Parametros           Descripcion
 ============         ===================


 Fecha             Autor             Modificacion
 =========       =========           ====================
 13/12/2023      felipe.valencia     OSF-1939: se modifica para agregar la función ldc_utilidades_fact.fsb_valida_imprime_factura
****************************************************************************************************/
(
 nmsusccodi      suscripc.susccodi%TYPE
,orfcursorimpdig OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfLastPayment
/*********************************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfLastPayment
  Descripcion    : Procedimiento que retorna el ultimo pago del usuario y la fecha de este ultimo pago.
  Ticket         : OSF-393
  Fecha          : 24/06/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
*********************************************************************************************************/
(
 sbFactsusc ge_boInstanceControl.stysbValue
,orfcursor  OUT constants_per.tyrefcursor
);
-----------------------------------------------------------------------------------------------------------------------------------------
FUNCTION fsbGetDescConcDife (inuservicio IN NUMBER, inudifeconc IN NUMBER, idtfechaini IN DATE ) RETURN VARCHAR2;
  /**************************************************************
    Propiedad intelectual de Gdc (c).

    Unidad         : fsbGetDescConcDife
    Descripcion    :  retorna valor del concepto de diferido por grupo
    Autor          : Luis Javier Lopez Barrios / Horbath
    Fecha          : 09/10/2022
    Ticket         : OSF-520


    Parametros              Descripcion
    ============         ===================
     inudifeconc         codigo del concepto del diferido
     idtfechaini         fecha de inicio
     inuservicio         codigo del tipo de producto
     Salida

    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/
  PROCEDURE rfGetSaldoAnterior(orfcursorsaldoante OUT constants_per.tyrefcursor);
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfGetSaldoAnterior
  Descripcion    : Procedimiento que retorna saldo anterior
  Ticket         : OSF-1056
  Fecha          : 26/04/2023
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
 FUNCTION fnuGetCaliConsumo(nuFactcodi        IN  NUMBER) RETURN VARCHAR2 ;
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : fnuGetCaliConsumo
  Descripcion    : funcion que devuelve calificacion del consumo
  Ticket         : OSF-2494
  Fecha          : 12/04/2024
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================
    nuFactcodi         codigo de la factura

  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
 PROCEDURE prcGetInfoAdicional( nuFactcodi        IN  NUMBER,
                                orfcursorinfoadic OUT constants_per.tyRefCursor);
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfGetInfoAdicional
  Descripcion    : Procedimiento que retorna informacion adicional en el spool
  Ticket         : OSF-2494
  Fecha          : 12/04/2024
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
END ldc_pkgprocefactspoolfac;
/
create or replace PACKAGE BODY ldc_pkgprocefactspoolfac IS
 /*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolfac
  Descripcion    : Paquete para acoplar los procesos de facturaci?n
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 11/07/2022

*******************************************************************************************************/
    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';--constante nombre del paquete
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;--Nivel de traza para este paquete.
-- Identificador del ultimo caso que hizo cambios
	csbVersion          CONSTANT VARCHAR2(15) := 'OSF-4454';
-----------------------------------------------------------------------------------------------------------------------------------------

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 19-05-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      19-05-2025   OSF-4454    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

 PROCEDURE RfDatosLecturas(
                          sbFactcodi  ge_boInstanceControl.stysbValue
                         ,sbfactpefa  ge_boInstanceControl.stysbValue
                         ,blNRegulado BOOLEAN
                         ,nuSesunuse  servsusc.sesunuse%TYPE
                         ,nucicloc    NUMBER
                         ,orfcursor OUT constants_per.tyrefcursor
                         ) AS
/**********************************************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosLecturas
  Descripcion    : Procedimiento para extraer los datos relacionados
                   con las lecturas
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos de las lecturas.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  15.06.2022     IBECERRA             OSF-164
  16/04/20119     ELAL                CA 200-2032 se coloca regla de negocio para lecturas anterior y actual
  03/09/2018      Jorge Valiente      CASO 200-1899: Crar cursor par identificar el medidor de los suscriptores no regulados
  01-03-2015      Llozada            Se modifica la l?gica ya que se estaban enviando trocadas la
                                     lectura anterior con la actual.
  11/11/2014      ggamarra           Creacion.
  24/06/2022      John Jairo Jimenez OSF-393 : Se modifica para cuando el consumo sea estimado y la
                                               observacion de lecatura sea NULL, se le asigne a la
                                               observacion de lectura el valor configurado
                                               en el parametro : PARAM_OBS_DESV_SIGNIFI.
**********************************************************************************************************************************/
nufactpefa        perifact.pefacodi%TYPE;
lectura_anterior  VARCHAR2(100);
lectura_actual    VARCHAR2(100);
num_medidor       VARCHAR2(50);
obs_lectura       VARCHAR2(100);

CURSOR cumedidor(inuservicio NUMBER) IS
 SELECT emsscoem num_medidor
   FROM elmesesu
  WHERE emsssesu = inuservicio
    AND emssfere > SYSDATE
    AND rownum = 1;


rfcumedidor cumedidor%ROWTYPE;
sbconsumo       VARCHAR2(100);
vnuCicloEsp     NUMBER;
sbCicloespe     VARCHAR2(100) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_CICLVALI');
sbObservacion   VARCHAR2(100) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_SPOOL_OBSERV');
sbobsdesvsign   ld_parameter.parameter_id%TYPE;
nuPerFactPrev   perifact.pefacodi%type;
nuPerConsPrev   pericose.pecscons%type;
nuConsEst       NUMBER;

    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfDatosLecturas';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;

FUNCTION fsbgetConsumo(
                        inuperifact IN perifact.pefacodi%TYPE
                       ,inuproducto IN pr_product.product_id%TYPE
                       ,inuCiclo    IN NUMBER
                      ) RETURN VARCHAR2 IS
/**********************************************************************************
Propiedad intelectual de GDC.

Unidad         : fsbgetConsumo
Descripcion    : funcion que devuelve el consumo
Autor          : Elkin Alvarez - Horbath Technologies

Parametros              Descripcion
============         ===================
inuperifact           periodos de facturacion
inuproducto           codigo de producto

Fecha             Autor             Modificacion
=========       =========           ====================
16/04/20119     ELAL                creacion

*************************************************************************************/
nuperidocons  pericose.pecscons%TYPE;
calculo_cons  VARCHAR2(4000);
vnucite       NUMBER;
csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbgetConsumo';

    CURSOR cuCicloTelemedidos
    IS
    SELECT COUNT(*)
    FROM (SELECT to_number(regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('CICLO_TELEMEDIDOS_GDC'),'[^,]+', 1, LEVEL))  ciclo
    FROM   dual
    CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('CICLO_TELEMEDIDOS_GDC'), '[^,]+', 1, LEVEL) IS NOT NULL )
    WHERE ciclo =  pkg_bcproducto.fnuciclofacturacion(inuproducto);

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 nuperidocons := ldc_boformatofactura.fnuobtperconsumo(
                                                       inuCiclo
                                                      ,inuperifact
                                                      );
 BEGIN
  SELECT decode(cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO') INTO calculo_cons
    FROM vw_cmprodconsumptions
   WHERE cosssesu = inuproducto
     AND cosspefa = inuperifact
     AND cosspecs = nuperidocons;
     pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
  WHEN OTHERS THEN
   calculo_cons := NULL;
 END;
 pkg_traza.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist VAlidacion ciclo asociado', pkg_traza.cnuNivelTrzDef);
 IF calculo_cons IS NOT NULL THEN

    IF (cuCicloTelemedidos%ISOPEN) THEN
        CLOSE  cuCicloTelemedidos;
    END IF;

    OPEN cuCicloTelemedidos;
    FETCH cuCicloTelemedidos INTO vnucite;
    CLOSE  cuCicloTelemedidos;

  IF vnucite = 1 THEN
     calculo_cons := 'RTU';
  END IF;
 END IF;

 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 RETURN calculo_cons;
EXCEPTION
 WHEN OTHERS THEN
  RETURN '';
END fsbgetConsumo;
--------------------------------------------------------------------------------------------------------------------
BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

 nufactpefa    := to_number(sbfactpefa);
 sbobsdesvsign := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('PARAM_OBS_DESV_SIGNIFI');
 BEGIN
  IF NOT blNRegulado THEN
   sbconsumo := fsbgetConsumo(sbfactpefa, nuSesunuse, nucicloc );
   SELECT num_medidor
         ,TO_CHAR((round(SUM(leac), 2)), 'FM999,999,999,990') lectura_actual
         ,TO_CHAR((round(SUM(NVL(lean, 0)), 2)),'FM999,999,999,990') lectura_anterior
         ,causal_no_lec
     INTO num_medidor, lectura_actual, lectura_anterior, obs_lectura
     FROM (SELECT nvl(leemleto, 0) leac
                 ,nvl(ldc_detallefact_gascaribe.fnuLecturaAnterior(sesunuse, factpefa), leemlean) lean
                 ,(
                   SELECT emsscoem
                     FROM elmesesu
                    WHERE emsssesu = leemsesu
                      AND emssfere > SYSDATE
                      AND rownum = 1
                   ) num_medidor
                 ,(
                   SELECT obledesc
                     FROM obselect
                    WHERE oblecodi = leemoble
                      AND oblecanl = 'S'
                      AND rownum = 1
                   ) causal_no_lec
             FROM factura, servsusc, lectelme
            WHERE factcodi = sbFactcodi
              AND sesususc = factsusc
              AND sesunuse = nuSesunuse
              AND leemsesu = sesunuse
              AND leempefa = factpefa
              AND leemclec = 'F'
           )
         WHERE rownum = 1
         GROUP BY num_medidor, causal_no_lec;
  ELSE
   num_medidor := NULL;
    OPEN cumedidor(nuSesunuse);
   FETCH cumedidor INTO rfcumedidor;
    IF cumedidor%FOUND THEN
     IF rfcumedidor.num_medidor IS NOT NULL THEN
        num_medidor := rfcumedidor.num_medidor;
     END IF;
    END IF;
   CLOSE cumedidor;
   lectura_anterior := NULL;
   lectura_actual   := NULL;
   obs_lectura      := NULL;
  END IF;
 EXCEPTION
  WHEN no_data_found THEN
   num_medidor      := '';
   lectura_anterior := 0;
   lectura_actual   := 0;
   obs_lectura      := ' ';
 END;
 SELECT COUNT(*) INTO vnuCicloEsp
   FROM (SELECT to_number(regexp_substr(sbCicloespe,'[^,]+', 1, LEVEL))  ciclos
    FROM   dual
  CONNECT BY regexp_substr(sbCicloespe, '[^,]+', 1, LEVEL) IS NOT NULL )
    WHERE ciclos =  nucicloc;

 IF vnuCicloEsp = 1 THEN
      lectura_anterior  := 'VER ANEXO';
      lectura_actual    := 'VER ANEXO';
 ELSIF sbconsumo = 'ESTIMADO' THEN
      lectura_anterior  := '';
      lectura_actual    := '';
  IF obs_lectura IS NULL THEN
     obs_lectura := sbobsdesvsign;
  END IF;
 ELSIF sbconsumo = 'LEC.MEDIDOR' THEN
   nuPerFactPrev   := pkbillingperiodmgr.fnugetperiodprevious(nufactpefa);
   nuPerConsPrev   := ldc_boformatofactura.fnuobtperconsumo(nucicloc,nuperfactprev);
   nuConsEst       := 0;
   SELECT count(1) INTO nuConsEst
     FROM conssesu
    WHERE cosssesu = nuSesunuse
      AND cosspefa = nuPerFactPrev
      AND cosspecs = nuPerConsPrev
      AND cossmecc = 3 ;
  IF (nuConsEst > 0) THEN
     lectura_anterior :='';
     obs_lectura := obs_lectura ||' '||sbobservacion;
  END IF;
 END IF;
 OPEN orfcursor FOR
  SELECT num_medidor        num_medidor
        ,lectura_anterior   lectura_anterior
        ,lectura_actual    lectura_actual
        ,obs_lectura        obs_lectura
    FROM dual;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

EXCEPTION
    --Validación de error controlado
    WHEN pkg_Error.Controlled_Error  THEN
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        RAISE pkg_Error.Controlled_Error;
    --Validación de error no controlado
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);
        pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        RAISE pkg_Error.Controlled_Error;
END rfdatoslecturas;
-----------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfRangosConsumo(
                           sbFactcodi  ge_boInstanceControl.stysbValue
                          ,sbFactsusc  ge_boInstanceControl.stysbValue
                          ,blNRegulado BOOLEAN
                          ,sbaplicanet ge_boInstanceControl.stysbValue
                          ,orfcursor OUT constants_per.tyrefcursor
                          ) IS
/*************************************************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfRangosConsumo
  Descripcion    : Procedimiento para extraer los campos relacionados
                   con los datos del medidor.
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================

  orfcursor            Retorna los datos de las fechas de revision

  Fecha           Autor               Modificacion
  =========       =========           ====================
  15/05/2018      Jorge Valiente      CASO 200-1427: Tomar de instancia APLICA para establecer
                                                     datos de rango de consumo a KISOKO .NET
   02-03-2015     agordillo          Incidente 143186 Modificacion
                                     Se comenta la consulta donde se obtiene los rango liquidados, dado que estos datos se
                                     obtienen el en cursor orfcursor, adicional cuando
                                     se le liquida al usuario mas de un rango de consumo genera error.
  02-03-2015      Llozada            Se modifica la l?gica para que ubique el consumo en el rango de la tarifa
                                     correspondiente
  12/02/2015      agordillo          Incidente.140643 Modificacion
                                      * Se modifica el select para obtener el maximo rango liquidado al cliente,
                                      y se le agrega relacion de concepto y servicio. Dado que pueden existir
                                      varlos registros con el mismo cargdoso y que no corresponden al mismo producto
                                      y al concepto de consumo
                                      * Se modifica el cursor orfcursor para que se filtre por el concepto de consumo
                                      dado que pueden existir varios rango liquidados y no corresponden al consumo.
  11/11/2014      ggamarra           Creacion.

*************************************************************************************************************************************/

nuTari         NUMBER;
nuLimite       NUMBER;
nuConsec       NUMBER;
nuLimiSuperior NUMBER;
nuSesu         NUMBER;
nuBlankRanks   NUMBER;
nuConcConsumo  NUMBER := 31;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfRangosConsumo';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

 IF NOT blNRegulado OR sbAplicaNET = '1' THEN
  --
  BEGIN
   IF sbAplicaNET = '1' THEN
    SELECT MAX(ralilisr), MAX(raliidre), MAX(ralicodo), MAX(cargnuse)
      INTO nuLimite, nuTari, nuConsec, nuSesu
      FROM cargos, cuencobr, rangliqu, servsusc
     WHERE cargcuco = cucocodi
       AND cargdoso LIKE 'CO-%TC-%'
       AND cargdoso NOT LIKE 'CO-PR%TC-%'
       AND cargconc = nuConcConsumo
       AND raliconc = cargconc
       AND cuconuse = ralisesu
       AND cargcodo = ralicodo
       AND ralisesu = sesunuse
       AND sesususc = sbFactsusc;
   ELSE
    SELECT MAX(ralilisr), MAX(raliidre), MAX(ralicodo), MAX(cargnuse)
      INTO nuLimite, nuTari, nuConsec, nuSesu
      FROM cargos, cuencobr, rangliqu
     WHERE cargcuco = cucocodi
       AND cucofact = sbFactcodi
       AND cargdoso LIKE 'CO-%TC-%'
       AND cargdoso NOT LIKE 'CO-PR%TC-%'
       AND cargconc = nuConcConsumo
       AND raliconc = cargconc
       AND cuconuse = ralisesu
       AND cargcodo = ralicodo;
   END IF;
  EXCEPTION
   WHEN OTHERS THEN
    nuTari   := -1;
    nuConsec := -1;
    nuSesu   := -1;
  END;
  -- Hallar cantidad de rangos
  IF nuTari > 0 THEN
   SELECT 7 - COUNT(1) INTO nuBlankRanks
     FROM ta_rangvitc
    WHERE ravtvitc = nuTari;
  ELSE
   nuBlankRanks := 7;
  END IF;
  -- Hallar el limite superior de la tarifa
  BEGIN
   SELECT MAX(ravtlisu) INTO nuLimiSuperior
     FROM ta_rangvitc
    WHERE ravtvitc = nuTari;
  EXCEPTION
   WHEN OTHERS THEN
    nuLimiSuperior := -1;
  END;
  OPEN orfcursor FOR
   SELECT lim_inferior lim_inferior
         ,decode(lim_superior, nulimisuperior, 'MAS', lim_superior) lim_superior
         ,valor_unidad valor_unidad
         ,consumo consumo
         ,to_char(val_consumo, 'FM999,999,999,990') val_consumo
     FROM (
           SELECT rango_tarifas.lim_inferior
                 ,rango_tarifas.lim_superior
                 ,nvl(rango_liquidado.valor_unidad, 0) valor_unidad
                 ,nvl(rango_liquidado.consumo, 0) consumo
                 ,nvl(rango_liquidado.val_consumo, 0) val_consumo
             FROM (
                   SELECT ravtliin lim_inferior
                         ,ravtlisu lim_superior
                         ,0        valor_unidad
                         ,0        consumo
                         ,0        val_consumo
                     FROM ta_rangvitc
                    WHERE ravtvitc = nuTari) rango_tarifas
                   ,(
                     SELECT raliliir lim_inferior
                           ,ralilisr lim_superior
                           ,ralivalo valor_unidad
                           ,raliunli consumo
                           ,ralivaul val_consumo
                       FROM rangliqu
                      WHERE ralicodo = nuConsec
                        AND ralisesu = nuSesu
                        AND raliconc = nuConcConsumo
                     ) rango_liquidado
                WHERE rango_tarifas.lim_inferior = rango_liquidado.lim_inferior(+)
                  AND rownum <= 7
                  AND rango_tarifas.lim_superior = rango_liquidado.lim_superior(+)
          )
  UNION ALL
   SELECT NULL lim_inferior
         ,NULL lim_superior
         ,NULL valor_unidad
         ,NULL consumo
         ,NULL val_consumo
     FROM servsusc
    WHERE rownum <= nuBlankRanks;
 ELSE
  nuBlankRanks := 7;
  OPEN orfcursor FOR
   SELECT NULL lim_inferior
         ,NULL lim_superior
         ,NULL valor_unidad
         ,NULL consumo
         ,NULL val_consumo
     FROM servsusc
    WHERE rownum <= nuBlankRanks;
 END IF;
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
END RfRangosConsumo;
------------------------------------------------------------------------------------------------------------------------------------------------------

PROCEDURE rfGetValCostCompValid(
                                 nuProducto   servsusc.sesunuse%TYPE
                                ,blNoRegulada BOOLEAN
                                ,orfcursor OUT constants_per.tyrefcursor
                                ) AS
/******************************************************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :  rfGetValCostCompValid
  Descripcion : Obtiene el valor de los componentes del costo
  Autor       : Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  19-03-2015          agordillo           Modificacion Incidente.140493
                                          * Se realiza el llamado a la funcion LDC_DetalleFact_GasCaribe.fnuConceptoComponent
                                          para obtener el concepto que corresponde el componente de costo.
                                          * Se agrega el  tbCompCost(6).concept para que se consulte la tarifa del concepto 741 de
                                          confibiabilidad, dado que en un futuro puede tener valor este componente.
  11-11-2014          ggamarra            Creacion.

******************************************************************************************************************************************/
nuVitcons    ta_vigetaco.vitccons%TYPE;
nuVitcvalo   ta_vigetaco.vitcvalo%TYPE;
rcProduct    servsusc%ROWTYPE;
inuCompType  NUMBER := 1;
inufot       NUMBER := 6;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'rfGetValCostCompValid';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;

TYPE tyrcCompCost IS RECORD(
                            concept NUMBER
                           ,valor   NUMBER
                           );
TYPE tytbCompCost IS TABLE OF tyrcCompCost INDEX BY BINARY_INTEGER;
tbCompCost tytbCompCost;
BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 -- Verifica si el cliente es industria no regulada
 IF NOT blNoRegulada AND nuProducto > 0 THEN
  rcProduct := pktblservsusc.frcgetrecord(nuProducto);
  pkBOInstancePrintingData.instancecurrentproduct(rcProduct);
  -- Inicia Agordillo Incidente.140493
  tbCompCost(1).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('GM'); -- Gm Suministro
  tbCompCost(2).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('TM'); -- Tm Transporte
  tbCompCost(3).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('DM'); -- Dm Distribuccion
  tbCompCost(4).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CV'); -- Cv Comercializacion
  tbCompCost(5).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CM'); -- Cm Componente Fijo
  tbCompCost(6).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CC'); -- Cc Confiabilidad
  -- Fin Agordillo Incidente.140493
  FOR i IN tbCompCost.first .. tbCompCost.last LOOP
   BEGIN
    nuVitcons := FA_BOPrintCostCompRules.fnuGetCostCompValid(
                                                                  tbCompCost(i).concept
                                                                 ,inuCompType
                                                                 ,inuFOT
                                                                 );
    SELECT vitcvalo INTO nuVitcvalo
      FROM ta_vigetaco
     WHERE vitccons = nuVitcons;
     tbCompCost(i).valor := nuVitcvalo;
   EXCEPTION
    WHEN no_data_found THEN
     tbCompCost(i).valor := 0;
    WHEN OTHERS THEN
     tbCompCost(i).valor := 0;
   END;
  END LOOP;
  OPEN orfcursor FOR
   SELECT 'Gm = $' || tbCompCost(1).valor || ' Tm = $' || tbCompCost(2)
               .valor || ' Dm = $' || tbCompCost(3).valor || ' Cv = $' || tbCompCost(4)
               .valor || ' Cc = $' || tbCompCost(6).valor ||
                ' Cm = $' || tbCompCost(5).valor COMPCOST
          FROM dual;

 ELSE
  rcProduct := pktblservsusc.frcgetrecord(nuProducto);
  pkBOInstancePrintingData.instancecurrentproduct(rcProduct);
  tbCompCost(1).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('GM'); -- Gm Suministro
  tbCompCost(2).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('TM'); -- Tm Transporte
  tbCompCost(3).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('DM'); -- Dm Distribuccion
  tbCompCost(4).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CV'); -- Cv Comercializacion
  tbCompCost(5).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CM'); -- Cm Componente Fijo
  tbCompCost(6).concept := LDC_DetalleFact_GasCaribe.fnuConceptoComponent('CC'); -- Cc Confiabilidad
  FOR i IN tbCompCost.first .. tbCompCost.last LOOP
   BEGIN
    nuVitcons := FA_BOPrintCostCompRules.fnuGetCostCompValid(
                                                                  tbCompCost(i).concept
                                                                 ,inuCompType
                                                                 ,inuFOT
                                                                 );
    SELECT vitcvalo INTO nuVitcvalo
      FROM ta_vigetaco
     WHERE vitccons = nuVitcons;
     tbCompCost(i).valor := nuVitcvalo;
   EXCEPTION
    WHEN no_data_found THEN
      tbCompCost(i).valor := 0;
    WHEN OTHERS THEN
       tbCompCost(i).valor := 0;
   END;
  END LOOP;
  OPEN orfcursor FOR
   SELECT 'Gm = $' || tbCompCost(1).valor || ' Tm = $' || tbCompCost(2)
               .valor || ' Dm = $' || tbCompCost(3).valor || ' Cv = $' || tbCompCost(4)
               .valor || ' Cc = $' || tbCompCost(6).valor || -- Agordillo Incidente.140493
                ' Cm = $' || tbCompCost(5).valor COMPCOST
          FROM dual;
 END IF;
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
END rfGetValCostCompValid;
------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosCodBarras(
                           sbFactcodi ge_boInstanceControl.stysbValue
                          ,orfcursor  OUT constants_per.tyrefcursor
                          ) AS
/************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosCodBarras
  Descripcion    : procedimiento para extraer los datos relacionados
                   al codigo de barras
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  11/11/2014      ggamarra             Creaci?n.
  04/06/2025	  jsoto				  OSF-4272 Se modifica cursor
									  Se cambia cursor por llamado a utilidad
									  pkg_bcImpresionCodigoBarras.ftbDatosCodigoBarras para obtener los
									  datos para el código de barras
  04/06/2025	  jsoto				  OSF-4272 Se modifica cursor
									  Se cambia cursor por llamado a utilidad
									  pkg_bcImpresionCodigoBarras.ftbDatosCodigoBarras para obtener los
									  datos para el código de barras
*************************************************************************************/

    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfDatosCodBarras';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
	dtFechaVencFactura	DATE;
	tbCodigoBarras 		pkg_bcImpresionCodigoBarras.tytbDatosCodBarras;
	sbCodEmpresa		empresa.codigo%TYPE;
	nuIndice			NUMBER;
	rcPeriodo			pkg_perifact.sbtRegPeriodofact;
	sbFactPefa			perifact.pefacodi%TYPE;

	dtFechaVencFactura	DATE;
	tbCodigoBarras 		pkg_bcImpresionCodigoBarras.tytbDatosCodBarras;
	sbCodEmpresa		empresa.codigo%TYPE;
	nuIndice			NUMBER;
	rcPeriodo			pkg_perifact.sbtRegPeriodofact;
	sbFactPefa			perifact.pefacodi%TYPE;


BEGIN
 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 pkg_traza.trace('sbFactcodi: '||sbFactcodi);

 sbFactPefa := pkg_factura.fnuobtfactpefa(TO_NUMBER(sbFactcodi));

 rcPeriodo := pkg_perifact.frcObtInfoPeriodo(TO_NUMBER(sbFactPefa));

 dtFechaVencFactura := add_months(rcPeriodo.pefafepa,120);

 sbCodEmpresa 		:= pkg_boconsultaempresa.fsbObtEmpresaFactura(sbFactcodi);

 tbCodigoBarras := pkg_bcImpresionCodigoBarras.ftbDatosCodigoBarras(pkbobillprintheaderrules.fsbgetcoupon(),dtFechaVencFactura,sbCodEmpresa);

	nuIndice := tbCodigoBarras.FIRST;

	IF nuIndice IS NOT NULL THEN

		pkg_traza.trace('tbCodigoBarras(nuIndice).codigo_1 '||tbCodigoBarras(nuIndice).codigo_1);
		pkg_traza.trace('tbCodigoBarras(nuIndice).codigo_2 '||tbCodigoBarras(nuIndice).codigo_2);
		pkg_traza.trace('tbCodigoBarras(nuIndice).codigo_3 '||tbCodigoBarras(nuIndice).codigo_3);
		pkg_traza.trace('tbCodigoBarras(nuIndice).codigo_4 '||tbCodigoBarras(nuIndice).codigo_4);
		pkg_traza.trace('tbCodigoBarras(nuIndice).codigo_barras '||tbCodigoBarras(nuIndice).codigo_barras);

		OPEN orfcursor FOR
		SELECT 	tbCodigoBarras(nuIndice).codigo_1 codigo_1
				,tbCodigoBarras(nuIndice).codigo_2 codigo_2
				,tbCodigoBarras(nuIndice).codigo_3 codigo_3
				,tbCodigoBarras(nuIndice).codigo_4 codigo_4
				,tbCodigoBarras(nuIndice).codigo_barras codigo_barras
		FROM dual;

	END IF;


 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

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
END RfDatosCodBarras;
--------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosCuenxCobrTt(
                             sbFactsusc  ge_boInstanceControl.stysbValue
                            ,orfcursor OUT constants_per.tyrefcursor
                            ) IS
/****************************************************************************************************************
 Propiedad intelectual de GDC (c).

 Unidad         : RfDatosCuenxCobrTt
 Descripcion    : funcion que devuelve el valor por cobrar de la tarifa transitoria

 Autor          : Luis Javier Lopez Barrios / Horbath

 Parametros           Descripcion
 ============         ===================
 inuSusccodi          contrato

 Fecha             Autor             Modificacion
 =========       =========           ====================
 04-01-2021       Horbath           CA559. Se ajusta para que valide el valor del parametro LDC_MET_CALCTOTAL
****************************************************************************************************************/
sbTipoMet   ld_parameter.value_chain%TYPE;
nuConcepto  ld_parameter.numeric_value%TYPE;

  csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfDatosCuenxCobrTt';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 -- Obtiene el identificador del contrato instanciado
 sbTipoMet  := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_MET_CALCTOTAL');
 nuConcepto := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CONCTATT');
 -- Si el valor es T, indica que se deben tener en cuenta todos los conceptos
 IF sbTipoMet = 'T' THEN
  OPEN orfcursor FOR
   SELECT nvl(abs(SUM(decode(dpttsign, 'CR', -nvl(dpttvano,0), nvl(dpttvano,0)))),0) acumu
     FROM ldc_deprtatt, ldc_prodtatt
    WHERE dpttcont = sbfactsusc
      AND prttsesu = dpttsesu
      AND prttacti = 'S';
   -- Si el valor es C, indica que se debe tener en cuenta unicamente el concepto de consumo
 ELSIF sbTipoMet = 'C' THEN
  OPEN orfcursor FOR
   SELECT nvl(abs(SUM(decode(dpttsign, 'CR', -nvl(dpttvano,0), nvl(dpttvano,0)))),0) acumu
     FROM ldc_deprtatt, ldc_prodtatt
    WHERE dpttcont = sbfactsusc
      AND prttsesu = dpttsesu
      AND dpttconc = nuconcepto
      AND prttacti = 'S';
   -- En caso contrario retornara nulo
 ELSE
  OPEN orfcursor FOR
   SELECT ' ' acumu FROM dual;
 END IF;

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
END rfdatoscuenxcobrtt;

 FUNCTION fnuGetValorIva ( inuConcepto IN cargos.cargconc%type,
                           inuCuenta   IN cargos.cargcuco%type) RETURN NUMBER IS
  /****************************************************************************************************************
     Propiedad intelectual de GDC (c).

     Unidad         : fnuGetValorIva
     Descripcion    : funcion que devuelve el valor de Iva

     Autor          : Luis Javier Lopez Barrios / Horbath

     Parametros           Descripcion
     ============         ===================
     inuConcepto          concepto
     inuCuenta            cuenta de cobro

     Fecha             Autor             Modificacion
     =========       =========           ====================
     04-07-2024       Horbath           OSF-2158
    ****************************************************************************************************************/
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuGetValorIva';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    nuValorIva          NUMBER;

    CURSOR cuGetValorIva IS
    SELECT nvl(SUM(decode(cargsign, 'CR', -cargvalo, cargvalo)),0)
    FROM cargos, concbali, concepto
    WHERE concbali.coblcoba = inuConcepto
      AND cargos.cargconc = concbali.coblconc
      AND cargos.cargcuco = inuCuenta
      AND concepto.conccodi = cargos.cargconc
      AND concepto.concticl = 4;

  BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    IF cuGetValorIva%ISOPEN THEN CLOSE cuGetValorIva; END IF;
    OPEN cuGetValorIva;
    FETCH cuGetValorIva INTO nuValorIva;
    CLOSE cuGetValorIva;
    pkg_traza.trace(' nuValorIva: ' || nuValorIva, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuValorIva;
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
 END fnuGetValorIva;
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

/******************************************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfConcepParcial
    Descripcion    : Procedimiento para mostrar el iva y el subtotal de los no regulados.
    Autor          : Gabriel Gamarra - Horbath Technologies

     Parametros           Descripcion
     ============         ===================

     orfcursor            Retorna los datos

    Historia de Modificaciones
        Fecha           Autor               Modificacion
        =========       =========           ====================
		20/05/2025      LJLB                OSF-4456: se agrega logica para que se muestre el saldo de diferido y cuotas a usuarios
                                            no regulados
        15/05/2025      LJLB                OSF-4454: se agrega logica para que a los diferidos no se le muestre el concepto
        03/02/2025		LJLB				OSF-3707: se agrega logica de unidades por concepto
		20/05/2025      LJLB                OSF-4456: se agrega logica para que se muestre el saldo de diferido y cuotas a usuarios
                                            no regulados
        15/05/2025      LJLB                OSF-4454: se agrega logica para que a los diferidos no se le muestre el concepto
        03/02/2025		LJLB				OSF-3707: se agrega logica de unidades por concepto
		01/10/2024      LJLB                OSF-3398: se modifica para quitar saldo a favor del subtotal y quitar concepto de
											716 de las cuotas
		23/05/2024      LJLB                OSF-2738 se coloca nuevo parametros con los conceptos de IVA
        18-09-2023		jpinedc (MVM)       OSF-1462: Se usa nuSaldoAnterior en lugar de
                                            nuSaldoProd
		26-07-2023		cgonzalez (Horbath) OSF-1367: Se modifica para que la variable gsbCargosMes se le
												asigne el valor de presente_mes solo cuando el producto es regulado
        04/11/2022      jcatuchemvm         OSF-660: Se ajusta la descripcion de los conceptos
                                            31 - Consumo y 196 - Subsidio para periodos recuperados

                                            Descripción actual:
                                                CONSUMO DE GAS NATURAL CO-XXAJ-YYYYMM
                                                SUBSIDIO AJ-YYYYMM

                                            Ajuste solicitado:
                                                Ajuste de Consumo (XXm3 - MES-YYYY)
                                                Ajuste de Subsidio (XXm3 - MES-YYYY)
        11/11/2014      ggamarra            Creacion.
*******************************************************************************************/

PROCEDURE RfConcepParcial(
                          sbFactcodi  ge_boInstanceControl.stysbValue
                         ,sbFactsusc  ge_boInstanceControl.stysbValue
                         ,blnregulado BOOLEAN
                         ,orfcursor   OUT constants_per.tyrefcursor
                         ) IS
 nuServicio       servsusc.sesuserv%TYPE;
 nuRegtblProdDife NUMBER;
 nuidx832         BINARY_INTEGER;
 sbmensa          VARCHAR2(5000);
 nmvacoddif       NUMBER;

 TYPE tyrcCargos IS RECORD(
                            cargcuco cargos.cargcuco%TYPE
                           ,cargnuse cargos.cargnuse%TYPE
                           ,servcodi servicio.servcodi%TYPE
                           ,servdesc servicio.servdesc%TYPE
                           ,cargconc cargos.cargconc%TYPE
                           ,concdefa concepto.concdefa%TYPE
                           ,cargcaca cargos.cargcaca%TYPE
                           ,cargsign cargos.cargsign%TYPE
                           ,cargpefa cargos.cargpefa%TYPE
                           ,cargvalo cargos.cargvalo%TYPE
                           ,cargdoso cargos.cargdoso%TYPE
                           ,cargcodo cargos.cargcodo%TYPE
                           ,cargunid cargos.cargunid%TYPE
                           ,cargfecr cargos.cargfecr%TYPE
                           ,cargprog cargos.cargprog%TYPE
                           ,cargpeco cargos.cargpeco%TYPE
                           ,cargtico cargos.cargtico%TYPE
                           ,cargvabl cargos.cargvabl%TYPE
                           ,cargtaco cargos.cargtaco%TYPE
                           ,orden    NUMBER
                          );

 TYPE tytbCargos IS TABLE OF tyrcCargos INDEX BY BINARY_INTEGER;
 tbCargos     tytbCargos;
 tbCargosNull tytbCargos;
 TYPE tyrcCargosOrd IS RECORD(
                              etiqueta       VARCHAR2(3)
                             ,concepto_id    NUMBER
                             ,conceptos      VARCHAR2(60)
                             ,signo          VARCHAR2(10)
                             ,orden          NUMBER
                             ,saldo_ant      NUMBER
                             ,capital        NUMBER
                             ,interes        NUMBER
                             ,total          NUMBER
                             ,saldo_dif      NUMBER
                             ,cuotas         NUMBER
                             ,car_doso       VARCHAR2(100)
                             ,car_caca       NUMBER
                             ,servicio       NUMBER
                             ,unidad_items   VARCHAR2(10)
                             ,cantidad       NUMBER
                             ,valor_iva      NUMBER
                             ,valor_unitario NUMBER
                             );

 TYPE tytbFinal   IS TABLE OF tyrcCargosOrd INDEX BY BINARY_INTEGER;
 tbCargosOrdered  tytbFinal;
 tbFinalNull      tytbFinal;
 TYPE tytbNumber  IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
 TYPE tytbVarchar IS TABLE OF NUMBER INDEX BY VARCHAR2(10);
 TYPE rcConcep IS RECORD(
                         cargconc NUMBER
                        ,cargdoso VARCHAR2(50)
                        ,cargvalo NUMBER(13, 2)
                        );

 TYPE tbConcep IS TABLE OF rcConcep INDEX BY VARCHAR2(50);
 tConcep tbConcep;
 gtbFinancion tytbNumber;
 gtbIvaConc     tytbNumber;


 gtbConceptos tytbVarchar;
 TYPE tytProducDiferidos IS RECORD(
                                   nuProducto  NUMBER
                                  ,nuSaldoDife NUMBER
                                  ,nuCuota     NUMBER
                                  );
 TYPE tytbProduDife  IS TABLE OF tytProducDiferidos INDEX BY BINARY_INTEGER;
 tblProdDife  tytbProduDife;
 nuIndex               NUMBER := 0;
 sbConcIVA             VARCHAR2(2000) := pkg_parametros.fsbGetValorCadena('CONCEPTOS_IVA');
 sbConcRecamora        VARCHAR2(2000) := pkg_parametros.fsbGetValorCadena('CONCEPTOS_RECARGO_MORA');
 nuDifesape            NUMBER;
 nuDifecuotas          NUMBER;
 nuInteres             NUMBER;
 nuLastSesu            NUMBER;
 nuConcSuministro      NUMBER := 200;
 nuConcComercial       NUMBER := 716;
 inx                   NUMBER;
 inxConc               VARCHAR2(10);
 i                     NUMBER;
 j                     NUMBER;
 k                     NUMBER;
 nuSaldoAnterior       NUMBER;
 nuSaldoProd           NUMBER;
 rcProduct             servsusc%ROWTYPE;
 rcProductNull         servsusc%ROWTYPE;
 nuPorcSubs            NUMBER;
 sbIdentifica          ld_policy.identification_id%TYPE;
 nuDoso                cargos.cargdoso%TYPE;
 nuConcSubAdi          NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CONSUBADI');
 nuConcSubAdiTT        NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CONSUBADITT');
 nuConcSubTT           NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CONSUBTRAS');
 sbdoso196             cargos.cargdoso%type := null;
 nucodo196             cargos.cargcodo%type := null;
 sbAplicasoosf65       VARCHAR2(1);
 nmconta               NUMBER(4);
 nmdfinte              diferido.difeinte%TYPE;
 nmvalsubcreg048       ldc_deprtatt.dpttvano%TYPE;
 nmvalconsucreg048     ldc_deprtatt.dpttvano%TYPE;
 nuConcInte            NUMBER        := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_CONCINTTT');
 sbprograma            VARCHAR2(40)  := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_PROGAGRUP');
 sbTextagrupador       VARCHAR2(400) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_TEXTAGRUP');
 sbaplicaentrega635    VARCHAR2(1)   := 'N';
 nuFinanciacion        VARCHAR2(400);
 sbPlanCon             VARCHAR2(4000) := ','||PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_PLANCOCF')||',';
 sbPlanOtr             VARCHAR2(4000) := ','||PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_PLANOTCO')||',';
 sbDescCon             VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_DESCPLCO');
 sbDescOtrco           VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_DESCPLOC');
 sbconcdefa            concepto.concdefa%type;
 nuAplicaEntrega200342 NUMBER;
 sbcod_con_iva_gdc     ld_parameter.value_chain%type := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('COD_CON_IVA_GDC');
 sbindice              VARCHAR2(50);
 nucargconc            cargos.cargconc%TYPE := NULL;
 sbcargdoso            cargos.cargdoso%TYPE := NULL;
 nucargvalo            cargos.cargvalo%TYPE := NULL;
 sbCodiFactProt        VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_CODCONCSEGUPROT'); -- se lamacena codigo de factura protegida
 nuExiste              NUMBER;
 sbDescriConBri        VARCHAR2(150) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_DESCCONCCREDBRIL');
 nuSaldoDife           NUMBER;
 nuIndeBri             NUMBER := 1;
 csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfConcepParcial';--nombre del método
 sbConcExcluir   VARCHAR2(4000) := pkg_parametros.fsbgetvalorcadena('CONC_EXCLUIR_INGRESO_FAEL');
 sbTipoProdExcluir   VARCHAR2(2000) := pkg_parametros.fsbgetvalorcadena('TIPO_PRODUCTO_EXCLUIR_FAEL');
 nuAplicaTiPro  NUMBER;
 blConcGravado  BOOLEAN;



 nuAplica  NUMBER;
 nuValorIva NUMBER;
 CURSOR cudososubsidio (nufactura factura.factcodi%TYPE, inupericose NUMBER) IS
  SELECT cargdoso,cargcodo
    FROM cargos, cuencobr, factura
   WHERE cucocodi = cargcuco
     AND cucofact = factcodi
     AND factcodi = nufactura
     AND cargconc = 196
     AND cargpeco = inupericose
     AND rownum   = 1;

 CURSOR cuCargos IS
  SELECT cargcuco
        ,cargnuse
        ,servcodi
        ,servdesc
        ,decode(cargconc, nuconcsubadi, 196,nuconcsubaditt, nuconcsubtt, cargconc) cargconc
        ,concdefa
        ,cargcaca
        ,cargsign
        ,cargpefa
        ,cargvalo
        ,decode(cargconc, nuconcsubaditt, 'SUBTRAN'||cargpeco, nuConcSubTT, 'SUBTRAN'||cargpeco,  cargdoso) cargdoso
        ,decode(cargconc, nuconcsubaditt, 0, nuconcsubtt, 0,  cargcodo) cargcodo
        ,cargunid
        ,cargfecr
        ,cargprog
        ,cargpeco
        ,cargtico
        ,cargvabl
        ,cargtaco
        ,orden
      -- Se ordenan los productos seg?n el orden que se requiere
    FROM cargos a
        ,cuencobr
        ,servsusc
        ,concepto
        ,(
          SELECT decode(servcodi,
                            7014,
                            1,
                            6121,
                            2,
                            7055,
                            3,
                            7056,
                            4,
                            7053,
                            5,
                            7052,
                            6,
                            7054,
                            7,
                            99) orden
        ,servcodi
        ,servdesc
    FROM servicio) Serv_ord
   WHERE cucofact = sbFactcodi
     AND cargcuco = cucocodi
     AND cargnuse = sesunuse
     AND sesuserv = servcodi
     AND decode (cargconc, nuConcSubAdi, 196, nuConcSubAdiTT,nuConcSubTT , cargconc)  = conccodi
     AND (concticl <> 4 OR (concticl = 4  AND cargdoso LIKE 'DF-%'))
     AND cargconc NOT IN ( CASE WHEN sbaplicaentrega635 = 'S' THEN
                             nvl(nuconcinte,0)
                           ELSE
                              -1
                           END )
     AND ((SELECT nvl(SUM(decode(c.cargsign, 'CR', -c.cargvalo, c.cargvalo)),0)
             FROM cargos c
            WHERE c.cargcuco = a.cargcuco
              AND c.cargconc = a.cargconc
              AND c.cargsign IN ('DB', 'CR')
              AND c.cargdoso = a.cargdoso) <> 0
        OR a.cargsign NOT IN ('DB', 'CR'))
   UNION -- Se agregan los productos que no facturan en la cuenta Y tengan saldo pendiente
  SELECT -1 cargcuco
        ,sesunuse cargnuse
        ,servcodi
        ,servdesc
        ,-1 cargconc
        ,NULL concdefa
        ,-1 cargcaca
        ,'XX' cargsign
        ,-9999 cargpefa
        ,0 cargvalo
        ,'-' cargdoso
        ,0 cargcodo
        ,0 cargunid
        ,SYSDATE cargfecr
        ,NULL cargprog
        ,NULL cargpeco
        ,NULL cargtico
        ,NULL cargvabl
        ,NULL cargtaco
        ,orden
      -- Se ordenan los productos seg?n el orden que se requiere
    FROM servsusc
        ,(SELECT decode(servcodi,
                            7014,
                            1,
                            6121,
                            2,
                            7055,
                            3,
                            7056,
                            4,
                            7053,
                            5,
                            7052,
                            6,
                            7054,
                            7,
                            99) orden,
                     servcodi,
                     servdesc
                FROM servicio) Serv_ord
   WHERE sesususc = sbFactsusc
     AND sesuserv = servcodi
     AND pkbccuencobr.fnugetoutstandbal(sesunuse) > 0
   ORDER BY orden, cargnuse, cargpefa DESC, cargdoso;

 CURSOR cuDiferidos(inuproducto in number) IS
  SELECT d.difecodi difecodi
       ,d.difesusc difesusc
       ,d.difeconc difeconc
       ,d.difevatd difevatd
       ,d.difevacu difevacu
       ,d.difecupa difecupa
       ,d.difenucu difenucu
       ,d.difesape difesape
       ,d.difenudo difenudo
       ,d.difeinte difeinte
       ,d.difeinac difeinac
       ,d.difeusua difeusua
       ,d.difeterm difeterm
       ,d.difesign difesign
       ,d.difenuse difenuse
       ,d.difemeca difemeca
       ,d.difecoin difecoin
       ,d.difeprog difeprog
       ,d.difepldi difepldi
       ,d.difefein difefein
       ,d.difefumo difefumo
       ,d.difespre difespre
       ,d.difetain difetain
       ,d.difefagr difefagr
       ,d.difecofi difecofi
       ,d.difetire difetire
       ,d.difefunc difefunc
       ,d.difelure difelure
       ,d.difeenre difeenre
       ,c.conccodi conccodi
       ,c.concdesc concdesc
       ,c.conccoco conccoco
       ,c.concorli concorli
       ,c.concpoiv concpoiv
       ,c.concorim concorim
       ,c.concorge concorge
       ,c.concdife concdife
       ,c.conccore conccore
       ,c.conccoin conccoin
       ,c.concflde concflde
       ,c.concunme concunme
       ,
        (CASE WHEN instr(sbPlanCon,','||d.difepldi||',') > 0 THEN
                 sbDescCon ||ldc_detallefact_gascaribe.fsbGetPeriodo(d.difenuse, d.difecodi)
              WHEN instr(sbPlanOtr,','||d.difepldi||',') > 0 THEN
                sbDescOtrco ||ldc_detallefact_gascaribe.fsbGetPeriodo(d.difenuse, d.difecodi)
              WHEN (instr(','||difeprog||',' , ','||sbprograma||',') > 0 ) AND sbaplicaentrega635 = 'S'  THEN
                     sbTextagrupador||'_'||to_char(difefein, 'dd/mm/yyyy')
             ELSE
               nvl( fsbGetDescConcDife(s.sesuserv, d.difeconc, d.difefein) ,c.concdefa)
         END ) concdefa
        ,
         (CASE WHEN (instr(','||difeprog||',' , ','||sbprograma||',') > 0 ) AND sbaplicaentrega635 = 'S'  THEN
           'S'
          ELSE
           'N'
          END
         ) aplicaagrup
        ,c.concflim concflim
        ,c.concsigl concsigl
        ,c.conctico conctico
        ,c.concnive concnive
        ,c.concclco concclco
        ,c.concticc concticc
        ,c.concticl concticl
        ,c.concappr concappr
        ,c.conccone conccone
        ,c.concapcp concapcp
        , s.sesuserv
    FROM diferido d, concepto c, servsusc s
   WHERE difesusc = sbfactsusc
     AND difesape > 0
     AND s.sesunuse = d.difenuse
     AND s.sesunuse = inuproducto
     AND difeconc = conccodi;

 SUBTYPE stytbcuDiferidos IS cuDiferidos%ROWTYPE;
 TYPE tytbcuDiferidos IS TABLE OF stytbcuDiferidos INDEX BY BINARY_INTEGER;
 tdiferidos tytbcuDiferidos;

   -- Tipo de dato de tabla PL donde el indice es el concepto y el valor es la unidad de medida
  tbUnidadMedConc pkg_conc_unid_medida_dian.tytbUnidadMedConc;
  nuCantidad NUMBER;
  sbUnidMed        VARCHAR2(20);
  nuValorUnitario  NUMBER(25,2);

  CURSOR cuGetSaldoDif(inuDiferido IN NUMBER) IS
  SELECT decode(difesign, 'DB', difesape, -1 * difesape)
                         ,(difenucu - difecupa)
  FROM diferido
  WHERE difecodi =inuDiferido;

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    nuLastSesu  := -1;
    inx         := 1;

    IF sbcod_con_iva_gdc IS NOT NULL THEN
        sbconciva := sbconciva || '|' || sbcod_con_iva_gdc;
    END IF;
    gsbTotal              := NULL;
    gsbivanoregulado      := NULL;
    gsbSubtotalNoReg      := NULL;
    gsbCargosMes          := NULL;
    gnuConcNumber         := 0;
    nuAplicaEntrega200342 := 1;
    sbaplicaentrega635    := 'S';
    sbAplicasoosf65       := 'S';
    tbCargos              := tbCargosNull;
    tbCargosOrdered       := tbFinalNull;

	--se carga tabla de unidades de medida
	tbUnidadMedConc.DELETE;

    tbUnidadMedConc := pkg_conc_unid_medida_dian.ftblCargarUnidadxConcepto;


    OPEN cuCargos;
    FETCH cuCargos BULK COLLECT INTO tbCargos;
    CLOSE cuCargos;

    IF NOT blNRegulado THEN
        pkg_traza.trace('Crear detalles para los regulados ', pkg_traza.cnuNivelTrzDef);
        i := tbCargos.first;
        tConcep.Delete; --200-2156 Se formatea tabla en memoria.
        gtbIvaConc.DELETE;
        LOOP
            EXIT WHEN i IS NULL;
            tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
            tbCargosOrdered(-1).servicio  := tbCargos(i).servcodi; -- Total servicio
            tbCargosOrdered(-2).servicio  := tbCargos(i).servcodi; -- IVA
            tbCargosOrdered(-3).servicio  := tbCargos(i).servcodi; -- Recargo por mora gravado
            tbCargosOrdered(-4).servicio  := tbCargos(i).servcodi; -- Recargo por mora no gravado
            nuValorIva := 0;
			nuAplicaTiPro := 0;


			SELECT COUNT(1) into nuAplicaTiPro
			FROM (
					SELECT to_number(regexp_substr(sbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS tipo_prod
					FROM dual
					CONNECT BY regexp_substr(sbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
			WHERE tipo_prod = tbCargos(i).servcodi;

            -- Imprime encabezado si cambia de servicio suscrito
            IF nuLastSesu <> tbCargos(i).cargnuse THEN
               rcProduct := pktblservsusc.frcgetrecord(tbCargos(i).cargnuse);
               pkboinstanceprintingdata.instancecurrentproduct(rcProduct);
               nuSaldoAnterior := ldc_detallefact_gascaribe.FnuGetSaldoAnterior(
                                        to_number(sbFactsusc)
                                       ,to_number(sbFactcodi)
                                       ,tbCargos(i).cargnuse
                                    );
                pkboinstanceprintingdata.instancecurrentproduct(rcProductNull);
                nuSaldoProd := pkbccuencobr.fnugetoutstandbal(tbCargos(i).cargnuse);
                --Validacion diferidos con saldo no asociados a una cuenta de cobro

                IF (tbCargos(i).cargpefa = -9999 AND nuSaldoProd > 0) OR tbCargos(i).cargpefa <> -9999 THEN
                    tbCargosOrdered(inx).etiqueta := '31';
                    IF tbCargos(i).servcodi IN (7055, 7056) THEN
                        tbCargosOrdered(inx).conceptos := upper(tbCargos(i).servdesc) ||' (Serv.Susc.' || tbCargos(i).cargnuse || ')';
                    ELSE
                        tbCargosOrdered(inx).conceptos := 'SERV.' ||upper(tbCargos(i).servdesc) ||' (Serv.Susc.' || tbCargos(i).cargnuse || ')';
                    END IF;
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    -- Se crea la linea de saldo anterior si tiene
                    IF nvl(nuSaldoAnterior, 0) > 0 THEN
                        tbCargosOrdered(inx).etiqueta := '32';
                        tbCargosOrdered(inx).conceptos := 'Saldo Anterior';
                        tbCargosOrdered(inx).saldo_ant := nuSaldoAnterior;
                        inx := inx + 1;
                    ELSE
                        -- El producto no tiene cargos, muestra el saldo para que salga en el detalle
                        IF tbCargos(i).cargpefa = -9999 THEN
                            tbCargosOrdered(inx).etiqueta := '32';
                            tbCargosOrdered(inx).conceptos := 'Saldo Anterior';
                            tbCargosOrdered(inx).saldo_ant := nuSaldoAnterior;
                            inx := inx + 1;
                        END IF;
                    END IF;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    -- Crea el detalle de totales
                    tbCargosOrdered(-1).etiqueta := '33';
                    tbCargosOrdered(-1).car_doso := tbCargos(i).cargnuse;
                    tbCargosOrdered(-1).conceptos := 'Total Servicio:';
                    tbCargosOrdered(-1).capital := 0;
                    tbCargosOrdered(-1).interes := 0;
                    tbCargosOrdered(-1).total := 0;
                    tbCargosOrdered(-1).saldo_dif := 0;
                    tbCargosOrdered(-1).valor_iva :=  0;

                    -- Crea el acumulado de IVA
                    tbCargosOrdered(-2).etiqueta := '32';
                    tbCargosOrdered(-2).conceptos := 'IVA';
                    tbCargosOrdered(-2).capital := 0;
                    -- Crea el acumulado de Recargo por mora
                    tbCargosOrdered(-3).etiqueta := '32';
                    tbCargosOrdered(-3).conceptos := 'x';
                    tbCargosOrdered(-3).interes := 0;
                    tbCargosOrdered(-3).valor_iva :=  0;
                    tbCargosOrdered(-3).valor_unitario := 0;
                    tbCargosOrdered(-3).car_doso := tbCargos(i).servcodi;

                    tbCargosOrdered(-4).etiqueta := '32';
                    tbCargosOrdered(-4).conceptos := 'x';
                    tbCargosOrdered(-4).interes := 0;
                    tbCargosOrdered(-4).valor_iva :=  0;
                    tbCargosOrdered(-4).valor_unitario := 0;
                    tbCargosOrdered(-4).car_doso := tbCargos(i).servcodi;

                    gtbIvaConc.DELETE;
                END IF;
            END IF;
            -- Crea los detalles
            -- se cambian los valores seg?n los signos, no se estan teniendo en cuenta SA
            IF tbCargos(i).cargsign IN ('CR', 'AS', 'PA') THEN
               tbCargos(i).cargvalo := -1 * tbCargos(i).cargvalo;
            ELSIF tbCargos(i).cargsign IN ('DB') THEN
               tbCargos(i).cargvalo := tbCargos(i).cargvalo;
            ELSE
               tbCargos(i).cargvalo := 0;
            END IF;

            SELECT COUNT(1) INTO nuExiste
            FROM (SELECT to_number(regexp_substr(sbCodiFactProt,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)) AS concepto
                    FROM dual
                  CONNECT BY regexp_substr(sbCodiFactProt, '[^,]+', 1, LEVEL) IS NOT NULL)
            WHERE tbCargos(i).cargconc = concepto ;

            -- Modificaci?n de las descripciones de los conceptos
            CASE
                -- Si el concepto es prima seguros se agrega la cedula
                WHEN tbCargos(i).servcodi IN (7053)
                    AND instr('|' || sbConcIVA || '|','|' || tbCargos(i).cargconc || '|') = 0
                    AND instr('|' || sbConcRecamora || '|','|' || tbCargos(i).cargconc || '|') = 0
                    AND substr(tbCargos(i).cargdoso, 0, 3)  NOT IN ('ID-', 'DF-') THEN
                    BEGIN
                       SELECT identification_id INTO sbIdentifica
                         FROM ld_policy
                        WHERE product_id = tbCargos(i).cargnuse;
                              tbCargos(i).concdefa := tbCargos(i).concdefa || ' CC: ' || sbIdentifica;
                    EXCEPTION
                        WHEN OTHERS THEN
                            NULL;
                    END;
                -- Si el concepto es subsidio se agrega el %
                WHEN tbCargos(i).servcodi IN (7014) AND tbCargos(i).cargconc = 196 THEN
                    OPEN cuDosoSubsidio(sbFactcodi, tbCargos(i).cargpeco);
                    FETCH cuDosoSubsidio into sbdoso196, nucodo196;
                    IF cuDosoSubsidio%NOTFOUND THEN
                       sbdoso196 := NULL;
                       nucodo196 := NULL;
                    END IF;
                    CLOSE cuDosoSubsidio;
                    tbCargos(i).cargdoso := sbdoso196;
                    IF tbCargos(i).cargdoso LIKE 'SU-PR%' THEN
                        tbCargos(i).concdefa := 'Ajuste de Subsidio ('||tbCargos(i).cargunid||'m3 - '||initcap(trim(to_char(to_date(substr(tbCargos(i).cargdoso, 11,2),'MM'),'MONTH')))||'-'||substr(tbCargos(i).cargdoso, 7,4)||')';
                    ELSE
                        tbCargos(i).concdefa := tbCargos(i).concdefa ;
                        IF sbdoso196 IS NOT NULL AND nucodo196 IS NOT NULL THEN
                            tbCargos(i).cargdoso := sbdoso196;
                            tbCargos(i).cargcodo := nucodo196;
                        END IF;
                    END IF;
                      -- Inicio OSF-65 JJJM
                    IF sbAplicasoosf65 = 'S' THEN
                        BEGIN
                            nuPorcSubs := NULL;
                            SELECT SUM(ralivasu) * 100 / SUM(ralivaul) INTO nuPorcSubs
                              FROM rangliqu
                             WHERE ralipefa = tbCargos(i).cargpefa
                               AND raliconc = 31
                               AND ralisesu = tbCargos(i).cargnuse
                               AND ralivasu > 0;
                            IF tbCargos(i).cargdoso NOT LIKE 'SU-PR%' AND tbCargos(i).cargdoso LIKE 'SU-%' AND nuPorcSubs IS NOT NULL THEN
                                tbCargos(i).concdefa := tbcargos(i).concdefa||' '||replace(to_char(round(to_char(nuPorcSubs), 2), '999990.99'), ' ', '') ||'% Cons.';
                            END IF;
                        EXCEPTION
                            WHEN OTHERS THEN
                                NULL;
                        END;
                    END IF;
                WHEN tbCargos(i).servcodi IN (7014) AND tbCargos(i).cargconc = 167 AND sbAplicasoosf65 = 'S' THEN
                -- Obtenemos el valor del cargos del concepto : "SUBSIDIO - RESCREG048"
                    nmvalsubcreg048 := 0;
                    BEGIN
                       SELECT r.dpttvano INTO nmvalsubcreg048
                         FROM ldc_deprtatt r
                        WHERE r.dpttsesu = tbCargos(i).cargnuse
                          AND r.dpttcuco = tbCargos(i).cargcuco
                          AND r.dpttpeco = tbCargos(i).cargpeco
                          AND r.dpttconc = 167
                          AND r.dpttrang = '0 - 20';
                    EXCEPTION
                        WHEN no_data_found THEN
                            nmvalsubcreg048 := 0;
                        WHEN OTHERS THEN
                            nmvalsubcreg048 := -1;
                    END;
                    nmvalsubcreg048 := nmvalsubcreg048 * 100;
                    -- Obtenemos el valor del cargos del concepto : "CONSUMO - RESCREG048"
                    nmvalconsucreg048 := 0;
                    BEGIN
                       SELECT r.dpttvano INTO nmvalconsucreg048
                         FROM ldc_deprtatt r
                        WHERE r.dpttsesu = tbCargos(i).cargnuse
                          AND r.dpttcuco = tbCargos(i).cargcuco
                          AND r.dpttpeco = tbCargos(i).cargpeco
                          AND r.dpttconc = 130
                          AND r.dpttrang = '0 - 20';
                    EXCEPTION
                        WHEN no_data_found THEN
                            nmvalconsucreg048 := 0;
                        WHEN OTHERS THEN
                            nmvalconsucreg048 := -1;
                    END;
                    nuPorcSubs := NULL;
                    IF nmvalconsucreg048 = 0  THEN
                        nuPorcSubs := 0;
                    ELSIF nmvalconsucreg048 = -1 OR nmvalsubcreg048 = -1 THEN
                        nuPorcSubs := -1;
                    ELSE
                        nuPorcSubs := nmvalsubcreg048/nmvalconsucreg048;
                    END IF;
                    IF nuPorcSubs IS NOT NULL THEN
                        tbCargos(i).concdefa := tbcargos(i).concdefa||' '||replace(to_char(round(to_char(nuPorcSubs), 2), '999990.99'), ' ', '')||'% Cons.';
                    END IF;
                    -- Fin OSF-65 JJJM
                -- Si el concepto es contribuci?n se agrega el %
                WHEN tbCargos(i).servcodi IN (7014) AND tbCargos(i).cargconc = 37 and substr(tbCargos(i).cargdoso, 0, 3)  NOT IN ('ID-', 'DF-') THEN
                    BEGIN
                        SELECT vitcporc INTO nuPorcSubs
                          FROM ta_vigetaco, pericose
                         WHERE vitctaco = tbCargos(i).CARGTACO
                           AND pecscons = tbCargos(i).CARGPECO
                           AND pecsfecf BETWEEN vitcfein AND vitcfefi
                           AND vitcvige = 'S'
                           AND rownum = 1;
                        IF tbCargos(i).cargdoso LIKE 'CN-PR%' THEN
                            tbCargos(i).concdefa := tbCargos(i).concdefa || '(' ||round(nuPorcSubs, 2) ||'% Cons. + ' ||
                            round(nuPorcSubs, 2) ||'% C. Fijo CN-AJ-' ||substr(tbCargos(i).cargdoso, 7, 6);
                        ELSE
                            tbCargos(i).concdefa := tbCargos(i).concdefa || '(' ||round(nuPorcSubs, 2) ||'% Cons. + ' ||round(nuPorcSubs, 2) || '% C. Fijo';
                        END IF;
                    EXCEPTION
                        WHEN OTHERS THEN
                            NULL;
                    END;
                WHEN tbCargos(i).servcodi IN (7014) AND tbCargos(i).cargdoso LIKE 'CO-PR%TC%' THEN
                    tbCargos(i).CONCDEFA := 'Ajuste de Consumo ('||tbCargos(i).cargunid||'m3 - '||initcap(trim(to_char(to_date(substr(tbCargos(i).cargdoso, 11,2),'MM'),'MONTH')))||'-'||substr(tbCargos(i).cargdoso, 7,4)||')';
                ELSE
                    NULL;
            END CASE;
            -- Evalua primero si es concepto de Iva o Recargo por mora para acumular
            CASE -- Acumulado de IVA
                WHEN instr('|' || sbconciva || '|',
                '|' || tbCargos(i).cargconc || '|') > 0 and substr(tbCargos(i).cargdoso, 0, 3)  NOT IN ('ID-', 'DF-') THEN
                    tbCargosOrdered(-2).capital := tbCargosOrdered(-2).capital + tbCargos(i).cargvalo;
                -- Acumulado Recargo por mora
                WHEN instr('|' || sbConcRecamora || '|',
                '|' || tbCargos(i).cargconc || '|') > 0 and substr(tbCargos(i).cargdoso, 0, 3)  NOT IN ('ID-', 'DF-')  THEN
                    IF nuAplicaTiPro = 0 THEN
                        IF (NOT gtbIvaConc.exists(tbCargos(i).cargconc)) THEN
                              nuValorIva := fnuGetValorIva(tbCargos(i).cargconc, tbCargos(i).cargcuco);
                             gtbIvaConc(tbCargos(i).cargconc) := tbCargos(i).cargconc;
                        END IF;
					END IF;

                    IF nuValorIva > 0 THEN
                        tbCargosOrdered(-3).interes := tbCargosOrdered(-3).interes + tbCargos(i).cargvalo;
                        IF tbCargosOrdered(-3).conceptos = 'x' THEN
                            tbCargosOrdered(-3).conceptos := 'INTERES DE MORA GRAVADO (Tasa ' || tbCargos(i).cargunid || '%)';
                            tbCargosOrdered(-3).concepto_id := tbCargos(i).cargconc;
                        END IF;
                        tbCargosOrdered(-3).unidad_items := 'und';
                        tbCargosOrdered(-3).cantidad := 1;
                        tbCargosOrdered(-3).valor_iva := tbCargosOrdered(-3).valor_iva + nuValorIva;
                        tbCargosOrdered(-3).valor_unitario := tbCargosOrdered(-3).valor_unitario + tbCargos(i).cargvalo;
                        tbCargosOrdered(-1).valor_iva := tbCargosOrdered(-1).valor_iva + nuValorIva;
                    ELSE
                        tbCargosOrdered(-4).interes := tbCargosOrdered(-4).interes + tbCargos(i).cargvalo;
                        IF tbCargosOrdered(-4).conceptos = 'x' THEN
                            tbCargosOrdered(-4).conceptos := 'INTERES DE MORA NO GRAVADO (Tasa ' || tbCargos(i).cargunid || '%)';
                            tbCargosOrdered(-4).concepto_id := 156;
                        END IF;
                        tbCargosOrdered(-4).unidad_items := 'und';
                        tbCargosOrdered(-4).cantidad := 1;
                        tbCargosOrdered(-4).valor_iva := tbCargosOrdered(-4).valor_iva + nuValorIva;
                        tbCargosOrdered(-4).valor_unitario := tbCargosOrdered(-4).valor_unitario  + tbCargos(i).cargvalo;
                        tbCargosOrdered(-1).valor_iva := tbCargosOrdered(-1).valor_iva + nuValorIva;
                    END IF;
                -- Arma el detalle para los dem?s cargos diferentes de diferidos
                WHEN substr(tbCargos(i).cargdoso, 0, 3) NOT IN ('DF-', 'ID-') AND tbCargos(i).cargsign IN ('DB', 'CR', 'PA', 'AS') THEN
                    tbCargosOrdered(inx).etiqueta := '32';
                    tbCargosOrdered(inx).conceptos := tbCargos(i).concdefa;
                    tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
                    tbCargosOrdered(inx).car_doso := tbCargos(i).cargdoso;
                    tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
                    tbCargosOrdered(inx).saldo_ant := NULL;
                    tbCargosOrdered(inx).interes := NULL;
                    tbCargosOrdered(inx).capital := tbCargos(i).cargvalo;
                    tbCargosOrdered(inx).total := NULL;
                    tbCargosOrdered(inx).saldo_dif := NULL;
                    tbCargosOrdered(inx).cuotas := NULL;
                    nuAplica := 0;

                    SELECT COUNT(1) INTO nuAplica
                    FROM (
                            SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
                            FROM dual
                            CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
                    WHERE concepto = tbCargos(i).cargconc;
                    IF nuAplica =  0 AND tbCargos(i).cargsign NOT IN ('PA', 'AS') AND nuAplicaTiPro = 0 THEN
                        IF (NOT gtbIvaConc.exists(tbCargos(i).cargconc)) THEN
                              nuValorIva := fnuGetValorIva(tbCargos(i).cargconc, tbCargos(i).cargcuco);
                              gtbIvaConc(tbCargos(i).cargconc) := tbCargos(i).cargconc;
                        END IF;

						nuCantidad :=  1;
						sbUnidMed  := 'und';
						nuValorUnitario := tbCargos(i).cargvalo;

						 -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
						IF tbUnidadMedConc.EXISTS(tbCargos(i).cargconc) then
						  sbUnidMed := lower(tbUnidadMedConc(tbCargos(i).cargconc).sbUnidadMed);
						  IF tbUnidadMedConc(tbCargos(i).cargconc).sbRequiereTarifa = 'S' THEN
						    nuValorUnitario := ROUND( CASE WHEN nvl(tbCargos(i).cargunid,0) = 0 THEN 0 ELSE tbCargos(i).cargvalo / tbCargos(i).cargunid END, 0) ;
							nuCantidad := NVL(tbCargos(i).cargunid, 1);
						  END IF;
						END IF;

                        tbCargosOrdered(inx).concepto_id := tbCargos(i).cargconc;
                        tbCargosOrdered(inx).unidad_items := sbUnidMed;
                        tbCargosOrdered(inx).cantidad := nuCantidad;
                        tbCargosOrdered(inx).valor_iva := nuValorIva;
                        tbCargosOrdered(inx).valor_unitario := nuValorUnitario;
                        tbCargosOrdered(-1).valor_iva := tbCargosOrdered(-1).valor_iva + nuValorIva;


                    END IF;
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    -- Agrupa diferido con su respectivo interes de financiaci?n
                    -- Se agrega la condicion de causa de cargo 51 que corresponde la cuota del diferido
                    -- El cual si debe de mostrar el saldo del diferido y el interes
                WHEN substr(tbCargos(i).cargdoso, 0, 3) = 'DF-' AND (tbCargos(i).cargcaca = 51) THEN
                    nuIndex := SUBSTR(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                    gtbFinancion(nuIndex) := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                    BEGIN
                        sbconcdefa := tbCargos(i).concdefa;
                        nuFinanciacion := null;
                        SELECT decode(difesign, 'DB', difesape, -1 * difesape),(difenucu - difecupa)
                        ,(
                         CASE WHEN instr(sbplancon,','||difepldi||',') > 0 THEN
                          sbDescCon||ldc_detallefact_gascaribe.fsbGetPeriodo(difenuse, difecodi)
                          WHEN instr(sbPlanOtr,','||difepldi||',') > 0 THEN
                           sbDescOtrco ||ldc_detallefact_gascaribe.fsbGetPeriodo(difenuse, difecodi)
                          WHEN (instr(','||difeprog||',' , ','||sbprograma||',') > 0 ) AND sbaplicaentrega635 = 'S'  THEN
                           sbTextagrupador||'_'||to_char(difefein, 'dd/mm/yyyy')
                         ELSE
                           nvl(fsbGetDescConcDife(tbCargos(i).servcodi, difeconc, difefein),tbCargos(i).concdefa)
                         END ) --379 Se agrupan conceptos por planes,
                        ,(
                        CASE WHEN (instr(','||difeprog||',' , ','||sbprograma||',') > 0 ) AND sbaplicaentrega635 = 'S'  THEN
                            to_char(difecofi)
                        ELSE
                            nvl(fsbGetDescConcDife(tbCargos(i).servcodi,difeconc, difefein),tbCargos(i).concdefa)
                        END
                        ) financiacion
                        INTO nuDifesape,nuDifecuotas,sbconcdefa,nuFinanciacion
                        FROM diferido
                        WHERE difecodi = substr(tbCargos(i).cargdoso,4,length(tbCargos(i).cargdoso) - 3);
                    EXCEPTION
                        WHEN OTHERS THEN
                            nuDifesape   := 0;
                            nuDifecuotas := 0;
                    END;
                    IF (tbCargos(i).servcodi = 7053 OR nuExiste > 0)
                        AND instr(upper(sbconcdefa), 'RESCREG-059') = 0
                         THEN
                        nuDifesape   := NULL;
                        nuDifecuotas := NULL;
                        nuInteres    := NULL;
                    ELSE
                        BEGIN
                            SELECT decode(cargsign, 'DB', cargvalo, -1 * cargvalo) INTO nuInteres
                            FROM cargos
                            WHERE cargdoso =
                                            'ID-' ||
                                            substr(tbCargos(i).cargdoso,
                                                   4,
                                                   length(tbCargos(i).cargdoso) - 3)
                                        AND cargcuco = tbCargos(i).cargcuco;
                        EXCEPTION
                            WHEN OTHERS THEN
                                nuInteres := 0;
                        END;
                        -- OBS. Se captura informacion del concepto ID-
                        -- Se guarda en memoria para indicar que ya fue agregado.
                        BEGIN
                            SELECT c.cargconc, c.cargdoso, c.cargvalo INTO nucargconc, sbcargdoso, nucargvalo
                            FROM cargos c
                            WHERE cargdoso =
                                           'ID-' ||
                                           substr(tbCargos(i).cargdoso,
                                                  4,
                                                  length(tbCargos(i).cargdoso) - 3)
                             AND cargcuco = tbCargos(i).cargcuco;
                             sbindice := lpad(nucargconc, 4, '0') || sbcargdoso;
                            IF sbindice IS NOT NULL THEN
                                tConcep(sbindice).cargconc := nucargconc;
                                tConcep(sbindice).cargdoso := sbcargdoso;
                                tConcep(sbindice).cargvalo := nucargvalo;
                            END IF;
                        EXCEPTION
                            WHEN OTHERS THEN
                                NULL;
                                nucargconc := NULL;
                        END;
                    END IF;
                    tbCargosOrdered(inx).etiqueta := '32';

                    tbCargosOrdered(inx).conceptos := sbconcdefa;
                    tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
                    IF nuFinanciacion IS NOT  NULL THEN
                        tbCargosOrdered(inx).car_doso := CASE WHEN instr(upper(sbconcdefa), 'RESCREG-059') = 0 THEN
                                              nuFinanciacion
                                        ELSE
                                          'RESCREG-059'||tbCargos(i).servcodi
                                        END;
                    ELSE
                        tbCargosOrdered(inx).car_doso := CASE WHEN instr(upper(sbconcdefa), 'RESCREG-059') = 0 THEN
                                                           tbCargos(i).cargdoso
                                       ELSE
                                         'RESCREG-059'||tbCargos(i).servcodi
                                       END;
                    END IF;
                    tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
                    tbCargosOrdered(inx).saldo_ant := NULL;
                    tbCargosOrdered(inx).capital := tbCargos(i).cargvalo;
                    tbCargosOrdered(inx).total := NULL;
                    tbCargosOrdered(inx).saldo_dif := nuDifesape;
                    tbCargosOrdered(inx).cuotas := nuDifecuotas;
                    nuValorIva := 0;
                    blConcGravado := false;
                    IF nuAplicaTiPro = 0 THEN
                        IF nuInteres > 0 THEN
                            IF (NOT gtbIvaConc.exists(nvl(nucargconc, tbCargos(i).cargconc))) THEN
                               nuValorIva := fnuGetValorIva(nvl(nucargconc, tbCargos(i).cargconc), tbCargos(i).cargcuco);
                               gtbIvaConc(nvl(nucargconc, tbCargos(i).cargconc)) := nvl(nucargconc, tbCargos(i).cargconc);
                            ELSE
                               blConcGravado :=  fnuGetValorIva(nvl(nucargconc, tbCargos(i).cargconc), tbCargos(i).cargcuco) > 0;
                            END IF;

                            nuCantidad :=  1;
                            sbUnidMed  := 'und';
                            nuValorUnitario := nuInteres;
                             -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
                            IF tbUnidadMedConc.EXISTS(tbCargos(i).cargconc) then
                              sbUnidMed := lower(tbUnidadMedConc(tbCargos(i).cargconc).sbUnidadMed);
                              IF tbUnidadMedConc(tbCargos(i).cargconc).sbRequiereTarifa = 'S' THEN
                                nuValorUnitario := ROUND( CASE WHEN nvl(tbCargos(i).cargunid,0) = 0 THEN 0 ELSE nuInteres / tbCargos(i).cargunid END, 0) ;
                                nuCantidad := NVL(tbCargos(i).cargunid, 1);
                              END IF;
                            END IF;

                            IF nuValorIva > 0 OR blConcGravado THEN
                               inx := inx  + 1;
                               tbCargosOrdered(inx).etiqueta := '32';
                               tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                               tbCargosOrdered(inx).conceptos := sbconcdefa;
                               tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
                               tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
                               tbCargosOrdered(inx).saldo_ant := NULL;
                               tbCargosOrdered(inx).capital := NULL;
                               tbCargosOrdered(inx).concepto_id := nvl(nucargconc, tbCargos(i).cargconc);
                               tbCargosOrdered(inx).unidad_items := sbUnidMed;
                               tbCargosOrdered(inx).cantidad := nuCantidad;
                               tbCargosOrdered(inx).valor_iva := nuValorIva;
                               tbCargosOrdered(inx).valor_unitario := nuValorUnitario;
                               tbCargosOrdered(inx).interes := nuInteres;
                               tbCargosOrdered(-1).valor_iva := tbCargosOrdered(-1).valor_iva + nuValorIva;
                               inx := inx + 1;
                               tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                            ELSE
                               tbCargosOrdered(inx).concepto_id := nvl(nucargconc, tbCargos(i).cargconc);
                               tbCargosOrdered(inx).unidad_items := sbUnidMed;
                               tbCargosOrdered(inx).cantidad := nuCantidad;
                               tbCargosOrdered(inx).valor_iva := nuValorIva;
                               tbCargosOrdered(inx).valor_unitario := nuValorUnitario;
                               tbCargosOrdered(inx).interes := nuInteres;
                            END IF;

                        END IF;
                   ELSE
                      tbCargosOrdered(inx).interes := nuInteres;
                   END IF;
                   IF nuValorIva = 0 AND NOT blConcGravado THEN
                        inx := inx + 1;
                        tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    END IF;
                 --------------------------------------------------------------------------------------------------
                -- Se agrega la condicion and (tbCargos(i).cargcaca !=51)
                -- para que se incluya los diferidos cuando no corresponden a cuota
                WHEN substr(tbCargos(i).cargdoso, 0, 3) = 'DF-' AND (tbCargos(i).cargcaca != 51) THEN
                    --Se almacena los codigo de los diferidos en la tabla
                    nuIndex := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                    gtbFinancion(nuIndex) := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                    tbCargosOrdered(inx).etiqueta := '32';
                    tbCargosOrdered(inx).concepto_id := tbCargos(i).cargconc;
                    tbCargosOrdered(inx).conceptos := tbCargos(i).concdefa;
                    tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
                    tbCargosOrdered(inx).car_doso := tbCargos(i).cargdoso;
                    tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
                    tbCargosOrdered(inx).saldo_ant := NULL;
                    tbCargosOrdered(inx).capital := tbCargos(i).cargvalo;
                    tbCargosOrdered(inx).interes := NULL;
                    tbCargosOrdered(inx).total := NULL;
                    tbCargosOrdered(inx).saldo_dif := NULL;
                    tbCargosOrdered(inx).cuotas := NULL;
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                ---------------------------------------------------------------------------------------------------
                WHEN substr(tbCargos(i).cargdoso, 0, 3) = 'ID-' THEN
                    -- Busca si el Interes tiene diferido padre
                    BEGIN
                        -- Se agrega la condicion (and cargcaca =51) dado que en una cuenta de cobro, solo puede
                        -- Haber un cargo con causa de cargo 51 - Cuota de Diferido en FGCA
                        SELECT cargdoso INTO nuDoso
                        FROM cargos
                        WHERE cargdoso = 'DF-' ||substr(tbCargos(i).cargdoso,4,length(tbCargos(i).cargdoso) - 3)
                        AND cargcuco = tbCargos(i).cargcuco
                        AND cargcaca = 51;
                    EXCEPTION
                        WHEN OTHERS THEN
                            nuDoso := NULL;
                    END;
                    nuValorIva := 0;
                    sbindice := lpad(tbCargos(i).cargconc, 4, '0') || tbCargos(i).cargdoso;
                    IF nuDoso IS NULL OR NOT tConcep.exists(sbindice) THEN
                        --Se almacena los codigo de los diferidos en la tabla
                        nuIndex := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                        gtbFinancion(nuIndex) := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                        blConcGravado := FALSE;
                           IF nuAplicaTiPro = 0 THEN
                                IF tbCargos(i).cargvalo > 0 THEN
                                    IF (NOT gtbIvaConc.exists(tbCargos(i).cargconc)) THEN
                                       nuValorIva := fnuGetValorIva(tbCargos(i).cargconc, tbCargos(i).cargcuco);
                                       gtbIvaConc(tbCargos(i).cargconc) := tbCargos(i).cargconc;
                                    ELSE
                                       blConcGravado :=  fnuGetValorIva(nvl(nucargconc, tbCargos(i).cargconc), tbCargos(i).cargcuco) > 0;
                                    END IF;

                                    nuCantidad :=  1;
                                    sbUnidMed  := 'und';
                                    nuValorUnitario := tbCargos(i).cargvalo;
                                     -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
                                    IF tbUnidadMedConc.EXISTS(tbCargos(i).cargconc) then
                                      sbUnidMed := lower(tbUnidadMedConc(tbCargos(i).cargconc).sbUnidadMed);
                                      IF tbUnidadMedConc(tbCargos(i).cargconc).sbRequiereTarifa = 'S' THEN
                                        nuValorUnitario := ROUND( CASE WHEN nvl(tbCargos(i).cargunid,0) = 0 THEN 0 ELSE tbCargos(i).cargvalo / tbCargos(i).cargunid END, 0) ;
                                        nuCantidad := NVL(tbCargos(i).cargunid, 1);
                                      END IF;
                                    END IF;

                                    IF nuValorIva > 0 OR  blConcGravado THEN
                                       inx := inx  + 1;
                                       tbCargosOrdered(inx).etiqueta := '32';
                                       tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                                       tbCargosOrdered(inx).conceptos := sbconcdefa;
                                       tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
                                       tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
                                       tbCargosOrdered(inx).saldo_ant := NULL;
                                       tbCargosOrdered(inx).capital := NULL;
                                       tbCargosOrdered(inx).concepto_id := tbCargos(i).cargconc;
                                       tbCargosOrdered(inx).unidad_items := sbUnidMed;
                                       tbCargosOrdered(inx).cantidad := nuCantidad;
                                       tbCargosOrdered(inx).valor_iva := nuValorIva;
                                       tbCargosOrdered(inx).valor_unitario := nuValorUnitario;
                                       tbCargosOrdered(inx).interes := tbCargos(i).cargvalo;
                                       tbCargosOrdered(-1).valor_iva := tbCargosOrdered(-1).valor_iva + nuValorIva;
                                       inx := inx + 1;
                                       tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                                   END IF;
                              END IF;
                           END IF;
                            IF nuValorIva = 0 AND NOT blConcGravado THEN
                                BEGIN
                                    sbconcdefa     := tbCargos(i).concdefa;
                                    nuFinanciacion := NULL;
                                    SELECT decode(difesign, 'DB', difesape, -1 * difesape)
                                    ,(difenucu - difecupa)
                                    ,(
                                        CASE
                                            WHEN instr(sbPlanCon,','||difepldi||',') > 0 THEN
                                            sbDescCon||ldc_detallefact_gascaribe.fsbGetPeriodo(difenuse, difecodi)
                                            WHEN instr(sbPlanOtr,','||difepldi||',') > 0 THEN
                                            sbDescOtrco ||ldc_detallefact_gascaribe.fsbGetPeriodo(difenuse, difecodi)
                                            WHEN (instr(','||difeprog||',' , ','||sbprograma||',') > 0 ) AND sbaplicaentrega635 = 'S' THEN
                                                 sbTextagrupador||'_'||to_char(difefein, 'dd/mm/yyyy')
                                            ELSE
                                              nvl(fsbGetDescConcDife(tbCargos(i).servcodi, difeconc, difefein),tbCargos(i).concdefa)
                                        END
                                    ) --379 Se agrupan conceptos por planes,
                                    ,(
                                    CASE WHEN (instr(','||difeprog||',' , ','||sbprograma||',') > 0 ) AND sbaplicaentrega635 = 'S' THEN
                                        to_char(difecofi)
                                    ELSE
                                        nvl(fsbGetDescConcDife(tbCargos(i).servcodi, difeconc, difefein),tbCargos(i).concdefa)
                                    END
                                    ) financiacion
                                    INTO nuDifesape,nuDifecuotas,sbconcdefa,nuFinanciacion
                                    FROM diferido
                                    WHERE difecodi = substr(tbCargos(i).cargdoso,4,length(tbCargos(i).cargdoso) - 3);
                                EXCEPTION
                                    WHEN OTHERS THEN
                                        nuDifesape   := 0;
                                        nuDifecuotas := 0;
                                END;
                                IF tbCargos(i).servcodi = 7053 AND instr(upper(sbconcdefa), 'RESCREG-059') = 0 THEN
                                    nuDifesape   := NULL;
                                    nuDifecuotas := NULL;
                                ELSE
                                    NULL;
                                END IF;
                                tbCargosOrdered(inx).etiqueta := '32';
                                tbCargosOrdered(inx).conceptos := sbconcdefa;
                                tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
                                IF nuFinanciacion IS NOT  NULL THEN
                                    tbCargosOrdered(inx).car_doso := CASE WHEN instr(upper(sbconcdefa), 'RESCREG-059') = 0 THEN
                                                  nuFinanciacion
                                                 ELSE
                                                  'RESCREG-059'||tbCargos(i).SERVCODI
                                                 END;
                                ELSE
                                    tbCargosOrdered(inx).car_doso := CASE WHEN instr(upper(sbconcdefa), 'RESCREG-059') = 0 THEN
                                                                   tbCargos(i).cargdoso
                                               ELSE
                                                'RESCREG-059'||tbCargos(i).servcodi
                                               END;
                                END IF;
                                tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
                                tbCargosOrdered(inx).saldo_ant := NULL;
                                tbCargosOrdered(inx).capital := 0;
                                tbCargosOrdered(inx).interes := tbCargos(i).cargvalo;
                                tbCargosOrdered(inx).total := NULL;
                                tbCargosOrdered(inx).saldo_dif := nuDifesape;
                                tbCargosOrdered(inx).cuotas := nuDifecuotas;
                                IF nuAplicaTiPro = 0 THEN
                                    nuCantidad :=  1;
                                    sbUnidMed  := 'und';
                                    nuValorUnitario := tbCargos(i).cargvalo;
                                     -- Valida si existe la unidad de medida del concepto en la tabla conc_unid_medida_dian
                                    IF tbUnidadMedConc.EXISTS(tbCargos(i).cargconc) then
                                      sbUnidMed := lower(tbUnidadMedConc(tbCargos(i).cargconc).sbUnidadMed);
                                      IF tbUnidadMedConc(tbCargos(i).cargconc).sbRequiereTarifa = 'S' THEN
                                        nuValorUnitario := ROUND( CASE WHEN nvl(tbCargos(i).cargunid,0) = 0 THEN 0 ELSE tbCargos(i).cargvalo / tbCargos(i).cargunid END, 0) ;
                                        nuCantidad := NVL(tbCargos(i).cargunid, 1);
                                      END IF;
                                    END IF;

                                    tbCargosOrdered(inx).concepto_id := tbCargos(i).cargconc;
                                    tbCargosOrdered(inx).unidad_items := sbUnidMed;
                                    tbCargosOrdered(inx).cantidad := nuCantidad;
                                    tbCargosOrdered(inx).valor_iva := nuValorIva;
                                    tbCargosOrdered(inx).valor_unitario := nuValorUnitario;
                                END IF;

                                inx := inx + 1;
                                tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                           END IF;
                    END IF;
                ELSE
                    NULL;
            END CASE;
            -- Acumulaci?n de totales
            IF tbCargos(i).cargsign IN ('CR', 'AS', 'PA', 'DB') THEN
                -- Acumula intereres de financiaci?n e IVA
                IF ( substr(tbCargos(i).cargdoso, 0, 3) = 'ID-') OR
                (
                    instr('|' || sbConcRecamora || '|',
                    '|' || tbCargos(i).cargconc || '|') > 0
                    AND substr(tbCargos(i).cargdoso, 0, 3)  NOT IN ('DF-')
                ) THEN
                    tbCargosOrdered(-1).interes := tbCargosOrdered(-1).interes + tbCargos(i).cargvalo;
                ELSE
                    tbCargosOrdered(-1).capital := tbCargosOrdered(-1).capital + tbCargos(i).cargvalo;
                END IF;
                tbCargosOrdered(-1).total := tbCargosOrdered(-1).total + tbCargos(i).cargvalo;
                  --379 LJLB -- se agrega condicion para que los diferidos de los alivios se muestren correctamente
                IF substr(tbCargos(i).cargdoso, 0, 3) = 'DF-' AND
                    ( (tbCargos(i).servcodi <> 7053 AND  nuExiste = 0) OR  (tbCargos(i).servcodi = 7053
                    AND instr(upper(sbconcdefa), 'RESCREG-059') <> 0)
                   )
                AND tbCargos(i).cargcaca = 51 THEN
                    nuIndex := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                    gtbFinancion(nuIndex) := substr(tbcargos(i).cargdoso,4,length(tbcargos(i).cargdoso) - 3);
                    BEGIN
                        SELECT decode(difesign, 'DB', difesape, -1 * difesape) INTO nuDifesape
                          FROM diferido
                         WHERE difecodi = substr(tbCargos(i).cargdoso,4,length(tbCargos(i).cargdoso) - 3);
                    EXCEPTION
                        WHEN OTHERS THEN
                            nuDifesape := 0;
                    END;
                    tbCargosOrdered(-1).saldo_dif := tbCargosOrdered(-1).saldo_dif + nuDifesape;
                END IF;
            END IF;
            -- Muestra el IVA, Recamora y Total si el servicio cambia
            IF tbCargos.next(i) IS NULL THEN
                pkg_traza.trace('LDC_DetalleFact_GasCaribe.RfConcepParcial Inicio Almacenar diferidos restantes', pkg_traza.cnuNivelTrzDef);
                IF (tbCargosOrdered.Count() > 0) THEN
                    pkg_traza.trace(' LDC_DetalleFact_GasCaribe.RfConcepParcial Inicio Almacenar diferidos restantes 1',10, pkg_traza.cnuNivelTrzDef);
                    k := tbCargosOrdered.first;
                    LOOP
                        EXIT WHEN k IS NULL;
                        IF (tbCargosOrdered(k).concepto_id IS NOT NULL AND k NOT IN (-1, -2, -3)) THEN
                           inxConc := To_Char(tbCargosOrdered(k).concepto_id, '0000');
                           inxConc := RTrim(LTrim(inxConc));
                           pkg_traza.trace('LDC_DetalleFact_GasCaribe.RfConcepParcial Inicio Almacenar diferidos restantes inxConc[' ||
                                               inxConc || ']idx[' || k || ']', pkg_traza.cnuNivelTrzDef);
                            gtbConceptos(inxConc) := k;
                        END IF;
                        k := tbCargosOrdered.next(k);
                    END LOOP;
                END IF;
                pkg_traza.trace(' LDC_DetalleFact_GasCaribe.RfConcepParcial Fin  Almacenar diferidos restantes gtbConceptos.COUNT[' ||
                          gtbConceptos.COUNT || ']', pkg_traza.cnuNivelTrzDef);

                IF nuLastSesu <> -1 THEN
                      OPEN cuDiferidos(nuLastSesu);
                      FETCH cuDiferidos BULK COLLECT INTO tdiferidos;
                      CLOSE cuDiferidos;
                      k := tdiferidos.FIRST;
                      LOOP
                          EXIT WHEN k IS NULL;
                          IF (NOT gtbFinancion.exists(tdiferidos(k).difecodi)) THEN
                              -- Creacion de detalles
                              inxConc := RTrim(LTrim(inx));
                               pkg_traza.trace('   tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] inx [' || inx || ']', pkg_traza.cnuNivelTrzDef);
                              nuServicio := pkg_bcproducto.fnuTipoProducto(tdiferidos(k).difenuse);

                                SELECT COUNT(1) INTO nuExiste
                                FROM (SELECT to_number(regexp_substr(sbCodiFactProt,
                                                                     '[^,]+',
                                                                     1,
                                                                     LEVEL)) AS concepto
                                        FROM dual
                                      CONNECT BY regexp_substr(sbCodiFactProt, '[^,]+', 1, LEVEL) IS NOT NULL)
                                WHERE tdiferidos(k).difeconc = concepto ;


                              IF (nuServicio = 7053 or nuExiste > 0) AND instr(upper(tdiferidos(k).concdefa), 'RESCREG-059') = 0 THEN
                                  nuDifesape := NULL;
                                  tdiferidos(k).difesape := NULL;
                                  nuDifecuotas := NULL;
                                  tdiferidos(k).difenucu := NULL;
                              ELSE
                                  nuDifesape := nuDifesape + tdiferidos(k).difesape;
                                  tbCargosOrdered(-1).saldo_dif := tbCargosOrdered(-1).saldo_dif + tDiferidos(k).difesape;
                              END IF;
                              -- 17/12/2015 Se agrega la condicion and nuServicio != 7053 para que solo se sume el saldo de diferido
                              -- Cuando el servicio es diferente 7053
                              --Valida si existe
                              IF (gtbConceptos.exists(inxConc) AND (nuServicio != 7053 or ( (nuServicio = 7053  or nuExiste > 0) AND instr(upper(tdiferidos(k).concdefa), 'RESCREG-059') <> 0)) ) THEN
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  inx := gtbConceptos(inxConc);
                                  tbcargosordered(inx).saldo_dif := tbcargosordered(inx).saldo_dif + tdiferidos(k).difesape;
                              ELSE
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).etiqueta := '32';
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).concepto_id := null;
                                  tbCargosOrdered(inx).concepto_id := null;
                                  tbCargosOrdered(inx).conceptos := tdiferidos(k).concdefa;
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).signo := NULL;
                                  IF tdiferidos(k).aplicaAgrup = 'S' THEN
                                      tbCargosOrdered(inx).car_doso := tdiferidos(k).DIFECOFI;
                                  ELSE
                                      tbCargosOrdered(inx).car_doso := NULL;
                                  END IF;
                                  tbCargosOrdered(inx).car_caca := NULL;
                                  tbCargosOrdered(inx).saldo_ant := NULL;
                                  tbCargosOrdered(inx).capital := 0;
                                  tbCargosOrdered(inx).interes := NULL;
                                  tbCargosOrdered(inx).total := NULL;
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).SALDO_DIF := tdiferidos(k).difesape;
                                  tbCargosOrdered(inx).CUOTAS := tdiferidos(k).difenucu;
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  inx := inx + 1;
                                  tbCargosOrdered(inx).servicio := tdiferidos(k).sesuserv;
                              END IF;
                          END IF;
                          k := tdiferidos.next(k);
                      END LOOP;
                   END IF;
                pkg_traza.trace('RfConcepParcial Termina  loop de difereidos',15);
                IF tbCargosOrdered(-2).capital <> 0 THEN
                    tbCargosOrdered(inx) := tbCargosOrdered(-2);
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                END IF;
                IF tbCargosOrdered(-3).interes <> 0 THEN
                    tbCargosOrdered(inx) := tbCargosOrdered(-3);
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                END IF;
                IF tbCargosOrdered(-4).interes <> 0 THEN
                    tbCargosOrdered(inx) := tbCargosOrdered(-4);
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                END IF;
                tbCargosOrdered(inx) := tbCargosOrdered(-1);
                inx := inx + 1;
                tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;

                tbCargosOrdered.delete(-2);
                tbCargosOrdered.delete(-3);
                tbCargosOrdered.delete(-4);
                tbCargosOrdered.delete(-1);
            ELSE
                j := tbCargos.next(i);
                IF tbCargos(j).cargnuse <> tbCargos(i).cargnuse THEN
                   IF nuLastSesu <> -1 THEN
                      OPEN cuDiferidos(nuLastSesu);
                      FETCH cuDiferidos BULK COLLECT INTO tdiferidos;
                      CLOSE cuDiferidos;
                      k := tdiferidos.FIRST;
                      LOOP
                          EXIT WHEN k IS NULL;
                          IF (NOT gtbFinancion.exists(tdiferidos(k).difecodi)) THEN
                              -- Creacion de detalles
                              inxConc := RTrim(LTrim(inx));
                                pkg_traza.trace('   tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] inx [' || inx || ']', pkg_traza.cnuNivelTrzDef);
                              nuServicio := pkg_bcproducto.fnuTipoProducto(tdiferidos(k).difenuse);
                              SELECT COUNT(1) INTO nuExiste
                                FROM (SELECT to_number(regexp_substr(sbCodiFactProt,
                                                                     '[^,]+',
                                                                     1,
                                                                     LEVEL)) AS concepto
                                        FROM dual
                                      CONNECT BY regexp_substr(sbCodiFactProt, '[^,]+', 1, LEVEL) IS NOT NULL)
                                WHERE tdiferidos(k).difeconc = concepto ;


                              IF (nuServicio = 7053 or nuExiste> 0 ) AND instr(upper(tdiferidos(k).concdefa), 'RESCREG-059') = 0 THEN
                                  nuDifesape := NULL;
                                  tdiferidos(k).difesape := NULL;
                                  nuDifecuotas := NULL;
                                  tdiferidos(k).difenucu := NULL;
                              ELSE
                                  nuDifesape := nuDifesape + tdiferidos(k).difesape;
                                  tbCargosOrdered(-1).saldo_dif := tbCargosOrdered(-1).saldo_dif + tDiferidos(k).difesape;
                              END IF;
                              -- 17/12/2015 Se agrega la condicion and nuServicio != 7053 para que solo se sume el saldo de diferido
                              -- Cuando el servicio es diferente 7053
                              --Valida si existe
                              IF (gtbConceptos.exists(inxConc) AND (nuServicio != 7053 or ( (nuServicio = 7053  or  nuExiste> 0 ) AND instr(upper(tdiferidos(k).concdefa), 'RESCREG-059') <> 0)) ) THEN
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  inx := gtbConceptos(inxConc);
                                  tbcargosordered(inx).saldo_dif := tbcargosordered(inx).saldo_dif + tdiferidos(k).difesape;
                              ELSE
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).etiqueta := '32';
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).concepto_id := null;
                                  tbCargosOrdered(inx).concepto_id := null;
                                  tbCargosOrdered(inx).conceptos := tdiferidos(k).concdefa;
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).signo := NULL;
                                  IF tdiferidos(k).aplicaAgrup = 'S' THEN
                                      tbCargosOrdered(inx).car_doso := tdiferidos(k).DIFECOFI;
                                  ELSE
                                      tbCargosOrdered(inx).car_doso := NULL;
                                  END IF;
                                  tbCargosOrdered(inx).car_caca := NULL;
                                  tbCargosOrdered(inx).saldo_ant := NULL;
                                  tbCargosOrdered(inx).capital := 0;
                                  tbCargosOrdered(inx).interes := NULL;
                                  tbCargosOrdered(inx).total := NULL;
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  tbCargosOrdered(inx).SALDO_DIF := tdiferidos(k).difesape;
                                  tbCargosOrdered(inx).CUOTAS := tdiferidos(k).difenucu;
                                  pkg_traza.trace('tdiferidos (k).difecodi[' || tdiferidos(k).difecodi || '] NO EXISTE ', pkg_traza.cnuNivelTrzDef);
                                  inx := inx + 1;
                                  tbCargosOrdered(inx).servicio := tdiferidos(k).sesuserv;
                              END IF;
                          END IF;
                          k := tdiferidos.next(k);
                      END LOOP;
                   END IF;
                    IF tbCargosOrdered(-2).CAPITAL <> 0 THEN
                        tbCargosOrdered(inx) := tbCargosOrdered(-2);
                        inx := inx + 1;
                        tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    END IF;
                    IF tbCargosOrdered(-3).interes <> 0 THEN
                        tbCargosOrdered(inx) := tbCargosOrdered(-3);
                        inx := inx + 1;
                        tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    END IF;
                    IF tbCargosOrdered(-4).interes <> 0 THEN
                        tbCargosOrdered(inx) := tbCargosOrdered(-4);
                        inx := inx + 1;
                        tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    END IF;
                    tbCargosOrdered(inx) := tbCargosOrdered(-1);
                    inx := inx + 1;
                    tbCargosOrdered(inx).servicio := tbCargos(i).servcodi;
                    tbCargosOrdered.delete(-2);
                    tbCargosOrdered.delete(-3);
                    tbCargosOrdered.delete(-4);
                    tbCargosOrdered.delete(-1);
                END IF;
            END IF;
            -- reasigna el servicio para los cambios
            nuLastSesu := tbCargos(i).cargnuse;
            i := tbCargos.next(i);
        END LOOP;

        tConcep.Delete; -- Se formatea tabla temporal
        DELETE FROM ldc_conc_factura_temp;
        pkg_traza.trace('   tbCargosOrdered.count[' || tbCargosOrdered.Count || '] ', pkg_traza.cnuNivelTrzDef);
        nuSaldoDife := 0;
        tblProdDife.delete;
        nuIndeBri := 1;
        FOR i IN tbCargosOrdered.first .. tbCargosOrdered.last LOOP
            tbCargosOrdered(i).ORDEN := i;
            nuSaldoDife := 0;
            --se valida si el concepto es el configurado en el parametro LDC_CODCONCSEGUPROT
            SELECT COUNT(1) INTO nuExiste
            FROM (SELECT to_number(regexp_substr(sbCodiFactProt,
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)) AS concepto
                    FROM dual
                  CONNECT BY regexp_substr(sbCodiFactProt, '[^,]+', 1, LEVEL) IS NOT NULL)
            WHERE tbCargosOrdered(i).concepto_id = concepto ;

            IF nuExiste > 0 AND instr(upper(tbCargosOrdered(i).CONCEPTOS), 'RESCREG-059') = 0 THEN
                nuSaldoDife := tbCargosOrdered(i).saldo_dif;
                tbCargosOrdered(i).saldo_dif := NULL;
                tblProdDife(nuIndeBri).nuProducto := tbCargosOrdered(i).servicio;
                tblProdDife(nuIndeBri).nuSaldoDife := nuSaldoDife;
                tblProdDife(nuIndeBri).nuCuota :=  tbCargosOrdered(i).cuotas;
                tbCargosOrdered(i).cuotas := NULL;
                nuIndeBri := nuIndeBri + 1;
            END IF;
        END LOOP;
        nuSaldoDife := 0;
        nuRegtblProdDife := tblProdDife.count;
        nuidx832 := NULL;
        FOR i IN tbCargosOrdered.first .. tbCargosOrdered.last LOOP
            FOR j IN 1..nuRegtblProdDife LOOP
                IF tblProdDife.EXISTS(j) THEN
                    IF tblProdDife(j).nuSaldoDife > 0 AND tblProdDife(j).nuCuota =  tbCargosOrdered(i).CUOTAS AND  tbCargosOrdered(i).servicio =  tblProdDife(j).nuProducto AND upper(tbCargosOrdered(i).CONCEPTOS) LIKE '%'||sbDescriConBri||'%' THEN
                        IF nuidx832 IS NULL THEN
                            nuidx832 := i;
                            tbCargosOrdered(i).SALDO_DIF := tbCargosOrdered(i).SALDO_DIF + tblProdDife(j).nuSaldoDife;
                        ELSE
                            tbCargosOrdered(nuidx832).SALDO_DIF := tbCargosOrdered(nuidx832).SALDO_DIF + tblProdDife(j).nuSaldoDife; -- CA 200-2698
                        END IF;
                        tblProdDife.delete(j);
                    END IF;
                END IF;
            END LOOP;
            -- Inicio OSF-65 JJJM
            IF sbAplicasoosf65 = 'S' THEN
                nmconta := 0;
                SELECT COUNT(1) INTO nmconta
                FROM (
                    SELECT to_number(regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('INTFINANPRODSPOOL'),
                                                 '[^,]+',
                                                 1,
                                                 LEVEL)) AS tipo_producto
                    FROM dual
                  CONNECT BY regexp_substr(PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('INTFINANPRODSPOOL'), '[^,]+', 1, LEVEL) IS NOT NULL)
                WHERE tipo_producto = tbCargosOrdered(i).servicio;
                IF tbcargosordered(i).cuotas > 0 AND tbcargosordered(i).interes > 0 AND nmconta >= 1 THEN
                    sbmensa := null;
                    nmvacoddif := NULL;
                    BEGIN
                        nmvacoddif := to_number(TRIM(substr(tbcargosordered(i).car_doso,4)));
                    EXCEPTION
                        WHEN OTHERS THEN
                            nmvacoddif := NULL;
                    END;
                    IF nmvacoddif IS NOT NULL THEN
                        nmdfinte := 0;
                        BEGIN
                            SELECT (power( 1 + difeinte/100, 1/12) - 1)*100 INTO nmdfinte
                              FROM diferido df
                             WHERE df.difecodi = nmvacoddif;
                        EXCEPTION
                            WHEN OTHERS THEN
                                nmdfinte := 0;
                                sbmensa := SQLERRM;
                        END;
                    ELSE
                        nmdfinte := 0;
                    END IF;
                    tbcargosordered(i).conceptos := tbcargosordered(i).conceptos||' '||replace(to_char(round(to_char(nmdfinte), 2), '999990.99'), ' ', '')||'%';
                END IF;
            END IF;
        -- Fin OSF-65
        END LOOP;
        FORALL i IN tbCargosOrdered.first .. tbCargosOrdered.last
            INSERT INTO ldc_conc_factura_temp
                                    (
                                     id
                                    ,concepto_id
                                    ,concepto
                                    ,conc_signo
                                    ,tipo_concepto
                                    ,orden_concepto
                                    ,valor_mes
                                    ,presente_mes
                                    ,amortizacion
                                    ,saldo_diferido
                                    ,vencido
                                    ,tasa_interes
                                    ,cuotas_pendientes
                                    ,servicio
                                    ,producto
                                    ,doc_soporte
                                    ,cau_cargo
                                    ,unidad_items
                                    ,cantidad
                                    ,valor_iva
                                    ,valor_unitario
                                    )
                              VALUES(
                                     tbcargosordered(i).etiqueta
                                    ,tbcargosordered(i).concepto_id
                                    ,tbcargosordered(i).conceptos
                                    ,tbcargosordered(i).signo
                                    ,NULL
                                    ,tbcargosordered(i).orden
                                    ,tbcargosordered(i).capital
                                    ,tbcargosordered(i).total
                                    ,tbcargosordered(i).interes
                                    ,tbcargosordered(i).saldo_dif
                                    ,tbcargosordered(i).saldo_ant
                                    ,NULL
                                    ,tbcargosordered(i).cuotas
                                    ,decode(nuaplicaentrega200342
                                    ,0
                                    ,NULL
                                    ,tbcargosordered(i).servicio)
                                    ,NULL
                                    ,tbcargosordered(i).car_doso
                                    ,tbcargosordered(i).car_caca
                                    ,tbcargosordered(i).unidad_items
                                    ,tbcargosordered(i).cantidad
                                    ,tbcargosordered(i).valor_iva
                                    , tbcargosordered(i).valor_unitario
                                    );

        -- Se agrega el llamado  a la funcion fnuCanConceptos, dado que para mostrarse los datos se agrupan,
        -- y el numero de concepto no corresponden a los datos inciales sin agrupacion
        gnuConcNumber := ldc_detallefact_gascaribe.fnucanconceptos;

		SELECT SUM(NVL(presente_mes,0)) + SUM(NVL(valor_iva,0)) INTO  gsbCargosMes
		FROM ldc_conc_factura_temp
        WHERE id = 33;

    ELSE
        gtbIvaConc.DELETE;
		-- Crear detalles para los no regulados
        i := tbCargos.first;
        LOOP
            EXIT WHEN i IS NULL;

			 nuValorIva := 0;
			nuAplicaTiPro := 0;

			SELECT COUNT(1) into nuAplicaTiPro
			FROM (
					SELECT to_number(regexp_substr(sbTipoProdExcluir,  '[^,]+',   1, LEVEL)) AS tipo_prod
					FROM dual
					CONNECT BY regexp_substr(sbTipoProdExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
			WHERE tipo_prod = tbCargos(i).servcodi;

			-- Imprime encabezado si cambia de servicio suscrito
            IF nuLastSesu = -1 THEN
                -- Crea el detalle de total
                tbCargosOrdered(-1).etiqueta := '36';
                tbCargosOrdered(-1).conceptos := 'TOTALES';
                tbCargosOrdered(-1).capital := 0;
                tbCargosOrdered(-1).interes := 0;
                tbCargosOrdered(-1).total := 0;
				tbCargosOrdered(-1).valor_iva :=  0;
                tbCargosOrdered(-1).saldo_dif := 0;
                tbCargosOrdered(inx).saldo_ant := pkbobillprintheaderrules.fnugettotalpreviousbalance;
                tbCargosOrdered(-1).saldo_dif := 0;
                tbCargosOrdered(inx).saldo_ant := pkbobillprintheaderrules.fnugettotalpreviousbalance;
            END IF;
            -- Crea los detalles
            IF tbCargos(i).cargsign IN ('CR', 'AS', 'PA') THEN
                tbCargos(i).cargvalo := -1 * tbCargos(i).cargvalo;
            ELSIF tbCargos(i).cargsign IN ('DB') THEN
                tbCargos(i).cargvalo := tbCargos(i).cargvalo;
            ELSE
                tbCargos(i).cargvalo := 0;
            END IF;

			nuAplica := 0;

			SELECT COUNT(1) INTO nuAplica
			FROM (
					SELECT to_number(regexp_substr(sbConcExcluir,  '[^,]+',   1, LEVEL)) AS concepto
					FROM dual
					CONNECT BY regexp_substr(sbConcExcluir, '[^,]+', 1, LEVEL) IS NOT NULL)
			WHERE concepto = tbCargos(i).cargconc;

			IF nuAplica =  0 AND tbCargos(i).cargsign NOT IN ('PA', 'AS') AND nuAplicaTiPro = 0
				AND tbCargos(i).cargvalo > 0 AND substr(tbCargos(i).cargdoso, 0, 3)  <> 'DF-' THEN
				IF (NOT gtbIvaConc.exists(tbCargos(i).cargconc)) THEN
					  nuValorIva := fnuGetValorIva(tbCargos(i).cargconc, tbCargos(i).cargcuco);
					  gtbIvaConc(tbCargos(i).cargconc) := tbCargos(i).cargconc;
				END IF;
				tbCargosOrdered(inx).concepto_id := tbCargos(i).cargconc;
				tbCargosOrdered(inx).unidad_items := 'und';
				tbCargosOrdered(inx).cantidad := 1;
				tbCargosOrdered(inx).valor_iva := nuValorIva;
				tbCargosOrdered(inx).valor_unitario := tbCargos(i).cargvalo;
				tbCargosOrdered(-1).valor_iva := tbCargosOrdered(-1).valor_iva + nuValorIva;

			END IF;

	        tbCargosOrdered(inx).etiqueta := '35';
            tbCargosOrdered(inx).conceptos := tbCargos(i).concdefa;
            tbCargosOrdered(inx).signo := tbCargos(i).cargsign;
            tbCargosOrdered(inx).car_doso := tbCargos(i).cargdoso;
            tbCargosOrdered(inx).car_caca := tbCargos(i).cargcaca;
            tbCargosOrdered(inx).saldo_ant := NULL;
            tbCargosOrdered(inx).capital := tbCargos(i).cargvalo;
            tbCargosOrdered(inx).interes := NULL;
            tbCargosOrdered(inx).total := NULL;

            IF  substr(tbCargos(i).cargdoso, 0, 3)  = 'DF-' THEN
                IF cuGetSaldoDif%ISOPEN THEN CLOSE cuGetSaldoDif; END IF;

                OPEN cuGetSaldoDif(substr(tbCargos(i).cargdoso,4,length(tbCargos(i).cargdoso) - 3));
                FETCH cuGetSaldoDif INTO nuDifesape,nuDifecuotas;
                CLOSE cuGetSaldoDif;

               tbCargosOrdered(inx).CUOTAS := nuDifecuotas;
               tbCargosOrdered(inx).saldo_dif := nuDifesape;
               tbCargosOrdered(-1).saldo_dif := tbCargosOrdered(-1).saldo_dif + NVL(nuDifesape,0);
            END IF;

            inx := inx + 1;

            -- Acumulaci?n de totales
            IF tbCargos(i).cargsign IN ('CR', 'AS', 'DB') THEN
                -- Agordillo Incidente.143745 se excluyen los totales de PA
                IF instr('|' || sbConcIVA || '|','|' || tbCargos(i).cargconc || '|') > 0 THEN
                    tbCargosOrdered(-1).interes := tbCargosOrdered(-1).interes + tbCargos(i).cargvalo;
                ELSE
                    tbCargosOrdered(-1).capital := tbCargosOrdered(-1).capital + tbCargos(i).cargvalo;
                    tbCargosOrdered(-1).saldo_dif := tbCargosOrdered(-1).saldo_dif + tbCargos(i).cargvalo;
                END IF;
                tbCargosOrdered(-1).total := tbCargosOrdered(-1).total + tbCargos(i).cargvalo;
            END IF;
            -- Muestra los totales si el servicio cambia
            IF tbCargos.next(i) IS NULL THEN
                gsbTotal         := tbCargosOrdered(-1).total + nvl(tbCargosOrdered(-1).valor_iva,0);
                gsbivanoregulado := tbCargosOrdered(-1).valor_iva;
                gsbsubtotalnoreg := tbCargosOrdered(-1).saldo_dif;
                gsbCargosMes     := tbCargosOrdered(-1).capital;
                tbCargosOrdered.delete(-1);
            END IF;
            -- reasigna el servicio para los cambios
            nuLastSesu := tbCargos(i).cargnuse;
            i := tbCargos.next(i);
        END LOOP;

        DELETE FROM ldc_conc_factura_temp;
        FOR i IN tbCargosOrdered.first .. tbCargosOrdered.last LOOP
            tbCargosOrdered(i).orden := i;
        END LOOP;
        FORALL i IN tbCargosOrdered.first .. tbCargosOrdered.last
            INSERT INTO ldc_conc_factura_temp
                                    (
                                     id
                                    ,concepto_id
                                    ,concepto
                                    ,conc_signo
                                    ,tipo_concepto
                                    ,orden_concepto
                                    ,valor_mes
                                    ,presente_mes
                                    ,amortizacion
                                    ,saldo_diferido
                                    ,vencido
                                    ,tasa_interes
                                    ,cuotas_pendientes
                                    ,servicio
                                    ,producto
                                    ,doc_soporte
                                    ,cau_cargo
									,unidad_items
									,cantidad
									,valor_unitario
									,valor_iva
                                    )
                              VALUES
                                    (
                                     tbcargosordered(i).etiqueta
                                    ,tbcargosordered(i).concepto_id
                                    ,tbcargosordered(i).conceptos
                                    ,tbcargosordered(i).signo
                                    ,NULL
                                    ,tbcargosordered(i).orden
                                    ,tbcargosordered(i).capital
                                    ,tbcargosordered(i).total
                                    ,tbcargosordered(i).interes
                                    ,tbcargosordered(i).saldo_dif
                                    ,tbcargosordered(i).saldo_ant
                                    ,NULL
                                    ,tbcargosordered(i).cuotas
                                    ,null
                                    ,null
                                    ,tbcargosordered(i).car_doso
                                    ,tbcargosordered(i).car_caca
									,tbcargosordered(i).unidad_items
									,tbcargosordered(i).cantidad
									,tbcargosordered(i).valor_unitario
									,tbcargosordered(i).valor_iva
                                    );
        -- Se agrega el llamado  a la funcion fnuCanConceptos, dado que para mostrarse los datos se agrupan,
        -- y el numero de concepto no corresponden a los datos inciales sin agrupacion
        gnuconcnumber := ldc_detallefact_gascaribe.fnucanconceptos;
    END IF;
    pkg_traza.trace('TOTAL:' || gsbTotal || ' IVA:' || gsbIVANoRegulado ||
                   ' SUBTOTAL:' || gsbSubtotalNoReg || ' CARGOSMES:' ||
                   gsbCargosMes || ' CANTIDAD_CONC:' || gnuConcNumber,
                   15);

    OPEN orfcursor FOR
    SELECT to_char(gsbTotal, 'FM999,999,999,990') total
        ,to_char(gsbIVANoRegulado, 'FM999,999,999,990') iva
        ,to_char(gsbSubtotalNoReg, 'FM999,999,999,990') subtotal
        ,to_char(gsbCargosMes, 'FM999,999,999,990') cargosmes
        ,gnuConcNumber cantidad_conc
    FROM dual;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
END RfConcepParcial;

----------------------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE RfDatosConceptos(
                           blNRegulado      BOOLEAN
                          ,orfcursordatconc OUT constants_per.tyrefcursor
                          ) IS
/****************************************************************************************************************************************
    Propiedad intelectual de PETI (c).

    Unidad         : RfDatosConceptos
    Descripcion    : Procedimiento para extraer los campos relacionados
                     con los datos de los conceptos.
    Autor          : Gabriel Gamarra - Horbath Technologies

    Parametros           Descripcion
    ============         ===================
  orfcursor            Retorna los datos de los conceptos.

    Fecha           Autor               Modificacion
    =========       =========           ====================
     21-05-2025      LJLB                OSF-4456: se ajusta consulta de no regulado para agregar nuevos campos solicitados de cuotas y saldo
                                    diferido
    20-11-2024      LJLB                OSF-3617: se quita de la agrupacion de cargos el campo doc_soporte, para el cursor de
                                        usuarios no regulados.
    20-08-2016      Sandra Mu?oz        Se agrupan los cargos del servicio 7055
    18/05/2014      Agordillo           Modificacion Cambio.7864
                                        * Se modifica para que cuando se consulta los no Regulados, el campo CUOTAS se obtenga
                                        del campo correspondiente en la tabla temporal
    27/05/2015      Slemus              Modificacion Aranda_Cambio.6452
                                        * Se modifica la consulta de agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                        por campos orden y concepto.
    07/04/2015      Agordillo           Modificacion Incidente.140493
                                        * Se agrega a la consulta la agrupacion (group by ID, CONCEPTO,DOC_SOPORTE,CAU_CARGO)
                                        por concepto, documento de soporte y causa de cargo, y se realiza ordenamiendo
                                        por el campo ORDEN
    12/03/2015      Agordillo           Modificacion Incidente.143745
                                        * Se agrega la condicion en la consulta de usuarios cuando no son regulados
                                        para que no incluya los signos que son PA , SA
                                        * Se cambia el llamado a la tabla LDC_CONC_FACTURA_TMP por LDC_CONC_FACTURA_TEMP
    04/02/2014      ggamarra            Se agrega formateo de numero en campo cuotas NC 4173
    11/11/2014      ggamarra            Creacion.

****************************************************************************************************************************************/
    nuAplicaEntrega200342 NUMBER;
    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfDatosConceptos';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
     nuCantidadConceptos number := 0; -- Cantidad de conceptos obtenidos en la consulta
    nuConceptosPorHoja  number := 78; -- Conceptos que se muestran por hoja en el estado de cuenta
    nuTotalConceptosAdd number;       -- Conceptos en "blanco" que se deben agregar para que la cantidad total sea multiplo de <nuConceptosPorHoja>


BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

 -- Cantidad de conceptos a retornar
     nuCantidadConceptos := ldc_detallefact_gascaribe.fnucanconceptos;

    -- Se calcula la cantidad de registros en blanco que se deben agregar al final
    nuTotalConceptosAdd := nuConceptosPorHoja*ceil(nuCantidadConceptos/nuConceptosPorHoja)-nuCantidadConceptos;

    -- Si la factura no tubiera conceptos <No debería suceder>
    IF nuCantidadConceptos = 0 then
       nuTotalConceptosAdd:=nuConceptosPorHoja;
    END if;

 IF NOT blNRegulado THEN
  nuAplicaEntrega200342 := 1;
  OPEN orfcursordatconc FOR
SELECT *
 FROM ( SELECT etiqueta
               ,nvl(concepto_id, decode(etiqueta, 31, -1,33, -2, -3 )) concepto_id
               ,desc_concep
               ,to_char(saldo_ant, 'FM999,999,999,990') saldo_ant
               ,to_char(capital, 'FM999,999,999,990') capital
               ,to_char(interes, 'FM999,999,999,990') interes
               ,to_char(total, 'FM999,999,999,990') total
               ,to_char(saldo_dif, 'FM999,999,999,990') saldo_dif
               ,unidad_items
               ,cantidad
               ,to_char(valor_unitario, 'FM999,999,999,990') valor_unitario
               ,to_char(valor_iva, 'FM999,999,999,990') valor_iva
               ,cuotas
       FROM (
             SELECT id etiqueta
                   , MAX(concepto_id) concepto_id--decode(id, 31, -1,33, -2, -3 ))) concepto_id
                   ,concepto desc_concep
                   ,SUM(vencido) saldo_ant
                   ,SUM(valor_mes) capital
                   ,SUM(amortizacion) interes
                   ,SUM(presente_mes) total
                   ,SUM(saldo_diferido) saldo_dif
                   ,ltrim(rtrim(to_char(MAX(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                   ,max(unidad_items) unidad_items
                   ,max(cantidad) cantidad
                   ,sum(valor_iva) valor_iva
                   ,SUM(valor_unitario) valor_unitario
                   ,MAX(orden_concepto) orden
               FROM ldc_conc_factura_temp lcft
              WHERE (lcft.servicio <> 7055
                 OR nuAplicaEntrega200342 = 0) AND id IS NOT NULL
                 and not exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  and concepto.conccodi = COBLCONC and CONCTICL = 4)
              GROUP BY  id, concepto, doc_soporte, cau_cargo
              union all
              SELECT id etiqueta
                       , MAX(concepto_id) concepto_id
                       ,c.concdefa desc_concep
                       ,SUM(vencido) saldo_ant
                       ,SUM(valor_mes) capital
                       ,SUM(amortizacion) interes
                       ,SUM(presente_mes) total
                       ,SUM(saldo_diferido) saldo_dif
                       ,ltrim(rtrim(to_char(max(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                       ,unidad_items
                       ,cantidad
                       ,sum(valor_iva) valor_iva
                       ,SUM(valor_unitario) valor_unitario
                       ,MAX(orden_concepto) orden
                   FROM ldc_conc_factura_temp lcft, concepto c
                  WHERE (lcft.servicio <> 7055
                     OR nuAplicaEntrega200342 = 0) AND id IS NOT NULL
                     and c.conccodi = concepto_id
                     and exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  and concepto.conccodi = COBLCONC and CONCTICL = 4)
             GROUP BY id, c.concdefa, SERVICIO, unidad_items,  cantidad
             UNION ALL
             SELECT id etiqueta
                   ,MAX(concepto_id) concepto_id--, decode(id, 31, -1,33, -2, -3 ))) concepto_id
                   ,concepto desc_concep
                   ,SUM(vencido) saldo_ant
                   ,SUM(valor_mes) capital
                   ,SUM(amortizacion) interes
                   ,SUM(presente_mes) total
                   ,SUM(saldo_diferido) saldo_dif
                   ,ltrim(rtrim(to_char(cuotas_pendientes,'FM999,999,999,990'))) cuotas
                   ,MAX(unidad_items) unidad_items
                   ,MAX(cantidad) cantidad
                   ,SUM(valor_iva) valor_iva
                   ,SUM(valor_unitario) valor_unitario
                   ,MAX(orden_concepto) orden
            FROM ldc_conc_factura_temp lcft
           WHERE lcft.servicio = 7055
             AND nuAplicaEntrega200342 = 1
             AND id IS NOT NULL
             and not exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  AND concepto.conccodi = COBLCONC AND CONCTICL = 4)
           GROUP BY id, concepto, cuotas_pendientes
           UNION ALL
           SELECT id etiqueta
               , MAX(concepto_id) concepto_id
               ,c.concdefa desc_concep
               ,SUM(vencido) saldo_ant
               ,SUM(valor_mes) capital
               ,SUM(amortizacion) interes
               ,SUM(presente_mes) total
               ,SUM(saldo_diferido) saldo_dif
               ,ltrim(rtrim(to_char(max(cuotas_pendientes),'FM999,999,999,990'))) cuotas
               ,unidad_items
               ,cantidad
               ,sum(valor_iva) valor_iva
               ,SUM(valor_unitario) valor_unitario
               ,MAX(orden_concepto) orden
          FROM ldc_conc_factura_temp lcft, concepto c
          WHERE  lcft.servicio = 7055
			 AND nuAplicaEntrega200342 = 1
			 AND id IS NOT NULL
             AND c.conccodi = concepto_id
             AND exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  AND concepto.conccodi = COBLCONC AND CONCTICL = 4)
          GROUP BY id, c.concdefa,  SERVICIO ,unidad_items,  cantidad
         UNION ALL
        SELECT  33 etiqueta
               ,-2 concepto_id
               ,'TOTAL SERVICIOS:' desc_concep
               ,NULL saldo_ant
               ,SUM(valor_mes) capital
               ,SUM(amortizacion) interes
               ,SUM(presente_mes) total
               ,SUM(saldo_diferido) saldo_dif
               ,'' cuotas
               ,'' unidad_items
               ,NULL cantidad
               ,SUM(valor_iva) valor_iva
               ,NULL valor_unitario
               ,100 orden
        FROM ldc_conc_factura_temp
        WHERE ID = 33
        ORDER BY orden
        )
     WHERE ( NVL(saldo_ant,0) + NVL(capital,0) + NVL(interes,0) + NVL(total,0) + NVL(saldo_dif,0) ) <> 0
                 OR nvl(etiqueta,'33') <> '32')
   union all
    select  null etiqueta, null concepto_id,
            null desc_concep,null saldo_ant,
            null capital, null interes, NULL total, NULL saldo_dif
           ,null unidad_items
           ,null cantidad
           ,null valor_unitario
            ,null valor_iva
            ,NULL cuotas
    from servsusc
    where rownum<=nuTotalConceptosAdd;


 ELSE
  OPEN orfcursordatconc FOR
  SELECT *
  FROM ( SELECT etiqueta
                ,concepto_id
                ,desc_concep
                ,saldo_ant
                ,capital
                ,interes
                ,total
                ,saldo_dif
                ,unidad_items
                ,cantidad
                ,to_char(valor_unitario, 'FM999,999,999,990') valor_unitario
                ,to_char(valor_iva, 'FM999,999,999,990') valor_iva
                ,cuotas
         FROM (
               SELECT id etiqueta
                     ,MAX(nvl(concepto_id, decode(id, 31, -1,33, -2, -3 )))  concepto_id
                     ,concepto desc_concep
                     ,NULL saldo_ant
                     ,to_char(SUM(valor_mes), 'FM999,999,999,990') capital
                     ,to_char(SUM(amortizacion), 'FM999,999,999,990') interes
                     ,to_char(SUM(presente_mes), 'FM999,999,999,990') total
                     ,to_char(SUM(saldo_diferido), 'FM999,999,999,990') saldo_dif
                     ,ltrim(rtrim(to_char(MAX(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                     ,unidad_items
                     ,cantidad
                     ,sum(valor_iva) valor_iva
                     ,SUM(valor_unitario) valor_unitario
                     ,MAX(orden_concepto) orden
                 FROM ldc_conc_factura_temp
                WHERE conc_signo NOT IN ('SA', 'PA')
                 and not exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  and concepto.conccodi = COBLCONC and CONCTICL = 4)
                GROUP BY id, concepto,  cau_cargo, cuotas_pendientes, unidad_items, cantidad
                union all
                SELECT id etiqueta
                     ,MAX(nvl(concepto_id, decode(id, 31, -1,33, -2, -3 )))  concepto_id
                     ,concepto desc_concep
                     ,NULL saldo_ant
                     ,to_char(SUM(valor_mes), 'FM999,999,999,990') capital
                     ,to_char(SUM(amortizacion), 'FM999,999,999,990') interes
                     ,to_char(SUM(presente_mes), 'FM999,999,999,990') total
                     ,to_char(SUM(saldo_diferido), 'FM999,999,999,990') saldo_dif
                     ,ltrim(rtrim(to_char(MAX(cuotas_pendientes),'FM999,999,999,990'))) cuotas
                     ,unidad_items
                     ,cantidad
                     ,sum(valor_iva) valor_iva
                     ,SUM(valor_unitario) valor_unitario
                     ,MAX(orden_concepto) orden
                 FROM ldc_conc_factura_temp
                WHERE conc_signo NOT IN ('SA', 'PA')
                 and  exists (select 1 from concbali, concepto where concbali.COBLCOBA =  concepto_id  and concepto.conccodi = COBLCONC and CONCTICL = 4)
                GROUP BY id, concepto,  cau_cargo,  unidad_items, cantidad
                ORDER BY orden
           ))
     union all
    select  null etiqueta, null desc_concep,null saldo_ant,
            null capital, null interes, NULL total, NULL saldo_dif, NULL cuotas,
            null concepto_id
           ,null unidad_items
           ,null cantidad
           ,null valor_iva
           ,null valor_unitario
    from servsusc
    where rownum<=nuTotalConceptosAdd;
 END IF;
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
END rfdatosconceptos;
--------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosimpresiondig
(
    nmsusccodi      suscripc.susccodi%TYPE,
    orfcursorimpdig OUT constants_per.tyrefcursor
)
IS
/******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfdatosimpresiondig
  Descripcion    : Procedimiento que valida si se imprime factuta fisica a usuario o no.
  Ticket         : OSF-65
  Fecha          : 31/05/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
  13/12/2023      felipe.valencia     OSF-1939: se modifica para agregar la función ldc_utilidades_fact.fsb_valida_imprime_factura
******************************************************************************************/

    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'rfdatosimpresiondig';--nombre del método
    sbError             VARCHAR2(4000);
    nuError             NUMBER;
    sbRespuesta         VARCHAR2(2) := 'S';

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi,pkg_traza.csbINICIO);

    sbRespuesta := ldc_utilidades_fact.fsb_valida_imprime_factura(nmsusccodi);

    pkg_traza.trace('sbRespuesta: ['||sbRespuesta||']', pkg_traza.cnuNivelTrzApi);
    -- Enviamos respuesta
    OPEN orfcursorimpdig FOR
    SELECT sbRespuesta AS imprimefact FROM dual;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN);
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
END rfdatosimpresiondig;
--------------------------------------------------------------------------------------------------------------

PROCEDURE rfLastPayment(
                        sbFactsusc ge_boInstanceControl.stysbValue
                       ,orfcursor OUT constants_per.tyrefcursor
                       ) AS
/*********************************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfLastPayment
  Descripcion    : Procedimiento que retorna el ultimo pago del usuario y la fecha de este ultimo pago.
  Ticket         : OSF-393
  Fecha          : 24/06/2022

  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
*********************************************************************************************************/
dtFechPago  DATE;
nuPayment   NUMBER;

    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'rfLastPayment';
    sbError             VARCHAR2(4000);
    nuError             NUMBER;

BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 BEGIN
  SELECT pagovapa, pagofepa INTO nuPayment, dtFechPago
    FROM(
         SELECT pagovapa, pagofepa
           FROM pagos
          WHERE pagosusc = sbFactsusc
          ORDER BY pagofepa DESC
         )
   WHERE ROWNUM = 1;
 EXCEPTION
  WHEN OTHERS THEN
  dtFechPago := null ;
  nuPayment  := 0 ;
 END;
 OPEN orfcursor for
 SELECT  to_char(nuPayment,'FM999,999,999,990') valor_ult_pago,to_char(dtFechPago,'DD/MM/YYYY') fecha_ult_pago
   FROM dual ;

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
END rfLastPayment;
--------------------------------------------------------------------------------------------------------------------------------------
  FUNCTION fsbGetDescConcDife (inuservicio IN NUMBER, inudifeconc IN NUMBER, idtfechaini IN DATE ) RETURN VARCHAR2 IS
  /**************************************************************
    Propiedad intelectual de Gdc (c).

    Unidad         : fsbGetDescConcDife
    Descripcion    :  retorna valor del concepto de diferido por grupo
    Autor          : Luis Javier Lopez Barrios / Horbath
    Fecha          : 09/10/2022
    Ticket         : OSF-520


    Parametros              Descripcion
    ============         ===================
     inudifeconc         codigo del concepto del diferido
     idtfechaini         fecha de inicio
     inuservicio         codigo del tipo de producto
     Salida

    Fecha             Autor             Modificacion
    =========       =========           ====================
  ******************************************************************/

    nuconcepto  diferido.difeconc%TYPE := inudifeconc;
    dtFechaini  diferido.difefein%TYPE := idtfechaini;
    sbdescConcepto   VArCHAR2(4000);
    sbListConcepNoagr  VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_LISTCONCNAGRUP');
    sbTipoProd  VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_TIPOPRODNAGRP');

    csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'fsbGetDescConcDife';
    sbError             VARCHAR2(4000);
    nuError             NUMBER;


    CURSOR cuGetInfoConcGrupo IS

    SELECT nvl(g.grupdesc,'Financiacion')||to_char(dtFechaini, '_dd/mm/yyyy') fina
    FROM concepto
      LEFT JOIN  ldc_concgrvf c ON c.cogrcodi= conccodi
      LEFT JOIN  ldc_grupvifa g ON g.grupcodi = c.grupcodi
    WHERE conccodi = nuconcepto
     AND concticl NOT IN (4,5)
    UNION ALL
    SELECT  nvl(g.grupdesc,'Financiacion')||to_char(dtFechaini, '_dd/mm/yyyy') fina
    FROM concepto
     LEFT JOIN  ldc_concgrvf c ON c.cogrcodi= conccodi
     LEFT JOIN  ldc_grupvifa g ON g.grupcodi = c.grupcodi
    WHERE conccodi = nuconcepto
     AND concticl IN (4,5);

     nuExiste NUMBER;

  BEGIN
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     SELECT COUNT(1) INTO nuExiste
      FROM (SELECT to_number(regexp_substr(sbTipoProd,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS tipoprod
              FROM dual
            CONNECT BY regexp_substr(sbTipoProd, '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE tipoprod = inuservicio;

    IF nuExiste > 0 THEN
       RETURN sbdescConcepto;
    END IF;

    SELECT COUNT(1) INTO nuExiste
    FROM (SELECT to_number(regexp_substr(sbListConcepNoagr,
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS concepto
              FROM dual
            CONNECT BY regexp_substr(sbListConcepNoagr, '[^,]+', 1, LEVEL) IS NOT NULL)
     WHERE concepto = nuconcepto;

    IF nuExiste > 0 THEN
      RETURN sbdescConcepto;
    END IF;

    IF cuGetInfoConcGrupo%ISOPEN THEN
       CLOSE cuGetInfoConcGrupo;
    END IF;

    OPEN cuGetInfoConcGrupo;
    FETCH cuGetInfoConcGrupo INTO sbdescConcepto;
    CLOSE cuGetInfoConcGrupo;

    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    return sbdescConcepto;
  EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
       return sbdescConcepto;
    WHEN OTHERS THEN
      pkg_Error.setError;
       return sbdescConcepto;
  END fsbGetDescConcDife;

  PROCEDURE rfGetSaldoAnterior(orfcursorsaldoante OUT constants_per.tyrefcursor) IS
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfGetSaldoAnterior
  Descripcion    : Procedimiento que retorna saldo anterior
  Ticket         : OSF-1056
  Fecha          : 26/04/2023
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
 ------------------------------------------------------------------------------------------------------------------------
      csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'rfGetSaldoAnterior';--nombre del método
      sbError             VARCHAR2(4000);
      nuError             NUMBER;
   BEGIN
     pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi,pkg_traza.csbINICIO);
     OPEN orfcursorsaldoante FOR
     SELECT to_char(SUM(nvl(vencido,0)), 'FM999,999,999,990')  saldo_ante
      FROM ldc_conc_factura_temp;
     pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzApi, pkg_traza.csbFIN);
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
 END rfGetSaldoAnterior;

 FUNCTION fnuGetCaliConsumo(nuFactcodi        IN  NUMBER) RETURN VARCHAR2 IS
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : fnuGetCaliConsumo
  Descripcion    : funcion que devuelve calificacion del consumo
  Ticket         : OSF-2494
  Fecha          : 12/04/2024
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================
    nuFactcodi         codigo de la factura

  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
    csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'fnuGetCaliConsumo';--nombre del método
    nuError NUMBER;
    sbError VARCHAR2(4000);

    nuContrato  NUMBER;
    nuPeriodo    NUMBER;
    v_styInfoProdDesvpobl   pkg_info_producto_desvpobl.styInfoProdDesvpobl;
    sbCalificacion   VARCHAR2(50);
    nuCausal NUMBER;

    CURSOR cuGetperiodo IS
    SELECT factsusc, factpefa
    FROM factura
    WHERE factcodi = nuFactcodi;
 BEGIN
   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
   IF cuGetperiodo%ISOPEN THEN CLOSE cuGetperiodo; END IF;

     OPEN cuGetperiodo;
     FETCH cuGetperiodo INTO nuContrato, nuPeriodo;
     CLOSE cuGetperiodo;
     pkg_traza.trace(' nuPeriodo => ' || nuPeriodo, pkg_traza.cnuNivelTrzDef);
     pkg_traza.trace(' nuContrato => ' || nuContrato, pkg_traza.cnuNivelTrzDef);
     v_styInfoProdDesvpobl := pkg_info_producto_desvpobl.frcGetInfoProdDesvpobl( nuContrato,
                                                                                 nuPeriodo );

     nuCausal := pkg_bcGestionConsumoDp.fnuDevuelveCausalOTCritica ( v_styInfoProdDesvpobl.PRODUCTO , v_styInfoProdDesvpobl.PERIODO_CONSUMO);
     IF nuCausal IS NULL THEN
          sbCalificacion := TO_CHAR(v_styInfoProdDesvpobl.calificacion);
     ELSE
         sbCalificacion := nuCausal;
     END IF;
     pkg_traza.trace(' sbCalificacion => ' || sbCalificacion, pkg_traza.cnuNivelTrzDef);

    RETURN sbCalificacion;
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
 END fnuGetCaliConsumo;

 PROCEDURE prcGetInfoAdicional( nuFactcodi        IN  NUMBER,
                                orfcursorinfoadic OUT CONSTANTS_PER.TYREFCURSOR) IS
 /******************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : rfGetInfoAdicional
  Descripcion    : Procedimiento que retorna informacion adicional en el spool
  Ticket         : OSF-2494
  Fecha          : 12/04/2024
  Autor          : Luis Javier Lopez Barrios

  Parametros           Descripcion
  ============         ===================


  Fecha             Autor             Modificacion
  =========       =========           ====================
 ******************************************************************************************/
   csbMT_NAME  CONSTANT VARCHAR2(100) := csbNOMPKG||'prcGetInfoAdicional';--nombre del método
    nuError NUMBER;
    sbError VARCHAR2(4000);
    sbCalificacion   VARCHAR2(50);
 BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

     sbCalificacion := fnuGetCaliConsumo(nuFactcodi);

     IF sbCalificacion IS NOT NULL THEN
         OPEN orfcursorinfoadic FOR
         SELECT sbCalificacion AS calificacion
         FROM DUAL;
     ELSE
       OPEN orfcursorinfoadic FOR
         SELECT '    ' AS calificacion
         FROM servsusc
         WHERE rownum < 2;
     END IF;

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
 END prcGetInfoAdicional;

END ldc_pkgprocefactspoolfac;
/