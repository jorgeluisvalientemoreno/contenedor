CREATE OR REPLACE PACKAGE BODY OR_BOFW_ORDERADDITIONALDATA IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO86247';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE ADDORDERADDITIONALDATA
    IS
      SBDIRECTORY_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBFILENAME GE_BOINSTANCECONTROL.STYSBVALUE;
      SBPATHFILE GE_DIRECTORY.PATH%TYPE;
    BEGIN
      SBDIRECTORY_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DIRECTORY_ID' );
      SBFILENAME := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DESCRIPTION' );
      SBPATHFILE := DAGE_DIRECTORY.FSBGETPATH( SBDIRECTORY_ID );
      OR_BOORDERADDITIONALDATA.ADDORDERADDDATAFROMFILE( SBPATHFILE, SBFILENAME );
      COMMIT;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ROLLBACK;
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ROLLBACK;
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSTANCESETATTRIBUTEFORM
    IS
      SBSOURCELISTID GE_BOINSTANCECONTROL.STYSBVALUE;
      NUSOURCELISTID GE_DIRECTORY.DIRECTORY_ID%TYPE;
      SBRUTADIRECT GE_DIRECTORY.PATH%TYPE;
      SBCURRENTINSTANCE VARCHAR2( 800 );
    BEGIN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBCURRENTINSTANCE );
      SBSOURCELISTID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DIRECTORY_ID' );
      NUSOURCELISTID := UT_CONVERT.FNUCHARTONUMBER( SBSOURCELISTID );
      SBRUTADIRECT := DAGE_DIRECTORY.FSBGETPATH( NUSOURCELISTID );
      GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE( SBCURRENTINSTANCE, NULL, 'GE_DIRECTORY', 'PATH', SBRUTADIRECT );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
END OR_BOFW_ORDERADDITIONALDATA;
/

