PACKAGE BODY FW_BOProcessInstance
IS
    




















    
    
    
    CSBVERSION                  CONSTANT VARCHAR2(10) := 'SAO208356';
    CSBWORKINSTANCE             CONSTANT VARCHAR2(15) := 'WORK_INSTANCE';
    
    
    

    
    
    

    
    
    

    



















    PROCEDURE GETREFINSTANCE (
        ISBINSTANCE     IN  VARCHAR2,
        ISBOBJECTTYPE   IN  VARCHAR2,
        ISBOBJECTID     IN  VARCHAR2,
        ORFINSTANCE     OUT CONSTANTS.TYREFCURSOR
    )
    IS
    BEGIN
    
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.GetRefInstance. isbInstance:['|| ISBINSTANCE
               ||'] isbObjectType:['|| ISBOBJECTTYPE
               ||'] isbObjectId:['|| ISBOBJECTID ||']', 15);
               
        IF NOT (GI_BOINSTANCE.FBLTMPINSTANCE ) THEN
        
            GI_BOINSTANCE.CHARGEINSTANCEINTMP(ISBINSTANCE);
            
        END IF;

        ORFINSTANCE :=
                 GI_BOINSTANCE.GETREFINSTANCE(ISBOBJECTTYPE,
                                              ISBOBJECTID,
                                              ISBINSTANCE);
                                              
       UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.GetRefInstance', 15);
       
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;
    END GETREFINSTANCE;

    




















    PROCEDURE  ADDATTRIBUTE
    (
        ISBINSTANCE  IN VARCHAR2,
        ISBGROUP     IN VARCHAR2,
        ISBENTITY    IN VARCHAR2,
        ISBATTRIBUTE IN VARCHAR2,
        ISBVALUE     IN VARCHAR2
    )
    IS
    
        NUINDEX NUMBER;
        
    BEGIN
    
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.AddAttribute. isbInstance:['|| ISBINSTANCE
               ||'] isbGroup:['|| ISBGROUP
               ||'] isbEntity:['|| ISBENTITY
               ||'] isbAttribute:['|| ISBATTRIBUTE
               ||'] isbValue:['|| ISBVALUE ||']', 15);

        IF NOT (GE_BOINSTANCECONTROL.FBLACCKEYATTRIBUTESTACK ( ISBINSTANCE,
                        ISBGROUP, ISBENTITY, ISBATTRIBUTE, NUINDEX))
        THEN

            GE_BOINSTANCECONTROL.ADDATTRIBUTE (ISBINSTANCE, ISBGROUP,
             ISBENTITY, ISBATTRIBUTE, ISBVALUE);

        ELSE

            GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE(ISBINSTANCE, ISBGROUP,
             ISBENTITY, ISBATTRIBUTE, ISBVALUE);

        END IF;

       UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.AddAttribute', 15);
       
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;
    END ADDATTRIBUTE;
    
    

























    PROCEDURE  ADDFRAME
    (
       ISBINSTANCENAME    VARCHAR2,
       IXLCOMPOSITION     XMLTYPE
    )
    IS
    
       XLATTRIBUTE        XMLTYPE;         
       NUINDEXATTRIBUTE   NUMBER(3) := 1;  
       SBENTITYNAME       GE_ENTITY.NAME_%TYPE;  
       SBATTRIBUTENAME    VARCHAR2(100); 
       SBINITEXPRESSIONID VARCHAR2(100); 
       SBVALEXPRESSIONID  VARCHAR2(100); 

    BEGIN

       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.AddFrame ', 15);

       
       IF(IXLCOMPOSITION IS NULL OR IXLCOMPOSITION.EXISTSNODE('//ATTRIBUTE') < 1)THEN

            UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.AddFrame - No hay atributos a instanciar', 15);
            RETURN;
            
       END IF;

       
       WHILE IXLCOMPOSITION.EXISTSNODE('//ATTRIBUTE[' || TO_CHAR(NUINDEXATTRIBUTE) || ']') > 0
       LOOP
       
            
            SBINITEXPRESSIONID := NULL;
            SBVALEXPRESSIONID := NULL;
            UT_TRACE.TRACE ('Atributo en la Posicion:[' || TO_CHAR(NUINDEXATTRIBUTE) ||']', 15);
       
            
            XLATTRIBUTE := IXLCOMPOSITION.EXTRACT('//ATTRIBUTE[' || TO_CHAR(NUINDEXATTRIBUTE) || ']');

            
            IF ( XLATTRIBUTE.EXISTSNODE('//ENTITY_NAME/text()') = 0 ) THEN
            
                UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/ATTRIBUTE['||
                        TO_CHAR(NUINDEXATTRIBUTE) ||']/ENTITY_NAME', 10);
                
                GE_BOERRORS.SETERRORCODEARGUMENT(901673,
                        '/PB/COMPOSITION/ATTRIBUTE['|| TO_CHAR(NUINDEXATTRIBUTE) ||']/ENTITY_NAME');
                        
            ELSE
            
                SBENTITYNAME := XLATTRIBUTE.EXTRACT('//ENTITY_NAME/text()').GETSTRINGVAL();
                UT_TRACE.TRACE ('sbEntityName ['||SBENTITYNAME||']', 20);
                
            END IF;

            
            IF ( XLATTRIBUTE.EXISTSNODE('//ATTRIBUTE_NAME/text()') = 0 ) THEN
            
                UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/ATTRIBUTE['||
                        TO_CHAR(NUINDEXATTRIBUTE) ||']/ATTRIBUTE_NAME', 10);
                
                GE_BOERRORS.SETERRORCODEARGUMENT(901673,
                        '/PB/COMPOSITION/ATTRIBUTE['|| TO_CHAR(NUINDEXATTRIBUTE) ||']/ATTRIBUTE_NAME');
                        
            ELSE
            
                SBATTRIBUTENAME := XLATTRIBUTE.EXTRACT('//ATTRIBUTE_NAME/text()').GETSTRINGVAL();
                UT_TRACE.TRACE ('sbAttributeName ['||SBATTRIBUTENAME||']', 20);
                
            END IF;


            
            IF ( ( XLATTRIBUTE.EXISTSNODE('//INIT_EXPRESSION_ID') = 1 )
                AND (XLATTRIBUTE.EXTRACT('//INIT_EXPRESSION_ID/text()') IS NOT NULL) )
            THEN
            
                SBINITEXPRESSIONID := XLATTRIBUTE.EXTRACT('//INIT_EXPRESSION_ID/text()').GETSTRINGVAL();
                
            END IF;
            
            UT_TRACE.TRACE ('sbInitExpressionId ['||SBINITEXPRESSIONID||']', 20);

            
            
            IF ( ( XLATTRIBUTE.EXISTSNODE('//VALID_EXPRESSION_ID') = 1 )
                AND (XLATTRIBUTE.EXTRACT('//VALID_EXPRESSION_ID/text()') IS NOT NULL) )
            THEN

                SBVALEXPRESSIONID := XLATTRIBUTE.EXTRACT('//VALID_EXPRESSION_ID/text()').GETSTRINGVAL();

            END IF;

            UT_TRACE.TRACE ('sbValExpressionId ['||SBVALEXPRESSIONID||']', 20);

            
            GE_BOINSTANCECONTROL.ADDATTRIBUTE(ISBINSTANCENAME, NULL,
                            SBENTITYNAME, SBATTRIBUTENAME, NULL);

            
            IF ( SBINITEXPRESSIONID IS NOT NULL ) THEN
            
                UT_TRACE.TRACE ('Ejecuta expresion de inicializacion ['||SBINITEXPRESSIONID||']', 20);
                GE_BOINSTANCECONTROL.SETATTRIBUTEEXPRESSIONS(ISBINSTANCENAME, NULL,
                      SBENTITYNAME, SBATTRIBUTENAME, TO_NUMBER(SBINITEXPRESSIONID),
                      GE_BOINSTANCECONSTANTS.CNUINITIALIZE_EXPRESSION );
                      
            END IF;

            
            IF ( SBVALEXPRESSIONID IS NOT NULL ) THEN

                UT_TRACE.TRACE ('Ejecuta expresion de validacion ['||SBVALEXPRESSIONID||']', 20);
                GE_BOINSTANCECONTROL.SETATTRIBUTEEXPRESSIONS(ISBINSTANCENAME, NULL,
                      SBENTITYNAME, SBATTRIBUTENAME, TO_NUMBER(SBVALEXPRESSIONID),
                      GE_BOINSTANCECONSTANTS.CNUPROCESS_EXPRESSION );

            END IF;

            
            NUINDEXATTRIBUTE := NUINDEXATTRIBUTE + 1;
            
       END LOOP;

       UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.AddFrame', 15);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;
    END ADDFRAME;

    




















    PROCEDURE CREATEINSTANCE (
        ISBNAMEINIT     IN  VARCHAR2,
        ISBOBJECT_TYPE  IN  NUMBER,
        ISBOBJECT_ID    IN  NUMBER,
        ISBPARENT       IN  VARCHAR2,
        OSBCREATENAME   OUT VARCHAR2
    )
    IS
    
        SBVALUE           GE_BOINSTANCECONTROL.STYSBVALUE;
        SBOBJTYPEPROCESS  VARCHAR2(200) := MO_BOCONFIGURATIONCONTROL.FNUGETPROCESSOBJECT ;

    BEGIN
    
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.CreateInstance. isbNameInit:['|| ISBNAMEINIT
               ||'] isbObject_type:['|| ISBOBJECT_TYPE
               ||'] isbObject_id:['|| ISBOBJECT_ID
               ||'] isbParent:['|| ISBPARENT
               ||'] osbCreateName:['|| OSBCREATENAME ||']', 15);

		MO_BOUNCOMPOSITIONUTIL.GETINSTANCENAME (ISBNAMEINIT, OSBCREATENAME);

        IF (ISBOBJECT_TYPE = MO_BOCONSTANTS.CNUGI_PROCESSENTITY) THEN
        
            MO_BOUNCOMPOSITIONUTIL.CREATEINSTANCE (ISBPARENT, OSBCREATENAME,
                  SBOBJTYPEPROCESS, ISBOBJECT_ID, NULL, GE_BOCONSTANTS.INSERT_);
                  
        END IF;

       UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.CreateInstance retorna ['||OSBCREATENAME||']', 15);
       
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;
    END CREATEINSTANCE;
    
    



















    FUNCTION FSBINSTANCENAME
    (
        ISBPARENTINSTANCE  IN VARCHAR2,
        ISBENTITYNAME      IN VARCHAR2,
        ISBEXTERNALID      IN VARCHAR2
    )
    RETURN VARCHAR2
    IS
    
       CSBINSTANCEDEFAULT  VARCHAR2(2) := '-1'; 
       RFINSTANCE          CONSTANTS.TYREFCURSOR;
       SBINSTANCENAME      VARCHAR2(100);
       SBOBJECTNAME        VARCHAR2(200);
       SBPARENTINSTANCE    VARCHAR2(100);
       SBEXTERNALID        VARCHAR2(100);
       BLFAIL              BOOLEAN;
       SBRETURNINSTANCENAME VARCHAR2(100);
    BEGIN
    
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.fsbInstanceName. isbParentInstance:['|| ISBPARENTINSTANCE
               ||'] isbEntityName:['|| ISBENTITYNAME
               ||'] isbExternalId:['|| ISBEXTERNALID ||']', 15);
               
       BLFAIL := FALSE; 
       SBRETURNINSTANCENAME := NULL;
       
       GETREFINSTANCE(ISBPARENTINSTANCE, ISBENTITYNAME, ISBEXTERNALID, RFINSTANCE);
       
       
       IF( RFINSTANCE%ISOPEN ) THEN
             FETCH RFINSTANCE INTO SBINSTANCENAME,  SBPARENTINSTANCE, SBEXTERNALID, SBOBJECTNAME;
             
             
             IF RFINSTANCE%FOUND THEN
                SBRETURNINSTANCENAME := SBINSTANCENAME;

             
             ELSIF ISBENTITYNAME <> CSBINSTANCEDEFAULT THEN
                SBRETURNINSTANCENAME := FSBINSTANCENAME(ISBPARENTINSTANCE, CSBINSTANCEDEFAULT, ISBEXTERNALID);

             
             ELSE
                SBRETURNINSTANCENAME := NULL;

             END IF;
          CLOSE RFINSTANCE;
       END IF;

       UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.fsbInstanceName Retorna:['|| SBRETURNINSTANCENAME ||']', 15);
       RETURN SBRETURNINSTANCENAME;
       
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
           IF (RFINSTANCE%ISOPEN ) THEN
              CLOSE RFINSTANCE;
           END IF;
             RAISE;
        WHEN OTHERS THEN
           IF (RFINSTANCE%ISOPEN ) THEN
              CLOSE RFINSTANCE;
           END IF;
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;

    END FSBINSTANCENAME;

    



















    PROCEDURE CREATEINSTANCEAPPLICATION(
       INUAPPLICATIONID   IN  SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
       OSBINSTANCENAME    OUT VARCHAR2
    )
    IS
    
       XLAPPLICATION      XMLTYPE;  
       XLWORK             XMLTYPE;  
       SBENTITYNAME       GE_ENTITY.NAME_%TYPE;  
       SBENTITYID         VARCHAR2(50);  
       SBEXTERNALID       VARCHAR2(50);  
       SBATTRIBUTENAME    VARCHAR2(100); 
       SBTAGNAME          VARCHAR2(100); 
       SBCOMPOSITIONID    VARCHAR2(100); 
       SBBEFOREEXPRESSION VARCHAR2(100); 
       BLAPPXML           BOOLEAN;
       
    BEGIN
    
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.CreateInstanceApplication. inuApplicationId:['|| INUAPPLICATIONID ||']', 5);

       
       BLAPPXML := BLISAPPXML( INUAPPLICATIONID, XLAPPLICATION);
       IF ( NOT BLAPPXML ) THEN
         RETURN;
       END IF;

       
       IF ( XLAPPLICATION.EXISTSNODE('//COMPOSITION') = 0 ) THEN
             UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION', 10);
             
            
            GE_BOERRORS.SETERRORCODEARGUMENT(901673, '/PB/COMPOSITION');
            
       END IF;

       
       XLWORK := XLAPPLICATION.EXTRACT('//COMPOSITION');

       
       IF ( XLWORK.EXISTSNODE('/COMPOSITION/ENTITY_NAME/text()') = 0 ) THEN
       
            UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/ENTITY_NAME', 10);
            
            GE_BOERRORS.SETERRORCODEARGUMENT(901673, '/PB/COMPOSITION/ENTITY_NAME');
            
       ELSE
       
           SBENTITYNAME := XLWORK.EXTRACT('/COMPOSITION/ENTITY_NAME/text()').GETSTRINGVAL();
           UT_TRACE.TRACE ('sbEntityName ['||SBENTITYNAME||']', 10);
           
       END IF;

       
       IF ( XLWORK.EXISTSNODE('/COMPOSITION/ENTITY_ID/text()') = 0 ) THEN
       
            UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/ENTITY_ID', 10);
            
            GE_BOERRORS.SETERRORCODEARGUMENT(901673, '/PB/COMPOSITION/ENTITY_ID');
            
       ELSE
       
           SBENTITYID := XLWORK.EXTRACT('/COMPOSITION/ENTITY_ID/text()').GETSTRINGVAL();
           UT_TRACE.TRACE ('sbEntityId ['||SBENTITYID||']', 10);
           
       END IF;

       
       IF ( XLWORK.EXISTSNODE('/COMPOSITION/EXTERNAL_ID/text()') = 0 ) THEN
       
            UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/EXTERNAL_ID', 10);
            
            GE_BOERRORS.SETERRORCODEARGUMENT(901673, '/PB/COMPOSITION/EXTERNAL_ID');
            
       ELSE
       
           SBEXTERNALID := XLWORK.EXTRACT('/COMPOSITION/EXTERNAL_ID/text()').GETSTRINGVAL();
           UT_TRACE.TRACE ('sbExternalId ['||SBEXTERNALID||']', 10);
           
       END IF;

       
       IF ( XLWORK.EXISTSNODE('/COMPOSITION/ATTRIBUTE_NAME/text()') = 0 ) THEN
       
            UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/ATTRIBUTE_NAME', 10);
            
            GE_BOERRORS.SETERRORCODEARGUMENT(901673, '/PB/COMPOSITION/ATTRIBUTE_NAME');
            
       ELSE
       
           SBATTRIBUTENAME := XLWORK.EXTRACT('/COMPOSITION/ATTRIBUTE_NAME/text()').GETSTRINGVAL();
           UT_TRACE.TRACE ('sbAttributeName ['||SBATTRIBUTENAME||']', 10);
           
       END IF;

       
       IF ( XLWORK.EXISTSNODE('/COMPOSITION/TAG_NAME/text()') = 1 ) THEN
       
           SBTAGNAME := XLWORK.EXTRACT('/COMPOSITION/TAG_NAME/text()').GETSTRINGVAL();
           UT_TRACE.TRACE ('sbTagName ['||SBTAGNAME||']', 10);
           
       END IF;

       
       OSBINSTANCENAME := FSBINSTANCENAME(CSBWORKINSTANCE, SBENTITYID, SBEXTERNALID);
       UT_TRACE.TRACE ('osbInstanceName ['||OSBINSTANCENAME||']', 10);

       
       IF (OSBINSTANCENAME IS NULL) THEN
       
          
          ADDATTRIBUTE(CSBWORKINSTANCE, '', SBENTITYNAME, SBATTRIBUTENAME, SBEXTERNALID);
          
          
          CREATEINSTANCE(SBTAGNAME, SBENTITYID, SBEXTERNALID, CSBWORKINSTANCE, OSBINSTANCENAME);

       END IF;

       
       IF ( XLWORK.EXISTSNODE('/COMPOSITION/CONFIGURATION_ID/text()') = 0 ) THEN
       
            UT_TRACE.TRACE ('--ERROR en el nodo /PB/COMPOSITION/CONFIGURATION_ID', 10);
            
            GE_BOERRORS.SETERRORCODEARGUMENT(901673, '/PB/COMPOSITION/CONFIGURATION_ID');
            
       ELSE
       
           SBCOMPOSITIONID := XLWORK.EXTRACT('/COMPOSITION/CONFIGURATION_ID/text()').GETSTRINGVAL();
           UT_TRACE.TRACE ('sbCompositionId ['||SBCOMPOSITIONID||']', 10);
           
       END IF;

       
       ADDFRAME(OSBINSTANCENAME, XLAPPLICATION.EXTRACT(
               '//ATTRIBUTE[PARENT_CONF_ID='||SBCOMPOSITIONID||
               ' and TYPE_ATTRIB_ID = 2 and (IS_VISIBLE=''Y'' or IS_VISIBLE=''X'' or IS_VISIBLE=''C'')]'));

       IF ( ( XLWORK.EXISTSNODE('/COMPOSITION/BEFORE_EXPRESSION_ID') = 1 )
            AND (XLWORK.EXTRACT('/COMPOSITION/BEFORE_EXPRESSION_ID/text()') IS NOT NULL) )
       THEN

            SBBEFOREEXPRESSION := XLWORK.EXTRACT('/COMPOSITION/BEFORE_EXPRESSION_ID/text()').GETSTRINGVAL();
       
            UT_TRACE.TRACE ('Ejecuta la expresion anterior de la composicion ['||SBBEFOREEXPRESSION||']', 20);
            
            GE_BOINSTANCECONTROL.EXECUTEEXPRESSION(TO_NUMBER(SBBEFOREEXPRESSION));
            
       END IF;

       UT_TRACE.TRACE ('Fin FW_BOProcessInstance.CreateInstanceApplication.', 5);
       
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
           UT_TRACE.TRACE ('Error en FW_BOProcessInstance.CreateInstanceApplication. inuApplicationId:['|| INUAPPLICATIONID ||']', 5);
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;

    END CREATEINSTANCEAPPLICATION;

    

















    PROCEDURE INITWORKINSTANCE(
       ISBPRINTERNAME     IN  VARCHAR2,
       ISBPRINTERAUXNAME  IN  VARCHAR2,
       OSBINSTANCENAME    OUT VARCHAR2
    )
    IS
    BEGIN
        UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.InitWorkInstance', 5);
        
          GE_BOINSTANCECONTROL.INITINSTANCEMANAGER ;
          MO_BOUNCOMPOSITIONUTIL.INIT ;

        UT_TRACE.TRACE ('Registro PS_PACKAGE_TYPE PS_PRODUCT_MOTIVE PS_PROD_MOTIVE_COMP', 7);
        MO_BOCONFIGURATIONCONTROL.SETPACKAGEOBJECT(GE_BOENTITY.GETENTITYIDBYNAME('PS_PACKAGE_TYPE'));
        MO_BOCONFIGURATIONCONTROL.SETMOTIVEOBJECT(GE_BOENTITY.GETENTITYIDBYNAME('PS_PRODUCT_MOTIVE'));
        MO_BOCONFIGURATIONCONTROL.SETCOMPONENTOBJECT(GE_BOENTITY.GETENTITYIDBYNAME('PS_PROD_MOTIVE_COMP'));

	    GE_BOINSTANCECONTROL.SETATTRIBUTENAME(GE_BOINSTANCECONSTANTS.CNUDSPLY_NAME);

        GE_BOINSTANCECONTROL.SETDSPLYMODE (GE_BOINSTANCECONSTANTS.CNUUT_TRACE);

        
        UT_TRACE.TRACE ('Se obtiene el nombre de workinstance', 7);
		OSBINSTANCENAME :=  MO_BOUNCOMPOSITIONCONSTANTS.CSBWORK_INSTANCE;

        UT_TRACE.TRACE ('Se crea la instancia ['||OSBINSTANCENAME||']', 7);
		GE_BOINSTANCECONTROL.CREATEINSTANCE (OSBINSTANCENAME, NULL);
		
		UT_TRACE.TRACE ('Se adicionan los atributos de MO_PROCESS', 7);
		
		ADDATTRIBUTE('WORK_INSTANCE', '', 'MO_PROCESS', 'PACKAGE_TYPE_ID', '');
		ADDATTRIBUTE('WORK_INSTANCE', '', 'MO_PROCESS', 'PRINTER', ISBPRINTERNAME);
		ADDATTRIBUTE('WORK_INSTANCE', '', 'MO_PROCESS', 'AUX_PRINTER', ISBPRINTERAUXNAME);
		
		
		UT_TRACE.TRACE ('Se carga la informaci?n del cliente corporativo', 7);
		GI_BOINSTANCEDATA.LOADCORPORATIVEINFORMATION(MO_BOCONSTANTS.FNUGETDEFAULTCORPCUSTOMER);
        UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.InitWorkInstance', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;

    END INITWORKINSTANCE;

    















    PROCEDURE GETAPPLICATION(
       INUAPPLICATIONID   IN   SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
       OSBINSTANCENAME    OUT  VARCHAR2,
       OCUAPPLICATION     OUT  CONSTANTS.TYREFCURSOR
    )
    IS

    BEGIN
    
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.GetApplication. inuApplicationId:['|| INUAPPLICATIONID ||']', 5);

       OCUAPPLICATION := GI_BCFRAMEWORKBATCHPROCESS.FRFAPPLICATION( INUAPPLICATIONID );

       
       IF ( OCUAPPLICATION%ISOPEN ) THEN
       
          
          CREATEINSTANCEAPPLICATION(INUAPPLICATIONID, OSBINSTANCENAME);

       END IF;
       
       UT_TRACE.TRACE ('Fin FW_BOProcessInstance.GetApplication.', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
           UT_TRACE.TRACE ('Error en FW_BOProcessInstance.GetApplication. inuApplicationId:['|| INUAPPLICATIONID ||']', 5);
             RAISE;

        WHEN OTHERS THEN
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;

    END GETAPPLICATION;

    












    FUNCTION FSBVERSION
    RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    
    FUNCTION BLISAPPXML
    (
       INUAPPLICATIONID IN   SA_EXECUTABLE.EXECUTABLE_ID%TYPE,
       OXLAPPXML        OUT    GE_DISTRIBUTION_FILE.APP_XML%TYPE
    ) RETURN BOOLEAN
    IS
       RESULTSQL  BOOLEAN;
    BEGIN
       UT_TRACE.TRACE ('Inicia FW_BOProcessInstance.blisAppXml ['||INUAPPLICATIONID||'] ', 5);
       RESULTSQL := FALSE;
       IF ( GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE%ISOPEN) THEN
        CLOSE GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE;
       END IF;
       
       OPEN  GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE(INUAPPLICATIONID);
       IF ( GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE%ISOPEN) THEN

            FETCH  GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE INTO OXLAPPXML;
            IF  ( GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE%FOUND) THEN
               UT_TRACE.TRACE ('Datos encontrados en XML', 5);
               RESULTSQL := TRUE;
            ELSE
               UT_TRACE.TRACE ('No existen datos en XML', 5);
               RESULTSQL := FALSE;
            END IF;
            CLOSE GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE;
       
       ELSE
          UT_TRACE.TRACE ('No existen datos', 5);
          RESULTSQL := FALSE;
       END IF;
       UT_TRACE.TRACE ('Finaliza FW_BOProcessInstance.blisAppXml',5);
       RETURN RESULTSQL;
       
       EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
           UT_TRACE.TRACE ('Error en FW_BOProcessInstance.blisAppXml. inuApplicationId:['|| INUAPPLICATIONID ||']', 5);
           IF ( GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE%ISOPEN) THEN
             CLOSE GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE;
           END IF;
             RAISE;

        WHEN OTHERS THEN
            IF ( GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE%ISOPEN) THEN
              CLOSE GI_BCFRAMEWORKBATCHPROCESS.CUAPPXMLTYPE;
            END IF;
             ERRORS.SETERROR;
             RAISE EX.CONTROLLED_ERROR;
    END;

END FW_BOPROCESSINSTANCE;