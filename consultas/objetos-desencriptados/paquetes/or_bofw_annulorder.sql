PACKAGE BODY OR_BoFW_AnnulOrder AS
  































  
  
  
  
  
  CSBVERSION CONSTANT VARCHAR2(20) := 'SAO208227';

  
  CNUNULL_ATTRIBUTE CONSTANT NUMBER := 2126;
  
  CNUERR_113406 CONSTANT GE_ERROR_LOG.MESSAGE_ID%TYPE := 113406;

  
  
  

  
  
  
  

  FUNCTION FSBVERSION RETURN VARCHAR2 IS
  BEGIN
    RETURN CSBVERSION;
  END;

  



  PROCEDURE ANNULORDER IS
    SBORDER_ID        GE_BOINSTANCECONTROL.STYSBVALUE;
    SBCOMMENT_TYPE_ID GE_BOINSTANCECONTROL.STYSBVALUE;
    SBORDER_COMMENT   GE_BOINSTANCECONTROL.STYSBVALUE;
  
    NUORDER_ID OR_ORDER.ORDER_ID%TYPE;
    NUINDEX    GE_BOINSTANCECONTROL.STYNUINDEX;
  
  BEGIN
    
    UT_TRACE.TRACE('Inicio:[OR_FW_AnnulOrder.AnnulOrder]', 15);
    IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                                                    NULL,
                                                    'OR_ORDER',
                                                    'ORDER_ID',
                                                    NUINDEX) THEN
      GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                                                NULL,
                                                'OR_ORDER',
                                                'ORDER_ID',
                                                SBORDER_ID);
    
      
      NUORDER_ID := UT_CONVERT.FNUCHARTONUMBER(SBORDER_ID);
    END IF;
  
    SBCOMMENT_TYPE_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER_COMMENT',
                                                               'COMMENT_TYPE_ID');
    SBORDER_COMMENT   := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE('OR_ORDER_COMMENT',
                                                               'ORDER_COMMENT');
  
    
    IF (SBCOMMENT_TYPE_ID IS NULL) THEN
      ERRORS.SETERROR(CNUNULL_ATTRIBUTE, 'Tipo');
      RAISE EX.CONTROLLED_ERROR;
    END IF;
  
    
    OR_BCORDERPROCESS.LOCKORDER(NUORDER_ID);
  
    UT_TRACE.TRACE('nuOrderId:[' || NUORDER_ID || ']', 15);
  
    
    OR_BOANULLORDER.ANULLORDEROFDAMAGE(NUORDER_ID,
                                       UT_CONVERT.FNUCHARTONUMBER(SBCOMMENT_TYPE_ID),
                                       SBORDER_COMMENT);
  
    COMMIT;
    UT_TRACE.TRACE('Fin:[OR_FW_AnnulOrder.AnnulOrder]', 15);
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      ROLLBACK;
      UT_TRACE.TRACE('CONTROLLED_ERROR :[OR_FW_AnnulOrder.AnnulOrder]', 15);
      RAISE;
    WHEN OTHERS THEN
      ROLLBACK;
      ERRORS.SETERROR;
      UT_TRACE.TRACE('others :[OR_FW_AnnulOrder.AnnulOrder]', 15);
      RAISE EX.CONTROLLED_ERROR;
    
  END ANNULORDER;

  























   PROCEDURE VALIDATECANCELORDER IS
    
    TBORDERACTIVITIES OR_BCORDERACTIVITIES.TYTBORDERACTIVITIES;
    NUINDEX           BINARY_INTEGER;
    NUORDERID         OR_ORDER.ORDER_ID%TYPE;
    NUORDERSTATUS     OR_ORDER.ORDER_STATUS_ID%TYPE;
  
  BEGIN
    
    GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                                              NULL,
                                              'OR_ORDER',
                                              'ORDER_ID',
                                              NUORDERID);
    UT_TRACE.TRACE('OR_BoFW_AnnulOrder.ValidateCancelOrder, ' || NUORDERID,
                   10);
  
    
    IF (NOT OR_BOANULLORDER.FBLORDENVALANUL(NUORDERID) ) THEN
      GE_BOERRORS.SETERRORCODE(CNUERR_113406);
    END IF;
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
    
  END VALIDATECANCELORDER;

  











  FUNCTION FNUGETCOMMENTCLASS RETURN NUMBER IS
    NUORDER_ID OR_ORDER.ORDER_ID%TYPE;
    SBORDER_ID GE_BOINSTANCECONTROL.STYSBVALUE;
    NUINDEX    GE_BOINSTANCECONTROL.STYNUINDEX;
  
  BEGIN
  
    
    UT_TRACE.TRACE('Inicio:[OR_FW_AnnulOrder.fnuGetCommentClass]', 15);
    IF GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                                                    NULL,
                                                    'OR_ORDER',
                                                    'ORDER_ID',
                                                    NUINDEX) THEN
    
      GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                                                NULL,
                                                'OR_ORDER',
                                                'ORDER_ID',
                                                SBORDER_ID);
    
      
      NUORDER_ID := UT_CONVERT.FNUCHARTONUMBER(SBORDER_ID);
    
      
      IF DAOR_ORDER.FSBGETADM_PENDING(NUORDER_ID) = GE_BOCONSTANTS.CSBYES THEN
      
        
        RETURN OR_BOCONSTANTS.CNUCOMM_CLASS_ADM_ORD;
      
      ELSE
        
        RETURN OR_BOCONSTANTS.CNUCOMM_CLASS_WRK_ORD;
      END IF;
    
    END IF;
  
    RETURN NULL;
  
  EXCEPTION
    WHEN EX.CONTROLLED_ERROR THEN
      RAISE EX.CONTROLLED_ERROR;
    WHEN OTHERS THEN
      ERRORS.SETERROR;
      RAISE EX.CONTROLLED_ERROR;
  END;
  
  
    


















    PROCEDURE INITORAOL IS
    
    NUPECSCONS          PERICOSE.PECSCONS%TYPE;
    RCPERICOSE          PERICOSE%ROWTYPE;
    SBINSTANCE          VARCHAR2(300);

    BEGIN
        
        GE_BOINSTANCECONTROL.GETATTRIBUTENEWVALUE(
                    GE_BOINSTANCECONSTANTS.CSBWORK_INSTANCE,
                    NULL, 'PERICOSE', 'PECSCONS', NUPECSCONS
        );
        
        RCPERICOSE := PKTBLPERICOSE.FRCGETRECORD(NUPECSCONS);
        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(
                    SBINSTANCE,NULL,'PERICOSE','PECSCONS',
                    NUPECSCONS
        );
        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(
                    SBINSTANCE,NULL,'PERICOSE','PECSFECI',
                    TO_CHAR(RCPERICOSE.PECSFECI, UT_DATE.FSBDATE_FORMAT)
        );
        
        GE_BOINSTANCECONTROL.GETCURRENTINSTANCE(SBINSTANCE);
        GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(
                    SBINSTANCE,NULL,'PERICOSE','PECSFECF',
                    TO_CHAR(RCPERICOSE.PECSFECF, UT_DATE.FSBDATE_FORMAT)
        );


        UT_TRACE.TRACE('OR_BoFW_AnnulOrder.InitORAOL, ' || NUPECSCONS, 10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
          RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
          ERRORS.SETERROR;
          RAISE EX.CONTROLLED_ERROR;
    END INITORAOL;
  
  

















    FUNCTION FRFGETREGREREADORDERS
    RETURN CONSTANTS.TYREFCURSOR
    IS
        SBPECSCONS          GE_BOINSTANCECONTROL.STYSBVALUE;
        NUPECSCONS          PERICOSE.PECSCONS%TYPE;
        RFSELECT            CONSTANTS.TYREFCURSOR;
    BEGIN
        UT_TRACE.TRACE('Inicia OR_BoFW_AnnulOrder.frfGetRegRereadOrders',15);
        
        SBPECSCONS := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('PERICOSE', 'PECSCONS');
        NUPECSCONS := TO_CHAR(SBPECSCONS);
        
        
        OPEN RFSELECT FOR SELECT DISTINCT
              /*+
                 leading(lectelme)
                 index(lectelme IX_LECTELME13)
                 use_nl(lectelme or_order_activity OR_ORDER OR_route)
              */ OR_ORDER.ORDER_ID PK,
            OR_ORDER.ORDER_ID ORDER_ID,
            OR_ORDER.EXEC_ESTIMATE_DATE EXEC_ESTIMATE_DATE,
            OR_ORDER.EXTERNAL_ADDRESS_ID ADDRESS,
            OR_ROUTE.ROUTE_ID || ' - ' || OR_ROUTE.NAME ROUTE_NAME,
            OR_ORDER.CONSECUTIVE CONSECUTIVO
             FROM   LECTELME,
                    OR_ORDER_ACTIVITY,
                    OR_ORDER,
                    OR_ROUTE
             WHERE  LECTELME.LEEMPECS = NUPECSCONS
             AND  LECTELME.LEEMFLCO = PKCONSTANTE.SI
             AND  LECTELME.LEEMDOCU = OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID
             AND  OR_ROUTE.ROUTE_ID(+) = OR_ORDER.ROUTE_ID
             AND  EXISTS (SELECT /*+ index (hileelme IX_HILEELME01) */
                                 'X'
                          FROM   HILEELME
                          WHERE  HILEELME.HLEMELME = LECTELME.LEEMCONS
                          AND    ROWNUM=1)
             AND  OR_ORDER_ACTIVITY.ORDER_ID = OR_ORDER.ORDER_ID
             AND  OR_ORDER.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED;
        UT_TRACE.TRACE('FIN OR_BoFW_AnnulOrder.frfGetRegRereadOrders',15);
        RETURN RFSELECT;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END FRFGETREGREREADORDERS;

    





















    PROCEDURE ANULLREREADINGORDER(
                                    SBORDERID          IN VARCHAR2,
                                    INUACTUAL          IN NUMBER,
                                    INUTOTAL           IN NUMBER,
                                    ONUERRORCODIGO    OUT NUMBER,
                                    OSBERRORMENSAJE   OUT VARCHAR2
                                )
    IS

        NUORDERID               OR_ORDER.ORDER_ID%TYPE;
        NUINDEX                 GE_BOINSTANCECONTROL.STYNUINDEX;
        SBCOMMENT_TYPE_ID       GE_BOINSTANCECONTROL.STYSBVALUE;
        NUCOMMENTTYPEID         GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE;
        SBORDER_COMMENT         GE_BOINSTANCECONTROL.STYSBVALUE;


     BEGIN
        UT_TRACE.TRACE('Inicia OR_BoFW_AnnulOrder.AnullRereadingOrder',15);
        
        ONUERRORCODIGO := GE_BOCONSTANTS.OK;
        OSBERRORMENSAJE := GE_BOCONSTANTS.CSBNULLSB;

        
        SBCOMMENT_TYPE_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('GE_COMMENT_TYPE', 'COMMENT_TYPE_ID');
        IF (SBCOMMENT_TYPE_ID IS NULL) THEN
            ERRORS.SETERROR (2126, 'Tipo de Comentario');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        NUCOMMENTTYPEID := TO_NUMBER(SBCOMMENT_TYPE_ID);
        
        
        SBORDER_COMMENT := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER_COMMENT', 'ORDER_COMMENT');
        
         
        OR_BCORDERPROCESS.LOCKORDER(SBORDERID);

        UT_TRACE.TRACE('nuOrderId:[' || SBORDERID || ']', 15);

        
        OR_BOANULLORDER.ANULLORDEROFDAMAGE(TO_NUMBER(SBORDERID),
                                           NUCOMMENTTYPEID,
                                           SBORDER_COMMENT);

        COMMIT;
        UT_TRACE.TRACE('Termina OR_BoFW_AnnulOrder.AnullRereadingOrder',15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ROLLBACK;
            ERRORS.GETERROR(ONUERRORCODIGO, OSBERRORMENSAJE);
        WHEN OTHERS THEN
            ROLLBACK;
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODIGO, OSBERRORMENSAJE);
    END ANULLREREADINGORDER;
    
END OR_BOFW_ANNULORDER;