PACKAGE BODY SA_BSExecutableMgr
IS






























































	

 	
    
    CSBVERSION   CONSTANT VARCHAR2(20)            := 'SAO196941';

   	
    CNUSUCCESS   CONSTANT NUMBER(1) := 0;
    CSBNOMESSAGE CONSTANT VARCHAR2(30) := 'NO ERRORS';


	

	

	
    

    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
    
        RETURN CSBVERSION;
    
    END;

    PROCEDURE ENVIROMENTVALIDATION IS
    BEGIN
          
          SA_BOSYSTEM.ISSECURITYENVIROMENTENABLED;
    EXCEPTION
      	WHEN EX.CONTROLLED_ERROR THEN
            RAISE  EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            RAISE;
    END;

    PROCEDURE INITIALIZEOUTPUTVARIABLES(ONUERRORCODE OUT NUMBER,OSBERRORTEXT OUT VARCHAR2) IS
    BEGIN
         ONUERRORCODE := CNUSUCCESS;
         OSBERRORTEXT := CSBNOMESSAGE;
    END;

    PROCEDURE ADDSYSTEMEXECUTABLE ( ISBNAME IN VARCHAR2,
          ISBDESCRIPTION IN VARCHAR2,
          ISBPATH IN VARCHAR2,
          ISBVERSION IN VARCHAR2,
          INUTYPE IN NUMBER,
          INUOPERATIVETYPE IN NUMBER,
          INUMODULEID IN NUMBER,
          INUSUBSYSTEMID IN NUMBER,
          INUPARENTEXECUTABLEID IN NUMBER,
          ISBLASTRECORDALLOWED VARCHAR2,
          ISBWITHOUTRESTRPOLICY VARCHAR2,
          ONUID IN OUT NOCOPY NUMBER,
   	      ONUERRORCODE OUT NUMBER,
          OSBERRORTEXT OUT VARCHAR2) IS
         



        
		PROCEDURE VALIDATEINPUT
		IS
        
		BEGIN

             SA_BOEXECUTABLE.VALIDATENAMEDATA(TRIM(ISBNAME));
             SA_BOEXECUTABLE.VALIDATEDESCRIPTIONDATA(TRIM(ISBDESCRIPTION));
             SA_BOEXECUTABLE.VALIDATEMODULEIDDATA(INUMODULEID);
             SA_BOEXECUTABLE.VALIDATEVERSIONDATA(TRIM(ISBVERSION));
             SA_BOSUBSYSTEM.VALIDATESUBSYSTEMIDDATA(TRIM(INUSUBSYSTEMID));
             SA_BOEXECUTABLE.VALIDATEEXECUTABLETYPE(TRIM(INUTYPE));
             SA_BOEXECUTABLE.VALIDATEEXECUTABLEOPERTYPE(TRIM(INUOPERATIVETYPE));

             

             SA_BOUSER.SETID(SA_BOSYSTEM.GETSYSTEMUSERID);
             SA_BOUSER.USERHASPERMWORKWITHEXECUTABLES;

             
             SA_BOEXECUTABLE.CHKEXECALREADYEXISTSBYNAME(ISBNAME);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
        BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
        
		BEGIN
  			
               
            ONUID := SA_BOEXECUTABLE.GETNEXTID;

            SA_BOEXECUTABLE.SETSUBSYSTEM (INUSUBSYSTEMID);
            SA_BOEXECUTABLE.SETDESCRIPTION(TRIM(ISBDESCRIPTION));
            SA_BOEXECUTABLE.SETPATH(TRIM(ISBPATH));
            SA_BOEXECUTABLE.SETMODULE(INUMODULEID);
            SA_BOEXECUTABLE.SETID(ONUID);
            SA_BOEXECUTABLE.SETVERSION(UPPER(TRIM(ISBVERSION)));
            SA_BOEXECUTABLE.SETNAME(UPPER(TRIM(ISBNAME)));
            SA_BOEXECUTABLE.SETTYPE(INUTYPE);
            SA_BOEXECUTABLE.SETOPERATIVETYPE(INUOPERATIVETYPE);
            SA_BOEXECUTABLE.SETPARENTEXECUTABLE(INUPARENTEXECUTABLEID);
            SA_BOEXECUTABLE.SETLASTRECORDALLOWED(ISBLASTRECORDALLOWED);
            SA_BOEXECUTABLE.SETWITHOUTRESTRPOLICY(ISBWITHOUTRESTRPOLICY);
            SA_BOEXECUTABLE.ADD;
			COMMIT;
		END;
    BEGIN
         SAVEPOINT ADDSYSTEMEXECUTABLE;
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
			ROLLBACK TO SAVEPOINT ADDSYSTEMEXECUTABLE;	
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
			ROLLBACK TO SAVEPOINT ADDSYSTEMEXECUTABLE;				
    END;

    PROCEDURE DELETEEXECUTABLE ( INUEXECUTABLEID IN NUMBER,
   	      ONUERRORCODE OUT NUMBER,
          OSBERRORTEXT OUT VARCHAR2) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             SA_BOEXECUTABLE.VALIDATEEXECUTABLEIDDATA(INUEXECUTABLEID);
             SA_BOUSER.SETID(SA_BOSYSTEM.GETSYSTEMUSERID);
             SA_BOUSER.USERHASPERMWORKWITHEXECUTABLES;
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
            SA_BOEXECUTABLE.SETID(INUEXECUTABLEID);
            SA_BOEXECUTABLE.DELETEBYCODE;
            COMMIT;
		END;
    BEGIN
 		 
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
			
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
			
    END;

    PROCEDURE GETALLEXECUTABLES(ORFEXECUTABLES OUT NOCOPY DASA_EXECUTABLE.TYREFCURSOR,
        ONUERRORCODE OUT NUMBER,
        OSBERRORTEXT OUT VARCHAR2) IS
    

    
		PROCEDURE VALIDATEINPUT
		IS
  		BEGIN
             NULL;
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS(ORFEXECUTABLES OUT NOCOPY DASA_EXECUTABLE.TYREFCURSOR)
		IS
		BEGIN
  			
	   	    SA_BOUSER.SETID(SA_BOSYSTEM.GETSYSTEMUSERID);
            ORFEXECUTABLES:= SA_BOEXECUTABLE.GETALLEXECUTABLES;
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS(ORFEXECUTABLES);
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE CHECKEXECUTABLEVERSION( ISBEXECUTABLENAME IN VARCHAR2,
          ISBVERSION  IN VARCHAR2,
   	      ONUERRORCODE OUT NUMBER,
          OSBERRORTEXT OUT VARCHAR2) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
	   	   	SA_BOEXECUTABLE.VALIDATENAMEDATA(ISBEXECUTABLENAME);
	        SA_BOEXECUTABLE.VALIDATEVERSIONDATA(ISBVERSION);

        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
            
            
            SA_BOEXECUTABLE.ISVERSIONMATCHING( ISBEXECUTABLENAME, ISBVERSION);
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETSYSTEMEXECUTABLEID ( INUEXECUTABLEID IN NUMBER,
          EXECUTABLEROW OUT NOCOPY DASA_EXECUTABLE.STYSA_EXECUTABLE,
   	      ONUERRORCODE OUT NUMBER,
          OSBERRORTEXT OUT VARCHAR2) IS
        

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             
            SA_BOEXECUTABLE.VALIDATEEXECUTABLEIDDATA(INUEXECUTABLEID);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
             SA_BOEXECUTABLE.SETID(INUEXECUTABLEID);
             EXECUTABLEROW:= SA_BOEXECUTABLE.GETEXECUTABLEBYID;
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE UPDATESYSTEMEXECUTABLE(EXECUTABLEROW IN OUT DASA_EXECUTABLE.STYSA_EXECUTABLE,
   	      ONUERRORCODE OUT NUMBER,
          OSBERRORTEXT OUT VARCHAR2) IS
        

        
		PROCEDURE VALIDATEINPUT
     	IS
		BEGIN

             EXECUTABLEROW.NAME := UPPER(TRIM(EXECUTABLEROW.NAME));
             EXECUTABLEROW.DESCRIPTION := TRIM(EXECUTABLEROW.DESCRIPTION);
             EXECUTABLEROW.VERSION := UPPER(TRIM(EXECUTABLEROW.VERSION));

             SA_BOEXECUTABLE.VALIDATENAMEDATA(EXECUTABLEROW.NAME);
             SA_BOEXECUTABLE.VALIDATEDESCRIPTIONDATA(EXECUTABLEROW.DESCRIPTION);
             SA_BOEXECUTABLE.VALIDATEVERSIONDATA(EXECUTABLEROW.VERSION);
             SA_BOEXECUTABLE.VALIDATEMODULEIDDATA(TRIM(EXECUTABLEROW.MODULE_ID));

             SA_BOEXECUTABLE.VALIDATEEXECUTABLETYPE(TRIM(EXECUTABLEROW.EXECUTABLE_TYPE_ID));
             SA_BOEXECUTABLE.VALIDATEEXECUTABLEOPERTYPE(TRIM(EXECUTABLEROW.EXEC_OPER_TYPE_ID));

             SA_BOSUBSYSTEM.VALIDATESUBSYSTEMIDDATA(EXECUTABLEROW.SUBSYSTEM_ID);

             SA_BOUSER.SETID(SA_BOSYSTEM.GETSYSTEMUSERID);
             SA_BOUSER.USERHASPERMWORKWITHEXECUTABLES;

             SA_BOEXECUTABLE.SETID(EXECUTABLEROW.EXECUTABLE_ID);
             SA_BOEXECUTABLE.CHKEXECALRDYEXISTSBYNMEINUPD(EXECUTABLEROW.NAME);

             
             
             SA_BOEXECUTABLE.SETID(EXECUTABLEROW.EXECUTABLE_ID);
             SA_BOEXECUTABLE.CHCKEXECISATTACHEDPUBLICROLE(EXECUTABLEROW.EXEC_OPER_TYPE_ID);

        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
             SA_BOEXECUTABLE.UPDATEEXECUTABLE(EXECUTABLEROW);
		END;
    BEGIN
         
         SAVEPOINT SPUPDATESYSTEMEXECUTABLE;
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
            ROLLBACK TO SAVEPOINT SPUPDATESYSTEMEXECUTABLE;			
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
            ROLLBACK TO SAVEPOINT SPUPDATESYSTEMEXECUTABLE;			
    END;

    PROCEDURE GETEXECUTABLETYPES(RFEXECTYPE OUT NOCOPY DASA_EXECUTABLE_TYPE.TYREFCURSOR,
        ONUERRORCODE OUT NUMBER,
        OSBERRORTEXT OUT VARCHAR2 ) IS
    BEGIN
         RFEXECTYPE:= SA_BOEXECUTABLE.GETEXECUTABLETYPES;
    EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
             ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
         WHEN OTHERS THEN
            ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETEXECUTABLEOPERATIVETYPES(RFEXECOPETYPE OUT NOCOPY DASA_EXECUTABLE_TYPE.TYREFCURSOR,
        ONUERRORCODE OUT NUMBER,
        OSBERRORTEXT OUT VARCHAR2 ) IS
    BEGIN
         RFEXECOPETYPE:= SA_BOEXECUTABLE.GETEXECUTABLEOPERATIVETYPES;
    EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
             ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
         WHEN OTHERS THEN
             ERRORS.SETERROR;
			 ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETUSERSATTACHED(INUEXECUTABLEID IN NUMBER, ORFUSERS OUT NOCOPY
        SA_BOEXECUTABLE.TYRFRECUSERS, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
  		BEGIN
             
            SA_BOEXECUTABLE.VALIDATEEXECUTABLEIDDATA(INUEXECUTABLEID);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS(ORFUSERS OUT NOCOPY SA_BOEXECUTABLE.TYRFRECUSERS)
		IS
		BEGIN
  			
             SA_BOEXECUTABLE.SETID(INUEXECUTABLEID);
             ORFUSERS := SA_BOEXECUTABLE.GETUSERSATTACHED;
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS(ORFUSERS);
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETRCEXECUTABLE(INUEXECUTABLEID  IN OUT  NUMBER,
         OSBNAME OUT  VARCHAR2, OSBDESCRIPTION  OUT  VARCHAR2,
         OSBPATH  OUT  VARCHAR2, OSBVERSION  OUT  VARCHAR2,
         ONUTYPE  OUT  NUMBER, ONUOPERATIVE_TYPE  OUT NUMBER,
         ONUMODULE_ID  OUT  NUMBER, ONUSUBSYSTEM_ID  OUT  NUMBER,
         ONUPARENT_EXECUTABLE_ID OUT NUMBER, ONUERRORCODE OUT NUMBER,
         OSBERRORTEXT OUT VARCHAR2 ) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
  		BEGIN
             
            SA_BOEXECUTABLE.VALIDATEEXECUTABLEIDDATA(INUEXECUTABLEID);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
        RCEXECUTABLE DASA_EXECUTABLE.STYSA_EXECUTABLE;
        BEGIN

  			
            SA_BOEXECUTABLE.SETID(INUEXECUTABLEID);
            RCEXECUTABLE := SA_BOEXECUTABLE.GETEXECUTABLEBYID;

	        OSBNAME:=RCEXECUTABLE.NAME;
	        OSBDESCRIPTION:=RCEXECUTABLE.DESCRIPTION ;
	        OSBPATH:=RCEXECUTABLE.PATH;
	        OSBVERSION:=RCEXECUTABLE.VERSION ;
	        ONUTYPE:=RCEXECUTABLE.EXECUTABLE_TYPE_ID ;
	        ONUOPERATIVE_TYPE:=RCEXECUTABLE.EXEC_OPER_TYPE_ID ;
	        ONUMODULE_ID:=RCEXECUTABLE.MODULE_ID ;
	        ONUSUBSYSTEM_ID:=RCEXECUTABLE.SUBSYSTEM_ID ;
	        ONUPARENT_EXECUTABLE_ID:=RCEXECUTABLE.PARENT_EXECUTABLE_ID;

		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETSBDESCRIPTION (INUEXECUTABLEID  IN OUT  NUMBER,
         OSBDESCRIPTION  OUT  VARCHAR2, ONUERRORCODE OUT NUMBER,
         OSBERRORTEXT OUT VARCHAR2 ) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             
            SA_BOEXECUTABLE.VALIDATEEXECUTABLEIDDATA(INUEXECUTABLEID);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
        RCEXECUTABLE DASA_EXECUTABLE.STYSA_EXECUTABLE;
        BEGIN
  			
            SA_BOEXECUTABLE.SETID(INUEXECUTABLEID);
            RCEXECUTABLE := SA_BOEXECUTABLE.GETEXECUTABLEBYID;
	        OSBDESCRIPTION:=RCEXECUTABLE.DESCRIPTION ;
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETSBNAME (INUEXECUTABLEID  IN OUT  NUMBER,
         OSBNAME  OUT  VARCHAR2, ONUERRORCODE OUT NUMBER,
         OSBERRORTEXT OUT VARCHAR2 ) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             
            SA_BOEXECUTABLE.VALIDATEEXECUTABLEIDDATA(INUEXECUTABLEID);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
        RCEXECUTABLE DASA_EXECUTABLE.STYSA_EXECUTABLE;
        BEGIN
  			
            SA_BOEXECUTABLE.SETID(INUEXECUTABLEID);
            RCEXECUTABLE := SA_BOEXECUTABLE.GETEXECUTABLEBYID;
	        OSBNAME:=RCEXECUTABLE.NAME ;
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETSYSTEMEXECUTABLEBYNAME ( ISBEXECUTABLENAME IN NUMBER,
          EXECUTABLEROW OUT NOCOPY DASA_EXECUTABLE.STYSA_EXECUTABLE,
   	      ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2) IS
        

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             
            SA_BOEXECUTABLE.VALIDATENAMEDATA(ISBEXECUTABLENAME);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
	    BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
             EXECUTABLEROW:=SA_BOEXECUTABLE.GETEXECUTABLEBYNAME(ISBEXECUTABLENAME);
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;





    PROCEDURE GETENTITIESBYEXECUTABLE(INUEXECUTABLE IN NUMBER,
        RCENTITIES OUT NOCOPY CONSTANTS.TYREFCURSOR,
        ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2) IS
        

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             NULL;
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
		BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS(RCENTITIES OUT NOCOPY CONSTANTS.TYREFCURSOR)
		IS
		BEGIN
  			
             RCENTITIES:= SA_BOEXECUTABLE.GETENTITIESBYEXECUTABLE(INUEXECUTABLE);
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS(RCENTITIES);
   EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE GETSYSTEMEXECTABLEDESCRPBYNAME ( ISBEXECUTABLENAME IN VARCHAR2,
          SBDESCRIPTION  OUT NOCOPY VARCHAR2, ONUERRORCODE OUT NUMBER,
		  OSBERRORTEXT OUT VARCHAR2) IS
    

        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             
            SA_BOEXECUTABLE.VALIDATENAMEDATA(ISBEXECUTABLENAME);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
	    BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
             SBDESCRIPTION:=SA_BOEXECUTABLE.GETEXECUTABLEDESCRIPTIONBYNAME(ISBEXECUTABLENAME);
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;


    PROCEDURE GETEXECUTABLEMODULEBYNAME(ISBEXECUTABLENAME IN VARCHAR2,
                                        ONUMODULE   OUT SA_EXECUTABLE.MODULE_ID%TYPE,
                                        ONUERRORCODE OUT NUMBER,
                                        OSBERRORTEXT OUT VARCHAR2) IS
 


        
		PROCEDURE VALIDATEINPUT
		IS
		BEGIN
             
            SA_BOEXECUTABLE.VALIDATENAMEDATA(ISBEXECUTABLENAME);
        END;

        
		PROCEDURE INITIALIZEOUTPUT
		IS
	    BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

        
   		PROCEDURE RUNPROCESS
		IS
		BEGIN
  			
             ONUMODULE :=SA_BOEXECUTABLE.GETEXECUTABLEMODULEBYNAME(ISBEXECUTABLENAME);
		END;
    BEGIN
         VALIDATEINPUT;
         INITIALIZEOUTPUT;
       	 RUNPROCESS;
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    PROCEDURE ISENABLEDTOEXECUTEBYID
    (
        INUEXECUTABLENAME IN  NUMBER,
        ONUERRORCODE      OUT NUMBER,
        OSBERRORTEXT      OUT VARCHAR2
    ) IS

		PROCEDURE INITIALIZEOUTPUT
		IS
	    BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORTEXT);
		END;

   		PROCEDURE RUNPROCESS
		IS
		BEGIN
            SA_BOUSER.ISENABLEDTOEXECUTEBYID(INUEXECUTABLENAME);
		END;
    BEGIN

        
        INITIALIZEOUTPUT;
        
        RUNPROCESS;

  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORTEXT);
    END;

    




















    PROCEDURE ISENABLEDTOEXECUTEBYNAME
    (
        ISBEXECUTABLENAME   IN      SA_EXECUTABLE.NAME%TYPE,
        ONUERRORCODE        OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
        OSBERRORMESSAGEOUT  OUT     VARCHAR2
    )
    IS
        NUEXECUTABLEID      SA_EXECUTABLE.EXECUTABLE_ID%TYPE;

        PROCEDURE INITIALIZEOUTPUT
        IS
        BEGIN
            INITIALIZEOUTPUTVARIABLES(ONUERRORCODE,OSBERRORMESSAGEOUT);
        END;

        PROCEDURE RUNPROCESS
        IS
        BEGIN
            NUEXECUTABLEID := SA_BOUSER.ISENABLEDTOEXECUTEBYNAME(ISBEXECUTABLENAME);
        END;
        
    BEGIN
        UT_TRACE.TRACE ('BEGIN SA_BSEXECUTABLEMGR.isEnabledToExecutebyName', 1);
        
        
        INITIALIZEOUTPUT;
        
        RUNPROCESS;

        UT_TRACE.TRACE ('END SA_BSEXECUTABLEMGR.isEnabledToExecutebyName', 1);
  	EXCEPTION
		WHEN EX.CONTROLLED_ERROR THEN
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGEOUT);
		WHEN OTHERS THEN
			ERRORS.SETERROR;
			ERRORS.GETERROR(ONUERRORCODE, OSBERRORMESSAGEOUT);
    END ISENABLEDTOEXECUTEBYNAME;

    BEGIN
         ENVIROMENTVALIDATION;
END;