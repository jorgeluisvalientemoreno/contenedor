create or replace PACKAGE   adm_person.pkg_reportes_inco IS
  FUNCTION fnuCrearCabeReporte ( isbAplicacion IN VARCHAR2, 
                                 isbObservacion IN VARCHAR2) RETURN NUMBER;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCrearCabeReporte
    Descripcion     : proceso que se encarga de crear un registro en la tabla reportes

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 30-11-2023

    Parametros de Entrada
      isbAplicacion   nombre de la aplicacion 
      isbObservacion  observacion
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/   

   PROCEDURE prCrearDetalleRepo( inuIdReporte    IN repoinco.reinrepo%type,
                                 inuObjeto       IN repoinco.reinval1%type,
                                 isbError        IN repoinco.reinobse%type,
                                 isbDescripcion  IN repoinco.reindes1%type,
                                 nuConsecutivo   IN NUMBER );
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCrearDetalleRepo
    Descripcion     : proceso que se encarga de crear un detalle en repoinco

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 30-11-2023

    Parametros de Entrada
      inuIdReporte    Id del reporte
      inuObjeto       objeto que se desea guardar en el log
      isbError        mensaje se error
      isbDescripcion  descripcion         
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/ 
END pkg_reportes_inco;
/
create or replace PACKAGE BODY  adm_person.pkg_reportes_inco IS
   -- Constantes para el control de la traza
   csbSP_NAME     CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
   csbVersion     CONSTANT VARCHAR2(15) := 'OSF-1916';
   nuError        NUMBER;
   sbError        VARCHAR2(4000);
   
   FUNCTION fnuCrearCabeReporte ( isbAplicacion IN VARCHAR2, 
                                 isbObservacion IN VARCHAR2) RETURN NUMBER IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fnuCrearCabeReporte
    Descripcion     : proceso que se encarga de crear un registro en la tabla reportes

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 30-11-2023

    Parametros de Entrada
      isbAplicacion   nombre de la aplicacion 
      isbObservacion  observacion
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/   
     PRAGMA AUTONOMOUS_TRANSACTION;
     csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fnuCrearCabeReporte';
        -- Variables
     rcRecord Reportes%rowtype;
  BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
      pkg_traza.trace(' isbaplicacion => ' || isbaplicacion, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(' isbObservacion => ' || isbObservacion, pkg_traza.cnuNivelTrzDef);
      
      rcRecord.REPOAPLI := isbaplicacion;
      rcRecord.REPOFECH := sysdate;
      rcRecord.REPOUSER := pkg_session.fsbgetTerminal;
      rcRecord.REPODESC := isbObservacion ;
      rcRecord.REPOSTEJ := null;
      rcRecord.REPONUME :=  seq.getnext('SQ_REPORTES');

        -- Insert record
      pktblReportes.insRecord(rcRecord);
      COMMIT;
      pkg_traza.trace(' rcRecord.Reponume => ' || rcRecord.Reponume, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
      return rcRecord.Reponume;
      
  EXCEPTION    
    WHEN pkg_error.CONTROLLED_ERROR THEN
      pkg_Error.getError(nuError, sbError);   
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      return -1;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(nuError, sbError);   
      pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
      return -1;
   END fnuCrearCabeReporte;
   PROCEDURE prCrearDetalleRepo( inuIdReporte    IN repoinco.reinrepo%type,
                                 inuObjeto       IN repoinco.reinval1%type,
                                 isbError        IN repoinco.reinobse%type,
                                 isbDescripcion  IN repoinco.reindes1%type,
                                 nuConsecutivo   IN NUMBER ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prCrearDetalleRepo
    Descripcion     : proceso que se encarga de crear un detalle en repoinco

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 30-11-2023

    Parametros de Entrada
      inuIdReporte    Id del reporte
      inuObjeto       objeto que se desea guardar en el log
      isbError        mensaje se error
      isbDescripcion  descripcion         
    Parametros de Salida
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       29-11-2023   OSF-1916    Creacion
  ***************************************************************************/ 
    PRAGMA AUTONOMOUS_TRANSACTION;
    csbMT_NAME        VARCHAR2(100) := csbSP_NAME || '.fnuCrearCabeReporte';
     -- Variables
    rcRepoinco repoinco%rowtype;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);   
    pkg_traza.trace(' inuIdReporte => ' || inuIdReporte, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' inuObjeto => ' || inuObjeto, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' isbDescripcion => ' || isbDescripcion, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' isbError => ' || isbError, pkg_traza.cnuNivelTrzDef);
    pkg_traza.trace(' nuConsecutivo => ' || isbError, pkg_traza.cnuNivelTrzDef);
    rcRepoinco.reinrepo := inuIdReporte;
    rcRepoinco.reinval1 := inuObjeto;
    rcRepoinco.reindes1 := isbDescripcion;
    rcRepoinco.reinobse := isbError;
    rcRepoinco.reincodi := nuConsecutivo;

    -- Insert record
    pktblRepoinco.insrecord(rcRepoinco);
    COMMIT;
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
  EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_Error.getError(nuError, sbError);   
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
    WHEN OTHERS THEN
        pkg_Error.setError;
        pkg_Error.getError(nuError, sbError);   
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR); 
  END prCrearDetalleRepo;
END pkg_reportes_inco;
/
PROMPT Otorgando permisos de ejecución para adm_person.PKG_REPORTES_INCO
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_REPORTES_INCO', 'ADM_PERSON');
END;
/