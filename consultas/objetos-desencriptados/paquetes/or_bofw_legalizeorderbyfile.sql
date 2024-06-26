CREATE OR REPLACE PACKAGE BODY OR_BOFW_LEGALIZEORDERBYFILE IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO185466';
   CNUERR_FINAL_DATE CONSTANT NUMBER := 811;
   CNUERR_PASS CONSTANT NUMBER := 7971;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE LEGALIZEBYFILE
    IS
      SBOPERATING_UNIT_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBLEGALIZE_PASSWORD GE_BOINSTANCECONTROL.STYSBVALUE;
      SBINITIAL_DATE GE_BOINSTANCECONTROL.STYSBVALUE;
      SBFINAL_DATE GE_BOINSTANCECONTROL.STYSBVALUE;
      SBDIRECTORY_ID GE_BOINSTANCECONTROL.STYSBVALUE;
      SBFILENAME GE_BOINSTANCECONTROL.STYSBVALUE;
      DTINITIAL OR_ORDER.EXEC_INITIAL_DATE%TYPE;
      DTFINAL OR_ORDER.EXECUTION_FINAL_DATE%TYPE;
      SBPATHFILE GE_DIRECTORY.PATH%TYPE;
      NUOPERATINGUNITID OR_OPERATING_UNIT.OPERATING_UNIT_ID%TYPE;
    BEGIN
      SBOPERATING_UNIT_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_OPERATING_UNIT', 'OPERATING_UNIT_ID' );
      SBLEGALIZE_PASSWORD := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_OPERATING_UNIT', 'LEGALIZE_PASSWORD' );
      SBINITIAL_DATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'EXEC_INITIAL_DATE' );
      SBFINAL_DATE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'OR_ORDER', 'EXECUTION_FINAL_DATE' );
      SBDIRECTORY_ID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DIRECTORY_ID' );
      SBFILENAME := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_BATCH_PROCESS', 'FILE_NAME' );
      SBPATHFILE := DAGE_DIRECTORY.FSBGETPATH( SBDIRECTORY_ID );
      NUOPERATINGUNITID := UT_CONVERT.FNUCHARTONUMBER( SBOPERATING_UNIT_ID );
      DTINITIAL := TO_DATE( SBINITIAL_DATE, UT_DATE.FSBDATE_FORMAT );
      DTFINAL := TO_DATE( SBFINAL_DATE, UT_DATE.FSBDATE_FORMAT );
      IF ( NUOPERATINGUNITID IS NOT NULL ) THEN
         IF ( DAOR_OPERATING_UNIT.FSBGETPASSWORD_REQUIRED( NUOPERATINGUNITID ) = GE_BOCONSTANTS.CSBYES ) THEN
            IF ( SBLEGALIZE_PASSWORD IS NULL AND DAOR_OPERATING_UNIT.FSBGETLEGALIZE_PASSWORD( NUOPERATINGUNITID ) IS NOT NULL OR SBLEGALIZE_PASSWORD IS NOT NULL AND DAOR_OPERATING_UNIT.FSBGETLEGALIZE_PASSWORD( NUOPERATINGUNITID ) IS NULL OR SBLEGALIZE_PASSWORD != DAOR_OPERATING_UNIT.FSBGETLEGALIZE_PASSWORD( NUOPERATINGUNITID ) ) THEN
               GE_BOERRORS.SETERRORCODE( CNUERR_PASS );
            END IF;
         END IF;
      END IF;
      IF ( DTFINAL > SYSDATE ) THEN
         GE_BOERRORS.SETERRORCODE( CNUERR_FINAL_DATE );
      END IF;
      GE_BOUTILITIES.VALIDDATE( DTINITIAL, DTFINAL );
      OR_BOACTIVITIESLEGALIZEBYFILE.LEGALIZEFROMFILE( SBPATHFILE, SBFILENAME, DTINITIAL, DTFINAL, NUOPERATINGUNITID );
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
END OR_BOFW_LEGALIZEORDERBYFILE;
/


