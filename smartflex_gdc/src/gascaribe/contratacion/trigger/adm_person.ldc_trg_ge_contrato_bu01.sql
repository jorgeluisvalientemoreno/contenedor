CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_GE_CONTRATO_BU01
BEFORE UPDATE OF STATUS ON GE_CONTRATO
FOR EACH ROW
DECLARE
    /******************************************************************************************
	Autor: horbath / Horbath
	Fecha: 27-07-2021
	Ticket: 709
	Descripcion:    Disparador para controlar la apertura de contratos que requieren configuracion
                    de tipo de incremento

	Historia de modificaciones
	Fecha		Autor			Descripcion
	26-07-2021	horbath			Creacion

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
    sbMethodName        VARCHAR2(50) := 'LDC_TRG_GE_CONTRATO_BU01';
    nuIdContrato        NUMBER;
    nuValidation        NUMBER;
    nuIdTipoContrato    ge_contrato.id_tipo_contrato%TYPE;
    sbParam             VARCHAR2(2000);
    nuCount             NUMBER;
	tbOperUnit              ldc_pe_bcgestlist.ttyrcOuByConTi;
    tbOperUnit_Empty        ldc_pe_bcgestlist.ttyrcOuByConTi;
    nuCountDif              NUMBER;
    rcldc_tipoinc_byconE    daldc_tipoinc_bycon.styldc_tipoinc_bycon;
	sbTipoInc               VARCHAR2(1);


    --Cursores:
    CURSOR cuOperUnit
    (
        inuContratoId   IN  ge_contrato.id_contrato%TYPE
    )
    IS
        SELECT COUNT(*)
        FROM ldc_uo_bytipoinc
        WHERE id_contrato = inuContratoId;

BEGIN
    ut_trace.trace(csbLDC||csbSP_NAME||csbPUSH||sbMethodName,cnuLEVELPUSHPOP);
	IF FBLAPLICAENTREGAXCASO('0000709') THEN

		    nuIdTipoContrato := :old.id_tipo_contrato;
        sbParam := null;
        ut_trace.trace('nuIdTipoContrato: '||nuIdTipoContrato,1);
        ut_trace.trace(':new.status: '||:new.status,1);

        IF (:old.status='RG' AND :new.status = 'AB') THEN

            ut_trace.trace(':new.status: '||:new.status,1);
            sbParam := dald_parameter.fsbGetValue_Chain('LDC_VALTINC_BYTTCON');

            ut_trace.trace('sbParam: '||sbParam,1);
            nuIdContrato := :new.id_contrato;
            IF ((sbParam is null) or  (','||sbParam||',' NOT LIKE '%,'||nuIdTipoContrato||',%')) THEN

                ut_trace.trace('nuIdContrato: '||nuIdContrato,1);

                    IF (cuOperUnit%ISOPEN) THEN
                        CLOSE cuOperUnit;
                    END IF;

                    OPEN cuOperUnit(nuIdContrato);
                    FETCH cuOperUnit INTO nuCount;
                    CLOSE cuOperUnit;

                    IF (nuCount = 0) THEN
                        ge_boerrors.seterrorcodeargument
                        (
                            Ld_Boconstans.cnuGeneric_Error,
                            'Debe relacionar las unidades operativas.'
                        );
                        RAISE ex.CONTROLLED_ERROR;
                    END IF;
            END IF;
            sbTipoInc := DALDC_TIPOINC_BYCON.fsbGetINCREMENT_TYPE(nuIdContrato, NULL);
            if sbTipoInc is null THEN
							ge_boerrors.seterrorcodeargument
							(
								Ld_Boconstans.cnuGeneric_Error,
								'Debe configurar el tipo de incremento.'
							);
							RAISE ex.CONTROLLED_ERROR;
						end if;
						tbOperUnit := tbOperUnit_Empty;
						nuCountDif := 0;
						nuCount	   := 0;
						ldc_pe_bcgestlist.pGetOuByConTi
						  (
							  nuIdContrato,
							  tbOperUnit
						  );

						IF (tbOperUnit.COUNT > 0) THEN
							  FOR idx IN tbOperUnit.FIRST .. tbOperUnit.LAST LOOP
								  --Se valida el tipo de incremento para las unidades compartidas
								  IF (ldc_pe_bcgestlist.cuCountDifTin%ISOPEN) THEN
									  CLOSE ldc_pe_bcgestlist.cuCountDifTin;
								  END IF;

								  OPEN ldc_pe_bcgestlist.cuCountDifTin(nuIdContrato,tbOperUnit(idx).OPERATING_UNIT_ID,sbTipoInc);
								  FETCH ldc_pe_bcgestlist.cuCountDifTin INTO nuCount;
								  CLOSE ldc_pe_bcgestlist.cuCountDifTin;

								  IF (nuCount > 0) THEN
									  nuCountDif := nuCountDif + 1;
								  END IF;

							  END LOOP;
						END IF;
						IF (nuCountDif != 0) THEN

							--Existen contratos de unidades compartidas con tipo de incremento diferente
							ge_boerrors.seterrorcodeargument
							(
								Ld_Boconstans.cnuGeneric_Error,
								'Existen contratos de unidades operativas compartidas con un tipo de incremento diferente al seleccionado.'
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
END LDC_TRG_GE_CONTRATO_BU01;
/
