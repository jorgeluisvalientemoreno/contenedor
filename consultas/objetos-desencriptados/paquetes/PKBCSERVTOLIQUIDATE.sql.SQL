
CREATE OR REPLACE PACKAGE PKBCSERVTOLIQUIDATE IS
   FUNCTION FSBVERSION
    RETURN VARCHAR2;
   FUNCTION FBLSERVBYCYCLE( INUCICLO IN CICLO.CICLCODI%TYPE )
    RETURN BOOLEAN;
   PROCEDURE GETSERVTOLIQARR( INUCICLO IN CICLO.CICLCODI%TYPE, OTBSERVLIQ OUT PKTBLSERVICIO.TYSERVCODI );
   PROCEDURE GETCOMPANYSERVTOLIQ( INUEMPRESA IN EMPRPRSE.EMPSCODI%TYPE, OTBSERVLIQ OUT PKTBLSERVICIO.TYSERVCODI );
   PROCEDURE CONSULTASERVLIQXCICLO( ISBROWID IN VARCHAR2, OCUCURSOR OUT CONSTANTS.TYREFCURSOR );
   PROCEDURE CONSULTASERVSLIQXCICLO( INUSLCICICL IN SELICICL.SLCICICL%TYPE, OCUCURSOR OUT CONSTANTS.TYREFCURSOR );
   PROCEDURE CICLODETIPOSERVLIQ( ISBKEY IN VARCHAR2, ONUCICLCODI OUT SELICICL.SLCICICL%TYPE );
END PKBCSERVTOLIQUIDATE;
/


CREATE OR REPLACE PACKAGE BODY PKBCSERVTOLIQUIDATE IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO96874';
   SBERRMSG GE_ERROR_LOG.DESCRIPTION%TYPE;
   BLISLOADED BOOLEAN := FALSE;
   SBATRSERVTOLIQUIDATE VARCHAR2( 5000 );
   CURSOR CUSELICICL( NUCICLO IN CICLO.CICLCODI%TYPE ) IS
SELECT slciserv
    FROM selicicl
    WHERE slcicicl = nuCiclo
    ORDER BY slciserv;
   CURSOR CUSERVICIO IS
SELECT servcodi
    FROM servicio
    WHERE servliqu = 'S'
    ORDER BY servcodi ;
   CURSOR CUSERVEMPR( NUEMPRESA IN EMPRPRSE.EMPSCODI%TYPE ) IS
