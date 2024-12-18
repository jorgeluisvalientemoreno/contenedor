CREATE OR REPLACE TRIGGER ADM_PERSON.TRGAIURLD_AVAILABLE_UNIT
AFTER INSERT OR UPDATE ON LD_AVAILABLE_UNIT

/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger  :  trgaiurLD_AVAILABLE_UNIT

Descripcion  : Trigger que registra los nuevos datos a insertarse en la tabla LD_AVAILABLE_UNIT

Autor  : Luis Alberto López Agudelo
Fecha  : 03-10-2012

Historia de Modificaciones
Fecha        IDEntrega           Modificación
05-09-2013    llopez.SAO214246      Creación
**************************************************************/
DECLARE
BEGIN
    ld_boavailableunit.ValAvailableOver();
EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END TRGAIURLD_AVAILABLE_UNIT;

/
