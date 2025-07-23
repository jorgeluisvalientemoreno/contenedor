create or replace PACKAGE PKG_UILDCGCAM IS

     sbFechaFinMov    VARCHAR2(50);
     sbFechaProgra    VARCHAR2(50);
     sbProceso     VARCHAR2(50);
     cnuNULL_ATTRIBUTE constant number := 2126;

     FUNCTION fsbVersion RETURN VARCHAR2;
      /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : fsbVersion
        Descripcion     : Retona el identificador del ultimo caso que hizo cambios
        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      22-11-2024   OSF-3540    Creacion
      ***************************************************************************/

     PROCEDURE prcObjeto( isbPeriodo   IN VARCHAR2,
                          inuCurrent   IN NUMBER,
                          inuTotal     IN NUMBER,
                          onuErrorcode OUT ge_error_log.message_id%TYPE,
                          osbErrormess OUT ge_error_log.description%TYPE);
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcObjeto
        Descripcion     : procedo de ejecucion de la forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada
           isbPeriodo       periodo de facturacion
           inuCurrent       valor actual
           inuTotal         total           
        Parametros de Salida
           onuErrorcode      codigo de error
           osbErrormess      mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
     ***************************************************************************/

     FUNCTION  frfConsulta RETURN CONSTANTS_PER.TYREFCURSOR;
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frfConsulta
        Descripcion     : funcion para retornar resultado de la forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
   ***************************************************************************/
  
   PROCEDURE prObtValorespb( isbFechaFinMov  OUT  ge_boInstanceControl.stysbValue,
                             isbFechaProgra OUT  ge_boInstanceControl.stysbValue,
                             isbProceso OUT  ge_boInstanceControl.stysbValue );
   /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prObtValorespb
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : obtiene valores del  PB [LDCGCAM]

      Parametros Entrada

      Valor de salida
        isbFechaFinMov    fecha fin de movimiento
        isbFechaProgra     fecha de programacion   
        isbProceso  proceso a ejecutar

      HISTORIA DE MODIFICACIONES
          FECHA        AUTOR       DESCRIPCION
          22/11/2022   LJLB        OSF-3540: se realiza ajustes de V8
          19/11/2020   horbath     ca 461 se quitan los campos de los filtros que se quitaron en la forma
                                  - se agrega nuevo campo proceso
          26/07/2021   LJLB        ca 696 se habilita campo de fecha fecha final de movimiento
    ***************************************************************************/
