PACKAGE BODY CC_BORequestRating IS







































































	
    
    CSBVERSION  CONSTANT VARCHAR2(250)  := 'SAO199558';
    
    
    CNUIMPUTABLEALCLIENTESANCION CONSTANT GE_ATTRIBUTED_TO.ATTRIBUTED_TO%TYPE := 3;

	
    
    
    
    FUNCTION FSBVERSION  RETURN VARCHAR2 IS
    BEGIN
        RETURN CSBVERSION;
    END;

    





































    PROCEDURE LIQSINGLEREQUEST
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    	
        NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        SBDOCUMENT          CARGOS.CARGDOSO%TYPE;
        NUPROGRAMID         CARGOS.CARGPROG%TYPE;
        NUCOMM_PLAN_ID      PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE;
        NUPACKAGEPAYMENTID  MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
        NUSTATUSANNULMOT    PS_MOTIVE_STATUS.MOTIVE_STATUS_ID%TYPE;

        
        
        

        PROCEDURE GETPROCESSDATA IS
        BEGIN
            UT_TRACE.TRACE('Inicio de CC_BORequestRating.LiqSingleRequest.GetProcessData',7);

            
            SBDOCUMENT := CC_BOCONSTANTS.CSBPREFIJODOC||CC_BOCONSTANTS.CSBSEPDOCPAYMENT||INUPACKAGEID;
            
            NUPROGRAMID := GE_BCPROCESOS.FRCPROGRAMA(CC_BOCONSTANTS.CSBCUSTOMERCARE).PROCCONS;
            
            MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT( INUPACKAGEID, NUPACKAGEPAYMENTID, FALSE );
            
            NUSTATUSANNULMOT := GE_BOPARAMETER.FNUGET(MO_BOCONSTANTS.CSBSTATUS_ANNUL_MOT);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
        
        PROCEDURE SETPROCESSDATAFGCA
        IS
        BEGIN
            UT_TRACE.TRACE('Inicio de CC_BORequestRating.LiqSingleRequest.SetProcessDataFGCA',7);

            
            PKINSTANCEDATAMGR.SETCG_SUPPDOCU (SBDOCUMENT);

         	
    	    PKINSTANCEDATAMGR.SETTG_PACKAGE (INUPACKAGEID);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
        
        PROCEDURE PROCESSREQUEST
        IS
            NUERRORCODE           GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    		SBERRORMESSAGE        GE_ERROR_LOG.DESCRIPTION%TYPE;
    		NUERRORLOGID          GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    		NURATING_PACKAGE_ID   MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
    		RCMOTIVE              DAMO_MOTIVE.STYMO_MOTIVE;
    		TBMOTIVES             DAMO_MOTIVE.TYTBMO_MOTIVE;
    		NUINDX                BINARY_INTEGER;
        BEGIN
            UT_TRACE.TRACE('CC_BORequestRating.LiqSingleRequest.ProcessRequest',7);
            NUERRORCODE :=  GE_BOCONSTANTS.CNUNULLNUM;
            
            
            RCMOTIVE        := MO_BOPACKAGES.FRCGETINITIALMOTIVE(INUPACKAGEID);

            
            NUPRODUCTID     := RCMOTIVE.PRODUCT_ID;
            
            
            NUCOMM_PLAN_ID  := RCMOTIVE.COMMERCIAL_PLAN_ID;
            
            
            IF (NUCOMM_PLAN_ID IS NULL) THEN
                NUCOMM_PLAN_ID := DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID(NUPRODUCTID);
            END IF;

    		
            MO_BOPACKAGEPAYMENT.INSERTREGBASIC(INUPACKAGEID,
                                               NUCOMM_PLAN_ID,
                                               NURATING_PACKAGE_ID);
                                               
            UT_TRACE.TRACE('Insert� mo_package_payment '||NURATING_PACKAGE_ID,8);

    	    
            FA_BOREQUESTLIQ.LIQUIDATE(NUPRODUCTID,
    		                          NUPROGRAMID,
                                      INUPACKAGEID,
                                      NULL,
                                      SBDOCUMENT,
    		                          NUERRORCODE,
    		                          SBERRORMESSAGE,
                                      NUERRORLOGID);
    		                          
            UT_TRACE.TRACE('Resultado FA_BORequestLiq.Liquidate Solicitud['||INUPACKAGEID||'] '||NUERRORCODE||' '||SBERRORMESSAGE,8);

            IF (  NUERRORCODE != GE_BOCONSTANTS.OK) THEN
		        ERRORS.SETERROR(CC_BOCONSTERROR.CNUBILLBACKERROR,'Liquidaci�n de Solicitudes' ||'|'|| NUERRORLOGID);
    		   	RAISE EX.CONTROLLED_ERROR ;
    		END IF;

            
            TBMOTIVES := MO_BCMOTIVE.FTBALLMOTIVESBYPACK(INUPACKAGEID);
            
            
            NUINDX := TBMOTIVES.FIRST;
            LOOP
                EXIT WHEN NUINDX IS NULL;
                
                IF (TBMOTIVES(NUINDX).MOTIVE_STATUS_ID <> NUSTATUSANNULMOT) THEN
                    
                    FA_BOREQUESTLIQ.LIQUIDATE(TBMOTIVES(NUINDX).PRODUCT_ID,
            		                          NUPROGRAMID,
                                              INUPACKAGEID,
                                              TBMOTIVES(NUINDX).MOTIVE_ID,
                                              SBDOCUMENT,
            		                          NUERRORCODE,
            		                          SBERRORMESSAGE,
                                              NUERRORLOGID);

                    UT_TRACE.TRACE('Resultado FA_BORequestLiq.Liquidate Motivo['||TBMOTIVES(NUINDX).MOTIVE_ID||'] '||NUERRORCODE||' '||SBERRORMESSAGE,9);

                    IF (  NUERRORCODE != GE_BOCONSTANTS.OK) THEN
                        ERRORS.SETERROR(CC_BOCONSTERROR.CNUBILLBACKERROR,'Liquidaci�n de Solicitudes' ||'|'|| NUERRORLOGID);
            		   	RAISE EX.CONTROLLED_ERROR;
            		END IF;
                END IF;
                
                NUINDX := TBMOTIVES.NEXT(NUINDX);
            END LOOP;

            UT_TRACE.TRACE('Termina CC_BORequestRating.LiqSingleRequest.ProcessRequest',7);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
        
    BEGIN
        UT_TRACE.TRACE('Inicia LiqSingleRequest',6);

        GETPROCESSDATA;

        IF (NUPACKAGEPAYMENTID IS NULL) THEN

		    SETPROCESSDATAFGCA;

		    PROCESSREQUEST;

        END IF;

        UT_TRACE.TRACE('Termina LiqSingleRequest',6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    



























    PROCEDURE LIQREQUEST
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUFIRSTPACKID      IN  MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    	
        NUPRODUCTID     PR_PRODUCT.PRODUCT_ID%TYPE;
        SBDOCUMENT      CARGOS.CARGDOSO%TYPE;
        NUPROGRAMID     CARGOS.CARGPROG%TYPE;
        NUPACKAGEPAYMENTID  MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;

        
        
        

        PROCEDURE GETPROCESSDATA IS
        BEGIN
            UT_TRACE.TRACE('Inicio de CC_BORequestRating.LiqRequest.GetProcessData',7);

            
            SBDOCUMENT := CC_BOCONSTANTS.CSBPREFIJODOC||CC_BOCONSTANTS.CSBSEPDOCPAYMENT||INUFIRSTPACKID;
            
            NUPROGRAMID := GE_BCPROCESOS.FRCPROGRAMA(CC_BOCONSTANTS.CSBCUSTOMERCARE).PROCCONS;
            
            MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT( INUPACKAGEID, NUPACKAGEPAYMENTID, FALSE );
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
        
        PROCEDURE SETPROCESSDATAFGCA
        IS
        BEGIN
            UT_TRACE.TRACE('Inicio de CC_BORequestRating.LiqRequest.SetProcessDataFGCA',7);

            
            PKINSTANCEDATAMGR.SETCG_SUPPDOCU (SBDOCUMENT);

         	
    	    PKINSTANCEDATAMGR.SETTG_PACKAGE (INUPACKAGEID);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
        
        PROCEDURE PROCESSREQUEST
        IS
            NUERRORCODE           GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    		SBERRORMESSAGE        GE_ERROR_LOG.DESCRIPTION%TYPE;
    		NUERRORLOGID          GE_ERROR_LOG.ERROR_LOG_ID%TYPE;
    		NURATING_PACKAGE_ID   MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
    		TBMOTIVES             DAMO_MOTIVE.TYTBMO_MOTIVE;
    		NUINDX                BINARY_INTEGER;
        BEGIN
            UT_TRACE.TRACE('CC_BORequestRating.LiqRequest.ProcessRequest',7);
            NUERRORCODE :=  GE_BOCONSTANTS.CNUNULLNUM;

            
            NUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID(INUFIRSTPACKID);

    		
            MO_BOPACKAGEPAYMENT.INSERTREGBASIC(INUPACKAGEID,
                                               NULL,
                                               NURATING_PACKAGE_ID);

            UT_TRACE.TRACE('Insert� mo_package_payment '||NURATING_PACKAGE_ID,8);

    	    
            FA_BOREQUESTLIQ.LIQUIDATE(NUPRODUCTID,
                        		      NUPROGRAMID,
                                      INUPACKAGEID,
                                      NULL,
                                      SBDOCUMENT,
                        		      NUERRORCODE,
                        		      SBERRORMESSAGE,
                                      NUERRORLOGID);
                        		      
            UT_TRACE.TRACE('Resultado pkFgca.LiqRequest Pedido['||INUPACKAGEID||'] '||NUERRORCODE||' '||SBERRORMESSAGE,8);

            IF (  NUERRORCODE != GE_BOCONSTANTS.OK) THEN
                ERRORS.SETERROR(CC_BOCONSTERROR.CNUBILLBACKERROR,'Liquidaci�n de Solicitudes' ||'|'|| NUERRORLOGID);
                RAISE EX.CONTROLLED_ERROR ;
    		END IF;

            UT_TRACE.TRACE('Termina CC_BORequestRating.LiqRequest.ProcessRequest',7);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END;
        
    BEGIN
        UT_TRACE.TRACE('Inicia LiqRequest',6);

        GETPROCESSDATA;

        IF (NUPACKAGEPAYMENTID IS NULL) THEN

		    SETPROCESSDATAFGCA;

		    PROCESSREQUEST;

        END IF;

        UT_TRACE.TRACE('Termina LiqRequest',6);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    



    PROCEDURE REQUESTRATINGBYFGCA
    (
        INUPACKAGEID    IN MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
    	
        NUPACKAGEPAYMENTID  MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
        SBTAGNAME           MO_PACKAGES.TAG_NAME%TYPE;
        NUINDX              BINARY_INTEGER;
        TBASSOPACKS         DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO;
    BEGIN
        UT_TRACE.TRACE('Inicia RequestRatingByFgca',4);
        
        
        MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT(INUPACKAGEID, NUPACKAGEPAYMENTID, FALSE);
		
        
        IF (NUPACKAGEPAYMENTID IS NULL) THEN
            
            SBTAGNAME := DAMO_PACKAGES.FSBGETTAG_NAME(INUPACKAGEID);
            IF (SBTAGNAME NOT IN ( PS_BOPACKAGETYPE.FSBTAGNAMEFEASIBLESALE,  PS_BOPACKAGETYPE.FSBTAGNAMERECOVER) ) THEN
                UT_TRACE.TRACE('Solicitud individual: ['||INUPACKAGEID||']',5);
                
                LIQSINGLEREQUEST(INUPACKAGEID);
            ELSE
                
                UT_TRACE.TRACE('Pedido: ['||INUPACKAGEID||']',5);
                
                
                TBASSOPACKS := MO_BCPACKAGES_ASSO.FTBPACKAGESBYPACKASSO(INUPACKAGEID);

                
                LIQREQUEST(INUPACKAGEID, TBASSOPACKS(TBASSOPACKS.FIRST).PACKAGE_ID);

                
                NUINDX := TBASSOPACKS.FIRST;
                LOOP
                    EXIT WHEN NUINDX IS NULL;
                        UT_TRACE.TRACE('Pedido: ['||INUPACKAGEID||'] Solicitud: ['||TBASSOPACKS(NUINDX).PACKAGE_ID||']',5);
                        
                        LIQSINGLEREQUEST(TBASSOPACKS(NUINDX).PACKAGE_ID);
                    NUINDX := TBASSOPACKS.NEXT(NUINDX);
                END LOOP;
            END IF;
        END IF;
        
        UT_TRACE.TRACE('Termina RequestRatingByFgca',4);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
    
    






























    PROCEDURE GETCONCEPTTARIFF
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUPRODUCTID    IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        INUCONCEPT      IN  PS_PACK_TYPE_CONC.REQUEST_CONCEPT%TYPE,
        ONUVALUE        OUT NUMBER
    )
    IS
        
        RCPRODUCT           DAPR_PRODUCT.STYPR_PRODUCT;
        NUDEPARTAM          NUMBER;
        NULOCALIDA          NUMBER;
        NUPACKAGEID         MO_PACKAGES.PACKAGE_ID%TYPE;
        DTREGISTERDATE      DATE;
        NUCLASESERVICIO     GE_SERVICE_CLASS.CLASS_SERVICE_ID%TYPE;
        NUPLANFACTURACION   CC_COMMERCIAL_PLAN.BILLING_PLAN%TYPE;
        NUCATEGORIA         SUBCATEG.SUCACATE%TYPE;
        NUSUBCATEGORIA      SUBCATEG.SUCACODI%TYPE;
        NUTIPOCOMPONENTE    PS_COMPONENT_TYPE.COMPONENT_TYPE_ID%TYPE;
        NUVALUE             NUMBER;
        NUERRORCODE         NUMBER;
        SBERRORMESSAGE      VARCHAR2(2000);
        NUCONTRATO          SERVSUSC.SESUSUSC%TYPE;
        NUEMPRESA           SUSCRIPC.SUSCSIST%TYPE;

    BEGIN
    
        UT_TRACE.TRACE('Inicio de CC_BORequestRating.GetConceptTariff', 5);

        
        DAPR_PRODUCT.GETRECORD(INUPRODUCTID, RCPRODUCT);

        
        NULOCALIDA := PR_BOADDRESS.FNUGETPRODGEOGRLOCATION(INUPRODUCTID);

        
        IF NULOCALIDA IS NULL THEN
            NULOCALIDA := -1;
            NUDEPARTAM := -1;
        ELSE
            NUDEPARTAM := GE_BCGEOGRA_LOCATION.FNUGETDEPARTMENT(NULOCALIDA);
        END IF;

        
        NUPACKAGEID := INUPACKAGEID;
        DTREGISTERDATE := DAMO_PACKAGES.FDTGETREQUEST_DATE(NUPACKAGEID);

        UT_TRACE.TRACE('-- Parametros para Obtener Tarifa', 8);
        UT_TRACE.TRACE('nuDepartam['|| NUDEPARTAM||'] nuLocalida['||NULOCALIDA||
                       '] nuProductType ['|| RCPRODUCT.PRODUCT_TYPE_ID ||
                       '] inuConceptId['||INUCONCEPT ||
                       '] Dates['||DTREGISTERDATE || ']'
                        , 10);

        
        NUPLANFACTURACION := DACC_COMMERCIAL_PLAN.FNUGETBILLING_PLAN(RCPRODUCT.COMMERCIAL_PLAN_ID);
        UT_TRACE.TRACE('Plan de facturaci�n ['||NUPLANFACTURACION||']', 5);
        
        
        NUTIPOCOMPONENTE := -1;
        
        NUCLASESERVICIO := -1;
        UT_TRACE.TRACE('Clase de servicio ['||NUCLASESERVICIO||']', 5);
        
        
        NUCATEGORIA := -1;
        NUSUBCATEGORIA := -1;

        
        NUCATEGORIA    := RCPRODUCT.CATEGORY_ID;
        NUSUBCATEGORIA := RCPRODUCT.SUBCATEGORY_ID;
        UT_TRACE.TRACE('Categoria ['||NUCATEGORIA||']  Subcategoria ['||NUSUBCATEGORIA||']', 5);

        
        NUCONTRATO := PKTBLSERVSUSC.FNUGETSUSCRIPTION (INUPRODUCTID);
        NUEMPRESA := PKTBLSUSCRIPC.FNUGETCOMPANY (NUCONTRATO);
        TA_BOCRITERIOSBUSQUEDA.ESTDATOEMPRESALOCAL (NUEMPRESA);

        
        PKBSS_TARIFFRULES.GETTARIFFPULSE
        (
            NUDEPARTAM,
            NULOCALIDA,
            RCPRODUCT.PRODUCT_TYPE_ID,
            NUCATEGORIA,
            NUSUBCATEGORIA,
            INUCONCEPT,
            NUPLANFACTURACION,
            DTREGISTERDATE,
            NUTIPOCOMPONENTE,
            NUCLASESERVICIO,
            NUVALUE,
            NUERRORCODE,
            SBERRORMESSAGE
        );

		
		GW_BOERRORS.CHECKERROR(NUERRORCODE, SBERRORMESSAGE);

        UT_TRACE.TRACE('Valor de la tarifa obtenido ['||NUVALUE||']', 5);
        ONUVALUE := NUVALUE;

        UT_TRACE.TRACE('Fin de CC_BORequestRating.GetConceptTariff', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GETCONCEPTTARIFF;

    



























    PROCEDURE GENPRODCHARGE
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        INUPRODUCTID    IN  PR_PRODUCT.PRODUCT_ID%TYPE,
        INUCONCEPT      IN  PS_PACK_TYPE_CONC.REQUEST_CONCEPT%TYPE,
        INUVALUE        IN  NUMBER
    )
    IS
    	SBSIGN              VARCHAR2(2);
    	DTFECHAREGISTRO     DATE;
        NUTAXVALUE          NUMBER;
        NUTAXPERCENT        NUMBER;
        NUUNITS             NUMBER;
        SBDOCUMENT          VARCHAR2(2000);
        NUERRORCODE         GE_MESSAGE.MESSAGE_ID%TYPE;
        SBERRORMESSAGE      GE_MESSAGE.DESCRIPTION%TYPE;
        
        
        NUCHARGECAUSE       CAUSCARG.CACACODI%TYPE;
        
        
        NUPRODUCTTYPE       SERVICIO.SERVCODI%TYPE;
    BEGIN
    
        UT_TRACE.TRACE('Inicio de CC_BORequestRating.GenProdCharge', 5);

        
        SBSIGN := CC_BOCONSTANTS.CSBDEBITO;

        
        SBDOCUMENT := CC_BOCONSTANTS.CSBPREFIJODOC||CC_BOCONSTANTS.CSBSEPDOCPAYMENT||INUPACKAGEID ;
        UT_TRACE.TRACE('Documento de soporte ['||SBDOCUMENT||']', 5);

        
        DTFECHAREGISTRO := SYSDATE;

        
        NUTAXVALUE := NULL;
        NUTAXPERCENT := NULL;
        NUUNITS := 1;
        
        
        NUPRODUCTTYPE := PKTBLSERVSUSC.FNUGETSERVICE(INUPRODUCTID);
        
        
        NUCHARGECAUSE := FA_BOCHARGECAUSES.FNUCONNECTIONCHCAUSE(NUPRODUCTTYPE);

        UT_TRACE.TRACE('Valor cargo a generar '||INUVALUE, 5);
        PKBILLDEFERRED.GENERATECHARGE
        (
            INUPRODUCTID    ,
            INUCONCEPT      ,
            NUCHARGECAUSE   ,
            SBDOCUMENT      ,
            SBSIGN          ,
            INUVALUE        ,
            DTFECHAREGISTRO ,
            CC_BOCONSTANTS.CSBCUSTOMERCARE ,
            NUUNITS         ,
            0               ,
            NUERRORCODE     ,
            SBERRORMESSAGE  );

		IF (  NUERRORCODE <> 0 ) THEN
            ERRORS.SETERROR
            (
                CC_BOCONSTERROR.CNUBILLSERVICEERROR ,
                'pkBillDeferred.GenerateCharge' || '|' ||
                NUERRORCODE||' - ' || SBERRORMESSAGE
            );
		    RAISE EX.CONTROLLED_ERROR ;
        END IF;
        UT_TRACE.TRACE('Cargo generado.', 5);

        UT_TRACE.TRACE('Fin de CC_BORequestRating.GenProdCharge', 5);

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    
    END GENPRODCHARGE;
    

    



	PROCEDURE REQUESTPOSRATING
    (
        INUPACKAGEID    IN MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS

    
    NUPACKAGETYPEID     MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
    RCPACKTYPECONC      DAPS_PACK_TYPE_CONC.STYPS_PACK_TYPE_CONC;
    NUCONCEPT           PS_PACK_TYPE_CONC.REQUEST_CONCEPT%TYPE;
    NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;

    
    NUERRORCODE         NUMBER;
    SBERRORMESSAGE      VARCHAR2(2000);
    NUINDEX             NUMBER;
    NUVALUE             NUMBER;

	

    
    
    

        PROCEDURE GETINITIALDATA IS
        BEGIN
            UT_TRACE.TRACE('Inicio de CC_BORequestRating.RequestPosRating.GetInitialData',5);

            
            NUPACKAGETYPEID := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(INUPACKAGEID);
            UT_TRACE.TRACE('Tipo de la solicitud ['||INUPACKAGEID||']', 5);

            
            OPEN PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY(NUPACKAGETYPEID);
                FETCH PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY INTO RCPACKTYPECONC;
            CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;
            
            NUCONCEPT := RCPACKTYPECONC.REQUEST_CONCEPT;
            
            UT_TRACE.TRACE('Concepto para el tipo de solicitud ['||NUCONCEPT||']', 5);

            
            NUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID (INUPACKAGEID);
            UT_TRACE.TRACE('Producto ['||NUPRODUCTID||']', 5);

            UT_TRACE.TRACE('Fin de CC_BORequestRating.RequestPosRating.GetInitialData',5);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                IF (PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY%ISOPEN) THEN
                    CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;
                END IF;
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                IF (PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY%ISOPEN) THEN
                    CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;
                END IF;
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        
        END GETINITIALDATA;
            


    BEGIN
        UT_TRACE.TRACE('Inicio de CC_BORequestRating.RequestPosRating', 5);

        
        GETINITIALDATA;
        
        
        IF (NUCONCEPT IS NOT NULL) THEN
            UT_TRACE.TRACE('Se genera el cargo para el concepto.', 5);
            
            GETCONCEPTTARIFF
            (
                INUPACKAGEID,
                NUPRODUCTID,
                NUCONCEPT,
                NUVALUE
            );
            
            GENPRODCHARGE
            (
                INUPACKAGEID,
                NUPRODUCTID,
                NUCONCEPT,
                NUVALUE
            );
            
        END IF;
        
        UT_TRACE.TRACE('Fin de CC_BORequestRating.RequestPosRating', 5);
   	EXCEPTION
    	WHEN EX.CONTROLLED_ERROR THEN
        	RAISE EX.CONTROLLED_ERROR ;

    	WHEN OTHERS THEN
        	ERRORS.SETERROR;
        	RAISE EX.CONTROLLED_ERROR;

    END REQUESTPOSRATING;

    























	PROCEDURE SANCTIONRATING
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS

    
    NUPACKAGETYPEID     MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
    RCPACKTYPECONC      DAPS_PACK_TYPE_CONC.STYPS_PACK_TYPE_CONC;
    RCMOTIVE            DAMO_MOTIVE.STYMO_MOTIVE;
    NUCONCEPT           PS_PACK_TYPE_CONC.REQUEST_CONCEPT%TYPE;
    NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;

    
    NUERRORCODE         NUMBER;
    SBERRORMESSAGE      VARCHAR2(2000);
    NUINDEX             NUMBER;
    NUVALUE             NUMBER;

	

	
	NUCAUSALID         MO_MOTIVE.CAUSAL_ID%TYPE;

    
    
    

        PROCEDURE GETINITIALDATA IS
        BEGIN
            UT_TRACE.TRACE('Inicio de CC_BORequestRating.SanctionRating.GetInitialData',5);

            
            NUPACKAGETYPEID := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(INUPACKAGEID);
            UT_TRACE.TRACE('Tipo de la solicitud ['||INUPACKAGEID||']', 5);

            
            OPEN PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY(NUPACKAGETYPEID);
                FETCH PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY INTO RCPACKTYPECONC;
            CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;

            NUCONCEPT := RCPACKTYPECONC.PENALTY_CONCEPT;
            
            UT_TRACE.TRACE('Concepto de sanci�n para el tipo de solicitud ['||NUCONCEPT||']', 5);

            
            RCMOTIVE := MO_BOPACKAGES.FRCGETINITIALMOTIVE(INUPACKAGEID);
            
            NUPRODUCTID := RCMOTIVE.PRODUCT_ID;
            UT_TRACE.TRACE('Producto ['||NUPRODUCTID||']', 5);

            
            NUCAUSALID := RCMOTIVE.CAUSAL_ID;
            UT_TRACE.TRACE('Identificador de la causal ['||NUCAUSALID||']', 5);
            
            UT_TRACE.TRACE('Fin de CC_BORequestRating.RequestPosRating.GetInitialData',5);
        EXCEPTION
            WHEN EX.CONTROLLED_ERROR THEN
                IF (PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY%ISOPEN) THEN
                    CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;
                END IF;
                RAISE EX.CONTROLLED_ERROR;
            WHEN OTHERS THEN
                IF (PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY%ISOPEN) THEN
                    CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;
                END IF;
                ERRORS.SETERROR;
                RAISE EX.CONTROLLED_ERROR;
        END GETINITIALDATA;

    BEGIN
        UT_TRACE.TRACE('Inicio de CC_BORequestRating.RequestPosRating', 5);

        
        GETINITIALDATA;

        
        IF (NUCONCEPT IS NOT NULL) THEN
            

            IF (NUCAUSALID IS NOT NULL) THEN
                IF (DACC_CAUSAL.FNUGETATTRIBUTED_TO(NUCAUSALID) = CNUIMPUTABLEALCLIENTESANCION) THEN
                    UT_TRACE.TRACE('Se genera el cargo para el concepto por la causal.', 5);
                    
                    GETCONCEPTTARIFF
                    (
                        INUPACKAGEID,
                        NUPRODUCTID,
                        NUCONCEPT,
                        NUVALUE
                    );
                    
                    GENPRODCHARGE
                    (
                        INUPACKAGEID,
                        NUPRODUCTID,
                        NUCONCEPT,
                        NUVALUE
                    );
                END IF;
            END IF;
        END IF;

        UT_TRACE.TRACE('Fin de CC_BORequestRating.RequestPosRating', 5);
   	EXCEPTION
    	WHEN EX.CONTROLLED_ERROR THEN
        	RAISE EX.CONTROLLED_ERROR ;

    	WHEN OTHERS THEN
        	ERRORS.SETERROR;
        	RAISE EX.CONTROLLED_ERROR;
    END SANCTIONRATING;

    PROCEDURE POSTREQRATINGBYFGCA
    (
        INUPACKAGEID    IN MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        NUPACKAGETYPEID     MO_PACKAGES.PACKAGE_TYPE_ID%TYPE;
        NUPACKAGEPAYMENTID  MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
        NUPRODUCTID         PR_PRODUCT.PRODUCT_ID%TYPE;
        NUCOMMPLANID        CC_COMMERCIAL_PLAN.COMMERCIAL_PLAN_ID%TYPE;
        RCPACKTYPECONC      DAPS_PACK_TYPE_CONC.STYPS_PACK_TYPE_CONC;
    BEGIN
        
        NUPACKAGETYPEID := DAMO_PACKAGES.FNUGETPACKAGE_TYPE_ID(INUPACKAGEID);

        
        OPEN PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY(NUPACKAGETYPEID);
            FETCH PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY INTO RCPACKTYPECONC;
        CLOSE PS_BCPACKAGE_TYPE.CUPACKCONCBYPACKTY;

        IF (RCPACKTYPECONC.PACK_TYPE_CONC_ID IS NULL) THEN
            
           REQUESTRATINGBYFGCA(INUPACKAGEID);
        ELSE
            
            
            MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT( INUPACKAGEID, NUPACKAGEPAYMENTID, FALSE ) ;

            
            IF (NUPACKAGEPAYMENTID IS NULL) THEN
                
                IF (RCPACKTYPECONC.REQUEST_CONCEPT IS NOT NULL) THEN
                    REQUESTPOSRATING(INUPACKAGEID);
                END IF;
                
                IF (RCPACKTYPECONC.PENALTY_CONCEPT IS NOT NULL) THEN
                    SANCTIONRATING(INUPACKAGEID);
                END IF;

                
                NUPRODUCTID := MO_BOPACKAGES.FNUFINDPRODUCTID (INUPACKAGEID);
                
                NUCOMMPLANID := DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID(NUPRODUCTID);

                
                MO_BOPACKAGEPAYMENT.INSERTREGBASIC( INUPACKAGEID,
                                                    NUCOMMPLANID,
                                                    NUPACKAGEPAYMENTID);
            END IF;
        END IF;

    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    PROCEDURE REVERSESINGLEPACK
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUREVERSEDVALUE    OUT CARGOS.CARGVALO%TYPE
    )
    IS
        SBDOCUMENT      CARGOS.CARGDOSO%TYPE;
        TBCHARGES       PKTBLCARGOS.TYTBCARGOS;
        RCPACKPAYMENT   DAMO_PACKAGE_PAYMENT.STYMO_PACKAGE_PAYMENT;
        NUINDX          BINARY_INTEGER;
        NUREVERSEDVALUE CARGOS.CARGVALO%TYPE := PKBILLCONST.CERO;
    BEGIN
        
        SBDOCUMENT := CC_BOCONSTANTS.CSBPREFIJODOC||CC_BOCONSTANTS.CSBSEPDOCPAYMENT||INUPACKAGEID;
        
        
        PKBCCARGOS.GETCHARGESBYSUPPORTDOC(SBDOCUMENT, TBCHARGES);
        
        
        NUINDX := TBCHARGES.CARGCONC.FIRST;
        WHILE (NUINDX IS NOT NULL) LOOP
            NUREVERSEDVALUE := NUREVERSEDVALUE + TBCHARGES.CARGVALO(NUINDX);
            NUINDX := TBCHARGES.CARGCONC.NEXT(NUINDX);
        END LOOP;
        
        
        PKBCCARGOS.DELETECHARGESBYSUPDOC(SBDOCUMENT);
        
        
        MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT(INUPACKAGEID, RCPACKPAYMENT.PACKAGE_PAYMENT_ID, FALSE);

        
        RCPACKPAYMENT := DAMO_PACKAGE_PAYMENT.FRCGETRECORD(RCPACKPAYMENT.PACKAGE_PAYMENT_ID);
        RCPACKPAYMENT.TOTAL_VALUE := NUREVERSEDVALUE;
        RCPACKPAYMENT.ACTIVE := CC_BOCONSTANTS.CSBNO;
        DAMO_PACKAGE_PAYMENT.UPDRECORD(RCPACKPAYMENT);
        
        
        ONUREVERSEDVALUE := NUREVERSEDVALUE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

    






















    PROCEDURE REVERSERATING
    (
        INUPACKAGEID        IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUPACKPAYMENTID    OUT MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE,
        ONUREVERSEDVALUE    OUT NUMBER
    )
    IS
        SBTAGNAME           MO_PACKAGES.TAG_NAME%TYPE;
        NUBILLID            FACTURA.FACTCODI%TYPE;
        NUREVERSEDVALUE     CARGOS.CARGVALO%TYPE := PKBILLCONST.CERO;
        NUTMPREVALUE        CARGOS.CARGVALO%TYPE := PKBILLCONST.CERO;
        RCPACKPAYMENT       DAMO_PACKAGE_PAYMENT.STYMO_PACKAGE_PAYMENT;
        TBASSOPACKS         DAMO_PACKAGES_ASSO.TYTBMO_PACKAGES_ASSO;
        NUINDX              BINARY_INTEGER;
    BEGIN
        UT_TRACE.TRACE('Inicia CC_BORequestRating.ReverseRating',4);

        
        NUBILLID := MO_BOPACKAGEPAYMENT.FNUGETACCOUNTBYPACKAGE(INUPACKAGEID);
        IF (NUBILLID IS NOT NULL) THEN
            ONUPACKPAYMENTID := NULL;
            ONUREVERSEDVALUE := NULL;
            RETURN;
        END IF;

          
        MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT(INUPACKAGEID, ONUPACKPAYMENTID, TRUE);

        
        SBTAGNAME := DAMO_PACKAGES.FSBGETTAG_NAME(INUPACKAGEID);
        IF (SBTAGNAME NOT IN ( PS_BOPACKAGETYPE.FSBTAGNAMEFEASIBLESALE,  PS_BOPACKAGETYPE.FSBTAGNAMERECOVER) ) THEN
            UT_TRACE.TRACE('Reversar Solicitud individual: ['||INUPACKAGEID||']',5);
            
            REVERSESINGLEPACK(INUPACKAGEID, NUREVERSEDVALUE);
        ELSE
            
            UT_TRACE.TRACE('Reversar Pedido: ['||INUPACKAGEID||']',5);

                            
            TBASSOPACKS := MO_BCPACKAGES_ASSO.FTBPACKAGESBYPACKASSO(INUPACKAGEID);

            
            NUINDX := TBASSOPACKS.FIRST;
            LOOP
                EXIT WHEN NUINDX IS NULL;
                    
                    REVERSESINGLEPACK(TBASSOPACKS(NUINDX).PACKAGE_ID, NUTMPREVALUE);
                    
                    NUREVERSEDVALUE := NUREVERSEDVALUE + NUTMPREVALUE;
                NUINDX := TBASSOPACKS.NEXT(NUINDX);
            END LOOP;

            
            RCPACKPAYMENT := DAMO_PACKAGE_PAYMENT.FRCGETRECORD(ONUPACKPAYMENTID);
            RCPACKPAYMENT.TOTAL_VALUE := NUREVERSEDVALUE;
            RCPACKPAYMENT.ACTIVE := CC_BOCONSTANTS.CSBNO;
            DAMO_PACKAGE_PAYMENT.UPDRECORD(RCPACKPAYMENT);
        END IF;

        
        ONUREVERSEDVALUE := NUREVERSEDVALUE;

        UT_TRACE.TRACE('Termina CC_BORequestRating.ReverseRating, Total Reversado['||NUREVERSEDVALUE||']',4);
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

     
























    PROCEDURE GENBILLANDFINANCING
    (
        INUPACKAGEID    IN MO_PACKAGES.PACKAGE_ID%TYPE
    )
    IS
        NUBILLID            FACTURA.FACTCODI%TYPE;
        NUFINANCINGID       DIFERIDO.DIFECOFI%TYPE;
        NUPACKAGEPAYMENTID  MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
    BEGIN
        
        MO_BOPACKAGEPAYMENT.GETIDPACKPAYMENT(INUPACKAGEID, NUPACKAGEPAYMENTID, FALSE);
    
        
        IF (DACC_SALES_FINANC_COND.FBLEXIST(INUPACKAGEID) AND
            NUPACKAGEPAYMENTID IS NOT NULL) THEN
            
            CC_BOACCOUNTS.GENERATEACCOUNTBYPACK(INUPACKAGEID);
            
             
            FI_BOFINANCVENTAPRODUCTOS.FINANCIARFACTURAVENTA
            (
                INUPACKAGEID,
                NUFINANCINGID
            );

        END IF;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;

  






















    PROCEDURE GENCOUPONWITHOUTBILL
    (
        INUPACKAGEID    IN  MO_PACKAGES.PACKAGE_ID%TYPE,
        ONUCOUPONID     OUT CUPON.CUPONUME%TYPE,
        ONUCOUPONVALUE  OUT CUPON.CUPOVALO%TYPE
    )
    IS
        NUPACKPAYMENTID     MO_PACKAGE_PAYMENT.PACKAGE_PAYMENT_ID%TYPE;
        NUSALEDVALUE        NUMBER;
    BEGIN
        
        REVERSERATING(INUPACKAGEID, NUPACKPAYMENTID, NUSALEDVALUE);

        
        IF (NUPACKPAYMENTID IS NULL) THEN
            RETURN;
        END IF;

        
        IF (DACC_SALES_FINANC_COND.FBLEXIST(INUPACKAGEID)) THEN
            
            NUSALEDVALUE := NUSALEDVALUE - NVL(DACC_SALES_FINANC_COND.FNUGETVALUE_TO_FINANCE(INUPACKAGEID), 0);
        END IF;

        
        PKCOUPONMGR.GENERATECOUPONSERVICE(PKBILLCONST.CSBTOKEN_SOLICITUD,
                                      TO_CHAR(INUPACKAGEID),
                                      NUSALEDVALUE,
                                      NULL,
                                      NULL,
                                      ONUCOUPONID
                                      );

        
        ONUCOUPONVALUE := NUSALEDVALUE;
    EXCEPTION
        WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
        WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
    END;
END CC_BOREQUESTRATING;