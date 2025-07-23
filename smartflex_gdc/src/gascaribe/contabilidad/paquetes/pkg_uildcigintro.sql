create or replace package pkg_uildcigintro AS

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retorna la version del paquete

    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  FUNCTION fsbVersion RETURN VARCHAR2;

 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : procesa la informacion para PB LDCIGINTRO

    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/

  PROCEDURE prcObjeto;
  
  END pkg_uildcigintro;
  
  /
  
  create or replace PACKAGE BODY pkg_uildcigintro IS

   -- Constantes para el control de la traza
  csbSP_NAME     CONSTANT VARCHAR2(200):= $$PLSQL_UNIT||'.';
  -- Identificador del ultimo caso que hizo cambios
  csbVersion     VARCHAR2(200) := 'OSF-4202';

  FUNCTION fsbVersion RETURN VARCHAR2 IS
  /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : fsbVersion
    Descripcion     : Retona el identificador del ultimo caso que hizo cambios
    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Modificaciones  :
    Autor       Fecha       Caso       Descripcion
  ***************************************************************************/
  BEGIN
    RETURN csbVersion;
  END fsbVersion;



PROCEDURE prcObjeto IS
 /***************************************************************************
    Propiedad Intelectual de Gases del Caribe
    Programa        : prcObjeto
    Descripcion     : proceso para PB LDCIGINTRO

    Autor           : Jhon Jairo Soto
    Fecha           : 10-04-2025

    Parametros de Entrada

    Parametros de Salida

    Modificaciones  :
    =========================================================
    Autor       Fecha       Caso        Descripcion
  ***************************************************************************/


	  onuErrorCode    	 NUMBER;
	  osbErrorMessage 	 VARCHAR2(4000);
      csbMT_NAME  		 VARCHAR2(200) := csbSP_NAME || 'prcObjeto';

      cnunull_attribute  CONSTANT NUMBER := 2126;
      sbpefafimo         ge_boinstancecontrol.stysbvalue;
      sbpefaffmo         ge_boinstancecontrol.stysbvalue;
      sbTipoInterfaz     ge_boinstancecontrol.stysbvalue;
      sbDias             ge_boinstancecontrol.stysbvalue;
      nuIdProgProc       ge_process_schedule.process_schedule_id%TYPE;
      dtfechaini         DATE;
      dtfechafin         DATE;
      nuDias_Retraso     NUMBER;
	  
	  sbJobDiario		 VARCHAR2(2) := 'DI';
	  sbSoloUnaVez		 VARCHAR2(2) := 'UV';

      rcProgramacion    dage_process_schedule.styge_process_schedule;
      sbFrecuencia      ge_process_schedule.frequency%TYPE;



