PACKAGE BODY pkBCNumeAuto AS



























































    
    
    

    
    
    CSBVERSION CONSTANT VARCHAR2(250) := 'SAO209287';
    
    
    SBERRMSG    GE_ERROR_LOG.DESCRIPTION%TYPE;

    
    
    
    
    
    
    
    
    






















FUNCTION FSBVERSION RETURN VARCHAR2 IS
BEGIN

    
    RETURN (CSBVERSION);

END FSBVERSION;

    



























    FUNCTION FNUOBTNUMAUTOPORCRIT
    (
        INUEMPRESA      NUMEAUTO.NUAUSIST%TYPE,
        INUTIPOCOMP     NUMEAUTO.NUAUTICO%TYPE,
        INUTIPOAUTO     NUMEAUTO.NUAUTIAU%TYPE,
        INUPUNTEMIS     NUMEAUTO.NUAUPUEM%TYPE,
        INUTIPOIMPR     NUMEAUTO.NUAUTIIM%TYPE
    )
    RETURN NUMEAUTO.NUAUCONS%TYPE
    IS
        CNUNO_NUMERACION_AUTORIZADA CONSTANT NUMBER := 12173;

        NUNUMEAUTO  NUMEAUTO.NUAUCONS%TYPE;

        CURSOR CUNUMAUTO IS
            SELECT  --+index (numeauto, IX_NUMEAUTO01)
                    NUAUCONS
            FROM    NUMEAUTO
            WHERE   NUAUSIST = INUEMPRESA
            AND     NUAUTICO = INUTIPOCOMP
            AND     NUAUTIAU = INUTIPOAUTO
            AND     NUAUPUEM = INUPUNTEMIS
            AND     NUAUTIIM = INUTIPOIMPR;

    BEGIN
        PKERRORS.PUSH('pkBCNumeAuto.fnuObtNumAutoPorCrit');

        IF ( CUNUMAUTO%ISOPEN ) THEN
            CLOSE CUNUMAUTO;
        END IF;

        OPEN CUNUMAUTO;

        FETCH CUNUMAUTO INTO NUNUMEAUTO;

        IF ( CUNUMAUTO%NOTFOUND ) THEN
            PKERRORS.SETERRORCODE( PKCONSTANTE.CSBDIVISION,
                    			   PKCONSTANTE.CSBMOD_BIL,
                    			   CNUNO_NUMERACION_AUTORIZADA );

            RAISE LOGIN_DENIED;
        END IF;

        CLOSE CUNUMAUTO;

        PKERRORS.POP;

        RETURN NUNUMEAUTO;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            IF (CUNUMAUTO%ISOPEN ) THEN
                CLOSE CUNUMAUTO;
            END IF;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END FNUOBTNUMAUTOPORCRIT;
    
    























    FUNCTION FNUNUMREGISTROSPORCRIT
    (
        INUEMPRESA      NUMEAUTO.NUAUSIST%TYPE,
        INUTIPOCOMP     NUMEAUTO.NUAUTICO%TYPE,
        INUTIPOAUTO     NUMEAUTO.NUAUTIAU%TYPE,
        INUPUNTEMIS     NUMEAUTO.NUAUPUEM%TYPE,
        INUTIPOIMPR     NUMEAUTO.NUAUTIIM%TYPE
    )
    RETURN NUMBER
    IS
        NUNUMREGISTROS  NUMBER;

        CURSOR CUNUMAUTO IS
            SELECT  --+index (numeauto, IX_NUMEAUTO01)
                    COUNT(1)
            FROM    NUMEAUTO
            WHERE   NUAUSIST = INUEMPRESA
            AND     NUAUTICO = INUTIPOCOMP
            AND     NUAUTIAU = INUTIPOAUTO
            AND     NUAUPUEM = INUPUNTEMIS
            AND     NUAUTIIM = INUTIPOIMPR;

    BEGIN
        PKERRORS.PUSH('pkBCNumeAuto.fnuNumRegistrosPorCrit');

        IF ( CUNUMAUTO%ISOPEN ) THEN
            CLOSE CUNUMAUTO;
        END IF;

        OPEN CUNUMAUTO;

        FETCH CUNUMAUTO INTO NUNUMREGISTROS;

        CLOSE CUNUMAUTO;

        PKERRORS.POP;

        RETURN NUNUMREGISTROS;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            PKERRORS.POP;
            IF (CUNUMAUTO%ISOPEN ) THEN
                CLOSE CUNUMAUTO;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            PKERRORS.POP;
            RAISE EX.CONTROLLED_ERROR;
    END FNUNUMREGISTROSPORCRIT;
    
    
































    FUNCTION FTBCODNUMAUTO
    (
        INUEMPRESA      IN  NUMEAUTO.NUAUSIST%TYPE,
        ISBPUNTOVENTA   IN  NUMEAUTO.NUAURESO%TYPE
    )
        RETURN PKTBLNUMEAUTO.TYNUAUCONS
    IS

        
        
        

        
        TBNUAUCONS  PKTBLNUMEAUTO.TYNUAUCONS;

        
        
        

        
        CURSOR CUNUAUCONS
        (
            INUEMPRESA      IN  NUMEAUTO.NUAUSIST%TYPE,
            ISBPUNTOVENTA   IN  NUMEAUTO.NUAURESO%TYPE
        )
        IS
            SELECT  --+ index_asc( numeauto IX_NUMEAUTO01 )
                    NUAUCONS
            FROM    NUMEAUTO
            WHERE   NUAUSIST =    DECODE( INUEMPRESA   ,  -1 , NUAUSIST, INUEMPRESA           )
            AND     NUAURESO LIKE DECODE( ISBPUNTOVENTA, '-1', NUAURESO, ISBPUNTOVENTA || '%' );

    BEGIN

        PKERRORS.PUSH
        (
            'FA_BCNumerAutorizada.ftbCodNumAuto'
        );

        IF( CUNUAUCONS%ISOPEN ) THEN
            CLOSE CUNUAUCONS;
        END IF;

        OPEN    CUNUAUCONS
                (
                    INUEMPRESA   ,
                    ISBPUNTOVENTA
                );

        
        FETCH           CUNUAUCONS
        BULK COLLECT
        INTO            TBNUAUCONS;

        CLOSE CUNUAUCONS;

        PKERRORS.POP;

        RETURN TBNUAUCONS;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            IF( CUNUAUCONS%ISOPEN ) THEN
                CLOSE CUNUAUCONS;
            END IF;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            IF( CUNUAUCONS%ISOPEN ) THEN
                CLOSE CUNUAUCONS;
            END IF;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM               ,
                PKBCNUMEAUTO.SBERRMSG
            );
            PKERRORS.POP;
            IF( CUNUAUCONS%ISOPEN ) THEN
                CLOSE CUNUAUCONS;
            END IF;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                PKBCNUMEAUTO.SBERRMSG
            );
    END;
    
    































    FUNCTION FBLAUTHNUMBYSALESPOINT
    (
        ISBPUNTOVENTA   IN  NUMEAUTO.NUAURESO%TYPE
    )
        RETURN BOOLEAN
    IS

        
        
        

        
        CURSOR CUNUMEAUTO
        (
            ISBPUNTOVENTA   IN  NUMEAUTO.NUAURESO%TYPE
        )
        IS
            SELECT  COUNT( 1 )
            FROM    NUMEAUTO
            WHERE   NUAURESO LIKE ISBPUNTOVENTA || '%';

        
        
        

        
        NUNUMDATOS  NUMBER;
        
        BLHAYDATOS  BOOLEAN;

    BEGIN

        PKERRORS.PUSH
        (
            'pkBCNumeAuto.fblAuthNumBySalesPoint'
        );

        
        NUNUMDATOS := 0;
        BLHAYDATOS := FALSE;

        IF( CUNUMEAUTO%ISOPEN ) THEN
            CLOSE CUNUMEAUTO;
        END IF;

        OPEN    CUNUMEAUTO
                (
                    ISBPUNTOVENTA
                );

        
        FETCH   CUNUMEAUTO
        INTO    NUNUMDATOS;

        
        IF( NUNUMDATOS > 0 ) THEN
            BLHAYDATOS := TRUE;
        END IF;

        CLOSE CUNUMEAUTO;

        PKERRORS.POP;

        RETURN BLHAYDATOS;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            IF( CUNUMEAUTO%ISOPEN ) THEN
                CLOSE CUNUMEAUTO;
            END IF;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            IF( CUNUMEAUTO%ISOPEN ) THEN
                CLOSE CUNUMEAUTO;
            END IF;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR
            (
                PKERRORS.FSBLASTOBJECT,
                SQLERRM               ,
                PKBCNUMEAUTO.SBERRMSG
            );
            PKERRORS.POP;
            IF( CUNUMEAUTO%ISOPEN ) THEN
                CLOSE CUNUMEAUTO;
            END IF;
            RAISE_APPLICATION_ERROR
            (
                PKCONSTANTE.NUERROR_LEVEL2,
                PKBCNUMEAUTO.SBERRMSG
            );
    END FBLAUTHNUMBYSALESPOINT;
    
    
    
    
    
     





















    PROCEDURE GETAUTHNUMBBYVCHERTYPE
    (
        INUTIPOCOMP IN  NUMEAUTO.NUAUTICO%TYPE,
        OTBNUMEAUTO OUT PKTBLNUMEAUTO.TYTBNUMEAUTO
    )
    IS
        
        
        
        CURSOR CUNUMEAUTO
        (
            INUNUAUTICO IN  NUMEAUTO.NUAUTICO%TYPE
        )
        IS
            SELECT  --+index(numeauto, IX_NUMEAUTO04)
                    *
            FROM    NUMEAUTO
            WHERE   NUAUTICO = INUNUAUTICO;
    BEGIN
        PKERRORS.PUSH('pkBCNumeauto.GetAuthNumbByVcherType');

        IF ( CUNUMEAUTO%ISOPEN ) THEN
            CLOSE CUNUMEAUTO;
        END IF;
        
        OPEN CUNUMEAUTO( INUTIPOCOMP);
        
        FETCH CUNUMEAUTO BULK COLLECT INTO OTBNUMEAUTO;
        
        CLOSE CUNUMEAUTO;
        
        PKERRORS.POP;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            PKERRORS.POP;
            IF ( CUNUMEAUTO%ISOPEN ) THEN
                CLOSE CUNUMEAUTO;
            END IF;
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            PKERRORS.POP;
            RAISE EX.CONTROLLED_ERROR;
    END GETAUTHNUMBBYVCHERTYPE;

    




























    PROCEDURE GETAUTHORIZEDNUMBERING
    (
        INUNUAUCONS  IN   NUMEAUTO.NUAUCONS%TYPE,
        INUNUAUPUEM  IN   NUMEAUTO.NUAUPUEM%TYPE,
        INUNUAUTICO  IN   NUMEAUTO.NUAUTICO%TYPE,
        INUNUAUTIIM  IN   NUMEAUTO.NUAUTIIM%TYPE,
        INUNUAUSIST  IN   NUMEAUTO.NUAUSIST%TYPE,
        INUNUAUTIAU  IN   NUMEAUTO.NUAUTIAU%TYPE,
        OCUNUMEAUTO  OUT  PKCONSTANTE.TYREFCURSOR
    )
    IS

    BEGIN
        PKERRORS.PUSH('pkBCNumeAuto.GetAuthorizedNumbering');

        IF ( OCUNUMEAUTO%ISOPEN ) THEN
            CLOSE OCUNUMEAUTO;
        END IF;

        OPEN OCUNUMEAUTO
        FOR
        SELECT  --+index (numeauto, IX_NUMEAUTO01)
                 *
          FROM   NUMEAUTO
         WHERE   NUAUCONS = NVL(INUNUAUCONS,NUAUCONS)
           AND   NUAUSIST = NVL(INUNUAUSIST,NUAUSIST)
           AND   NUAUTICO = NVL(INUNUAUTICO,NUAUTICO)
           AND   NUAUTIAU = NVL(INUNUAUTIAU,NUAUTIAU)
           AND   NUAUPUEM = NVL(INUNUAUPUEM,NUAUPUEM)
           AND   NUAUTIIM = NVL(INUNUAUTIIM,NUAUTIIM);

        PKERRORS.POP;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            IF (OCUNUMEAUTO%ISOPEN ) THEN
                CLOSE OCUNUMEAUTO;
            END IF;
            RAISE LOGIN_DENIED;

        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;

        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END ;
    
    
    






















    FUNCTION FNUOBTNUMAUTOPORCRIT
    (
        INUEMPRESA      NUMEAUTO.NUAUSIST%TYPE,
        INUTIPOCOMP     NUMEAUTO.NUAUTICO%TYPE,
        INUTIPOAUTO     NUMEAUTO.NUAUTIAU%TYPE,
        INUPUNTEMIS     NUMEAUTO.NUAUPUEM%TYPE
    )
    RETURN NUMEAUTO.NUAUCONS%TYPE
    IS
        CNUNO_NUMERACION_AUTORIZADA CONSTANT NUMBER := 12173;

        
        NUNUMEAUTO  NUMEAUTO.NUAUCONS%TYPE;

        CURSOR CUNUMAUTO
        (
            INUEMPRESAVAR  IN  NUMEAUTO.NUAUSIST%TYPE,
            INUTIPOCOMPVAR IN  NUMEAUTO.NUAUTICO%TYPE,
            INUTIPOAUTOVAR IN  NUMEAUTO.NUAUTIAU%TYPE,
            INUPUNTEMISVAR IN  NUMEAUTO.NUAUPUEM%TYPE
        )
        IS
            SELECT  /*+
                        ordered
                        index( NUMEAUTO IX_NUMEAUTO01 )
                        index( TIPOIMPR PK_TIPOIMPR )
                    */
                    NUAUCONS
            FROM    NUMEAUTO, TIPOIMPR
                    
            WHERE   NUMEAUTO.NUAUSIST = INUEMPRESAVAR
            AND     NUMEAUTO.NUAUPUEM = INUPUNTEMISVAR
            AND     NUMEAUTO.NUAUTICO = INUTIPOCOMPVAR
            AND     NUMEAUTO.NUAUTIAU = INUTIPOAUTOVAR
            AND     TIPOIMPR.TIIMCODI = NUMEAUTO.NUAUTIIM
            AND     TIPOIMPR.TIIMCOAU = PKCONSTANTE.NO
            AND     ROWNUM = 1;
            
    BEGIN
        PKERRORS.PUSH('pkBCNumeAuto.fnuObtNumAutoPorCrit');

        
        IF ( CUNUMAUTO%ISOPEN ) THEN
            CLOSE CUNUMAUTO;
        END IF;

        OPEN    CUNUMAUTO
                (
                    INUEMPRESA,
                    INUTIPOCOMP,
                    INUTIPOAUTO,
                    INUPUNTEMIS
                );
                
        FETCH CUNUMAUTO INTO NUNUMEAUTO;

        IF ( CUNUMAUTO%NOTFOUND ) THEN
            PKERRORS.SETERRORCODE(
                PKCONSTANTE.CSBDIVISION,
                PKCONSTANTE.CSBMOD_BIL,
                CNUNO_NUMERACION_AUTORIZADA
            );
            RAISE LOGIN_DENIED;
        END IF;

        CLOSE CUNUMAUTO;

        PKERRORS.POP;

        RETURN NUNUMEAUTO;

    EXCEPTION
        WHEN LOGIN_DENIED THEN
            IF (CUNUMAUTO%ISOPEN ) THEN
                CLOSE CUNUMAUTO;
            END IF;
            PKERRORS.POP;
            RAISE LOGIN_DENIED;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            IF (CUNUMAUTO%ISOPEN ) THEN
                CLOSE CUNUMAUTO;
            END IF;
            
            PKERRORS.POP;
            RAISE PKCONSTANTE.EXERROR_LEVEL2;
        WHEN OTHERS THEN
            IF (CUNUMAUTO%ISOPEN ) THEN
                CLOSE CUNUMAUTO;
            END IF;
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG);
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2,SBERRMSG);
    END FNUOBTNUMAUTOPORCRIT;

END PKBCNUMEAUTO;