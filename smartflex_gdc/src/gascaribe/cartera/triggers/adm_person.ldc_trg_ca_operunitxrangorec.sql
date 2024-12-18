CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_CA_OPERUNITXRANGOREC before insert or update on LDC_CA_OPERUNITXRANGOREC
referencing old as old new as new for each row

declare

begin
    if (:new.RANGOINICIAL > :new.RANGOFINAL) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'Los dias iniciales no puede ser mayor al dia final, codigo  ['||:new.IDOPERUNITXRANGOREC||'] de la Unidades operativas por rangos de recaudo');
        raise ex.CONTROLLED_ERROR;
    end if;

    if (:new.RANGOINICIAL < 0) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                         'El rango inicial no puede ser negativo, codigo  ['||:new.IDOPERUNITXRANGOREC||'] de la Unidades operativas por rangos de recaudo');
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
