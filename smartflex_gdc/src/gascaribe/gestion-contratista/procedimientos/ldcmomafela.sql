create or replace procedure ldcmomafela(inuProgramacion IN ge_process_schedule.process_schedule_id%type) IS
/**************************************************************************
    Autor       : John Jairo Jimenez Marimon
    Fecha       : 2017-12-25
    Descripcion : Actualizamos fecha maxima de legalizacion a tipos de trabajos permitidos

    Parametros Entrada
      nuano Año
      numes Mes

    Valor de salida
      sbmen  mensaje
      error  codigo del error

   HISTORIA DE MODIFICACIONES
	16/02/2018 200-1756  SE MODIFICA PARA ACTUALIZAR LA FECHA MAXIMA DE LEGALIZACIÃN
	20/02/2025 OSF-3889  Se implementan nuevas pautas de desarrollo.
***************************************************************************/


sbParametros       ge_process_schedule.parameters_%TYPE;
nuHilos            NUMBER := 1;
nuLogProceso       ge_log_process.log_process_id%TYPE;
sbOrdenes          VARCHAR2(4000);
dtFechaMaxLegActu  DATE;
sbObservacion      or_log_order_action.error_message%TYPE;
csbMT_NAME		   VARCHAR2(200) := 'LDCMOMAFELA';
nuError			   NUMBER;
sbError			   VARCHAR2(4000);
	

BEGIN

  pkg_gestionprocesosprogramados.prc_agregalogalproceso(inuprogramacion,nuhilos,nulogproceso);
 -- Se obtiene parametros
 sbParametros      := pkg_gestionprocesosprogramados.fsbobtparametrosproceso(inuProgramacion);
 sbOrdenes         := pkg_gestionprocesosprogramados.fsbobtvalorparametroproceso(sbParametros,'NAME','|','=');
 dtFechaMaxLegActu := to_date(pkg_gestionprocesosprogramados.fsbobtvalorparametroproceso(sbParametros,'EVAL_LAST_DATE','|','='),'DD/MM/YYYY HH24:MI:SS');
 sbObservacion     := pkg_gestionprocesosprogramados.fsbobtvalorparametroproceso(sbParametros,'ERROR_MESSAGE','|','=');
 
 pkg_boldcmomafela.prcObjeto(sbOrdenes,sbObservacion,dtFechaMaxLegActu);
 
 COMMIT;
 
  pkg_gestionprocesosprogramados.prc_actestadologproceso(nuLogProceso,'F');

EXCEPTION
 WHEN OTHERS THEN
 ROLLBACK;
  pkg_Error.setError;
  pkg_Error.getError(nuError, sbError);
  pkg_traza.trace('sbError: ' || sbError, pkg_traza.cnuNivelTrzDef);
  pkg_traza.trace(csbMT_NAME, pkg_traza.cnuNivelTrzDef, pkg_traza.csbFIN_ERR);
  pkg_gestionprocesosprogramados.prc_actestadologproceso(nuLogProceso,'F');
  RAISE pkg_Error.Controlled_Error;
END;
/