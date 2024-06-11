PACKAGE RC_BOCollectFileAutRecep IS









































    
    
    
    
    SUBTYPE STYARCHDX IS BINARY_INTEGER;
    TYPE TYTBLISTARCHIVOS IS TABLE OF RC_CARGAUAR.CAARNOAR%TYPE INDEX BY STYARCHDX;

    
    SUBTYPE STYDIRIDX IS RC_CARGAUAR.CAARRUTA%TYPE;
    TYPE TYTBDIRECTORIOSINDX IS TABLE OF RC_BCPRDAENTI.TYRCDIRECTORIOS INDEX BY STYDIRIDX;


    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    FUNCTION FSBVERSION RETURN VARCHAR2;

    
    PROCEDURE RECORDPROCPROBLEM
    (
        ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE,
        ISBRUTAARCHIVO      IN  RC_CARGAUAR.CAARRUTA%TYPE,
        ISBMENSAJE          IN  VARCHAR2                 ,
        INUENTIDAD          IN  RC_CARGAUAR.CAARENTI%TYPE,
        INUEVENTO           IN  RC_CARGAUAR.CAAREVEN%TYPE,
        INULINEA            IN  NUMBER                   ,
        ISBCONTENIDO        IN  VARCHAR2
    );

    
    PROCEDURE MOVEARCHTOPROCDIR
    (
        ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE,
        ISBRUTAARCHIVO      IN  RC_CARGAUAR.CAARRUTA%TYPE,
        ISBTARGETPATH       IN  RC_CARGAUAR.CAARRUTA%TYPE
    );

    
    FUNCTION FNUGETCOMPANYBYARCHNAME
    (
        ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE
    )
    RETURN RC_CARGAUAR.CAARSIST%TYPE;

    
    FUNCTION FBOSEARCHACTIVEAUTCOLLECPROC
    RETURN BOOLEAN;

    
    PROCEDURE LOADALLDIRECTORIES
    (
        OTBDIRECTORIOSRECAUDO OUT NOCOPY TYTBDIRECTORIOSINDX
    );

    
    PROCEDURE LOADALLDIRSERVERFILES
    (
        ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE,
        ISBRUTAARCHIVOS     IN  RC_CARGAUAR.CAARRUTA%TYPE,
        OTBLISTARCHIVOS     OUT NOCOPY TYTBLISTARCHIVOS
    );

    
    PROCEDURE AUTOMATICREGISTERPROCESS;

    
    PROCEDURE GETPARAMETERS;


END RC_BOCOLLECTFILEAUTRECEP;

PACKAGE BODY RC_BOCollectFileAutRecep IS









































    
    
    
    
    
    
    
    
    

    CSBBITACORA                 CONSTANT VARCHAR2(18)  := 'BITAProcAutoRec_';
    CSBPAR_RUTA_TRAZA           CONSTANT VARCHAR2(31)  := 'RUTA_TRAZA';
    CSBPAR_RUTA_TRABAJO         CONSTANT VARCHAR2(31)  := 'RC_ARCH_PROCESS_PATH';
    CSBPAR_EMPRESA              CONSTANT VARCHAR2(31)  := 'DEFAULT_COMPANY';
    CSBRUTA_TRAZA               CONSTANT VARCHAR2(31)  := 'RUTA_TRAZA';
    CNUEND_OF_FILE              CONSTANT NUMBER        := 1;

    CNUMSG_ERROR_MOVE           CONSTANT NUMBER        := 5786;
    CNUMSG_ERROR_DIR_REPETIDO   CONSTANT NUMBER        := 5773;
    CNUMSG_ERROR_ARCH_YA_REG    CONSTANT NUMBER        := 5911;
    CNUMSG_SISTEMA_NO_EXISTE    CONSTANT NUMBER        := 6548;

    
    CSBVERSION          CONSTANT VARCHAR2(15)  := 'SAO220989';

    
    
    
    
    
    
    
    
    
    
    
    

    SBMSGERR                    GE_ERROR_LOG.DESCRIPTION%TYPE ;  

    
    GBOFLAG_PARAM_CARGADOS      BOOLEAN := FALSE;
    GSBRUTA_TRAZAS              RC_CARGAUAR.CAARRUTA%TYPE;
    GSBRUTA_TRABAJO             RC_CARGAUAR.CAARRUTA%TYPE;
    GSBFAIL_FILE_PATH           RC_CARGAUAR.CAARRUTA%TYPE;
    GSBEMPRESA_POR_DEFECTO      SISTEMA.SISTCODI%TYPE;

    
    
    
    
    PROCEDURE TDD
    (
        ISBCADENA IN VARCHAR2
    );




















