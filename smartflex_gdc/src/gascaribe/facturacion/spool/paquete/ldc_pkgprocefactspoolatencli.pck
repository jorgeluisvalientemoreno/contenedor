create or replace PACKAGE ldc_pkgprocefactspoolatencli IS
/*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolatencli
  Descripcion    : Paquete para acoplar los procesos de atencion al cliente
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 18/MAR/2022

*******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------
 glCupon_Cupon_id        ld_cupon_causal.cuponume%TYPE := NULL;
 glCausal_Cupon_id       ld_cupon_causal.causal_id%TYPE := NULL;
 glPackage_type_Cupon_id NUMBER := 0;
 glPackage_Cupon_id      ld_cupon_causal.package_id%TYPE := NULL;
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE rfdatosgenerales
/*******************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosGenerales
  Descripcion :   Obtiene los datos generales de una factura
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
********************************************************************************************/
(
 sbFactcodi  ge_boInstanceControl.stysbValue
,sbFactsusc  ge_boInstanceControl.stysbValue
,blnregulado BOOLEAN
,orfcursor   OUT constants_per.tyRefCursor
);
------------------------------------------------------------------------------------------------------------------------

PROCEDURE RfProteccion_Datos
/**********************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfProteccion_Datos
  Descripcion    : Servicio para retonar si el funcionario tiene o no la solciitud de proteccion de
                   datos activo en OSF
  Autor          : Jorge Valiente

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna caracter
                               S SI tiene proteccion de datos activo.
                               N NO tiene proteccion de datos activo.

  Fecha             Autor             Modificacion
  =========       =========           ====================
**********************************************************************************************************/
(
  sbFactsusc ge_boInstanceControl.stysbValue
 ,orfcursor OUT constants_per.tyRefCursor
);
------------------------------------------------------------------------------------------------------------------------

END ldc_pkgprocefactspoolatencli;
/
create or replace PACKAGE BODY ldc_pkgprocefactspoolatencli IS

    csbNOMPKG            CONSTANT VARCHAR2(32)       := $$PLSQL_UNIT||'.';--constante nombre del paquete
    csbNivelTraza        CONSTANT NUMBER(2)          := pkg_traza.cnuNivelTrzDef;--Nivel de traza para este paquete.

/*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolatencli
  Descripcion    : Paquete para acoplar los procesos de atencion al cliente
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 18/MAR/2022

*******************************************************************************************************/
--------------------------------------------------------------------------------------------------------------------------------------
PROCEDURE RfDatosGenerales(
                           sbFactcodi ge_boInstanceControl.stysbValue
                          ,sbFactsusc   ge_boInstanceControl.stysbValue
                          ,blnregulado  BOOLEAN
                          ,orfcursor    OUT constants_per.tyRefCursor
                          ) IS
/*******************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   RfDatosGenerales
  Descripcion :   Obtiene los datos generales de una factura
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  13-12-2023          felipe.valencia     OSF-1939: Se modifica el cursor de regulados
                                          para cambiar el calculo de la fecga de suspensión
                                          y cambio por estandares
  26/04/2023          LJLB               OSF-1056: se modifica campos para no regulado ciclo, uso y localidad
  11-11-2014           ggamarra            Creacion

********************************************************************************************/
 nucausaldecobro NUMBER := 0;
 sbCuponume      NUMBER;
 csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'RfDatosGenerales';
    sbError             VARCHAR2(4000);
    nuError             NUMBER;

 CURSOR cucausaldecobro(nucausal_id NUMBER) IS
  SELECT COUNT(1)
    FROM dual
   WHERE nucausal_id IN
             (SELECT to_number(regexp_substr(dald_parameter.fsbgetvalue_chain('CAUSALES_COBRO_DUPLICADO',NULL),
                                           '[^,]+',
                                           1,
                                           LEVEL)) AS causales
              FROM dual
            CONNECT BY regexp_substr(dald_parameter.fsbgetvalue_chain('CAUSALES_COBRO_DUPLICADO',NULL), '[^,]+', 1, LEVEL) IS NOT NULL);

 rcld_cupon_causal   dald_cupon_causal.styld_cupon_causal;
 nuproductoprincipal servsusc.sesunuse%TYPE;
 sbusonoresidencial  VARCHAR2(50) := dald_parameter.fsbgetvalue_chain('LDC_USOSERV',NULL); -- se almacena valor no residencial
