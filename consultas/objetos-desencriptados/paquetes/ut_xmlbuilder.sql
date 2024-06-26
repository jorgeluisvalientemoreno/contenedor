CREATE OR REPLACE PACKAGE BODY UT_XMLBUILDER IS
   GSBXMLDATA VARCHAR2( 32767 ) := '';
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO157081';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END FSBVERSION;
   PROCEDURE ADDDATATOXML( ISBXMLDATA IN VARCHAR2 )
    IS
    BEGIN
      GSBXMLDATA := GSBXMLDATA || ISBXMLDATA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ADDDATATOXML;
   PROCEDURE ADDNODE( ISBNODENAME IN VARCHAR2, IBLISNULLNODE IN BOOLEAN := FALSE, ISBNAMESPACE IN VARCHAR2 := NULL )
    IS
      SBNAMESPACETAG VARCHAR2( 4000 ) := '';
    BEGIN
      IF ( ISBNAMESPACE IS NOT NULL ) THEN
         SBNAMESPACETAG := ISBNAMESPACE || ':';
      END IF;
      IF ( IBLISNULLNODE ) THEN
         ADDDATATOXML( CHR( 13 ) || '<' || SBNAMESPACETAG || ISBNODENAME || ' />' );
       ELSE
         ADDDATATOXML( CHR( 13 ) || '<' || SBNAMESPACETAG || ISBNODENAME || '>' );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ADDNODE;
   PROCEDURE ENDNODE( ISBNODENAME IN VARCHAR2, ISBNAMESPACE IN VARCHAR2 := NULL )
    IS
      SBNAMESPACETAG VARCHAR2( 4000 ) := '';
    BEGIN
      IF ( ISBNAMESPACE IS NOT NULL ) THEN
         SBNAMESPACETAG := ISBNAMESPACE || ':';
      END IF;
      ADDDATATOXML( CHR( 13 ) || '</' || SBNAMESPACETAG || ISBNODENAME || '>' );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ENDNODE;
   PROCEDURE ADDITEMNODE( ISBITEMNAME IN VARCHAR2, ISBITEMVALUE IN VARCHAR2, ISBNAMESPACE IN VARCHAR2 := NULL )
    IS
      SBNAMESPACETAG VARCHAR2( 4000 ) := '';
    BEGIN
      IF ( ISBNAMESPACE IS NOT NULL ) THEN
         SBNAMESPACETAG := ISBNAMESPACE || ':';
      END IF;
      IF ( ISBITEMVALUE IS NULL ) THEN
         ADDDATATOXML( CHR( 13 ) || '<' || SBNAMESPACETAG || ISBITEMNAME || ' />' );
       ELSE
         ADDDATATOXML( CHR( 13 ) || '<' || SBNAMESPACETAG || ISBITEMNAME || '>' || ISBITEMVALUE || '</' || SBNAMESPACETAG || ISBITEMNAME || '>' );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END ADDITEMNODE;
   FUNCTION FSBGETXMLBUILD
    RETURN VARCHAR2
    IS
    BEGIN
      UT_TRACE.TRACE( 'UT_XMLBuilder.fsbGetXMLBuild [' || GSBXMLDATA || ']', 2 );
      RETURN GSBXMLDATA;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END FSBGETXMLBUILD;
   PROCEDURE CLEAR
    IS
    BEGIN
      GSBXMLDATA := '';
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END CLEAR;
END UT_XMLBUILDER;
/