FUNCTION FSBVERSION RETURN VARCHAR2 IS
BEGIN

    RETURN CSBVERSION;

END FSBVERSION;





























PROCEDURE RECORDPROCPROBLEM
(
    ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE,
    ISBRUTAARCHIVO      IN  RC_CARGAUAR.CAARRUTA%TYPE,
    ISBMENSAJE          IN  VARCHAR2                 ,
    INUENTIDAD          IN  RC_CARGAUAR.CAARENTI%TYPE,
    INUEVENTO           IN  RC_CARGAUAR.CAAREVEN%TYPE,
    INULINEA            IN  NUMBER                   ,
    ISBCONTENIDO        IN  VARCHAR2
)
IS
    
    
    
    SBNOMBREBITACORA    VARCHAR2(30);
    SBLINEA             VARCHAR2(5000);
    GMANEJADORARCHIVO   UTL_FILE.FILE_TYPE;
    RCREPORTES          REPORTES%ROWTYPE;
    RCREPOINCO          REPOINCO%ROWTYPE;
    SBPARAMETROS        VARCHAR2(2000)  ;
    OSBNOTIFENVIADA     VARCHAR2(2000)  ;
    OSBLOGNOTIF         VARCHAR2(2000)  ;

BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.RecordProcProblem');
    TDD('Recording Problem...');

    
    
    
     GETPARAMETERS;

    
    
    
    SBNOMBREBITACORA := CSBBITACORA || TO_CHAR(SYSDATE,'dd-mm-yyyy') ||'.trc';

    TDD('---------------------------- E R R O R ----------------------------');
    TDD(RPAD('-- D:['||GSBRUTA_TRAZAS||']',65,' ')||'--');
    TDD(RPAD('-- N:['||SBNOMBREBITACORA||']',65,' ')||'--');
    TDD(RPAD('-- M:['||ISBMENSAJE||']',65,' ')||'--');
    TDD('-------------------------------------------------------------------');

    
    
    
    SBLINEA := REPLACE(TO_CHAR(SYSDATE,'dd-Month-yyyy'),' ','') ||    
               '  '||TO_CHAR(SYSDATE,'hh24:mi:ss')              ||    
               '  '||RPAD(NVL(ISBNOMBREARCHIVO,' '),60,' ')     ||    
               '  '||RPAD(NVL(ISBRUTAARCHIVO,' '),80,' ')       ||    
               '  '||ISBMENSAJE;                                      

    
    
    
    GMANEJADORARCHIVO :=
    PKUTLFILEMGR.FOPEN
    (
        GSBRUTA_TRAZAS,    
        SBNOMBREBITACORA,  
        'a'                
    );
    PKUTLFILEMGR.PUT_LINE(GMANEJADORARCHIVO,SBLINEA);

    PKUTLFILEMGR.FCLOSE ( GMANEJADORARCHIVO );
    
    TDD('Recorded!');
    
    
    
    
    TDD('Notifying Problem...');

    
    RCREPORTES.REPONUME := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL ('SQ_REPORTES');
    RCREPORTES.REPOAPLI := PKERRORS.FSBGETAPPLICATION();
    RCREPORTES.REPOFECH := PKGENERALSERVICES.FDTGETSYSTEMDATE();
    RCREPORTES.REPOUSER := PKGENERALSERVICES.FSBGETUSERNAME() ;
    RCREPORTES.REPODESC := SBNOMBREBITACORA;
    RCREPORTES.REPOSTEJ := NULL ;
    
    PKTBLREPORTES.INSRECORD (RCREPORTES);
    
    
    RCREPOINCO.REINREPO     := RCREPORTES.REPONUME ;                        
    RCREPOINCO.REINCODI     := 1 ;                                          
    RCREPOINCO.REINDES1     := TO_CHAR(INUENTIDAD)|| ' - ' ||
                               PKTBLBANCO.FSBGETBANCNOMB (INUENTIDAD) ;     
    RCREPOINCO.REINDES3     := TO_CHAR(INUEVENTO) || ' - ' ||
                               PKTBLEVENDEAU.FSBGETDESCRIPTION (INUEVENTO); 
    RCREPOINCO.REINDES4     := ISBRUTAARCHIVO ;                             
    RCREPOINCO.REINDES5     := ISBNOMBREARCHIVO;                            
    RCREPOINCO.REINLON1     := INULINEA ;                                   
    RCREPOINCO.REINDES2     := ISBCONTENIDO ;                               
    RCREPOINCO.REINOBSE     := ISBMENSAJE ;                                 

    PKTBLREPOINCO.INSRECORD(RCREPOINCO);
    
    
    SBPARAMETROS            :=  TO_CHAR(RCREPOINCO.REINREPO) || '|' ||
                                '1' ;
    
    GE_BOALERTMESSAGEPARAM.VERANDSENDNOTIF
    (
        RC_BOCONSTANTS.CNUREPOINCO      ,   
        SBPARAMETROS                    ,   
        NULL                            ,   
        NULL                            ,   
        OSBNOTIFENVIADA                 ,   
        OSBLOGNOTIF                     ,   
        NULL                                
    );
    
    TDD('Notified!  NotifEnviada: ' || OSBNOTIFENVIADA || ' LogNotif: ' || OSBLOGNOTIF );

    
    
    
    MOVEARCHTOPROCDIR
    (
        ISBNOMBREARCHIVO,
        ISBRUTAARCHIVO,
        GSBFAIL_FILE_PATH
    );
    
    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END RECORDPROCPROBLEM;






























