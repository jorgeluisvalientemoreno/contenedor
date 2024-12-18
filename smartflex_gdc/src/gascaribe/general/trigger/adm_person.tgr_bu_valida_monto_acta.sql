CREATE OR REPLACE TRIGGER ADM_PERSON.TGR_BU_VALIDA_MONTO_ACTA
BEFORE UPDATE ON ge_contrato
REFERENCING old AS old new AS new for each row
/*****************************************************************
Propiedad intelectual de Gas Caribe.

Unidad         : TGR_BU_VALIDA_MONTO_ACTA
Descripcion    : Disparador que permite validar los montos del contrato antes de su apertura
Autor          : Eduardo Cerón
Fecha          : 30/03/2017

Historia de Modificaciones
Fecha           Autor           Modificacion
=========       =========       ====================
21/10/2024      jpinedc         OSF-3450: Se migra a ADM_PERSON    
******************************************************************/

DECLARE

    nuMontoJunta           ld_parameter.numeric_value%type;
    nuMontoComite          ld_parameter.numeric_value%type;
    nuValidacion           int;
    nuValorContrato        ge_contrato.valor_total_contrato%type;
    nuIdContrato           ge_contrato.id_contrato%type;
    sbStatusOld            ge_contrato.status%type;
    sbStatusNew            ge_contrato.status%type;

BEGIN

    nuValorContrato := :new.valor_total_contrato;
    nuIdContrato := :old.id_contrato;

    nuMontoJunta := dald_parameter.fnuGetNumeric_Value('MONTO_APROBACION_JUNTA',0);
    nuMontoComite := dald_parameter.fnuGetNumeric_Value('MONTO_APROBACION_COMITE',0);

    sbStatusOld := :old.status;
    sbStatusNew := :new.status;

    IF sbStatusOld = 'RG' AND sbStatusNew = 'AB' then

        IF nuValorContrato >= nuMontoComite AND nuValorContrato < nuMontoJunta THEN

            select count(1)
            into nuValidacion
            from ldc_monto_acta
            where ldc_monto_acta.id_contrato = nuIdContrato;

            IF nuValidacion = 0 THEN

                ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El contrato' ||nuIdContrato||', no tiene la aprobación respectiva en el ejecutable LDCCA - Actas de aprobación por contrato. Por favor registre la aprobación.');
                raise ex.controlled_error;

            END IF;

        ELSIF nuValorContrato >= nuMontoJunta THEN

                select count(1)
                into nuValidacion
                from ldc_monto_acta
                where ldc_monto_acta.id_contrato = nuIdContrato
                and ldc_monto_acta.tipo_acta = 'J';

                IF nuValidacion = 0 THEN

                    ge_boerrors.seterrorcodeargument(ld_boconstans.cnugeneric_error, 'El contrato '||nuIdContrato||', no tiene la aprobación respectiva en el ejecutable LDCCA - Actas de aprobación por contrato. Por favor registre la aprobación.');
                    raise ex.controlled_error;

                END IF;

        END IF;

    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

end;
/
