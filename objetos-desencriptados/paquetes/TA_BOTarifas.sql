PACKAGE BODY TA_BOTarifas AS




































































































    
    
    
    
    
    

    
    
    CSBVERSION                  CONSTANT VARCHAR2(250) := 'SAO568866';

    CNUPORCIENTO                CONSTANT NUMBER := 100;
    
    
    CNU_ERR_NO_VIGE_TARI        CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 7721;
    
    CSBRANGO_VALOR              CONSTANT  VARCHAR2(1) := 'V';
    CSBRANGO_PORC               CONSTANT  VARCHAR2(1) := 'P';

    
    
    
    
    
    
    
    
    

    
    
    
    
    
    
    
    GBLPARAMETROSCARGADOS       BOOLEAN := FALSE;
    
    GDTLASTCACHECLEARED         DATE    := UT_DATE.FDTSYSDATE;

    
    SBMSJERR                    GE_ERROR_LOG.DESCRIPTION%TYPE;
    
    GNUSEGUNDOENDIAS            NUMBER := TA_BOUTILITARIO.CNUSEGUNDOENDIAS;
    
    
    GBOCONVERTIRMONEDA          BOOLEAN := TRUE;
    
    GSBFORMALIQRANGODIR         VARCHAR2(1);

    
    
    

    



















    FUNCTION FSBVERSION RETURN VARCHAR2 IS
    BEGIN
    
        RETURN CSBVERSION;
    
    END FSBVERSION;

    




















    FUNCTION FBLEXPIREDCACHE
    RETURN BOOLEAN
    IS
    BEGIN
      TD('TA_BOTarifas.fblExpiredCache [Inicio]');
      IF GDTLASTCACHECLEARED < TRUNC(SYSDATE)
      THEN
        TD('Cache Expirada. TRUE');
        RETURN TRUE;
      ELSE
        TD('Cache Expirada. FALSE');
        RETURN FALSE;
      END IF;
      TD('TA_BOTarifas.fblExpiredCache [Fin]');
    END FBLEXPIREDCACHE;
    
    



















    PROCEDURE CLEARCACHE
    AS
    BEGIN
      TD('TA_BOTarifas.ClearCache [Inicio]');
      IF FBLEXPIREDCACHE THEN
        TD('Cache expirado. Se debe limpiar memoria');
        TA_BOTARIFACONCEPTO.LIMPIARMEMORIAGENERAL;
        GDTLASTCACHECLEARED := UT_DATE.FDTSYSDATE;
      END IF;
      TD('TA_BOTarifas.ClearCache [Fin]');
    END;

    





























    PROCEDURE LIMPIARMEMORIAGENERAL
    (
        IBOBORRARINDEXADO   IN  BOOLEAN DEFAULT TRUE
    )
    IS
    BEGIN
    
        TA_BOTARIFACONCEPTO.LIMPIARMEMORIAGENERAL;
        TA_BOVIGETACO.LIMPIARMEMORIA;
        TA_BORANGVITC.LIMPIARMEMORIA;
        TA_BOTARIFASLIQUIDADAS.LIMPIARMEMORIAGENERAL;
        TA_BCGESTIONCRITERIOS.LIMPIARMEMORIA;
        IF (IBOBORRARINDEXADO) THEN
            TA_BCPROYECTOTARIFAS.ELIMINARINDEXADO;
        END IF;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIMPIARMEMORIAGENERAL;

     
























    PROCEDURE ESTCONVERTIRMONEDA
    (
        IBOCONVERTIRMONEDA  IN BOOLEAN
    )
    IS
    BEGIN
    
        GBOCONVERTIRMONEDA := IBOCONVERTIRMONEDA;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END ESTCONVERTIRMONEDA;

     

























    PROCEDURE ESTPROCESOMASIVO
    (
        IBOPROCESOMASIVO IN  BOOLEAN,
        INUNUMEROHILO    IN  TA_VIGELIQU.VILINUHI%TYPE
    )
    IS
    BEGIN
    
        TA_BOTARIFASLIQUIDADAS.ESTPROCESOMASIVO
        (
            IBOPROCESOMASIVO,
            INUNUMEROHILO
        );

        
        IF (IBOPROCESOMASIVO) THEN
            TA_BOTARIFACONCEPTO.ESTUSARHASHDB(FALSE);
        ELSE
            TA_BOTARIFACONCEPTO.ESTUSARHASHDB(TRUE);
        END IF;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END ESTPROCESOMASIVO;

     

























    PROCEDURE ESTLIQRANGODIRVALPORC
    (
        ISBFORMALIQUIDAR    IN  VARCHAR2
    )
    IS
    BEGIN
    
        GSBFORMALIQRANGODIR := ISBFORMALIQUIDAR;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END ESTLIQRANGODIRVALPORC;

    



















    PROCEDURE CONVERTIRMONEDATARIFA
    (
        INUTARIFA           IN  TA_TARICONC.TACOCONS%TYPE,
        INUVALORCONVERTIR   IN  CARGOS.CARGVALO%TYPE,
        ONUVALORCONVERTIDO  OUT CARGOS.CARGVALO%TYPE
    )
    IS
        SBTIPOMONEDA GST_TIPOMONE.TIMOCODI%TYPE;
    BEGIN
    
        TD('TA_BOTarifas.ConvertirMonedaTarifa');
        ONUVALORCONVERTIDO := INUVALORCONVERTIR;

        IF (INUTARIFA IS NULL) THEN
            TD('C�digo de tarifa nula');
            RETURN;
        END IF;

        
        TA_BOTARIFACONCEPTO.OBTTIPOMONEDATARIFA( INUTARIFA, SBTIPOMONEDA );

        TA_BOUTILITARIO.OBTCAMBIOMONEDALOCAL(  SBTIPOMONEDA,
                                               INUVALORCONVERTIR,
                                               ONUVALORCONVERTIDO
                                             );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END CONVERTIRMONEDATARIFA;

    























    PROCEDURE TARIFANOOBTENIDA
    IS
    BEGIN
    
        
        TA_BOTARIFASLIQUIDADAS.LIMPIARMEMORIA();
        TD('Tarifa no Obtenida correctamente');
        
        TA_BOCRITERIOSBUSQUEDA.LIMPIADATOEMPRESALOCAL;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END TARIFANOOBTENIDA;
    
    























    PROCEDURE TARIFAOBTENIDA
    IS
    BEGIN
    
        TA_BOTARIFASLIQUIDADAS.ESTDATOSVALIDOS;
        TD('La tarifa fue obtenida correctamente');
        
        TA_BOCRITERIOSBUSQUEDA.LIMPIADATOEMPRESALOCAL;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END TARIFAOBTENIDA;
    
    































    PROCEDURE OBTTARIFASPORCONCEPTO
    (
        INUSERVICIO     IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO     IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO     IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO     IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAINI     IN  TA_CONFTACO.COTCFEIN%TYPE,
        IDTFECHAFIN     IN  TA_CONFTACO.COTCFEFI%TYPE,
        IBOPERMPERS     IN  BOOLEAN,
        OTBTARIFAS      OUT NOCOPY TA_BCTARICONC.TTYTA_TARICONC
    )
    IS
    BEGIN
    

        
        TA_BOTARIFACONCEPTO.OBTTARIFASPORCONCEPTOEX(INUSERVICIO ,
                                                    INUCONCEPTO ,
                                                    INUPRODUCTO ,
                                                    INUCONTRATO ,
                                                    IDTFECHAINI  ,
                                                    IDTFECHAFIN  ,
                                                    IBOPERMPERS ,
                                                    OTBTARIFAS
                                                   );

        
        
        TA_BOTARIFASLIQUIDADAS.ESTTARIFASLIQUIDADAS( OTBTARIFAS );
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            TARIFANOOBTENIDA();
            RAISE;
        WHEN OTHERS THEN
            TARIFANOOBTENIDA();
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END OBTTARIFASPORCONCEPTO;
    
    






















    PROCEDURE OBTVIGENCIAPORTARIFAS
    (
        ITBTARIFAS      IN  TA_BCTARICONC.TTYTA_TARICONC,
        IDTFECHAINI     IN  TA_VIGETACO.VITCFEIN%TYPE,
        IDTFECHAFIN     IN  TA_VIGETACO.VITCFEFI%TYPE,
        OTBVIGENCIAS    OUT TA_BCVIGETACO.TTYTA_VIGETACO
    )
    IS
        DTFECHAMAX  TA_VIGETACO.VITCFEFI%TYPE;
        NUINDICE    NUMBER;
    BEGIN

        
        TA_BOVIGETACO.OBTVIGENCIASPORTARIFASEX( ITBTARIFAS  ,
                                                IDTFECHAINI ,
                                                IDTFECHAFIN ,
                                                OTBVIGENCIAS
                                               );

        DTFECHAMAX := GREATEST(IDTFECHAINI, IDTFECHAFIN);

        
        NUINDICE := OTBVIGENCIAS.FIRST;
        WHILE (NUINDICE IS NOT NULL) LOOP
            TA_BOTARIFASLIQUIDADAS.ESTVIGENCIALIQUIDADA
                                            (
                                                DTFECHAMAX,
                                                OTBVIGENCIAS(NUINDICE).VITCCONS
                                            );
            NUINDICE := OTBVIGENCIAS.NEXT(NUINDICE);
        END LOOP;


    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);

    END OBTVIGENCIAPORTARIFAS;

    



































    PROCEDURE OBTVIGENCIAPROMEDIADA
    (
        INUTARIFA           IN  TA_VIGETACO.VITCTACO%TYPE,
        INUFOT              IN  NUMBER,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFA   IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        IBOCONVERTIRMONEDA  IN  BOOLEAN,
        IDTFECHAINI         IN  DATE,
        IDTFECHAFIN         IN  DATE,
        OBOEXISTE           OUT BOOLEAN,
        ORCVIGENCIA         OUT TA_VIGETACO%ROWTYPE
    )
    IS
        DTFECHAMAX  TA_VIGETACO.VITCFEFI%TYPE;
    BEGIN

        
        
        
        TA_BOVIGETACO.OBTVIGENCIAPROMEDIADA(INUTARIFA,
                                            INUFOT,
                                            IDTFECHAPERIODOINI,
                                            IDTFECHAPERIODOFIN,
                                            IDTFECHAVIGTARIFA,
                                            IDTFECHALIQINI,
                                            IDTFECHALIQFIN,
                                            IBOCONVERTIRMONEDA,
                                            OBOEXISTE,
                                            ORCVIGENCIA
                                          );

        IF (OBOEXISTE) THEN

            DTFECHAMAX := GREATEST(IDTFECHAINI, IDTFECHAFIN);

            
            TA_BOTARIFASLIQUIDADAS.ESTVIGENCIALIQUIDADA
                                                (
                                                    DTFECHAMAX,
                                                    ORCVIGENCIA.VITCCONS
                                                );

        END IF;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);

    END OBTVIGENCIAPROMEDIADA;

    






















    PROCEDURE APLICARVALORTARIFA
    (
        INUUNIDADES         IN  NUMBER,
        INUVALORTARIFA      IN  NUMBER,
        ONUVALORAPLICADO    OUT NUMBER
    )
    IS
    BEGIN
    

        ONUVALORAPLICADO := INUUNIDADES * INUVALORTARIFA;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END APLICARVALORTARIFA;

    






















    PROCEDURE APLICARPORCTARIFA
    (
        INUUNIDADES         IN  NUMBER,
        INUPORCENTAJE       IN  NUMBER,
        ONUVALORAPLICADO    OUT NUMBER
    )
    IS
    BEGIN
    

        ONUVALORAPLICADO := INUUNIDADES * INUPORCENTAJE / CNUPORCIENTO;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END APLICARPORCTARIFA;

    
























    PROCEDURE OBTFECHAFOT3
    (
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        ODTFECHA            OUT TA_VIGETACO.VITCFEIN%TYPE
    )
    IS
    	
    	NUMESINI	NUMBER;
    	NUMESFIN	NUMBER;

    	DTULTIMODIA	DATE;
    	NUDIASINI	NUMBER;
    	NUDIASFIN	NUMBER;
         
    	DTFECHA		DATE ;
    BEGIN
    

    	
    	
    	NUMESINI := TO_NUMBER (TO_CHAR (IDTFECHAPERIODOINI,'mm')) ;
    	NUMESFIN := TO_NUMBER (TO_CHAR (IDTFECHAPERIODOFIN,'mm')) ;

    	
    	
    	IF (NUMESINI != NUMESFIN) THEN

    	    
    	    DTULTIMODIA := LAST_DAY (IDTFECHAPERIODOINI);

    	    
    	    NUDIASINI := DTULTIMODIA - IDTFECHAPERIODOINI + 1 ;

    	    
    	    NUDIASFIN := IDTFECHAPERIODOFIN - (DTULTIMODIA+1) + 1 ;

    	    
    	    IF (NUDIASINI > NUDIASFIN) THEN
    		  DTFECHA := IDTFECHAPERIODOINI;
    	    ELSE
    		  DTFECHA := IDTFECHAPERIODOFIN;
    	    END IF;

    	ELSE

    	    
    	    DTFECHA := IDTFECHAPERIODOFIN ;

    	END IF;
    	
    	ODTFECHA   := DTFECHA   ;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END OBTFECHAFOT3;

    

































    PROCEDURE OBTFECHASFOT
    (
        INUFOT              IN  NUMBER,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        ODTFECHAINI         OUT TA_VIGETACO.VITCFEIN%TYPE,
        ODTFECHAFIN         OUT TA_VIGETACO.VITCFEFI%TYPE
    )
    IS
    BEGIN
    
        TD('FOT ['||INUFOT||']');
        
        CASE INUFOT
            WHEN TA_BOUTILITARIO.CNUFOT1 THEN
                ODTFECHAINI := IDTFECHAPERIODOFIN;
                ODTFECHAFIN := IDTFECHAPERIODOFIN;
            WHEN TA_BOUTILITARIO.CNUFOT2 THEN
                ODTFECHAINI := IDTFECHAPERIODOINI;
                ODTFECHAFIN := IDTFECHAPERIODOINI;
            WHEN TA_BOUTILITARIO.CNUFOT3 THEN
                OBTFECHAFOT3(IDTFECHAPERIODOINI, IDTFECHAPERIODOFIN, ODTFECHAINI);
                ODTFECHAFIN := ODTFECHAINI;
            WHEN TA_BOUTILITARIO.CNUFOT4 THEN
                ODTFECHAINI := NVL(IDTFECHALIQINI, IDTFECHAPERIODOINI);
                ODTFECHAFIN := NVL(IDTFECHALIQFIN, IDTFECHAPERIODOFIN);
            WHEN TA_BOUTILITARIO.CNUFOT5 THEN
                ODTFECHAINI := IDTFECHAVIGTARIFAS;
                ODTFECHAFIN := IDTFECHAVIGTARIFAS;
            WHEN TA_BOUTILITARIO.CNUFOT6 THEN
                ODTFECHAINI := IDTFECHAPERIODOINI;
                ODTFECHAFIN := IDTFECHAPERIODOFIN;
            ELSE  
                ODTFECHAINI := IDTFECHAPERIODOFIN;
                ODTFECHAFIN := IDTFECHAPERIODOFIN;
        END CASE;
            
        TD('Fecha Inicial ['|| UT_DATE.FSBSTR_DATE(ODTFECHAINI)||
            '] Fecha Final['|| UT_DATE.FSBSTR_DATE(ODTFECHAFIN)||']');

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END OBTFECHASFOT;

    











































    PROCEDURE PROCESARVIGENCIASFOT4
    (
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        ITBVIGENCIAS        IN  TA_BCVIGETACO.TTYTA_VIGETACO,
        ORCVIGENCIA         OUT TA_VIGETACO%ROWTYPE
    )
    IS
        RCVIGENCIAPROMEDIO  TA_VIGETACO%ROWTYPE;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        NUINDICE            NUMBER;
        NUVALORPROMEDIO     NUMBER:=0;
        NUPORCPROMEDIO      NUMBER:=0;
        NUVALORPRORRAT      NUMBER:=0;
        NUPORCPRORRAT       NUMBER:=0;
        NUDIAS              NUMBER:=0;
        NUDIASACUM          NUMBER:=0;

        DTFECHAINITMP       DATE;
        DTFECHAFINTMP       DATE;
    BEGIN
    

        NUINDICE := ITBVIGENCIAS.FIRST;
        IF (NUINDICE IS NULL) THEN
            TD('No hay vigencias a procesar FOT4');
            RETURN;
        END IF;
        
        
        
        RCVIGENCIAPROMEDIO := ITBVIGENCIAS(NUINDICE);
        
        NUDIASACUM  :=  IDTFECHAPERIODOFIN - IDTFECHAPERIODOINI +
                        TA_BOUTILITARIO.CNUSEGUNDOENDIAS;


        IF (NUDIASACUM = 0) THEN
            RCVIGENCIAPROMEDIO.VITCVALO  := 0;
            RCVIGENCIAPROMEDIO.VITCPORC  := 0;
            ORCVIGENCIA := RCVIGENCIAPROMEDIO;
            RETURN;
        END IF;
        
        WHILE (NUINDICE IS NOT NULL) LOOP
            RCVIGENCIA := ITBVIGENCIAS(NUINDICE);

            
            
            DTFECHAINITMP := GREATEST(  NVL(IDTFECHALIQINI, IDTFECHAPERIODOINI),
                                        RCVIGENCIA.VITCFEIN
                                     );

            
            
            DTFECHAFINTMP := LEAST(  NVL(IDTFECHALIQFIN, IDTFECHAPERIODOFIN),
                                     RCVIGENCIA.VITCFEFI
                                   );

       		
    		NUDIAS := DTFECHAFINTMP - DTFECHAINITMP +
                         TA_BOUTILITARIO.CNUSEGUNDOENDIAS;

            TA_BOUTILITARIO.PRORRATEARPORDIAS(  NUDIASACUM          ,
                                                NUDIAS              ,
                                                RCVIGENCIA.VITCVALO ,
                                                RCVIGENCIA.VITCPORC ,
                                                NUVALORPRORRAT      ,
                                                NUPORCPRORRAT
                                            );

            
            IF ( GBOCONVERTIRMONEDA ) THEN

                
                CONVERTIRMONEDATARIFA(
                            RCVIGENCIA.VITCTACO,
                            NUVALORPRORRAT,
                            NUVALORPRORRAT);
            END IF;


            NUVALORPROMEDIO := NUVALORPROMEDIO + NUVALORPRORRAT;
            NUPORCPROMEDIO  := NUPORCPROMEDIO + NUPORCPRORRAT;

            NUINDICE := ITBVIGENCIAS.NEXT(NUINDICE);
        END LOOP;

        RCVIGENCIAPROMEDIO.VITCVALO := NUVALORPROMEDIO ;
        RCVIGENCIAPROMEDIO.VITCPORC := NUPORCPROMEDIO ;

        ORCVIGENCIA := RCVIGENCIAPROMEDIO;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END PROCESARVIGENCIASFOT4;

    

























    PROCEDURE PROCESARVIGENCIASFOT6
    (
        IDTFECHAINI     IN  TA_VIGETACO.VITCFEIN%TYPE,
        IDTFECHAFIN     IN  TA_VIGETACO.VITCFEFI%TYPE,
        ITBVIGENCIAS    IN  TA_BCVIGETACO.TTYTA_VIGETACO,
        ORCVIGENCIA     OUT TA_VIGETACO%ROWTYPE
    )
    IS
        NUINDICEVIG     NUMBER;
        TBVIGENCIAS     TA_BCVIGETACO.TTYTA_VIGETACO;
        RCVIGENCIA      TA_VIGETACO%ROWTYPE;
        DTFECHAINITMP   TA_VIGETACO.VITCFEIN%TYPE;
        DTFECHAFINTMP   TA_VIGETACO.VITCFEFI%TYPE;
        DTFECHATARIFA   TA_VIGETACO.VITCFEFI%TYPE;
        NUDIAS          NUMBER:=0;

        
        NUINDICERESULT  NUMBER;
        
        NUMAYORNUMDIAS  NUMBER:=0;

    BEGIN
    
        TD('Evaluando ['||ITBVIGENCIAS.COUNT||'] Vigencias para FOT6');

        NUINDICEVIG := ITBVIGENCIAS.FIRST;
        IF (NUINDICEVIG IS NULL) THEN
            TD('No hay vigencias a evaluar');
            RETURN;
        END IF;
        
        WHILE ( NUINDICEVIG IS NOT NULL ) LOOP

            RCVIGENCIA  := ITBVIGENCIAS(NUINDICEVIG);
            
            
            
            DTFECHAINITMP := GREATEST(  IDTFECHAINI,
                                        RCVIGENCIA.VITCFEIN
                                     );
            
            
            DTFECHAFINTMP := LEAST(  IDTFECHAFIN,
                                     RCVIGENCIA.VITCFEFI
                                   );

    		
    		NUDIAS := DTFECHAFINTMP - DTFECHAINITMP +
                         TA_BOUTILITARIO.CNUSEGUNDOENDIAS;

    	    
    	    
    	    
    	    IF (NUDIAS > NUMAYORNUMDIAS) THEN
        		
        		NUMAYORNUMDIAS := NUDIAS ;

        		
        		DTFECHATARIFA := RCVIGENCIA.VITCFEIN ;

        		NUINDICERESULT := NUINDICEVIG ;
        		
    		
    		
    	    ELSIF( NUDIAS = NUMAYORNUMDIAS AND
        		   RCVIGENCIA.VITCFEIN < DTFECHATARIFA ) THEN
        		   
    		    
    		    
    		    NUMAYORNUMDIAS := NUDIAS ;

    		    
    		    DTFECHATARIFA := RCVIGENCIA.VITCFEIN;

    		    NUINDICERESULT := NUINDICEVIG ;

    	    END IF ;

            NUINDICEVIG := ITBVIGENCIAS.NEXT(NUINDICEVIG);
        END LOOP;

        ORCVIGENCIA     := ITBVIGENCIAS(NUINDICERESULT);
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END PROCESARVIGENCIASFOT6;

    








































    PROCEDURE PROCESARVIGENCIASFOT
    (
        INUFOT              IN  NUMBER,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        ITBVIGENCIAS        IN  TA_BCVIGETACO.TTYTA_VIGETACO,
        IBOPROMEDIAR        IN  BOOLEAN,
        ORCVIGENCIA         OUT TA_VIGETACO%ROWTYPE
    )
    IS
    BEGIN
    

        IF (ITBVIGENCIAS.FIRST IS NULL) THEN
            TD('No hay Vigencias para procesar');
            RETURN;
        END IF;
        
        
        
        IF ( INUFOT = TA_BOUTILITARIO.CNUFOT4 ) THEN
            PROCESARVIGENCIASFOT4(  IDTFECHAPERIODOINI,
                                    IDTFECHAPERIODOFIN,
                                    IDTFECHALIQINI,
                                    IDTFECHALIQFIN,
                                    ITBVIGENCIAS,
                                    ORCVIGENCIA     
                                 );

        ELSIF ( INUFOT = TA_BOUTILITARIO.CNUFOT6 ) THEN
            PROCESARVIGENCIASFOT6(  IDTFECHAPERIODOINI,
                                    IDTFECHAPERIODOFIN,
                                    ITBVIGENCIAS,
                                    ORCVIGENCIA     
                                 );

        
        
        ELSE
            ORCVIGENCIA := ITBVIGENCIAS(ITBVIGENCIAS.FIRST);
            
        END IF;
        
        
        
        IF ( IBOPROMEDIAR  AND INUFOT != TA_BOUTILITARIO.CNUFOT4 ) THEN

            

            TA_BOUTILITARIO.PRORRATEARPORFECHAS(IDTFECHAPERIODOINI,
                                                IDTFECHAPERIODOFIN,
                                                IDTFECHALIQINI,
                                                IDTFECHALIQFIN,
                                                ORCVIGENCIA.VITCVALO,
                                                ORCVIGENCIA.VITCPORC,
                                                ORCVIGENCIA.VITCVALO, 
                                                ORCVIGENCIA.VITCPORC  
                                               );

        END IF;
        
        
        IF ( GBOCONVERTIRMONEDA AND INUFOT != TA_BOUTILITARIO.CNUFOT4 ) THEN

            
            CONVERTIRMONEDATARIFA(
                        ORCVIGENCIA.VITCTACO,
                        ORCVIGENCIA.VITCVALO,
                        ORCVIGENCIA.VITCVALO);
        END IF;

        TD('Vigencia Seleccionada ['||ORCVIGENCIA.VITCCONS||']');

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END PROCESARVIGENCIASFOT;
    
    













































    PROCEDURE PROCESARRANGOS
    (
        INUUNIDADES         IN  NUMBER,
        INUDIASBASE         IN  NUMBER,
        INUDIASLIQ          IN  NUMBER,
        ITBTA_RANGVITC      IN  TA_BCRANGVITC.TTYTA_RANGVITC,
        INUCODTARIFA        IN  TA_TARICONC.TACOCONS%TYPE,
        ONUVALORTARIFA      OUT CARGOS.CARGVALO%TYPE,
        ONUPORCTARIFA       OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUINDICE        NUMBER;
        NUUNIDLIQUIDAR  NUMBER:=0;
        NUUNIDRANGO     NUMBER:=0;
        NUUNIDLIQUIDO   NUMBER:=0;
        RCTA_RANGVITC   TA_RANGVITC%ROWTYPE;
        NUVALORTOT      CARGOS.CARGVALO%TYPE      :=0;
        NUPORCTOT       CARGOS.CARGVALO%TYPE      :=0;
        NUVALOR         CARGOS.CARGVALO%TYPE      :=0;
        NUPORCEN        CARGOS.CARGVALO%TYPE      :=0;
    BEGIN
    

        TD('Procesando Unidades ['||INUUNIDADES||'] en ['||ITBTA_RANGVITC.COUNT||']rangos ');

        NUINDICE := ITBTA_RANGVITC.FIRST;
        IF (NUINDICE IS NULL) THEN
            TD('No hay rangos para procesar');
            RETURN;
        END IF;

        NUUNIDLIQUIDAR := INUUNIDADES;
        WHILE (NUINDICE IS NOT NULL  ) LOOP

            RCTA_RANGVITC := ITBTA_RANGVITC(NUINDICE);

            
            IF (INUUNIDADES < RCTA_RANGVITC.RAVTLIIN OR NUUNIDLIQUIDAR = 0 ) THEN
                TD('Termina. Menor que limite inf o consumo 0');
        	    EXIT ;
            END IF ;

        	NUUNIDRANGO := RCTA_RANGVITC.RAVTLISU - RCTA_RANGVITC.RAVTLIIN;

        	
           	IF (RCTA_RANGVITC.RAVTLIIN > 0) THEN

        	    NUUNIDRANGO := NUUNIDRANGO + 1;
            END IF;

        	IF (NUUNIDLIQUIDAR < NUUNIDRANGO) THEN

                TA_BOUTILITARIO.PRORRATEARPORDIAS
                                            (
                                                INUDIASBASE,
                                                INUDIASLIQ ,
                                                RCTA_RANGVITC.RAVTVALO,
                                                RCTA_RANGVITC.RAVTPORC,
                                                RCTA_RANGVITC.RAVTVALO, 
                                                RCTA_RANGVITC.RAVTPORC  
                                            );
                                            
                APLICARVALORTARIFA( NUUNIDLIQUIDAR, RCTA_RANGVITC.RAVTVALO,NUVALOR );
                APLICARPORCTARIFA ( NUUNIDLIQUIDAR, RCTA_RANGVITC.RAVTPORC,NUPORCEN);
                NUUNIDLIQUIDO := NUUNIDLIQUIDAR;
        	    NUUNIDLIQUIDAR := 0;

            ELSE

                TA_BOUTILITARIO.PRORRATEARPORDIAS
                                            (
                                                INUDIASBASE,
                                                INUDIASLIQ ,
                                                RCTA_RANGVITC.RAVTVALO,
                                                RCTA_RANGVITC.RAVTPORC,
                                                RCTA_RANGVITC.RAVTVALO, 
                                                RCTA_RANGVITC.RAVTPORC  
                                            );
                                            
                APLICARVALORTARIFA(NUUNIDRANGO, RCTA_RANGVITC.RAVTVALO,NUVALOR);
                APLICARPORCTARIFA (NUUNIDRANGO, RCTA_RANGVITC.RAVTPORC,NUPORCEN);
                NUUNIDLIQUIDO := NUUNIDRANGO;
        	    NUUNIDLIQUIDAR := NUUNIDLIQUIDAR - NUUNIDRANGO;

        	END IF;
        	
        	
            IF ( GBOCONVERTIRMONEDA ) THEN
                
                CONVERTIRMONEDATARIFA(
                            INUCODTARIFA,
                            NUVALOR,
                            NUVALOR);
            END IF;
            
            
            TA_BOTARIFASLIQUIDADAS.ESTRANGOLIQUIDADO(   RCTA_RANGVITC,
                                                        NUUNIDLIQUIDO,
                                                        NUVALOR,
                                                        NUPORCEN
                                                     );
            
        	NUVALORTOT := NUVALORTOT + NUVALOR;
        	NUPORCTOT  := NUPORCTOT  + NUPORCEN;

            NUINDICE := ITBTA_RANGVITC.NEXT(NUINDICE);
        END LOOP;
        TD('Valor ['||NUVALORTOT||'] Porcentaje ['||NUPORCTOT||']');
        ONUVALORTARIFA  := NUVALORTOT;
        ONUPORCTARIFA   := NUPORCTOT;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END PROCESARRANGOS;

    






































































    PROCEDURE LIQTARIFA
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_VIGETACO.VITCVALO%TYPE,
        ONUPORCTARIFA       OUT TA_VIGETACO.VITCPORC%TYPE
    )
    IS
        TBTARIFAS           TA_BCTARICONC.TTYTA_TARICONC;
        TBVIGENCIAS         TA_BCVIGETACO.TTYTA_VIGETACO;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        DTFECHAINI          DATE;
        DTFECHAFIN          DATE;
        NUVALORCONVERTIDO   TA_VIGETACO.VITCVALO%TYPE;
        BOEXISTE            BOOLEAN;

    BEGIN
    

        TD('Buscando Tarifa LiqTarifa. Concepto ['||INUCONCEPTO||'] Servicio ['
        ||INUSERVICIO||']');

        CLEARCACHE;


        
        OBTFECHASFOT( INUFOT,
                      IDTFECHAPERIODOINI,
                      IDTFECHAPERIODOFIN,
                      IDTFECHAVIGTARIFAS,
                      IDTFECHALIQINI,
                      IDTFECHALIQFIN,
                      DTFECHAINI,
                      DTFECHAFIN
                    );

        
        OBTTARIFASPORCONCEPTO(  INUSERVICIO ,
                                INUCONCEPTO ,
                                INUPRODUCTO ,
                                INUCONTRATO ,
                                DTFECHAINI  ,
                                DTFECHAFIN  ,
                                IBOPERMPERS ,
                                TBTARIFAS
                               );

        
        
        OBTVIGENCIAPROMEDIADA(  TBTARIFAS(TBTARIFAS.FIRST).TACOCONS,
                                INUFOT,
                                IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHAVIGTARIFAS,
                                IDTFECHALIQINI,
                                IDTFECHALIQFIN,
                                GBOCONVERTIRMONEDA,
                                DTFECHAINI,
                                DTFECHAFIN,
                                BOEXISTE,
                                RCVIGENCIA
                             );

        
        IF ( BOEXISTE ) THEN
            ONUCODTARIFA    := RCVIGENCIA.VITCTACO;
            ONUCODVIGENCIA  := RCVIGENCIA.VITCCONS;
            ONUVALORTARIFA  := RCVIGENCIA.VITCVALO;
            ONUPORCTARIFA   := RCVIGENCIA.VITCPORC;

            
            TARIFAOBTENIDA();
            RETURN; 
            
        END IF;

        
        OBTVIGENCIAPORTARIFAS(  TBTARIFAS  ,
                                DTFECHAINI ,
                                DTFECHAFIN ,
                                TBVIGENCIAS
                             );

        
        PROCESARVIGENCIASFOT (  INUFOT,
                                IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHALIQINI,
                                IDTFECHALIQFIN,
                                TBVIGENCIAS,
                                TRUE,
                                RCVIGENCIA
                             );

        ONUCODTARIFA    := RCVIGENCIA.VITCTACO;
        ONUCODVIGENCIA  := RCVIGENCIA.VITCCONS;
        ONUVALORTARIFA  := RCVIGENCIA.VITCVALO;
        ONUPORCTARIFA   := RCVIGENCIA.VITCPORC;

        
        TA_BOVIGETACO.ADICVIGENCIAPROMEDIADA(TBTARIFAS(TBTARIFAS.FIRST).TACOCONS,
                                             INUFOT,
                                             RCVIGENCIA,
                                             IDTFECHAPERIODOINI,
                                             IDTFECHAPERIODOFIN,
                                             IDTFECHAVIGTARIFAS,
                                             IDTFECHALIQINI,
                                             IDTFECHALIQFIN,
                                             GBOCONVERTIRMONEDA
                                            );
        
        TARIFAOBTENIDA();
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            TARIFANOOBTENIDA();
            RAISE;
        WHEN OTHERS THEN
            TARIFANOOBTENIDA();
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFA;

    



















































    PROCEDURE LIQTARIFAVALOR
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_VIGETACO.VITCVALO%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUCODTARIFA        TA_TARICONC.TACOCONS%TYPE;
        NUCODVIGENCIA      TA_VIGETACO.VITCCONS%TYPE;
        NUVALORTARIFA      TA_VIGETACO.VITCVALO%TYPE;
        NUVALORAPLICADO    CARGOS.CARGVALO%TYPE;
        NUPORCTARIFA       TA_VIGETACO.VITCPORC%TYPE;
    BEGIN
    

        LIQTARIFA(  INUSERVICIO,
                    INUCONCEPTO,
                    INUPRODUCTO,
                    INUCONTRATO,
                    IDTFECHAPERIODOINI,
                    IDTFECHAPERIODOFIN,
                    IDTFECHAVIGTARIFAS,
                    IDTFECHALIQINI,
                    IDTFECHALIQFIN,
                    INUFOT            ,
                    IBOPERMPERS       ,
                    NUCODTARIFA       ,  
                    NUCODVIGENCIA     ,  
                    NUVALORTARIFA     ,  
                    NUPORCTARIFA         
                 );
                
        
        IF ( INUUNIDADES IS NOT NULL ) THEN
            APLICARVALORTARIFA( INUUNIDADES, NUVALORTARIFA, NUVALORAPLICADO );
        END IF;

        ONUCODTARIFA     := NUCODTARIFA;
        ONUCODVIGENCIA   := NUCODVIGENCIA;
        ONUVALORTARIFA   := NUVALORTARIFA;
        ONUVALORAPLICADO := NUVALORAPLICADO;
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFAVALOR;
    
    





















































    PROCEDURE LIQTARIFAPORC
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUPORCTARIFA       OUT TA_VIGETACO.VITCPORC%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUCODTARIFA        TA_TARICONC.TACOCONS%TYPE;
        NUCODVIGENCIA      TA_VIGETACO.VITCCONS%TYPE;
        NUVALORTARIFA      TA_VIGETACO.VITCVALO%TYPE;
        NUVALORAPLICADO    CARGOS.CARGVALO%TYPE;
        NUPORCTARIFA       TA_VIGETACO.VITCPORC%TYPE;
        
        
        BOCONVERTIRACTUAL  BOOLEAN;
    BEGIN
    
        
        BOCONVERTIRACTUAL := GBOCONVERTIRMONEDA;
        
        
        GBOCONVERTIRMONEDA := FALSE;

        LIQTARIFA(  INUSERVICIO,
                    INUCONCEPTO,
                    INUPRODUCTO,
                    INUCONTRATO,
                    IDTFECHAPERIODOINI,
                    IDTFECHAPERIODOFIN,
                    IDTFECHAVIGTARIFAS,
                    IDTFECHALIQINI    ,
                    IDTFECHALIQFIN    ,
                    INUFOT            ,
                    IBOPERMPERS       ,
                    NUCODTARIFA       ,  
                    NUCODVIGENCIA     ,  
                    NUVALORTARIFA     ,  
                    NUPORCTARIFA         
                 );
                 
        
        GBOCONVERTIRMONEDA := BOCONVERTIRACTUAL;

        
        IF ( INUUNIDADES IS NOT NULL ) THEN
            APLICARPORCTARIFA( INUUNIDADES, NUPORCTARIFA, NUVALORAPLICADO );
        END IF;

        ONUCODTARIFA     := NUCODTARIFA;
        ONUCODVIGENCIA   := NUCODVIGENCIA;
        ONUPORCTARIFA    := NUPORCTARIFA;
        ONUVALORAPLICADO := NUVALORAPLICADO;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFAPORC;


    




























































    PROCEDURE PROCESARVIGRANGDIRFOT4
    (
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        ITBVIGENCIAS        IN  TA_BCVIGETACO.TTYTA_VIGETACO,
        INUUNIDADES         IN  NUMBER,
        ONUVALORTARIFA      OUT TA_RANGVITC.RAVTVALO%TYPE,
        ONUPORCTARIFA       OUT TA_RANGVITC.RAVTPORC%TYPE,
        ORCVIGENCIA         OUT TA_VIGETACO%ROWTYPE,
        OTBRANGOSAPLICAN OUT NOCOPY  TA_BCRANGVITC.TTYTA_RANGVITC
    )
    IS
        RCPRIMERVIGENCIA    TA_VIGETACO%ROWTYPE;
        RCRANGODIRECTO      TA_RANGVITC%ROWTYPE;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        NUVALORTARIFATMP    TA_RANGVITC.RAVTVALO%TYPE;
        NUPORCTARIFATMP     TA_RANGVITC.RAVTPORC%TYPE;
        NUINDICE            NUMBER;
        NUVALORPROMEDIO     NUMBER:=0;
        NUPORCPROMEDIO      NUMBER:=0;
        NUVALORPRORRAT      NUMBER:=0;
        NUPORCPRORRAT       NUMBER:=0;
        NUDIAS              NUMBER:=0;
        NUDIASACUM          NUMBER:=0;
        DTFECHAINITMP       DATE;
        DTFECHAFINTMP       DATE;

    BEGIN
    

        NUINDICE := ITBVIGENCIAS.FIRST;
        IF (NUINDICE IS NULL) THEN
            TD('No hay vigencias a procesar RangDirFOT4');
            RETURN;
        END IF;

        
        
        RCPRIMERVIGENCIA := ITBVIGENCIAS(NUINDICE);

        NUDIASACUM  :=  IDTFECHAPERIODOFIN - IDTFECHAPERIODOINI +
                        TA_BOUTILITARIO.CNUSEGUNDOENDIAS;

        IF (NUDIASACUM = 0) THEN
            ORCVIGENCIA     := RCPRIMERVIGENCIA;
            ONUVALORTARIFA  := 0;
            ONUPORCTARIFA   := 0;
        END IF;
        
        
        WHILE (NUINDICE IS NOT NULL) LOOP
            RCVIGENCIA := ITBVIGENCIAS(NUINDICE);
            
            
            
            DTFECHAINITMP := GREATEST(  NVL(IDTFECHALIQINI,IDTFECHAPERIODOINI),
                                        RCVIGENCIA.VITCFEIN
                                     );

            
            
            DTFECHAFINTMP := LEAST(  NVL(IDTFECHALIQFIN,IDTFECHAPERIODOFIN),
                                     RCVIGENCIA.VITCFEFI
                                   );

       		
    		NUDIAS := DTFECHAFINTMP - DTFECHAINITMP +
                         TA_BOUTILITARIO.CNUSEGUNDOENDIAS;

            
            TA_BORANGVITC.OBTRANGODIRECTO ( RCVIGENCIA.VITCCONS,
                                            INUUNIDADES,
                                            RCRANGODIRECTO
                                          );

            OTBRANGOSAPLICAN(OTBRANGOSAPLICAN.COUNT + 1) := RCRANGODIRECTO;
            
            TA_BOUTILITARIO.PRORRATEARPORDIAS(  NUDIASACUM              ,
                                                NUDIAS                  ,
                                                RCRANGODIRECTO.RAVTVALO ,
                                                RCRANGODIRECTO.RAVTPORC ,
                                                NUVALORPRORRAT          ,
                                                NUPORCPRORRAT
                                            );
            
            IF ( GBOCONVERTIRMONEDA ) THEN
                
                CONVERTIRMONEDATARIFA(
                            RCVIGENCIA.VITCTACO,
                            NUVALORPRORRAT,  
                            NUVALORPRORRAT); 
            END IF;
            
            IF (GSBFORMALIQRANGODIR = CSBRANGO_VALOR) THEN
                APLICARVALORTARIFA(INUUNIDADES, NUVALORPRORRAT,NUVALORTARIFATMP);
            ELSIF (GSBFORMALIQRANGODIR = CSBRANGO_PORC) THEN
                APLICARPORCTARIFA (INUUNIDADES, NUPORCPRORRAT, NUPORCTARIFATMP);
            ELSE
                NUVALORTARIFATMP:= NULL;
                NUPORCTARIFATMP:= NULL;
            END IF;

            
            TA_BOTARIFASLIQUIDADAS.ESTRANGOLIQUIDADO(   RCRANGODIRECTO,
                                                        INUUNIDADES,
                                                        NUVALORTARIFATMP,
                                                        NUPORCTARIFATMP
                                                     );

                                                     
            NUVALORPROMEDIO := NUVALORPROMEDIO + NUVALORPRORRAT;
            NUPORCPROMEDIO  := NUPORCPROMEDIO + NUPORCPRORRAT;

            NUINDICE := ITBVIGENCIAS.NEXT(NUINDICE);
        END LOOP;

        ONUVALORTARIFA := NUVALORPROMEDIO ;
        ONUPORCTARIFA  := NUPORCPROMEDIO  ;

        TD('Rango Directo Procesados FOT4 ['||OTBRANGOSAPLICAN.COUNT||']');
        ORCVIGENCIA  := RCPRIMERVIGENCIA;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END PROCESARVIGRANGDIRFOT4;

    





















































    PROCEDURE LIQTARIFARANGODIRFOT4
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUUNIDADES         IN  NUMBER,
        IBOCONVERTIRMONEDA  IN  BOOLEAN,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_VIGETACO.VITCVALO%TYPE,
        ONUPORCTARIFA       OUT TA_VIGETACO.VITCPORC%TYPE
    )
    IS
        SBMENSAJE           GE_ERROR_LOG.DESCRIPTION%TYPE;
        NUCODPRIMERTARIFA   TA_TARICONC.TACOCONS%TYPE;
        TBTARIFAS           TA_BCTARICONC.TTYTA_TARICONC;
        TBVIGENCIAS         TA_BCVIGETACO.TTYTA_VIGETACO;
        TBRANGOS            TA_BCRANGVITC.TTYTA_RANGVITC;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        DTFECHAINI          DATE;
        DTFECHAFIN          DATE;
        NUVALORTARIFA       TA_VIGETACO.VITCVALO%TYPE;
        NUPORCTARIFA        TA_VIGETACO.VITCPORC%TYPE;
        NUVALORCONVERTIDO   TA_VIGETACO.VITCVALO%TYPE;
    BEGIN
    

        TD('Buscando Tarifa LiqTarifaRangoDirFOT4. Concepto ['||INUCONCEPTO||']');

        
        OBTFECHASFOT( TA_BOUTILITARIO.CNUFOT4,
                      IDTFECHAPERIODOINI,
                      IDTFECHAPERIODOFIN,
                      NULL,
                      IDTFECHALIQINI,
                      IDTFECHALIQFIN,
                      DTFECHAINI,
                      DTFECHAFIN
                    );

        
        OBTTARIFASPORCONCEPTO(  INUSERVICIO ,
                                INUCONCEPTO ,
                                INUPRODUCTO ,
                                INUCONTRATO ,
                                DTFECHAINI  ,
                                DTFECHAFIN  ,
                                IBOPERMPERS ,
                                TBTARIFAS    
                               );

        
        OBTVIGENCIAPORTARIFAS(  TBTARIFAS  ,
                                DTFECHAINI ,
                                DTFECHAFIN ,
                                TBVIGENCIAS  
                             );

        
        PROCESARVIGRANGDIRFOT4 (IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHALIQINI    ,
                                IDTFECHALIQFIN    ,
                                TBVIGENCIAS       ,
                                INUUNIDADES       ,
                                NUVALORTARIFA     ,  
                                NUPORCTARIFA      ,  
                                RCVIGENCIA        ,  
                                TBRANGOS             
                              );

        ONUCODTARIFA    := RCVIGENCIA.VITCTACO;
        ONUCODVIGENCIA  := RCVIGENCIA.VITCCONS;
        ONUPORCTARIFA   := NUPORCTARIFA;
        ONUVALORTARIFA  := NUVALORTARIFA;
        
        
        TARIFAOBTENIDA();
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            TARIFANOOBTENIDA();
            RAISE;
        WHEN OTHERS THEN
            TARIFANOOBTENIDA();
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGODIRFOT4;

    



















































    PROCEDURE PROCESARVIGRANGFOT4
    (
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUUNIDADES         IN  NUMBER,
        ITBVIGENCIAS        IN  TA_BCVIGETACO.TTYTA_VIGETACO,
        ORCVIGENCIA         OUT TA_VIGETACO%ROWTYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE,
        ONUPORCAPLICADO     OUT CARGOS.CARGVALO%TYPE
    )
    IS
        RCPRIMERVIGENCIA    TA_VIGETACO%ROWTYPE;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        TBTA_RANGVITC       TA_BCRANGVITC.TTYTA_RANGVITC;
        NUVALORAPLICADO     CARGOS.CARGVALO%TYPE     :=0;
        NUPORCAPLICADO      CARGOS.CARGVALO%TYPE     :=0;
        NUVALORTEMP         CARGOS.CARGVALO%TYPE;
        NUPORCTEMP          CARGOS.CARGVALO%TYPE;
        NUINDICE            NUMBER;
        NUDIAS              NUMBER:=0;
        NUDIASACUM          NUMBER:=0;
        DTFECHAINITMP       DATE;
        DTFECHAFINTMP       DATE;

    BEGIN
    

        NUINDICE := ITBVIGENCIAS.FIRST;
        IF (NUINDICE IS NULL) THEN
            TD('No hay vigencias a procesar ProcesarVigRangFOT4');
            RETURN;
        END IF;

        
        
        RCPRIMERVIGENCIA := ITBVIGENCIAS(NUINDICE);
        NUDIASACUM  :=  IDTFECHAPERIODOFIN -  IDTFECHAPERIODOINI +
                        TA_BOUTILITARIO.CNUSEGUNDOENDIAS;

        
        WHILE (NUINDICE IS NOT NULL) LOOP
            RCVIGENCIA :=  ITBVIGENCIAS(NUINDICE);

            
            
            DTFECHAINITMP := GREATEST( NVL(IDTFECHALIQINI, IDTFECHAPERIODOINI),
                                       RCVIGENCIA.VITCFEIN
                                     );

            
            
            DTFECHAFINTMP := LEAST(  NVL(IDTFECHALIQFIN, IDTFECHAPERIODOFIN),
                                     RCVIGENCIA.VITCFEFI
                                   );

       		
    		NUDIAS := DTFECHAFINTMP - DTFECHAINITMP +
                         TA_BOUTILITARIO.CNUSEGUNDOENDIAS;

            
            TA_BORANGVITC.OBTRANGOSPORVIGENCIAEX( RCVIGENCIA.VITCCONS,
                                                  TBTA_RANGVITC
                                                );

            
            PROCESARRANGOS ( INUUNIDADES  ,
                             NUDIASACUM   ,
                             NUDIAS       ,
                             TBTA_RANGVITC,
                             RCVIGENCIA.VITCTACO,
                             NUVALORTEMP  ,
                             NUPORCTEMP
                           );

            NUVALORAPLICADO := NUVALORAPLICADO + NUVALORTEMP;
            NUPORCAPLICADO  := NUPORCAPLICADO  + NUPORCTEMP;
            
            
            TBTA_RANGVITC.DELETE;

            NUINDICE := ITBVIGENCIAS.NEXT(NUINDICE);
        END LOOP;

        TD('Rangos Procesados FOT4 Valor ['||NUVALORAPLICADO||']');
        ORCVIGENCIA      := RCPRIMERVIGENCIA;
        ONUVALORAPLICADO := NUVALORAPLICADO;
        ONUPORCAPLICADO  := NUPORCAPLICADO;
        
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END PROCESARVIGRANGFOT4;


    








































































    PROCEDURE LIQTARIFARANGODIRECTO
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOCONVERTIRMONEDA  IN  BOOLEAN,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_VIGETACO.VITCVALO%TYPE,
        ONUPORCTARIFA       OUT TA_VIGETACO.VITCPORC%TYPE
    )
    IS
        TBTARIFAS           TA_BCTARICONC.TTYTA_TARICONC;
        TBVIGENCIAS         TA_BCVIGETACO.TTYTA_VIGETACO;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        RCRANGODIRECTO      TA_RANGVITC%ROWTYPE;
        NUVALORTARIFATMP    RANGLIQU.RALIVAUL%TYPE;
        NUPORCTARIFATMP     RANGLIQU.RALIVAUL%TYPE;
        DTFECHAINI          DATE;
        DTFECHAFIN          DATE;
        NUVALORCONVERTIDO   TA_VIGETACO.VITCVALO%TYPE;
        BOEXISTE            BOOLEAN;
        NUVALORPRORRAT      NUMBER:=0;
        NUPORCPRORRAT       NUMBER:=0;
    BEGIN
    

        
        OBTFECHASFOT( INUFOT,
                      IDTFECHAPERIODOINI,
                      IDTFECHAPERIODOFIN,
                      IDTFECHAVIGTARIFAS,
                      IDTFECHALIQINI,
                      IDTFECHALIQFIN,
                      DTFECHAINI,
                      DTFECHAFIN
                    );

        
        OBTTARIFASPORCONCEPTO(  INUSERVICIO ,
                                INUCONCEPTO ,
                                INUPRODUCTO ,
                                INUCONTRATO ,
                                DTFECHAINI  ,
                                DTFECHAFIN  ,
                                IBOPERMPERS ,
                                TBTARIFAS
                               );

        
        
        OBTVIGENCIAPROMEDIADA(  TBTARIFAS(TBTARIFAS.FIRST).TACOCONS,
                                INUFOT,
                                IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHAVIGTARIFAS,
                                IDTFECHALIQINI,
                                IDTFECHALIQFIN,
                                FALSE, 
                                DTFECHAINI,
                                DTFECHAFIN,
                                BOEXISTE,
                                RCVIGENCIA
                             );

        
        IF ( NOT BOEXISTE ) THEN

            
            OBTVIGENCIAPORTARIFAS(  TBTARIFAS  ,
                                    DTFECHAINI ,
                                    DTFECHAFIN ,
                                    TBVIGENCIAS
                                 );

            
            PROCESARVIGENCIASFOT (  INUFOT,
                                    IDTFECHAPERIODOINI,
                                    IDTFECHAPERIODOFIN,
                                    IDTFECHALIQINI,
                                    IDTFECHALIQFIN,
                                    TBVIGENCIAS,
                                    FALSE,
                                    RCVIGENCIA
                                 );
                                 
            
            TA_BOVIGETACO.ADICVIGENCIAPROMEDIADA(
                                            TBTARIFAS(TBTARIFAS.FIRST).TACOCONS,
                                            INUFOT,
                                            RCVIGENCIA,
                                            IDTFECHAPERIODOINI,
                                            IDTFECHAPERIODOFIN,
                                            IDTFECHAVIGTARIFAS,
                                            IDTFECHALIQINI,
                                            IDTFECHALIQFIN,
                                            FALSE
                                            );

        END IF;

        
        TA_BORANGVITC.OBTRANGODIRECTO ( RCVIGENCIA.VITCCONS,
                                        INUUNIDADES,
                                        RCRANGODIRECTO
                                      );
                                      
        TA_BOUTILITARIO.PRORRATEARPORFECHAS(IDTFECHAPERIODOINI,
                                            IDTFECHAPERIODOFIN,
                                            IDTFECHALIQINI,
                                            IDTFECHALIQFIN,
                                            RCRANGODIRECTO.RAVTVALO ,
                                            RCRANGODIRECTO.RAVTPORC ,
                                            NUVALORPRORRAT          ,
                                            NUPORCPRORRAT
                                        );
                                        
        
        NUVALORCONVERTIDO := NUVALORPRORRAT;
        
        
        IF ( IBOCONVERTIRMONEDA ) THEN

            CONVERTIRMONEDATARIFA(  RCVIGENCIA.VITCTACO,
                                    NUVALORPRORRAT,
                                    NUVALORCONVERTIDO
                                 );
        END IF;
        
        IF (GSBFORMALIQRANGODIR = CSBRANGO_VALOR) THEN
            APLICARVALORTARIFA(INUUNIDADES, NUVALORCONVERTIDO,  NUVALORTARIFATMP);
        ELSIF (GSBFORMALIQRANGODIR = CSBRANGO_PORC) THEN
            APLICARPORCTARIFA (INUUNIDADES, NUPORCPRORRAT,      NUPORCTARIFATMP);
        ELSE
            NUVALORTARIFATMP:= NULL;
            NUPORCTARIFATMP := NULL;
        END IF;

        APLICARVALORTARIFA(INUUNIDADES, NUVALORCONVERTIDO,  NUVALORTARIFATMP);
        
        APLICARPORCTARIFA (INUUNIDADES, NUPORCPRORRAT,      NUPORCTARIFATMP);
        
        
        TA_BOTARIFASLIQUIDADAS.ESTRANGOLIQUIDADO(   RCRANGODIRECTO,
                                                    INUUNIDADES,
                                                    NUVALORTARIFATMP,
                                                    NUPORCTARIFATMP
                                                 );

        ONUCODTARIFA    := RCVIGENCIA.VITCTACO;
        ONUCODVIGENCIA  := RCVIGENCIA.VITCCONS;
        ONUVALORTARIFA  := NUVALORCONVERTIDO;
        ONUPORCTARIFA   := NUPORCPRORRAT;

        
        TARIFAOBTENIDA();
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            TARIFANOOBTENIDA();
            RAISE;
        WHEN OTHERS THEN
            TARIFANOOBTENIDA();
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGODIRECTO;
    
    
























































    PROCEDURE LIQTARIFARANGODIRECFOT
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_RANGVITC.RAVTVALO%TYPE,
        ONUPORCTARIFA       OUT TA_RANGVITC.RAVTPORC%TYPE
    )
    IS
        NUCODTARIFA        TA_TARICONC.TACOCONS%TYPE;
        NUCODVIGENCIA      TA_VIGETACO.VITCCONS%TYPE;
        NUVALORTARIFA      TA_RANGVITC.RAVTVALO%TYPE;
        NUPORCTARIFA       TA_RANGVITC.RAVTPORC%TYPE;
    BEGIN
    
        TD('Buscando Tarifa LiqTarifaRangoDirecFOT. Concepto ['||INUCONCEPTO||']'
        ||' Servicio['||INUSERVICIO||']');
        
        
        
        IF (INUFOT = TA_BOUTILITARIO.CNUFOT4) THEN

            LIQTARIFARANGODIRFOT4(  INUSERVICIO        ,
                                    INUCONCEPTO        ,
                                    INUPRODUCTO        ,
                                    INUCONTRATO        ,
                                    IDTFECHAPERIODOINI ,
                                    IDTFECHAPERIODOFIN ,
                                    IDTFECHALIQINI     ,
                                    IDTFECHALIQFIN     ,
                                    INUUNIDADES        ,
                                    GBOCONVERTIRMONEDA ,
                                    IBOPERMPERS        ,
                                    NUCODTARIFA        ,
                                    NUCODVIGENCIA      ,
                                    NUVALORTARIFA      ,
                                    NUPORCTARIFA
                                 );

        ELSE
            
            LIQTARIFARANGODIRECTO(  INUSERVICIO       ,
                                    INUCONCEPTO       ,
                                    INUPRODUCTO       ,
                                    INUCONTRATO       ,
                                    IDTFECHAPERIODOINI,
                                    IDTFECHAPERIODOFIN,
                                    IDTFECHAVIGTARIFAS,
                                    IDTFECHALIQINI    ,
                                    IDTFECHALIQFIN    ,
                                    INUFOT            ,
                                    INUUNIDADES       ,
                                    GBOCONVERTIRMONEDA,
                                    IBOPERMPERS       ,
                                    NUCODTARIFA       , 
                                    NUCODVIGENCIA     , 
                                    NUVALORTARIFA     , 
                                    NUPORCTARIFA        
                                 );

        END IF;
        
        ONUCODTARIFA    := NUCODTARIFA;
        ONUCODVIGENCIA  := NUCODVIGENCIA;
        ONUVALORTARIFA  := NUVALORTARIFA;
        ONUPORCTARIFA   := NUPORCTARIFA;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGODIRECFOT;

    






























































    PROCEDURE LIQTARIFARANGODIRVAL
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_RANGVITC.RAVTVALO%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUCODTARIFA        TA_TARICONC.TACOCONS%TYPE;
        NUCODVIGENCIA      TA_VIGETACO.VITCCONS%TYPE;
        NUVALORTARIFA      TA_VIGETACO.VITCVALO%TYPE;
        NUVALORAPLICADO    CARGOS.CARGVALO%TYPE;
        NUPORCTARIFA       TA_VIGETACO.VITCPORC%TYPE;
    BEGIN
    
        TD('TA_BOTarifas.LiqTarifaRangoDirVal');
        
        ESTLIQRANGODIRVALPORC( CSBRANGO_VALOR );
        
        LIQTARIFARANGODIRECFOT( INUSERVICIO       ,
                                INUCONCEPTO       ,
                                INUPRODUCTO       ,
                                INUCONTRATO       ,
                                IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHAVIGTARIFAS,
                                IDTFECHALIQINI    ,
                                IDTFECHALIQFIN    ,
                                INUFOT            ,
                                INUUNIDADES       ,
                                IBOPERMPERS       ,
                                NUCODTARIFA       , 
                                NUCODVIGENCIA     , 
                                NUVALORTARIFA     , 
                                NUPORCTARIFA        
                             );

        
        IF ( INUUNIDADES IS NOT NULL ) THEN
            APLICARVALORTARIFA( INUUNIDADES, NUVALORTARIFA, NUVALORAPLICADO );
        END IF;

        ONUCODTARIFA     := NUCODTARIFA;
        ONUCODVIGENCIA   := NUCODVIGENCIA;
        ONUVALORTARIFA   := NUVALORTARIFA;
        ONUVALORAPLICADO := NUVALORAPLICADO;
        ESTLIQRANGODIRVALPORC( NULL );


    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            ESTLIQRANGODIRVALPORC( NULL );
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            ESTLIQRANGODIRVALPORC( NULL );
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGODIRVAL;

    






























































    PROCEDURE LIQTARIFARANGODIRPORC
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUPORCTARIFA       OUT TA_RANGVITC.RAVTPORC%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUCODTARIFA        TA_TARICONC.TACOCONS%TYPE;
        NUCODVIGENCIA      TA_VIGETACO.VITCCONS%TYPE;
        NUVALORTARIFA      TA_VIGETACO.VITCVALO%TYPE;
        NUVALORAPLICADO    CARGOS.CARGVALO%TYPE;
        NUPORCTARIFA       TA_VIGETACO.VITCPORC%TYPE;

        
        BOCONVERTIRACTUAL  BOOLEAN;
    BEGIN
    
        
        BOCONVERTIRACTUAL := GBOCONVERTIRMONEDA;

        
        GBOCONVERTIRMONEDA := FALSE;

        ESTLIQRANGODIRVALPORC( CSBRANGO_PORC );
        
        LIQTARIFARANGODIRECFOT( INUSERVICIO       ,
                                INUCONCEPTO       ,
                                INUPRODUCTO       ,
                                INUCONTRATO       ,
                                IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHAVIGTARIFAS,
                                IDTFECHALIQINI    ,
                                IDTFECHALIQFIN    ,
                                INUFOT            ,
                                INUUNIDADES       ,
                                IBOPERMPERS       ,
                                NUCODTARIFA       , 
                                NUCODVIGENCIA     , 
                                NUVALORTARIFA     , 
                                NUPORCTARIFA        
                             );
                             
        
        GBOCONVERTIRMONEDA := BOCONVERTIRACTUAL;

        
        IF ( INUUNIDADES IS NOT NULL ) THEN
            APLICARPORCTARIFA( INUUNIDADES, NUPORCTARIFA, NUVALORAPLICADO );
        END IF;

        ONUCODTARIFA     := NUCODTARIFA;
        ONUCODVIGENCIA   := NUCODVIGENCIA;
        ONUPORCTARIFA    := NUPORCTARIFA;
        ONUVALORAPLICADO := NUVALORAPLICADO;
        ESTLIQRANGODIRVALPORC( NULL );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            ESTLIQRANGODIRVALPORC( NULL );
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            ESTLIQRANGODIRVALPORC( NULL );
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGODIRPORC;
    
    












































































    PROCEDURE LIQTARIFARANGOSFOT4
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUUNIDADES         IN  NUMBER,
        IBOCONVERTIRMONEDA  IN  BOOLEAN,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE,
        ONUPORCAPLICADO     OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUVALORAPLICADO     CARGOS.CARGVALO%TYPE;
        NUPORCAPLICADO      CARGOS.CARGVALO%TYPE;
        TBTARIFAS           TA_BCTARICONC.TTYTA_TARICONC;
        TBVIGENCIAS         TA_BCVIGETACO.TTYTA_VIGETACO;
        TBRANGOS            TA_BCRANGVITC.TTYTA_RANGVITC;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        DTFECHAINI          DATE;
        DTFECHAFIN          DATE;
    BEGIN
    

        TD('Buscando Tarifa LiqTarifaRangosFOT4. Concepto ['||INUCONCEPTO||']');

        
        OBTFECHASFOT( TA_BOUTILITARIO.CNUFOT4,
                      IDTFECHAPERIODOINI,
                      IDTFECHAPERIODOFIN,
                      NULL,
                      IDTFECHALIQINI,
                      IDTFECHALIQFIN,
                      DTFECHAINI,
                      DTFECHAFIN
                    );

        
        OBTTARIFASPORCONCEPTO(  INUSERVICIO ,
                                INUCONCEPTO ,
                                INUPRODUCTO ,
                                INUCONTRATO ,
                                DTFECHAINI  ,
                                DTFECHAFIN  ,
                                IBOPERMPERS ,
                                TBTARIFAS
                               );

        
        OBTVIGENCIAPORTARIFAS(  TBTARIFAS  ,
                                DTFECHAINI ,
                                DTFECHAFIN ,
                                TBVIGENCIAS 
                              );

        
        
        PROCESARVIGRANGFOT4 (   IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHALIQINI    ,
                                IDTFECHALIQFIN    ,
                                INUUNIDADES       ,
                                TBVIGENCIAS       ,
                                RCVIGENCIA        ,
                                NUVALORAPLICADO   ,
                                NUPORCAPLICADO     
                             );

        ONUCODTARIFA    := RCVIGENCIA.VITCTACO;
        ONUCODVIGENCIA  := RCVIGENCIA.VITCCONS;
        ONUVALORAPLICADO:= NUVALORAPLICADO;
        ONUPORCAPLICADO := NUPORCAPLICADO;

        
        TARIFAOBTENIDA();
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            TARIFANOOBTENIDA();
            RAISE;
        WHEN OTHERS THEN
            TARIFANOOBTENIDA();
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGOSFOT4;
    
    


































































    PROCEDURE LIQTARIFARANGOS
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOCONVERTIRMONEDA  IN  BOOLEAN,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE,
        ONUPORCAPLICADO     OUT CARGOS.CARGVALO%TYPE
    )
    IS
        SBMENSAJE           GE_ERROR_LOG.DESCRIPTION%TYPE;
        NUVALORTARIFA       CARGOS.CARGVALO%TYPE;
        NUPORCTARIFA        CARGOS.CARGVALO%TYPE;
        TBTARIFAS           TA_BCTARICONC.TTYTA_TARICONC;
        TBVIGENCIAS         TA_BCVIGETACO.TTYTA_VIGETACO;
        TBTA_RANGVITC       TA_BCRANGVITC.TTYTA_RANGVITC;
        RCVIGENCIA          TA_VIGETACO%ROWTYPE;
        DTFECHAINI          DATE;
        DTFECHAFIN          DATE;
        NUDIASBASE          NUMBER;
        NUDIASLIQ           NUMBER;
    BEGIN
    

        TD('Buscando Tarifa LiqTarifaRangos. Concepto ['||INUCONCEPTO||']');

        
        OBTFECHASFOT( INUFOT,
                      IDTFECHAPERIODOINI,
                      IDTFECHAPERIODOFIN,
                      IDTFECHAVIGTARIFAS,
                      IDTFECHALIQINI,
                      IDTFECHALIQFIN,
                      DTFECHAINI,
                      DTFECHAFIN
                    );

        
        OBTTARIFASPORCONCEPTO(  INUSERVICIO ,
                                INUCONCEPTO ,
                                INUPRODUCTO ,
                                INUCONTRATO ,
                                DTFECHAINI  ,
                                DTFECHAFIN  ,
                                IBOPERMPERS ,
                                TBTARIFAS
                              );

        
        OBTVIGENCIAPORTARIFAS(  TBTARIFAS  ,
                                DTFECHAINI ,
                                DTFECHAFIN ,
                                TBVIGENCIAS
                              );


        
        PROCESARVIGENCIASFOT (  INUFOT,
                                DTFECHAINI,
                                DTFECHAFIN,
                                NULL,
                                NULL,
                                TBVIGENCIAS,
                                FALSE,
                                RCVIGENCIA
                             );
                             
        
        TA_BORANGVITC.OBTRANGOSPORVIGENCIAEX( RCVIGENCIA.VITCCONS,
                                              TBTA_RANGVITC
                                            );

        NUDIASBASE :=   IDTFECHAPERIODOFIN - IDTFECHAPERIODOINI +
                        TA_BOUTILITARIO.CNUSEGUNDOENDIAS;
        NUDIASLIQ  :=   IDTFECHALIQFIN  - IDTFECHALIQINI +
                        TA_BOUTILITARIO.CNUSEGUNDOENDIAS;
                        
        
        PROCESARRANGOS( INUUNIDADES,
                        NUDIASBASE,
                        NUDIASLIQ,
                        TBTA_RANGVITC,
                        RCVIGENCIA.VITCTACO,
                        NUVALORTARIFA,
                        NUPORCTARIFA );

        ONUCODTARIFA    := RCVIGENCIA.VITCTACO;
        ONUCODVIGENCIA  := RCVIGENCIA.VITCCONS;
        ONUVALORAPLICADO:= NUVALORTARIFA;
        ONUPORCAPLICADO := NUPORCTARIFA;

        
        TARIFAOBTENIDA();
    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            TARIFANOOBTENIDA();
            RAISE;
        WHEN OTHERS THEN
            TARIFANOOBTENIDA();
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGOS;

    

























































    PROCEDURE LIQTARIFARANGOSFOT
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHAPERIODOINI  IN  PERICOSE.PECSFECI%TYPE,
        IDTFECHAPERIODOFIN  IN  PERICOSE.PECSFECF%TYPE,
        IDTFECHAVIGTARIFAS  IN  SERVSUSC.SESUFEVI%TYPE,
        IDTFECHALIQINI      IN  DATE,
        IDTFECHALIQFIN      IN  DATE,
        INUFOT              IN  NUMBER,
        INUUNIDADES         IN  NUMBER,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORAPLICADO    OUT CARGOS.CARGVALO%TYPE,
        ONUPORCAPLICADO     OUT CARGOS.CARGVALO%TYPE
    )
    IS
        NUCODTARIFA        TA_TARICONC.TACOCONS%TYPE;
        NUCODVIGENCIA      TA_VIGETACO.VITCCONS%TYPE;
        NUVALORTARIFA      CARGOS.CARGVALO%TYPE;
        NUPORCTARIFA       CARGOS.CARGVALO%TYPE;
        RCRANGODIRECTO     TA_RANGVITC%ROWTYPE;
    BEGIN
    
        TD('Buscando Tarifa LiqTarifaRangosFOT. Concepto ['||INUCONCEPTO||']'
        ||' Servicio['||INUSERVICIO||']');
        
        
        
        IF (INUFOT = TA_BOUTILITARIO.CNUFOT4) THEN

           LIQTARIFARANGOSFOT4( INUSERVICIO        ,
                                INUCONCEPTO        ,
                                INUPRODUCTO        ,
                                INUCONTRATO        ,
                                IDTFECHAPERIODOINI ,
                                IDTFECHAPERIODOFIN ,
                                IDTFECHALIQINI     ,
                                IDTFECHALIQFIN     ,
                                INUUNIDADES        ,
                                GBOCONVERTIRMONEDA ,
                                IBOPERMPERS        ,
                                NUCODTARIFA        ,
                                NUCODVIGENCIA      ,
                                NUVALORTARIFA      ,
                                NUPORCTARIFA
                              );
        ELSE
            
            LIQTARIFARANGOS(    INUSERVICIO,
                                INUCONCEPTO,
                                INUPRODUCTO,
                                INUCONTRATO,
                                IDTFECHAPERIODOINI,
                                IDTFECHAPERIODOFIN,
                                IDTFECHAVIGTARIFAS,
                                IDTFECHALIQINI    ,
                                IDTFECHALIQFIN    ,
                                INUFOT            ,
                                INUUNIDADES       ,
                                GBOCONVERTIRMONEDA, 
                                IBOPERMPERS       ,
                                NUCODTARIFA       , 
                                NUCODVIGENCIA     , 
                                NUVALORTARIFA     , 
                                NUPORCTARIFA        
                            );
        END IF;

        ONUCODTARIFA    := NUCODTARIFA;
        ONUCODVIGENCIA  := NUCODVIGENCIA;
        ONUVALORAPLICADO:= NUVALORTARIFA;
        ONUPORCAPLICADO := NUPORCTARIFA;

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFARANGOSFOT;
    

    
    


    







































    PROCEDURE LIQTARIFADATOSBASICOS
    (
        INUSERVICIO         IN  TA_CONFTACO.COTCSERV%TYPE,
        INUCONCEPTO         IN  CONCEPTO.CONCCODI%TYPE,
        INUPRODUCTO         IN  TA_TARICONC.TACOSESU%TYPE,
        INUCONTRATO         IN  TA_TARICONC.TACOSUSC%TYPE,
        IDTFECHALIQ         IN  PERICOSE.PECSFECF%TYPE,
        IBOPERMPERS         IN  BOOLEAN,
        ONUCODTARIFA        OUT TA_TARICONC.TACOCONS%TYPE,
        ONUCODVIGENCIA      OUT TA_VIGETACO.VITCCONS%TYPE,
        ONUVALORTARIFA      OUT TA_VIGETACO.VITCVALO%TYPE,
        ONUPORCTARIFA       OUT TA_VIGETACO.VITCPORC%TYPE
    )
    IS
    BEGIN
    
        TD('TA_BOTarifas.LiqTarifaDatosBasicos');
        
        LIQTARIFA
        (
            INUSERVICIO,
            INUCONCEPTO,
            INUPRODUCTO,
            INUCONTRATO,
            IDTFECHALIQ,
            IDTFECHALIQ,
            NULL,
            NULL,
            NULL,
            TA_BOUTILITARIO.CNUFOT1,
            IBOPERMPERS,
            ONUCODTARIFA,
            ONUCODVIGENCIA,
            ONUVALORTARIFA,
            ONUPORCTARIFA
        );

    EXCEPTION
        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
            RAISE;
        WHEN OTHERS THEN
            PKERRORS.NOTIFYERROR(PKERRORS.FSBLASTOBJECT, SQLERRM, SBMSJERR);
            RAISE_APPLICATION_ERROR(PKCONSTANTE.NUERROR_LEVEL2, SBMSJERR);
    
    END LIQTARIFADATOSBASICOS;
    
END TA_BOTARIFAS;