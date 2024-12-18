CREATE OR REPLACE FUNCTION adm_person.fnuGetNPrevPeriod
(
    inuPefa     in conssesu.cosspefa%type,
    inuValPrev  in number
)
return conssesu.cosscoca%type
/*****************************************************************
Propiedad intelectual de Gases de Occidente

Unidad         : fnuGetNPrevPeriod
Descripcion    : Funcion que retorna el N periodo anterior al que se recibe por
                 parametro (Usada para el reporte consumos altos Auditorias POST)
Autor          : Carlos Alberto Ramirez Herrera
Fecha          : 15/10/2013

Parametros         Descripcion
============	===================
    inuPefa     Periodo del cual se quiere partir
    inuValPrev  Numero de periodos hacia atras del cual se quiere obtener

Historia de Modificaciones

DD-MM-YYYY    <Autor>.SAONNNNN        Modificacion
-----------  -------------------    -------------------------------------
15/10/2013   carlosr
Creacion
******************************************************************/
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
        return null;
    when others then
        Errors.setError;
        return null;
END fnuGetNPrevPeriod;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('FNUGETNPREVPERIOD', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON FNUGETNPREVPERIOD TO REPORTES;
/
