CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CA_BONO_LIQUIDARECA before insert or update on LDC_CA_BONO_LIQUIDARECA
referencing old as old new as new for each row

declare

begin
    if (:new.LBLPORCINICIAL > :new.LBLPORCFINAL) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje inicial no puede ser mayor a la final, codigo  ['||:new.IDLIQUIDABOBORECA||'] de la Configuracion Bonificacion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.LBLPORCINICIAL < 0 or  :new.LBLPORCFINAL < 0 or :new.LBLPORCINICIAL > 100 or  :new.LBLPORCFINAL > 100) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje inicial y final debe estar entre 0 y 100, Codigo  ['||:new.IDLIQUIDABOBORECA||'] de la Configuracion Bonificacion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.LBLVALORFIJO < 0) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El valor fijo para el calculo de pago al contratista no puede ser negativo, Codigo  ['||:new.IDLIQUIDABOBORECA||'] de la Configuracion Bonificacion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.LBLDEPARTAMENTO is null) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El departamento no puede ser nulo, Codigo  ['||:new.IDLIQUIDABOBORECA||'] de la Configuracion Bonificacion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise;

    when OTHERS then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
end;
/
