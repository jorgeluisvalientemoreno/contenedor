CREATE OR REPLACE PACKAGE PERSONALIZACIONES.PKG_BOIMPRE_FACT_SERVI IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : PKG_BOIMPRE_FACT_SERVI
    Descripcion     : Paquete para generar factura no recurrente para el PB PBIFSE
  
    Autor           : Jorge Luis Valiente Moreno
    Fecha           : 28-12-2023
  
    Parametros de Entrada
  
    Parametros de Salida
  
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/

  PROCEDURE prcImprimirFacturaEnServidor(inuFactura     NUMBER,
                                         isbRutaSistema VARCHAR2);

  PROCEDURE prcDatosFactura(isbFactcodi In varchar2,
                            orfcursor   Out constants_per.tyRefCursor);

  PROCEDURE prcDetalleFactura(isbFactcodi In varchar2,
                              orfcursor   Out constants_per.tyRefCursor);

  PROCEDURE prcDetalleIva(isbFactcodi In varchar2,
                          orfcursor   Out constants_per.tyRefCursor);

  PROCEDURE prcTotalFactura(isbFactcodi In varchar2,
                            orfcursor   Out constants_per.tyRefCursor);

END PKG_BOIMPRE_FACT_SERVI;
/
CREATE OR REPLACE PACKAGE BODY PERSONALIZACIONES.PKG_BOIMPRE_FACT_SERVI IS

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

  PROCEDURE prcImprimirFacturaEnServidor(inuFactura     NUMBER,
                                         isbRutaSistema VARCHAR2) IS
    /***************************************************************************
      Propiedad Intelectual de Gases del Caribe
      Programa        : prcImprimirFacturaEnServidor
      Descripcion     : proceso que genera PDF de la factura no recuirrente para PB

      Autor           : Jorge Luis Valiente Moreno
      Fecha           : 28-12-2023

      Parametros de Entrada
      inuConfexme      Codigo de CONFEXME para generar PDF
      isbRutaSistema   Ruta del sistema para generar el PDF

      Parametros de Salida

      Modificaciones  :
      =========================================================
      Autor       Fecha       Caso       Descripcion
    ***************************************************************************/
    -- Nombre de este m?todo
    csbMT_NAME VARCHAR2(105) := csbSP_NAME ||
                                '.prcImprimirFacturaEnServidor';

    onuErrorCode    number;
    osbErrorMessage varchar2(4000);

    --Variables para el FCED
    nuConfexmeId number; /* Codigo configuracion de extraccion y mezcla (configurado como parametro ) */
    --------------------------------

  BEGIN
    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    nuConfexmeId := pkg_parametros.fnuGetValorNumerico('CONFEXME_FACTURA_SERVICIO_PBIFSE');

    pkg_traza.trace('Factura: ' || inuFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Ruta Sistema: ' || isbRutaSistema,
                    pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('Confexme: ' || nuConfexmeId, pkg_traza.cnuNivelTrzDef);

    if (nuConfexmeId is null) then
      pkg_error.setErrorMessage(isbMsgErrr => 'No existe Codigo CONFEXME en el parametro CONFEXME_FACTURA_SERVICIO_PBIFSE');
    end if;

    PKG_BOIMPRESION_FACTURAS.prcImprimirFacturaEnServidor(nuConfexmeId,
                                                          inuFactura,
                                                          isbRutaSistema);

    pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('Error: ' || OsbErrorMessage,
                      pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME,
                      pkg_traza.cnuNivelTrzDef,
                      pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END prcImprimirFacturaEnServidor;

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

  BEGIN

    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    pkg_traza.trace('Factura: ' || isbFactcodi, pkg_traza.cnuNivelTrzDef);

    pkg_bcimpre_fact_servi.prcDatosFactura(isbFactcodi, orfcursor);

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

    pkg_bcimpre_fact_servi.prcDetalleFactura(isbFactcodi, orfcursor);

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

    pkg_bcimpre_fact_servi.prcDetalleIva(isbFactcodi, orfcursor);

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

  BEGIN

    pkg_traza.trace(csbMT_NAME,
                    pkg_traza.cnuNivelTrzDef,
                    pkg_traza.csbINICIO);

    pkg_traza.trace('Factura: ' || isbFactcodi, pkg_traza.cnuNivelTrzDef);

    pkg_bcimpre_fact_servi.prcTotalFactura(isbFactcodi, orfcursor);

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
  
END PKG_BOIMPRE_FACT_SERVI;
/

BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_BOIMPRE_FACT_SERVI', 'PERSONALIZACIONES');
END;
/
