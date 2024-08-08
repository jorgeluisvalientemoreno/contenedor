PACKAGE FI_BOVentasDirectasFinanciadas AS
























    
    
    
    
    TYPE TYRCCARGO IS RECORD
    (
        CARGCONC            CARGOS.CARGCONC%TYPE,
        CARGVALO            CARGOS.CARGVALO%TYPE,
        CARGSIGN            CARGOS.CARGSIGN%TYPE
    );
    
    TYPE TYTBCARGOS IS TABLE OF TYRCCARGO
        INDEX BY BINARY_INTEGER;
    
    
    
    
    
    
    
    
    
    
    
    
    
    FUNCTION FSBVERSION RETURN VARCHAR2;

    
    PROCEDURE REGISTRAR
    (
        INUPRODUCTO     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPLANDIFE     IN  PLANDIFE.PLDICODI%TYPE,
        INUDIFENUCU     IN  DIFERIDO.DIFENUCU%TYPE,
        ISBDOCUSOPO     IN  CARGOS.CARGDOSO%TYPE,
        ITBCARGOS       IN  TYTBCARGOS,
        ISBDIFEPROG     IN  DIFERIDO.DIFEPROG%TYPE,
        ONUDIFECOFI     OUT DIFERIDO.DIFECOFI%TYPE
    );

END FI_BOVENTASDIRECTASFINANCIADAS;

