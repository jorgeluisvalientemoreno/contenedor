PACKAGE BODY pkAssocServSubsAgroupMgr AS





































    
    
    
    
    
    
    SBERRMSG        GE_ERROR_LOG.DESCRIPTION%TYPE;         
    GSBAPPLICATION	GE_ERROR_LOG.APPLICATION%TYPE;
    
    
    
    
    
    CSBVERSION       CONSTANT VARCHAR2(250):= 'SAO214409';
    
    CNUNUM_AGROUP	 MENSAJE.MENSCODI%TYPE := 11051;	
    CNUSEPARACION	 NUMBER := 1;			
    CNUTEMPORAL  	 NUMBER := 2;			
    CNUSUSCAGRUPADA	 MENSAJE.MENSCODI%TYPE := 11052; 
    CNUCICLO_AGROUP	 MENSAJE.MENSCODI%TYPE := 11053; 
    CNUSUSCRIPCIONES MENSAJE.MENSCODI%TYPE := 11054; 
    CNUSUSC_AGROUP	 MENSAJE.MENSCODI%TYPE := 11055;	
    CSBSUSC_AGROUP	 VARCHAR2(10) := '<SUSCRIPC>';
    CNUTOPE_GRUPO_TEMPORAL	CONSTANT NUMBER  := 100;
    CNURECDS_MAX_READ       CONSTANT NUMBER := 100 ;    
    CSBPROG_GEN_CTAS	    CONSTANT VARCHAR(4) := 'FGCC';
    CNUGRUPO_DEFAULT	    CONSTANT NUMBER  := 99;
    GSBPROG_IMPRESION	    VARCHAR(4) := NULL;
	
	
    CNUSUSC_ASOCIADA	CONSTANT NUMBER := 12065;
    
    
    
    PROCEDURE  VALIDCYCLESUBSCRIBER
    (
	 INUSUSCASOC   IN   SESUASOC.SSASSUSC%TYPE,
	 INUSUSCRIPC   IN   SESUASOC.SSASSUSC%TYPE
    ) ;





















PROCEDURE  VALIDCYCLESUBSCRIBER
(
     INUSUSCASOC   IN	SESUASOC.SSASSUSC%TYPE,
     INUSUSCRIPC   IN	SESUASOC.SSASSUSC%TYPE
)
IS
  NUCYCLESUSC		SUSCRIPC.SUSCCICL%TYPE; 		
  NUCYCLEASOC		SUSCRIPC.SUSCCICL%TYPE;			
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidCycleSubscriber');
    NUCYCLEASOC := PKTBLSUSCRIPC.FNUGETBILLINGCYCLE ( INUSUSCASOC );
    NUCYCLESUSC := PKTBLSUSCRIPC.FNUGETBILLINGCYCLE ( INUSUSCRIPC );
    IF ( NUCYCLESUSC <> NUCYCLEASOC ) THEN
	PKERRORS.SETERRORCODE (
				PKCONSTANTE.CSBDIVISION,
				PKCONSTANTE.CSBMOD_BIL,
				CNUCICLO_AGROUP
			      ) ;
	RAISE LOGIN_DENIED;
    END IF ;
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
END VALIDCYCLESUBSCRIBER;



















