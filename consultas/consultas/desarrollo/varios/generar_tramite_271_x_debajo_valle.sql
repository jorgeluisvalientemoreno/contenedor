declare
    osbErrorMessage VARCHAR2(4000);
    onuErrorCode NUMBER;
    subscriptionId NUMBER;
    packageId NUMBER;

    personId NUMBER := 13615;
    operatingUnitId NUMBER := 3850;
    documentTypeId NUMBER := 1;
    documentConsecutiveType NUMBER := 596;
    documentKey NUMBER := 9050021;
    comment varchar2(2000) := '[CONSTRUCTORA-184825879] Solicitud hija para proyecto constructor especial Mirla T17. Solicitud 184825879';
    addressId number := 3773504;
    categoryId number := 1;
    subcategoryId number := 3;
    subscriberIdentificationType number := 110;
    subscriberIdentification varchar2(2000) := '8605134931';
    subscriberName varchar2(2000) := 'CONSTRUCTORA BOLIVAR S.A.';
    subscriberLastName varchar2(2000) := 'CONSTRUCTOR';
    subscriberPhone varchar2(2000) := '3016857815';
    subscriberEmail varchar2(2000) := 'maria.pastrana@constructorabolivar.com';
    companyName varchar2(2000) := 'CONSTRUCTORA BOLIVAR S.A.';
    companyTitle varchar2(2000) := '';
    personQuantity number := 1;
    previousEnergySource number := 1;
    inConstruction varchar2(2000) := 'N';
    salesmanId number := -1;
    installationOperatingUnitId number := 3478;
    certificationOperatingUnitId number := 3479;
    premiseTypeId number := 3;
    premiseSeparation varchar2(2000) := 'N';
    law1581 number := 1;
    commercialPlanId number := 54;
    totalSaleValue number := 731911;
    financingPlanId number := 23;
    downPayment number := 125000;
    numInstallments number := 36;
    totalFinancedValue number := 606911;
    monthlyPaymentValue number := 23526;
    downPaymentMode number := 13;
    downPaymentReceived varchar2(100) := 'N';
    usage number := 1;
    installationType number := 1;


    sbWorkInstance VARCHAR2(2000);
    sbInstancia VARCHAR2(2000);
    sbInstanciaMotive VARCHAR2(2000);
    sbInstanciaCompGas VARCHAR2(2000);
    sbInstanciaCompMed VARCHAR2(2000);
    isValid varchar2(2000);
    parentFrame NUMBER := 1856;-----------------------ojoooooooooooooooooooooooooooooooooooooo-------------------------------------------------------------------------------------------------------------
							/*
							ese consecutivo se obtiene con la siguiente consulta
							SELECT *
							FROM OPEN.GI_FRAME C
							WHERE description='FRAME-PAQUETE-1068828'

							*/
    automaticDocumentKey NUMBER;
    vSubscriptionId NUMBER;
    vPackageId NUMBER;
    function GET_ATTR(entityName VARCHAR2, attrName VARCHAR2, outValue OUT VARCHAR2) return boolean is
    begin
        "OPEN".gi_bsInstanceManager.getInitValue(sbInstancia, NULL, entityName, attrName, outValue, onuErrorCode, osbErrorMessage);
        if (onuErrorCode != 0) then
            return false;
        end if;
        return true;
    end;
    function SET_ATTR(instance VARCHAR2, entityName VARCHAR2, attrName VARCHAR2, attrValue VARCHAR2) return boolean is
    begin
        "OPEN".gi_bsinstancemanager.SetAttributeValue(instance, NULL, entityName, attrName, attrValue, onuErrorCode, osbErrorMessage);
        if (onuErrorCode != 0) then
            return false;
        end if;
        "OPEN".gi_bsInstanceManager.validateValue(instance, NULL, entityName, attrName, isValid, onuErrorCode, osbErrorMessage);
        if (onuErrorCode != 0) then
            return false;
        end if;
        if isValid != 'Y' then
          return false;
        end if;
        return true;
    end;
