CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_GE_CONTRATO_BU02
BEFORE UPDATE OF STATUS ON GE_CONTRATO
FOR EACH ROW
DECLARE
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 26-10-2021
	Ticket: 807
	Descripcion:    Disparador para controlar el cierre de contratos que no tienen solicitud de aprobacion

	Historia de modificaciones
	Fecha		Autor			Descripcion
	26-10-2021	horbath			Creacion

	******************************************************************************************/
    -- Constantes:

    -- Esta constante se debe modificar cada vez que se entregue el objeto con
    -- un SAO.
    csbVersion CONSTANT VARCHAR2(20) := 'CA807';

    -- Constantes para manejo de pila de errores.
    csbSP_NAME  CONSTANT VARCHAR2(32) := $$PLSQL_UNIT||'.';
    csbPUSH     CONSTANT VARCHAR2(50) := 'Inicia ';
    csbPOP      CONSTANT VARCHAR2(50) := 'Finaliza ';
    csbPOP_ERC  CONSTANT VARCHAR2(50) := '*Finaliza con error controlado ';
    csbPOP_ERR  CONSTANT VARCHAR2(50) := '*Finaliza con error ';
    csbLDC      CONSTANT VARCHAR2(50) := '[LDC]';
    -- Nivel de traza TR.
    cnuLEVELPUSHPOP             CONSTANT NUMBER := 1;
    cnuLEVEL                    CONSTANT NUMBER := 10;
    --Variables:
    sbMethodName        VARCHAR2(50) := 'LDC_TRG_GE_CONTRATO_BU02';
    nuIdContrato        NUMBER;
    nuValidation        NUMBER;
    nuIdTipoContrato    ge_contrato.id_tipo_contrato%TYPE;
    sbParam             VARCHAR2(2000);
    nuCount             NUMBER;
    --Cursores:
    CURSOR cuExistSol
    (
        inuContratoId   IN  ge_contrato.id_contrato%TYPE
    )
    IS
        SELECT COUNT(*)
        FROM ldc_reqclose_contract
        WHERE id_contrato = inuContratoId
        AND state_request = 'A';

BEGIN
    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
        IF FBLAPLICAENTREGAXCASO('0000807') THEN

            nuIdTipoContrato := :old.id_tipo_contrato;
            ut_trace.trace('nuIdTipoContrato: '||nuIdTipoContrato,1);
            nuIdContrato     := :new.id_contrato;
            ut_trace.trace(':new.status: '||:new.status,1);

            IF (:new.status = 'CE') THEN
                ut_trace.trace(':new.status: '||:new.status,1);
                IF (cuExistSol%ISOPEN) THEN
                    CLOSE cuExistSol;
                END IF;

                OPEN cuExistSol(nuIdContrato);
                FETCH cuExistSol INTO nuCount;
                IF (cuExistSol%NOTFOUND) THEN
                    nuCount := 0;
                END IF;
                CLOSE cuExistSol;

                IF (nuCount = 0) THEN
                    ge_boerrors.seterrorcodeargument
                    (
                        Ld_Boconstans.cnuGeneric_Error,
                        'No es posible cerrar el contrato, dado que no tiene una solicitud de cierre de contrato aprobada.'
                    );
                    RAISE ex.CONTROLLED_ERROR;
                END IF;
            END IF;
        END IF;
    ut_trace.trace(csbLDC||csbSP_NAME||csbPOP||sbMethodName,cnuLEVELPUSHPOP);
EXCEPTION
    WHEN LOGIN_DENIED OR ex.CONTROLLED_ERROR OR pkConstante.exERROR_LEVEL2 THEN
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERC||sbMethodName,cnuLEVEL);
        Errors.pop;
        RAISE  ex.CONTROLLED_ERROR;
    WHEN OTHERS THEN
        Errors.SetError;
        ut_trace.trace(csbLDC||csbSP_NAME||csbPOP_ERR||sbMethodName,cnuLEVEL);
        Errors.pop;
        RAISE  ex.CONTROLLED_ERROR;
END LDC_TRG_GE_CONTRATO_BU02;
/