PACKAGE BODY FI_BOVentasDirectasFinanciadas AS






































































    
    
    
    SBERRMSG            GE_ERROR_LOG.DESCRIPTION%TYPE;
    
    
    
    

    
    
    
    
    CSBVERSION          CONSTANT VARCHAR2(10) := 'SAO201863';
    
    
    CSBDIRECT_SALES     CONSTANT PARAMETR.PAMECODI%TYPE := 'DIRECT_SALES';
    
    
    
    
    
    
    
    

    
























    FUNCTION FSBVERSION RETURN VARCHAR2
    IS
    BEGIN
    
        
        RETURN ( CSBVERSION );

    EXCEPTION

        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 THEN
        	PKERRORS.POP;
        	RAISE;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        	PKERRORS.POP;
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END FSBVERSION;


    
















































































    PROCEDURE REGISTRAR
    (
        INUPRODUCTO     IN  SERVSUSC.SESUNUSE%TYPE,
        INUPLANDIFE     IN  PLANDIFE.PLDICODI%TYPE,
        INUDIFENUCU     IN  DIFERIDO.DIFENUCU%TYPE,
        ISBDOCUSOPO     IN  CARGOS.CARGDOSO%TYPE,
        ITBCARGOS       IN  TYTBCARGOS,
        ISBDIFEPROG     IN  DIFERIDO.DIFEPROG%TYPE,
        ONUDIFECOFI     OUT DIFERIDO.DIFECOFI%TYPE
    )
    IS

        
        
        
        
        
        
        
        
        
        SBDOCUSOPO              DIFERIDO.DIFENUDO%TYPE;
        
        
        
        SBDIFEPROG              DIFERIDO.DIFEPROG%TYPE;
        
        
        RCPRODUCTO              SERVSUSC%ROWTYPE;
        
        
        RCPLANDIFE              PLANDIFE%ROWTYPE;
        
        
        NUFACTURA               FACTURA.FACTCODI%TYPE;
        
        
        
        
        
        
        
        PROCEDURE INICIALIZAR
        IS
        BEGIN
        
            UT_TRACE.TRACE( 'Inicio: [FI_BOVentasDirectasFinanciadas.Registrar.Inicializar]', 6 );

            
            SBDIFEPROG := SUBSTR( ISBDIFEPROG, 0, 10 );
            SBDOCUSOPO := SUBSTR( ISBDOCUSOPO, 0, 10 );

        	
        	ONUDIFECOFI := NULL;

            UT_TRACE.TRACE( 'Fin: [FI_BOVentasDirectasFinanciadas.Registrar.Inicializar]', 6 );

        EXCEPTION

            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            	RAISE;

            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        
        END INICIALIZAR;
        
        
        
        PROCEDURE VALIDARDATOSENTRADA
        IS
        
            
            NUIDXCARGOS             BINARY_INTEGER;
            
        BEGIN
        
            UT_TRACE.TRACE( 'Inicio: [FI_BOVentasDirectasFinanciadas.Registrar.ValidarDatosEntrada]', 6 );
        	
        	
            PKSERVNUMBERMGR.VALBASICDATA( INUPRODUCTO );
            
            
            RCPRODUCTO := PKTBLSERVSUSC.FRCGETRECORD( INUPRODUCTO );
            
            
            PKDEFERREDPLANMGR.VALBASICDATA( INUPLANDIFE );
            
            
            PKDEFERREDPLANMGR.VALIDATEEXPIRYDATE( INUPLANDIFE );
            
            
            RCPLANDIFE := PKTBLPLANDIFE.FRCGETRECORD( INUPLANDIFE );
            
            
            PKDEFERREDPLANMGR.VALQUOTASNUMBER
            (
                INUPLANDIFE,
                INUDIFENUCU
            );

            
            IF ( SBDOCUSOPO IS NULL ) THEN
            
                
                PKERRORS.SETERRORCODE
                (
                    PKCONSTANTE.CSBDIVISION,
                    PKCONSTANTE.CSBMOD_SAT,
                    9507
                );
                RAISE LOGIN_DENIED;
            
            END IF;
            
            
            IF ( ITBCARGOS.COUNT = 0 ) THEN
            
                
                PKERRORS.SETERRORCODE
                (
                    PKCONSTANTE.CSBDIVISION,
                    PKCONSTANTE.CSBMOD_BIL,
                    10965
                );
                RAISE LOGIN_DENIED;
            
            END IF;
            
            
            IF ( SBDIFEPROG IS NULL ) THEN
            
                
                PKERRORS.SETERRORCODE
                (
                    PKCONSTANTE.CSBDIVISION,
                    PKCONSTANTE.CSBMOD_SAT,
                    9568
                );
                RAISE LOGIN_DENIED;
            
            END IF;


            NUIDXCARGOS := ITBCARGOS.FIRST;

        	LOOP

                
                EXIT WHEN NUIDXCARGOS IS NULL;

                
                IF ( ITBCARGOS( NUIDXCARGOS ).CARGVALO <= PKBILLCONST.CERO ) THEN
                
                    
                    PKERRORS.SETERRORCODE
                    (
                        PKCONSTANTE.CSBDIVISION,
                        PKCONSTANTE.CSBMOD_SAT,
                        9116
                    );
                
                END IF;
                
                
                FA_BOPOLITICAREDONDEO.VALIDAPOLITICA
                (
                    INUPRODUCTO,
                    ITBCARGOS( NUIDXCARGOS ).CARGVALO
                );

                
                NUIDXCARGOS := ITBCARGOS.NEXT( NUIDXCARGOS );

        	END LOOP;

            UT_TRACE.TRACE( 'Fin: [FI_BOVentasDirectasFinanciadas.Registrar.ValidarDatosEntrada]', 6 );

        EXCEPTION

            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            	RAISE;

            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        
        END VALIDARDATOSENTRADA;
        
        

        PROCEDURE GENERARFACTURAVENTA
        IS

            
            NUIDXCARGOS             BINARY_INTEGER;

            
            NUCUENTACOBRO           CUENCOBR.CUCOCODI%TYPE;

            
            NUSALDOFACTURA          NUMBER;

            
            NUCODIGOERROR           MENSAJE.MENSCODI%TYPE;

            
            NUMENSAJEERROR          MENSAJE.MENSDESC%TYPE;
            
            NUVALOR                 CARGOS.CARGVALO%TYPE;
            NUBASE                  CARGOS.CARGVABL%TYPE;
            
            
            NUCAUSACARGOVENTA       CAUSCARG.CACACODI%TYPE;

        BEGIN
        
            UT_TRACE.TRACE( 'Inicio: [FI_BOVentasDirectasFinanciadas.Registrar.GenerarFacturaVenta]', 6 );
        	
            
            NUCAUSACARGOVENTA := FA_BOCHARGECAUSES.FNUDIRECTSALESCHCAUSE(RCPRODUCTO.SESUSERV);

            
            NUIDXCARGOS := ITBCARGOS.FIRST;

        	LOOP

                
                EXIT WHEN NUIDXCARGOS IS NULL;

                
                PKCONCEPTMGR.VALBASICDATA( ITBCARGOS( NUIDXCARGOS ).CARGCONC );

                
                IF ( ITBCARGOS( NUIDXCARGOS ).CARGVALO <= PKBILLCONST.CERO ) THEN
                
                    
                    PKERRORS.SETERRORCODE
                    (
                        PKCONSTANTE.CSBDIVISION,
                        PKCONSTANTE.CSBMOD_SAT,
                        9116
                    );
                
                END IF;

                
                PKSIGNMGR.VALIDATENULL( ITBCARGOS( NUIDXCARGOS ).CARGSIGN );

                IF ( ITBCARGOS( NUIDXCARGOS ).CARGSIGN NOT IN ( PKBILLCONST.DEBITO, PKBILLCONST.CREDITO ) ) THEN
                
                    
                    PKERRORS.SETERRORCODE
                    (
                        PKCONSTANTE.CSBDIVISION,
                        PKCONSTANTE.CSBMOD_SAT,
                        9521
                    );
                    RAISE LOGIN_DENIED;
                
                END IF;

                NUVALOR := ITBCARGOS( NUIDXCARGOS ).CARGVALO;

                
                NUBASE := FNUCALCULAIMPUESTO
                                            (
                                                INUPRODUCTO,
                                                ITBCARGOS( NUIDXCARGOS ).CARGCONC,
                                                NUVALOR,
                                                NULL,
                                                PKBILLCONST.CNUOBTIENE_BASE
                                            );

                
                PKCHARGEMGR.SETBASEVALUE (NUBASE);

                
                PKCHARGEMGR.GENERATECHARGE
                (
                    INUPRODUCTO,
                    PKCONSTANTE.NULLNUM,
                    ITBCARGOS( NUIDXCARGOS ).CARGCONC,
                    NUCAUSACARGOVENTA,
                    NUVALOR,
                    ITBCARGOS( NUIDXCARGOS ).CARGSIGN,
                    SBDOCUSOPO
                );

                
                NUIDXCARGOS := ITBCARGOS.NEXT( NUIDXCARGOS );

        	END LOOP;

        	
        	PKGENERATEINVOICE.GENERATEBYSUPPDOC
        	(
        	    RCPRODUCTO.SESUSUSC,
        	    RCPRODUCTO.SESUNUSE,
        	    SBDOCUSOPO,
        	    NUFACTURA,
        	    NUCUENTACOBRO,
                NUSALDOFACTURA,
                NUCODIGOERROR,
                NUMENSAJEERROR
            );

            
            IF ( NUCODIGOERROR <> PKCONSTANTE.EXITO ) THEN
                RAISE LOGIN_DENIED;
            END IF;

            UT_TRACE.TRACE( 'Factura generada [' || TO_CHAR( NUFACTURA )
                || '] Cuenta de Cobro [' || TO_CHAR( NUCUENTACOBRO ) || ']', 7 );
            UT_TRACE.TRACE( 'Fin: [FI_BOVentasDirectasFinanciadas.Registrar.GenerarFacturaVenta]', 6 );

        EXCEPTION

            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            	RAISE;

            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        
        END GENERARFACTURAVENTA;

        
        
        PROCEDURE FINANCIARCONCEPTOSFACTURA
        IS

            
            NUNUMPRODSFINANC            NUMBER;
            
            
            ONUACUMCUOTA                NUMBER;
            ONUSALDO                    NUMBER;
            ONUTOTALACUMCAPITAL         NUMBER;
            ONUTOTALACUMCUOTEXTR        NUMBER;
            ONUTOTALACUMINTERES         NUMBER;
            OSBREQUIEREVISADO           VARCHAR2(1);

            NUINTERATE		            DIFERIDO.DIFEINTE%TYPE;	
            NUQUOTAMETHOD	            DIFERIDO.DIFEMECA%TYPE;	
            NUTAINCODI	                PLANDIFE.PLDITAIN%TYPE;	
            BOSPREAD                    BOOLEAN;
        
        BEGIN
        
            UT_TRACE.TRACE( 'Inicio: [FI_BOVentasDirectasFinanciadas.Registrar.FinanciarConceptosFactura]', 6 );
        	
        	
            IF( PKBCACCOUNTSTATUS.FNUGETBALANCE( NUFACTURA ) = PKBILLCONST.CERO )THEN
                RETURN;
            END IF;
        	
        	
        	PKDEFERREDMGR.NUGETNEXTFINCCODE( ONUDIFECOFI );

            
            
            CC_BOFINANCING.SETACCOUNTSTATUS( NUFACTURA, GE_BOCONSTANTS.CSBYES, PKCONSTANTE.NO, PKCONSTANTE.NO );
            
            
            
            CC_BCFINANCING.SELECTALLOWEDPRODUCTS( PKCONSTANTE.SI, NUNUMPRODSFINANC );
            
            
            
            CC_BCFINANCING.SETDISCOUNT( RCPLANDIFE.PLDICODI );
            
            
            PKDEFERREDPLANMGR.VALPLANCONFIG (
                RCPLANDIFE.PLDICODI,
                PKGENERALSERVICES.FDTGETSYSTEMDATE,
                NUQUOTAMETHOD,
                NUTAINCODI,
                NUINTERATE,
                BOSPREAD
            );
            
            
            CC_BOFINANCING.EXECDEBTFINANC
            (
                RCPLANDIFE.PLDICODI,
                RCPLANDIFE.PLDIMCCD,
                PKGENERALSERVICES.FDTGETSYSTEMDATE,
                NUINTERATE,
                PKBILLCONST.CERO,
                INUDIFENUCU,
                SBDOCUSOPO,
                PKBILLCONST.CIENPORCIEN,
                PKBILLCONST.CERO,
                PKCONSTANTE.NO,
                SBDIFEPROG,
                PKCONSTANTE.NO,
                PKCONSTANTE.NO,
                ONUDIFECOFI,
                ONUACUMCUOTA,
                ONUSALDO,
                ONUTOTALACUMCAPITAL,
                ONUTOTALACUMCUOTEXTR,
                ONUTOTALACUMINTERES,
                OSBREQUIEREVISADO
            );
            
            
            CC_BOFINANCING.COMMITFINANC;
            
            
            IF ( NOT CC_BCFINANCING.FBOEXISTDEFERRED( ONUDIFECOFI ) ) THEN
                
                ONUDIFECOFI := NULL;
            END IF;

            UT_TRACE.TRACE( 'Fin: [FI_BOVentasDirectasFinanciadas.Registrar.FinanciarConceptosFactura]', 6 );

        EXCEPTION

            WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
            	RAISE;

            WHEN OTHERS THEN
            	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
            	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
        
        END FINANCIARCONCEPTOSFACTURA;
        
        
        
    BEGIN
    
        UT_TRACE.TRACE( 'Inicio: [FI_BOVentasDirectasFinanciadas.Registrar', 6 );

        
        INICIALIZAR;

        
        VALIDARDATOSENTRADA;
        
        
        PKERRORS.SETAPPLICATION( SBDIFEPROG );
        
        
        GENERARFACTURAVENTA;
        
        
        FINANCIARCONCEPTOSFACTURA;

        UT_TRACE.TRACE( 'Fin: [FI_BOVentasDirectasFinanciadas.Registrar', 6 );

    EXCEPTION

        WHEN LOGIN_DENIED OR PKCONSTANTE.EXERROR_LEVEL2 OR EX.CONTROLLED_ERROR THEN
        	RAISE;

        WHEN OTHERS THEN
        	PKERRORS.NOTIFYERROR( PKERRORS.FSBLASTOBJECT, SQLERRM, SBERRMSG );
        	RAISE_APPLICATION_ERROR( PKCONSTANTE.NUERROR_LEVEL2, SBERRMSG );
    
    END REGISTRAR;

END FI_BOVENTASDIRECTASFINANCIADAS;