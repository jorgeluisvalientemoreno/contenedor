PACKAGE BODY GC_BOCastigocartera AS















































































































    
     CSBVERSION     CONSTANT VARCHAR2(250)            := 'SAO360935';
     
     
     CSBPUNISH      CONSTANT VARCHAR2(10) := 'PUN-';
     
     CNUTRAZA       NUMBER := 10;
     
    
    
    
     
    
    

    
    TBBILLNOTES             GC_BCCASTIGOCARTERA.TYTBBILLNOTES;
    
    
    TBCHARGECAUSES          GC_BCCASTIGOCARTERA.TYTBPUNISHTYPECAUSES;

    
    
    

    
    
    

    
    CSBNOTEOBSE		CONSTANT NOTAS.NOTAOBSE%TYPE := PKBILLINGNOTEMGR.CSBUCAS;

    
    
    

    
    SBERRMSG        GE_ERROR_LOG.DESCRIPTION%TYPE;

    
    
    
    
    
    
    
    
    
    













    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
        RETURN GC_BOCASTIGOCARTERA.CSBVERSION;
    END FSBVERSION;

    




























    FUNCTION FBLEXISTEDOCCASTIGADO(INUNUM_DOCUMENTO IN FACTURA.FACTCODI%TYPE,
                                   INUTIPO_DOCUMENTO IN FACTURA.FACTCONS%TYPE,
                                   ONUTIPOCAST OUT GC_PRODPRCA.PRPCTICA%TYPE)
    RETURN BOOLEAN
    IS
    BEGIN
        PKERRORS.PUSH('GC_BOCastigocartera.fblExisteDocCastigado');

        FOR RC IN GC_BCCASTIGOCARTERA.CUPRODCAST(INUNUM_DOCUMENTO,
                                                 INUTIPO_DOCUMENTO) LOOP
            ONUTIPOCAST := RC.PRPCTICA;
            PKERRORS.POP;
            RETURN PKCONSTANTE.VERDADERO;
        END LOOP;

        PKERRORS.POP;
        RETURN  PKCONSTANTE.FALSO;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
           PKERRORS.POP;
           RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	   PKERRORS.POP;
           RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
           PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG);
           PKERRORS.POP;
           RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,GC_BOCASTIGOCARTERA.SBERRMSG);
    END FBLEXISTEDOCCASTIGADO;
    
    
























    FUNCTION FSBEXISTEDOCCASTIGADO
    (
        INUNUM_DOCUMENTO    IN  FACTURA.FACTCODI%TYPE,
        INUTIPO_DOCUMENTO   IN  FACTURA.FACTCONS%TYPE
    )
    RETURN VARCHAR2
    IS
        
        NUTIPOCAST      GC_PRODPRCA.PRPCTICA%TYPE;
        
        BLCASTIGO       BOOLEAN;
        
        SBCASTIGO       VARCHAR2(1);
    BEGIN
    
        PKERRORS.PUSH('GC_BOCastigocartera.fsbExisteDocCastigado');

        
        BLCASTIGO := FBLEXISTEDOCCASTIGADO
                                        (
                                            INUNUM_DOCUMENTO,
                                            INUTIPO_DOCUMENTO,
                                            NUTIPOCAST
                                        );

        
        IF BLCASTIGO THEN
        
            SBCASTIGO := PKCONSTANTE.SI;
        
        ELSE
        
            SBCASTIGO := PKCONSTANTE.NO;
        
        END IF;

        PKERRORS.POP;

        
        RETURN ( SBCASTIGO );

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
        	RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,GC_BOCASTIGOCARTERA.SBERRMSG);
    
    END FSBEXISTEDOCCASTIGADO;
    
    
















    PROCEDURE VALSTATUSPROYECT
    (
        INUPROJECT IN GC_PROYCAST.PRCACONS%TYPE
    )
    IS
        
        SBSTATUS    GC_PROYCAST.PRCAESTA%TYPE;
        
        
        CNUFINISHEDPROJECT          CONSTANT NUMBER := 901016;
        CNUINVALIDSTATEPROJECT      CONSTANT NUMBER := 300330;

    BEGIN

        PKERRORS.PUSH ('GC_BOCastigoCartera.ValStatusProyect');

        
        DAGC_PROYCAST.ACCKEY( INUPROJECT );

        
        SBSTATUS := DAGC_PROYCAST.FSBGETPRCAESTA(INUPROJECT);

        
        IF ( SBSTATUS = GC_BOGENACCINFWRITEOFF.CSBPROJ_STAT_FINISHED ) THEN
           ERRORS.SETERROR
                    (
                        CNUFINISHEDPROJECT,
                        INUPROJECT
                    );
            PKERRORS.POP;
            RAISE EX.CONTROLLED_ERROR;
        
        ELSIF  ( SBSTATUS = GC_BOGENACCINFWRITEOFF.CSBPROJ_STAT_PROCESSIN  ) THEN
           ERRORS.SETERROR
                    (
                        CNUINVALIDSTATEPROJECT,
                        INUPROJECT||'|'||'[P]'
                    );
           PKERRORS.POP;
           RAISE EX.CONTROLLED_ERROR;
        END IF;

        PKERRORS.POP;

    EXCEPTION
    WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
         PKERRORS.POP;
         RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
           PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG);
           PKERRORS.POP;
           RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,GC_BOCASTIGOCARTERA.SBERRMSG);
    END VALSTATUSPROYECT;

    
    
























    PROCEDURE VALPARAMPROGRAM
    (
         INUPROJECT       IN GC_PROYCAST.PRCACONS%TYPE,
         ISBFRECUENCIA    IN  GE_PROCESS_SCHEDULE.FREQUENCY%TYPE
    )
    IS
        
        CNUNULL_ATTRIBUTE           CONSTANT NUMBER := 2126;

        
        CSBPARAMETRO CONSTANT PARAMETR.PAMECODI%TYPE:='NRO_PROCESOS_PARALELO';
        
        
        CNUFREQUENCY_VALUE          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900536;

        
        NUNUMHILOS NUMBER;

    BEGIN
        PKERRORS.PUSH('GC_BOCastigoCartera.ValParamProgram');

       
        IF (ISBFRECUENCIA IS NULL )THEN
            PKERRORS.SETERRORCODE(PKCONSTANTE.CSBDIVISION,
                                  PKCONSTANTE.CSBMOD_BIL,
                                  CNUNULL_ATTRIBUTE
                                  );
            PKERRORS.CHANGEMESSAGE('%1','Frecuencia');
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        END IF;

        
        IF (ISBFRECUENCIA NOT IN (GE_BOSCHEDULE.CSBSOLOUNAVEZ)) THEN

             ERRORS.SETERROR
             (
                CNUFREQUENCY_VALUE,
                'La Frecuencia de programaci�n debe ser S�LO UNA VEZ'
             );

            PKERRORS.POP;
            RAISE LOGIN_DENIED;
            
        END IF;

        NUNUMHILOS := PKGENERALPARAMETERSMGR.FNUGETNUMBERVALUE (CSBPARAMETRO);

        
        IF( NUNUMHILOS IS NULL ) THEN
                
                ERRORS.SETERROR
                (
                    1422,
                    CSBPARAMETRO
                );
                PKERRORS.POP;
                
                RAISE LOGIN_DENIED;
        END IF;

        
        VALSTATUSPROYECT (  INUPROJECT
                          );



        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            PKERRORS.POP;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM,
                                                GC_BOCASTIGOCARTERA.SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,
                                                GC_BOCASTIGOCARTERA.SBERRMSG);
    END VALPARAMPROGRAM;

    























    PROCEDURE GETPUNISHBALANCEBYPROD
    (
        INUPRODUCT      IN  SERVSUSC.SESUNUSE%TYPE,
        OTBREACTCHARGES OUT NOCOPY PKBCCHARGES.TYTBREACCHARGES
    )
    IS

        
        RCTIPOCAST  TIPOCAST%ROWTYPE;
    
        
        TBPROJECTS      DAGC_PRODPRCA.TYTBGC_PRODPRCA;
        
        
        TBNOTES         PKTBLNOTAS.TYTBNOTAS;
        

        
        TBCARGCONC      PKTBLCARGOS.TYCARGCONC;
        TBCARGCUCO      PKTBLCARGOS.TYCARGCUCO;
        TBCARGVALO      PKTBLCARGOS.TYCARGVALO;
        TBCARGVABL      PKTBLCARGOS.TYCARGVABL;
        
        
        NUREACTCHRINDEX NUMBER;
        
        GTBNOTES        PKTBLNOTAS.TYNOTANUME;
    BEGIN
        PKERRORS.PUSH( 'GC_BOCastigocartera.GetPunishBalanceByProd' );
        UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.GetPunishBalanceByProd]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        
        
        OTBREACTCHARGES.DELETE;
        
        
        GC_BCPRODPRCA.GETPUNISHPROJECTSBYPROD( INUPRODUCT, TBPROJECTS );
        
        
        IF TBPROJECTS.COUNT > 0 THEN
        
            
            FOR NUIND IN TBPROJECTS.FIRST .. TBPROJECTS.LAST LOOP
            
                
                
                PKBCNOTAS.GETPUNISHNOTES(
                                            TBPROJECTS( NUIND ).PRPCSUSC,
                                            TBPROJECTS( NUIND ).PRPCPRCA,
                                            TBPROJECTS( NUIND ).PRPCFECA,
                                            TBNOTES
                                        );
                
                IF TBNOTES.NOTANUME.COUNT > 0 THEN
                
                    
                    IF NOT GC_BOCASTIGOCARTERA.TBCHARGECAUSES.EXISTS( TBPROJECTS( NUIND ).PRPCTICA ) THEN
                        
                        RCTIPOCAST := PKTBLTIPOCAST.FRCGETRECORD( TBPROJECTS( NUIND ).PRPCTICA );
                        
                        GC_BOCASTIGOCARTERA.TBCHARGECAUSES( TBPROJECTS(NUIND).PRPCTICA ).NUPUNISHCAUSE := RCTIPOCAST.TICACACA;
                        
                        GC_BOCASTIGOCARTERA.TBCHARGECAUSES( TBPROJECTS(NUIND).PRPCTICA ).NUREACTCAUSE :=RCTIPOCAST.TICACARE;
                    END IF;
                    
                    
                    FOR NUNOTEIND IN TBNOTES.NOTANUME.FIRST .. TBNOTES.NOTANUME.LAST LOOP

                        
                        IF (NOT GTBNOTES.EXISTS(TBNOTES.NOTANUME( NUNOTEIND ))) THEN
                            
                            PKBCCHARGES.GETPUNISHBALANCEBYCONC(
                                                                TBNOTES.NOTANUME( NUNOTEIND ),
                                                                TBPROJECTS( NUIND ).PRPCNUSE,
                                                                GC_BOCASTIGOCARTERA.TBCHARGECAUSES(TBPROJECTS(NUIND).PRPCTICA).NUPUNISHCAUSE,
                                                                GC_BOCASTIGOCARTERA.TBCHARGECAUSES(TBPROJECTS(NUIND).PRPCTICA).NUREACTCAUSE,
                                                                TBCARGCONC,
                                                                TBCARGCUCO,
                                                                TBCARGVALO,
                                                                TBCARGVABL
                                                              );
                            
                            IF TBCARGCONC.COUNT > 0 THEN

                                
                                FOR NUINDCHARGE IN TBCARGCONC.FIRST .. TBCARGCONC.LAST LOOP

                                    
                                    NUREACTCHRINDEX := OTBREACTCHARGES.COUNT + 1;

                                    
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).NUCHARGEVALUE := ABS( TBCARGVALO( NUINDCHARGE ) );
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).NUBASECHVALUE := ABS( TBCARGVABL( NUINDCHARGE ) );
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).NUCHARGECAUSE := GC_BOCASTIGOCARTERA.TBCHARGECAUSES( TBPROJECTS( NUIND ).PRPCTICA ).NUREACTCAUSE;
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).NUCHARGECONC := TBCARGCONC( NUINDCHARGE );
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).NUACCOUNT := TBCARGCUCO( NUINDCHARGE );
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).SBSUPPORTDOC := GC_BOCASTIGOCARTERA.CSBPUNISH || TBPROJECTS( NUIND ).PRPCPRCA;
                                    
                                    OTBREACTCHARGES( NUREACTCHRINDEX ).SBSIGN := PKCHARGEMGR.FSBGETCANCELSIGN( TBCARGVALO( NUINDCHARGE ) );
                                END LOOP;
                                
                                
                                GTBNOTES(TBNOTES.NOTANUME( NUNOTEIND )) := TBNOTES.NOTANUME( NUNOTEIND );
                                
                            END IF;
                            
                        END IF;
                    END LOOP;
                END IF;
            END LOOP;
        END IF;

        UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.GetPunishBalanceByProd]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
    END GETPUNISHBALANCEBYPROD;
    
    



























    PROCEDURE REACTNEGOCIATEDDEBT
    (
        IOTBDEBTNEGOCHARGES IN OUT NOCOPY GC_BCDEBTNEGOCHARGE.TYTBDEBTNEGOCHARGES,
        INUPRODUCT          IN  SERVSUSC.SESUNUSE%TYPE
    )
    IS
        
        
        TBREACTCHARGES  PKBCCHARGES.TYTBNOTECHARGES;
        
        
        TBREACTBALANCE  GC_BCCASTIGOCARTERA.TYTBPROJECTREACVALUE;
        
        
        NUREACINDEX     NUMBER;
        
        
        SBTOKEN         VARCHAR2(20) := GC_BOCASTIGOCARTERA.CSBPUNISH || '%';
        
        
        NUSUBSCRIPTION  SERVSUSC.SESUSUSC%TYPE;
        
        








































        PROCEDURE GETREACTDEBTCHARGES
        (
            ITBDEBTCHARGES  IN  GC_BCDEBTNEGOCHARGE.TYTBDEBTNEGOCHARGES,
            OTBREACTCHARGES OUT NOCOPY  PKBCCHARGES.TYTBNOTECHARGES,
            OTBREACTBALANCE OUT NOCOPY  GC_BCCASTIGOCARTERA.TYTBPROJECTREACVALUE
        )
        IS
            
            SBREACTBALANCEINDEX VARCHAR2(100);
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.ReactNegociatedDebt.GetReactDebtCharges' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.ReactNegociatedDebt.GetReactDebtCharges]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            IF ITBDEBTCHARGES.COUNT > 0 THEN

                
                
                FOR NUIND IN ITBDEBTCHARGES.FIRST .. ITBDEBTCHARGES.LAST LOOP

                    
                    
                    IF (ITBDEBTCHARGES( NUIND ).SUPPORT_DOCUMENT LIKE SBTOKEN
                        AND ITBDEBTCHARGES( NUIND ).IS_DISCOUNT = PKCONSTANTE.NO )

                    THEN

                        
                        OTBREACTCHARGES( NUIND ).CARGIDEN := NUIND;
                        OTBREACTCHARGES( NUIND ).CARGCUCO := ITBDEBTCHARGES( NUIND ).CUCOCODI;
                        OTBREACTCHARGES( NUIND ).CARGNUSE := INUPRODUCT;
                        OTBREACTCHARGES( NUIND ).CARGCONC := ITBDEBTCHARGES( NUIND ).CONCCODI;
                        OTBREACTCHARGES( NUIND ).CARGCACA := ITBDEBTCHARGES( NUIND ).CACACODI;
                        OTBREACTCHARGES( NUIND ).CARGSIGN := ITBDEBTCHARGES( NUIND ).SIGNCODI;
                        OTBREACTCHARGES( NUIND ).CARGDOSO := ITBDEBTCHARGES( NUIND ).SUPPORT_DOCUMENT;
                        OTBREACTCHARGES( NUIND ).CARGVACO := ITBDEBTCHARGES( NUIND ).BILLED_VALUE;
                        OTBREACTCHARGES( NUIND ).CARGVBLC := ITBDEBTCHARGES( NUIND ).BILLED_BASE_VALUE;

                        
                        SBREACTBALANCEINDEX := SUBSTR( ITBDEBTCHARGES( NUIND ).SUPPORT_DOCUMENT, 5 );
                        
                        
                        OTBREACTBALANCE( SBREACTBALANCEINDEX ).NUPRODUCT := INUPRODUCT;
                        
                        IF ITBDEBTCHARGES( NUIND ).SIGNCODI = PKBILLCONST.DEBITO THEN
                            
                            OTBREACTBALANCE( SBREACTBALANCEINDEX ).NUREACTVALUE :=
                                OTBREACTBALANCE( SBREACTBALANCEINDEX ).NUREACTVALUE + ITBDEBTCHARGES( NUIND ).BILLED_VALUE;
                        ELSE
                            
                            OTBREACTBALANCE( SBREACTBALANCEINDEX ).NUREACTVALUE :=
                                OTBREACTBALANCE( SBREACTBALANCEINDEX ).NUREACTVALUE - ITBDEBTCHARGES( NUIND ).BILLED_VALUE;
                        END IF;

                    END IF;
                END LOOP;
            END IF;
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.ReactNegociatedDebt.GetReactDebtCharges]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END GETREACTDEBTCHARGES;
        
        




















        PROCEDURE UPDATEPUNISHBALANCE
        (
            ITBREACTBALANCE IN  GC_BCCASTIGOCARTERA.TYTBPROJECTREACVALUE
        )
        IS
            
            SBINDEX         VARCHAR2(100);
            
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.ReactNegociatedDebt.UpdatePunishBalance' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.ReactNegociatedDebt.UpdatePunishBalance]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            SBINDEX := ITBREACTBALANCE.FIRST;
            
            
            LOOP
                
                EXIT WHEN SBINDEX IS NULL;
                
                
                GC_BCPRODPRCA.UPDATEREACTBALBYPRODPOJECT
                (
                    ITBREACTBALANCE( SBINDEX ).NUPRODUCT,
                    TO_NUMBER( SBINDEX ),
                    ITBREACTBALANCE( SBINDEX ).NUREACTVALUE
                );
                
                
                SBINDEX := ITBREACTBALANCE.NEXT( SBINDEX );
                
            END LOOP;
            
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.ReactNegociatedDebt.UpdatePunishBalance]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END UPDATEPUNISHBALANCE;
        
        



















        PROCEDURE CREATEREACTNOTES
        (
            IOTBREACTCHARGES IN OUT NOCOPY  PKBCCHARGES.TYTBNOTECHARGES
        )
        IS
            
            TBREACTNOTES    PKBILLINGNOTEMGR.TYTBNOTAMEM;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.ReactNegociatedDebt.CreateReactNotes' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.ReactNegociatedDebt.CreateReactNotes]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            FA_BOBILLINGNOTES.CREATENOTESFROMMEMORY
            (
                NUSUBSCRIPTION,
                PKBILLINGNOTEMGR.CSBURCC,
                IOTBREACTCHARGES,
                FA_BOBILLINGNOTES.CSBPUNISH_NOTE_TYPE,
                TBREACTNOTES
            );

            
            IF TBREACTNOTES.COUNT > 0 THEN
                
                FOR NUIND IN TBREACTNOTES.FIRST .. TBREACTNOTES.LAST LOOP
                    
                    PKBILLINGNOTEMGR.PROCESONUMERACIONFISCAL( TBREACTNOTES( NUIND ).NOTANUME );
                END LOOP;
            END IF;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.ReactNegociatedDebt.CreateReactNotes]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END CREATEREACTNOTES;
        
        


























        PROCEDURE UPDATEDEBTCHARGESINFO
        (
            ITBREACTCHARGES IN PKBCCHARGES.TYTBNOTECHARGES
        )
        IS
            
            NUIND       NUMBER;
            
            
            RCPERIFACT  PERIFACT%ROWTYPE;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.ReactNegociatedDebt.UpdatedebtChargesInfo' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.ReactNegociatedDebt.UpdatedebtChargesInfo]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
          	PKSUBSCRIBERMGR.ACCCURRENTPERIOD( NUSUBSCRIPTION, RCPERIFACT );
            
          	
          	NUIND := ITBREACTCHARGES.FIRST;

            
            LOOP
                EXIT WHEN NUIND IS NULL;
                
                IF IOTBDEBTNEGOCHARGES.EXISTS(ITBREACTCHARGES(NUIND).CARGIDEN)
                    THEN
                    

                    IOTBDEBTNEGOCHARGES(ITBREACTCHARGES(NUIND).CARGIDEN).SUPPORT_DOCUMENT :=
                        ITBREACTCHARGES( NUIND ).CARGDOSO;

                    
                    IOTBDEBTNEGOCHARGES(ITBREACTCHARGES(NUIND).CARGIDEN).PEFACODI
                        := RCPERIFACT.PEFACODI;
                END IF;
                NUIND := ITBREACTCHARGES.NEXT(NUIND);
            END LOOP;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.ReactNegociatedDebt.UpdatedebtChargesInfo]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END UPDATEDEBTCHARGESINFO;
        
        






















        PROCEDURE UPDATEFINANCIALSTATUS
        (
            INUPUNISHPRODUCT    IN  SERVSUSC.SESUNUSE%TYPE
        )
        IS
            
            CSBDEBT_STATUS  CONSTANT SERVSUSC.SESUESFN%TYPE := 'D';
            
            
            NUPUNISBALANCE  GC_PRODPRCA.PRPCSARE%TYPE := 0;
            
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.ReactNegociatedDebt.UpdateFinancialStatus' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.ReactNegociatedDebt.UpdateFinancialStatus]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            NUPUNISBALANCE := GC_BCCASTIGOCARTERA.FNUOBTCARCASTPORSERVS ( INUPUNISHPRODUCT );
            
            
            IF NUPUNISBALANCE <= 0 THEN
                
                PKTBLSERVSUSC.UPDSESUESFN( INUPUNISHPRODUCT, CSBDEBT_STATUS );
            END IF;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.ReactNegociatedDebt.UpdateFinancialStatus]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END UPDATEFINANCIALSTATUS;

    BEGIN
        PKERRORS.PUSH( 'GC_BOCastigocartera.ReactNegociatedDebt' );
        UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.ReactNegociatedDebt]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        
        
        NUSUBSCRIPTION := PKTBLSERVSUSC.FNUGETSESUSUSC( INUPRODUCT );

        
        GETREACTDEBTCHARGES( IOTBDEBTNEGOCHARGES, TBREACTCHARGES, TBREACTBALANCE );
        
        
        IF TBREACTCHARGES.COUNT > 0 THEN

            
            UPDATEPUNISHBALANCE( TBREACTBALANCE );

            
            CREATEREACTNOTES( TBREACTCHARGES );

            
            UPDATEDEBTCHARGESINFO( TBREACTCHARGES );
            
            
            UPDATEFINANCIALSTATUS( INUPRODUCT );
            
        END IF;
        
        UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.ReactNegociatedDebt]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
    END REACTNEGOCIATEDDEBT;
    
    























    FUNCTION FNUGETSUBSCRIBERSTOPROCESS
    (
        INUPROJECT      IN  GC_PRODPRCA.PRPCPRCA%TYPE,
        INUTOTALTHREADS IN  NUMBER,
        INUTHREAD       IN  NUMBER
    )
    RETURN NUMBER
    IS
        
        NUTOTALSUBSCRIBERS  NUMBER := 0;
    BEGIN
        PKERRORS.PUSH( 'GC_BOCastigocartera.fnuGetSubscribersToProcess' );
        UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.fnuGetSubscribersToProcess]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        
        
        NUTOTALSUBSCRIBERS := GC_BCPRODPRCA.FNUGETSUBSBYPOJECTTHREAD
                              (
                                  INUPROJECT,
                                  INUTOTALTHREADS,
                                  INUTHREAD
                              );
        UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.fnuGetSubscribersToProcess]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        PKERRORS.POP;

        
        RETURN NVL( NUTOTALSUBSCRIBERS, 0 );
    
    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
    END FNUGETSUBSCRIBERSTOPROCESS;
    
    









































    PROCEDURE PUNISHSUBSCRIPTIONS
    (
        INUPROJECT      IN  GC_PRODPRCA.PRPCPRCA%TYPE,
        INUTOTALTHREADS IN  NUMBER,
        INUTHREAD       IN  NUMBER,
        ISBSTATUSPROG   IN  ESTAPROG.ESPRPROG%TYPE
    )
    IS
        
        TBPOLITICS          DAGC_POLICACA.TYTBGC_POLICACA;
        
        
        TBUPDATEPRODUCTS    DAGC_PRODPRCA.TYTBGC_PRODPRCA;
        
        
        RCPUNISHPROJECT     DAGC_PROYCAST.STYGC_PROYCAST;
        
        
        RCSISTEMA   SISTEMA%ROWTYPE;
        
        
        BOERROR             BOOLEAN := FALSE;
        
        


















        PROCEDURE INITIALIZE
        IS
            
            CSBPUNISH_PROCESS   CONSTANT VARCHAR2(10) := 'CASCA';
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.Initialize' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.Initialize]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            PKERRORS.INITIALIZE;
            
            
            PKERRORS.SETAPPLICATION( CSBPUNISH_PROCESS );
            
            
            GC_BOCASTIGOCARTERA.TBBILLNOTES.DELETE;
            GC_BOCASTIGOCARTERA.TBCHARGECAUSES.DELETE;
            
            
            RCPUNISHPROJECT := DAGC_PROYCAST.FRCGETRECORD( INUPROJECT );
            
            
            RCSISTEMA := PKTBLSISTEMA.FRCGETRECORD( SA_BOSYSTEM.FNUGETUSERCOMPANYID );

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.Initialize]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END INITIALIZE;
        
        





















        PROCEDURE HANDLEERROR
        (
            IRCPUNISHPRODUCT    IN  DAGC_PRODPRCA.STYGC_PRODPRCA,
            INUERRORCODE        IN  GE_MESSAGE.MESSAGE_ID%TYPE,
            ISBERRORMSG         IN  GE_MESSAGE.DESCRIPTION%TYPE
        )
        IS
            
            RCPUNISHPROD    DAGC_PRODPRCA.STYGC_PRODPRCA;
            
            PRAGMA AUTONOMOUS_TRANSACTION;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.HandleError' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.HandleError]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            RCPUNISHPROD := IRCPUNISHPRODUCT;
            
            
            RCPUNISHPROD.PRPCRECA := ISBERRORMSG;
            
            
            RCPUNISHPROD.PRPCFECA := SYSDATE;
            
            
            DAGC_PRODPRCA.UPDRECORD( RCPUNISHPROD );
            
            
            BOERROR := TRUE;

            PKGENERALSERVICES.COMMITTRANSACTION;
            
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.HandleError]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END HANDLEERROR;
        
        




















        PROCEDURE GETTOTALSUBSCRIPTIONS
        (
            IOTBREGISTERS   IN OUT NOCOPY DAGC_PRODPRCA.TYTBGC_PRODPRCA,
            IRCLASTPRODUCT  IN DAGC_PRODPRCA.STYGC_PRODPRCA
        )
        IS
            
            NUINDEX         NUMBER;
            
            
            TBNEWREGISTERS  DAGC_PRODPRCA.TYTBGC_PRODPRCA;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.GetTotalSubscriptions' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.GetTotalSubscriptions]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            NUINDEX := IOTBREGISTERS.FIRST;
            
            LOOP
                
                EXIT WHEN NUINDEX IS NULL;
                
                
                IF IOTBREGISTERS( NUINDEX ).PRPCSUSC = IRCLASTPRODUCT.PRPCSUSC THEN
                    
                    IOTBREGISTERS.DELETE( NUINDEX );
                END IF;
                
                
                NUINDEX := IOTBREGISTERS.NEXT( NUINDEX );
            END LOOP;
            
            
            GC_BCPRODPRCA.GETSUBSCRIPTIONTOPROCESS
            (
                INUPROJECT,
                IRCLASTPRODUCT.PRPCSUSC,
                TBNEWREGISTERS
            );
            
            
            NUINDEX := TBNEWREGISTERS.FIRST;
            
            
            LOOP
                
                EXIT WHEN NUINDEX IS NULL;

                
                IOTBREGISTERS( IOTBREGISTERS.COUNT + 1 ) := TBNEWREGISTERS( NUINDEX );

                
                NUINDEX := TBNEWREGISTERS.NEXT( NUINDEX );
            END LOOP;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.GetTotalSubscriptions]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END GETTOTALSUBSCRIPTIONS;
        
        






















        PROCEDURE GETSUBSCRIPTIONSTOPROCESS
        (
            INUPROJECTCODE      IN  GC_PRODPRCA.PRPCPRCA%TYPE,
            INUPIVOT            IN  GC_PRODPRCA.PRPCSUSC%TYPE,
            INUTHREADS          IN  NUMBER,
            INUCURRTHREAD       IN  NUMBER,
            OTBSUBSCRIPTIONS    OUT NOCOPY DAGC_PRODPRCA.TYTBGC_PRODPRCA
        )
        IS
            
            TBREGISTERS     DAGC_PRODPRCA.TYTBGC_PRODPRCA;
            
            
            RCLASTPRODUCT   DAGC_PRODPRCA.STYGC_PRODPRCA;
            

        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.GetSubscriptionsToProcess' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.GetSubscriptionsToProcess]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            GC_BCPRODPRCA.GETPRODUCTSBYSUBSCRIPTION
            (
                INUPROJECTCODE,
                INUPIVOT,
                INUTHREADS,
                INUCURRTHREAD,
                TBREGISTERS
            );
            
            
            IF TBREGISTERS.COUNT > 0 THEN
                
                RCLASTPRODUCT := TBREGISTERS( TBREGISTERS.LAST );
                
                
                GETTOTALSUBSCRIPTIONS( TBREGISTERS, RCLASTPRODUCT );

            END IF;
            
            
            OTBSUBSCRIPTIONS := TBREGISTERS;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.GetSubscriptionsToProcess]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END GETSUBSCRIPTIONSTOPROCESS;
        
        





















        PROCEDURE SETERROR
        (
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            ISBATTRIBUTE    IN  VARCHAR2,
            INUPOLITIC      IN  GC_PRODPRCA.PRPCPOCA%TYPE
        )
        IS
            
            CNUWRONG_POLITIC    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901099;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.SetError' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.SetError]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            ERRORS.SETERROR
            (
                CNUWRONG_POLITIC,
                INUPRODUCT || '|' ||
                ISBATTRIBUTE || '|' ||
                INUPOLITIC
            );

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.SetError]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

            
            RAISE EX.CONTROLLED_ERROR;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END SETERROR;
        
        























        PROCEDURE VALPORTFOLIOCHANGES
        (
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE
        )
        IS
            
            CNUNO_BILL_CHARGES  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901226;
            
            
            CNUCLAIM_ACCOUNT    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 114903;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.ValPortfolioChanges' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.ValPortfolioChanges]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            IF PKCHARGEMGR.FBLEXISTCHARGBILLNULLSERVICE( INUPRODUCT ) THEN
                ERRORS.SETERROR( CNUNO_BILL_CHARGES, INUPRODUCT );
                PKERRORS.POP;
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            IF (PKBCCUENCOBR.FNUCLAIMVALUEBYPROD( INUPRODUCT ) <> 0) THEN
                ERRORS.SETERROR( CNUCLAIM_ACCOUNT, INUPRODUCT );
                PKERRORS.POP;
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.ValPortfolioChanges]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;
        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END VALPORTFOLIOCHANGES;
        
        




















        PROCEDURE VALWRITEOFFPOLICIES
        (
            IRCPUNISHPRODUCT    IN DAGC_PRODPRCA.STYGC_PRODPRCA
        )
        IS
            
            RCPOLICACA          DAGC_POLICACA.STYGC_POLICACA;
            
            
            RCTODATEPRODUCT     DAGC_PRODPRCA.STYGC_PRODPRCA;
            
            
            CNUNO_DEBT_ACC  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901100;

        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.ValWriteOffPolicies' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.ValWriteOffPolicies]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            IF IRCPUNISHPRODUCT.PRPCPOCA IS NOT NULL THEN

                
                GC_BOGENACCINFWRITEOFF.GETACCINFBYPRODUCT( IRCPUNISHPRODUCT.PRPCNUSE, RCTODATEPRODUCT );
                
                
                IF RCTODATEPRODUCT.PRPCNUSE IS NULL THEN
                    
                    ERRORS.SETERROR( CNUNO_DEBT_ACC, IRCPUNISHPRODUCT.PRPCNUSE );
                    PKERRORS.POP;
                    RAISE EX.CONTROLLED_ERROR;
                END IF;
            
                
                IF NOT TBPOLITICS.EXISTS( IRCPUNISHPRODUCT.PRPCPOCA ) THEN
                    
                    TBPOLITICS( IRCPUNISHPRODUCT.PRPCPOCA ) := DAGC_POLICACA.FRCGETRECORD( IRCPUNISHPRODUCT.PRPCPOCA );
                END IF;

                
                RCPOLICACA := TBPOLITICS( IRCPUNISHPRODUCT.PRPCPOCA );

                
                IF RCPOLICACA.POCCSERV <> RCTODATEPRODUCT.PRPCSERV THEN
                    
                    SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Tipo de producto', IRCPUNISHPRODUCT.PRPCPOCA );
                END IF;

                
                IF RCPOLICACA.POCCEDAD IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCEDAD > RCTODATEPRODUCT.PRPCEDDE THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Edad de la deuda', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCNUCU IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCNUCU > RCTODATEPRODUCT.PRPCNUCU THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'N�mero de Cuentas Pendientes', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCNUFI IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCNUFI > RCTODATEPRODUCT.PRPCNUFI THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'N�mero de diferidos', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCSAPE IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCSAPE > ( RCTODATEPRODUCT.PRPCSPNF + NVL( RCTODATEPRODUCT.PRPCSPFI, 0 ) ) THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Saldo pendiente', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCTICL IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCTICL <> RCTODATEPRODUCT.PRPCTICL THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Tipo de cliente', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCSEOP IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCSEOP <> RCTODATEPRODUCT.PRPCSEOP THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Sector operativo', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCCATE IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCCATE <> RCTODATEPRODUCT.PRPCCATE THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Categor�a', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCSUCA IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCSUCA <> RCTODATEPRODUCT.PRPCSUCA THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Subcategor�a', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCUBG1 IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCUBG1 <> RCTODATEPRODUCT.PRPCUBG1 THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Ubicaci�n geogr�fica 1', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCUBG2 IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCUBG2 <> RCTODATEPRODUCT.PRPCUBG2 THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Ubicaci�n geogr�fica 2', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCUBG3 IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCUBG3 <> RCTODATEPRODUCT.PRPCUBG3 THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Ubicaci�n geogr�fica 3', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCUBG4 IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCUBG4 <> RCTODATEPRODUCT.PRPCUBG4 THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Ubicaci�n geogr�fica 4', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;

                
                IF RCPOLICACA.POCCUBG5 IS NOT NULL THEN
                    
                    IF RCPOLICACA.POCCUBG5 <> RCTODATEPRODUCT.PRPCUBG5 THEN
                        
                        SETERROR( RCTODATEPRODUCT.PRPCNUSE, 'Ubicaci�n geogr�fica 5', IRCPUNISHPRODUCT.PRPCPOCA );
                    END IF;
                END IF;
            END IF;
            
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.ValWriteOffPolicies]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END VALWRITEOFFPOLICIES;
        
        
































        PROCEDURE TRANSFERDEFTOCURRDEBT
        (
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            ONUERRORCODE    OUT GE_MESSAGE.MESSAGE_ID%TYPE,
            OSBERRORMESSAGE OUT GE_MESSAGE.DESCRIPTION%TYPE
        )
        IS
            
            NUPENDINGBAL    DIFERIDO.DIFESAPE%TYPE := 0;
            
            
            NUTOTALDEBT     DIFERIDO.DIFESAPE%TYPE := 0;
            
            
            NUACCSTATUS     FACTURA.FACTCODI%TYPE;
            
            
            NUACCOUNT       CUENCOBR.CUCOCODI%TYPE;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.TransferDefToCurrDebt' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.TransferDefToCurrDebt]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            PKERRORS.GETERRORVAR( ONUERRORCODE, OSBERRORMESSAGE, PKCONSTANTE.INITIALIZE );
            
            
            PKBILLINGNOTEMGR.CLEARNOTETYPE;
            
            
            NUPENDINGBAL := PKDEFERREDMGR.FNUGETDEFERREDBALSERVICE( INUPRODUCT );
            
            
            
            
            
            NUTOTALDEBT := NUPENDINGBAL;
            
            
            IF NUTOTALDEBT <> 0 THEN
                
                PKTRANSDEFTOCURRDEBT.TRANSFERDEBT
                (
            		INUPRODUCT,
            		PKCONSTANTE.NULLNUM,
            		NUTOTALDEBT,
            		PKERRORS.FSBGETAPPLICATION,
            		NUACCSTATUS,
            		NUACCOUNT,
                    ONUERRORCODE,
                    OSBERRORMESSAGE,
            		FALSE,    
                    FALSE,   
                    FALSE    
                );

            END IF;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.TransferDefToCurrDebt]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END TRANSFERDEFTOCURRDEBT;
        
        
































        PROCEDURE GETDISTBALANCE
        (
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            ITBCARGTERM     IN  PKBCCHARGES.TYCARGTERM,
            ITBCARGNUSE     IN  PKTBLCARGOS.TYCARGNUSE,
            ITBCARGVALO     IN  PKTBLCARGOS.TYCARGVALO,
            ITBCARGVABL     IN  PKTBLCARGOS.TYCARGVABL,
            ITBCARGSIGN     IN  PKTBLCARGOS.TYCARGSIGN,
            ITBCARGFECR     IN  PKTBLCARGOS.TYCARGFECR,
            ITBCARGUNID     IN  PKTBLCARGOS.TYCARGUNID,
            ITBCARGDOSO     IN  PKTBLCARGOS.TYCARGDOSO,
            ITBCARGCODO     IN  PKTBLCARGOS.TYCARGCODO,
            OTBKEYS         OUT NOCOPY PKCONCEPTVALUESMGR.TYSTRING,
            OTBBALANCE      OUT NOCOPY PKCONCEPTVALUESMGR.TYNUMBER,
            OTBBASEBALANCE  OUT NOCOPY PKCONCEPTVALUESMGR.TYNUMBER
        )
        IS
            
            TBDISTCHARGES   PKCONCEPTVALUESMGR.TYTBCARGOSDIST;
            
            
            NUINDEX         NUMBER := 0;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.GetDistBalance' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.GetDistBalance]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            OTBKEYS.DELETE;
            OTBBALANCE.DELETE;
            OTBBASEBALANCE.DELETE;

            
            IF ITBCARGTERM.COUNT > 0 THEN
                
                NUINDEX := TBDISTCHARGES.COUNT + 1;
                
                FOR NUIND IN ITBCARGTERM.FIRST .. ITBCARGTERM.LAST LOOP
                    TBDISTCHARGES( NUINDEX ).CARGTERM:= ITBCARGTERM( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGSIGN:= ITBCARGSIGN( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGVALO:= ITBCARGVALO( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGVABL:= ITBCARGVABL( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGFECR:= ITBCARGFECR( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGUNID:= ITBCARGUNID( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGDOSO:= ITBCARGDOSO( NUIND );
                    TBDISTCHARGES( NUINDEX ).CARGCODO:= ITBCARGCODO( NUIND );
                    
                    
                    IF ITBCARGSIGN( NUIND ) IN ( PKBILLCONST.APLSALDFAV, PKBILLCONST.PAGO ) THEN
                        TBDISTCHARGES( NUINDEX ).CARGFLFA := 'S';
                    ELSE
                        TBDISTCHARGES( NUINDEX ).CARGFLFA := 'N';
                    END IF;

                    
                    NUINDEX := NUINDEX + 1;
                END LOOP;
                
                
            	PKCONCEPTVALUESMGR.GETBALANCEBYCONC
                (
                    INUPRODUCT,
                    TBDISTCHARGES,
                    OTBKEYS,
                    OTBBALANCE,
                    OTBBASEBALANCE,
                    1,
                    0,
                    FALSE
                );
            END IF;
            

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.GetDistBalance]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END GETDISTBALANCE;
        
        






















        PROCEDURE CREATEBILLINGNOTE
        (
            INUPRODUCT  IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            INUPROJECT  IN  GC_PRODPRCA.PRPCPRCA%TYPE,
            ISBBILL     IN  VARCHAR2,
            INUACCOUNT  IN  CUENCOBR.CUCOCODI%TYPE
        )
        IS
            
            NUNOTENUMBER    NOTAS.NOTANUME%TYPE;
            
            SBNOTEDOC       NOTAS.NOTADOSO%TYPE;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.CreateBillingNote' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.CreateBillingNote]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            PKBILLINGNOTEMGR.CREATEBILLINGNOTE
            (
                INUPRODUCT,
                INUACCOUNT,
                PKBILLINGNOTEMGR.CNUTD_NOTA_CREDITO,
                SYSDATE,
                GC_BOCASTIGOCARTERA.CSBNOTEOBSE,
                PKBILLCONST.CSBTOKEN_NOTA_CREDITO,
                NUNOTENUMBER,
                GC_BOCASTIGOCARTERA.CSBPUNISH || INUPROJECT
            );
            
            
            PKBILLINGNOTEMGR.GETDOCUMSOP( SBNOTEDOC );

            
            GC_BOCASTIGOCARTERA.TBBILLNOTES( ISBBILL ).SBNOTADOSO := SBNOTEDOC;
            GC_BOCASTIGOCARTERA.TBBILLNOTES( ISBBILL ).NUNOTANUME := NUNOTENUMBER;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.CreateBillingNote]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END CREATEBILLINGNOTE;
        
        



























        PROCEDURE CREATENOTEDETAIL
        (
            INUNOTE         IN  NOTAS.NOTANUME%TYPE,
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            INUSUBSCRIPTION IN  GC_PRODPRCA.PRPCSUSC%TYPE,
            INUACCOUNT      IN  CUENCOBR.CUCOCODI%TYPE,
            INUCONCEPT      IN  CONCEPTO.CONCCODI%TYPE,
            INUCHARGECAUSE  IN  CARGOS.CARGCACA%TYPE,
            INUVALUE        IN  CARGOS.CARGVALO%TYPE,
            INUBASEVALUE    IN  CARGOS.CARGVABL%TYPE,
            ISBSUPPDOC      IN  CARGOS.CARGDOSO%TYPE
        )
        IS
            
            SBCANCELSIGN    CARGOS.CARGSIGN%TYPE;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.CreateNoteDetail' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.CreateNoteDetail]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            SBCANCELSIGN := PKCHARGEMGR.FSBGETCANCELSIGN ( INUVALUE );

            
            FA_BOBILLINGNOTES.DETAILREGISTER
            (
                INUNOTE,
                INUPRODUCT,
                INUSUBSCRIPTION,
                INUACCOUNT,
                INUCONCEPT,
                INUCHARGECAUSE,
                ABS( INUVALUE ),
                ABS( INUBASEVALUE ),
                ISBSUPPDOC,
                SBCANCELSIGN,
                PKCONSTANTE.NO,             
                NULL,                       
                PKCONSTANTE.NO              
            );

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.CreateNoteDetail]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END CREATENOTEDETAIL;
        
        
























        PROCEDURE PUNISHACCOUNT
        (
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            INUSUBSCRIPTION IN  GC_PRODPRCA.PRPCSUSC%TYPE,
            INUPROJECT      IN  GC_PRODPRCA.PRPCPRCA%TYPE,
            INUACCOUNT      IN  CUENCOBR.CUCOCODI%TYPE,
            INUBILL         IN  FACTURA.FACTCODI%TYPE,
            INUCAUSE        IN  CARGOS.CARGCACA%TYPE,
            ONUPUNISHVALUE  OUT GC_PRODPRCA.PRPCSACA%TYPE
        )
        IS
            
            TBCARGTERM      PKBCCHARGES.TYCARGTERM;
            TBCARGNUSE      PKTBLCARGOS.TYCARGNUSE;
            TBCARGVALO      PKTBLCARGOS.TYCARGVALO;
            TBCARGVABL      PKTBLCARGOS.TYCARGVABL;
            TBCARGSIGN      PKTBLCARGOS.TYCARGSIGN;
            TBCARGFECR      PKTBLCARGOS.TYCARGFECR;
            TBCARGUNID      PKTBLCARGOS.TYCARGUNID;
            TBCARGDOSO      PKTBLCARGOS.TYCARGDOSO;
            TBCARGCODO      PKTBLCARGOS.TYCARGCODO;
            
            TBKEYS          PKCONCEPTVALUESMGR.TYSTRING;
            TBBALANCE       PKCONCEPTVALUESMGR.TYNUMBER;
            TBBASEBALANCE   PKCONCEPTVALUESMGR.TYNUMBER;
            
            RCDATA          PKCONCEPTVALUESMGR.RTYDATAKEY;
            
            SBINDEX         VARCHAR2(100);
            
            NUPUNVALUE      GC_PRODPRCA.PRPCSACA%TYPE := 0;
            
            
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.PunishAccount' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.PunishAccount]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            PKBCCHARGES.GETDISTACCOUNTCHARGES
            (
                INUACCOUNT,
                TBCARGTERM,
                TBCARGNUSE,
                TBCARGVALO,
                TBCARGVABL,
                TBCARGSIGN,
                TBCARGFECR,
                TBCARGUNID,
                TBCARGDOSO,
                TBCARGCODO
            );
            
            
            GETDISTBALANCE
            (
                INUPRODUCT,
                TBCARGTERM,
                TBCARGNUSE,
                TBCARGVALO,
                TBCARGVABL,
                TBCARGSIGN,
                TBCARGFECR,
                TBCARGUNID,
                TBCARGDOSO,
                TBCARGCODO,
                TBKEYS,
                TBBALANCE,
                TBBASEBALANCE
            );

            
            SBINDEX :=  TBKEYS.FIRST;
            
            LOOP
                
                EXIT WHEN SBINDEX IS NULL;
                
                
                RCDATA := NULL;

                
                PKCONCEPTVALUESMGR.DECODEKEY
                (
                    TBKEYS( SBINDEX ),
                    RCDATA,
                    1,
                    0
                );
                
                
                
                IF NOT GC_BOCASTIGOCARTERA.TBBILLNOTES.EXISTS( TO_CHAR( INUBILL ) ) THEN
                    
                    CREATEBILLINGNOTE( INUPRODUCT, INUPROJECT, TO_CHAR( INUBILL ), INUACCOUNT );
                END IF;
                
                
                CREATENOTEDETAIL
                (
                    GC_BOCASTIGOCARTERA.TBBILLNOTES( TO_CHAR( INUBILL ) ).NUNOTANUME,
                    INUPRODUCT,
                    INUSUBSCRIPTION,
                    INUACCOUNT,
                    RCDATA.CARGCONC,
                    INUCAUSE,
                    TBBALANCE( SBINDEX ),
                    TBBASEBALANCE( SBINDEX ),
                    GC_BOCASTIGOCARTERA.TBBILLNOTES( TO_CHAR( INUBILL ) ).SBNOTADOSO
                );
                
                
                NUPUNVALUE := NUPUNVALUE + TBBALANCE( SBINDEX );

                
                SBINDEX := TBKEYS.NEXT( SBINDEX );
            END LOOP;
            
            
            ONUPUNISHVALUE := NUPUNVALUE;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.PunishAccount]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END PUNISHACCOUNT;
        
        























        PROCEDURE PROCESSACCOUNTS
        (
            INUPRODUCT      IN  GC_PRODPRCA.PRPCNUSE%TYPE,
            INUSUBSCRIPTION IN  GC_PRODPRCA.PRPCSUSC%TYPE,
            INUPROJECT      IN  GC_PRODPRCA.PRPCPRCA%TYPE,
            INUCAUSE        IN  CARGOS.CARGCACA%TYPE,
            ONUPUNISHVALUE  OUT GC_PRODPRCA.PRPCSACA%TYPE
        )
        IS
            
            TBACCOUNTS      PKBCCUENCOBR.TYTBACCOUNTS;
            
            CNUNO_DEBT_ACC  CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901100;
            
            NUPUNISHVAL     GC_PRODPRCA.PRPCSACA%TYPE := 0;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.ProcessAccounts' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.ProcessAccounts]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            PKBILLINGNOTEMGR.SETCASTIGO;
            
            
            ONUPUNISHVALUE := 0;

            
            GC_BCCASTIGOCARTERA.GETACCOUNTS( INUPRODUCT, TBACCOUNTS );

            
            IF TBACCOUNTS.COUNT = 0 THEN
                ERRORS.SETERROR( CNUNO_DEBT_ACC, INUPRODUCT );
                PKERRORS.POP;
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            PKACCOUNTMGR.APPLYPOSITIVEBALSERV ( INUPRODUCT, TBACCOUNTS( TBACCOUNTS.FIRST ).CUCOCODI );
            
            
            FOR NUIND IN TBACCOUNTS.FIRST .. TBACCOUNTS.LAST LOOP
                
                NUPUNISHVAL := 0;
                
                PUNISHACCOUNT
                (
                    INUPRODUCT,
                    INUSUBSCRIPTION,
                    INUPROJECT,
                    TBACCOUNTS( NUIND ).CUCOCODI,
                    TBACCOUNTS( NUIND ).CUCOFACT,
                    INUCAUSE,
                    NUPUNISHVAL
                );
                
                ONUPUNISHVALUE := ONUPUNISHVALUE + NUPUNISHVAL;
            
            END LOOP;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.ProcessAccounts]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END PROCESSACCOUNTS;
        
        


















        PROCEDURE GETCHARGECAUSES
        (
            INUPUNISHTYPE   IN  GC_PRODPRCA.PRPCTICA%TYPE
        )
        IS
            
            
            
            
            
            RCTIPOCAST  TIPOCAST%ROWTYPE;
            
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.GetChargeCauses' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.GetChargeCauses]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            IF NOT GC_BOCASTIGOCARTERA.TBCHARGECAUSES.EXISTS( INUPUNISHTYPE ) THEN
                RCTIPOCAST := PKTBLTIPOCAST.FRCGETRECORD(INUPUNISHTYPE);
                
                GC_BOCASTIGOCARTERA.TBCHARGECAUSES( INUPUNISHTYPE ).NUPUNISHCAUSE := RCTIPOCAST.TICACACA;
                
                GC_BOCASTIGOCARTERA.TBCHARGECAUSES( INUPUNISHTYPE ).NUREACTCAUSE := RCTIPOCAST.TICACARE;
            END IF;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.GetChargeCauses]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END GETCHARGECAUSES;
        
        



























        PROCEDURE PUNISHPRODUCT
        (
            IRCPUNISHPRODUCT    IN DAGC_PRODPRCA.STYGC_PRODPRCA,
            INUPROJECT          IN  GC_PRODPRCA.PRPCPRCA%TYPE
        )
        IS
            
            NUERRORCODE     GE_MESSAGE.MESSAGE_ID%TYPE;

            
            SBERRORMSG      GE_MESSAGE.DESCRIPTION%TYPE;
            
            
            NUPUNISHVALUE   GC_PRODPRCA.PRPCSACA%TYPE := 0;
            
            
            RCPUNISHPRODUCT DAGC_PRODPRCA.STYGC_PRODPRCA := IRCPUNISHPRODUCT;
            
            
            CSBPUNISHPROD   CONSTANT SERVSUSC.SESUESFN%TYPE := 'C';
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.PunishProduct' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.PunishProduct]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            VALPORTFOLIOCHANGES( IRCPUNISHPRODUCT.PRPCNUSE );

            
            VALWRITEOFFPOLICIES( IRCPUNISHPRODUCT );
            
            
            TRANSFERDEFTOCURRDEBT( IRCPUNISHPRODUCT.PRPCNUSE, NUERRORCODE, SBERRORMSG );
            
            
            IF NUERRORCODE <> PKCONSTANTE.EXITO THEN
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            
            GETCHARGECAUSES( IRCPUNISHPRODUCT.PRPCTICA );
            
            
            PKTBLSERVSUSC.UPDSESUESFN
            (
                RCPUNISHPRODUCT.PRPCNUSE,
                CSBPUNISHPROD
            );
            
            
            PROCESSACCOUNTS
            (
                IRCPUNISHPRODUCT.PRPCNUSE,
                IRCPUNISHPRODUCT.PRPCSUSC,
                INUPROJECT,
                GC_BOCASTIGOCARTERA.TBCHARGECAUSES( IRCPUNISHPRODUCT.PRPCTICA ).NUPUNISHCAUSE,
                NUPUNISHVALUE
            );

            
            RCPUNISHPRODUCT.PRPCSACA := NUPUNISHVALUE;
            RCPUNISHPRODUCT.PRPCFECA := SYSDATE;
            
            
            TBUPDATEPRODUCTS( TBUPDATEPRODUCTS.COUNT + 1 ) := RCPUNISHPRODUCT;
            
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.PunishProduct]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
                PKERRORS.POP;
                
                IF SBERRORMSG IS NULL THEN
                    PKERRORS.GETERRORVAR( NUERRORCODE, SBERRORMSG );
                END IF;
                HANDLEERROR( IRCPUNISHPRODUCT, NUERRORCODE, SBERRORMSG );
            	PKERRORS.POP;
            	
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
            	PKERRORS.POP;
            	PKERRORS.GETERRORVAR( NUERRORCODE, SBERRORMSG );
            	HANDLEERROR( IRCPUNISHPRODUCT, NUERRORCODE, SBERRORMSG );
            	
            WHEN OTHERS THEN
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END PUNISHPRODUCT;
        
        





















        PROCEDURE UPDATENONPROCPRODUCTS
        (
            INUERRORCODE        IN  GE_MESSAGE.MESSAGE_ID%TYPE,
            ISBERRORMSG         IN  GE_MESSAGE.DESCRIPTION%TYPE
        )
        IS
            
            RCPUNISHPRODUCT DAGC_PRODPRCA.STYGC_PRODPRCA;
            
            NUINDEX         NUMBER;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.UpdateNonProcProducts' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.UpdateNonProcProducts]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            PKGENERALSERVICES.ROLLBACKTRANSACTION;
            
            
            NUINDEX := TBUPDATEPRODUCTS.FIRST;
            LOOP
                
                EXIT WHEN NUINDEX IS NULL;
                
                
                RCPUNISHPRODUCT := TBUPDATEPRODUCTS( NUINDEX );
                
                RCPUNISHPRODUCT.PRPCSACA := 0;
                RCPUNISHPRODUCT.PRPCFECA := SYSDATE;
                RCPUNISHPRODUCT.PRPCRECA := ISBERRORMSG;
                
                
                DAGC_PRODPRCA.UPDRECORD( RCPUNISHPRODUCT );

                
                NUINDEX := TBUPDATEPRODUCTS.NEXT( NUINDEX );
            END LOOP;

            
            GC_BOCASTIGOCARTERA.TBBILLNOTES.DELETE;
            
            
            TBUPDATEPRODUCTS.DELETE;
            
            
            BOERROR := TRUE;
            
            
            PKGENERALSERVICES.COMMITTRANSACTION;
            
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.UpdateNonProcProducts]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END UPDATENONPROCPRODUCTS;
        
        



















        PROCEDURE ASSIGNAUTHNUMBER
        IS
            
            SBINDEX     VARCHAR2(20);
            
            
            NUERRORCODE     GE_MESSAGE.MESSAGE_ID%TYPE;

            
            SBERRORMSG      GE_MESSAGE.DESCRIPTION%TYPE;
        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.AssignAuthNumber' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.AssignAuthNumber]', GC_BOCASTIGOCARTERA.CNUTRAZA );

            
            IF RCSISTEMA.SISTFLNF = PKCONSTANTE.SI THEN
                
                SBINDEX := GC_BOCASTIGOCARTERA.TBBILLNOTES.FIRST;
                
                
                LOOP
                    
                    EXIT WHEN SBINDEX IS NULL;
                    
                    
                    PKBILLINGNOTEMGR.PROCESONUMERACIONFISCAL( GC_BOCASTIGOCARTERA.TBBILLNOTES( SBINDEX ).NUNOTANUME );
                    
                    
                    SBINDEX := GC_BOCASTIGOCARTERA.TBBILLNOTES.NEXT( SBINDEX );
                END LOOP;
            END IF;
            
            
            GC_BOCASTIGOCARTERA.TBBILLNOTES.DELETE;

            
            PKGENERALSERVICES.COMMITTRANSACTION;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.AssignAuthNumber]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
                PKERRORS.GETERRORVAR( NUERRORCODE, SBERRORMSG );
                UPDATENONPROCPRODUCTS( NUERRORCODE, SBERRORMSG );
            	PKERRORS.POP;
            	
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKERRORS.GETERRORVAR( NUERRORCODE, SBERRORMSG );
                UPDATENONPROCPRODUCTS( NUERRORCODE, SBERRORMSG );
            	PKERRORS.POP;
            	
            WHEN OTHERS THEN
                
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END ASSIGNAUTHNUMBER;
        
        


















        PROCEDURE UPDATEPRODBALANCES
        IS
            
            NUINDEX         NUMBER;
            
            
            NUTOTAL         NUMBER := 0;
            
            
            RCREGISTER      DAGC_PROYCAST.STYGC_PROYCAST;

        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.UpdateProdBalances' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.UpdateProdBalances]', GC_BOCASTIGOCARTERA.CNUTRAZA );


            
            NUINDEX := TBUPDATEPRODUCTS.FIRST;
            
            
            LOOP
                
                EXIT WHEN NUINDEX IS NULL;

                
                DAGC_PRODPRCA.UPDRECORD( TBUPDATEPRODUCTS( NUINDEX ) );
                
                
                NUTOTAL := NUTOTAL + TBUPDATEPRODUCTS( NUINDEX ).PRPCSACA;
                
                
                NUINDEX := TBUPDATEPRODUCTS.NEXT( NUINDEX );
                
            END LOOP;
            
            
            GC_BCPROYCAST.LOCKPROJECT( RCPUNISHPROJECT.PRCACONS, RCREGISTER );
            
            
            RCREGISTER.PRCAPRCA := NVL(RCREGISTER.PRCAPRCA, 0) + TBUPDATEPRODUCTS.COUNT;

            
            RCREGISTER.PRCASACA := NVL(RCREGISTER.PRCASACA, 0)  + NUTOTAL;

            
            GC_BCPROYCAST.UPDATEPROJECT( RCREGISTER );
            
            
            TBUPDATEPRODUCTS.DELETE;
            
            
            PKGENERALSERVICES.COMMITTRANSACTION;
            
            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.UpdateProdBalances]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
                PKGENERALSERVICES.ROLLBACKTRANSACTION;
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END UPDATEPRODBALANCES;
        
        

























        PROCEDURE PROCESSSUBSCRIPTIONS
        IS
            
            NUSUBSPIVOT         GC_PRODPRCA.PRPCSUSC%TYPE := 0;

            
            TBSUSBCRIPTIONS     DAGC_PRODPRCA.TYTBGC_PRODPRCA;
            
            
            NUINDEX             NUMBER;
            
            
            NUOLDSUBSCRIPTION   SUSCRIPC.SUSCCODI%TYPE := NULL;
            
            
            NUPORCENTAJE        NUMBER;

        BEGIN
            PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions.ProcessSubscriptions' );
            UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions.ProcessSubscriptions]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            
            
            LOOP
            
                
                TBSUSBCRIPTIONS.DELETE;
                GC_BOCASTIGOCARTERA.TBBILLNOTES.DELETE;

                
                GETSUBSCRIPTIONSTOPROCESS
                (
                    INUPROJECT,
                    NUSUBSPIVOT,
                    INUTOTALTHREADS,
                    INUTHREAD,
                    TBSUSBCRIPTIONS
                );

                
                EXIT WHEN TBSUSBCRIPTIONS.FIRST IS NULL;

                
                NUINDEX := TBSUSBCRIPTIONS.FIRST;
                
                
                NUOLDSUBSCRIPTION := NULL;
                
                
                LOOP
                    
                    EXIT WHEN NUINDEX IS NULL;
                    
                    
                    IF NUOLDSUBSCRIPTION IS NULL THEN
                        NUOLDSUBSCRIPTION := TBSUSBCRIPTIONS( NUINDEX ).PRPCSUSC;
                    END IF;
                    
                    
                    IF NUOLDSUBSCRIPTION <> TBSUSBCRIPTIONS( NUINDEX ).PRPCSUSC THEN
                        
                        NUOLDSUBSCRIPTION := TBSUSBCRIPTIONS( NUINDEX ).PRPCSUSC;

                        
                        ASSIGNAUTHNUMBER;

                        
                        UPDATEPRODBALANCES;
                    END IF;
                    
                    
                    PUNISHPRODUCT( TBSUSBCRIPTIONS( NUINDEX ), INUPROJECT );
                    
                    
                    IF NUINDEX = TBSUSBCRIPTIONS.LAST THEN
                        
                        NUOLDSUBSCRIPTION := TBSUSBCRIPTIONS( NUINDEX ).PRPCSUSC;

                        
                        ASSIGNAUTHNUMBER;

                        
                        UPDATEPRODBALANCES;
                    END IF;

                    
                    NUINDEX := TBSUSBCRIPTIONS.NEXT( NUINDEX );
                
                END LOOP;
                
                
                PKSTATUSEXEPROGRAMMGR.UPDATEPERCENTAGE
                (
                    ISBSTATUSPROG,
                    'Procesando...',
                    TBSUSBCRIPTIONS.COUNT,
                    NUPORCENTAJE
                );
                
                
                NUSUBSPIVOT := TBSUSBCRIPTIONS( TBSUSBCRIPTIONS.LAST ).PRPCSUSC;
            END LOOP;
            
            PKGENERALSERVICES.COMMITTRANSACTION;

            UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions.ProcessSubscriptions]', GC_BOCASTIGOCARTERA.CNUTRAZA );
            PKERRORS.POP;

        EXCEPTION
            WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
            	PKERRORS.POP;
            	RAISE LOGIN_DENIED;
            WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            	PKERRORS.POP;
            	RAISE PKCONSTANTE.EXERROR_LEVEL2;
            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
            	PKERRORS.POP;
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
        END PROCESSSUBSCRIPTIONS;
    BEGIN
        PKERRORS.PUSH( 'GC_BOCastigocartera.PunishSubscriptions' );
        UT_TRACE.TRACE( 'INICIO [GC_BOCastigocartera.PunishSubscriptions]', GC_BOCASTIGOCARTERA.CNUTRAZA );

        
        INITIALIZE;
        
        
        PROCESSSUBSCRIPTIONS;
        
        UT_TRACE.TRACE( 'FIN [GC_BOCastigocartera.PunishSubscriptions]', GC_BOCASTIGOCARTERA.CNUTRAZA );
        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
        	PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BOCASTIGOCARTERA.SBERRMSG );
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BOCASTIGOCARTERA.SBERRMSG );
    END PUNISHSUBSCRIPTIONS;

END GC_BOCASTIGOCARTERA;