BEGIN
    BEGIN
        SELECT pp.SUBSCRIPTION_ID, mp.PACKAGE_ID
        INTO vSubscriptionId, vPackageId
        FROM "OPEN".PR_PRODUCT pp
        INNER JOIN "OPEN".MO_MOTIVE mm ON mm.PRODUCT_ID = pp.PRODUCT_ID
        INNER JOIN "OPEN".MO_PACKAGES mp ON mp.PACKAGE_ID = mm.PACKAGE_ID
        WHERE pp.PRODUCT_TYPE_ID = 7014
        AND pp.PRODUCT_STATUS_ID = 15
        AND pp.ADDRESS_ID = addressId
        AND mp.PACKAGE_TYPE_ID = 271
        AND COMMENT_ LIKE '[CONSTRUCTORA-%'
        AND ROWNUM = 1;
    EXCEPTION
        WHEN OTHERS THEN
            vSubscriptionId := NULL;
            vPackageId := NULL;
    END;
    IF (vSubscriptionId IS NOT NULL AND vPackageId IS NOT NULL) THEN
        subscriptionId := vSubscriptionId;
        packageId := vPackageId;
        onuErrorCode := 0;
        osbErrorMessage := null;
        RETURN;
    END IF;
    "OPEN".GI_BSINSTANCEMANAGER.INITMANAGER(onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.CreateInstanceWork(sbWorkInstance, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'MO_PROCESS', 'PACKAGE_TYPE_ID', '271', onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'MO_PROCESS', 'PRINTER', 'produc', onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'MO_PROCESS', 'AUX_PRINTER', 'AUX', onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BOInstanceData.LoadCorporativeInformation(-1);
    "OPEN".gi_boConfiguration.LoadConfiguration(271, 2012, null);
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'PS_PACKAGE_TYPE', 'PACKAGE_TYPE_ID', '271', onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('PAQUETE', '2012', '271', sbWorkInstance, sbInstancia, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('CREATED INSTANCE ' || sbInstancia);
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstancia, '2012', '271', parentFrame, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'PS_PRODUCT_MOTIVE', 'PRODUCT_MOTIVE_ID', '59', onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('M_INSTALACION_DE_GAS_59', '2013', '59', sbInstancia, sbInstanciaMotive, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('CREATED INSTANCE ' || sbInstanciaMotive);

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstanciaMotive, '2012', '271', parentFrame - 1, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame - 1, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('C_GAS_42', '2014', '42', sbInstanciaMotive, sbInstanciaCompGas, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('CREATED INSTANCE ' || sbInstanciaCompGas);
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstanciaCompGas, '2012', '271', parentFrame - 2, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame - 2, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('C_MEDICION_43', '2014', '43', sbInstanciaCompGas, sbInstanciaCompMed, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    DBMS_OUTPUT.PUT_LINE('CREATED INSTANCE ' || sbInstanciaCompMed);
    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstanciaCompMed, '2012', '271', parentFrame - 3, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame - 3, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstancia, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    if (not GET_ATTR('MO_PACKAGES', 'PACKAGE_ID', packageId)) then
        DBMS_OUTPUT.PUT_LINE('Could not find PACKAGE_ID');
        rollback;
        return;
    end if;
    if (not GET_ATTR('SUSCRIPC', 'SUSCCODI', subscriptionId)) then
        DBMS_OUTPUT.PUT_LINE('Could not find SUSCCODI');
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'PERSON_ID', TO_CHAR(personId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'POS_OPER_UNIT_ID', TO_CHAR(operatingUnitId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'DOCUMENT_TYPE_ID', TO_CHAR(documentTypeId))) then
        rollback;
        return;
    end if;
    automaticDocumentKey := documentKey;
    IF documentKey IS NULL THEN
        -- Grab the first unused consecutive for the operating unit
        SELECT codiulnu INTO automaticDocumentKey FROM (SELECT NVL(codiulnu + 1, codinuin) AS codiulnu from OPEN.FA_CONSDIST WHERE codicona = documentConsecutiveType AND codiunop = operatingUnitId AND codiacti = 'S' ORDER BY codinuin ASC) sub WHERE ROWNUM = 1;
    END IF;
    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'DOCUMENT_KEY', TO_CHAR(automaticDocumentKey))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'PROJECT_ID', '')) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'COMMENT_', comment)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', TO_CHAR(addressId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PROCESS', 'USE', TO_CHAR(categoryId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'MO_PROCESS', 'STRATUM', TO_CHAR(subcategoryId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'IDENT_TYPE_ID', TO_CHAR(subscriberIdentificationType))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'IDENTIFICATION', subscriberIdentification)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'SUBSCRIBER_NAME', subscriberName)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'SUBS_LAST_NAME', subscriberLastName)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBS_WORK_RELAT', 'COMPANY', companyName)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBS_WORK_RELAT', 'TITLE', companyTitle)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'E_MAIL', subscriberEmail)) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBS_HOUSING_DATA', 'PERSON_QUANTITY', TO_CHAR(personQuantity))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBS_GENERAL_DATA', 'OLD_OPERATOR', TO_CHAR(previousEnergySource))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'CONSTRUCCION', TO_CHAR(inConstruction))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'PERSON_ID', TO_CHAR(salesmanId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'OPER_UNIT_INST', TO_CHAR(installationOperatingUnitId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'OPER_UNIT_CERT', TO_CHAR(certificationOperatingUnitId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'PHONE', TO_CHAR(subscriberPhone))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'TIPO_PREDIO', TO_CHAR(premiseTypeId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'PREDIO_INDE', TO_CHAR(premiseSeparation))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'ESTALEY', TO_CHAR(law1581))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstancia, 'LDC_ENERGETICO_ANT', 'ENERG_ANT', TO_CHAR(previousEnergySource))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_MOTIVE', 'COMMERCIAL_PLAN_ID', TO_CHAR(commercialPlanId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'TOTAL_VALUE', TO_CHAR(totalSaleValue))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_4', TO_CHAR(financingPlanId))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INITIAL_PAYMENT', TO_CHAR(downPayment))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_7', TO_CHAR(numInstallments))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_6', TO_CHAR(totalFinancedValue))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_5', TO_CHAR(monthlyPaymentValue))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INIT_PAYMENT_MODE', TO_CHAR(downPaymentMode))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INIT_PAY_RECEIVED', TO_CHAR(downPaymentReceived))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'USAGE', TO_CHAR(usage))) then
        rollback;
        return;
    end if;
    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INSTALL_TYPE', TO_CHAR(installationType))) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstanciaCompMed, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.execafterexpressframeonly(2012, 271, parentFrame - 3, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstanciaCompGas, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.execafterexpressframeonly(2012, 271, parentFrame - 2, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstanciaMotive, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.execafterexpressframeonly(2012, 271, parentFrame - 1, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstancia, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    "OPEN".gi_bsInstanceManager.execafterexpressionframe(2012, 271, parentFrame, onuErrorCode, osbErrorMessage);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
    rollback;
    dbms_output.put_line('Everything OK before process');
    -- gi_bsInstanceManager.ProcessInstanceTransaction automatically commits when everything goes right.
    -- "OPEN".gi_bsInstanceManager.ProcessInstanceTransaction(onuErrorCode, osbErrorMessage, true, false);
    if (onuErrorCode != 0) then
        rollback;
        return;
    end if;
