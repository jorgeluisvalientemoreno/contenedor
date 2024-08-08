CREATE OR REPLACE PACKAGE BODY GE_BCNOTIFMESGALERT IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO158519';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE GETGENERICALERT( INUREFERENCE IN GE_MESG_ALERT.REFERENCE%TYPE, INUINISTATUS IN GE_MESG_ALERT.INITIAL_STATUS%TYPE, INUENDSTATUS IN GE_MESG_ALERT.FINAL_STATUS%TYPE, INUENTITYID IN GE_MESG_ALERT.ENTITY_ID%TYPE, OTBALERTS OUT DAGE_MESG_ALERT.TYTBGE_MESG_ALERT )
    IS
      CURSOR CUALERTA( INUREFERENCE IN GE_MESG_ALERT.REFERENCE%TYPE, INUINISTATUS IN GE_MESG_ALERT.INITIAL_STATUS%TYPE, INUENDSTATUS IN GE_MESG_ALERT.FINAL_STATUS%TYPE, INUENTITYID IN GE_MESG_ALERT.ENTITY_ID%TYPE ) IS
SELECT  /*+ index(ge_mesg_alert IDX_GE_MESG_ALERT01)*/
                GE_mesg_alert.*,GE_mesg_alert.rowid
        FROM    ge_mesg_alert
        WHERE   ge_mesg_alert.entity_id = inuEntityId
        AND     ge_mesg_alert.active = ge_boconstants.csbYES
        AND     (ge_mesg_alert.reference = inuReference OR ge_mesg_alert.reference IS NULL)
        AND     (ge_mesg_alert.initial_status = inuIniStatus OR ge_mesg_alert.initial_status IS NULL)
        AND     (ge_mesg_alert.final_status = inuEndStatus OR ge_mesg_alert.final_status IS NULL)
        AND     ut_date.fdtSysdate BETWEEN ge_mesg_alert.initial_date AND ge_mesg_alert.final_date
        AND     GE_BOUtilities.fsbValAssigRule
                (
                    ge_mesg_alert.config_expression_id
                ) = GE_BOConstants.csbYES;
    BEGIN
      IF CUALERTA%ISOPEN THEN
         CLOSE CUALERTA;
      END IF;
      OPEN CUALERTA( INUREFERENCE, INUINISTATUS, INUENDSTATUS, INUENTITYID );
      FETCH CUALERTA
         BULK COLLECT INTO OTBALERTS;
      CLOSE CUALERTA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUALERTA%ISOPEN THEN
            CLOSE CUALERTA;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUALERTA%ISOPEN THEN
            CLOSE CUALERTA;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETGENERICALERT;
   PROCEDURE GETCREATORDERALERT( INUREFERENCE IN GE_MESG_ALERT.REFERENCE%TYPE, INUENDSTATUS IN GE_MESG_ALERT.FINAL_STATUS%TYPE, INUENTITYID IN GE_MESG_ALERT.ENTITY_ID%TYPE, OTBALERTS OUT DAGE_MESG_ALERT.TYTBGE_MESG_ALERT )
    IS
      CURSOR CUALERTA( INUREFERENCE IN GE_MESG_ALERT.REFERENCE%TYPE, INUENDSTATUS IN GE_MESG_ALERT.FINAL_STATUS%TYPE, INUENTITYID IN GE_MESG_ALERT.ENTITY_ID%TYPE ) IS
SELECT  /*+ index(ge_mesg_alert IDX_GE_MESG_ALERT01)*/
                GE_mesg_alert.*,GE_mesg_alert.rowid
        FROM    ge_mesg_alert
        WHERE   ge_mesg_alert.entity_id = inuEntityId
        AND     ge_mesg_alert.active = ge_boconstants.csbYES
        AND     ge_mesg_alert.initial_status IS NULL
        AND     ge_mesg_alert.final_status = inuEndStatus
        AND     (ge_mesg_alert.reference = inuReference OR ge_mesg_alert.reference IS NULL)
        AND     ut_date.fdtSysdate BETWEEN ge_mesg_alert.initial_date AND ge_mesg_alert.final_date
        AND     GE_BOUtilities.fsbValAssigRule
                (
                    ge_mesg_alert.config_expression_id
                ) = GE_BOConstants.csbYES;
    BEGIN
      IF CUALERTA%ISOPEN THEN
         CLOSE CUALERTA;
      END IF;
      OPEN CUALERTA( INUREFERENCE, INUENDSTATUS, INUENTITYID );
      FETCH CUALERTA
         BULK COLLECT INTO OTBALERTS;
      CLOSE CUALERTA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF CUALERTA%ISOPEN THEN
            CLOSE CUALERTA;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CUALERTA%ISOPEN THEN
            CLOSE CUALERTA;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETCREATORDERALERT;
END GE_BCNOTIFMESGALERT;
/


