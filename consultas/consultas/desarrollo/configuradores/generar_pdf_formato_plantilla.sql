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
         ERRORS.SETERROR( 2741, 'No se ha definido un formato de extraccion para el tipo de documento [' || INUDOCUMENTTYPE || ']' );
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