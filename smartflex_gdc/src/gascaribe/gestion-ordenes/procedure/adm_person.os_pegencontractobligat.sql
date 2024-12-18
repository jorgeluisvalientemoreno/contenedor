CREATE OR REPLACE PROCEDURE adm_person.os_pegencontractobligat
(
    inuPeriodId       IN  ge_periodo_cert.id_periodo%TYPE,
    idbCutOffDate     IN  ge_periodo_cert.fecha_final%TYPE,
    inuContractTypeId IN  ge_tipo_contrato.id_tipo_contrato%TYPE,
    inuContractorId   IN  ge_contrato.id_contratista%TYPE,
    inuAdminBaseId    IN  ge_base_administra.id_base_administra%TYPE,
    onuErrorCode      OUT ge_error_log.error_log_id%TYPE,
    osbErrorMessage   OUT ge_error_log.description%TYPE
)
IS
	/***************************************************************************
    Unidad      : OS_PEGenContractObligat
    Descripcion	: API para la Generación de Obligaciones a contratistas

    Autor       : Javier Marin Guevara
    Fecha       : 11-08-2021

    Parametros              	Descripcion
    ============            	===================
    Entrada:
        inuPeriodId             Código del periodo (Obligatorio)
        idbCutOffDate           Fecha de corte (Obligatorio)
        inuContractTypeId       Código de Tipo de contrato (Opcional)
        inuContractorId         Código de contratista (Opcional)
        inuAdminBaseId          Código de la Base administrativa (Opcional)
    Salida:
        onuErrorCode            Código de Error
                                    0 - Terminó con éxito.
                                    <> 0 - Código de error.
        osbErrorMessage         Descripción de Error
                                    '-'- Terminó con éxito.
                                    <> '-' - Mensaje de error.
    Retorno:
        No aplica.

    Historia de Modificaciones
    Fecha       Autor                 Modificacion
    ==========  ===================   ====================
    11-08-2021  jmarin.SAO540745      Creacion
    20/05/2024  Adrianavg             OSF-2673: Migrar del esquema OPEN al esquema ADM_PERSOM
    ***************************************************************************/
    cnuTRACE_LEVEL  CONSTANT    NUMBER := 1;

BEGIN
    UT_Trace.Trace('BEGIN OS_PEGenContractObligat', cnuTRACE_LEVEL);

    -- Generar Obligaciones a contratistas
    PE_BSGenContractOblig.Process
    (
        inuPeriodId,
        idbCutOffDate,
        inuContractTypeId,
        inuContractorId,
        inuAdminBaseId,
        onuErrorCode,
        osbErrorMessage
    );

    UT_Trace.Trace('END OS_PEGenContractObligat',cnuTRACE_LEVEL);
EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        Errors.GetError(onuErrorCode, osbErrorMessage);
    WHEN OTHERS THEN
        Errors.SetError;
        Errors.GetError(onuErrorCode, osbErrorMessage);
END Os_Pegencontractobligat;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre OS_PEGENCONTRACTOBLIGAT
BEGIN
    pkg_utilidades.prAplicarPermisos('OS_PEGENCONTRACTOBLIGAT', 'ADM_PERSON'); 
END;
/