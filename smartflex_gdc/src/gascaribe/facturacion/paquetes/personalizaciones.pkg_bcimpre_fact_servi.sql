CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BCIMPRE_FACT_SERVI IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BCIMPRE_FACT_SERVI
    Descripcion     : Paquete para generar factura no recurrente para el PB PBIFSE
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 28-12-2023
  
    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  sbConcepto_Iva varchar2(4000) := pkg_parametros.fsbGetValorCadena('CONCEPTO_IVA_FACTURA_SERVICIO_PBIFSE');

  PROCEDURE prcDatosFactura(isbFactcodi In varchar2,
                            orfcursor   Out constants_per.tyRefCursor);

  PROCEDURE prcDetalleIva(isbFactcodi In varchar2,
                          orfcursor   Out constants_per.tyRefCursor);

  PROCEDURE prcDetalleFactura(isbFactcodi In varchar2,
                              orfcursor   Out constants_per.tyRefCursor);

  PROCEDURE prcTotalFactura(isbFactcodi In varchar2,
                            orfcursor   Out constants_per.tyRefCursor);

END PKG_BCIMPRE_FACT_SERVI;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BCIMPRE_FACT_SERVI IS

  -- Constantes para el control de la traza
  csbSP_NAME CONSTANT VARCHAR2(35) := $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion VARCHAR2(15) := 'OSF-1999';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : fsbVersion
      Descripcion     : Retona DATA de usuarios
      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 28-12-2023
    
      Modificaciones  :
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prcDatosFactura(isbFactcodi In varchar2,
                            orfcursor   Out constants_per.tyRefCursor) IS
  
    /*****************************************************************
    Propiedad intelectual de Gases del CAribe (c).
    
    Unidad         : prcDatosFactura
    Descripcion    : procedimiento para obtener todos los datos asociados a la venta de servico de gas.
    Autor          : Jorge Valiente
    Fecha          : 29/12/2023
    
    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
  
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.prcDatosFactura';
  
    nuError NUMBER;
    sberror VARCHAR2(4000);
  
    CURSOR cuDatos IS
      SELECT fc.factnufi CODIGO_FACTURA,
             To_Char(fc.factfege, 'dd/MON/yyyy HH24:MI:SS') FECHA_EXPEDICION,
             To_Char(cc.cucofeve, 'dd/MON/yyyy') FECHA_VENCIMIENTO,
             gs.subscriber_name || ' ' || gs.subs_last_name CLIENTE,
             gs.identification NIT_CLIENTE,
             (select gsc.subscriber_name || ' ' || gsc.subs_second_last_name
                from ge_subscriber gsc
               where gsc.subscriber_id = gs.contact_id) CONTACTO,
             aa.address_parsed DIRECCION,
             ggl.description CIUDAD,
             gs.e_mail CORREO,
             gs.phone TELEFONO
        FROM factura fc
       inner join cuencobr cc
          on fc.factcodi = cc.cucofact
       inner join suscripc b
          on fc.factsusc = b.susccodi
       inner join servsusc s
          on b.susccodi = s.sesususc
         AND cc.cuconuse = s.sesunuse
       inner join ge_subscriber gs
          on gs.subscriber_id = b.suscclie
       inner join ab_address aa
          on aa.address_id = b.susciddi
       inner join ge_geogra_location ggl
          on ggl.geograp_location_id = aa.geograp_location_id
       WHERE fc.factcodi = To_Number(isbFactcodi);
  
    rccuDatos cuDatos%ROWTYPE;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Factura: ' || isbFactcodi, pkg_traza.cnuNivelTrzDef);
  
    --Obtiene los datos principales
    OPEN cuDatos;
    FETCH cuDatos
      INTO rccuDatos;
    CLOSE cuDatos;
  
    pkg_traza.trace('Datos Extraidos de la Facuta',
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Numero Fiscal: ' || rccuDatos.Codigo_Factura,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Fecha Expedicion: ' || rccuDatos.Fecha_Expedicion,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Fecha Vencimiento: ' || rccuDatos.Fecha_Vencimiento,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Cliente: ' || rccuDatos.Cliente,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Nit_Cliente: ' || rccuDatos.Nit_Cliente,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Contacto: ' || rccuDatos.Contacto,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Direccion: ' || rccuDatos.Direccion,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Ciudad: ' || rccuDatos.Ciudad,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Correo: ' || rccuDatos.Correo,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Telefono: ' || rccuDatos.Telefono,
                    pkg_traza.cnuNivelTrzDef);
  
    OPEN orfcursor FOR
      SELECT rccuDatos.Codigo_Factura    Codigo_Factura,
             rccuDatos.Fecha_Expedicion  Fecha_Expedicion,
             rccuDatos.Fecha_Vencimiento Fecha_Vencimiento,
             rccuDatos.Cliente           Cliente,
             rccuDatos.Nit_Cliente       Nit_Cliente,
             rccuDatos.Contacto          Contacto,
             rccuDatos.Direccion         Direccion,
             rccuDatos.Ciudad            Ciudad,
             rccuDatos.Correo            Correo,
             rccuDatos.Telefono          Telefono
        FROM dual;
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END prcDatosFactura;

  PROCEDURE prcDetalleFactura(isbFactcodi In varchar2,
                              orfcursor   Out constants_per.tyRefCursor) IS
  
    /*****************************************************************
    Propiedad intelectual de Sincecomp (c).
    
    Unidad         : prcDetalleFactura
    Descripcion    : procedimiento para obtener todos los detalles de la factura.
    Autor          : Jorge Valiente
    Fecha          : 02/01/2024
    
    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    
    ******************************************************************/
  
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.prcDetalleFactura';
  
    nuError NUMBER;
    sberror VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Factura: ' || isbFactcodi, pkg_traza.cnuNivelTrzDef);
  
    OPEN orfcursor FOR
      SELECT CON.CONCCODI CODIGO,
             CON.CONCDESC CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) VALOR,
             (Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL
        FROM cargos c
       inner join concepto con
          on conccodi = c.cargconc
       inner join cuencobr cc
          on cc.cucocodi = c.cargcuco
       inner join factura f
          on f.factcodi = cc.cucofact
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         and f.factcodi = To_Number(isbFactcodi)
         and c.cargconc not in
             (SELECT to_number(regexp_substr(sbConcepto_Iva,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS iva
                FROM dual
              CONNECT BY regexp_substr(sbConcepto_Iva, '[^,]+', 1, LEVEL) IS NOT NULL);
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END prcDetalleFactura;

  PROCEDURE prcDetalleIva(isbFactcodi In varchar2,
                          orfcursor   Out constants_per.tyRefCursor) IS
  
    /*****************************************************************
    Propiedad intelectual de Sincecomp (c).
    
    Unidad         : prcDetalleIva
    Descripcion    : procedimiento para obtener todos los detalles de la factura.
    Autor          : Jorge Valiente
    Fecha          : 02/01/2024
    
    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    
    ******************************************************************/
  
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.prcDetalleIva';
  
    nuError NUMBER;
    sberror VARCHAR2(4000);
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    pkg_traza.trace('Factura: ' || isbFactcodi, pkg_traza.cnuNivelTrzDef);
  
    OPEN orfcursor FOR
      SELECT CON.CONCCODI CODIGO,
             CON.CONCDESC CONCEPTO,
             decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1)) CANTIDAD,
             sum(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO)) VALOR,
             sum(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                 decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL
        FROM cargos c
       inner join concepto con
          on conccodi = c.cargconc
       inner join cuencobr cc
          on cc.cucocodi = c.cargcuco
       inner join factura f
          on f.factcodi = cc.cucofact
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         and f.factcodi = To_Number(isbFactcodi)
         and c.cargconc in
             (SELECT to_number(regexp_substr(sbConcepto_Iva,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS iva
                FROM dual
              CONNECT BY regexp_substr(sbConcepto_Iva, '[^,]+', 1, LEVEL) IS NOT NULL)
    group by CON.CONCCODI, CON.CONCDESC, decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1));
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END prcDetalleIva;

  PROCEDURE prcTotalFactura(isbFactcodi In varchar2,
                            orfcursor   Out constants_per.tyRefCursor) IS
  
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.
    
    Unidad         : prcTotalFactura
    Descripcion    : procedimiento para obtener el total de la factura.
    Autor          : Jorge Valiente
    Fecha          : 03/01/2024
    
    Parametros              Descripcion
    ============         ===================
    orfcursor            Retorna los datos del detalle de la factura.
    
    Fecha             Autor             Modificacion
    =========       =========           ====================
    ******************************************************************/
  
    csbMT_NAME VARCHAR2(70) := csbSP_NAME || '.prcTotalFactura';
  
    nuError NUMBER;
    sberror VARCHAR2(4000);
  
    ---Total  Factura
    CURSOR cuTotalFactura IS
      SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                 decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_TOTAL_PAGAR
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(isbFactcodi)
         and c.cargconc not in
             (SELECT to_number(regexp_substr(sbConcepto_Iva,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS iva
                FROM dual
              CONNECT BY regexp_substr(sbConcepto_Iva, '[^,]+', 1, LEVEL) IS NOT NULL);
  
    rccuTotalFactura cuTotalFactura%ROWTYPE;
  
    ---Total  Iva
    CURSOR cuTotalIva IS
      SELECT SUM(Decode(c.cargsign, 'DB', c.CARGVALO, -c.CARGVALO) *
                 decode(nvl(C.CARGUNID, 1), 0, 1, nvl(C.CARGUNID, 1))) VALOR_IVA
        FROM open.cargos c, open.concepto, open.cuencobr cc, open.factura f
       WHERE c.cargtipr = 'A'
         AND c.cargsign IN ('DB', 'CR')
         AND conccodi = c.cargconc
         and cc.cucocodi = c.cargcuco
         AND f.factcodi = cc.cucofact
         and f.factcodi = To_Number(isbFactcodi)
         and c.cargconc in
             (SELECT to_number(regexp_substr(sbConcepto_Iva,
                                             '[^,]+',
                                             1,
                                             LEVEL)) AS iva
                FROM dual
              CONNECT BY regexp_substr(sbConcepto_Iva, '[^,]+', 1, LEVEL) IS NOT NULL);
  
    rccuTotalIva cuTotalIva%ROWTYPE;
  
  BEGIN
  
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);
  
    OPEN cuTotalFactura;
    FETCH cuTotalFactura
      INTO rccuTotalFactura;
    CLOSE cuTotalFactura;
  
    OPEN cuTotalIva;
    FETCH cuTotalIva
      INTO rccuTotalIva;
    CLOSE cuTotalIva;
  
    pkg_traza.trace('Valor Total Pagar: ' ||
                    rccuTotalFactura.Valor_Total_Pagar,
                    pkg_traza.cnuNivelTrzDef);
  
    pkg_traza.trace('Valor Iva: ' || rccuTotalIva.Valor_Iva,
                    pkg_traza.cnuNivelTrzDef);
  
    OPEN orfcursor FOR
      SELECT nvl(rccuTotalFactura.Valor_Total_Pagar, 0) Valor_Total_Pagar,
             nvl(rccuTotalIva.Valor_Iva, 0) Valor_Iva
        FROM dual;
  
    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('Error: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
    
  END prcTotalFactura;

END PKG_BCIMPRE_FACT_SERVI;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BCIMPRE_FACT_SERVI', 'PERSONALIZACIONES');
END;
/
