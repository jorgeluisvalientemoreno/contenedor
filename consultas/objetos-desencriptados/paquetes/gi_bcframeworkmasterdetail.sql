PACKAGE BODY GI_BCFrameWorkMasterDetail
IS





































































    
    CSBVERSION   CONSTANT VARCHAR2(20) := 'SAO204673';

    

    CURSOR CUPARENTENTITY( INUEXECUTABLEID NUMBER )
    IS
    SELECT ENTITY_ID
    FROM GI_ENTITY_DISP_DATA
    WHERE EXECUTABLE_ID = INUEXECUTABLEID
      AND PARENT_ENTITY_ID IS NULL;

    















    CURSOR CUCOUNTSCHEMECOLUMNS(INUENTITYID IN  GE_ENTITY.ENTITY_ID%TYPE)
    IS
    SELECT  COUNT (1) COLUMNSCOUNTED
    FROM    GE_ENTITY,
            ALL_TAB_COLUMNS
    WHERE   /*+ Ubicaci�n: GI_BCFrameWorkMasterDetail.cuCountSchemeColumns SAO204673 */
            OWNER = GE_BOPARAMETER.FSBGET('DEFAULT_SCHEMA')
    AND     TABLE_NAME = GE_ENTITY.NAME_
    AND     GE_ENTITY.ENTITY_ID = INUENTITYID;

	
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    FUNCTION FRCGETENTITIESBYEXECUTABLE
    (
        INUEXECUTABLEID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCENTITIES CONSTANTS.TYREFCURSOR;
        NUPARENTENTITYID NUMBER;
    BEGIN

        IF ( DASA_EXECUTABLE.FNUGETPARENT_EXECUTABLE_ID(INUEXECUTABLEID) = GI_BOFRAMEWORKCONSTANTS.CNUMADFWEXECUTABLE ) THEN

            OPEN CUPARENTENTITY(INUEXECUTABLEID);
            FETCH CUPARENTENTITY INTO NUPARENTENTITYID;
            CLOSE CUPARENTENTITY;

            OPEN ORCENTITIES FOR
            SELECT *
            FROM
            (
            SELECT
                EXECUTABLE_ID,
            	ENTITY_ID,
                PARENT_ENTITY_ID,
            	DISPLAY_TYPE,
            	LEVEL_,
            	POSITION_IN_LEVEL,
        	    ICON_,
            	DEFAULT_WHERE,
        	    JOIN_CONDITION,
            	READ_ONLY,
        	    ALLOW_INSERT,
            	ALLOW_DELETE,
                DAGE_ENTITY.FSBGETNAME_(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_NAME,
                CONFIGURA_TYPE_ID,
                DAGE_ENTITY.FNUGETMODULE_ID(ENTITY_ID) MODULE_ID,
                DAGE_MODULE.FSBGETDESCRIPTION(DAGE_ENTITY.FNUGETMODULE_ID(ENTITY_ID)) MODULE_DESC,
                DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC,
                GI_BCFRAMEWORKMASTERDETAIL.FSBGETDISPLAYORDERBY(EXECUTABLE_ID,ENTITY_ID) ORDER_BY_COLS
            FROM GI_ENTITY_DISP_DATA
            WHERE EXECUTABLE_ID = INUEXECUTABLEID
            ) B
            START WITH ENTITY_ID = NUPARENTENTITYID
            CONNECT BY PRIOR ENTITY_ID = PARENT_ENTITY_ID
            ORDER SIBLINGS BY POSITION_IN_LEVEL;

            RETURN ORCENTITIES;

        END IF;

        OPEN ORCENTITIES FOR
        SELECT
            EXECUTABLE_ID,
          	ENTITY_ID,
            PARENT_ENTITY_ID,
          	DISPLAY_TYPE,
          	LEVEL_,
           	POSITION_IN_LEVEL,
       	    ICON_,
           	DEFAULT_WHERE,
       	    JOIN_CONDITION,
           	READ_ONLY,
       	    ALLOW_INSERT,
           	ALLOW_DELETE,
            DAGE_ENTITY.FSBGETNAME_(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_NAME,
            CONFIGURA_TYPE_ID,
            DAGE_ENTITY.FNUGETMODULE_ID(ENTITY_ID) MODULE_ID,
            DAGE_MODULE.FSBGETDESCRIPTION(DAGE_ENTITY.FNUGETMODULE_ID(ENTITY_ID)) MODULE_DESC,
            DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC,
            GI_BCFRAMEWORKMASTERDETAIL.FSBGETDISPLAYORDERBY(EXECUTABLE_ID,ENTITY_ID) ORDER_BY_COLS
        FROM GI_ENTITY_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        RETURN ORCENTITIES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETENTITIESBYID
    (
        INUENTITYID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCENTITIES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCENTITIES FOR
        SELECT ENTITY_ATTRIBUTE_ID, ENTITY_ID, TECHNICAL_NAME, DISPLAY_NAME, KEY_
        FROM
        GE_ENTITY_ATTRIBUTES
        WHERE ENTITY_ID = INUENTITYID;

        RETURN ORCENTITIES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETATTRIBUTEDATA
    (
        INUEXECUTABLEID IN NUMBER,
        INUENTITYID     IN NUMBER,
        INUATTRIBUTEID  IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCATTRIBUTES CONSTANTS.TYREFCURSOR;
    BEGIN

        IF (UPPER(DAGE_ENTITY_ATTRIBUTES.FSBGETSTATUS(INUATTRIBUTEID)) = 'B' ) THEN

            OPEN ORCATTRIBUTES FOR
            SELECT
            GI_ATTRIB_DISP_DATA.*, '' CONF_TYPE_DESC
            FROM GI_ATTRIB_DISP_DATA
            WHERE 1 = 2;

            RETURN ORCATTRIBUTES;

        END IF;

        OPEN ORCATTRIBUTES FOR
        SELECT
        GI_ATTRIB_DISP_DATA.*,
        DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = INUENTITYID
          AND ENTITY_ATTRIBUTE_ID = INUATTRIBUTEID;

        RETURN ORCATTRIBUTES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETENTITIESTOSHOW
    (
        INUEXECUTABLEID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCENTITIES CONSTANTS.TYREFCURSOR;
        NUPARENTENTITYID NUMBER;

        RCSA_EXECUTABLE DASA_EXECUTABLE.STYSA_EXECUTABLE;

    BEGIN

        RCSA_EXECUTABLE := DASA_EXECUTABLE.FRCGETRECORD(INUEXECUTABLEID);

        IF ( DASA_EXECUTABLE.FNUGETPARENT_EXECUTABLE_ID(INUEXECUTABLEID) = GI_BOFRAMEWORKCONSTANTS.CNUMADFWEXECUTABLE ) THEN

            OPEN CUPARENTENTITY(INUEXECUTABLEID);
            FETCH CUPARENTENTITY INTO NUPARENTENTITYID;
            CLOSE CUPARENTENTITY;

            OPEN ORCENTITIES FOR
            SELECT *
            FROM
            (
            SELECT
                EXECUTABLE_ID,
            	ENTITY_ID,
                PARENT_ENTITY_ID,
            	DISPLAY_TYPE,
            	LEVEL_,
            	POSITION_IN_LEVEL,
        	    ICON_,
            	DEFAULT_WHERE,
        	    JOIN_CONDITION,
            	READ_ONLY,
        	    ALLOW_INSERT,
            	ALLOW_DELETE,
            	CONFIGURA_TYPE_ID,
          	    DAGE_ENTITY.FSBGETNAME_(ENTITY_ID) NAME_,
           	    DAGE_ENTITY.FSBGETDESCRIPTION(ENTITY_ID) DESCRIPTION,
           	    DAGE_ENTITY.FSBGETDISPLAY_NAME(ENTITY_ID) DISPLAY_NAME,
                DAGE_ENTITY.FSBGETNAME_(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_NAME,
                DAGE_ENTITY.FSBGETDISPLAY_NAME(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_DISP_NAME,
                RCSA_EXECUTABLE.PARENT_EXECUTABLE_ID PARENT_EXEC_ID,
                RCSA_EXECUTABLE.DESCRIPTION || ' (' || RCSA_EXECUTABLE.NAME || ')' APPLICATION_TITLE,
                DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC,
                GI_BCFRAMEWORKMASTERDETAIL.FSBGETDISPLAYORDERBY(EXECUTABLE_ID,ENTITY_ID) ORDER_BY_COLS
            FROM GI_ENTITY_DISP_DATA
            WHERE EXECUTABLE_ID = INUEXECUTABLEID
            ) B
            START WITH ENTITY_ID = NUPARENTENTITYID
            CONNECT BY PRIOR ENTITY_ID = PARENT_ENTITY_ID
            ORDER SIBLINGS BY POSITION_IN_LEVEL;

            RETURN ORCENTITIES;

        END IF;

        OPEN ORCENTITIES FOR
        SELECT
            EXECUTABLE_ID,
            ENTITY_ID,
            PARENT_ENTITY_ID,
            DISPLAY_TYPE,
            LEVEL_,
            POSITION_IN_LEVEL,
        	ICON_,
            DEFAULT_WHERE,
        	JOIN_CONDITION,
            READ_ONLY,
        	ALLOW_INSERT,
            ALLOW_DELETE,
            CONFIGURA_TYPE_ID,
          	DAGE_ENTITY.FSBGETNAME_(ENTITY_ID) NAME_,
           	DAGE_ENTITY.FSBGETDESCRIPTION(ENTITY_ID) DESCRIPTION,
           	DAGE_ENTITY.FSBGETDISPLAY_NAME(ENTITY_ID) DISPLAY_NAME,
            DAGE_ENTITY.FSBGETNAME_(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_NAME,
            DAGE_ENTITY.FSBGETDISPLAY_NAME(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_DISP_NAME,
            RCSA_EXECUTABLE.PARENT_EXECUTABLE_ID PARENT_EXEC_ID,
            RCSA_EXECUTABLE.DESCRIPTION || ' (' || RCSA_EXECUTABLE.NAME || ')' APPLICATION_TITLE,
            DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC,
            GI_BCFRAMEWORKMASTERDETAIL.FSBGETDISPLAYORDERBY(EXECUTABLE_ID,ENTITY_ID) ORDER_BY_COLS
        FROM GI_ENTITY_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        RETURN ORCENTITIES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETENTITYTOSHOW
    (
        INUEXECUTABLEID IN NUMBER,
        INUENTITYID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCENTITIES CONSTANTS.TYREFCURSOR;
        RCSA_EXECUTABLE DASA_EXECUTABLE.STYSA_EXECUTABLE;
    BEGIN

        RCSA_EXECUTABLE := DASA_EXECUTABLE.FRCGETRECORD(INUEXECUTABLEID);

        OPEN ORCENTITIES FOR
        SELECT
            EXECUTABLE_ID,
            ENTITY_ID,
            PARENT_ENTITY_ID,
            DISPLAY_TYPE,
            LEVEL_,
            POSITION_IN_LEVEL,
        	ICON_,
            DEFAULT_WHERE,
        	JOIN_CONDITION,
            READ_ONLY,
        	ALLOW_INSERT,
            ALLOW_DELETE,
            CONFIGURA_TYPE_ID,
          	DAGE_ENTITY.FSBGETNAME_(ENTITY_ID) NAME_,
           	DAGE_ENTITY.FSBGETDESCRIPTION(ENTITY_ID) DESCRIPTION,
           	DAGE_ENTITY.FSBGETDISPLAY_NAME(ENTITY_ID) DISPLAY_NAME,
            DAGE_ENTITY.FSBGETNAME_(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_NAME,
            DAGE_ENTITY.FSBGETDISPLAY_NAME(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_DISP_NAME,
            RCSA_EXECUTABLE.PARENT_EXECUTABLE_ID PARENT_EXEC_ID,
            RCSA_EXECUTABLE.DESCRIPTION || ' (' || RCSA_EXECUTABLE.NAME || ')' APPLICATION_TITLE,
            DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC,
            GI_BCFRAMEWORKMASTERDETAIL.FSBGETDISPLAYORDERBY(EXECUTABLE_ID,ENTITY_ID) ORDER_BY_COLS
        FROM GI_ENTITY_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = INUENTITYID;

        RETURN ORCENTITIES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETENTITYTOSHOWBYNAME
    (
        INUEXECUTABLEID     IN NUMBER,
        ISBENTITYNAME       IN VARCHAR2,
        ISBDEFAULTWHERE     IN VARCHAR2

    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCENTITIES CONSTANTS.TYREFCURSOR;
        NUENTITYID  NUMBER;
        RCSA_EXECUTABLE DASA_EXECUTABLE.STYSA_EXECUTABLE;
    BEGIN

        NUENTITYID := GE_BOENTITY.GETENTITYIDBYNAME(ISBENTITYNAME);
        RCSA_EXECUTABLE := DASA_EXECUTABLE.FRCGETRECORD(INUEXECUTABLEID);

        OPEN ORCENTITIES FOR
        SELECT
            EXECUTABLE_ID,
            ENTITY_ID,
            PARENT_ENTITY_ID,
            DISPLAY_TYPE,
            LEVEL_,
            POSITION_IN_LEVEL,
        	ICON_,
            ISBDEFAULTWHERE DEFAULT_WHERE,
        	JOIN_CONDITION,
            READ_ONLY,
        	'N' ALLOW_INSERT,
            'N' ALLOW_DELETE,
            CONFIGURA_TYPE_ID,
          	DAGE_ENTITY.FSBGETNAME_(ENTITY_ID) NAME_,
           	DAGE_ENTITY.FSBGETDESCRIPTION(ENTITY_ID) DESCRIPTION,
           	DAGE_ENTITY.FSBGETDISPLAY_NAME(ENTITY_ID) DISPLAY_NAME,
            DAGE_ENTITY.FSBGETNAME_(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_NAME,
            DAGE_ENTITY.FSBGETDISPLAY_NAME(NVL(PARENT_ENTITY_ID,ENTITY_ID)) PARENT_ENTITY_DISP_NAME,
            RCSA_EXECUTABLE.PARENT_EXECUTABLE_ID PARENT_EXEC_ID,
            RCSA_EXECUTABLE.DESCRIPTION || ' (' || RCSA_EXECUTABLE.NAME || ')' APPLICATION_TITLE,
            DECODE(CONFIGURA_TYPE_ID,NULL,NULL,DAGR_CONFIGURA_TYPE.FSBGETDESCRIPTION(CONFIGURA_TYPE_ID)) CONF_TYPE_DESC,
            GI_BCFRAMEWORKMASTERDETAIL.FSBGETDISPLAYORDERBY(EXECUTABLE_ID,ENTITY_ID) ORDER_BY_COLS
        FROM GI_ENTITY_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = NUENTITYID;

        RETURN ORCENTITIES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETENTITYPRIMARYKEY
    (
        ISBENTITYNAME     IN VARCHAR2
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCATTRIBUTES CONSTANTS.TYREFCURSOR;
        NUENTITYID NUMBER;
    BEGIN

        NUENTITYID := GE_BOENTITY.GETENTITYIDBYNAME(ISBENTITYNAME);

        OPEN ORCATTRIBUTES FOR
        SELECT TECHNICAL_NAME
        FROM GE_ENTITY_ATTRIBUTES
        WHERE ENTITY_ID = NUENTITYID
          AND KEY_ = 'Y'
        ORDER BY SECUENCE_;

        RETURN ORCATTRIBUTES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION FRCGETATTRIBUTESTOSHOW
    (
        INUEXECUTABLEID IN NUMBER,
        INUENTITYID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCATTRIBUTES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCATTRIBUTES FOR
        SELECT A.*, B.*, C.*
        FROM GE_ENTITY_ATTRIBUTES A, GI_ATTRIB_DISP_DATA B, GE_ATTR_VAL_EXPRESS C
        WHERE B.EXECUTABLE_ID = INUEXECUTABLEID
          AND A.ENTITY_ID = INUENTITYID
          AND A.ENTITY_ID = B.ENTITY_ID
          AND A.STATUS <> 'B'
          AND A.ENTITY_ATTRIBUTE_ID = B.ENTITY_ATTRIBUTE_ID
          AND B.ENTITY_ATTRIBUTE_ID = C.ENTITY_ATTRIBUTE_ID(+)
        ORDER BY B.POSITION;

        RETURN ORCATTRIBUTES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;



    FUNCTION FBLREFERENTIALRELATION
    (
        INUPARENTENTITYID IN NUMBER,
        INUCHILDENTITYID IN NUMBER
    )
    RETURN BOOLEAN
    IS
        NURELEXISTS NUMBER;
        BLREFREL BOOLEAN;
    BEGIN
        BLREFREL := FALSE;
        SELECT COUNT(ENTITY_REFERENCE_ID) INTO NURELEXISTS
        FROM GE_ENTITY_REFERENCE WHERE PARENT_ENTITY_ID = INUPARENTENTITYID
        AND CHILD_ENTITY_ID = INUCHILDENTITYID;

        IF (NURELEXISTS > 0) THEN
            BLREFREL := TRUE;
        END IF;

        RETURN BLREFREL;
    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETENTITYATTRIBUTES
    (
        INUENTITYID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCATTRIBUTES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCATTRIBUTES FOR
        SELECT *
        FROM GE_ENTITY_ATTRIBUTES
        WHERE ENTITY_ID = INUENTITYID;

        RETURN ORCATTRIBUTES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETATTRIBALLOWEDVALUES
    (
        INUATTRIBUTEID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCATTRIBUTES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCATTRIBUTES FOR
        SELECT VALUE_, DESCRIPTION
        FROM GE_ATTR_ALLOWED_VALUES
        WHERE ENTITY_ATTRIBUTE_ID = INUATTRIBUTEID;

        RETURN ORCATTRIBUTES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FSBDUPLICATEATTRIBCASE
    (
        INUEXECUTABLEID    IN NUMBER,
        INUATTRIBUTEID     IN NUMBER,
        ISBSTYLECASE       IN VARCHAR2
    )
    RETURN VARCHAR2
    IS

        SBDUPEXEC   VARCHAR2(2000);

        CURSOR CUDUPCASE
        IS
        SELECT EXECUTABLE_ID, ENTITY_ID, ENTITY_ATTRIBUTE_ID, STYLE_CASE
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID > 0
          AND ENTITY_ID > 0
          AND ENTITY_ATTRIBUTE_ID = INUATTRIBUTEID;

    BEGIN

        SBDUPEXEC := NULL;

        IF (NOT DASA_EXECUTABLE.FBLEXIST(INUEXECUTABLEID)) THEN
            RETURN SBDUPEXEC;
        END IF;

        FOR RG IN CUDUPCASE LOOP

            IF (RG.STYLE_CASE <> ISBSTYLECASE AND RG.EXECUTABLE_ID <> INUEXECUTABLEID ) THEN

                SBDUPEXEC := RG.EXECUTABLE_ID ||
                            ' [' ||DASA_EXECUTABLE.FSBGETNAME(RG.EXECUTABLE_ID) || '] - ' ||
                             DASA_EXECUTABLE.FSBGETDESCRIPTION(RG.EXECUTABLE_ID);
                EXIT;

            END IF;

        END LOOP;

        RETURN SBDUPEXEC;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    FUNCTION FRCGETORDERBYCOLUMNS
    (
        INUEXECUTABLEID    IN NUMBER,
        INUENTITYID     IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
        ORCATTRIBUTES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCATTRIBUTES FOR
        SELECT ENTITY_ATTRIBUTE_ID,
               DAGE_ENTITY_ATTRIBUTES.FSBGETDISPLAY_NAME(ENTITY_ATTRIBUTE_ID) DISPLAY_NAME,
               SELECTION_ORDER
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = INUENTITYID
          AND SELECTION_ORDER IS NOT NULL
        ORDER BY SEL_ORDER_SEQ;

        RETURN ORCATTRIBUTES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FSBGETORDERBY
    (
        INUEXECUTABLEID    IN NUMBER,
        INUENTITYID     IN NUMBER
    )
    RETURN VARCHAR2
    IS
        SBORDERBY   VARCHAR2(32767);

        CURSOR CUCOLUMNS
        IS
        SELECT DAGE_ENTITY.FSBGETNAME_(ENTITY_ID) ENTITY_NAME,
               DAGE_ENTITY_ATTRIBUTES.FSBGETTECHNICAL_NAME(ENTITY_ATTRIBUTE_ID) TECHNICAL_NAME,
               SELECTION_ORDER
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = INUENTITYID
          AND SELECTION_ORDER IS NOT NULL
        ORDER BY SEL_ORDER_SEQ;

    BEGIN

        SBORDERBY := NULL;

        FOR RG IN CUCOLUMNS LOOP

            IF (UPPER(RG.SELECTION_ORDER) = 'A' ) THEN
                SBORDERBY := SBORDERBY || RG.ENTITY_NAME || '.' || RG.TECHNICAL_NAME || ' ASC, ';
            END IF;

            IF (UPPER(RG.SELECTION_ORDER) = 'D' ) THEN
                SBORDERBY := SBORDERBY || RG.ENTITY_NAME || '.' || RG.TECHNICAL_NAME || ' DESC, ';
            END IF;

        END LOOP;

        IF (SBORDERBY IS NULL) THEN
            RETURN SBORDERBY;
        END IF;

        SBORDERBY := SBORDERBY || 'XXX';
        SBORDERBY := REPLACE(SBORDERBY,', XXX','');

        RETURN SBORDERBY;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETMODULES
    RETURN CONSTANTS.TYREFCURSOR
    IS
         ORCMODULES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCMODULES FOR
        SELECT *
        FROM GE_MODULE;

        RETURN ORCMODULES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FRCGETCONFIGTYPES
    (
        INUMODULEID IN NUMBER
    )
    RETURN CONSTANTS.TYREFCURSOR
    IS
         ORCCONFIGTYPES CONSTANTS.TYREFCURSOR;
    BEGIN

        OPEN ORCCONFIGTYPES FOR
        SELECT *
        FROM GR_CONFIGURA_TYPE
        WHERE MODULE_ID = INUMODULEID;

        RETURN ORCCONFIGTYPES;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    FUNCTION FSBGETDISPLAYORDERBY
    (
        INUEXECUTABLEID    IN NUMBER,
        INUENTITYID     IN NUMBER
    )
    RETURN VARCHAR2
    IS
        SBORDERBY   VARCHAR2(32767);

        CURSOR CUCOLUMNS
        IS
        SELECT DAGE_ENTITY_ATTRIBUTES.FSBGETDISPLAY_NAME(ENTITY_ATTRIBUTE_ID) DISPLAY_NAME,
               SELECTION_ORDER
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = INUENTITYID
          AND SELECTION_ORDER IS NOT NULL
        ORDER BY SEL_ORDER_SEQ;

    BEGIN

        SBORDERBY := NULL;

        FOR RG IN CUCOLUMNS LOOP

            IF (UPPER(RG.SELECTION_ORDER) = 'A' ) THEN
                SBORDERBY := SBORDERBY || RG.DISPLAY_NAME || ' ASC, ';
            END IF;

            IF (UPPER(RG.SELECTION_ORDER) = 'D' ) THEN
                SBORDERBY := SBORDERBY || RG.DISPLAY_NAME || ' DESC, ';
            END IF;

        END LOOP;

        IF (SBORDERBY IS NULL) THEN
            RETURN SBORDERBY;
        END IF;

        SBORDERBY := SBORDERBY || 'XXX';
        SBORDERBY := REPLACE(SBORDERBY,', XXX','');

        RETURN SBORDERBY;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    FUNCTION FBLSAMEATTRIBSAMOUNT
    (
        INUEXECUTABLEID    IN NUMBER,
        INUENTITYID     IN NUMBER
    )
    RETURN BOOLEAN
    IS

        BLSAMEATTRIBS       BOOLEAN;
        NUEXECUTABLECOLUMNS NUMBER;
        NUENTITYCOLUMNS     NUMBER;
        
        NUSCHEMECOLUMNS     NUMBER;

        CURSOR CUEXECUTABLECOLUMNS
        IS
        SELECT COUNT(*)
        FROM GI_ATTRIB_DISP_DATA
        WHERE EXECUTABLE_ID = INUEXECUTABLEID
          AND ENTITY_ID = INUENTITYID;

        CURSOR CUENTITYCOLUMNS
        IS
        SELECT COUNT(*)
        FROM GE_ENTITY_ATTRIBUTES
        WHERE ENTITY_ID = INUENTITYID
          AND STATUS <> 'B';

    BEGIN

        BLSAMEATTRIBS := TRUE;

        OPEN CUEXECUTABLECOLUMNS;
        FETCH CUEXECUTABLECOLUMNS INTO NUEXECUTABLECOLUMNS;
        CLOSE CUEXECUTABLECOLUMNS;

        OPEN CUENTITYCOLUMNS;
        FETCH CUENTITYCOLUMNS INTO NUENTITYCOLUMNS;
        CLOSE CUENTITYCOLUMNS;

        IF (NUEXECUTABLECOLUMNS <> NUENTITYCOLUMNS) THEN
            BLSAMEATTRIBS := FALSE;
        ELSE
            OPEN CUCOUNTSCHEMECOLUMNS(INUENTITYID);
            FETCH CUCOUNTSCHEMECOLUMNS INTO NUSCHEMECOLUMNS;
            CLOSE CUCOUNTSCHEMECOLUMNS;

            IF (NUSCHEMECOLUMNS <> NUENTITYCOLUMNS) THEN
                BLSAMEATTRIBS := FALSE;
            END IF;
        END IF;

        RETURN BLSAMEATTRIBS;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE DELAPPLICATION
    (
        INUEXECUTABLEID IN NUMBER
    )
    IS
    BEGIN
        DELETE SA_MENU_OPTION
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_ROLE_EXECUTABLES
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_EXEC_ENTITIES
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_ATTR_ROLE_EXEC
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_ENT_ROLE_EXEC
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_PEXEC_ACTION_FRM
        WHERE PARENT_EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_USER_EXCEPTIONS
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

        DELETE SA_EXECUTABLE
        WHERE EXECUTABLE_ID = INUEXECUTABLEID;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    

















    PROCEDURE ENTITIESCHILDRELATED
    (
        INUENTITYID         IN  GE_ENTITY.ENTITY_ID%TYPE,
        OCUCHILDENTITIES    OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN OCUCHILDENTITIES FOR
            SELECT GE.NAME_, GE.DISPLAY_NAME
            FROM GE_ENTITY_REFERENCE GER, GE_ENTITY GE
            WHERE PARENT_ENTITY_ID = INUENTITYID
            AND GER.CHILD_ENTITY_ID = GE.ENTITY_ID;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;

    END;

    
















    PROCEDURE COLUMNINFO
    (
        INUENTITYID       IN  GE_ENTITY.ENTITY_ID%TYPE,
        OCUCOLUMNINFO     OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN OCUCOLUMNINFO FOR
            SELECT /*+ USE_NL(GEA, GAT) */
            GEA.ENTITY_ATTRIBUTE_ID, GEA.TECHNICAL_NAME, GEA.DISPLAY_NAME, GEA.COMMENT_, GAT.DESCRIPTION, GEA.PRECISION, GEA.SCALE, GEA.LENGTH
            FROM GE_ENTITY_ATTRIBUTES GEA, GE_ATTRIBUTES_TYPE GAT
            WHERE GEA.ENTITY_ID = INUENTITYID
            AND GEA.ATTRIBUTE_TYPE_ID = GAT.ATTRIBUTE_TYPE_ID;

    END;

    
















    PROCEDURE ENTITIESPARENTRELATED
    (
        INUENTITYID          IN  GE_ENTITY.ENTITY_ID%TYPE,
        OCUPARENTENTITIES    OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN OCUPARENTENTITIES FOR
            SELECT GE.NAME_, GE.DISPLAY_NAME
            FROM GE_ENTITY_REFERENCE GER, GE_ENTITY GE
            WHERE GER.CHILD_ENTITY_ID = INUENTITYID
            AND GER.PARENT_ENTITY_ID = GE.ENTITY_ID;

    EXCEPTION

        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    














    FUNCTION FNUCOUNTSCHEMECOL(INUENTITYID IN  GE_ENTITY.ENTITY_ID%TYPE)
    RETURN NUMBER
    IS
    BEGIN
        UT_TRACE.TRACE('Inicia GI_BCFrameWorkMasterDetail.fnuCountSchemeCol ['||INUENTITYID||']',15);

        FOR RCROW IN CUCOUNTSCHEMECOLUMNS(INUENTITYID) LOOP
            UT_TRACE.TRACE('Finaliza GI_BCFrameWorkMasterDetail.fnuCountSchemeCol ['||RCROW.COLUMNSCOUNTED||']',15);
            RETURN RCROW.COLUMNSCOUNTED;
        END LOOP;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('Error : ex.CONTROLLED_ERROR',15);
            RAISE;

        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error : others',15);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

END GI_BCFRAMEWORKMASTERDETAIL;