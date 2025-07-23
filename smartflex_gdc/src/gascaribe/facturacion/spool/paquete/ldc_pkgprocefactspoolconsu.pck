create or replace PACKAGE      ldc_pkgprocefactspoolconsu IS
/*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolconsu
  Descripcion    : Paquete para acoplar los procesos de consumo
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 11/07/2022

*******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------
cnuCategoriaInd CONSTANT servsusc.sesucate%TYPE := dald_parameter.fnuGetNumeric_Value('CODIGO_CATE_INDUSTRIAL',0);

PROCEDURE rfdatosconsumohist
/**************************************************************************
 Propiedad Intelectual de PETI

 Funcion     :   RfDatosConsumoHist
 Descripcion :   Obtiene datos de los consumos
 Autor       :   Gabriel Gamarra - Horbath Technologies

 Historia de Modificaciones
   Fecha               Autor                Modificacion
 =========           =========          ====================
 11-11-2014          ggamarra            Creacion
**************************************************************************/
(
 sbfactsusc  ge_boinstancecontrol.stysbvalue
,sbfactpefa  ge_boinstancecontrol.stysbvalue
,sbfactcodi  ge_boinstancecontrol.stysbvalue
,blnregulado BOOLEAN
,orfcursor   OUT constants_per.tyRefCursor
);
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosAdicionales
/*************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosAdicionales
  Descripcion    : Procedimiento para extraer datos adicionales para mostrar en el SPOOL.
  Autor          : Jorge Valiente

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
************************************************************************************************/
(
 sbFactcodi  ge_boInstanceControl.stysbValue
,sbFactsusc  ge_boInstanceControl.stysbValue
,sbPeriodo   ge_boInstanceControl.stysbValue
,blNRegulado BOOLEAN
,orfcursor OUT constants_per.tyRefCursor
);
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosMedMalubi
/*************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosMedMalubi
  Descripcion    : Procedimiento para extraer si el usuario tiene solicitud VSI
                   dentro del periodo de facturaci?n
  Autor          : John Jairo Jimenez Marimon

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
************************************************************************************************/
(
 sbfactpefa ge_boinstancecontrol.stysbvalue
,nuproduct  servsusc.sesunuse%TYPE
,orfcursor OUT constants_per.tyRefCursor
);
-----------------------------------------------------------------------------------------------------------------------

END ldc_pkgprocefactspoolconsu;
/
create or replace PACKAGE BODY      ldc_pkgprocefactspoolconsu IS
/*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolconsu
  Descripcion    : Paquete para acoplar los procesos de consumo
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 18/MAR/2022

*******************************************************************************************************/
   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  nuError number;
  sbError VARCHAR2(4000);
