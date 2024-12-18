CREATE OR REPLACE PROCEDURE "ADM_PERSON"."CANCELPOLICYBYAGE" 
IS
nuOrderId or_order.order_id%type;
nuOrderActivity or_order_activity.order_activity_id%type;
nuPolicyId ld_policy.policy_id%type;
nurecptype number;
nuContactId number;
sbCanCausal number;
sbCanBySin  number;
sbRequestXML varchar2(400);

CURSOR cuProdByOrder (inuOrderId in or_order.order_id%type)
IS
SELECT PRODUCT_ID
FROM OR_order o, or_order_activity oa
WHERE o.order_id = oa.order_id
AND o.order_id = inuOrderId;
nuProductId servsusc.sesunuse%type;
nuPolicyNumber ld_policy.policy_number%type;
nuSuscripc suscripc.susccodi%type;

CURSOR cuPolicyToCancel (inuPolicyNumber in ld_policy.policy_number%type)
IS
SELECT policy_id
FROM(
SELECT policy_id
FROM ld_policy
WHERE policy_number = inuPolicyNumber
ORDER BY DTCREATE_POLICY desc)
WHERE rownum = 1;


BEGIN
    nuOrderId := or_bolegalizeorder.fnuGetCurrentOrder;
    open cuProdByOrder(nuOrderId);
    fetch cuProdByOrder into nuProductId;
    close cuProdByOrder;

    nuSuscripc     := pktblservsusc.fnugetsuscription(nuProductId);
    nuPolicyNumber := ld_bcsecuremanagement.fnuGetRenewPolicyByProduct(nuProductId);
    nurecptype     := dald_parameter.fnuGetNumeric_Value('COD_REC_TYPE');
    nuContactId    := pktblsuscripc.fnugetsuscclie(nuSuscripc);
    sbCanCausal   := dald_parameter.fsbGetValue_Chain(ld_boconstans.cnuCausCancelAge);
    sbCanBySin    := DALD_PARAMETER.fsbGetValue_Chain(LD_BOConstans.csbCanBySin);

    open cuPolicyToCancel(nuPolicyNumber);
    fetch cuPolicyToCancel INTO nuPolicyId;

    sbRequestXML := '<?xml version="1.0" encoding="ISO-8859-1"?>'||
                    '<P_CANCELACION_DE_SEGUROS_XML_100266 ID_TIPOPAQUETE="100266">
                    <ID>'||GE_BOPERSONAL.FNUGETPERSONID()||'</ID>'||
                    '<RECEPTION_TYPE_ID>' ||nurecptype||'</RECEPTION_TYPE_ID>
                    <COMMENT_>Cancelación por Mayoría de Edad para cobertura de la póliza</COMMENT_>
                    <FECHA_DE_SOLICITUD>' || trunc(sysdate) ||'</FECHA_DE_SOLICITUD>
                    <ADDRESS_ID></ADDRESS_ID>
                    <CONTACT_ID>' ||nuContactId||'</CONTACT_ID>
                    <CONTRACT>' ||nuSuscripc||'</CONTRACT>
                    <M_CANCELACION_DE_SEGUROS_XML_100273>
                        <ANSWER_ID>''</ANSWER_ID>
                        <POLIZA_A_CANCELAR>' ||nuPolicyId ||'</POLIZA_A_CANCELAR>
                        <CAUSAL_DE_CANCELACION>' ||sbCanCausal ||'</CAUSAL_DE_CANCELACION>
                        <OBSERVACIONES_DE_LA_POLIZA>Cancelación por Mayoría de Edad para cobertura de la póliza</OBSERVACIONES_DE_LA_POLIZA>' ||
                        '<SOLICITUD_QUE_FUE_REGISTRADA>' || sbCanBySin ||'</SOLICITUD_QUE_FUE_REGISTRADA>
                    </M_CANCELACION_DE_SEGUROS_XML_100273>
                    </P_CANCELACION_DE_SEGUROS_XML_100266>';

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END cancelPolicyByAge;
/

BEGIN
    pkg_utilidades.prAplicarPermisos('CANCELPOLICYBYAGE', 'ADM_PERSON');
END;
/