PROCEDURE  VALIDSUBSINGROUPING
(
     INUSUSCRIPC   IN	SESUASOC.SSASSUSC%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidSubsInGrouping');
    
    
    IF (NOT PKASSOCSERVSUBSAGROUPMGR.FBLISINVALID ( INUSUSCRIPC )) THEN
	PKERRORS.SETERRORCODE	(
				    PKCONSTANTE.CSBDIVISION,
				    PKCONSTANTE.CSBMOD_BIL,
				    CNUSUSCAGRUPADA
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
	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
    	PKERRORS.POP;
	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
END VALIDSUBSINGROUPING;


















PROCEDURE VALIDATEEXISTGROUPING
(
    INUSERVSUSC     IN      SESUASOC.SSASSESU%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidateExistGrouping');
    
    PKTBLSESUASOC.VALIDATEDUPVALUES (INUSERVSUSC, PKCONSTANTE.NOCACHE);
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
END VALIDATEEXISTGROUPING;



















PROCEDURE VALIDATEGROUPNUMBER
(
    INUGRUPNUMBER	IN	SESUASOC.SSASCONS%TYPE,
    INURANGE		IN	NUMBER
)
IS
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidateGroupNumber');
    
    IF ( ( INUGRUPNUMBER BETWEEN 1 AND 98 ) AND
 	 ( INURANGE = CNUSEPARACION ) ) THEN
	PKERRORS.POP;
	RETURN;
    END IF;
    
    
    IF ( ( INUGRUPNUMBER BETWEEN 1 AND 9 ) AND
	 ( INURANGE = CNUTEMPORAL) ) THEN
	PKERRORS.POP;
	RETURN;
    END IF;
    
    PKERRORS.SETERRORCODE (
				PKCONSTANTE.CSBDIVISION,
				PKCONSTANTE.CSBMOD_BIL,
				CNUNUM_AGROUP
			  );
    RAISE LOGIN_DENIED;
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
END VALIDATEGROUPNUMBER;




















PROCEDURE VALIDATEGROUPING
(
    INUSUSCRIPC     IN      SESUASOC.SSASSUSC%TYPE,
    INUSERVSUSC     IN      SESUASOC.SSASSESU%TYPE
)
IS
    RCREGISTRO SESUASOC%ROWTYPE;
    SBMSG  MENSAJE.MENSDESC%TYPE;
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidateGrouping');
    
    IF (PKTBLSESUASOC.FBLEXIST (INUSERVSUSC,PKCONSTANTE.NOCACHE)) THEN
	RCREGISTRO := PKTBLSESUASOC.FRCGETRECORD (INUSERVSUSC);
	IF ( RCREGISTRO.SSASSUSC <> INUSUSCRIPC ) THEN
	    
	    PKERRORS.SETERRORCODE (
					PKCONSTANTE.CSBDIVISION,
					PKCONSTANTE.CSBMOD_BIL,
					CNUSUSC_AGROUP
				  );
	    PKERRORS.CHANGEMESSAGE (
					CSBSUSC_AGROUP,
					TO_CHAR ( RCREGISTRO.SSASSUSC )
				   );
	    RAISE LOGIN_DENIED;
	END IF;
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
	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
    	PKERRORS.POP;
	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
END VALIDATEGROUPING;



















PROCEDURE  VALIDATESUBSCRIBERS
(
     INUSUSCASOC   IN	SESUASOC.SSASSUSC%TYPE,
     INUSUSCRIPC   IN	SESUASOC.SSASSUSC%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidateSubscribers');
    IF ( INUSUSCASOC = INUSUSCRIPC ) THEN
	PKERRORS.SETERRORCODE (
				PKCONSTANTE.CSBDIVISION,
				PKCONSTANTE.CSBMOD_BIL,
				CNUSUSCRIPCIONES
			      ) ;
	RAISE LOGIN_DENIED;
    END IF ;
    
    VALIDCYCLESUBSCRIBER (
			    INUSUSCASOC,
			    INUSUSCRIPC
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
	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
    	PKERRORS.POP;
	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
END VALIDATESUBSCRIBERS;




















FUNCTION FBLISINVALID
(
    INUSUSCRIPC     IN      SESUASOC.SSASSUSC%TYPE
)
RETURN BOOLEAN IS
    NUCOUNT NUMBER;
    CURSOR CUSUSCSESU IS
	SELECT  COUNT(*) FROM VWSUSCAGROUP
	WHERE SESUSUSC = INUSUSCRIPC
	  AND SSASCONS < 100;
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.fblIsInvalid');
    OPEN CUSUSCSESU;
    FETCH CUSUSCSESU INTO NUCOUNT;
    CLOSE CUSUSCSESU;
    
    IF (NUCOUNT > 0) THEN
	PKERRORS.POP;
	RETURN FALSE;
    END IF;
    
    PKERRORS.POP;
    RETURN TRUE;
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
END FBLISINVALID;































FUNCTION FBLISASSOCIATED
    (
	INUSUSC		IN	SUSCRIPC.SUSCCODI%TYPE
    )
RETURN BOOLEAN IS
    
    
    
    
    
    
    NURECORDS	NUMBER; 
    
    
    
    
    
    CURSOR CUSESUASOC (	INUSUSCCODI IN	SUSCRIPC.SUSCCODI%TYPE ) IS
        SELECT 1
        FROM   SESUASOC
        WHERE  SSASSUSC = INUSUSCCODI
        AND    ROWNUM = 1;

BEGIN

    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.fblIsAssociated');

    
    OPEN CUSESUASOC( INUSUSC );
    FETCH CUSESUASOC INTO NURECORDS;

    IF ( CUSESUASOC%NOTFOUND ) THEN
        NURECORDS := 0;
    END IF;

    CLOSE CUSESUASOC;

    PKERRORS.POP;

    
    RETURN ( NURECORDS > 0 );

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
END FBLISASSOCIATED;
    




















    FUNCTION FBLHASASSOCIATION
    (
	INUSESUHIJO	IN	SESUASOC.SSASSESU%TYPE
    )
    RETURN BOOLEAN
    IS
	
	
	CURSOR CUAGRUPACIONVIGENTE
	    (
		INUSESUCHILD	SESUASOC.SSASSESU%TYPE
	    )
	IS
	SELECT SESUSUSC
	FROM   VWSUSCAGROUP
	WHERE  SESUNUSE = INUSESUCHILD ;
	
	NUSUSCPARENT	SESUASOC.SSASSUSC%TYPE;
    BEGIN
    
	PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.fblHasAssociation');
	
	
	OPEN CUAGRUPACIONVIGENTE (INUSESUHIJO) ;
	FETCH CUAGRUPACIONVIGENTE INTO NUSUSCPARENT ;
	
	IF (CUAGRUPACIONVIGENTE%FOUND) THEN
	    CLOSE CUAGRUPACIONVIGENTE;
	    PKERRORS.POP;
	    RETURN (TRUE);
	END IF;
	
	CLOSE CUAGRUPACIONVIGENTE;
	PKERRORS.POP;
	RETURN (FALSE);
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
    
    END FBLHASASSOCIATION;
    


















    PROCEDURE VALHASASSOCIATION
    (
	INUSESUHIJO	IN	SESUASOC.SSASSESU%TYPE
    )
    IS
	
	
	CNUHAS_ASSOCIATION	CONSTANT NUMBER := 10226 ;
    BEGIN
    
	PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.ValHasAssociation');
	
	IF (FBLHASASSOCIATION (INUSESUHIJO)) THEN
	    PKERRORS.SETERRORCODE
		(
		    PKCONSTANTE.CSBDIVISION,
		    PKCONSTANTE.CSBMOD_BIL,
		    CNUHAS_ASSOCIATION
		);
	    RAISE LOGIN_DENIED ;
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
	    PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
	    PKERRORS.POP;
	    RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END VALHASASSOCIATION;
    



















    FUNCTION FBLISGROUPCHILD
    (
	INUSUSCHIJO	IN	SUSCRIPC.SUSCCODI%TYPE
    )
    RETURN BOOLEAN
    IS
	
	
	CURSOR CUGROUPCHILD
	    (
		INUSUSC	SUSCRIPC.SUSCCODI%TYPE
	    )
	IS
	SELECT SESUSUSC
	FROM   VWSUSCAGROUP
	WHERE  SESUSUSC = INUSUSC ;
	
	NUSUSCPARENT	SESUASOC.SSASSUSC%TYPE;
    BEGIN
    
	PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.fblIsGroupChild');
	
	
	OPEN CUGROUPCHILD (INUSUSCHIJO) ;
	FETCH CUGROUPCHILD INTO NUSUSCPARENT ;
	
	IF (CUGROUPCHILD%FOUND) THEN
	    CLOSE CUGROUPCHILD;
	    PKERRORS.POP;
	    RETURN (TRUE);
	END IF;
	
	CLOSE CUGROUPCHILD;
	PKERRORS.POP;
	RETURN (FALSE);
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
    
    END FBLISGROUPCHILD;
    


















    PROCEDURE VALISNOTGROUPCHILD
    (
	INUSUSCHIJO	IN	SUSCRIPC.SUSCCODI%TYPE
    )
    IS
	
	
	CNUSUSC_AGRUPADA	CONSTANT NUMBER := 10164 ;
    BEGIN
    
	PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.ValIsNotGroupChild');
	
	IF (FBLISGROUPCHILD (INUSUSCHIJO)) THEN
	    PKERRORS.SETERRORCODE
		(
		    PKCONSTANTE.CSBDIVISION,
		    PKCONSTANTE.CSBMOD_BIL,
		    CNUSUSC_AGRUPADA
		);
	    RAISE LOGIN_DENIED ;
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
	    PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
	    PKERRORS.POP;
	    RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END VALISNOTGROUPCHILD;
    



















    FUNCTION FBLISGROUPPARENT
    (
	INUSUSCPADRE	IN	SUSCRIPC.SUSCCODI%TYPE
    )
    RETURN BOOLEAN
    IS
	
	
	CURSOR CUGROUPPARENT
	    (
		INUSUSC	SUSCRIPC.SUSCCODI%TYPE
	    )
	IS
	SELECT SESUSUSC
	FROM   VWSUSCAGROUP
	WHERE  SSASSUSC = INUSUSC ;
	
	NUSUSCPARENT	SESUASOC.SSASSUSC%TYPE;
    BEGIN
    
	PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.fblIsGroupParent');
	
	
	OPEN CUGROUPPARENT (INUSUSCPADRE) ;
	FETCH CUGROUPPARENT INTO NUSUSCPARENT ;
	
	IF (CUGROUPPARENT%FOUND) THEN
	    CLOSE CUGROUPPARENT;
	    PKERRORS.POP;
	    RETURN (TRUE);
	END IF;
	
	CLOSE CUGROUPPARENT;
	PKERRORS.POP;
	RETURN (FALSE);
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
    
    END FBLISGROUPPARENT;
    


















    PROCEDURE VALISNOTGROUPPARENT
    (
	INUSUSCPADRE	IN	SUSCRIPC.SUSCCODI%TYPE
    )
    IS
	
	
	CNUSUSC_AGRUPADORA	CONSTANT NUMBER := 10165 ;
    BEGIN
    
	PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.ValIsNotGroupParent');
	
	
	IF (FBLISGROUPPARENT (INUSUSCPADRE)) THEN
	    PKERRORS.SETERRORCODE
		(
		    PKCONSTANTE.CSBDIVISION,
		    PKCONSTANTE.CSBMOD_BIL,
		    CNUSUSC_AGRUPADORA
		);
	    RAISE LOGIN_DENIED ;
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
	    PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
	    PKERRORS.POP;
	    RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END VALISNOTGROUPPARENT;
    






































PROCEDURE GETDATAASSOCIATION
    (
    	INUSUSCCODI	    IN	SUSCRIPC.SUSCCODI%TYPE,
    	OCUASSOCIATION	OUT	PKCONSTANTE.TYREFCURSOR
    )
IS
    
    
    
    
    
    
    
    
    
    
	FUNCTION FBLTEMPORAL
    RETURN BOOLEAN IS
	    NURECORDS	NUMBER := 0;

	    CURSOR CUSESUASOC IS
            SELECT COUNT(1)
            FROM   SESUASOC
            WHERE  SSASSUSC = INUSUSCCODI
            AND    SSASCONS >= CNUTOPE_GRUPO_TEMPORAL;

	BEGIN

        PKERRORS.PUSH('pkAssocServSubsAgroupMgr.GetDataAssociation.fblTemporal');

		IF ( CUSESUASOC%ISOPEN ) THEN
			CLOSE CUSESUASOC;
		END IF;

		OPEN CUSESUASOC;
		FETCH CUSESUASOC INTO NURECORDS;

		IF ( CUSESUASOC%NOTFOUND ) THEN
		    NURECORDS := 0;
		END IF;

		CLOSE CUSESUASOC;

        PKERRORS.POP;

        RETURN ( NURECORDS > 0);
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END FBLTEMPORAL;
BEGIN

    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.GetDataAssociation');

    IF (OCUASSOCIATION%ISOPEN) THEN
	    CLOSE OCUASSOCIATION;
    END IF;

    IF ( GSBAPPLICATION = GSBPROG_IMPRESION ) THEN

        OPEN OCUASSOCIATION FOR
    	    SELECT *
              FROM SESUASOC
    	     WHERE SSASSUSC = INUSUSCCODI
               AND SSASCONS < CNUTOPE_GRUPO_TEMPORAL;

    ELSE

        
        
    	IF ( FBLTEMPORAL ) THEN

		    OPEN OCUASSOCIATION FOR
			    SELECT *
                  FROM SESUASOC
			     WHERE SSASSUSC = INUSUSCCODI
			       AND SSASCONS >= CNUTOPE_GRUPO_TEMPORAL;

	    ELSE 

	   	    OPEN OCUASSOCIATION FOR
		        SELECT *
                  FROM SESUASOC
		         WHERE SSASSUSC = INUSUSCCODI
		           AND SSASCONS < CNUTOPE_GRUPO_TEMPORAL;

	    END IF;

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
    	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
    	PKERRORS.POP;
    	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
END GETDATAASSOCIATION;
































PROCEDURE DELDATAASSOCIATION
	(
		INUSUSC		IN	SUSCRIPC.SUSCCODI%TYPE
	)
IS	PRAGMA AUTONOMOUS_TRANSACTION ;
    
    
    
    
    
    
    
    
    
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.DelDataAssociation');

    DELETE SESUASOC
     WHERE SSASSUSC = INUSUSC
       AND SSASCONS >= CNUTOPE_GRUPO_TEMPORAL;

    COMMIT;

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
END DELDATAASSOCIATION;


































PROCEDURE UPASSOCIATIONACCOUNT
    (
   	INUPERIODO	   IN	FACTURA.FACTPEFA%TYPE,
	INUSUSCRIPCION IN	SUSCRIPC.SUSCCODI%TYPE
    )
    IS
    CUASSOCIATION	PKCONSTANTE.TYREFCURSOR;
    TBSSASCONS		PKTBLSESUASOC.TYSSASCONS;
    TBSSASSUSC		PKTBLSESUASOC.TYSSASSUSC;
    TBSSASSESU		PKTBLSESUASOC.TYSSASSESU;
    
    
    
    




    PROCEDURE CLEARMEMORY IS
    BEGIN
        PKERRORS.PUSH('pkAssocServSubsAgroupMgr.UpAssociationAccount.ClearMemory');

    	TBSSASCONS.DELETE;
    	TBSSASSUSC.DELETE;
    	TBSSASSESU.DELETE;

    	PKERRORS.POP;
    EXCEPTION
        WHEN LOGIN_DENIED THEN
            PKERRORS.POP;
            RAISE;
        WHEN PKCONSTANTE.EXERROR_LEVEL2 THEN
            PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            PKERRORS.POP;
            RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END CLEARMEMORY;
    
    
BEGIN

    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.UpAssociationAccount');

    
    GSBPROG_IMPRESION := PKGENERALPARAMETERSMGR.FSBGETSTRINGVALUE('PROG_IMPR_FIFA');

    
    GSBAPPLICATION := UPPER( NVL( PKERRORS.FSBGETAPPLICATION, GSBPROG_IMPRESION ) );

    
    
    UPDEFAULTGROUPINACC( INUSUSCRIPCION, INUPERIODO );

    PKBP_UTILMGR.DOCOMMIT ;

    
    GETDATAASSOCIATION ( INUSUSCRIPCION, CUASSOCIATION );

    
    
    LOOP
    	
        
    	FETCH CUASSOCIATION
         BULK COLLECT INTO TBSSASCONS, TBSSASSUSC, TBSSASSESU
    	LIMIT CNURECDS_MAX_READ;

    	
    	IF ( TBSSASCONS.FIRST IS NULL ) THEN
    	    EXIT;
    	END IF;

    	
        
    	FORALL NUINDEX IN TBSSASCONS.FIRST .. TBSSASCONS.LAST
    	    UPDATE CUENCOBR
    	       SET CUCOGRIM = TBSSASCONS(NUINDEX)
    	     WHERE CUCONUSE = TBSSASSESU(NUINDEX)
    	       AND  CUCOFACT IN
               (SELECT FACTCODI FROM FACTURA WHERE FACTPEFA = INUPERIODO AND
                 FACTSUSC = INUSUSCRIPCION);

        PKBP_UTILMGR.DOCOMMIT ;

    	
    	CLEARMEMORY ;

    	EXIT WHEN CUASSOCIATION%NOTFOUND;

    END LOOP;

    
    CLEARMEMORY ;

    PKBP_UTILMGR.DOCOMMIT ;

    CLOSE CUASSOCIATION;

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
END UPASSOCIATIONACCOUNT;


















PROCEDURE  VALIDATEISASSOSIATED
(
     INUSUSCRIPC   IN   SESUASOC.SSASSUSC%TYPE
)
IS
BEGIN
    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.ValidateIsAssosiated');
    IF ( PKASSOCSERVSUBSAGROUPMGR.FBLISASSOCIATED ( INUSUSCRIPC )) THEN
        PKERRORS.SETERRORCODE   (
                                    PKCONSTANTE.CSBDIVISION,
                                    PKCONSTANTE.CSBMOD_BIL,
                                    CNUSUSC_ASOCIADA
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
        PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        PKERRORS.POP;
        RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
END VALIDATEISASSOSIATED;


























PROCEDURE  DELDATAASSOCBYSERVNUM
(
     INUSERVNUMBER    IN    SERVSUSC.SESUNUSE%TYPE
)
IS
BEGIN

    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.DelDataAssocbyServNum');

    DELETE SESUASOC
    WHERE  SSASSESU = INUSERVNUMBER;

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

END DELDATAASSOCBYSERVNUM;






























FUNCTION FBLISDEFASSOCIATED
    (
	INUSUSC		IN	SUSCRIPC.SUSCCODI%TYPE
    )
RETURN BOOLEAN IS
    
    
    
    
    
    
    NURECORDS	NUMBER; 
    
    
    
    
    
    CURSOR CUSESUASOC (	INUSUSCCODI IN	SUSCRIPC.SUSCCODI%TYPE ) IS
        SELECT 1
        FROM   SESUASOC
        WHERE  SSASSUSC = INUSUSCCODI
        AND    SSASCONS < CNUTOPE_GRUPO_TEMPORAL;

BEGIN

    PKERRORS.PUSH('pkAssocServSubsAgroupMgr.fblIsDefAssociated');

    
    OPEN CUSESUASOC( INUSUSC );
    FETCH CUSESUASOC INTO NURECORDS;

    IF ( CUSESUASOC%NOTFOUND ) THEN
        NURECORDS := 0;
    END IF;

    CLOSE CUSESUASOC;

    PKERRORS.POP;

    
    RETURN ( NURECORDS > 0 );

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
END FBLISDEFASSOCIATED;


    























    PROCEDURE UPDEFAULTGROUPINACC
        (
            INUCONTRACT                   IN  SUSCRIPC.SUSCCODI%TYPE,
            INUBILLINGPERIOD              IN  PERIFACT.PEFACODI%TYPE
        )
    IS

    
    
    
    
    
    
    
    
    

    BEGIN
    

        PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.UpDefaultGroupInAcc');

        
        
        UPDATE CUENCOBR
    	SET    CUCOGRIM = CNUGRUPO_DEFAULT
    	WHERE
    
    
    
               CUCOFACT IN
               (SELECT FACTCODI FROM FACTURA WHERE FACTPEFA = INUBILLINGPERIOD AND
                FACTSUSC = INUCONTRACT)
    	AND    CUCOGRIM <> CNUGRUPO_DEFAULT;

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
    
    END UPDEFAULTGROUPINACC;


    
























    PROCEDURE UPGROUPINACC
        (
            INUPRODUCT                    IN  CUENCOBR.CUCONUSE%TYPE,
            INUBILLINGPERIOD              IN  PERIFACT.PEFACODI%TYPE,
            INUGROUP                      IN  CUENCOBR.CUCOGRIM%TYPE
        )
    IS

    
    
    
    
    
    
    
    
    

    BEGIN
    

        PKERRORS.PUSH ('pkAssocServSubsAgroupMgr.UpGroupInAcc');

        
        UPDATE CUENCOBR
        SET    CUCOGRIM = INUGROUP
        WHERE  CUCONUSE = INUPRODUCT
       
        AND CUCOFACT IN
          ( SELECT FACTCODI
           FROM FACTURA
           WHERE FACTSUSC = PKTBLSERVSUSC.FNUGETSUSCRIPTION(INUPRODUCT)
           AND FACTPEFA = INUBILLINGPERIOD );
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
    
    END UPGROUPINACC;


    




















    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN

        RETURN CSBVERSION;

    END FSBVERSION;

    



















    FUNCTION FCUGETGROUPACCWITHBAL
    (
        INUSUBSCRIP IN  SESUASOC.SSASSUSC%TYPE,
        INUGROUP    IN  SESUASOC.SSASCONS%TYPE
    )
    RETURN PKCONSTANTE.TYREFCURSOR
    IS
        
        
        
        CUGROUPACCWITHBAL PKCONSTANTE.TYREFCURSOR;
    BEGIN

        PKERRORS.PUSH('pkAssocServSubsAgroupMgr.fcuGetGroupAccWithBal');

        OPEN CUGROUPACCWITHBAL FOR
            SELECT CUENCOBR.*
            FROM   CUENCOBR, SESUASOC
            WHERE  SSASSUSC = INUSUBSCRIP
            AND    SSASCONS = INUGROUP
            AND    SSASSESU = CUCONUSE
            AND    NVL( CUCOSACU, 0 ) > 0;
            
        PKERRORS.POP;
        
        RETURN CUGROUPACCWITHBAL;
            
    END FCUGETGROUPACCWITHBAL;
    
     















    FUNCTION FNUGETPRODUCTGROUP
    (
        INUPRODUCT  IN  SESUASOC.SSASSESU%TYPE
    )
    RETURN SESUASOC.SSASCONS%TYPE
    IS
        
        
        
        NUGROUP     SESUASOC.SSASCONS%TYPE;
        
        
        
        CURSOR CUGROUP
        IS
            SELECT SSASCONS
            FROM   SESUASOC
            WHERE  SSASSESU = INUPRODUCT;
    BEGIN

        PKERRORS.PUSH('pkAssocServSubsAgroupMgr.fnuGetProductGroup');

        OPEN CUGROUP;
        FETCH CUGROUP INTO NUGROUP;
        CLOSE CUGROUP;

        PKERRORS.POP;
        RETURN NUGROUP;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
            RAISE;
        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    END FNUGETPRODUCTGROUP;
    
    
















    PROCEDURE GETTEMPASSOCIATION
    (
    	INUSUSCCODI	    IN         SUSCRIPC.SUSCCODI%TYPE,
    	OTBSESUASOC	    OUT NOCOPY PKTBLSESUASOC.TYSSASSESU
    )
    IS
        CURSOR CUASSOCIATION IS
            SELECT  /*+ index (sesuasoc IX_SSAS_SUSC)*/
                    SESUASOC.SSASSESU
            FROM    /*+ pkAssocServSubsAgroupMgr.GetTempAssociation */
                    SESUASOC
            WHERE   SSASSUSC = INUSUSCCODI
            AND     SSASCONS >= CNUTOPE_GRUPO_TEMPORAL;
    BEGIN

        UT_TRACE.TRACE( 'pkAssocServSubsAgroupMgr.GetTempAssociation', 20 );

        IF (CUASSOCIATION%ISOPEN) THEN
    	    CLOSE CUASSOCIATION;
        END IF;

        OPEN CUASSOCIATION;
        FETCH  CUASSOCIATION BULK COLLECT INTO OTBSESUASOC;
        CLOSE CUASSOCIATION;

        UT_TRACE.TRACE( 'pkAssocServSubsAgroupMgr.GetTempAssociation', 20 );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            IF (CUASSOCIATION%ISOPEN) THEN
        	    CLOSE CUASSOCIATION;
            END IF;
            RAISE;
        WHEN OTHERS THEN
            IF (CUASSOCIATION%ISOPEN) THEN
        	    CLOSE CUASSOCIATION;
            END IF;
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END GETTEMPASSOCIATION;
    
END PKASSOCSERVSUBSAGROUPMGR;