-----------------------------------------------------------------------------------------------------------------------
PROCEDURE rfdatosconsumohist(
                             sbfactsusc  ge_boinstancecontrol.stysbvalue
                            ,sbfactpefa  ge_boinstancecontrol.stysbvalue
                            ,sbfactcodi  ge_boinstancecontrol.stysbvalue
                            ,blnregulado BOOLEAN
                            ,orfcursor   OUT constants_per.tyRefCursor
                            ) AS
 /*********************************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosConsumoHist
  Descripcion    : Procedimiento para extraer los datos relacionados
                   a los consumos historicos
  Autor          : Gabriel Gamarra - Horbath Technologies

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos consumos historicos.

  Fecha             Autor            Modificacion
  =========       =========          ====================
  20-05-2025      LJLB               OSF-4456: se agrega funcion para consultar consumo de productos no regulados
  17/04/2019      elal               ca 200-2032 se cambia tipo de variable a presion y temperatura
  13/03/2017      KCienfuegos.CA1081 Se modifican los cursores cucm_vavafacoP y cucm_vavafacoPL
                                     para obtener el valor de la columna vvfcvalo en lugar de la
                                     columna vvfcvapr, de acuerdo a lo cotizado por NLCZ.
  07/10/2015      Mmejia.ARA.8800    Se modifica la funcion modificar el calculo de la conversion
                                     de M3 a Kwh.
  07/09/2015      Spacheco ara8640   Se trabaja con open fetch para identificar la configuracion mas
                                     cercana al dia actual para la temperatura y la presion.
  05/08/2015      Mmejia.ARA.8199    Se modifica la funcion para que el variable sbFactor_correccion sea de tipo
                                     varchar2 no number la varible es sbFactor_correccion
  17/07/2015      Spacheco-ara8209   se modifica para que al identificar un ciclo telemedio el mensaje de calculo de
                                     consumo colocara rtu.
  13-05-2015      Slemus-ARA7263     Se modifica el origen de datos de temperatura y presi?n.
  01-03-2015      Llozada            Se envia el consumo sin multiplicarlo por el factor de correcci?n ya que en
                                     la tabla de consumos est? f?rmula ya est? aplicada.
  11/11/2014      ggamarra           Creacion.
  02/06/2022   John Jairo Jimenez    OSF-65 Se modifica para a?adirle a la variabe : equival_kwh
                                            el valor en pesos por Kilovatio/hora,la formula aplicada
                                            es : round(consumo_act/(par_pod_calor * consumo_act),2).

*********************************************************************************************************************/
csbMT_NAME 		VARCHAR2(150) := csbSP_NAME || '.rfdatosconsumohist';
nuperidocons        pericose.pecscons%TYPE;
cons_correg         NUMBER;
sbFactor_correccion VARCHAR2(200);
consumo_mes_1       NUMBER;
fecha_cons_mes_1    VARCHAR2(10);
consumo_mes_2       NUMBER;
fecha_cons_mes_2    VARCHAR2(10);
consumo_mes_3       NUMBER;
fecha_cons_mes_3    VARCHAR2(10);
consumo_mes_4       NUMBER;
fecha_cons_mes_4    VARCHAR2(10);
consumo_mes_5       NUMBER;
fecha_cons_mes_5    VARCHAR2(10);
consumo_mes_6       NUMBER;
fecha_cons_mes_6    VARCHAR2(10);
consumo_promedio    NUMBER;
temperatura         VARCHAR2(100);
presionvar          VARCHAR2(100);
sbconsumo_promedio  VARCHAR2(100);
presion             NUMBER;
calculo_cons        VARCHAR2(50);
equival_kwh         VARCHAR2(500);
nuCategoria         servsusc.sesucate%TYPE;
sbAplicasoosf65     VARCHAR2(1);
nmvalconsumo        cargos.cargvalo%TYPE;
par_pod_calor       NUMBER := pkg_bcld_parameter.fnuobtienevalornumerico('FIDF_POD_CALORIFICO');
nucicloc            NUMBER;
nuproduct           NUMBER;
nugeoloc            ge_geogra_location.geograp_location_id%TYPE;
vnucite             NUMBER;
sbCicloespe         VARCHAR2(100) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CICLVALI');
vnuCicloEsp         NUMBER;
 sbConceptoConsuNoRegu  VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('CONCEPTO_PARA_CALCCONS_USUNOREGULADO');
 sbCiclosTelemedidos  VARCHAR2(4000) := pkg_parametros.fsbGetValorCadena('CICLO_TELEMEDIDOS_GDC');

--Declaracion de cursores
CURSOR cucm_vavafacoP(nuproduct1 IN servsusc.sesunuse%TYPE) IS
 SELECT to_char(decode(nucategoria, cnucategoriaind, vvfcvalo, vvfcvapr)) presion
   FROM open.cm_vavafaco
  WHERE vvfcsesu = nuproduct1
    AND vvfcfefv >= trunc(SYSDATE)
    AND vvfcvafc = 'PRESION_OPERACION'
  ORDER BY vvfcfefv ASC;

CURSOR cucm_vavafacoPL(nugeoloc1 IN NUMBER) IS
 SELECT to_char(decode(nucategoria, cnucategoriaind, vvfcvalo, vvfcvapr)) presion
   FROM open.cm_vavafaco
  WHERE vvfcfefv >= trunc(SYSDATE)
    AND vvfcvafc = 'PRESION_OPERACION'
    AND vvfcubge = nugeoloc1
  ORDER BY vvfcfefv ASC;

CURSOR cucm_vavafacoPt(nuproduct1 IN servsusc.sesunuse%TYPE) IS
 SELECT TO_CHAR(vvfcvapr)
   FROM open.cm_vavafaco
  WHERE vvfcsesu = nuproduct1
    AND vvfcfefv >= trunc(SYSDATE)
    AND vvfcvafc = 'TEMPERATURA'
  ORDER BY vvfcfefv ASC;

