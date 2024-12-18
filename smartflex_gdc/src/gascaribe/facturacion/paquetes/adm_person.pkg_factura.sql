create or replace PACKAGE   adm_person.pkg_factura IS
  FUNCTION fsbVersion RETURN VARCHAR2;
   
  PROCEDURE prActuNumeFiscal ( inuFactura    IN  factura.factcodi%type,
                               inuNumeFisc   IN  factura.factnufi%type,
                               inuConsNuau   IN  factura.factconf%type,
                               isbActuSigCon IN  VARCHAR2,
                               onuError      OUT NUMBER,
                               osbError      OUT VARCHAR2);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActuNumeFiscal
    Descripcion     : proceso que actualiza numero fiscal de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada
        inuFactura     codigo de la factura
        inuNumeFisc    numero fiscal
        inuConsNuau    consecutivo
        isbActuSigCon  S - si actualiza tabla consecut N - no actualiza
    Parametros de Salida
        onuError       Codigo de error.
        osbError       Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  PROCEDURE prInsertaFactura
    (
        inufact     in factura.factcodi%type,
        inususc     in factura.factsusc%type,
        inupefa     in factura.factpefa%type,
        inuvaap     in factura.factvaap%type,
        idtfege     in factura.factfege%type,
        isbterm     in factura.factterm%type,
        isbusua     in factura.factusua%type,
        inuprog     in factura.factprog%type
    );
    
  PROCEDURE prActualizaFechagen ( inuFactura    IN  factura.factcodi%type,
                                  idtFechagen   IN  factura.factfege%type);
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechagen
    Descripcion     : proceso que fecha de generacion de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuFactura     codigo de la factura
        idtFechagen    fecha de generacion
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
END pkg_factura;
/
create or replace PACKAGE BODY  adm_person.pkg_factura  IS
 -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-2913';
   nuError  NUMBER;
   sbError  VARCHAR2(4000);

   FUNCTION fsbVersion RETURN VARCHAR2 IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 16-11-2023

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB       16-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;

  PROCEDURE prActuNumeFiscal ( inuFactura    IN  factura.factcodi%type,
                              inuNumeFisc   IN  factura.factnufi%type,
                              inuConsNuau   IN  factura.factconf%type,
                              isbActuSigCon IN  VARCHAR2,
                              onuError      OUT NUMBER,
                              osbError      OUT VARCHAR2) IS
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActuNumeFiscal
    Descripcion     : proceso que actualiza numero fiscal de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 29-11-2023

    Parametros de Entrada
        inuFactura     codigo de la factura
        inuNumeFisc    numero fiscal
        inuConsNuau    consecutivo
        isbActuSigCon  S - si actualiza tabla consecut N - no actualiza
    Parametros de Salida
        onuError       Codigo de error.
        osbError       Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prActuNumeFiscal';
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	  pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuNumeFisc => ' || inuNumeFisc, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' inuConsNuau => ' || inuConsNuau, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' isbActuSigCon => ' || isbActuSigCon, pkg_traza.cnuNivelTrzDef);
      pkg_error.prinicializaerror(onuError, osbError);

      UPDATE factura SET factnufi = inuNumeFisc,
                          factconf = inuConsNuau
      WHERE factcodi = inuFactura;

      IF isbActuSigCon = 'S' THEN
        UPDATE consecut SET consnume = inuNumeFisc + 1
        WHERE conscodi = inuConsNuau;
      END IF;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuError, osbError);
      pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prActuNumeFiscal;
  
  PROCEDURE prInsertaFactura (  inufact     in factura.factcodi%type,
                                inususc     in factura.factsusc%type,
                                inupefa     in factura.factpefa%type,
                                inuvaap     in factura.factvaap%type,
                                idtfege     in factura.factfege%type,
                                isbterm     in factura.factterm%type,
                                isbusua     in factura.factusua%type,
                                inuprog     in factura.factprog%type ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertaFactura
    Descripción     : Inserta registro en factura

    Autor           : jcatuche
    Fecha           : 15-05-2024

    Parametros de Entrada
        inufact     identificador de la factura
        inususc     identificador del contrato
        inupefa     identificador del periodo
        inuvaap     valor aprobado
        idtfege     fecha de generación
        isbterm     terminal
        isbusua     usuario que inserta
        inuprog     programa que inserta
    Parametros de Salida
        NA
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripción
    jcatuche    15-05-2024  OSF-2467    Creación
  ***************************************************************************/
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prInsertaFactura';
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
    pkg_traza.trace('inufact <= ' || inufact, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inususc <= ' || inususc, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inupefa <= ' || inupefa, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuvaap <= ' || inuvaap, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('idtfege <= ' || idtfege, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbterm <= ' || isbterm, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('isbusua <= ' || isbusua, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('inuprog <= ' || inuprog, pkg_traza.cnuNivelTrzDef);
    
    insert into factura
    ( 
        factcodi, 
        factsusc,
        factpefa,
        factvaap,
        factfege,
        factterm,
        factusua,
        factprog
    ) 
    values 
    (
        inufact,
        inususc,
        inupefa,
        inuvaap,
        idtfege,
        isbterm,
        isbusua,
        inuprog
    );
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
    
  EXCEPTION    
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.CONTROLLED_ERROR; 
  END prInsertaFactura;

  PROCEDURE prActualizaFechagen ( inuFactura    IN  factura.factcodi%type,
                                  idtFechagen   IN  factura.factfege%type) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prActualizaFechagen
    Descripcion     : proceso que fecha de generacion de una factura

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 27-06-2024

    Parametros de Entrada
        inuFactura     codigo de la factura
        idtFechagen    fecha de generacion
    Parametros de Salida       
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       27-06-2024   OSF-2913    Creacion
  ***************************************************************************/
   csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.prActualizaFechagen';


  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	  pkg_traza.trace(' inuFactura => ' || inuFactura, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' idtFechagen => ' || idtFechagen, pkg_traza.cnuNivelTrzDef);
      UPDATE factura SET factfege = SYSDATE WHERE factcodi = inuFactura;
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_error.CONTROLLED_ERROR;
 END prActualizaFechagen;
END pkg_factura;
/
PROMPT Otorgando permisos de ejecucion a PKG_FACTURA
BEGIN
  pkg_utilidades.prAplicarPermisos('PKG_FACTURA','ADM_PERSON');
END;
/