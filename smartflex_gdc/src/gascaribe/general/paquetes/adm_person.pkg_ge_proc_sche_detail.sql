create or replace PACKAGE  adm_person.pkg_ge_proc_sche_detail IS
   subtype styDetalleProgramacion  is  ge_proc_sche_detail%rowtype;
   
   CURSOR cuDetalleProg(inuIdProceProgramado IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE) IS
   SELECT ge_proc_sche_detail.*, ge_proc_sche_detail.rowid
   FROM ge_proc_sche_detail
   WHERE process_schedule_id = inuIdProceProgramado;

   SUBTYPE styDetalleProgrmacion IS cuDetalleProg%ROWTYPE;
   
   TYPE tytblDetalleProgramacion IS TABLE OF styDetalleProgrmacion INDEX BY BINARY_INTEGER;
   
   FUNCTION fsbVersion RETURN VARCHAR2;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Modificaciones  :
        Autor       Fecha        Caso       Descripcion
        LJLB        13-12-2024   OSF-3741     Creacion
    ***************************************************************************/
  PROCEDURE prInsertarDetalleProgram( iregDetalleProg IN  styDetalleProgramacion);
   /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prInsertarDetalleProgram
    Descripcion     : proceso que inserta en la tabla de detalle programacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 13-12-2024

    Parametros de Entrada
      iregDetalleProg        registro de detalle de programacion
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        13-12-2024   OSF-3741     Creacion
  ***************************************************************************/
  PROCEDURE prcObtDetalleProgramacion(inuIdProceProgramado IN GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE, 
                                      otbDetalleProgramacion OUT tytblDetalleProgramacion );
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtDetalleProgramacion
    Descripcion     : proceso que obtiene tabla pl de detalle de programacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-12-2024

    Parametros de Entrada
      inuIdProceProgramado        id de la programacion
    Parametros de Salida
      otbDetalleProgramacion      tabla de detalle de la programacion
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-12-2024   OSF-3741     Creacion
  ***************************************************************************/
END pkg_ge_proc_sche_detail;
/
create or replace PACKAGE BODY  adm_person.pkg_ge_proc_sche_detail IS
   csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
  -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3540';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez Barrios
    Fecha           : 09-12-2024

    Modificaciones  :
    Autor       Fecha        Caso       Descripcion
    LJLB        09-12-2024   OSF-3741     Creacion
   ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbVersion';
   BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('csbVersion => ' || csbVersion, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN csbVersion;
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;
    END fsbVersion;
    PROCEDURE prInsertarDetalleProgram( iregDetalleProg IN  styDetalleProgramacion) IS
       /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prInsertarDetalleProgram
        Descripcion     : proceso que inserta en la tabla de detalle programacion
    
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 13-12-2024
    
        Parametros de Entrada
          iregDetalleProg        registro de detalle de programacion
        Parametros de Salida
    
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB        13-12-2024   OSF-3741     Creacion
      ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prInsertarDetalleProgram';
   BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        INSERT INTO GE_PROC_SCHE_DETAIL ( proc_sche_detail_id,
                                          process_schedule_id,
                                          sequence,
                                          parameter )
                                   VALUES(
                                           iregDetalleProg.proc_sche_detail_id,
                                           iregDetalleProg.process_schedule_id,
                                           iregDetalleProg.sequence,
                                           iregDetalleProg.parameter );
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR;  
  END prInsertarDetalleProgram;

  PROCEDURE prcObtDetalleProgramacion(inuIdProceProgramado   IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE, 
                                      otbDetalleProgramacion OUT tytblDetalleProgramacion ) IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObtDetalleProgramacion
    Descripcion     : proceso que obtiene tabla pl de detalle de programacion

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 23-12-2024

    Parametros de Entrada
      inuIdProceProgramado        id de la programacion
    Parametros de Salida
      otbDetalleProgramacion      tabla de detalle de la programacion
    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB        23-12-2024   OSF-3741     Creacion
  ***************************************************************************/
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcObtDetalleProgramacion';
   BEGIN
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
      pkg_traza.trace(' inuIdProceProgramado => ' || inuIdProceProgramado, pkg_traza.cnuNivelTrzDef);
      IF cuDetalleProg%ISOPEN THEN CLOSE cuDetalleProg; END IF;

      OPEN cuDetalleProg(inuIdProceProgramado);
      FETCH cuDetalleProg BULK COLLECT INTO otbDetalleProgramacion;
      CLOSE cuDetalleProg;

      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
            RAISE pkg_error.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            RAISE pkg_error.CONTROLLED_ERROR; 
  END prcObtDetalleProgramacion;
END pkg_ge_proc_sche_detail;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre pkg_ge_proc_sche_detail
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_GE_PROC_SCHE_DETAIL', 'ADM_PERSON'); 
END;
/