create or replace PACKAGE  personalizaciones.pkg_boldcgcam IS
  FUNCTION fsbVersion RETURN VARCHAR2;
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Luis Javier Lopez - Horbath
    Fecha           : 22-11-2024

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
    LJLB      22-11-2024   OSF-3540    Creacion
  ***************************************************************************/
  PROCEDURE prcObjeto( isbPeriodo    IN VARCHAR2,
                       inuCurrent    IN NUMBER,
                       inuTotal      IN NUMBER,
                       isbCadenaCon  IN VARCHAR2,
                      isbProceso    IN VARCHAR2,
                      isbFechaProg  IN VARCHAR2,
                      onuErrorcode  OUT ge_error_log.message_id%TYPE,
                       osbErrormess   OUT ge_error_log.description%TYPE);
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObjeto
	Descripcion     : proceso de ejecucion de la forma LDCGCAM

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-11-2024

	Parametros de Entrada
	   isbPeriodo       periodo de facturacion
	   inuCurrent       valor actual
	   inuTotal         total
	   isbCadenaCon		cadena de conexion
	   isbProceso       proceso a programar
	   isbFechaProg		fecha de programacion
	Parametros de Salida
	   onuErrorcode      codigo de error
	   osbErrormess      mensaje de error
	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB       22-11-2024   OSF-3540    Creacion
 ***************************************************************************/
 FUNCTION  frfConsulta(isbProceso  IN VARCHAR2,
                        isbFechaMov IN VARCHAR2) RETURN CONSTANTS_PER.TYREFCURSOR ;
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfConsulta
    Descripcion     : funcion para retornar resultado de la forma LDCGCAM

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2024

    Parametros de Entrada
       isbProceso   proceso a ejecutar
       isbFechaMov  fecha final de movimiento
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       22-11-2024   OSF-3540    Creacion
***************************************************************************/
   PROCEDURE PRCPROGFGCA ( idtFechaProg IN DATE,
                          iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                          isbCadenaCon IN VARCHAR2,
                          onuError OUT NUMBER,
                          osbError OUT VARCHAR2);
   /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCPROGFGCA
      Fecha       : 2024-24-12
      Ticket      : OSF-3540
      Descripcion : proceso que se encarga de programar el proceso FGCC

      Parametros Entrada
       idtFechaProg	fecha de programacion
       iregPeriodo	registro de periodos
       isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
   ***************************************************************************/
   PROCEDURE PRCPROGFGCC ( idtFechaProg IN DATE,
                          iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                          isbCadenaCon IN VARCHAR2,
                           onuError OUT NUMBER,
                           osbError OUT VARCHAR2);
   /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FGCC

      Parametros Entrada
        idtFechaProg	fecha de programacion
	    iregPeriodo	registro de periodos
	    isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
    PROCEDURE 	PRCPROGFIDF( idtFechaProg IN DATE,
                            iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                            isbCadenaCon IN VARCHAR2,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCPROGFIDF
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FIDF

      Parametros Entrada
       idtFechaProg	fecha de programacion
       iregPeriodo	registro de periodos
       isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      27/07/2021   ljlb       ca 696 se coloca orden en la programacion del proceso FIDF
      ***************************************************************************/
   PROCEDURE 	PRCPROGFCPE( idtFechaProg IN DATE,
                            iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                            isbCadenaCon IN VARCHAR2,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2);
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCPROGFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FCPE

      Parametros Entrada
        idtFechaProg	fecha de programacion
        iregPeriodo	registro de periodos
        isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
END pkg_boldcgcam;
/
create or replace PACKAGE BODY   personalizaciones.pkg_boldcgcam IS

  csbSP_NAME        CONSTANT VARCHAR2(100):= $$PLSQL_UNIT;
   -- Identificador del ultimo caso que hizo cambios
  csbVersion          CONSTANT VARCHAR2(15) := 'OSF-3540';
  nuError             NUMBER;
  sbError             VARCHAR2(4000);
  nuConsecutivo       NUMBER := 0;
  nuIdReporte NUMBER;

  sbCiclo VARCHAR2(4000) := PKG_BCLD_PARAMETER.FSBOBTIENEVALORCADENA('LDC_CICLEXPCA');
  NUMINUTOS           NUMBER := PKG_BCLD_PARAMETER.FNUOBTIENEVALORNUMERICO('LDC_MINENTHILOS');

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

   PROCEDURE prcValidProgPeriodo
    (
      inuExecuta    IN  SA_EXECUTABLE.NAME%TYPE,
      inuperiodo    IN  PERIFACT.PEFACODI%TYPE
    )
    IS

        --variables para job
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcValidProgPeriodo';
        nuJob                  GE_PROCESS_SCHEDULE.JOB%TYPE;
        sbparametros           GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
        nuprogramacion         GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE;
        sbFechaejec            VARCHAR2(300);
        sbHoraejec             VARCHAR2(300);
        sbFrecuencia           VARCHAR2(300);
        --variables para ejecutables
        nuTipoejecutable       SA_EXECUTABLE.EXECUTABLE_TYPE_ID%TYPE;
        nuEjeOperTipo          SA_EXECUTABLE.EXEC_OPER_TYPE_ID%TYPE;
        nuEjecPath              VARCHAR2(200);
        cuprogramacion         CONSTANTS_PER.TYREFCURSOR;
        nuExecutable           SA_EXECUTABLE.EXECUTABLE_ID%TYPE;
        sbdescripcion          SA_EXECUTABLE.DESCRIPTION%TYPE;
        nuEjecPadre            SA_EXECUTABLE.PARENT_EXECUTABLE_ID%TYPE;
        nuModulo               SA_EXECUTABLE.MODULE_ID%TYPE;
        sbversion              SA_EXECUTABLE.VERSION%TYPE;

        nuPosiServ            NUMBER;
        nuPosiperiodo         NUMBER;
        nuPosFinal            NUMBER;

        --variable para programacion
        NUPERIODO             PERIFACT.PEFACODI%TYPE;
        nuTipoprod            SERVICIO.SERVCODI%TYPE;
        blprogramado          BOOLEAN := FALSE;
        NUERRORPROG     	  GE_MESSAGE.MESSAGE_ID%TYPE := 143474;
        sbMensajeError        VARCHAR2(4000);
        
        CURSOR cuGetMensaError IS 
        SELECT  ge_message.description
        FROM ge_message
        WHERE message_id = NUERRORPROG;
        
       
    BEGIN

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.SETAPPLICATION ( 'FEPF' );
        pkg_BOGestionEjecucionProcesos.prcObtInfoEjecxNombre( inuExecuta,
															nuExecutable,
															sbdescripcion,
															nuModulo,
															sbversion,
															nuTipoejecutable,
															nuEjeOperTipo,
															nuEjecPadre,
															nuEjecPath);



        cuprogramacion := pkg_gestionprocesosprogramados.frfObtProgramacionxEjecu(nuExecutable);

        LOOP

            FETCH cuprogramacion INTO   sbFechaejec,
                                        sbHoraejec,
                                        sbFrecuencia,
                                        nuJob,
                                        sbparametros,
                                        nuprogramacion;
            EXIT WHEN  cuprogramacion%NOTFOUND;

            nuPosiperiodo := INSTR(sbparametros,'PEFACODI=') + 9;
            nuPosFinal := INSTR(sbparametros,'|',nuPosiperiodo,1);
            NUPERIODO := TO_CHAR(SUBSTR(sbparametros,nuPosiperiodo,nuPosFinal-nuPosiperiodo));

            IF  NUPERIODO = inuperiodo THEN
                IF cuGetMensaError%ISOPEN THEN CLOSE cuGetMensaError; END IF;
                OPEN cuGetMensaError;
                FETCH cuGetMensaError INTO sbMensajeError;
                CLOSE cuGetMensaError;
                pkg_error.setErrorMessage(NUERRORPROG, sbMensajeError);
            END IF;

        END LOOP;

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
  END prcValidProgPeriodo;

   FUNCTION fblValidProgPeriodo (
      isbExecutable    IN  SA_EXECUTABLE.NAME%TYPE,
      inuperiodo    IN  PERIFACT.PEFACODI%TYPE,
      inuTipoprod   IN  SERVICIO.SERVCODI%TYPE
    ) RETURN BOOLEAN IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fblValidProgPeriodo
    Descripcion     : funcion para validar programacion de un periodo y ejecutable

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2024

    Parametros de Entrada
       isbExecutable   proceso a ejecutar
       inuperiodo      periodo de facturacion
       inuTipoprod     tipo de producto
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       22-11-2024   OSF-3540    Creacion
***************************************************************************/
        --variables para job
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.fblValidProgPeriodo';
        nuJob                  GE_PROCESS_SCHEDULE.JOB%TYPE;
        sbparametros           GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE;
        nuprogramacion         GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE;
        sbFechaejec            VARCHAR2(300);
        sbHoraejec             VARCHAR2(300);
        sbFrecuencia           VARCHAR2(300);
        --variables para ejecutables
        nuTipoejecutable       SA_EXECUTABLE.EXECUTABLE_TYPE_ID%TYPE;
        nuEjeOperTipo          SA_EXECUTABLE.EXEC_OPER_TYPE_ID%TYPE;
        nuEjecPath              VARCHAR2(200);
        cuprogramacion         CONSTANTS_PER.TYREFCURSOR;
        nuExecutable           SA_EXECUTABLE.EXECUTABLE_ID%TYPE;
        sbdescripcion          SA_EXECUTABLE.DESCRIPTION%TYPE;
        nuEjecPadre            SA_EXECUTABLE.PARENT_EXECUTABLE_ID%TYPE;
        nuModulo               SA_EXECUTABLE.MODULE_ID%TYPE;
        sbversion              SA_EXECUTABLE.VERSION%TYPE;

        tblDetalleProg         pkg_ge_proc_sche_detail.tytblDetalleProgramacion;

        nuPosiServ            NUMBER;
        nuPosiperiodo         NUMBER;
        nuPosFinal            NUMBER;

        --variable para programacion
        NUPERIODO             PERIFACT.PEFACODI%TYPE;
        nuTipoprod            SERVICIO.SERVCODI%TYPE;
        blprogramado          BOOLEAN := FALSE;

    BEGIN
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.SETAPPLICATION ( isbExecutable );

        pkg_BOGestionEjecucionProcesos.prcObtInfoEjecxNombre( isbExecutable,
															  nuExecutable,
															  sbdescripcion,
															  nuModulo,
															  sbversion,
															  nuTipoejecutable,
															  nuEjeOperTipo,
															  nuEjecPadre,
															  nuEjecPath);



        cuprogramacion := pkg_gestionprocesosprogramados.frfObtProgramacionxEjecu(nuExecutable);

        LOOP

            FETCH cuprogramacion INTO   sbFechaejec,
                                        sbHoraejec,
                                        sbFrecuencia,
                                        nuJob,
                                        sbparametros,
                                        nuprogramacion;
            EXIT WHEN  cuprogramacion%NOTFOUND;
            nuPosiperiodo := INSTR(sbparametros,'PEFACODI=') + 9;
            nuPosFinal := INSTR(sbparametros,'|',nuPosiperiodo,1);
            NUPERIODO := TO_CHAR(SUBSTR(sbparametros,nuPosiperiodo,nuPosFinal-nuPosiperiodo));

            IF  NUPERIODO = inuperiodo THEN
                pkg_ge_proc_sche_detail.prcObtDetalleProgramacion(nuprogramacion,tblDetalleProg);
                FOR I IN  1..tblDetalleProg.COUNT LOOP
                    nuPosiServ := INSTR(tblDetalleProg(I).PARAMETER,'SERVCODI=') + 9;
                    nuPosFinal := INSTR(tblDetalleProg(I).PARAMETER,'|',1,2);
                    nuTipoprod := SUBSTR(tblDetalleProg(I).PARAMETER,nuPosiServ,nuPosFinal-nuPosiServ);
                    IF  nuTipoprod = inuTipoprod THEN
                        blprogramado := TRUE;
                    END IF;
                END LOOP;
            END IF;
        END LOOP;
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        RETURN(blprogramado);


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
  END fblValidProgPeriodo;

   FUNCTION fnuCreaEncabezaRepo RETURN NUMBER  IS
     -- Variables
     csbMT_NAME   VARCHAR2(100) := csbSP_NAME || '.fnuCreaEncabezaRepo';
     nuIdReporte  NUMBER;
  BEGIN
    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);

	nuIdReporte := pkg_reportes_inco.fnuCrearCabeReporte ( 'PR_FACT_MA',
																'INCONSISTENCIAS PROCESOS DE FACTURAICON MASIVOS');

    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    RETURN nuIdReporte;
  EXCEPTION
	WHEN pkg_error.CONTROLLED_ERROR THEN
	   ROLLBACK;
		pkg_error.geterror(nuError,sbError);
		pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	   RETURN -1;
	WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.geterror(nuError,sbError);
		pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
		ROLLBACK;
		RETURN -1;
  END  fnuCreaEncabezaRepo;

  PROCEDURE prcCreaDetalleRepo(
        inuIdReporte    in repoinco.reinrepo%type,
        inuProduct      in repoinco.reinval1%type,
        isbError        in repoinco.reinobse%type,
        isbTipo         in repoinco.reindes1%type
    )
    IS
       -- Variables
        csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.prcCreaDetalleRepo';
        rcRepoinco repoinco%rowtype;
    BEGIN
    --{
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        nuConsecutivo := nuConsecutivo  + 1;
		pkg_reportes_inco.prCrearDetalleRepo( inuIdReporte,
                                              inuProduct,
                                              isbError,
                                              isbTipo,
                                              nuConsecutivo );

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
           	pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
           ROLLBACK;
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.geterror(nuError,sbError);
            pkg_traza.trace(' sbError => ' || sbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
            ROLLBACK;
  END prcCreaDetalleRepo;

  PROCEDURE PRCVALIPROFGCC(  iregPeriFact IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) is
   /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCVALIPROFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de validar las condiciones para ejecucion del periodo para Fgcc

      Parametros Entrada
       iregPeriFact  registro de periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
        csbMT_NAME      	VARCHAR2(100) := csbSP_NAME || '.PRCVALIPROFGCC';
        regPeriFact		pkg_bcldcgcam.cugetPeriodo%ROWTYPE;
        SBPROGRAMA          VARCHAR2(100) := 'FGCC';


        PROCEDURE prValidaPeriFact(regPerifactu   IN OUT pkg_bcldcgcam.cugetPeriodo%ROWTYPE) IS
            csbMT_NAME1      VARCHAR2(150) := csbMT_NAME || '.prValidaPeriFact';
            CSBEJECUCION	     CONSTANT VARCHAR2(1) := 'E';
            sbestaEjecu	PROCEJEC.PREJESPR%TYPE;
        BEGIN
            pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
            sbestaEjecu := PKG_BOGESTIONEJECUCIONPROCESOS.FSBOBTESTADOPROCESO(regPerifactu.PEFACODI, 'FGCC');

            IF ( sbestaEjecu = CSBEJECUCION ) THEN
                regPerifactu.PEFAFEGE := NVL(regPerifactu.PEFAFEGE,SYSDATE);
            ELSE
                regPerifactu.PEFAFEGE := SYSDATE;
            END IF;
            pkg_bogestionperiodos.prcvaliperiodoconsconf( regPerifactu.PEFACICL,
                                                          -1,
                                                          regPerifactu.PEFACODI);
            pkg_traza.trace( csbMT_NAME1, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

        END prValidaPeriFact;
   BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
		pkg_error.prInicializaError(onuError, osbError);
		regPeriFact := iregPeriFact;
        prValidaPeriFact(regPeriFact);

        PKG_BOGESTIONEJECUCIONPROCESOS.PRCVALIDAEJECUPROCESO
        (
            regPeriFact.PEFACODI,
            SBPROGRAMA,
            -1
        );

        prcValidProgPeriodo (SBPROGRAMA,regPeriFact.PEFACODI);

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
        WHEN pkg_error.CONTROLLED_ERROR THEN
             pkg_error.GETERROR(onuError, osbError);
             pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
	         pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
        WHEN OTHERS THEN
            pkg_error.setError;
            pkg_error.GETERROR(onuError, osbError);
            pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
            pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END  PRCVALIPROFGCC;

	PROCEDURE PRCPROGFGCC ( idtFechaProg IN DATE,
						   iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
						   isbCadenaCon IN VARCHAR2,
                           onuError OUT NUMBER,
                           osbError OUT VARCHAR2) IS
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCPROGFGCC
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FGCC

      Parametros Entrada
        idtFechaProg	fecha de programacion
	    iregPeriodo	registro de periodos
	    isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRCPROGFGCC';
     onuScheduleProcessAux NUMBER;
     isbParameters VARCHAR2(4000);
     isbWhat VARCHAR2(4000);
     inuExecutable     Sa_executable.executable_id%type := 5549;
     isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
	 regPeriodoProg      pkg_ldc_periprog.styPeriodoProgramado;
	 regPeriodoPrognull  pkg_ldc_periprog.styPeriodoProgramado;

    BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	 pkg_error.prInicializaError(onuError, osbError);
	 pkg_traza.trace('inuPeriodo => ' || iregPeriodo.pefacodi, pkg_traza.cnuNivelTrzDef);
	 pkg_traza.trace('idtFechaProg => ' || idtFechaProg, pkg_traza.cnuNivelTrzDef);

     pkg_traza.trace(' CICLO ['||iregPeriodo.PEFACICL||'] ANIO ['||iregPeriodo.PEFAANO||' MES ['||iregPeriodo.PEFAMES||'] FECHA ['||iregPeriodo.FECHA||']', 10);

     --Parametros
     isbParameters := 'PEFACODI='||iregPeriodo.pefacodi||'|PEFADESC='||iregPeriodo.PEFADESC||'|PEFACICL='||iregPeriodo.pefacicl||'|PEFAANO='||iregPeriodo.PEFAANO||'|PEFAMES='||iregPeriodo.PEFAMES||'|PEFAFEGE='||iregPeriodo.FECHA||'|PEFAFCCO='||to_char(sysdate, 'dd/mm/yyyy hh24:mi:ss')||'|CON='||isbCadenaCon||'|';

     pkg_traza.trace('isbParameters ['||isbParameters||']', 10);
     --Bloque anonimo con el que se fija la frecuencia de ejecucion del job
     pkg_gestionprocesosprogramados.prc_PrepararProceso( isbParameters,
															 'FGCC',
															 onuScheduleProcessAux);

      --se crea programacion
	  pkg_gestionprocesosprogramados.prc_creaProgramacion(onuScheduleProcessAux, isbFrecuency, idtFechaProg );
	  regPeriodoProg := regPeriodoPrognull;

	  regPeriodoProg.PEPRPEFA := iregPeriodo.pefacodi;
	  regPeriodoProg.PEPRCICL := iregPeriodo.pefacicl;
	  regPeriodoProg.PEPRPROG := onuScheduleProcessAux;
	  regPeriodoProg.PEPRUSUA := pkg_session.getUser;
	  regPeriodoProg.PEPRTERM := pkg_session.FSBGETTERMINAL;
	  regPeriodoProg.PEPRFEIN := idtFechaProg;
	  regPeriodoProg.PROCESO := 2;

	  --se inserta programacion por periodo
	  pkg_ldc_periprog.prInsertarPeriodoProgramado(regPeriodoProg);
      pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
           pkg_error.GETERROR(onuError, osbError);
           pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
           pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      WHEN OTHERS THEN
          pkg_error.setError;
          pkg_error.GETERROR(onuError, osbError);
          pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
		  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END  PRCPROGFGCC;

  PROCEDURE PRCPROGFGCA ( idtFechaProg IN DATE,
						 iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
						 isbCadenaCon IN VARCHAR2,
						 onuError OUT NUMBER,
                         osbError OUT VARCHAR2) IS
 /**************************************************************************
  Autor       : Horbath
  Proceso     : PRCPROGFGCA
  Fecha       : 2024-24-12
  Ticket      : OSF-3540
  Descripcion : proceso que se encarga de programar el proceso FGCC

  Parametros Entrada
   idtFechaProg	fecha de programacion
   iregPeriodo	registro de periodos
   isbCadenaCon	cadena de conexion
  Valor de salida
    onuError codigo de error
    osbError  mensaje de error
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
***************************************************************************/
	 csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRCPROGFGCA';

	 csbBloqueado         CONSTANT VARCHAR2(20) := 'BLOQUEADO' ;
	 csbEjecucion        CONSTANT VARCHAR2(20) := 'EJECUCION' ;
	 csbInconsistente    CONSTANT VARCHAR2(20) := 'INCONSISTENTE' ;
	 csbCaido            CONSTANT VARCHAR2(20) := 'CAIDO' ;
	 csbPendiente        CONSTANT VARCHAR2(20) := 'PENDIENTE' ;
	 csbAutorizado       CONSTANT VARCHAR2(20) := 'AUTORIZADO' ;
	--tabla de servicios pendientes
	 tblServpend         pkg_BOGestionEjecucionProcesos.stytServPendLiqui;
	 SBTIPOSERV          VARCHAR2(2);
	 SBSERVDESC          VARCHAR2(100);
	 NUINDEX             NUMBER :=1 ;
	 NUCICLO             NUMBER;

	 onuScheduleProcessAux NUMBER;

     isbParameters  	 VARCHAR2(4000);
     isbWhat 			 VARCHAR2(4000);
     inuExecutable     	 Sa_executable.executable_id%type := 5153;
     isbFrecuency      	 Ge_process_schedule.Frequency%type := 'UV';
	 regDetalleProg 	 pkg_ge_proc_sche_detail.styDetalleProgramacion;
	 regDetallePrognull  pkg_ge_proc_sche_detail.styDetalleProgramacion;
	 regPeriodoProg      pkg_ldc_periprog.styPeriodoProgramado;
	 regPeriodoPrognull  pkg_ldc_periprog.styPeriodoProgramado;
	 SBDESCESTADO        VARCHAR2(100);
    BEGIN
	   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	   pkg_error.prInicializaError(onuError, osbError);
	   pkg_traza.trace('inuPeriodo => ' || iregPeriodo.pefacodi, pkg_traza.cnuNivelTrzDef);
	   pkg_traza.trace('idtFechaProg => ' || idtFechaProg, pkg_traza.cnuNivelTrzDef);
	   SBTIPOSERV :=  '-' ;
       --Parametros
	   isbParameters := 'NULL=|PEFACODI='||iregPeriodo.pefacodi||'|PEFADESC='||iregPeriodo.PEFADESC||'|PEFACICL='||iregPeriodo.pefacicl||'|PEFAANO='||iregPeriodo.PEFAANO||'|PEFAMES='||iregPeriodo.PEFAMES||'|PEFAFEGE='||iregPeriodo.FECHA||'|NULL=|SERVTISE=-|CON='||isbCadenaCon||'|';
	   pkg_traza.trace('isbParameters ['||isbParameters||']', pkg_traza.cnuNivelTrzDef);

	   pkg_gestionprocesosprogramados.prc_PrepararProceso( isbParameters,
															 'FGCA',
															 onuScheduleProcessAux);

	   pkg_BOGestionEjecucionProcesos.prcObtServPendLiqu( iregPeriodo.pefacicl,
															iregPeriodo.pefacodi,
															SBTIPOSERV,
															tblServpend);

		--si hay datos pendientes
	   IF tblServpend.COUNT > 0 THEN
			FOR I IN tblServpend.FIRST..tblServpend.LAST LOOP
				IF NOT fblValidProgPeriodo('FGCA',  iregPeriodo.pefacodi, tblServpend(I).SERVCODI) THEN
				  IF tblServpend(I).SERVESTA = 'B' THEN
					SBDESCESTADO := csbBloqueado;
				  END IF;

				  IF tblServpend(I).SERVESTA = 'E' THEN
					SBDESCESTADO := csbEjecucion;
				  END IF;

				  IF tblServpend(I).SERVESTA = 'I' THEN
					SBDESCESTADO := csbInconsistente;
				  END IF;

				  IF tblServpend(I).SERVESTA = 'C' THEN
					SBDESCESTADO := csbCaido;
				  END IF;

					IF tblServpend(I).SERVESTA = 'P' THEN
					SBDESCESTADO := csbPendiente;
				  END IF;

				  IF tblServpend(I).SERVESTA = 'A' THEN
					SBDESCESTADO := csbAutorizado;
				  END IF;

				  SBSERVDESC := pkg_servicio.fsbObtDescripcion(tblServpend(I).SERVCODI);

				  regDetalleProg := regDetallePrognull;
				  --se inserta detalle de programacion
				  regDetalleProg.PROC_SCHE_DETAIL_ID := PKG_GESTIONSECUENCIAS.fnuSEQ_GE_PROC_SCHE_DETAIL;
				  regDetalleProg.PROCESS_SCHEDULE_ID := onuScheduleProcessAux;
				  regDetalleProg.SEQUENCE := NUINDEX;
				  regDetalleProg.PARAMETER := '|SERVCODI='||tblServpend(I).SERVCODI||'|SERVDESC='||SBSERVDESC||'|SERVESTA='||SBDESCESTADO||'|';

				  pkg_ge_proc_sche_detail.prInsertarDetalleProgram( regDetalleProg);

				  NUINDEX := NUINDEX + 1;
				END IF;
			END LOOP;
		END IF;
		--se crea programacion
		pkg_gestionprocesosprogramados.prc_creaProgramacion(onuScheduleProcessAux, isbFrecuency, idtFechaProg );
		regPeriodoProg := regPeriodoPrognull;

		regPeriodoProg.PEPRPEFA := iregPeriodo.pefacodi;
		regPeriodoProg.PEPRCICL := iregPeriodo.pefacicl;
		regPeriodoProg.PEPRPROG := onuScheduleProcessAux;
		regPeriodoProg.PEPRUSUA := pkg_session.getUser;
		regPeriodoProg.PEPRTERM := pkg_session.FSBGETTERMINAL;
		regPeriodoProg.PEPRFEIN := idtFechaProg;
		regPeriodoProg.PROCESO := 1;

		--se inserta programacion por periodo
		pkg_ldc_periprog.prInsertarPeriodoProgramado(regPeriodoProg);
	    pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);

    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
           pkg_error.GETERROR(onuError, osbError);
           pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
           pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      WHEN OTHERS THEN
          pkg_error.setError;
          pkg_error.GETERROR(onuError, osbError);
          pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
		  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END  PRCPROGFGCA;

  PROCEDURE 	PRCPROGFIDF( idtFechaProg IN DATE,
                            iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                            isbCadenaCon IN VARCHAR2,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRPROGFIDF
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FIDF

      Parametros Entrada
       idtFechaProg	fecha de programacion
       iregPeriodo	registro de periodos
       isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
      27/07/2021   ljlb       ca 696 se coloca orden en la programacion del proceso FIDF
      ***************************************************************************/
      csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRCPROGFIDF';
      onuScheduleProcessAux NUMBER;
      isbParameters VARCHAR2(4000);
      isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
      regPeriodoProg      pkg_ldc_periprog.styPeriodoProgramado;
	  regPeriodoPrognull  pkg_ldc_periprog.styPeriodoProgramado;
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(onuError, osbError);
        pkg_traza.trace('inuPeriodo => ' || iregPeriodo.pefacodi, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('idtFechaProg => ' || idtFechaProg, pkg_traza.cnuNivelTrzDef);

        isbParameters := '|ORDEN=r.route_id, funcion|PERIFACT='||iregPeriodo.pefacodi||'|CONDICION=|ESTAARCH=0|COPIAFIEL=S|MEDIO=GR|RUTASREPARTO=|TIPOSDOC=66|CON='||isbCadenaCon;

        pkg_traza.trace('isbParameters ['||isbParameters||']', 10);
        pkg_gestionprocesosprogramados.prc_PrepararProceso( isbParameters,
														  'FIDF',
														   onuScheduleProcessAux);

		pkg_gestionprocesosprogramados.prc_creaProgramacion(onuScheduleProcessAux, isbFrecuency, idtFechaProg );
		regPeriodoProg := regPeriodoPrognull;

		regPeriodoProg.PEPRPEFA := iregPeriodo.pefacodi;
		regPeriodoProg.PEPRCICL := iregPeriodo.pefacicl;
		regPeriodoProg.PEPRPROG := onuScheduleProcessAux;
		regPeriodoProg.PEPRUSUA := pkg_session.getUser;
		regPeriodoProg.PEPRTERM := pkg_session.FSBGETTERMINAL;
		regPeriodoProg.PEPRFEIN := idtFechaProg;
		regPeriodoProg.PROCESO := 3;

		--se inserta programacion por periodo
		pkg_ldc_periprog.prInsertarPeriodoProgramado(regPeriodoProg);
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
           pkg_error.GETERROR(onuError, osbError);
           pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
           pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      WHEN OTHERS THEN
          pkg_error.setError;
          pkg_error.GETERROR(onuError, osbError);
          pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
		  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END  PRCPROGFIDF;
    PROCEDURE PRCVALIPROFCPE(inuPeriodo IN NUMBER,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) IS
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCVALIPROFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de validar las condiciones para ejecucion del periodo para FCPE

      Parametros Entrada
       inuPeriodo  periodo de facturacion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
     csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRCVALIPROFCPE';
     SBPROGRAMA varchar2(40) := 'FCPE';

    BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     pkg_error.prInicializaError(onuError, osbError);
     PKG_BOGESTIONEJECUCIONPROCESOS.PRCVALIDAEJECUPROCESO( inuPeriodo, SBPROGRAMA, -1);
     prcValidProgPeriodo (SBPROGRAMA,inuPeriodo);
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
   EXCEPTION
     WHEN pkg_error.CONTROLLED_ERROR THEN
           pkg_error.GETERROR(onuError, osbError);
           pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
           pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      WHEN OTHERS THEN
          pkg_error.setError;
          pkg_error.GETERROR(onuError, osbError);
          pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
		  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END  PRCVALIPROFCPE;

    PROCEDURE 	PRCPROGFCPE( idtFechaProg IN DATE,
                            iregPeriodo  IN pkg_bcldcgcam.cugetPeriodo%ROWTYPE,
                            isbCadenaCon IN VARCHAR2,
                            onuError OUT NUMBER,
                            osbError OUT VARCHAR2) is
     /**************************************************************************
      Autor       : Horbath
      Proceso     : PRCPROGFCPE
      Fecha       : 2020-13-11
      Ticket      : 461
      Descripcion : proceso que se encarga de programar el proceso FCPE

      Parametros Entrada
        idtFechaProg	fecha de programacion
        iregPeriodo	registro de periodos
        isbCadenaCon	cadena de conexion
      Valor de salida
        onuError codigo de error
        osbError  mensaje de error
      HISTORIA DE MODIFICACIONES
      FECHA        AUTOR       DESCRIPCION
    ***************************************************************************/
       csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.PRCPROGFCPE';
       onuScheduleProcessAux NUMBER;

       isbParameters VARCHAR2(4000);
       nuPeriSigu NUMBER;
       nuReporte  REPORTES.REPONUME%TYPE;
       regPeriSigui  pkg_bcldcgcam.cugetPeriodo%ROWTYPE;
       isbFrecuency      Ge_process_schedule.Frequency%type := 'UV';
       regPeriodoProg      pkg_ldc_periprog.styPeriodoProgramado;
	   regPeriodoPrognull  pkg_ldc_periprog.styPeriodoProgramado;
    BEGIN
        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
        pkg_error.prInicializaError(onuError, osbError);
        pkg_traza.trace('iregPeriodo.pefacodi => ' || iregPeriodo.pefacodi, pkg_traza.cnuNivelTrzDef);
        pkg_traza.trace('idtFechaProg => ' || idtFechaProg, pkg_traza.cnuNivelTrzDef);

        --obtiene periodo siguiente
        pkg_bogestionperiodos.prcObtPeriodoFactSigu(iregPeriodo.pefacodi,nuPeriSigu);
        pkg_traza.trace('nuPeriSigu => ' || nuPeriSigu, pkg_traza.cnuNivelTrzDef);
        --se obtienen datos del periodo
        
        regPeriSigui := pkg_bcldcgcam.frcObtPeriodoFacturacion(nuPeriSigu);
        
        --se consulta reporte
        pkg_reportes_inco.prcInsPeriFactaProcRepoInc( iregPeriodo.pefacodi,
                                                    nuPeriSigu,
                                                    nuReporte );

        pkg_traza.trace('nuReporte => ' || nuReporte, pkg_traza.cnuNivelTrzDef);
        --Parametros
        isbParameters := 'NULL=|PEFACODI='||iregPeriodo.pefacodi||'|PEFADESC='||iregPeriodo.PEFADESC||'|PEFACICL='||iregPeriodo.pefacicl||'|PEFAANO='||iregPeriodo.PEFAANO||'|PEFAMES='||iregPeriodo.PEFAMES||'|PEFAFIMO='||iregPeriodo.pefafimo||'|PEFAFFMO='||iregPeriodo.pefaffmo||'|NULL=|FACTPEFA='||nuPeriSigu||'|CICLDESC='||iregPeriodo.PEFADESC||'|CICLCODI='||iregPeriodo.pefacicl||'|SSEFANO='||regPeriSigui.pefaano||'|SSEFMES='||regPeriSigui.pefames||'|PECSFECI='||regPeriSigui.pefafimo||'|PECSFECF='||regPeriSigui.pefaffmo||'|REPONUME='||RPAD(nuReporte,8,' ')||'|CON='||isbCadenaCon||'|';

        pkg_traza.trace('isbParameters ['||isbParameters||']', 10);


        pkg_gestionprocesosprogramados.prc_PrepararProceso( isbParameters,
														    'FCPE',
														    onuScheduleProcessAux);

		pkg_gestionprocesosprogramados.prc_creaProgramacion(onuScheduleProcessAux, isbFrecuency, idtFechaProg );
		regPeriodoProg := regPeriodoPrognull;

		regPeriodoProg.PEPRPEFA := iregPeriodo.pefacodi;
		regPeriodoProg.PEPRCICL := iregPeriodo.pefacicl;
		regPeriodoProg.PEPRPROG := onuScheduleProcessAux;
		regPeriodoProg.PEPRUSUA := pkg_session.getUser;
		regPeriodoProg.PEPRTERM := pkg_session.FSBGETTERMINAL;
		regPeriodoProg.PEPRFEIN := idtFechaProg;
		regPeriodoProg.PROCESO := 4;

		--se inserta programacion por periodo
		pkg_ldc_periprog.prInsertarPeriodoProgramado(regPeriodoProg);

        pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
    EXCEPTION
      WHEN pkg_error.CONTROLLED_ERROR THEN
           pkg_error.GETERROR(onuError, osbError);
           pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
		   pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      WHEN OTHERS THEN
          pkg_error.setError;
          pkg_error.GETERROR(onuError, osbError);
          pkg_traza.trace(' osbError => ' || osbError, pkg_traza.cnuNivelTrzDef);
		  pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
    END  PRCPROGFCPE;

  PROCEDURE prcObjeto( isbPeriodo    IN VARCHAR2,
                       inuCurrent    IN NUMBER,
                       inuTotal      IN NUMBER,
                       isbCadenaCon  IN VARCHAR2,
					   isbProceso    IN VARCHAR2,
					   isbFechaProg  IN VARCHAR2,
					   onuErrorcode  OUT ge_error_log.message_id%TYPE,
                       osbErrormess   OUT ge_error_log.description%TYPE) IS
 /***************************************************************************
	Propiedad Intelectual de Gases del Caribe
	Programa        : prcObjeto
	Descripcion     : proceso de ejecucion de la forma LDCGCAM

	Autor           : Luis Javier Lopez Barrios
	Fecha           : 22-11-2024

	Parametros de Entrada
	   isbPeriodo       periodo de facturacion
	   inuCurrent       valor actual
	   inuTotal         total
	   isbCadenaCon		cadena de conexion
	   isbProceso       proceso a programar
	   isbFechaProg		fecha de programacion
	Parametros de Salida
	   onuErrorcode      codigo de error
	   osbErrormess      mensaje de error
	Modificaciones  :
	=========================================================
	Autor       Fecha       Caso       Descripcion
	LJLB       22-11-2024   OSF-3540    Creacion
 ***************************************************************************/
   csbMT_NAME       	VARCHAR2(100) := csbSP_NAME || '.prcObjeto';
   dtFechaProg      	DATE;
   sbdateformat 		VARCHAR2(400):= LDC_BOCONSGENERALES.FSBGETFORMATOFECHA;
   nuPeriodo			NUMBER;
   regPeriodo          pkg_bcldcgcam.cugetPeriodo%ROWTYPE;

 BEGIN
	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
	pkg_traza.trace('isbPeriodo => ' || isbPeriodo, pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace('inuCurrent => ' || inuCurrent, pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace('inuTotal => ' || inuTotal, pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace('isbProceso => ' || isbProceso, pkg_traza.cnuNivelTrzDef);
	pkg_traza.trace('isbFechaProg => ' || isbFechaProg, pkg_traza.cnuNivelTrzDef);

	IF inucurrent = 1 THEN
	   nuIdReporte := fnuCreaEncabezaRepo;
	END IF;
	nuPeriodo := TO_NUMBER(isbPeriodo);
	--se obtienen datos del periodo
	
    regPeriodo:= pkg_bcldcgcam.frcObtPeriodoFacturacion(nuPeriodo);
	pkg_traza.trace(' CICLO ['||regPeriodo.PEFACICL||'] AniO ['||regPeriodo.PEFAANO||' MES ['||regPeriodo.PEFAMES||'] FECHA ['||regPeriodo.FECHA||']', pkg_traza.cnuNivelTrzDef);

	IF dtFechaProg IS NULL THEN
	   dtFechaProg := to_date(isbFechaProg,''||sbdateformat||'') + (NUMINUTOS * (1/24/60));
	ELSE
	   dtFechaProg := dtFechaProg + (NUMINUTOS * (1/24/60));
	END IF;

	IF isbProceso = 1 THEN
	   PRCPROGFGCA ( dtFechaProg,
					regPeriodo,
					isbCadenaCon,
					onuerrorcode,
					osberrormess);

		IF onuerrorcode <> 0 THEN
		  prcCreaDetalleRepo(nuIdReporte,nuPeriodo,'PROCESO FGCC, ERROR: '||osberrormess, 'S');
		END IF;
	ELSIF isbProceso = 2 THEN
	   --valida informacion del periodo
	   PRCVALIPROFGCC(regPeriodo, onuerrorcode, osberrormess);
	   IF onuerrorcode =  0 THEN
		  PRCPROGFGCC(dtFechaProg,
					 regPeriodo,
					 isbCadenaCon,
                     onuerrorcode,
                     osberrormess);

		  IF onuerrorcode <> 0 THEN
			 prcCreaDetalleRepo(nuIdReporte,nuPeriodo,'PROCESO FGCC, ERROR: '||osberrormess, 'S');
		  END IF;
	   ELSE
		  prcCreaDetalleRepo(nuIdReporte,nuPeriodo,'PROCESO FGCC, ERROR: '||osberrormess, 'S');
	   END IF;
	 ELSIF isbProceso = 3 THEN
	    PRCPROGFIDF( dtFechaProg,
					regPeriodo,
					isbCadenaCon,
                    onuerrorcode,
                    osberrormess);
	   IF onuerrorcode <> 0 THEN
		  prcCreaDetalleRepo(nuIdReporte,nuPeriodo,'PROCESO FIDF, ERROR: '||osberrormess, 'S');
	   END IF;
	 ELSE
		--valida informacion del periodo
		PRCVALIPROFCPE(nuPeriodo, onuerrorcode, osberrormess);
		IF  onuerrorcode =  0 THEN
		  PRCPROGFCPE( dtFechaProg,
					  regPeriodo,
					  isbCadenaCon,
                      onuerrorcode,
                      osberrormess);
		  IF onuerrorcode <> 0 THEN
			  prcCreaDetalleRepo(nuIdReporte,nuPeriodo,'PROCESO FCPE, ERROR: '||osberrormess, 'S');
		  END IF;
		ELSE
			prcCreaDetalleRepo(nuIdReporte,nuPeriodo,'PROCESO FCPE, ERROR: '||osberrormess, 'S');
		END IF;
	 END IF;
	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
 EXCEPTION
	WHEN pkg_error.CONTROLLED_ERROR THEN
		pkg_error.geterror(onuerrorcode,osberrormess);
		pkg_traza.trace(' osberrormess => ' || osberrormess, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
	WHEN OTHERS THEN
		pkg_error.setError;
		pkg_error.geterror(onuerrorcode,osberrormess);
		pkg_traza.trace(' osberrormess => ' || osberrormess, pkg_traza.cnuNivelTrzDef);
		pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  END prcObjeto;

  FUNCTION  frfConsulta(isbProceso  IN VARCHAR2,
                        isbFechaMov IN VARCHAR2) RETURN CONSTANTS_PER.TYREFCURSOR  IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : frfConsulta
    Descripcion     : funcion para retornar resultado de la forma LDCGCAM

    Autor           : Luis Javier Lopez Barrios
    Fecha           : 22-11-2024

    Parametros de Entrada
       isbProceso   proceso a ejecutar
       isbFechaMov  fecha final de movimiento
    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso       Descripcion
    LJLB       22-11-2024   OSF-3540    Creacion
***************************************************************************/
    csbMT_NAME      VARCHAR2(100) := csbSP_NAME || '.frfConsulta';
    rcResultado     CONSTANTS_PER.TYREFCURSOR;
 BEGIN
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbINICIO);
     pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);
     rcResultado := pkg_bcldcgcam.frfConsulta(isbProceso, isbFechaMov);
     RETURN rcResultado;
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

END pkg_boldcgcam;   
/
PROMPT OTORGA PERMISOS ESQUEMA sobre pkg_bOldcgcam
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_BOLDCGCAM', 'PERSONALIZACIONES'); 
END;
/