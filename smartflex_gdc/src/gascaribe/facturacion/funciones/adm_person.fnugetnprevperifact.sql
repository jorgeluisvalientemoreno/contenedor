CREATE OR REPLACE FUNCTION adm_person.fnuGetNPrevPerifact(inuPefa in conssesu.cosspefa%type, inuValPrev in categori.catecodi%type)
return conssesu.cosscoca%type
AS
    nuPerifact  conssesu.cosspefa%type;
BEGIN

    if(inuValPrev = 1)then

        nuPerifact := pkbillingperiodmgr.fnugetperiodprevious(inuPefa);

    elsif(inuValPrev = 2)then

        nuPerifact := pkbillingperiodmgr.fnugetperiodprevious(
                            pkbillingperiodmgr.fnugetperiodprevious(inuPefa));

    elsif(inuValPrev = 3)then

        nuPerifact := pkbillingperiodmgr.fnugetperiodprevious(
                            pkbillingperiodmgr.fnugetperiodprevious(
                                pkbillingperiodmgr.fnugetperiodprevious(inuPefa)));
    elsif(inuValPrev = 4)then

        nuPerifact := pkbillingperiodmgr.fnugetperiodprevious(
                            pkbillingperiodmgr.fnugetperiodprevious(
                                    pkbillingperiodmgr.fnugetperiodprevious(
                                        pkbillingperiodmgr.fnugetperiodprevious(inuPefa))));

    elsif(inuValPrev = 5)then

        nuPerifact := pkbillingperiodmgr.fnugetperiodprevious(
                            pkbillingperiodmgr.fnugetperiodprevious(
                                pkbillingperiodmgr.fnugetperiodprevious(
                                        pkbillingperiodmgr.fnugetperiodprevious(
                                            pkbillingperiodmgr.fnugetperiodprevious(inuPefa)))));

    elsif(inuValPrev = 6)then

        nuPerifact := pkbillingperiodmgr.fnugetperiodprevious(
                            pkbillingperiodmgr.fnugetperiodprevious(
                                pkbillingperiodmgr.fnugetperiodprevious(
                                    pkbillingperiodmgr.fnugetperiodprevious(
                                            pkbillingperiodmgr.fnugetperiodprevious(
                                                pkbillingperiodmgr.fnugetperiodprevious(inuPefa))))));

    END if;

    return nuPerifact;

EXCEPTION
    when ex.CONTROLLED_ERROR then
        raise ex.CONTROLLED_ERROR;
    when others then
        Errors.setError;
        raise ex.CONTROLLED_ERROR;
END fnuGetNPrevPerifact;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETNPREVPERIFACT', 'ADM_PERSON');
END;
/
