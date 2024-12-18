CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIU_LD_PRICELIST
BEFORE INSERT OR UPDATE on LD_PRICE_LIST
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  TRGBIU_LD_PRICELIST

Historia de Modificaciones
Fecha        IDEntrega             Modificación
18-07-2014   cfranco.4215     se agrega validación : nueva fecha final
                              no puede ser mayor a la fecha final aprobada
                              cuando se esta actualizando.
05-10-2012   jconsuegra.SAO156577  Creación
**************************************************************/
DECLARE

  var number(1); -- local variables here

BEGIN
    if(:old.amount_printouts = :new.amount_printouts) or (:new.amount_printouts is null)then
        IF((trunc(:new.initial_date) >= trunc(SYSDATE) OR updating) AND trunc(:new.final_date) >= trunc(SYSDATE))THEN
            if(trunc(:new.initial_date) > trunc(:new.final_date))then
                ge_boerrors.seterrorcodeargument
                (
                    ld_boconstans.cnuGeneric_Error,
                    'La fecha inicial debe ser menor o igual a la fecha final'
                );
            end if;
        ELSE
            ge_boerrors.seterrorcodeargument
            (
                ld_boconstans.cnuGeneric_Error,
                'La fecha inicial y la final deben ser mayor o igual a la fecha del sistema'
            );
        END IF;

        IF UPDATING THEN
            if (:new.approved = 'Y') then
                begin
                    select 1 into var from ld_price_list_deta d
                    where d.price_list_id = :old.price_list_id and rownum = 1;
                exception
                    when no_data_found then
                    ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                               'No se puede aprobar una lista de precios sin artículos asociados');
                end;

               if(:new.final_date > :old.final_date) then
                    ge_boerrors.seterrorcodeargument
                    (
                        ld_boconstans.cnuGeneric_Error,
                        'La nueva fecha final ['||:new.final_date||'] no puede ser mayor a la fecha final aprobada ['||:old.final_date||']'
                    );
               END if;

            end if;
        END IF;
        IF INSERTING THEN
            if (:new.approved = 'Y') then
                begin
                    select 1 into var
                    from ld_price_list_deta d
                    where d.price_list_id = :new.price_list_id and rownum = 1;
                exception
                    when no_data_found then
                    ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                                               'No se puede aprobar una lista de precios sin artículos asociados');
                end;
            end if;
        END IF;
    end if;

EXCEPTION WHEN OTHERS THEN
    Errors.setError;
    RAISE ex.CONTROLLED_ERROR;
END TRGBIU_LD_PRICELIST;
/
