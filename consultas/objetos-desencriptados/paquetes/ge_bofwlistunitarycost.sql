
CREATE OR REPLACE PACKAGE BODY GE_BOFWLISTUNITARYCOST IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO179446';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE UPDTITEMCOSTLISTFROMFILE
    IS
      SBDIRECTORY GE_BOINSTANCECONTROL.STYSBVALUE;
      SBFILE GE_BOINSTANCECONTROL.STYSBVALUE;
      NUDIRECTORY_ID GE_DIRECTORY.DIRECTORY_ID%TYPE;
    BEGIN
      SBDIRECTORY := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DIRECTORY_ID' );
      SBFILE := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_DIRECTORY', 'DESCRIPTION' );
      NUDIRECTORY_ID := UT_CONVERT.FNUCHARTONUMBER( SBDIRECTORY );
      GE_BOCOSTLISTUPDBYFILE.UPDATEUNITARYCOSTLISTBYFILE( NUDIRECTORY_ID, SBFILE );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSTANCEFORMSLISTATTRIBUTES
    IS
      SBSOURCELISTID GE_BOINSTANCECONTROL.STYSBVALUE;
      NUSOURCELISTID GE_LIST_UNITARY_COST.LIST_UNITARY_COST_ID%TYPE;
      SBDESCRIPTION GE_LIST_UNITARY_COST.DESCRIPTION%TYPE;
      DTSTARTDATE GE_LIST_UNITARY_COST.VALIDITY_START_DATE%TYPE;
      DTFINALDATE GE_LIST_UNITARY_COST.VALIDITY_FINAL_DATE%TYPE;
      SBCURRENTINSTANCE VARCHAR2( 800 );
    BEGIN
      GE_BOINSTANCECONTROL.GETCURRENTINSTANCE( SBCURRENTINSTANCE );
      SBSOURCELISTID := GE_BOINSTANCECONTROL.FSBGETFIELDVALUE( 'GE_LIST_UNITARY_COST', 'LIST_UNITARY_COST_ID' );
      NUSOURCELISTID := UT_CONVERT.FNUCHARTONUMBER( SBSOURCELISTID );
      SBDESCRIPTION := DAGE_LIST_UNITARY_COST.FSBGETDESCRIPTION( NUSOURCELISTID );
      DTSTARTDATE := DAGE_LIST_UNITARY_COST.FDTGETVALIDITY_START_DATE( NUSOURCELISTID );
      DTFINALDATE := DAGE_LIST_UNITARY_COST.FDTGETVALIDITY_FINAL_DATE( NUSOURCELISTID );
      GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE( SBCURRENTINSTANCE, NULL, 'GE_ITEMS', 'DESCRIPTION', SBDESCRIPTION );
      GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE( SBCURRENTINSTANCE, NULL, 'OR_ORDER', 'EXEC_ESTIMATE_DATE', TO_CHAR( DTSTARTDATE, 'DD/MM/YYYY' ) );
      GE_BOINSTANCECONTROL.SETATTRIBUTENEWVALUE( SBCURRENTINSTANCE, NULL, 'OR_ORDER', 'MAX_DATE_TO_LEGALIZE', TO_CHAR( DTFINALDATE, 'DD/MM/YYYY' ) );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
END GE_BOFWLISTUNITARYCOST;
/


