CREATE OR REPLACE PROCEDURE OS_ADDITEMSORDER( INUORDERID IN NUMBER, INUITEMID IN NUMBER, INULEGALITEMAMOUNT IN NUMBER, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
 IS
 BEGIN
   OR_BSADDITEMSORDER.ADDITEMSORDER( INUORDERID, INUITEMID, INULEGALITEMAMOUNT, ONUERRORCODE, OSBERRORMESSAGE );
 EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
END OS_ADDITEMSORDER;
/