CURSOR cucm_vavafacotL(nugeoloc1 IN NUMBER) IS
 SELECT TO_CHAR(vvfcvapr)
   FROM open.cm_vavafaco
  WHERE vvfcfefv >= trunc(SYSDATE)
    AND vvfcvafc = 'TEMPERATURA'
    AND vvfcubge = nugeoloc1
  ORDER BY vvfcfefv ASC;
  
  
  CURSOR cuObtConsumoNoReg IS
  SELECT SUM(NVL(a.cargunid, 0)) consumo
  FROM cargos a, cuencobr 
  WHERE cucofact = sbfactcodi
     AND a.cargcuco = cucocodi
     AND (cargdoso NOT LIKE 'DF-%' OR cargdoso NOT LIKE 'ID-%' )
     AND cargconc IN ( SELECT to_number(regexp_substr(sbConceptoConsuNoRegu,'[^,]+', 1,LEVEL)) AS tipoprod
                       FROM dual
                       CONNECT BY regexp_substr(sbConceptoConsuNoRegu, '[^,]+', 1, LEVEL) IS NOT NULL)
     AND ((SELECT nvl(SUM(decode(c.cargsign, 'CR', -c.cargvalo, c.cargvalo)),0)
             FROM cargos c
            WHERE c.cargcuco = a.cargcuco
              AND c.cargconc = a.cargconc
              AND c.cargsign IN ('DB', 'CR')
              AND c.cargdoso = a.cargdoso) <> 0
        OR a.cargsign NOT IN ('DB', 'CR'));


-- Obtiene los historicos de consumo
PROCEDURE gethistoricos(
                        nucontrato IN NUMBER
                       ,nuproducto IN NUMBER
                       ,nuciclo    IN NUMBER
                       ,nuperiodo  IN NUMBER
                       ) AS
 
  csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.gethistoricos';
 TYPE tytbperiodos IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
 tbperconsumo    tytbperiodos;
 tbperfactura    tytbperiodos;
 tbperiodos      tytbperiodos;
 frperiodos      constants_per.tyrefcursor;
 nuperfactactual perifact.pefacodi%TYPE;
 nuperfactprev   perifact.pefacodi%TYPE;
 nuperconsprev   pericose.pecscons%TYPE;
 sbperiodos      VARCHAR2(100) := '';
 nuciclof        NUMBER;

 CURSOR cuconsumo(nuproducto NUMBER, tbperi tytbperiodos) IS
  SELECT SUM(c_1) consumo_1
        ,SUM(c_2) consumo_2
        ,SUM(c_3) consumo_3
        ,SUM(c_4) consumo_4
        ,SUM(c_5) consumo_5
        ,SUM(c_6) consumo_6
    FROM (SELECT CASE
           WHEN pecscons = tbperi(1) THEN
            SUM(cosssuma)
           END c_1
          ,CASE
            WHEN pecscons = tbperi(2) THEN
             SUM(cosssuma)
           END c_2
          ,CASE
            WHEN pecscons = tbperi(3) THEN
             SUM(cosssuma)
           END c_3
          ,CASE
            WHEN pecscons = tbperi(4) THEN
             SUM(cosssuma)
           END c_4
          ,CASE
            WHEN pecscons = tbperi(5) THEN
             SUM(cosssuma)
           END c_5
          ,CASE
            WHEN pecscons = tbperi(6) THEN
             SUM(cosssuma)
           END c_6
    FROM open.vw_cmprodconsumptions -- pericose
   WHERE cosssesu = nuproducto
     AND pecscons IN (
                      tbperi(1)
                     ,tbperi(2)
                     ,tbperi(3)
                     ,tbperi(4)
                     ,tbperi(5)
                     ,tbperi(6)
                     )
   GROUP BY pecscons);
