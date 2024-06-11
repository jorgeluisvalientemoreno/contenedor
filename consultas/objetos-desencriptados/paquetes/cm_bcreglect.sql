PACKAGE BODY CM_BCRegLect
IS
    


























    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO212519';

    
    
    

    
    
    

    
    
    
    













    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;

    





















    PROCEDURE GETCONSPERTOPROC
    (
        IDTDATE         IN  DATE,
        OTBCONSPERS     OUT CM_BCREGLECT.TYTBPERICOSE
    )
    IS
        CURSOR CUCONSPERTOPROC
        IS
            SELECT /*+ leading(ciclcons)
                       use_nl(ciclcons pericose)
                       index(pericose IX_PERICOSE03) */
                PERICOSE.PECSCONS,
                PERICOSE.PECSFECI,
                PERICOSE.PECSCICO
            FROM
                CICLCONS,
                PERICOSE
                /*+ CM_BCRegLect.GetConsPerToProc SAO207123 */
            WHERE CICLCONS.CICOGELE = 'S'
              AND CICLCONS.CICOCODI = PERICOSE.PECSCICO
              AND TRUNC(PERICOSE.PECSFECF) = IDTDATE;
    BEGIN
        OPEN CUCONSPERTOPROC;

        FETCH CUCONSPERTOPROC BULK COLLECT INTO OTBCONSPERS;

        CLOSE CUCONSPERTOPROC;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUCONSPERTOPROC%ISOPEN) THEN
                CLOSE CUCONSPERTOPROC;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUCONSPERTOPROC%ISOPEN) THEN
                CLOSE CUCONSPERTOPROC;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCONSPERTOPROC;
    
    





















    FUNCTION FNUGETCURRCONSPERIODBYPROD
    (
        INUSESUNUSE IN SERVSUSC.SESUNUSE%TYPE,
        IDTDATE     IN DATE DEFAULT UT_DATE.FDTSYSDATE
    )
    RETURN PERICOSE.PECSCONS%TYPE
    IS
        CURSOR CUCONSPERIOD
        IS
            SELECT  /*+ leading(servsusc)
                        use_nl(servsusc pericose)
                        index(pericose IX_PERICOSE01) */
                    PECSCONS
            FROM    SERVSUSC,
                    PERICOSE
                    /*+ CM_BCRegLect.fnuGetCurrConsPeriodByProd SAO212519 */
            WHERE   SESUNUSE = INUSESUNUSE
            AND     SESUCICO = PECSCICO
            AND     IDTDATE BETWEEN PECSFECI AND PECSFECF;
    BEGIN
        FOR RCCONSPERIOD IN CUCONSPERIOD LOOP
            RETURN RCCONSPERIOD.PECSCONS;
        END LOOP;

        RETURN -1;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETCURRCONSPERIODBYPROD;
    
    




















    FUNCTION FNUGETPREVCONSPERIOD
    (
        INUPERICOSE    IN PERICOSE.PECSCONS%TYPE,
        IDTINITIALDATE IN PERICOSE.PECSFECI%TYPE,
        INUCICLCONS    IN CICLCONS.CICOCODI%TYPE
    )
    RETURN PERICOSE.PECSCONS%TYPE
    IS
        NUPECSCONS  PERICOSE.PECSCONS%TYPE;       
        DTSYSDATE   DATE := UT_DATE.FDTSYSDATE;   

        CURSOR CUCONSPERIOD
        IS
            SELECT /*+ index_desc(pericose IX_PERICOSE01) */
                   PERICOSE.PECSCONS
            FROM   PERICOSE
                   /*+ CM_BCRegLect.fnuGetPrevConsPeriod SAO207123 */
            WHERE  PERICOSE.PECSCICO = INUCICLCONS
               AND PERICOSE.PECSFECI < IDTINITIALDATE
               AND PERICOSE.PECSCONS <> INUPERICOSE
            ORDER BY PERICOSE.PECSFECI DESC;
    BEGIN

        FOR RCCONSPERIOD IN CUCONSPERIOD LOOP
            RETURN RCCONSPERIOD.PECSCONS;
        END LOOP;

        RETURN NULL;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FNUGETPREVCONSPERIOD;

END CM_BCREGLECT;