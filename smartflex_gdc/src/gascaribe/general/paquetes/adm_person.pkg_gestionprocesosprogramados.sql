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

END pkg_gestionprocesosprogramados;
/
create or replace PACKAGE BODY  adm_person.pkg_gestionprocesosprogramados
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
    -- Constantes
    --------------------------------------------
    csbVERSION          CONSTANT VARCHAR2(10) := 'OSF-3016';
    csbSP_NAME          CONSTANT VARCHAR2(100):= $$PLSQL_UNIT||'.';
    cnuNVLTRC           CONSTANT NUMBER       := pkg_traza.cnuNivelTrzDef;
	csbInicio   		CONSTANT VARCHAR2(35) := pkg_traza.fsbINICIO;

    -----------------------------------
    -- Variables privadas del package
    -----------------------------------

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

END pkg_gestionprocesosprogramados;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('PKG_GESTIONPROCESOSPROGRAMADOS', 'ADM_PERSON'); 
END;
/