END PKG_UILDCGCAM;
/
create or replace PACKAGE BODY PKG_UILDCGCAM IS
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
        Fecha           : 22-11-2024

        Modificaciones  :
        Autor       Fecha       Caso       Descripcion
        LJLB      22-11-2024   OSF-3540    Creacion
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
    PROCEDURE prObtValorespb( isbFechaFinMov  OUT  ge_boInstanceControl.stysbValue,
                            isbFechaProgra OUT  ge_boInstanceControl.stysbValue,
                            isbProceso OUT  ge_boInstanceControl.stysbValue ) is
  /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prObtValorespb
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : obtiene valores del  PB [LDCGCAM]

      Parametros Entrada

      Valor de salida
        isbFechaFinMov    fecha fin de movimiento
        isbFechaProgra     fecha de programacion   
        isbProceso  proceso a ejecutar

      HISTORIA DE MODIFICACIONES
          FECHA        AUTOR       DESCRIPCION
          22/11/2022   LJLB        OSF-3540: se realiza ajustes de V8
          19/11/2020   horbath     ca 461 se quitan los campos de los filtros que se quitaron en la forma
                                  - se agrega nuevo campo proceso
          26/07/2021   LJLB        ca 696 se habilita campo de fecha fecha final de movimiento
    ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prObtValorespb';
     BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        --Se obtienen datos del PB
        isbFechaFinMov := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFFMO');
        isbFechaProgra := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAFEGE');
        isbProceso := ge_boInstanceControl.fsbGetFieldValue ('PERIFACT', 'PEFAANO');
        pkg_traza.trace(' isbFechaFinMov => ' || isbFechaFinMov, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' isbFechaProgra => ' || isbFechaProgra, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace(' isbProceso => ' || isbProceso, pkg_traza.cnuNivelTrzDef);
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
     END prObtValorespb;

    PROCEDURE prValidaInfor IS
    /**************************************************************************
      Autor       : Luis Javier Lopez Barrios / Horbath
      Proceso     : prValidaInfor
      Fecha       : 2020-13-03
      Ticket      : 65
      Descripcion : proceso que se encarga de validar informacion del PB [LDCGCAM]

      Parametros Entrada

      Valor de salida

      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      19/11/2020   horbath     ca 461 se agrega nuevo campo sbProceso al proceso que obtienen los valores
                              se quita las validaciones de los campos que no se utilizan
      26/07/2021   LJLB        CA 696 se agrega fecha final de movimiento y se valida que no sea mayor a la fecha del sistema
                               ni menor a la fecha resultante de la resta de la fecha del sistema menos los dias del parametro LDC_DIASATRAPERM

    ***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prValidaInfor';
    sbdateformat VARCHAR2(100);--se almacena formato de fecha

    dtFechaProg DATE;
    --inicio ca 696
    nuDias NUMBER := nvl(PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_DIASATRAPERM'), 0);
    dtFechaFinal DATE;
    dtFechaFinalCal date;
    --fin ca 696

  BEGIN
       pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
       sbdateformat := LDC_BOCONSGENERALES.FSBGETFORMATOFECHA;
       --se obtienen datos del PB
       prObtValorespb( sbFechaFinMov,
                      sbFechaProgra,
                      sbProceso);

    
        IF TO_NUMBER(sbProceso) IN (3,4) and sbFechaFinMov is not null  THEN
            pkg_traza.trace('dtFechaFinal '||dtFechaFinal, pkg_traza.cnuNivelTrzDef);
            dtFechaFinal := TO_DATE(sbFechaFinMov,''||sbdateformat||'');
            pkg_traza.trace('sbdateformat '||sbdateformat||' dtFechaFinal '||dtFechaFinal, pkg_traza.cnuNivelTrzDef);
            
            IF dtFechaFinal > SYSDATE THEN
               pkg_error.setErrorMessage (isbMsgErrr =>  'Fecha Final de Movimientos no puede ser mayor a la fecha del sistema');
            END IF;
            
            dtFechaFinalCal := TRUNC(SYSDATE) - nuDias;
            
            pkg_traza.trace('fecha '||dtFechaFinalCal, pkg_traza.cnuNivelTrzDef);
            IF dtFechaFinal  < dtFechaFinalCal THEN
               pkg_error.setErrorMessage (isbMsgErrr =>  'Fecha Final de Movimientos no puede ser menor a la fecha '||dtFechaFinalCal);
            END IF;
            pkg_traza.trace('termino validar fecha', pkg_traza.cnuNivelTrzDef);
        END IF;
    
        IF (sbFechaProgra is null) then
             pkg_error.setErrorMessage (cnuNULL_ATTRIBUTE, 'Fecha de programacion');
        END IF;
    
        dtFechaProg := TO_DATE(sbFechaProgra,''||sbdateformat||'');
        pkg_traza.trace('dtFechaProg '||dtFechaProg, pkg_traza.cnuNivelTrzDef);
    
         --se valoida que la fecha de programacion no sea menor a la del sistema
        IF dtFechaProg < sysdate - 4/24/60 THEN
             pkg_error.setErrorMessage (isbMsgErrr => 'Fecha de programacion no puede ser menor a la del sistema');
        END IF;

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
    END prValidaInfor;

    PROCEDURE prcObjeto( isbPeriodo   IN VARCHAR2,
                          inuCurrent   IN NUMBER,
                          inuTotal     IN NUMBER,
                          onuErrorcode OUT ge_error_log.message_id%TYPE,
                          osbErrormess OUT ge_error_log.description%TYPE) IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prcObjeto
        Descripcion     : procedo de ejecucion de la forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada
           isbPeriodo       periodo de facturacion
           inuCurrent       valor actual
           inuTotal         total           
        Parametros de Salida
           onuErrorcode      codigo de error
           osbErrormess      mensaje de error
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
     ***************************************************************************/
       csbMT_NAME       VARCHAR2(100) := csbSP_NAME || '.prcObjeto';
	   sbFechaFinMovP    VARCHAR2(50);
       sbFechaPrograP    VARCHAR2(50);
       sbProcesoP        VARCHAR2(50);
	   sbCadenaCone  VARCHAR2(100);
	   sbUsuario      VARCHAR2(100);
	   sbpassword     VARCHAR2(100);
	   sbInstance     VARCHAR2(100);
	   sbCadeScrip    VARCHAR2(500);


    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_traza.trace('isbPeriodo => ' || isbPeriodo, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('inuCurrent => ' || inuCurrent, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('inuTotal => ' || inuTotal, pkg_traza.cnuNivelTrzDef);
		--se obtienen datos del PB
		prObtValorespb( sbFechaFinMovP,
						sbFechaPrograP,
						sbProcesoP);

		pkg_traza.trace('sbFechaFinMovP =>'||sbFechaFinMovP, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('sbFechaPrograP =>'||sbFechaPrograP, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace('sbProcesoP =>'||sbProcesoP, pkg_traza.cnuNivelTrzDef);

        IF (sbFechaPrograP IS NULL) THEN
          pkg_error.setErrorMessage(cnuNULL_ATTRIBUTE, 'Fecha de programacion');
        END IF;

        IF NVL(sbProcesoP,'-1') <> NVL(sbProceso ,'-1') THEN
          pkg_error.setErrorMessage (isbMsgErrr => 'Se cambiaron los datos de la consulta, por favor volver a generar la busqueda');
        END IF;

  	    IF sbProceso IN ('3', '4') THEN
		  IF sbFechaFinMovP <> sbFechaFinMov  THEN
			 pkg_error.setErrorMessage (isbMsgErrr =>'Se cambiaron los datos de la consulta, por favor volver a generar la busqueda');
		  END IF;
	    END IF;

		IF sbCadeScrip IS NULL THEN
		  --se obtiene cadena de conexion
		  GE_BODATABASECONNECTION.GETCONNECTIONSTRING(sbUsuario, sbpassword, sbInstance);
		  sbCadenaCone  := sbUsuario || '/' || sbpassword || '@' || sbInstance;
		  sbCadeScrip   := FA_UIProcesosFact.FSBENCRIPTACADENA(sbCadenaCone);
		END IF;

		pkg_boldcgcam.prcObjeto( isbPeriodo,
								 inuCurrent,
								 inuTotal ,
								 sbCadeScrip ,
								 sbProcesoP,
								 sbFechaPrograP,								 
								 onuErrorcode ,
								 osbErrormess );

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
   END prcObjeto;
   FUNCTION  frfConsulta RETURN CONSTANTS_PER.TYREFCURSOR IS
     /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frfConsulta
        Descripcion     : funcion para retornar resultado de la forma LDCGCAM

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 22-11-2024

        Parametros de Entrada

        Parametros de Salida

        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       22-11-2024   OSF-3540    Creacion
    ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frfConsulta';
      rfResultado CONSTANTS_PER.TYREFCURSOR;
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		--se valida datos del PB
        prValidaInfor;
        rfResultado := pkg_boldcgcam.frfConsulta(sbProceso, sbFechaFinMov);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
        RETURN rfResultado;
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
   END frfConsulta;
 
END PKG_UILDCGCAM;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_UILDCGCAM', 'OPEN'); 
END;
/