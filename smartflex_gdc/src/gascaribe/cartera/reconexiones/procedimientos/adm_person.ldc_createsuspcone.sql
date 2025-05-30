/**************************************************************************
    Propiedad Intelectual de Gas Caribe
    Procedure   :  ldc_createsuspcone

    Historia de Modificaciones
    Fecha       Autor               	Modificacion
    ==========	=================== 	====================================================================
    17-07-2013  cgonzalez (Horbath)     OSF-923: Se ajusta para que la fecha de atencion se cree con valor nulo
**************************************************************************/
create or replace PROCEDURE ADM_PERSON.LDC_CREATESUSPCONE
(
  INUSUSPIDSC    IN    SUSPCONE.SUCOIDSC%TYPE,
  INUDEPAORDE    IN    SUSPCONE.SUCODEPA%TYPE,
  INULOCAORDE    IN    SUSPCONE.SUCOLOCA%TYPE,
  INUNUMEORDE    IN    SUSPCONE.SUCONUOR%TYPE,
  INUEVENAPLI    IN    CONFESCO.COECCODI%TYPE,
  INUCAUSDESC    IN    SUSPCONE.SUCOCACD%TYPE,
  ISBSUCOTIPO    IN    SUSPCONE.SUCOTIPO%TYPE,
  ISBOBSERVAC    IN    SUSPCONE.SUCOOBSE%TYPE,
  IRCSERVSUSC    IN    SERVSUSC%ROWTYPE,
  INUCICLO       IN    SUSCRIPC.SUSCCICL%TYPE,
  INUORDER_ACTIVITY_ID IN OR_ORDER_ACTIVITY.ORDER_ACTIVITY_ID%TYPE
)
IS
    
    RCSUSPCONE      SUSPCONE%ROWTYPE;
    SBERRMSG varchar2(3000);
BEGIN
    
    UT_TRACE.TRACE( 'Inicio: [pkSuspConnServiceMgr.CreateSuspConne]', 5 );
    
    
    RCSUSPCONE.SUCOIDSC := INUSUSPIDSC;
    RCSUSPCONE.SUCODEPA := INUDEPAORDE;
    RCSUSPCONE.SUCOLOCA := INULOCAORDE;
    RCSUSPCONE.SUCONUOR := INUNUMEORDE;
    RCSUSPCONE.SUCOSUSC := IRCSERVSUSC.SESUSUSC;
    RCSUSPCONE.SUCOSERV := IRCSERVSUSC.SESUSERV;
    RCSUSPCONE.SUCONUSE := IRCSERVSUSC.SESUNUSE;
    RCSUSPCONE.SUCOTIPO := ISBSUCOTIPO;
    RCSUSPCONE.SUCOFEOR := SYSDATE;
    RCSUSPCONE.SUCOCACD := INUCAUSDESC;
    RCSUSPCONE.SUCOOBSE := ISBOBSERVAC;
    RCSUSPCONE.SUCOCOEC := INUEVENAPLI;
    RCSUSPCONE.SUCOCICL := INUCICLO;
    RCSUSPCONE.SUCOORIM := PKCONSTANTE.NO;
    RCSUSPCONE.SUCOPROG := PKERRORS.FSBGETAPPLICATION;
    RCSUSPCONE.SUCOTERM := PKGENERALSERVICES.FSBGETTERMINAL;
    RCSUSPCONE.SUCOUSUA := PKGENERALSERVICES.FSBGETUSERNAME;
    RCSUSPCONE.SUCOFEAT := null;
    RCSUSPCONE.SUCOCUPO := null;
    RCSUSPCONE.SUCOACTIV_ID:=INUORDER_ACTIVITY_ID;
    
   
    
    IF ( PKACCREIVADVANCEMGR.GNUACTIVITYCONS IS NOT NULL ) THEN
    
        RCSUSPCONE.SUCOACGC := PKACCREIVADVANCEMGR.GNUACTIVITYCONS;
    
    END IF;

    
    PKTBLSUSPCONE.INSRECORD( RCSUSPCONE );
    
    UT_TRACE.TRACE( 'Fin: [pkSuspConnServiceMgr.CreateSuspConne]', 5 );
    
EXCEPTION

    WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        UT_TRACE.TRACE( 'Error: [pkSuspConnServiceMgr.CreateSuspConne]', 5 );
      RAISE;

    WHEN OTHERS THEN
      PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        UT_TRACE.TRACE( 'Error: [pkSuspConnServiceMgr.CreateSuspConne]', 5 );
      RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );

END;
/
BEGIN
    pkg_utilidades.prAplicarPermisos('LDC_CREATESUSPCONE', 'ADM_PERSON');
END;
/
GRANT EXECUTE ON ADM_PERSON.LDC_CREATESUSPCONE TO REXEREPORTES;
/