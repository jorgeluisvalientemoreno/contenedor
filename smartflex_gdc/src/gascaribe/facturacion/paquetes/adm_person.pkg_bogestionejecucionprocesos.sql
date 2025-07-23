create or replace PACKAGE adm_person.pkg_BOGestionEjecucionProcesos IS
   SUBTYPE stytServPendLiqui IS PKBOPROCCTRLBYSERVICEMGR.TYTBSERVPENDLIQU;

   FUNCTION fsbVersion RETURN VARCHAR2;
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

   PROCEDURE prcObtInfoEjecxNombre(  isbNombreEjec         IN  sa_executable.name%TYPE,
                                    onuIdEjecutable       OUT sa_executable.executable_id%TYPE,
                                    osbDescripcion        OUT sa_executable.description%TYPE,
                                    onuModulo             OUT sa_executable.module_id%TYPE,
                                    osbVersion            OUT sa_executable.version%TYPE,
                                    onuTipoEjecutable     OUT sa_executable.executable_type_id%TYPE,
                                    onuTipoOperativo      OUT sa_executable.exec_oper_type_id%TYPE,
                                    onuEjecutablePadre    OUT sa_executable.parent_executable_id%TYPE,
                                    osbPath               OUT VARCHAR2);
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prObtInfoEjecxNombre
        Descripcion     : proceso que devuelve informacion del ejecutable por su nombre

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
            isbNombreEjec  nombre del ejecutable
        Parametros de Salida
            onuIdEjecutable       id el ejecutable
            osbDescripcion        descripcion
            onuModulo             modulo
            osbVersion            version
            onuTipoEjecutable     id del tipo de ejecutable
            onuTipoOperativo      id del tipo operativo
            onuEjecutablePadre    ejecutable padre
            osbPath               path
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
     FUNCTION fsbObtEstadoProceso(  inuPeriodoFact   IN procejec.prejcope%TYPE,
                                    isbPrograma      IN procejec.prejprog%TYPE) RETURN VARCHAR2;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbObtEstadoProceso
        Descripcion     : funcion que devuelve estado de un proceso en procejec

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
           inuPeriodoFact       periodo de facturacion
           isbPrograma          nombre del programa
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
    PROCEDURE prcValidaEjecuProceso (  inuPeriodoFact  IN procejec.prejcope%TYPE,
                                       isbPrograma     IN procejec.prejprog%TYPE,
                                       inuInfoAdic     IN procejec.prejinad%TYPE DEFAULT -1  ) ;
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcValidaEjecuProceso
        Descripcion     : proceso que valida si se puede ejecutar un proceso

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
           inuPeriodoFact       periodo de facturacion
           isbPrograma          nombre del programa
           inuInfoAdic          informacion adicional
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
     PROCEDURE prcObtServPendLiqu( inuCiclo         IN ciclo.ciclcodi%TYPE,
                                      inuPeriodo       IN perifact.pefacodi%TYPE,
                                      isbTipoServ      IN servicio.servtise%TYPE,
                                      iotbServPendLiq  IN OUT stytServPendLiqui );
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcObtServPendLiqu
        Descripcion     : proceso que obtiene tabla de servicios pendientes por liquidar

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
           inuCiclo             ciclo de facturacion
           inuPeriodo           periodo de facturacion
           isbTipoServ          tipo de servicio
           tytTblServPendLiqu      tabla de servicios pendiente por liquidar
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
     PROCEDURE prcInsertaRegistroEjec( isbProceso     IN  procejec.prejprog%TYPE,
                                      inuPeriodoFact IN  procejec.prejcope%TYPE DEFAULT -1,
                                      inuInfoAdic    IN  procejec.prejinad%TYPE DEFAULT -1,
                                      onuIdProceso   OUT procejec.prejidpr%TYPE );
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcInsertaRegistroEjec
        Descripcion     : proceso que registra en la tabla procejec

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-01-2025

        Parametros de Entrada
           isbProceso           Nombre del proceso
           inuPeriodoFact       periodo de facturacion
           inuInfoAdic          informacion adicional           
        Parametros de Salida
          onuIdProceso          id del proceso creado
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-01-2025   OSF-3741    Creacion
     ***************************************************************************/ 
      PROCEDURE prcActualizaRegistroEjec( inuIdProceso   IN procejec.prejidpr%TYPE );
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcActualizaRegistroEjec
        Descripcion     : proceso que actualiza a terminado registro en la tabla procejec

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-01-2025

        Parametros de Entrada
           inuIdProceso         id del proceso creado          
        Parametros de Salida
        
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-01-2025   OSF-3741    Creacion
     ***************************************************************************/
