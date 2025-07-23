create or replace PROCEDURE LDCGPAD(inuProgramacion  in ge_process_schedule.process_schedule_id%type) IS
 /*****************************************************************
  Propiedad intelectual de GDC

  Unidad         : LDCGPAD
  Descripcion    : proceso que se encarga de programar el PB LDCGPAD
  Autor          : Luis Javier Lopez Barrios / Horbath
  Fecha          : 05/12/2022

  Parametros              Descripcion
  ============         ===================
  Fecha             Autor             Modificacion
  =========       =========           ====================
  22/01/2025      LJLB                OSF-3650: se modifica proceso para aplicar pautas tecnicas
  ******************************************************************/
 csbMT_NAME      VARCHAR2(100) := 'LDCGPAD';
 nuHilos          NUMBER := 1;
 nuLogProceso     ge_log_process.log_process_id%TYPE;
 nuerror          NUMBER;
 sbError          VARCHAR2(4000);
 sbParametros     ge_process_schedule.parameters_%TYPE; 
 sbCiclo          ge_process_schedule.parameters_%TYPE; 
 
BEGIN
  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
  pkg_gestionprocesosprogramados.prc_agregalogalproceso(inuProgramacion,nuHilos,nuLogProceso);
  sbParametros := pkg_gestionprocesosprogramados.fsbObtParametrosProceso(inuProgramacion);
  
  pkg_traza.trace(' sbParametros => ' || sbParametros, pkg_traza.cnuNivelTrzDef);
  sbCiclo := pkg_gestionprocesosprogramados.fsbObtValorParametroProceso (  sbParametros, 'PEFACICL');    
  pkg_uildcgpad.prcObjeto(to_number(sbCiclo));
  
  pkg_gestionprocesosprogramados.prc_actestadologproceso(nuLogProceso,'F');
  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
EXCEPTION
    WHEN pkg_error.CONTROLLED_ERROR THEN
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        pkg_gestionprocesosprogramados.prc_actestadologproceso(nuLogProceso,'F');
        RAISE pkg_error.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        pkg_error.setError;
        pkg_error.geterror(nuError,sbError);
        pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
        pkg_gestionprocesosprogramados.prc_actestadologproceso(nuLogProceso,'F');
        RAISE pkg_error.CONTROLLED_ERROR;
END LDCGPAD;
/