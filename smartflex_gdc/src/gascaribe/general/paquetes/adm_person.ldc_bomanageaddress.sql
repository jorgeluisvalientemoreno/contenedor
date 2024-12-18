CREATE OR REPLACE PACKAGE      adm_person.LDC_BOMANAGEADDRESS
IS
/**************************************************************************
    Propiedad Intelectual de PETI

    PACKAGE     :  LDC_BOMANAGEADDRESS
    Descripcion :  Paquete que tiene la logica para los APIS de gestion de dirección
                   para Ordenes y solicitudes.


    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    15/07/2024          PAcosta             OSF-2885: Cambio de esquema ADM_PERSON 
                                            Retiro marcacion esquema .open objetos de lógica    
    04-09-2014          oparra              Team 60. Creacion
**************************************************************************/

    PROCEDURE UpdAddressOrder
    (
        inuorderid      in  or_order.order_id%type,
        inuaddressid    in  or_order.external_address_id%type,
        isbflagprocess  in  varchar2,
        onuerrorcode    out ge_error_log.error_log_id%type,
        osberrormessage out ge_error_log.description%type
    );

    PROCEDURE UpdAddressRequest
    (
        inupackageid    in  mo_packages.package_id%type,
        inuaddressid    in  mo_packages.address_id%type,
        onuerrorcode    out ge_error_log.error_log_id%type,
        osberrormessage out ge_error_log.description%type
    );

    PROCEDURE ReassingOrder
    (
    	inuorder           in OR_ORDER.ORDER_ID%TYPE,
    	inuOperatunit      in OR_ORDER.OPERATING_UNIT_ID%TYPE,
    	idtexecdate        in OR_ORDER.ARRANGED_HOUR%TYPE,
    	onuerrorcode       out number,
    	osbErrorMessage    out varchar2
    );

    PROCEDURE INSADDRESS
    (
        INUGEOGRAPLOCATIONID    IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        ISBADDRESS              IN AB_ADDRESS.ADDRESS%TYPE,
        INUNEIGHBORTHOODID      IN AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE,
        ISBISURBAN              IN AB_ADDRESS.IS_URBAN%TYPE := NULL,
        ISBSHAPE                IN VARCHAR2,
        ISBVERIFIED             IN AB_ADDRESS.VERIFIED%TYPE := 'N',
        ONUADDRESSID            OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        ONUFATHERADDRESSID      OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        onuerrorcode            out number,
    	osbErrorMessage         out varchar2
    );

    PROCEDURE ADDRESSCHANGE
    (
        INUOLDADDRESSID         IN  AB_ADDRESS.ADDRESS_ID%TYPE,
        ISBNEWADDRESS           IN  AB_ADDRESS.ADDRESS%TYPE,
        INUNEWGEOLOCATIONID     IN  AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        INUNEWNEIGHBORHOODID    IN  AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE,
        INUCONSECUTIVE          IN  AB_PREMISE.CONSECUTIVE%TYPE,
        ONUNEWADDRESSID         OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        ONUFATHERADDID          OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        onuerrorcode            out number,
    	osbErrorMessage         out varchar2
    );

    FUNCTION fnuExistAddressId
    (
        inuGeograLocation   in ab_address.geograp_location_id%type,
        isbAddress          in ab_address.address%type
    )
    RETURN number;


