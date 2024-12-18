CREATE OR REPLACE PACKAGE adm_person.ldc_pkgestionacartasredes
/**********************************************************************
        Propiedad intelectual SCS
        Nombre              LDC_PKGESTIONACARTASREDES
        Autor               Oscar Parra
        Fecha               09/12/2016

        Descripción         Paquete logica pra gestionar las cartas de diseno
                            redes

        Historia de Modificaciones
        Fecha             Autor             Modificación
       ==========       ==========         ======================
       09/12/2016         oparra           1. Creacion
       02/10/2019         Eceron           Se modifica: SENDEMAILTT12104
                                           Se crea: fnuGetGeoLocation
       23/04/2024        jpinedc           Se cambia ldc_sendeemail por
                                           pkg_Correo
       26/06/2024        Adrianavg         OSF-2883: Migrar del esquema OPEN al esquema ADM_PERSON
       14/08/2024        jpinedc           OSF-3126: Se modifica PRGENERACARTASREDES
***********************************************************************/
IS

    -----------------------------------------
    -- Metodos publicos
    -----------------------------------------

    PROCEDURE PRGENERACARTASREDES;

    FUNCTION fnuGetGeoLocation
    (
        inuOrderId      IN      or_order.order_id%TYPE
    )
    RETURN or_order.geograp_location_id%TYPE;

    PROCEDURE SENDEMAILTT12104;


END LDC_PKGESTIONACARTASREDES;
/