PROCEDURE MOVEARCHTOPROCDIR
(
    ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE,
    ISBRUTAARCHIVO      IN  RC_CARGAUAR.CAARRUTA%TYPE,
    ISBTARGETPATH       IN  RC_CARGAUAR.CAARRUTA%TYPE
)
IS
    
    
    
    SBCOMANDO       VARCHAR2(500);
    NUERROREXE      NUMBER;

BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.MoveArchToProcDir');
    TDD('Moving File...');

    
    
    
    GETPARAMETERS;

    SBCOMANDO := 'mv ' || ISBRUTAARCHIVO  || '/' || ISBNOMBREARCHIVO || ' ' ||
                          ISBTARGETPATH || '/' || ISBNOMBREARCHIVO;

    TDD('['||SBCOMANDO||']');

    
    
    
    NUERROREXE :=
    UT_OSCOMMAND.RUN(SBCOMANDO);

    IF ( NUERROREXE != 0 ) THEN
    
        
        ERRORS.SETERROR(CNUMSG_ERROR_MOVE,REPLACE(UT_OSCOMMAND.GETMESSAGE,CHR(10),' '));
        RAISE LOGIN_DENIED;
    
    END IF;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END MOVEARCHTOPROCDIR;






















FUNCTION FNUGETCOMPANYBYARCHNAME
(
    ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE
)
RETURN RC_CARGAUAR.CAARSIST%TYPE
IS
    
    
    
    SBSEPARADOR         VARCHAR2(100);
    NUEMPRESA           SISTEMA.SISTCODI%TYPE;

BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.fnuGetCompanyByArchName');
    TDD('Obteniendo Empresa...['||ISBNOMBREARCHIVO||']');
    
    
    
    GETPARAMETERS;


    
    IF ( ISBNOMBREARCHIVO IS NULL OR LENGTH(ISBNOMBREARCHIVO) <= 4 ) THEN
    
        PKERRORS.POP;
        RETURN GSBEMPRESA_POR_DEFECTO;
    
    END IF;

    
    
    
    
    SBSEPARADOR := SUBSTR(ISBNOMBREARCHIVO,4,1);

    IF ( SBSEPARADOR = '_') THEN
    
        
        BEGIN
            NUEMPRESA := TO_NUMBER(SUBSTR(ISBNOMBREARCHIVO,1,3));
        
        EXCEPTION
            WHEN OTHERS THEN
            TDD('Valor no num�rico');
            PKERRORS.POP;
            RETURN GSBEMPRESA_POR_DEFECTO;
        END;
    ELSE
        PKERRORS.POP;
        RETURN GSBEMPRESA_POR_DEFECTO;
    
    END IF;

    
    
    
    IF ( NOT PKTBLSISTEMA.FBLEXIST(NUEMPRESA) ) THEN
    
        ERRORS.SETERROR(CNUMSG_SISTEMA_NO_EXISTE,NUEMPRESA);
        RAISE LOGIN_DENIED;
    
    END IF;

    PKERRORS.POP;
    RETURN NUEMPRESA;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END FNUGETCOMPANYBYARCHNAME;






















