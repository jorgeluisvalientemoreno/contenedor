PACKAGE Ge_BoNotifMesgAlert
IS




















































































    
    
    
    TYPE TYTBTYSELECT IS TABLE OF GE_BOINSTANCE.TYTBINSTANCE INDEX BY BINARY_INTEGER;
    TYPE TYTBNUMBER IS TABLE OF NUMBER INDEX BY BINARY_INTEGER;

    
    
    
    CSBSTATUS_RE                CONSTANT VARCHAR2(2) := 'RE'; 
    CSBSTATUS_SE                CONSTANT VARCHAR2(2) := 'SE'; 
    CSBSTATUS_ES                CONSTANT VARCHAR2(2) := 'ES'; 
    CSBSTATUS_ET                CONSTANT VARCHAR2(2) := 'ET'; 
    
    
    

    
    
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2;
    
    PROCEDURE PROCSTAORDERFORALERT
    (
        IRCORDEN        IN  DAOR_ORDER.STYOR_ORDER,
        INUESTADOINI    IN  OR_ORDER.ORDER_STATUS_ID%TYPE
    );
    
    PROCEDURE PROCSTAUNDOPERFORALERT
    (
        IRCOPERUNIT     IN  DAOR_OPERATING_UNIT.STYOR_OPERATING_UNIT,
        INUESTADOINI    IN  OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID%TYPE,
        IDTCHANGEDATE   IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    );
    
    
    
    PROCEDURE PROCESSNOTIFALERTTEMP
    (
         INUMESGALERTID     IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
         INUSTATEMENTID     IN  GE_STATEMENT.STATEMENT_ID%TYPE,
         INUTIMEREF         IN  NUMBER,
         INUPORCENTTOL      IN  NUMBER,
         ISBLETRENOTIFY     IN  VARCHAR2 DEFAULT 'N'
    );

    FUNCTION FBLPROCESSSTATEMENT
    (
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        ISBINPUT        IN  VARCHAR2,
        OTBSELECTINS    OUT TYTBTYSELECT
    )
    RETURN BOOLEAN;

    PROCEDURE SENDPACKATTREMINALERT
    (
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        INUHOURSBEFORE  IN  NUMBER
    );

    PROCEDURE SENDPACKATTEXPIRALERT
    (
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        INUHOURSAFTER   IN  NUMBER
    );
    
    
    
    
    PROCEDURE PROCGENRLNOTIFALERTTEMP
    (
         INUMESGALERTID     IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
         INUSTATEMENTID     IN  GE_STATEMENT.STATEMENT_ID%TYPE,
         ISBLETRENOTIFY     IN  VARCHAR2 DEFAULT 'N'
    );
    
    PROCEDURE SAVELOGNOTIF
    (
       INUNOTIFID   IN  GE_NOTIFICATION.NOTIFICATION_ID%TYPE,
       INUERRCODE   IN  NUMBER,
       ISBERRMSG    IN  VARCHAR2,
       ISBSTATUS    IN  VARCHAR2,
       ISBOUTTEXT   IN  VARCHAR2,
       ISBINPUTDTA  IN  VARCHAR2,
       INUEXTERNAL  IN  NUMBER,
       ONULOG_ID    OUT NUMBER
    );

