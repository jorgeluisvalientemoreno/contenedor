PACKAGE MO_BCWfPackInterfac IS


































    
    
    
    

















    CURSOR CUWFPACKINTERFAC
        (
        INUPACKAGEID        IN MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE,
        INUACTIONID         IN MO_WF_PACK_INTERFAC.ACTION_ID%TYPE,
        INUSTATUSACTIVITYID IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE
        )
    IS
        SELECT  /*+index(a IDX_MO_WF_PACK_INTERFAC_02)*/A.*, A.ROWID
        FROM MO_WF_PACK_INTERFAC A  /*+MO_BCWfPackInterfac.cuWfPackInterfac*/
        WHERE A.PACKAGE_ID = INUPACKAGEID
        AND A.ACTION_ID = INUACTIONID
        AND A.STATUS_ACTIVITY_ID = INUSTATUSACTIVITYID;


    

















    CURSOR CUEXISTACTIVITY
        (
        INUPACKAGEID        IN MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE,
        INUACTIONID         IN MO_WF_PACK_INTERFAC.ACTION_ID%TYPE,
        INUSTATUSACTIVITYID IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE
        )
    IS
        SELECT  /*+index(a IDX_MO_WF_PACK_INTERFAC_02)*/ COUNT(A.PACKAGE_ID) NUCOUNT
        FROM MO_WF_PACK_INTERFAC A/*+MO_BCWfPackInterfac.cuExistActivity*/
        WHERE A.PACKAGE_ID = INUPACKAGEID
        AND A.ACTION_ID = INUACTIONID
        AND A.STATUS_ACTIVITY_ID = INUSTATUSACTIVITYID
        AND ROWNUM = 1;


    
    
    
    



    FUNCTION FSBVERSION  RETURN VARCHAR2;

    
















    FUNCTION FRFGETACTIVPACKNOFINISH
        (
        INUPACKAGEID    IN MO_PACKAGES.PACKAGE_ID%TYPE,
        INUACTIVITYID   IN MO_WF_PACK_INTERFAC.ACTIVITY_ID%TYPE DEFAULT NULL
        )
    RETURN CONSTANTS.TYREFCURSOR;
    
    

















    FUNCTION FRCACTIVITIESSTANDBY
        (
        INUPACKAGE_ID   IN  MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE,
        INUACTION_ID    IN  MO_WF_PACK_INTERFAC.ACTION_ID%TYPE,
        INUSEQUENCE     IN  NUMBER DEFAULT 0
        )
    RETURN CONSTANTS.TYREFCURSOR;
    
    
    













    CURSOR CUMOWFPACKINTERFAC
    (
        INUACTIVITYID       IN MO_WF_PACK_INTERFAC.ACTIVITY_ID%TYPE,
        INUSTATUSACTIVID    IN MO_WF_PACK_INTERFAC.STATUS_ACTIVITY_ID%TYPE
    )
    IS
        SELECT A.*, A.ROWID
        FROM MO_WF_PACK_INTERFAC A
        WHERE A.ACTIVITY_ID = INUACTIVITYID
        AND A.STATUS_ACTIVITY_ID = INUSTATUSACTIVID;

    














    CURSOR CUWFPACKINTERFACE
    (
        INUACTIVITYID   IN  MO_WF_PACK_INTERFAC.ACTIVITY_ID%TYPE,
        INUPACKAGEID    IN  MO_WF_PACK_INTERFAC.PACKAGE_ID%TYPE
    )
    IS
        SELECT WF_PACK_INTERFAC_ID
        FROM MO_WF_PACK_INTERFAC
        WHERE ACTIVITY_ID = INUACTIVITYID
        AND PACKAGE_ID = INUPACKAGEID;



    














    FUNCTION FBOPACKAGEHASFLOW
    (
        INUPACKAGEID IN MO_PACKAGES.PACKAGE_ID%TYPE
    )
    RETURN BOOLEAN;
    

END MO_BCWFPACKINTERFAC;