
CREATE OR REPLACE PACKAGE BODY GC_BCPRODPRCA IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO191958';
   CNUTRAZA CONSTANT NUMBER := 10;
   CNULIMIT CONSTANT NUMBER := 100;
   SBERRMSG GE_ERROR_LOG.DESCRIPTION%TYPE;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END FSBVERSION;
   FUNCTION FRFGETSALDOPROD( INUSESUNUSE IN SERVSUSC.SESUNUSE%TYPE )
    RETURN PKCONSTANTE.TYREFCURSOR
    IS
      RFPRODUCTS PKCONSTANTE.TYREFCURSOR;
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.frfGetSaldoProd' );
      IF ( RFPRODUCTS%ISOPEN ) THEN
         CLOSE RFPRODUCTS;
      END IF;
      OPEN RFPRODUCTS FOR SELECT  /*+ index (gc_prodprca IDX_GC_PRODPRCA01) */
            prpccons, prpcnuse, prpcsaca, prpcsare, prpcfeca
            FROM gc_prodprca
                 /*+ GC_BCProdprca.frGetProductsbyProject */
            WHERE prpcnuse = inuSesunuse
            AND   nvl(prpcsaca,0)-nvl(prpcsare,0) > 0
            ORDER BY prpcfeca asc;
      PKERRORS.POP;
      RETURN RFPRODUCTS;
    EXCEPTION
      WHEN LOGIN_DENIED OR EX.CONTROLLED_ERROR THEN
         IF ( RFPRODUCTS%ISOPEN ) THEN
            CLOSE RFPRODUCTS;
         END IF;
         PKERRORS.POP;
         RAISE LOGIN_DENIED;
      WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         RAISE PKCONSTANTE.EXERROR_LEVEL2;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BCPRODPRCA.SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BCPRODPRCA.SBERRMSG );
   END FRFGETSALDOPROD;
   PROCEDURE ACTUALIZASALDOSPROD( INUPRPCCONS IN GC_PRODPRCA.PRPCCONS%TYPE, INUPRPCSARE IN GC_PRODPRCA.PRPCSARE%TYPE, INUPPRCNWSR IN GC_PRODPRCA.PRPCSARE%TYPE := 0 )
    IS
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.ActualizaSaldosProd' );
      UPDATE gc_prodprca
               /*+ GC_BCProdprca.ActualizaSaldosProd */
           SET  prpcsare = inuPrpcsare
           /*+  GC_BCProdprca.ActualizaSaldosProd */
        WHERE prpccons = inuPrpccons;
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         RAISE;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, GC_BCPRODPRCA.SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, GC_BCPRODPRCA.SBERRMSG );
   END ACTUALIZASALDOSPROD;
   PROCEDURE GETPUNISHPROJECTSBYPROD( INUPRODUCT IN GC_PRODPRCA.PRPCNUSE%TYPE, OTBPROJECTS OUT NOCOPY DAGC_PRODPRCA.TYTBGC_PRODPRCA )
    IS
      CURSOR CUPUNISHPROJECTS IS