END GE_BONOTIFMESGALERT;
/
PACKAGE BODY Ge_BoNotifMesgAlert
IS































































































    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO198736';

    
    
    

    CSBMESG_ALERT               CONSTANT VARCHAR2(20) := 'MESG_ALERT_ID';
    CSBSTATEMENT                CONSTANT VARCHAR2(20) := 'STATEMENT_ID';
    CSBNOTIF_TYPE               CONSTANT VARCHAR2(20) := 'NOTIFICATION_TYPE_ID';
    CSBPERSONID                 CONSTANT VARCHAR2(20) := 'PERSON_ID';
    CSBSEMICOLON                CONSTANT VARCHAR2(1) := ';';
    CSBCOMMA                    CONSTANT VARCHAR2(1) := ',';
    CSBEQUAL                    CONSTANT VARCHAR2(1) := '=';
     CSBFIELD                   CONSTANT VARCHAR2(20) := 'FIELD';

    CNUNEXT_ATTEMPT_NUMBER      CONSTANT NUMBER := GE_BOPARAMETER.FNUGET('NEXT_ATTEMPT_NUMBER') * UT_DATE.CNUFACTOR_MINUTE_DATE;

    
    CNUORDER_ENTY_ID            CONSTANT NUMBER(15)    := 3294;
    
    CNUOPERUNIT_ENTY_ID         CONSTANT NUMBER(15)    := 3274;

    
    CNUATTRIB_NO_EXISTS         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 3114;
    
    CNUATTRIB_NULL              CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 1184;
    
    CNUALERT_NO_ACTIV           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 17842;
    
    CNUALERT_NO_TEMPO           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 17806;
    
    CNUALERT_NO_VIGEN           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 13321;
    
    CNUALERT_NO_PARAM           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 13301;
    
    
    CNUSTATEMENT_NOT_HAS_PK     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300012;
    
    CNUENTITY_NOT_HAS_PK        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300013;
    
    CNUNOTIF_WRONG_CONF         CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300017;
    
    CNUNOBODY_TO_NOTIF          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 300019;

    
    
    

    
    
    
    
    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
    
    


















    PROCEDURE STRINGTOTBPARAMETRS
    (
       ISBSTRING   IN VARCHAR2,
       OTBINSTANCE OUT NOCOPY GE_BOINSTANCE.TYTBINSTANCE
    )
    IS
        
        TBPARAMETER      UT_STRING.TYTB_STRPARAMETERS;
    BEGIN
        
        UT_TRACE.TRACE ('Ge_BoNotifmesgalert.StringToTbParametrs'||ISBSTRING,20);
        
        
        UT_STRING.EXTPARAMETERS(ISBSTRING,CSBSEMICOLON,CSBEQUAL,TBPARAMETER);

        IF TBPARAMETER.COUNT <= 0 THEN
          ERRORS.SETERROR(2081);
          RAISE EX.CONTROLLED_ERROR;
        END IF;

        FOR NUINDICE IN 1..TBPARAMETER.COUNT LOOP
            GE_BOINSTANCE.SETATTRIBUTE( OTBINSTANCE,
                                        NULL,
                                        TBPARAMETER(NUINDICE).SBPARAMETER,
                                        GE_BOCONSTANTS.CSBVARCHAR2,
                                        TBPARAMETER(NUINDICE).SBVALUE,
                                        NULL,
                                        NULL
                                      );
        END LOOP;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END STRINGTOTBPARAMETRS;
    
    















    FUNCTION FBLPROCESSSTATEMENT
    (
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        ISBINPUT        IN  VARCHAR2,
        OTBSELECTINS    OUT TYTBTYSELECT
    ) RETURN BOOLEAN
    IS
        
        NUCURSOR            NUMBER(20);
        REGTABLAS           GE_BOSTATEMENT.DESCSELECT;
        TBINSTANCE          GE_BOINSTANCE.TYTBINSTANCE;
        TBTMPSELECT         GE_BOINSTANCE.TYTBINSTANCE;
        RCSTATEMENT         DAGE_STATEMENT.STYGE_STATEMENT;
        BLFETCH             BOOLEAN := FALSE;
        SBNEWSELECT         VARCHAR2(10):= 'NEW SELECT';
        TBSELECTINS         TYTBTYSELECT;
        NUINDICE            NUMBER := 0;
    BEGIN
        
        UT_TRACE.TRACE('INICIO GE_BoNotifMesgAlert.fblProcessStatement',11);

        
        GE_BOINSTANCE.STRDEFAULTTOINSTANCE(ISBINPUT,TBINSTANCE);
        
        
        DAGE_STATEMENT.GETRECORD(INUSTATEMENTID, RCSTATEMENT);

        GE_BOSTATEMENT.OPENSTATEMENT(
                                    TBINSTANCE, INUSTATEMENTID,
                                    REGTABLAS, NUCURSOR
                                   );
        
        GE_BOINSTANCE.SETATTRIBUTE(
                TBTMPSELECT, NULL, SBNEWSELECT,NULL, RCSTATEMENT.NAME, NULL, NULL
                );
        
        GE_BOINSTANCE.DELETETABLE(TBTMPSELECT);

        
        LOOP
            
            EXIT WHEN NOT GE_BOSTATEMENT.FETCHSTATEMENT(NUCURSOR,REGTABLAS,TBTMPSELECT);

            NUINDICE := NVL(NUINDICE,0)+1;
            TBSELECTINS(NUINDICE) := TBTMPSELECT;

            
            BLFETCH := TRUE;
        END LOOP;

        
        IF NOT BLFETCH THEN
            UT_TRACE.TRACE('No Arrojo Datos el statement',10);
            UT_TRACE.TRACE('FIN GE_BoNotifMesgAlert.fblProcessStatement',11);
            RETURN FALSE;
        END IF;

        
        GE_BOSTATEMENT.CLOSESTATEMENT(NUCURSOR);

        OTBSELECTINS := TBSELECTINS;

        UT_TRACE.TRACE('FIN GE_BoNotifMesgAlert.fblProcessStatement',11);

        RETURN TRUE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLPROCESSSTATEMENT;

    


















    FUNCTION FBLFINDATTRORDORUOPER
    (
        TBREGSELECT     IN  TYTBTYSELECT,
        ONUINDORDEN     OUT NUMBER,
        ONUINDUNOPER    OUT NUMBER
    ) RETURN BOOLEAN
    IS
        
        TBTMPSELECT         GE_BOINSTANCE.TYTBINSTANCE;
        BLEXISTATTRI        BOOLEAN := FALSE;
        SBATRIBUTORDER      VARCHAR2(40) := 'ORDER_ID';
        SBATRIBUTUNIOPER    VARCHAR2(40) := 'OPERATING_UNIT_ID';

    BEGIN
        
        TBTMPSELECT := TBREGSELECT(1); 
        FOR IND IN TBTMPSELECT.FIRST..TBTMPSELECT.LAST LOOP
            IF (TBTMPSELECT(IND).NAME_ATTRIBUTE = SBATRIBUTORDER) THEN
                
                BLEXISTATTRI := TRUE;
                ONUINDORDEN := IND;
                
            END IF;
            IF (TBTMPSELECT(IND).NAME_ATTRIBUTE = SBATRIBUTUNIOPER ) THEN
                
                BLEXISTATTRI := TRUE;
                ONUINDUNOPER := IND;
            END IF;
        END LOOP;

        RETURN BLEXISTATTRI;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLFINDATTRORDORUOPER;

    
    


















    PROCEDURE SAVELOGNOTIF
    (
       INUNOTIFID   IN  GE_NOTIFICATION.NOTIFICATION_ID%TYPE,
       INUERRCODE   IN  NUMBER,
       ISBERRMSG    IN  VARCHAR2,
       ISBSTATUS    IN  VARCHAR2,
       ISBOUTTEXT   IN  VARCHAR2,
       ISBINPUTDTA  IN  VARCHAR2,
       INUEXTERNAL  IN  NUMBER,
       ONULOG_ID    OUT NUMBER
    )
    IS
        
        RCNOTIFICATION_LOG  DAGE_NOTIFICATION_LOG.STYGE_NOTIFICATION_LOG;
        RCNOTIFICATION      DAGE_NOTIFICATION.STYGE_NOTIFICATION;
    BEGIN
       
        
        IF ( DAGE_NOTIFICATION.FBLEXIST(INUNOTIFID) ) THEN
            DAGE_NOTIFICATION.GETRECORD(INUNOTIFID,RCNOTIFICATION);
        ELSE
            RETURN;
        END IF;

        
        IF RCNOTIFICATION.REPORT_LOG = GE_BOCONSTANTS.CSBNO THEN
            
            RETURN;
        END IF;

        

        RCNOTIFICATION_LOG.NOTIFICATION_TYPE_ID := NVL(RCNOTIFICATION.NOTIFICATION_TYPE_ID,1);
        RCNOTIFICATION_LOG.NOTIFICATION_ID := INUNOTIFID;

        RCNOTIFICATION_LOG.EXTERNAL_ID      := INUEXTERNAL;
        RCNOTIFICATION_LOG.DATE_            := SYSDATE;
        RCNOTIFICATION_LOG.STATUS           := NVL(ISBSTATUS,CSBSTATUS_RE);
        RCNOTIFICATION_LOG.PARAMETERS       := NULL;
        RCNOTIFICATION_LOG.OUTPUT           := NVL(RCNOTIFICATION.FORMAT_TYPE,'T');
        RCNOTIFICATION_LOG.OUTPUT_TEXT      := ISBOUTTEXT;
        RCNOTIFICATION_LOG.OUTPUT_CLOB      := EMPTY_CLOB;
        RCNOTIFICATION_LOG.OUTPUT_BLOB      := EMPTY_BLOB;
        RCNOTIFICATION_LOG.ATTEMPT_NUMBER   := 1;
        RCNOTIFICATION_LOG.ATTEMPT_DATE     := SYSDATE;
        RCNOTIFICATION_LOG.ATTEMPT_NEXT     := SYSDATE + CNUNEXT_ATTEMPT_NUMBER;
        RCNOTIFICATION_LOG.INPUT_DATA       := SUBSTR(ISBINPUTDTA,1,1024);
        RCNOTIFICATION_LOG.ORIGIN_MODULE_ID := NVL(RCNOTIFICATION.ORIGIN_MODULE_ID,1);
        RCNOTIFICATION_LOG.TARGET_MODULE_ID := NVL(RCNOTIFICATION.TARGET_MODULE_ID,1);
        RCNOTIFICATION_LOG.ERROR_CODE       := INUERRCODE;
        RCNOTIFICATION_LOG.ERROR_MESSAGE    := ISBERRMSG;

        RCNOTIFICATION_LOG.NOTIFICATION_LOG_ID := GE_BOSEQUENCE.NEXTGE_NOTIFICATION_LOG;

        ONULOG_ID := RCNOTIFICATION_LOG.NOTIFICATION_LOG_ID;

        DAGE_NOTIFICATION_LOG.INSRECORD(RCNOTIFICATION_LOG);

    EXCEPTION
       WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
       WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SAVELOGNOTIF;


    








































    PROCEDURE PROCSTAORDERFORALERT
    (
        IRCORDEN        IN  DAOR_ORDER.STYOR_ORDER,
        INUESTADOINI    IN  OR_ORDER.ORDER_STATUS_ID%TYPE
    )
    IS
    
        RCTIPOTRABAJO       DAOR_TASK_TYPE.STYOR_TASK_TYPE;
        TBALERTAS           DAGE_MESG_ALERT.TYTBGE_MESG_ALERT;
        RCACTIVIDADES       DAOR_ORDER_ACTIVITY.STYOR_ORDER_ACTIVITY;
        BLCUMPLETIPODANO    BOOLEAN;
        BLCUMPLECAUSAL      BOOLEAN;
        OSBTIPOFORMATO      GE_NOTIFICATION.FORMAT_TYPE%TYPE;
        OSBSALIDATEXTO      GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE;
        OSBSALIDACLOB       GE_NOTIFICATION_LOG.OUTPUT_CLOB%TYPE;
        NUINDEX             NUMBER;
        NUTIPODANO          TT_DAMAGE.REG_DAMAGE_TYPE_ID%TYPE;
        ISBINPUT            VARCHAR2(2000);
        SBPARAMS            VARCHAR2(2000);
        TBOPERUNITSNOTIFY   DAOR_OPERATING_UNIT.TYTBOR_OPERATING_UNIT;
        TBPERSONSNOTIFY     DAGE_PERSON.TYTBGE_PERSON;
        TBPERSNOTIFYGENERIC GE_BOFWPARAMETMESGALERT.TYTBPERSONS;
        TBPERSONEXCEP       GE_BOFWPARAMETMESGALERT.TYTBPERSONS;
        NUNOTIFICATIONLOG   GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;
        NUERROR             GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        SBERROR             GE_ERROR_LOG.DESCRIPTION%TYPE;
        NUNOTITYPE          GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE;
        CNUORDER_CREATED    CONSTANT NUMBER := -9999;
        NUIDX               NUMBER;
        SBIDX               VARCHAR2(20);
        SBKEY               VARCHAR2(20);
        NUAUXIDX            NUMBER;
        
        TBOPERUNITPER       DAOR_OPER_UNIT_PERSONS.TYTBOR_OPER_UNIT_PERSONS;
        BLORDCREATE         BOOLEAN;
        CSBTOKEN_CREATE     CONSTANT VARCHAR2(21) := 'la Creaci?n';
        CSBTOKEN_CHANGE     CONSTANT VARCHAR2(30) := 'el Cambio de Estado';
        CSBTOKEN_ORDER      CONSTANT VARCHAR2(10)  := 'Orden';
        CNUNOBODY_ALERT     CONSTANT NUMBER(5)    := 16902;
        SBMSG               VARCHAR2(100);
        
        NULOGNOTIF          GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE := NULL;
        NUNOTIFID           GE_NOTIFICATION.NOTIFICATION_ID%TYPE := NULL;
        SBOUTTEXT           VARCHAR2(4000);
        SBINPUTDTA          VARCHAR2(1024);
        NUEXTERNAL          NUMBER;
        
        SBNAME              GE_OBJECT.NAME_%TYPE;
        NUOBJECT            GE_OBJECT.OBJECT_ID%TYPE;
        TBFIELDSNOTIF       UT_STRING.TYTB_STRING;
        
        SBCURRENTINSTANCE   GE_BOINSTANCECONTROL.STYSBNAME;
        SBCURRENTGROUP      GE_BOINSTANCECONTROL.STYSBNAME;
        SBCURRENTENTITY     GE_BOINSTANCECONTROL.STYSBNAME;
        SBCURRENTATTRIBUTE  GE_BOINSTANCECONTROL.STYSBNAME;
        BLEXISTINSTANCE     BOOLEAN;
        
    BEGIN
        
        UT_TRACE.TRACE('INICIO ge_bonotifmesgalert.procStaOrderForAlert',7);
        
        RCTIPOTRABAJO := DAOR_TASK_TYPE.FRCGETRECORD(IRCORDEN.TASK_TYPE_ID);
        
        
        IF RCTIPOTRABAJO.NOTIFICABLE = GE_BOCONSTANTS.CSBYES THEN

            
            BLEXISTINSTANCE := GE_BOINSTANCECONTROL.FBLISINITINSTANCECONTROL;
        
            IF BLEXISTINSTANCE THEN
                
                GE_BOINSTANCECONTROL.GETCURRENTDATA
                (
                    SBCURRENTINSTANCE,
                    SBCURRENTGROUP,
                    SBCURRENTENTITY,
                    SBCURRENTATTRIBUTE
                );

            END IF;
        
            
            GE_BOUTILITIES.SETVALUES(GE_BOCONSTANTS.CNUOR_ORDER_ENTITYID, IRCORDEN.ORDER_ID);
        
            
            IF IRCORDEN.ORDER_STATUS_ID = OR_BOCONSTANTS.CNUORDER_STAT_REGISTERED AND INUESTADOINI IS NULL THEN
            
                BLORDCREATE := TRUE;
                
                
                GE_BCNOTIFMESGALERT.GETCREATORDERALERT(IRCORDEN.TASK_TYPE_ID, CNUORDER_CREATED, CNUORDER_ENTY_ID, TBALERTAS);

            ELSE

                BLORDCREATE := FALSE;
            
                
                GE_BCNOTIFMESGALERT.GETGENERICALERT(IRCORDEN.TASK_TYPE_ID, INUESTADOINI, IRCORDEN.ORDER_STATUS_ID, CNUORDER_ENTY_ID, TBALERTAS);
            
            END IF;
            
            GE_BOUTILITIES.DESTROYTABLE(GE_BOCONSTANTS.CNUOR_ORDER_ENTITYID);
            
            IF BLEXISTINSTANCE THEN
                
                GE_BOINSTANCECONTROL.SETCURRENTDATA
                (
                    SBCURRENTINSTANCE,
                    SBCURRENTGROUP,
                    SBCURRENTENTITY,
                    SBCURRENTATTRIBUTE
                );

            END IF;
            
            
            NUINDEX := TBALERTAS.FIRST;
            
            LOOP
                EXIT WHEN NUINDEX IS NULL;

                
                
                BEGIN

                    UT_TRACE.TRACE('Alerta '||TBALERTAS(NUINDEX).MESG_ALERT_ID,7);
                    NUEXTERNAL := TBALERTAS(NUINDEX).MESG_ALERT_ID;
                    NUNOTIFID := TBALERTAS(NUINDEX).NOTIFICATION_ID;
                    
                    NUNOTITYPE := DAGE_NOTIFICATION.FNUGETNOTIFICATION_TYPE_ID
                                  (
                                      NUNOTIFID
                                  );

                    BLCUMPLETIPODANO := FALSE;
                    BLCUMPLECAUSAL   := FALSE;

                    
                    IF TBALERTAS(NUINDEX).TYPE_DAMAGE IS NOT NULL THEN

                        
                        OPEN OR_BCORDERACTIVITIES.CUCORRECTMAINTENORDER(IRCORDEN.ORDER_ID);
                        FETCH OR_BCORDERACTIVITIES.CUCORRECTMAINTENORDER INTO RCACTIVIDADES;
                        CLOSE OR_BCORDERACTIVITIES.CUCORRECTMAINTENORDER;

                        IF RCACTIVIDADES.ORDER_ACTIVITY_ID IS NOT NULL THEN
                            
                            NUTIPODANO := DATT_DAMAGE.FNUGETREG_DAMAGE_TYPE_ID(RCACTIVIDADES.PACKAGE_ID);
                            
                            
                            IF NUTIPODANO = TBALERTAS(NUINDEX).TYPE_DAMAGE THEN
                                BLCUMPLETIPODANO := TRUE;
                            END IF;
                        END IF;
                    ELSE
                        BLCUMPLETIPODANO := TRUE;
                    END IF;

                    
                    IF TBALERTAS(NUINDEX).CAUSAL_LEGALIZATION IS NOT NULL THEN
                        
                        
                        IF IRCORDEN.CAUSAL_ID = TBALERTAS(NUINDEX).CAUSAL_LEGALIZATION THEN
                            BLCUMPLECAUSAL := TRUE;
                        END IF;
                    ELSE
                        BLCUMPLECAUSAL := TRUE;
                    END IF;

                    IF (BLCUMPLETIPODANO) THEN UT_TRACE.TRACE('Cumple Timpo Da?o : TRUE',7); END IF;
                    IF (BLCUMPLECAUSAL) THEN UT_TRACE.TRACE('blCumpleCausal : TRUE',7); END IF;

                    
                    
                    IF BLCUMPLETIPODANO AND BLCUMPLECAUSAL THEN

                        
                        GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER
                        (
                            ISBINPUT,
                            'ORDER_ID',
                            IRCORDEN.ORDER_ID
                        );

                        
                        GE_BOXSLTRANSFORMATION.GETXSLTRANSFORMATION
                        (
                            NUNOTIFID,
                            GE_BOMODULE.GETORDERS,
                            ISBINPUT,
                            OSBTIPOFORMATO,
                            OSBSALIDATEXTO,
                            OSBSALIDACLOB
                        );

                        SBOUTTEXT := OSBSALIDATEXTO;
                        SBINPUTDTA := ISBINPUT;

                        UT_TRACE.TRACE('Mensaje '||SBOUTTEXT,7);

                        
                        NUOBJECT := DAGE_MESG_ALERT.FNUGETOBJECT_ID
                                    (
                                        TBALERTAS(NUINDEX).MESG_ALERT_ID
                                    );
                        UT_TRACE.TRACE('nuObject: ' || NUOBJECT, 1);
                        
                        IF ( NUOBJECT IS NOT NULL ) THEN
                            SBNAME := DAGE_OBJECT.FSBGETNAME_
                            (
                                NUOBJECT
                            );
                        END IF;

                        IF SBNAME IS NOT NULL THEN

                             GE_BONOTIFSERVICES.GTBFIELDSNOTIF.DELETE;
                            
                            EXECUTE IMMEDIATE 'Begin ' || SBNAME || '(:inuOrder); END;' USING IN IRCORDEN.ORDER_ID;

                            TBOPERUNITSNOTIFY := GE_BONOTIFSERVICES.GTBOPERUNITS;
                            TBPERSONSNOTIFY:= GE_BONOTIFSERVICES. GTBPERSONOTIF;
                            TBFIELDSNOTIF := GE_BONOTIFSERVICES.GTBFIELDSNOTIF;
                            
                        END IF;


                        NUIDX := TBOPERUNITSNOTIFY.FIRST;

                        
                        IF NUIDX IS NOT NULL AND NUNOTITYPE = GE_BOCONSTANTS.CNUTYPENOTIFPOPUP THEN
                            
                            LOOP
                                EXIT WHEN NUIDX IS NULL;

                                TBOPERUNITPER.DELETE;
                                
                                OR_BCOPERUNITPERSON.GETPERSONSBYOPEUNI(TBOPERUNITSNOTIFY(NUIDX).OPERATING_UNIT_ID, TBOPERUNITPER);

                                NUAUXIDX := TBOPERUNITPER.FIRST;
                                LOOP
                                    EXIT WHEN NUAUXIDX IS NULL;
                                    SBKEY := TBOPERUNITPER(NUAUXIDX).PERSON_ID||'_'||NUNOTITYPE;
                                    TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBOPERUNITPER(NUAUXIDX).PERSON_ID;
                                    TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NUNOTITYPE;
                                    TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                                    NUAUXIDX := TBOPERUNITPER.NEXT(NUAUXIDX);
                                END LOOP;
                                NUIDX := TBOPERUNITSNOTIFY.NEXT(NUIDX);
                            END LOOP;

                        END IF;

                        
                        NUIDX := TBPERSONSNOTIFY.FIRST;
                        LOOP
                            EXIT WHEN NUIDX IS NULL;
                            SBKEY := TBPERSONSNOTIFY(NUIDX).PERSON_ID||'_'||NUNOTITYPE;
                            TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBPERSONSNOTIFY(NUIDX).PERSON_ID;
                            TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NUNOTITYPE;
                            TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                            NUIDX := TBPERSONSNOTIFY.NEXT(NUIDX);
                        END LOOP;

                        
                        GE_BOFWPARAMETMESGALERT.GETPERSONSNOTIFICATION
                        (
                            TBALERTAS(NUINDEX).MESG_ALERT_ID,
                            IRCORDEN.ORDER_ID,
                            NULL,
                            NUNOTITYPE,
                            TBPERSONEXCEP
                        );

                        
                        SBIDX := TBPERSONEXCEP.FIRST;

                        LOOP
                            EXIT WHEN SBIDX IS NULL;
                            SBKEY := SBIDX||'_'||NVL(TBPERSONEXCEP(SBIDX).NOTIFICATION_TYPE_ID,NUNOTITYPE);
                            
                            IF TBPERSONEXCEP(SBIDX).ACTIVE = GE_BOCONSTANTS.CSBYES THEN

                                
                                IF TBPERSONEXCEP(SBIDX).MATCH THEN
                                
                                    
                                    IF NOT TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                        TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBPERSONEXCEP(SBIDX).PERSON_ID;
                                        TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                                        TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NVL(TBPERSONEXCEP(SBIDX).NOTIFICATION_TYPE_ID,NUNOTITYPE);
                                    END IF;

                                
                                ELSE
                                    
                                    IF TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                        TBPERSNOTIFYGENERIC.DELETE(SBKEY);
                                    END IF;

                                END IF;
                            
                            ELSIF TBPERSONEXCEP(SBIDX).ACTIVE = GE_BOCONSTANTS.CSBNO THEN

                                
                                IF TBPERSONEXCEP(SBIDX).MATCH THEN
                                    
                                    IF TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                        TBPERSNOTIFYGENERIC.DELETE(SBKEY);
                                    END IF;
                                END IF;
                            END IF;

                            SBIDX := TBPERSONEXCEP.NEXT(SBIDX);

                        END LOOP;

                        
                       IF TBPERSNOTIFYGENERIC.COUNT < 1 AND TBFIELDSNOTIF.COUNT < 1 AND
                            ( NUNOTITYPE = GE_BOCONSTANTS.CNUTYPENOTIFPOPUP OR TBOPERUNITSNOTIFY.COUNT < 1 ) THEN


                            IF BLORDCREATE THEN
                                SBMSG := CSBTOKEN_CREATE;
                            ELSE
                                SBMSG := CSBTOKEN_CHANGE;
                            END IF;
                            
                            ERRORS.SETERROR(CNUNOBODY_ALERT, SBMSG||'|'||CSBTOKEN_ORDER||' '||IRCORDEN.ORDER_ID||'|'||TBALERTAS(NUINDEX).MESG_ALERT_ID);
                            RAISE EX.CONTROLLED_ERROR;
                        END IF;

                        
                        IF TBOPERUNITSNOTIFY .COUNT > 0 AND NUNOTITYPE <> GE_BOCONSTANTS.CNUTYPENOTIFPOPUP  THEN

                            NUIDX := TBOPERUNITSNOTIFY.FIRST;

                            LOOP

                                EXIT WHEN NUIDX IS NULL;
                                SBPARAMS := NULL;

                                
                                GE_BONOTIFICATION.SETATTRIBUTE
                                (
                                    SBPARAMS,
                                    'ORDER_ID',
                                    IRCORDEN.ORDER_ID
                                );

                                
                                GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER
                                (
                                    SBPARAMS,
                                    'OPERATING_UNIT_ID',
                                    TBOPERUNITSNOTIFY(NUIDX).OPERATING_UNIT_ID
                                );

                                
                                GE_BONOTIFICATION.SETATTRIBUTE(SBPARAMS,CSBNOTIF_TYPE,NUNOTITYPE);

                                
                                GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                                (
                                    NUNOTIFID,
                                    NUNOTITYPE,
                                    GE_BOMODULE.GETORDERS,
                                    SBPARAMS,
                                    IRCORDEN.ORDER_ID,
                                    OSBSALIDATEXTO,
                                    NUNOTIFICATIONLOG,
                                    NUERROR,
                                    SBERROR
                                );
                                SBINPUTDTA := SBPARAMS;

                                NUIDX := TBOPERUNITSNOTIFY.NEXT(NUIDX);
                            END LOOP;
                        END IF;

                        SBIDX := TBPERSNOTIFYGENERIC.FIRST;

                        
                        LOOP

                            EXIT WHEN SBIDX IS NULL;

                            SBPARAMS := NULL;

                            
                            GE_BONOTIFICATION.SETATTRIBUTE
                            (
                                SBPARAMS,
                                CSBPERSONID,
                                TBPERSNOTIFYGENERIC(SBIDX).PERSON_ID
                            );

                            
                            GE_BONOTIFICATION.SETATTRIBUTE
                            (
                                SBPARAMS,
                                'ORDER_ID',
                                IRCORDEN.ORDER_ID
                            );

                            
                            GE_BONOTIFICATION.SETATTRIBUTE
                            (
                                SBPARAMS,
                                CSBNOTIF_TYPE,
                                TBPERSNOTIFYGENERIC(SBIDX).NOTIFICATION_TYPE_ID
                            );

                            
                            GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                            (
                                NUNOTIFID,
                                TBPERSNOTIFYGENERIC(SBIDX).NOTIFICATION_TYPE_ID,
                                GE_BOMODULE.GETORDERS,
                                SBPARAMS,
                                IRCORDEN.ORDER_ID,
                                OSBSALIDATEXTO,
                                NUNOTIFICATIONLOG,
                                NUERROR,
                                SBERROR
                            );
                            SBINPUTDTA := SBPARAMS;

                            SBIDX := TBPERSNOTIFYGENERIC.NEXT(SBIDX);
                        END LOOP;

                    END IF;
                    
                     

                    SBIDX := TBFIELDSNOTIF.FIRST;

                    LOOP
                        EXIT WHEN SBIDX IS NULL;
                        SBPARAMS := NULL;

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBPARAMS,
                            CSBFIELD,
                            TBFIELDSNOTIF(SBIDX)
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBPARAMS,CSBNOTIF_TYPE,NUNOTITYPE);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBPARAMS,CSBMESG_ALERT,TBALERTAS(NUINDEX).MESG_ALERT_ID);

                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            NUNOTITYPE,
                            GE_BOMODULE.GETORDERS,
                            SBPARAMS,
                            NUEXTERNAL,
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );

                        SBINPUTDTA := SBPARAMS;
                        SBIDX := TBFIELDSNOTIF.NEXT(SBIDX);
                    END LOOP;
                EXCEPTION
                    WHEN EX.CONTROLLED_ERROR THEN
                        ERRORS.GETERROR(NUERROR, SBERROR);
                        SAVELOGNOTIF(NUNOTIFID,NUERROR,SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
                    WHEN OTHERS THEN
                        ERRORS.SETERROR;
                        ERRORS.GETERROR(NUERROR, SBERROR);
                        SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
                END;
                
                
                NUINDEX := TBALERTAS.NEXT(NUINDEX);
                
                TBOPERUNITSNOTIFY.DELETE;
                TBPERSONSNOTIFY.DELETE;
                TBPERSNOTIFYGENERIC.DELETE;
                TBPERSONEXCEP.DELETE;

            END LOOP;
        
        END IF;
        UT_TRACE.TRACE('FIN ge_bonotifmesgalert.procStaOrderForAlert',7);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    
    
    






































    PROCEDURE PROCSTAUNDOPERFORALERT
    (
        IRCOPERUNIT     IN  DAOR_OPERATING_UNIT.STYOR_OPERATING_UNIT,
        INUESTADOINI    IN  OR_OPERATING_UNIT.OPER_UNIT_STATUS_ID%TYPE,
        IDTCHANGEDATE   IN OR_ORDER_STAT_CHANGE.STAT_CHG_DATE%TYPE DEFAULT NULL
    )
    IS
    
        TBALERTAS           DAGE_MESG_ALERT.TYTBGE_MESG_ALERT;
        NUINDEX             NUMBER;
        NUNOTITYPE          GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE;
        ISBINPUT            VARCHAR2(2000);
        OSBSALIDATEXTO      GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE;
        SBPARAMS            VARCHAR2(2000);
        TBOPERUNITSNOTIFY   DAOR_OPERATING_UNIT.TYTBOR_OPERATING_UNIT;
        TBPERSONSNOTIFY     DAGE_PERSON.TYTBGE_PERSON;
        TBPERSNOTIFYGENERIC GE_BOFWPARAMETMESGALERT.TYTBPERSONS;
        TBPERSONEXCEP       GE_BOFWPARAMETMESGALERT.TYTBPERSONS;
        NUNOTIFICATIONLOG   GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;
        NUERROR             GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
        SBERROR             GE_ERROR_LOG.DESCRIPTION%TYPE;
        OSBTIPOFORMATO      GE_NOTIFICATION.FORMAT_TYPE%TYPE;
        OSBSALIDACLOB       GE_NOTIFICATION_LOG.OUTPUT_CLOB%TYPE;
        NUIDX               NUMBER;
        SBIDX               VARCHAR2(20);
        SBKEY               VARCHAR2(20);
        NUAUXIDX            NUMBER;

        TBOPERUNITPER       DAOR_OPER_UNIT_PERSONS.TYTBOR_OPER_UNIT_PERSONS;
        BLORDCREATE         BOOLEAN;
        CSBTOKEN_CREATE     CONSTANT VARCHAR2(11) := 'la Creaci?n';
        CSBTOKEN_CHANGE     CONSTANT VARCHAR2(19) := 'el Cambio de Estado';
        CSBTOKEN_OPER_UNI   CONSTANT VARCHAR2(50)  := 'Unidad de trabajo';
        CNUNOBODY_ALERT     CONSTANT NUMBER(5)    := 16902;
        SBMSG               VARCHAR2(100);

        NULOGNOTIF          GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE := NULL;
        NUNOTIFID           GE_NOTIFICATION.NOTIFICATION_ID%TYPE := NULL;
        SBOUTTEXT           VARCHAR2(4000);
        SBINPUTDTA          VARCHAR2(1024);
        NUEXTERNAL          NUMBER;
    
        SBNAME              GE_OBJECT.NAME_%TYPE;
        NUOBJECT            GE_OBJECT.OBJECT_ID%TYPE;
        TBFIELDSNOTIF       UT_STRING.TYTB_STRING;

        SBCURRENTINSTANCE   GE_BOINSTANCECONTROL.STYSBNAME;
        SBCURRENTGROUP      GE_BOINSTANCECONTROL.STYSBNAME;
        SBCURRENTENTITY     GE_BOINSTANCECONTROL.STYSBNAME;
        SBCURRENTATTRIBUTE  GE_BOINSTANCECONTROL.STYSBNAME;
        BLEXISTINSTANCE     BOOLEAN;

    BEGIN
        
        UT_TRACE.TRACE('INICIO Ge_BoNotifMesgAlert.procStaUndOperForAlert',10);

        IF IRCOPERUNIT.NOTIFICABLE = GE_BOCONSTANTS.CSBYES THEN
        
            
            BLEXISTINSTANCE := GE_BOINSTANCECONTROL.FBLISINITINSTANCECONTROL;
        
            IF BLEXISTINSTANCE THEN
                
                GE_BOINSTANCECONTROL.GETCURRENTDATA
                (
                    SBCURRENTINSTANCE,
                    SBCURRENTGROUP,
                    SBCURRENTENTITY,
                    SBCURRENTATTRIBUTE
                );

            END IF;
        
            
            GE_BOUTILITIES.SETVALUES(GE_BOCONSTANTS.CNUOR_OPERATING_UNIT_ENTITYID, IRCOPERUNIT.OPERATING_UNIT_ID);
        
            GE_BCNOTIFMESGALERT.GETGENERICALERT
            (
                IRCOPERUNIT.OPERATING_UNIT_ID,
                INUESTADOINI,
                IRCOPERUNIT.OPER_UNIT_STATUS_ID,
                CNUOPERUNIT_ENTY_ID,
                TBALERTAS
            );
            
            
            GE_BOUTILITIES.DESTROYTABLE(CNUOPERUNIT_ENTY_ID);
            
            IF BLEXISTINSTANCE THEN
                
                GE_BOINSTANCECONTROL.SETCURRENTDATA
                (
                    SBCURRENTINSTANCE,
                    SBCURRENTGROUP,
                    SBCURRENTENTITY,
                    SBCURRENTATTRIBUTE
                );

            END IF;
            
            
            NUINDEX := TBALERTAS.FIRST;

            LOOP
                EXIT WHEN NUINDEX IS NULL;
                
                
                
                BEGIN
                    NUEXTERNAL := TBALERTAS(NUINDEX).MESG_ALERT_ID;
                    NUNOTIFID := TBALERTAS(NUINDEX).NOTIFICATION_ID;
                    
                    NUNOTITYPE := DAGE_NOTIFICATION.FNUGETNOTIFICATION_TYPE_ID
                                  (
                                      NUNOTIFID
                                  );

                    
                    GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER
                    (
                        ISBINPUT,
                        'OPERATING_UNIT_ID',
                        IRCOPERUNIT.OPERATING_UNIT_ID
                    );

                    
                    GE_BOXSLTRANSFORMATION.GETXSLTRANSFORMATION
                    (
                        TBALERTAS(NUINDEX).NOTIFICATION_ID,
                        GE_BOMODULE.GETORDERS,
                        ISBINPUT,
                        OSBTIPOFORMATO,
                        OSBSALIDATEXTO,
                        OSBSALIDACLOB
                    );

                    SBOUTTEXT := OSBSALIDATEXTO;
                    SBINPUTDTA := ISBINPUT;

                    
                     NUOBJECT := DAGE_MESG_ALERT.FNUGETOBJECT_ID
                                (
                                    TBALERTAS(NUINDEX).MESG_ALERT_ID
                                );
                    UT_TRACE.TRACE('nuObject: ' || NUOBJECT, 1);
                    
                    IF ( NUOBJECT IS NOT NULL ) THEN
                        SBNAME := DAGE_OBJECT.FSBGETNAME_
                        (
                            NUOBJECT
                        );
                    END IF;
                               
                    IF SBNAME IS NOT NULL THEN
                        GE_BONOTIFSERVICES.GTBFIELDSNOTIF.DELETE;
                        
                        EXECUTE IMMEDIATE 'Begin ' || SBNAME || '(:inuOper); END;' USING IN IRCOPERUNIT.OPERATING_UNIT_ID;
                        TBOPERUNITSNOTIFY := GE_BONOTIFSERVICES.GTBOPERUNITS;
                        TBPERSONSNOTIFY := GE_BONOTIFSERVICES. GTBPERSONOTIF;
                        TBFIELDSNOTIF := GE_BONOTIFSERVICES.GTBFIELDSNOTIF;
                    END IF;

                    NUIDX := TBOPERUNITSNOTIFY.FIRST;

                    
                    IF NUIDX IS NOT NULL AND NUNOTITYPE = GE_BOCONSTANTS.CNUTYPENOTIFPOPUP THEN
                        
                        LOOP
                            EXIT WHEN NUIDX IS NULL;
                            
                            TBOPERUNITPER.DELETE;
                            
                            OR_BCOPERUNITPERSON.GETPERSONSBYOPEUNI(TBOPERUNITSNOTIFY(NUIDX).OPERATING_UNIT_ID, TBOPERUNITPER);

                            NUAUXIDX := TBOPERUNITPER.FIRST;
                            LOOP
                                EXIT WHEN NUAUXIDX IS NULL;
                                SBKEY := TBOPERUNITPER(NUAUXIDX).PERSON_ID||'_'||NUNOTITYPE;
                                TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBOPERUNITPER(NUAUXIDX).PERSON_ID;
                                TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NUNOTITYPE;
                                TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                                NUAUXIDX := TBOPERUNITPER.NEXT(NUAUXIDX);
                            END LOOP;
                            NUIDX := TBOPERUNITSNOTIFY.NEXT(NUIDX);
                        END LOOP;
                    END IF;

                    
                    NUIDX := TBPERSONSNOTIFY.FIRST;
                    LOOP
                        EXIT WHEN NUIDX IS NULL;
                        SBKEY := TBPERSONSNOTIFY(NUIDX).PERSON_ID||'_'||NUNOTITYPE;
                        TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBPERSONSNOTIFY(NUIDX).PERSON_ID;
                        TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NUNOTITYPE;
                        TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                        NUIDX := TBPERSONSNOTIFY.NEXT(NUIDX);
                    END LOOP;

                    
                    GE_BOFWPARAMETMESGALERT.GETPERSONSNOTIFICATION
                    (
                        TBALERTAS(NUINDEX).MESG_ALERT_ID,
                        NULL, 
                        IRCOPERUNIT.OPERATING_UNIT_ID, 
                        NUNOTITYPE,
                        TBPERSONEXCEP
                    );

                    
                    SBIDX := TBPERSONEXCEP.FIRST;

                    LOOP
                        EXIT WHEN SBIDX IS NULL;
                        SBKEY := SBIDX||'_'||NVL(TBPERSONEXCEP(SBIDX).NOTIFICATION_TYPE_ID,NUNOTITYPE);
                        
                        IF TBPERSONEXCEP(SBIDX).ACTIVE = GE_BOCONSTANTS.CSBYES THEN

                            
                            IF TBPERSONEXCEP(SBIDX).MATCH THEN

                                
                                IF NOT TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                    TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBPERSONEXCEP(SBIDX).PERSON_ID;
                                    TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                                    TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NVL(TBPERSONEXCEP(SBIDX).NOTIFICATION_TYPE_ID,NUNOTITYPE);
                                END IF;

                            
                            ELSE
                                
                                IF TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                    TBPERSNOTIFYGENERIC.DELETE(SBKEY);
                                END IF;

                            END IF;
                        
                        ELSIF TBPERSONEXCEP(SBIDX).ACTIVE = GE_BOCONSTANTS.CSBNO THEN

                            
                            IF TBPERSONEXCEP(SBIDX).MATCH THEN
                                
                                IF TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                    TBPERSNOTIFYGENERIC.DELETE(SBKEY);
                                END IF;
                            END IF;
                        END IF;

                        SBIDX := TBPERSONEXCEP.NEXT(SBIDX);

                    END LOOP;

                    
                    IF TBPERSNOTIFYGENERIC.COUNT < 1 AND TBFIELDSNOTIF.COUNT < 1 AND
                        ( NUNOTITYPE = GE_BOCONSTANTS.CNUTYPENOTIFPOPUP OR TBOPERUNITSNOTIFY.COUNT < 1 ) THEN

                        IF BLORDCREATE THEN
                            SBMSG := CSBTOKEN_CREATE;
                        ELSE
                            SBMSG := CSBTOKEN_CHANGE;
                        END IF;
                        
                        ERRORS.SETERROR(CNUNOBODY_ALERT, SBMSG||'|'||CSBTOKEN_OPER_UNI||' '||IRCOPERUNIT.OPERATING_UNIT_ID||'|'||TBALERTAS(NUINDEX).MESG_ALERT_ID);
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;

                    
                    IF TBOPERUNITSNOTIFY.COUNT > 0 AND NUNOTITYPE <> GE_BOCONSTANTS.CNUTYPENOTIFPOPUP  THEN
                    
                        NUIDX := TBOPERUNITSNOTIFY.FIRST;

                        LOOP

                            EXIT WHEN NUIDX IS NULL;
                            SBPARAMS := NULL;

                            
                            GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER
                            (
                                SBPARAMS,
                                'OPERATING_UNIT_ID',
                                TBOPERUNITSNOTIFY(NUIDX).OPERATING_UNIT_ID
                            );

                            
                            GE_BONOTIFICATION.SETATTRIBUTE(SBPARAMS,CSBNOTIF_TYPE,NUNOTITYPE);

                            
                            GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                            (
                                NUNOTIFID,
                                NUNOTITYPE,
                                GE_BOMODULE.GETORDERS,
                                SBPARAMS,
                                IRCOPERUNIT.OPERATING_UNIT_ID, 
                                OSBSALIDATEXTO,
                                NUNOTIFICATIONLOG,
                                NUERROR,
                                SBERROR,
                                IDTCHANGEDATE
                            );
                            SBINPUTDTA := SBPARAMS;

                            NUIDX := TBOPERUNITSNOTIFY.NEXT(NUIDX);
                        END LOOP;
                    END IF;

                    SBIDX := TBPERSNOTIFYGENERIC.FIRST;

                    
                    LOOP

                        EXIT WHEN SBIDX IS NULL;

                        SBPARAMS := NULL;

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBPARAMS,
                            CSBPERSONID,
                            TBPERSNOTIFYGENERIC(SBIDX).PERSON_ID
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBPARAMS,
                            CSBNOTIF_TYPE,
                            TBPERSNOTIFYGENERIC(SBIDX).NOTIFICATION_TYPE_ID
                        );

                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            TBPERSNOTIFYGENERIC(SBIDX).NOTIFICATION_TYPE_ID,
                            GE_BOMODULE.GETORDERS,
                            SBPARAMS,
                            IRCOPERUNIT.OPERATING_UNIT_ID,
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );
                        
                        SBINPUTDTA := SBPARAMS;

                        SBIDX := TBPERSNOTIFYGENERIC.NEXT(SBIDX);
                    END LOOP;
                    
                    

                    SBIDX := TBFIELDSNOTIF.FIRST;

                    LOOP
                        EXIT WHEN SBIDX IS NULL;
                        SBPARAMS := NULL;

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBPARAMS,
                            CSBFIELD,
                            TBFIELDSNOTIF(SBIDX)
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBPARAMS,CSBNOTIF_TYPE,NUNOTITYPE);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBPARAMS,CSBMESG_ALERT,TBALERTAS(NUINDEX).MESG_ALERT_ID);

                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            NUNOTITYPE,
                            GE_BOMODULE.GETORDERS,
                            SBPARAMS,
                            NUEXTERNAL,
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );

                        SBINPUTDTA := SBPARAMS;
                        SBIDX := TBFIELDSNOTIF.NEXT(SBIDX);
                    END LOOP;
                EXCEPTION
                    WHEN EX.CONTROLLED_ERROR THEN
                        ERRORS.GETERROR(NUERROR, SBERROR);
                        SAVELOGNOTIF(NUNOTIFID,NUERROR,SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
                    WHEN OTHERS THEN
                        ERRORS.SETERROR;
                        ERRORS.GETERROR(NUERROR, SBERROR);
                        SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
                END;
                
                
                NUINDEX := TBALERTAS.NEXT(NUINDEX);

                
                TBOPERUNITSNOTIFY.DELETE;
                TBPERSONSNOTIFY.DELETE;
                TBPERSNOTIFYGENERIC.DELETE;
                TBPERSONEXCEP.DELETE;

            END LOOP;
        END IF;

        UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.procStaUndOperForAlert',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    

















    FUNCTION FBLWASNOTIFTHIS
    (
        INUEXTERNAL     IN  NUMBER, 
        INUNOTIFID      IN  GE_NOTIFICATION.NOTIFICATION_ID%TYPE,
        ITBPARAMNOTIF   IN  GE_BOINSTANCE.TYTBINSTANCE
    ) RETURN BOOLEAN
    IS
        TBINSTANCE          GE_BOINSTANCE.TYTBINSTANCE;
        TBLOGNOTIF          DAGE_NOTIFICATION_LOG.TYTBGE_NOTIFICATION_LOG;
        SBWHERE             VARCHAR2(2000);

        SBOUTTEXT           VARCHAR2(4000);
        NUOUTVAL            NUMBER;
        NUINDEX_VALUE       NUMBER;
        NUNUMPARAMMATCH     NUMBER; 
        BLEXISTPARAM        BOOLEAN;
        INDXPARM            NUMBER;
        IND                 NUMBER;

    BEGIN
        UT_TRACE.TRACE('INICIO Ge_BoNotifMesgAlert.fblWasNotifThis',10);

        SBWHERE := ' NOTIFICATION_ID = '|| INUNOTIFID;
        SBWHERE := SBWHERE || ' AND ERROR_CODE  = 0 ';
        SBWHERE := SBWHERE || ' AND EXTERNAL_ID = '|| INUEXTERNAL;

        
        
        BEGIN
            DAGE_NOTIFICATION_LOG.GETRECORDS(SBWHERE,TBLOGNOTIF);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR  THEN
                UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.fblWasNotifThis',10);
                RETURN FALSE;
            WHEN OTHERS THEN
                UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.fblWasNotifThis',10);
                RETURN FALSE;
        END;
        
        
        
        
        
        
        IF TBLOGNOTIF.COUNT > 0 THEN
            IND := TBLOGNOTIF.FIRST;
            LOOP
                EXIT WHEN IND IS NULL;
                IF (TBLOGNOTIF(IND).INPUT_DATA IS NOT NULL) THEN
                    GE_BOINSTANCE.STRDEFAULTTOINSTANCE(TBLOGNOTIF(IND).INPUT_DATA,TBINSTANCE);
                    IF ITBPARAMNOTIF.COUNT > 0 THEN
                        NUNUMPARAMMATCH := 0;
                        INDXPARM := ITBPARAMNOTIF.FIRST;
                        LOOP
                          EXIT WHEN INDXPARM IS NULL;
                            
                            BLEXISTPARAM := GE_BOUTILITIES.FBLGETVALUEPARAMETR
                                                (
                                                    TBINSTANCE,
                                                    ITBPARAMNOTIF(INDXPARM).NAME_ATTRIBUTE,
                                                    SBOUTTEXT,
                                                    NUOUTVAL,
                                                    NUINDEX_VALUE
                                                );

                            IF ( BLEXISTPARAM AND SBOUTTEXT = ITBPARAMNOTIF(INDXPARM).VALUE_ ) THEN
                                NUNUMPARAMMATCH := NUNUMPARAMMATCH + 1;
                            END IF;

                            INDXPARM := ITBPARAMNOTIF.NEXT(INDXPARM);
                        END LOOP;
                        
                        
                        IF (NUNUMPARAMMATCH = ITBPARAMNOTIF.COUNT) THEN
                            UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.fblWasNotifThis',10);
                            RETURN TRUE;
                        END IF;
                    ELSE
                        UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.fblWasNotifThis',10);
                        RETURN FALSE;
                    END IF;
                END IF;

                IND := TBLOGNOTIF.NEXT(IND);
            END LOOP;
        END IF;
        UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.fblWasNotifThis',10);
        RETURN FALSE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLWASNOTIFTHIS;
    
    
    
















    PROCEDURE VALIDDATAGNRLALERTTEMP
    (
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE
    )
    IS
        
        RCMESGALERT         DAGE_MESG_ALERT.STYGE_MESG_ALERT;
    BEGIN
        
        UT_TRACE.TRACE('INICIO GE_BONotifMesgAlert.ValidDataGnrlAlertTemp');

        
        IF (NOT DAGE_MESG_ALERT.FBLEXIST(INUMESGALERTID)) THEN
            ERRORS.SETERROR(CNUALERT_NO_PARAM,TO_CHAR(INUMESGALERTID));
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        DAGE_MESG_ALERT.GETRECORD(INUMESGALERTID,RCMESGALERT);

        
        IF (NOT SYSDATE BETWEEN RCMESGALERT.INITIAL_DATE AND RCMESGALERT.FINAL_DATE ) THEN
            ERRORS.SETERROR(CNUALERT_NO_VIGEN,TO_CHAR(INUMESGALERTID));
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        
        IF RCMESGALERT.IS_TEMP_EVENT = OR_BOCONSTANTS.CSBNO THEN
            
            ERRORS.SETERROR(CNUALERT_NO_TEMPO,TO_CHAR(INUMESGALERTID));
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        IF RCMESGALERT.ACTIVE = OR_BOCONSTANTS.CSBNO THEN
            ERRORS.SETERROR(CNUALERT_NO_ACTIV,TO_CHAR(INUMESGALERTID));
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        UT_TRACE.TRACE('FIN GE_BONotifMesgAlert.ValidDataGnrlAlertTemp');
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDDATAGNRLALERTTEMP;


    





















































    PROCEDURE PROCESSNOTIFALERTTEMP
    (
         INUMESGALERTID     IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
         INUSTATEMENTID     IN  GE_STATEMENT.STATEMENT_ID%TYPE,
         INUTIMEREF         IN  NUMBER,
         INUPORCENTTOL      IN  NUMBER,
         ISBLETRENOTIFY     IN  VARCHAR2 DEFAULT 'N'
    )
    IS
        
        

        TBTMPSELECT         GE_BOINSTANCE.TYTBINSTANCE;
        RCMESGALERT         DAGE_MESG_ALERT.STYGE_MESG_ALERT;

        SBINPUT             VARCHAR2(2000);
        TBSELECTINS         TYTBTYSELECT;
        NUINDORDEN          NUMBER;
        NUINDUNOPER         NUMBER;

        NUNOTITYPE          GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE;
        OSBSALIDATEXTO      GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE;
        OSBTIPOFORMATO      GE_NOTIFICATION.FORMAT_TYPE%TYPE;
        OSBSALIDACLOB       GE_NOTIFICATION_LOG.OUTPUT_CLOB%TYPE;
        TBOPERUNITSNOTIFY   DAOR_OPERATING_UNIT.TYTBOR_OPERATING_UNIT;
        TBPERSONSNOTIFY     DAGE_PERSON.TYTBGE_PERSON;
        TBPERSNOTIFYGENERIC GE_BOFWPARAMETMESGALERT.TYTBPERSONS;
        TBPERSONEXCEP       GE_BOFWPARAMETMESGALERT.TYTBPERSONS;

        NUNOTIFICATIONLOG   GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;

        NUORDER_ID          NUMBER;
        NUOPERUNIT          NUMBER;
        SBORDERID           VARCHAR2(50);
        SBOPERUNIT          VARCHAR2(50);
        NUOPERUNITEXOR      NUMBER; 

        NUIDX               NUMBER;
        SBIDX               VARCHAR2(20);
        SBKEY               VARCHAR2(20);
        NUAUXIDX            NUMBER;
        TBOPERUNITPER       DAOR_OPER_UNIT_PERSONS.TYTBOR_OPER_UNIT_PERSONS;
        TBPARAMETERS        GE_BOINSTANCE.TYTBINSTANCE;

        SBATRIBUTORDER      VARCHAR2(40) := 'ORDER_ID';
        SBATRIBUTUNIOPER    VARCHAR2(40) := 'OPERATING_UNIT_ID';
        NUERROR             GE_ERROR_LOG.ERROR_LOG_ID%TYPE := GE_BOCONSTANTS.CNUSUCCESS;
        SBERROR             GE_ERROR_LOG.DESCRIPTION%TYPE := GE_BOCONSTANTS.CSBNOMESSAGE;
        CSBTOKEN_ORD_OPERU  VARCHAR2(50) := '';
        CSBTOKEN_ORDER      CONSTANT VARCHAR2(10)  := 'Orden';
        CSBTOKEN_OPER_UNI   CONSTANT VARCHAR2(50)  := 'Unidad de trabajo';
        CNUNOBODY_ALERT     CONSTANT NUMBER(15)    := 16902;
        SBMSG               VARCHAR2(20) := 'el evento';

        NULOGNOTIF          GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE := NULL;
        NUNOTIFID           GE_NOTIFICATION.NOTIFICATION_ID%TYPE := NULL;
        NUCLASSNOTIF        GE_NOTIFICATION.NOTIFICATION_CLASS_ID%TYPE;
        SBPARAMETERS        GE_NOTIFICATION.PARAMETERS%TYPE;
        NUENTITYID          GE_ENTITY.ENTITY_ID%TYPE;
        NUINDEX_VALUE       NUMBER;
        BLEXISTPARAM        BOOLEAN;
        
        SBOUTTEXT           VARCHAR2(4000);
        SBINPUTDTA          VARCHAR2(1024);
        NUEXTERNAL          NUMBER := INUMESGALERTID;
        
        SBNAME              GE_OBJECT.NAME_%TYPE;
        NUOBJECT            GE_OBJECT.OBJECT_ID%TYPE;
        NUPARAM             NUMBER;
        TBFIELDSNOTIF       UT_STRING.TYTB_STRING;
        CSBSI               CONSTANT VARCHAR2(1) := 'S';

    BEGIN
        
        UT_TRACE.TRACE('INICIO Ge_BoNotifMesgAlert.processNotifAlertTemp',10);

        
        
        
        
        VALIDDATAGNRLALERTTEMP(INUMESGALERTID);
        

        
        
        DAGE_MESG_ALERT.GETRECORD(INUMESGALERTID,RCMESGALERT);
        
        NUNOTIFID := RCMESGALERT.NOTIFICATION_ID;
        NUNOTITYPE := DAGE_NOTIFICATION.FNUGETNOTIFICATION_TYPE_ID(NUNOTIFID);      
        NUCLASSNOTIF := DAGE_NOTIFICATION.FNUGETNOTIFICATION_CLASS_ID(NUNOTIFID);   
        SBPARAMETERS := DAGE_NOTIFICATION.FSBGETPARAMETERS(NUNOTIFID);              

        
        IF (SBPARAMETERS IS NULL) THEN
            ERRORS.SETERROR(CNUNOTIF_WRONG_CONF,NUNOTIFID);
            NUEXTERNAL := NUNOTIFID;
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        STRINGTOTBPARAMETRS(SBPARAMETERS,TBPARAMETERS);
        BLEXISTPARAM := GE_BOUTILITIES.FBLGETVALUEPARAMETR( TBPARAMETERS,
                                                            GE_BOCONSTANTS.CSBENTITY_ID_PARAM,
                                                            SBOUTTEXT,
                                                            NUENTITYID,
                                                            NUINDEX_VALUE
                                                          );

        
        IF (NOT BLEXISTPARAM)THEN
            ERRORS.SETERROR(CNUNOTIF_WRONG_CONF,NUNOTIFID);
            NUEXTERNAL := NUNOTIFID;
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        
        
        
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,'TiempoReferencia',INUTIMEREF);
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,'porcentajeTolerancia',INUPORCENTTOL);

        SBINPUTDTA := SBINPUT;

        
        IF (NOT FBLPROCESSSTATEMENT(INUSTATEMENTID,SBINPUT,TBSELECTINS) ) THEN
            RETURN;
        END IF;

        
        
        
        
        
        IF (NOT FBLFINDATTRORDORUOPER(TBSELECTINS,NUINDORDEN,NUINDUNOPER)) THEN
            ERRORS.SETERROR(14061,TO_CHAR(INUSTATEMENTID));
            NUEXTERNAL :=INUSTATEMENTID;
            RAISE EX.CONTROLLED_ERROR;
            
        END IF;

        
        IF ( NUENTITYID = CNUOPERUNIT_ENTY_ID AND NUINDUNOPER IS NULL ) THEN
            
            
            ERRORS.SETERROR(18363,'Unidades de Trabajo');
            RAISE EX.CONTROLLED_ERROR;
        ELSIF ( NUENTITYID = CNUORDER_ENTY_ID AND NUINDORDEN IS NULL ) THEN
            
            ERRORS.SETERROR(18363,'Ordenes');
            RAISE EX.CONTROLLED_ERROR;
        END IF;


        
        
        FOR N IN TBSELECTINS.FIRST .. TBSELECTINS.LAST LOOP
            TBTMPSELECT := TBSELECTINS(N);

            
            
            BEGIN

                NUORDER_ID  := NULL;
                NUOPERUNIT  := NULL;
                NUOPERUNITEXOR := NULL;
                SBORDERID   := '';
                SBOPERUNIT  := '';
                SBINPUT     := '';

                IF (NUENTITYID = CNUOPERUNIT_ENTY_ID ) THEN
                    NUOPERUNIT  := TBTMPSELECT(NUINDUNOPER).VALUE_;
                    SBOPERUNIT  := TBTMPSELECT(NUINDUNOPER).NAME_ATTRIBUTE;
                    NUOPERUNITEXOR := NUOPERUNIT;
                END IF;

                IF (NUENTITYID = CNUORDER_ENTY_ID) THEN
                    NUORDER_ID  := TBTMPSELECT(NUINDORDEN).VALUE_;
                    SBORDERID   := TBTMPSELECT(NUINDORDEN).NAME_ATTRIBUTE;
                    NUOPERUNITEXOR := NULL; 
                END IF;

                NUEXTERNAL :=NVL(NUORDER_ID,NUOPERUNIT);

                SBPARAMETERS := CSBMESG_ALERT||'='||INUMESGALERTID||';'||CSBSTATEMENT||'='||INUSTATEMENTID||';';
                STRINGTOTBPARAMETRS(SBPARAMETERS,TBPARAMETERS);
                
                IF (UPPER(ISBLETRENOTIFY) = CSBSI OR
                    NOT FBLWASNOTIFTHIS(NUEXTERNAL,NUNOTIFID,TBPARAMETERS)) THEN

                    
                    
                    
                    
                    IF (NUENTITYID = CNUORDER_ENTY_ID ) THEN
                        
                        GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER (SBINPUT,SBATRIBUTORDER,NUORDER_ID);
                    ELSIF (NUENTITYID = CNUOPERUNIT_ENTY_ID) THEN
                        
                        GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER(SBINPUT,SBATRIBUTUNIOPER,NUOPERUNIT);
                    END IF;


                    
                    GE_BOXSLTRANSFORMATION.GETXSLTRANSFORMATION
                    (
                        NUNOTIFID,
                        GE_BOMODULE.GETORDERS,
                        SBINPUT,
                        OSBTIPOFORMATO,
                        OSBSALIDATEXTO,
                        OSBSALIDACLOB
                    );

                    SBOUTTEXT := OSBSALIDATEXTO;
                    SBINPUTDTA := SBINPUT;

                    
                    
                    

                    IF NUOPERUNITEXOR IS NULL THEN
                        CSBTOKEN_ORD_OPERU   := CSBTOKEN_ORDER;
                        NUPARAM := NUORDER_ID;
                    ELSE
                        CSBTOKEN_ORD_OPERU   := CSBTOKEN_OPER_UNI;
                        NUPARAM := NUOPERUNITEXOR;
                    END IF;

                    
                    NUOBJECT := DAGE_MESG_ALERT.FNUGETOBJECT_ID
                                (
                                    INUMESGALERTID
                                );
                    UT_TRACE.TRACE('nuObject: ' || NUOBJECT, 1);
                    
                    IF ( NUOBJECT IS NOT NULL ) THEN
                        SBNAME := DAGE_OBJECT.FSBGETNAME_
                        (
                            NUOBJECT
                        );
                    END IF;
                    IF SBNAME IS NOT NULL THEN
                        GE_BONOTIFSERVICES.GTBFIELDSNOTIF.DELETE;
                        
                        EXECUTE IMMEDIATE 'Begin ' || SBNAME || '(:nuParam); END;' USING IN NUPARAM;

                        TBOPERUNITSNOTIFY := GE_BONOTIFSERVICES.GTBOPERUNITS;
                        TBPERSONSNOTIFY:= GE_BONOTIFSERVICES.GTBPERSONOTIF;
                        TBFIELDSNOTIF := GE_BONOTIFSERVICES.GTBFIELDSNOTIF;
                    END IF;

                    NUIDX := TBOPERUNITSNOTIFY.FIRST;

                    
                    IF NUIDX IS NOT NULL AND NUNOTITYPE = GE_BOCONSTANTS.CNUTYPENOTIFPOPUP THEN
                        
                        LOOP
                            EXIT WHEN NUIDX IS NULL;

                            TBOPERUNITPER.DELETE;
                            
                            OR_BCOPERUNITPERSON.GETPERSONSBYOPEUNI(TBOPERUNITSNOTIFY(NUIDX).OPERATING_UNIT_ID, TBOPERUNITPER);

                            NUAUXIDX := TBOPERUNITPER.FIRST;
                            LOOP
                                EXIT WHEN NUAUXIDX IS NULL;
                                SBKEY := TBOPERUNITPER(NUAUXIDX).PERSON_ID||'_'||NUNOTITYPE;
                                TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBOPERUNITPER(NUAUXIDX).PERSON_ID;
                                TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NUNOTITYPE;
                                TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                                NUAUXIDX := TBOPERUNITPER.NEXT(NUAUXIDX);
                            END LOOP;
                            NUIDX := TBOPERUNITSNOTIFY.NEXT(NUIDX);
                        END LOOP;

                    END IF;

                    
                    NUIDX := TBPERSONSNOTIFY.FIRST;
                    LOOP
                        EXIT WHEN NUIDX IS NULL;
                        SBKEY := TBPERSONSNOTIFY(NUIDX).PERSON_ID||'_'||NUNOTITYPE;
                        TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBPERSONSNOTIFY(NUIDX).PERSON_ID;
                        TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NUNOTITYPE;
                        TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                        NUIDX := TBPERSONSNOTIFY.NEXT(NUIDX);
                    END LOOP;

                    
                    GE_BOFWPARAMETMESGALERT.GETPERSONSNOTIFICATION
                    (
                        INUMESGALERTID,
                        NUORDER_ID,
                        NUOPERUNITEXOR,
                        NUNOTITYPE,
                        TBPERSONEXCEP
                    );

                    
                    SBIDX := TBPERSONEXCEP.FIRST;

                    LOOP
                        EXIT WHEN SBIDX IS NULL;
                        SBKEY := SBIDX||'_'||NVL(TBPERSONEXCEP(SBIDX).NOTIFICATION_TYPE_ID,NUNOTITYPE);
                        
                        IF TBPERSONEXCEP(SBIDX).ACTIVE = GE_BOCONSTANTS.CSBYES THEN

                            
                            IF TBPERSONEXCEP(SBIDX).MATCH THEN

                                
                                IF NOT TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                    TBPERSNOTIFYGENERIC(SBKEY).PERSON_ID := TBPERSONEXCEP(SBIDX).PERSON_ID;
                                    TBPERSNOTIFYGENERIC(SBKEY).ACTIVE := GE_BOCONSTANTS.CSBYES;
                                    TBPERSNOTIFYGENERIC(SBKEY).NOTIFICATION_TYPE_ID := NVL(TBPERSONEXCEP(SBIDX).NOTIFICATION_TYPE_ID,NUNOTITYPE);
                                END IF;

                            
                            ELSE
                                
                                IF TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                    TBPERSNOTIFYGENERIC.DELETE(SBKEY);
                                END IF;
                            END IF;
                        
                        ELSIF TBPERSONEXCEP(SBIDX).ACTIVE = GE_BOCONSTANTS.CSBNO THEN

                            
                            IF TBPERSONEXCEP(SBIDX).MATCH THEN
                                
                                IF TBPERSNOTIFYGENERIC.EXISTS(SBKEY) THEN
                                    TBPERSNOTIFYGENERIC.DELETE(SBKEY);
                                END IF;
                            END IF;
                        END IF;

                        SBIDX := TBPERSONEXCEP.NEXT(SBIDX);

                    END LOOP;

                    
                    IF TBPERSNOTIFYGENERIC.COUNT < 1 AND TBFIELDSNOTIF.COUNT < 1 AND
                        ( NUNOTITYPE = GE_BOCONSTANTS.CNUTYPENOTIFPOPUP OR TBOPERUNITSNOTIFY.COUNT < 1 ) THEN
                        
                        ERRORS.SETERROR(CNUNOBODY_ALERT, SBMSG||'|'||CSBTOKEN_ORD_OPERU||' '||NVL(NUORDER_ID,NUOPERUNITEXOR)||'|'||INUMESGALERTID);
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;


                    
                    
                    
                    
                    
                    IF TBOPERUNITSNOTIFY .COUNT > 0 AND NUNOTITYPE <> GE_BOCONSTANTS.CNUTYPENOTIFPOPUP  THEN

                        NUIDX := TBOPERUNITSNOTIFY.FIRST;

                        LOOP
                            EXIT WHEN NUIDX IS NULL;
                            SBINPUT := NULL;

                            
                            GE_BONOTIFICATION.SETATTRIBUTE( SBINPUT,
                                                            SBATRIBUTUNIOPER,
                                                            TBOPERUNITSNOTIFY(NUIDX).OPERATING_UNIT_ID
                                                          );

                            
                            GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBNOTIF_TYPE,NUNOTITYPE);
                            
                            GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBMESG_ALERT,INUMESGALERTID);
                            
                            GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBSTATEMENT,INUSTATEMENTID);

                            
                            GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                            (
                                NUNOTIFID,
                                NUNOTITYPE,
                                GE_BOMODULE.GETORDERS,
                                SBINPUT,
                                NVL(NUORDER_ID,NUOPERUNITEXOR),
                                OSBSALIDATEXTO,
                                NUNOTIFICATIONLOG,
                                NUERROR,
                                SBERROR
                            );
                            SBINPUTDTA := SBINPUT;
                            NUIDX := TBOPERUNITSNOTIFY.NEXT(NUIDX);
                        END LOOP;
                    END IF;

                    
                    
                    
                    SBIDX := TBPERSNOTIFYGENERIC.FIRST;

                    
                    LOOP
                        EXIT WHEN SBIDX IS NULL;

                        SBINPUT := NULL;
                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBINPUT,
                            CSBPERSONID,
                            TBPERSNOTIFYGENERIC(SBIDX).PERSON_ID
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBINPUT,
                            CSBNOTIF_TYPE,
                            TBPERSNOTIFYGENERIC(SBIDX).NOTIFICATION_TYPE_ID
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBMESG_ALERT,INUMESGALERTID);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBSTATEMENT,INUSTATEMENTID);

                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            TBPERSNOTIFYGENERIC(SBIDX).NOTIFICATION_TYPE_ID,
                            GE_BOMODULE.GETORDERS,
                            SBINPUT,
                            NVL(NUORDER_ID,NUOPERUNITEXOR),
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );

                        SBINPUTDTA := SBINPUT;

                        SBIDX := TBPERSNOTIFYGENERIC.NEXT(SBIDX);
                    END LOOP;
                    
                    

                    SBIDX := TBFIELDSNOTIF.FIRST;

                    LOOP
                        EXIT WHEN SBIDX IS NULL;
                        SBINPUT := NULL;

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBINPUT,
                            CSBFIELD,
                            TBFIELDSNOTIF(SBIDX)
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBNOTIF_TYPE,NUNOTITYPE);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBMESG_ALERT,INUMESGALERTID);

                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            NUNOTITYPE,
                            GE_BOMODULE.GETORDERS,
                            SBINPUT,
                            NUEXTERNAL,
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );

                        SBINPUTDTA := SBINPUT;
                        SBIDX := TBFIELDSNOTIF.NEXT(SBIDX);
                    END LOOP;
                END IF; 
            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    ERRORS.GETERROR(NUERROR, SBERROR);
                    SAVELOGNOTIF(NUNOTIFID,NUERROR,SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    ERRORS.GETERROR(NUERROR, SBERROR);
                    SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
            END;
            

            
            TBOPERUNITSNOTIFY.DELETE;
            TBPERSONSNOTIFY.DELETE;
            TBPERSNOTIFYGENERIC.DELETE;
            TBPERSONEXCEP.DELETE;

        END LOOP;

        UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.processNotifAlertTemp',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(NUERROR, SBERROR);
            SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(NUERROR, SBERROR);
            SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
            RAISE EX.CONTROLLED_ERROR;
    END PROCESSNOTIFALERTTEMP;

    























    FUNCTION FBOFINDPACKAGE
    (
        ITBREGSELECT    IN  TYTBTYSELECT,
        ONUIDXPACKAGE   OUT BINARY_INTEGER
    )
    RETURN BOOLEAN
    IS
        
        
        
        TBATTRIBUTES    GE_BOINSTANCE.TYTBINSTANCE;
    BEGIN

        UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.fboFindPackage', 15 );

        
        TBATTRIBUTES := ITBREGSELECT(1);

        
        FOR NUIDX IN TBATTRIBUTES.FIRST .. TBATTRIBUTES.LAST LOOP

            
            IF ( TBATTRIBUTES(NUIDX).NAME_ATTRIBUTE =
                 MO_BOCONSTANTS.CSBPACKAGE_ID )
            THEN

                
                ONUIDXPACKAGE := NUIDX;
                RETURN TRUE;

            END IF;

        END LOOP;

        UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.fboFindPackage', 15 );
        RETURN FALSE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBOFINDPACKAGE;

    

























    PROCEDURE NOTIFYPERSON
    (
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        INUNOTIFID      IN  GE_NOTIFICATION.NOTIFICATION_ID%TYPE,
        INUPACKAGE      IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ISBTEXT         IN  GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE,
        INUPERSON       IN  GE_PERSON.PERSON_ID%TYPE,
        INUNOTITYPE     IN  GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE,
        OSBINPUTDTA     OUT VARCHAR2
    )
    IS
        
        
        
        SBINPUT     VARCHAR2(2000);
        NUNOTIFLOG  GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;
        NUERROR     GE_ERROR_LOG.ERROR_LOG_ID%TYPE := GE_BOCONSTANTS.CNUSUCCESS;
        SBERROR     GE_ERROR_LOG.DESCRIPTION%TYPE := GE_BOCONSTANTS.CSBNOMESSAGE;
    BEGIN

        UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.NotifyPerson', 15 );

        UT_TRACE.TRACE( 'Persona que se notificar?: '||INUPERSON, 3 );
        
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT, CSBPERSONID, INUPERSON );
        
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBNOTIF_TYPE,INUNOTITYPE );
        
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBMESG_ALERT,INUMESGALERTID );
        
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBSTATEMENT,INUSTATEMENTID );
        

        
        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS( INUNOTIFID,
                                                    INUNOTITYPE,
                                                    DAGE_NOTIFICATION.FNUGETORIGIN_MODULE_ID(INUNOTIFID),
                                                    SBINPUT,
                                                    INUPACKAGE,
                                                    ISBTEXT,
                                                    NUNOTIFLOG,
                                                    NUERROR,
                                                    SBERROR );
        OSBINPUTDTA := SBINPUT;

        UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.NotifyPerson', 15 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END NOTIFYPERSON;

    



























    PROCEDURE NOTIFYPACKAGE
    (
        INUPACKAGE      IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUCLASSNOTIF   IN  GE_NOTIFICATION.NOTIFICATION_CLASS_ID%TYPE,
        INUNOTITYPE     IN  GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE,
        INUNOTIFID      IN  GE_NOTIFICATION.NOTIFICATION_ID%TYPE,
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        OSBTEXTRESULT   OUT GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE,
        OSBINPUTDTA     OUT VARCHAR2
    )
    IS
        
        
        
        CNUNO_PERS_NOTIFY   CONSTANT GE_ERROR_LOG.ERROR_LOG_ID%TYPE := 14063;
        
        
        
        NUIDX               BINARY_INTEGER;
        SBINPUT             VARCHAR2(2000);
        SBFORMATTYPE        GE_NOTIFICATION.FORMAT_TYPE%TYPE;
        CLCLOBRESULT        GE_NOTIFICATION_LOG.OUTPUT_CLOB%TYPE;
        TBPERSONSNOTIFY     DAGE_PERSON.TYTBGE_PERSON;
        SBNAME              GE_OBJECT.NAME_%TYPE;
        NUOBJECT            GE_OBJECT.OBJECT_ID%TYPE;
    BEGIN

        UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.NotifyPackage', 15 );
        
        
        GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER( SBINPUT,
                                                   MO_BOCONSTANTS.CSBPACKAGE_ID,
                                                   INUPACKAGE );

        
        GE_BOXSLTRANSFORMATION.GETXSLTRANSFORMATION( INUNOTIFID,
                                                     DAGE_NOTIFICATION.FNUGETORIGIN_MODULE_ID(INUNOTIFID),
                                                     SBINPUT,
                                                     SBFORMATTYPE,
                                                     OSBTEXTRESULT,
                                                     CLCLOBRESULT );
        OSBINPUTDTA := SBINPUT;

        
        NUOBJECT := DAGE_MESG_ALERT.FNUGETOBJECT_ID
                    (
                        INUMESGALERTID
                    );
        UT_TRACE.TRACE('nuObject: ' || NUOBJECT, 1);
        
        IF ( NUOBJECT IS NOT NULL ) THEN
            SBNAME := DAGE_OBJECT.FSBGETNAME_
            (
                NUOBJECT
            );
        END IF;


        IF SBNAME IS NOT NULL THEN
            
            EXECUTE IMMEDIATE 'Begin ' || SBNAME || '(:inuPackage); END;' USING IN INUPACKAGE;
            TBPERSONSNOTIFY := GE_BONOTIFSERVICES.GTBPERSONOTIF;
        END IF;


        UT_TRACE.TRACE( 'Personas que se notificar?n: '||TBPERSONSNOTIFY.COUNT, 3 );
        
        IF ( TBPERSONSNOTIFY.COUNT = 0 ) THEN

            
            ERRORS.SETERROR( CNUNO_PERS_NOTIFY );
            RAISE EX.CONTROLLED_ERROR;

        END IF;

        NUIDX := TBPERSONSNOTIFY.FIRST;

        
        WHILE NUIDX IS NOT NULL LOOP

            
            NOTIFYPERSON( INUMESGALERTID,
                          INUSTATEMENTID,
                          INUNOTIFID,
                          INUPACKAGE,
                          OSBTEXTRESULT,
                          TBPERSONSNOTIFY(NUIDX).PERSON_ID,
                          INUNOTITYPE,
                          OSBINPUTDTA );

            NUIDX := TBPERSONSNOTIFY.NEXT(NUIDX);

        END LOOP;

        UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.NotifyPackage', 15 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END NOTIFYPACKAGE;

    




















    PROCEDURE SENDPACKATTREMINALERT
    (
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        INUHOURSBEFORE  IN  NUMBER
    )
    IS
        
        
        
        
        
        
        SBINPUTDTA      VARCHAR2(1024);
        SBVARIABLES     VARCHAR2(2000);
        TBSELECTINS     TYTBTYSELECT;
        NUIDXPACKAGE    BINARY_INTEGER;
        RCMESGALERT     DAGE_MESG_ALERT.STYGE_MESG_ALERT;
        TBTMPSELECT     GE_BOINSTANCE.TYTBINSTANCE;
        RCPACKAGE       DAMO_PACKAGES.STYMO_PACKAGES;
        SBTEXTRESULT    GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE;
        NUNOTITYPE      GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE;
        NUERROR         GE_ERROR_LOG.ERROR_LOG_ID%TYPE := GE_BOCONSTANTS.CNUSUCCESS;
        SBERROR         GE_ERROR_LOG.DESCRIPTION%TYPE := GE_BOCONSTANTS.CSBNOMESSAGE;
        NULOGNOTIF      GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;
        NUNOTIFID       GE_NOTIFICATION.NOTIFICATION_ID%TYPE;
        NUCLASSNOTIF    GE_NOTIFICATION.NOTIFICATION_CLASS_ID%TYPE;
        NUPACKAGE       MO_PACKAGES.PACKAGE_ID%TYPE;
        
        
        
        PROCEDURE VALINPUTDATA
        IS
            CSBHOURS_BEFORE CONSTANT VARCHAR2(20) := 'Horas Antes';
        BEGIN
        
            UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.SendPackAttReminAlert.ValInputData', 16 );

            
            VALIDDATAGNRLALERTTEMP(INUMESGALERTID);

            
            DAGE_MESG_ALERT.GETRECORD(INUMESGALERTID,RCMESGALERT);

            
            IF ( INUHOURSBEFORE IS NULL ) THEN

                
                ERRORS.SETERROR( CNUATTRIB_NULL, CSBHOURS_BEFORE );
                RAISE EX.CONTROLLED_ERROR;

            END IF;

            UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.SendPackAttReminAlert.ValInputData', 16 );
            
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALINPUTDATA;
        
    BEGIN

        UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.SendPackAttReminAlert', 15 );

        
        VALINPUTDATA;

        NUNOTIFID := RCMESGALERT.NOTIFICATION_ID;

        
        GE_BONOTIFICATION.SETATTRIBUTE( SBVARIABLES, 'HorasAntes', INUHOURSBEFORE );

        
        IF ( NOT FBLPROCESSSTATEMENT( INUSTATEMENTID, SBVARIABLES, TBSELECTINS ) )
        THEN
            RETURN;
        END IF;

        
        IF ( NOT FBOFINDPACKAGE( TBSELECTINS, NUIDXPACKAGE ) ) THEN

            
            NUPACKAGE := INUSTATEMENTID;
            
            
            ERRORS.SETERROR( CNUATTRIB_NO_EXISTS,
                             MO_BOCONSTANTS.CSBPACKAGE_ID||'|'||INUSTATEMENTID );
            RAISE EX.CONTROLLED_ERROR;

        END IF;

        
        NUNOTITYPE := DAGE_NOTIFICATION.FNUGETNOTIFICATION_TYPE_ID( NUNOTIFID );
        NUCLASSNOTIF := DAGE_NOTIFICATION.FNUGETNOTIFICATION_CLASS_ID( NUNOTIFID );

        UT_TRACE.TRACE( 'Se encontr? registros a notificar cant: '||TBSELECTINS.COUNT, 10 );

        
        FOR NUIDXREC IN TBSELECTINS.FIRST .. TBSELECTINS.LAST LOOP

            
            TBTMPSELECT := TBSELECTINS( NUIDXREC );

            
            BEGIN

                
                NUPACKAGE := TBTMPSELECT( NUIDXPACKAGE ).VALUE_;

                
                RCPACKAGE := DAMO_PACKAGES.FRCGETRCDATA( NUPACKAGE );

                
                
                
                IF ( SYSDATE BETWEEN ( RCPACKAGE.EXPECT_ATTEN_DATE -
                    (INUHOURSBEFORE/24) ) AND RCPACKAGE.EXPECT_ATTEN_DATE )
                THEN

                    
                    NOTIFYPACKAGE( NUPACKAGE,
                                   NUCLASSNOTIF,
                                   NUNOTITYPE,
                                   NUNOTIFID,
                                   INUMESGALERTID,
                                   INUSTATEMENTID,
                                   SBTEXTRESULT,
                                   SBINPUTDTA );
                    
                END IF;

            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    ERRORS.GETERROR( NUERROR, SBERROR );
                    SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    ERRORS.GETERROR( NUERROR, SBERROR );
                    SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
            END;

        END LOOP;

        UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.SendPackAttReminAlert', 15 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR( NUERROR, SBERROR );
            SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR( NUERROR, SBERROR );
            SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
            RAISE EX.CONTROLLED_ERROR;
    END SENDPACKATTREMINALERT;

    




















    PROCEDURE SENDPACKATTEXPIRALERT
    (
        INUMESGALERTID  IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
        INUSTATEMENTID  IN  GE_STATEMENT.STATEMENT_ID%TYPE,
        INUHOURSAFTER   IN  NUMBER
    )
    IS
        
        
        
        SBINPUTDTA          VARCHAR2(1024);
        SBVARIABLES         VARCHAR2(2000);
        TBSELECTINS         TYTBTYSELECT;
        NUIDXPACKAGE        BINARY_INTEGER;
        RCMESGALERT         DAGE_MESG_ALERT.STYGE_MESG_ALERT;
        TBTMPSELECT         GE_BOINSTANCE.TYTBINSTANCE;
        RCPACKAGE           DAMO_PACKAGES.STYMO_PACKAGES;
        SBTEXTRESULT        GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE;
        NUNOTITYPE          GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE;
        NUERROR             GE_ERROR_LOG.ERROR_LOG_ID%TYPE := GE_BOCONSTANTS.CNUSUCCESS;
        SBERROR             GE_ERROR_LOG.DESCRIPTION%TYPE := GE_BOCONSTANTS.CSBNOMESSAGE;
        NULOGNOTIF          GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;
        NUNOTIFID           GE_NOTIFICATION.NOTIFICATION_ID%TYPE;
        NUCLASSNOTIF        GE_NOTIFICATION.NOTIFICATION_CLASS_ID%TYPE;
        NUPACKAGE           MO_PACKAGES.PACKAGE_ID%TYPE;
        
        
        
        PROCEDURE VALINPUTDATA
        IS
            CSBHOURS_AFTER  CONSTANT VARCHAR2(20) := 'Horas Despu?s';
        BEGIN

            UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.SendPackAttExpirAlert.ValInputData', 16 );

            
            VALIDDATAGNRLALERTTEMP(INUMESGALERTID);

            
            DAGE_MESG_ALERT.GETRECORD(INUMESGALERTID,RCMESGALERT);

            
            IF ( INUHOURSAFTER IS NULL ) THEN

                
                ERRORS.SETERROR( CNUATTRIB_NULL, CSBHOURS_AFTER );
                RAISE EX.CONTROLLED_ERROR;

            END IF;

            UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.SendPackAttExpirAlert.ValInputData', 16 );

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALINPUTDATA;
        
    BEGIN

        UT_TRACE.TRACE( 'Ge_BONotifMesgAlert.SendPackAttExpirAlert', 15 );

        
        VALINPUTDATA;

        NUNOTIFID := RCMESGALERT.NOTIFICATION_ID;

        
        GE_BONOTIFICATION.SETATTRIBUTE( SBVARIABLES, 'HorasDespues', INUHOURSAFTER );

        
        IF ( NOT FBLPROCESSSTATEMENT( INUSTATEMENTID, SBVARIABLES, TBSELECTINS ) )
        THEN
            RETURN;
        END IF;

        
        IF ( NOT FBOFINDPACKAGE( TBSELECTINS, NUIDXPACKAGE ) ) THEN

            
            NUPACKAGE := INUSTATEMENTID;

            
            ERRORS.SETERROR( CNUATTRIB_NO_EXISTS,
                             MO_BOCONSTANTS.CSBPACKAGE_ID||'|'||INUSTATEMENTID );
            RAISE EX.CONTROLLED_ERROR;

        END IF;

        
        NUNOTITYPE := DAGE_NOTIFICATION.FNUGETNOTIFICATION_TYPE_ID( NUNOTIFID );
        NUCLASSNOTIF := DAGE_NOTIFICATION.FNUGETNOTIFICATION_CLASS_ID( NUNOTIFID );

        UT_TRACE.TRACE( 'Se encontr? registros a notificar cant: '||TBSELECTINS.COUNT, 10 );

        
        FOR NUIDXREC IN TBSELECTINS.FIRST .. TBSELECTINS.LAST LOOP

            
            TBTMPSELECT := TBSELECTINS( NUIDXREC );

            
            BEGIN

                
                NUPACKAGE := TBTMPSELECT( NUIDXPACKAGE ).VALUE_;

                
                RCPACKAGE := DAMO_PACKAGES.FRCGETRCDATA( NUPACKAGE );

                
                
                IF ( SYSDATE > RCPACKAGE.EXPECT_ATTEN_DATE + (INUHOURSAFTER/24) )
                THEN

                    
                    NOTIFYPACKAGE( NUPACKAGE,
                                   NUCLASSNOTIF,
                                   NUNOTITYPE,
                                   NUNOTIFID,
                                   INUMESGALERTID,
                                   INUSTATEMENTID,
                                   SBTEXTRESULT,
                                   SBINPUTDTA );

                END IF;

            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    ERRORS.GETERROR( NUERROR, SBERROR );
                    SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    ERRORS.GETERROR( NUERROR, SBERROR );
                    SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
            END;

        END LOOP;

        UT_TRACE.TRACE( 'Fin Ge_BONotifMesgAlert.SendPackAttExpirAlert', 15 );

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR( NUERROR, SBERROR );
            SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR( NUERROR, SBERROR );
            SAVELOGNOTIF( NUNOTIFID, NUERROR, SBERROR, CSBSTATUS_ES, SBTEXTRESULT, SBINPUTDTA, NUPACKAGE, NULOGNOTIF );
            RAISE EX.CONTROLLED_ERROR;
    END SENDPACKATTEXPIRALERT;

    
















    PROCEDURE VALIDEXISTPKINSTATEMENT
    (
        ITBINSTSTATEMENT    IN  GE_BOINSTANCE.TYTBINSTANCE,
        ITBPKCOLNAMES        IN  DAGE_ENTITY_ATTRIBUTES.TYTBTECHNICAL_NAME,
        INUENTITYID          IN  GE_ENTITY.ENTITY_ID%TYPE,
        OTBINDEXPK           OUT  TYTBNUMBER
    )
    IS
        
        NUAUXIDX            NUMBER;
        SBOUTTEXT           VARCHAR2(4000);
        NUOUTVAL            NUMBER;
        NUINDEXKEY          NUMBER;
        NUENTITYID          GE_ENTITY.ENTITY_ID%TYPE;

    BEGIN
        
        UT_TRACE.TRACE('INICIO Ge_BoNotifMesgAlert.validExistPkInStatement',10);
        
        
        
        IF (ITBPKCOLNAMES.COUNT > 0) THEN
            NUAUXIDX := ITBPKCOLNAMES.FIRST;
            LOOP
                IF (NOT GE_BOUTILITIES.FBLGETVALUEPARAMETR( ITBINSTSTATEMENT,
                                                            ITBPKCOLNAMES(NUAUXIDX),
                                                            SBOUTTEXT,
                                                            NUOUTVAL,
                                                            NUINDEXKEY )              ) THEN
                    
                    
                    ERRORS.SETERROR(CNUSTATEMENT_NOT_HAS_PK,
                                    ITBPKCOLNAMES(NUAUXIDX) ||'|'||
                                    DAGE_ENTITY.FSBGETNAME_(INUENTITYID)
                                    );
                    RAISE EX.CONTROLLED_ERROR;
                END IF;

                OTBINDEXPK(NUAUXIDX) := NUINDEXKEY;

                NUAUXIDX := ITBPKCOLNAMES.NEXT(NUAUXIDX);
                EXIT WHEN NUAUXIDX IS NULL;
            END LOOP;
        ELSE
            
            ERRORS.SETERROR(CNUENTITY_NOT_HAS_PK, DAGE_ENTITY.FSBGETNAME_(INUENTITYID));
            RAISE EX.CONTROLLED_ERROR;
        END IF;
        UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.validExistPkInStatement',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VALIDEXISTPKINSTATEMENT;

    





























    PROCEDURE PROCGENRLNOTIFALERTTEMP
    (
         INUMESGALERTID     IN  GE_MESG_ALERT.MESG_ALERT_ID%TYPE,
         INUSTATEMENTID     IN  GE_STATEMENT.STATEMENT_ID%TYPE,
         ISBLETRENOTIFY     IN  VARCHAR2 DEFAULT 'N'
    )
    IS
        
        RCMESGALERT         DAGE_MESG_ALERT.STYGE_MESG_ALERT;

        
        TBTMPSELECT         GE_BOINSTANCE.TYTBINSTANCE;
        TBSELECTINS         TYTBTYSELECT;
        SBINPUT             VARCHAR2(2000);
        NUINDEXKEY          NUMBER;

        OSBTIPOFORMATO      GE_NOTIFICATION.FORMAT_TYPE%TYPE;
        OSBSALIDATEXTO      GE_NOTIFICATION_LOG.OUTPUT_TEXT%TYPE;
        OSBSALIDACLOB       GE_NOTIFICATION_LOG.OUTPUT_CLOB%TYPE;
        SBOUTTEXT           VARCHAR2(4000);

        SBIDX               VARCHAR2(20);

        NUERROR             GE_ERROR_LOG.ERROR_LOG_ID%TYPE := GE_BOCONSTANTS.CNUSUCCESS;
        SBERROR             GE_ERROR_LOG.DESCRIPTION%TYPE := GE_BOCONSTANTS.CSBNOMESSAGE;

        SBINPUTDTA          VARCHAR2(1024);
        NUEXTERNAL          NUMBER := INUMESGALERTID;
        NULOGNOTIF          GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE := NULL;
        NUNOTIFICATIONLOG   GE_NOTIFICATION_LOG.NOTIFICATION_LOG_ID%TYPE;

        NUNOTIFID           GE_NOTIFICATION.NOTIFICATION_ID%TYPE := NULL;
        NUORGMDLE           GE_NOTIFICATION.ORIGIN_MODULE_ID%TYPE;
        NUNOTITYPE          GE_NOTIFICATION.NOTIFICATION_TYPE_ID%TYPE;
        NUCLASSNOTIF        GE_NOTIFICATION.NOTIFICATION_CLASS_ID%TYPE;
        SBPARAMETERS        GE_NOTIFICATION.PARAMETERS%TYPE;
        TBPARAMETERS        GE_BOINSTANCE.TYTBINSTANCE;

        NUENTITYID          GE_ENTITY.ENTITY_ID%TYPE;
        BLEXISTPARAM        BOOLEAN;

        TBPKCOLNAMES        DAGE_ENTITY_ATTRIBUTES.TYTBTECHNICAL_NAME;
        TBINDEXPK           TYTBNUMBER;

        TBPERSTONOTIFY      GE_BOFWPARAMETMESGALERT.TYTBPERSONS;

        SBNAME              GE_OBJECT.NAME_%TYPE;
        TBFIELDSNOTIF       UT_STRING.TYTB_STRING;
        SBUSING             GE_BOUTILITIES.STYSTATEMENT;
        NUOBJECT            GE_OBJECT.OBJECT_ID%TYPE;
        CSBSI               CONSTANT VARCHAR2(1) := 'S';
    BEGIN
        
        UT_TRACE.TRACE('INICIO Ge_BoNotifMesgAlert.procGenrlNotifAlertTemp',10);
        SBUSING := NULL;

        
        
        
        
        VALIDDATAGNRLALERTTEMP(INUMESGALERTID);

        
        
        DAGE_MESG_ALERT.GETRECORD(INUMESGALERTID,RCMESGALERT);

        NUNOTIFID    := RCMESGALERT.NOTIFICATION_ID;
        NUORGMDLE    := DAGE_NOTIFICATION.FNUGETORIGIN_MODULE_ID(NUNOTIFID);        
        NUNOTITYPE   := DAGE_NOTIFICATION.FNUGETNOTIFICATION_TYPE_ID(NUNOTIFID);    
        NUCLASSNOTIF := DAGE_NOTIFICATION.FNUGETNOTIFICATION_CLASS_ID(NUNOTIFID);   
        SBPARAMETERS := DAGE_NOTIFICATION.FSBGETPARAMETERS(NUNOTIFID);              

        
        IF (SBPARAMETERS IS NULL) THEN
            NUEXTERNAL := NUNOTIFID;
            ERRORS.SETERROR(CNUNOTIF_WRONG_CONF,NUNOTIFID);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        STRINGTOTBPARAMETRS(SBPARAMETERS,TBPARAMETERS);
        BLEXISTPARAM := GE_BOUTILITIES.FBLGETVALUEPARAMETR(  TBPARAMETERS,
                                                             GE_BOCONSTANTS.CSBENTITY_ID_PARAM,
                                                             SBOUTTEXT,
                                                             NUENTITYID,
                                                             NUINDEXKEY
                                                           );

        
        IF (NOT BLEXISTPARAM)THEN
            ERRORS.SETERROR(CNUNOTIF_WRONG_CONF,NUNOTIFID);
            NUEXTERNAL := NUNOTIFID;
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        IF (NUENTITYID = CNUOPERUNIT_ENTY_ID OR NUENTITYID = CNUORDER_ENTY_ID) THEN
            
            PROCESSNOTIFALERTTEMP ( INUMESGALERTID,INUSTATEMENTID,NULL,NULL,UPPER(ISBLETRENOTIFY));
            RETURN;
        END IF;

        
        GE_BCENTITYATTRIBUTES.GETENTITYPKCOLUMNSNAME(NUENTITYID,TBPKCOLNAMES);

        
        
        
        
        
        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,'paramNULO','valorNULO');

        
        IF (NOT FBLPROCESSSTATEMENT(INUSTATEMENTID,SBINPUT,TBSELECTINS) ) THEN
            RETURN;
        END IF;

        
        
        
        
        
        VALIDEXISTPKINSTATEMENT( TBSELECTINS(TBSELECTINS.FIRST),
                                 TBPKCOLNAMES,
                                 NUENTITYID,
                                 TBINDEXPK
                               );

        
        FOR N IN TBSELECTINS.FIRST .. TBSELECTINS.LAST LOOP
            TBTMPSELECT := TBSELECTINS(N);

            
            
            BEGIN
                SBINPUT     := '';
                
                SBUSING     := NULL;

                
                NUEXTERNAL := TBTMPSELECT(TBINDEXPK(TBINDEXPK.FIRST)).VALUE_;

                SBPARAMETERS := CSBMESG_ALERT||'='||INUMESGALERTID||';'||CSBSTATEMENT||'='||INUSTATEMENTID||';';

                FOR INDX IN TBINDEXPK.FIRST .. TBINDEXPK.LAST LOOP
                    SBPARAMETERS := SBPARAMETERS || UPPER(TBTMPSELECT(TBINDEXPK(INDX)).NAME_ATTRIBUTE) ||'='||TBTMPSELECT(TBINDEXPK(INDX)).VALUE_||';';

                    
                    
                    IF TBTMPSELECT(TBINDEXPK(INDX)).ATTRIBUTE_TYPE = DAGE_ATTRIBUTES_TYPE.FSBGETDESCRIPTION(GE_BOCONSTANTS.CNUATTRTYPEVARCHAR2) THEN
                        
                        GE_BOXSLTRANSFORMATION.SETATTRIBUTETEXT
                        (
                            SBINPUT,
                            UPPER(TBTMPSELECT(TBINDEXPK(INDX)).NAME_ATTRIBUTE),
                            TBTMPSELECT(TBINDEXPK(INDX)).VALUE_
                        );

                    ELSE
                        
                        GE_BOXSLTRANSFORMATION.SETATTRIBUTENUMBER
                        (
                            SBINPUT,
                            UPPER(TBTMPSELECT(TBINDEXPK(INDX)).NAME_ATTRIBUTE),
                            TBTMPSELECT(TBINDEXPK(INDX)).VALUE_
                        );
                    END IF;

                    IF SBUSING IS NOT NULL THEN
                        SBUSING      := SBUSING || ', ''' || TBTMPSELECT(TBINDEXPK(INDX)).VALUE_ || '''';
                    ELSE
                        SBUSING      := '''' || TBTMPSELECT(TBINDEXPK(INDX)).VALUE_ || '''';
                    END IF;
                END LOOP;

                TBPARAMETERS.DELETE;
                STRINGTOTBPARAMETRS(SBPARAMETERS,TBPARAMETERS);
                
                 
                IF (UPPER(ISBLETRENOTIFY) = CSBSI OR
                    NOT FBLWASNOTIFTHIS(NUEXTERNAL,NUNOTIFID,TBPARAMETERS)) THEN

                    
                    
                    
                    
                    GE_BOXSLTRANSFORMATION.GETXSLTRANSFORMATION
                    (
                        NUNOTIFID,
                        NUORGMDLE,
                        SBINPUT,
                        OSBTIPOFORMATO,
                        OSBSALIDATEXTO,
                        OSBSALIDACLOB
                    );

                    SBOUTTEXT := OSBSALIDATEXTO;
                    SBINPUTDTA := SBINPUT;

                    
                    
                    
                    
                    GE_BOFWPARAMETMESGALERT.GETPERSONTONOTIF
                    (
                        INUMESGALERTID,
                        NUNOTITYPE,
                        TBPERSTONOTIFY
                    );

                    
                    NUOBJECT := DAGE_MESG_ALERT.FNUGETOBJECT_ID
                                (
                                    INUMESGALERTID
                                );
                    UT_TRACE.TRACE('nuObject: ' || NUOBJECT, 1);
                    
                    IF ( NUOBJECT IS NOT NULL ) THEN
                        SBNAME := DAGE_OBJECT.FSBGETNAME_
                        (
                            NUOBJECT
                        );
                    END IF;
                    IF SBNAME IS NOT NULL THEN
                        GE_BONOTIFSERVICES.GTBFIELDSNOTIF.DELETE;
                        
                        EXECUTE IMMEDIATE 'Begin ' || SBNAME || '(' || SBUSING || '); END;';

                        TBFIELDSNOTIF := GE_BONOTIFSERVICES.GTBFIELDSNOTIF;
                    END IF;
                    
                    IF TBPERSTONOTIFY.COUNT < 1 AND TBFIELDSNOTIF.COUNT < 1  THEN
                        
                        ERRORS.SETERROR(CNUNOBODY_TO_NOTIF, INUMESGALERTID );
                        RAISE EX.CONTROLLED_ERROR;
                    END IF;

                    
                    
                    
                    SBIDX := TBPERSTONOTIFY.FIRST;

                    
                    LOOP
                        EXIT WHEN SBIDX IS NULL;

                        SBINPUT := NULL;
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBPERSONID,TBPERSTONOTIFY(SBIDX).PERSON_ID);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBNOTIF_TYPE,TBPERSTONOTIFY(SBIDX).NOTIFICATION_TYPE_ID);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBMESG_ALERT,INUMESGALERTID);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBSTATEMENT,INUSTATEMENTID);

                        FOR INDX IN TBINDEXPK.FIRST .. TBINDEXPK.LAST LOOP
                            
                            GE_BONOTIFICATION.SETATTRIBUTE( SBINPUT,
                                                            UPPER(TBTMPSELECT(TBINDEXPK(INDX)).NAME_ATTRIBUTE),
                                                            TBTMPSELECT(TBINDEXPK(INDX)).VALUE_
                                                          );
                        END LOOP;



                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            TBPERSTONOTIFY(SBIDX).NOTIFICATION_TYPE_ID,
                            NUORGMDLE,
                            SBINPUT,
                            NUEXTERNAL,
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );

                        SBINPUTDTA := SBINPUT;

                        SBIDX := TBPERSTONOTIFY.NEXT(SBIDX);
                    END LOOP;

                    
                    SBIDX := TBFIELDSNOTIF.FIRST;

                    LOOP
                        EXIT WHEN SBIDX IS NULL;
                        SBINPUT := NULL;

                        
                        GE_BONOTIFICATION.SETATTRIBUTE
                        (
                            SBINPUT,
                            CSBFIELD,
                            TBFIELDSNOTIF(SBIDX)
                        );

                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBNOTIF_TYPE,NUNOTITYPE);
                        
                        GE_BONOTIFICATION.SETATTRIBUTE(SBINPUT,CSBMESG_ALERT,INUMESGALERTID);

                        FOR INDX IN TBINDEXPK.FIRST .. TBINDEXPK.LAST LOOP
                            
                            GE_BONOTIFICATION.SETATTRIBUTE( SBINPUT,
                                                            UPPER(TBTMPSELECT(TBINDEXPK(INDX)).NAME_ATTRIBUTE),
                                                            TBTMPSELECT(TBINDEXPK(INDX)).VALUE_
                                                          );
                        END LOOP;

                        
                        GE_BONOTIFICATION.SENDNOTIFYWITHOUTPROCESS
                        (
                            NUNOTIFID,
                            NUNOTITYPE,
                            NUORGMDLE,
                            SBINPUT,
                            NUEXTERNAL,
                            OSBSALIDATEXTO,
                            NUNOTIFICATIONLOG,
                            NUERROR,
                            SBERROR
                        );

                        SBINPUTDTA := SBINPUT;
                        SBIDX := TBFIELDSNOTIF.NEXT(SBIDX);
                    END LOOP;
                END IF; 
            EXCEPTION
                WHEN EX.CONTROLLED_ERROR THEN
                    ERRORS.GETERROR(NUERROR, SBERROR);
                    SAVELOGNOTIF(NUNOTIFID,NUERROR,SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
                WHEN OTHERS THEN
                    ERRORS.SETERROR;
                    ERRORS.GETERROR(NUERROR, SBERROR);
                    SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
            END;
            

            
            TBPERSTONOTIFY.DELETE;

        END LOOP;

        UT_TRACE.TRACE('FIN Ge_BoNotifMesgAlert.procGenrlNotifAlertTemp',10);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            ERRORS.GETERROR(NUERROR, SBERROR);
            SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            ERRORS.GETERROR(NUERROR, SBERROR);
            SAVELOGNOTIF(NUNOTIFID,NUERROR, SBERROR,CSBSTATUS_ES,SBOUTTEXT,SBINPUTDTA,NUEXTERNAL,NULOGNOTIF);
            RAISE EX.CONTROLLED_ERROR;
    END PROCGENRLNOTIFALERTTEMP;

END GE_BONOTIFMESGALERT;