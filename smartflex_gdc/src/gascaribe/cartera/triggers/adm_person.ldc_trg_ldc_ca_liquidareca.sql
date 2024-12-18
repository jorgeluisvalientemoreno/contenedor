CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDC_CA_LIQUIDARECA before insert or update on LDC_CA_LIQUIDARECA
referencing old as old new as new for each row
declare

begin
    if (:new.PORCINICIAL > :new.PORCFINAL) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje inicial no puede ser mayor a la final, codigo  ['||:new.IDLIQUIDARECA||'] de la Configuracion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.PORCINICIAL < 0 or  :new.PORCFINAL < 0 or :new.PORCINICIAL > 100 or  :new.PORCFINAL > 100) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje inicial y final debe estar entre 0 y 100, Codigo  ['||:new.IDLIQUIDARECA||'] de la Configuracion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.VALORPORC < 0) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje para el calculo de pago al contratista no puede ser negativo, Codigo  ['||:new.IDLIQUIDARECA||'] de la Configuracion de liquidacion por rango por recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.DEPARTAMENTO is null ) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El departamento no puede ser nulo, Codigo  ['||:new.IDLIQUIDARECA||'] de la Configuracion de liquidacion por rango por recaudo');
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
