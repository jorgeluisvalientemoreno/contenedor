CREATE OR REPLACE FUNCTION adm_person.fnuGetBestFinancingPlan(inusubscriptionid suscripc.susccodi%type, inuproductid servsusc.sesunuse%type)
RETURN plandife.pldicodi%type
IS
    rcPlandife  plandife%rowtype;
BEGIN
    ut_trace.Trace('INICIO fnuGetBestFinancingPlan', 15);

    rcPlandife := cc_bofinancing.frcbestfinancingplan(inusubscriptionid => inusubscriptionid, inuproductid => inuproductid, inuofferclass => cc_boconstants.cnuNegotiationOffer);

    ut_trace.Trace('RETURN plan de financiacion = '||rcPlandife.pldicodi, 15);

    return rcPlandife.pldicodi;

EXCEPTION
        when ex.CONTROLLED_ERROR then
            return null;
        when others then
            Errors.setError;
            return null;
END fnuGetBestFinancingPlan;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETBESTFINANCINGPLAN', 'ADM_PERSON');
END;
/

