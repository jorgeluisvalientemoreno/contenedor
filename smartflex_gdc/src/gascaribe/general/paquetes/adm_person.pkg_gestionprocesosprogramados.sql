create or replace PACKAGE adm_person.pkg_gestionprocesosprogramados
IS
    /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_gestionprocesosprogramados </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Gestiona los procesos programados
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------


    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
            <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_prepararEjecucion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Prepara la ejecución
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prc_prepararEjecucion(inuejecutableId	IN  SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
									isbParametros   IN  GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE,
									isbWhat         IN  GE_PROCESS_SCHEDULE.WHAT%TYPE,
									onuProcesoId 	OUT GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
									inuProcesoId 	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE DEFAULT PKCONSTANTE.NULLNUM
									);

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_creaProgramacion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Crea la programación
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prc_creaProgramacion(inuProcesoId  	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
								   isbFrequencia	IN  GE_PROCESS_SCHEDULE.FREQUENCY%TYPE,
								   idtFecha         IN  DBA_JOBS.NEXT_DATE%TYPE
								  );

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_programarproceso </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Programa el proceso a ejecutar
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prc_programarproceso(isbParametros	IN	Ge_process_schedule.parameters_%type,
								   isbProcessName	IN 	sa_executable.name%type
								  );

    PROCEDURE prc_PrepararProceso( isbParametros	IN	Ge_process_schedule.parameters_%type,
								   isbProcessName	IN 	sa_executable.name%type,
                                   onuProcesoId 	OUT GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE);
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prc_PrepararProceso
        Descripcion     : prepara proceso para su programacion

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 20-12-2024

        Parametros de Entrada
            isbParametros   parametros de la programcion
            isbProcessName  nombre del ejecutable            
        Parametros de Salida
           onuProcesoId     codigo de la programacion
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       20-12-2024   OSF-3741    Creacion
     ***************************************************************************/ 
                                  
    FUNCTION frfObtProgramacionxEjecu (inuEjecutableId  IN  sa_executable.executable_id%TYPE) RETURN CONSTANTS_PER.TYREFCURSOR;
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frfObtProgramacionxEjecu
        Descripcion     : proceso que devuelve programacion por ejecutable

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 10-12-2024

        Parametros de Entrada
            inuEjecutableId  id del ejecutable       
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       10-12-2024   OSF-3741    Creacion
     ***************************************************************************/
     -- Agrega log a un proceso programado		  
    PROCEDURE prc_AgregaLogAlProceso
    (
        inuProgramacion  	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE, 
        inuHilos            IN  NUMBER,
        onuLogProceso       OUT NUMBER
    );
    
    -- Obtiene el valor de los parámetros del proceso programado
    FUNCTION fsbObtParametrosProceso
    (
        inuProgramacion  	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE
    )    
    RETURN GE_PROCESS_SCHEDULE.parameters_%TYPE;
    
    -- Actualiza el estado del log del proceso
    PROCEDURE prc_ActEstadoLogProceso
    ( 
        inuLogProceso   IN  NUMBER, 
        isbEstado       IN  VARCHAR2
    );
    
    -- Obtiene el valor de un parametro de la lista de entrada
    FUNCTION fsbObtValorParametroProceso
    (
        isbListaParametros  IN  GE_PROCESS_SCHEDULE.parameters_%TYPE,
        isbParametro        IN  GE_PROCESS_SCHEDULE.parameters_%TYPE,
        isbSeparadorLista   IN  VARCHAR2 DEFAULT '|',
        isbSeparadorValor   IN  VARCHAR2 DEFAULT '='            
    )    
    RETURN GE_PROCESS_SCHEDULE.parameters_%TYPE;  