BEGIN
  pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 -- Obtiene el cupon instanciado
 sbcuponume       := pkbobillprintheaderrules.fsbgetcoupon;
 glCupon_Cupon_id := sbCuponume;
 pkg_traza.trace('-- PASO 3. [] RfDatosGenerales sbFactcodi: ' ||sbFactcodi, pkg_traza.cnuNivelTrzDef);
 pkg_traza.trace('-- PASO 4. [] RfDatosGenerales sbPackage_type_id: ' ||glPackage_type_Cupon_id, pkg_traza.cnuNivelTrzDef);
 pkg_traza.trace('-- PASO 5. [] RfDatosGenerales sbCausal_id: ' ||glCausal_Cupon_id, pkg_traza.cnuNivelTrzDef);
 -- Si se genero en la solicitud de Estado de Cuenta, adicione el cobro por duplicado.
 IF glPackage_type_Cupon_id = 100006 THEN
    pkg_traza.trace('-- PASO 6.[] glPackage_type_Cupon_id: ' ||glPackage_type_Cupon_id, pkg_traza.cnuNivelTrzDef);
    -- Obtiene si la causal genera cobro.
   OPEN cucausaldecobro(glCausal_Cupon_id);
  FETCH cucausaldecobro INTO nucausaldecobro;
  CLOSE cucausaldecobro;
  pkg_traza.trace('-- PASO 7.[] nucausaldecobro: ' || nucausaldecobro, pkg_traza.cnuNivelTrzDef);
  IF nucausaldecobro != 0 THEN
    -- Inserta en la entidad LD_CUPON_CAUSAL
   rcld_cupon_causal.cuponume   := glcupon_cupon_id;
   rcld_cupon_causal.causal_id  := glcausal_cupon_id;
   rcld_cupon_causal.package_id := glpackage_cupon_id;
   dald_cupon_causal.insrecord(rcld_cupon_causal);
   pkg_traza.trace('-- PASO 8.[] Inserto en LD_CUPON_CAUSAL cuponume: ' ||glCupon_Cupon_id, pkg_traza.cnuNivelTrzDef);
  END IF;
 END IF;