END LDC_BOMANAGEADDRESS;
/
CREATE OR REPLACE PACKAGE BODY      adm_person.LDC_BOMANAGEADDRESS
IS

    --------------------------------------------
    -- Procedimientos DEL PAQUETE
    --------------------------------------------

    PROCEDURE INITIALIZEOUTPUTVARIABLES( ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORTEXT := GE_BOCONSTANTS.CSBNOMESSAGE;
   END;


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : UpdAddressOrder
    Descripcion : Procedimiento que actualiza la direccion asociada a una Orden.
                  "isbflagprocess" = 'A' si se ejecuta por api y 'P' si se ejecuta
                  por proceso.

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    04-09-2014          oparra              Creacion
    **************************************************************************/
    PROCEDURE UpdAddressOrder
    (
        inuorderid      in  or_order.order_id%type,
        inuaddressid    in  or_order.external_address_id%type,
        isbflagprocess  in  varchar2,
        onuerrorcode    out ge_error_log.error_log_id%type,
        osberrormessage out ge_error_log.description%type
    )
    IS
        nuflagOrder     number;
        nuflagOrAct     number;
        nuflagAddre     number;

        cursor cuOrder(inuOrden or_order.order_id%type)
        is
            select 1
            from or_order
            where order_id = inuOrden;

        cursor cuOrderAct(inuOrden or_order.order_id%type)
        is
            select 1
            from or_order_activity
            where order_id = inuOrden;

        cursor cuDireccion(inuDireccion or_order.external_address_id%type)
        is
            select 1
            from ab_address
            where address_id = inudireccion;

    BEGIN

        -- Valida los parametros de entrada
        IF inuorderid is not null and inuaddressid is not null THEN

            open cuOrder(inuorderid);
            fetch cuOrder into nuflagOrder;
            close cuOrder;

            -- validar si existe la Orden
            if nuflagOrder = 1 then

                open cuDireccion(inuaddressid);
                fetch cuDireccion into nuflagAddre;
                close cuDireccion;

                -- validar si existe la nueva direccion
                if nuflagAddre = 1 then

                    update or_order
                    set external_address_id = inuaddressid
                    where order_id = inuOrderid;

                    open cuOrderAct(inuorderid);
                    fetch cuOrderAct into nuflagOrAct;
                    close cuOrderAct;

                    -- Actualiza order_activity
                    if nuflagOrAct = 1 then
                        update or_order_activity
                        set address_id = inuaddressid
                        where order_id = inuOrderid;
                    end if;

                    -- si se ejecuta por API (orden individual) se da commit por cada una.
                    if isbFlagProcess = 'A' then
                        commit;
                    end if;

                    --ONUERRORCODE    := 1;
                    OSBERRORMESSAGE := 'Se Actualizo la Dirección asociada a la de Orden '||inuOrderid||' Exitosamente';
                    return;

                else
                    ONUERRORCODE    := -1;
                    OSBERRORMESSAGE := 'La Direccion ingresada no existe.';
                    return;

                end if;
                -- fin validacion direccion

            else
                ONUERRORCODE    := -1;
                OSBERRORMESSAGE := 'La Orden ingresada no existe.';
                return;

            end if;
            -- fin validacion Orden

        ELSE
            ONUERRORCODE    := -1;
            OSBERRORMESSAGE := 'El Numero de la Orden y el código de la dirección no pueden ser nulos';
            return;
        END IF;


    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );

    END UpdAddressOrder;


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : UpdAddressRequest
    Descripcion : Procedimiento que actualiza la direccion asociada a una Solicitud
                  y a sus ordenes asociadas.

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    04-09-2014          oparra              Creacion
    **************************************************************************/
    PROCEDURE UpdAddressRequest
    (
        inupackageid    in  mo_packages.package_id%type,
        inuaddressid    in  mo_packages.address_id%type,
        onuerrorcode    out ge_error_log.error_log_id%type,
        osberrormessage out ge_error_log.description%type
    )
    IS
        nuSolicitud     number;
        nuAddressAct    number;
        nuMoAddressid   number;
        nuMODirec       number;
        nuflagDirec     number;
        --
        nuErrorid       number;
        sbErrorMsg      varchar2(2000);
        sbOrdenes       varchar2(2000)  := '';

        cursor cuSolicitud(inuSolicitud mo_packages.package_id%type)
        is
            select package_id, address_id
            from mo_packages
            where package_id = inuSolicitud;

        cursor cuMoAddress(inuSolicitud mo_packages.package_id%type)
        is
            select address_id, parser_address_id
            from mo_address
            where package_id = inuSolicitud;

        cursor cuDireccion(inuDireccion mo_packages.address_id%type)
        is
            select 1
            from ab_address
            where address_id = inudireccion;

        cursor cuOrdenes(inuSolicitud mo_packages.package_id%type)
        is
            select c.order_id
            from mo_packages a, or_order_activity b, or_order c
            where a.package_id = b.package_id
            and b.order_id = c.order_id
            and a.package_id = inuSolicitud;

    BEGIN

        IF inupackageid is not null and inuaddressid is not null THEN

            open cuSolicitud(inupackageid);
            fetch cuSolicitud into nuSolicitud, nuAddressAct;
            close cuSolicitud;

            -- validar si existe la Solicitud
            if nuSolicitud is not null then

                open cuDireccion(inuaddressid);
                fetch cuDireccion into nuflagDirec;
                close cuDireccion;

                -- validar si existe la nueva direccion
                if nuflagDirec = 1 then

                    open cuMoAddress(inupackageid);
                    fetch cuMoAddress into nuMoAddressid,nuMODirec;
                    close cuMoAddress;

                    if nuMoAddressid is not null then

                        -- si la solicitud tiene direccion y es igual a mo_address se actualiza
                        if nuAddressAct is not null and nuAddressAct = nuMODirec then
                            update mo_packages
                            set address_id = inuaddressid
                            where package_id = inupackageid;
                        end if;

                        -- actuliza la direccion en mo_address
                        update mo_address
                        set parser_address_id = inuaddressid
                        where package_id = inupackageid;

                        -- Recorrer las ordenes
                        for orden in cuOrdenes(inupackageid) loop
                            -- se actualiza la direccion de las ordenes asociadas a la solicitud
                            LDC_BOMANAGEADDRESS.UpdAddressOrder(orden.order_id,inuaddressid,'P',nuErrorid,sbErrorMsg);

                            if nuErrorid = 1 then
                                sbOrdenes   := sbOrdenes||','||to_char(orden.order_id);
                            end if;
                        end loop;

                        commit;
                        ONUERRORCODE    := 1;

                        if length(sbOrdenes) > 1 then
                            OSBERRORMESSAGE := 'Se Actualizo la Dirección de la Solicitud '||inuPackageid||' y sus ordenes asociadas: '||substr(sbOrdenes,2);
                        else
                            OSBERRORMESSAGE := 'Se Actualizo la Dirección asociada a la Solicitud '||inuPackageid||' exitosamente';
                        end if;

                        return;

                    else
                        ONUERRORCODE    := -1;
                        OSBERRORMESSAGE := 'La solicitud no tiene registro Dirección asociada en MO_ADDRESS';
                        return;
                    end if;

                else
                    ONUERRORCODE    := -1;
                    OSBERRORMESSAGE := 'La Direccion ingresada no existe.';
                    return;
                end if;
                -- fin validacion direccion
            else
                ONUERRORCODE    := -1;
                OSBERRORMESSAGE := 'La Solicitud ingresada no existe.';
                return;
            end if;
            -- fin validacion solicitud
        ELSE
            ONUERRORCODE    := -1;
            OSBERRORMESSAGE := 'El Numero de la Solicitud y el código de la dirección no pueden ser nulos';

        END IF;


    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );

    END UpdAddressRequest;


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : ReassingOrder
    Descripcion : Procedimiento que permite reasignar una orden a otra unidad
                  operativa, utilizando el servicio de OSF.

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           ===========          ====================
    02-10-2014        oparra.Team1714         Creacion
    **************************************************************************/
    PROCEDURE ReassingOrder
    (
    	inuorder           in OR_ORDER.ORDER_ID%TYPE,
    	inuOperatunit      in OR_ORDER.OPERATING_UNIT_ID%TYPE,
    	idtexecdate        in OR_ORDER.ARRANGED_HOUR%TYPE,
    	onuerrorcode       out number,
    	osbErrorMessage    out varchar2
    )
    IS
        -- Proceso de reasignacion de orden de Smartflex
        PROCEDURE RUNPROCESS
        IS
        BEGIN
            OR_BOPROCESSORDER.PROCESSREASSINGORDER( inuorder, inuOperatunit, idtexecdate );
        END;

    BEGIN
        INITIALIZEOUTPUTVARIABLES( ONUERRORCODE, OSBERRORMESSAGE );
        RUNPROCESS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
    END ReassingOrder;


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : fnuExistAddressId
    Descripcion : Procedimiento que retorna el address_id si existe la direccion
                  ingresada (ab_address.address), sino cero.

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    04-09-2014        oparra.Team659        Creacion
    **************************************************************************/
    FUNCTION fnuExistAddressId
    (
        inuGeograLocation   in ab_address.geograp_location_id%type,
        isbAddress          in ab_address.address%type
    )
    RETURN number
    IS
        nuAdd   ab_address.address_id%type;
    BEGIN
        if isbAddress is not null and inuGeograLocation is not null then
            begin
                select address_id
                into nuAdd
                from ab_address
                where geograp_location_id = inuGeograLocation
                and address like '%'||isbAddress||'%';
            exception
                when no_data_found then
                    nuAdd   := 0;
            end;
        end if;

        return nuAdd;


    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;

    END fnuExistAddressId;


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : INSADDRESS
    Descripcion : Procedimiento

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    25-10-2014        oparra.Team659        Creacion
    **************************************************************************/
    PROCEDURE INSADDRESS
    (
        INUGEOGRAPLOCATIONID    IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        ISBADDRESS              IN AB_ADDRESS.ADDRESS%TYPE,
        INUNEIGHBORTHOODID      IN AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE,
        ISBISURBAN              IN AB_ADDRESS.IS_URBAN%TYPE := NULL,
        ISBSHAPE                IN VARCHAR2,
        ISBVERIFIED             IN AB_ADDRESS.VERIFIED%TYPE := 'N',
        ONUADDRESSID            OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        ONUFATHERADDRESSID      OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        onuerrorcode            out number,
    	osbErrorMessage         out varchar2
    )
    IS
      SBADDRESSPARSED AB_ADDRESS.ADDRESS_PARSED%TYPE := NULL;

      -- Proceso de reasignacion de orden de Smartflex
        PROCEDURE RUNPROCESS
        IS
        BEGIN
            LDC_AB_BOADDRESSPARSER.CREAACTUALIZADIRECCION
            (
                INUGEOGRAPLOCATIONID,
                ISBADDRESS,
                INUNEIGHBORTHOODID,
                ISBISURBAN,
                ONUADDRESSID,
                SBADDRESSPARSED,
                ONUFATHERADDRESSID,
                ISBVERIFIED
            );

            UT_TRACE.TRACE( ONUADDRESSID || ' Direccion Parseada:[' || SBADDRESSPARSED || ']', 3 );
            UT_TRACE.TRACE( 'Direccion Padre:[' || ONUFATHERADDRESSID || ']', 3 );

            AB_BOADDRESS.UPDSHAPEADDRESS( ONUADDRESSID, ISBSHAPE );
        END;

    BEGIN

        UT_TRACE.TRACE( 'Inicia LDC_BOMANAGEADDRESS.InsAddress', 2 );

        INITIALIZEOUTPUTVARIABLES( ONUERRORCODE, OSBERRORMESSAGE );
        RUNPROCESS;

        UT_TRACE.TRACE( 'Finaliza: LDC_BOMANAGEADDRESS.InsAddress', 2 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END INSADDRESS;


    /**************************************************************************
    Propiedad Intelectual de PETI

    Funcion     : ADDRESSCHANGE
    Descripcion : Procedimiento

    Historia de Modificaciones
      Fecha               Autor                Modificacion
    =========           =========          ====================
    25-10-2014        oparra.Team659        Creacion
    **************************************************************************/
    PROCEDURE ADDRESSCHANGE
    (
        INUOLDADDRESSID         IN  AB_ADDRESS.ADDRESS_ID%TYPE,
        ISBNEWADDRESS           IN  AB_ADDRESS.ADDRESS%TYPE,
        INUNEWGEOLOCATIONID     IN  AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE,
        INUNEWNEIGHBORHOODID    IN  AB_ADDRESS.NEIGHBORTHOOD_ID%TYPE,
        INUCONSECUTIVE          IN  AB_PREMISE.CONSECUTIVE%TYPE,
        ONUNEWADDRESSID         OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        ONUFATHERADDID          OUT AB_ADDRESS.ADDRESS_ID%TYPE,
        onuerrorcode            out number,
    	osbErrorMessage         out varchar2
    )
    IS

    BEGIN
        INITIALIZEOUTPUTVARIABLES(ONUERRORCODE, OSBERRORMESSAGE);

        LDC_AB_BOADDRESSCHANGE.ADDRESSCHANGE
        (
            INUOLDADDRESSID,
            ISBNEWADDRESS,
            INUNEWGEOLOCATIONID,
            INUNEWNEIGHBORHOODID,
            INUCONSECUTIVE,
            ONUNEWADDRESSID,
            ONUFATHERADDID
        );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );

    END ADDRESSCHANGE;


END LDC_BOMANAGEADDRESS;
/
PROMPT Otorgando permisos de ejecucion a LDC_BOMANAGEADDRESS
BEGIN
    pkg_utilidades.praplicarpermisos('LDC_BOMANAGEADDRESS', 'ADM_PERSON');
END;
/