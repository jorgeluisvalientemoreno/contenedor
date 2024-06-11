PACKAGE BODY CC_BOGrace_Peri_Defe
IS
    


































    
    
    
    
    
    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO205002';
    
    
    
    
    TYPE TYDIFECODI IS TABLE OF DIFERIDO.DIFECODI%TYPE INDEX BY VARCHAR2(15);
    
    
    
    
    
    
    
    CSBCLAIMGRACEPERIOD     CONSTANT VARCHAR2(100) := 'PERI_GRACIA_RECL_DIF';

    
    CNUNULL_ATTRIBUTE       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119562;
    
    CNUMINOR_SYSDATE        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901359;
    
    CNUENDDAT_MIN_INITDAT   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901360;
    
    CNUGRACE_DAYS           CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901364;
    
    CNUGRACE_PERI_INVAL     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901365;
    
    CNUMINOR_ENDDATE        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 7350;
    
    CSBGRACE_PERI_DEFE      CONSTANT VARCHAR(20) := 'CC_GRACE_PERI_DEFE';
    
    CSBFIRPG                CONSTANT VARCHAR2(7) := 'FIRPG';
    
    CSBCUSTOMER             CONSTANT VARCHAR2(10) := 'CUSTOMER';
    
    CNUERROR_FINAN          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 902134;
    

    
    
    
    
    
    
    
    
    
    
    
    
    
    
    

    
    
    

    























    FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
    
        RETURN CSBVERSION;
    
    END FSBVERSION;
    
    















    FUNCTION FSBFILLCLAIMPROGRAMS
    RETURN VARCHAR2
    IS
        
        SBPROGRAMS    VARCHAR2(2000);
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOGrace_Peri_Defe.fsbFillClaimPrograms', 10);
    
        SBPROGRAMS:=  '|'||GE_BCPROCESOS.FNUGETPROCESS(CC_BOCLAIMUTIL.CSBCHARGES_CLAIM_PROCESS_NAME)||
                      '|'||GE_BCPROCESOS.FNUGETPROCESS(CC_BOCLAIMUTIL.CSBMOTION_REVER_PROCESS_NAME) ||
                      '|'||GE_BCPROCESOS.FNUGETPROCESS(CC_BOCLAIMUTIL.CSBMOTION_APPEAL_PROCESS_NAME)||
                      '|'||GE_BCPROCESOS.FNUGETPROCESS(CC_BOCLAIMUTIL.CSBMOTION_COMPL_PROCESS_NAME) ||'|';
        UT_TRACE.TRACE('Programas Reclamaciones['||SBPROGRAMS||']', 11);
        UT_TRACE.TRACE('Fin: CC_BOGrace_Peri_Defe.fsbFillClaimPrograms', 10);
    
        RETURN SBPROGRAMS;
    
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FSBFILLCLAIMPROGRAMS;
    
    



















    FUNCTION FBOVALCANCELCHRGSCLAIM
    (
        INUDEFERREDID      IN    CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE,
        ITBCLAIMMOTIVES    IN    DAMO_MOTIVE.TYTBMOTIVE_ID
    )
    RETURN BOOLEAN
    IS
        
        TBCARGTRAM           PKTBLCARGTRAM.TYCATRCONS;
        
        SBSUPPORTDOCUMENT    VARCHAR2(2000);
        
        NUMOTIVEINDEX        NUMBER;
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOGrace_Peri_Defe.fboValCancelChrgsClaim', 6);

        


        IF (ITBCLAIMMOTIVES.COUNT > 0) THEN
        
            
            TBCARGTRAM.DELETE;

            
            SBSUPPORTDOCUMENT := '|'||PKBILLCONST.CSBTOKEN_DIFERIDO||INUDEFERREDID||
                                 '|'||PKBILLCONST.CSBTOKEN_INTERES_DIFERIDO||INUDEFERREDID||
                                 '|'||PKBILLCONST.CSBTOKEN_CUOTA_EXTRA||INUDEFERREDID||
                                 '|'||PKBILLCONST.CSBTOKEN_TRANS_DIFCOR||INUDEFERREDID||'|';
            UT_TRACE.TRACE('Documentos de Soporte Diferido['||SBSUPPORTDOCUMENT||']', 5);

            
            NUMOTIVEINDEX := ITBCLAIMMOTIVES.FIRST;
            WHILE (NUMOTIVEINDEX IS NOT NULL) LOOP
                

                PKBCCARGTRAM.GETCARGTRAMBYMOTIVE( ITBCLAIMMOTIVES(NUMOTIVEINDEX),
                                                  SBSUPPORTDOCUMENT,
                                                  TBCARGTRAM
                                                );

                IF (TBCARGTRAM.COUNT > 0) THEN
                    UT_TRACE.TRACE('FIN: CC_BOGrace_Peri_Defe.fboValCancelChrgsClaim [FALSE]', 5);
                    RETURN FALSE;
                END IF;

                NUMOTIVEINDEX := ITBCLAIMMOTIVES.NEXT(NUMOTIVEINDEX);
            END LOOP;
        END IF;
        
        


        UT_TRACE.TRACE('FIN: CC_BOGrace_Peri_Defe.fboValCancelChrgsClaim [TRUE]', 5);
        RETURN TRUE;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBOVALCANCELCHRGSCLAIM;

    




































    PROCEDURE REGCLAIMDEFGRCPERIOD
    (
        ITBCHARGES    IN    PKBCCARGTRAM.TYTBCARGTRAM
    )
    IS
    
    
    
        
        NUIDX                NUMBER;
        
        NUIDXDEF             NUMBER := 1;
        
        TBDEFGRACEPERIODS    DACC_GRACE_PERI_DEFE.TYTBCC_GRACE_PERI_DEFE;
        
        TBDEFERREDS          TYDIFECODI;
        
        NUDEFERREDID         CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE;
        
        SBPROGRAMS           VARCHAR2(2000);
        
        NUGRACEPERIDEFEID    CC_GRACE_PERI_DEFE.GRACE_PERI_DEFE_ID%TYPE;

    
    
    
        





























        FUNCTION FRCCREATEGRCPERIOD
        (
            INUDEFERRED    IN    CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE
        )
        RETURN DACC_GRACE_PERI_DEFE.STYCC_GRACE_PERI_DEFE
        IS
            
            RCDEFERREDGRCPERIOD         DACC_GRACE_PERI_DEFE.STYCC_GRACE_PERI_DEFE;
            
            RCPROGRAM                   PROCESOS%ROWTYPE;
            
        BEGIN
        
            UT_TRACE.TRACE('Inicio: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod.frcCreateGrcPeriod', 6);
            
            
            IF( PKERRORS.FSBGETAPPLICATION IS NULL ) THEN
                RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA ( CC_BOCLAIMUTIL.CSBCHARGES_CLAIM_PROCESS_NAME );
            ELSE
                RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA (PKERRORS.FSBGETAPPLICATION);
            END IF;

            
            RCDEFERREDGRCPERIOD.GRACE_PERI_DEFE_ID  := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE(CSBGRACE_PERI_DEFE,CSBSEQ_GRACE_PERI_DEFE) ;
            RCDEFERREDGRCPERIOD.GRACE_PERIOD_ID     := GE_BOPARAMETER.FNUVALORNUMERICO(CSBCLAIMGRACEPERIOD);
            RCDEFERREDGRCPERIOD.DEFERRED_ID         := INUDEFERRED;
            RCDEFERREDGRCPERIOD.INITIAL_DATE        := SYSDATE;
            RCDEFERREDGRCPERIOD.END_DATE            := UT_DATE.FDTMAXDATE;
            RCDEFERREDGRCPERIOD.PROGRAM             := RCPROGRAM.PROCCONS;
            RCDEFERREDGRCPERIOD.PERSON_ID           := GE_BOPERSONAL.FNUGETPERSONID;
            
            UT_TRACE.TRACE('Fin: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod.frcCreateGrcPeriod', 6);
            
            RETURN RCDEFERREDGRCPERIOD;
        
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
                UT_TRACE.TRACE('Error: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod.frcCreateGrcPeriod', 6);
            	RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                UT_TRACE.TRACE('Error: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod.frcCreateGrcPeriod', 6);
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END FRCCREATEGRCPERIOD;
        
    BEGIN
        UT_TRACE.TRACE('Inicio: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod', 5);
        
        

        SBPROGRAMS := FSBFILLCLAIMPROGRAMS;
        
        
        NUIDX := ITBCHARGES.FIRST;
        
        
        WHILE ( NUIDX IS NOT NULL ) LOOP

            
            IF (FBOISDEFERRED(ITBCHARGES(NUIDX).CATRDOSO)) THEN

                
                NUDEFERREDID := TO_NUMBER(SUBSTR( ITBCHARGES(NUIDX).CATRDOSO, 4 ));
                UT_TRACE.TRACE('Diferido['||NUDEFERREDID||']', 7);
                
                
                IF ( NOT TBDEFERREDS.EXISTS(NUDEFERREDID) ) THEN
                
                    
                    TBDEFERREDS (NUDEFERREDID) := NUDEFERREDID;

                    

                    NUGRACEPERIDEFEID := CC_BCGRACE_PERI_DEFE.FNUGETACTIVEGRAPER( NUDEFERREDID,
                                                                                  SBPROGRAMS
                                                                                );
                    UT_TRACE.TRACE('Identificador Periodo de Gracia por Diferido['||NUGRACEPERIDEFEID||']', 7);
                    
                    
                    IF (NUGRACEPERIDEFEID IS NULL) THEN
                        
                        TBDEFGRACEPERIODS(NUIDXDEF) := FRCCREATEGRCPERIOD(NUDEFERREDID);
                        
                        

                        PKTBLDIFERIDO.UPDDIFEENRE(NUDEFERREDID, CC_BOCONSTANTS.CSBSI);
                        UT_TRACE.TRACE('Actualiza flag de diferido en relamo a S. Diferido: '|| NUDEFERREDID, 1);

                        

                        NUIDXDEF := NUIDXDEF + 1;
                    END IF;
                END IF;
            END IF;
            
            NUIDX := ITBCHARGES.NEXT(NUIDX);
        END LOOP;
        
        

        IF ( TBDEFGRACEPERIODS.COUNT > 0 ) THEN
            
            DACC_GRACE_PERI_DEFE.INSRECORDS(TBDEFGRACEPERIODS);
        END IF;

        UT_TRACE.TRACE('Fin: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod', 5);
        
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('Error: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod', 5);
        	RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('Error: CC_BOGrace_Peri_Defe.RegClaimDefGrcPeriod', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGCLAIMDEFGRCPERIOD;
    
    
















































    PROCEDURE CANCELCHRGSCLAIMPRDS
    (
        ITBCHARGES    IN    PKBCCARGTRAM.TYTBCARGTRAM
    )
    IS
    
    
    
        
        NUIDX                  NUMBER;
        
        TBDEFERREDS            TYDIFECODI;
        
        NUDEFERREDID           CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE;
        
        SBPROGRAMS             VARCHAR2(2000);
        
        NUGRACEPERIDEFEID      CC_GRACE_PERI_DEFE.GRACE_PERI_DEFE_ID%TYPE;
        
        TBCLAIMMOTIVES         DAMO_MOTIVE.TYTBMOTIVE_ID;
        
        NUCLAIMMOTIVETYPE      MO_MOTIVE.MOTIVE_TYPE_ID%TYPE;
        
        NUSUBSCRIPTIONID       DIFERIDO.DIFESUSC%TYPE;
        
        NUTMPSUBSCRIPTIONID    DIFERIDO.DIFESUSC%TYPE;

    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOGrace_Peri_Defe.CancelChrgsClaimPrds', 5);
        
        

        SBPROGRAMS := FSBFILLCLAIMPROGRAMS;
        
        
        NUCLAIMMOTIVETYPE := PS_BOMOTIVETYPE.FNUMOTITYPEBYTAG(PS_BOMOTIVETYPE.CSBMOTY_RECLAMACIONES);

        
        NUIDX := ITBCHARGES.FIRST;

        
        WHILE ( NUIDX IS NOT NULL ) LOOP
        
            
            IF (FBOISDEFERRED (ITBCHARGES(NUIDX).CATRDOSO)) THEN
               
                
                NUDEFERREDID := TO_NUMBER(SUBSTR( ITBCHARGES(NUIDX).CATRDOSO, 4 ));
                UT_TRACE.TRACE('Diferido['||NUDEFERREDID||']', 7);

                
                IF ( NOT TBDEFERREDS.EXISTS (NUDEFERREDID)) THEN

                    
                    TBDEFERREDS (NUDEFERREDID) := NUDEFERREDID;
                    
                    

                    NUGRACEPERIDEFEID := CC_BCGRACE_PERI_DEFE.FNUGETACTIVEGRAPER( NUDEFERREDID,
                                                                                  SBPROGRAMS
                                                                                );
                    UT_TRACE.TRACE('Identificador Periodo de Gracia por Diferido['||NUGRACEPERIDEFEID||']', 7);

                    
                    IF (NUGRACEPERIDEFEID IS NOT NULL) THEN

                        
                        NUTMPSUBSCRIPTIONID := PKTBLDIFERIDO.FNUGETDIFESUSC(NUDEFERREDID);
                        UT_TRACE.TRACE('Contrato del Diferido['||NUTMPSUBSCRIPTIONID||']', 7);
                    
                        IF (NUSUBSCRIPTIONID IS NULL) OR
                           (NUSUBSCRIPTIONID != NUTMPSUBSCRIPTIONID) THEN

                            
                            NUSUBSCRIPTIONID := NUTMPSUBSCRIPTIONID;
                            
                            
                            TBCLAIMMOTIVES.DELETE;
                            
                            

                            CC_BCCLAIMUTIL.GETACTIVECLAIMMOTIVE( NUSUBSCRIPTIONID,
                                                                 ITBCHARGES(NUIDX).CATRMOTI,
                                                                 NUCLAIMMOTIVETYPE,
                                                                 TBCLAIMMOTIVES
                                                               );
                            
                        END IF;

                        

                        IF (FBOVALCANCELCHRGSCLAIM( NUDEFERREDID, TBCLAIMMOTIVES)) THEN
                            DACC_GRACE_PERI_DEFE.UPDEND_DATE( NUGRACEPERIDEFEID, SYSDATE);
                            
                            

                            PKTBLDIFERIDO.UPDDIFEENRE(NUDEFERREDID, CC_BOCONSTANTS.CSBNO);
                            UT_TRACE.TRACE('Actualiza flag de diferido en relamo a N. Diferido: '|| NUDEFERREDID, 1);
                            
                        END IF;
                    END IF;
                END IF;
            END IF;

            
            NUIDX := ITBCHARGES.NEXT(NUIDX);
        END LOOP;

        UT_TRACE.TRACE('Fin: CC_BOGrace_Peri_Defe.CancelChrgsClaimPrds', 5);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOGrace_Peri_Defe.CancelChrgsClaimPrds', 5);
        	RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOGrace_Peri_Defe.CancelChrgsClaimPrds', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CANCELCHRGSCLAIMPRDS;
    
    




























    FUNCTION FBOISDEFERRED
    (
        ISBSUPPORTDOCUMENT    IN    CARGOS.CARGDOSO%TYPE
    )
    RETURN BOOLEAN
    IS
    
    
    
        
        BOISDEFERRED        BOOLEAN := FALSE;
    
    BEGIN
    
        UT_TRACE.TRACE('Inicio: CC_BOGrace_Peri_Defe.fboIsDeferred', 6);

        
        IF (NOT BOISDEFERRED AND PKCHARGEMGR.FBOISDEFERREDBACKDOC(ISBSUPPORTDOCUMENT)) THEN
            BOISDEFERRED := TRUE;
        END IF;

        
        IF (NOT BOISDEFERRED AND PKCHARGEMGR.FBOISINTERESTDEFBACKDOC(ISBSUPPORTDOCUMENT)) THEN
            BOISDEFERRED := TRUE;
        END IF;

        
        IF (NOT BOISDEFERRED AND PKCHARGEMGR.FBOISDEFADTNLINTLMBACKDOC(ISBSUPPORTDOCUMENT)) THEN
            BOISDEFERRED := TRUE;
        END IF;

        
        IF (NOT BOISDEFERRED AND PKCHARGEMGR.FBOISTRANSDIFCORDOC(ISBSUPPORTDOCUMENT)) THEN
            BOISDEFERRED := TRUE;
        END IF;

        UT_TRACE.TRACE('Fin: CC_BOGrace_Peri_Defe.fboIsDeferred', 6);
        
        RETURN BOISDEFERRED;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR OR LOGIN_DENIED THEN
            UT_TRACE.TRACE('ex.CONTROLLED_ERROR: CC_BOGrace_Peri_Defe.fboIsDeferred', 6);
        	RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('others: CC_BOGrace_Peri_Defe.fboIsDeferred', 6);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FBOISDEFERRED;


    

















    FUNCTION FDTGETDEFENDGRAPERDATE
    (
        INUDEFERRED IN  CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE,
        ISBPROGRAM  IN  DIFERIDO.DIFEPROG%TYPE
    )
    RETURN CC_GRACE_PERI_DEFE.END_DATE%TYPE
    IS
        
        
        
        DTENDDATE   CC_GRACE_PERI_DEFE.END_DATE%TYPE;
        RCPROGRAM   PROCESOS%ROWTYPE;
    BEGIN

        UT_TRACE.TRACE( 'CC_BOGrace_Peri_Defe.fdtGetDefEndGraPerDate', 15 );

        
        RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA( ISBPROGRAM );

        
        DTENDDATE := CC_BCGRACE_PERI_DEFE.FDTGETDEFENDGRAPERDATE(
                                                            INUDEFERRED,
                                                            RCPROGRAM.PROCCONS );

        UT_TRACE.TRACE( 'Fin CC_BOGrace_Peri_Defe.fdtGetDefEndGraPerDate', 15 );
        RETURN DTENDDATE;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END FDTGETDEFENDGRAPERDATE;
    

    





















	PROCEDURE REGGRACEPERIODBYPROD
    (
        INUPRODUCTID       IN    PR_PRODUCT.PRODUCT_ID%TYPE,
        INUGRACEPERIOD     IN    CC_GRACE_PERI_DEFE.GRACE_PERIOD_ID%TYPE,
        IDTINITIALDATE     IN    CC_GRACE_PERI_DEFE.INITIAL_DATE%TYPE,
        IDTENDDATE         IN    CC_GRACE_PERI_DEFE.END_DATE%TYPE
    )
    IS
    
        

        NUDIFFERENCEDAYS    NUMBER;
        
        
        RCGRACEPERIOD       DACC_GRACE_PERIOD.STYCC_GRACE_PERIOD;
        
        
        TBDIFERIDOS         PKBCDIFERIDO.TYTBDIFERIDO;
        
        
        NUINDEXDIFERIDO     NUMBER;
        
        
        TBGRACEPERIDEFE     DACC_GRACE_PERI_DEFE.TYTBCC_GRACE_PERI_DEFE;
        
        
        NUINDEXGRACEPERI    NUMBER;
        
        
        RCGRACEPERIDEFE     DACC_GRACE_PERI_DEFE.STYCC_GRACE_PERI_DEFE;
        
        
        RCPROGRAM           PROCESOS%ROWTYPE;
        
        
        NUPERSONID          CC_GRACE_PERI_DEFE.PERSON_ID%TYPE;
    
        
        PROCEDURE VALIDATEDATA IS
        BEGIN

            
            IF (INUPRODUCTID IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador del Producto');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            DAPR_PRODUCT.ACCKEY(INUPRODUCTID);
            
            
            IF (INUGRACEPERIOD IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador del Periodo de Gracia');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            RCGRACEPERIOD := DACC_GRACE_PERIOD.FRCGETRECORD(INUGRACEPERIOD);
            
            
            IF (INUGRACEPERIOD = GE_BOPARAMETER.FNUVALORNUMERICO(CSBCLAIMGRACEPERIOD)) THEN
                ERRORS.SETERROR(CNUGRACE_PERI_INVAL,INUGRACEPERIOD);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            
            IF (IDTINITIALDATE IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Fecha Inicial Periodo de Gracia');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            
            IF (IDTENDDATE IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Fecha Final Periodo de Gracia');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            
            IF (TRUNC(IDTINITIALDATE) < TRUNC(SYSDATE)) THEN
                ERRORS.SETERROR(CNUMINOR_SYSDATE);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            
            IF (TRUNC(IDTENDDATE) < TRUNC(IDTINITIALDATE) ) THEN
                ERRORS.SETERROR(CNUENDDAT_MIN_INITDAT);
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            


            NUDIFFERENCEDAYS := (TRUNC(IDTENDDATE) - TRUNC(IDTINITIALDATE)) + 1;
            
            IF ( NUDIFFERENCEDAYS < RCGRACEPERIOD.MIN_GRACE_DAYS ) OR
               ( NUDIFFERENCEDAYS > RCGRACEPERIOD.MAX_GRACE_DAYS )
            THEN
                ERRORS.SETERROR(CNUGRACE_DAYS,NUDIFFERENCEDAYS||'|'||RCGRACEPERIOD.GRACE_PERIOD_ID);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEDATA;
    BEGIN

        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.RegGracePeriodByProd', 3);
        UT_TRACE.TRACE('Producto['||INUPRODUCTID||'] Periodo de Gracia['||INUGRACEPERIOD||']', 4);

        
        VALIDATEDATA;
        
        
        TBDIFERIDOS := PKBCDIFERIDO.FTBDIFERIDOBYPRODUCT(INUPRODUCTID);
        UT_TRACE.TRACE('Diferidos Asociados al Producto['||TBDIFERIDOS.COUNT||']', 4);
        
        
        NUINDEXGRACEPERI := 1;
        
        
        RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA (CSBFIRPG);
        
        
        NUPERSONID := GE_BOPERSONAL.FNUGETPERSONID;

        
        NUINDEXDIFERIDO := TBDIFERIDOS.FIRST;
        WHILE (NUINDEXDIFERIDO IS NOT NULL) LOOP
        
            
            RCGRACEPERIDEFE := NULL;
            
            
            RCGRACEPERIDEFE.GRACE_PERI_DEFE_ID  := GE_BOSEQUENCE.FNUGETNEXTVALSEQUENCE(CSBGRACE_PERI_DEFE,CSBSEQ_GRACE_PERI_DEFE) ;
            RCGRACEPERIDEFE.GRACE_PERIOD_ID     := INUGRACEPERIOD;
            RCGRACEPERIDEFE.DEFERRED_ID         := TBDIFERIDOS(NUINDEXDIFERIDO).DIFECODI;
            RCGRACEPERIDEFE.INITIAL_DATE        := IDTINITIALDATE;
            RCGRACEPERIDEFE.END_DATE            := IDTENDDATE;
            RCGRACEPERIDEFE.PROGRAM             := RCPROGRAM.PROCCONS;
            RCGRACEPERIDEFE.PERSON_ID           := NUPERSONID;
            
            
            TBGRACEPERIDEFE (NUINDEXGRACEPERI) := RCGRACEPERIDEFE;
            
            
            NUINDEXGRACEPERI := NUINDEXGRACEPERI + 1;
            NUINDEXDIFERIDO := TBDIFERIDOS.NEXT(NUINDEXDIFERIDO);
        END LOOP;
        
        
        IF (TBGRACEPERIDEFE.COUNT > 0) THEN
            DACC_GRACE_PERI_DEFE.INSRECORDS(TBGRACEPERIDEFE);
        END IF;
        
        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.RegGracePeriodByProd', 3);
    
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END REGGRACEPERIODBYPROD;
    

    






















	PROCEDURE CANCELGRACEPERIODBYPRO
    (
        INUPRODUCTID       IN    PR_PRODUCT.PRODUCT_ID%TYPE,
        INUGRACEPERIOD     IN    CC_GRACE_PERI_DEFE.GRACE_PERIOD_ID%TYPE,
        IDTINITIALDATE     IN    CC_GRACE_PERI_DEFE.INITIAL_DATE%TYPE,
        IDTENDDATE         IN    CC_GRACE_PERI_DEFE.END_DATE%TYPE
    )
    IS
    
        
        TBGRACEPERIDEFE         DACC_GRACE_PERI_DEFE.TYTBCC_GRACE_PERI_DEFE;
        
        
        NUINDEXGRACEPERIDEFE    NUMBER;
        
        
        RCPROGRAM               PROCESOS%ROWTYPE;
        
        
        DTSYSDATE               CC_GRACE_PERI_DEFE.END_DATE%TYPE := SYSDATE;
    
        
        PROCEDURE VALIDATEDATA IS
        BEGIN

            
            IF (INUPRODUCTID IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador del Producto');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            DAPR_PRODUCT.ACCKEY(INUPRODUCTID);

            
            IF (INUGRACEPERIOD IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador del Periodo de Gracia');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            DACC_GRACE_PERIOD.ACCKEY(INUGRACEPERIOD);

            
            IF (IDTINITIALDATE IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Fecha Inicial Periodo de Gracia');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            IF (IDTENDDATE IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Fecha Final Periodo de Gracia');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEDATA;
    
    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.CancelGracePeriodByPro', 3);
        UT_TRACE.TRACE('Producto['||INUPRODUCTID||'] Periodo de Gracia['||INUGRACEPERIOD||']', 4);
    
        
        VALIDATEDATA;
        
        
        RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA (CSBFIRPG);
        
        
        TBGRACEPERIDEFE := CC_BCGRACE_PERI_DEFE.FTBGETGRACEPERIDEFE ( INUPRODUCTID,
                                                                      INUGRACEPERIOD,
                                                                      IDTINITIALDATE,
                                                                      IDTENDDATE,
                                                                      RCPROGRAM.PROCCONS
                                                                    );
        
        NUINDEXGRACEPERIDEFE := TBGRACEPERIDEFE.FIRST;
        WHILE (NUINDEXGRACEPERIDEFE IS NOT NULL) LOOP

            

            TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).END_DATE := DTSYSDATE;

            NUINDEXGRACEPERIDEFE := TBGRACEPERIDEFE.NEXT(NUINDEXGRACEPERIDEFE);
        END LOOP;
        
        
        IF(TBGRACEPERIDEFE.COUNT > 0) THEN
            DACC_GRACE_PERI_DEFE.UPDRECORDS(TBGRACEPERIDEFE);
        END IF;
        
        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.CancelGracePeriodByPro', 3);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CANCELGRACEPERIODBYPRO;
    

    

























	PROCEDURE CANCELGRACEPERIODBYREQ
    (
        INUREQUESTID    IN    MO_PACKAGES.PACKAGE_ID%TYPE,
        INUENDDATE      IN    CC_GRACE_PERI_DEFE.END_DATE%TYPE
    )
    IS
        
        NUBILL                  FACTURA.FACTCODI%TYPE;
        
        
        RCPROGRAM               PROCESOS%ROWTYPE;

        
        TBCHARGES               PKBCCARGOS.TYTBRCCARGOS;
        
        
        NUCHARGEINDEX           NUMBER;
        
        
        TBDEFERREDS             TYDIFECODI;

        
        NUDEFERREDID            CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE;

        
        TBGRACEPERIDEFE         DACC_GRACE_PERI_DEFE.TYTBCC_GRACE_PERI_DEFE;

        
        NUINDEXGRACEPERIDEFE    NUMBER;
        
        
        BOUPDATE                BOOLEAN := FALSE;
        
        
        CNUGRACE_PERIOD_PARAM   CONSTANT    GE_PARAMETER.PARAMETER_ID%TYPE    :=  'PERI_GRACIA_RECL_DIF';
        
        
        NUGRACEPERIOD           CC_GRACE_PERIOD.GRACE_PERIOD_ID%TYPE;

        
        PROCEDURE VALIDATEDATA IS
        BEGIN

            
            IF (INUREQUESTID IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador de la Solicitud');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            DAMO_PACKAGES.ACCKEY(INUREQUESTID);
            
            
            IF (INUENDDATE IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Fecha Final');
                RAISE EX.CONTROLLED_ERROR;
            END IF;
            
            
            IF (TRUNC(INUENDDATE) < TRUNC(SYSDATE)) THEN
                ERRORS.SETERROR(CNUMINOR_ENDDATE);
                RAISE EX.CONTROLLED_ERROR;
            END IF;

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEDATA;

    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.CancelGracePeriodByReq', 3);
        UT_TRACE.TRACE('Solicitud['||INUREQUESTID||'] Fecha Final['||INUENDDATE||']', 4);

        
        VALIDATEDATA;
        
        
        TBDEFERREDS.DELETE;
        TBCHARGES.DELETE;
        
        
        NUBILL := MO_BOPACKAGEPAYMENT.FNUGETACCOUNTBYPACKAGE( INUREQUESTID );
        UT_TRACE.TRACE('Factura['||NUBILL||']', 5);

        
        RCPROGRAM := GE_BCPROCESOS.FRCPROGRAMA (CSBCUSTOMER);
        UT_TRACE.TRACE('Programa['||RCPROGRAM.PROCCONS||']', 5);
        
        
        PKBCCARGOS.GETDEFERRCHARGESBYBILL( NUBILL,
                                           RCPROGRAM.PROCCONS,
                                           TBCHARGES
                                         );

        
        NUGRACEPERIOD   :=  GE_BOPARAMETER.FNUGET(CNUGRACE_PERIOD_PARAM);
        UT_TRACE.TRACE('nuGracePeriod['||NUGRACEPERIOD||']', 5);

        
        NUCHARGEINDEX := TBCHARGES.FIRST;
        WHILE (NUCHARGEINDEX IS NOT NULL) LOOP
        
            
            NUDEFERREDID := TO_NUMBER(SUBSTR(TBCHARGES(NUCHARGEINDEX).CARGDOSO, 4 ));
            UT_TRACE.TRACE('Diferido['||NUDEFERREDID||']', 5);
            
            
            IF (NOT TBDEFERREDS.EXISTS(NUDEFERREDID)) THEN
            
                
                TBDEFERREDS(NUDEFERREDID) := NUDEFERREDID;

                
                CC_BCGRACE_PERI_DEFE.GETGRAPERBYPROGRAM
                (
                    NUDEFERREDID,
                    RCPROGRAM.PROCCONS,
                    TBGRACEPERIDEFE
                );

                
                NUINDEXGRACEPERIDEFE := TBGRACEPERIDEFE.FIRST;
                WHILE (NUINDEXGRACEPERIDEFE IS NOT NULL) LOOP
                    UT_TRACE.TRACE('Perido de Gracia por Diferido['||TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).GRACE_PERI_DEFE_ID||'],
                                    Perido de Gracia['||TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).GRACE_PERIOD_ID||']', 5);

                    
                    IF( TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).GRACE_PERIOD_ID = NUGRACEPERIOD)THEN
                        

                        IF (TRUNC(TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).END_DATE) >= TRUNC(INUENDDATE)) THEN
                            

                              TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).END_DATE := INUENDDATE;
                              BOUPDATE := TRUE;
                        END IF;
                    END IF;

                    NUINDEXGRACEPERIDEFE := TBGRACEPERIDEFE.NEXT(NUINDEXGRACEPERIDEFE);
                END LOOP;

                
                IF(BOUPDATE) THEN
                    UT_TRACE.TRACE('Actualizando Registros', 15);
                    DACC_GRACE_PERI_DEFE.UPDRECORDS(TBGRACEPERIDEFE);
                    TBGRACEPERIDEFE.DELETE;
                    BOUPDATE := FALSE;
                END IF;
            END IF;

            
            NUCHARGEINDEX := TBCHARGES.NEXT(NUCHARGEINDEX);
        END LOOP;
        
        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.CancelGracePeriodByReq', 3);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            RAISE;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CANCELGRACEPERIODBYREQ;
    

    






















	PROCEDURE ADDGRACEPERTODEFERRED
    (
        INUREQUESTID    IN    MO_PACKAGES.PACKAGE_ID%TYPE,
        IBOWITHPARAM    IN    BOOLEAN
    )
    IS
        
        TBDEFERREDS             PKTBLDIFERIDO.TYDIFECODI;

        
        NUFINANID               DIFERIDO.DIFECOFI%TYPE;

        
        CNUGRACE_PERIOD_PARAM   CONSTANT    GE_PARAMETER.PARAMETER_ID%TYPE    :=  'PERI_GRACIA_RECL_DIF';

        
        NUGRACEPERIODPARAM      CC_GRACE_PERIOD.GRACE_PERIOD_ID%TYPE;

        
        NUGRACEPERIOD           CC_GRACE_PERIOD.GRACE_PERIOD_ID%TYPE;

        
        NUDEFERREDINDEX           NUMBER;

        
        NUDEFERREDID            CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE;
        
        
        RCDIFERIDO              DIFERIDO%ROWTYPE;
        
        
        RCFINANPLAN             PLANDIFE%ROWTYPE;
        
        
        NUGRACEDAYS             CC_GRACE_PERIOD.MAX_GRACE_DAYS%TYPE;

        
        PROCEDURE VALIDATEDATA IS
        BEGIN

            
            IF (INUREQUESTID IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador de la Solicitud');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            DAMO_PACKAGES.ACCKEY(INUREQUESTID);

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEDATA;

    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.AddGracePerToDeferred', 3);
        UT_TRACE.TRACE('Solicitud['||INUREQUESTID||']', 4);

        
        VALIDATEDATA;

        
        TBDEFERREDS.DELETE;

        
        NUFINANID   := NULL;
        
        
        IF( DACC_SALES_FINANC_COND.FBLEXIST( INUREQUESTID ) )THEN
            
            NUFINANID   := DACC_SALES_FINANC_COND.FNUGETFINAN_ID( INUREQUESTID );
        END IF;

        
        IF( NUFINANID IS NULL AND DACC_FINANCING_REQUEST.FBLEXIST( INUREQUESTID ) )THEN
            
            NUFINANID   := DACC_FINANCING_REQUEST.FNUGETFINANCING_ID( INUREQUESTID );
        END IF;

        
        IF( NUFINANID IS NULL )THEN
            
            ERRORS.SETERROR(CNUERROR_FINAN);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        PKBCDIFERIDO.GETDEFERREDSBYFINANC( NUFINANID, TBDEFERREDS );

        IF( IBOWITHPARAM )THEN
            
            NUGRACEPERIODPARAM  :=  GE_BOPARAMETER.FNUGET(CNUGRACE_PERIOD_PARAM);
            UT_TRACE.TRACE('Parametro [PERI_GRACIA_RECL_DIF] nuGracePeriodParam: ['||NUGRACEPERIODPARAM||']', 5);
        END IF;

        
        NUDEFERREDINDEX := TBDEFERREDS.FIRST;
        WHILE (NUDEFERREDINDEX IS NOT NULL) LOOP

            
            NUDEFERREDID := TBDEFERREDS(NUDEFERREDINDEX);
            UT_TRACE.TRACE('Diferido['||NUDEFERREDID||']', 5);

            
            RCDIFERIDO  :=  PKTBLDIFERIDO.FRCGETRECORD( NUDEFERREDID );

            

            IF(IBOWITHPARAM)THEN
                
                NUGRACEPERIOD   := NUGRACEPERIODPARAM;
            ELSE
                
                RCFINANPLAN := PKTBLPLANDIFE.FRCGETRECORD( RCDIFERIDO.DIFEPLDI );
                
                NUGRACEPERIOD   := RCFINANPLAN.PLDIPEGR;
            END IF;
                
            UT_TRACE.TRACE('nuGracePeriod['||NUGRACEPERIOD||']', 5);
            
            IF(NOT NUGRACEPERIOD IS NULL)THEN

                
                NUGRACEDAYS  :=  DACC_GRACE_PERIOD.FNUGETMAX_GRACE_DAYS( NUGRACEPERIOD );

                
                PKDEFERRED.AGGREGATEGRACEPERIOD
                (
                    NUGRACEPERIOD,
                    RCDIFERIDO.DIFECODI,
                    RCDIFERIDO.DIFEPROG,
                    SYSDATE + NUGRACEDAYS
                );

            END IF;

            
            NUDEFERREDINDEX := TBDEFERREDS.NEXT(NUDEFERREDINDEX);
        END LOOP;

        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.AddGracePerToDeferred', 3);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR [LOGIN_DENIED] CC_BOGrace_Peri_Defe.AddGracePerToDeferred', 5);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR [OTHERS] CC_BOGrace_Peri_Defe.AddGracePerToDeferred', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ADDGRACEPERTODEFERRED;
    

    



















	PROCEDURE ADDGRACEPERIODMANUAL
    (
        INUREQUESTID    IN    MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.AddGracePeriodManual', 3);
        ADDGRACEPERTODEFERRED( INUREQUESTID, FALSE );
        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.AddGracePeriodManual', 3);
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR [LOGIN_DENIED] CC_BOGrace_Peri_Defe.AddGracePeriodManual', 5);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR [OTHERS] CC_BOGrace_Peri_Defe.AddGracePeriodManual', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ADDGRACEPERIODMANUAL;

    



















	PROCEDURE ADDGRACEPERIODDUMMY
    (
        INUREQUESTID    IN    MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.AddGracePeriodDummy', 3);
        ADDGRACEPERTODEFERRED( INUREQUESTID, TRUE );
        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.AddGracePeriodDummy', 3);
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR [LOGIN_DENIED] CC_BOGrace_Peri_Defe.AddGracePeriodDummy', 5);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR [OTHERS] CC_BOGrace_Peri_Defe.AddGracePeriodDummy', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END ADDGRACEPERIODDUMMY;
    
    



















	PROCEDURE CANCELGRACEPERTODEF
    (
        INUREQUESTID    IN    MO_PACKAGES.PACKAGE_ID%TYPE,
        INUENDDATE      IN    CC_GRACE_PERI_DEFE.END_DATE%TYPE
    )
    IS
        
        TBDEFERREDS             PKTBLDIFERIDO.TYDIFECODI;

        
        NUFINANID               DIFERIDO.DIFECOFI%TYPE;

        
        CNUGRACE_PERIOD_PARAM   CONSTANT    GE_PARAMETER.PARAMETER_ID%TYPE    :=  'PERI_GRACIA_RECL_DIF';

        
        NUGRACEPERIODPARAM      CC_GRACE_PERIOD.GRACE_PERIOD_ID%TYPE;

        
        NUGRACEPERIOD           CC_GRACE_PERIOD.GRACE_PERIOD_ID%TYPE;

        
        NUDEFERREDINDEX           NUMBER;

        
        NUDEFERREDID            CC_GRACE_PERI_DEFE.DEFERRED_ID%TYPE;

        
        RCDIFERIDO              DIFERIDO%ROWTYPE;

        
        RCFINANPLAN             PLANDIFE%ROWTYPE;

        
        NUGRACEDAYS             CC_GRACE_PERIOD.MAX_GRACE_DAYS%TYPE;
        
        
        TBGRACEPERIDEFE         DACC_GRACE_PERI_DEFE.TYTBCC_GRACE_PERI_DEFE;
        
        
        NUINDEXGRACEPERIDEFE    NUMBER;

        
        BOUPDATE                BOOLEAN := FALSE;
        
        
        PROCEDURE VALIDATEDATA IS
        BEGIN

            
            IF (INUREQUESTID IS NULL) THEN
                ERRORS.SETERROR(CNUNULL_ATTRIBUTE,'Identificador de la Solicitud');
                RAISE EX.CONTROLLED_ERROR;
            END IF;

            
            DAMO_PACKAGES.ACCKEY(INUREQUESTID);

        EXCEPTION
            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
                RAISE;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END VALIDATEDATA;

    BEGIN
        UT_TRACE.TRACE('Inicio CC_BOGrace_Peri_Defe.CancelGracePerToDef', 3);
        UT_TRACE.TRACE('Solicitud['||INUREQUESTID||']', 4);

        
        VALIDATEDATA;

        
        TBDEFERREDS.DELETE;
        TBGRACEPERIDEFE.DELETE;

        
        NUFINANID   := NULL;

        
        IF( DACC_SALES_FINANC_COND.FBLEXIST( INUREQUESTID ) )THEN
            
            NUFINANID   := DACC_SALES_FINANC_COND.FNUGETFINAN_ID( INUREQUESTID );
        END IF;

        
        IF( NUFINANID IS NULL AND DACC_FINANCING_REQUEST.FBLEXIST( INUREQUESTID ) )THEN
            
            NUFINANID   := DACC_FINANCING_REQUEST.FNUGETFINANCING_ID( INUREQUESTID );
        END IF;

        
        IF( NUFINANID IS NULL )THEN
            
            ERRORS.SETERROR(CNUERROR_FINAN);
            RAISE EX.CONTROLLED_ERROR;
        END IF;

        
        PKBCDIFERIDO.GETDEFERREDSBYFINANC( NUFINANID, TBDEFERREDS );

        
        NUGRACEPERIODPARAM  :=  GE_BOPARAMETER.FNUGET(CNUGRACE_PERIOD_PARAM);
        UT_TRACE.TRACE('Parametro [PERI_GRACIA_RECL_DIF] nuGracePeriodParam: ['||NUGRACEPERIODPARAM||']', 5);

        
        NUDEFERREDINDEX := TBDEFERREDS.FIRST;
        WHILE (NUDEFERREDINDEX IS NOT NULL) LOOP

            
            NUDEFERREDID := TBDEFERREDS(NUDEFERREDINDEX);
            UT_TRACE.TRACE('Diferido['||NUDEFERREDID||']', 5);

            
            CC_BCGRACE_PERI_DEFE.GETGRAPERBYPROGRAM
            (
                NUDEFERREDID,
                NULL,
                TBGRACEPERIDEFE
            );
            
            
            NUINDEXGRACEPERIDEFE := TBGRACEPERIDEFE.FIRST;
            WHILE (NUINDEXGRACEPERIDEFE IS NOT NULL) LOOP
                UT_TRACE.TRACE('Perido de Gracia por Diferido['||TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).GRACE_PERI_DEFE_ID||'],
                                Perido de Gracia['||TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).GRACE_PERIOD_ID||']', 5);

                
                IF( TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).GRACE_PERIOD_ID = NUGRACEPERIODPARAM)THEN
                    

                    IF (TRUNC(TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).END_DATE) >= TRUNC(INUENDDATE)) THEN
                        

                          TBGRACEPERIDEFE(NUINDEXGRACEPERIDEFE).END_DATE := INUENDDATE;
                          BOUPDATE := TRUE;
                    END IF;
                END IF;

                NUINDEXGRACEPERIDEFE := TBGRACEPERIDEFE.NEXT(NUINDEXGRACEPERIDEFE);
            END LOOP;

            
            IF(BOUPDATE) THEN
                UT_TRACE.TRACE('Actualizando Registros', 15);
                DACC_GRACE_PERI_DEFE.UPDRECORDS(TBGRACEPERIDEFE);
                TBGRACEPERIDEFE.DELETE;
                BOUPDATE := FALSE;
            END IF;

            
            NUDEFERREDINDEX := TBDEFERREDS.NEXT(NUDEFERREDINDEX);
        END LOOP;

        UT_TRACE.TRACE('Fin CC_BOGrace_Peri_Defe.CancelGracePerToDef', 3);

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            UT_TRACE.TRACE('ERROR [LOGIN_DENIED] CC_BOGrace_Peri_Defe.CancelGracePerToDef', 5);
            RAISE;
        WHEN OTHERS THEN
            UT_TRACE.TRACE('ERROR [OTHERS] CC_BOGrace_Peri_Defe.CancelGracePerToDef', 5);
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END CANCELGRACEPERTODEF;

END CC_BOGRACE_PERI_DEFE;