PL/SQL Developer Test script 3.0
486
declare
  subtype styFinancialDesc IS varchar2(20);
       -- Codigos de Estados Financieros (Check Constraints)
    csbIdAldia               constant OPEN.servsusc.sesuesfn%type := 'A';
    csbIdConDeuda            constant OPEN.servsusc.sesuesfn%type := 'D';
    csbIdCastigado           constant OPEN.servsusc.sesuesfn%type := 'C';
    csbIdEnMora              constant OPEN.servsusc.sesuesfn%type := 'M';
    -- Descripcion de Estados Financieros (Check Constraint)
    csbAlDia                 constant styFinancialDesc := 'Al dia';
    csbConDeuda              constant styFinancialDesc := 'Con deuda';
    csbCastigado             constant styFinancialDesc := 'Castigado';
    csbEnMora                constant styFinancialDesc := 'En mora';
        inuOrderId      open.or_order.order_id%type:=216691515;

        clXML           clob;
        sbTag           open.ge_boutilities.styStatement;

        rcOrder         open.daor_order.styOR_order;
        rcSubscriber    open.dage_subscriber.styGE_subscriber;
        sbPhone         open.ge_subs_phone.full_phone_number%type;
        nuProductId     open.pr_product.product_id%type;
        nuPackageId     open.mo_packages.package_id%type;
        sbPackageComm   open.mo_packages.comment_%type;

        nuIdx           binary_integer;
        tbConsumptions  open.CM_BCMeasConsumptions.tytbConsumptions;
        tbReadings      open.pkbclectelme.tytbReadings;
        nuCurrentPeriod open.pericose.pecscons%type;
        rcServsusc      open.servsusc%rowtype;
        nuCurrPeriod    open.pericose.pecscons%type;
        nuPeriodAccum   number;
        sgAddressShape  open.ab_address.shape%type;
        nuAddressId     open.ab_address.address_id%type;

        nuLocalityId      open.ge_geogra_location.geograp_location_id%type;
        nuNeighBortHoodId open.ge_geogra_location.geograp_location_id%type;
        nuGeoDepartMentId open.ge_geogra_location.geograp_location_id%type;
        sbElementCode     open.elemmedi.elmecodi%type;
        sbFinancialDesc   varchar2(4000);
        sbDescTipoCons    open.tipocons.tcondesc%type;
        sbOservacionAnexa VARCHAR2(500);

        -- Consumos promedios
        type tyrcAverCons is record
        (
            nuAverage       open.conssesu.cosscoca%type,
            nuAccumulator   number,
            clXMLConsuption clob
        );
        type tytbAverCons is table of tyrcAverCons index by binary_integer;
        tbAverCons      tytbAverCons;

        PROCEDURE GetAverConsumptions(
            itbConsumptions in      open.CM_BCMeasConsumptions.tytbConsumptions,
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
            when others then
            dbms_output.put_line('error'||sqlerrm);
        END GetAverConsumptions;

        FUNCTION fsbGetTag(sbLabel varchar2, sbValue varchar2, nuLevel number default 1) return varchar2
        IS
            sbTempTag   open.ge_boutilities.styStatement;
        BEGIN
            sbTempTag := '<'||sbLabel||'>'||sbValue||'</'||sbLabel||'>';
            sbTempTag := lpad(sbTempTag, length(sbTempTag) + (nuLevel-1)*2, '  ');
            return sbTempTag||chr(10);
        EXCEPTION
            when others then
             dbms_output.put_line('Error'||sqlerrm);
        END fsbGetTag;
        
        FUNCTION fnValProductoCastigado
    (
        inuProducto       in  OPEN.pr_product.product_id%type
    )
    return boolean
    is
      CONTADOR NUMBER DEFAULT 0;
    begin
      SELECT COUNT(1) INTO CONTADOR
        FROM OPEN.SERVSUSC
        WHERE SESUESFN = 'C'
        AND SESUNUSE = inuProducto;

      IF CONTADOR > 0 THEN
        RETURN TRUE;
      ELSE
        RETURN FALSE;
      END IF;
    EXCEPTION
             when others then
             dbms_output.put_line('Error'||sqlerrm);
    END fnValProductoCastigado;

    BEGIN
        --<EmergencyData>
        clXML := '<EmergencyData>'||chr(10);

        --  <ORDER_ID>1101</ORDER_ID>
        sbTag := fsbGetTag('ORDER_ID',inuOrderId,2);-- se agrega fsbValidateCharactersXML
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- Obtener registro de la orden
        rcOrder := open.daor_order.frcGetRecord(inuOrderId);

        --  <CREATED_DATE>02-07-2012 17:28:27</CREATED_DATE>
        sbTag := fsbGetTag('CREATED_DATE',to_char(rcOrder.created_date,'dd-mm-yyyy HH24:mi:ss'),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        --  <PRIORITY>1</PRIORITY>
        sbTag := fsbGetTag('PRIORITY',rcOrder.priority,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        --  <OPERATING_SECTOR_ID>1</OPERATING_SECTOR_ID>
        -- fsbValidateCharactersXML
        sbTag := fsbGetTag('OPERATING_SECTOR_ID',rcOrder.operating_sector_id,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <OPERATING_SECTOR_DESC>VISTA HERMOSA</OPERATING_SECTOR_DESC>
        sbTag := fsbGetTag
                 ('OPERATING_SECTOR_DESC',
                 open.daor_operating_sector.fsbGetDescription(rcOrder.operating_sector_id,0)
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
                  open.daor_task_type.fsbGetDescription(rcOrder.task_type_id,0)
                  ,2
                 );
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        --  <EXTERNAL_ADDRESS_ID>80794</EXTERNAL_ADDRESS_ID>
        sbTag := fsbGetTag('EXTERNAL_ADDRESS_ID',rcOrder.external_address_id,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <ADDRESS_PARSED>CL 29 OESTE AV 6 OESTE - 77</ADDRESS_PARSED>
        sbTag := fsbGetTag('ADDRESS_PARSED',open.daab_address.fsbGetAddress_Parsed(rcOrder.external_address_id,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- Si el cliente no es nulo
        if (rcOrder.subscriber_id IS not null) then
            -- obtiene registro del suscriptor
            rcSubscriber := open.dage_subscriber.frcGetRecord(rcOrder.subscriber_id);

            --  <SUBSCRIBER_NAME>MARIO MURILLO</SUBSCRIBER_NAME>
            sbTag := fsbGetTag('SUBSCRIBER_NAME',rcSubscriber.subscriber_name||' - '||rcSubscriber.Subs_Last_Name,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            sbPhone := open.cc_boOssSubscriberData.fsbGetPhone(rcOrder.subscriber_id);
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
        nuNeighBortHoodId := open.ge_bogeogra_location.fnuGetGeo_LocaByAddress(rcOrder.external_address_id, open.AB_BOConstants.csbToken_BARRIO);
        sbTag := fsbGetTag('NEIGHBORTHOOD_ID',nuNeighBortHoodId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <NEIGHBORTHOOD_DESC>VISTA HERMOSA</NEIGHBORTHOOD_DESC>
        sbTag := fsbGetTag('NEIGHBORTHOOD_DESC',open.dage_geogra_location.fsbGetDescription(nuNeighBortHoodId,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_LOCATION_ID>4</GEOGRAP_LOCATION_ID>
        nuLocalityId := open.ge_bogeogra_location.fnuGetGeo_LocaByAddress(rcOrder.external_address_id, open.AB_BOConstants.csbToken_LOCALIDAD);
        sbTag := fsbGetTag('GEOGRAP_LOCATION_ID',nuLocalityId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_LOCATION_DESC>SANTIAGO DE CALI</GEOGRAP_LOCATION_DESC>
        sbTag := fsbGetTag('GEOGRAP_LOCATION_DESC',open.dage_geogra_location.fsbGetDescription(nuLocalityId,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_DEPARTMENT_ID>55</GEOGRAP_DEPARTMENT_ID>
        nuGeoDepartMentId := open.ge_bogeogra_location.fnuGetGeo_LocaByAddress(rcOrder.external_address_id, open.AB_BOConstants.csbToken_DEPARTAMENTO);
        sbTag := fsbGetTag('GEOGRAP_DEPARTMENT_ID',nuGeoDepartMentId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- <GEOGRAP_DEPARTMENT_DESC>VALLE DEL CAUCA</GEOGRAP_DEPARTMENT_DESC>
        sbTag := fsbGetTag('GEOGRAP_DEPARTMENT_DESC',open.dage_geogra_location.fsbGetDescription(nuGeoDepartMentId,0),2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        sgAddressShape := open.daab_address.fsgGetShape(rcOrder.external_address_id, 0);
        "OPEN".ab_bogeometria.GetPointCordinates(sgAddressShape, rcOrder.x, rcOrder.y);

        --  <GEOGRAPHIC_LOCATION>2.9291999999E-8;0.002302</GEOGRAPHIC_LOCATION>
        if (rcOrder.x is not null AND rcOrder.y is not null) then
            sbTag := fsbGetTag('GEOGRAPHIC_LOCATION',rcOrder.x||';'||rcOrder.y,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        else
            sbTag := fsbGetTag('GEOGRAPHIC_LOCATION',null,2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        END if;

        -- Obtiene la solicitud de la orden
        nuPackageId := open.Or_BcOrderActivities.fnuGetPackIdInFirstAct(inuOrderId);

        --  <PACKAGE_ID>128135</PACKAGE_ID>
        sbTag := fsbGetTag('PACKAGE_ID',nuPackageId,2);
        dbms_lob.writeappend(clXML, length(sbTag), sbTag);

        -- Obtiene el producto asociado a la orden
        nuProductId := open.Or_BcOrderActivities.fnuGetProdIdInFirstAct(inuOrderId);
        IF OPEN.fblAplicaEntrega('OSS_MAN_JGBA_2001731_2') THEN
            IF fnValProductoCastigado(nuProductId) THEN
              sbOservacionAnexa := 'CASTIGADO - NO REALIZAR TRABAJOS. USUARIO CON CARTERA CASTIGADA ';
            END IF;
        END IF;

        sbPackageComm := OPEN.DAMO_packages.fsbGetComment_(nuPackageId, 0);
        if (sbPackageComm is not null OR sbOservacionAnexa IS NOT NULL) then
            --  <COMMENT>Observaci?n de la solicitud</COMMENT>
            -- fsbValidateCharactersXML
            sbTag := fsbGetTag('COMMENT',NVL(sbOservacionAnexa,'')||NVL(sbPackageComm,''),2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);
        end if;



        if (nuProductId is not null) then
            --  <SERVICE_NUMBER>3210130</SERVICE_NUMBER>
            sbTag := fsbGetTag('SERVICE_NUMBER',OPEN.dapr_product.fsbGetService_Number(nuProductId, 0),2);
            dbms_lob.writeappend(clXML, length(sbTag), sbTag);

            rcServsusc := OPEN.pktblservsusc.frcGetRecord(nuProductId);

            if (rcServsusc.Sesuesco is not null) then
                --  <CUTSTATE>1</CUTSTATE>
                sbTag := fsbGetTag('CUTSTATE',rcServsusc.Sesuesco,2);
                dbms_lob.writeappend(clXML, length(sbTag), sbTag);

                --  <CUTSTATE_DESC>SUSPENSION TOTAL</CUTSTATE_DESC>
                sbTag := fsbGetTag('CUTSTATE_DESC',OPEN.pktblestacort.fsbGetDescription(rcServsusc.Sesuesco),2);
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
                "OPEN".pkBCPericose.GetConsPeriodByDate
                (
                    rcServsusc.Sesucico,        -- Ciclo de Consumo
                    trunc(OPEN.ut_date.fdtSysdate),  -- Fecha actual
                    nuCurrentPeriod             -- (out) Per?odo de consumoa actual
                );

            EXCEPTION
                when others then
                    nuCurrentPeriod := null;
            END;

            if (nuCurrentPeriod is not null) then
                -- Obtiene los ?ltimos 6 consumos
                "OPEN".CM_BCMeasConsumptions.GetProdConsumptions(
                    nuProductId,
                    null,
                    nuCurrentPeriod,
                    OPEN.CM_BCMeasConsumptions.csbINCLUDE_CURR_PERIOD,
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
                                sbDescTipoCons := OPEN.pktbltipocons.fsbGetDescription(tbConsumptions(nuIdx).nuConsumptionType);
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
                "OPEN".pkbclectelme.GetProdReadings(
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
                            sbDescTipoCons := OPEN.pktbltipocons.fsbGetDescription(tbReadings(nuIdx).nuConsumptionType);
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
                            sbElementCode := OPEN.pktblelemmedi.fsbGetElmecodi(tbReadings(nuIdx).nuElementId);
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
        dbms_output.put_line(clXML);
        --return clXML;
  
end;
0
0
