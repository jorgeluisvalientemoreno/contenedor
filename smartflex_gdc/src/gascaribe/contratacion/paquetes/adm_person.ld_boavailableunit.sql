CREATE OR REPLACE PACKAGE adm_person.ld_boavailableunit IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad          :   LD_BOAvailableUnit
Descripcion     :   Paquete con los servicios de disponibilidad de Contratistras
                    y proveedores
Autor           :   Luis Alberto López Agudelo
Fecha           :   05-09-2013

Historia de Modificaciones
Fecha       Autor               Modificacion
==========  ==================  ====================
05-09-2013  llopez.SAO214246    Creación
18-06-2024  Adrianavg           OSF-2798: Se migra del esquema OPEN al esquema ADM_PERSON
******************************************************************/

    -- Declaracion de Tipos de datos publicos

    -- Declaracion de constantes publicas

    -- Declaracion de variables publicas

    -- Declaracion de funciones y procedimientos publicos
    FUNCTION fsbVersion RETURN VARCHAR2;

    /*****************************************************************
    Unidad         : ValAvailableOver
    Descripcion    : Valida que no haya solapamientos en las disponibilidades
    ******************************************************************/
    PROCEDURE ValAvailableOver;

    /*****************************************************************
    Unidad         : AddAvailableUnit
    Descripcion    : Adiciona a la tabla PL un registro para validar
    ******************************************************************/
    PROCEDURE AddAvailableUnit(
        inuavailable_unit_id    in  ld_available_unit.available_unit_id%type,
        operating_unit_id       in  ld_available_unit.operating_unit_id%type,
        operating_zone_id       in  ld_available_unit.operating_zone_id%type,
        initial_date            in  ld_available_unit.initial_date%type,
        final_date              in  ld_available_unit.final_date%type
    );