exception when others then
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(onuErrorCode, osbErrorMessage);
    dbms_output.put_line('Error: ' || onuErrorCode ||' - ' || osbErrorMessage);
    rollback;
end;


/


PL/SQL Developer Test script 3.0
481
declare
    sbWorkInstance VARCHAR2(2000);
    sbInstancia VARCHAR2(2000);
    sbInstanciaMotive VARCHAR2(2000);
    sbInstanciaCompGas VARCHAR2(2000);
    sbInstanciaCompMed VARCHAR2(2000);
    isValid varchar2(2000);
    parentFrame NUMBER := 2341;

    automaticDocumentKey NUMBER;
    vSubscriptionId NUMBER;
    vPackageId NUMBER;
    blCons varchar2(1):='N';
    premiseSeparation varchar2(1):= 'N';
	  law1581 varchar2(1):='N';
    downPaymentReceived varchar2(1) := 'N';

    function GET_ATTR(entityName VARCHAR2, attrName VARCHAR2, outValue OUT VARCHAR2) return boolean is
    begin
        "OPEN".gi_bsInstanceManager.getInitValue(sbInstancia, NULL, entityName, attrName, outValue, :onuErrorCode, :osbErrorMessage);

        if (:onuErrorCode != 0) then
            return false;
        end if;

        return true;
    end;

    function SET_ATTR(instance VARCHAR2, entityName VARCHAR2, attrName VARCHAR2, attrValue VARCHAR2) return boolean is
    begin
        "OPEN".gi_bsinstancemanager.SetAttributeValue(instance, NULL, entityName, attrName, attrValue, :onuErrorCode, :osbErrorMessage);

        if (:onuErrorCode != 0) then
            return false;
        end if;

        "OPEN".gi_bsInstanceManager.validateValue(instance, NULL, entityName, attrName, isValid, :onuErrorCode, :osbErrorMessage);

        if (:onuErrorCode != 0) then
            return false;
        end if;

        if isValid != 'Y' then
          return false;
        end if;

        return true;
    end;
