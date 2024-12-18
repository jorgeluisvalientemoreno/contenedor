CREATE OR REPLACE PACKAGE      ge_boemergencyorders AS
/* *************************************************************
Package	    : GE_BOEmergencyOrders
Descripcion	: Objeto de negocio para ordenes de emergencia
************************************************************** */
    --------------------------------------------
    -- Tipos y Variables
    --------------------------------------------
    subtype styFinancialDesc IS varchar2(20);
    --------------------------------------------
    -- Constantes
    --------------------------------------------
    -- Codigos de Estados Financieros (Check Constraints)
    csbIdAldia               constant servsusc.sesuesfn%type := 'A';
    csbIdConDeuda            constant servsusc.sesuesfn%type := 'D';
    csbIdCastigado           constant servsusc.sesuesfn%type := 'C';
    csbIdEnMora              constant servsusc.sesuesfn%type := 'M';
    -- Descripcion de Estados Financieros (Check Constraint)
    csbAlDia                 constant styFinancialDesc := 'Al dia';
    csbConDeuda              constant styFinancialDesc := 'Con deuda';
    csbCastigado             constant styFinancialDesc := 'Castigado';
    csbEnMora                constant styFinancialDesc := 'En mora';

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    /* ***************************************************************
    Unidad   : fsbVersion
    Descripcion	: Obtiene la version del paquete
    **************************************************************** */
    FUNCTION fsbVersion return varchar2;

    /* ***************************************************************
    Unidad   : fsbvalidatecharactersxml
    Descripcion	: fsbValidateCharactersXML que se encarga de:
                  - Reemplazar los caracteres reservados del XML (<,>,&,',") por el nombre de la entidad correspondiente
                  - Eliminar los espacios al inicio y fin de los tag
    **************************************************************** */
    FUNCTION fsbvalidatecharactersxml
    (
      isbCadena IN VARCHAR2
    )
    return varchar2;


    /***************************************************************************
    Unidad      :   RegisterEmergency
    Descripcion :   Registra la orden de la emergencia en la tabla de Eventos
                    notificables a Mobile
    ***************************************************************************/
    PROCEDURE RegisterEmergency
    (
        inuOrderId      in  or_order.order_id%type
    );

    /***************************************************************************
    Unidad      :   fblIsEmergencyAct
    Descripcion :   Valida si la actividad es actividad de emergencia
    ***************************************************************************/
    FUNCTION fblIsEmergencyAct
    (
        inuItemId       in  ge_items.items_id%type
    )
    return boolean;

    /***************************************************************************
    Unidad      :   ReportEmergencies
    Descripcion :   Reporta las emergencias al sistema externo por medio del
                    plug-in OS_EMERGENCY_ORDER
    ***************************************************************************/
    PROCEDURE ReportEmergencies;

    /***************************************************************************
    Unidad      :   fnValProductoCastigado
    Descripcion :   Valida si el producto esta castigado
    ***************************************************************************/
    FUNCTION fnValProductoCastigado
    (
        inuProducto       in  pr_product.product_id%type
    )
    return boolean;

