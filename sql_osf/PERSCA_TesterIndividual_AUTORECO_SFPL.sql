--ALTER SESSION SET CURRENT_SCHEMA = OPEN;
DECLARE

  csbNivelTraza CONSTANT NUMBER(2) := pkg_traza.fnuNivelTrzDef;

  csbCAUSCARG_PERSCA       CONSTANT LD_PARAMETER.value_chain%TYPE := '1,4,15,60'; -- pkg_BCLD_Parameter.fsbObtieneValorCadena ('CAUSCARG_PERSCA');
  cnuCONCEPTO_CONSUMO      CONSTANT concepto.conccodi%TYPE := 31;
  cnuMESES_PERSCA_AUTORECO CONSTANT NUMBER := 3; --pkg_parametros.fnuGetValorNumerico('MESES_PERSCA_AUTORECO');

  TYPE tytbEscoFact IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;

  gtbEscoFact tytbEscoFact;

  gsbConsulta            VARCHAR2(32000);
  gblgtbPrNoValiAutoreco BOOLEAN := FALSE;

  TYPE tytbPrNoValiAutoreco IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

  gtbPrNoValiAutoreco tytbPrNoValiAutoreco;

  nuProceso NUMBER := 7;

  csbTIPO_SUSP_GENE_PERS CONSTANT LDC_PARAREPE.paravast%TYPE := '102,104'; --daLDC_PARAREPE.fsbGetPARAVAST('TIPOSUSP_GENERA_PERSEC_REPA',NULL);

  TYPE tytbTISU_GENERA_PERSEC_REPA IS TABLE OF NUMBER(1) INDEX BY BINARY_INTEGER;
  gtbTiSuGeneraPersecRepa tytbTISU_GENERA_PERSEC_REPA;

  NUCantiReg number := 0;

  sbRegistra varchar2(1);

  CURSOR cuProd IS
    SELECT product_id
      FROM pr_product
     WHERE product_type_id = 7014
       AND subscription_id in (1505492);

  nuConta     NUMBER;
  sumaConsumo NUMBER;
  sw          NUMBER;

  nuPaso NUMBER;

  inuProceso NUMBER := nuProceso;

  sbRecipients VARCHAR2(2000);

  dfFechaLega     DATE;
  nuUltimaLectura NUMBER;

  nuORD_ACT_ID pr_product.SUSPEN_ORD_ACT_ID%type;

  nuLEEMLETO lectelme.LEEMLETO%type;
  nuLEEMPEFA lectelme.LEEMPEFA%type;
  dfLEEMFELE lectelme.LEEMFELE%type;
  nuLEEMSESU lectelme.LEEMSESU%type;
  nuLEEMDOCU lectelme.LEEMDOCU%type;
  nuLEEMPECS lectelme.LEEMPECS%type;

  type stylectelme IS record(
    LEEMLETO lectelme.LEEMLETO%type,
    LEEMPEFA lectelme.LEEMPEFA%type,
    LEEMFELE lectelme.LEEMFELE%type,
    LEEMSESU lectelme.LEEMSESU%type,
    LEEMDOCU lectelme.LEEMDOCU%type,
    LEEMPECS lectelme.LEEMPECS%type);

  type tbtylectelmeTable IS table of stylectelme index BY binary_integer;

  tblectelme tbtylectelmeTable;

  -- contrato a procesar
  nuNumesusc servsusc.sesususc%type;
  -- Producto a procesar
  nuNumeServ servsusc.sesunuse%type;
  -- Estado de Corte del Producto
  nuServEsco servsusc.sesuesco%type;
  -- Ciclo del producto
  nuciclo servsusc.sesucicl%type;
  -- order_activity_id de la orden de suspension
  -- Ciclo de consumo del servicio suscrito
  nuCicloCons servsusc.sesucico%type;

  -- se consulta lectura actual y lectura anterior de facturacion
  CURSOR cuConsuLectfact(dtFechaLect date) IS --200-2611
    SELECT leemleto lectactu, leemlean lectant, leemfele fecha
      FROM lectelme
     WHERE leemsesu = nuNumeServ
       AND leemtcon = 1
       AND leemclec = 'F'
       and lectelme.leemfele >= dtFechaLect --200-2611
       AND lectelme.leemfele IN
           (SELECT MAX(lectelme.leemfele)
              FROM lectelme
             WHERE leemsesu = nuNumeServ
               AND leemclec = 'F')
       AND leemleto > 0;

  rgLecturaProd cuConsuLectfact%rowtype;

  -- Lista de procesos de Autoreconectados
  cnuLDC_PROCAUTORECO CONSTANT ld_parameter.numeric_value%TYPE := 7; --pkg_BCLD_Parameter.fnuObtieneValorNumerico ('LDC_PROCAUTORECO') ;

  -- Lista de procesos de Autoreconectados Servicios Nuevos        
  csbPROCAUTORECO_SN CONSTANT ld_parameter.value_chain%TYPE := NULL; --pkg_BCLD_Parameter.fsbObtieneValorCadena ('PROCAUTORECO_SN') ;

  cnuTOLEREANCIA_DIF NUMBER := 5; /*NVL (
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                       'TOLERANCIA_DIFE_AUTORECONE'),
                   0);*/

  cnuTOLEREANCIA_DIFSN NUMBER := 1; /*NVL (
                   pkg_BCLD_Parameter.fnuObtieneValorNumerico (
                       'TOLERANCIA_DIFE_AUTORECONE_SN'),
                   0);*/

  gnuToleranciaDif NUMBER;

  inuSERV NUMBER := 7014; --pkg_BCLD_Parameter.fnuObtieneValorNumerico('COD_TIPO_SERV');

  inuCiclo        NUMBER := -1;
  inuDepartamento NUMBER := -1;
  inuLocalidad    NUMBER := -1;

  inCiclo        NUMBER;
  inDepartamento NUMBER;
  inLocalidad    NUMBER;

  nuDepaProd NUMBER;
  nuLocaProd NUMBER;

  nuTitrSusp  NUMBER;
  nuOrdenSusp NUMBER;
  nuLectSusp  NUMBER;

  SBESTADOCORTE    VARCHAR2(4000);
  SBESTADOPRODUCTO VARCHAR2(4000);
  SBTIPOSUSPENSION VARCHAR2(4000);

  --CURSOR PARA OBTENER LOS DATOS PRO PROCESO DE PERSECUCION
  CURSOR culdc_Proceso(NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE) IS
    SELECT LP.* FROM LDC_PROCESO LP WHERE LP.PROCESO_ID = NULDC_PROCESO_ID;

  rcldc_Proceso culdc_Proceso%ROWTYPE;

  cursor cuproductossuspendidosauto(nuCiclo          servsusc.sesucicl%type,
                                    NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE,
                                    ESTADOCORTE      VARCHAR2,
                                    ESTADOPRODCUTO   VARCHAR2,
                                    TIPOSSUSPENSION  VARCHAR2,
                                    inudepa          NUMBER,
                                    inuloca          NUMBER,
                                    inuProductId     IN servsusc.sesunuse%type) IS
    SELECT *
      FROM (SELECT sesususc,
                   sesunuse,
                   sesuesco,
                   sesucicl,
                   suspen_ord_act_id,
                   --PR_BOSUSPENDCRITERIONS.FNUGETPRODUCTDEPARTMEN(s.sesunuse) DEPA,
                   (select gl.geo_loca_father_id
                      from pr_product         pr,
                           ab_address         ab,
                           ge_geogra_location gl
                     where pr.address_id = ab.address_id
                       and pr.product_id = s.sesunuse
                       and gl.geograp_location_id = ab.geograp_location_id) DEPA,
                   --PKG_BCPRODUCTO.FNUOBTENERLOCALIDAD(s.sesunuse ) LOCA--,
                   (select ab.geograp_location_id
                      from pr_product pr, ab_address ab
                     where pr.address_id = ab.address_id
                       and pr.product_id = s.sesunuse) LOCA
            --inuHilo pershilo
              FROM servsusc              s,
                   pr_product            p,
                   pr_prod_suspension    ps,
                   ldc_proceso_actividad lpa
             WHERE s.sesuesco IN
                   (SELECT TO_NUMBER(REGEXP_SUBSTR(decode(estadocorte,
                                                          '-1',
                                                          to_char(s.sesuesco),
                                                          estadocorte),
                                                   '[^' || ',' /*','*/
                                                   || ']+',
                                                   1,
                                                   level))
                      FROM dual
                    CONNECT BY REGEXP_SUBSTR(decode(estadocorte,
                                                    '-1',
                                                    to_char(s.sesuesco),
                                                    estadocorte),
                                             '[^' || ',' /*','*/
                                             || ']+',
                                             1,
                                             level) is not null)
               AND p.product_status_id IN
                  
                   (SELECT TO_NUMBER(REGEXP_SUBSTR(decode(estadoprodcuto,
                                                          '-1',
                                                          to_char(p.product_status_id),
                                                          estadoprodcuto),
                                                   '[^' || ',' /*','*/
                                                   || ']+',
                                                   1,
                                                   level))
                      FROM dual
                    CONNECT BY REGEXP_SUBSTR(decode(estadoprodcuto,
                                                    '-1',
                                                    to_char(p.product_status_id),
                                                    estadoprodcuto),
                                             '[^' || ',' /*','*/
                                             || ']+',
                                             1,
                                             level) is not null)
               AND ps.suspension_type_id IN
                   (SELECT TO_NUMBER(REGEXP_SUBSTR(decode(tipossuspension,
                                                          '-1',
                                                          to_char(ps.suspension_type_id),
                                                          tipossuspension),
                                                   '[^' || ',' /*','*/
                                                   || ']+',
                                                   1,
                                                   level))
                      FROM dual
                    CONNECT BY REGEXP_SUBSTR(decode(tipossuspension,
                                                    '-1',
                                                    to_char(ps.suspension_type_id),
                                                    tipossuspension),
                                             '[^' || ',' /*','*/
                                             || ']+',
                                             1,
                                             level) is not null)
               AND s.sesucicl = decode(nuciclo, -1, s.sesucicl, nuciclo)
               AND sesuserv = inuServ
               AND ps.ACTIVE = 'Y'
               AND p.product_id = s.sesunuse
               AND p.product_id = ps.product_id
               AND p.suspen_ord_act_id IS NOT NULL
               AND 0 = (SELECT count(1)
                          FROM LDC_SUSP_AUTORECO, or_order
                         WHERE SARESESU = sesunuse
                           AND SAREORDE = order_id
                           AND order_status_id IN (0, 5, 6, 7)) --200-2614
               AND 0 = (SELECT count(1)
                          FROM LDC_SUSP_AUTORECO
                         WHERE SARESESU = s.sesunuse
                           AND SAREORDE IS NULL)
               AND lpa.proceso_id = nuldc_proceso_id
               AND lpa.activity_id =
                  --pkg_bcordenes.fnuObtieneItemActividad(suspen_ord_act_id)
                   (SELECT activity_id
                      FROM or_order_activity
                     WHERE order_activity_id = suspen_ord_act_id)
               AND NOT EXISTS
             (SELECT 'X'
                      FROM or_order_activity,
                           or_order,
                           ldc_actividad_generada
                     WHERE or_order_activity.product_id = p.product_id
                       AND or_order_activity.order_id = or_order.order_id
                       AND order_status_id IN (0, 5, 6, 7) --200-2614
                       AND or_order_activity.activity_id =
                           ldc_actividad_generada.proxima_activity_id
                       AND ldc_actividad_generada.activity_id_generada =
                           lpa.activity_id -- Inicia NC 3468.
                    )
               AND sesunuse = inuProductId
               AND --/*LDC_PKGESTPREXCLURP*/FUNVALEXCLURP(sesunuse) = 0
                   (SELECT COUNT(1)
                      FROM LDC_PRODEXCLRP
                     WHERE PRODUCT_ID = inuProductId) = 0)
     WHERE DEPA = DECODE(inuDepa, -1, depa, inudepa)
       AND loca = DECODE(inuLoca, -1, loca, inuLoca);

  rcproductossuspendidosauto cuproductossuspendidosauto%ROWTYPE;

  CURSOR cuMaximaLectura(nuNuse           lectelme.leemsesu%type,
                         NULDC_PROCESO_ID LDC_PROCESO.PROCESO_ID%TYPE) IS
  
    SELECT leemfele, nvl(leemleto, 0), b.order_id, b.task_type_id
      FROM lectelme a
     inner join or_order_activity b
        on a.LEEMDOCU = b.ORDER_ACTIVITY_ID
     WHERE LEEMSESU = nuNuse
       AND LEEMCLEC = 'T'
       AND --pkg_BCOrdenes.fnuObtieneTipoTrabajo(b.order_id) 
           (SELECT task_type_id FROM or_order WHERE order_id = b.order_id) =
           (SELECT LPA.TASK_TYPE_ID
              FROM LDC_PROCESO_ACTIVIDAD LPA
             WHERE LPA.PROCESO_ID = NULDC_PROCESO_ID
               AND LPA.ACTIVITY_ID = B.ACTIVITY_ID)
     ORDER BY leemfele desc;

  --se consulta informacion del producto
  CURSOR cuDatosProd IS
    SELECT 1 /*daab_segments.fnugetoperating_sector_id(PKG_BCDIRECCIONES.FNUGETSEGMENTO_ID(address_id), NULL)*/ seop,
           suscclie cliente,
           subscription_id contrato,
           product_status_id estado_prod,
           address_id direccion,
           category_id categoria,
           (SELECT multivivienda
              FROM ldc_info_predio
             WHERE premise_id = (select estate_number
                                   from ab_address
                                  where address_id = address_id
                                    and rownum < 2) --PKG_BCDIRECCIONES.FNUGETPREDIO(address_id )
               AND ROWNUM < 2) multfami,
           (SELECT MAX(plazo_maximo)
              FROM ldc_plazos_cert
             WHERE id_producto = product_id) plazo_max
      FROM pr_product, suscripc
     WHERE subscription_id = susccodi
       AND product_id = nuNumeServ;

  rgDatosProd cuDatosProd%rowtype;

  --Se consulta marca de suspension
  CURSOR cuMarcaProd IS
    SELECT suspension_type_id
      FROM pr_prod_suspension
     WHERE active = 'Y'
       AND product_id = nuNumeServ;

  nuMarcaProd NUMBER;

  CURSOR cuLecturas(nuNuse lectelme.leemsesu%type,
                    dtfele lectelme.leemfele%type) IS
    SELECT LEEMLETO, LEEMPEFA, LEEMFELE, LEEMSESU, LEEMDOCU, LEEMPECS
      FROM lectelme
     WHERE LEEMSESU = nuNuse
       AND leemtcon = 1
       AND LEEMCLEC = 'F'
       AND leemfele > dtfele
       and lectelme.leemfele in
           (SELECT max(lectelme.leemfele)
              FROM lectelme
             WHERE leemsesu = nuNuse
               AND leemclec = 'F')
       and LEEMLETO > 0;

  ONUPREVPECSCONS conssesu.cosspecs%type;

  nuPromedio            number := 0;
  Limite                number(9);
  add_cons_tope         number(9) := 2; --pkg_BCLD_Parameter.fnuObtieneValorNumerico('PCAR_VALOR_ADIC_CONS_PROM');
  periodos_consecutivos VARCHAR2(1) := 'N'; --pkg_BCLD_Parameter.fsbObtieneValorCadena('FLAG_PERIODO_CONSE_PERS');
  nuNumPeriodo          number := 1; --pkg_BCLD_Parameter.fnuObtieneValorNumerico('NUM_PERI_EVA_PERS');
  sbmarca               varchar(1);
  NUACTIVITY            ge_items.items_id%type;
  nuDeudaCorr           NUMBER(15, 2) := 0;
  nuDeudaDife           NUMBER(15, 2) := 0;
  nuSaldoTot            NUMBER(15, 2) := 0;
  NUACTIV_GENERA        ge_items.items_id%type;

  procedure Traza(isbMetodo     varchar2,
                  isbNivelTraza VARCHAR2 DEFAULT NULL,
                  isbMomento    VARCHAR2 DEFAULT NULL) IS
  BEGIN
    IF isbMomento IS NOT NULL THEN
      DBMS_OUTPUT.PUT_LINE(CASE isbMomento
                             WHEN 'I' THEN
                              'Inicia'
                             ELSE
                              'Finaliza'
                           END || '_' || isbMetodo);
    ELSE
      DBMS_OUTPUT.PUT_LINE(isbMetodo);
    END IF;
  END Traza;

  FUNCTION fdtFechIniVolFact(idtFechaSusp DATE) RETURN DATE IS
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fdtFechIniVolFact';
  
    dtFechIniVolFact DATE;
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    Traza('cnuMESES_PERSCA_AUTORECO|' || cnuMESES_PERSCA_AUTORECO, 10);
  
    IF NVL(cnuMESES_PERSCA_AUTORECO, 0) <= 0 THEN
      dtFechIniVolFact := idtFechaSusp;
    ELSE
      dtFechIniVolFact := TRUNC(ADD_MONTHS(SYSDATE,
                                           -cnuMESES_PERSCA_AUTORECO));
    
      IF dtFechIniVolFact < idtFechaSusp THEN
        dtFechIniVolFact := idtFechaSusp;
      END IF;
    
    END IF;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN dtFechIniVolFact;
  
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            pkg_Error.getError(nuError,sbError);
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      --            pkg_error.setError;
      --            pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || sbError, csbNivelTraza);
      RAISE; -- pkg_error.Controlled_Error;
  END fdtFechIniVolFact;

  PROCEDURE pCargagtbEscoFact IS
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pCargagtbEscoFact';
  
    CURSOR cuEscoFact IS
      SELECT *
        FROM confesco
       WHERE coecserv = 7014 /*cnuSERV_GAS*/
         AND coecfact = 'S';
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    IF gtbEscoFact.COUNT = 0 THEN
    
      FOR rgEscoFact IN cuEscoFact LOOP
      
        gtbEscoFact(rgEscoFact.coeccodi) := 1;
      
      END LOOP;
    
    END IF;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            pkg_Error.getError(nuError,sbError);
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      --pkg_error.setError;
      --pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || sbError, csbNivelTraza);
      RAISE; -- pkg_error.Controlled_Error;
  END pCargagtbEscoFact;

  FUNCTION fsbVolFactMayToler(inuProducto  NUMBER,
                              inuSeSuEsCo  NUMBER,
                              idtFechaSusp DATE,
                              inuSeSuCiCo  NUMBER) RETURN VARCHAR2 IS
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fsbVolFactMayToler';
  
    -- Volumen facturado neto posterior a la fecha de lectura suspensi n
    nuVoluFactPostSusp NUMBER;
  
    sbVolFactMayToler VARCHAR2(1) := 'N';
  
    dtFechIniVolFact DATE;
  
    -- Obtiene el volumen facturado neto posterior a la fecha de lectura suspensi n
    CURSOR cuVoluFactPostSusp(idtFechIniVolFact DATE,
                              idtFechSuspension DATE) IS
      WITH causas AS
       (SELECT /*+ MATERIALIZED */
         REGEXP_SUBSTR(csbCAUSCARG_PERSCA, '[^,]+', 1, level) codigo
          FROM DUAL
        CONNECT BY REGEXP_SUBSTR(csbCAUSCARG_PERSCA, '[^,]+', 1, level) is not null)
      SELECT /*+ INDEX ( CARGOS IX_CARG_NUSE_CUCO_CONC ) */
       SUM(CASE ca.cargsign
             WHEN 'DB' THEN
              cargunid
             WHEN 'CR' then
              -cargunid
           END) volumen
        FROM cargos ca
       WHERE ca.cargnuse = inuProducto
         AND ca.cargcuco > 0
         AND ca.cargconc = cnuCONCEPTO_CONSUMO
         AND ca.cargcaca IN (SELECT codigo FROM causas)
         AND ca.cargsign IN ('DB', 'CR')
         AND ca.cargfecr > idtFechIniVolFact
         AND ca.cargpeco IN (SELECT pecscons
                               FROM pericose pc
                              WHERE pc.pecscico = inuSeSuCiCo
                                AND pc.pecsfeci >= idtFechIniVolFact
                                AND pc.pecsfeci > idtFechSuspension
                                AND pc.pecsflav = 'S');
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    Traza('inuSesuEsco|' || inuSesuEsco, 10);
    Traza('inuSesuCico|' || inuSesuCico, 10);
  
    Traza('idtFechaSusp|' ||
          to_char(idtFechaSusp, 'dd/mm/yyyy hh24:mi:ss'),
          10);
  
    pCargagtbEscoFact;
  
    IF gtbEscoFact.exists(inuSeSuEsCo) THEN
    
      nuVoluFactPostSusp := NULL;
    
      dtFechIniVolFact := fdtFechIniVolFact(idtFechaSusp);
    
      Traza('dtFechIniVolFact|' ||
            to_char(dtFechIniVolFact, 'dd/mm/yyyy hh24:mi:ss'),
            10);
    
      -- Obtiene el volumen facturado neto posterior a la fecha de lectura suspensi n
      OPEN cuVoluFactPostSusp(dtFechIniVolFact, idtFechaSusp); ---
      FETCH cuVoluFactPostSusp
        INTO nuVoluFactPostSusp;
      CLOSE cuVoluFactPostSusp;
    
      Traza('nuVoluFactPostSusp|' || nuVoluFactPostSusp, 10);
    
      Traza('gnuToleranciaDif|' || gnuToleranciaDif, 10);
    
      -- Si el volumen facturado neto posterior a la fecha de lectura suspensi n es menor
      -- o igual al tolerado se procesa el siguiente producto
      IF NVL(nuVoluFactPostSusp, 0) > gnuToleranciaDif THEN
        sbVolFactMayToler := 'S';
      END IF;
    
    ELSE
      -- Indica que el producto esta en un estado de cartera no facturable
      sbVolFactMayToler := 'X';
    END IF;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN sbVolFactMayToler;
  
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            pkg_Error.getError(nuError,sbError);
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      --pkg_error.setError;
      --pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || sbError, csbNivelTraza);
      RAISE; -- pkg_error.Controlled_Error;
  END fsbVolFactMayToler;

  FUNCTION fnuObtieneItemActividad(inuActividadOrden IN or_order_activity.order_activity_id%TYPE)
    RETURN or_order_activity.activity_id%TYPE IS
  
    csbMT_NAME VARCHAR2(70) := '.fnuObtieneItemActividad';
  
    CURSOR cuActividad(inuActividadOrden IN or_order_activity.order_activity_id%TYPE) IS
      SELECT activity_id
        FROM or_order_activity
       WHERE order_activity_id = inuActividadOrden;
  
    nuActividad or_order_activity.activity_id%TYPE;
  
    PROCEDURE CierraCursorActividad IS
      -- Nombre de este m todo
      csbMT_NAME1 VARCHAR2(105) := csbMT_NAME || '.CierraCursorActividad';
    BEGIN
    
      Traza(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    
      IF (cuActividad%ISOPEN) THEN
        CLOSE cuActividad;
      END IF;
    
      Traza(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    
    END CierraCursorActividad;
  
  BEGIN
  
    Traza(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    Traza('inuActividadOrden: ' || inuActividadOrden,
          pkg_traza.cnuNivelTrzDef);
  
    CierraCursorActividad;
  
    OPEN cuActividad(inuActividadOrden);
    FETCH cuActividad
      INTO nuActividad;
    CLOSE cuActividad;
  
    Traza('nuActividad: ' || nuActividad, pkg_traza.cnuNivelTrzDef);
    Traza(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
    RETURN nuActividad;
  
  EXCEPTION
    WHEN OTHERS THEN
      --pkg_error.SetError;
      CierraCursorActividad;
      Traza(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RETURN nuActividad;
  END fnuObtieneItemActividad;
  -- Carga la tabla global gtbPrNoValiAutoreco
  PROCEDURE pCarggtbPrNoValiAutoreco(inuServ NUMBER, inuProceso NUMBER) IS
  
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pCarggtbPrNoValiAutoreco';
  
    -- Cursor referenciado para obtener los productos a procesar
    rfcProdNoValPers SYS_REFCURSOR;
  
    TYPE tytbProdNoValPers IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;
  
    tbProdNoValPers tytbProdNoValPers;
  
    csbRT VARCHAR2(1) := CHR(13);
  
    CURSOR cuConsConf IS
      WITH ActiValid AS
       (select DISTINCT REGEXP_SUBSTR(A.ACTIVIDAD_VALIDAR, '[^,]+', 1, level) Actividad
          from LDC_PROCESO A
         where A.PROCESO_ID = inuProceso
        connect by regexp_substr(A.ACTIVIDAD_VALIDAR, '[^,]+', 1, level) is not null),
      TiTrValid AS
       (select DISTINCT task_type_id
          from or_task_types_items
         where items_id in (SELECT Actividad FROM ActiValid)),
      EstaNoTerm AS
       (SELECT ORDER_STATUS_ID EstaOrde
          FROM or_order_status
         WHERE is_final_status = 'N'),
      ListaActiValid AS
       (select ListAgg(Actividad, ',') within group(order by 1) sbActiValid
          from ActiValid),
      ListaTiTrValid AS
       (select ListAgg(task_type_id, ',') within group(order by 1) sbTiTrValid
          from TiTrValid),
      ListaEstaNoTerm AS
       (select ListAgg(EstaOrde, ',') within group(order by 1) sbEstaNoTerm
          from EstaNoTerm),
      ListasEstados AS
       (select EstadoProducto sbEstaProd, EstadoCorteCC sbEstaCort
          from LDC_PROCESO A
         where A.PROCESO_ID = inuProceso)
      SELECT *
        FROM ListaActiValid, ListaTiTrValid, ListaEstaNoTerm, ListasEstados;
  
    rcConsConf cuConsConf%ROWTYPE;
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    IF NOT gblgtbPrNoValiAutoreco THEN
    
      OPEN cuConsConf;
      FETCH cuConsConf
        INTO rcConsConf;
      CLOSE cuConsConf;
    
      IF rcConsConf.sbEstaProd <> '-1' THEN
      
        gsbConsulta := 'select pr.product_id sesunuse' || csbRT ||
                       'from or_order ot' || csbRT ||
                       'inner join or_order_activity oa on oa.order_id = ot.order_id' ||
                       csbRT ||
                       'inner join pr_product pr on pr.product_id = oa.product_id' ||
                       csbRT || 'where ot.task_type_id in ( ' ||
                       rcConsConf.sbTiTrValid || ' )' || csbRT ||
                       '  and ot.order_status_id in ( ' ||
                       rcConsConf.sbEstaNoTerm || ' )' || csbRT ||
                       '  and oa.activity_id + 0 in (' ||
                       rcConsConf.sbActiValid || ' )' || csbRT ||
                       '  and pr.product_status_id + 0 IN ( ' ||
                       rcConsConf.sbEstaProd || ')' || csbRT ||
                       '  and pr.product_type_id = :nuServ' || csbRT;
      
      ELSE
      
        gsbConsulta := 'select pr.sesunuse' || csbRT || 'from or_order ot' ||
                       csbRT ||
                       'inner join or_order_activity oa on oa.order_id = ot.order_id' ||
                       csbRT ||
                       'inner join servsusc pr on pr.sesunuse = oa.product_id' ||
                       csbRT || 'where ot.task_type_id in ( ' ||
                       rcConsConf.sbTiTrValid || ' )' || csbRT ||
                       '  and ot.order_status_id in ( ' ||
                       rcConsConf.sbEstaNoTerm || ' )' || csbRT ||
                       '  and oa.activity_id + 0 in (' ||
                       rcConsConf.sbActiValid || ' )' || csbRT ||
                       '  and pr.sesuesco + 0 IN ( ' ||
                       rcConsConf.sbEstaCort || ')' || csbRT ||
                       '  and pr.sesuserv = :nuServ' || csbRT;
      
      END IF;
    
      Traza('gsbConsulta|' || gsbConsulta, 10);
    
      OPEN rfcProdNoValPers FOR gsbConsulta
        USING inuServ;
    
      LOOP
      
        tbProdNoValPers.DELETE;
      
        FETCH rfcProdNoValPers BULK COLLECT
          INTO tbProdNoValPers LIMIT 100;
      
        EXIT WHEN tbProdNoValPers.COUNT = 0;
      
        FOR ind IN 1 .. tbProdNoValPers.COUNT LOOP
          gtbPrNoValiAutoreco(tbProdNoValPers(ind)) := 1;
        END LOOP;
      
      END LOOP;
    
      CLOSE rfcProdNoValPers;
    
      gblgtbPrNoValiAutoreco := TRUE;
    
    END IF;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            --pkg_Error.getError(nuError,sbError);
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RAISE; /*RAISE pkg_error.Controlled_Error;*/
    WHEN OTHERS THEN
      Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      --pkg_error.setError;
      --pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || sbError, csbNivelTraza);
      RAISE; /*RAISE pkg_error.Controlled_Error;*/
  END pCarggtbPrNoValiAutoreco;

  -- Valida si el producto debe iniciar proceso de persecucion por autoreconexion
  FUNCTION fnugetValidaAuto(inuProducto IN servsusc.sesunuse%type,
                            inuProceso  ldc_proceso.proceso_id%TYPE)
    RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fnugetValidaAuto';
  
    nugetValidaAuto NUMBER(1) := 0;
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pCarggtbPrNoValiAutoreco(7014 /*cnuSERV_GAS*/, inuProceso);
  
    IF gtbPrNoValiAutoreco.exists(inuProducto) THEN
      nugetValidaAuto := 1;
    END IF;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN nugetValidaAuto;
  
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            --pkg_Error.getError(nuError,sbError);
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RETURN 0;
    WHEN OTHERS THEN
      Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      --pkg_error.setError;
      --pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || sbError, csbNivelTraza);
      RETURN 0;
  END fnugetValidaAuto;

  FUNCTION fnuGetActividadgenerarAuto(inuProceso   IN LDC_PROCESO.PROCESO_ID%TYPE,
                                      inuActividad IN LDC_PROCESO_ACTIVIDAD.ACTIVITY_ID%TYPE,
                                      sbMarca      in number) RETURN NUMBER IS
  
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fnuGetActividadgenerarAuto';
  
    --consulta Actividad a Generar
    CURSOR cuConsultaActividadGene IS
      SELECT PROXIMA_ACTIVITY_ID
        FROM LDC_ACTIVIDAD_GENERADA LAG
       WHERE LAG.PROCESO_ID = inuProceso
         AND LAG.ACTIVITY_ID_GENERADA = inuActividad
         AND INSTR(',' || SUSPENSION_TYPE_ID || ',', ',' || sbMarca || ',') > 0;
  
    nuProxActivi LDC_ACTIVIDAD_GENERADA.PROXIMA_ACTIVITY_ID%type;
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    OPEN cuConsultaActividadGene;
    FETCH cuConsultaActividadGene
      INTO nuProxActivi;
    CLOSE cuConsultaActividadGene;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN nuProxActivi;
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            --pkg_Error.getError(nuError,sbError);        
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RETURN -1;
    WHEN OTHERS THEN
      Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);
      ----pkg_error.setError;
      ----pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || SQLERRM, csbNivelTraza);
      RETURN - 1;
  END fnuGetActividadgenerarAuto;

  -- Carga la tabla global gtbTiSuGeneraPersecRepa
  PROCEDURE pCarggtbTiSuGenePersecRepa IS
  
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.pCarggtbTiSuGenePersecRepa';
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    CURSOR cuTipoSuspGenePers IS
      SELECT REGEXP_SUBSTR(csbTIPO_SUSP_GENE_PERS,
                           '[^' || ',' || ']+',
                           1,
                           level) TipoSusp
        FROM dual
      CONNECT BY regexp_substr(csbTIPO_SUSP_GENE_PERS,
                               '[^' || ',' || ']+',
                               1,
                               level) is not null;
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    IF gtbTiSuGeneraPersecRepa.COUNT = 0 THEN
    
      FOR rgTiSu IN cuTipoSuspGenePers LOOP
        gtbTiSuGeneraPersecRepa(rgTiSu.TipoSusp) := 1;
      END LOOP;
    
    END IF;
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            --pkg_Error.getError(nuError,sbError);        
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RAISE; /*RAISE pkg_error.Controlled_Error;*/
    WHEN OTHERS THEN
      --Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
      ----pkg_error.setError;
      ----pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || SQLERRM, csbNivelTraza);
      RAISE;
  END pCarggtbTiSuGenePersecRepa;

  FUNCTION fsbPermiteRegistroAutoRec(inuProducto IN pr_product.product_id%type)
    RETURN VARCHAR2 IS
  
    csbMetodo CONSTANT VARCHAR2(100) := 'LDC_PKGENEORDEAUTORECO.fsbPermiteRegistroAutoRec';
  
    sbPermiteRegistroAutoRec VARCHAR2(1) := 'N';
  
    cnuEdadSup CONSTANT NUMBER := 60; --daLDC_PARAREPE.fnuGetPAREVANU('PERSEC_EDAD_SUP',NULL);
    cnuEdadInf CONSTANT NUMBER := 54; --daLDC_PARAREPE.fnuGetPAREVANU('PERSEC_EDAD_INFER',NULL);
  
    nuEdadProducto NUMBER;
  
    nuTipoSuspension PR_PROD_SUSPENSION.suspension_type_id%type;
  
    nuError NUMBER;
    sbError VARCHAR2(4000);
  
    CURSOR cuTipoSuspension IS
      SELECT SUSPENSION_TYPE_ID
        FROM (SELECT *
                FROM PR_PROD_SUSPENSION
               WHERE PRODUCT_ID = inuProducto
                 AND ACTIVE = 'Y'
               ORDER BY register_date desc)
       WHERE rownum = 1;
  
  BEGIN
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbINICIO);
  
    pCarggtbTiSuGenePersecRepa;
  
    --nuEdadProducto := ldc_getedadrp(inuProducto);
  
    select /*nuMesesCert */
     60 - months_between(trunc(to_date(plazo_maximo), 'MONTH'),
                         trunc(sysdate, 'MONTH'))
      into nuEdadProducto
      from LDC_PLAZOS_CERT
     where id_producto = inuProducto;
  
    Traza('nuEdadProducto|' || nuEdadProducto);
    Traza('cnuEdadSup|' || cnuEdadSup);
  
    IF nuEdadProducto > cnuEdadSup THEN
    
      sbPermiteRegistroAutoRec := 'Y';
    
    ELSE
    
      Traza('cnuEdadInf|' || cnuEdadInf);
    
      IF nuEdadProducto >= cnuEdadInf AND nuEdadProducto <= cnuEdadSup THEN
      
        OPEN cuTipoSuspension;
        FETCH cuTipoSuspension
          INTO nuTipoSuspension;
        CLOSE cuTipoSuspension;
      
        Traza('nuTipoSuspension|' || nuTipoSuspension);
      
        IF gtbTiSuGeneraPersecRepa.exists(nuTipoSuspension) THEN
        
          Traza('Cumple gtbTiSuGeneraPersecRepa.exists(nuTipoSuspension)');
        
          sbPermiteRegistroAutoRec := 'Y';
        
        END IF;
      
      END IF;
    
    END IF;
  
    Traza('sbPermiteRegistroAutoRec|' || sbPermiteRegistroAutoRec);
  
    Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN);
  
    RETURN sbPermiteRegistroAutoRec;
  
  EXCEPTION
    --        WHEN pkg_error.Controlled_Error THEN
    --            Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERC);
    --            --pkg_Error.getError(nuError,sbError);        
    --            Traza('sbError => ' || sbError, csbNivelTraza );
    --            RAISE; /*RAISE pkg_error.Controlled_Error;*/
    WHEN OTHERS THEN
      --Traza(csbMetodo, csbNivelTraza, pkg_traza.csbFIN_ERR);          
      ----pkg_error.setError;
      ----pkg_Error.getError(nuError,sbError);
      Traza('sbError => ' || sqlerrm, csbNivelTraza);
      RAISE;
  END fsbPermiteRegistroAutoRec;

