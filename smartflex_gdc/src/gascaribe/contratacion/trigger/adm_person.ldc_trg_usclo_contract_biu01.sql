CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_USCLO_CONTRACT_BIU01
BEFORE INSERT OR UPDATE ON LDC_USERCLOSE_CONTRACT
FOR EACH ROW
DECLARE
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 26-10-2021
	Ticket: 807
	Descripcion: 	Disparador para controlar la configuracion de los usuarios solicitantes y
                    aprobadores de cierre de contratos

	Historia de modificaciones
	Fecha		Autor			Descripcion
	25-10-2021	horbath			Creacion Trigger

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
    sbMethodName        VARCHAR2(50) := 'LDC_TRG_USCLO_CONTRACT_BIU01';
    nuExist             NUMBER;

    CURSOR cuUser
    (
        isbUser IN  VARCHAR2
    )
    IS
        SELECT COUNT(*)
        FROM sa_user a
        WHERE a.mask = isbUser;

BEGIN
    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);

        IF fblaplicaentregaxcaso('0000807') THEN

            IF(:NEW.USER_REQUEST_APROVE = :NEW.USER_APROVE) THEN

                ge_boerrors.seterrorcodeargument
                (
                    2741,
                    'No se permite configurar el mismo usuario como solicitante y aprobador'
                );
                RAISE ex.CONTROLLED_ERROR;
            END IF;


            nuExist := 0;

            OPEN cuUser(:NEW.USER_REQUEST_APROVE);
            FETCH cuUser INTO nuExist;
            CLOSE cuUser;

            --Se valida si los procesos de facturacion ya terminaron
            IF(nuExist = 0 OR nuExist IS NULL) THEN

                ge_boerrors.seterrorcodeargument
                (
                    2741,
                    'El usuario solicitante ['||:NEW.USER_REQUEST_APROVE||'] no existe en Smart Flex'
                );
                RAISE ex.CONTROLLED_ERROR;
            END IF;

            nuExist := 0;

            OPEN cuUser(:NEW.USER_APROVE);
            FETCH cuUser INTO nuExist;
            CLOSE cuUser;

            --Se valida si los procesos de facturacion ya terminaron
            IF(nuExist = 0 OR nuExist IS NULL) THEN

                ge_boerrors.seterrorcodeargument
                (
                    2741,
                    'El usuario aprobador ['||:NEW.USER_APROVE||'] no existe en Smart Flex'
                );
                RAISE ex.CONTROLLED_ERROR;
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
END LDC_TRG_USCLO_CONTRACT_BIU01;
/