END GE_BOEmergencyOrders;
/
CREATE OR REPLACE PACKAGE BODY      ge_boemergencyorders AS
/* *************************************************************
Propiedad intelectual de Open International Systems. (c).

Package	    : GE_BOEmergencyOrders
Descripcion	: Objeto de negocio para ?rdenes de emergencia

Autor	: Luis Alberto L?pez Agudelo
Fecha	: 15-08-2012

Historia de Modificaciones
Fecha           Autor               Modificacion
============    =================== ====================
06-05-2024  	Adrianavg           OSF-2640: Ajustar ReportEmergencies
19-05-2015  	jhinestrozaSAO_312755 Se modifica fclGetXML
22-08-2013      amendezSAO215164    Se modifica fclGetXML
                                    Constantes adicionadas:
                                        csbIdAldia
                                        csbIdConDeuda
                                        csbIdCastigado
                                        csbIdEnMora
                                        csbAlDia
                                        csbConDeuda
                                        csbCastigado
                                        csbEnMora
                                    Tipo adicionado:
                                        styFinancialDesc
31-07-2013      llopezSAO213575     Se modifica fclGetXML
04-07-2013      llopezSAO211279     Se modifica fclGetXML
08-09-2012      llopezSAO190491     Se modifica fclGetXML
15-08-2012      llopezSAO188151     Creaci?n
************************************************************** */

    --------------------------------------------
    -- Tipos y Variables
    --------------------------------------------
    -- Esta constante se debe modificar cada vez que se entregue el paquete con un SAO
    csbVersion                  constant varchar2(20) := 'SAO215164';

    --------------------------------------------
    -- Constantes
    --------------------------------------------

    --------------------------------------------
    -- Funciones y Procedimientos
    --------------------------------------------
    FUNCTION fsbVersion return varchar2 IS
    BEGIN
        Return csbVersion;
    END;


    FUNCTION fsbvalidatecharactersxml (isbCadena IN varchar2)
    RETURN VARCHAR2
  /*****************************************************************
  Propiedad intelectual de GDO (c).

  Unidad         : fsbValidateCharactersXML
  Descripcion    : Funcion que remplaza los caracteres reservados de un XML por su entidad equivalente .
  Autor          : Jose Edward Hinestroza
  Fecha          : 14/05/2015

  Parametros              Descripcion
  isbCadena               Cadena a procesar

  Fecha             Autor                    Modificacion
  =========       =========                  ====================
  14/05/2015      jhinestroza.SAO_312755     Creacion
  *****************************************************************/

  IS
    sbAmpersand     varchar2(5) := '&'; -- Signo Y comercial
    sbMenoQue       varchar2(5) := '<'; -- Signo Mayor que
    sbMayoQue       varchar2(5) := '>'; -- Signo Menor que
    sbComillaDoble  varchar2(5) := '"'; -- Signo Comilla Doble
    sbComillaSimple varchar2(5) := '''';-- Signo Comill Sencilla
    isbCadenaProcesada VARCHAR2(3000);
  BEGIN
    ut_trace.trace('INICIO FUNCION fsbValidateCharactersXML', 10);
    -- Se eliminan los espacios a la cadena para evitar excepciones en la lectura del XML
    isbCadenaProcesada := TRIM(isbCadena);
    -- Se hace el replace del ampersand(&), para no modificar los otros campos
    isbCadenaProcesada := replace(isbCadenaProcesada,sbAmpersand,sbAmpersand||'amp;');
    -- Se hace el replace a los otros campos (<, >, ", ')
    isbCadenaProcesada := replace(replace(replace(replace(isbCadenaProcesada,sbMenoQue,sbAmpersand||'lt;'),sbMayoQue,sbAmpersand||'gt;'),sbComillaDoble,sbAmpersand||'quot;'),sbComillaSimple,sbAmpersand||'apos;');
    ut_trace.trace('FIN FUNCION fsbValidateCharactersXML', 10);

    RETURN isbCadenaProcesada;

    EXCEPTION
    WHEN OTHERS THEN
       -- retorna la cadena sin espacion
       RETURN TRIM(isbCadena);

  END fsbValidateCharactersXML;






    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :   RegisterEmergency
    Descripcion :   Registra la orden de la emergencia en la tabla de Eventos
                    notificables a Mobile

    Autor       :   Luis Alberto l?pez Agudelo
    Fecha       :   15-08-2012
    Parametros  :
        inuOrderId      Identificador de la orden

    Historia de Modificaciones
    Fecha       Autor                   Modificaci?n
    =========== ===================     ===================================
    15-08-2012  llopezSAO188151         Creaci?n
    ***************************************************************************/
    PROCEDURE RegisterEmergency
    (
        inuOrderId      in  or_order.order_id%type
    )
    IS
        nuDummy ge_mobile_event.mobile_event_id%type;
    BEGIN
        -- Registra el evento en la tabla por medio del:
        GE_BONotifyToExtSys.RegisterMobileEvent(
            GE_BONotifyToExtSys.cnuETEmergency,
            inuOrderId,
            nuDummy
        );
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END RegisterEmergency;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :   fblIsEmergencyAct
    Descripcion :   Valida si la actividad es actividad de emergencia

    Autor       :   Luis Alberto l?pez Agudelo
    Fecha       :   15-08-2012
    Parametros  :
        inuItemId       Identificador de la actividad

    Historia de Modificaciones
    Fecha       Autor                   Modificaci?n
    =========== ===================     ===================================
    15-08-2012  llopezSAO188151         Creaci?n
    ***************************************************************************/
    FUNCTION fblIsEmergencyAct
    (
        inuItemId       in  ge_items.items_id%type
    )
    return boolean
    IS
    BEGIN
        return daor_emergency_items.fblExist(inuItemId);
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fblIsEmergencyAct;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :   fclGetXML
    Descripcion :   Crea el XML con la info de la orden

    Autor       :   Luis Alberto l?pez Agudelo
    Fecha       :   16-08-2012
    Parametros  :
        inuOrderId      Identificador de la orden

    Historia de Modificaciones
    Fecha       Autor                   Modificaci?n
    =========== ===================     ===================================
    19-05-2015  jhinestroza.SAO_312755  Se agrega en los campos del XML la funcion
                                        fsbValidateCharactersXML.
    21-08-2013  amendezSAO215164        Se modifica para adicionar los siguientes
                                        datos:
                                        - Descripci?n del sector operativo  <OPERATING_SECTOR_DESC>
                                        - Descripci?n del tipo de trabajo   <TASK_TYPE_DESC>
                                        - Direcci?n                         <ADDRESS_PARSED>
                                        - Nombre del barrio                 <NEIGHBORTHOOD_DESC>
                                        - Nombre localidad                  <GEOGRAP_LOCATION_DESC>
                                        - Nombre Departamento               <GEOGRAP_DEPARTMENT_DESC>
                                        - Descripci?n del medidor           <ELEMENT_DESC>
                                        - Descripci?n del estado financiero <FINANCIAL_STATE_DESC>
                                        - Descripci?n del estado de corte   <CUTSTATE_DESC>
                                        - Descripci?n de tipo de consumo.   <CONSTYPE_DESC> y <CONSUMPTIONTYPE_DESC>
    31-07-2013  llopezSao213575         Se modifica para enviar el estado de corte
                                        en CUTSTATE y el estado financiero en
                                        FINNANCIAL_STATE
    04-07-2013  llopezSAO211279         Se modifica para que solo envie las
                                        etiquetas obligatorias asi no tengan datos
                                            a.	GEOGRAP_LOCATION_ID
                                            b.	GEOGRAP_DEPARTMENT_ID
                                            c.	ORDER_ID
                                            d.	CREATED_DATE
                                            e.	EXTERNAL_ADDRESS_ID
                                            f.	PRIORITY
                                            g.	SERVICE_NUMBER
                                            h.	GEOGRAPHIC_LOCATION
                                            i.	PACKAGE_ID
                                            j.	LECTURE1
                                            k.	OPERATING_SECTOR_ID
                                            l.	SUBSCRIBER_NAME
                                            m.	TASK_TYPE_ID
                                            n.	NEIGHBORTHOOD
                                            o.	FINNANCIAL_STATE
    08-09-2012  llopezSAO190491         Se modifica etiqueta phone, manera de
                                        obtener producto, x y y de la direcci?n
    16-08-2012  llopezSAO188151         Creaci?n
    ***************************************************************************/
    FUNCTION fclGetXML
    (
        inuOrderId      in  or_order.order_id%type
    ) return clob
    IS
        clXML           clob;
        sbTag           ge_boutilities.styStatement;

        rcOrder         daor_order.styOR_order;
        rcSubscriber    dage_subscriber.styGE_subscriber;
        sbPhone         ge_subs_phone.full_phone_number%type;
        nuProductId     pr_product.product_id%type;
        nuPackageId     mo_packages.package_id%type;
        sbPackageComm   mo_packages.comment_%type;

        nuIdx           binary_integer;
        tbConsumptions  CM_BCMeasConsumptions.tytbConsumptions;
        tbReadings      pkbclectelme.tytbReadings;
        nuCurrentPeriod pericose.pecscons%type;
        rcServsusc      servsusc%rowtype;
        nuCurrPeriod    pericose.pecscons%type;
        nuPeriodAccum   number;
        sgAddressShape  ab_address.shape%type;
        nuAddressId     ab_address.address_id%type;

        nuLocalityId      ge_geogra_location.geograp_location_id%type;
        nuNeighBortHoodId ge_geogra_location.geograp_location_id%type;
        nuGeoDepartMentId ge_geogra_location.geograp_location_id%type;
        sbElementCode     elemmedi.elmecodi%type;
        sbFinancialDesc   styFinancialDesc;
        sbDescTipoCons    tipocons.tcondesc%type;
        sbOservacionAnexa VARCHAR2(500);

        -- Consumos promedios
        type tyrcAverCons is record
        (
            nuAverage       conssesu.cosscoca%type,
            nuAccumulator   number,
            clXMLConsuption clob
        );
        type tytbAverCons is table of tyrcAverCons index by binary_integer;
        tbAverCons      tytbAverCons;

        PROCEDURE GetAverConsumptions(
            itbConsumptions in      CM_BCMeasConsumptions.tytbConsumptions,
            otbAverCons     in out  NOCOPY tytbAverCons
        ) IS
            nuIdx   number;
        BEGIN
            otbAverCons.delete;

            nuIdx := itbConsumptions.first();
            while (nuIdx is not null) loop
                if (otbAverCons.exists(itbConsumptions(nuIdx).nuConsumptionType)) then
                    otbAverCons(itbConsumptions(nuIdx).nuConsumptionType).nuAverage :=
                        otbAverCons(itbConsumptions(nuIdx).nuConsumptionType).nuAverage + itbConsumptions(nuIdx).nuConsumption;
                    otbAverCons(itbConsumptions(nuIdx).nuConsumptionType).nuAccumulator :=
                        otbAverCons(itbConsumptions(nuIdx).nuConsumptionType).nuAccumulator + 1;
                else
                    otbAverCons(itbConsumptions(nuIdx).nuConsumptionType).nuAverage := itbConsumptions(nuIdx).nuConsumption;
                    otbAverCons(itbConsumptions(nuIdx).nuConsumptionType).nuAccumulator := 1;
                end if;
                nuIdx := itbConsumptions.next(nuIdx);
            end loop;
            nuIdx := otbAverCons.first();
            while (nuIdx is not null) loop
                otbAverCons(nuIdx).nuAverage := otbAverCons(nuIdx).nuAverage / otbAverCons(nuIdx).nuAccumulator;
                otbAverCons(nuIdx).nuAccumulator := 0;
                nuIdx := otbAverCons.next(nuIdx);
            end loop;
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END GetAverConsumptions;

        FUNCTION fsbGetTag(sbLabel varchar2, sbValue varchar2, nuLevel number default 1) return varchar2
        IS
            sbTempTag   ge_boutilities.styStatement;
        BEGIN
            sbTempTag := '<'||sbLabel||'>'||sbValue||'</'||sbLabel||'>';
            sbTempTag := lpad(sbTempTag, length(sbTempTag) + (nuLevel-1)*2, '  ');
            return sbTempTag||chr(10);
        EXCEPTION
            when ex.CONTROLLED_ERROR then
                raise ex.CONTROLLED_ERROR;
            when others then
                Errors.setError;
                raise ex.CONTROLLED_ERROR;
        END fsbGetTag;
    BEGIN
        --<EmergencyData>
        clXML := '<EmergencyData>'||chr(10);

        --  <ORDER_ID>1101</ORDER_ID>
        sbTag := fsbGetTag('ORDER_ID',fsbValidateCharactersXML(inuOrderId),2);-- se agrega fsbValidateCharactersXML
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- Obtener registro de la orden
        rcOrder := daor_order.frcGetRecord(inuOrderId);

        --  <CREATED_DATE>02-07-2012 17:28:27</CREATED_DATE>
        sbTag := fsbGetTag('CREATED_DATE',to_char(rcOrder.created_date,'dd-mm-yyyy HH24:mi:ss'),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        --  <PRIORITY>1</PRIORITY>
        sbTag := fsbGetTag('PRIORITY',rcOrder.priority,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        --  <OPERATING_SECTOR_ID>1</OPERATING_SECTOR_ID>
        -- fsbValidateCharactersXML
        sbTag := fsbGetTag('OPERATING_SECTOR_ID',fsbValidateCharactersXML(rcOrder.operating_sector_id),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <OPERATING_SECTOR_DESC>VISTA HERMOSA</OPERATING_SECTOR_DESC>
        sbTag := fsbGetTag
                 ('OPERATING_SECTOR_DESC',
                  daor_operating_sector.fsbGetDescription(rcOrder.operating_sector_id,0)
                  ,2
                 );
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <TASK_TYPE_ID>2200</TASK_TYPE_ID>
        sbTag := fsbGetTag('TASK_TYPE_ID',rcOrder.task_type_id,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <TASK_TYPE_DESC>VERIFICACION DE INCIDENTE EN PRODUCTO</TASK_TYPE_DESC>
        -- fsbValidateCharactersXML
        sbTag := fsbGetTag
                 ('TASK_TYPE_DESC',
                  fsbValidateCharactersXML(daor_task_type.fsbGetDescription(rcOrder.task_type_id,0))
                  ,2
                 );
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        --  <EXTERNAL_ADDRESS_ID>80794</EXTERNAL_ADDRESS_ID>
        sbTag := fsbGetTag('EXTERNAL_ADDRESS_ID',rcOrder.external_address_id,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <ADDRESS_PARSED>CL 29 OESTE AV 6 OESTE - 77</ADDRESS_PARSED>
        sbTag := fsbGetTag('ADDRESS_PARSED',daab_address.fsbGetAddress_Parsed(rcOrder.external_address_id,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- Si el cliente no es nulo
        if (rcOrder.subscriber_id IS not null) then
            -- obtiene registro del suscriptor
            rcSubscriber := dage_subscriber.frcGetRecord(rcOrder.subscriber_id);

            --  <SUBSCRIBER_NAME>MARIO MURILLO</SUBSCRIBER_NAME>
            sbTag := fsbGetTag('SUBSCRIBER_NAME',rcSubscriber.subscriber_name||' - '||rcSubscriber.Subs_Last_Name,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            sbPhone := cc_boOssSubscriberData.fsbGetPhone(rcOrder.subscriber_id);
            if (sbPhone is not null) then
                --  <PHONE>2561454</PHONE>
                sbTag := fsbGetTag('PHONE',sbPhone,2);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);
            end if;
        else
            --  <SUBSCRIBER_NAME></SUBSCRIBER_NAME>
            sbTag := fsbGetTag('SUBSCRIBER_NAME',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        end if;

        -- <NEIGHBORTHOOD_ID>2</NEIGHBORTHOOD_ID>
        nuNeighBortHoodId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(rcOrder.external_address_id, AB_BOConstants.csbToken_BARRIO);
        sbTag := fsbGetTag('NEIGHBORTHOOD_ID',nuNeighBortHoodId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <NEIGHBORTHOOD_DESC>VISTA HERMOSA</NEIGHBORTHOOD_DESC>
        sbTag := fsbGetTag('NEIGHBORTHOOD_DESC',dage_geogra_location.fsbGetDescription(nuNeighBortHoodId,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_LOCATION_ID>4</GEOGRAP_LOCATION_ID>
        nuLocalityId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(rcOrder.external_address_id, AB_BOConstants.csbToken_LOCALIDAD);
        sbTag := fsbGetTag('GEOGRAP_LOCATION_ID',nuLocalityId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_LOCATION_DESC>SANTIAGO DE CALI</GEOGRAP_LOCATION_DESC>
        sbTag := fsbGetTag('GEOGRAP_LOCATION_DESC',dage_geogra_location.fsbGetDescription(nuLocalityId,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_DEPARTMENT_ID>55</GEOGRAP_DEPARTMENT_ID>
        nuGeoDepartMentId := ge_bogeogra_location.fnuGetGeo_LocaByAddress(rcOrder.external_address_id, AB_BOConstants.csbToken_DEPARTAMENTO);
        sbTag := fsbGetTag('GEOGRAP_DEPARTMENT_ID',nuGeoDepartMentId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_DEPARTMENT_DESC>VALLE DEL CAUCA</GEOGRAP_DEPARTMENT_DESC>
        sbTag := fsbGetTag('GEOGRAP_DEPARTMENT_DESC',dage_geogra_location.fsbGetDescription(nuGeoDepartMentId,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        sgAddressShape := daab_address.fsgGetShape(rcOrder.external_address_id, 0);
        ab_bogeometria.GetPointCordinates(sgAddressShape, rcOrder.x, rcOrder.y);

        --  <GEOGRAPHIC_LOCATION>2.9291999999E-8;0.002302</GEOGRAPHIC_LOCATION>
        if (rcOrder.x is not null AND rcOrder.y is not null) then
            sbTag := fsbGetTag('GEOGRAPHIC_LOCATION',rcOrder.x||';'||rcOrder.y,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        else
            sbTag := fsbGetTag('GEOGRAPHIC_LOCATION',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        END if;

        -- Obtiene la solicitud de la orden
        nuPackageId := Or_BcOrderActivities.fnuGetPackIdInFirstAct(inuOrderId);

        --  <PACKAGE_ID>128135</PACKAGE_ID>
        sbTag := fsbGetTag('PACKAGE_ID',nuPackageId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- Obtiene el producto asociado a la orden
        nuProductId := Or_BcOrderActivities.fnuGetProdIdInFirstAct(inuOrderId);
        IF OPEN.fblAplicaEntrega('OSS_MAN_JGBA_2001731_2') THEN
            IF fnValProductoCastigado(nuProductId) THEN
              sbOservacionAnexa := 'CASTIGADO - NO REALIZAR TRABAJOS. USUARIO CON CARTERA CASTIGADA ';
            END IF;
        END IF;

        sbPackageComm := DAMO_packages.fsbGetComment_(nuPackageId, 0);
        if (sbPackageComm is not null OR sbOservacionAnexa IS NOT NULL) then
            --  <COMMENT>Observaci?n de la solicitud</COMMENT>
            -- fsbValidateCharactersXML
            sbTag := fsbGetTag('COMMENT',fsbValidateCharactersXML(NVL(sbOservacionAnexa,'')||NVL(sbPackageComm,'')),2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        end if;



        if (nuProductId is not null) then
            --  <SERVICE_NUMBER>3210130</SERVICE_NUMBER>
            sbTag := fsbGetTag('SERVICE_NUMBER',dapr_product.fsbGetService_Number(nuProductId, 0),2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            rcServsusc := pktblservsusc.frcGetRecord(nuProductId);

            if (rcServsusc.Sesuesco is not null) then
                --  <CUTSTATE>1</CUTSTATE>
                sbTag := fsbGetTag('CUTSTATE',rcServsusc.Sesuesco,2);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                --  <CUTSTATE_DESC>SUSPENSION TOTAL</CUTSTATE_DESC>
                sbTag := fsbGetTag('CUTSTATE_DESC',pktblestacort.fsbGetDescription(rcServsusc.Sesuesco),2);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);
            end if;

            --  <FINNANCIAL_STATE>A</FINNANCIAL_STATE>
            sbTag := fsbGetTag('FINNANCIAL_STATE',rcServsusc.Sesuesfn,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            --  <FINANCIAL_STATE_DESC>AL D?A</FINANCIAL_STATE_DESC>
            IF    rcServsusc.Sesuesfn = csbIdAlDia     then sbFinancialDesc := csbAlDia;
            ELSIF rcServSusc.Sesuesfn = csbIdConDeuda  then sbFinancialDesc := csbConDeuda;
            ELSIF rcServSusc.Sesuesfn = csbIdCastigado then sbFinancialDesc := csbCastigado;
            ELSIF rcServSusc.Sesuesfn = csbIdEnMora    then sbFinancialDesc := csbEnMora;
            ELSE  sbFinancialDesc := NULL;
            END IF;
            sbTag := fsbGetTag('FINANCIAL_STATE_DESC',sbFinancialDesc,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            -- Consumos
            BEGIN
                -- Obtiene el per?odo de consumo Actual --
                pkBCPericose.GetConsPeriodByDate
                (
                    rcServsusc.Sesucico,        -- Ciclo de Consumo
                    trunc(ut_date.fdtSysdate),  -- Fecha actual
                    nuCurrentPeriod             -- (out) Per?odo de consumoa actual
                );

            EXCEPTION
                when others then
                    nuCurrentPeriod := null;
            END;

            if (nuCurrentPeriod is not null) then
                -- Obtiene los ?ltimos 6 consumos
                CM_BCMeasConsumptions.GetProdConsumptions(
                    nuProductId,
                    null,
                    nuCurrentPeriod,
                    CM_BCMeasConsumptions.csbINCLUDE_CURR_PERIOD,
                    6,
                    tbConsumptions
                );

                if (tbConsumptions.first is not null) then
                    --  <CONSUMPTIONS>
                    sbTag := '  <CONSUMPTIONS>'||chr(10);
                    dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                    -- obtiene promedios por tipo de consumo
                    GetAverConsumptions(tbConsumptions, tbAverCons);

                    nuIdx := tbConsumptions.first();
                    while (nuIdx is not null) loop

                        if (tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).nuAccumulator = 0) then
                            --    <CONSUMPTION>
                            tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).clXMLConsuption := '    <CONSUMPTION>'||chr(10);
                            --      <CONSUMPTIONTYPE>1</CONSUMPTIONTYPE>
                            sbTag := fsbGetTag('CONSUMPTIONTYPE',tbConsumptions(nuIdx).nuConsumptionType,4);
                            dbms_lob.writeappend(tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).clXMLConsuption, length(sbTag), sbTag);

                            --      <CONSUMPTIONTYPE_DESC>CONSUMO GAS</CONSUMPTIONTYPE_DESC>
                            IF tbConsumptions(nuIdx).nuConsumptionType IS NOT NULL THEN
                                sbDescTipoCons := pktbltipocons.fsbGetDescription(tbConsumptions(nuIdx).nuConsumptionType);
                            else
                                sbDescTipoCons := null;
                            END IF;
                            sbTag := fsbGetTag('CONSUMPTIONTYPE_DESC',sbDescTipoCons,4);
                            dbms_lob.writeappend(tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).clXMLConsuption, length(sbTag), sbTag);

                            --      <AVERAGECONS>450</AVERAGECONS>
                            sbTag := fsbGetTag('AVERAGECONS',tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).nuAverage,4);
                            dbms_lob.writeappend(tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).clXMLConsuption, length(sbTag), sbTag);
                        end if;

                        tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).nuAccumulator :=
                            tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).nuAccumulator + 1;
                        --      <CONSUMPTION#>614</CONSUMPTION#>
                        sbTag := fsbGetTag(
                            'CONSUMPTION'||tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).nuAccumulator,
                            tbConsumptions(nuIdx).nuConsumption,
                            4);
                        dbms_lob.writeappend(tbAverCons(tbConsumptions(nuIdx).nuConsumptionType).clXMLConsuption, length(sbTag), sbTag);

                        nuIdx := tbConsumptions.next(nuIdx);
                    end loop;

                    nuIdx := tbAverCons.first();
                    while (nuIdx is not null) loop
                        --    </CONSUMPTION>
                        sbTag := '    </CONSUMPTION>'||chr(10);
                        dbms_lob.writeappend(tbAverCons(nuIdx).clXMLConsuption, length(sbTag), sbTag);
                        dbms_lob.append(clXML, tbAverCons(nuIdx).clXMLConsuption);
                        nuIdx := tbAverCons.next(nuIdx);
                    end loop;

                    --  </CONSUMPTIONS>
                    sbTag := '  </CONSUMPTIONS>'||chr(10);
                    dbms_lob.writeappend(clXML, length(sbTag), sbTag);
                end if;

                --Lecturas
                --  <READINGS>
                sbTag := '  <READINGS>'||chr(10);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                -- Obtiene las ?ltimos 6 lecturas del producto
                pkbclectelme.GetProdReadings(
                    nuProductId,
                    nuCurrentPeriod,
                    6,
                    tbReadings
                );

                nuIdx := tbReadings.first();
                while (nuIdx is not null) loop
                    if (nvl(nuCurrPeriod, 0.1) <> tbReadings(nuIdx).nuPeriod) then
                        nuPeriodAccum := nvl(nuPeriodAccum, 0) + 1;
                        nuCurrPeriod := tbReadings(nuIdx).nuPeriod;
                    end if;

                    if (nuPeriodAccum <= 6) then

                        --    </READ>
                        sbTag := '    <READ>'||chr(10);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <PERIOD>7326</PERIOD>
                        sbTag := fsbGetTag('PERIOD',tbReadings(nuIdx).nuPeriod,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <CONSTYPE>34</CONSTYPE>
                        sbTag := fsbGetTag('CONSTYPE',tbReadings(nuIdx).nuConsumptionType,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <CONSTYPE_DESC>CONSUMO GAS</CONSTYPE_DESC>
                        IF tbReadings(nuIdx).nuConsumptionType IS NOT NULL THEN
                            sbDescTipoCons := pktbltipocons.fsbGetDescription(tbReadings(nuIdx).nuConsumptionType);
                        else
                            sbDescTipoCons := null;
                        END IF;
                        sbTag := fsbGetTag('CONSTYPE_DESC',sbDescTipoCons,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <ELEMENT>135</ELEMENT>
                        sbTag := fsbGetTag('ELEMENT',tbReadings(nuIdx).nuElementId,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <ELEMENT_CODE>342213-1996-01</ELEMENT_CODE>
                        sbElementCode := NULL;
                        IF tbReadings(nuIdx).nuElementId IS NOT NULL THEN
                            sbElementCode := pktblelemmedi.fsbGetElmecodi(tbReadings(nuIdx).nuElementId);
                        END IF;
                        sbTag := fsbGetTag('ELEMENT_CODE',sbElementCode,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <READING>130251</READING>
                        sbTag := fsbGetTag('READING',tbReadings(nuIdx).nuReading,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <OBS1></OBS1>
                        sbTag := fsbGetTag('OBS1',tbReadings(nuIdx).sbObs1,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <OBS2></OBS2>
                        sbTag := fsbGetTag('OBS2',tbReadings(nuIdx).sbObs2,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --      <OBS3></OBS3>
                        sbTag := fsbGetTag('OBS3',tbReadings(nuIdx).sbObs3,4);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                        --    </READ>
                        sbTag := '    </READ>'||chr(10);
                        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                    end if;

                    nuIdx := tbReadings.next(nuIdx);
                end loop;

                --  </READINGS>
                sbTag := '  </READINGS>'||chr(10);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);
            else
                --  <READINGS></READINGS>
                sbTag := fsbGetTag('READINGS',null,2);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);
            end if;
        else
            --  <SERVICE_NUMBER></SERVICE_NUMBER>
            sbTag := fsbGetTag('SERVICE_NUMBER',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            --  <FINNANCIAL_STATE></FINNANCIAL_STATE>
            sbTag := fsbGetTag('FINNANCIAL_STATE',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            --  <FINANCIAL_STATE_DESC></FINANCIAL_STATE_DESC>
            sbTag := fsbGetTag('FINANCIAL_STATE_DESC',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            --  <READINGS></READINGS>
            sbTag := fsbGetTag('READINGS',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        end if;

        --</EmergencyData>
        sbTag := '</EmergencyData> ';
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        return clXML;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fclGetXML;

    /***************************************************************************
    Propiedad intelectual de Open International Systems (c).
    Unidad      :   ReportEmergencies
    Descripcion :   Reporta las emergencias al sistema externo por medio del
                    plug-in OS_EMERGENCY_ORDER

    Autor       :   Luis Alberto l?pez Agudelo
    Fecha       :   16-08-2012

    Historia de Modificaciones
    Fecha       Autor                   Modificaci?n
    =========== ===================     ===================================
    16-08-2012  llopezSAO188151         Creaci?n
    06-05-2024  Adrianavg               OSF-2640: Retirar llamado a OS_EMERGENCY_ORDER(clXML, nuErrorCode, sbErrorMessage)    
    ***************************************************************************/
    PROCEDURE ReportEmergencies
    IS
        rfPendingEmerg  constants.tyRefCursor;
        tbPendingEmerg  dage_mobile_event.tytbGE_mobile_event;
        nuIdx           binary_integer;
        nuErrorCode     ge_error_log.error_log_id%type;
        sbErrorMessage  ge_error_log.description%type;
        clXml           clob;
    BEGIN
        rfPendingEmerg := GE_BCEmergencyOrders.frfGetPendEmergencies();

        fetch rfPendingEmerg BULK COLLECT INTO tbPendingEmerg;
        nuIdx := tbPendingEmerg.first;

        while (nuIdx is not null) loop
            BEGIN
                -- coloca inicio del proceso
                tbPendingEmerg(nuIdx).sent_init_date := ut_date.fdtSysdate;

                -- OPbtiene XML
                clXml := fclGetXML(tbPendingEmerg(nuIdx).reference_value);

                -- Valida si termino con error
                if (nuErrorCode is null OR nuErrorCode = ge_boconstants.cnuSUCCESS) then
                    tbPendingEmerg(nuIdx).event_successfull := null;
                else
                    tbPendingEmerg(nuIdx).event_successfull := ge_boconstants.csbNO;
                end if;
                -- Indica c?digo y mensaje de error devuelto
                tbPendingEmerg(nuIdx).error_code := nuErrorCode;
                tbPendingEmerg(nuIdx).error_message := sbErrorMessage;
                tbPendingEmerg(nuIdx).sent_end_date := ut_date.fdtSysdate;

                -- Actualiza el registro
                dage_mobile_event.updRecord(tbPendingEmerg(nuIdx));

            EXCEPTION
                when ex.CONTROLLED_ERROR  then
                    Errors.getError(nuErrorCode, sbErrorMessage);
                    -- Reporta error
                    tbPendingEmerg(nuIdx).error_code := nuErrorCode;
                    tbPendingEmerg(nuIdx).error_message := sbErrorMessage;
                    tbPendingEmerg(nuIdx).sent_end_date := ut_date.fdtSysdate;
                    dage_mobile_event.updRecord(tbPendingEmerg(nuIdx));
                when OTHERS then
                    Errors.setError;
                    Errors.getError(nuErrorCode, sbErrorMessage);
                    -- Reporta error
                    tbPendingEmerg(nuIdx).error_code := nuErrorCode;
                    tbPendingEmerg(nuIdx).error_message := sbErrorMessage;
                    tbPendingEmerg(nuIdx).sent_end_date := ut_date.fdtSysdate;
                    dage_mobile_event.updRecord(tbPendingEmerg(nuIdx));
            END;
            nuIdx := tbPendingEmerg.next(nuIdx);
        end loop;

        close rfPendingEmerg;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END ReportEmergencies;

     /***************************************************************************
    Unidad      :   fnValProductoCastigado
    Descripcion :   Valida si el producto esta castigado
    Autor       :   Josh Brito CASO 200-1731
    ***************************************************************************/
    FUNCTION fnValProductoCastigado
    (
        inuProducto       in  pr_product.product_id%type
    )
    return boolean
    is
      CONTADOR NUMBER DEFAULT 0;
    begin
      SELECT COUNT(1) INTO CONTADOR
        FROM SERVSUSC
        WHERE SESUESFN = 'C'
        AND SESUNUSE = inuProducto;

      IF CONTADOR > 0 THEN
        RETURN TRUE;
      ELSE
        RETURN FALSE;
      END IF;
    EXCEPTION
        when ex.CONTROLLED_ERROR then
            raise ex.CONTROLLED_ERROR;
        when others then
            Errors.setError;
            raise ex.CONTROLLED_ERROR;
    END fnValProductoCastigado;


END GE_BOEmergencyOrders;
/
