
CREATE OR REPLACE PACKAGE BODY OR_BORELATEDORDER IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO186451';
   CNUERR901274 CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901274;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FNUGETPATHERORDERID( INURELATEDORDERID IN OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE )
    RETURN NUMBER
    IS
      RCRELATEDORDERFATHER OR_BCRELATEDORDER.CURELATEDORDERFATHER%ROWTYPE;
      NURELATEDORDERID OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE;
    BEGIN
      OPEN OR_BCRELATEDORDER.CURELATEDORDERFATHER( INURELATEDORDERID );
      FETCH OR_BCRELATEDORDER.CURELATEDORDERFATHER
         INTO RCRELATEDORDERFATHER;
      IF OR_BCRELATEDORDER.CURELATEDORDERFATHER%NOTFOUND THEN
         CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHER;
         RETURN INURELATEDORDERID;
      END IF;
      NURELATEDORDERID := RCRELATEDORDERFATHER.ORDER_ID;
      CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHER;
      RETURN NURELATEDORDERID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF OR_BCRELATEDORDER.CURELATEDORDERFATHER%ISOPEN THEN
            CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHER;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF OR_BCRELATEDORDER.CURELATEDORDERFATHER%ISOPEN THEN
            CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHER;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FBLEXISTCHILDRENORDERS( INUORDERID IN OR_RELATED_ORDER.ORDER_ID%TYPE, INURELTYPE IN OR_RELATED_ORDER.RELA_ORDER_TYPE_ID%TYPE )
    RETURN BOOLEAN
    IS
      RCRELATEDORDERFATHER OR_BCRELATEDORDER.CURELATEDORDERFATHER%ROWTYPE;
      NURELATEDORDERID OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE;
    BEGIN
      OPEN OR_BCORDER.CURELORDERBYORDERANDTYPE( INUORDERID, INURELTYPE );
      FETCH OR_BCORDER.CURELORDERBYORDERANDTYPE
         INTO RCRELATEDORDERFATHER;
      IF OR_BCORDER.CURELORDERBYORDERANDTYPE%NOTFOUND THEN
         CLOSE OR_BCORDER.CURELORDERBYORDERANDTYPE;
         RETURN FALSE;
      END IF;
      CLOSE OR_BCORDER.CURELORDERBYORDERANDTYPE;
      RETURN TRUE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF OR_BCORDER.CURELORDERBYORDERANDTYPE%ISOPEN THEN
            CLOSE OR_BCORDER.CURELORDERBYORDERANDTYPE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF OR_BCORDER.CURELORDERBYORDERANDTYPE%ISOPEN THEN
            CLOSE OR_BCORDER.CURELORDERBYORDERANDTYPE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FNUGETPATHERORDERIDBYTYPE( INURELATEDORDERID IN OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE, INUTYPEORDERID IN OR_RELATED_ORDER.RELA_ORDER_TYPE_ID%TYPE )
    RETURN NUMBER
    IS
      RCRELATEDORDERFATHER OR_BCRELATEDORDER.CURELATEDORDERFATHER%ROWTYPE;
      NURELATEDORDERID OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE;
    BEGIN
      IF OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE%ISOPEN THEN
         CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE;
      END IF;
      OPEN OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE( INURELATEDORDERID, INUTYPEORDERID );
      FETCH OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE
         INTO RCRELATEDORDERFATHER;
      IF OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE%NOTFOUND THEN
         CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE;
         UT_TRACE.TRACE( 'Sale en: {' || INURELATEDORDERID || '}', 5 );
         RETURN INURELATEDORDERID;
      END IF;
      NURELATEDORDERID := RCRELATEDORDERFATHER.ORDER_ID;
      UT_TRACE.TRACE( 'Hija: [' || INURELATEDORDERID || '] Padre: [' || NURELATEDORDERID || ']', 5 );
      CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE;
      RETURN FNUGETPATHERORDERIDBYTYPE( NURELATEDORDERID, INUTYPEORDERID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE%ISOPEN THEN
            CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE%ISOPEN THEN
            CLOSE OR_BCRELATEDORDER.CURELATEDORDERFATHERANDTYPE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FLBGETORDERRELATED( INURELATEDORDERID IN OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE )
    RETURN BOOLEAN
    IS
      NURELATEDORDER OR_RELATED_ORDER.RELATED_ORDER_ID%TYPE;
    BEGIN
      NURELATEDORDER := OR_BCRELATEDORDER.FSBVALIDATEORDERRELATED( INURELATEDORDERID=>INURELATEDORDERID );
      IF ( NURELATEDORDER IS NOT NULL AND NURELATEDORDER > 0 ) THEN
         RETURN GE_BOCONSTANTS.GETTRUE;
       ELSE
         RETURN GE_BOCONSTANTS.GETFALSE;
      END IF;
   END FLBGETORDERRELATED;
   PROCEDURE RELATEORDERS( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUORDERRELAID IN OR_ORDER.ORDER_ID%TYPE, INURELATIONTYPE IN GE_TRANSITION_TYPE.TRANSITION_TYPE_ID%TYPE )
    IS
      RCRELATEDORDER DAOR_RELATED_ORDER.STYOR_RELATED_ORDER;
    BEGIN
      UT_TRACE.TRACE( 'INICIO OR_BORelatedOrder.relateOrders', 2 );
      DAOR_ORDER.ACCKEY( INUORDERID );
      DAOR_ORDER.ACCKEY( INUORDERRELAID );
      DAGE_TRANSITION_TYPE.ACCKEY( INURELATIONTYPE );
      IF ( FSBEXISTRELATION( INUORDERID, INUORDERRELAID, INURELATIONTYPE ) = GE_BOCONSTANTS.CSBYES ) THEN
         GE_BOERRORS.SETERRORCODEARGUMENT( CNUERR901274, INUORDERID || '|' || INUORDERRELAID );
      END IF;
      RCRELATEDORDER.ORDER_ID := INUORDERID;
      RCRELATEDORDER.RELATED_ORDER_ID := INUORDERRELAID;
      RCRELATEDORDER.RELA_ORDER_TYPE_ID := INURELATIONTYPE;
      DAOR_RELATED_ORDER.INSRECORD( RCRELATEDORDER );
      UT_TRACE.TRACE( 'FIN OR_BORelatedOrder.relateOrders', 2 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END RELATEORDERS;
   FUNCTION FSBEXISTRELATION( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, INUORDERRELAID IN OR_ORDER.ORDER_ID%TYPE, INURELATIONTYPE IN GE_TRANSITION_TYPE.TRANSITION_TYPE_ID%TYPE )
    RETURN VARCHAR2
    IS
      RCRELATION DAOR_RELATED_ORDER.STYOR_RELATED_ORDER;
    BEGIN
      UT_TRACE.TRACE( 'INICIO OR_BORelatedOrder.fsbExistRelation. inuOrderId: ' || INUORDERID || ' inuOrderRelaId: ' || INUORDERRELAID, 2 );
      IF ( DAOR_RELATED_ORDER.FBLEXIST( INUORDERID, INUORDERRELAID ) ) THEN
         RCRELATION := DAOR_RELATED_ORDER.FRCGETRECORD( INUORDERID, INUORDERRELAID );
         IF ( RCRELATION.RELA_ORDER_TYPE_ID = INURELATIONTYPE ) THEN
            UT_TRACE.TRACE( 'FIN OR_BORelatedOrder.fsbExistRelation. Existe relacion', 2 );
            RETURN GE_BOCONSTANTS.CSBYES;
          ELSE
            UT_TRACE.TRACE( 'FIN OR_BORelatedOrder.fsbExistRelation. No existe relacion', 2 );
            RETURN GE_BOCONSTANTS.CSBNO;
         END IF;
       ELSE
         UT_TRACE.TRACE( 'FIN OR_BORelatedOrder.fsbExistRelation. No existe relacion', 2 );
         RETURN GE_BOCONSTANTS.CSBNO;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FSBEXISTRELATION;
   PROCEDURE GETRELATEDORDERS( INUORDERID IN OR_ORDER.ORDER_ID%TYPE, OCURELATEDORDERS OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO OR_BORelatedOrder.GetRelatedOrders', 2 );
      OCURELATEDORDERS := OR_BCRELATEDORDER.FRFGETRELATEDORDERS( INUORDERID );
      UT_TRACE.TRACE( 'FIN OR_BORelatedOrder.GetRelatedOrders', 2 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETRELATEDORDERS;
END OR_BORELATEDORDER;
/

