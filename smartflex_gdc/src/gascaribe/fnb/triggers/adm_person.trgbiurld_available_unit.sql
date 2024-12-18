CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBIURLD_AVAILABLE_UNIT
BEFORE INSERT OR UPDATE
ON LD_AVAILABLE_UNIT
REFERENCING OLD AS old NEW AS new
FOR EACH ROW

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgbiurLD_AVAILABLE_UNIT

Descripcion  : Trigger que registra los nuevos datos a insertarse en la tabla LD_AVAILABLE_UNIT

Autor  : Luis Alberto López Agudelo
Fecha  : 05-09-2013

Historia de Modificaciones
Fecha        IDEntrega           Modificación
05-09-2013    llopez.SAO214246      Creación
**************************************************************/
DECLARE
    /******************************************
        Declaracion de variables y Constantes
    ******************************************/

BEGIN
    :new.initial_date := trunc(:new.initial_date);
    :new.final_date := trunc(:new.final_date);
    if (:new.initial_date > :new.final_date) then
        ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                           'La fecha inicial no puede ser mayor a la fecha final.');
    end if;
    /*Obtener valores e instanciar las variables de paquete*/
    ld_boavailableunit.AddAvailableUnit(
        :new.available_unit_id,
        :new.operating_unit_id,
        :new.operating_zone_id,
        :new.initial_date,
        :new.final_date
    );

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGBIURLD_AVAILABLE_UNIT;
/
