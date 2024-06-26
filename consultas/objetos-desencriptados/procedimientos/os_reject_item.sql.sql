CREATE OR REPLACE PROCEDURE OS_REJECT_ITEM( ICLXMLREJECTITEM IN CLOB, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
 IS
 BEGIN
   GE_BSACCEPTITEMS.REJECTITEM( ICLXMLREJECTITEM, ONUERRORCODE, OSBERRORMESSAGE );
 EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
END OS_REJECT_ITEM;
/