BEGIN

	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbInicio);


    --<<Se realiza la asignacion de los valores de los campos a las variables definidas>>--
    sbpefafimo := ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_PROCMONI', 'PRMOFEIN');

    sbpefaffmo := ge_boinstancecontrol.fsbgetfieldvalue ('LDCI_PROCMONI', 'PRMOFEFI');
	
    sbTipoInterfaz := ge_boinstancecontrol.fsbgetfieldvalue  ('LDCI_TIPOINTERFAZ', 'TIPOINTERFAZ');

    sbDias := ge_boInstanceControl.fsbGetFieldValue ('LDCI_ENCAINTESAP', 'NUM_DOCUMENTOSAP');

    --<<VAlida los parametros del reporte que no esten en Nullo-->>
    IF (sbTipoInterfaz IS NULL) THEN
        pkg_error.setErrorMessage (cnunull_attribute, 'Debe Indicar Tipo Interfaz ');
    END IF;

    --<<VAlida los parametros del reporte -->>
    IF (sbTipoInterfaz NOT IN ('L2','LA','L5') AND sbDias IS NOT NULL ) THEN
        pkg_error.setErrorMessage (1260, 'Fechas validas. Existe inconsistencia en los criterios ingresados [Dias de retraso] No se permite para ese tipo de interfaz ['||sbTipoInterfaz||']');
    END IF;

    nuDias_Retraso    := to_number(sbDias);

    -- Obtiene la programacion en memoria
    nuIdProgProc := ge_boschedule.fnugetscheduleinmemory;

    rcProgramacion := dage_process_schedule.frcgetrecord(nuIdProgProc);

    sbFrecuencia:= rcProgramacion.frequency;


    IF (sbpefafimo IS NOT NULL AND sbpefaffmo IS NULL) THEN
		pkg_error.setErrorMessage(1260, 'El atributo Fecha Final no puede ser nulo');
    END IF;


    IF (sbpefafimo IS NULL AND sbpefaffmo IS NOT NULL) THEN
		pkg_error.setErrorMessage(1260, 'El atributo Fecha Inicial no puede ser nulo');
    END IF;


    IF (sbpefafimo IS NOT NULL AND sbpefaffmo IS NOT NULL) THEN
        IF (nuDias_Retraso IS NOT NULL) THEN
			pkg_error.setErrorMessage(1260, 'Si ingreso fecha inicial y fecha final no debe poner dias de retraso');
        END IF;
    END IF;


    IF (sbpefafimo IS NULL AND sbpefaffmo IS NULL) THEN
        IF (nuDias_Retraso IS NULL) THEN
			pkg_error.setErrorMessage(1260, 'No ingreso fecha inicial y fecha final, debe ingresar dias de retraso');
        END IF;
    END IF;

    IF (sbFrecuencia NOT IN (sbSoloUnaVez,sbJobDiario)) THEN
			pkg_error.setErrorMessage(1260, 'El atributo Frecuencia debe ser sólo una vez o diaria');
    END IF;


    IF (sbFrecuencia = sbJobDiario)THEN
        IF (sbpefafimo IS NOT NULL AND sbpefaffmo IS NOT NULL) THEN
			pkg_error.setErrorMessage(1260, 'Los atributos Fecha Inicial y Fecha Final NO deben tener valor');
        END IF;

        IF (nuDias_Retraso IS NULL) THEN
			pkg_error.setErrorMessage(1260, 'si ingreso fecha inicial y fecha final, debe ingresar días de retraso');
        END IF;

        IF ( nuDias_Retraso < 0 ) THEN  
			pkg_error.setErrorMessage(1260, 'El atributo dias retraso debe ser mayor o igual que cero');
        END IF;

        sbpefafimo  := TRUNC(SYSDATE-nuDias_Retraso);
        sbpefaffmo  := TRUNC(SYSDATE-nuDias_Retraso);

    END IF;


    IF (sbFrecuencia = sbSoloUnaVez)THEN

        IF (sbpefafimo IS NULL AND sbpefaffmo IS NULL) THEN
			pkg_error.setErrorMessage(1260, 'Los atributos Fecha Inicial y Fecha Final deben tener valor');
        END IF;


        IF (nuDias_Retraso IS NOT NULL) THEN
			pkg_error.setErrorMessage(1260, 'Si ingreso fecha inicial y fecha final, no debe ingresar días de retraso');
        END IF;

    END IF;

    dtfechaini  := UT_DATE.FDTDATEWITHFORMAT(sbpefafimo);
    dtfechafin  := UT_DATE.FDTDATEWITHFORMAT(sbpefaffmo);

    pkgeneralservices.valdaterange
    (
        sbpefafimo,
        dtfechafin
    );


	pkg_traza.trace( csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN);


EXCEPTION
    WHEN pkg_Error.Controlled_Error THEN
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERC);
      RAISE pkg_error.Controlled_Error;
    WHEN OTHERS THEN
      pkg_Error.setError;
      pkg_Error.getError(onuErrorCode, osbErrorMessage);
      pkg_traza.trace('osbErrorMessage: ' || osbErrorMessage, pkg_traza.cnuNivelTrzDef);
      pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
      RAISE pkg_Error.Controlled_Error;
END prcObjeto;


END pkg_uildcigintro;
/
PROMPT Otorgando permisos de ejecución 
BEGIN
    pkg_utilidades.prAplicarPermisos(upper('pkg_uildcigintro'), upper('open'));
END;
/


