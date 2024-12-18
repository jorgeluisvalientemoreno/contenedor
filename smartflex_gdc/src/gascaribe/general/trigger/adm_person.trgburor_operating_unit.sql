CREATE OR REPLACE TRIGGER ADM_PERSON.TRGBUROR_OPERATING_UNIT
BEFORE UPDATE OF OPER_UNIT_CLASSIF_ID, CONTRACTOR_ID ON OR_OPERATING_UNIT
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
/**************************************************************
Propiedad intelectual de Open International Systems. (c).

Trigger       :  TRGBUROR_OPERATING_UNIT

Descripcion   : Trigger para la creación de contratistas y proveedores

Autor         : Luis Alberto López Agudelo
Fecha         : 05-09-2013

Historia de Modificaciones
Fecha        IDEntrega           Modificacion
05-09-2013    llopez.SAO214246   Creación
**************************************************************/
DECLARE
BEGIN
    if (sa_bosystem.getsystemprocessname <> 'LDDPC') then
        return;
    end if;
    if (:new.oper_unit_classif_id in (Dald_parameter.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB'),
                                      Dald_parameter.fnuGetNumeric_Value('SUPPLIER_FNB')) AND
        :new.contractor_id is null) then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                           'Cuando la clasificación de la unidad de trabajo es proveedor o contratista, el contratista es requerido.');
    elsif (:new.oper_unit_classif_id = ge_boparameter.fnuGet('OR_DISPATCH_UNITCLAS') AND
        :new.contractor_id is not null) then
        ge_boerrors.seterrorcodeargument(ld_boconstans.cnuGeneric_Error,
                           'no es posible definir un contratista cunado la clasificación de la unidad de trabajo no es proveedor o contratista');
    end if;

    -- Si esta cambiando la clasificación de la unidad de trabajo por contratista
    if (:old.oper_unit_classif_id <> :new.oper_unit_classif_id) then
        if (:new.oper_unit_classif_id = Dald_parameter.fnuGetNumeric_Value('CONTRACTOR_SALES_FNB')) then
            :new.assign_type := or_boconstants.cnuAssignByCapacity;
            :new.es_externa := ge_boconstants.csbYES;
        elsif (:new.oper_unit_classif_id = Dald_parameter.fnuGetNumeric_Value('SUPPLIER_FNB')) then
            :new.assign_type := or_boconstants.cnuAssignByCapacity;
            :new.es_externa := ge_boconstants.csbYES;
        elsif (:new.oper_unit_classif_id = ge_boparameter.fnuGet('OR_DISPATCH_UNITCLAS')) then
            :new.contractor_id := null;
            :new.assign_type := or_boconstants.cnuAssignBySchedule;
            :new.es_externa := ge_boconstants.csbNO;
        end if;

    end if;

EXCEPTION
  when ex.CONTROLLED_ERROR then
    raise ex.CONTROLLED_ERROR;
  when others then
    Errors.setError;
    raise ex.CONTROLLED_ERROR;
END TRGBUROR_OPERATING_UNIT;
/
