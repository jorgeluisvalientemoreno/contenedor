CREATE OR REPLACE TRIGGER ADM_PERSON.LDC_TRG_LD_ZON_ASSIG_VALID
AFTER INSERT OR UPDATE ON  LD_ZON_ASSIG_VALID
REFERENCING
    NEW AS NEW
    OLD AS OLD
FOR EACH ROW
    /**************************************************************************
    Propiedad Intelectual de PETI
    TRIGGER     :  LDC_TRG_LD_ZON_ASSIG_VALID
    Descripcion : Trigger que permite validar que al momento del insert o update
                  en la tabla LD_ZON_ASSIG_VALID verifique que la fecha de visita
                  se encuentre en el rango del cronograma configurado para la feria
    Autor       : Alexandra Gordillo (Optima Consulting)
    Fecha       : 12-06-2013
    **************************************************************************/
DECLARE

    nuOperating_uni LDC_COFUOOP.cofunid%type;

BEGIN

    SELECT  cofunid INTO nuOperating_uni
    FROM    LDC_COFUOOP
    WHERE   cofunid = :new.operating_unit_id
    AND     :new.date_of_visit between coffein and coffefi;

EXCEPTION
    when no_data_found then
        GI_BOERRORS.SETERRORCODEARGUMENT(2741, 'La fecha de visita no se encuentra en '||
                                               'el rango de fecha que se tiene en el cronograma '||
                                               'para la unidad de trabajo '||:new.operating_unit_id);
    when ex.CONTROLLED_ERROR then
        raise;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END LDC_TRG_LD_ZON_ASSIG_VALID;
/
