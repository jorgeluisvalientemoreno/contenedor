CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_LDC_ANTIC_CONTR
BEFORE INSERT OR UPDATE ON LDC_ANTIC_CONTR
FOR EACH ROW
/**************************************************************************
    Autor       :
    Fecha       : 21/03/2020
    Ticket      : 80
    Descripción: Trigger con validaciones para la tabla LDC_ANTIC_CONTR

    HISTORIA DE MODIFICACIONES
    FECHA        AUTOR       DESCRIPCION
***************************************************************************/
DECLARE

sbEntrega VARCHAR2(100) := '0000080';

cursor cuGetValorAnticipo(inuContratoId IN ge_contrato.ID_CONTRATO%type)is
    SELECT VALOR_ANTICIPO
    FROM GE_CONTRATO
    WHERE ID_CONTRATO = inuContratoId;

nuValorAnticipo GE_CONTRATO.VALOR_ANTICIPO%type;
nuIdContrato LDC_ANTIC_CONTR.idcontrato%type;

BEGIN
	ut_trace.trace('Inicia TGR_LDC_ANTIC_CONTR',10);

	IF fblaplicaentregaxcaso(sbEntrega) THEN

        IF INSERTING THEN

            nuIdContrato := :NEW.idcontrato;

        END IF;

        IF UPDATING THEN

            nuIdContrato := :OLD.idcontrato;

        END IF;

        IF :NEW.PORANTICIPO IS NOT NULL AND :NEW.VAL_FIJO_AMORT IS NOT NULL THEN

            Errors.SetError (2741, 'Es requerido solo uno de los campos Porcentaje de Anticipo o Valor Fijo de Amortización');
            RAISE ex.CONTROLLED_ERROR;

        END IF;

        IF :NEW.VAL_FIJO_AMORT IS NOT NULL THEN

            IF :NEW.VAL_FIJO_AMORT < 0 THEN

                Errors.SetError (2741, 'Valor fijo de amortización no admite valores negativos');
                RAISE ex.CONTROLLED_ERROR;

            END IF;

            OPEN cuGetValorAnticipo(nuIdContrato);
            FETCH cuGetValorAnticipo INTO nuValorAnticipo;
            CLOSE cuGetValorAnticipo;

            IF nuValorAnticipo IS NULL THEN

                nuValorAnticipo := 0;

            END IF;

            IF :NEW.VAL_FIJO_AMORT > nuValorAnticipo THEN

                Errors.SetError (2741, 'Valor fijo de amortización no debe superar el 100% del valor de anticipo otorgado al contrato');
                RAISE ex.CONTROLLED_ERROR;

            END IF;

        END IF;

	END IF;

	ut_trace.trace('Fin TGR_LDC_ANTIC_CONTR',10);
EXCEPTION
    WHEN ex.CONTROLLED_ERROR THEN
        RAISE ex.CONTROLLED_ERROR;

     WHEN OTHERS THEN
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;

END TGR_LDC_ANTIC_CONTR;
/
