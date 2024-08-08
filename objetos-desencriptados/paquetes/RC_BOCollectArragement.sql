PACKAGE BODY RC_BOCollectArragement IS


















































































    
    
    
    CSBVERSION              CONSTANT VARCHAR2(250) := 'SAO303084';
    
    
    CSBARRANGE_CLOSE        CONSTANT SA_EXECUTABLE.NAME%TYPE := 'RCNCCR';

    
    CSBDATE_FORMAT          CONSTANT VARCHAR2(30) := 'DD-MM-YYYY HH24:MI:SS';
    
    CSBDAYS_FORMAT          CONSTANT VARCHAR2(30) := 'DD-MM-YYYY';
    
    CSBHOURS_FORMAT         CONSTANT VARCHAR2(30) := 'HH24:MI:SS';
    
    
    CNUEXISTS_PAYARRANGE    CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901600;
    
    CNUNOT_EXISTS_PAYARRAN  CONSTANT MENSAJE.MENSCODI%TYPE := 9065;
    
    CNUFIELD_VALUE          CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 111121;
    
    CNUEXITSCONCILIA        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901600;
    
    CNUARRANGE_NO_COMPANY   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 900973;
    
    CNUPAY_ON_ARRANGE       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901134;
    
    CNUNO_DATA_SEARCH       CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 2515;
    
    CNUNO_DATE_RANGE        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 2348;
    
    CNUCHECK_AUTO_ARRANGE   CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 7601;
    
    
    CNUNO_ENTITY_TO_PAY     CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 4075;

    
    CNU_COMMENT_TYPE CONSTANT GE_COMMENT_TYPE.COMMENT_TYPE_ID%TYPE := 4;

    
    CSBTAG_INFO_COUPON      CONSTANT VARCHAR2(50) := 'Cupones_Pagados';
    
    CSBTAG_INFO_VALUE       CONSTANT VARCHAR2(50) := 'Valor_Pagado';
    
    CSBTAG_AUTOMATIC_CLOSE  CONSTANT VARCHAR2(50) := 'Cierre_Automatico';

    
    CSBCOMMENTA CONSTANT VARCHAR2(1000) := 'Legalizaci�n autom�tica:
                                                            Conciliaci�n[%s1] -
                                                            Entidad[%s2] -
                                                            Punto de Pago[%s3]';
    
    
    

    
    SBERRMSG                GE_ERROR_LOG.DESCRIPTION%TYPE;
    
    




















FUNCTION FNUGETARRANGFORSUBA
(
    INUCONCBANC IN CONCILIA.CONCBANC%TYPE,
    ISBCONCSUBA IN RC_CONCPUPA.COPPSUBA%TYPE,
    IDTCONCFEPA IN CONCILIA.CONCFEPA%TYPE
)
RETURN CONCILIA.CONCCONS%TYPE
IS
    DTCONCFEPA CONCILIA.CONCFEPA%TYPE;
    TBCONCILIA PKTBLCONCILIA.TYCONCCONS;
    RCCONCPUPA RC_CONCPUPA%ROWTYPE;

BEGIN
    PKERRORS.PUSH('RC_BOCollectArragement.fnuGetArrangForSuba');

    DTCONCFEPA := TRUNC(IDTCONCFEPA);

    TBCONCILIA := RC_BCCOLLECTARRAGEMENT.FTBGETARRANGEMNTBYDATA(
        INUCONCBANC,
        DTCONCFEPA,
        INUCONCBANC,
        ISBCONCSUBA,
        SA_BOSYSTEM.FNUGETUSERCOMPANYID);

    IF TBCONCILIA.COUNT > 0 THEN
        PKERRORS.POP;
        RETURN TBCONCILIA(TBCONCILIA.FIRST);
    END IF;

    PKENTITYARRANGEMENTMGR.CREATEARRANGEMENT(
        INUCONCBANC,
        DTCONCFEPA,
        PKENTITYARRANGEMENTMGR.CNUINFO_COUPONS,
        PKENTITYARRANGEMENTMGR.CNUINFO_VALUE,
        PKGENERALSERVICES.FSBGETUSERNAME,
        
        TBCONCILIA(1));

    RCCONCPUPA.COPPCONC := TBCONCILIA(1);
    RCCONCPUPA.COPPBANC := INUCONCBANC;
    RCCONCPUPA.COPPSUBA := ISBCONCSUBA;
    PKTBLRC_CONCPUPA.INSRECORD(RCCONCPUPA);

    PKERRORS.POP;
    RETURN TBCONCILIA(1);

EXCEPTION
    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
        PKERRORS.POP;
    	RAISE;
    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
    	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    	RAISE;
END FNUGETARRANGFORSUBA;


































FUNCTION FRFGETARRANGECLOSE
RETURN CONSTANTS.TYREFCURSOR
IS
    
    CSBHINT             CONSTANT VARCHAR2(100) := '<HINT>';

    
    OCUCURSOR           CONSTANTS.TYREFCURSOR;
    
    SBHINT              VARCHAR2(500);
    
    SBCURRENTSQL        VARCHAR2(8000);

    
    SBINITIALDATE       GE_BOINSTANCECONTROL.STYSBVALUE;
    DTINITIALDATE       CONCILIA.CONCFEPA%TYPE;
    
    SBFINALDATE         GE_BOINSTANCECONTROL.STYSBVALUE;
    DTFINALDATE         CONCILIA.CONCFERE%TYPE;
    
    NUENTITY            CONCILIA.CONCBANC%TYPE;
    
    NUARRANGEMENT       CONCILIA.CONCCONS%TYPE;
    
    NUCAJA_TRAN_APERTURA    PARAMETR.PAMENUME%TYPE;
    
    SBUSERDB    FUNCIONA.FUNCUSBA%TYPE;
    
BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.frfGetArrangeClose');

    
    PKERRORS.SETAPPLICATION ( CSBARRANGE_CLOSE );

    
    NUENTITY := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE(
                                                        'CONCILIA', 'CONCBANC'
                                                               ));

    
    NUARRANGEMENT := TO_NUMBER(GE_BOINSTANCECONTROL.FSBGETFIELDVALUE(
                                                        'CONCILIA', 'CONCCONS'
                                                                    ));
    
    SBINITIALDATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE(
                                                        'CONCILIA', 'CONCFEPA'
                                                          );

    
    SBFINALDATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE(
                                                        'CONCILIA', 'CONCFERE'
                                                        );

    
    IF ( ( SBINITIALDATE IS NULL ) AND ( SBFINALDATE IS NULL ) AND
         ( ( NUENTITY IS NULL ) OR ( NUENTITY = PKCONSTANTE.NULLNUM ) ) AND
         ( ( NUARRANGEMENT IS NULL ) OR ( NUARRANGEMENT = PKCONSTANTE.NULLNUM ) )
       ) THEN
    
        ERRORS.SETERROR(CNUNO_DATA_SEARCH);
        RAISE LOGIN_DENIED;
    
    END IF;

    
    IF ( ( ( SBINITIALDATE IS NULL ) AND ( SBFINALDATE IS NOT NULL ) ) OR
         ( ( SBINITIALDATE IS NOT NULL ) AND ( SBFINALDATE IS NULL ) ) ) THEN
    
        ERRORS.SETERROR(CNUNO_DATE_RANGE);
        RAISE LOGIN_DENIED;
    
    END IF;

    DTINITIALDATE := TRUNC(TO_DATE(SBINITIALDATE, UT_DATE.FSBDATE_FORMAT));

    DTFINALDATE := TRUNC(TO_DATE(SBFINALDATE, UT_DATE.FSBDATE_FORMAT));

    
    PKGENERALSERVICES.VALDATELESSCURRENT(DTINITIALDATE);
    PKGENERALSERVICES.VALDATELESSCURRENT(DTFINALDATE);
    
    PKGENERALSERVICES.VALDATERANGE(DTINITIALDATE,DTFINALDATE);

    
    NUCAJA_TRAN_APERTURA := PKTBLPARAMETR.FNUGETVALUENUMBER('CAJA_TRAN_APERTURA');

    
    SBUSERDB := PKGENERALSERVICES.FSBGETUSERNAME;

    
    SBCURRENTSQL := 'SELECT  ' || CSBHINT ||CHR(10)||
                    '        conccons pk, '||CHR(10)||
                    '        concbanc ||'' - ''|| bancnomb "Entidad", '||CHR(10)||
                    '        conccons "No. Conciliaci�n", '||CHR(10)||
                    '        concfepa "Fecha de Conciliaci�n", '||CHR(10)||
                    '        concvato + RC_BCCollectArragement.fnuGetValDocument(conccons) "Valor Informado",'||CHR(10)||
                    '        concnucu "Cupones Informados",'||CHR(10)||
                    '        conccapa "Valor Procesado", '||CHR(10)||
                    '        concprre "Cupones Procesados", '||CHR(10)||
                    '        concvato + RC_BCCollectArragement.fnuGetValDocument'||CHR(10)||
                    '        ( '||CHR(10)||
                    '            conccons '||CHR(10)||
                    '        ) - conccapa "Valor Sobrante / Faltante",'||CHR(10)||
                    '        decode(concciau, null, ''N'', concciau) "Cierre Autom�tico"'||CHR(10)||
                    'FROM    /*+ RC_BOCollectArragement.frfGetArrangeClose */
                             concilia, banco, funciona '||CHR(10)||
                    'WHERE   concbanc = banccodi'||CHR(10)||
                    'AND     concfunc = funccodi'||CHR(10)||
                    ' AND    not exists (
                                        SELECT  /*+
                                                leading(ca_detadocu)
                                                index (ca_detadocu IX_CA_DETADOCU05)
                                                use_nl_with_index (ca_document PK_CA_DOCUMENT)
                                                */
                                                DEDOSOPO
                                        FROM    ca_detadocu,ca_document
                                        WHERE   dedosopo = to_char(conccons)
                                        AND     dedodocu = docucodi
                                        AND     docutran = :nuParametr'||CHR(10)||
                                        ')
                        '||CHR(10)||
                        'AND FUNCUSBA = :UserDB'||CHR(10)||
                        'AND     nvl(concflpr,''N'') = ''N''';
                    
    
    IF ( NUENTITY != PKCONSTANTE.NULLNUM ) THEN
    
        SBCURRENTSQL := SBCURRENTSQL || CHR(10) || 'AND     banccodi = :nuEntity ';
    
    END IF;

    
    IF ( NUARRANGEMENT IS NOT NULL ) THEN
    
        SBCURRENTSQL := SBCURRENTSQL || CHR(10) || 'AND     conccons = :nuArrangement ';
    
    END IF;

    
    IF ( (DTINITIALDATE IS NOT NULL) AND (DTFINALDATE IS NOT NULL) ) THEN
    
        SBCURRENTSQL := SBCURRENTSQL || CHR(10) ||
                        'AND     concfepa BETWEEN :dtInitialDate AND :dtFinalDate ';
    
    END IF;

    IF ( (DTINITIALDATE IS NOT NULL) AND (DTFINALDATE IS NOT NULL) ) THEN
    
        
        IF ( (NUENTITY != PKCONSTANTE.NULLNUM) AND (NUARRANGEMENT IS NOT NULL) ) THEN
        
            SBHINT := ' /*+  index(CONCILIA, PK_CONCILIA) */ ';

            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);

            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        NUENTITY,
                        NUARRANGEMENT ,
                        DTINITIALDATE,
                        DTFINALDATE;
        
        ELSIF (NUENTITY != PKCONSTANTE.NULLNUM AND (NUARRANGEMENT IS NULL) ) THEN
        
            SBHINT := ' /*+  leading (BANCO) index(CONCILIA, IX_CONCILIA05) */ ';
            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);

            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        NUENTITY,
                        DTINITIALDATE,
                        DTFINALDATE;
        
        ELSIF (NUENTITY IS NULL AND (NUARRANGEMENT IS NOT NULL) ) THEN
        
            SBHINT := ' /*+  index(CONCILIA, PK_CONCILIA) */ ';
            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);

            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        NUARRANGEMENT,
                        DTINITIALDATE,
                        DTFINALDATE;
        
        ELSE
        
            SBHINT := ' /*+  index(CONCILIA, IX_CONC_FEPA) */ ';
            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);

            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        DTINITIALDATE,
                        DTFINALDATE;
        
        END IF;
    
    ELSE
    
        
        IF ( (NUENTITY != PKCONSTANTE.NULLNUM) AND (NUARRANGEMENT IS NOT NULL) ) THEN
        
            SBHINT := '/*+  index(CONCILIA, PK_CONCILIA) */ ';
            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);

            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        NUENTITY,
                        NUARRANGEMENT;
        
        ELSIF (NUENTITY != PKCONSTANTE.NULLNUM AND (NUARRANGEMENT IS NULL) ) THEN
        
            SBHINT := ' /*+  index(CONCILIA, IX_CONCILIA05) */ ';
            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);
            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        NUENTITY;
        
        ELSIF (NUENTITY IS NULL AND (NUARRANGEMENT IS NOT NULL) ) THEN
        
            SBHINT := ' /*+  index(CONCILIA, PK_CONCILIA) */ ';
            SBCURRENTSQL := SBCURRENTSQL||' ORDER BY conccons desc';
            SBCURRENTSQL := REPLACE(SBCURRENTSQL,CSBHINT,SBHINT);

            OPEN OCUCURSOR FOR SBCURRENTSQL
                USING   NUCAJA_TRAN_APERTURA,
                        SBUSERDB,
                        NUARRANGEMENT;
        
        END IF;
    
    END IF;

    PKERRORS.POP;

    
    RETURN ( OCUCURSOR );

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
    	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	
        PKERRORS.POP;
    	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN

        PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END FRFGETARRANGECLOSE;




















