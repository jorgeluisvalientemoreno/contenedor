PACKAGE BODY GE_BOFwContratistas












IS

    
    CSBVERSION          CONSTANT VARCHAR2(20) := 'SAO388049';

   	

    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    
    


















    PROCEDURE GETCONTRATISTASLOV
    (
        ORFRECURSOR OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
        CT_BOCONTRSECURITY.GETCONTRACTORSLOV(ORFRECURSOR);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETCONTRATISTASLOV;
    
    
    



















    
    PROCEDURE UPDAVGCOSTBYTASKTYPE
    IS
        CNUNULL_ATTRIBUTE CONSTANT NUMBER := 2126;

        
        CNUERR_FINAL_DATE CONSTANT NUMBER := 811;

        DTINITIAL               OR_ORDER.EXEC_INITIAL_DATE%TYPE;
        DTFINAL                 OR_ORDER.EXECUTION_FINAL_DATE%TYPE;

        SBEXEC_INITIAL_DATE     GE_BOINSTANCECONTROL.STYSBVALUE;
        SBEXECUTION_FINAL_DATE  GE_BOINSTANCECONTROL.STYSBVALUE;
        
        
        SBPROCESSID             ESTAPROG.ESPRPROG%TYPE;
        
        


















        PROCEDURE INITDATA
        (
            OSBPROCESSID    OUT ESTAPROG.ESPRPROG%TYPE
        )
        IS

            
            
            

            
            CNUINF_MSG_EXEC CONSTANT MENSAJE.MENSCODI%TYPE := 10010;

            
            
            

            
            SBPROCEXECMSG   MENSAJE. MENSDESC%TYPE;

        BEGIN

            UT_TRACE.TRACE('INICIO GE_BOFwContratistas.UpdAvgCostByTaskType.InitData', 2);

            
            OSBPROCESSID := PKSTATUSEXEPROGRAMMGR.FSBGETPROGRAMID(GE_BOCERTIFICATE.GCSBEST_CST_PROC);
            UT_TRACE.TRACE('[osbProcessID]='||OSBPROCESSID, 1);

            
            PKSTATUSEXEPROGRAMMGR.VALIDATERECORDAT(OSBPROCESSID);
            SBPROCEXECMSG :=    PKTBLMENSAJE.FSBGETDESCRIPTION
                                (
                                    PKCONSTANTE.CSBDIVISION,
                                    PKCONSTANTE.CSBMOD_GRL ,
                                    CNUINF_MSG_EXEC
                                );

            PKSTATUSEXEPROGRAMMGR.UPSTATUSEXEPROGRAMAT
            (
                OSBPROCESSID,
                SBPROCEXECMSG,
                PKBILLCONST.CERO,
                PKBILLCONST.CERO
            );

            UT_TRACE.TRACE('FIN GE_BOFwContratistas.UpdAvgCostByTaskType.InitData', 2);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END INITDATA;

        




















        PROCEDURE CALLPROC
        (
            ISBPROCESSID    IN  ESTAPROG.ESPRPROG%TYPE,
            IDTINITDATE     IN  DATE,
            IDTFINALDATE    IN  DATE
        )
        IS

            
            
            

            
            CSBPROC_NAME    CONSTANT VARCHAR2(6) := 'ctcce';
            
            CSBSLASH        CONSTANT VARCHAR2(1) := '/';
            
            CSBAT           CONSTANT VARCHAR2(1) := '@';
            
            CNUTRACE_LVL    CONSTANT NUMBER      := 3;

            
            
            

            
            SBUSER          VARCHAR2(100);
            
            SBPASSWORD      VARCHAR2(100);
            
            SBINSTANCE      VARCHAR2(100);
            
            SBCONNECTION    VARCHAR2(1000);
            
            SBPROCPARAMS    VARCHAR2(1000);

        BEGIN

            UT_TRACE.TRACE('INICIO GE_BOFwContratistas.UpdAvgCostByTaskType.CallProC', 2);

            
            GE_BODATABASECONNECTION.GETCONNECTIONSTRING(SBUSER, SBPASSWORD, SBINSTANCE);

            SBCONNECTION := SBUSER||CSBSLASH||SBPASSWORD||CSBAT||SBINSTANCE;

            SBPROCPARAMS := '''' ||ISBPROCESSID                                       ||''''||
                            ' '''||TO_CHAR(IDTINITDATE,  UT_DATE.FSBSHORT_DATE_FORMAT)||''''||
                            ' '''||TO_CHAR(IDTFINALDATE, UT_DATE.FSBSHORT_DATE_FORMAT)||'''';

            UT_TRACE.TRACE('[sbProCParams]='||SBPROCPARAMS, 3);

            
            BI_BOSERVICIOSDOTNET.INVOCARPROC(CSBPROC_NAME, SBCONNECTION, SBPROCPARAMS, CNUTRACE_LVL);

            UT_TRACE.TRACE('FIN GE_BOFwContratistas.UpdAvgCostByTaskType.CallProC', 2);

        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END CALLPROC;

    BEGIN
    
        UT_TRACE.TRACE('INICIO GE_BOFwContratistas.UpdAvgCostByTaskType', 1);

        
        SBEXEC_INITIAL_DATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER', 'EXEC_INITIAL_DATE');
        SBEXECUTION_FINAL_DATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('OR_ORDER', 'EXECUTION_FINAL_DATE');
        
        
        

        IF (SBEXEC_INITIAL_DATE IS NULL) THEN
            ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Fecha Inicial');
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        IF (SBEXECUTION_FINAL_DATE IS NULL) THEN
            ERRORS.SETERROR (CNUNULL_ATTRIBUTE, 'Fecha Final');
            RAISE EX.CONTROLLED_ERROR;
        END IF;


        DTINITIAL := TO_DATE(SBEXEC_INITIAL_DATE,UT_DATE.FSBDATE_FORMAT);
  	    DTFINAL   := TO_DATE(SBEXECUTION_FINAL_DATE,UT_DATE.FSBDATE_FORMAT);

        
        PKGENERALSERVICES.VALDATERANGE(DTINITIAL, DTFINAL);

        
        PKGENERALSERVICES.VALDATELESSCURRENT(DTFINAL);
        
        
        INITDATA(SBPROCESSID);

        
        CALLPROC(SBPROCESSID, DTINITIAL, DTFINAL);
       
        UT_TRACE.TRACE('FIN GE_BOFwContratistas.UpdAvgCostByTaskType', 1);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END UPDAVGCOSTBYTASKTYPE;

END GE_BOFWCONTRATISTAS;