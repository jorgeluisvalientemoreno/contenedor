CREATE OR REPLACE PACKAGE BODY PS_BOPACKTYPEVALIDATE IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO183620';
   CSBLEVELVALPROD CONSTANT VARCHAR2( 1 ) := 'P';
   CSBLEVELVALCONTRAT CONSTANT VARCHAR2( 1 ) := 'C';
   CNUREINSTALL_MOTIVE_TYPE CONSTANT NUMBER( 4 ) := 10;
   NUERROR_62 CONSTANT NUMBER( 4 ) := 62;
   CNUATTRIB_NULL_STAT_ERR CONSTANT GE_MESSAGE.MESSAGE_ID%TYPE := 119562;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   FUNCTION FBLPRODHASMOTIACTIVES( INUPRODUCTID IN MO_MOTIVE.PRODUCT_ID%TYPE, ISBTAGNAMEPRODMOT IN MO_MOTIVE.TAG_NAME%TYPE )
    RETURN BOOLEAN
    IS
      NUPRODUCTMOTIVEID PS_PRODUCT_MOTIVE.PRODUCT_MOTIVE_ID%TYPE;
      NUMOTIVETYPEID PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%TYPE;
      BOPRODHASMOTIVES BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.fblProdHasMotivesActives. Producto:[' || INUPRODUCTID || ']TAG producto motivo:[' || ISBTAGNAMEPRODMOT || ']', 12 );
      BOPRODHASMOTIVES := FALSE;
      NUPRODUCTMOTIVEID := PS_BOPRODUCTMOTIVE.FNUGETPRODMOTIVEBYTAGNAME( ISBTAGNAMEPRODMOT );
      NUMOTIVETYPEID := DAPS_PRODUCT_MOTIVE.FNUGETMOTIVE_TYPE_ID( NUPRODUCTMOTIVEID );
      IF ( NUMOTIVETYPEID = CNUREINSTALL_MOTIVE_TYPE ) THEN
         FOR RCMOTIVE IN MO_BCMOTIVE.CUMOTIBYSERVNUMBANDTAG( UT_CONVERT.FSBNUMBERTOCHAR( INUPRODUCTID ), ISBTAGNAMEPRODMOT )
          LOOP
            UT_TRACE.TRACE( 'Motivo:[' || RCMOTIVE.MOTIVE_ID || ']Estado:[' || RCMOTIVE.MOTIVE_STATUS_ID || ']', 14 );
            IF ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCMOTIVE.MOTIVE_STATUS_ID ) ) THEN
               BOPRODHASMOTIVES := TRUE;
               EXIT;
            END IF;
         END LOOP;
       ELSE
         FOR RCMOTIVE IN MO_BCMOTIVE.CUMOTIVESBYPRODANDTAG( INUPRODUCTID, ISBTAGNAMEPRODMOT )
          LOOP
            UT_TRACE.TRACE( 'Motivo:[' || RCMOTIVE.MOTIVE_ID || ']Estado:[' || RCMOTIVE.MOTIVE_STATUS_ID || ']', 14 );
            IF ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCMOTIVE.MOTIVE_STATUS_ID ) ) THEN
               BOPRODHASMOTIVES := TRUE;
               EXIT;
            END IF;
         END LOOP;
      END IF;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.fblProdHasMotivesActives', 12 );
      RETURN BOPRODHASMOTIVES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FBLPRODHASPACKACTIVES( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBTAGNAMEPACKTYPE IN MO_PACKAGES.TAG_NAME%TYPE )
    RETURN BOOLEAN
    IS
      BOPRODHASPACKACT BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.fblProdHasPackActives. Producto:[' || INUPRODUCTID || ']Tag del tipo paquete:[' || ISBTAGNAMEPACKTYPE || ']', 12 );
      BOPRODHASPACKACT := FALSE;
      FOR RCPACKAGESBYPROD IN MO_BCPACKAGES.CUPACKAGESBYPROD( INUPRODUCTID, ISBTAGNAMEPACKTYPE )
       LOOP
         UT_TRACE.TRACE( 'Paquete:[' || RCPACKAGESBYPROD.PACKAGE_ID || ']Estado:[' || RCPACKAGESBYPROD.MOTIVE_STATUS_ID || ']', 14 );
         IF ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCPACKAGESBYPROD.MOTIVE_STATUS_ID ) ) THEN
            BOPRODHASPACKACT := TRUE;
            EXIT;
         END IF;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.fblProdHasPackActives', 12 );
      RETURN BOPRODHASPACKACT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FBLSUBSCHASPACKACTIVES( INUSUBSCRIPTIONID IN MO_MOTIVE.SUBSCRIPTION_ID%TYPE, ISBTAGNAMEPACKTYPE IN MO_PACKAGES.TAG_NAME%TYPE )
    RETURN BOOLEAN
    IS
      BOSUBSCHASACTVPACK BOOLEAN;
      PROCEDURE VALIDATEDATA
       IS
       BEGIN
         IF ( INUSUBSCRIPTIONID IS NULL ) THEN
            ERRORS.SETERROR( CNUATTRIB_NULL_STAT_ERR, 'Identificador del Contrato' );
            RAISE EX.CONTROLLED_ERROR;
         END IF;
         PKTBLSUSCRIPC.ACCKEY( INUSUBSCRIPTIONID );
         IF ( ISBTAGNAMEPACKTYPE IS NULL ) THEN
            ERRORS.SETERROR( CNUATTRIB_NULL_STAT_ERR, 'TagName de la Solicitud' );
            RAISE EX.CONTROLLED_ERROR;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.fblSubscHasPackActives. Subscripcion:[' || INUSUBSCRIPTIONID || ']Tag del tipo paquete:[' || ISBTAGNAMEPACKTYPE || ']', 12 );
      VALIDATEDATA;
      BOSUBSCHASACTVPACK := FALSE;
      FOR RCPACKAGESBYSUBS IN PS_BCPACKTYPEVALIDATE.CUPACKBYSUBSCRIPTION( INUSUBSCRIPTIONID, ISBTAGNAMEPACKTYPE )
       LOOP
         UT_TRACE.TRACE( 'Paquete:[' || RCPACKAGESBYSUBS.PACKAGE_ID || ']Estado:[' || RCPACKAGESBYSUBS.MOTIVE_STATUS_ID || ']', 14 );
         IF ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCPACKAGESBYSUBS.MOTIVE_STATUS_ID ) ) THEN
            BOSUBSCHASACTVPACK := TRUE;
            EXIT;
         END IF;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.fblSubscHasPackActives', 12 );
      RETURN BOSUBSCHASACTVPACK;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FBLSUBSCHASPACKACTIVES;
   FUNCTION FBLCOMPHASMOTIACTIVES( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUCOMPONENTID IN PR_COMPONENT.COMPONENT_ID%TYPE, ISBTAGNAMEPRODMOT IN MO_MOTIVE.TAG_NAME%TYPE )
    RETURN BOOLEAN
    IS
      NUMOTIVETYPEID PS_PRODUCT_MOTIVE.MOTIVE_TYPE_ID%TYPE;
      BOPRODHASMOTIVES BOOLEAN;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.fblCompHasMotiActives. Componente:[' || INUCOMPONENTID || ']TAG producto motivo:[' || ISBTAGNAMEPRODMOT || ']', 12 );
      BOPRODHASMOTIVES := FALSE;
      FOR RCMOTIVE IN MO_BCMOTIVE.CUMOTIVESBYPRODANDTAG( INUPRODUCTID, ISBTAGNAMEPRODMOT )
       LOOP
         FOR RCCOMPONENT IN MO_BCCOMPONENT.CUCOMPONENTSBYMOT( RCMOTIVE.MOTIVE_ID )
          LOOP
            IF ( RCCOMPONENT.COMPONENT_ID_PROD = INUCOMPONENTID AND ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCCOMPONENT.MOTIVE_STATUS_ID ) ) ) THEN
               BOPRODHASMOTIVES := TRUE;
               EXIT;
            END IF;
         END LOOP;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.fblCompHasMotiActives', 12 );
      RETURN BOPRODHASMOTIVES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALPENDPACKTYPEPROD( INUPACKAGETYPEID IN PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE, INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBSETERROR IN VARCHAR2, OSBRESPONSE OUT VARCHAR2 )
    IS
      NUPACKAGETYPEID PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;
      SBDESCPACKTYPE PS_PACKAGE_TYPE.DESCRIPTION%TYPE;
      SBTAGNAMEPACKTYPE PS_PACKAGE_TYPE.TAG_NAME%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.valpendPackTypeProd. Tipo paquete:[' || INUPACKAGETYPEID || '] Producto :[' || INUPRODUCTID || ']', 12 );
      OSBRESPONSE := MO_BOPARAMETER.FSBGETNO;
      SBTAGNAMEPACKTYPE := DAPS_PACKAGE_TYPE.FSBGETTAG_NAME( INUPACKAGETYPEID );
      FOR RCVALSPACK IN PS_BCPACKTYPEVALIDATE.CUVALIDPACKTYPE( SBTAGNAMEPACKTYPE, CSBLEVELVALPROD )
       LOOP
         IF ( FBLPRODHASPACKACTIVES( INUPRODUCTID, RCVALSPACK.TAG_NAME_VALID ) ) THEN
            UT_TRACE.TRACE( 'antes if', 12 );
            IF ( ISBSETERROR = GE_BOCONSTANTS.CSBYES ) THEN
               UT_TRACE.TRACE( 'antes tipo paque', 12 );
               NUPACKAGETYPEID := PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME( RCVALSPACK.TAG_NAME_VALID );
               UT_TRACE.TRACE( 'antes tipo desc', 12 );
               SBDESCPACKTYPE := DAPS_PACKAGE_TYPE.FSBGETDESCRIPTION( NUPACKAGETYPEID );
               UT_TRACE.TRACE( 'antes tipo erro', 12 );
               ERRORS.SETERROR( NUERROR_62, SBDESCPACKTYPE );
               RAISE EX.CONTROLLED_ERROR;
             ELSE
               OSBRESPONSE := MO_BOPARAMETER.FSBGETYES;
               RETURN;
            END IF;
         END IF;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.valpendPackTypeProd.', 12 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALPENDREQBYCONTRACT( INUPACKAGETYPEID IN PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE, INUSUBSCRIPTIONID IN SUSCRIPC.SUSCCODI%TYPE, ISBSETERROR IN VARCHAR2, OSBRESPONSE OUT VARCHAR2 )
    IS
      NUPACKAGETYPEID PS_PACKAGE_TYPE.PACKAGE_TYPE_ID%TYPE;
      SBDESCPACKTYPE PS_PACKAGE_TYPE.DESCRIPTION%TYPE;
      SBTAGNAMEPACKTYPE PS_PACKAGE_TYPE.TAG_NAME%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.pendReqValByContract. Tipo paquete:[' || INUPACKAGETYPEID || '] Contrato :[' || INUSUBSCRIPTIONID || ']', 12 );
      OSBRESPONSE := MO_BOPARAMETER.FSBGETNO;
      SBTAGNAMEPACKTYPE := DAPS_PACKAGE_TYPE.FSBGETTAG_NAME( INUPACKAGETYPEID );
      FOR RCVALSPACK IN PS_BCPACKTYPEVALIDATE.CUVALIDPACKTYPE( SBTAGNAMEPACKTYPE, CSBLEVELVALCONTRAT )
       LOOP
         IF ( FBLSUBSCHASPACKACTIVES( INUSUBSCRIPTIONID, RCVALSPACK.TAG_NAME_VALID ) ) THEN
            IF ( ISBSETERROR = GE_BOCONSTANTS.CSBYES ) THEN
               NUPACKAGETYPEID := PS_BOPACKAGETYPE.FNUGETPACKTYPEBYTAGNAME( RCVALSPACK.TAG_NAME_VALID );
               SBDESCPACKTYPE := DAPS_PACKAGE_TYPE.FSBGETDESCRIPTION( NUPACKAGETYPEID );
               ERRORS.SETERROR( NUERROR_62, SBDESCPACKTYPE );
               RAISE EX.CONTROLLED_ERROR;
             ELSE
               OSBRESPONSE := MO_BOPARAMETER.FSBGETYES;
               RETURN;
            END IF;
         END IF;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.pendReqValByContract.', 12 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FTBGETPACKACTIVESPROD( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBTAGNAMEPACKTYPE IN MO_PACKAGES.TAG_NAME%TYPE )
    RETURN DAMO_PACKAGES.TYTBMO_PACKAGES
    IS
      TBPACKAGES DAMO_PACKAGES.TYTBMO_PACKAGES;
      NUINDEXPACKAGES NUMBER;
      PROCEDURE CLOSECURSOR
       IS
       BEGIN
         IF ( MO_BCPACKAGES.CUPACKAGESBYPROD%ISOPEN ) THEN
            CLOSE MO_BCPACKAGES.CUPACKAGESBYPROD;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END;
    BEGIN
      UT_TRACE.TRACE( 'Inicia Metodo PS_BOPackTypeValidate.ftbGetPackActivesProd. Producto:[' || INUPRODUCTID || ']Tag del tipo paquete:[' || ISBTAGNAMEPACKTYPE || ']', 12 );
      CLOSECURSOR;
      TBPACKAGES.DELETE;
      NUINDEXPACKAGES := 1;
      FOR RCPACKAGESBYPROD IN MO_BCPACKAGES.CUPACKAGESBYPROD( INUPRODUCTID, ISBTAGNAMEPACKTYPE )
       LOOP
         UT_TRACE.TRACE( 'Paquete:[' || RCPACKAGESBYPROD.PACKAGE_ID || ']Estado:[' || RCPACKAGESBYPROD.MOTIVE_STATUS_ID || ']', 14 );
         IF ( NOT PS_BOMOTIVESTATUS.FBLISFINALSTATUS( RCPACKAGESBYPROD.MOTIVE_STATUS_ID ) ) THEN
            TBPACKAGES( NUINDEXPACKAGES ) := RCPACKAGESBYPROD;
            NUINDEXPACKAGES := NUINDEXPACKAGES + 1;
         END IF;
      END LOOP;
      UT_TRACE.TRACE( 'Finaliza Metodo PS_BOPackTypeValidate.ftbGetPackActivesProd', 12 );
      RETURN TBPACKAGES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSECURSOR;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSECURSOR;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FTBGETPACKACTIVESPROD;
END PS_BOPACKTYPEVALIDATE;
/


