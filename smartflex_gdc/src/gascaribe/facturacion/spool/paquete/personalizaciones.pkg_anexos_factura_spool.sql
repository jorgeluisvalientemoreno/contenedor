create or replace PACKAGE personalizaciones.pkg_anexos_factura_spool IS
  subtype styAnexosFacturaspool  is  anexos_factura_spool%rowtype;

  TYPE tytFactAnexo IS RECORD ( tipo_anexo  anexos_factura_spool.tipo_anexo%TYPE,
                                anexo       anexos_factura_spool.anexo%TYPE);

  TYPE tytblFactAnexo IS TABLE OF tytFactAnexo INDEX BY VARCHAR2(20);

  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 18-03-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      18-03-2025   OSF-4012    Creacion
  ***************************************************************************/


   PROCEDURE prcInsAnexoFactspool( iregAnexoFactspool IN  styAnexosFacturaspool);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInsAnexoFactspool
    Descripcion     : proceso que inserta en la tabla anexo de factura spool

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 18-03-2025

    Parametros de Entrada
      iregAnexoFactspool        registro de anexo de factura spool
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       18-03-2025   OSF-4012    Creacion
  ***************************************************************************/
  FUNCTION ftytblObtAnexoFactxPeriodo (inuPeriodoFact  IN NUMBER) RETURN tytblFactAnexo;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftytblObtAnexoFactxPeriodo
    Descripcion     : funcion que devuelve anexo por periodo de facturacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 18-03-2025

    Parametros de Entrada
      iregAnexoFactspool        registro de anexo de factura spool
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       18-03-2025   OSF-4012    Creacion
  ***************************************************************************/

END pkg_anexos_factura_spool;
/
create or replace PACKAGE BODY  personalizaciones.pkg_anexos_factura_spool IS
    -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-4012';

   nuError NUMBER;
   sbError VARCHAR2(4000);
  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 18-03-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      18-03-2025   OSF-4012    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN csbVersion;

  END fsbVersion;

  PROCEDURE prcInsAnexoFactspool( iregAnexoFactspool IN  styAnexosFacturaspool) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcInsAnexoFactspool
    Descripcion     : proceso que inserta en la tabla anexo de factura spool

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 18-03-2025

    Parametros de Entrada
      iregAnexoFactspool        registro de anexo de factura spool
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       18-03-2025   OSF-4012    Creacion
  ***************************************************************************/
     csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.prcInsAnexoFactspool';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' contrato => ' || iregAnexoFactspool.contrato, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' periodo_facturacion => ' || iregAnexoFactspool.periodo_facturacion, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' tipo_anexo => ' || iregAnexoFactspool.tipo_anexo, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' fecha_registro => ' || iregAnexoFactspool.fecha_registro, pkg_traza.cnuNivelTrzDef);
    INSERT INTO anexos_factura_spool ( contrato,
                                       periodo_facturacion,
                                       tipo_anexo,
                                       anexo,
                                       fecha_registro)
         VALUES( iregAnexoFactspool.contrato,
                 iregAnexoFactspool.periodo_facturacion,
                 iregAnexoFactspool.tipo_anexo,
                 iregAnexoFactspool.anexo,
                 iregAnexoFactspool.fecha_registro);

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prcInsAnexoFactspool;
  FUNCTION ftytblObtAnexoFactxPeriodo (inuPeriodoFact  IN NUMBER) RETURN tytblFactAnexo IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : ftytblObtAnexoFactxPeriodo
    Descripcion     : funcion que devuelve anexo por periodo de facturacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 18-03-2025

    Parametros de Entrada
      iregAnexoFactspool        registro de anexo de factura spool
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       18-03-2025   OSF-4012    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(150) := csbSP_NAME || '.ftytblObtAnexoFactxPeriodo';

    nuContador NUMBER:=0;
    sbIndex    VARCHAR2(20);
    v_tytblFactAnexo   tytblFactAnexo;

    CURSOR cuObtAnexosxPeri IS
    SELECT tipo_anexo,
            LISTAGG(anexo, CHR(13)) WITHIN GROUP (ORDER BY anexo) AS anexos_concatenados
    FROM anexos_factura_spool
    WHERE periodo_facturacion = inuPeriodoFact
    GROUP BY  tipo_anexo;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
    pkg_traza.trace(' inuPeriodoFact => ' || inuPeriodoFact, pkg_traza.cnuNivelTrzDef);
    v_tytblFactAnexo.DELETE;

    FOR reg IN cuObtAnexosxPeri LOOP
       nuContador := nuContador +1;
       sbIndex := inuPeriodoFact||''||nuContador;
       v_tytblFactAnexo(sbIndex).tipo_anexo := reg.tipo_anexo;
       v_tytblFactAnexo(sbIndex).anexo := reg.anexos_concatenados;
    END LOOP;

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN v_tytblFactAnexo;
  EXCEPTION
   WHEN pkg_error.CONTROLLED_ERROR THEN
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
       pkg_error.setError;
       pkg_error.geterror(nuError, sbError);
       pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END ftytblObtAnexoFactxPeriodo;

END pkg_anexos_factura_spool;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_ANEXOS_FACTURA_SPOOL','PERSONALIZACIONES');
    EXECUTE IMMEDIATE 'GRANT EXECUTE ON personalizaciones.PKG_ANEXOS_FACTURA_SPOOL TO ROLE_APPFACTURACION_ELECTRONIK';
END;
/