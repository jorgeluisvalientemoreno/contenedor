CREATE OR REPLACE PACKAGE BODY PR_BOVALIDATE IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO186604';
   CSBVOLSUSP CONSTANT GE_SUSPENSION_TYPE.CLASS_SUSPENSION%TYPE := 'V';
   CSBPREPAYCOMMPLAN CONSTANT CC_COMMERCIAL_PLAN.PREPAY%TYPE := 'P';
   CSBCONTCOUNTCOMMPLAN CONSTANT CC_COMMERCIAL_PLAN.PREPAY%TYPE := 'C';
   CNUINVOLSUSPTYPE CONSTANT GE_SUSPENSION_TYPE.SUSPENSION_TYPE_ID%TYPE := 3;
   CNUOUTVOLSUSPTYPE CONSTANT GE_SUSPENSION_TYPE.SUSPENSION_TYPE_ID%TYPE := 4;
   CNUBIVOLSUSPTYPE CONSTANT GE_SUSPENSION_TYPE.SUSPENSION_TYPE_ID%TYPE := 5;
   CNUPRODUCTINSTATUS CONSTANT NUMBER := 111263;
   CNUDEFBILLCICLE CONSTANT NUMBER := -1;
   CNUMESGDEFBILLCYCLE CONSTANT NUMBER := 3337;
   CNUMESGNULLBILLCYCLE CONSTANT NUMBER := 111422;
   CSBTAGCLAIMDUPLFACT CONSTANT VARCHAR2( 100 ) := 'M_GENER_CLAIMDUPLFACT';
   CSBTAGCLAIMINF CONSTANT VARCHAR2( 100 ) := 'M_GENER_CLAIMINF';
   CNUPRODWITHREQ CONSTANT NUMBER( 4 ) := 5542;
   CNUCAMPONULO CONSTANT NUMBER( 6 ) := 950;
   CSBCATEGORY CONSTANT VARCHAR2( 30 ) := 'Categoria';
   CSBSUBCATEGORY CONSTANT VARCHAR2( 30 ) := 'Subcategoria';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE VALIDATESUBSCRIBER( INUSUBSCRIBER_ID IN SUSCRIPC.SUSCCLIE%TYPE )
    IS
    BEGIN
      IF ( INUSUBSCRIBER_ID IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUSUBSCRIBERIDISNULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATESUBSCRIPTIONTYPE( INUSUBSCRIPTION_TYPE IN SUSCRIPC.SUSCTISU%TYPE )
    IS
    BEGIN
      IF ( INUSUBSCRIPTION_TYPE IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUSUBSCTYPEISNULL );
         RAISE EX.CONTROLLED_ERROR;
       ELSE
         DAGE_SUBSCRIPTION_TYPE.ACCKEY( INUSUBSCRIPTION_TYPE );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATEDATAADDRESS( INUADDRESS_ID IN SUSCRIPC.SUSCIDDI%TYPE, INUGEOGRAP_LOCATION_ID IN AB_ADDRESS.GEOGRAP_LOCATION_ID%TYPE, ISBADDRESS IN AB_ADDRESS.ADDRESS%TYPE, ISBISURBAN IN AB_ADDRESS.IS_URBAN%TYPE := CC_BOCONSTANTS.CSBSI )
    IS
    BEGIN
      IF ( INUADDRESS_ID IS NULL ) THEN
         IF ( INUGEOGRAP_LOCATION_ID IS NULL AND ISBADDRESS IS NULL AND ISBISURBAN IS NULL ) THEN
            ERRORS.SETERROR( PR_BOCONSTERROR.CNUADDRESSIDISNULL );
            RAISE EX.CONTROLLED_ERROR;
         END IF;
         IF ( INUGEOGRAP_LOCATION_ID IS NULL OR ISBADDRESS IS NULL OR ISBISURBAN IS NULL ) THEN
            ERRORS.SETERROR( PR_BOCONSTERROR.CNUADDRESSDATAISNULL );
            RAISE EX.CONTROLLED_ERROR;
         END IF;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATESUBSCRIPTION( INUSUBSCRIPTION_ID IN SUSCRIPC.SUSCCODI%TYPE )
    IS
    BEGIN
      IF ( INUSUBSCRIPTION_ID IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUSUBSCRIPTIONIDISNULL );
         RAISE EX.CONTROLLED_ERROR;
       ELSE
         PKTBLSUSCRIPC.ACCKEY( INUSUBSCRIPTION_ID );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATEPRODTYPE( INUPRODUCT_TYPE_ID IN PR_PRODUCT.PRODUCT_TYPE_ID%TYPE )
    IS
    BEGIN
      IF ( INUPRODUCT_TYPE_ID IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUPRODTYPEISNULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATECOMMPLAN( INUCOMMERCIAL_PLAN_ID IN PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE )
    IS
    BEGIN
      IF ( INUCOMMERCIAL_PLAN_ID IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUCOMMPLANISNULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATESOCIECOSTRATUM( INUCATEGORYID IN SUBCATEG.SUCACATE%TYPE, INUSUBCATEGORYID IN SUBCATEG.SUCACODI%TYPE )
    IS
    BEGIN
      IF ( INUCATEGORYID IS NULL ) THEN
         ERRORS.SETERROR( CNUCAMPONULO, CSBCATEGORY );
         RAISE EX.CONTROLLED_ERROR;
       ELSIF ( INUSUBCATEGORYID IS NULL ) THEN
         ERRORS.SETERROR( CNUCAMPONULO, CSBSUBCATEGORY );
         RAISE EX.CONTROLLED_ERROR;
       ELSE
         PKTBLCATEGORI.ACCKEY( INUCATEGORYID );
         PKTBLSUBCATEG.ACCKEY( INUCATEGORYID, INUSUBCATEGORYID );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATEPRODUCT( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
    BEGIN
      IF ( INUPRODUCT_ID IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUPRODUCTIDISNULL );
         RAISE EX.CONTROLLED_ERROR;
       ELSE
         DAPR_PRODUCT.ACCKEY( INUPRODUCT_ID );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATECOMPONENTTYPE( INUCOMPONENTTYPEID IN PR_COMPONENT.COMPONENT_TYPE_ID%TYPE )
    IS
    BEGIN
      IF ( INUCOMPONENTTYPEID IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUCOMPTYPEISNULL );
         RAISE EX.CONTROLLED_ERROR;
       ELSE
         DAPS_COMPONENT_TYPE.ACCKEY( INUCOMPONENTTYPEID );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATECOMMPLANPROD( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
    BEGIN
      IF ( DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID( INUPRODUCTID ) IS NULL ) THEN
         ERRORS.SETERROR( PR_BOCONSTERROR.CNUCOMMPLANPRODISNULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FBLISPRODINVOLSUSP( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN BOOLEAN
    IS
      RCVOLSUSPMOTIVES MO_BCMOTIVE.CUMOTIBYPRANDSUSPTY%ROWTYPE;
      BLISPROINVOLSUSP BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( '-- Inicio PR_BOValidate.IsProdinVolSusp inuProductId [' || INUPRODUCTID || ']', 5 );
      BLISPROINVOLSUSP := FALSE;
      FOR RCVOLSUSPMOTIVES IN MO_BCMOTIVE.CUMOTIBYPRANDSUSPTY( INUPRODUCTID, CNUINVOLSUSPTYPE )
       LOOP
         IF ( ( RCVOLSUSPMOTIVES.MOTIVE_TYPE_ID = MO_BOCONSTANTS.CNUSUSP_MOTI_TYPE ) AND ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCVOLSUSPMOTIVES.MOTIVE_STATUS_ID ) ) ) THEN
            BLISPROINVOLSUSP := TRUE;
            RETURN BLISPROINVOLSUSP;
         END IF;
      END LOOP;
      FOR RCVOLSUSPMOTIVES IN MO_BCMOTIVE.CUMOTIBYPRANDSUSPTY( INUPRODUCTID, CNUOUTVOLSUSPTYPE )
       LOOP
         IF ( ( RCVOLSUSPMOTIVES.MOTIVE_TYPE_ID = MO_BOCONSTANTS.CNUSUSP_MOTI_TYPE ) AND ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCVOLSUSPMOTIVES.MOTIVE_STATUS_ID ) ) ) THEN
            BLISPROINVOLSUSP := TRUE;
            RETURN BLISPROINVOLSUSP;
         END IF;
      END LOOP;
      FOR RCVOLSUSPMOTIVES IN MO_BCMOTIVE.CUMOTIBYPRANDSUSPTY( INUPRODUCTID, CNUBIVOLSUSPTYPE )
       LOOP
         IF ( ( RCVOLSUSPMOTIVES.MOTIVE_TYPE_ID = MO_BOCONSTANTS.CNUSUSP_MOTI_TYPE ) AND ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCVOLSUSPMOTIVES.MOTIVE_STATUS_ID ) ) ) THEN
            BLISPROINVOLSUSP := TRUE;
            RETURN BLISPROINVOLSUSP;
         END IF;
      END LOOP;
      RETURN BLISPROINVOLSUSP;
      UT_TRACE.TRACE( '-- Fin PR_BOValidate.IsProdinVolSusp', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLISPRODINVOLSUSP;
   FUNCTION FBLISPRODVOLSUSP( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN BOOLEAN
    IS
      RCSUSPENSIONTYPE PR_BCSUSPENSION.CUSUSPACTBYPRDANDCLA%ROWTYPE;
      BLISPROVOLSUSP BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( '-- Inicio PR_BOValidate.IsProdVolSusp inuProductId [' || INUPRODUCTID || ']', 5 );
      BLISPROVOLSUSP := FALSE;
      OPEN PR_BCSUSPENSION.CUSUSPACTBYPRDANDCLA( INUPRODUCTID, CSBVOLSUSP );
      FETCH PR_BCSUSPENSION.CUSUSPACTBYPRDANDCLA
         INTO RCSUSPENSIONTYPE;
      IF ( PR_BCSUSPENSION.CUSUSPACTBYPRDANDCLA%FOUND ) THEN
         BLISPROVOLSUSP := TRUE;
      END IF;
      CLOSE PR_BCSUSPENSION.CUSUSPACTBYPRDANDCLA;
      RETURN BLISPROVOLSUSP;
      UT_TRACE.TRACE( '-- Fin PR_BOValidate.IsProdVolSusp blIsProVolSusp', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSE PR_BCSUSPENSION.CUSUSPACTBYPRDANDCLA;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLISPRODVOLSUSP;
   FUNCTION FBLISPRODINPREPAPLAN( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN BOOLEAN
    IS
      NUCOMMPLANID PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE;
      SBPLANTYPEFLAG CC_COMMERCIAL_PLAN.PREPAY%TYPE;
      BLISPROINPREPAYPLAN BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( '-- Inicio PR_BOValidate.IsProdinPrepayPlan', 5 );
      BLISPROINPREPAYPLAN := FALSE;
      NUCOMMPLANID := DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID( INUPRODUCTID );
      UT_TRACE.TRACE( 'Producto [' || INUPRODUCTID || '] Plan comercial [' || NUCOMMPLANID || ']', 5 );
      IF ( NUCOMMPLANID IS NOT NULL ) THEN
         SBPLANTYPEFLAG := DACC_COMMERCIAL_PLAN.FSBGETPREPAY( NUCOMMPLANID );
         UT_TRACE.TRACE( 'Flag del plan comercial [' || SBPLANTYPEFLAG || ']', 5 );
         IF ( SBPLANTYPEFLAG = CSBPREPAYCOMMPLAN ) THEN
            BLISPROINPREPAYPLAN := TRUE;
         END IF;
      END IF;
      RETURN BLISPROINPREPAYPLAN;
      UT_TRACE.TRACE( '-- Fin PR_BOValidate.IsProdinPrepayPlan blIsProinPrepayPlan', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLISPRODINPREPAPLAN;
   FUNCTION FBLISPRODINCONTRPLAN( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN BOOLEAN
    IS
      NUCOMMPLANID PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE;
      SBPLANTYPEFLAG CC_COMMERCIAL_PLAN.PREPAY%TYPE;
      BLISPROINCONTPLAN BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( '-- Inicio PR_BOValidate.IsProdinControlPlan', 5 );
      BLISPROINCONTPLAN := FALSE;
      NUCOMMPLANID := DAPR_PRODUCT.FNUGETCOMMERCIAL_PLAN_ID( INUPRODUCTID );
      UT_TRACE.TRACE( 'Producto [' || INUPRODUCTID || '] Plan comercial [' || NUCOMMPLANID || ']', 5 );
      IF ( NUCOMMPLANID IS NOT NULL ) THEN
         SBPLANTYPEFLAG := DACC_COMMERCIAL_PLAN.FSBGETPREPAY( NUCOMMPLANID );
         UT_TRACE.TRACE( 'Flag de plan comercial [' || SBPLANTYPEFLAG || ']', 5 );
         IF ( SBPLANTYPEFLAG = CSBCONTCOUNTCOMMPLAN ) THEN
            BLISPROINCONTPLAN := TRUE;
         END IF;
      END IF;
      RETURN BLISPROINCONTPLAN;
      UT_TRACE.TRACE( '-- Fin PR_BOValidate.IsProdinControlPlan', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLISPRODINCONTRPLAN;
   FUNCTION FBLVALIDATEPENDINGPROD( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, IBLRAISEERROR IN BOOLEAN := FALSE )
    RETURN BOOLEAN
    IS
      RCPRODUCT DAPR_PRODUCT.STYPR_PRODUCT;
    BEGIN
      RCPRODUCT := DAPR_PRODUCT.FRCGETRECORD( INUPRODUCTID );
      IF ( RCPRODUCT.PRODUCT_STATUS_ID = PR_BOCONSTANTS.FNUGETPRODSTATUSINSTALLPEND ) THEN
         IF ( IBLRAISEERROR ) THEN
            ERRORS.SETERROR( CNUPRODUCTINSTATUS, TO_CHAR( INUPRODUCTID ) || '|' || TO_CHAR( RCPRODUCT.PRODUCT_STATUS_ID ) || '|' || DAPS_PRODUCT_STATUS.FSBGETDESCRIPTION( RCPRODUCT.PRODUCT_STATUS_ID ) );
            RAISE EX.CONTROLLED_ERROR;
         END IF;
         RETURN TRUE;
       ELSE
         RETURN FALSE;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATECYCLE( INUBILLINGCYCLE IN CICLO.CICLCODI%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '-- Inicio PR_BOValidate.ValidateCycle BillingCycle: [' || INUBILLINGCYCLE || ']', 5 );
      IF ( INUBILLINGCYCLE IS NULL ) THEN
         ERRORS.SETERROR( CNUMESGNULLBILLCYCLE );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      IF ( INUBILLINGCYCLE = CNUDEFBILLCICLE ) THEN
         ERRORS.SETERROR( CNUMESGDEFBILLCYCLE );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      UT_TRACE.TRACE( '-- Fin PR_BOValidate.ValidateCycle', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FBLVALRETUNINSTALLPR( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, IBLRAISEERROR IN BOOLEAN := FALSE )
    RETURN BOOLEAN
    IS
      RCPRODUCT DAPR_PRODUCT.STYPR_PRODUCT;
    BEGIN
      UT_TRACE.TRACE( '-- Inicio PR_BOValidate.fblValRetUninstallPr ProductId: [' || INUPRODUCTID || ']', 5 );
      RCPRODUCT := DAPR_PRODUCT.FRCGETRECORD( INUPRODUCTID );
      UT_TRACE.TRACE( '-- Producto obtenido: [' || RCPRODUCT.PRODUCT_ID || ']', 5 );
      UT_TRACE.TRACE( '-- Estado del producto: [' || RCPRODUCT.PRODUCT_STATUS_ID || ']', 5 );
      IF ( RCPRODUCT.PRODUCT_STATUS_ID = PR_BOPARAMETER.FNUGETPRRETUNINST ) THEN
         IF ( IBLRAISEERROR ) THEN
            ERRORS.SETERROR( CNUPRODUCTINSTATUS, TO_CHAR( INUPRODUCTID ) || '|' || TO_CHAR( RCPRODUCT.PRODUCT_STATUS_ID ) || '|' || DAPS_PRODUCT_STATUS.FSBGETDESCRIPTION( RCPRODUCT.PRODUCT_STATUS_ID ) );
            RAISE EX.CONTROLLED_ERROR;
         END IF;
         RETURN TRUE;
       ELSE
         RETURN FALSE;
      END IF;
      UT_TRACE.TRACE( '-- Fin PR_BOValidate.fblValRetUninstallPr', 5 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDATENULLSTRING( ISBSTRING IN VARCHAR2, INUERRORCODE IN GE_MESSAGE.MESSAGE_ID%TYPE )
    IS
    BEGIN
      IF ( ISBSTRING IS NULL ) THEN
         ERRORS.SETERROR( INUERRORCODE );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALDATEBEFORECURRENT( IDTDATE IN DATE, INUERRORCODE IN GE_MESSAGE.MESSAGE_ID%TYPE )
    IS
    BEGIN
      IF ( TRUNC( IDTDATE ) > TRUNC( UT_DATE.FDTSYSDATE ) ) THEN
         ERRORS.SETERROR( INUERRORCODE );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FSBVALCATEGCLEANSERV( INUCOMPONENTID IN PR_COMPONENT.COMPONENT_ID%TYPE )
    RETURN VARCHAR2
    IS
      NUCLASSSERVID PS_CLASS_SERVICE.CLASS_SERVICE_ID%TYPE;
      NUCATEGORYID PS_CLASS_SERVICE.CATEGORY%TYPE;
      SBRESPONSE VARCHAR2( 1 ) := GE_BOCONSTANTS.CSBNO;
      NUCATEGCLEANSERV NUMBER := PR_BOCONSTANTS.CNUCATEGCLEANSERV;
    BEGIN
      UT_TRACE.TRACE( 'Inicia MO_BOCnf_Generic_Valid.fsbValCategCleanServ', 10 );
      NUCLASSSERVID := DAPR_COMPONENT.FNUGETCLASS_SERVICE_ID( INUCOMPONENTID );
      NUCATEGORYID := DAPS_CLASS_SERVICE.FNUGETCATEGORY( NUCLASSSERVID );
      IF ( NUCATEGORYID = NUCATEGCLEANSERV ) THEN
         SBRESPONSE := GE_BOCONSTANTS.CSBYES;
      END IF;
      UT_TRACE.TRACE( 'Termina MO_BOCnf_Generic_Valid.fsbValCategCleanServ', 10 );
      RETURN SBRESPONSE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FSBVALCATEGCLEANSERV;
   PROCEDURE VALIDPRODHASMOTIVESACTIVES( INUPRODUCTID IN MO_MOTIVE.PRODUCT_ID%TYPE, ISBTAGNAME IN MO_MOTIVE.TAG_NAME%TYPE, OSBRESPONSE OUT VARCHAR2, ONUMOTIVEID OUT MO_MOTIVE.MOTIVE_ID%TYPE )
    IS
      CURSOR CUMOTIVE IS
SELECT /*+ INDEX (a IDX_MO_MOTIVE_08)*/
                a.*, a.Rowid
            FROM Mo_Motive a
            WHERE a.Product_Id = inuProductId
            AND a.Tag_Name = isbTagName;
      RCMOTIVE DAMO_MOTIVE.STYMO_MOTIVE;
      BLEXIST BOOLEAN := FALSE;
    BEGIN
      UT_TRACE.TRACE( 'Inicia MO_BOCnf_Generic_Valid.ValidProdHasMotivesActives. Producto:[' || INUPRODUCTID || ']Tag_Name:[' || ISBTAGNAME || ']', 12 );
      OPEN CUMOTIVE;
      FETCH CUMOTIVE
         INTO RCMOTIVE;
      WHILE CUMOTIVE%FOUND
       LOOP
         UT_TRACE.TRACE( 'Motivo:[' || RCMOTIVE.MOTIVE_ID || ']Estado:[' || RCMOTIVE.MOTIVE_STATUS_ID || ']', 14 );
         IF ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCMOTIVE.MOTIVE_STATUS_ID ) ) THEN
            OSBRESPONSE := MO_BOPARAMETER.FSBGETYES;
            ONUMOTIVEID := RCMOTIVE.MOTIVE_ID;
            BLEXIST := TRUE;
            EXIT;
         END IF;
         FETCH CUMOTIVE
            INTO RCMOTIVE;
      END LOOP;
      CLOSE CUMOTIVE;
      IF ( NOT BLEXIST ) THEN
         OSBRESPONSE := MO_BOPARAMETER.FSBGETNO;
      END IF;
      UT_TRACE.TRACE( 'Respuesta:[' || OSBRESPONSE || ']Motivo Encontrado:[' || ONUMOTIVEID || ']', 12 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         IF ( CUMOTIVE%ISOPEN ) THEN
            CLOSE CUMOTIVE;
         END IF;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF ( CUMOTIVE%ISOPEN ) THEN
            CLOSE CUMOTIVE;
         END IF;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END VALIDPRODHASMOTIVESACTIVES;
END PR_BOVALIDATE;
/


