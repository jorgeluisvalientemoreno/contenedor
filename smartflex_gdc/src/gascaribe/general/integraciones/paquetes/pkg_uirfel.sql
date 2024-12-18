create or replace PACKAGE PKG_UIRFEL IS
  FUNCTION frcGetFactReenviar RETURN constants_per.tyrefcursor; 
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetFactReenviar
    Descripcion     : proceso que retorna informacion para PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
    
    Parametros de Salida
    
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       15-11-2023   OSF-1916    Creacion
  ***************************************************************************/
  PROCEDURE prProcesarFact (isbpk             IN VARCHAR2,
                            inucurrent        IN NUMBER,
                            inutotal          IN NUMBER,
                            OnuErrorCode Out number,
                            OsbErrorMessage Out varchar2);
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prProcesarFact
    Descripcion     : proceso que procesa la informacion para PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
        isbPk          Identificador de la orden.
        inuCurrent     Registro actual.
        inuTotal       Total de registros
    Parametros de Salida
        onuErrorCode   Codigo de error.
        osbErrorMess   Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
    LJLB       15-11-2023   OSF-1916    Creacion
  ***************************************************************************/

END PKG_UIRFEL;
/
create or replace PACKAGE BODY PKG_UIRFEL IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(35):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(15) := 'OSF-1916';


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

  FUNCTION frcGetFactReenviar RETURN constants_per.tyrefcursor IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frcGetFactReenviar
    Descripcion     : proceso que retorna informacion para PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       15-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    csbMT_NAME      VARCHAR2(70) := csbSP_NAME || '.frcGetFactReenviar';
    nuError         NUMBER;
    sberror         VARCHAR2(4000);
    rcFactElec      constants_per.tyrefcursor;
    sbdateformat    ge_boutilities.stystatementattribute;
    sbContrato      ge_boinstancecontrol.stysbvalue;
    sbFactura       ge_boinstancecontrol.stysbvalue;
    sbFechaInic     ge_boinstancecontrol.stysbvalue;
    sbFechaFin      ge_boinstancecontrol.stysbvalue;
    sbEstado        ge_boinstancecontrol.stysbvalue;

    dtFechaIni      DATE;
    dtFechaFinal    DATE;

    PROCEDURE prValidaDatos IS
      -- Nombre de este método
      csbMT_NAME1  VARCHAR2(105) := csbMT_NAME || '.prValidaDatos';

      sbexiste VARCHAR2(1);

      CURSOR cuValidaContrato IS
      SELECT 'X'
      FROM suscripc
      WHERE susccodi = sbContrato;

    BEGIN
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       -- se valida campos no vacios
       IF sbContrato IS NULL AND sbFactura IS NULL AND sbFechaInic IS NULL
          AND sbFechaFin IS NULL AND sbEstado IS NULL THEN
          pkg_error.setErrorMessage ( isbMsgErrr => 'Se debe seleccionar por lo menos un campo para la busqueda');
       END IF;

       IF sbContrato IS NOT NULL THEN
          IF cuValidaContrato%ISOPEN THEN
             CLOSE cuValidaContrato;
          END IF;

          OPEN cuValidaContrato;
          FETCH cuValidaContrato INTO sbexiste;
          IF cuValidaContrato%NOTFOUND  THEN
             CLOSE cuValidaContrato;
             pkg_error.setErrorMessage ( isbMsgErrr => 'Contrato ['||sbContrato||'] no existe');
          END IF;
          CLOSE cuValidaContrato;
       END IF;

       IF sbFechaInic IS NULL AND sbFechaFin IS NOT NULL THEN
            pkg_error.setErrorMessage ( isbMsgErrr => 'Fecha inicial no puede estar vacia');
       END IF;

       IF sbFechaInic IS NOT NULL AND sbFechaFin IS  NULL THEN
          pkg_error.setErrorMessage ( isbMsgErrr => 'Fecha final no puede estar vacia');
       END IF;

       IF sbFechaInic IS NOT NULL THEN
          dtFechaIni := TO_DATE(TO_CHAR(TO_DATE(sbFechaInic,sbdateformat), 'DD/MM/YYYY')||' 00:00:00', 'DD/MM/YYYY HH24:MI:SS');
          dtFechaFinal :=  TO_DATE(TO_CHAR(TO_DATE(sbFechaFin,sbdateformat), 'DD/MM/YYYY')||' 23:59:59', 'DD/MM/YYYY HH24:MI:SS');

          IF dtFechaIni > dtFechaFinal THEN
             pkg_error.setErrorMessage ( isbMsgErrr => 'Fecha inicial no puede ser mayor a la fecha final');
          END IF;

          IF trunc(dtFechaFinal) > SYSDATE THEN
             pkg_error.setErrorMessage ( isbMsgErrr => 'Fecha final no puede ser mayor a la fecha del sistema');
          END IF;
       END IF;
       pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
     WHEN pkg_error.CONTROLLED_ERROR THEN
          pkg_Error.getError(nuError, sberror);
          pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
          raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
          pkg_Error.setError;
          pkg_Error.getError(nuError, sberror);
          pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
          pkg_traza.trace(csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
          raise pkg_error.CONTROLLED_ERROR;
    END prValidaDatos;

  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

    sbdateformat := LDC_BOCONSGENERALES.FSBGETFORMATOFECHA;

    sbContrato   := ge_boinstancecontrol.fsbgetfieldvalue('FACTURA', 'FACTSUSC');
    sbFactura    := ge_boinstancecontrol.fsbgetfieldvalue('FACTURA', 'FACTCODI');
    sbFechaInic  := ge_boinstancecontrol.fsbgetfieldvalue('FACTURA', 'FACTFEGE');
    sbFechaFin   := ge_boinstancecontrol.fsbgetfieldvalue('PLANSUSC', 'PLSUFEIV');
    sbEstado     := ge_boinstancecontrol.fsbgetfieldvalue('PERIFACT', 'PEFAANO');

    pkg_traza.trace('sbContrato: ' || sbContrato||' sbFactura: ' || sbFactura, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('sbFechaInic: ' || sbFechaInic||' sbFechaFin: ' || sbFechaFin, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace('sbEstado: ' || sbEstado, pkg_traza.cnuNivelTrzDef);

    prValidaDatos;

    rcFactElec := pkg_bcfactelectronica.frcgetfactreenviar(sbContrato, sbFactura, dtFechaIni, dtFechaFinal, sbEstado);

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN rcFactElec;
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sberror);
      pkg_traza.trace('sberror: ' || sberror, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END frcGetFactReenviar;
  PROCEDURE prProcesarFact (isbpk             IN VARCHAR2,
                            inucurrent        IN NUMBER,
                            inutotal          IN NUMBER,
                            OnuErrorCode      Out number,
                            OsbErrorMessage   Out varchar2) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prProcesarFact
    Descripcion     : proceso que procesa la informacion para PB RFEL

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 15-11-2023

    Parametros de Entrada
        isbPk          Identificador de la orden.
        inuCurrent     Registro actual.
        inuTotal       Total de registros
    Parametros de Salida
        onuErrorCode   Codigo de error.
        osbErrorMess   Mensaje de error.
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       15-11-2023   OSF-1916    Creacion
  ***************************************************************************/
    -- Nombre de este método
    csbMT_NAME  VARCHAR2(105) := csbSP_NAME || '.prProcesarFact';
  BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     pkg_traza.trace('isbpk: ' || isbpk||' inucurrent: ' || inucurrent||' inutotal: '||inutotal, pkg_traza.cnuNivelTrzDef);

     pkg_bcfactelectronica.prProcesarReenvio( isbpk, OnuErrorCode, OsbErrorMessage);
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      raise pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(OnuErrorCode, OsbErrorMessage);
      pkg_traza.trace('sberror: ' || OsbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      raise pkg_error.CONTROLLED_ERROR;
  END prProcesarFact;

END PKG_UIRFEL;
/
BEGIN
      pkg_utilidades.prAplicarPermisos('PKG_UIRFEL', 'OPEN');
END;
/    