BEGIN
    
  

    BEGIN
        SELECT pp.SUBSCRIPTION_ID, mp.PACKAGE_ID
        INTO vSubscriptionId, vPackageId
        FROM "OPEN".PR_PRODUCT pp
        INNER JOIN "OPEN".MO_MOTIVE mm ON mm.PRODUCT_ID = pp.PRODUCT_ID
        INNER JOIN "OPEN".MO_PACKAGES mp ON mp.PACKAGE_ID = mm.PACKAGE_ID
        WHERE pp.PRODUCT_TYPE_ID = 7014
        AND pp.PRODUCT_STATUS_ID = 15
        AND pp.ADDRESS_ID = :addressId
        AND mp.PACKAGE_TYPE_ID = 271
        AND COMMENT_ LIKE '[CONSTRUCTORA-%'
        AND ROWNUM = 1;
    EXCEPTION
        WHEN OTHERS THEN
            vSubscriptionId := NULL;
            vPackageId := NULL;
    END;

    IF (vSubscriptionId IS NOT NULL AND vPackageId IS NOT NULL) THEN
        :subscriptionId := vSubscriptionId;
        :packageId := vPackageId;
        :onuErrorCode := 0;
        :osbErrorMessage := null;
        RETURN;
    END IF;

    "OPEN".GI_BSINSTANCEMANAGER.INITMANAGER(:onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.CreateInstanceWork(sbWorkInstance, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'MO_PROCESS', 'PACKAGE_TYPE_ID', '271', :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'MO_PROCESS', 'PRINTER', 'produc', :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'MO_PROCESS', 'AUX_PRINTER', 'AUX', :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BOInstanceData.LoadCorporativeInformation(-1);
    "OPEN".gi_boConfiguration.LoadConfiguration(271, 2012, null);

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'PS_PACKAGE_TYPE', 'PACKAGE_TYPE_ID', '271', :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('PAQUETE', '2012', '271', sbWorkInstance, sbInstancia, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstancia, '2012', '271', parentFrame, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTE(sbWorkInstance, NULL, 'PS_PRODUCT_MOTIVE', 'PRODUCT_MOTIVE_ID', '59', :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('M_INSTALACION_DE_GAS_59', '2013', '59', sbInstancia, sbInstanciaMotive, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstanciaMotive, '2012', '271', parentFrame - 1, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame - 1, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('C_GAS_42', '2014', '42', sbInstanciaMotive, sbInstanciaCompGas, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstanciaCompGas, '2012', '271', parentFrame - 2, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame - 2, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.CREATEINSTANCE('C_MEDICION_43', '2014', '43', sbInstanciaCompGas, sbInstanciaCompMed, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".GI_BSINSTANCEMANAGER.ADDATTRIBUTEFRAME(sbInstanciaCompMed, '2012', '271', parentFrame - 3, :onuErrorCode, :osbErrorMessage);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.ExecBeforeExpressionFrame(2012, 271, parentFrame - 3, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstancia, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    if (not GET_ATTR('MO_PACKAGES', 'PACKAGE_ID', :packageId)) then
        rollback;
        return;
    end if;

    if (not GET_ATTR('SUSCRIPC', 'SUSCCODI', :subscriptionId)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'PERSON_ID', TO_CHAR(:personId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'POS_OPER_UNIT_ID', TO_CHAR(:operatingUnitId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'DOCUMENT_TYPE_ID', TO_CHAR(:documentTypeId))) then
        rollback;
        return;
    end if;

    automaticDocumentKey := :documentKey;
    IF :documentKey IS NULL THEN
        -- Grab the first unused consecutive for the operating unit
        SELECT codiulnu INTO automaticDocumentKey FROM (SELECT NVL(codiulnu + 1, codinuin) AS codiulnu from OPEN.FA_CONSDIST WHERE codicona = :documentConsecutiveType AND codiunop = /*:operatingUnitId*/4021 AND codiacti = 'S' ORDER BY codinuin ASC) sub WHERE ROWNUM = 1;
    END IF;

    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'DOCUMENT_KEY', TO_CHAR(automaticDocumentKey))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'PROJECT_ID', '')) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PACKAGES', 'COMMENT_', :comment)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PROCESS', 'ADDRESS_MAIN_MOTIVE', TO_CHAR(:addressId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PROCESS', 'USE', TO_CHAR(:categoryId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'MO_PROCESS', 'STRATUM', TO_CHAR(:subcategoryId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'IDENT_TYPE_ID', TO_CHAR(:subscriberIdentificationType))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'IDENTIFICATION', :subscriberIdentification)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'SUBSCRIBER_NAME', :subscriberName)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'SUBS_LAST_NAME', :subscriberLastName)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBS_WORK_RELAT', 'COMPANY', :companyName)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBS_WORK_RELAT', 'TITLE', :companyTitle)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'E_MAIL', :subscriberEmail)) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBS_HOUSING_DATA', 'PERSON_QUANTITY', TO_CHAR(:personQuantity))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBS_GENERAL_DATA', 'OLD_OPERATOR', TO_CHAR(:previousEnergySource))) then
        rollback;
        return;
    end if;

    --if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'CONSTRUCCION', TO_CHAR(:inConstruction))) then blCons
    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'CONSTRUCCION', TO_CHAR(blCons))) then 
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'PERSON_ID', TO_CHAR(:salesmanId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'OPER_UNIT_INST', TO_CHAR(:installationOperatingUnitId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'OPER_UNIT_CERT', TO_CHAR(:certificationOperatingUnitId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'GE_SUBSCRIBER', 'PHONE', TO_CHAR(:subscriberPhone))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'TIPO_PREDIO', TO_CHAR(:premiseTypeId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'PREDIO_INDE', TO_CHAR(premiseSeparation))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_DAADVENTA', 'ESTALEY', TO_CHAR(law1581))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstancia, 'LDC_ENERGETICO_ANT', 'ENERG_ANT', TO_CHAR(:previousEnergySource))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_MOTIVE', 'COMMERCIAL_PLAN_ID', TO_CHAR(:commercialPlanId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'TOTAL_VALUE', TO_CHAR(:totalSaleValue))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_4', TO_CHAR(:financingPlanId))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INITIAL_PAYMENT', TO_CHAR(:downPayment))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_7', TO_CHAR(:numInstallments))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_6', TO_CHAR(:totalFinancedValue))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_PROCESS', 'VALUE_5', TO_CHAR(:monthlyPaymentValue))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INIT_PAYMENT_MODE', TO_CHAR(:downPaymentMode))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INIT_PAY_RECEIVED', TO_CHAR(downPaymentReceived))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'USAGE', TO_CHAR(:usage))) then
        rollback;
        return;
    end if;

    if (not SET_ATTR(sbInstanciaMotive, 'MO_GAS_SALE_DATA', 'INSTALL_TYPE', TO_CHAR(:installationType))) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstanciaCompMed, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.execafterexpressframeonly(2012, 271, parentFrame - 3, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstanciaCompGas, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.execafterexpressframeonly(2012, 271, parentFrame - 2, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstanciaMotive, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.execafterexpressframeonly(2012, 271, parentFrame - 1, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsinstancemanager.SetCurrentInstance(sbInstancia, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    "OPEN".gi_bsInstanceManager.execafterexpressionframe(2012, 271, parentFrame, :onuErrorCode, :osbErrorMessage);
    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;

    -- gi_bsInstanceManager.ProcessInstanceTransaction automatically commits when everything goes right.
    "OPEN".gi_bsInstanceManager.ProcessInstanceTransaction(:onuErrorCode, :osbErrorMessage, true, false);

    if (:onuErrorCode != 0) then
        rollback;
        return;
    end if;
exception when others then
    "OPEN".ERRORS.SETERROR;
    "OPEN".ERRORS.GETERROR(:onuErrorCode, :osbErrorMessage);
    rollback;
end;
37
:onuErrorCode
1
-2291
3
:osbErrorMessage
1
Valor invalido. [974257465]
5
:addressId
1
116499
3
:subscriptionId
1
67257279
3
:packageId 
1
186550475
3
:personId
1
37289
3
:operatingUnitId
1
4021
3
:documentTypeId
1
1
3
:documentKey
0
3
:documentConsecutiveType
1
275
3
:comment
1
PRUEBA VENTA
5
:categoryId
1
1
3
:subcategoryId
1
5
3
:subscriberIdentificationType
1
1
3
:subscriberIdentification
1
123
3
:subscriberName
1
RODRIGUEZ
5
:subscriberLastName
1
MIGUEL
5
:companyName
1
NN
5
:companyTitle
1
INGENIERO
5
:subscriberEmail
1
silvana.jurado@remotto.co
5
:personQuantity
1
1
3
:previousEnergySource
1
1
3
:salesmanId
1
37289
3
:installationOperatingUnitId
1
3478
3
:certificationOperatingUnitId
1
3479
3
:subscriberPhone
1
3003033185
5
:premiseTypeId
1
3
3
:commercialPlanId
1
5
3
:totalSaleValue
1
3167617
3
:financingPlanId
1
23
3
:downPayment
1
0
3
:numInstallments
1
14
3
:totalFinancedValue
1
3167617
3
:monthlyPaymentValue
1
269320
3
:usage
1
1
3
:installationType
1
1
3
:downPaymentMode
1
13
3
2
inuPersonId
inuPOS_Id
