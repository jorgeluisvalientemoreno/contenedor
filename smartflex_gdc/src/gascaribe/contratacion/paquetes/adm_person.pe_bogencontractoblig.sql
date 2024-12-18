CREATE OR REPLACE PACKAGE adm_person.PE_BOGenContractOblig AS
/*******************************************************************************
    Package	    : PE_BOGenContractOblig
    Descripcion	: Paquete BO para la Generación de Obligaciones a contratistas

    Autor	    : Javier Marin Guevara
    Fecha	    : 10-08-2021

    Historia de Modificaciones
    Fecha	    ID Entrega            Modificación
    10/07/2024  PAcosta               OSF-2893: Cambio de esquema ADM_PERSON  
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
        inuAdminBaseId    IN  ge_base_administra.id_base_administra%TYPE
    );

END PE_BOGenContractOblig;
/
CREATE OR REPLACE PACKAGE BODY adm_person.PE_BOGenContractOblig AS
/*******************************************************************************
    Package	    : PE_BOGenContractOblig
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
    csbVERSION              CONSTANT    VARCHAR2(20) := 'SAO540745';

	-- Nivel de traza
    cnuTRACE_LEVEL          CONSTANT    NUMBER := 40;

    -- Mensajes
    cnuGENERIC_NUMBER       CONSTANT    ge_message.message_id%type := 2741;


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
        inuAdminBaseId    IN  ge_base_administra.id_base_administra%TYPE
    )
    IS
        rcPeriod             dage_periodo_cert.styGE_periodo_cert;
        tbContracts          dage_contrato.tytbId_Contrato;
        tbCertificates       dage_acta.tytbId_Acta;
        nuContractCounter    NUMBER := 0;
        nuCertificateCounter NUMBER := 0;
        sbImpriActas         VARCHAR2(1) := 'N';

        PROCEDURE ValidateData
        IS
        BEGIN
            UT_Trace.Trace( 'BEGIN PE_BOGenContractOblig.Process.ValidateData', cnuTRACE_LEVEL);

            -- Valida que el código del periodo no sea nulo (Obligatorio)
            IF (inuPeriodId IS NULL) THEN
                GE_BOErrors.setErrorCodeArgument(cnuGENERIC_NUMBER, 'El periodo de certificación no puede ser nulo.');
                RAISE ex.CONTROLLED_ERROR;

            -- Valida la existencia del periodo en la base de datos
            ELSIF (inuPeriodId IS NOT NULL) THEN
                DAge_periodo_cert.acckey(inuPeriodId);
            END IF;

            -- Valida que la fecha de corte no sea nula (Obligatorio)
            IF (idbCutOffDate IS NULL) THEN
                GE_BOErrors.setErrorCodeArgument(cnuGENERIC_NUMBER, 'La fecha de corte no puede ser nula.');
                RAISE ex.CONTROLLED_ERROR;

            -- Valida que la fecha de corte no sea superior a la fecha del sistema
            ELSIF (idbCutOffDate IS NOT NULL) THEN
                IF (idbCutOffDate > SYSDATE) THEN
                    GE_BOErrors.setErrorCodeArgument(cnuGENERIC_NUMBER, 'La fecha de corte no puede ser mayor a la del sistema.');
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
            END IF;

            -- Valida la existencia del Tipo de contrato en la base de datos
            IF (inuContractTypeId IS NOT NULL) THEN
                DAge_tipo_contrato.acckey(inuContractTypeId);
            END IF;

            -- Valida la existencia del contratista en la base de datos
            IF (inuContractorId IS NOT NULL) THEN
                DAge_contratista.acckey(inuContractorId);
            END IF;

            -- Valida la existencia de la base administrativa en la base de datos
            IF (inuAdminBaseId IS NOT NULL) THEN
                DAge_base_administra.acckey(inuAdminBaseId);
            END IF;

            UT_Trace.Trace( 'END PE_BOGenContractOblig.Process.ValidateData', cnuTRACE_LEVEL);
        EXCEPTION
            WHEN ex.CONTROLLED_ERROR THEN
                UT_Trace.Trace( 'ERROR PE_BOGenContractOblig.Process.ValidateData', cnuTRACE_LEVEL);
                RAISE ex.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                UT_Trace.Trace( 'ERROR OTHERS PE_BOGenContractOblig.Process.ValidateData', cnuTRACE_LEVEL);
                Errors.setError;
                RAISE ex.CONTROLLED_ERROR;
        END ValidateData;

        PROCEDURE ProcessContract
        (
            inuContractId    ge_contrato.id_contrato%type
        )
        IS
            tbNoAdminBaseLiqCertifs     CT_BCLiquidationSupport.tytbCertificateId;
            tbNoAdminBaseBillCertifs    CT_BCLiquidationSupport.tytbCertificateId;
            tbLiqCertificates           CT_BCLiquidationSupport.tytbCertificateId;
            tbBillCertificates          CT_BCLiquidationSupport.tytbCertificateId;
        BEGIN
            UT_Trace.Trace( 'BEGIN PE_BOGenContractOblig.Process.ProcessContract', cnuTRACE_LEVEL);

            -- Se limpia la tabla temporal
            CT_BCLiquidationSupport.ClearTMPOrdersTable;

            -- Se generan sus obligaciones
            CT_BOLiquidationProcess.GenerateContractOblig
            (
                inuPeriodId,
                inuContractId,
                inuAdminBaseId,
                idbCutOffDate,
                tbNoAdminBaseLiqCertifs,
                tbNoAdminBaseBillCertifs,
                tbLiqCertificates,
                tbBillCertificates,
                FALSE,
                tbCertificates
            );

            nuContractCounter := nuContractCounter + 1;
            nuCertificateCounter := nuCertificateCounter + tbCertificates.COUNT;

            --Si se imprimen las actas generadas
            IF ( (sbImpriActas = ge_boconstants.csbYES) AND (tbCertificates.COUNT > 0)) THEN
                --Se marca cada acta para impresión
                FOR n IN tbCertificates.FIRST..tbCertificates.LAST LOOP
                    --Se adiciona a la tablaPL para la impresion de las Actas
                    --para que se pueda leer desde .NET CTIAS y CTIMA.
                    ct_bocertificate.addCertifToPrintTablePL(tbCertificates(n));
                END LOOP;
                -- Se establece CTIASCOMP para ejecutarse al finalizar el proceso
                GE_BOIOpenExecutable.SetOnEvent(72,'POST_REGISTER');
            END IF;

            UT_Trace.Trace( 'END PE_BOGenContractOblig.Process.ProcessContract', cnuTRACE_LEVEL);
        EXCEPTION
            WHEN ex.CONTROLLED_ERROR THEN
                UT_Trace.Trace( 'ERROR PE_BOGenContractOblig.Process.ProcessContract', cnuTRACE_LEVEL);
                -- Enviar al log (ct_process_log)
                CT_BoProcessLog.registerProcessLog(inuContractId, inuPeriodId, idbCutOffDate, NULL, NULL, NULL);
            WHEN OTHERS THEN
                UT_Trace.Trace( 'ERROR OTHERS PE_BOGenContractOblig.Process.ProcessContract', cnuTRACE_LEVEL);
                Errors.setError;
                -- Enviar al log (ct_process_log)
                CT_BoProcessLog.registerProcessLog(inuContractId, inuPeriodId, idbCutOffDate, NULL, NULL, NULL);
        END ProcessContract;

    BEGIN
    	UT_Trace.Trace( 'BEGIN PE_BOGenContractOblig.Process', cnuTRACE_LEVEL);

        -- Validar parametros
        ValidateData;

        -- Se consulta la información del periodo
        dage_periodo_cert.getrecord(inuPeriodId, rcPeriod);

        -- Se consultan los contratos abiertos a procesar
        CT_BCContract.GetOpenContractsToProcess
        (
            inuContractTypeId,
            inuContractorId,
            idbCutOffDate,
            rcPeriod.fecha_inicial,
            rcPeriod.fecha_final,
            tbContracts
        );

        IF (tbContracts.COUNT = 0) THEN
            Errors.setError(6482);
            RAISE ex.CONTROLLED_ERROR;
        END IF;

        -- Se limpia el cache de las listas de costos
        GE_BOCertContratista.LimpiarCacheValorItemLista;

        -- Limpiar la tabla de actas a imprimir
        CT_BOCertificate.clearPrintTablePL;

        --Por cada contrato consultado
        FOR n IN tbContracts.FIRST..tbContracts.LAST LOOP
            ProcessContract(tbContracts(n));
        END LOOP;

    	UT_Trace.Trace( 'END PE_BOGenContractOblig.Process', cnuTRACE_LEVEL);
	EXCEPTION
        WHEN ex.CONTROLLED_ERROR THEN
            UT_Trace.Trace( 'ERROR PE_BOGenContractOblig.Process', cnuTRACE_LEVEL);
            RAISE ex.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_Trace.Trace( 'ERROR OTHERS PE_BOGenContractOblig.Process', cnuTRACE_LEVEL);
            Errors.setError;
            RAISE ex.CONTROLLED_ERROR;
    END Process;

END PE_BOGenContractOblig;
/
PROMPT Otorgando permisos de ejecucion a PE_BOGENCONTRACTOBLIG
BEGIN
    pkg_utilidades.praplicarpermisos('PE_BOGENCONTRACTOBLIG', 'ADM_PERSON');
END;
/