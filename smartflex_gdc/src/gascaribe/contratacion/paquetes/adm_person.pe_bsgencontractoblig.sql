CREATE OR REPLACE PACKAGE adm_person.PE_BSGenContractOblig AS
/*******************************************************************************
    Package	    : PE_BSGenContractOblig
    Descripcion	: Paquete BS para la Generación de Obligaciones a contratistas

    Autor	    : Javier Marin Guevara
    Fecha	    : 10-08-2021

    Historia de Modificaciones
    Fecha	            ID Entrega         Modificación
    10/07/2024          PAcosta            OSF-2893: Cambio de esquema ADM_PERSON
    10-08-2021  jmarin.SAO540745      Creacion
*******************************************************************************/
    ----------------------------------------------------------------------------
    -- Tipos públicos del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Objetos públicos del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Constantes públicas del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Cursores públicos del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Arreglos públicos del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Registros públicos del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Variables públicas del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Métodos públicos del paquete:
    ----------------------------------------------------------------------------
    FUNCTION fsbVersion
    RETURN VARCHAR2;

    -- Procedimiento para Generar de Obligaciones a contratistas
    PROCEDURE Process
    (
        inuPeriodId       IN  ge_periodo_cert.id_periodo%TYPE,
        idbCutOffDate     IN  ge_periodo_cert.fecha_final%TYPE,
        inuContractTypeId IN  ge_tipo_contrato.id_tipo_contrato%TYPE,
        inuContractorId   IN  ge_contrato.id_contratista%TYPE,
        inuAdminBaseId    IN  ge_base_administra.id_base_administra%TYPE,
        onuErrorCode      OUT ge_error_log.error_log_id%TYPE,
        osbErrorMessage   OUT ge_error_log.description%TYPE
    );

END PE_BSGenContractOblig;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PE_BSGenContractOblig AS
/*******************************************************************************
    Package	    : PE_BSGenContractOblig
    Descripcion	: Paquete BS para la Generación de Obligaciones a contratistas

    Autor	    : Javier Marin Guevara
    Fecha	    : 10-08-2021

    Historia de Modificaciones
    Fecha	    ID Entrega            Modificación
    10-08-2021  jmarin.SAO540745      Creacion
*******************************************************************************/
    ----------------------------------------------------------------------------
    -- Tipos privados del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Objetos privados del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Constantes privadas del paquete:
    ----------------------------------------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO.
    csbVERSION              constant    varchar2(20) := 'SAO540745';

	-- Nivel de traza
    cnuTRACE_LEVEL          constant    number := 20;

    ----------------------------------------------------------------------------
    -- Cursores privados del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Arreglos privados del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Registros privados del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Variables privadas del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Métodos privados del paquete:
    ----------------------------------------------------------------------------
    ----------------------------------------------------------------------------
    -- Métodos publicos del paquete:
    ----------------------------------------------------------------------------
    /***************************************************************************
    Unidad      :   fsbVersion
    Descripcion	:   Retorna la versión del SAO
    Autor       :   Javier Marin Guevara
    Fecha       :   10-08-2021

    Parametros              	Descripcion
    ============            	===================
    Entrada:
        No aplica
    Salida:
        No aplica
    Retorno:
        No aplica

    Historia de Modificaciones
    Fecha       Autor                   Modificacion
    ==========  ===================     ====================
    10-08-2021  jmarin.SAO540745        Creacion
    ***************************************************************************/
    FUNCTION fsbVersion
    RETURN VARCHAR2
    IS
    BEGIN
        -- Retorna el SAO con que se realizo la ultima entrega
        RETURN csbVERSION;
	EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END fsbVersion;

	/***************************************************************************
    Unidad      : Process
    Descripcion	: Procedimiento para la Generación de Obligaciones a contratistas
    Autor       : Javier Marin Guevara
    Fecha       : 10-08-2021

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
    10-08-2021  jmarin.SAO540745      Creacion
    ***************************************************************************/
    PROCEDURE Process
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
    BEGIN
    	UT_Trace.Trace( 'BEGIN PE_BSGenContractOblig.Process', cnuTRACE_LEVEL);

		-- Inicializa las variables de salida
        GE_BOUtilities.InitializeOutput(onuErrorCode, osbErrorMessage);

        -- Generación de Obligaciones a contratistas
        PE_BOGenContractOblig.Process
        (
            inuPeriodId,
            idbCutOffDate,
            inuContractTypeId,
            inuContractorId,
            inuAdminBaseId
        );

    	UT_Trace.Trace( 'END PE_BSGenContractOblig.Process', cnuTRACE_LEVEL);
    EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            errors.getError(onuErrorCode, osbErrorMessage);
        WHEN OTHERS THEN
            Errors.setError;
            errors.getError(onuErrorCode, osbErrorMessage);
    END Process;

END PE_BSGenContractOblig;
/
PROMPT Otorgando permisos de ejecucion a PE_BSGENCONTRACTOBLIG
BEGIN
    pkg_utilidades.praplicarpermisos('PE_BSGENCONTRACTOBLIG', 'ADM_PERSON');
END;
/