BEGIN
 pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 nuciclof := nuciclo;
 -- Periodo de facturacion Actual
 nuperfactactual := nuperiodo; 
 -- Obtiene los periodos facturados
 frperiodos := ldc_detallefact_gascaribe.frfcambiociclo(nucontrato);
 FETCH frperiodos BULK COLLECT INTO tbperiodos;
 
 pkg_traza.trace('Inicio Obtiene los ultimos 6 periodos facturados', pkg_traza.cnuNivelTrzDef);
 -- Obtiene los ultimos 6 periodos facturados
 FOR i IN 1 .. 6 LOOP
  -- Periodo de Facturacion Anterior
  BEGIN
   nuperfactprev := pkbillingperiodmgr.fnugetperiodprevious(nuperfactactual);
  EXCEPTION
   WHEN ex.controlled_error THEN
       nuperfactprev := -1;
   WHEN OTHERS THEN
       nuperfactprev := -1;
  END;
  -- Se valida si el periodo obtenido es igual al facturado si no es igual, es por
  -- que el cliente cambio de ciclo
  IF (tbperiodos.exists(i + 1)) AND (tbperiodos(i + 1) != nuperfactprev) THEN
      nuperfactprev := tbperiodos(i + 1);
      nuciclof      := pktblperifact.fnugetcycle(nuperfactprev);
  END IF;
  -- Periodo de consumo Anterior
  BEGIN
   nuperconsprev := ldc_boformatofactura.fnuobtperconsumo(
                                                          nuciclof
                                                         ,nuperfactprev
                                                         );
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
		nuperconsprev := -1;
   WHEN OTHERS THEN
		nuperconsprev := -1;
  END;
  tbperconsumo(i) := nuperconsprev;
  tbperfactura(i) := nuperfactprev;
  IF (sbperiodos IS NOT NULL) THEN
       sbperiodos := nuperconsprev || ',' || sbperiodos;
  ELSE
       sbperiodos := nuperconsprev;
  END IF;
  -- El Anterior queda actual para hayar los anteriores
  nuperfactactual := nuperfactprev;
 END LOOP;
 pkg_traza.trace('Fin Obtiene los ultimos 6 periodos facturados', pkg_traza.cnuNivelTrzDef);
 pkg_traza.trace('Inicio recorre el cursor cuconsumo', pkg_traza.cnuNivelTrzDef);
 FOR i IN cuconsumo(nuproducto, tbperconsumo) LOOP
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_1',15);
  consumo_mes_1 := nvl(i.consumo_1, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_2',15);
  consumo_mes_2 := nvl(i.consumo_2, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_3',15);
  consumo_mes_3 := nvl(i.consumo_3, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_4',15);
  consumo_mes_4 := nvl(i.consumo_4, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_5',15);
  consumo_mes_5 := nvl(i.consumo_5, 0);
  ut_trace.trace('Inicio LDC_DETALLEFACT_GASCARIBE.getHistoricos For recorre el cursor cuconsumo i.consumo_6',15);
  consumo_mes_6 := nvl(i.consumo_6, 0);
 END LOOP;
 pkg_traza.trace('Fin recorre el cursor cuconsumo', pkg_traza.cnuNivelTrzDef);
 -- Hayando meses
 fecha_cons_mes_1 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy(tbperfactura(1));
 fecha_cons_mes_2 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy(tbperfactura(2));
 fecha_cons_mes_3 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy(tbperfactura(3));
 fecha_cons_mes_4 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy(tbperfactura(4));
 fecha_cons_mes_5 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy(tbperfactura(5));
 fecha_cons_mes_6 := ldc_detallefact_gascaribe.fsbgetfechapermmyyyy(tbperfactura(6));
 pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
END gethistoricos;
BEGIN
  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 nuproduct   := ldc_detallefact_gascaribe.fnugetproducto(sbfactcodi);
 nuCategoria := pkg_bcproducto.fnucategoria(nuproduct);
 IF NOT blnregulado THEN
      BEGIN
       nucicloc := nvl(pktblservsusc.fnugetbillingcycle(nuproduct), -1);
       -- Se obtiene el periodo de consumo actual, dado el periodo de facturacion
       nuperidocons := ldc_boformatofactura.fnuobtperconsumo(nucicloc,sbfactpefa);
      EXCEPTION
       WHEN OTHERS THEN
        nucicloc     := -1;
        nuperidocons := -1;
      END;
      gethistoricos(sbfactsusc, nuproduct, nucicloc, sbfactpefa);
      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist Obtener el origen del consumo',15);
      -- Obtener el origen del consumo
      BEGIN
       SELECT decode(cossmecc, 1, 'LEC.MEDIDOR', 'ESTIMADO') INTO calculo_cons
         FROM vw_cmprodconsumptions
        WHERE cosssesu = nuproduct
          AND cosspefa = sbfactpefa
          AND cosspecs = nuperidocons;
      EXCEPTION
       WHEN OTHERS THEN
        calculo_cons := NULL;
      END;
      ut_trace.trace('LDC_DETALLEFACT_GASCARIBE.rfdatosconsumohist VAlidacion ciclo asociado',15);
      --Spacheco ara:8209 --se valida si el ciclo asociado al usuario esta configurado en el parametro
      --de ciclo de telemedido
      IF calculo_cons IS NOT NULL THEN
      
	   SELECT COUNT(*) INTO vnucite
	   FROM (
		   SELECT to_number(regexp_substr(sbCiclosTelemedidos,'[^,]+', 1,LEVEL)) AS ciclo
		   FROM dual
		   CONNECT BY regexp_substr(sbCiclosTelemedidos, '[^,]+', 1, LEVEL) IS NOT NULL)
	   WHERE ciclo = pkg_bcproducto.fnuciclofacturacion(nuproduct);

       IF vnucite = 1 THEN
          calculo_cons := 'RTU';
       END IF;
      END IF;
     pkg_traza.trace(' Paso 1', pkg_traza.cnuNivelTrzDef);
      sbAplicasoosf65 := 'S';
    
	   nmvalconsumo := 0;
	   BEGIN
		SELECT nvl(SUM(cc.cargvalo),0) INTO nmvalconsumo
		  FROM cuencobr cu,cargos cc
		 WHERE cucofact    = sbfactcodi
		   AND cc.cargpefa = sbfactpefa
		   AND cu.cucocodi = cc.cargcuco
		   AND cc.cargconc = 31
		   AND cc.cargcaca = 15
		   AND substr(cc.cargdoso,1,5) = 'CO-20';
	   EXCEPTION
		WHEN OTHERS THEN
		  nmvalconsumo := 0;
	   END;
   
      BEGIN
       /*01-03-2015 Llozada: Se envia el consumo sin multiplicarlo por el factor de correcci?n ya que en
         la tabla de consumos est? f?rmula ya est? aplicada.*/
       SELECT to_char(fac_correccion, '0.9999')
             ,round(consumo_act)
             , round(consumo_act) || ' M3 Equivalen a ' ||
                 round(par_pod_calor * consumo_act, 2) || 'Kwh Aprox $ '||replace(to_char(round(to_char((  decode((par_pod_calor * consumo_act),0,0,nmvalconsumo/(par_pod_calor * consumo_act)))), 2), '999990.99'), ' ', '') ||' kw/h'
		     ,round((consumo_mes_1 + consumo_mes_2 + consumo_mes_3 +
                     consumo_mes_4 + consumo_mes_5 + consumo_mes_6) / 6) cons_promedio
         INTO sbFactor_correccion
             ,cons_correg
             ,equival_kwh
             ,consumo_promedio
         FROM (SELECT ldc_detallefact_gascaribe.fnugetconsumoresidencial(MAX(sesunuse)
                     ,MAX(cosspecs)) consumo_act
                     ,MAX(fccofaco) fac_correccion
                     ,MAX(fccofasc) supercompres
                     ,MAX(fccofapc) * MAX(fccofaco) poder_calor
                 FROM factura f
                INNER JOIN servsusc s
                   ON (sesususc = factsusc AND
                         sesuserv =
                        pkg_bcld_parameter.fnuobtienevalornumerico('COD_SERV_GAS'))
                 LEFT OUTER JOIN conssesu c
                   ON (c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND
                       cossmecc = 4)
                 LEFT OUTER JOIN cm_facocoss
                   ON (cossfcco = fccocons)
                WHERE factcodi = sbfactcodi), perifact
        WHERE pefacodi = sbfactpefa;
    pkg_traza.trace(' Paso 2', pkg_traza.cnuNivelTrzDef);
     BEGIN
      nugeoloc := pkg_bcdirecciones.fnugetlocalidad(pkg_bcproducto.fnuIdDireccInstalacion(nuproduct)  );
     END;
     pkg_traza.trace(' Paso 3', pkg_traza.cnuNivelTrzDef);
	 /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
            cerca al dia del proceso*/
      --se consulta presion
      OPEN cucm_vavafacoP(nuproduct);
     FETCH cucm_vavafacoP INTO presion;
      IF cucm_vavafacoP%NOTFOUND THEN
       ------si no existe configuracion de presion para el producto se consulta por localidad
        OPEN cucm_vavafacoPl(nugeoloc);
       FETCH cucm_vavafacoPl INTO presion;
        IF cucm_vavafacoPl%NOTFOUND THEN
          presion := 0;
        END IF;
       CLOSE cucm_vavafacoPl;
       ------
      END IF;
     CLOSE cucm_vavafacoP;
     pkg_traza.trace(' Paso 4', pkg_traza.cnuNivelTrzDef);
     /*SPacheco Ara 8640 se trabaja con open fetch para identificar la configuracion mas
            cerca al dia del proceso*/
       --se consulta la temperatura configurada por el producto
      OPEN cucm_vavafacoPt(nuproduct);
      FETCH cucm_vavafacoPt INTO temperatura;
       IF cucm_vavafacoPt%NOTFOUND THEN
        ------si no posee configuracion de temperatura por producto consulta por localidad
         OPEN cucm_vavafacotl(nugeoloc);
        FETCH cucm_vavafacotl INTO temperatura;
         IF cucm_vavafacotl%NOTFOUND THEN
            temperatura := 0;
         END IF;
        CLOSE cucm_vavafacotl;
        ------
       END IF;
      CLOSE cucm_vavafacoPt;
      sbconsumo_promedio := to_char(consumo_promedio, 'FM999,999,990');
     EXCEPTION
      WHEN no_data_found THEN
       sbFactor_correccion := '0';
       consumo_mes_1       := 0;
       fecha_cons_mes_1    := ' ';
       consumo_mes_2       := 0;
       fecha_cons_mes_2    := ' ';
       consumo_mes_3       := 0;
       fecha_cons_mes_3    := ' ';
       consumo_mes_4       := 0;
       fecha_cons_mes_4    := ' ';
       consumo_mes_5       := 0;
       fecha_cons_mes_5    := ' ';
       consumo_mes_6       := 0;
       fecha_cons_mes_6    := ' ';
       consumo_promedio    := 0;
       sbconsumo_promedio  := '0';
       temperatura         := 0;
       cons_correg         := 0;
       calculo_cons        := ' ';
       equival_kwh         := ' ';
     END;
     -- Si es no regulado no muestra datos
     --INICIO CA 200-2032 ELAL -- se valida ciclos especiales
      SELECT COUNT(*) INTO vnuCicloEsp
        FROM(
             SELECT to_number(regexp_substr(sbCicloespe,'[^,]+', 1, LEVEL))  ciclos
               FROM   dual
            CONNECT BY regexp_substr(sbCicloespe, '[^,]+', 1, LEVEL) IS NOT NULL )
              WHERE ciclos =  nucicloc;
      presionvar :=  to_char(presion, 'FM999,990.90');
      IF  vnuCicloEsp >= 1 THEN
		   sbFactor_correccion := 'VER ANEXO';
		   temperatura := 'VER ANEXO';
		   presionvar := 'VER ANEXO';
      END IF;
 ELSE
  --no regulado
  --se consulta consumo de los cargos correspondientes
  IF cuObtConsumoNoReg%ISOPEN THEN CLOSE cuObtConsumoNoReg; END IF;
  
  OPEN cuObtConsumoNoReg;
  FETCH cuObtConsumoNoReg INTO cons_correg;
  CLOSE cuObtConsumoNoReg;
  
  sbFactor_correccion := NULL;
  consumo_mes_1       := NULL;
  fecha_cons_mes_1    := NULL;
  consumo_mes_2       := NULL;
  fecha_cons_mes_2    := NULL;
  consumo_mes_3       := NULL;
  fecha_cons_mes_3    := NULL;
  consumo_mes_4       := NULL;
  fecha_cons_mes_4    := NULL;
  consumo_mes_5       := NULL;
  fecha_cons_mes_5    := NULL;
  consumo_mes_6       := NULL;
  fecha_cons_mes_6    := NULL;
  consumo_promedio    := NULL;
  temperatura         := NULL;
  presion             := NULL;
  equival_kwh         := NULL;
  calculo_cons        := NULL;
 END IF;
 OPEN orfcursor FOR
  SELECT to_char(cons_correg,'FM999,999,999,990')         cons_correg
        ,sbFactor_correccion factor_correccion
        ,consumo_mes_1       consumo_mes_1
        ,fecha_cons_mes_1    fecha_cons_mes_1
        ,consumo_mes_2       consumo_mes_2
        ,fecha_cons_mes_2    fecha_cons_mes_2
        ,consumo_mes_3       consumo_mes_3
        ,fecha_cons_mes_3    fecha_cons_mes_3
        ,consumo_mes_4       consumo_mes_4
        ,fecha_cons_mes_4    fecha_cons_mes_4
        ,consumo_mes_5       consumo_mes_5
        ,fecha_cons_mes_5    fecha_cons_mes_5
        ,consumo_mes_6       consumo_mes_6
        ,fecha_cons_mes_6    fecha_cons_mes_6
        ,sbconsumo_promedio  consumo_promedio
        ,temperatura         temperatura
        ,presionvar          presion
        ,TRIM(equival_kwh)   equival_kwh
        ,calculo_cons        calculo_cons
    FROM dual;
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
END rfdatosconsumohist;
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosAdicionales(
                             sbFactcodi  ge_boInstanceControl.stysbValue
                            ,sbFactsusc  ge_boInstanceControl.stysbValue
                            ,sbPeriodo   ge_boInstanceControl.stysbValue
                            ,blNRegulado BOOLEAN
                            ,orfcursor   OUT constants_per.tyRefCursor
                            ) IS
/***********************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfDatosAdicionales
  Descripcion    : Procedimiento para extraer datos adicionales para mostrar en el SPOOL.
  Autor          : Jorge Valiente

  Parametros           Descripcion
  ============         ===================
  orfcursor            Retorna los datos generales de la factura.

  Fecha             Autor             Modificacion
  =========       =========           ====================
  01/07/2021      LJLB                 CA 635 se coloca campo de cambio de uso
*************************************************************************************************/
 csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.RfDatosAdicionales';
 nuProductoPrincipal pr_product.product_id%TYPE;

CURSOR cudireccionproducto(nuproducto pr_product.product_id%TYPE) IS
 SELECT aa.address_parsed direccion_producto
   FROM pr_product pp, ab_address aa
  WHERE pp.product_id = nuproducto
    AND pp.address_id = aa.address_id
    AND rownum = 1;

rfcudireccionproducto cudireccionproducto%ROWTYPE;

CURSOR cucausadesviacion(Isbfactcodi VARCHAR2) IS
 SELECT ldc_detallefact_gascaribe.fsbgetCalifVariConsumos(MAX(sesunuse), MAX(cosspecs)) CAUSA_DESVIACION
   FROM factura f
  INNER JOIN servsusc s
     ON (sesususc = factsusc AND
          sesuserv = pkg_bcld_parameter.fnuobtienevalornumerico('COD_SERV_GAS'))
   LEFT OUTER JOIN conssesu c
     ON (c.cosssesu = s.sesunuse AND c.cosspefa = f.factpefa AND
         cossmecc = 4)
   LEFT OUTER JOIN cm_facocoss
     ON (cossfcco = fccocons)
  WHERE factcodi = Isbfactcodi;
rfcucausadesviacion cucausadesviacion%ROWTYPE;
sbpagare_unico VARCHAR2(4000) := ' ';

CURSOR cupagareunico(IsbFactsusc VARCHAR2) IS
 SELECT lp.pagare_id pagare_unico
   FROM open.ldc_pagunidat lp
  WHERE lp.suscription_id = isbfactsusc
    AND lp.estado         = 1;

rfcupagareunico cupagareunico%ROWTYPE;
sbTipoSoli      VARCHAR2(400) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_TIPOCAUSO');
sbCategorias    VARCHAR2(400) := pkg_bcld_parameter.fsbobtienevalorcadena('LDC_CATEVACAMBIO');
nuproducto      NUMBER;
nuCategoria     NUMBER;
sbCambioUso     VARCHAR2(1) := 'N';
nuCateante      NUMBER;
nuperiante      NUMBER;

CURSOR cuGetCategoriaProd IS
 SELECT sesunuse, sesucate
   FROM servsusc
  WHERE sesususc = to_number(sbFactsusc)
    AND sesuserv = 7014
    AND sesucate IN (
                     SELECT to_number(regexp_substr(sbCategorias,'[^,]+', 1, LEVEL)) AS categoria
                       FROM dual
                     CONNECT BY regexp_substr(sbCategorias, '[^,]+', 1, LEVEL) IS NOT NULL
                    );

CURSOR cuExisteCambioUso IS
 SELECT open.pkbillingperiodmgr.fnugetperiodprevious(p.pefacodi) periodoant
   FROM mo_packages s, perifact p, mo_motive m
  WHERE s.package_id = m.package_id
    AND m.product_id = nuproducto
    AND p.pefacodi = to_number(sbPeriodo)
    AND s.request_date BETWEEN pefafimo AND pefaffmo
    AND s.motive_status_id = 14
    AND s.package_type_id IN (SELECT to_number(regexp_substr(sbTipoSoli,'[^,]+', 1, LEVEL)) AS tiposoli
                                FROM dual
                                  CONNECT BY regexp_substr(sbTipoSoli, '[^,]+', 1, LEVEL) IS NOT NULL
                                )
   ORDER BY s.attention_date DESC;

CURSOR cuGetCategoriaAnte IS
 SELECT cucocate
   FROM factura f, cuencobr c
  WHERE F.factcodi = c.cucofact
    AND c.cuconuse = nuproducto
    AND f.factpefa = nuperiante;
BEGIN
 pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

  OPEN cupagareunico(sbFactsusc);
 FETCH cupagareunico INTO rfcupagareunico;
    IF cupagareunico%FOUND THEN
     IF rfcupagareunico.pagare_unico IS NOT NULL THEN
        sbpagare_unico := 'con PU';
     END IF;
    END IF;
 CLOSE cupagareunico;
 IF NOT blnregulado THEN
   OPEN cuGetCategoriaProd;
  FETCH cuGetCategoriaProd INTO nuproducto, nuCategoria;
  CLOSE cuGetCategoriaProd;
  IF nuproducto IS NOT NULL THEN
    OPEN cuExisteCambioUso;
   FETCH cuExisteCambioUso INTO nuperiante;
    IF cuExisteCambioUso%FOUND THEN
       OPEN cuGetCategoriaAnte;
      FETCH cuGetCategoriaAnte INTO nuCateante;
      CLOSE cuGetCategoriaAnte;
     IF NVL(nuCateante,nuCategoria) <> nuCategoria THEN
        sbCambioUso := 'S';
     END IF;
    END IF;
   CLOSE cuExisteCambioUso;
  END IF;
  OPEN orfcursor FOR
    SELECT NULL           direccion_producto
          ,NULL           causa_desviacion
          ,sbpagare_unico pagare_unico
          ,sbCambioUso    cambiouso
      FROM dual;
    ELSE
     nuProductoPrincipal := ldc_detallefact_gascaribe.fnuProductoPrincipal(sbFactsusc);
      OPEN cucausadesviacion(sbFactcodi);
     FETCH cucausadesviacion INTO rfcucausadesviacion;
     CLOSE cucausadesviacion;

      OPEN cudireccionproducto(nuProductoPrincipal);
     FETCH cudireccionproducto INTO rfcudireccionproducto;
     CLOSE cudireccionproducto;

      OPEN orfcursor FOR
       SELECT rfcudireccionproducto.direccion_producto direccion_producto
             ,rfcucausadesviacion.causa_desviacion     causa_desviacion
             ,sbpagare_unico                           pagare_unico
             ,NULL                                     cambiouso
         FROM dual;
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
END rfdatosadicionales;
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosMedMalubi(
                           sbfactpefa ge_boinstancecontrol.stysbvalue
                          ,nuproduct  servsusc.sesunuse%TYPE
                          ,orfcursor OUT constants_per.tyRefCursor
                          ) IS
/****************************************************************************************
Propiedad intelectual de GDC (c).

Unidad         : RfDatosMedMalubi
Descripcion    : Procedimiento para extraer si el usuario tiene solicitud VSI
                 dentro del periodo de facturaci?n
Ticket         : OSF-72
Fecha          : 10/05/2022
Autor          : John Jairo Jimenez Marimon

Parametros           Descripcion
============         ===================


Fecha             Autor             Modificacion
=========       =========           ====================
******************************************************************************************/
csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.RfDatosAdicionales';
nmconta        NUMBER;
sbmed_mal_ubic VARCHAR2(2);
BEGIN
 pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 
 sbmed_mal_ubic := 'N';
 SELECT COUNT(1) INTO nmconta
   FROM or_order_activity a,or_order o,ldc_obleacti l
  WHERE a.product_id  = nuproduct
    AND a.activity_id = l.actividad
    AND l.gen_noti    = 'S'
    AND o.order_status_id <> 12
    AND a.order_id    = o.order_id
    AND EXISTS (
                 SELECT '1'
                   FROM perifact pf
                  WHERE pf.pefacodi = sbfactpefa
                    AND o.created_date BETWEEN pf.pefafimo AND pf.pefaffmo
                );
    IF nmconta >= 1 THEN
     sbmed_mal_ubic := 'S';
    ELSE
     sbmed_mal_ubic := 'N';
    END IF;
 -- Enviamos respuesta
 OPEN orfcursor FOR
  SELECT sbmed_mal_ubic AS med_mal_ubicado
    FROM dual;
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
END rfdatosmedmalubi;
-----------------------------------------------------------------------------------------------------------------------

END ldc_pkgprocefactspoolconsu;
/