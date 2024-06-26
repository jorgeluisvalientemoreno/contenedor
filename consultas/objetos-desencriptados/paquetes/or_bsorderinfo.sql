CREATE OR REPLACE PACKAGE BODY OR_BSORDERINFO IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO186815';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE GETWORKORDERS( INUOPERATINGUNITID IN OR_ORDER.OPERATING_UNIT_ID%TYPE, INUGEOGRALOCATIONID IN OR_ORDER.GEOGRAP_LOCATION_ID%TYPE, INUCONSCYCLEID IN CICLCONS.CICOCODI%TYPE, INUOPERATINGSECTORID IN OR_ORDER.OPERATING_SECTOR_ID%TYPE, INUROUTEID IN OR_ORDER.ROUTE_ID%TYPE, IDTINITIALDATE IN OR_ORDER.CREATED_DATE%TYPE, IDTFINALDATA IN OR_ORDER.CREATED_DATE%TYPE, INUTASKTYPEID IN OR_ORDER.TASK_TYPE_ID%TYPE, INUORDERSTATUSID IN OR_ORDER.ORDER_STATUS_ID%TYPE, ORFORDER OUT CONSTANTS.TYREFCURSOR, ONUERRORCODE OUT GE_ERROR_LOG.MESSAGE_ID%TYPE, OSBERRORMSG OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio Or_BSOrderInfo.GetWorkOrders', 1 );
      GE_BOUTILITIES.INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMSG );
      GE_BOGENERALUTIL.OPEN_REFCURSOR( ORFORDER );
      OR_BOORDERINFO.VALWORKORDERSINFO( INUOPERATINGUNITID, INUGEOGRALOCATIONID, INUCONSCYCLEID, INUOPERATINGSECTORID, INUROUTEID, IDTINITIALDATE, IDTFINALDATA, INUTASKTYPEID, INUORDERSTATUSID );
      OR_BOORDERINFO.GETWORKORDERS( INUOPERATINGUNITID, INUGEOGRALOCATIONID, INUCONSCYCLEID, INUOPERATINGSECTORID, INUROUTEID, IDTINITIALDATE, IDTFINALDATA, INUTASKTYPEID, INUORDERSTATUSID, ORFORDER );
      UT_TRACE.TRACE( 'Fin Or_BSOrderInfo.GetWorkOrders', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR Or_BSOrderInfo.GetWorkOrders', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMSG );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others Or_BSOrderInfo.GetWorkOrders', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMSG );
   END GETWORKORDERS;
   PROCEDURE GETORDERACTIVITIES( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, ORFREADACTIVITIES OUT CONSTANTS.TYREFCURSOR, ONUERRORCODE OUT GE_ERROR_LOG.MESSAGE_ID%TYPE, OSBERRORMSG OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'Inicio Or_BSOrderInfo.GetOrderActivities', 1 );
      GE_BOUTILITIES.INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMSG );
      GE_BOGENERALUTIL.OPEN_REFCURSOR( ORFREADACTIVITIES );
      OR_BOORDERINFO.GETORDERACTIVITIES( INUORDERID, ORFREADACTIVITIES );
      UT_TRACE.TRACE( 'Fin Or_BSOrderInfo.GetOrderActivities', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR Or_BSOrderInfo.GetOrderActivities', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMSG );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others Or_BSOrderInfo.GetOrderActivities', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMSG );
   END GETORDERACTIVITIES;
END OR_BSORDERINFO;
/


