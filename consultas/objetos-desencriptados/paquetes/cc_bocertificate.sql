CREATE OR REPLACE PACKAGE BODY CC_BOCERTIFICATE IS
   CSBVERSION CONSTANT VARCHAR2( 10 ) := 'SAO189401';
   CNUDOC_PYS CONSTANT GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE := 131;
   CNUDOC_PAIDS CONSTANT GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE := 134;
   CNUDOC_DEBT_DETAIL CONSTANT GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE := 133;
   CNUDOC_STATUS_ACCOUNT CONSTANT GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE := 132;
   CSBTAG_PYS CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_SOLICITUD_DE_CERTIFICADO_DE_PAZ_Y_SALVO_272';
   CSBTAG_DEBT_DETAIL CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_DEUDA_POR_CONCEPTO_274';
   CSBTAG_STATUS_ACCOUNT CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_SOLICITUD_DE_CERTIFICADO_DE_ESTADO_DE_CUENTA_273';
   CSBTAG_PAIDS CONSTANT MO_PACKAGES.TAG_NAME%TYPE := 'P_SOLICITUD_DE_CONSTANCIA_DE_PAGOS_275';
   CNUTRACE_LEVEL CONSTANT NUMBER := 4;
   CSBGEN_PRINTING_EXE CONSTANT NUMBER := 8189;
   GNUPACKAGESID MO_PACKAGES.PACKAGE_ID%TYPE;
   GRCMOTIVE DAMO_MOTIVE.STYMO_MOTIVE;
   FUNCTION FNUPACKAGESID
    RETURN MO_PACKAGES.PACKAGE_ID%TYPE
    IS
    BEGIN
      RETURN GNUPACKAGESID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUPACKAGESID;
   FUNCTION FNUMOTIVEID
    RETURN MO_MOTIVE.MOTIVE_ID%TYPE
    IS
    BEGIN
      RETURN GRCMOTIVE.MOTIVE_ID;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUMOTIVEID;
   PROCEDURE GENERATEPDF( INUPACKAGESID IN MO_PACKAGES.PACKAGE_ID%TYPE, INUDOCUMENTTYPE IN GE_DOCUMENT_TYPE.DOCUMENT_TYPE_ID%TYPE, ISBNAMEDOCUMENT IN VARCHAR, IBLPOSTEXE IN BOOLEAN := TRUE )
    IS
      CLCLOBDATA CLOB;
      NUFORMATCODI ED_FORMATO.FORMCODI%TYPE;
      SBNOMPLANTILL ED_PLANTILL.PLANNOMB%TYPE;
      PROCEDURE CLOSECURSORS
       IS
       BEGIN
         IF ( CC_BCCERTIFICATE.CUCONFIGBYDOCTYPE%ISOPEN ) THEN
            CLOSE CC_BCCERTIFICATE.CUCONFIGBYDOCTYPE;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END CLOSECURSORS;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GeneratePDF', CNUTRACE_LEVEL );
      CLOSECURSORS;
      OPEN CC_BCCERTIFICATE.CUCONFIGBYDOCTYPE( INUDOCUMENTTYPE );
      FETCH CC_BCCERTIFICATE.CUCONFIGBYDOCTYPE
         INTO NUFORMATCODI, SBNOMPLANTILL;
      CLOSE CC_BCCERTIFICATE.CUCONFIGBYDOCTYPE;
      IF ( NUFORMATCODI IS NULL ) THEN
         ERRORS.SETERROR( 2741, 'No se ha definido un formato de extracci�n para el tipo de documento [' || INUDOCUMENTTYPE || ']' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      IF ( SBNOMPLANTILL IS NULL ) THEN
         ERRORS.SETERROR( 2741, 'No se ha definido una plantilla para el tipo de documento [' || INUDOCUMENTTYPE || ']' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      GNUPACKAGESID := INUPACKAGESID;
      GRCMOTIVE := MO_BOPACKAGES.FRCGETINITIALMOTIVE( GNUPACKAGESID, FALSE );
      UT_TRACE.TRACE( 'Motivo [' || GRCMOTIVE.MOTIVE_ID || ']', CNUTRACE_LEVEL + 1 );
      UT_TRACE.TRACE( 'Ejecuta Formato [' || NUFORMATCODI || '][' || SBNOMPLANTILL || ']', CNUTRACE_LEVEL + 1 );
      PKBODATAEXTRACTOR.EXECUTERULES( NUFORMATCODI, CLCLOBDATA );
      PKBOED_DOCUMENTMEM.SETFILEINTEMP( TRUE );
      PKBOED_DOCUMENTMEM.SETEXECUTEFILE( TRUE );
      ID_BOGENERALPRINTING.SETISDATAFROMFILE( FALSE );
      PKBOED_DOCUMENTMEM.SETTEMPLATE( SBNOMPLANTILL );
      PKBOED_DOCUMENTMEM.SET_PRINTDOC( CLCLOBDATA );
      PKBOED_DOCUMENTMEM.SETBASICDATAEXME( NULL, ISBNAMEDOCUMENT );
      IF ( NOT IBLPOSTEXE ) THEN
         GE_BOIOPENEXECUTABLE.SETONEVENT( CSBGEN_PRINTING_EXE, 'POST_REGISTER' );
      END IF;
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GeneratePDF', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSECURSORS;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSECURSORS;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GENERATEPDF;
   PROCEDURE GENERATECERTBALDET( INUPACKAGES IN MO_PACKAGES.PACKAGE_ID%TYPE, IBLPOSTEXE IN BOOLEAN )
    IS
      RCPACKAGES DAMO_PACKAGES.STYMO_PACKAGES;
      TBPRODUCTS DAPR_PRODUCT.TYTBPRODUCT_ID;
      PROCEDURE CLOSECURSORS
       IS
       BEGIN
         IF ( CC_BCCERTIFICATE.CUPRODUCTSBYPACK%ISOPEN ) THEN
            CLOSE CC_BCCERTIFICATE.CUPRODUCTSBYPACK;
         END IF;
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END CLOSECURSORS;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GenerateCertBalDet', CNUTRACE_LEVEL );
      CLOSECURSORS;
      IF ( NOT IBLPOSTEXE ) THEN
         DAMO_PACKAGES.ACCKEY( INUPACKAGES );
      END IF;
      OPEN CC_BCCERTIFICATE.CUPRODUCTSBYPACK( INUPACKAGES );
      FETCH CC_BCCERTIFICATE.CUPRODUCTSBYPACK
         BULK COLLECT INTO TBPRODUCTS;
      CLOSE CC_BCCERTIFICATE.CUPRODUCTSBYPACK;
      IF ( TBPRODUCTS.COUNT <= 0 ) THEN
         ERRORS.SETERROR( 2741, 'La Solicitud [' || INUPACKAGES || '] no tiene motivos con productos ' || 'asociados, necesarios para generar el certificado' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      CC_BOCERTACCOUNTDETAIL.CALCULESTATUSACCOUNTS( TBPRODUCTS );
      GENERATEPDF( INUPACKAGES, CNUDOC_DEBT_DETAIL, 'EstadoDetallado-' || INUPACKAGES, IBLPOSTEXE );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GenerateCertBalDet', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         CLOSECURSORS;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         CLOSECURSORS;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GENERATECERTBALDET;
   PROCEDURE VALPRODTOPYS( INUPRODUCTID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
      NUVALUECOR NUMBER;
      NUVALUEDIF NUMBER;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.ValProdToPyS', CNUTRACE_LEVEL );
      IF ( PKTBLSERVSUSC.FSBGETSESUESFN( INUPRODUCTID ) = PKBILLCONST.CSBEST_CASTIGADO ) THEN
         ERRORS.SETERROR( 2741, 'El producto presenta cartera castigada' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      NUVALUECOR := PKBCCUENCOBR.FNUGETPRODUCTTOTALVALUE( INUPRODUCTID );
      IF ( NUVALUECOR > PKBILLCONST.CERO ) THEN
         ERRORS.SETERROR( 41, NUVALUECOR );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      NUVALUEDIF := PKDEFERREDMGR.FNUGETDEFERREDBALSERVICE( INUPRODUCTID );
      IF ( NUVALUEDIF > PKBILLCONST.CERO ) THEN
         ERRORS.SETERROR( 42, NUVALUEDIF );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.ValProdToPyS', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END VALPRODTOPYS;
   PROCEDURE GENERATEPAZYSALVO( INUPACKAGES IN MO_PACKAGES.PACKAGE_ID%TYPE, IBLPOSTEXE IN BOOLEAN )
    IS
      NUPRODUCT PR_PRODUCT.PRODUCT_ID%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GeneratePazySalvo', CNUTRACE_LEVEL );
      IF ( NOT IBLPOSTEXE ) THEN
         DAMO_PACKAGES.ACCKEY( INUPACKAGES );
      END IF;
      NUPRODUCT := MO_BOPACKAGES.FRCGETINITIALMOTIVE( INUPACKAGES ).PRODUCT_ID;
      DAPR_PRODUCT.ACCKEY( NUPRODUCT );
      VALPRODTOPYS( NUPRODUCT );
      GENERATEPDF( INUPACKAGES, CNUDOC_PYS, 'PazYSalvo-' || INUPACKAGES || '-', IBLPOSTEXE );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GeneratePazySalvo', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GENERATEPAZYSALVO;
   PROCEDURE GENERATECERTPAIDS( INUPACKAGES IN MO_PACKAGES.PACKAGE_ID%TYPE, IBLPOSTEXE IN BOOLEAN )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GenerateCertPaids', CNUTRACE_LEVEL );
      GENERATEPDF( INUPACKAGES, CNUDOC_PAIDS, 'ConstanciaPagos-' || INUPACKAGES || '-', IBLPOSTEXE );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GenerateCertPaids', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GENERATECERTPAIDS;
   PROCEDURE GENERATECERTBALRES( INUPACKAGES IN MO_PACKAGES.PACKAGE_ID%TYPE, IBLPOSTEXE IN BOOLEAN )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GenerateCertBalRes', CNUTRACE_LEVEL );
      GENERATEPDF( INUPACKAGES, CNUDOC_STATUS_ACCOUNT, 'EstadoDeCuenta-' || INUPACKAGES || '-', IBLPOSTEXE );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GenerateCertBalRes', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GENERATECERTBALRES;
   PROCEDURE GENCERTGENERIC( INUPACKAGES IN MO_PACKAGES.PACKAGE_ID%TYPE )
    IS
      RCPACKAGES DAMO_PACKAGES.STYMO_PACKAGES;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GenCertGeneric', CNUTRACE_LEVEL );
      RCPACKAGES := DAMO_PACKAGES.FRCGETRECORD( INUPACKAGES );
      IF ( RCPACKAGES.TAG_NAME = CSBTAG_PYS ) THEN
         GENERATEPAZYSALVO( INUPACKAGES, TRUE );
      END IF;
      IF ( RCPACKAGES.TAG_NAME = CSBTAG_DEBT_DETAIL ) THEN
         GENERATECERTBALDET( INUPACKAGES, TRUE );
      END IF;
      IF ( RCPACKAGES.TAG_NAME = CSBTAG_STATUS_ACCOUNT ) THEN
         GENERATECERTBALRES( INUPACKAGES, TRUE );
      END IF;
      IF ( RCPACKAGES.TAG_NAME = CSBTAG_PAIDS ) THEN
         GENERATECERTPAIDS( INUPACKAGES, TRUE );
      END IF;
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GenCertGeneric', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GENCERTGENERIC;
   PROCEDURE GETSTATUSDETAIL( ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIA CC_BOCertificate.GetStatusDetail', CNUTRACE_LEVEL );
      CC_BOCERTACCOUNTDETAIL.GETCHARGESDETAIL( ORFCURSOR );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GetStatusDetail', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETSTATUSDETAIL;
   PROCEDURE GETDIFEDETAIL( ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GetDifeDetail', CNUTRACE_LEVEL );
      CC_BOCERTACCOUNTDETAIL.GETDIFEBALADETAIL( ORFCURSOR );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GetDifeDetail', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETDIFEDETAIL;
   PROCEDURE GETPAYSDETAIL( ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GetPaysDetail', CNUTRACE_LEVEL );
      FA_BOCERTIFICATES.GETPAYMENTSINFO( GRCMOTIVE.SUBSCRIPTION_ID, GRCMOTIVE.PROV_INITIAL_DATE, GRCMOTIVE.PROV_FINAL_DATE, ORFCURSOR );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GetPaysDetail', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETPAYSDETAIL;
   PROCEDURE GETSTATUSACCOUNT( ORFCURSOR OUT CONSTANTS.TYREFCURSOR )
    IS
      TBPRODUCTS DAPR_PRODUCT.TYTBPRODUCT_ID;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.GetStatusAccount', CNUTRACE_LEVEL );
      OPEN CC_BCCERTIFICATE.CUPRODUCTSBYPACK( GNUPACKAGESID );
      FETCH CC_BCCERTIFICATE.CUPRODUCTSBYPACK
         BULK COLLECT INTO TBPRODUCTS;
      CLOSE CC_BCCERTIFICATE.CUPRODUCTSBYPACK;
      FA_BOCERTIFICATES.GETACCOUNTSTATEMENTS( GRCMOTIVE.SUBSCRIPTION_ID, TBPRODUCTS, GRCMOTIVE.PROV_INITIAL_DATE, GRCMOTIVE.PROV_FINAL_DATE, ORFCURSOR );
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.GetStatusAccount', CNUTRACE_LEVEL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END GETSTATUSACCOUNT;
   FUNCTION FNUVALPACKCERTIFICATE( INUPACKAGESID IN MO_PACKAGES.PACKAGE_ID%TYPE )
    RETURN NUMBER
    IS
      NUISPACKCERT NUMBER;
      TAG_NAME MO_PACKAGES.TAG_NAME%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'INICIO CC_BOCertificate.fnuValPackCertificate', CNUTRACE_LEVEL );
      UT_TRACE.TRACE( 'Solicitud [' || INUPACKAGESID || ']', CNUTRACE_LEVEL + 1 );
      NUISPACKCERT := 0;
      IF ( INUPACKAGESID IS NOT NULL ) THEN
         TAG_NAME := DAMO_PACKAGES.FSBGETTAG_NAME( INUPACKAGESID );
         IF ( TAG_NAME = CSBTAG_PYS OR TAG_NAME = CSBTAG_DEBT_DETAIL OR TAG_NAME = CSBTAG_STATUS_ACCOUNT OR TAG_NAME = CSBTAG_PAIDS ) THEN
            NUISPACKCERT := 1;
         END IF;
      END IF;
      UT_TRACE.TRACE( 'FIN CC_BOCertificate.fnuValPackCertificate', CNUTRACE_LEVEL );
      RETURN NUISPACKCERT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FNUVALPACKCERTIFICATE;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END FSBVERSION;
END CC_BOCERTIFICATE;
/

