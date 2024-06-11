PACKAGE BODY GE_BOUtilities
AS






































    
    CSBVERSION   CONSTANT VARCHAR2(20)            := 'SAO200868';
    CNUERR_NULL_INITIAL_DATE       CONSTANT NUMBER(4) := 2540;
    CNUERR_NULL_FINAL_DATE         CONSTANT NUMBER(4) := 2557;
    CNUERR_FINAL_TO_INITIAL_DATE   CONSTANT NUMBER(4) := 2572;
    
    CSBNOTIFINSTANCE                CONSTANT VARCHAR2(100)  := 'NOTIFICATION_INSTANCE';


    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
    
        RETURN CSBVERSION;
    
    END;

    
    PROCEDURE INITIALIZEOUTPUT
        (
        ONUERRORCODE OUT NOCOPY NUMBER,
        OSBERRORMESSAGE OUT NOCOPY VARCHAR2
        )
    IS
    BEGIN
       
	   ONUERRORCODE    := GE_BOCONSTANTS.CNUSUCCESS;
	   OSBERRORMESSAGE := NULL;
    END;
    
    PROCEDURE ADDATTRIBUTE
    (
        ISBATTRIBUTE  IN GE_BOUTILITIES.STYSTATEMENTATTRIBUTE,
        ISBALIAS      IN GE_BOUTILITIES.STYSTATEMENTATTRIBUTE,
        IOSBSELECT    IN OUT GE_BOUTILITIES.STYSTATEMENTATTRIBUTE
    )
    IS

    SBMASK  VARCHAR2(40);
    NUINDEX PLS_INTEGER;

    BEGIN

        IF IOSBSELECT IS NOT NULL THEN
            IOSBSELECT := IOSBSELECT ||', '|| CHR(10);
        END IF;

        IOSBSELECT := IOSBSELECT || ISBATTRIBUTE ||' '|| ISBALIAS;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;

        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE VALIDDATE
    (
        IDTINITIAL IN DATE,
        IDTFINAL IN DATE
    ) IS
    BEGIN
        UT_TRACE.TRACE('ValidDate INICIO',3);
        IF IDTINITIAL IS NULL AND IDTFINAL IS NULL THEN
            RETURN;
        END IF;
        
        IF IDTINITIAL IS NULL THEN
            UT_TRACE.TRACE('idtInitial NULL',3);
            ERRORS.SETERROR (CNUERR_NULL_INITIAL_DATE);
 			RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF IDTFINAL IS NULL THEN
            UT_TRACE.TRACE('idtFinal NULL',3);
            ERRORS.SETERROR (CNUERR_NULL_FINAL_DATE);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF IDTFINAL < IDTINITIAL THEN
            UT_TRACE.TRACE('idtFinal <  idtInitial',3);
            ERRORS.SETERROR (CNUERR_FINAL_TO_INITIAL_DATE);
            RAISE EX.CONTROLLED_ERROR;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    FUNCTION FNUGETAPPLICATIONNULL
    RETURN NUMBER
    IS
    BEGIN
         RETURN CNUAPPLICATIONNULL;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    



















    FUNCTION FBLGETVALUEPARAMETR
    (
        ITBPARAMETERS       IN GE_BOINSTANCE.TYTBINSTANCE,
        ISBNAME_ATTRIBUTE   IN GE_ATTRIBUTES.NAME_ATTRIBUTE%TYPE,
        OSBVALUEPARAM       OUT VARCHAR2,
        ONUVALUEPARAM       OUT NUMBER,
        ONUINDEX_VALUE      OUT NUMBER
    ) RETURN BOOLEAN
    IS
        
        NUINDEX     NUMBER;
    BEGIN
        
        UT_TRACE.TRACE('INICIO GE_BOUtilities.GetValueParametr',20);
        
        IF ITBPARAMETERS.COUNT > 0 THEN
            NUINDEX := ITBPARAMETERS.FIRST;
            LOOP
                IF (UPPER(ITBPARAMETERS(NUINDEX).NAME_ATTRIBUTE) = UPPER(ISBNAME_ATTRIBUTE) ) THEN
                    OSBVALUEPARAM := ITBPARAMETERS(NUINDEX).VALUE_;
                    ONUINDEX_VALUE := NUINDEX;
                    
                    BEGIN
                        ONUVALUEPARAM := ITBPARAMETERS(NUINDEX).VALUE_;
                        EXCEPTION WHEN OTHERS THEN NULL;
                    END;
                    UT_TRACE.TRACE('FIN GE_BOUtilities.GetValueParametr',20);
                    RETURN TRUE;
                END IF;
                NUINDEX := ITBPARAMETERS.NEXT(NUINDEX);
                EXIT WHEN NUINDEX IS NULL;
            END LOOP;

        END IF;
        
        RETURN FALSE;
        UT_TRACE.TRACE('FIN GE_BOUtilities.GetValueParametr',20);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    
















    FUNCTION FSBGETDESC
    (
        INUENTITY_ID        IN      GE_MESG_ALERT.ENTITY_ID%TYPE,
        ISBREFERENCE        IN      GE_MESG_ALERT.REFERENCE%TYPE
    )
    RETURN VARCHAR2
    IS
        TBSTRING            UT_STRING.TYTB_STRING;
        V_COUNTER           NUMBER;
        CUCURSOR            CONSTANTS.TYREFCURSOR;
        TBFIELDS            DAGE_ENTITY_ATTRIBUTES.TYTBGE_ENTITY_ATTRIBUTES;
        TBSELECT            UT_STRING.TYTB_STRING;
        SBSELECT            VARCHAR2(32767);
        SBWHERE             VARCHAR2(32767);
        SBRETURN            VARCHAR2(2000);
        NUENTITY            GE_MESG_ALERT.ENTITY_ID%TYPE;
        CNUENTITYORDER      CONSTANT GE_ENTITY.ENTITY_ID%TYPE := 3294;
        CNUENTITYTASKTYPE   CONSTANT GE_ENTITY.ENTITY_ID%TYPE := 3313;
    BEGIN
        UT_TRACE.TRACE('Inicia GE_BOUtilities.fsbGetDesc',1);
        
        IF (DAGE_ENTITY.FSBGETIN_PERSIST(INUENTITY_ID) = GE_BOCONSTANTS.CSBNO) THEN
            UT_TRACE.TRACE('Termina GE_BOUtilities.fsbGetDesc No persistente',1);
            RETURN ISBREFERENCE;
        END IF;

        
        IF INUENTITY_ID = CNUENTITYORDER  THEN
           NUENTITY := CNUENTITYTASKTYPE;
        ELSE
           NUENTITY := INUENTITY_ID;
        END IF;

        
        UT_STRING.EXTSTRING (ISBREFERENCE, '|', TBSTRING);

        
        GE_BCUTILITIES.GETTECHNAMES
        (
            NUENTITY,
            CUCURSOR
        );
        FETCH CUCURSOR BULK COLLECT INTO TBFIELDS;
        CLOSE CUCURSOR;

        
        
        IF TBFIELDS.COUNT <> TBSTRING.COUNT THEN
            UT_TRACE.TRACE('Termina GE_BOUtilities.fsbGetDesc Diferentes tama?os',1);
            RETURN ISBREFERENCE;
        END IF;

        
        GE_BCUTILITIES.GETFIRSTLOVDESCENT
        (
            NUENTITY,
            CUCURSOR
        );
        FETCH CUCURSOR BULK COLLECT INTO TBSELECT;
        CLOSE CUCURSOR;

        
        IF(TBSELECT.COUNT = 0) THEN
            TBSELECT.DELETE;
            GE_BCUTILITIES.GETFIRSTVAR2FIELDENT
            (
                NUENTITY,
                CUCURSOR
            );
            FETCH CUCURSOR BULK COLLECT INTO TBSELECT;
            CLOSE CUCURSOR;
        END IF;

        
        IF(TBSELECT.COUNT = 0) THEN
            UT_TRACE.TRACE('Termina GE_BOUtilities.fsbGetDesc No Varchar2',1);
            RETURN ISBREFERENCE;
        END IF;

         
        FOR V_COUNTER IN 1 .. TBSTRING.COUNT
          LOOP
            IF SBWHERE IS NULL THEN
                SBWHERE := 'WHERE ' || TBFIELDS(V_COUNTER).TECHNICAL_NAME || ' = ''' || TBSTRING(V_COUNTER) || '''';
            ELSE
                SBWHERE := SBWHERE || CHR(10) || ' AND ' || TBFIELDS(V_COUNTER).TECHNICAL_NAME || ' = ''' || TBSTRING(V_COUNTER)|| '''';
            END IF;
        END LOOP;

        SBSELECT := 'Select ' || TBSELECT(1) || CHR(10) || 'FROM ' || DAGE_ENTITY.FSBGETNAME_(NUENTITY);
        SBSELECT := SBSELECT || CHR(10) || SBWHERE;

        UT_TRACE.TRACE(SBSELECT,1);

        
        OPEN CUCURSOR FOR SBSELECT;
        FETCH CUCURSOR INTO SBRETURN;
        CLOSE CUCURSOR;

        IF SBRETURN IS NOT NULL THEN
            UT_TRACE.TRACE('Termina GE_BOUtilities.fsbGetDesc OK',1);
            RETURN SBRETURN;
        ELSE
            UT_TRACE.TRACE('Termina GE_BOUtilities.fsbGetDesc NULO',1);
            RETURN ISBREFERENCE;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUCURSOR%ISOPEN THEN
                CLOSE CUCURSOR;
            END IF;
            RETURN '';
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            IF CUCURSOR%ISOPEN THEN
                CLOSE CUCURSOR;
            END IF;
            RETURN '';
    END FSBGETDESC;
    
    

















    FUNCTION FSBGETNOTIFINSTANCE
    RETURN VARCHAR2
    IS
    BEGIN

        
        RETURN CSBNOTIFINSTANCE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBGETNOTIFINSTANCE;
    
    



















    FUNCTION FSBVALASSIGRULE
    (
        INUASSIGNATIONRULEID    IN  GE_MESG_ALERT.CONFIG_EXPRESSION_ID%TYPE
    )
    RETURN VARCHAR2
    IS
        NUERRORCODE             NUMBER;
        SBRETURNVALUE           VARCHAR2(2000);
        SBERRORMESSAGE          VARCHAR2(2000);
    BEGIN
        UT_TRACE.TRACE ('Begin GE_BOUtilities.fsbValAssigRule', 10);

        UT_TRACE.TRACE ('AssignationRuleID[' || INUASSIGNATIONRULEID|| ']', 11);

        IF INUASSIGNATIONRULEID IS NULL THEN
            UT_TRACE.TRACE ('End GE_BOUtilities.fsbValAssigRule', 10);
            RETURN GE_BOCONSTANTS.CSBYES;
        END IF;

        GR_BOCONFIG_EXPRESSION.EXECUTEINITEXPRESSION(INUASSIGNATIONRULEID, SBRETURNVALUE, NUERRORCODE, SBERRORMESSAGE);

        UT_TRACE.TRACE ('ReturnValue[' || SBRETURNVALUE || ']', 11);
        UT_TRACE.TRACE ('ErrorCode[' || NUERRORCODE || ']', 11);

        UT_TRACE.TRACE ('End GE_BOUtilities.fsbValAssigRule', 10);

        IF NUERRORCODE = 0 AND SBRETURNVALUE = '0' THEN
            RETURN GE_BOCONSTANTS.CSBYES;
        END IF;

        RETURN GE_BOCONSTANTS.CSBNO;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBVALASSIGRULE;
    
    
 



















    PROCEDURE SETVALUES
    (
        INUENTITYID         IN      GE_MESG_ALERT.ENTITY_ID%TYPE,
        ISBREFNOTIF         IN      GE_MESG_ALERT.REFERENCE%TYPE
    )
    IS
        
        BORESULT BOOLEAN;
    BEGIN
        BORESULT := FBOSETVALUES(INUENTITYID,ISBREFNOTIF);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
                RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END SETVALUES;
    
    
    




















    FUNCTION FBOSETVALUES
    (
        INUENTITYID         IN      GE_MESG_ALERT.ENTITY_ID%TYPE,
        ISBREFNOTIF         IN      GE_MESG_ALERT.REFERENCE%TYPE
    )
    RETURN BOOLEAN
    IS
        SBENTITYNAME        GE_ENTITY.NAME_%TYPE;
        NUNOTIFINSTANCE     GE_BOINSTANCECONTROL.STYNUINDEX;
        TBSTRING            UT_STRING.TYTB_STRING;
        CUCURSOR            CONSTANTS.TYREFCURSOR;
        TBFIELDS            DAGE_ENTITY_ATTRIBUTES.TYTBGE_ENTITY_ATTRIBUTES;
        NUENTITY            GE_BOINSTANCECONTROL.STYNUINDEX;
        BLFOUND             BOOLEAN;
        BLISPERS            BOOLEAN;
        SBNAME              GE_ENTITY_ADITIONAL.PRIMARY_KEY_ATTRIBUTE%TYPE;
    BEGIN
        UT_TRACE.TRACE ('Begin GE_BOUtilities.setValues', 1);

        
        SBENTITYNAME := DAGE_ENTITY.FSBGETNAME_(INUENTITYID);
        
        
        UT_STRING.EXTSTRING (ISBREFNOTIF, '|', TBSTRING);
        
        BLISPERS := DAGE_ENTITY.FSBGETIN_PERSIST(INUENTITYID) = GE_BOCONSTANTS.CSBYES;
        IF (BLISPERS) THEN

            
            GE_BCUTILITIES.GETTECHNAMES
            (
                INUENTITYID,
                CUCURSOR
            );

            FETCH CUCURSOR BULK COLLECT INTO TBFIELDS;
            CLOSE CUCURSOR;
            
            
            
            IF TBFIELDS.COUNT <> TBSTRING.COUNT THEN
                UT_TRACE.TRACE('Termina GE_BOUtilities.setValues, par?metros incorrectos', 1);
                RETURN FALSE;
            END IF;

        ELSE
            
            SBNAME := DAGE_ENTITY_ADITIONAL.FSBGETPRIMARY_KEY_ATTRIBUTE
                      (
                         INUENTITYID
                      );
            IF  TBSTRING.COUNT = 0 THEN
                UT_TRACE.TRACE('Termina GE_BOUtilities.setValues, par?metros incorrectos', 1);
                RETURN FALSE;
            END IF;
        END IF;

        UT_TRACE.TRACE('ge_boInstanceControl.fblIsInitInstanceControl', 1);
        IF (NOT(GE_BOINSTANCECONTROL.FBLISINITINSTANCECONTROL)) THEN
            
            GE_BOINSTANCECONTROL.INITINSTANCEMANAGER;
        END IF;

        
        
        IF (NOT(GE_BOINSTANCECONTROL.FBLACCKEYINSTANCESTACK(CSBNOTIFINSTANCE,
                                                                NUNOTIFINSTANCE))) THEN
            UT_TRACE.TRACE('ge_boInstanceControl.CreateInstance', 1);
            GE_BOINSTANCECONTROL.CREATEINSTANCE
            (
                CSBNOTIFINSTANCE,
                NULL
            );
        END IF;
        UT_TRACE.TRACE('ge_boInstanceControl.fblAcckeyInstanceStack', 1);
        BLFOUND := GE_BOINSTANCECONTROL.FBLACCKEYINSTANCESTACK
                    (
                        CSBNOTIFINSTANCE,
                        NUNOTIFINSTANCE
                    );
        
        UT_TRACE.TRACE('ge_boInstanceControl.AddEntityStack', 1);
        
        GE_BOINSTANCECONTROL.ADDENTITYSTACK
        (
            NUNOTIFINSTANCE,
            CSBNOTIFINSTANCE,
            NULL,
            SBENTITYNAME,
            NULL,
            NUENTITY
        );

        
        IF (BLISPERS) THEN
        
            FOR INDX IN TBFIELDS.FIRST .. TBFIELDS.LAST LOOP

                GE_BOINSTANCECONTROL.ADDATTRIBUTE
                (
                    CSBNOTIFINSTANCE,
                    NULL,
                    SBENTITYNAME,
                    UPPER(TBFIELDS(INDX).TECHNICAL_NAME),
                    TO_CHAR(TBSTRING(INDX)),
                    TRUE
                );

            END LOOP;
            
        ELSE
            UT_TRACE.TRACE('ge_boInstanceControl.AddAttribute', 1);
            GE_BOINSTANCECONTROL.ADDATTRIBUTE
            (
                CSBNOTIFINSTANCE,
                NULL,
                SBENTITYNAME,
                UPPER(SBNAME),
                TO_CHAR(TBSTRING(TBSTRING.FIRST)),
                TRUE
            );
        
        END IF;

        UT_TRACE.TRACE ('End GE_BOUtilities.fboSetValues', 1);
        RETURN TRUE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBOSETVALUES;
    
    
    













    FUNCTION FSBCONVERTSTR2HEX
    (
        ISBSTR  IN  VARCHAR2
    ) RETURN VARCHAR2
    IS
        
        NUITERA         NUMBER := 1;
        SBNEWDATAHEX    VARCHAR2(32767);
        SBCHARHEX       VARCHAR2(2);
    BEGIN
        
        UT_TRACE.TRACE('INICIO GE_BOUtilities.fsbConvertStr2Hex',20);

        
        IF (ISBSTR IS NOT NULL AND LENGTH(ISBSTR) > 0 ) THEN
            LOOP
                SBCHARHEX := NVL(UT_CONVERT.INT2HEX(ASCII(SUBSTR(ISBSTR,NUITERA,1))),'00');
                IF (LENGTH(SBCHARHEX) = 1) THEN SBCHARHEX := '0'||SBCHARHEX; END IF;
                SBNEWDATAHEX := SBNEWDATAHEX || SBCHARHEX;
                EXIT WHEN NUITERA >= LENGTH(ISBSTR);
                NUITERA := NUITERA + 1;
            END LOOP;
        END IF;

        RETURN SBNEWDATAHEX;

        UT_TRACE.TRACE('FIN GE_BOUtilities.fsbConvertStr2Hex',20);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBCONVERTSTR2HEX;

    
















    FUNCTION FSBCONVERTHEX2STR
    (
        ISBHEX   IN VARCHAR2
    ) RETURN VARCHAR2
    IS
        NUITERA         NUMBER := 1;
        SBNEWDATASTR    VARCHAR2(32767);
        SBCHARSTR       VARCHAR2(2);
    BEGIN
        
        UT_TRACE.TRACE('FIN GE_BOUtilities.fsbConvertHex2Str',20);

        
        IF (ISBHEX IS NOT NULL AND MOD(LENGTH(ISBHEX),2) = 0 ) THEN
            LOOP
                SBCHARSTR := CHR(UT_CONVERT.HEX2INT(SUBSTR(ISBHEX,NUITERA,2)));
                SBNEWDATASTR := SBNEWDATASTR || SBCHARSTR;
                EXIT WHEN NUITERA >= LENGTH(ISBHEX);
                NUITERA := NUITERA + 2;
            END LOOP;
        END IF;

        RETURN SBNEWDATASTR;

        UT_TRACE.TRACE('FIN GE_BOUtilities.fsbConvertHex2Str',20);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBCONVERTHEX2STR;

    














    PROCEDURE DESTROYTABLE
    (
        INUENTITYID         IN      GE_MESG_ALERT.ENTITY_ID%TYPE
    )
    IS

    BEGIN
        
        UT_TRACE.TRACE('FIN GE_BOUtilities.destroyTable',20);

        
        GE_BOINSTANCECONTROL.DESTROYENTITY
        (
            CSBNOTIFINSTANCE,
            NULL,
            DAGE_ENTITY.FSBGETNAME_(INUENTITYID)
        );

        UT_TRACE.TRACE('FIN GE_BOUtilities.destroyTable',20);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END DESTROYTABLE;

    












	FUNCTION FSBTOSTRING
    (
        ISBVALUE    IN  VARCHAR2
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN GE_BOCONSTANTS.CSBQUOTE || ISBVALUE || GE_BOCONSTANTS.CSBQUOTE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBTOSTRING;

    












	FUNCTION FSBTOSTRING
    (
        INUVALUE    IN  NUMBER
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN TO_CHAR(INUVALUE);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBTOSTRING;

    













	FUNCTION FSBTOSTRING
    (
        IDTVALUE        IN  DATE,
        ISBDATEFORMAT   IN  VARCHAR2 DEFAULT UT_DATE.FSBDATE_FORMAT
    )
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN GE_BOCONSTANTS.CSBQUOTE || TO_CHAR(IDTVALUE, ISBDATEFORMAT) || GE_BOCONSTANTS.CSBQUOTE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBTOSTRING;
END GE_BOUTILITIES;