END pkg_gestionprocesosprogramados;
/
create or replace PACKAGE BODY  adm_person.pkg_gestionprocesosprogramados IS
 /******************************************************************
    <Package Fuente="Propiedad Intelectual de GDC">
    <Unidad> pkg_gestionprocesosprogramados </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Gestiona los procesos programados
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
     </Historial>
     </Package>
    ******************************************************************/

    --------------------------------------------
    -- Constantes
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3741';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

    -----------------------------------
    -- Variables privadas del package
    -----------------------------------
    sbErrorMensage			VARCHAR2(2000);
    nuError                 NUMBER;
    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------

    /**************************************************************************
    <FUNCTION Fuente="Propiedad Intelectual de GDC">
    <Unidad> fsbVersion </Unidad>
    <Autor> Jhon.Erazo </Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Obtiene la version del paquete.
    </Descripcion>
    <Retorno Nombre="Versión del paquete" Tipo="VARCHAR2">
        Versión del paquete
    </Retorno>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </FUNCTION>
    **************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        return CSBVERSION;
    END fsbVersion;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_prepararEjecucion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Prepara la ejecución
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prc_prepararEjecucion(inuejecutableId	IN  SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
									isbParametros   IN  GE_PROCESS_SCHEDULE.PARAMETERS_%TYPE,
									isbWhat         IN  GE_PROCESS_SCHEDULE.WHAT%TYPE,
									onuProcesoId 	OUT GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
									inuProcesoId 	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE DEFAULT PKCONSTANTE.NULLNUM
									)
    IS

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_prepararEjecucion';

		nuError				NUMBER;
		sbmensaje			VARCHAR2(1000);

    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		-- Prepara la ejecución
		GE_BOSchedule.PrepareSchedule(inuejecutableId,
									  isbParametros,
									  isbWhat,
									  onuProcesoId,
									  inuProcesoId
									  );

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
    END prc_prepararEjecucion;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_creaProgramacion </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Crea la programación
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prc_creaProgramacion(inuProcesoId  	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE,
								   isbFrequencia	IN  GE_PROCESS_SCHEDULE.FREQUENCY%TYPE,
								   idtFecha         IN  DBA_JOBS.NEXT_DATE%TYPE
								  )
    IS

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_creaProgramacion';

		nuError				NUMBER;
		sbmensaje			VARCHAR2(1000);

    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		-- Prepara la ejecución
		GE_BOSchedule.Scheduleprocess(inuProcesoId,
									  isbFrequencia,
									  idtFecha
									  );

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
    END prc_creaProgramacion;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_programarproceso </Unidad>
    <Autor> Jhon Eduar Erazo</Autor>
    <Fecha> 24-07-2024 </Fecha>
    <Descripcion>
        Programa el proceso a ejecutar
    </Descripcion>
    <Historial>
           <Modificacion Autor="Jhon.Erazo" Fecha="24-07-2024" Inc="OSF-3016" Empresa="GDC">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/
    PROCEDURE prc_programarproceso(isbParametros	IN	Ge_process_schedule.parameters_%type,
								   isbProcessName	IN 	sa_executable.name%type
								  )
    IS

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_programarproceso';

		nuError				NUMBER;
		nuScheduleProcess	Ge_process_schedule.process_schedule_id%type	:= NULL;
		nuExecutable     	Sa_executable.executable_id%type				:= NULL;
		sbmensaje			VARCHAR2(1000);
		sbWhat           	Ge_process_schedule.what%type					:= NULL;
		sbFrecuency      	Ge_process_schedule.Frequency%type 				:= 'UV';
		dtNextDate			DATE;

		CURSOR cuExecutableId IS
            SELECT a.executable_id
            FROM sa_executable a
            WHERE a.name = isbProcessName;

		CURSOR cuNextDate IS
			SELECT TO_DATE(SYSDATE + (1 * (2/24/60)),'DD-MM-YYYY HH24:MI:SS')
			FROM DUAL;

    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);

		pkg_traza.trace('isbParametros: ' || isbParametros, cnuNVLTRC);

		-- Obtiene la secuencia del proceso a ejecutar
		nuScheduleProcess := PKG_GESTIONSECUENCIAS.fnuSEQ_GE_PROCESS_SCHEDULE;

		pkg_traza.trace('nuScheduleProcess: ' || nuScheduleProcess, cnuNVLTRC);

		IF (cuExecutableId%ISOPEN) THEN
			CLOSE cuExecutableId;
		END IF;

		-- Obtiene el Identificador del ejecutable
		open cuExecutableId;
		fetch cuExecutableId INTO nuExecutable;
		close cuExecutableId;

		pkg_traza.trace('nuExecutable: ' || nuExecutable, cnuNVLTRC);

		IF (cuNextDate%ISOPEN) THEN
			CLOSE cuNextDate;
		END IF;

		open cuNextDate;
		fetch cuNextDate INTO dtNextDate;
		close cuNextDate;

		pkg_traza.trace('dtNextDate: ' || dtNextDate, cnuNVLTRC);

		sbWhat := 'BEGIN
				    SetSystemEnviroment;
					Errors.Initialize;'||
					isbProcessName||'( '||nuScheduleProcess||' );
					if( DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcess||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
						GE_BOSchedule.InactiveSchedule( '||nuScheduleProcess||' );
					end if;
					EXCEPTION
						when OTHERS then
							Errors.SetError;
							if( DAGE_Process_Schedule.fsbGetFrequency( '||nuScheduleProcess||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
								GE_BOSchedule.DropSchedule( '||nuScheduleProcess||' );
							end if;
					END;';

		pkg_traza.trace('sbWhat: ' || sbWhat, cnuNVLTRC);

		-- Prepara la ejecución
		prc_prepararEjecucion(nuExecutable,
							  isbParametros,
							  sbWhat,
							  nuScheduleProcess,
							  nuScheduleProcess
							  );

		--se crea programacion
		prc_creaProgramacion(nuScheduleProcess,
							 sbFrecuency,
							 dtNextDate
							 );

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
    END prc_programarproceso;
        PROCEDURE prc_PrepararProceso(isbParametros	IN	Ge_process_schedule.parameters_%type,
								   isbProcessName	IN 	sa_executable.name%type,
                                   onuProcesoId 	OUT GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE) IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : prc_PrepararProceso
        Descripcion     : prepara proceso para su programacion

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 20-12-2024

        Parametros de Entrada
            isbParametros   parametros de la programcion
            isbProcessName  nombre del ejecutable           
        Parametros de Salida
            onuProcesoId     codigo de la programacion
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       20-12-2024   OSF-3741    Creacion
     ***************************************************************************/

		csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_PrepararProceso';

		nuError				NUMBER;
		nuExecutable     	Sa_executable.executable_id%type				:= NULL;
		sbmensaje			VARCHAR2(1000);
		sbWhat           	Ge_process_schedule.what%type					:= NULL;
		sbFrecuency      	Ge_process_schedule.Frequency%type 				:= 'UV';
		
		CURSOR cuExecutableId IS
        SELECT a.executable_id
        FROM sa_executable a
        WHERE a.name = isbProcessName;

    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
		pkg_traza.trace('isbParametros: ' || isbParametros, cnuNVLTRC);
        pkg_traza.trace('isbProcessName: ' || isbProcessName, cnuNVLTRC);
		-- Obtiene la secuencia del proceso a ejecutar
		onuProcesoId := PKG_GESTIONSECUENCIAS.fnuSEQ_GE_PROCESS_SCHEDULE;

		pkg_traza.trace('onuProcesoId: ' || onuProcesoId, cnuNVLTRC);

		IF (cuExecutableId%ISOPEN) THEN
			CLOSE cuExecutableId;
		END IF;

		-- Obtiene el Identificador del ejecutable
		open cuExecutableId;
		fetch cuExecutableId INTO nuExecutable;
		close cuExecutableId;

		sbWhat := 'BEGIN
				    SetSystemEnviroment;
					Errors.Initialize;'||
					isbProcessName||'( '||onuProcesoId||' );
					if( DAGE_Process_Schedule.fsbGetFrequency( '||onuProcesoId||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
						GE_BOSchedule.InactiveSchedule( '||onuProcesoId||' );
					end if;
					EXCEPTION
						when OTHERS then
							Errors.SetError;
							if( DAGE_Process_Schedule.fsbGetFrequency( '||onuProcesoId||' ) in ( GE_BOSchedule.csbSoloUnaVez, GE_BOSchedule.csbSoloUnaVezDH ) ) then
								GE_BOSchedule.DropSchedule( '||onuProcesoId||' );
							end if;
					END;';

		pkg_traza.trace('sbWhat: ' || sbWhat, cnuNVLTRC);

		-- Prepara la ejecución
		prc_prepararEjecucion(nuExecutable,
							  isbParametros,
							  sbWhat,
							  onuProcesoId,
                              onuProcesoId);

		

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbmensaje);
			pkg_traza.trace('nuError: ' || nuError || ' sbmensaje: ' || sbmensaje, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
    END prc_PrepararProceso;
    FUNCTION frfObtProgramacionxEjecu (inuEjecutableId  IN  sa_executable.executable_id%TYPE) RETURN CONSTANTS_PER.TYREFCURSOR IS
    /***************************************************************************
        Propiedad Intelectual de Gases del Caribe
        Programa        : frfObtProgramacionxEjecu
        Descripcion     : proceso que devuelve programacion por ejecutable

        Autor           : Luis Javier Lopez Barrios
        Fecha           : 10-12-2024

        Parametros de Entrada
            inuEjecutableId  id del ejecutable       
        Parametros de Salida
        Modificaciones  :
        =========================================================
        Autor       Fecha       Caso       Descripcion
        LJLB       10-12-2024   OSF-3741    Creacion
     ***************************************************************************/
      csbMT_NAME  	      VARCHAR2(150) := csbSP_NAME || 'frfObtProgramacionxEjecu';
      rfCuProgramacion    CONSTANTS_PER.TYREFCURSOR;
    BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, csbInicio);
        pkg_traza.trace('inuEjecutableId: ' || inuEjecutableId, cnuNVLTRC);
        rfCuProgramacion := GE_BCPROCESS_SCHEDULE.FRFGETSCHEDULESBYAPLICATION(inuEjecutableId);
        pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
        RETURN rfCuProgramacion;
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbErrorMensage);
			pkg_traza.trace('nuError: ' || nuError || ' sbErrorMensage: ' || sbErrorMensage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC);
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbErrorMensage);
			pkg_traza.trace('nuError: ' || nuError || ' sbErrorMensage: ' || sbErrorMensage, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR);
			RAISE pkg_Error.Controlled_Error;
   END frfObtProgramacionxEjecu;

   	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_AgregaLogAlProceso </Unidad>
    <Autor> Lubin Pineda </Autor>
    <Fecha> 20-01-2025 </Fecha>
    <Descripcion> 
        Agrega log a un proceso programado
    </Descripcion>
    <Historial>
           <Modificacion Autor="Lubin.Pineda" Fecha="20-01-2025" Inc="OSF-3870" Empresa="EFI">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/	
    PROCEDURE prc_AgregaLogAlProceso
    (
        inuProgramacion  	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE, 
        inuHilos            IN  NUMBER,
        onuLogProceso       OUT NUMBER
    )
    IS
    
        csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_AgregaLogAlProceso';
        nuError             NUMBER;
        sbError           VARCHAR2(4000);
    		
    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		ge_boschedule.AddLogToScheduleProcess(inuProgramacion,inuHilos,onuLogProceso);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prc_AgregaLogAlProceso;


	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> fsbObtParametrosProceso </Unidad>
    <Autor> Lubin Pineda </Autor>
    <Fecha> 20-01-2025 </Fecha>
    <Descripcion> 
        Obtiene el valor de los parámetros del proceso programado
    </Descripcion>
    <Historial>
           <Modificacion Autor="Lubin.Pineda" Fecha="20-01-2025" Inc="OSF-3870" Empresa="EFI">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/	    
    FUNCTION fsbObtParametrosProceso
    (
        inuProgramacion  	IN  GE_PROCESS_SCHEDULE.PROCESS_SCHEDULE_ID%TYPE
    )    
    RETURN GE_PROCESS_SCHEDULE.parameters_%TYPE
    IS
        csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fsbObtParametrosProceso';
        nuError             NUMBER;
        sbError           VARCHAR2(4000);
        
        sbParametrosProceso  GE_PROCESS_SCHEDULE.parameters_%TYPE;
        
        CURSOR cuObtParametrosProceso
        IS
        SELECT parameters_
        FROM GE_PROCESS_SCHEDULE
        WHERE process_schedule_id = inuProgramacion;
        
    BEGIN
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		IF cuObtParametrosProceso%ISOPEN THEN CLOSE cuObtParametrosProceso; END IF;
		
		OPEN cuObtParametrosProceso;
		FETCH cuObtParametrosProceso INTO sbParametrosProceso;
		CLOSE cuObtParametrosProceso;
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbParametrosProceso;
		
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
            RETURN sbParametrosProceso;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
            RETURN sbParametrosProceso;
    END fsbObtParametrosProceso;

	/**************************************************************************
    <PROCEDURE Fuente="Propiedad Intelectual de <Empresa>">
    <Unidad> prc_ActEstadoLogProceso </Unidad>
    <Autor> Lubin Pineda </Autor>
    <Fecha> 20-01-2025 </Fecha>
    <Descripcion> 
        Actualiza el estado del log del proceso programado
    </Descripcion>
    <Historial>
           <Modificacion Autor="Lubin.Pineda" Fecha="20-01-2025" Inc="OSF-3870" Empresa="EFI">
               Creación
           </Modificacion>
    </Historial>
    </PROCEDURE>
    **************************************************************************/	
    PROCEDURE prc_ActEstadoLogProceso
    ( 
        inuLogProceso   IN  NUMBER, 
        isbEstado       IN  VARCHAR2
    )
    IS
        csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'prc_ActEstadoLogProceso';
        nuError             NUMBER;
        sbError           VARCHAR2(4000);
    BEGIN

		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);
		
		ge_boschedule.changelogProcessStatus(inuLogProceso,isbEstado);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);

    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
			RAISE pkg_error.CONTROLLED_ERROR;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
			RAISE pkg_Error.Controlled_Error;
    END prc_ActEstadoLogProceso;
                
    -- Obtiene el valor de un parametro de la lista de entrada
    FUNCTION fsbObtValorParametroProceso
    (
        isbListaParametros  IN  GE_PROCESS_SCHEDULE.parameters_%TYPE,
        isbParametro        IN  GE_PROCESS_SCHEDULE.parameters_%TYPE,
        isbSeparadorLista   IN  VARCHAR2 DEFAULT '|',
        isbSeparadorValor   IN  VARCHAR2 DEFAULT '='            
    )    
    RETURN GE_PROCESS_SCHEDULE.parameters_%TYPE
    IS
        csbMT_NAME  		VARCHAR2(70) := csbSP_NAME || 'fsbObtValorParametro';
        nuError             NUMBER;
        sbError             VARCHAR2(4000);
        
        sbValorParametro    GE_PROCESS_SCHEDULE.parameters_%TYPE;
                
    BEGIN
    
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbINICIO);

        sbValorParametro := ut_string.getparametervalue(isbListaParametros,isbParametro,isbSeparadorLista,isbSeparadorValor);
		
		pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN);
		
		RETURN sbValorParametro;
		
    EXCEPTION
		WHEN pkg_error.CONTROLLED_ERROR THEN
			pkg_error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERC); 
            RETURN sbValorParametro;
		WHEN others THEN
			pkg_Error.setError;
			pkg_Error.getError(nuError, sbError);
			pkg_traza.trace('nuError: ' || nuError || ' sbError: ' || sbError, cnuNVLTRC);
			pkg_traza.trace(csbMT_NAME, cnuNVLTRC, pkg_traza.csbFIN_ERR); 
            RETURN sbValorParametro;
    END fsbObtValorParametroProceso;
       
END pkg_gestionprocesosprogramados;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_GESTIONPROCESOSPROGRAMADOS', 'ADM_PERSON'); 
END;
/