SELECT  /*+
                        index ( gc_prodprca IDX_GC_PRODPRCA01 )
                    */
                    gc_prodprca.*,gc_prodprca.rowid
            FROM    gc_prodprca
                    /*+ GC_BCProdprca.GetPunishProjectsByProd */
            WHERE   gc_prodprca.prpcnuse = inuProduct
            AND     nvl( gc_prodprca.prpcsaca, 0 ) - nvl( gc_prodprca.prpcsare, 0 ) > 0;
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.GetPunishProjectsByProd' );
      UT_TRACE.TRACE( 'INICIO [GC_BCProdprca.GetPunishProjectsByProd]', CNUTRAZA );
      OTBPROJECTS.DELETE;
      IF CUPUNISHPROJECTS%ISOPEN THEN
         CLOSE CUPUNISHPROJECTS;
      END IF;
      OPEN CUPUNISHPROJECTS;
      FETCH CUPUNISHPROJECTS
         BULK COLLECT INTO OTBPROJECTS;
      CLOSE CUPUNISHPROJECTS;
      UT_TRACE.TRACE( 'FIN [GC_BCProdprca.GetPunishProjectsByProd]', CNUTRAZA );
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         PKERRORS.POP;
         IF CUPUNISHPROJECTS%ISOPEN THEN
            CLOSE CUPUNISHPROJECTS;
         END IF;
         RAISE LOGIN_DENIED;
      WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         IF CUPUNISHPROJECTS%ISOPEN THEN
            CLOSE CUPUNISHPROJECTS;
         END IF;
         RAISE PKCONSTANTE.EXERROR_LEVEL2;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         IF CUPUNISHPROJECTS%ISOPEN THEN
            CLOSE CUPUNISHPROJECTS;
         END IF;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END GETPUNISHPROJECTSBYPROD;
   PROCEDURE UPDATEREACTBALBYPRODPOJECT( INUPRODUCT IN GC_PRODPRCA.PRPCNUSE%TYPE, INUPUNISHPROJECT IN GC_PRODPRCA.PRPCPRCA%TYPE, INUREACTVALUE IN GC_PRODPRCA.PRPCSARE%TYPE )
    IS
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.UpdateReactBalByProdPoject' );
      UT_TRACE.TRACE( 'INICIO [GC_BCProdprca.UpdateReactBalByProdPoject]', CNUTRAZA );
      UPDATE  /*+
                    index ( gc_prodprca IDX_GC_PRODPRCA01 )
                */
                gc_prodprca
                /*+ GC_BCProdprca.UpdateReactBalByProdPoject */
        SET     gc_prodprca.prpcsare = nvl( gc_prodprca.prpcsare, 0 ) + inuReactValue
        WHERE   gc_prodprca.prpcnuse = inuProduct
        AND     gc_prodprca.prpcprca = inuPunishProject;
      UT_TRACE.TRACE( 'FIN [GC_BCProdprca.UpdateReactBalByProdPoject]', CNUTRAZA );
      PKERRORS.POP;
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
   END UPDATEREACTBALBYPRODPOJECT;
   FUNCTION FNUGETSUBSBYPOJECTTHREAD( INUPROJECT IN GC_PRODPRCA.PRPCPRCA%TYPE, INUTOTALTHREADS IN NUMBER, INUTHREAD IN NUMBER )
    RETURN NUMBER
    IS
      NUTOTALSUBSCRIBERS NUMBER := 0;
      CURSOR CUSUBSCRIBERS IS
SELECT  /*+
                        index ( gc_prodprca IDX_GC_PRODPRCA04 )
                    */
                    count ( prpcsusc )
            FROM    gc_prodprca
                    /*+ GC_BCProdprca.fnuGetSubsByPojectThread */
            WHERE   prpcprca = inuProject
            AND     prpcfeex IS NULL
            AND     prpcfeca IS NULL
            AND     MOD ( prpcsusc, inuTotalThreads ) + 1 = inuThread;
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.fnuGetSubsByPojectThread' );
      UT_TRACE.TRACE( 'INICIO [GC_BCProdprca.fnuGetSubsByPojectThread]', CNUTRAZA );
      IF CUSUBSCRIBERS%ISOPEN THEN
         CLOSE CUSUBSCRIBERS;
      END IF;
      OPEN CUSUBSCRIBERS;
      FETCH CUSUBSCRIBERS
         INTO NUTOTALSUBSCRIBERS;
      CLOSE CUSUBSCRIBERS;
      UT_TRACE.TRACE( 'FIN [GC_BCProdprca.fnuGetSubsByPojectThread]', CNUTRAZA );
      PKERRORS.POP;
      RETURN NUTOTALSUBSCRIBERS;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.POP;
         RAISE LOGIN_DENIED;
      WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.POP;
         RAISE PKCONSTANTE.EXERROR_LEVEL2;
      WHEN OTHERS THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END FNUGETSUBSBYPOJECTTHREAD;
   PROCEDURE GETPRODUCTSBYSUBSCRIPTION( INUPROJECT IN GC_PRODPRCA.PRPCPRCA%TYPE, INUPIVOT IN GC_PRODPRCA.PRPCSUSC%TYPE, INUTOTALTHREADS IN NUMBER, INUTHREAD IN NUMBER, OTBSUBSCRIPTIONS OUT DAGC_PRODPRCA.TYTBGC_PRODPRCA )
    IS
      CURSOR CUSUBSCRIBERS IS
