PACKAGE BODY or_bsRoutePremise
IS
    
























    
    
    
    CSBVERSION                  CONSTANT UT_DATATYPES.STYSAOVERSION := 'SAO582286';

    
    
    
    
    
    
    
    
    
    















    FUNCTION FSBVERSION
    RETURN UT_DATATYPES.STYSAOVERSION
    IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    


















    PROCEDURE ADDPREMISETOROUTE (
                                    INUROUTEID       IN OR_ROUTE_PREMISE.ROUTE_ID%TYPE,
                                    INUPREMISEID     IN OR_ROUTE_PREMISE.PREMISE_ID%TYPE,
                                    INUCONSECUTIVE   IN OR_ROUTE_PREMISE.CONSECUTIVE%TYPE,
                                    ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                    OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
                                )
    IS
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        OR_BOROUTEPREMISE.ADDPREMISETOROUTE(INUROUTEID,INUPREMISEID, INUCONSECUTIVE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END ADDPREMISETOROUTE;
    
    

















    PROCEDURE REMPREMISEOFROUTE (
                                    INUROUTEID       IN OR_ROUTE_PREMISE.ROUTE_ID%TYPE,
                                    INUPREMISEID     IN OR_ROUTE_PREMISE.PREMISE_ID%TYPE,
                                    ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
                                    OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
                                )
    IS
    BEGIN
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        OR_BOROUTEPREMISE.REMPREMISEOFROUTE(INUROUTEID,INUPREMISEID);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END REMPREMISEOFROUTE;
    
    
































    PROCEDURE ADDPREMISETOROUTEBYXML
    (
        ICLDATA         IN  UT_DATATYPES.STYCLOB,
        ONUERRORCODE    OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('BEGIN OR_BSRoutePremise.AddPremiseToRouteByXML', 1);

        ST_BOGENERALAPIS.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        OR_BOROUTEPREMISE.ADDPREMISETOROUTEBYXML
        (
            ICLDATA
        );

        UT_TRACE.TRACE('END OR_BSRoutePremise.AddPremiseToRouteByXML', 1);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR OR_BSRoutePremise.AddPremiseToRouteByXML', 1);
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others OR_BSRoutePremise.AddPremiseToRouteByXML', 1);
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END ADDPREMISETOROUTEBYXML;
    
END OR_BSROUTEPREMISE;