nuProductoPrincipal := ldc_detallefact_gascaribe.fnuProductoPrincipal(sbFactsusc);
 IF NOT blnregulado THEN

  ---- Se abre el CURSOR a retornar.
  OPEN orfcursor FOR
   SELECT fc.factcodi factura
         ,to_char(
                  fc.factfege,
                  'DD/MON/YYYY',
                  'nls_date_language=spanish') fech_fact
         ,to_char(
                  to_date(pf.pefames || '-' || pf.pefaano,'MM-YYYY'),
                  'MON-YYYY',
                  'nls_date_language=spanish') mes_fact
         ,to_char(to_date(pktblperifact.fnugetmonth(fc.factpefa) || '-' ||
                  pktblperifact.fnugetyear(fc.factpefa),
                  'MM-YYYY'),
                  'MONTH YYYY',
                  'nls_date_language=spanish') periodo_fact
         ,  to_char(cc.cucofeve, 'DD/MM/YYYY') pago_hasta
         ,to_char(round(pc.pecsfecf - pc.pecsfeci)) dias_consumo
         ,b.susccodi contrato
         ,pkbobillprintheaderrules.fsbgetcoupon() cupon
         ,a.subscriber_name || ' ' || a.subs_last_name nombre
         ,ca.address_parsed direccion_cobro
         ,pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(ca.geograp_location_id) ||
               ' - ' || substr(pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(pkg_bcdirecciones.fnugetubicageopadre(ca.geograp_location_id)),
                               0,
                               3) localidad
         ,REPLACE(pktblcategori.fsbgetdescription(s.sesucate),'COMERCIAL',sbusonoresidencial) categoria
         ,TRIM(REPLACE(ldc_detallefact_gascaribe.FSBCategoriaUNICO(s.sesucate, s.sesusuca),'ESTRATO','')) estrato
         ,b.susccicl ciclo
         ,nvl(ldc_detallefact_gascaribe.fsbRutaReparto(inuProducto => s.sesunuse)
         ,ab.route_id ||daab_premise.fnugetconsecutive(ca.estate_number)) ruta
         ,ldc_detallefact_gascaribe.fnuMesesDeuda(fc.factsusc) meses_deuda
         ,cc.cucocodi num_control
         ,to_char(pc.pecsfeci, 'DD/MON') || ' - ' ||to_char(pc.pecsfecf, 'DD/MON') periodo_consumo
         ,to_char(b.suscsafa, 'FM999,999,999,990') saldo_favor
         ,NULL saldo_ant
         , to_char(pefaffpa, 'DD/MM/YYYY') fecha_suspension
         ,(
           SELECT SUM(cucovare + cucovrap)
             FROM cuencobr, servsusc
            WHERE cuconuse = sesunuse
              AND sesususc = fc.factsusc) valor_recl
         ,to_char(
                  (
                   SELECT ROUND(cupovalo)
                     FROM cupon
                    WHERE cuponume = pkbobillprintheaderrules.fsbgetcoupon()),'FM999,999,999,990') total_factura
         ,to_char(cc.cucofeve, 'DD/MM/YYYY') pago_sin_recargo
         ,NULL condicion_pago
         ,NULL identifica
         ,NULL servicio
     FROM factura  fc
         ,cuencobr cc
         ,suscripc b
         ,servsusc s
         ,ge_subscriber a
         ,perifact pf
         ,pericose pc
         ,ab_address ca
         ,ab_segments   ab
    WHERE fc.factcodi = sbFactcodi
      AND fc.factcodi = cc.cucofact
      AND fc.factsusc = b.susccodi
      AND b.susccodi = s.sesususc
      AND a.subscriber_id = b.suscclie
      AND pf.pefacodi = fc.factpefa
      AND pc.pecscons =
                        ldc_boformatofactura.fnuobtperconsumo(
                                                                   pf.pefacicl
                                                                  ,pf.pefacodi
                                                                  )
      AND b.susciddi = ca.address_id --(+)
      AND pf.pefacodi = fc.factpefa
      AND ca.segment_id = ab.segments_id
      AND sesunuse = nvl(nuProductoPrincipal, sesunuse)
      AND rownum = 1;
 ELSE
  OPEN orfcursor FOR
   SELECT fc.factcodi factura
         ,to_char(
                  fc.factfege,
                  'DD/MON/YYYY',
                  'nls_date_language=spanish') fech_fact
         ,to_char(to_date(pf.pefames || '-' || pf.pefaano, 'MM-YYYY'),
                       'MONTH YYYY',
                       'nls_date_language=spanish') mes_fact
         ,to_char(pc.pecsfeci, 'DD') || ' AL ' ||
               to_char(pc.pecsfecf, 'DD MONTH', 'nls_date_language=spanish') ||
               ' DEL ' || PEFAANO periodo_fact
         ,to_char(cc.cucofeve,
                          'DD/MON/YYYY',
                          'nls_date_language=spanish') pago_hasta
         ,NULL dias_consumo
         ,b.susccodi contrato
         ,pkbobillprintheaderrules.fsbgetcoupon() cupon
         ,a.subscriber_name || ' ' ||a.subs_last_name nombre
         ,ca.address_parsed  direccion_cobro
         ,pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(ca.geograp_location_id) ||
               ' - ' || substr(pkg_bcdirecciones.fsbGetDescripcionUbicaGeo(pkg_bcdirecciones.fnugetubicageopadre(ca.geograp_location_id)),
                               0,
                               3) localidad
         ,REPLACE(pktblcategori.fsbgetdescription(s.sesucate),'COMERCIAL',sbusonoresidencial) categoria
         ,ldc_detallefact_gascaribe.FSBCategoriaUNICO(s.sesucate, s.sesusuca) estrato
         ,b.susccicl ciclo
         ,NULL ruta
         ,NULL meses_deuda
         ,NULL num_control
         ,NULL periodo_consumo
         ,to_char(b.suscsafa, 'FM999,999,999,990') saldo_favor
         ,to_char(pkbobillprintheaderrules.fnugettotalpreviousbalance,'FM999,999,999,990') saldo_ant
         ,NULL fecha_suspension
         ,NULL valor_recl
         ,to_char(
                  (
                   SELECT round(cupovalo)
                     FROM cupon
                    WHERE cuponume = pkbobillprintheaderrules.fsbgetcoupon()
                  ),'FM999,999,999,990') total_factura
         ,to_char(cc.cucofeve, 'DD/MM/YYYY') pago_sin_recargo
         ,'CONTADO' condicion_pago
         ,a.identification identifica
         ,'NO REGULADO' servicio
     FROM factura       fc
         ,cuencobr      cc
         ,suscripc      b
         ,servsusc      s
         ,ge_subscriber a
         ,perifact      pf
         ,pericose      pc
         ,ab_address    ca
         ,ab_segments   ab
    WHERE fc.factcodi = sbFactcodi
      AND fc.factcodi = cc.cucofact
      AND fc.factsusc = b.susccodi
      AND b.susccodi = s.sesususc
      AND a.subscriber_id = b.suscclie
      AND pf.pefacodi = fc.factpefa
      AND pc.pecscons = ldc_boformatofactura.fnuobtperconsumo(
                                                                   pf.pefacicl
                                                                  ,pf.pefacodi
                                                                  )
      AND b.susciddi = ca.address_id --(+)
      AND pf.pefacodi = fc.factpefa
      AND ca.segment_id = ab.segments_id
       AND sesunuse = nvl(nuProductoPrincipal, sesunuse)
      AND rownum = 1;
 END IF;
 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
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
END rfdatosgenerales;
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE rfproteccion_datos(
                             sbFactsusc ge_boInstanceControl.stysbValue
                            ,orfcursor OUT constants_per.tyRefCursor
                            ) AS