SELECT  /*+
                        index_asc ( gc_prodprca IDX_GC_PRODPRCA04 )
                    */
                    gc_prodprca.*, gc_prodprca.rowid
            FROM    gc_prodprca
                    /*+ GC_BCProdprca.fnuGetSubsByPojectThread */
            WHERE   prpcprca = inuProject
            AND     prpcsusc > inuPivot
            AND     prpcfeex IS NULL
            AND     prpcfeca IS NULL
            AND     MOD ( prpcsusc, inuTotalThreads ) + 1 = inuThread;
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.GetProductsBySubscription' );
      UT_TRACE.TRACE( 'INICIO [GC_BCProdprca.GetProductsBySubscription]', CNUTRAZA );
      IF CUSUBSCRIBERS%ISOPEN THEN
         CLOSE CUSUBSCRIBERS;
      END IF;
      OPEN CUSUBSCRIBERS;
      FETCH CUSUBSCRIBERS
         BULK COLLECT INTO OTBSUBSCRIPTIONS
         LIMIT CNULIMIT;
      CLOSE CUSUBSCRIBERS;
      UT_TRACE.TRACE( 'FIN [GC_BCProdprca.GetProductsBySubscription]', CNUTRAZA );
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.POP;
         RAISE LOGIN_DENIED;
      WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.POP;
         RAISE PKCONSTANTE.EXERROR_LEVEL2;
      WHEN OTHERS THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END GETPRODUCTSBYSUBSCRIPTION;
   PROCEDURE GETSUBSCRIPTIONTOPROCESS( INUPROJECT IN GC_PRODPRCA.PRPCPRCA%TYPE, INUSUBSCRIPTION IN GC_PRODPRCA.PRPCSUSC%TYPE, OTBSUBSCRIPTIONS OUT DAGC_PRODPRCA.TYTBGC_PRODPRCA )
    IS
      CURSOR CUSUBSCRIBERS IS
SELECT  /*+
                        index_asc ( gc_prodprca IDX_GC_PRODPRCA04 )
                    */
                    gc_prodprca.*, gc_prodprca.rowid
            FROM    gc_prodprca
                    /*+ GC_BCProdprca.GetSubscriptionToProcess */
            WHERE   prpcprca = inuProject
            AND     prpcsusc = inuSubscription
            AND     prpcfeex IS NULL
            AND     prpcfeca IS NULL;
    BEGIN
      PKERRORS.PUSH( 'GC_BCProdprca.GetSubscriptionToProcess' );
      UT_TRACE.TRACE( 'INICIO [GC_BCProdprca.GetSubscriptionToProcess]', CNUTRAZA );
      IF CUSUBSCRIBERS%ISOPEN THEN
         CLOSE CUSUBSCRIBERS;
      END IF;
      OPEN CUSUBSCRIBERS;
      FETCH CUSUBSCRIBERS
         BULK COLLECT INTO OTBSUBSCRIPTIONS;
      CLOSE CUSUBSCRIBERS;
      UT_TRACE.TRACE( 'FIN [GC_BCProdprca.GetSubscriptionToProcess]', CNUTRAZA );
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.POP;
         RAISE LOGIN_DENIED;
      WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.POP;
         RAISE PKCONSTANTE.EXERROR_LEVEL2;
      WHEN OTHERS THEN
         IF CUSUBSCRIBERS%ISOPEN THEN
            CLOSE CUSUBSCRIBERS;
         END IF;
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END GETSUBSCRIPTIONTOPROCESS;
END GC_BCPRODPRCA;
/

