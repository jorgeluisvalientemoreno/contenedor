PACKAGE BODY CM_BOLectelme AS
    

































    
    
    
    
    CSBVERSION CONSTANT VARCHAR2(10) := 'SAO331607';
    
    
    CNUERROR_3060     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3060;
    
    CNUERROR_3461     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3461;
    
    CNUERROR_903821   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 903821;
    
    CNUERROR_900444   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900444;
    
    CNUERROR_COMMENT  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 111528;
    
    CNUNO_CAUSNOLE    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900467;
    
    



















    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
    
        PKERRORS.PUSH('CM_BOLectelme.fsbVersion');

        PKERRORS.POP;
        
        RETURN (CSBVERSION);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END FSBVERSION;
    
    


























































    PROCEDURE INSERTREADING
    (
        INUORDERACTIVITYID IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE,
        INUORDERID         IN OR_ORDER_ACTIVITY.ORDER_ID%TYPE,
        INUACTIVITYID      IN OR_ORDER_ACTIVITY.ACTIVITY_ID%TYPE,
        INUPERSONID        IN OR_ORDER_PERSON.PERSON_ID%TYPE,
        INUPRODUCTID       IN OR_ORDER_ACTIVITY.PRODUCT_ID%TYPE,
        ISBELMECODI        IN ELEMMEDI.ELMECODI%TYPE,
        INUTIPOCONS        IN TIPOCONS.TCONCODI%TYPE,
        INUREADINGTAKEN    IN LECTELME.LEEMLETO%TYPE,
        ISBREADINGCAUSAL   IN LECTELME.LEEMCLEC%TYPE,
        IDTREADINGDATE     IN LECTELME.LEEMFELE%TYPE,
        INUCOMMENTA        IN LECTELME.LEEMOBLE%TYPE,
        INUCOMMENTB        IN LECTELME.LEEMOBSB%TYPE,
        INUCOMMENTC        IN LECTELME.LEEMOBSC%TYPE,
        IBLGENCONSUMPTION  IN BOOLEAN DEFAULT TRUE
    )
    IS
        RCORDER         DAOR_ORDER.STYOR_ORDER;          
        RCLECTELME      LECTELME%ROWTYPE;                
        RCLASTREADING   LECTELME%ROWTYPE;                
        
        NUERROR         GE_ERROR_LOG.ERROR_LOG_ID%TYPE;  
        SBERROR         GE_ERROR_LOG.DESCRIPTION%TYPE;   
        
        SBSERIAL        GE_ITEMS_SERIADO.SERIE%TYPE;                       
        NUSERIALITEM    GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE;            
        NUITEMID        GE_ITEMS_SERIADO.ITEMS_ID%TYPE;                    
        NUITEMTYPEID    GE_ITEMS.ID_ITEMS_TIPO%TYPE;                       
        NUITEMTYPEATTID GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR%TYPE;          
        NUIDATRIBUTEVALUE  GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_AT_VAL%TYPE; 
        SBVALOR            GE_ITEMS_TIPO_AT_VAL.VALOR%TYPE;                
        CSBMETERFACTOR  VARCHAR2(50) := 'METER_FACTOR';                    
        RCOBSELECT      OBSELECT%ROWTYPE;                                  
        RCELMESESU      ELMESESU%ROWTYPE;                                  
        
    BEGIN
    
        UT_TRACE.TRACE('INICIO CM_BOLectelme.InsertReading',5);

        
        PKMEASUREMENTELEMENMGR.VALBASICDATA(ISBELMECODI);
        
        
        PKCONSUMPTIONTYPEMGR.VALBASICDATA(INUTIPOCONS);
        
        
        IF (   (ISBREADINGCAUSAL IS NULL)
            OR (ISBREADINGCAUSAL NOT IN (CM_BOCONSTANTS.CSBCAUS_LECT_INST,
                                         CM_BOCONSTANTS.CSBCAUS_LECT_RETI,
                                         CM_BOCONSTANTS.CSBCAUS_LECT_BILL,
                                         CM_BOCONSTANTS.CSBCAUS_LECT_TRAB))) THEN
            ERRORS.SETERROR(CNUERROR_900444);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (INUREADINGTAKEN IS NULL) THEN
            
            IF (INUCOMMENTA IS NULL) THEN
                ERRORS.SETERROR(CNUERROR_3060,
                                'Observaci?n 1');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            RCOBSELECT := PKTBLOBSELECT.FRCGETRECORD(INUCOMMENTA);
            IF (NVL(RCOBSELECT.OBLECANL,
                    PKCONSTANTE.NO) <> PKCONSTANTE.SI) THEN
                ERRORS.SETERROR(CNUNO_CAUSNOLE);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            IF (INUCOMMENTB IS NOT NULL) THEN
                PKOBSERVAOFREADINGMGR.VALBASICDATA(INUCOMMENTB,
                                                   PKCONSTANTE.SI);
            END IF;
            IF (INUCOMMENTC IS NOT NULL) THEN
                PKOBSERVAOFREADINGMGR.VALBASICDATA(INUCOMMENTC,
                                                   PKCONSTANTE.SI);
            END IF;
        ELSE
            
            IF (INUREADINGTAKEN < 0) THEN
                ERRORS.SETERROR(CNUERROR_3461);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            IF (INUCOMMENTA IS NOT NULL) THEN
                PKOBSERVAOFREADINGMGR.VALBASICDATA(INUCOMMENTA,
                                                   PKCONSTANTE.NO);
            END IF;
            IF (INUCOMMENTB IS NOT NULL) THEN
                PKOBSERVAOFREADINGMGR.VALBASICDATA(INUCOMMENTB,
                                                   PKCONSTANTE.NO);
            END IF;
            IF (INUCOMMENTC IS NOT NULL) THEN
                PKOBSERVAOFREADINGMGR.VALBASICDATA(INUCOMMENTC,
                                                   PKCONSTANTE.NO);
            END IF;
        END IF;
        
        
        IF (INUCOMMENTA = INUCOMMENTB) THEN
            ERRORS.SETERROR(CNUERROR_COMMENT,
                            '[Observaci?n 1]|[Observaci?n 2]');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (INUCOMMENTA = INUCOMMENTC) THEN
            ERRORS.SETERROR(CNUERROR_COMMENT,
                            '[Observaci?n 1]|[Observaci?n 3]');
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        IF (INUCOMMENTB = INUCOMMENTC) THEN
            ERRORS.SETERROR(CNUERROR_COMMENT,
                            '[Observaci?n 2]|[Observaci?n 3]');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        RCELMESESU := PKBCELMESESU.FRCGETMEASELEMPRODDATE(ISBELMECODI,
                                                          INUPRODUCTID,
                                                          IDTREADINGDATE);

        
        IF (RCELMESESU.EMSSELME IS NOT NULL) THEN
        
            
            RCLECTELME.LEEMSESU := RCELMESESU.EMSSSESU;
            RCLECTELME.LEEMCMSS := RCELMESESU.EMSSCMSS;
            RCLECTELME.LEEMELME := RCELMESESU.EMSSELME;

            IF (INUREADINGTAKEN IS NOT NULL) THEN
                
                PKBOMEASELEMCONSMPTCALCDATA.VALIDATEREADBUTT(RCLECTELME.LEEMELME,
                                                             INUTIPOCONS,
                                                             INUREADINGTAKEN);
            END IF;

            
            RCLECTELME.LEEMPECS := CM_BOCHANGEMETER.FNUGETCURRCONSPERIODBYPROD(RCLECTELME.LEEMSESU,
                                                                               IDTREADINGDATE);
            
            
            RCLECTELME.LEEMPEFA := CM_BOCHANGEMETER.FNUGETPERIFACT(RCLECTELME.LEEMSESU,
                                                                   RCLECTELME.LEEMPECS);
                                                                   
            
            
            SBSERIAL := PKTBLELEMMEDI.FSBGETELMECODI(RCLECTELME.LEEMELME);
            GE_BCITEMSSERIADO.GETIDBYSERIE(SBSERIAL, NUSERIALITEM);
            NUITEMID := DAGE_ITEMS_SERIADO.FNUGETITEMS_ID(NUSERIALITEM);
            NUITEMTYPEID := DAGE_ITEMS.FNUGETID_ITEMS_TIPO(NUITEMID);

            
            NUITEMTYPEATTID := GE_BCITEMSTIPO.FNUGETATRIBUTOTIPO(NUITEMTYPEID, CSBMETERFACTOR);

            
            IF (NUITEMTYPEATTID IS NULL OR NUITEMTYPEATTID = 0) THEN
                RCLECTELME.LEEMFAME := NULL;
            ELSE
                GE_BCITEMSSERIADO.GETATRIBUTEVALUE(NUITEMTYPEATTID,NUSERIALITEM, NUIDATRIBUTEVALUE, SBVALOR);
                RCLECTELME.LEEMFAME := UT_CONVERT.FNUCHARTONUMBER(SBVALOR);
            END IF;
                                                                              
            
            
            IF (CM_BOCONSTANTS.CSBCAUS_LECT_INST != ISBREADINGCAUSAL ) THEN
                 
                 PKMEASUREMENTREADINGMGR.GETLASTREADING(RCLECTELME.LEEMELME,
                                                        INUTIPOCONS,
                                                        RCLASTREADING);

                 RCLECTELME.LEEMLEAN := RCLASTREADING.LEEMLETO;
                 RCLECTELME.LEEMFELA := RCLASTREADING.LEEMFELE;
            ELSE
                 RCLECTELME.LEEMLEAN := INUREADINGTAKEN;
                 RCLECTELME.LEEMFELA := IDTREADINGDATE;
            END IF;

            
            RCLECTELME.LEEMCONS := CM_BOSEQUENCE.FNULECTELMENEXTSEQVAL;
            RCLECTELME.LEEMDOCU := INUORDERACTIVITYID;
            RCLECTELME.LEEMCLEC := ISBREADINGCAUSAL;
            RCLECTELME.LEEMTCON := INUTIPOCONS;
            RCLECTELME.LEEMOBLE := INUCOMMENTA;
            RCLECTELME.LEEMOBSB := INUCOMMENTB;
            RCLECTELME.LEEMOBSC := INUCOMMENTC;
            RCLECTELME.LEEMLETO := INUREADINGTAKEN;
            RCLECTELME.LEEMFELE := IDTREADINGDATE;
            
            RCLECTELME.LEEMPETL := INUPERSONID;

            

            IF (RCLECTELME.LEEMCLEC = CM_BOCONSTANTS.CSBCAUS_LECT_RETI ) THEN
                RCLECTELME.LEEMFELE := TRUNC(IDTREADINGDATE);
            END IF;

            
            IF (RCLECTELME.LEEMCLEC = CM_BOCONSTANTS.CSBCAUS_LECT_INST ) THEN
                RCLECTELME.LEEMFELE := TRUNC(IDTREADINGDATE) + 1/UT_DATE.CNUSECONDSBYDAY;
            END IF;
            
            
            PKTBLLECTELME.INSRECORD(RCLECTELME);

            IF (IBLGENCONSUMPTION) THEN
                
                IF (ISBREADINGCAUSAL <> CM_BOCONSTANTS.CSBCAUS_LECT_TRAB) THEN
                    
                    DAOR_ORDER.GETRECORD(INUORDERID,
                                         RCORDER);
                    
                    CM_BOCONSUMPTIONENGINE.CALCULATECONSUMPTION(RCLECTELME,
                                                                RCORDER,
                                                                INUACTIVITYID);
                END IF;
            END IF;
                                                    
        ELSE
            
            
            
            ERRORS.SETERROR(CNUERROR_903821,
                            TO_CHAR(NVL(IDTREADINGDATE,''))||'|'
                            ||TO_CHAR(NVL(ISBELMECODI,''))||'|'||TO_CHAR(NVL(INUPRODUCTID,'')));
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN CM_BOLectelme.InsertReading',5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END INSERTREADING;
    
    
















    PROCEDURE UPDMETERFACTOR (
                                INUSERIALITEM   IN GE_ITEMS_SERIADO.ID_ITEMS_SERIADO%TYPE,
                                INUMETERFACTOR  IN GE_ITEMS_TIPO_AT_VAL.VALOR%TYPE
                             )
    IS
        NUITEMID        GE_ITEMS_SERIADO.ITEMS_ID%TYPE;
        NUITEMTYPEID    GE_ITEMS.ID_ITEMS_TIPO%TYPE;
        NUITEMTYPEATTID GE_ITEMS_TIPO_ATR.ID_ITEMS_TIPO_ATR%TYPE;
        NUATTRVALUEID   GE_ITEMS_TIPO_AT_VAL.ID_ITEMS_TIPO_AT_VAL%TYPE;
        CSBMETERFACTOR  VARCHAR2(50) := 'METER_FACTOR';
        CNUERROR_901613 NUMBER(6) := 901613;
    BEGIN
        UT_TRACE.TRACE('INICIO CM_BOLectelme.updMeterFactor',5);
        
        
        NUITEMID := DAGE_ITEMS_SERIADO.FNUGETITEMS_ID(INUSERIALITEM);
        NUITEMTYPEID := DAGE_ITEMS.FNUGETID_ITEMS_TIPO(NUITEMID);

        
        NUITEMTYPEATTID := GE_BCITEMSTIPO.FNUGETATRIBUTOTIPO(NUITEMTYPEID, CSBMETERFACTOR);

        
        IF (NUITEMTYPEATTID IS NULL OR NUITEMTYPEATTID = 0) THEN
            GE_BOERRORS.SETERRORCODEARGUMENT(CNUERROR_901613, CSBMETERFACTOR);
        END IF;

        
        GE_BOITEMSSERIADO.ACTUALIZARATRIBUTO(NUITEMTYPEATTID,INUSERIALITEM,INUMETERFACTOR,NUATTRVALUEID);
        UT_TRACE.TRACE('FIN CM_BOLectelme.updMeterFactor',5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDMETERFACTOR;

END CM_BOLECTELME;