BEGIN

  DBMS_OUTPUT.ENABLE(10000000000000);
  /*ut_trace.Init;
  ut_trace.SetOutPut(ut_trace.cnuTRACE_DBMS_OUTPUT);
  ut_trace.SetLevel(99);*/

  gnuToleranciaDif := CASE nuProceso
                        WHEN cnuLDC_PROCAUTORECO THEN
                         cnuTOLEREANCIA_DIF
                        ELSE
                         cnuTOLEREANCIA_DIFSN
                      END;
  nuPaso           := 0;

  inCiclo        := nvl(inuCICLO, -1);
  inDepartamento := nvl(inuDepartamento, -1);
  inLocalidad    := nvl(inuLocalidad, -1);

  nuPaso := 1;

  OPEN culdc_Proceso(inuProceso);
  FETCH culdc_Proceso
    INTO rcldc_Proceso;
  CLOSE culdc_Proceso;

  sbRecipients := rcldc_Proceso.EMAIL;
  Traza('Correo: ' || sbRecipients, 10);

  nuPaso := 14;

  IF rcldc_Proceso.ESTADOCORTE IS NOT NULL THEN
    SBESTADOCORTE := rcldc_Proceso.ESTADOCORTE;
  ELSE
    SBESTADOCORTE := '-1';
  END IF;
  Traza('Estado Corte: ' || SBESTADOCORTE, 10);

  nuPaso := 15;

  IF rcldc_Proceso.ESTADOPRODUCTO IS NOT NULL THEN
    SBESTADOPRODUCTO := rcldc_Proceso.ESTADOPRODUCTO;
  ELSE
    SBESTADOPRODUCTO := '-1';
  END IF;
  Traza('Estado Producto: ' || SBESTADOPRODUCTO, 10);

  nuPaso := 16;

  IF (rcldc_Proceso.SUSPENSION_TYPES IS NOT NULL) THEN
    SBTIPOSUSPENSION := rcldc_Proceso.SUSPENSION_TYPES;
  ELSE
    SBTIPOSUSPENSION := '-1';
  END IF;
  Traza('Tipo suspension: ' || SBTIPOSUSPENSION, 10);

  nuPaso := 17;

  FOR rgProd IN cuProd LOOP
  
    Traza('----------------------', 10);
    Traza('Producto|' || rgProd.Product_Id, 10);

    Traza('Valida Autoreconectado:' || fnuGetValidaAuto(rgProd.Product_Id, nuProceso), 10);
  
    IF /*LDC_PKGENEORDEAUTORECO.*/
     fnuGetValidaAuto(rgProd.Product_Id, nuProceso) = 0 THEN
    
      rcproductossuspendidosauto := NULL;
    
      nuPaso := 21;
    
      Traza('cuproductossuspendidosauto' , 10);
      Traza('Ciclo: ' || inCiclo, 10);
      Traza('Proceso: ' || nuProceso, 10);
      Traza('Estado Corte: ' || SBESTADOCORTE, 10);
      Traza('Estado Producto: ' || SBESTADOPRODUCTO, 10);
      Traza('Tipo Suspension: ' || SBTIPOSUSPENSION, 10);
      Traza('Departamento: ' || inDepartamento, 10);
      Traza('Localidad: ' || inLocalidad, 10);
      Traza('Producto: ' || rgProd.Product_Id, 10);

      OPEN cuproductossuspendidosauto(inCiclo,
                                      nuProceso,
                                      SBESTADOCORTE,
                                      SBESTADOPRODUCTO,
                                      SBTIPOSUSPENSION,
                                      inDepartamento,
                                      inLocalidad,
                                      rgProd.Product_Id --tbProdGas(indPrGa)
                                      );
    
      FETCH cuproductossuspendidosauto
        INTO rcproductossuspendidosauto;
      CLOSE cuproductossuspendidosauto;
    
      IF rcproductossuspendidosauto.sesunuse IS NOT NULL THEN
      
        Traza('Producto OK en cuproductossuspendidosauto');
      
        nuPaso := 22;
      
        dfFechaLega     := NULL;
        nuUltimaLectura := NULL;
        nuOrdenSusp     := NULL;
        nuTitrSusp      := NULL;
        nuLectSusp      := null;
        numarcaprod     := NULL;
        rgLecturaProd   := NULL;
      
        -- Obtiene datos del producto a procesar
        nuNumesusc   := rcproductossuspendidosauto.sesususc;
        nuNumeServ   := rcproductossuspendidosauto.sesunuse;
        nuServEsco   := rcproductossuspendidosauto.sesuesco;
        nuciclo      := rcproductossuspendidosauto.sesucicl;
        nuORD_ACT_ID := rcproductossuspendidosauto.SUSPEN_ORD_ACT_ID;
        nuDepaProd   := rcproductossuspendidosauto.depa;
        nuLocaProd   := rcproductossuspendidosauto.loca;
        nuCicloCons  := rcproductossuspendidosauto.sesucicl;
      
        nuConta     := 0;
        sumaConsumo := 0;
        sw          := 0;
      
        -- busca la fecha de lectura
        open cuMaximaLectura(nuNumeServ, inuProceso);
        fetch cuMaximaLectura
          into dfFechaLega, nuUltimaLectura, nuOrdenSusp, nuTitrSusp;
        close cuMaximaLectura;
      
        Traza('inuProceso|' || inuProceso, 10);
        Traza('dfFechaLega|' || dfFechaLega, 10);
        Traza('nuUltimaLectura|' || nuUltimaLectura, 10);
        Traza('nuOrdenSusp|' || nuOrdenSusp, 10);
        Traza('nuTitrSusp|' || nuTitrSusp, 10);
      
        nuPaso := 23;
      
        --si es autoreconectado se realiza e cargue de los demas datos
        nuLectSusp := nuUltimaLectura;
      
        OPEN cuDatosProd;
        FETCH cuDatosProd
          INTO rgdatosProd;
        CLOSE cuDatosProd;
      
        OPEN cuConsuLectfact(dfFechaLega); --200-2611
        FETCH cuConsuLectfact
          INTO rgLecturaProd;
        CLOSE cuConsuLectfact;
      
        OPEN cuMarcaProd;
        FETCH cuMarcaProd
          INTO numarcaprod;
        CLOSE cuMarcaProd;
      
        nuPaso := 24;
      
        Traza('numarcaprod|' || numarcaprod, 10);
        Traza('dfFechaLega|' || dfFechaLega, 10);
        Traza('SBESTADOCORTE|' || SBESTADOCORTE, 10);
        Traza('SBESTADOPRODUCTO|' || SBESTADOPRODUCTO, 10);
      
        --PRESECUSION PARA LOS SERVICIOS CON EL ESTADO DEL PRODCUTO
        if dfFechaLega is not null AND SBESTADOPRODUCTO <> '-1' then
          Traza('PRESECUSION PARA LOS SERVICIOS CON EL ESTADO DEL PRODCUTO',
                10);
        
          nuPaso := 25;
        
          --sb200216 :=  '2. FALSE';
          --Validacion Original de EFIGAS
          if (nuUltimaLectura > add_cons_tope) then
            sbmarca := 'N';
          else
            sbmarca := 'S';
          end if;
        
          Traza('nuLectSusp|' || nuLectSusp, 10);
          Traza('rgLecturaProd.lectactu|' || rgLecturaProd.lectactu, 10);
          Traza('gnuToleranciaDif|' || gnuToleranciaDif, 10);
        
          if abs(nuLectSusp - rgLecturaProd.lectactu) > gnuToleranciaDif AND
             rgLecturaProd.lectactu IS NOT NULL THEN
            sbRegistra := 'S';
          else
            sbRegistra := 'N';
          end if;
        
          nuActivity  :=  /*pkg_bcordenes.*/
           fnuObtieneItemActividad(nuORD_ACT_ID);
          nuDeudaCorr := null; --gc_bodebtmanagement.fnugetdebtbyprod(nuNumeServ); -- Deuda Corriente (Vencida y No vencida)
          nuDeudaDife := NULL; --gc_bodebtmanagement.fnugetdefdebtbyprod(nuNumeServ); -- Deuda Diferida
          nuSaldoTot  := (nvl(nuDeudaCorr, 0) + nvl(nuDeudaDife, 0));
        
          nuPaso := 26;
        
          NUACTIV_GENERA := NULL;
          NUACTIV_GENERA := fnuGetActividadgenerarAuto(inuProceso,
                                                       nuActivity,
                                                       numarcaprod);
        
          Traza('NUACTIV_GENERA|' || NUACTIV_GENERA, 10);
          Traza('sbRegistra|' || sbRegistra, 10);
          Traza('nuNumeServ|' || nuNumeServ, 10);
          Traza('nuServEsCo|' || nuServEsCo, 10);
          Traza('nuCicloCons|' || nuCicloCons, 10);
          Traza('fsbPermiteRegistroAutoRec(nuNumeServ)|' ||
                fsbPermiteRegistroAutoRec(nuNumeServ),
                10);
          Traza('LDC_PKGENEORDEAUTORECO.fsbVolFactMayToler|' || /*LDC_PKGENEORDEAUTORECO.*/
                fsbVolFactMayToler(nuNumeServ,
                                   nuServEsCo,
                                   dfFechaLega,
                                   nuCicloCons),
                10);
        
          IF nvl(NUACTIV_GENERA, 0) > 0 THEN
          
            IF sbRegistra = 'S' THEN
              --200-2611
            
              IF INSTR(',' || csbPROCAUTORECO_SN || ',',
                       ',' || inuProceso || ',') > 0 OR
                 fsbPermiteRegistroAutoRec(nuNumeServ) = 'Y' THEN
              
                IF /*LDC_PKGENEORDEAUTORECO.*/
                 fsbVolFactMayToler(nuNumeServ,
                                    nuServEsCo,
                                    dfFechaLega,
                                    nuCicloCons) IN ('S', 'X') THEN
                
                  nuPaso := 27;
                
                  Traza('INGRESA REGISTRO EN LDC_SUSP_AUTORECO' ||
                        sbRegistra,
                        10);
                
                  NUCantiReg := NUCantiReg + 1;
                
                END IF;
              
              END IF;
            
            END IF; --200-2611
          
          end if; -- nvl(NUACTIV_GENERA,0) > 0
        
        END IF; -- FIN PSERSUCUCION PARA SERVICIOS CON ESTADO DE CARTERA
      
      ELSE
      
        Traza('Producto NOK en cuproductossuspendidosauto');
      
      END IF; -- fin for
    
    ELSE
    
      Traza('No cumple LDC_PKGENEORDEAUTORECO.fnuGetValidaAuto', 20);
    
    END IF;
  
  END LOOP;

END;
/
