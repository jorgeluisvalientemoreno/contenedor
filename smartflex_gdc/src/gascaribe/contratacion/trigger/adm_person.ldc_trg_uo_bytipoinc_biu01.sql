CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_UO_BYTIPOINC_BIU01
BEFORE INSERT ON LDC_UO_BYTIPOINC
FOR EACH ROW
DECLARE
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 26-07-2021
	Ticket: 709
	Descripcion: 	Disparador para controlar la insercion de unidades operativas compartidas
                    en contratos con diferente tipo de incremento

	Historia de modificaciones
	Fecha		Autor			Descripcion
	26-07-2021	horbath			Creacion de paquete BC

	******************************************************************************************/
    -- Constantes:

    -- Esta constante se debe modificar cada vez que se entregue el objeto con
    -- un SAO.
    csbVersion CONSTANT VARCHAR2(20) := 'CA709';

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
    sbMethodName        VARCHAR2(50) := 'LDC_TRG_UO_BYTIPOINC_BIU01';
    nuIdContrato        NUMBER;
    nuOperatingUnit     or_operating_unit.operating_unit_id%TYPE;
    sbIncrementType     VARCHAR2(1);
    blValidation        BOOLEAN;
BEGIN

    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
    IF FBLAPLICAENTREGAXCASO('0000709') THEN

		nuIdContrato := :new.id_contrato;
        nuOperatingUnit := :new.operating_unit_id;
        blValidation := TRUE;
        sbIncrementType := null;

        IF (daldc_tipoinc_bycon.fblExist(nuIdContrato)) THEN
            sbIncrementType := daldc_tipoinc_bycon.fsbgetincrement_type(nuIdContrato, null);

            blValidation := ldc_pe_bogestlist.fblValTipoInc(nuIdContrato,nuOperatingUnit,sbIncrementType);

            IF NOT (blValidation) THEN
                ge_boerrors.seterrorcodeargument
                (
                    Ld_Boconstans.cnuGeneric_Error,
                    'La unidad operativa ['||nuOperatingUnit||'] existe en otros contratos con un tipo de incremento diferente al seleccionado.'
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
END LDC_TRG_UO_BYTIPOINC_BIU01;
/
