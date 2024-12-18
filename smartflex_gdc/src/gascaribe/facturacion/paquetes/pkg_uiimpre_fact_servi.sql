CREATE OR REPLACE PACKAGE PKG_UIIMPRE_FACT_SERVI IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_UIIMPRE_FACT_SERVI
    Descripcion     : Paquete para generar factura no recurrente para el PB PBIFSE

    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 23-01-2024

    Modificaciones
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  PROCEDURE prcDatosFactura(orfcursor Out constants_per.tyRefCursor);

  PROCEDURE prcDetalleFactura(orfcursor OUT constants_per.tyRefCursor);
  
  PROCEDURE prcDetalleIva(orfcursor OUT constants_per.tyRefCursor);

  PROCEDURE prcTotalFactura(orfcursor OUT constants_per.tyRefCursor);
  
END PKG_UIIMPRE_FACT_SERVI;
/
CREATE OR REPLACE PACKAGE BODY PKG_UIIMPRE_FACT_SERVI IS

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

  PROCEDURE prcDatosFactura(orfcursor Out constants_per.tyRefCursor) IS

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

    sbFactcodi varchar2(20); --ge_boInstanceControl.stysbValue;

    nuError NUMBER;
    sberror VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    --Obtener datos instanciados de lso servicios utilizados en la forma PBIFSE
    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);

    pkg_traza.trace('Factura: ' || sbFactcodi, pkg_traza.cnuNivelTrzDef);

    PKG_BOIMPRE_FACT_SERVI.prcDatosFactura(sbFactcodi, orfcursor);

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

  PROCEDURE prcDetalleFactura(orfcursor OUT constants_per.tyRefCursor) IS

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

    sbFactcodi varchar2(20);

    nuError NUMBER;
    sberror VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);

    pkg_traza.trace('Factura: ' || sbFactcodi, pkg_traza.cnuNivelTrzDef);

    PKG_BOIMPRE_FACT_SERVI.prcDetalleFactura(sbFactcodi, orfcursor);

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
  
  PROCEDURE prcDetalleIva(orfcursor OUT constants_per.tyRefCursor) IS

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

    sbFactcodi varchar2(20);

    nuError NUMBER;
    sberror VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);

    pkg_traza.trace('Factura: ' || sbFactcodi, pkg_traza.cnuNivelTrzDef);

    PKG_BOIMPRE_FACT_SERVI.prcDetalleIva(sbFactcodi, orfcursor);

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

  PROCEDURE prcTotalFactura(orfcursor OUT constants_per.tyRefCursor) IS

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

    sbFactcodi varchar2(20);

    nuError NUMBER;
    sberror VARCHAR2(4000);

  BEGIN

    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    GE_BOINSTANCECONTROL.GETGLOBALATTRIBUTE('FACTCODI', sbFactcodi);

    PKG_BOIMPRE_FACT_SERVI.prcTotalFactura(sbFactcodi, orfcursor);

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

END PKG_UIIMPRE_FACT_SERVI;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_UIIMPRE_FACT_SERVI', 'OPEN');
END;
/

