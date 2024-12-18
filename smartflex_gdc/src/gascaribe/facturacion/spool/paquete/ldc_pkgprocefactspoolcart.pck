CREATE OR REPLACE PACKAGE ldc_pkgprocefactspoolcart IS
/*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolcart
  Descripcion    : Paquete para acoplar los procesos de cartera
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 11/07/2022

*******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE rfgetvalrates
/********************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   rfGetValRates
  Descripcion :   Obtiene los valores de las tasas de cambio
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
********************************************************************************************************/
(
 blNoRegulada BOOLEAN
,orfcursor OUT constants.tyRefCursor
);

-----------------------------------------------------------------------------------------------------------------------
 
PROCEDURE RfDatosFinanEspecial
/*********************************************************************************************************
    Propiedad intelectual de GDC (c).

    Unidad         : RfDatosFinanEspecial
    Descripcion    : proceso que devuelve si un producto tiene financiacion de cartera especiales
    Ticket         : 874

    Autor          : Luis Javier Lopez Barrios / Horbath

    Parametros           Descripcion
    ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
********************************************************************************************************/
(
 sbFactura ge_boInstanceControl.stysbValue
,orfcursor OUT constants.tyRefCursor
);
-----------------------------------------------------------------------------------------------------------------------

END ldc_pkgprocefactspoolcart;
/
CREATE OR REPLACE PACKAGE BODY ldc_pkgprocefactspoolcart IS
/*******************************************************************************************************
  Propiedad intelectual de Gases del Caribe S.A (c).

  Unidad         : ldc_pkgprocefactspoolcart
  Descripcion    : Paquete para acoplar los procesos de cartera
                   que se utilizaran en el spool de facturaci?n
  Autor          : John Jairo Jimenez Marimon
  Fecha          : 11/07/2022

*******************************************************************************************************/
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE rfGetValRates(
                        blNoRegulada BOOLEAN
                       ,orfcursor OUT constants.tyRefCursor
                       ) AS
/********************************************************************************************************
  Propiedad Intelectual de PETI

  Funcion     :   rfGetValRates
  Descripcion :   Obtiene los valores de las tasas de cambio
  Autor       :   Gabriel Gamarra - Horbath Technologies

  Historia de Modificaciones
    Fecha               Autor                Modificacion
  =========           =========          ====================
  11-11-2014           ggamarra            Creacion
********************************************************************************************************/  
 sbTP         VARCHAR2(50);
 sbTU         VARCHAR2(50);

 CURSOR cuMoneValo(sbMone valomone.vamotmde%TYPE) IS
  SELECT vamovalo
    FROM (
          SELECT vamovalo
            FROM valomone
           WHERE vamotmor = 'PC'
             AND vamotmde = sbMone
           ORDER BY vamoffvi DESC
         )
   WHERE rownum = 1;
BEGIN
 -- Verifica si el cliente es industria no regulada
 IF blNoRegulada THEN
   OPEN cuMoneValo('TU');
    IF cuMoneValo%NOTFOUND THEN
       sbTU := 0;
    ELSE
     FETCH cuMoneValo INTO sbTU;
    END IF;
  CLOSE cuMoneValo;
  OPEN cuMoneValo('TP');
   IF cuMoneValo%NOTFOUND THEN
      sbTP := 0;
   ELSE
    FETCH cuMoneValo INTO sbTP;
   END IF;
  CLOSE cuMoneValo;
  OPEN orfcursor FOR
   SELECT 'Tasa Ultimo dia Mes   $' || sbTU tasa_ultima,
          'Tasa Prom. Mes        $' || sbTP tasa_promedio
    FROM dual;
 ELSE
  OPEN orfcursor FOR
   SELECT NULL tasa_ultima, NULL tasa_promedio FROM dual;
 END IF;
EXCEPTION
 WHEN ex.controlled_error THEN
    RAISE ex.controlled_error;
 WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
END rfgetvalrates;
-----------------------------------------------------------------------------------------------------------------------

PROCEDURE RfDatosFinanEspecial(
                               sbFactura ge_boInstanceControl.stysbValue
                              ,orfcursor OUT constants.tyRefCursor
                              ) Is
 /************************************************************************************************
  Propiedad intelectual de GDC (c).

  Unidad         : RfDatosFinanEspecial
  Descripcion    : proceso que devuelve si un producto tiene financiacion de cartera especiales
  Ticket         : 874

  Autor          : Luis Javier Lopez Barrios / Horbath

  Parametros           Descripcion
  ============         ===================


    Fecha             Autor             Modificacion
    =========       =========           ====================
**************************************************************************************************/
 sbDatos   VARCHAR2(2);
 CURSOR cugetExisteFinanEspeci IS
  SELECT 'SI'
    FROM cargos, cuencobr, diferido, LDC_CONFPLCAES
   WHERE cucofact = to_number(sbFactura)
     AND cargcuco = cucocodi
     AND cargcaca = 51
     AND cargdoso = 'DF-'||difecodi
     AND difenuse = cuconuse
     AND difepldi = COPCORIG;
BEGIN
 -- Obtiene el identificador del contrato instanciado
  OPEN cugetExisteFinanEspeci;
 FETCH cugetExisteFinanEspeci INTO sbDatos;
  IF cugetExisteFinanEspeci%NOTFOUND THEN
    sbDatos := 'NO';
  END IF;
 CLOSE cugetExisteFinanEspeci;
 OPEN orfcursor FOR
  SELECT sbdatos finaespe
    FROM dual;
EXCEPTION
 WHEN ex.controlled_error THEN
     RAISE ex.controlled_error;
 WHEN OTHERS THEN
    errors.seterror;
    RAISE ex.controlled_error;
END rfdatosfinanespecial;
----------------------------------------------------------------------------------------------------------------------

END ldc_pkgprocefactspoolcart;
/
GRANT EXECUTE ON ldc_pkgprocefactspoolcart TO SYSTEM_OBJ_PRIVS_ROLE;