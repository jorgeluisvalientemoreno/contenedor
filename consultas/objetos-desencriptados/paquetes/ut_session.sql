PACKAGE BODY UT_session AS






















































































































































        
        CSBVERSION CONSTANT VARCHAR2(250) := 'SAO304715';

        
        CSBUSER      CONSTANT VARCHAR2(50) := USER;
        CNUSESSIONID CONSTANT NUMBER(21)   := NVL(USERENV('SESSIONID'),'NO SESSION');
        CSBIPADDRESS CONSTANT VARCHAR2(50) := NVL(UT_CONTEXT.GETCONTEXTVARIABLE('USERENV','IP_ADDRESS'),'NO IP');
        CNUAUDSID CONSTANT NUMBER          := UT_CONTEXT.GETCONTEXTVARIABLE('USERENV','SESSIONID');
        
        BOSTATSLOADED      BOOLEAN := FALSE;
        NUCPU_USED        NUMBER(2);
        NUMEMORY_USED     NUMBER(2);
        NUOPENCURSORS     NUMBER(2);

        CSBEXCAPP            CONSTANT SA_EXECUTABLE.NAME%TYPE := 'SACME';
        CSBSESSIONSTATUS     CONSTANT VARCHAR2(6) := 'KILLED';
        CSBMULTISESSDISABLED CONSTANT SA_USER.MULTISESSION_ENABLED%TYPE := 'N';

        CNUERR4886 CONSTANT NUMBER(4) := 4886; 

        
        SBTERMINAL  VARCHAR2(50) := NVL(USERENV('TERMINAL'),'NO TERMINAL');
        SBPROGRAM VARCHAR2(100)  := NULL;
        DTLOGON_DATE DATE        := NULL;
        SBMACHINE VARCHAR2(50);
        SBOSUSER VARCHAR2(50);
        SBERRMSG	             GE_ERROR_LOG.DESCRIPTION%TYPE;   

        GSBCURRENTSPID VARCHAR2(20) := NULL;

        
        TYPE TY_REF_CURSOR IS REF CURSOR;
        
        
        
        
        
        CURSOR CUSESSION
        IS
        SELECT *
        FROM   GV$SESSION
        WHERE  AUDSID = USERENV('sessionid');
        
        CURSOR CUEXISTSESSION ( INUAUDSID    IN NUMBER,
    			    INUSID       IN NUMBER,
    			    INUSERIAL#   IN NUMBER )
        IS
        SELECT COUNT(*)
        FROM   GV$SESSION
        WHERE  AUDSID  = INUAUDSID
        AND    SID     = INUSID
        AND    SERIAL# = INUSERIAL# ;


    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;
    
     PROCEDURE LOADSTATVARS
    IS
    BEGIN

        IF NOT BOSTATSLOADED THEN

            NUCPU_USED        := UT_SESSION.FNUGETSTATISTIC('CPU_Used');
            NUMEMORY_USED     := UT_SESSION.FNUGETSTATISTIC('Memory_Used');
            NUOPENCURSORS     := UT_SESSION.FNUGETSTATISTIC('OpenCursors');

            BOSTATSLOADED := TRUE;

        END IF;

    END;

    
    FUNCTION GETSESSIONID
    RETURN NUMBER
    IS
    BEGIN
       RETURN CNUSESSIONID;
    END;

    
    FUNCTION GETTERMINAL
    RETURN VARCHAR2
    IS
    BEGIN
       IF SBTERMINAL IS NULL THEN
          RETURN GETMACHINEOFCURRENTUSER;
       ELSE
          RETURN SBTERMINAL;
       END IF;
    END;

    
    FUNCTION GETMACHINE
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN GETMACHINEOFCURRENTUSER; 
    END;

    
    FUNCTION GETUSER
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN CSBUSER;
    END;

    FUNCTION GETIP
    RETURN VARCHAR2
    IS
    BEGIN
        RETURN CSBIPADDRESS;
    END;

    
    PROCEDURE KILLUSERS
    (
        SBUSERS IN VARCHAR2
    )
    IS
       CURSOR CUSESSIONS IS
              SELECT SID, SERIAL#
              FROM GV$SESSION
              WHERE OSUSER LIKE SBUSERS;

       SBCOMMAND VARCHAR2(1000);
    BEGIN
       
       FOR REG IN CUSESSIONS LOOP
           SBCOMMAND := 'alter system kill session ' ||
                        '''' || REG.SID || ',' || REG.SERIAL# || '''';
           EXECUTE IMMEDIATE SBCOMMAND;
       END LOOP;
       
    END;

    









    FUNCTION GETNUMBEROFSESSIONSBYUSER
    (
        ISBUSERNAME IN VARCHAR2
    )
    RETURN NUMBER
    IS
    



       CUUSERSESSIONS TY_REF_CURSOR;
       NUCOUNT        NUMBER(4) := 0;
       
    BEGIN
    
       OPEN CUUSERSESSIONS FOR
            SELECT COUNT(*)
            FROM GV$SESSION
            WHERE USERNAME = UPPER(ISBUSERNAME);
            
       FETCH CUUSERSESSIONS INTO NUCOUNT;
       CLOSE CUUSERSESSIONS;
       
       RETURN NUCOUNT;
       
    EXCEPTION
        WHEN OTHERS THEN
            RAISE;
    END;

    
    FUNCTION GETNUMBEROFSESSIONSBYCURRUSER
    RETURN NUMBER
    IS
    



    BEGIN
       RETURN GETNUMBEROFSESSIONSBYUSER(USER);
    END;

    









    FUNCTION GETNUMBEROFSESSIONSBYMACHINE
    (
        ISBMACHINENAME IN VARCHAR2
    )
    RETURN NUMBER
    IS
    



       CUUSERSESSIONS TY_REF_CURSOR;
       NUCOUNT        NUMBER(4) := 0;
    BEGIN

       OPEN CUUSERSESSIONS FOR
            SELECT COUNT(*)
            FROM GV$SESSION
            WHERE UPPER(MACHINE) = UPPER(ISBMACHINENAME);
            
       FETCH CUUSERSESSIONS INTO NUCOUNT;
       CLOSE CUUSERSESSIONS;
       RETURN NUCOUNT;
       
    END;

    









    FUNCTION GETNUMOFSESSIONSBYSCHEMA
    (
        ISBSCHEMANAME IN VARCHAR2
    )
    RETURN NUMBER
    IS
    



       CUUSERSESSIONS TY_REF_CURSOR;
       NUCOUNT        NUMBER (4) := 0;
       
    BEGIN
    
       OPEN CUUSERSESSIONS FOR
            SELECT COUNT(*)
            FROM GV$SESSION
            WHERE UPPER(SCHEMANAME) = UPPER(ISBSCHEMANAME);
            
       FETCH CUUSERSESSIONS INTO NUCOUNT;
       CLOSE CUUSERSESSIONS;
       RETURN NUCOUNT;
       
    END;

    









    FUNCTION GETNUMOFSESSIONSBYOSUSER
    (
        ISBOSUSER IN VARCHAR2
    )
    RETURN NUMBER
    IS
    



       CUUSERSESSIONS TY_REF_CURSOR;
       NUCOUNT        NUMBER(4) := 0;
    BEGIN

       OPEN CUUSERSESSIONS FOR
              SELECT COUNT(*)
              FROM GV$SESSION
              WHERE UPPER(OSUSER) = UPPER(ISBOSUSER);
              
       FETCH CUUSERSESSIONS INTO NUCOUNT;
       CLOSE CUUSERSESSIONS;
       
       RETURN NUCOUNT;
       
    END;

    









    FUNCTION GETNUMOFSESSIONSBYTERMNAME
    (
        TERMINALNAME IN VARCHAR2
    )
    RETURN NUMBER
    IS
    



       CUUSERSESSIONS TY_REF_CURSOR;
       NUCOUNT        NUMBER(4) := 0;
    BEGIN
       OPEN CUUSERSESSIONS FOR
            SELECT COUNT(*)
            FROM GV$SESSION
            WHERE UPPER(TERMINAL) = UPPER(TERMINALNAME);
            
       FETCH CUUSERSESSIONS INTO NUCOUNT;
       CLOSE CUUSERSESSIONS;
       
       RETURN NUCOUNT;
    END;

    









    FUNCTION GETNUMOFSESSIONSBYUSERANDTERM
    (
        ISBUSERNAME IN VARCHAR2,
        TERMINALNAME IN VARCHAR2
    )
    RETURN NUMBER
    IS
    



       CUUSERSESSIONS TY_REF_CURSOR;
       NUCOUNT        NUMBER (4) := 0;
    BEGIN

       OPEN  CUUSERSESSIONS FOR
            SELECT COUNT(*)
            FROM GV$SESSION
            WHERE USERNAME = UPPER(ISBUSERNAME)
              AND UPPER(TERMINAL) = UPPER(TERMINALNAME);

       FETCH  CUUSERSESSIONS INTO  NUCOUNT;
       CLOSE  CUUSERSESSIONS;

       RETURN  NUCOUNT;
       
    END;

    









    FUNCTION GETSESSIONSBYID
    (
        INUSESIONID IN NUMBER
    )
    RETURN ROWSESSION
    IS
    



       RWSESSION      ROWSESSION;
       CUUSERSESSIONS TY_REF_CURSOR;
       
    BEGIN

       OPEN CUUSERSESSIONS FOR
            SELECT *
            FROM GV$SESSION
            WHERE SID = INUSESIONID;
            
       FETCH CUUSERSESSIONS INTO RWSESSION;
       CLOSE CUUSERSESSIONS;
       
       RETURN RWSESSION;
       
    END;
    
    
    FUNCTION GETMACHINEOFCURRENTUSER
    RETURN VARCHAR2
    IS
    BEGIN

       RETURN SBMACHINE;

    EXCEPTION
       WHEN OTHERS THEN
            RAISE;
    END;

    









    PROCEDURE GETMODULESOFCURRCLIMACHINE
    





    (
       ORFPROGS      OUT TYRFPROGS,
       ISBPROGIGNORE IN GV$SESSION.PROGRAM%TYPE DEFAULT NULL
    )
    IS
       SBCLIENTMACHINE GV$SESSION.MACHINE%TYPE;
    BEGIN

       SBCLIENTMACHINE:=GETMACHINEOFCURRENTUSER;

       IF ISBPROGIGNORE IS NULL THEN
          OPEN ORFPROGS FOR
               SELECT MODULE,ACTION
               FROM GV$SESSION
               WHERE MACHINE=SBCLIENTMACHINE
                 AND STATUS<>'KILLED';
       ELSE
          OPEN ORFPROGS FOR
               SELECT MODULE,ACTION
               FROM GV$SESSION
               WHERE MACHINE=SBCLIENTMACHINE
                 AND MODULE <> ISBPROGIGNORE
                 AND STATUS<>'KILLED';
       END IF;
       
    END;
    
    


















    PROCEDURE SETMODULE
    (
       ISBMODULENAME      IN VARCHAR2,
       ISBACTION          IN VARCHAR2,
       REGISTERONLYIFNULL IN VARCHAR2 DEFAULT GE_BOCONSTANTS.CSBYES
    )
    IS
       SBMODULENAME VARCHAR2(100);
       SBACTION     VARCHAR2(100);
    BEGIN
        IF(REGISTERONLYIFNULL=GE_BOCONSTANTS.CSBYES) THEN
          DBMS_APPLICATION_INFO.READ_MODULE(SBMODULENAME,SBACTION);
          IF (SBMODULENAME IS NULL) AND (SBACTION IS NULL) THEN
             DBMS_APPLICATION_INFO.SET_MODULE(ISBMODULENAME,ISBACTION);
          END IF;
       ELSE
          DBMS_APPLICATION_INFO.SET_MODULE(ISBMODULENAME,ISBACTION);
       END IF;
    END SETMODULE;
    
    PROCEDURE SETCLIENTINFO
    (
       SBCLIENTINFO IN VARCHAR2
    )
    IS
    BEGIN
        DBMS_APPLICATION_INFO.SET_CLIENT_INFO(SBCLIENTINFO);
    END;

    PROCEDURE SETTERMINAL
    (
       ISBTERMINAL      IN VARCHAR2
    )
    IS
    BEGIN
        SBTERMINAL := ISBTERMINAL;
    END;

    
    FUNCTION GETCLIENTINFO
    RETURN VARCHAR2
    IS
        SBCLIENTINFO VARCHAR2(250);
    BEGIN
        DBMS_APPLICATION_INFO.READ_CLIENT_INFO(SBCLIENTINFO);
        RETURN SBCLIENTINFO;
    END;

    
    FUNCTION GETACTION
    (
        NUSID IN NUMBER DEFAULT NULL
    )
    RETURN VARCHAR2
    IS
        SBACTION VARCHAR2(250);
        SBMODULE VARCHAR2(200);
    BEGIN

        DBMS_APPLICATION_INFO.READ_MODULE(SBMODULE,SBACTION);

        RETURN SBACTION;

    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'NULL';
    END;

    
    PROCEDURE SETCACHEDCURSOR
    (
       NUCURSOR IN INTEGER
    )
    IS
    BEGIN
        EXECUTE IMMEDIATE 'ALTER SESSION SET SESSION_CACHED_CURSORS = '||NUCURSOR;
    END;

    
    FUNCTION GETMODULE
    RETURN VARCHAR2
    IS
        SBMODULE VARCHAR2(250);
        SBACTION VARCHAR2(250);
    BEGIN
        GETMODULE(SBMODULE,SBACTION);
        RETURN SBMODULE;
    END;

    
    PROCEDURE GETMODULE
    (
       OSBMODULENAME OUT VARCHAR2,
       OSBACTION     OUT VARCHAR2
    )
    IS
    BEGIN
       DBMS_APPLICATION_INFO.READ_MODULE(OSBMODULENAME,OSBACTION);
    END;

    
    FUNCTION GETPROGRAM
    RETURN VARCHAR2
    IS
    
    BEGIN
       RETURN NVL(SBPROGRAM,'Sin programa en la session actual');
    END;















    
    PROCEDURE CHANGECURSORSHARING
    (
        IBLVALUE IN BOOLEAN
    )
    IS
       SBSTATEMENT VARCHAR2(250);
    BEGIN
       IF IBLVALUE THEN
          SBSTATEMENT := 'alter session SET CURSOR_SHARING = FORCE';
       ELSE
           SBSTATEMENT := 'alter session SET CURSOR_SHARING = EXACT';
       END IF;

       EXECUTE IMMEDIATE SBSTATEMENT;
    END;

    
    
    FUNCTION GETSYSTEMCONNECTDATE
    RETURN DATE
    IS
    BEGIN
        RETURN TO_DATE(DTLOGON_DATE,UT_DATE.FSBDATE_FORMAT);
    END;

    












    PROCEDURE INITPROGRAM
    AS
        NUAUDSID NUMBER := NULL;

        CURSOR CUSESSION IS
            SELECT PROGRAM, LOGON_TIME, MACHINE, OSUSER
              FROM GV$SESSION
             WHERE AUDSID = NUAUDSID
               AND ROWNUM = 1;
    BEGIN

        NUAUDSID := UT_CONTEXT.GETCONTEXTVARIABLE('USERENV','SESSIONID');

        OPEN CUSESSION;

        FETCH CUSESSION INTO  SBPROGRAM, DTLOGON_DATE, SBMACHINE, SBOSUSER;

        IF SBPROGRAM IS NULL THEN
            SBPROGRAM := 'NO PROGRAM';
        END IF;

        
        IF SBOSUSER IS NULL THEN
            SBOSUSER := 'EJECUTOR';
        END IF;
        
        IF SBMACHINE IS NULL THEN
            SBMACHINE := 'NOMACHINE';
        END IF;

        IF ( CUSESSION%NOTFOUND ) THEN
            CLOSE CUSESSION;
            RAISE NO_DATA_FOUND;
        END IF;

        CLOSE CUSESSION;

    EXCEPTION
        WHEN OTHERS THEN
            IF CUSESSION%ISOPEN THEN
                CLOSE CUSESSION;
            END IF;
            RAISE;
    END;













    
    FUNCTION GETOSUSER
    RETURN VARCHAR2
    IS
    BEGIN
       RETURN SBOSUSER;
    END;

    
    
    
    FUNCTION FSBGETACOUNTSTATUS
    (
        ISBMASK IN VARCHAR2
    )
    RETURN VARCHAR2
    IS
        SBSTATUS VARCHAR2(32) ;

        CURSOR CUDATA ( ISBMASK VARCHAR2 )
        IS
            SELECT DBA_USERS.ACCOUNT_STATUS
            FROM DBA_USERS
            WHERE DBA_USERS.USERNAME = ISBMASK;

    BEGIN
        OPEN CUDATA (ISBMASK);
        FETCH CUDATA INTO SBSTATUS;
        
        CLOSE CUDATA;
        RETURN SBSTATUS;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUDATA%ISOPEN THEN
                CLOSE CUDATA;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF CUDATA%ISOPEN THEN
                CLOSE CUDATA;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    
    PROCEDURE GETACTIVEPROCESSEXECINSESSION
    (
        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN ORFREFCURSOR FOR
             SELECT /*+index(a PK_GE_MONITOR_LOG)*/
                DAGE_PROCESS_EXECUTOR.FSBGETDESCRIPTION(A.PROCESS_EXECUTOR_ID)||
                    ' - ('||A.PROCESS_EXECUTOR_ID||')' PROCESS_EXECUTOR,
                A.PROCESS_EXECUTOR_ID,
                A.SESSION_ID,
                A.THREAD_NUMBER,
                DAGE_PROCESS_EXECUTOR.FSBGETSTATUS(A.PROCESS_EXECUTOR_ID) STATUS,
                A.DATE_START,
                A.DATE_END_EXECUTION,
                A.LAST_TIME_EXEC,
                A.MAX_TIME_EXEC,
                A.MIN_TIME_EXEC,
                A.TOTAL_TIME_EXEC,
                A.AVG_TIME_EXEC,
                A.TOTAL_RECORDS,
                A.TOTAL_EXEC,
                A.FAILURE_RECORDS,
                MACHINE,
                DECODE(S.STATUS, NULL,'INACTIVE', S.STATUS) THREAD_STATUS
            FROM GE_MONITOR_LOG A, GV$SESSION S
            WHERE A.SESSION_ID = S.AUDSID(+);
    END;
    
    
    PROCEDURE GETSERVERLOCKS
    (
        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN

        OPEN ORFREFCURSOR FOR
            SELECT S.TERMINAL,
                   P.USERNAME,
                   S.USERNAME ORA,
                   S.CLIENT_INFO,
                   S.PROGRAM,
                   S.SID SID,
                   S.SERIAL# SERIAL#,
                   DECODE
                   (
                        L2.TYPE,
                        'TM','ROW LOCK',
                        'TX','TRANS. ROW-LEVEL',
                        'RT','REDO-LOG',
                        'TS','TEMPORARY SEGMENT',
                        'TD','TABLE LOCK',
                        'TO','TEMPORARY OBJECT',
                        'CU','CURSOR BIND',
                        L2.TYPE
                    )   TIPO_OBJETO,

                   DECODE(L2.TYPE,
                          'TM','DML '||U.USERNAME||'.'||O.OBJECT_NAME,
                          'TX','TRANS ENQUEUE'               ,
                          'RT','REDO LOG'                  ,
                          'TS',U.USERNAME||'.'||O.OBJECT_NAME  ,
                          'TD',DECODE(L2.LMODE+L2.REQUEST  ,
                                      4,'PARSE '||U.USERNAME||'.'||O.OBJECT_NAME,
                                      6,'DDL',
                                      L2.LMODE+L2.REQUEST),
                          'TO',U.USERNAME||'.'||O.OBJECT_NAME,
                          'CU',U.USERNAME||'.'||O.OBJECT_NAME,
                               L2.TYPE                     )   NOMBRE_OBJETO  ,
                   DECODE(L2.LMODE+L2.REQUEST              ,
                          2   ,'RS'                        ,
                          3   ,'RX'                        ,
                          4   ,'S'                         ,
                          5   ,'SRX'                       ,
                          6   ,'X'                         ,
                               L2.LMODE+L2.REQUEST         )   MODO_BLOQUEO ,
                   DECODE(L2.REQUEST                       ,
                          0,'N'                           ,
                            'Y'                         )   ESPERA_RECURSO
            FROM   GV$PROCESS    P,
                   GV$_LOCK     L1,
                   GV$LOCK      L2,
                   GV$RESOURCE   R,
                   DBA_OBJECTS   O,
                   DBA_USERS     U,
                   GV$SESSION    S
            WHERE
                P.INST_ID = L1.INST_ID
                AND L1.INST_ID = L2.INST_ID
                
                
                AND S.PADDR    = P.ADDR
                AND  S.SADDR     = L1.SADDR
                AND  L1.RADDR   = R.ADDR
                AND  L2.ADDR    = L1.LADDR
                AND  L2.TYPE    <> 'MR'
                AND  R.ID1      = O.OBJECT_ID (+)
                AND  O.OWNER   = U.USERNAME (+)
                AND  P.USERNAME LIKE '%'
            ORDER BY
                   1,
                   2,
                   3,
                   6;
    
    END;

    

    PROCEDURE GETDATASESSION
    (

        ORFREFCURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
      LOADSTATVARS;

        OPEN ORFREFCURSOR FOR
            SELECT
                    SS.SID,
                    SS.AUDSID,
                    SS.OSUSER,
                    SE.VALUE OPENCURSOR,
                    SS.MODULE PROGRAM,
                    S1.OSUSER SESSIONLOCK
            FROM    GV$SESSION SS,
                    GV$SESSTAT SE,
                    GV$LOCK L1,
                    GV$SESSION S1,
                    GV$LOCK L2
            WHERE SE.SID = SS.SID
                AND SE.STATISTIC# = NUOPENCURSORS    
                AND S1.SID (+) = L1.SID
                AND SS.SID=L2.SID (+)
                AND L1.BLOCK (+) = 1
                AND L2.REQUEST (+) > 0
                AND L1.ID1 (+) = L2.ID1
                AND L1.ID2 (+) = L2.ID2
            ORDER BY  OSUSER;


    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    





















    FUNCTION GETSESSIONMODULE
    (
        INUSESSIONID IN  NUMBER
    ) RETURN VARCHAR2
    IS
        SBMODULE    VARCHAR2(4000);
        RFREFCURSOR CONSTANTS.TYREFCURSOR;

    BEGIN
      OPEN RFREFCURSOR FOR
        SELECT  MODULE
        FROM    GV$SESSION
        WHERE   AUDSID = INUSESSIONID;

    FETCH RFREFCURSOR INTO SBMODULE;

    CLOSE RFREFCURSOR;

    RETURN SBMODULE;

    EXCEPTION
        WHEN OTHERS THEN
        
            IF RFREFCURSOR%ISOPEN THEN
             CLOSE RFREFCURSOR;
            END IF;
            
            RETURN '';
        
    END;

    
    PROCEDURE GETAMOUNTMEMORYCPU
    (
        INUSESSIONID   IN  NUMBER,
        ONUMEMORYVALUE OUT NUMBER,
        ONUCPUVALUE    OUT NUMBER,
        ODTSYSDATE     OUT DATE
    )
    IS
     CURSOR CURESOURCE IS
            SELECT  SECPU.VALUE CPU,
                    SERAM.VALUE RAM,
                    SYSDATE     TIME
            FROM GV$SESSTAT SECPU,
                 GV$SESSTAT SERAM,
                 GV$SESSION SS
            WHERE   SECPU.STATISTIC# = NUCPU_USED  
                AND SERAM.STATISTIC# = NUMEMORY_USED  
                AND (SECPU.SID= SS.SID AND SECPU.INST_ID = SS.INST_ID)
                AND (SERAM.SID= SS.SID AND SERAM.INST_ID = SS.INST_ID)
                AND SS.AUDSID = INUSESSIONID;
    BEGIN
         LOADSTATVARS;

        OPEN CURESOURCE;
        FETCH CURESOURCE INTO ONUCPUVALUE, ONUMEMORYVALUE, ODTSYSDATE;
        CLOSE CURESOURCE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    





















    FUNCTION FNUGETSTATISTIC
    (
        ISBNAME   IN  VARCHAR
    )
    RETURN NUMBER
    IS
        CURSOR CUOPENCURSOR(SBNAME VARCHAR2)
        IS
            SELECT STATISTIC#
            FROM GV$SYSSTAT
            WHERE NAME = SBNAME;

        SBNAME  GV$SYSSTAT.NAME%TYPE;
        NUSTATISTIC GV$SYSSTAT.STATISTIC#%TYPE;
        
    BEGIN

        IF(ISBNAME = 'CPU_Used') THEN
            SBNAME := 'CPU used by this session';
        END IF;
        
        IF(ISBNAME = 'Memory_Used' ) THEN
            SBNAME := 'session uga memory';
        END IF;
        
        IF(ISBNAME = 'OpenCursors') THEN
            SBNAME := 'opened cursors current';
        END IF;
        
        OPEN CUOPENCURSOR(SBNAME);
        FETCH CUOPENCURSOR INTO NUSTATISTIC;
        CLOSE CUOPENCURSOR;

        RETURN NUSTATISTIC;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    
    















    FUNCTION FBLUSERCONECTBYUSRNAME
    (
        ISBNAMEUSER IN  SA_USER.MASK%TYPE
    )RETURN BOOLEAN
    IS
        
        SBSESSIONSTATUS VARCHAR2(20) := 'KILLED';
        
        CURSOR CUUSERCONEC( ISBUSRNAME IN VARCHAR2)
        IS
            SELECT *
            FROM GV$SESSION
            WHERE GV$SESSION.USERNAME = ISBUSRNAME
            AND STATUS <> SBSESSIONSTATUS;
            
        RCSESSION   CUUSERCONEC%ROWTYPE;
    BEGIN
        
        
        
        IF CUUSERCONEC%ISOPEN THEN CLOSE CUUSERCONEC; END IF;

        OPEN CUUSERCONEC(ISBNAMEUSER);
        FETCH CUUSERCONEC INTO RCSESSION;
        
        IF (CUUSERCONEC%NOTFOUND) THEN
            CLOSE CUUSERCONEC;
            RETURN FALSE;
        ELSE
            CLOSE CUUSERCONEC;
            RETURN TRUE;
        END IF;

        RETURN FALSE;
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF CUUSERCONEC%ISOPEN THEN CLOSE CUUSERCONEC; END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            IF CUUSERCONEC%ISOPEN THEN CLOSE CUUSERCONEC; END IF;
            RAISE EX.CONTROLLED_ERROR;
    END FBLUSERCONECTBYUSRNAME;
    
 
    PROCEDURE EXECUTECOMMAND(SBCOMMAND IN VARCHAR2)
    IS
       NUERROR NUMBER;
    BEGIN
       NUERROR := UT_OSCOMMAND.RUN(SBCOMMAND);

       IF (NUERROR != 0) THEN
    	  ERRORS.SETERROR(-1);
          ERRORS.SETMESSAGE(NUERROR||' - '||UT_OSCOMMAND.GETMESSAGE);
          RAISE EX.CONTROLLED_ERROR;
       END IF;
    EXCEPTION
       WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END EXECUTECOMMAND;

    
    PROCEDURE KILLUSERSESSIONS
    IS
       NUUSERID       SA_USER.USER_ID%TYPE;
       SBUSER         SA_USER.MASK%TYPE;
       SBCOMMAND      VARCHAR2(1000);

       CURSOR CUSESSIONS(ISBUSER IN SA_USER.MASK%TYPE) IS
              SELECT GV$SESSION.SID, GV$SESSION.SERIAL#, GV$PROCESS.SPID,GV$SESSION.INST_ID,GV$SESSION.MACHINE
              FROM GV$SESSION, GV$PROCESS
              WHERE GV$SESSION.USERNAME = ISBUSER
                AND GV$SESSION.PADDR = GV$PROCESS.ADDR
                AND UPPER(REPLACE(TRIM(GV$SESSION.MACHINE),
                                  CHR(0),
                            NULL)) NOT IN (SELECT DISTINCT UPPER(TRIM(GE_HOST.HOST_NAME))
                                           FROM GE_HOST)
                AND (GV$SESSION.MODULE = CSBEXCAPP OR GV$SESSION.MODULE LIKE 'NOTI_%')
                AND GV$SESSION.STATUS <> CSBSESSIONSTATUS;
    BEGIN
       NUUSERID := SA_BOSYSTEM.GETSYSTEMUSERID;
       SBUSER := DASA_USER.FSBGETMASK(NUUSERID);
       
       IF(UT_SESSION.FNUISRACSESSION > 1 )THEN
           
           FOR REG IN CUSESSIONS(SBUSER) LOOP
            SBCOMMAND := 'alter system kill session ' ||
            '''' || REG.SID || ',' || REG.SERIAL# || ',@' ||REG.INST_ID ||'''';
            EXECUTE IMMEDIATE SBCOMMAND;

            
            EXECUTECOMMAND('ssh '||REG.MACHINE||' kill -9 '||REG.SPID);
           END LOOP;
       ELSE
           
           FOR REG IN CUSESSIONS(SBUSER) LOOP
               
               SBCOMMAND := 'alter system kill session ' ||
                            '''' || REG.SID || ',' || REG.SERIAL# || '''';
               EXECUTE IMMEDIATE SBCOMMAND;
               
               
               EXECUTECOMMAND('kill -9 '||REG.SPID);
           END LOOP;
       END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END KILLUSERSESSIONS;


    FUNCTION FBLISUSERCONNECTED
    (
        ISBUSER IN SA_USER.MASK%TYPE
    )
    RETURN BOOLEAN
    IS
        SBVARIABLE     VARCHAR2(1);

        CURSOR CUUSERSESSIONS
        IS
            SELECT 'X'
            FROM GV$SESSION
            WHERE GV$SESSION.USERNAME = ISBUSER
              AND UPPER(REPLACE(TRIM(GV$SESSION.MACHINE),
                                CHR(0),
                                NULL)) NOT IN (SELECT DISTINCT UPPER(TRIM(GE_HOST.HOST_NAME))
                                               FROM GE_HOST)
              AND (GV$SESSION.MODULE = CSBEXCAPP OR GV$SESSION.MODULE LIKE 'NOTI_%')
              AND GV$SESSION.STATUS <> CSBSESSIONSTATUS;
    BEGIN
        IF (CUUSERSESSIONS%ISOPEN) THEN
            CLOSE CUUSERSESSIONS;
        END IF;

        OPEN CUUSERSESSIONS;

        FETCH CUUSERSESSIONS INTO SBVARIABLE;

        CLOSE CUUSERSESSIONS;

        IF (SBVARIABLE IS NULL) THEN
            RETURN FALSE;
        ELSE
            RETURN TRUE;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            IF (CUUSERSESSIONS%ISOPEN) THEN
                CLOSE CUUSERSESSIONS;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            IF (CUUSERSESSIONS%ISOPEN) THEN
                CLOSE CUUSERSESSIONS;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBLISUSERCONNECTED;

    
    PROCEDURE VERIFYMULTISESSION
    IS
        NUUSERID            SA_USER.USER_ID%TYPE;
        RCUSER              DASA_USER.STYSA_USER;
    BEGIN
        NUUSERID := SA_BOSYSTEM.GETSYSTEMUSERID;
        DASA_USER.GETRECORD(NUUSERID,
                            RCUSER);

        IF (RCUSER.MULTISESSION_ENABLED IS NOT NULL) THEN
            IF (RCUSER.MULTISESSION_ENABLED = CSBMULTISESSDISABLED) THEN
                IF (UT_SESSION.FBLISUSERCONNECTED(RCUSER.MASK)) THEN
                    ERRORS.SETERROR(CNUERR4886);
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
            END IF;
        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END VERIFYMULTISESSION;


    

















    FUNCTION FNUGETCURRENTPGASIZEMB
    RETURN NUMBER
    IS
        
        NUPGAMEMORY    NUMBER(10,3);
        
        
        CURSOR CUMEMORY(NUSESSIONID NUMBER)
            IS
        SELECT MAX(P.PGA_ALLOC_MEM - P.PGA_FREEABLE_MEM)/1048576
               "session_pga_memory(MB)"
          FROM GV$SESSION S,
               GV$PROCESS P
         WHERE P.ADDR = S.PADDR
           AND S.AUDSID = NUSESSIONID
           AND P.INST_ID = S.INST_ID
           AND S.INST_ID = SYS_CONTEXT('USERENV','INSTANCE');

    BEGIN
    
        
        IF (CUMEMORY%ISOPEN) THEN
          CLOSE CUMEMORY;
        END IF;
         
        OPEN CUMEMORY(CNUSESSIONID);
        
        FETCH CUMEMORY INTO NUPGAMEMORY;
        
        CLOSE CUMEMORY;
        
        RETURN NUPGAMEMORY;

    EXCEPTION
        WHEN  EX.CONTROLLED_ERROR THEN
        	RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    

 


















    FUNCTION FSBGETIDSESSION
    RETURN VARCHAR2
    IS
        
        SBIDSESSION    VARCHAR2(4000);
        NUAUDSID	   NUMBER;
        NUSID   	   NUMBER;
        NUSERIAL#	   NUMBER;
        RCSESSION	   CUSESSION%ROWTYPE ;
    BEGIN
        PKERRORS.PUSH('pkIC_SessionMgr.fsbGetIdSession');
        IF ( CUSESSION%ISOPEN ) THEN
    	CLOSE CUSESSION;
        END IF;
        OPEN  CUSESSION;
        FETCH CUSESSION INTO RCSESSION ;
        CLOSE CUSESSION;
        
        SBIDSESSION := TO_CHAR ( RCSESSION.AUDSID ) || ',' ||
    		   TO_CHAR ( RCSESSION.SID )    || ',' ||
    		   TO_CHAR ( RCSESSION.SERIAL# )|| '|' ;
        PKERRORS.POP;
        RETURN ( SBIDSESSION );
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END FSBGETIDSESSION;

    


















     FUNCTION FBLEXISTSESSION
     (
	    INUAUDSID	   IN NUMBER,
	    INUSID   	   IN NUMBER,
	    INUSERIAL#	   IN NUMBER
     )
    RETURN BOOLEAN
    IS
    
    NUNUMSES    NUMBER;    
    BLFOUND     BOOLEAN;   
    BEGIN
        PKERRORS.PUSH('pkIC_SessionMgr.fblExistSession');
        IF ( CUEXISTSESSION%ISOPEN ) THEN
    	CLOSE CUEXISTSESSION;
        END IF;
        BLFOUND := FALSE ;
        OPEN  CUEXISTSESSION ( INUAUDSID, INUSID, INUSERIAL# );
        FETCH CUEXISTSESSION INTO NUNUMSES ;
        CLOSE CUEXISTSESSION ;
        IF ( NVL ( NUNUMSES , 0 ) > 0 ) THEN
    	BLFOUND := TRUE ;
        END IF ;
        PKERRORS.POP;
        RETURN ( BLFOUND );
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END FBLEXISTSESSION;

    













    PROCEDURE ENABLESORTMERGEJOINS
    (
        IBLENABLE       IN      BOOLEAN
    )
    IS
        SBENABLE VARCHAR2(10);
    BEGIN

        IF IBLENABLE THEN
            SBENABLE := 'TRUE';
        ELSE
            SBENABLE := 'FALSE';
        END IF;

        EXECUTE IMMEDIATE 'ALTER SESSION SET "_OPTIMIZER_SORTMERGE_JOIN_ENABLED" = '||SBENABLE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    













    PROCEDURE ENABLEHASHJOINS
    (
        IBLENABLE       IN      BOOLEAN
    )
    IS
        SBENABLE VARCHAR2(10);
    BEGIN

        IF IBLENABLE THEN
            SBENABLE := 'TRUE';
        ELSE
            SBENABLE := 'FALSE';
        END IF;

        EXECUTE IMMEDIATE 'ALTER SESSION SET "_HASH_JOIN_ENABLED" = '||SBENABLE;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    













    FUNCTION FNUISRACSESSION RETURN NUMBER
    IS
       NUSESSION     NUMBER(2);
    BEGIN
       
       SELECT COUNT(1)
         INTO NUSESSION
         FROM GV$INSTANCE;

        RETURN NUSESSION;
        
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
    END FNUISRACSESSION;

    













    FUNCTION FSBSPID RETURN VARCHAR
    IS
    BEGIN
        
        
        IF GSBCURRENTSPID IS NULL THEN
            
            SELECT
                GV$PROCESS.SPID INTO GSBCURRENTSPID
            FROM
                GV$SESSION, GV$PROCESS
            WHERE
                GV$SESSION.PADDR = GV$PROCESS.ADDR
                AND GV$SESSION.AUDSID = CNUSESSIONID;
        END IF;

        RETURN GSBCURRENTSPID;

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
    END FSBSPID;

BEGIN
    
    INITPROGRAM;

END UT_SESSION;