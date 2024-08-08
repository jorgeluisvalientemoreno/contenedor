PACKAGE GC_UICancelInclusion AS




















    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    FUNCTION FSBVERSION RETURN VARCHAR2;

    

    














    
    FUNCTION  CONSULTAINCLUSIONES RETURN CONSTANTS.TYREFCURSOR;
    
    
    




















    PROCEDURE CANCELARINCLUSION(
        ISBINCCSESU             IN VARCHAR2,
        INUCURRENT              IN NUMBER,
        INUTOTAL                IN NUMBER,
        ONUERRORCODE            OUT NUMBER,
        OSBERRORMESS            OUT VARCHAR2
    );
    

END GC_UICANCELINCLUSION;

PACKAGE BODY GC_UICancelInclusion AS

































    
    
    
    
    
    
    
    
    
    
    
    
        CSBVERSION      CONSTANT VARCHAR2(250)  := 'SAO205494';
        CSBAPPNAME      CONSTANT VARCHAR2(4)    := 'FAIO';
        CNUERRNOORD     CONSTANT NUMBER         := 4407;
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    SBERRMSG  GE_MESSAGE.DESCRIPTION%TYPE;
    
    
    
    
    
    
    

    













    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END FSBVERSION;
    

    
    


















    FUNCTION CONSULTAINCLUSIONES
    RETURN CONSTANTS.TYREFCURSOR
    IS
        SBSUSCCODI GE_BOINSTANCECONTROL.STYSBVALUE;
        NUSESUSUSC SERVSUSC.SESUSUSC%TYPE;
        OCUCURSOR  CONSTANTS.TYREFCURSOR;
        RCFUNCIONA FUNCIONA%ROWTYPE;
        SBUSER	   HICAEXCR.HCECUSUA%TYPE;
    BEGIN

        UT_TRACE.TRACE( 'GC_UICancelInclusion.ConsultaInclusiones', 15 );

        SBSUSCCODI := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE ('SUSCRIPC', 'SUSCCODI');
        
        SBUSER     := PKGENERALSERVICES.FSBGETUSERNAME;
        RCFUNCIONA := PKTBLFUNCIONA.FRCGETRECORDUSERBD(SBUSER);
        NUSESUSUSC := UT_CONVERT.FNUCHARTONUMBER(SBSUSCCODI);

        OPEN OCUCURSOR FOR
            SELECT  INCLCOCO.INCCCOIN PK,
                    INCLCOCO.INCCSESU SERVICE_NUMBER,
                    INCLCOCO.INCCSERV ||'-'|| SERVICIO.SERVDESC PRODUCT_TYPE,
                    INCLCOCO.INCCESCO ||'-'|| ESTACORT.ESCODESC EVENTO_DE_CORTE,
                    INCLCOCO.INCCCACD ||'-'|| CAUSCODE.CACDDESC CAUSCODE
            FROM    ESTACORT,
                    CAUSCODE,
                    SERVICIO,
                    INCLCOCO
            WHERE   INCLCOCO.INCCSUSC = NUSESUSUSC
            AND     SERVICIO.SERVCODI = INCLCOCO.INCCSERV
            AND     ESTACORT.ESCOCODI = INCLCOCO.INCCESCO
            AND     CAUSCODE.CACDCODI = INCLCOCO.INCCCACD
            AND     INCLCOCO.INCCFECA IS NULL
            AND     INCLCOCO.INCCCACD IN (
                SELECT  CACECACD
                FROM    CAUSCODD
                WHERE   CACEDEPE = RCFUNCIONA.FUNCDEPE
                AND     CACESERV = INCCSERV);

        UT_TRACE.TRACE( 'Fin GC_UICancelInclusion.ConsultaInclusiones', 15 );
        RETURN OCUCURSOR;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CONSULTAINCLUSIONES;
    
    
































    PROCEDURE CANCELARINCLUSION
    (
        ISBINCCSESU             IN VARCHAR2,
        INUCURRENT              IN NUMBER,
        INUTOTAL                IN NUMBER,
        ONUERRORCODE            OUT NUMBER,
        OSBERRORMESS            OUT VARCHAR2
    )
    IS
        NUCONSINCL      INCLCOCO.INCCCOIN%TYPE;
        RCINCLCOCO      INCLCOCO%ROWTYPE;
        RCFUNCIONA      FUNCIONA%ROWTYPE;
        SBUSER	        HICAEXCR.HCECUSUA%TYPE;
        DTCANCELDATE    EXCOCORE.ECCRFECA%TYPE;
        NUSESUDEPA      SERVSUSC.SESUDEPA%TYPE;
        NUSESULOCA      SERVSUSC.SESULOCA%TYPE;
        NUNUMORDER      OR_ORDER.ORDER_ID%TYPE;
        BLEXITSORDEN    BOOLEAN;
        CSBCONEXION     CONSTANT VARCHAR2(1) := 'C' ; 
        
        
        
        
        




        PROCEDURE LIMPIARMEMORIA IS
        BEGIN
            UT_TRACE.TRACE( 'INICIO: GC_UICancelInclusion.CancelarInclusion.LimpiarMemoria', 16 );

            
            PKTBLEXCOCORE.CLEARMEMORY;
            PKTBLHICAEXCR.CLEARMEMORY;

            UT_TRACE.TRACE( 'FIN: GC_UICancelInclusion.CancelarInclusion.LimpiarMemoria', 16 );
        EXCEPTION
        	WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	    RAISE;
        	WHEN OTHERS THEN
        	    PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        	    RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END LIMPIARMEMORIA;


        




        PROCEDURE INICIALIZAR IS
        BEGIN
            UT_TRACE.TRACE( 'INICIO: GC_UICancelInclusion.CancelarInclusion.Inicializar', 16 );

            PKERRORS.SETAPPLICATION(CSBAPPNAME);

            SBUSER     := PKGENERALSERVICES.FSBGETUSERNAME;
            RCFUNCIONA := PKTBLFUNCIONA.FRCGETRECORDUSERBD(SBUSER);
            DTCANCELDATE := SYSDATE;

            PKGENERALSERVICES.SETSERVICEREP(RCFUNCIONA.FUNCCODI);

            NUCONSINCL := TO_NUMBER(ISBINCCSESU);
            RCINCLCOCO := PKTBLINCLCOCO.FRCGETRECORD(NUCONSINCL);

            
            

            UT_TRACE.TRACE( 'FIN: GC_UICancelInclusion.CancelarInclusion.Inicializar', 16 );
        EXCEPTION
        	WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	    RAISE;
        	WHEN OTHERS THEN
        	    PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        	    RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        END INICIALIZAR;

        















        PROCEDURE PROCESAR
        IS
        BEGIN
            UT_TRACE.TRACE( 'INICIO: GC_UICancelInclusion.CancelarInclusion.Procesar', 16 );

            UT_TRACE.TRACE('Registro               : '||INUCURRENT||'/'||INUTOTAL,1);
            UT_TRACE.TRACE('N�mero de Servicio     : '||RCINCLCOCO.INCCSESU ,1);
            UT_TRACE.TRACE('C�digo de la inclusi�n : '||NUCONSINCL,1);
            UT_TRACE.TRACE('Fecha de cancelaci�n   : '||DTCANCELDATE,1);
            UT_TRACE.TRACE('Servicio subscrito     : '||RCINCLCOCO.INCCSUSC,1);
            UT_TRACE.TRACE('Estado de corte        : '||RCINCLCOCO.INCCESCO,1);

            PKTBLINCLCOCO.UPCANCELDATE(NUCONSINCL,DTCANCELDATE);

            PKINCLUDESUSPCONNMGR.UPDDELINCLUINSERVSUSC
            (
                RCINCLCOCO.INCCSESU,
                RCINCLCOCO.INCCESCO
            );

            
            BLEXITSORDEN := PKSUSPCONNSERVICEMGR.FBLEXISTORDER
                            (
                                -1, 
                                -1, 
                                RCINCLCOCO.INCCSESU,
                                CSBCONEXION
                            );

            IF ( BLEXITSORDEN ) THEN
                UT_TRACE.TRACE('-- Ya existe orden.',17);
                ONUERRORCODE := CNUERRNOORD;
                OSBERRORMESS := GE_BOMESSAGE.FSBGETMESSAGE(ONUERRORCODE,'['||RCINCLCOCO.INCCSESU||']');
            ELSE
                
                PKBSGENERATEORDERINCLUSION.CANCELINCLUSION
                (
                    RCINCLCOCO.INCCSESU,
                    RCINCLCOCO.INCCCACD,
                    RCINCLCOCO.INCCOBSE,
                    NUNUMORDER,
                    ONUERRORCODE,
                    OSBERRORMESS
                );

                
                IF ( NVL(ONUERRORCODE,0) <> 0 OR OSBERRORMESS IS NOT NULL ) THEN
                    UT_TRACE.TRACE('-- Hubo error en el proceso de generacion de ordenes.',17);
                    ONUERRORCODE := CNUERRNOORD;
                    OSBERRORMESS := GE_BOMESSAGE.FSBGETMESSAGE(ONUERRORCODE,'['||RCINCLCOCO.INCCSESU||']');

                ELSE
                    
                    IF ( NUNUMORDER <> 0 ) THEN
                        UT_TRACE.TRACE('-- Se gener� orden '||NUNUMORDER,17);
                        OSBERRORMESS := 'Se creo la �rden ['||NUNUMORDER||']';
                    ELSE
                        UT_TRACE.TRACE('-- No se gener� orden.',17);
                    END IF;
               END IF;

            END IF;

            COMMIT;

            UT_TRACE.TRACE( 'Fin GC_UICancelInclusion.CancelarInclusion.Procesar', 16 );
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END PROCESAR;
        

    BEGIN
    
        UT_TRACE.TRACE( 'INICIO: GC_UICancelInclusion.CancelarInclusion', 15 );
        
        
        
        

        LIMPIARMEMORIA;
        
        INICIALIZAR;

        PROCESAR;
        
        UT_TRACE.TRACE( 'Fin: GC_UICancelInclusion.CancelarInclusion', 15 );
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.GETERRORVAR( ONUERRORCODE, OSBERRORMESS );
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.GETERRORVAR( ONUERRORCODE, OSBERRORMESS );
    END CANCELARINCLUSION;

    
END GC_UICANCELINCLUSION;