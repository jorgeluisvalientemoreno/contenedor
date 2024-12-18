create or replace PACKAGE   personalizaciones.pkg_info_producto_desvpobl IS
   CURSOR cuGetRegistro( inuContrato    IN  info_producto_desvpobl.contrato%type,
                         inuPerioFact   IN  info_producto_desvpobl.periodo_facturacion%type,
                         inuPeriCose    IN  info_producto_desvpobl.periodo_consumo%type) IS
   SELECT  info_producto_desvpobl.*,
           info_producto_desvpobl.ROWID id_reg
   FROM info_producto_desvpobl
   WHERE info_producto_desvpobl.contrato = inuContrato
    AND info_producto_desvpobl.periodo_facturacion = inuPerioFact
    AND info_producto_desvpobl.periodo_consumo = DECODE(inuPeriCose, -1, info_producto_desvpobl.periodo_consumo, inuPeriCose )
    AND info_producto_desvpobl.estado = 'A';

   SUBTYPE styInfoProdDesvpobl IS cuGetRegistro%ROWTYPE;

   subtype styInfoProductoDesvpobl is  info_producto_desvpobl%rowtype;


   PROCEDURE prInsInfoProdDesvpobl( iregInfoProdDesvpobl IN  styInfoProductoDesvpobl,
                                    osbRowId             OUT  VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsInfoProdDesvpobl
    Descripcion     : proceso que inserta en la tabla de informacion de producto
                      del proceso de desviacion poblacional

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 20-03-2024

    Parametros de Entrada
      iregInfoProdDesvpobl        registro de informacion de producto con desviacion poblacional
    Parametros de Salida
      osbRowId     rowid del registro
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       20-03-2024   OSF-2494   Creacion
  ***************************************************************************/
  PROCEDURE prActCalifiProdDesvpobl(isbRowId         IN   VARCHAR2,
                                    inuCalificacion  IN   info_producto_desvpobl.calificacion%type);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActInfoProdDesvpobl
    Descripcion     : proceso que actualiza calificacion de la informacion de producto desvpobl

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 12-04-2024

    Parametros de Entrada
      isbRowId              id del rowid del registro actualizar
      inuCalificacion       codigo de la calificacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       12-04-2024   OSF-2494   Creacion
  ***************************************************************************/
  PROCEDURE prActEstadoProdDesvpobl(isbRowId     IN   VARCHAR2,
                                    isbEstado    IN   info_producto_desvpobl.estado%type);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActEstadoProdDesvpobl
    Descripcion     : proceso que actualiza estado de la informacion de producto desvpobl

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 12-04-2024

    Parametros de Entrada
      isbRowId              id del rowid del registro actualizar
      inuCalificacion       codigo de la calificacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       12-04-2024   OSF-2494   Creacion
  ***************************************************************************/

  FUNCTION frcGetInfoProdDesvpobl( inuContrato    IN  info_producto_desvpobl.contrato%type,
                                  inuPerioFact   IN  info_producto_desvpobl.periodo_facturacion%type,
                                  inuPeriCose    IN  info_producto_desvpobl.periodo_consumo%type default -1) RETURN styInfoProdDesvpobl;
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetInfoProdDesvpobl
    Descripcion     : funcion que devuelve infromacion de la informacion de producto desvpobl

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 12-04-2024

    Parametros de Entrada
      inuContrato           codigo del contrato
      inuPerioFact          periodo de facturacion
      inuPeriCose           periodo de consumo
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       12-04-2024   OSF-2494   Creacion
  ***************************************************************************/

END pkg_info_producto_desvpobl;  
/
create or replace PACKAGE BODY  personalizaciones.pkg_info_producto_desvpobl IS
  -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2494';
   nuError      NUMBER;
   sbError      VARCHAR2(4000);


  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      15-01-2024   OSF-2158    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prInsInfoProdDesvpobl( iregInfoProdDesvpobl IN   styInfoProductoDesvpobl,
                                   osbRowId             OUT  VARCHAR2 ) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsInfoProdDesvpobl
    Descripcion     : proceso que inserta en la tabla de informacion de producto
                      del proceso de desviacion poblacional

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 20-03-2024

    Parametros de Entrada
      iregFacturaEle        registro de factura electronica
    Parametros de Salida
      osbRowId              rowid del registro
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       20-03-2024   OSF-2494   Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsInfoProdDesvpobl';


  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' Producto => ' || iregInfoProdDesvpobl.producto, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' periodo_facturacion => ' || iregInfoProdDesvpobl.periodo_facturacion, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' periodo_consumo => ' || iregInfoProdDesvpobl.periodo_consumo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' consumo_actual => ' || iregInfoProdDesvpobl.consumo_actual, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' consumo_promedio => ' || iregInfoProdDesvpobl.consumo_promedio, pkg_traza.cnuNivelTrzDef);
     pkg_traza.trace(' desviacion_poblacional => ' || iregInfoProdDesvpobl.desviacion_poblacional, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' fecha_registro => ' || iregInfoProdDesvpobl.fecha_registro, pkg_traza.cnuNivelTrzDef);

    INSERT INTO info_producto_desvpobl( producto,
                                        contrato,
                                        periodo_facturacion,
                                        periodo_consumo,
                                        consumo_actual,
                                        consumo_promedio,
                                        desviacion_poblacional,
                                        tipo_desviacion,
                                        fecha_registro)
    VALUES (iregInfoProdDesvpobl.producto,
            iregInfoProdDesvpobl.contrato,
            iregInfoProdDesvpobl.periodo_facturacion,
            iregInfoProdDesvpobl.periodo_consumo,
            iregInfoProdDesvpobl.consumo_actual,
            iregInfoProdDesvpobl.consumo_promedio,
            iregInfoProdDesvpobl.desviacion_poblacional,
            iregInfoProdDesvpobl.tipo_desviacion,
            iregInfoProdDesvpobl.fecha_registro)
    RETURNING rowid INTO osbRowId;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE  pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE  pkg_error.CONTROLLED_ERROR;
  END prInsInfoProdDesvpobl;

  PROCEDURE prActCalifiProdDesvpobl(isbRowId         IN   VARCHAR2,
                                    inuCalificacion  IN   info_producto_desvpobl.calificacion%type) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActInfoProdDesvpobl
    Descripcion     : proceso que actualiza calificacion de la informacion de producto desvpobl

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 12-04-2024

    Parametros de Entrada
      isbRowId              id del rowid del registro actualizar
      inuCalificacion       codigo de la calificacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       12-04-2024   OSF-2494   Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActCalifiProdDesvpobl';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' isbRowId => ' || isbRowId, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuCalificacion => ' || inuCalificacion, pkg_traza.cnuNivelTrzDef);
    UPDATE info_producto_desvpobl SET calificacion = inuCalificacion
    WHERE rowid = isbRowId;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE  pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE  pkg_error.CONTROLLED_ERROR;
  END prActCalifiProdDesvpobl;
  PROCEDURE prActEstadoProdDesvpobl(isbRowId     IN   VARCHAR2,
                                    isbEstado    IN   info_producto_desvpobl.estado%type) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActEstadoProdDesvpobl
    Descripcion     : proceso que actualiza estado de la informacion de producto desvpobl

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 12-04-2024

    Parametros de Entrada
      isbRowId              id del rowid del registro actualizar
      inuCalificacion       codigo de la calificacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       12-04-2024   OSF-2494   Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prActEstadoProdDesvpobl';

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' isbRowId => ' || isbRowId, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' isbEstado => ' || isbEstado, pkg_traza.cnuNivelTrzDef);
    UPDATE info_producto_desvpobl SET estado = isbEstado
    WHERE rowid = isbRowId;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE  pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE  pkg_error.CONTROLLED_ERROR;
  END prActEstadoProdDesvpobl;

  FUNCTION frcGetInfoProdDesvpobl( inuContrato   IN  info_producto_desvpobl.contrato%type,
                                  inuPerioFact   IN  info_producto_desvpobl.periodo_facturacion%type,
                                  inuPeriCose    IN  info_producto_desvpobl.periodo_consumo%type default -1) RETURN styInfoProdDesvpobl is
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetInfoProdDesvpobl
    Descripcion     : funcion que devuelve infromacion de la informacion de producto desvpobl

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 12-04-2024

    Parametros de Entrada
      inuContrato           codigo del contrato
      inuPerioFact          periodo de facturacion
      inuPeriCose           periodo de consumo
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       12-04-2024   OSF-2494   Creacion
  ***************************************************************************/
   csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frcGetInfoProdDesvpobl';
   V_styInfoProdDesvpobl   styInfoProdDesvpobl;
   V_styInfoProdDesvpoblNull   styInfoProdDesvpobl;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuContrato => ' || inuContrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuPerioFact => ' || inuPerioFact, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuPeriCose => ' || inuPeriCose, pkg_traza.cnuNivelTrzDef);
    IF cuGetRegistro%ISOPEN THEN
       CLOSE cuGetRegistro;
    END IF;

    V_styInfoProdDesvpoblNull := V_styInfoProdDesvpobl;

    OPEN cuGetRegistro(inuContrato, inuPerioFact, inuPeriCose);
    FETCH cuGetRegistro INTO V_styInfoProdDesvpobl;
    CLOSE cuGetRegistro;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN V_styInfoProdDesvpobl;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
       RAISE  pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError,sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
       RAISE  pkg_error.CONTROLLED_ERROR;
  END frcGetInfoProdDesvpobl;

END pkg_info_producto_desvpobl;
/
BEGIN
	pkg_utilidades.prAplicarPermisos('PKG_INFO_PRODUCTO_DESVPOBL', 'PERSONALIZACIONES'); 
END;
/