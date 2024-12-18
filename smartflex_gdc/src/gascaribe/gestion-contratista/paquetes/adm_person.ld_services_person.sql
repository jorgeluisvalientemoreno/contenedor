CREATE OR REPLACE Package ADM_PERSON.Ld_services_person Is
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: Ld_services_person
    Descripcion:        Objeto con servicios de consulta para reportes

    Autor    : Eduardo Cerón.
    Fecha    : 24-04-2018

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    24-04-2018   Eduardo Cerón.         Creación
    ******************************************************************/


    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.
    Nombre:         fsbGetTecnicoVentas
    Descripcion:    Retorna el ténico de ventas dada la solicitud
    ******************************************************************/
    function fsbGetTecnicoVentas
    (
        inuPackageId        in  mo_packages.package_id%type
    )
    return varchar2;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.
    Nombre:         fsbGetUnidadCertificadora
    Descripcion:    Retorna el ténico de ventas dada la solicitud
    ******************************************************************/
    function fsbGetUnidadCertificadora
    (
        inuPackageId        in  mo_packages.package_id%type
    )
    return varchar2;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.
    Nombre:         fsbGetUnidadInst
    Descripcion:    Retorna el ténico de ventas dada la solicitud
    ******************************************************************/
    function fsbGetUnidadInst
    (
        inuPackageId        in  mo_packages.package_id%type
    )
    return varchar2;


End Ld_services_person;
/
CREATE OR REPLACE Package Body ADM_PERSON.Ld_services_person Is
    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre del Paquete: Ld_services_person
    Descripcion:        Objeto con servicios de consulta para reportes

    Autor    : Eduardo Cerón.
    Fecha    : 24-04-2018

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    24-04-2018   Eduardo Cerón.         Creación
    ******************************************************************/

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre:         fsbGetTecnicoVentas
    Descripcion:    Retorna el ténico de ventas dada la solicitud

    Autor    : Eduardo Cerón.
    Fecha    : 24-04-2018

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    24-04-2018   Eduardo Cerón.         Creación
    ******************************************************************/
    function fsbGetTecnicoVentas
    (
        inuPackageId        in  mo_packages.package_id%type
    )
    return varchar2
    is
        cursor cuPackage
        is
            select  ld_package_person.person_id,
                    ld_person_oper_unit.person_name
            from    ld_person_oper_unit, ld_package_person
            where   ld_person_oper_unit.operating_unit_id = ld_package_person.person_id
            and     ld_package_person.package_id = inuPackageId;

        nuPersonId      ld_package_person.person_id%type;
        sbPersonName    ld_person_oper_unit.person_name%type;
        sbResult        varchar2(200);

    begin
        ut_trace.trace('INICIO Ld_services_person.fsbGetTecnicoVentas - inuPackageId '||inuPackageId,10);

        if(cuPackage%isopen) then
            close cuPackage;
        end if;

        open cuPackage;
        fetch cuPackage into nuPersonId, sbPersonName;
        close cuPackage;

        IF nuPersonId is not null then
            sbResult := nuPersonId||' - '||sbPersonName;
        end if;

        ut_trace.trace('FIN Ld_services_person.fsbGetTecnicoVentas - '||sbResult,10);
        return sbResult;

    exception
        when others then
            return null;
    end fsbGetTecnicoVentas;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre:         fnuGetUnidadCertificadora
    Descripcion:    Retorna la unidad certificadora dada la solicitud

    Autor    : Eduardo Cerón.
    Fecha    : 24-04-2018

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    24-04-2018   Eduardo Cerón.         Creación
    ******************************************************************/
    function fsbGetUnidadCertificadora
    (
        inuPackageId        in  mo_packages.package_id%type
    )
    return varchar2
    is
        cursor cuPackage
        is
            select  LD_PACKAGE_PERSON.oper_unit_cert,
                    daor_operating_unit.fsbgetname(LD_PACKAGE_PERSON.oper_unit_cert,0) nombre
            from    LD_PACKAGE_PERSON
            where   LD_PACKAGE_PERSON.package_id = inuPackageId;

        nuPersonId      LD_PACKAGE_PERSON.oper_unit_cert%type;
        sbPersonName    ld_person_oper_unit.person_name%type;
        sbResult        varchar2(200);

    begin
        ut_trace.trace('INICIO Ld_services_person.fsbGetUnidadCertificadora - inuPackageId '||inuPackageId,10);

        if(cuPackage%isopen) then
            close cuPackage;
        end if;

        open cuPackage;
        fetch cuPackage into nuPersonId, sbPersonName;
        close cuPackage;

        IF nuPersonId is not null then
            sbResult := nuPersonId||' - '||sbPersonName;
        end if;

        ut_trace.trace('FIN Ld_services_person.fsbGetUnidadCertificadora - '||sbResult,10);
        return sbResult;

    exception
        when others then
            return null;
    end fsbGetUnidadCertificadora;

    /*****************************************************************
    Propiedad intelectual de Gases del Caribe.

    Nombre:         fsbGetUnidadInst
    Descripcion:    Retorna la unidad instaladora dada la solicitud

    Autor    : Eduardo Cerón.
    Fecha    : 24-04-2018

    Historia de Modificaciones

    DD-MM-YYYY    <Autor>.              Modificacion
    -----------  -------------------    -------------------------------------
    24-04-2018   Eduardo Cerón.         Creación
    ******************************************************************/
    function fsbGetUnidadInst
    (
        inuPackageId        in  mo_packages.package_id%type
    )
    return varchar2
    is
        cursor cuPackage
        is
            select  LD_PACKAGE_PERSON.oper_unit_inst,
                    daor_operating_unit.fsbgetname(LD_PACKAGE_PERSON.oper_unit_inst,0) nombre
            from    LD_PACKAGE_PERSON
            where   LD_PACKAGE_PERSON.package_id = inuPackageId;

        nuPersonId      LD_PACKAGE_PERSON.oper_unit_inst%type;
        sbPersonName    ld_person_oper_unit.person_name%type;
        sbResult        varchar2(200);

    begin
        ut_trace.trace('INICIO Ld_services_person.fsbGetUnidadInst - inuPackageId '||inuPackageId,10);

        if(cuPackage%isopen) then
            close cuPackage;
        end if;

        open cuPackage;
        fetch cuPackage into nuPersonId, sbPersonName;
        close cuPackage;

        IF nuPersonId is not null then
            sbResult := nuPersonId||' - '||sbPersonName;
        end if;

        ut_trace.trace('FIN Ld_services_person.fsbGetUnidadInst - '||sbResult,10);
        return sbResult;

    exception
        when others then
            return null;
    end fsbGetUnidadInst;



End Ld_services_person;
/
PROMPT Otorgando permisos de ejecucion a LD_SERVICES_PERSON
BEGIN
    pkg_utilidades.praplicarpermisos('LD_SERVICES_PERSON', 'ADM_PERSON');
END;
/
PROMPT Otorgando permisos de ejecucion sobre LD_SERVICES_PERSON para reportes
GRANT EXECUTE ON ADM_PERSON.LD_SERVICES_PERSON TO REXEREPORTES;
/
