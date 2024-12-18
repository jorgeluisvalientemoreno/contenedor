CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRGBU_AB_INFO_PREMISE
BEFORE UPDATE ON AB_INFO_PREMISE
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/**************************************************************************
    Propiedad Intelectual de PETI
    trigger     :   LDC_TRGBU_AB_INFO_PREMISE
    Descripcion :   Trigger que continua la ejecucion
	                del flujo de negocio "Venta de Gas por Formulario IFRS"
					para los predios no anillados que se anillen.
    Autor       :   Juan C. Ramírez - Optima Consulting
    Fecha       :   10-DIC-2013

    Historia de Modificaciones
    Fecha               Autor                  Modificacion
    =========           =========              ================
    10-DIC-2013         jcramirez              Creacion.
**************************************************************************/
DECLARE
    --------------
	--Constantes
	--------------
	csbIsRingY  CONSTANT    open.AB_INFO_PREMISE.is_ring%TYPE         :=  'Y';      --Flag el predio es anillado
	csbIsRingN  CONSTANT    open.AB_INFO_PREMISE.is_ring%TYPE         :=  'N';      --Flag el predio no es anillado
	cnuVForIFRS CONSTANT    open.PS_PACKAGE_TYPE.package_type_id%TYPE := 100249;    --Tramite Venta de Gas por Formulario IFRS
	cnuUnTyVaGa CONSTANT    open.WF_UNIT_TYPE.unit_type_id%TYPE       := 100617;    --Tipo de unidad, Validar Gasificacion (Actividad)
	cnuWFStaEsp CONSTANT    open.WF_INSTANCE_STATUS.instance_status_id%TYPE :=  4;  --Estado de la Instancia, Esperando Respuesta

	-------------
	--Variables
	-------------
    nuPackageId open.MO_PACKAGES.package_id%TYPE;
	nuErrCode   open.GE_ERROR_LOG.error_log_id%TYPE;
    sbErrMsg    open.GE_ERROR_LOG.description%TYPE;

	------------
	--Cursores
	------------
	--Cursor para obtener las solicitudes del predio
	CURSOR cuSolicitudesPredio
	(
	inuPremiseId open.AB_PREMISE.premise_id%TYPE
	)
	IS
	    SELECT pa.package_id
		FROM ab_premise pr, ab_address ad, mo_packages pa
		WHERE pr.premise_id = inuPremiseId
		AND ad.estate_number = pr.premise_id
		AND pa.address_id = ad.address_id
		AND pa.package_type_id IN (cnuVForIFRS);

	--Cursor para obtener las actividades de una solicitud
	CURSOR cuActividadesSolicitud
	(
	inuPackageId open.MO_PACKAGES.package_id%TYPE
	)
	IS
	    SELECT *
		FROM open.mo_wf_pack_interfac
		WHERE package_id = inuPackageId;

	rcActividadSolicitud cuActividadesSolicitud%ROWTYPE;

BEGIN
    ut_trace.trace('Inicia LDC_TRGBU_AB_INFO_PREMISE ',8);

	--Verifica si el valor del campo "Es anillado" cambia a "Y".
	IF :NEW.is_ring = csbIsRingY AND :OLD.is_ring <> csbIsRingY THEN

		--Obtiene las solicitudes detenidas para el predio no anillado
		BEGIN
		    OPEN cuSolicitudesPredio(:NEW.premise_id);
			LOOP
			    FETCH cuSolicitudesPredio INTO nuPackageId;
				EXIT WHEN cuSolicitudesPredio%NOTFOUND;

				--Valida si el flujo se encuentra detenido en la actividad "Validar Gasificacion".
				IF LD_BOcancellations.fnuWorkFlowStandBy(nuPackageId,cnuUnTyVaGa,cnuWFStaEsp) = ld_boconstans.cnuonenumber THEN

				    --Obtiene actividades de la solicitud
					BEGIN
					    OPEN cuActividadesSolicitud(nuPackageId);
						LOOP
						    FETCH cuActividadesSolicitud INTO rcActividadSolicitud;
							EXIT WHEN cuActividadesSolicitud%NOTFOUND;

        				    --Empuja el flujo para la solicitud
		        			mo_bowf_pack_interfac.PrepNotToWfPack(rcActividadSolicitud.package_id
				        	                                     ,rcActividadSolicitud.action_id
						        								 ,MO_BOCausal.fnuGetSuccess
								        						 ,MO_BOStatusParameter.fnuGetSTA_ACTIV_STANDBY
										        				 ,FALSE);
						END LOOP;
				        CLOSE cuActividadesSolicitud;
					EXCEPTION
            		    WHEN others THEN
			                IF cuActividadesSolicitud%ISOPEN THEN
    	    		    	    CLOSE cuActividadesSolicitud;
	    	        		END IF;
					END;

				END IF;

			END LOOP;
			CLOSE cuSolicitudesPredio;
		EXCEPTION
		    WHEN others THEN
			    IF cuSolicitudesPredio%ISOPEN THEN
				    CLOSE cuSolicitudesPredio;
				END IF;
		END;
	END IF;

	ut_trace.trace('Finaliza LDC_TRGBU_AB_INFO_PREMISE ',8);
EXCEPTION
    WHEN others THEN
        pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDC_TRGBU_AB_INFO_PREMISE;
/
