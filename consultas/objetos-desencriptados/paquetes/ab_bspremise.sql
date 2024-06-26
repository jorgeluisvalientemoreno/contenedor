
CREATE OR REPLACE PACKAGE BODY AB_BSPREMISE IS
   CSBVERSION CONSTANT VARCHAR2( 250 ) := 'SAO188104';
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE CLEARMEMORY
    IS
    BEGIN
      DAAB_ADDRESS.CLEARMEMORY;
      DAAB_PREMISE.CLEARMEMORY;
      DAAB_BLOCK.CLEARMEMORY;
      DAAB_ZIP_CODE.CLEARMEMORY;
   END;
   PROCEDURE VALIDBLOCKNULL( INUBLOCK_ID IN AB_BLOCK.BLOCK_ID%TYPE )
    IS
    BEGIN
      IF INUBLOCK_ID IS NULL THEN
         ERRORS.SETERROR( AB_BOMESSAGE_CONSTANTS.CNUERR_BLOCK_NULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDBLOCKSIDENULL( ISBBLOCKSIDE IN AB_PREMISE.BLOCK_SIDE%TYPE )
    IS
    BEGIN
      IF ISBBLOCKSIDE IS NULL THEN
         ERRORS.SETERROR( AB_BOMESSAGE_CONSTANTS.CNUERR_BLOCK_SIDE_NULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDZONENULL( INUZONE IN AB_BLOCK.ZONE%TYPE )
    IS
    BEGIN
      IF INUZONE IS NULL THEN
         ERRORS.SETERROR( AB_BOMESSAGE_CONSTANTS.CNUERR_ZONE_NULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDSECTORNULL( INUSECTOR IN AB_BLOCK.SECTOR%TYPE )
    IS
    BEGIN
      IF INUSECTOR IS NULL THEN
         ERRORS.SETERROR( AB_BOMESSAGE_CONSTANTS.CNUERR_SECTOR_NULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALIDPREMISENULL( INUPREMISE IN AB_PREMISE.PREMISE%TYPE )
    IS
    BEGIN
      IF INUPREMISE IS NULL THEN
         ERRORS.SETERROR( AB_BOMESSAGE_CONSTANTS.CNUERR_PREMISE_NULL );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INITIALIZEOUTPUTVAR( ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORTEXT := GE_BOCONSTANTS.CSBNOMESSAGE;
   END;
   PROCEDURE GETDESCRIPTIONPREMISETYPE( INUPREMISE_TYPE_ID IN AB_PREMISE_TYPE.PREMISE_TYPE_ID%TYPE, OSBDESCRIPTION OUT AB_PREMISE_TYPE.DESCRIPTION%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORMESSAGE OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORMESSAGE );
      OSBDESCRIPTION := DAAB_PREMISE_TYPE.FSBGETDESCRIPTION( INUPREMISE_TYPE_ID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END;
   PROCEDURE GETPREMISETYPES( ORFPREMISETYPE OUT DAAB_PREMISE_TYPE.TYREFCURSOR, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      ORFPREMISETYPE := AB_BOPREMISE.FRFGETPREMISE_TYPE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE GETBLOCKS( ORFBLOCK OUT DAAB_BLOCK.TYREFCURSOR, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      ORFBLOCK := AB_BOPREMISE.FRFGETBLOCKS;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE VALIDATEBLOCK( INUGEOGRA_LOCATION IN AB_BLOCK.GEOGRAP_LOCATION_ID%TYPE, INUZONE IN AB_BLOCK.ZONE%TYPE, INUSECTOR IN AB_BLOCK.SECTOR%TYPE, INUBLOCK IN AB_BLOCK.BLOCK_%TYPE, ONUBLOCK_ID OUT AB_BLOCK.BLOCK_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      AB_BOPREMISE.VALIDATEEXISTBLOCK( INUGEOGRA_LOCATION, INUZONE, INUSECTOR, INUBLOCK, ONUBLOCK_ID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR( CONSTANTS.CNURECORD_NOT_EXIST, DAAB_BLOCK.FSBGETMESSAGEDESCRIPTION );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE GETPREMISES( ORFPREMISE OUT DAAB_PREMISE.TYREFCURSOR, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      ORFPREMISE := AB_BOPREMISE.FRFGETPREMISES;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE VALIDATEPREMISE( INUBLOCK_ID IN AB_PREMISE.BLOCK_ID%TYPE, ISBBLOCKSIDE IN AB_PREMISE.BLOCK_SIDE%TYPE, INUPREMISE IN AB_PREMISE.PREMISE%TYPE, INUBUILDING IN AB_PREMISE.NUMBER_DIVISION%TYPE, ONUPREMISE_ID OUT AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      AB_BOPREMISE.VALIDATEEXIST( INUBLOCK_ID, ISBBLOCKSIDE, INUPREMISE, INUBUILDING, ONUPREMISE_ID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.SETERROR( CONSTANTS.CNURECORD_NOT_EXIST, DAGE_MESSAGE.FSBGETDESCRIPTION( AB_BOPREMISE.CNUTABLEPARAMETER ) );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE INSERTPREMISE( INUBLOCK_ID IN AB_PREMISE.BLOCK_ID%TYPE, ISBBLOCKSIDE IN AB_PREMISE.BLOCK_SIDE%TYPE, INUPREMISE IN AB_PREMISE.PREMISE%TYPE, INUNUMBERDIVISION IN AB_PREMISE.NUMBER_DIVISION%TYPE, INUPREMISETYPE IN AB_PREMISE.PREMISE_TYPE_ID%TYPE, ISBADDRESS IN AB_ADDRESS.ADDRESS%TYPE, INUZIP_CODE IN AB_PREMISE.ZIP_CODE_ID%TYPE, ONUPREMISEID OUT AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      VALIDBLOCKNULL( INUBLOCK_ID );
      VALIDBLOCKSIDENULL( ISBBLOCKSIDE );
      VALIDPREMISENULL( INUPREMISE );
      AB_BOPREMISE.INSERTPREMISEWITCHSEGMENT( INUBLOCK_ID, ISBBLOCKSIDE, INUPREMISE, INUNUMBERDIVISION, INUPREMISETYPE, ISBADDRESS, INUZIP_CODE, ONUPREMISEID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE INSERTPREMISE( ONUPREMISEID OUT AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      ONUPREMISEID := AB_BOPREMISE.FNUINSERTPREMISE;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE UPDPREMISE( INUPREMISE_ID IN AB_PREMISE.PREMISE_ID%TYPE, ISBADDRESS IN AB_ADDRESS.ADDRESS%TYPE, INUZIP_CODE IN AB_PREMISE.ZIP_CODE_ID%TYPE, ISBCOMPLEMENT IN AB_BUILDING_DIVISION.COMPLEMENT%TYPE, ONUBUILDIVISION_ID OUT AB_BUILDING_DIVISION.BUILDING_DIVISION_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
      RCPREMISE DAAB_PREMISE.STYAB_PREMISE;
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      IF NVL( INUPREMISE_ID, -1 ) = -1 THEN
         RETURN;
      END IF;
      IF ( INUZIP_CODE != AB_BOCONSTANTS.CNUAPPLICATIONNULL ) THEN
         DAAB_PREMISE.UPDZIP_CODE_ID( INUPREMISE_ID, INUZIP_CODE );
       ELSE
         DAAB_PREMISE.UPDZIP_CODE_ID( INUPREMISE_ID, NULL );
      END IF;
      IF ( ISBCOMPLEMENT IS NOT NULL ) THEN
         AB_BOPREMISE.CREATEBUILDINGDIVISION( INUPREMISE_ID, ISBCOMPLEMENT, ONUBUILDIVISION_ID );
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUBUILDIVISION_ID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUBUILDIVISION_ID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE INSERTBUILDINGPREMISE( INUPREMISE_ID IN AB_BUILDING_DIVISION.PREMISE_ID%TYPE, ISBCOMPLEMENT IN AB_BUILDING_DIVISION.COMPLEMENT%TYPE, ONUBUILDING_DIVISION OUT AB_BUILDING_DIVISION.BUILDING_DIVISION_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
      PROCEDURE INSERTBUILDING
       IS
         CUBUILDINGDIVISION DAAB_BUILDING_DIVISION.STYAB_BUILDING_DIVISION;
       BEGIN
         ONUBUILDING_DIVISION := AB_BOSEQUENCE.FNUNEXTBUILDINGDIVISION;
         CUBUILDINGDIVISION.BUILDING_DIVISION_ID := ONUBUILDING_DIVISION;
         CUBUILDINGDIVISION.PREMISE_ID := INUPREMISE_ID;
         CUBUILDINGDIVISION.COMPLEMENT := ISBCOMPLEMENT;
         DAAB_BUILDING_DIVISION.INSRECORD( CUBUILDINGDIVISION );
      END;
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      INSERTBUILDING;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUBUILDING_DIVISION := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUBUILDING_DIVISION := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE UPADDRESSPREMISE( INUPREMISE_ID IN AB_BUILDING_DIVISION.PREMISE_ID%TYPE, ISBADDRESS IN AB_ADDRESS.ADDRESS%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE GETRECORD( INUPREMISE_ID IN AB_PREMISE.PREMISE_ID%TYPE, INUBUILDINGDIVI IN AB_BUILDING_DIVISION.BUILDING_DIVISION_ID%TYPE, ONUGEOGRAPLOCAT OUT AB_BLOCK.GEOGRAP_LOCATION_ID%TYPE, ONUBLOCK_ID OUT AB_BLOCK.BLOCK_ID%TYPE, ONUZONA OUT AB_BLOCK.ZONE%TYPE, ONUSECTOR OUT AB_BLOCK.SECTOR%TYPE, ONUBLOCK OUT AB_BLOCK.BLOCK_%TYPE, OSBBLOCKSIDE OUT AB_PREMISE.BLOCK_SIDE%TYPE, ONUPREMISE OUT AB_PREMISE.PREMISE%TYPE, ONUNUMBERDIVI OUT AB_PREMISE.NUMBER_DIVISION%TYPE, ONUPREMISETYPE OUT AB_PREMISE.PREMISE_TYPE_ID%TYPE, OSBADDRESS OUT AB_ADDRESS.ADDRESS%TYPE, ONUZIP_CODE OUT AB_PREMISE.ZIP_CODE_ID%TYPE, OSBCOMPLEMENT OUT AB_BUILDING_DIVISION.COMPLEMENT%TYPE, OSBPREFIXZIPCODE OUT GE_GEOGRA_LOCATION.PREFIX_ZIP_CODE%TYPE, OSBSUFIXZIPCODE OUT AB_ZIP_CODE.ZIP_CODE%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      AB_BOPREMISE.GETRECORD( INUPREMISE_ID, INUBUILDINGDIVI, ONUGEOGRAPLOCAT, ONUBLOCK_ID, ONUZONA, ONUSECTOR, ONUBLOCK, OSBBLOCKSIDE, ONUPREMISE, ONUNUMBERDIVI, ONUPREMISETYPE, OSBADDRESS, ONUZIP_CODE, OSBCOMPLEMENT, OSBPREFIXZIPCODE, OSBSUFIXZIPCODE );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE GETOWNERS( INUPREMISE_ID IN AB_PREMISE.PREMISE_ID%TYPE, ORFOWNERS OUT DAAB_OWNER_PREMISE.TYRFRECORDS, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      ORFOWNERS := AB_BOPREMISE.FRFGETOWNERS( INUPREMISE_ID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE REGISTEROWNER( INUPREMISE_ID IN AB_PREMISE.PREMISE_ID%TYPE, ISBIDENTIFICATION IN GE_SUBSCRIBER.IDENTIFICATION%TYPE, INUIDENT_TYPE IN GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      AB_BOPREMISE.REGISTEROWNER( INUPREMISE_ID, ISBIDENTIFICATION, INUIDENT_TYPE );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE VALIDATEOWNER( INUTYPEIDENTIFIC_ID IN GE_SUBSCRIBER.IDENT_TYPE_ID%TYPE, ISBIDENTIFICATION_ID IN GE_SUBSCRIBER.IDENTIFICATION%TYPE, ONUSUBSCRIBER_ID OUT GE_SUBSCRIBER.SUBSCRIBER_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      ONUSUBSCRIBER_ID := GE_BOSUBSCRIBER.GETSUBSCRIBERID( INUTYPEIDENTIFIC_ID, ISBIDENTIFICATION_ID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE INSERTPREMISE( INUGEOGRAPLOCATIONID IN AB_BLOCK.GEOGRAP_LOCATION_ID%TYPE, INUZONE IN AB_BLOCK.ZONE%TYPE, INUSECTOR IN AB_BLOCK.SECTOR%TYPE, INUBLOCK_ IN AB_BLOCK.BLOCK_%TYPE, ISBBLOCKSIDE IN AB_PREMISE.BLOCK_SIDE%TYPE, INUPREMISE IN AB_PREMISE.PREMISE%TYPE, INUNUMBERDIVISION IN AB_PREMISE.NUMBER_DIVISION%TYPE, INUPREMISETYPE IN AB_PREMISE.PREMISE_TYPE_ID%TYPE, ISBADDRESS IN AB_ADDRESS.ADDRESS%TYPE, INUZIP_CODE IN AB_PREMISE.ZIP_CODE_ID%TYPE, ONUPREMISEID OUT AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      VALIDBLOCKNULL( INUBLOCK_ );
      VALIDBLOCKSIDENULL( ISBBLOCKSIDE );
      VALIDZONENULL( INUZONE );
      VALIDSECTORNULL( INUSECTOR );
      VALIDPREMISENULL( INUPREMISE );
      AB_BOPREMISE.INSPREMISEWITHSEGMENTBLOCK( INUGEOGRAPLOCATIONID, INUZONE, INUSECTOR, INUBLOCK_, ISBBLOCKSIDE, INUPREMISE, INUNUMBERDIVISION, INUPREMISETYPE, ISBADDRESS, INUZIP_CODE, ONUPREMISEID, NULL );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE GETPREMISEID( INUGEOGRAP_LOCATION_ID IN AB_BLOCK.GEOGRAP_LOCATION_ID%TYPE, INUZONE IN AB_BLOCK.ZONE%TYPE, INUSECTOR IN AB_BLOCK.SECTOR%TYPE, INUBLOCK_ IN AB_BLOCK.BLOCK_%TYPE, ISBBLOCKSIDE IN AB_PREMISE.BLOCK_SIDE%TYPE, INUPREMISE IN AB_PREMISE.PREMISE%TYPE, INUNUMBERDIVISION IN AB_PREMISE.NUMBER_DIVISION%TYPE, ONUPREMISE_ID OUT AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
      PROCEDURE VALIDIMPUTDATA
       IS
       BEGIN
         VALIDBLOCKNULL( INUBLOCK_ );
         VALIDBLOCKSIDENULL( ISBBLOCKSIDE );
         VALIDZONENULL( INUZONE );
         VALIDSECTORNULL( INUSECTOR );
         VALIDPREMISENULL( INUPREMISE );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END;
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      VALIDIMPUTDATA;
      AB_BOPREMISE.EXISTPREMISEWITHSEGMENTBLOCK( INUGEOGRAP_LOCATION_ID, INUZONE, INUSECTOR, INUBLOCK_, ISBBLOCKSIDE, INUPREMISE, INUNUMBERDIVISION, ONUPREMISE_ID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUPREMISE_ID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUPREMISE_ID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE INSERTPREMISE( INUGEOGRAPLOCATIONID IN AB_BLOCK.GEOGRAP_LOCATION_ID%TYPE, INUZONE IN AB_BLOCK.ZONE%TYPE, INUSECTOR IN AB_BLOCK.SECTOR%TYPE, INUBLOCK_ IN AB_BLOCK.BLOCK_%TYPE, ISBBLOCKSIDE IN AB_PREMISE.BLOCK_SIDE%TYPE, INUPREMISE IN AB_PREMISE.PREMISE%TYPE, INUNUMBERDIVISION IN AB_PREMISE.NUMBER_DIVISION%TYPE, INUPREMISETYPE IN AB_PREMISE.PREMISE_TYPE_ID%TYPE, ISBADDRESS IN AB_ADDRESS.ADDRESS%TYPE, INUZIP_CODE IN AB_PREMISE.ZIP_CODE_ID%TYPE, INUADDRESSID IN AB_ADDRESS.ADDRESS_ID%TYPE, ONUPREMISEID OUT AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      INITIALIZEOUTPUTVAR( ONUERRORCODE, OSBERRORTEXT );
      VALIDBLOCKNULL( INUBLOCK_ );
      VALIDBLOCKSIDENULL( ISBBLOCKSIDE );
      VALIDZONENULL( INUZONE );
      VALIDSECTORNULL( INUSECTOR );
      VALIDPREMISENULL( INUPREMISE );
      CLEARMEMORY;
      AB_BOPREMISE.INSPREMISEWITHSEGMENTBLOCK( INUGEOGRAPLOCATIONID, INUZONE, INUSECTOR, INUBLOCK_, ISBBLOCKSIDE, INUPREMISE, INUNUMBERDIVISION, INUPREMISETYPE, ISBADDRESS, INUZIP_CODE, ONUPREMISEID, INUADDRESSID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ONUPREMISEID := AB_BOCONSTANTS.CNUAPPLICATIONNULL;
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END;
   PROCEDURE GETPREMISEGEOGRAPLOCATION( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, ONUGEOGRAPLOCATIONID OUT GE_GEOGRA_LOCATION.GEOGRAP_LOCATION_ID%TYPE, ONUERRORCODE OUT NUMBER, OSBERRORTEXT OUT VARCHAR2 )
    IS
    BEGIN
      ONUGEOGRAPLOCATIONID := AB_BOPREMISE.FNUGETPREMISEGEOGRAPLOCATION( INUPREMISEID );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORTEXT );
   END GETPREMISEGEOGRAPLOCATION;
   PROCEDURE INITIALIZEOUTPUT( ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      ONUERRORCODE := CONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := GE_BOCONSTANTS.CSBNOMESSAGE;
   END;
   PROCEDURE UPDPREMISE( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, INUPREMISE IN AB_PREMISE.PREMISE%TYPE, INUNUMBERDIVISION IN AB_PREMISE.NUMBER_DIVISION%TYPE, INUPREMISETYPEID IN AB_PREMISE.PREMISE_TYPE_ID%TYPE, ISBAPARTAMENTSAMOUNT IN AB_PREMISE.APARTAMENTS_AMOUNT%TYPE, INUFLOORSAMOUNT IN AB_PREMISE.FLOORS_AMOUNT%TYPE, ISBSETBACKBUILDING IN AB_PREMISE.SETBACK_BUILDING%TYPE, ISBSERVANTSPASSAGE IN AB_PREMISE.SERVANTS_PASSAGE%TYPE, INUPREMISESTATUSID IN AB_PREMISE.PREMISE_STATUS_ID%TYPE, INUCATEGORY IN AB_PREMISE.CATEGORY_%TYPE, INUSUBCATEGORY IN AB_PREMISE.SUBCATEGORY_%TYPE, INUCONSECUTIVE IN AB_PREMISE.CONSECUTIVE%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.UpdPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEDATAPREMISE( INUPREMISEID, INUPREMISE, INUNUMBERDIVISION, INUPREMISETYPEID, ISBAPARTAMENTSAMOUNT, INUFLOORSAMOUNT, ISBSETBACKBUILDING, ISBSERVANTSPASSAGE, INUPREMISESTATUSID, INUCATEGORY, INUSUBCATEGORY, INUCONSECUTIVE );
      AB_BOPREMISE.UPDPREMISE( INUPREMISEID, INUPREMISE, INUNUMBERDIVISION, INUPREMISETYPEID, ISBAPARTAMENTSAMOUNT, INUFLOORSAMOUNT, ISBSETBACKBUILDING, ISBSERVANTSPASSAGE, INUPREMISESTATUSID, INUCATEGORY, INUSUBCATEGORY, INUCONSECUTIVE );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.UpdPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.UpdPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.UpdPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END UPDPREMISE;
   PROCEDURE DELPREMISE( INUID IN AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.DelPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMISE( INUID );
      AB_BOPREMISE.DELPREMISE( INUID );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.DelPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.DelPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.DelPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END DELPREMISE;
   PROCEDURE GETPREMISE( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, ONUPREMISE OUT AB_PREMISE.PREMISE%TYPE, ONUNUMBERDIVISION OUT AB_PREMISE.NUMBER_DIVISION%TYPE, ONUPREMISETYPEID OUT AB_PREMISE.PREMISE_TYPE_ID%TYPE, OSBAPARTAMENTSAMOUNT OUT AB_PREMISE.APARTAMENTS_AMOUNT%TYPE, ONUFLOORSAMOUNT OUT AB_PREMISE.FLOORS_AMOUNT%TYPE, OSBSETBACKBUILDING OUT AB_PREMISE.SETBACK_BUILDING%TYPE, OSBSERVANTSPASSAGE OUT AB_PREMISE.SERVANTS_PASSAGE%TYPE, ONUPREMISESTATUSID OUT AB_PREMISE.PREMISE_STATUS_ID%TYPE, ONUCATEGORY OUT AB_PREMISE.CATEGORY_%TYPE, ONUSUBCATEGORY OUT AB_PREMISE.SUBCATEGORY_%TYPE, ONUCONSECUTIVE OUT AB_PREMISE.CONSECUTIVE%TYPE, ONUCICLFACT OUT AB_SEGMENTS.CICLCODI%TYPE, ONUSECTOROPER OUT AB_SEGMENTS.OPERATING_SECTOR_ID%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.GetPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMISE( INUPREMISEID );
      AB_BOPREMISE.GETPREMISE( INUPREMISEID, ONUPREMISE, ONUNUMBERDIVISION, ONUPREMISETYPEID, OSBAPARTAMENTSAMOUNT, ONUFLOORSAMOUNT, OSBSETBACKBUILDING, OSBSERVANTSPASSAGE, ONUPREMISESTATUSID, ONUCATEGORY, ONUSUBCATEGORY, ONUCONSECUTIVE, ONUCICLFACT, ONUSECTOROPER );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.GetPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.GetPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.GetPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END GETPREMISE;
   PROCEDURE INSPREMISETYPE( ISBDESCRIPTION IN AB_PREMISE_TYPE.DESCRIPTION%TYPE, INUACCESSTIME IN AB_PREMISE_TYPE.ACCESS_TIME%TYPE, ONUPREMTYPEID OUT AB_PREMISE_TYPE.PREMISE_TYPE_ID%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.InsPremiseType', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEDATAPREMTYPE( ISBDESCRIPTION, INUACCESSTIME );
      AB_BOPREMISE.INSPREMISETYPE( ISBDESCRIPTION, INUACCESSTIME, ONUPREMTYPEID );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.InsPremiseType', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.InsPremiseType', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.InsPremiseType', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END INSPREMISETYPE;
   PROCEDURE UPDPREMISETYPE( INUPREMTYPEID IN AB_PREMISE_TYPE.PREMISE_TYPE_ID%TYPE, ISBDESCRIPTION IN AB_PREMISE_TYPE.DESCRIPTION%TYPE, INUACCESSTIME IN AB_PREMISE_TYPE.ACCESS_TIME%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.UpdPremiseType', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMTYPE( INUPREMTYPEID );
      AB_BOPREMISE.VALIDATEDATAPREMTYPE( ISBDESCRIPTION, INUACCESSTIME );
      AB_BOPREMISE.UPDPREMISETYPE( INUPREMTYPEID, ISBDESCRIPTION, INUACCESSTIME );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.UpdPremiseType', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.UpdPremiseType', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.UpdPremiseType', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END UPDPREMISETYPE;
   PROCEDURE DELPREMISETYPE( INUID IN AB_PREMISE_TYPE.PREMISE_TYPE_ID%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.DelPremiseType', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMTYPE( INUID );
      AB_BOPREMISE.DELPREMISETYPE( INUID );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.DelPremiseType', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.DelPremiseType', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.DelPremiseType', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END DELPREMISETYPE;
   PROCEDURE GETPREMISETYPE( INUPREMTYPEID IN AB_PREMISE_TYPE.PREMISE_TYPE_ID%TYPE, OSBDESCRIPTION OUT AB_PREMISE_TYPE.DESCRIPTION%TYPE, ONUACCESSTIME OUT AB_PREMISE_TYPE.ACCESS_TIME%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.GetPremiseType', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMTYPE( INUPREMTYPEID );
      AB_BOPREMISE.GETPREMISETYPE( INUPREMTYPEID, OSBDESCRIPTION, ONUACCESSTIME );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.GetPremiseType', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.GetPremiseType', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.GetPremiseType', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END GETPREMISETYPE;
   PROCEDURE INSINFOPREMISE( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, ISBRING IN AB_INFO_PREMISE.IS_RING%TYPE, IDTDATERING IN AB_INFO_PREMISE.DATE_RING%TYPE, ISBCONNECTION IN AB_INFO_PREMISE.IS_CONNECTION%TYPE, ISBINTERNAL IN AB_INFO_PREMISE.IS_INTERNAL%TYPE, INUINTERNALTYPE IN AB_INFO_PREMISE.INTERNAL_TYPE%TYPE, ISBMEAUSERMENT IN AB_INFO_PREMISE.IS_MEASUREMENT%TYPE, INUNUMPOINTS IN AB_INFO_PREMISE.NUMBER_POINTS%TYPE, INULEVELRISK IN AB_INFO_PREMISE.LEVEL_RISK%TYPE, ISBDESCRISK IN AB_INFO_PREMISE.DESCRIPTION_RISK%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.InsInfoPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALDATAINFOPREMISE( INUPREMISEID, ISBRING, IDTDATERING, ISBCONNECTION, ISBINTERNAL, INUINTERNALTYPE, ISBMEAUSERMENT, INUNUMPOINTS, INULEVELRISK, ISBDESCRISK );
      AB_BOPREMISE.INSINFOPREMISE( INUPREMISEID, ISBRING, IDTDATERING, ISBCONNECTION, ISBINTERNAL, INUINTERNALTYPE, ISBMEAUSERMENT, INUNUMPOINTS, INULEVELRISK, ISBDESCRISK );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.InsInfoPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.InsInfoPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.InsInfoPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END INSINFOPREMISE;
   PROCEDURE UPDINFOPREMISE( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, ISBRING IN AB_INFO_PREMISE.IS_RING%TYPE, IDTDATERING IN AB_INFO_PREMISE.DATE_RING%TYPE, ISBCONNECTION IN AB_INFO_PREMISE.IS_CONNECTION%TYPE, ISBINTERNAL IN AB_INFO_PREMISE.IS_INTERNAL%TYPE, INUINTERNALTYPE IN AB_INFO_PREMISE.INTERNAL_TYPE%TYPE, ISBMEAUSERMENT IN AB_INFO_PREMISE.IS_MEASUREMENT%TYPE, INUNUMPOINTS IN AB_INFO_PREMISE.NUMBER_POINTS%TYPE, INULEVELRISK IN AB_INFO_PREMISE.LEVEL_RISK%TYPE, ISBDESCRISK IN AB_INFO_PREMISE.DESCRIPTION_RISK%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
      NUID AB_INFO_PREMISE.INFO_PREMISE_ID%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.UpdInfoPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALDATAINFOPREMISE( INUPREMISEID, ISBRING, IDTDATERING, ISBCONNECTION, ISBINTERNAL, INUINTERNALTYPE, ISBMEAUSERMENT, INUNUMPOINTS, INULEVELRISK, ISBDESCRISK );
      NUID := AB_BOPREMISE.FNUGETIDINFOPREMISE( INUPREMISEID );
      AB_BOPREMISE.UPDINFOPREMISE( NUID, INUPREMISEID, ISBRING, IDTDATERING, ISBCONNECTION, ISBINTERNAL, INUINTERNALTYPE, ISBMEAUSERMENT, INUNUMPOINTS, INULEVELRISK, ISBDESCRISK );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.UpdInfoPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.UpdInfoPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.UpdInfoPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END UPDINFOPREMISE;
   PROCEDURE DELINFOPREMISE( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
      NUID AB_INFO_PREMISE.INFO_PREMISE_ID%TYPE;
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.DelInfoPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMISE( INUPREMISEID );
      NUID := AB_BOPREMISE.FNUGETIDINFOPREMISE( INUPREMISEID );
      AB_BOPREMISE.DELINFOPREMISE( NUID );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.DelInfoPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.DelInfoPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.DelInfoPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END DELINFOPREMISE;
   PROCEDURE GETINFOPREMISE( INUPREMISEID IN AB_PREMISE.PREMISE_ID%TYPE, OSBRING OUT AB_INFO_PREMISE.IS_RING%TYPE, ODTDATERING OUT AB_INFO_PREMISE.DATE_RING%TYPE, OSBCONNECTION OUT AB_INFO_PREMISE.IS_CONNECTION%TYPE, OSBINTERNAL OUT AB_INFO_PREMISE.IS_INTERNAL%TYPE, ONUINTERNALTYPE OUT AB_INFO_PREMISE.INTERNAL_TYPE%TYPE, OSBMEAUSERMENT OUT AB_INFO_PREMISE.IS_MEASUREMENT%TYPE, ONUNUMPOINTS OUT AB_INFO_PREMISE.NUMBER_POINTS%TYPE, ONULEVELRISK OUT AB_INFO_PREMISE.LEVEL_RISK%TYPE, OSBDESCRISK OUT AB_INFO_PREMISE.DESCRIPTION_RISK%TYPE, ONUERRORCODE OUT GE_ERROR_LOG.ERROR_LOG_ID%TYPE, OSBERRORMESSAGE OUT GE_ERROR_LOG.DESCRIPTION%TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( 'INICIO AB_BSPremise.GetInfoPremise', 1 );
      INITIALIZEOUTPUT( ONUERRORCODE, OSBERRORMESSAGE );
      AB_BOPREMISE.VALIDATEIDPREMISE( INUPREMISEID );
      AB_BOPREMISE.GETINFOPREMISE( INUPREMISEID, OSBRING, ODTDATERING, OSBCONNECTION, OSBINTERNAL, ONUINTERNALTYPE, OSBMEAUSERMENT, ONUNUMPOINTS, ONULEVELRISK, OSBDESCRISK );
      UT_TRACE.TRACE( 'FIN AB_BSPremise.GetInfoPremise', 1 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         UT_TRACE.TRACE( 'CONTROLLED_ERROR AB_BSPremise.GetInfoPremise', 1 );
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         UT_TRACE.TRACE( 'others AB_BSPremise.GetInfoPremise', 1 );
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END GETINFOPREMISE;
END AB_BSPREMISE;
/


