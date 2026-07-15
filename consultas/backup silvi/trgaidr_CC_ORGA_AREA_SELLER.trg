CREATE OR REPLACE TRIGGER trgaidr_CC_ORGA_AREA_SELLER
AFTER INSERT OR DELETE ON CC_ORGA_AREA_SELLER
REFERENCING OLD AS old NEW AS new
FOR EACH ROW
DECLARE
    -- Identificador de la unidad operativa
    nuOperatingUnitId       or_operating_unit.operating_unit_id%type := null;
    -- Registro de los datos de la persona de la unidad de trabajo
    rcor_oper_unit_persons  daor_oper_unit_persons.styOR_oper_unit_persons;
    -- Persona a asociar a la unidad operativa
    nuPersonId              ge_person.person_id%type;
    -- Unidad Operativa que representa el Vendedor
    nuOwnOperUnitByPerson   or_operating_unit.operating_unit_id%type;
    -- Base Administrativa de la Unidad Operativa del Vendedor
    nuOperUnitAdminBaseID   or_operating_unit.admin_base_id%type;
BEGIN
    ut_trace.trace ('trgaidr_CC_ORGA_AREA_SELLER', 5);

    IF INSERTING then
        -- Obtiene la unidad de trabajo del canal de ventas
        nuOperatingUnitId := OR_BCOperUnitPerson.fnuObtOpUnitByOrgArea(:new.organizat_area_id);
        ut_trace.Trace('Unidad de trabajo encontrada ['||nuOperatingUnitId||']', 6);

        -- Si se encontro se registran datos
        if (nuOperatingUnitId IS not null) then
            -- Inserta el registro de la persona de la unidad operativa
            rcor_oper_unit_persons.operating_unit_id := nuOperatingUnitId;
            rcor_oper_unit_persons.person_id := :new.person_id;
            daor_oper_unit_persons.insRecord(rcor_oper_unit_persons);

        END IF;

    END IF;

    IF DELETING THEN
        -- Obtiene la unidad de trabajo asociada al canal de ventas
        nuOperatingUnitId := OR_BCOperUnitPerson.fnuObtOpUnitByOrgArea(:old.organizat_area_id);
        ut_trace.Trace('Unidad de trabajo encontrada ['||nuOperatingUnitId||']', 6);

        -- Si existe se eliminan los datos
        if (nuOperatingUnitId IS not null) then
            -- Elimina el registro de la persona de la unidad operativa
            nuPersonId := :old.person_id;
            daor_oper_unit_persons.delRecord(nuOperatingUnitId, nuPersonId);
        END if;
    END IF;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;

    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;

END trgaidr_CC_ORGA_AREA_SELLER;
/