FUNCTION FBOSEARCHACTIVEAUTCOLLECPROC
RETURN BOOLEAN
IS
    
    
    
    SBCOMANDO           VARCHAR2(200);
    SBARCHIVO_UNICO     VARCHAR2(200);
    NUERROREXE          NUMBER;
    SBLINEA             VARCHAR2(2000);
    GMANEJADORARCHIVO   UTL_FILE.FILE_TYPE;
    NUCODIGO            NUMBER;

BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.fboSearchActiveAutCollecProc');
    TDD('Buscando...FPAU');

    
    
    
    GETPARAMETERS;

    
    
    
    SBCOMANDO       := 'ps -ef | grep fpau | grep -vc grep';
    SBARCHIVO_UNICO := '.AU' ||TO_CHAR(SYSDATE,'hh24miss');
    SBCOMANDO       := SBCOMANDO || ' > ' || GSBRUTA_TRAZAS || '/' ||SBARCHIVO_UNICO;

    TDD('['||SBCOMANDO||']');
    LLAMASIST ( SBCOMANDO );
    
    DBMS_LOCK.SLEEP ( 1.5 );

    
    
    
    GMANEJADORARCHIVO :=
    PKUTLFILEMGR.FOPEN
    (
        GSBRUTA_TRAZAS,    
        SBARCHIVO_UNICO,   
        'r'                
    );
    NUCODIGO := PKUTLFILEMGR.GET_LINE(GMANEJADORARCHIVO,SBLINEA);
    PKUTLFILEMGR.FCLOSE ( GMANEJADORARCHIVO );
    TDD(SBLINEA);

    SBCOMANDO := 'rm '|| GSBRUTA_TRAZAS || '/' ||SBARCHIVO_UNICO;
    LLAMASIST ( SBCOMANDO );
    TDD('Clear: ['||SBCOMANDO||']');

    
    IF ( SBLINEA = 0 ) THEN
    
        TDD('FPAU Idle');
        PKERRORS.POP;
        RETURN FALSE;
    ELSE
        TDD('FPAU Running');
        PKERRORS.POP;
        RETURN TRUE;
    
    END IF;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END FBOSEARCHACTIVEAUTCOLLECPROC;





































































PROCEDURE AUTOMATICREGISTERPROCESS
IS
    
    
    
    NUCODIGOERROR           NUMBER;
    SBMENSAJEERROR          VARCHAR2(2000);

    TBDIRECTORIOS           TYTBDIRECTORIOSINDX;
    SBDIRDX                 STYDIRIDX;

    TBLISTAARCHIVOS         TYTBLISTARCHIVOS;
    NUARCHDX                STYARCHDX;

    RCARCHIVOMATRICULADO    RC_CARGAUAR%ROWTYPE;
    NUCONSECUTIVOMATRICULA  RC_CARGAUAR.CAARCONS%TYPE;
    NUEMPRESARECAUDADORA    RC_CARGAUAR.CAARSIST%TYPE;
    
    SBMSG_ARCH_YA_REG       GE_MESSAGE.DESCRIPTION%TYPE;
    SBCADENACONEXION        VARCHAR2(50);
    SBCOMANDO               VARCHAR2(1000);
    SBRUTATRAZA             PARAMETR.PAMECHAR%TYPE;
    BOMATRICULAEFECTUADA    BOOLEAN;
BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.AutomaticRegisterProcess');
    TDD('Iniciando Proceso Autom�tico...');

    
    
    
    GETPARAMETERS;
    BOMATRICULAEFECTUADA := FALSE;
    
    
    
    
    
    TDD('-- [1] Cargando Directorios...');
    LOADALLDIRECTORIES(TBDIRECTORIOS);

    
    
    
    SBMSG_ARCH_YA_REG :=
    DAGE_MESSAGE.FSBGETDESCRIPTION(CNUMSG_ERROR_ARCH_YA_REG);

    TDD('-- [2] Se recorren los directorios');
    SBDIRDX := TBDIRECTORIOS.FIRST;
    LOOP
    EXIT WHEN ( SBDIRDX IS NULL );

        
        
        
        TDD('');
        TDD('-- [2.1] Se obtienen los archivos para ['||TBDIRECTORIOS(SBDIRDX).DIRECTORIOENTRADA||']');
        LOADALLDIRSERVERFILES
        (
            NULL,                                       
            TBDIRECTORIOS(SBDIRDX).DIRECTORIOENTRADA,   
            TBLISTAARCHIVOS                             
        );

        
        
        
        TDD('');
        TDD('-- [2.2] Se recorren los archivos');
        NUARCHDX := TBLISTAARCHIVOS.FIRST;
        LOOP
        EXIT WHEN ( NUARCHDX IS NULL );
            TDD('-- [2.2.1] Se recorren los archivos');
            
            
            
            
            RC_BCCARGAUAR.LOCKENTITY;
            RCARCHIVOMATRICULADO := NULL;
            TDD('-- [2.2.2] Se recorren los archivos');
            
            
            
            
            
            RCARCHIVOMATRICULADO :=
            RC_BCCARGAUAR.FRCGETREGBYARCHNAME( TBLISTAARCHIVOS(NUARCHDX) );
            IF ( RCARCHIVOMATRICULADO.CAARCONS IS NULL ) THEN
            
                TDD('-- [2.2.3] Se recorren los archivos');
                
                
                
                
                NUEMPRESARECAUDADORA :=
                FNUGETCOMPANYBYARCHNAME(TBLISTAARCHIVOS(NUARCHDX));

                
                
                
                TDD('-- [2.2.4] Matriculando Archivo');
                RC_BCCARGAUAR.REGISTERARCHIVE
                (
                    TBLISTAARCHIVOS(NUARCHDX),                  
                    TBDIRECTORIOS(SBDIRDX).DIRECTORIOENTRADA,   
                    TBDIRECTORIOS(SBDIRDX).ENTIDAD,             
                    TBDIRECTORIOS(SBDIRDX).EVENTO,              
                    NUEMPRESARECAUDADORA,                       
                    NULL,                                       
                    NUCONSECUTIVOMATRICULA                      
                );

                
                
                
                
                
                TDD('-- [2.2.5] Moviendo Archivo a Directorio de Trabajo --');
                MOVEARCHTOPROCDIR
                (
                    TBLISTAARCHIVOS(NUARCHDX),                  
                    TBDIRECTORIOS(SBDIRDX).DIRECTORIOENTRADA,   
                    GSBRUTA_TRABAJO                             
                );

                
                
                
                
                BOMATRICULAEFECTUADA := TRUE;

            ELSE
                
                
                
                RECORDPROCPROBLEM
                (
                    TBLISTAARCHIVOS(NUARCHDX),                  
                    TBDIRECTORIOS(SBDIRDX).DIRECTORIOENTRADA,   
                    SBMSG_ARCH_YA_REG,                          
                    TBDIRECTORIOS(SBDIRDX).ENTIDAD,             
                    TBDIRECTORIOS(SBDIRDX).EVENTO,              
                    NULL,                                       
                    NULL                                        
                );
            
            END IF;

            
            
            
            COMMIT;

            NUARCHDX := TBLISTAARCHIVOS.NEXT( NUARCHDX );
        END LOOP; 

        SBDIRDX := TBDIRECTORIOS.NEXT( SBDIRDX );
    END LOOP; 

    
    
    
    
    IF ( BOMATRICULAEFECTUADA ) THEN
    
        IF ( NOT FBOSEARCHACTIVEAUTCOLLECPROC ) THEN
        
            TDD('Iniciando FPAU');
            SBCADENACONEXION := GE_BODATABASECONNECTION.FSBGETDEFAULTCONNECTIONSTRING;
            SBRUTATRAZA      := TRIM( PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE( CSBRUTA_TRAZA ) );

            SBCOMANDO := 'fpau '|| SBCADENACONEXION ||' > '
                                || SBRUTATRAZA||'/fpau_'||TO_CHAR(SYSDATE,'ddmmyyyy_hh24miss')||'.trc'
                                ||' 2>' || CHR(38) || '1 ' || CHR(38);

            TDD(SBCOMANDO);
            LLAMASIST( SBCOMANDO );
        
        END IF;
    ELSE
        TDD('No se matricularon archivos. No se intenta iniciar [FPAU]');
    
    END IF;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END AUTOMATICREGISTERPROCESS;


























