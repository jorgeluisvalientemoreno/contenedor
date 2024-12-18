CREATE OR REPLACE TRIGGER ADM_PERSON.LDCTRGBUI_LDC_TT_TB
BEFORE UPDATE OR INSERT ON LDC_TT_TB
REFERENCING OLD AS OLD NEW AS NEW FOR EACH ROW
/*  Propiedad intelectual de GASES DE OCCIDENTE
    Trigger     :   LDCTRGBUI_LDC_TT_TB
    Descripción :   Trigger para la tabla "LDC_TT_TB"
					Parametrización de tipos de trabajo
					por tipos de bodega.
    Autor       :   Juan C. Ramírez C. (Optima Consulting)
    Fecha       :   24-OCT-2014

    Historial de modificaciones
    Fecha            IDEntrega
    24-OCT-2014      jcramirez
*/
DECLARE
    --Constantes
    cdtFechaFinal CONSTANT DATE := TO_DATE('31/12/4732 23:59:59','DD/MM/YYYY HH24:MI:SS'); --Fecha límite final
    csbFlagNo CONSTANT LDC_TT_TB.ACTIVE_FLAG%TYPE := 'N'; --Flag Desactivado
	csbFlagSi CONSTANT LDC_TT_TB.ACTIVE_FLAG%TYPE := 'Y'; --Flag Activado

    --Variables
    nuErrCode GE_ERROR_LOG.error_log_id%TYPE;
    sbErrMsg  GE_ERROR_LOG.description%TYPE;
    rcLdcTtTb LDC_TT_TB%ROWTYPE;
BEGIN
    --Inserción
    IF INSERTING THEN
        IF (:NEW.ACTIVE_FLAG <> csbFlagNo) THEN
            :NEW.disable_date := cdtFechaFinal;

        ELSE
            :NEW.disable_date := SYSDATE;
        END IF;
    END IF;

    --Actualización
    IF UPDATING THEN
	    IF (:NEW.ACTIVE_FLAG <> csbFlagNo) THEN
		    :NEW.disable_date := cdtFechaFinal;

		ELSE
		    :NEW.disable_date := SYSDATE;

		END IF;
    END IF;

	COMMIT;

EXCEPTION
    WHEN others THEN
        pkErrors.GetErrorVar(nuErrCode, sbErrMsg);
END LDCTRGBUI_LDC_TT_TB;
/
