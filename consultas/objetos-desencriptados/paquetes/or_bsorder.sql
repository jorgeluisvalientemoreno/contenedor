PACKAGE BODY Or_BSOrder
AS

    CSBVERSION CONSTANT VARCHAR2(20) := 'SAO221735';
    
    
    
    
















 
    PROCEDURE INITIALIZEOUTVAR 
    ( 
        IONUERRCODE  IN OUT  NUMBER, 
        IOSBERRMESS  IN OUT  VARCHAR2 
    ) 
    IS 
    BEGIN 
        IONUERRCODE := OR_BOCONSTANTS.CNUSUCCESS; 
        IOSBERRMESS := NULL; 
    EXCEPTION 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END INITIALIZEOUTVAR; 
    














 
    PROCEDURE VALIDATEASSDATA 
    ( 
        INUORDERNUMBER  IN OR_ORDER.ORDER_ID%TYPE 
    ) 
    IS 
    BEGIN 
        
        OR_BOVALIDATOR.VALIDATEASSIGNDATA(INUORDERNUMBER); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
		    RAISE EX.CONTROLLED_ERROR; 
    END VALIDATEASSDATA; 
    
    















    PROCEDURE  VALIDATEGROUPASSDATA
    (
        ITBORDERS IN DAOR_ORDER.TYTBORDER_ID
    )
    IS
    BEGIN
        
        OR_BOVALIDATOR.VALIDATEGROUPASSIGNDATA(ITBORDERS);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
		    RAISE EX.CONTROLLED_ERROR;
    END VALIDATEGROUPASSDATA;

    














 
    PROCEDURE VALIDATEANULLDATA 
    ( 
        INUORDER   IN OR_ORDER.ORDER_ID%TYPE 
    ) 
    IS 
    BEGIN 
        
        OR_BOVALIDATOR.VALIDATEANULLDATA(INUORDER); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
		    RAISE EX.CONTROLLED_ERROR; 
    END VALIDATEANULLDATA; 
 
    















 
    PROCEDURE ANULLORDERPROCESS 
    ( 
        INUORDER       IN  OR_ORDER.ORDER_ID%TYPE 
    ) 
    IS 
    BEGIN 
        
        OR_BOANULLORDER.ANULLORDER(INUORDER); 
        
        
        OR_BOANULLORDER.FINISHANULLORDER(INUORDER); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END ANULLORDERPROCESS; 
     
    

















 
    PROCEDURE VALIDATEGENERATEDATA 
    ( 
        INUORDER      IN OR_ORDER.ORDER_ID%TYPE, 
        INUOPERSECTOR IN OR_ORDER.OPERATING_SECTOR_ID%TYPE 
    ) 
    IS 
    BEGIN 
        
        OR_BOVALIDATOR.VALIDATEGENERATEDATA(INUORDER, INUOPERSECTOR); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            RAISE EX.CONTROLLED_ERROR; 
    END VALIDATEGENERATEDATA; 

    

















 
    PROCEDURE VALIDATELEGALIZEDATA 
    ( 
        INUORDER     IN OR_ORDER.ORDER_ID%TYPE, 
        INUCAUSAL    IN OR_ORDER.CAUSAL_ID%TYPE, 
        IDTEXEINIDAT IN OR_ORDER.EXEC_INITIAL_DATE%TYPE, 
        IDTEXEFINDAT IN OR_ORDER.EXECUTION_FINAL_DATE%TYPE 
    ) 
    IS 
    BEGIN 
        
        OR_BOVALIDATOR.VALIDATELEGALIZEDATA(INUORDER, INUCAUSAL, 
                                            IDTEXEINIDAT, IDTEXEFINDAT); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            RAISE; 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
		    RAISE EX.CONTROLLED_ERROR; 
    END VALIDATELEGALIZEDATA; 

    
    PROCEDURE ANULLORDER 
    ( 
        INUORDER     IN OR_ORDER.ORDER_ID%TYPE, 
        ONUERRORCODE OUT NUMBER, 
        OSBERRORMESS OUT VARCHAR2 
    ) 
    IS 
    BEGIN 
        
        INITIALIZEOUTVAR(ONUERRORCODE, OSBERRORMESS); 
        
        VALIDATEANULLDATA(INUORDER); 
        
        ANULLORDERPROCESS(INUORDER); 
    EXCEPTION 
        WHEN EX.CONTROLLED_ERROR THEN 
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS); 
        WHEN OTHERS THEN 
            ERRORS.SETERROR; 
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS); 
    END ANULLORDER; 

    PROCEDURE GETORDERBYCOMPONENTID
    (
        INUCOMPONENTID       IN  OR_EXTERN_SYSTEMS_ID.EXTERN_SYSTEM_ID%TYPE,
        INUTASKTYPE          IN  OR_ORDER.TASK_TYPE_ID%TYPE,
        ONUORDERID           OUT OR_ORDER.ORDER_ID%TYPE,
        ONUOPERUNITID        OUT OR_ORDER.OPERATING_UNIT_ID%TYPE,
        ONUERRORCODE         OUT NUMBER,
        OSBERRORMESS         OUT VARCHAR2
    )
    IS
    	RCDATOS       CONSTANTS.TYREFCURSOR;       
    	NUORDER       OR_ORDER.ORDER_ID%TYPE;      
    	NUTASK        OR_ORDER.TASK_TYPE_ID%TYPE;  
    	NUOPERUNITID  OR_ORDER.OPERATING_UNIT_ID%TYPE; 
    BEGIN
        
        INITIALIZEOUTVAR(ONUERRORCODE, OSBERRORMESS);

    	
		RCDATOS := OR_BCORDER.GETCOMPONENTORDERS(INUCOMPONENTID);
		LOOP
		    FETCH RCDATOS INTO ONUORDERID, NUTASK, ONUOPERUNITID;	
			EXIT WHEN RCDATOS%NOTFOUND;
			IF ( INUTASKTYPE =  NUTASK ) THEN
				CLOSE RCDATOS;
				RETURN;
			END IF;
		END LOOP;	
		CLOSE RCDATOS;
		
    EXCEPTION
       WHEN EX.CONTROLLED_ERROR THEN
            IF (RCDATOS%ISOPEN) THEN
                CLOSE RCDATOS;
            END IF;
           ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
       WHEN OTHERS THEN
            IF (RCDATOS%ISOPEN) THEN
                CLOSE RCDATOS;
            END IF;
           ERRORS.SETERROR;
           ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
    END GETORDERBYCOMPONENTID;

    FUNCTION FSBVERSION RETURN VARCHAR2
    IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    PROCEDURE VALINPUTDATA
    (
        INUORDERID           IN OR_ORDER.ORDER_ID%TYPE,
        ONUERRORCODE          OUT NUMBER,
        OSBERRORMESS          OUT VARCHAR2
    )
    IS
        BLISLEGALIZE BOOLEAN;
    BEGIN
    
        IF INUORDERID IS NOT NULL THEN
            
            BLISLEGALIZE := OR_BSUTLSERVICES.ISLEGALIZE(INUORDERID,ONUERRORCODE,OSBERRORMESS);

            IF ONUERRORCODE <> 0 THEN
               ERRORS.SETERROR;
               RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            IF NOT BLISLEGALIZE THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
            RAISE EX.CONTROLLED_ERROR;
    END VALINPUTDATA;





   PROCEDURE SETORDEREXECDATE (
                               INUORDERID    IN  OR_ORDER.ORDER_ID%TYPE,
                               IDTEXECDATE   IN  OR_ORDER.ARRANGED_HOUR%TYPE,
                               ONUERRORCODE  OUT NUMBER,
                               OSBERRORMESS  OUT VARCHAR2
                              )
    IS
    BEGIN
       INITIALIZEOUTVAR  ( ONUERRORCODE, OSBERRORMESS );
       OR_BOORDER.SETORDEREXECDATE(INUORDERID, IDTEXECDATE);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
    END;

    



    PROCEDURE UPDATEPRINTTIMENUMBER
    (
       ISBORDERSIDS IN VARCHAR2,
       ONUERRORCODE OUT NUMBER,
       OSBERRORMESS OUT VARCHAR2
    )
    IS
    BEGIN

        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESS);

        OR_BOORDER.UPDATEPRINTTIMENUMBER(ISBORDERSIDS);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
    END UPDATEPRINTTIMENUMBER;
    
    PROCEDURE GETORDERIDBYNUMSEQ
    (
       INUNUMERATOR IN  OR_ORDER.NUMERATOR_ID%TYPE,
       INUSEQUENCE  IN  OR_ORDER.SEQUENCE%TYPE,
       ONUORDERID   OUT OR_ORDER.ORDER_ID%TYPE,
       ONUERRORCODE OUT NUMBER,
       OSBERRORMESS OUT VARCHAR2
    )
    IS
    BEGIN
        ONUORDERID := OR_BOORDER.FNUGETORDERIDBYNUMSEQ(INUNUMERATOR, INUSEQUENCE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESS);
    END GETORDERIDBYNUMSEQ;

    






























    PROCEDURE GETORDERINFO
    (
        ISBADMINBASEIDS     IN  VARCHAR2,
        ISBZONES            IN  VARCHAR2,
        IDTASSIGNDATE       IN  OR_SCHED_AVAILABLE.DATE_%TYPE,
        OTBOPERUNITS        OUT OR_BCOPERATINGUNIT.TYTBOPERUNIT,
        OTBORDERS           OUT OR_BCORDER.TYTBORDER,
        ONUERRORCODE        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_MESSAGE.DESCRIPTION%TYPE
    )
    IS
    BEGIN
        INITIALIZEOUTVAR(ONUERRORCODE, OSBERRORMESSAGE);
        OR_BOORDER.GETORDERSASSIGNINFO
        (
            ISBADMINBASEIDS,
            ISBZONES,
            IDTASSIGNDATE,
            OTBOPERUNITS,
            OTBORDERS
        );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END GETORDERINFO;

    






























    PROCEDURE ASSIGNORDERPROCESS
    (
        INUORDERID      IN  OR_ORDER.ORDER_ID%TYPE,
        INUOPERUNITID   IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        IDTARRANGEDHOUR IN  OR_ORDER.ARRANGED_HOUR%TYPE,
        ONUERRORCODE    OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE OUT GE_MESSAGE.DESCRIPTION%TYPE,
        IDTCHANGEDATE   IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    )
    IS
    
        CNUERR901479 CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901479;
    BEGIN

        
        INITIALIZEOUTVAR(ONUERRORCODE, OSBERRORMESSAGE);

        
        IF ( DAOR_OPERATING_UNIT.FSBGETASSIGN_TYPE(INUOPERUNITID) IN
                (
                    OR_BCORDEROPERATINGUNIT.CSBASSIGN_SCHED,
                    OR_BCORDEROPERATINGUNIT.CSBASSIGN_ROUTE
                )
            )THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUERR901479, INUORDERID||'|'||INUOPERUNITID);
        END IF;

        
        OR_BOASSIGNMENT.ASSIGNORDERPROCESS
        (
            INUORDERID,
            INUOPERUNITID,
            IDTARRANGEDHOUR,
            IDTCHANGEDATE
        );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END;
    
    


































    PROCEDURE ASSIGNORDER
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ISBACTIVITIES   IN  GE_PARAMETER.VALUE%TYPE,
        INUINSTANCEID   IN  WF_INSTANCE.INSTANCE_ID%TYPE,
        ONUERRORCODE    OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE OUT GE_MESSAGE.DESCRIPTION%TYPE
    )
    IS
        BLASSIGNEDORDER     BOOLEAN;
    BEGIN
        
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);
        
        
        
        IF(ISBACTIVITIES IS NULL) THEN
            RETURN;
        END IF;
        
        
        OR_BOPROCESSORDER.ASSIGNSALESORDERS
        (
            INUPACKAGEID,
            ISBACTIVITIES,
            BLASSIGNEDORDER
        );
        

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END ASSIGNORDER;
    
    


























    PROCEDURE ASSIGNMOTIVEORDERS
    (
        INUMOTIVEID     IN  MO_MOTIVE.MOTIVE_ID%TYPE,
        ISBACTIVITIES   IN  GE_PARAMETER.VALUE%TYPE,
        INUINSTANCEID   IN  WF_INSTANCE.INSTANCE_ID%TYPE,
        ONUERRORCODE    OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE OUT GE_MESSAGE.DESCRIPTION%TYPE
    )
    IS
        BLASSIGNEDORDER     BOOLEAN;
    BEGIN
        
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        
        
        IF(ISBACTIVITIES IS NULL) THEN
            RETURN;
        END IF;

        
        OR_BOPROCESSORDER.ASSIGNMOTIVEORDERS
        (
            INUMOTIVEID,
            ISBACTIVITIES,
            BLASSIGNEDORDER
        );


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END ASSIGNMOTIVEORDERS;
    
    































    PROCEDURE CREATECLOSEORDER
    (
        INUOPERUNITID       IN  OR_ORDER.OPERATING_UNIT_ID%TYPE,
        INUACTIVITY         IN  GE_ITEMS.ITEMS_ID%TYPE,
        INUADDRESSID        IN  OR_ORDER_ACTIVITY.ADDRESS_ID%TYPE,
        IDTFINISHDATE       IN  OR_ORDER.EXECUTION_FINAL_DATE%TYPE,
        INUITEMAMOUNT       IN  OR_ORDER_ITEMS.LEGAL_ITEM_AMOUNT%TYPE DEFAULT 1,
        INUREFVALUE         IN  OR_ORDER_ACTIVITY.VALUE_REFERENCE%TYPE DEFAULT NULL,
        INUCAUSAL           IN  GE_CAUSAL.CAUSAL_ID%TYPE DEFAULT 1,
        INURELATIONTYPE     IN  GE_TRANSITION_TYPE.TRANSITION_TYPE_ID%TYPE DEFAULT NULL,
        IONUORDERID         IN OUT OR_ORDER.ORDER_ID%TYPE,
        INUORDERRELAID      IN  OR_ORDER.ORDER_ID%TYPE DEFAULT NULL,
        INUCOMMENTTYPEID    IN  GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE DEFAULT NULL,
        ISBCOMMENT          IN  OR_ORDER_COMMENT.ORDER_COMMENT%TYPE DEFAULT NULL,
        INUPERSONID         IN  OR_ORDER_PERSON.PERSON_ID%TYPE,
        ONUERRORCODE        OUT GE_MESSAGE.MESSAGE_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_MESSAGE.DESCRIPTION%TYPE
    )
    IS

    BEGIN

        
        INITIALIZEOUTVAR(ONUERRORCODE, OSBERRORMESSAGE);

        
        OR_BOORDER.VALIDCLOSEORDERDATA
            (
                INUOPERUNITID,
                INUACTIVITY,
                INUADDRESSID,
                IDTFINISHDATE,
                INUITEMAMOUNT,
                INUREFVALUE,
                INUCAUSAL,
                INURELATIONTYPE,
                IONUORDERID,
                INUORDERRELAID,
                INUCOMMENTTYPEID,
                ISBCOMMENT,
                INUPERSONID
            );

        
        OR_BOORDER.CREATECLOSEORDER
            (
                INUOPERUNITID,
                INUACTIVITY,
                INUADDRESSID,
                IDTFINISHDATE,
                INUITEMAMOUNT,
                INUREFVALUE,
                INUCAUSAL,
                INURELATIONTYPE,
                IONUORDERID,
                INUORDERRELAID,
                INUCOMMENTTYPEID,
                ISBCOMMENT,
                INUPERSONID
            );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END CREATECLOSEORDER;
    
    





















    PROCEDURE RELATEDORDER
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        INUORDERIDTORELATE  IN  OR_ORDER.ORDER_ID%TYPE,
        ONUERRORCODE        OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
        NURELATIONTYPE  GE_TRANSITION_TYPE.TRANSITION_TYPE_ID%TYPE;
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BSOrder.RelatedOrder', 2 );

        
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        
        
        NURELATIONTYPE := OR_BOCONSTANTS.CNURELATEDORDERTYPE;

        
        OR_BORELATEDORDER.RELATEORDERS
            (
                INUORDERID,
                INUORDERIDTORELATE,
                NURELATIONTYPE
            );

        UT_TRACE.TRACE('FIN Or_BSOrder.RelatedOrder', 2 );
    EXCEPTION
       WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END RELATEDORDER;
    
    





















    PROCEDURE GETRELATEDORDER
    (
        INUORDERID          IN  OR_ORDER.ORDER_ID%TYPE,
        OCURELATEDORDERS    OUT CONSTANTS.TYREFCURSOR,
        ONUERRORCODE        OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGE     OUT GE_ERROR_LOG.DESCRIPTION%TYPE
    )
    IS
    
    BEGIN
        UT_TRACE.TRACE('INICIO Or_BSOrder.GetRelatedOrder ', 2 );

        
        GE_BOUTILITIES.INITIALIZEOUTPUT(ONUERRORCODE, OSBERRORMESSAGE);

        
        OR_BOORDER.VALIFORDEREXIST(INUORDERID);

        
        
        OR_BORELATEDORDER.GETRELATEDORDERS(INUORDERID, OCURELATEDORDERS);

        UT_TRACE.TRACE('FIN Or_BSOrder.GetRelatedOrder', 2 );
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGE);
    END GETRELATEDORDER;

END OR_BSORDER;