PROCEDURE LOADALLDIRECTORIES
(
    OTBDIRECTORIOSRECAUDO OUT NOCOPY TYTBDIRECTORIOSINDX
)
IS
    
    
    

    
    TBDIRECTORIOS   RC_BCPRDAENTI.TYTBDIRECTORIOS;
    NUIDX           RC_BCPRDAENTI.STYDIRSIDX;

    SBDETALLES      VARCHAR2(2000);
BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.LoadAllDirectories');
    TDD('Cargando Directorios...');

    RC_BCPRDAENTI.GETALLRECCOLLECTDIR(TBDIRECTORIOS);
    TDD('Conteo ['||TBDIRECTORIOS.COUNT||']');

    
    
    
    NUIDX := TBDIRECTORIOS.FIRST;
    LOOP
    EXIT WHEN ( NUIDX IS NULL );

        IF ( OTBDIRECTORIOSRECAUDO.EXISTS(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA) ) THEN
        
            SBDETALLES := TBDIRECTORIOS(NUIDX).EVENTO                                           || '|' || 
                          TBDIRECTORIOS(NUIDX).ENTIDAD                                          || '|' || 
                          OTBDIRECTORIOSRECAUDO(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA).EVENTO  || '|' || 
                          OTBDIRECTORIOSRECAUDO(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA).ENTIDAD;          

            
            ERRORS.SETERROR(CNUMSG_ERROR_DIR_REPETIDO,SBDETALLES);
            RAISE LOGIN_DENIED;
        
        END IF;

        
        OTBDIRECTORIOSRECAUDO(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA).ENTIDAD           :=
        TBDIRECTORIOS(NUIDX).ENTIDAD;

        
        OTBDIRECTORIOSRECAUDO(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA).EVENTO            :=
        TBDIRECTORIOS(NUIDX).EVENTO;
        
        
        OTBDIRECTORIOSRECAUDO(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA).DESC_EVENTO       :=
        TBDIRECTORIOS(NUIDX).DESC_EVENTO;

        
        OTBDIRECTORIOSRECAUDO(TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA).DIRECTORIOENTRADA :=
        TBDIRECTORIOS(NUIDX).DIRECTORIOENTRADA;

        NUIDX := TBDIRECTORIOS.NEXT(NUIDX);
    END LOOP;

    
    TBDIRECTORIOS.DELETE;
    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END LOADALLDIRECTORIES;































PROCEDURE LOADALLDIRSERVERFILES
(
    ISBNOMBREARCHIVO    IN  RC_CARGAUAR.CAARNOAR%TYPE,
    ISBRUTAARCHIVOS     IN  RC_CARGAUAR.CAARRUTA%TYPE,
    OTBLISTARCHIVOS     OUT NOCOPY TYTBLISTARCHIVOS
)
IS
    
    
    
    SBCOMANDO           VARCHAR2(200);
    SBARCHIVO_UNICO     VARCHAR2(200);
    GMANEJADORARCHIVO   UTL_FILE.FILE_TYPE;
    NUCODIGO            NUMBER;
    SBLINEA             VARCHAR2(2000);
    NULINEA             NUMBER;

BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.LoadAllDirServerFiles');

    
    
    
    SBARCHIVO_UNICO := '.ALU' ||TO_CHAR(SYSDATE,'hh24miss');
    IF ( ISBNOMBREARCHIVO IS NOT NULL ) THEN
    
        SBCOMANDO := 'ls -lrt '||ISBRUTAARCHIVOS||' | grep ^- |awk ''{printf $NF;printf "\n"}'' | grep -i '||ISBNOMBREARCHIVO;
    ELSE

        SBCOMANDO := 'ls -lrt '||ISBRUTAARCHIVOS||' | grep ^- |awk ''{printf $NF;printf "\n"}''';
    
    END IF;
    SBCOMANDO       := SBCOMANDO || ' > ' || ISBRUTAARCHIVOS || '/' ||SBARCHIVO_UNICO;

    TDD('Comando: ['||SBCOMANDO||']');

    TDD(SBCOMANDO);
    LLAMASIST( SBCOMANDO );

    DBMS_LOCK.SLEEP ( 3 );

    
    
    
    GMANEJADORARCHIVO :=
    PKUTLFILEMGR.FOPEN
    (
        ISBRUTAARCHIVOS,   
        SBARCHIVO_UNICO,   
        'r'                
    );

    NULINEA := 0;
    LOOP
        NUCODIGO := PKUTLFILEMGR.GET_LINE(GMANEJADORARCHIVO,SBLINEA);
        EXIT WHEN ( NUCODIGO = CNUEND_OF_FILE );

        OTBLISTARCHIVOS(NULINEA) := SBLINEA;
        NULINEA := NULINEA + 1;

    END LOOP;
    PKUTLFILEMGR.FCLOSE ( GMANEJADORARCHIVO );
    TDD('Lineas: ['||OTBLISTARCHIVOS.COUNT||']');

    
    
    
    SBCOMANDO := 'rm '|| ISBRUTAARCHIVOS || '/' ||SBARCHIVO_UNICO;
    LLAMASIST ( SBCOMANDO );
    TDD('Clear: ['||SBCOMANDO||']');

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END LOADALLDIRSERVERFILES;































PROCEDURE GETPARAMETERS
IS
    
    SBJOB_PATHS     GE_PARAMETER.VALUE%TYPE;
    
    TBPATHS         UT_STRING.TYTB_STRING;
    
    CSBDELIMITER    CONSTANT VARCHAR2(1) := '|';
BEGIN
    PKERRORS.PUSH('RC_BOCollectFileAutRecep.GetParameters');

    IF ( NOT GBOFLAG_PARAM_CARGADOS ) THEN
    
        TDD('----------------------------');
        TDD('-- Cargando Par�metros... --');
        TDD('-- Ruta Trazas            --');
        TDD('-- Ruta de Trabajo        --');
        TDD('-- Compa�ia por Defecto   --');
        TDD('----------------------------');

        
        GSBRUTA_TRAZAS :=
        TRIM(PKGENERALPARAMETERSMGR.FSBGETSTRINGPARAMETER(CSBPAR_RUTA_TRAZA));

        
        SBJOB_PATHS := TRIM(GE_BOPARAMETER.FSBGET(CSBPAR_RUTA_TRABAJO));
        
        
        UT_STRING.EXTSTRING
        (
            SBJOB_PATHS,
            CSBDELIMITER,
            TBPATHS
        );

        IF ( TBPATHS.FIRST IS NOT NULL ) THEN
        
            
            GSBRUTA_TRABAJO := TBPATHS(TBPATHS.FIRST);
        
        END IF;
        
        IF ( TBPATHS.LAST IS NOT NULL ) THEN
        
            
            GSBFAIL_FILE_PATH := TBPATHS(TBPATHS.LAST);
        
        END IF;

        
        GSBEMPRESA_POR_DEFECTO :=
        GE_BOPARAMETER.FNUGET (CSBPAR_EMPRESA);

        
        GBOFLAG_PARAM_CARGADOS := TRUE;
        
        TDD('----------------------------');
        TDD('gsbRUTA_TRAZAS - '||GSBRUTA_TRAZAS        );
        TDD('gsbRUTA_TRABAJO - '||GSBRUTA_TRABAJO       );
        TDD('gsbEMPRESA_POR_DEFECTO - '||GSBEMPRESA_POR_DEFECTO);
        TDD('gsbFAIL_FILE_PATH - '||GSBFAIL_FILE_PATH);
        TDD('----------------------------');
        
    
    END IF;

    PKERRORS.POP;
EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
        RAISE LOGIN_DENIED;
    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        PKERRORS.POP;
        RAISE PKCONSTANTE.EXERROR_LEVEL2;
    WHEN OTHERS THEN
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSGERR );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBMSGERR);

END GETPARAMETERS;



















PROCEDURE TDD
(
    ISBCADENA IN VARCHAR2
)
IS
BEGIN

    TD(ISBCADENA);
    UT_TRACE.TRACE(ISBCADENA,1);

END TDD;




END RC_BOCOLLECTFILEAUTRECEP;