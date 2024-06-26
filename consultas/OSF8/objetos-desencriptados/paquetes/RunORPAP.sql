PROCEDURE RunORPAP
(
    INUTOTALTHREAD       IN GE_PROCESS_EXECUTOR.THREAD%TYPE,
    ISBFILEPATH          IN CC_FILE.FILE_SYS_LOCATION%TYPE,
    ISBFILENAME          IN CC_FILE.FILE_NAME%TYPE,
    ISBINITIALDATE       IN UT_DATATYPES.STYMAXVARCHAR,
    ISBFINALDATE         IN UT_DATATYPES.STYMAXVARCHAR,
    ISBOPERUNITID        IN UT_DATATYPES.STYMAXVARCHAR,
    ISBCOPRIDCO          IN UT_DATATYPES.STYMAXVARCHAR,
    ISBPROCESSNAME       IN UT_DATATYPES.STYMAXVARCHAR
)

























IS

    
    NUERRORCODE          ST_BOBACKGROUNDPROCESS.STYNUMBER;

BEGIN
    UT_TRACE.TRACE('BEGIN RunORPAP', 30);


    
    ST_BOBACKGROUNDPROCESS.SETTOTALTHREADS(INUTOTALTHREAD);
    ST_BOBACKGROUNDPROCESS.SETPROGRAMNAME(OR_BCORDER.CSBORPAP);
    NUERRORCODE := ST_BOBACKGROUNDPROCESS.FNURUNTHREADEDPROCESS(
        'OR_BOActivitiesLegalizeByFile.LegalizeFromFile',
        ISBPROCESSNAME,
        ST_BOBACKGROUNDPROCESS.CSBPARTITION,
        ST_BOBACKGROUNDPROCESS.CSBTOTAL,
        ISBFILEPATH,
        ISBFILENAME,
        ISBINITIALDATE,
        ISBFINALDATE,
        ISBOPERUNITID,
        ISBCOPRIDCO
    );

    
    IF (NUERRORCODE = ST_BOBACKGROUNDPROCESS.CNUENDED_WITH_ERR) THEN
        PKSTATUSEXEPROGRAMMGR.PROCESSFINISHNOKAT(ISBPROCESSNAME);
        
        OR_BOORDER.UPDPROCFINBYSESSION(ISBCOPRIDCO);
    END IF;

    UT_TRACE.TRACE('END RunORPAP', 30);
EXCEPTION
    WHEN OTHERS THEN
        UT_TRACE.TRACE('Others exception in [RunORPAP]', 30);
        IF(ISBPROCESSNAME IS NOT NULL)THEN
            PKSTATUSEXEPROGRAMMGR.PROCESSFINISHNOKAT(ISBPROCESSNAME);
        END IF;
        
        OR_BOORDER.UPDPROCFINBYSESSION(ISBCOPRIDCO);
        RAISE;
END RUNORPAP;