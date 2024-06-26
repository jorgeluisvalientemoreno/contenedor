CREATE OR REPLACE PACKAGE BODY GE_BOCOSTLISTUPDBYFILE IS
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO186226';
   CSBFILE_SEPARATOR CONSTANT VARCHAR2( 1 ) := '/';
   CSBFILE_ERROR_EXT CONSTANT VARCHAR2( 5 ) := '.err';
   CNUERR_UNSTRUCTURED_FILE CONSTANT NUMBER := 112804;
   CNUDUP_MAIN_ADDRESS CONSTANT NUMBER := 10458;
   CNUSECURITYCONTRACT CONSTANT NUMBER := 4707;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE CLOSEFILE( IOFPFILE IN OUT UTL_FILE.FILE_TYPE )
    IS
    BEGIN
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.CloseFile] INICIO', 10 );
      IF UTL_FILE.IS_OPEN( IOFPFILE ) THEN
         GE_BOFILEMANAGER.FILECLOSE( IOFPFILE );
      END IF;
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.CloseFile] FIN', 10 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE REGISTERERRORINLOG( INURECORD IN NUMBER, INUERROR IN NUMBER, ISBERROR IN VARCHAR2, IOFPFILE IN OUT UTL_FILE.FILE_TYPE )
    IS
      SBLINE VARCHAR2( 2000 );
    BEGIN
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.registerErrorInLog] INICIO', 10 );
      IF UTL_FILE.IS_OPEN( IOFPFILE ) THEN
         SBLINE := 'Linea: [' || INURECORD || '] Error: ' || INUERROR || ' - ' || ISBERROR;
         UT_TRACE.TRACE( SBLINE, 11 );
         GE_BOFILEMANAGER.FILEWRITE( IOFPFILE, SBLINE );
      END IF;
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.registerErrorInLog] FIN', 10 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE OPENFILESDATAANDERROR( INUDIRECTORYID IN GE_DIRECTORY.DIRECTORY_ID%TYPE, ISBFILENAME IN GE_DIRECTORY.PATH%TYPE, IOFPFILEDATA IN OUT UTL_FILE.FILE_TYPE, IOFPFILEERROR IN OUT UTL_FILE.FILE_TYPE )
    IS
      SBPATHFILE GE_DIRECTORY.PATH%TYPE;
      SBERRORFILE GE_DIRECTORY.PATH%TYPE;
    BEGIN
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.OpenFilesDataAndError] INICIO', 4 );
      SBPATHFILE := DAGE_DIRECTORY.FSBGETPATH( INUDIRECTORYID );
      UT_TRACE.TRACE( 'Archivo Datos: ' || SBPATHFILE || CSBFILE_SEPARATOR || ISBFILENAME, 10 );
      GE_BOFILEMANAGER.CHECKFILEISEXISTING( SBPATHFILE || CSBFILE_SEPARATOR || ISBFILENAME );
      SBERRORFILE := SUBSTR( ISBFILENAME, 1, INSTR( ISBFILENAME, '.' ) - 1 );
      IF SBERRORFILE IS NULL THEN
         SBERRORFILE := ISBFILENAME;
      END IF;
      SBERRORFILE := SBERRORFILE || CSBFILE_ERROR_EXT;
      UT_TRACE.TRACE( 'Archivo Errores: ' || SBPATHFILE || CSBFILE_SEPARATOR || SBERRORFILE, 10 );
      GE_BOFILEMANAGER.FILEOPEN( IOFPFILEDATA, SBPATHFILE, ISBFILENAME, GE_BOFILEMANAGER.CSBREAD_OPEN_FILE );
      GE_BOFILEMANAGER.FILEOPEN( IOFPFILEERROR, SBPATHFILE, SBERRORFILE, GE_BOFILEMANAGER.CSBWRITE_OPEN_FILE );
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.OpenFilesDataAndError] FIN', 4 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALFILESTRUCTURE( ISBLINE IN VARCHAR2, INULINE IN NUMBER, INUCAMPS IN NUMBER, OTBLINEDATA OUT UT_STRING.TYTB_STRING )
    IS
      SBLINE VARCHAR2( 2000 );
    BEGIN
      SBLINE := REPLACE( ISBLINE, CHR( 13 ), '' );
      UT_STRING.EXTSTRING( SBLINE, ';', OTBLINEDATA );
      UT_TRACE.TRACE( 'Datos: ' || SBLINE, 5 );
      IF ( OTBLINEDATA.COUNT != INUCAMPS ) THEN
         ERRORS.SETERROR( CNUERR_UNSTRUCTURED_FILE, INULINE );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDATEITEMCOSTINLIST( INUUNITARYCOSTLISTID IN GE_UNIT_COST_ITE_LIS.LIST_UNITARY_COST_ID%TYPE, INUITEMSID IN GE_UNIT_COST_ITE_LIS.ITEMS_ID%TYPE, INUPRICE IN GE_UNIT_COST_ITE_LIS.PRICE%TYPE, INUSALESVALUE IN GE_UNIT_COST_ITE_LIS.SALES_VALUE%TYPE, ONUERRORCODE OUT NOCOPY NUMBER, OSBERRORMESSAGE OUT NOCOPY VARCHAR2 )
    IS
    BEGIN
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.addItemToList] INICIO', 8 );
      ONUERRORCODE := GE_BOCONSTANTS.CNUSUCCESS;
      OSBERRORMESSAGE := GE_BOCONSTANTS.CSBNOMESSAGE;
      GE_BOUNITCOSTITELIS.UPDATEITEMCOSTINLIST( INUUNITARYCOSTLISTID, INUITEMSID, INUPRICE, INUSALESVALUE, ONUERRORCODE, OSBERRORMESSAGE );
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.addItemToList] FIN', 8 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         ERRORS.GETERROR( ONUERRORCODE, OSBERRORMESSAGE );
   END UPDATEITEMCOSTINLIST;
   PROCEDURE UPDATEUNITARYCOSTLISTBYFILE( INUDIRECTORYID IN GE_DIRECTORY.DIRECTORY_ID%TYPE, ISBFILENAME IN GE_DIRECTORY.PATH%TYPE )
    IS
      FPLISTDATA UTL_FILE.FILE_TYPE;
      FPLISTERRORS UTL_FILE.FILE_TYPE;
      SBDATALINE VARCHAR2( 2000 );
      SBERRORLINE VARCHAR2( 2000 );
      NURECORD NUMBER;
      NUERROR NUMBER;
      SBERROR VARCHAR2( 2000 );
      PROCEDURE PROCESSCHANGEREGISTER( ISBDATALINE IN VARCHAR2, INURECORD IN NUMBER, ONUERROR OUT NUMBER, OSBERROR OUT VARCHAR2 )
       IS
         TBDATARECORD UT_STRING.TYTB_STRING;
         NUITEMID GE_ITEMS.ITEMS_ID%TYPE;
       BEGIN
         UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.processChangeRegister] INICIO', 8 );
         ONUERROR := GE_BOCONSTANTS.CNUSUCCESS;
         OSBERROR := GE_BOCONSTANTS.CSBNOMESSAGE;
         VALFILESTRUCTURE( ISBDATALINE, INURECORD, 4, TBDATARECORD );
         IF ( CT_BOCONTRSECURITY.FNUCANMANAGECOSTLIST( UT_CONVERT.FNUCHARTONUMBER( TBDATARECORD( 1 ) ) ) = 0 ) THEN
            ONUERROR := CNUSECURITYCONTRACT;
            OSBERROR := GE_BOMESSAGE.FSBGETMESSAGE( CNUSECURITYCONTRACT, NULL );
         END IF;
         NUITEMID := GE_BCITEMS.FNUGETITEMSID( TBDATARECORD( 2 ) );
         IF ( ONUERROR = GE_BOCONSTANTS.CNUSUCCESS ) THEN
            GE_BOUNITCOSTITELIS.INSERTORUPDATEITEMCOSTINLIST( UT_CONVERT.FNUCHARTONUMBER( TBDATARECORD( 1 ) ), NUITEMID, UT_CONVERT.FNUCHARTONUMBER( TBDATARECORD( 3 ) ), UT_CONVERT.FNUCHARTONUMBER( TBDATARECORD( 4 ) ), ONUERROR, OSBERROR );
         END IF;
         UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.processChangeRegister] FIN', 8 );
       EXCEPTION
         WHEN EX.CONTROLLED_ERROR THEN
            RAISE EX.CONTROLLED_ERROR;
         WHEN OTHERS THEN
            ERRORS.SETERROR;
            RAISE EX.CONTROLLED_ERROR;
      END;
    BEGIN
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.UpdateUnitaryCostListByFile] INICIO', 4 );
      OPENFILESDATAANDERROR( INUDIRECTORYID, ISBFILENAME, FPLISTDATA, FPLISTERRORS );
      CT_BOCONTRSECURITY.LOADSECURITYSETTINGS( CT_BOCONSTANTS.CSBSEC_INFO_TYPE_GENERAL );
      CT_BOCONTRSECURITY.LOADSECURITYSETTINGS( CT_BOCONSTANTS.CSBSEC_INFO_TYPE_COST_LI );
      CT_BOCONTRSECURITY.LOADSECURITYSETTINGS( CT_BOCONSTANTS.CSBSEC_INFO_TYPE_WORK_UDT );
      NURECORD := 0;
      WHILE TRUE
       LOOP
         GE_BOFILEMANAGER.FILEREAD( FPLISTDATA, SBDATALINE );
         EXIT WHEN SBDATALINE IS NULL;
         NURECORD := NURECORD + 1;
         SAVEPOINT PROCESSDATA;
         PROCESSCHANGEREGISTER( SBDATALINE, NURECORD, NUERROR, SBERROR );
         IF NUERROR != GE_BOCONSTANTS.CNUSUCCESS THEN
            REGISTERERRORINLOG( NURECORD, NUERROR, SBERROR, FPLISTERRORS );
            ROLLBACK TO PROCESSDATA;
          ELSE
            COMMIT;
         END IF;
      END LOOP;
      CLOSEFILE( FPLISTDATA );
      CLOSEFILE( FPLISTERRORS );
      UT_TRACE.TRACE( '[GE_BOCostListUpdByFile.UpdateUnitaryCostListByFile] FIN', 4 );
    EXCEPTION
      WHEN EX.CONTROLLED_ERROR THEN
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         ERRORS.SETERROR;
         RAISE EX.CONTROLLED_ERROR;
   END;
END GE_BOCOSTLISTUPDBYFILE;
/


