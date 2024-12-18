CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIUR_LD_SUPPLI_SETTINGS
BEFORE INSERT OR UPDATE on LD_SUPPLI_SETTINGS
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/*******************************************************************************
 Propiedad intelectual de Open International Systems. (c).

 Trigger       : trgBIUR_Ld_Suppli_Settings

 Descripcion   : Trigger que controla que se registren los datos que son
                 obligatorios en el caso de que el Contratista corresponda
                 a una Gran Superficie

 Historia de Modificaciones
 Fecha        IDEntrega          Modificacion

 05-Sep-2013  jcastroSAO213041   Se corrigen los mensajes de error generados
                                 para reflejar las nuevas descripciones de los
                                 campos.
*******************************************************************************/

DECLARE
    nuError number := ld_boconstans.cnuGeneric_Error;

BEGIN
--{
    -- Valida si corresponde a una Gran Superficie

    IF (:new.post_leg_process = 'Y') THEN
    --{
        -- Valida que tenga asignado el Procedimiento Post-Venta

        IF (:new.leg_process_orders IS NULL) THEN
        --{
           	ge_boerrors.seterrorcodeargument(nuError, 'El campo "Procedimiento de ejecución Post-Venta" ' ||
                 'no puede ser nulo, si el campo "Gran Superficie" se encuentra activo');
        --}
        END IF;

        -- Valida que tenga asignada la Descripcion del Procedimiento Post-Venta

        IF (:new.exe_rule_post_sale IS NULL) THEN
        --{
           	ge_boerrors.seterrorcodeargument(nuError, 'El campo "Descripción del procedimiento de ejecución Post-Venta" ' ||
                    'no puede ser nulo, si el campo "Gran Superficie" se encuentra activo');
        --}
        END IF;
    --}
    END IF;

EXCEPTION
    when OTHERS then
        Errors.setError;
        RAISE ex.CONTROLLED_ERROR;
--}
END TRGBIUR_LD_SUPPLI_SETTINGS;
/