csbMetodo  CONSTANT VARCHAR2(100) := csbNOMPKG||'rfproteccion_datos';
/**********************************************************************************************************
  Propiedad intelectual de PETI (c).

  Unidad         : RfProteccion_Datos
  Descripcion    : Servicio para retonar si el funcionario tiene o no la solciitud de proteccion de
                   datos activo en OSF
  Autor          : Jorge Valiente

  Parametros              Descripcion
  ============         ===================
  orfcursor            Retorna caracter
                               S SI tiene proteccion de datos activo.
                               N NO tiene proteccion de datos activo.

  Fecha             Autor             Modificacion
  =========       =========           ====================
**********************************************************************************************************/
 CURSOR cuprotecciondatos(
                          isbfactsusc         VARCHAR2,
                          inucod_tipsolprodat NUMBER
                         ) IS
  SELECT nvl(lpd.estado, 'N') proteccion_estado
        ,MAX(lpd.fecha_creacion) maxima_fecha
    FROM ldc_proteccion_datos lpd, mo_packages mp, suscripc s
   WHERE mp.package_id      = lpd.package_id
     AND mp.package_type_id = inucod_tipsolprodat
     AND mp.subscriber_id   = s.suscclie
     AND lpd.id_cliente     = mp.subscriber_id
     AND s.susccodi         = isbfactsusc
   GROUP BY nvl(lpd.estado, 'N');

  rfcuprotecciondatos cuprotecciondatos%ROWTYPE;
  sbproteccion_estado VARCHAR2(2000) := 'N';

  CURSOR cunuldpatameter(sbparametro VARCHAR2) IS
   SELECT nvl(lp.numeric_value,0) valor
     FROM ld_parameter lp
    WHERE lp.parameter_id = sbParametro;

  rfcunuldpatameter cunuldpatameter%ROWTYPE;
  nucod_tip_sol_pro_dat NUMBER := 100265;
BEGIN
 -- Verifica si el cliente es industria no regulada
 pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
 --CASO 200-2479
  OPEN cunuldpatameter('COD_TIP_SOL_PRO_DAT');
 FETCH cunuldpatameter INTO rfcunuldpatameter;
    IF cunuldpatameter%FOUND THEN
     IF rfcunuldpatameter.valor IS NOT NULL THEN
        nucod_tip_sol_pro_dat := rfcunuldpatameter.valor;
     END IF;
    END IF;
 CLOSE cunuldpatameter;
    --Fin CASO 200-2479
  OPEN cuprotecciondatos(sbfactsusc,nucod_tip_sol_pro_dat);
 FETCH cuprotecciondatos INTO rfcuprotecciondatos;
    IF cuprotecciondatos%FOUND THEN
     IF rfcuprotecciondatos.proteccion_estado IS NOT NULL THEN
        sbproteccion_estado := rfcuprotecciondatos.proteccion_estado;
     END IF;
    END IF;
 CLOSE cuprotecciondatos;

 OPEN orfcursor FOR
  SELECT 0 visible
        ,NULL impreso
        ,sbproteccion_estado proteccion_estado
    FROM dual;
    pkg_traza.trace(csbMetodo, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
 WHEN pkg_Error.controlled_error THEN
  OPEN orfcursor FOR
   SELECT 0, NULL FROM dual;
 WHEN OTHERS THEN
  OPEN orfcursor FOR
   SELECT 0, NULL FROM dual;
END rfproteccion_datos;
-----------------------------------------------------------------------------------------------------------------------
END ldc_pkgprocefactspoolatencli;
/