SELECT sepsserv
    FROM seemprse
    WHERE sepssist = nuEmpresa
    ORDER BY sepsserv;
   PROCEDURE GETSERVTOLIQARR( INUCICLO IN CICLO.CICLCODI%TYPE, OTBSERVLIQ OUT PKTBLSERVICIO.TYSERVCODI )
    IS
      TBSERVLIQ PKTBLSERVICIO.TYSERVCODI;
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.GetServToLiqArr' );
      OTBSERVLIQ.DELETE;
      IF ( FBLSERVBYCYCLE( INUCICLO ) ) THEN
         IF ( CUSELICICL%ISOPEN ) THEN
            CLOSE CUSELICICL;
         END IF;
         OPEN CUSELICICL( INUCICLO );
         FETCH CUSELICICL
            BULK COLLECT INTO TBSERVLIQ;
         CLOSE CUSELICICL;
       ELSE
         IF ( CUSERVICIO%ISOPEN ) THEN
            CLOSE CUSERVICIO;
         END IF;
         OPEN CUSERVICIO;
         FETCH CUSERVICIO
            BULK COLLECT INTO TBSERVLIQ;
         CLOSE CUSERVICIO;
      END IF;
      OTBSERVLIQ := TBSERVLIQ;
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
   END GETSERVTOLIQARR;
   FUNCTION FBLSERVBYCYCLE( INUCICLO IN CICLO.CICLCODI%TYPE )
    RETURN BOOLEAN
    IS
      NUSERV SERVICIO.SERVCODI%TYPE;
      BLCONF BOOLEAN;
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.fblServByCycle' );
      IF ( CUSELICICL%ISOPEN ) THEN
         CLOSE CUSELICICL;
      END IF;
      BLCONF := FALSE;
      OPEN CUSELICICL( INUCICLO );
      FETCH CUSELICICL
         INTO NUSERV;
      IF ( CUSELICICL%FOUND ) THEN
         BLCONF := TRUE;
      END IF;
      CLOSE CUSELICICL;
      PKERRORS.POP;
      RETURN ( BLCONF );
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
   END FBLSERVBYCYCLE;
   PROCEDURE GETCOMPANYSERVTOLIQ( INUEMPRESA IN EMPRPRSE.EMPSCODI%TYPE, OTBSERVLIQ OUT PKTBLSERVICIO.TYSERVCODI )
    IS
      TBSERVLIQ PKTBLSERVICIO.TYSERVCODI;
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.GetCompanyServToLiq' );
      OTBSERVLIQ.DELETE;
      IF ( CUSERVEMPR%ISOPEN ) THEN
         CLOSE CUSERVEMPR;
      END IF;
      OPEN CUSERVEMPR( INUEMPRESA );
      FETCH CUSERVEMPR
         BULK COLLECT INTO TBSERVLIQ;
      CLOSE CUSERVEMPR;
      OTBSERVLIQ := TBSERVLIQ;
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
   END GETCOMPANYSERVTOLIQ;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN ( CSBVERSION );
   END FSBVERSION;
   PROCEDURE LLENAATRSERVTOLIQUXCICLO
    IS
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.LlenaAtrServToLiquXCiclo' );
      IF SBATRSERVTOLIQUIDATE IS NOT NULL THEN
         PKERRORS.POP;
         RETURN;
      END IF;
      SBATRSERVTOLIQUIDATE := 'chartorowid(rowid) Key,' || CHR( 10 ) || 'slciserv tipo_producto,' || CHR( 10 ) || '(select servdesc FROM servicio WHERE servcodi=slciserv) desc_tipo_producto,' || CHR( 10 ) || 'slcicicl Padre_ID';
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         RAISE;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END LLENAATRSERVTOLIQUXCICLO;
   PROCEDURE CONSULTASERVLIQXCICLO( ISBROWID IN VARCHAR2, OCUCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      SBSQL VARCHAR2( 5000 );
      NUROWID ROWID;
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.ConsultaServLiqXCiclo' );
      IF ( OCUCURSOR%ISOPEN ) THEN
         CLOSE OCUCURSOR;
      END IF;
      IF ISBROWID IS NOT NULL THEN
         NUROWID := CHARTOROWID( ISBROWID );
      END IF;
      LLENAATRSERVTOLIQUXCICLO;
      SBSQL := ' SELECT ' || CHR( 10 ) || SBATRSERVTOLIQUIDATE || CHR( 10 ) || ' FROM SELICICL ' || CHR( 10 ) || ' WHERE rowid = :nuRowid ';
      OPEN OCUCURSOR
           FOR SBSQL
           USING IN NUROWID;
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         RAISE;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END CONSULTASERVLIQXCICLO;
   PROCEDURE CONSULTASERVSLIQXCICLO( INUSLCICICL IN SELICICL.SLCICICL%TYPE, OCUCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      SBSQL VARCHAR2( 5000 );
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.ConsultaServsLiqXCiclo' );
      IF ( OCUCURSOR%ISOPEN ) THEN
         CLOSE OCUCURSOR;
      END IF;
      LLENAATRSERVTOLIQUXCICLO;
      SBSQL := ' SELECT ' || CHR( 10 ) || SBATRSERVTOLIQUIDATE || CHR( 10 ) || ' FROM SELICICL ' || CHR( 10 ) || ' WHERE slcicicl = :nuslcicicl ';
      OPEN OCUCURSOR
           FOR SBSQL
           USING IN INUSLCICICL;
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         RAISE;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END CONSULTASERVSLIQXCICLO;
   PROCEDURE CICLODETIPOSERVLIQ( ISBKEY IN VARCHAR2, ONUCICLCODI OUT SELICICL.SLCICICL%TYPE )
    IS
    BEGIN
      PKERRORS.PUSH( 'pkBCServToLiquidate.CicloDeTipoServLiq' );
      IF ISBKEY IS NULL THEN
         ONUCICLCODI := NULL;
         PKERRORS.POP;
         RETURN;
      END IF;
      SELECT slcicicl
    INTO   onuciclcodi
    FROM   SELICICL
    WHERE  rowid=chartorowid(isbkey);
      PKERRORS.POP;
    EXCEPTION
      WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
         PKERRORS.POP;
         RAISE;
      WHEN OTHERS THEN
         PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
         PKERRORS.POP;
         RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
   END CICLODETIPOSERVLIQ;
END PKBCSERVTOLIQUIDATE;
/