END pkg_BOGestionEjecucionProcesos;
/
create or replace PACKAGE BODY adm_person.pkg_BOGestionEjecucionProcesos IS
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

   PROCEDURE prcObtInfoEjecxNombre(  isbNombreEjec         IN  sa_executable.name%TYPE,
                                    onuIdEjecutable       OUT sa_executable.executable_id%TYPE,
                                    osbDescripcion        OUT sa_executable.description%TYPE,
                                    onuModulo             OUT sa_executable.module_id%TYPE,
                                    osbVersion            OUT sa_executable.version%TYPE,
                                    onuTipoEjecutable     OUT sa_executable.executable_type_id%TYPE,
                                    onuTipoOperativo      OUT sa_executable.exec_oper_type_id%TYPE,
                                    onuEjecutablePadre    OUT sa_executable.parent_executable_id%TYPE,
                                    osbPath               OUT VARCHAR2) IS
   /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcObtInfoEjecxNombre
        Descripcion     : proceso que devuelve informacion del ejecutable por su nombre

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
            isbNombreEjec  nombre del ejecutable
        Parametros de Salida
            onuIdEjecutable       id el ejecutable
            osbDescripcion        descripcion
            onuModulo             modulo
            osbVersion            version
            onuTipoEjecutable     id del tipo de ejecutable
            onuTipoOperativo      id del tipo operativo
            onuEjecutablePadre    ejecutable padre
            osbPath               path
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcObtInfoEjecxNombre';
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('isbNombreEjec => ' || isbNombreEjec, pkg_traza.cnuNivelTrzDef);
        SA_BOEXECUTABLE.GETEXECUTABLEDATABYNAME( isbNombreEjec,
                                                 onuIdEjecutable  ,
                                                 osbDescripcion ,
                                                 onuModulo ,
                                                 osbVersion,
                                                 onuTipoEjecutable,
                                                 onuTipoOperativo ,
                                                 onuEjecutablePadre,
                                                 osbPath );

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
     END prcObtInfoEjecxNombre;
     FUNCTION fsbObtEstadoProceso(  inuPeriodoFact   IN procejec.prejcope%TYPE,
                                    isbPrograma      IN procejec.prejprog%TYPE) RETURN VARCHAR2 IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbGetEstadoProceso
        Descripcion     : funcion que devuelve estado de un proceso en procejec

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
           inuPeriodoFact       periodo de facturacion
           isbPrograma          nombre del programa
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fsbObtEstadoProceso';
        sbEstadoProceso  VARCHAR2(1000);
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuPeriodoFact => ' || inuPeriodoFact, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('isbPrograma => ' || isbPrograma, pkg_traza.cnuNivelTrzDef);
        sbEstadoProceso := PKEXECUTEDPROCESSMGR.FSBGETSTATUSOFPROCESS(inuPeriodoFact, isbPrograma);
        pkg_traza.trace('sbEstadoProceso => ' || sbEstadoProceso, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN sbEstadoProceso;
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
    END fsbObtEstadoProceso;
    PROCEDURE prcValidaEjecuProceso (  inuPeriodoFact  IN procejec.prejcope%TYPE,
                                       isbPrograma     IN procejec.prejprog%TYPE,
                                       inuInfoAdic     IN procejec.prejinad%TYPE DEFAULT -1  ) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcValidaEjecuProceso
        Descripcion     : proceso que valida si se puede ejecutar un proceso

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
           inuPeriodoFact       periodo de facturacion
           isbPrograma          nombre del programa
           inuInfoAdic          informacion adicional
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcValidaEjecuProceso';
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuPeriodoFact => ' || inuPeriodoFact, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('isbPrograma => ' || isbPrograma, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuInfoAdic => ' || inuInfoAdic, pkg_traza.cnuNivelTrzDef);
        PKEXECUTEDPROCESSMGR.VALIFCANEXECUTEPROCESS(  inuPeriodoFact,  isbPrograma,inuInfoAdic);
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
     END prcValidaEjecuProceso;
     PROCEDURE prcObtServPendLiqu( inuCiclo         IN ciclo.ciclcodi%TYPE,
                                      inuPeriodo       IN perifact.pefacodi%TYPE,
                                      isbTipoServ      IN servicio.servtise%TYPE,
                                      iotbServPendLiq  IN OUT stytServPendLiqui ) IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcObtServPendLiqu
        Descripcion     : proceso que obtiene o usa tabla PL de servicios pendientes por liquidar

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 09-12-2024

        Parametros de Entrada
           inuCiclo             ciclo de facturacion
           inuPeriodo           periodo de facturacion
           isbTipoServ          tipo de servicio
           iotbServPendLiq      tabla de servicios pendiente por liquidar
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       09-12-2024   OSF-3741    Creacion
     ***************************************************************************/
       csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcObtServPendLiqu';
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuCiclo => ' || inuCiclo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuPeriodo => ' || inuPeriodo, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('isbTipoServ => ' || isbTipoServ, pkg_traza.cnuNivelTrzDef);
        PKBOPROCCTRLBYSERVICEMGR.FILLSERVPENDLIQSERVTYPE( inuCiclo,
                                                          inuPeriodo,
                                                          isbTipoServ,
                                                          iotbServPendLiq );

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
     END prcObtServPendLiqu;
     PROCEDURE prcInsertaRegistroEjec( isbProceso     IN  procejec.prejprog%TYPE,
                                  inuPeriodoFact IN  procejec.prejcope%TYPE DEFAULT -1,
                                  inuInfoAdic    IN  procejec.prejinad%TYPE DEFAULT -1,
                                  onuIdProceso   OUT procejec.prejidpr%TYPE ) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcInsertaRegistroEjec
        Descripcion     : proceso que registra en la tabla procejec

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-01-2025

        Parametros de Entrada
           isbProceso           Nombre del proceso
           inuPeriodoFact       periodo de facturacion
           inuInfoAdic          informacion adicional           
        Parametros de Salida
          onuIdProceso          id del proceso creado
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-01-2025   OSF-3741    Creacion
     ***************************************************************************/ 
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcInsertaRegistroEjec';
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('isbProceso => ' || isbProceso, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuPeriodoFact => ' || inuPeriodoFact, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('inuInfoAdic => ' || inuInfoAdic, pkg_traza.cnuNivelTrzDef);
        PKEXECUTEDPROCESSMGR.VALISINEXECUTION(
            inuPeriodoFact,
            isbProceso,
            inuInfoAdic
        );
       
        PKEXECUTEDPROCESSMGR.ADDINEXECRECORD(
            isbProceso,
            inuPeriodoFact,
            inuInfoAdic,
            onuIdProceso
        );
        pkg_traza.trace('onuIdProceso => ' || onuIdProceso, pkg_traza.cnuNivelTrzDef);
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
     END prcInsertaRegistroEjec;
     PROCEDURE prcActualizaRegistroEjec( inuIdProceso   IN procejec.prejidpr%TYPE) IS
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcActualizaRegistroEjec
        Descripcion     : proceso que actualiza a terminado registro en la tabla procejec

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 14-01-2025

        Parametros de Entrada
           inuIdProceso         id del proceso creado          
        Parametros de Salida
        
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       14-01-2025   OSF-3741    Creacion
     ***************************************************************************/
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcInsertaRegistroEjec';
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('inuIdProceso => ' || inuIdProceso, pkg_traza.cnuNivelTrzDef);
        PKEXECUTEDPROCESSMGR.UPDATEPROCESS(inuIdProceso);
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
     END prcActualizaRegistroEjec;
END pkg_BOGestionEjecucionProcesos;
/
PROMPT Otorgando permisos de ejecucion a PKG_BOGESTIONEJECUCIONPROCESOS
BEGIN
    pkg_utilidades.praplicarpermisos('PKG_BOGESTIONEJECUCIONPROCESOS', 'ADM_PERSON');
END;
/