END LD_BOAvailableUnit;
/
CREATE OR REPLACE PACKAGE BODY adm_person.LD_BOAvailableUnit IS
/*****************************************************************
Propiedad intelectual de Open International Systems (c).

Unidad          :   LD_BOAvailableUnit
Descripcion     :   Paquete con los servicios de disponibilidad de Contratistras
                    y proveedores
Autor           :   Luis Alberto López Agudelo
Fecha           :   05-09-2013

Historia de Modificaciones
Fecha       Autor               Modificacion
==========  ==================  ====================
05-09-2013  llopez.SAO214246    Creación
******************************************************************/

    /* Cursores */
    CURSOR cuRecord
    (
    	inuAvaiable_Unit_Id in LD_Available_Unit.available_unit_id%type
    )
    IS
    	SELECT LD_Available_Unit.*,LD_Available_Unit.rowid
    	FROM LD_Available_Unit
    	WHERE available_unit_id = inuAvaiable_Unit_Id;

    /* Declaracion de Tipos de datos privados */
    subtype styLD_Available_Unit    is  cuRecord%rowtype;
    type tytbLD_Available_Unit      is  table of styLD_Available_Unit index by binary_integer;

    /* Declaracion de constantes privados */
    csbVersion CONSTANT VARCHAR2(20) := 'SAO214246';

    /* Declaracion de variables privados */
    gtbAvailableUnit    tytbLD_Available_Unit;

    /* Declaracion de funciones y procedimientos */
    FUNCTION fsbVersion RETURN VARCHAR2 IS
    BEGIN
        RETURN csbVersion;
    END;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : ValAvailableOver
    Descripcion    : Valida que no haya solapamientos en las disponibilidades

    Autor          : Luis Alberto López Agudelo
    Fecha          : 05-09-2013

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    ==========  ==================  ====================
    05-09-2013  llopez.SAO214246    Creación
    ******************************************************************/
    PROCEDURE ValAvailableOver
    IS
        nuIdx   number;
        nuError number;
        CURSOR cuValOverlapping(
            rcAvailableUnit in styLD_Available_Unit
        ) IS
            SELECT  1
            FROM    ld_available_unit
            WHERE   available_unit_id <> rcAvailableUnit.available_unit_id
            AND     operating_unit_id = rcAvailableUnit.operating_unit_id
            AND     (   (
                        initial_date <= rcAvailableUnit.initial_date AND
                        final_date >= rcAvailableUnit.initial_date
                        )   OR
                        (
                        initial_date <= rcAvailableUnit.final_date AND
                        final_date >= rcAvailableUnit.final_date
                        )   OR
                        (
                        initial_date >= rcAvailableUnit.initial_date AND
                        final_date <= rcAvailableUnit.final_date
                        )
                    );
    BEGIN
        nuIdx := gtbAvailableUnit.first;

        while ((nuIdx is not null) AND (nuError is null)) loop
            open cuValOverlapping(gtbAvailableUnit(nuIdx));
            fetch cuValOverlapping into nuError;
            close cuValOverlapping;
            if (nuError is null) then
                nuIdx := gtbAvailableUnit.next(nuIdx);
            end if;
        end loop;
        if (nuError = 1) then
            ge_boerrors.seterrorcodeargument(Ld_Boconstans.cnuGeneric_Error,
                               'Ya existe una disponibilidad para la unidad '||
                               gtbAvailableUnit(nuIdx).operating_unit_id||
                               ' que se solapa en las fechas del '||
                               to_char(gtbAvailableUnit(nuIdx).initial_date,'dd/mm/yyyy')||
                               ' al '||to_char(gtbAvailableUnit(nuIdx).final_date,'dd/mm/yyyy'));
        end if;

    EXCEPTION
        when ex.CONTROLLED_ERROR then
            gtbAvailableUnit.delete;
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            gtbAvailableUnit.delete;
            raise ex.CONTROLLED_ERROR;
    END ValAvailableOver;

    /*****************************************************************
    Propiedad intelectual de Open International Systems (c).

    Unidad         : AddAvailableUnit
    Descripcion    : Adiciona a la tabla PL un registro para validar

    Autor          : Luis Alberto López Agudelo
    Fecha          : 05-09-2013

    Historia de Modificaciones
    Fecha       Autor               Modificacion
    ==========  ==================  ====================
    05-09-2013  llopez.SAO214246    Creación
    ******************************************************************/
    PROCEDURE AddAvailableUnit(
        inuavailable_unit_id    in  ld_available_unit.available_unit_id%type,
        operating_unit_id       in  ld_available_unit.operating_unit_id%type,
        operating_zone_id       in  ld_available_unit.operating_zone_id%type,
        initial_date            in  ld_available_unit.initial_date%type,
        final_date              in  ld_available_unit.final_date%type
    ) IS
        nuIdx   number;
    BEGIN
        if (gtbAvailableUnit.first is null) then
            nuIdx := 1;
        else
            nuIdx := gtbAvailableUnit.last + 1;
        end if;

        gtbAvailableUnit(nuIdx).available_unit_id := inuavailable_unit_id;
        gtbAvailableUnit(nuIdx).operating_unit_id := operating_unit_id;
        gtbAvailableUnit(nuIdx).operating_zone_id := operating_zone_id;
        gtbAvailableUnit(nuIdx).initial_date      := initial_date;
        gtbAvailableUnit(nuIdx).final_date        := final_date;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END AddAvailableUnit;


END LD_BOAvailableUnit;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre LD_BOAVAILABLEUNIT
BEGIN
    pkg_utilidades.prAplicarPermisos('LD_BOAVAILABLEUNIT', 'ADM_PERSON'); 
END;
/
PROMPT
PROMPT OTORGA PERMISOS a REXEREPORTES sobre LD_BOAVAILABLEUNIT
GRANT EXECUTE ON ADM_PERSON.LD_BOAVAILABLEUNIT TO REXEREPORTES;
/