CREATE OR REPLACE PACKAGE BODY adm_person.LDC_PKGESTIONACARTASREDES
/**********************************************************************
        Propiedad intelectual SCS
        Nombre              LDC_PKGESTIONACARTASREDES
        Autor               Oscar Parra
        Fecha               09/12/2016

        Descripción         Paquete logica pra gestionar las cartas de diseno
                            redes

        Historia de Modificaciones
        Fecha             Autor             Modificación
       ==========       ==========         ======================
       02/10/2019         Eceron           Se modifica: SENDEMAILTT12104
                                           Se crea: fnuGetGeoLocation
***********************************************************************/
IS

    /**********************************************************************
        Propiedad intelectual SCS
        Nombre              FSBGETUSUARIOORDEN
        Autor               Oscar Parra
        Fecha               09/12/2016

        Descripción         procedimiento del objeto

        Historia de Modificaciones
        Fecha             Autor             Modificación
       ==========       ==========         ======================
       09/12/2016         oparra           1. Creacion
    ***********************************************************************/
    FUNCTION FSBGETUSUARIORDEN(inuOrder     number)
    RETURN VARCHAR2
    IS
        sbUser  varchar2(2000);
        sbOrder varchar2(50);

        cursor cuNameUser
        is
            select upper(trim(subscriber_name)||' '||trim(subs_last_name))
            from or_order_Activity a,
                 pr_product p,
                 suscripc s,
                 ge_subscriber c
            where a.address_id = p.address_id
            and p.subscription_id = s.susccodi
            and s.suscclie = c.subscriber_id
            and a.task_type_id = dald_parameter.fnuGetNumeric_Value('LDC_TT_DISENO_REDES_POLIET')
            and a.order_id = inuOrder
            and rownum < 2;

    BEGIN

        /*ge_boinstanceControl.INITINSTANCEMANAGER;
        ge_boinstanceControl.CREATEINSTANCE( 'INSTANCE_REPORT', NULL );

        -- Setea losv alores en la isntancia
        ge_boinstanceControl.AddAttribute('INSTANCE_REPORT',NULL,'OR_ORDER','ORDER_ID',29746888,TRUE);

        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE('INSTANCE_REPORT',null,'OR_ORDER','ORDER_ID', sbOrder); */

        open cuNameUser;
        fetch cuNameUser into sbUser;
        IF cuNameUser%NOTFOUND THEN
            sbUser  := null;
            close cuNameUser;
        end if;

        return  sbUser;


    EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
            raise pkg_Error.CONTROLLED_ERROR;
        when others then
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END FSBGETUSUARIORDEN;


    /**********************************************************************
        Propiedad intelectual SCS
        Nombre              PRGENERACARTASREDES
        Autor               Oscar Parra
        Fecha               09/12/2016

        Descripción         procedimiento del objeto

        Historia de Modificaciones
        Fecha             Autor             Modificación
       ==========       ==========         ======================
       09/12/2016       oparra              1. Creacion
       14/08/2024       jpinedc             OSF-3126: Se cambia truncate por
                                            pkg_truncate_tablas_open.prcldc_userCartasPolit
    ***********************************************************************/
    PROCEDURE PRGENERACARTASREDES
    IS

        cnuNULL_ATTRIBUTE constant number := 2126;

        sbOrder     ge_boInstanceControl.stysbValue;
        sbUser      varchar2(200);
        nuCausal    number;
        sbExecu     ld_parameter.value_chain%type;
        nuExeId     number;

        cursor cuExecutable(isbName varchar2)
        is
            select sa_executable.executable_id
            from sa_executable
            where sa_executable.name = isbName
            and rownum < 2;


    BEGIN

        pkg_Traza.Trace('INICIO LDC_PKGESTIONACARTASREDES.PRGENERACARTASREDES',10);

        sbOrder := ge_boInstanceControl.fsbGetFieldValue ('OR_ORDER', 'ORDER_ID');

        ------------------------------------------------
        -- Required Attributes
        ------------------------------------------------

        if (sbOrder is null) then
            Errors.SetError (cnuNULL_ATTRIBUTE, 'Codigo de la orden');
            raise pkg_Error.CONTROLLED_ERROR;
        end if;

        nuCausal    := daor_order.fnugetcausal_id(to_number(sbOrder));
        pkg_Traza.Trace('Ejecucion PRGENERACARTASREDES => nuCausal: '||nuCausal,10);

        /* validacion causal */

        if (nuCausal = dald_parameter.fnuGetNumeric_Value('COD_CAUSAL_NO_VIABLE')) then
            sbExecu := pkg_BCLD_Parameter.fsbObtieneValorCadena('CARTA_NO_VIABLE_ZONA_RIESGO');

        elsif (nuCausal = dald_parameter.fnuGetNumeric_Value('COD_CAUSAL_IMPOS_TEC')) then
            sbExecu := pkg_BCLD_Parameter.fsbObtieneValorCadena('CARTA_IMPOSIBILIDAD_TEC');

        elsif (nuCausal = dald_parameter.fnuGetNumeric_Value('COD_CAUSAL_REQ_PERMISO')) then
            sbExecu := pkg_BCLD_Parameter.fsbObtieneValorCadena('CARTA_REQ_PERMISO');

        elsif (nuCausal = dald_parameter.fnuGetNumeric_Value('CAUSAL_NO_VIABLE_POR_INVER')) then
            sbExecu := pkg_BCLD_Parameter.fsbObtieneValorCadena('CARTA_NO_VIABLE_POR_INVER');

        end if;

        -- Consulta codigo de ejecutable
        open cuExecutable(sbExecu);
        fetch cuExecutable into nuExeId;
        if cuExecutable%NOTFOUND THEN
            nuExeId  := null;
            close cuExecutable;
        end if;

        pkg_Traza.Trace('Ejecucion PRGENERACARTASREDES => Ejecutable: '||nuExeId,10);

        sbUser  := FSBGETUSUARIORDEN(to_number(sbOrder));


        -- Registra el usuario de la orden
        pkg_truncate_tablas_open.prcldc_userCartasPolit;

        insert into ldc_userCartasPolit
        values (to_number(sbOrder),sbUser, sysdate);

        commit;
        ---

        /*-- Instancia en Memoria el valor de la orden
        ge_boinstanceControl.INITINSTANCEMANAGER;
        ge_boinstanceControl.CREATEINSTANCE( 'INSTANCE_REPORT', NULL );

        -- Setea los valores en la isntancia
        ge_boinstanceControl.AddAttribute('INSTANCE_REPORT',NULL,'OR_ORDER','ORDER_ID',to_number(sbOrder),TRUE);*/

        -- Se ejecuta el reporte crystal segun la causal
        if (nuExeId is not null) then
            GE_BOIOpenExecutable.setonevent(nuExeId,'POST_REGISTER');
        end if;

        pkg_Traza.Trace('FIN LDC_PKGESTIONACARTASREDES.PRGENERACARTASREDES',10);

    EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
            raise pkg_Error.CONTROLLED_ERROR;
        when others then
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;

    END PRGENERACARTASREDES;

    /**********************************************************************
        Propiedad intelectual SCS
        Nombre              fnuGetGeoLocation
        Autor               Eduardo Ceron
        Fecha               02/10/2019

        Descripción         Obtiene el departamento de la orden

        Historia de Modificaciones
        Fecha             Autor             Modificación
       ==========       ==========         ======================
       02/10/2019         Eceron           1. Creacion
    ***********************************************************************/
    FUNCTION fnuGetGeoLocation
    (
        inuOrderId      IN      or_order.order_id%TYPE
    )
    RETURN or_order.geograp_location_id%TYPE
    IS
        nuGeoLocation   or_order.geograp_location_id%TYPE;

        CURSOR cuGeoLocation
        IS
            select gf.geograp_location_id
            from ge_geogra_location g, or_order ot, ab_address ab, ge_geogra_location gf
            where ot.external_address_id = ab.address_id
            and g.geograp_location_id = ab.geograp_location_id
            and gf.geograp_location_id = g.geo_loca_father_id
            and ot.order_id = inuOrderId;

    BEGIN
        pkg_Traza.Trace('INICIO LDC_PKGESTIONACARTASREDES.fnuGetGeoLocation - inuOrderId: '||inuOrderId,10);

        OPEN cuGeoLocation;
        FETCH cuGeoLocation INTO nuGeoLocation;
        CLOSE cuGeoLocation;

        pkg_Traza.Trace('FIN LDC_PKGESTIONACARTASREDES.fnuGetGeoLocation - RETURN: '||nuGeoLocation,10);
        RETURN nuGeoLocation;

    EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
            raise pkg_Error.CONTROLLED_ERROR;
        when others then
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;

    END fnuGetGeoLocation;

    /**********************************************************************
        Propiedad intelectual SCS
        Nombre              SENDEMAILTT12104
        Autor               Oscar Parra
        Fecha               09/12/2016

        Descripción         procedimiento que envia correo

        Historia de Modificaciones
        Fecha             Autor             Modificación
       ==========       ==========         ======================
       02/10/2019         Eceron           Se modifica para hacer uso de la nueva
                                           tabla LDC_MAIL_GEO_LOCATION
       09/12/2016         oparra           1. Creacion
    ***********************************************************************/
    PROCEDURE SENDEMAILTT12104
    IS

        nuOrderId       or_order.order_id%type;
        nuCausalId      or_order.causal_id%type;
        sbCausal        ge_causal.description%type;
        dtFecha         or_order.created_date%type;
        sbSubject       ld_parameter.value_chain%type;
        sbMessage       ld_parameter.value_chain%type;
        nuGeoLocaOrd    or_order.geograp_location_id%TYPE;

        sbRemitente     ld_parameter.value_chain%TYPE:= pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_SMTP_SENDER');

        CURSOR cuEmail(inuDepto  IN  or_order.geograp_location_id%TYPE)
        IS
            SELECT  EMAIL
            FROM    LDC_MAIL_GEO_LOCATION
            WHERE   geo_location_id = inuDepto;

    BEGIN
        pkg_Traza.Trace('INICIO LDC_PKGESTIONACARTASREDES.SENDEMAILTT12104',10);

        -- Obtener orden de la instancia
        nuOrderId   := or_bolegalizeorder.fnuGetCurrentOrder;

        -- causal de la orden
        nuCausalId   := daor_order.fnugetcausal_id(nuOrderId);
        sbCausal     := dage_causal.fsbgetdescription(nuCausalId);
        nuGeoLocaOrd := fnuGetGeoLocation(nuOrderId);

        pkg_Traza.Trace('Ejecucion SENDEMAILTT12104  => nuCausalId => ' ||nuCausalId||' nuGeoLocaOrd: '||nuGeoLocaOrd,10);

        -- fecha de la orden
        dtFecha     := daor_order.fdtgetcreated_date(nuOrderId);

        -- Ajustar Mensaje del correo
        sbMessage       := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_TEXTO_CORREO_TT_12104');

        -- adicionar la orden
        sbMessage       := replace(sbMessage,'ORDER_ID',nuOrderId);
        -- adicionar fecha creacion
        sbMessage       := replace(sbMessage,'CREATED_DATE',dtFecha);
        -- adicionar causal
        sbMessage       := replace(sbMessage,'CAUSAL_ID',nuCausalId||' - '||sbCausal);

        sbSubject       := pkg_BCLD_Parameter.fsbObtieneValorCadena('LDC_ASUNTO_CORREO_TT_12104')||nuOrderId;

        FOR rgMail IN cuEmail(nuGeoLocaOrd) LOOP

            IF rgMail.email IS NULL THEN
                pkg_error.setErrorMessage( isbMsgErrr => 'No existe configuración de correo para la ubicación geográfica ['|| dage_geogra_location.fsbgetdescription(nuGeoLocaOrd,0) ||'] en la forma LDMGEO.' );
            END IF;

            pkg_Traza.Trace('Ejecucion SENDEMAILTT12104 - si aplica entrega - Envia correo',10);

            pkg_Correo.prcEnviaCorreo
            (
                isbRemitente        =>   sbRemitente,
                isbDestinatarios    =>   rgMail.email,
                isbAsunto           =>   sbSubject,
                isbMensaje          =>   sbMessage
            );

        END LOOP;

        pkg_Traza.Trace('FIN LDC_PKGESTIONACARTASREDES.SENDEMAILTT12104',10);

    EXCEPTION
        when pkg_Error.CONTROLLED_ERROR then
            raise pkg_Error.CONTROLLED_ERROR;
        when others then
            pkg_Error.setError;
            raise pkg_Error.CONTROLLED_ERROR;
    END SENDEMAILTT12104;

END LDC_PKGESTIONACARTASREDES;
/

PROMPT OTORGA PERMISOS ESQUEMA sobre LDC_PKGESTIONACARTASREDES
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_PKGESTIONACARTASREDES', 'ADM_PERSON'); 
END;
/

