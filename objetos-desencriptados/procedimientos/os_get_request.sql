
CREATE OR REPLACE PROCEDURE OS_GET_REQUEST( INUITEMSDOCUMENT_ID IN GE_ITEMS_REQUEST.ID_ITEMS_DOCUMENTO%TYPE, OSBREQUEST IN OUT CLOB, ONUERRORCODE OUT NUMBER, OSBERRORMESSAGE OUT VARCHAR2 )
 IS
 BEGIN
   GE_BSITEMSREQUEST.GETREQUESTDATA( INUITEMSDOCUMENT_ID, OSBREQUEST, ONUERRORCODE, OSBERRORMESSAGE );
 EXCEPTION
   WHEN EX.CONTROLLED_ERROR THEN
      ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   WHEN OTHERS THEN
      ERRORS.SETERROR;
      ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
END OS_GET_REQUEST;
/

