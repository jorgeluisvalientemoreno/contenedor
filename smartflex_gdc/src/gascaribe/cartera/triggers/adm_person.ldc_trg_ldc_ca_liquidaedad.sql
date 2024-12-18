CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LDC_CA_LIQUIDAEDAD before insert or update on LDC_CA_LIQUIDAEDAD
referencing old as old new as new for each row

declare

begin
    if (:new.LCLPORCINICIAL > :new.LCLPORCFINAL) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje inicial no puede ser mayor a la final, codigo  ['||:new.IDLIQUIDAEDAD||'] de la Configuracion de liquidacion por rango por Edad');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.LCLPORCINICIAL < 0 or  :new.LCLPORCFINAL < 0 or :new.LCLPORCINICIAL > 100 or  :new.LCLPORCFINAL > 100) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje inicial y final debe estar entre 0 y 100, Codigo  ['||:new.IDLIQUIDAEDAD||'] de la Configuracion de liquidacion por rango por Edad');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.LCLVALORFIJO < 0) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El porcentaje para el calculo de pago al contratista no puede ser negativo, Codigo  ['||:new.IDLIQUIDAEDAD||'] de la Configuracion de liquidacion por rango por Edad');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.LCLDEPARTAMENTO is null ) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El departamento no ppuede ser nulo, Codigo  ['||:new.IDLIQUIDAEDAD||'] de la Configuracion de liquidacion por rango por Edad');
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