FUNCTION FSBVERSION
RETURN VARCHAR2
IS
BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.fsbVersion');

    PKERRORS.POP;

    
    RETURN ( CSBVERSION );

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
    	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	
    	PKERRORS.POP;
    	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END FSBVERSION;

























PROCEDURE ASSISTEDCLOSE
(
    ISBID           IN      VARCHAR2,
    INUCURRENT      IN      NUMBER,
    INUTOTAL        IN      NUMBER,
    ONUERRORCODE    OUT     GE_ERROR_LOG.ERROR_LOG_ID%TYPE,
    OSBERRORMESSAGE OUT     GE_ERROR_LOG.DESCRIPTION%TYPE
)
IS
    
    NUARRANGEMENT       CONCILIA.CONCCONS%TYPE;
BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.AssistedClose');

    
    NUARRANGEMENT := TO_NUMBER(ISBID);
    
    
    COLLECTINGCLOSEPROCESS
    (
        NUARRANGEMENT,
        NULL,
        NULL
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
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END ASSISTEDCLOSE;

























PROCEDURE AUTOMATICCLOSE
IS
    
    TBARRANGEMENTS          RC_BCCOLLECTARRAGEMENT.TYTBCONCILIA;
    
    NUARRANGEIDX            NUMBER;
    
    NUREPORTEDVALUE         CONCILIA.CONCVATO%TYPE;
    
    NUREPORTEDCOUPON        CONCILIA.CONCNUCU%TYPE;
BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.AutomaticClose');

    
    TBARRANGEMENTS := RC_BCCOLLECTARRAGEMENT.FTBGETOPENARRAGEMENTS;

    
    NUARRANGEIDX := TBARRANGEMENTS.CONCCONS.FIRST;

    
    LOOP
    
        EXIT WHEN NUARRANGEIDX IS NULL;
        
        TD('Collect Arrangement: '||TBARRANGEMENTS.CONCCONS(NUARRANGEIDX));
        
        
        NUREPORTEDVALUE := NULL;
        NUREPORTEDCOUPON := NULL;
        
        TD('  Reported Value: '||TBARRANGEMENTS.CONCVATO(NUARRANGEIDX));
        TD('  Reported Coupons: '||TBARRANGEMENTS.CONCNUCU(NUARRANGEIDX));

        
        
        IF ( ( PKENTITYARRANGEMENTMGR.CNUINFO_VALUE = TBARRANGEMENTS.CONCVATO(NUARRANGEIDX) ) AND
           ( PKENTITYARRANGEMENTMGR.CNUINFO_COUPONS = TBARRANGEMENTS.CONCNUCU(NUARRANGEIDX) ) ) THEN
        
            NUREPORTEDVALUE := TBARRANGEMENTS.CONCCAPA(NUARRANGEIDX);
            NUREPORTEDCOUPON := TBARRANGEMENTS.CONCPRRE(NUARRANGEIDX);
        
        END IF;
        

        TD('  Final Reported Value: '||NUREPORTEDVALUE);
        TD('  Final Reported Coupons: '||NUREPORTEDCOUPON);

        
        
        
        
        
        IF ( NOT RC_BCCOLLECTARRAGEMENT.FBOEXISTSINCONSLINES(TBARRANGEMENTS.CONCCONS(NUARRANGEIDX)) )
        THEN
        
            BEGIN
            
                
                COLLECTINGCLOSEPROCESS
                (
                    TBARRANGEMENTS.CONCCONS(NUARRANGEIDX),
                    NUREPORTEDVALUE,
                    NUREPORTEDCOUPON
                );

                TD('*** Collect Arrangement Closed ***');


                
                PKGENERALSERVICES.COMMITTRANSACTION;
                
            EXCEPTION
                WHEN OTHERS THEN
                    TD('*** Collect Arrangement With Errors ***');
                    PKGENERALSERVICES.ROLLBACKTRANSACTION;
            
            END;
            
            TD('--------------------------------------------');
        
        END IF;
        
        TD('');

        NUARRANGEIDX := TBARRANGEMENTS.CONCCONS.NEXT(NUARRANGEIDX);
    
    END LOOP;

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
    	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	
    	PKERRORS.POP;
    	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END AUTOMATICCLOSE;














































PROCEDURE COLLECTINGCLOSEPROCESS
(
    INUARRANGEMENT      IN      CONCILIA.CONCCONS%TYPE,
    INUINFOVALUE        IN      CONCILIA.CONCVATO%TYPE,
    INUINFOCOUPON       IN      CONCILIA.CONCNUCU%TYPE,
    IBOVALFILEPROCESSED IN      BOOLEAN DEFAULT TRUE
)
IS
    
    RCARRANGEMENT       CONCILIA%ROWTYPE;
    
    
    
    CURSOR CUCONCILIA
    (
        INUCONCCONS IN CONCILIA.CONCCONS%TYPE
    )
    IS
        SELECT  *
        FROM    CONCILIA
        WHERE   CONCCONS = INUCONCCONS
        FOR UPDATE OF CONCNUCU, CONCVATO, CONCFLPR, CONCFECI;

    
    
    
    FUNCTION FRCENTITYARRANGEMENT
        (
            INUCONCCONS    IN    CONCILIA.CONCCONS%TYPE
        )
    RETURN CONCILIA%ROWTYPE
    IS
        CNURECORD_NO_EXISTE     CONSTANT NUMBER :=9065; 
        RCCONCILIA              CONCILIA%ROWTYPE;    
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.frcEntityArrangement');
        IF ( CUCONCILIA%ISOPEN ) THEN
            CLOSE CUCONCILIA;
        END IF;
        
        OPEN CUCONCILIA(INUCONCCONS) ;
        FETCH CUCONCILIA INTO RCCONCILIA;
        IF ( CUCONCILIA%NOTFOUND ) THEN
            PKERRORS.SETERRORCODE(  PKCONSTANTE.CSBDIVISION,
                                    PKCONSTANTE.CSBMOD_SAT,
                                    CNURECORD_NO_EXISTE );
            RAISE LOGIN_DENIED;
        END IF;
        PKERRORS.POP;
        RETURN RCCONCILIA ;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            CLOSE CUCONCILIA;
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            CLOSE CUCONCILIA;
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            CLOSE CUCONCILIA;
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END FRCENTITYARRANGEMENT;
    


    PROCEDURE ENTITYARRANGEMENTCLOSE
    IS
    BEGIN

        PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.EntityArrangementClose');

        
        UPDATE CONCILIA
           SET CONCNUCU = RCARRANGEMENT.CONCNUCU,
               CONCVATO = RCARRANGEMENT.CONCVATO,
               CONCFLPR = PKCONSTANTE.SI,
               CONCFECI = PKGENERALSERVICES.FDTGETSYSTEMDATE
        WHERE CURRENT OF CUCONCILIA;

        IF ( CUCONCILIA%ISOPEN) THEN
            CLOSE CUCONCILIA;
        END IF;

        PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            IF ( CUCONCILIA%ISOPEN) THEN
                CLOSE CUCONCILIA;
            END IF;
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF ( CUCONCILIA%ISOPEN) THEN
                CLOSE CUCONCILIA;
            END IF;
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            IF ( CUCONCILIA%ISOPEN) THEN
                CLOSE CUCONCILIA;
            END IF;
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END ENTITYARRANGEMENTCLOSE;

    


























    PROCEDURE ARRANGEMENTADJUST
    IS
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.ArrangementAdjust');

        
        RCARRANGEMENT := FRCENTITYARRANGEMENT (INUARRANGEMENT);

        
        
        
        
        IF ( INUINFOCOUPON IS NOT NULL AND INUINFOVALUE IS NOT NULL ) THEN
        
            
            RCARRANGEMENT.CONCNUCU := INUINFOCOUPON;
            RCARRANGEMENT.CONCVATO := INUINFOVALUE;
        
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END ARRANGEMENTADJUST;

    

















    PROCEDURE GENCOUPONCTRLSUPPDOC
    IS
        
        NUDOCUMENTCTRL      DOCUSORE.DOSRCODI%TYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.GenCouponCtrlSuppDoc');

        
        IF ( PKBCDOCUSORE.FBLEXISTCOUPONCONTROL(INUARRANGEMENT) ) THEN
        
            PKERRORS.POP;
            RETURN;
        
        END IF;
        
        IF (RCARRANGEMENT.CONCVATO <> PKENTITYARRANGEMENTMGR.CNUINFO_VALUE) THEN
            
            RC_BOCOLLECTSUPPORTDOC.REGCTRLCOUPONSUPPDOC
            (
                RCARRANGEMENT.CONCBANC,
                INUARRANGEMENT,
                RCARRANGEMENT.CONCFEPA,
                RCARRANGEMENT.CONCVATO,
                RCARRANGEMENT.CONCNUCU,
                NUDOCUMENTCTRL
            );
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END GENCOUPONCTRLSUPPDOC;

    

























    PROCEDURE GENMISSEXCESSSUPPDOC
    IS
        
        NUDOCUMENTCODE      DOCUSORE.DOSRCODI%TYPE;
        
        NUDIFFERENCEVALUE   DOCUSORE.DOSRVDSR%TYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.GenMissExcessSuppDoc');
        
        
        
        
        
        IF ( PKERRORS.FSBGETAPPLICATION = CA_BOCONSTANTS.CSBFCIE ) THEN
        
            PKERRORS.POP;
            RETURN;
        
        END IF;

        
        NUDIFFERENCEVALUE := RC_BCCOLLECTARRAGEMENT.FNUGETVALDOCUMENT(INUARRANGEMENT) -
                             RCARRANGEMENT.CONCCAPA;

        
        IF ( NUDIFFERENCEVALUE > PKBILLCONST.CERO ) THEN
        
            
            RC_BOCOLLECTSUPPORTDOC.REGMISSINGSUPPDOC
            (
                RCARRANGEMENT.CONCBANC,
                INUARRANGEMENT,
                RCARRANGEMENT.CONCFEPA,
                ABS(NUDIFFERENCEVALUE),
                NUDOCUMENTCODE
            );
        
        
        ELSIF ( NUDIFFERENCEVALUE < PKBILLCONST.CERO ) THEN
        
            
            RC_BOCOLLECTSUPPORTDOC.REGEXCESSSUPPDOC
            (
                RCARRANGEMENT.CONCBANC,
                INUARRANGEMENT,
                RCARRANGEMENT.CONCFEPA,
                ABS(NUDIFFERENCEVALUE),
                NUDOCUMENTCODE
            );
        
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END GENMISSEXCESSSUPPDOC;

    




















    PROCEDURE VALCLOSEARRANGEMENT
    IS
        
        SBFILENAME          ARCHRECA.ARRENOAF%TYPE;
        
        SBSTATUSFILE        GST_HIARREDA.HIREESTA%TYPE;
        
        BLALLOWCLOSE        BOOLEAN := TRUE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.ValCloseArrangement');
        
        
        PKENTITYARRANGEMENTMGR.VALIDATEISCLOSED(INUARRANGEMENT);

        
        SBFILENAME := RC_BCARCHRECA.FSBOBTNOMBREARCHFACT(INUARRANGEMENT);

        
        
        IF (SBFILENAME IS NOT NULL) THEN
        
            
            SBSTATUSFILE := PKBCGST_HIARREDA.FSBOBTESTADOULTREGARCH(SBFILENAME);

            
            IF IBOVALFILEPROCESSED
                AND NVL(SBSTATUSFILE, PKBCGST_HIARREDA.FSBGETPROCESS) = PKBCGST_HIARREDA.FSBGETPROCESS
            THEN
            
                BLALLOWCLOSE := FALSE;
            
            END IF;
        
        END IF;
        
        
        IF ( NOT BLALLOWCLOSE ) THEN
        
            ERRORS.SETERROR(CNUPAY_ON_ARRANGE,INUARRANGEMENT);
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END VALCLOSEARRANGEMENT;
    
    























    PROCEDURE CALLGENERATEORDERS (INUCONCCONS CONCILIA.CONCCONS%TYPE)
    IS
        
        TYTBGROUPEDPAYS  RC_BCCOLLECTARRAGEMENT.TYRCGRPAY;

        
        NUIDX   NUMBER;

        
        SBCOMMENT   OR_ORDER_ACTIVITY.COMMENT_%TYPE;

        
        NUUSERID    SA_USER.USER_ID%TYPE;
        NUPERSONID  GE_PERSON.PERSON_ID%TYPE;

        
        NUORDERID  OR_ORDER.ORDER_ID%TYPE;

        
        RCORDECONC  RC_ORDECONC%ROWTYPE;

        NUERRORCODE     GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE  GE_MESSAGE.DESCRIPTION%TYPE;

    BEGIN
         PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess.CallGenerateOrders');

         
         TYTBGROUPEDPAYS := RC_BCCOLLECTARRAGEMENT.FTBGETGROUPPAYMENTS(INUCONCCONS);

         
         IF TYTBGROUPEDPAYS.NUENTIDADPAGO.COUNT = 0 THEN
            PKERRORS.POP;
            RETURN;
         END IF;

         
         NUUSERID   := SA_BCUSER.FNUUSERID(PKGENERALSERVICES.FSBGETUSERNAME);
         
         
         NUPERSONID := GE_BCPERSON.FNUGETFIRSTPERSONBYUSERID(NUUSERID);

         
         NUIDX := TYTBGROUPEDPAYS.NUENTIDADPAGO.FIRST;
         LOOP
             EXIT WHEN NUIDX IS NULL;

             
             SBCOMMENT := CSBCOMMENTA;
             SBCOMMENT := REPLACE(SBCOMMENT, '%s1', INUCONCCONS);
             SBCOMMENT := REPLACE(SBCOMMENT, '%s2', TYTBGROUPEDPAYS.NUENTIDADPAGO(NUIDX));
             SBCOMMENT := REPLACE(SBCOMMENT, '%s3', TYTBGROUPEDPAYS.NUPUNTOPAGO(NUIDX));

             
             OR_BSORDER.CREATECLOSEORDER
             (
                 TYTBGROUPEDPAYS.NUUNIDADTRABAJO(NUIDX), 
                 TYTBGROUPEDPAYS.NUACTIVIDAD(NUIDX),     
                 TYTBGROUPEDPAYS.NUDIRECCIONPTO(NUIDX),  
                 TYTBGROUPEDPAYS.DTFECHAPAGO(NUIDX),     
                 TYTBGROUPEDPAYS.NUNUMEROCUPONES(NUIDX), 
                 TYTBGROUPEDPAYS.NUVALORPAGADO(NUIDX),   
                 1,                                      
                 NULL,
                 NUORDERID,                              
                 NULL,
                 CNU_COMMENT_TYPE,                       
                 SBCOMMENT,                              
                 NUPERSONID,                             
                 NUERRORCODE,                            
                 SBERRORMESSAGE                          
            );


            
            IF NUERRORCODE <> 0 THEN
                ERRORS.SETERROR(NUERRORCODE,SBERRORMESSAGE);
                RAISE LOGIN_DENIED;
            END IF;


            
            RCORDECONC.ORCOBANC := TYTBGROUPEDPAYS.NUENTIDADPAGO(NUIDX);
            RCORDECONC.ORCOCONC := INUCONCCONS;
            RCORDECONC.ORCOCONS := PKGENERALSERVICES.FNUGETNEXTSEQUENCEVAL
                                                      ('SQ_RC_ORDECONC_174898');
            RCORDECONC.ORCOORDE := NUORDERID;
            RCORDECONC.ORCOSUBA := TYTBGROUPEDPAYS.NUPUNTOPAGO(NUIDX);

            
            PKTBLRC_ORDECONC.INSRECORD(RCORDECONC);
            
            
            NUORDERID:= NULL;

            
            NUIDX := TYTBGROUPEDPAYS.NUENTIDADPAGO.NEXT(NUIDX);
         END LOOP;

         PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
        	RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END CALLGENERATEORDERS;

BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.CollectingCloseProcess');

    
    VALCLOSEARRANGEMENT;

    
    ARRANGEMENTADJUST;

    
    GENCOUPONCTRLSUPPDOC;

    
    GENMISSEXCESSSUPPDOC;

    
    ENTITYARRANGEMENTCLOSE;

    
    CALLGENERATEORDERS(INUARRANGEMENT);
    
    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
    	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	
    	PKERRORS.POP;
    	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END COLLECTINGCLOSEPROCESS;





























PROCEDURE EXTERNALCLOSEPROCESS
(
    INUREFTYPE          IN      NUMBER,
    INUENTITY           IN      BANCO.BANCCODI%TYPE,
    IDTPAYARRANDATE     IN      CONCILIA.CONCFEPA%TYPE,
    INUPAYARRANCODE     IN      CONCILIA.CONCCONS%TYPE,
    INUINFOCOUPONS      IN      CONCILIA.CONCNUCU%TYPE,
    INUINFOVALUE        IN      CONCILIA.CONCVATO%TYPE
)
IS
    
    TBCONCCONS      PKTBLCONCILIA.TYCONCCONS;
    
    RCCONCILIA      CONCILIA%ROWTYPE;

    
    
    

    























    PROCEDURE VALBASICDATA
    IS
        
        BLEXISTS        BOOLEAN;
        
        RCFUNCIONA      FUNCIONA%ROWTYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.ExternalCloseProcess.ValBasicData');

        IF ( INUREFTYPE = CNUREF_ONE ) THEN
        
            
            RCCONCILIA := PKTBLCONCILIA.FRCGETRECORD(INUPAYARRANCODE);
        
        ELSIF ( INUREFTYPE = CNUREF_TWO ) THEN
        
            
            BLEXISTS := PKBCCONCILIA.FBLGETAGREEMENTBYBANK
                        (
                            INUENTITY,
                            TRUNC(IDTPAYARRANDATE),
                            TRUNC(IDTPAYARRANDATE),
                            TBCONCCONS
                        );

            
            IF ( NOT BLEXISTS ) THEN
            
                PKERRORS.SETERRORCODE
                (
                    PKCONSTANTE.CSBDIVISION,
                    PKCONSTANTE.CSBMOD_SAT,
                    CNUNOT_EXISTS_PAYARRAN
                );
                RAISE LOGIN_DENIED;
            
            END IF;

            
            
            IF ( TBCONCCONS.COUNT > 1 ) THEN
            
                ERRORS.SETERROR(CNUEXISTS_PAYARRANGE);
                RAISE LOGIN_DENIED;
            
            END IF;

            TD('tbconccons(1) '||TBCONCCONS(1) );

            
            RCCONCILIA := PKTBLCONCILIA.FRCGETRECORD(TBCONCCONS(1));
        
        END IF;
        
        
        RCFUNCIONA := PKTBLFUNCIONA.FRCGETRECORDUSERBD(AU_BOSYSTEM.GETSYSTEMUSERMASK);

        
        IF (RCFUNCIONA.FUNCCODI != RCCONCILIA.CONCFUNC) THEN
        
            PKERRORS.SETERRORCODE( PKCONSTANTE.CSBDIVISION, PKCONSTANTE.CSBMOD_BIL, 10136 );
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END VALBASICDATA;

    

















    PROCEDURE VALINPUTDATA
    IS
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.ExternalCloseProcess.ValInputData');

        
        
        IF ( INUREFTYPE = CNUREF_ONE ) THEN
        
            
            PKENTITYARRANGEMENTMGR.VALBASICCODE(INUPAYARRANCODE);
        
        
        
        ELSIF ( INUREFTYPE = CNUREF_TWO ) THEN
        
            
            PKBANKMGR.VALBASICDATA(INUENTITY);

            
            PKGENERALSERVICES.VALIDATEDATENULLITY(IDTPAYARRANDATE);
        
        END IF;

        
        
        IF ( ( INUINFOCOUPONS IS NULL ) OR ( INUINFOCOUPONS < 0 ) ) THEN
        
            ERRORS.SETERROR(CNUFIELD_VALUE,CSBTAG_INFO_COUPON);
            RAISE LOGIN_DENIED;
        
        END IF;

        
        IF ( ( INUINFOVALUE IS NULL ) OR ( INUINFOVALUE < 0 ) ) THEN
        
            ERRORS.SETERROR(CNUFIELD_VALUE,CSBTAG_INFO_VALUE);
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END VALINPUTDATA;
BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.ExternalCloseProcess');

    
    VALINPUTDATA;

    
    VALBASICDATA;

    
    COLLECTINGCLOSEPROCESS
    (
        RCCONCILIA.CONCCONS,
        INUINFOVALUE,
        INUINFOCOUPONS
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
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END EXTERNALCLOSEPROCESS;
























PROCEDURE EXTERNALCREATEPROCESS
(
    INUREFTYPE          IN      NUMBER,
    INUENTITY           IN      BANCO.BANCCODI%TYPE,
    ISBENTITYBRANCH     IN      SUCUBANC.SUBACODI%TYPE,
    IDTPAYARRANDATE     IN      CONCILIA.CONCFEPA%TYPE,
    ISBAUTOMATICCLOSE   IN      CONCILIA.CONCCIAU%TYPE,
    ONUARRANGECODE      OUT     CONCILIA.CONCCONS%TYPE
)
IS
    
    DTARRANGEDATE       CONCILIA.CONCFEPA%TYPE;

    
    
    

    






















    PROCEDURE CREATEARRANGEMENT
    IS
        
        RCCONCPUPA          RC_CONCPUPA%ROWTYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.ExternalCreateProcess.CreateArrangement');

        
        IF ( INUREFTYPE = CNUREF_ONE ) THEN
        
            
            PKENTITYARRANGEMENTMGR.CREATEARRANGEMENT
            (
                INUENTITY,
                DTARRANGEDATE,
                PKENTITYARRANGEMENTMGR.CNUINFO_COUPONS,
                PKENTITYARRANGEMENTMGR.CNUINFO_VALUE,
                PKGENERALSERVICES.FSBGETUSERNAME,
                ONUARRANGECODE, 
                PKENTITYARRANGEMENTMGR.FNUGETCOMPANY,
                ISBAUTOMATICCLOSE
            );
        
        
        ELSIF ( INUREFTYPE = CNUREF_TWO ) THEN
        
            
            PKENTITYARRANGEMENTMGR.CREATEPAYARRANGBYSCHED
            (
                INUENTITY,
                ISBENTITYBRANCH,
                DTARRANGEDATE,
                ONUARRANGECODE, 
                ISBAUTOMATICCLOSE
            );

            
            RCCONCPUPA.COPPCONC := ONUARRANGECODE;
            RCCONCPUPA.COPPBANC := INUENTITY;
            RCCONCPUPA.COPPSUBA := ISBENTITYBRANCH;

            PKTBLRC_CONCPUPA.INSRECORD(RCCONCPUPA);
        
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END CREATEARRANGEMENT;

    
























    PROCEDURE VALBASICDATA
    IS
        
        BLEXISTS        BOOLEAN;
        
        TBCONCCONS      PKTBLCONCILIA.TYCONCCONS;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.ExternalCreateProcess.ValBasicData');

        
        PKPAYMENTMGR.VALIDAFECHAPAGO
        (
            DTARRANGEDATE,
            NULL,
            PKERRORS.FSBGETAPPLICATION
        );
        
        IF ( INUREFTYPE = CNUREF_ONE ) THEN
        
            
            BLEXISTS := PKBCCONCILIA.FBLGETAGREEMENTBYBANK
                        (
                            INUENTITY,
                            TRUNC(DTARRANGEDATE),
                            TRUNC(DTARRANGEDATE),
                            TBCONCCONS
                        );
        
        ELSIF ( INUREFTYPE = CNUREF_TWO ) THEN
        
            DTARRANGEDATE := PKENTITYARRANGEMENTMGR.FDTGETPAYARRANGMNTDATE
                             (
                                INUENTITY,
                                ISBENTITYBRANCH,
                                DTARRANGEDATE
                             );
        
            
            BLEXISTS := RC_BCCOLLECTARRAGEMENT.FBLEXISTARRANGEBRANCH
                        (
                            INUENTITY,
                            ISBENTITYBRANCH,
                            TRUNC(DTARRANGEDATE),
                            PKENTITYARRANGEMENTMGR.FNUGETCOMPANY
                        );
        
        END IF;

        
        
        IF ( BLEXISTS ) THEN
        
            ERRORS.SETERROR(CNUEXISTS_PAYARRANGE);
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END VALBASICDATA;

    

















    PROCEDURE VALINPUTDATA
    IS
        
        SBARGUMENT          GE_MESSAGE.DESCRIPTION%TYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.ExternalCreateProcess.ValInputData');

        
        PKBANKMGR.VALBASICDATA(INUENTITY);

        
        IF ( INUREFTYPE = CNUREF_TWO ) THEN
        
            
            PKBRANCHENTITYMGR.VALBASICDATA(INUENTITY,ISBENTITYBRANCH);
        
        END IF;

        
        PKGENERALSERVICES.VALIDATEDATENULLITY(DTARRANGEDATE);

        
        IF ( ISBAUTOMATICCLOSE NOT IN (PKCONSTANTE.SI,PKCONSTANTE.NO) ) THEN
        
            ERRORS.SETERROR(CNUCHECK_AUTO_ARRANGE,CSBTAG_AUTOMATIC_CLOSE);
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END VALINPUTDATA;

BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.ExternalCreateProcess');

    
    DTARRANGEDATE := IDTPAYARRANDATE;

    
    VALINPUTDATA;

    
    VALBASICDATA;

    
    CREATEARRANGEMENT;

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
    	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	
    	PKERRORS.POP;
    	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END EXTERNALCREATEPROCESS;
























    FUNCTION FBLVALPAYMENTDATE
    (
        IDTPAYMENTDATE IN PAGOS.PAGOFEPA%TYPE,
        IDTARRANGEDATE IN CONCILIA.CONCFEPA%TYPE,
        ISBAPPLICATION IN PROCESOS.PROCCODI%TYPE
    )
    RETURN BOOLEAN
    IS
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.fblValPaymentDate');

        



        IF (IDTPAYMENTDATE > SYSDATE AND IDTARRANGEDATE = IDTPAYMENTDATE AND
            ISBAPPLICATION = PKPAYMENTMGR.CSBOS_PAYMENT )THEN
            TD ('RC_BOCollectArragement.fblValPaymentDate FALSE');
            RETURN FALSE;
        ELSE
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END FBLVALPAYMENTDATE;





































PROCEDURE GETARRANGEMENTCODE
(
    INUARRANGECODE          IN      CONCILIA.CONCCONS%TYPE,
    INUENTITY               IN      CONCILIA.CONCBANC%TYPE,
    IDTARRANGEDATE          IN      CONCILIA.CONCFEPA%TYPE,
    INUCOLLECTENTITY        IN      PAGOS.PAGOBANC%TYPE,
    ISBCOLLECTBRANCH        IN      PAGOS.PAGOSUBA%TYPE,
    IDTPAYMENTDATE          IN      PAGOS.PAGOFEPA%TYPE,
    ONUARRANGECODE          OUT NOCOPY  CONCILIA.CONCCONS%TYPE
)
IS
    
    BLSCHEDULE          BOOLEAN;
    
    DTARRANGEDATE       CONCILIA.CONCFEPA%TYPE;
    
    NUARRANGEENTITY     CONCILIA.CONCBANC%TYPE;
    
    RCCONCILIA          CONCILIA%ROWTYPE;

    
    
    

    


















    FUNCTION FNUGETARRANGEMNTBYDATA
    RETURN CONCILIA.CONCCONS%TYPE
    IS
        
        TBARRANGEMENT           PKTBLCONCILIA.TYCONCCONS;
        
        NUARRANGEMENTCODE       CONCILIA.CONCCONS%TYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.GetArrangementCode.fnuGetArrangemntbyData');

        
        TBARRANGEMENT := RC_BCCOLLECTARRAGEMENT.FTBGETARRANGEMNTBYDATA
                         (
                            NUARRANGEENTITY,
                            DTARRANGEDATE,
                            INUCOLLECTENTITY,
                            ISBCOLLECTBRANCH,
                            PKENTITYARRANGEMENTMGR.FNUGETCOMPANY
                         );

        
        IF ( TBARRANGEMENT.COUNT > 1 ) THEN
        
            
            
            ERRORS.SETERROR(CNUEXITSCONCILIA);
            RAISE LOGIN_DENIED;
        
        END IF;

        IF ( TBARRANGEMENT.COUNT > PKBILLCONST.CERO ) THEN
        
            
            NUARRANGEMENTCODE := TBARRANGEMENT(TBARRANGEMENT.FIRST);
        
        END IF;

        PKERRORS.POP;

        
        RETURN ( NUARRANGEMENTCODE );

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
        	RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END FNUGETARRANGEMNTBYDATA;
    
    















































    PROCEDURE GETARRANGEMENTSCHEDULE
    IS
        
        SBARGUMENT          GE_MESSAGE.DESCRIPTION%TYPE;
        
        RCCONCPUPA          RC_CONCPUPA%ROWTYPE;
        
        DTCLOSEHOUR         DATE;
        
        DTCLOSEDATE         CONCILIA.CONCFEPA%TYPE;

        SBAPPLICATION      PROCESOS.PROCCODI%TYPE;
        
        BLVALPAYDATE       BOOLEAN := TRUE;

        
        SBLOCKHANDLER       VARCHAR2(2000);
        
        NUERROR             NUMBER;

    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.GetArrangementCode.GetArrangementSchedule');

        SBAPPLICATION := PKERRORS.FSBGETAPPLICATION;

        
        DTCLOSEHOUR := RC_BCHORACCPP.FDTGETHORABYBANCSUCU(
                                                            INUCOLLECTENTITY,
                                                            ISBCOLLECTBRANCH
                                                         );
        
        
        
        
        
        DTCLOSEDATE := TO_DATE(
                                TO_CHAR(DTARRANGEDATE,CSBDAYS_FORMAT) ||' '||
                                TO_CHAR(DTCLOSEHOUR,CSBHOURS_FORMAT),
                                CSBDATE_FORMAT
                              );

        TD('Fecha de cierre '|| DTCLOSEDATE);
        
        
        IF ( IDTPAYMENTDATE > DTCLOSEDATE ) THEN
        
            
            
            DTARRANGEDATE := DTCLOSEDATE + 1/(3600*24);
        
        END IF;

        TD('Fecha de pago '|| IDTPAYMENTDATE);
        TD('Fecha Concilia '||DTARRANGEDATE);


        

        BLVALPAYDATE := FBLVALPAYMENTDATE( IDTPAYMENTDATE,
                                           DTARRANGEDATE,
                                           SBAPPLICATION
                                          );

        PKPAYMENTMGR.VALIDAFECHAPAGO
        (
            DTARRANGEDATE,
            NULL,
            SBAPPLICATION,
            BLVALPAYDATE 
        );


        
        DTARRANGEDATE := PKENTITYARRANGEMENTMGR.FDTGETPAYARRANGMNTDATE
                         (
                            INUCOLLECTENTITY,
                            ISBCOLLECTBRANCH,
                            DTARRANGEDATE
                         );

        TD('NEW Arrangement Date '||DTARRANGEDATE);

        SBLOCKHANDLER := INUCOLLECTENTITY||'|'||ISBCOLLECTBRANCH||'|'||
                         TO_CHAR(DTARRANGEDATE,'DD-MM-YYYY');

        TD('Lock�s Key '||SBLOCKHANDLER);

        
        UT_LOCK.ALLOCATE_UNIQUE_AT(SBLOCKHANDLER, SBLOCKHANDLER);
        NUERROR := DBMS_LOCK.REQUEST
        (
            LOCKHANDLE        => SBLOCKHANDLER,     
            LOCKMODE          => DBMS_LOCK.X_MODE,  
            RELEASE_ON_COMMIT => TRUE               
        );

        TD('--- Locked Successful! ---');

        
        ONUARRANGECODE := FNUGETARRANGEMNTBYDATA;

        
        IF ( ONUARRANGECODE IS NULL ) THEN
        
            PKENTITYARRANGEMENTMGR.CREATECOLLARRANGEMENT
            (
                NUARRANGEENTITY,
                DTARRANGEDATE,
                PKENTITYARRANGEMENTMGR.CNUINFO_COUPONS,
                PKENTITYARRANGEMENTMGR.CNUINFO_VALUE,
                PKGENERALSERVICES.FSBGETUSERNAME,
                PKENTITYARRANGEMENTMGR.FNUGETCOMPANY,
                ONUARRANGECODE
            );

            
            PKENTITYARRANGEMENTMGR.CREATECONCPUPA
            (
                INUCOLLECTENTITY,
                ISBCOLLECTBRANCH,
                ONUARRANGECODE
            );
        
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END GETARRANGEMENTSCHEDULE;

    



































    PROCEDURE GETARRANGENOTSCHEDULE
    IS
        
        SBLOCKHANDLER       VARCHAR2(2000);
        
        NUERROR             NUMBER;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.GetArrangementCode.GetArrangeNotSchedule');

        IF ( INUARRANGECODE IS NOT NULL ) THEN
        
            
            RCCONCILIA := PKTBLCONCILIA.FRCGETRECORD(INUARRANGECODE);

            ONUARRANGECODE := RCCONCILIA.CONCCONS;
        
        ELSE
        
            
            IF ( RCCONCILIA.CONCCONS IS NULL ) THEN
            
                
                PKPAYMENTMGR.VALIDAFECHAPAGO
                (
                    DTARRANGEDATE,
                    NULL,
                    PKERRORS.FSBGETAPPLICATION
                );
            
            END IF;

            TD('NEW Arrangement Date '||DTARRANGEDATE);

            
            SBLOCKHANDLER := INUENTITY||'|'||TO_CHAR(DTARRANGEDATE,'DD-MM-YYYY');


            TD('Lock�s Key '||SBLOCKHANDLER);

            
            UT_LOCK.ALLOCATE_UNIQUE_AT(SBLOCKHANDLER, SBLOCKHANDLER);

            NUERROR := DBMS_LOCK.REQUEST
            (
                LOCKHANDLE        => SBLOCKHANDLER,     
                LOCKMODE          => DBMS_LOCK.X_MODE,  
                RELEASE_ON_COMMIT => TRUE               
            );

            TD('--- Locked Successful! ---');


            ONUARRANGECODE := PKENTITYARRANGEMENTMGR.FNUCREARUOBTCONCILIACION
                              (
                                INUENTITY,
                                DTARRANGEDATE,
                                PKENTITYARRANGEMENTMGR.CNUINFO_COUPONS,
                                PKENTITYARRANGEMENTMGR.CNUINFO_VALUE,
                                PKGENERALSERVICES.FSBGETUSERNAME
                              );
        

            NUERROR := DBMS_LOCK.RELEASE(SBLOCKHANDLER);

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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END GETARRANGENOTSCHEDULE;
    
    
















    PROCEDURE GETDATA
    IS
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.GetArrangementCode.GetData');

        IF ( INUARRANGECODE IS NOT NULL ) THEN
        
            
            RCCONCILIA := PKTBLCONCILIA.FRCGETRECORD(INUARRANGECODE);
        
        END IF;
        
        
        
        DTARRANGEDATE := NVL(RCCONCILIA.CONCFEPA,IDTARRANGEDATE);
        
        
        
        NUARRANGEENTITY := NVL(RCCONCILIA.CONCBANC,INUENTITY);
        
        
        BLSCHEDULE  := RC_BCHORACCPP.FBLEXIST(INUCOLLECTENTITY,ISBCOLLECTBRANCH);

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
        	RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
        	
        	PKERRORS.POP;
        	RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END GETDATA;
    
    



















    PROCEDURE VALPROCESSARRANGEMENT
    IS
        
        SBARGUMENT          GE_MESSAGE.DESCRIPTION%TYPE;
    BEGIN
    
        PKERRORS.PUSH('RC_BOCollectArragement.GetArrangementCode.ValProcessArrangement');

        
        RCCONCILIA := PKTBLCONCILIA.FRCGETRECORD(ONUARRANGECODE);

        
        PKENTITYARRANGEMENTMGR.VALIDATEISCLOSED(ONUARRANGECODE);

        
        IF ( RCCONCILIA.CONCSIST != PKENTITYARRANGEMENTMGR.FNUGETCOMPANY ) THEN
        
            SBARGUMENT := ONUARRANGECODE|| '|' || RCCONCILIA.CONCSIST
                          || '-' || PKTBLSISTEMA.FSBGETCOMPANYNAME(RCCONCILIA.CONCSIST);

            ERRORS.SETERROR
            (
                CNUARRANGE_NO_COMPANY,
                SBARGUMENT
            );
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    
    END VALPROCESSARRANGEMENT;
    
BEGIN

    PKERRORS.PUSH('RC_BOCollectArragement.GetArrangementCode');
    
    
    GETDATA;

    IF ( BLSCHEDULE ) THEN
    
        
        GETARRANGEMENTSCHEDULE;
    
    ELSE
    
        
        GETARRANGENOTSCHEDULE;
    
    END IF;

    
    VALPROCESSARRANGEMENT;

    PKERRORS.POP;

EXCEPTION
    WHEN LOGIN_DENIED THEN
        PKERRORS.POP;
    	RAISE LOGIN_DENIED;

    WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
    	
    	PKERRORS.POP;
    	RAISE PKCONSTANTE.EXERROR_LEVEL2;

    WHEN OTHERS THEN
    	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);

END GETARRANGEMENTCODE;

    




















    PROCEDURE VALISCASHARRANGEMENT
    (
        INUARRANGEMENT  CONCILIA.CONCCONS%TYPE
    )
    IS
        BLCASHARRANGEMENT   BOOLEAN;

        
        
        CNUCASH_ARRAN CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 901583;

    BEGIN
         PKERRORS.PUSH('RC_BOCollectArragement.ValIsCashArrangement');

         
         BLCASHARRANGEMENT := RC_BCCOLLECTARRAGEMENT.FBLISCASHARRANGEMENT
                                                               (INUARRANGEMENT);

         IF (BLCASHARRANGEMENT) THEN
            ERRORS.SETERROR(CNUCASH_ARRAN);
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
        	PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END VALISCASHARRANGEMENT;

END RC_BOCOLLECTARRAGEMENT;