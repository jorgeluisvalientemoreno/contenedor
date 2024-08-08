CREATE OR REPLACE PACKAGE BODY DAMO_MOTIVE IS
   CNURECORD_NOT_EXIST CONSTANT NUMBER( 1 ) := 1;
   CNURECORD_ALREADY_EXIST CONSTANT NUMBER( 1 ) := 2;
   CNUAPPTABLEBUSSY CONSTANT NUMBER( 4 ) := 6951;
   CNUINS_PK_NULL CONSTANT NUMBER( 4 ) := 1682;
   CNURECORD_HAVE_CHILDREN CONSTANT NUMBER( 4 ) := -2292;
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO186338';
   CSBTABLEPARAMETER CONSTANT VARCHAR2( 30 ) := 'MO_MOTIVE';
   CNUGEENTITYID CONSTANT VARCHAR2( 30 ) := 8;
   CURSOR CULOCKRCBYPK( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE ) IS
SELECT MO_motive.*,MO_motive.rowid 
		FROM MO_motive
		WHERE  Motive_Id = inuMotive_Id
		FOR UPDATE NOWAIT;
   CURSOR CULOCKRCBYROWID( IRIROWID IN VARCHAR2 ) IS
SELECT MO_motive.*,MO_motive.rowid 
		FROM MO_motive
		WHERE 
			rowId = irirowid
		FOR UPDATE NOWAIT;
   TYPE TYRFMO_MOTIVE IS REF CURSOR;
   RCRECOFTAB TYRCMO_MOTIVE;
   RCDATA CURECORD%ROWTYPE;
   BLDAO_USE_CACHE BOOLEAN := NULL;
   FUNCTION FSBGETMESSAGEDESCRIPTION
    RETURN VARCHAR2
    IS
      SBTABLEDESCRIPTION VARCHAR2( 32000 );
    BEGIN
      IF ( CNUGEENTITYID > 0 AND DAGE_ENTITY.FBLEXIST( CNUGEENTITYID ) ) THEN
         SBTABLEDESCRIPTION := DAGE_ENTITY.FSBGETDISPLAY_NAME( CNUGEENTITYID );
       ELSE
         SBTABLEDESCRIPTION := CSBTABLEPARAMETER;
      END IF;
      RETURN SBTABLEDESCRIPTION;
   END;
   PROCEDURE GETDAO_USE_CACHE
    IS
    BEGIN
      IF ( BLDAO_USE_CACHE IS NULL ) THEN
         BLDAO_USE_CACHE := GE_BOPARAMETER.FSBGET( 'DAO_USE_CACHE' ) = 'Y';
      END IF;
   END;
   FUNCTION FSBPRIMARYKEY( RCI IN STYMO_MOTIVE := RCDATA )
    RETURN VARCHAR2
    IS
      SBPK VARCHAR2( 500 );
    BEGIN
      SBPK := '[';
      SBPK := SBPK || UT_CONVERT.FSBTOCHAR( RCI.MOTIVE_ID );
      SBPK := SBPK || ']';
      RETURN SBPK;
   END;
   PROCEDURE LOCKBYPK( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ORCMO_MOTIVE OUT STYMO_MOTIVE )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      OPEN CULOCKRCBYPK( INUMOTIVE_ID );
      FETCH CULOCKRCBYPK
         INTO ORCMO_MOTIVE;
      IF CULOCKRCBYPK%NOTFOUND THEN
         CLOSE CULOCKRCBYPK;
         RAISE NO_DATA_FOUND;
      END IF;
      CLOSE CULOCKRCBYPK;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF CULOCKRCBYPK%ISOPEN THEN
            CLOSE CULOCKRCBYPK;
         END IF;
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
      WHEN EX.RESOURCE_BUSY THEN
         IF CULOCKRCBYPK%ISOPEN THEN
            CLOSE CULOCKRCBYPK;
         END IF;
         ERRORS.SETERROR( CNUAPPTABLEBUSSY, FSBPRIMARYKEY( RCERROR ) || '|' || FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CULOCKRCBYPK%ISOPEN THEN
            CLOSE CULOCKRCBYPK;
         END IF;
         RAISE;
   END;
   PROCEDURE LOCKBYROWID( IRIROWID IN VARCHAR2, ORCMO_MOTIVE OUT STYMO_MOTIVE )
    IS
    BEGIN
      OPEN CULOCKRCBYROWID( IRIROWID );
      FETCH CULOCKRCBYROWID
         INTO ORCMO_MOTIVE;
      IF CULOCKRCBYROWID%NOTFOUND THEN
         CLOSE CULOCKRCBYROWID;
         RAISE NO_DATA_FOUND;
      END IF;
      CLOSE CULOCKRCBYROWID;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF CULOCKRCBYROWID%ISOPEN THEN
            CLOSE CULOCKRCBYROWID;
         END IF;
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' rowid=[' || IRIROWID || ']' );
         RAISE EX.CONTROLLED_ERROR;
      WHEN EX.RESOURCE_BUSY THEN
         IF CULOCKRCBYROWID%ISOPEN THEN
            CLOSE CULOCKRCBYROWID;
         END IF;
         ERRORS.SETERROR( CNUAPPTABLEBUSSY, 'rowid=[' || IRIROWID || ']|' || FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
      WHEN OTHERS THEN
         IF CULOCKRCBYROWID%ISOPEN THEN
            CLOSE CULOCKRCBYROWID;
         END IF;
         RAISE;
   END;
   PROCEDURE DELRECORDOFTABLES( ITBMO_MOTIVE IN OUT NOCOPY TYTBMO_MOTIVE )
    IS
    BEGIN
      RCRECOFTAB.MOTIVE_ID.DELETE;
      RCRECOFTAB.PRIVACY_FLAG.DELETE;
      RCRECOFTAB.CLIENT_PRIVACY_FLAG.DELETE;
      RCRECOFTAB.PROVISIONAL_FLAG.DELETE;
      RCRECOFTAB.IS_MULT_PRODUCT_FLAG.DELETE;
      RCRECOFTAB.AUTHORIZ_LETTER_FLAG.DELETE;
      RCRECOFTAB.PARTIAL_FLAG.DELETE;
      RCRECOFTAB.PROV_INITIAL_DATE.DELETE;
      RCRECOFTAB.PROV_FINAL_DATE.DELETE;
      RCRECOFTAB.INITIAL_PROCESS_DATE.DELETE;
      RCRECOFTAB.PRIORITY.DELETE;
      RCRECOFTAB.MOTIV_RECORDING_DATE.DELETE;
      RCRECOFTAB.ESTIMATED_INST_DATE.DELETE;
      RCRECOFTAB.ASSIGN_DATE.DELETE;
      RCRECOFTAB.ATTENTION_DATE.DELETE;
      RCRECOFTAB.ANNUL_DATE.DELETE;
      RCRECOFTAB.STATUS_CHANGE_DATE.DELETE;
      RCRECOFTAB.STUDY_NUM_TRANSFEREN.DELETE;
      RCRECOFTAB.CUSTOM_DECISION_FLAG.DELETE;
      RCRECOFTAB.EXECUTION_MAX_DATE.DELETE;
      RCRECOFTAB.STANDARD_TIME.DELETE;
      RCRECOFTAB.SERVICE_NUMBER.DELETE;
      RCRECOFTAB.PRODUCT_MOTIVE_ID.DELETE;
      RCRECOFTAB.DISTRIBUT_ADMIN_ID.DELETE;
      RCRECOFTAB.DISTRICT_ID.DELETE;
      RCRECOFTAB.BUILDING_ID.DELETE;
      RCRECOFTAB.ANNUL_CAUSAL_ID.DELETE;
      RCRECOFTAB.PRODUCT_ID.DELETE;
      RCRECOFTAB.MOTIVE_TYPE_ID.DELETE;
      RCRECOFTAB.PRODUCT_TYPE_ID.DELETE;
      RCRECOFTAB.MOTIVE_STATUS_ID.DELETE;
      RCRECOFTAB.SUBSCRIPTION_ID.DELETE;
      RCRECOFTAB.PACKAGE_ID.DELETE;
      RCRECOFTAB.UNDOASSIGN_CAUSAL_ID.DELETE;
      RCRECOFTAB.GEOGRAP_LOCATION_ID.DELETE;
      RCRECOFTAB.CREDIT_LIMIT.DELETE;
      RCRECOFTAB.CREDIT_LIMIT_COVERED.DELETE;
      RCRECOFTAB.CUST_CARE_REQUES_NUM.DELETE;
      RCRECOFTAB.VALUE_TO_DEBIT.DELETE;
      RCRECOFTAB.TAG_NAME.DELETE;
      RCRECOFTAB.ORGANIZAT_AREA_ID.DELETE;
      RCRECOFTAB.COMMERCIAL_PLAN_ID.DELETE;
      RCRECOFTAB.PERMANENCE.DELETE;
      RCRECOFTAB.COMPANY_ID.DELETE;
      RCRECOFTAB.INCLUDED_FEATURES_ID.DELETE;
      RCRECOFTAB.RECEPTION_TYPE_ID.DELETE;
      RCRECOFTAB.CAUSAL_ID.DELETE;
      RCRECOFTAB.ASSIGNED_PERSON_ID.DELETE;
      RCRECOFTAB.ANSWER_ID.DELETE;
      RCRECOFTAB.CATEGORY_ID.DELETE;
      RCRECOFTAB.SUBCATEGORY_ID.DELETE;
      RCRECOFTAB.IS_IMMEDIATE_ATTENT.DELETE;
      RCRECOFTAB.ELEMENT_POSITION.DELETE;
      RCRECOFTAB.ROW_ID.DELETE;
   END;
   PROCEDURE FILLRECORDOFTABLES( ITBMO_MOTIVE IN OUT NOCOPY TYTBMO_MOTIVE, OBLUSEROWID OUT BOOLEAN )
    IS
    BEGIN
      DELRECORDOFTABLES( ITBMO_MOTIVE );
      FOR N IN ITBMO_MOTIVE.FIRST..ITBMO_MOTIVE.LAST
       LOOP
         RCRECOFTAB.MOTIVE_ID( N ) := ITBMO_MOTIVE( N ).MOTIVE_ID;
         RCRECOFTAB.PRIVACY_FLAG( N ) := ITBMO_MOTIVE( N ).PRIVACY_FLAG;
         RCRECOFTAB.CLIENT_PRIVACY_FLAG( N ) := ITBMO_MOTIVE( N ).CLIENT_PRIVACY_FLAG;
         RCRECOFTAB.PROVISIONAL_FLAG( N ) := ITBMO_MOTIVE( N ).PROVISIONAL_FLAG;
         RCRECOFTAB.IS_MULT_PRODUCT_FLAG( N ) := ITBMO_MOTIVE( N ).IS_MULT_PRODUCT_FLAG;
         RCRECOFTAB.AUTHORIZ_LETTER_FLAG( N ) := ITBMO_MOTIVE( N ).AUTHORIZ_LETTER_FLAG;
         RCRECOFTAB.PARTIAL_FLAG( N ) := ITBMO_MOTIVE( N ).PARTIAL_FLAG;
         RCRECOFTAB.PROV_INITIAL_DATE( N ) := ITBMO_MOTIVE( N ).PROV_INITIAL_DATE;
         RCRECOFTAB.PROV_FINAL_DATE( N ) := ITBMO_MOTIVE( N ).PROV_FINAL_DATE;
         RCRECOFTAB.INITIAL_PROCESS_DATE( N ) := ITBMO_MOTIVE( N ).INITIAL_PROCESS_DATE;
         RCRECOFTAB.PRIORITY( N ) := ITBMO_MOTIVE( N ).PRIORITY;
         RCRECOFTAB.MOTIV_RECORDING_DATE( N ) := ITBMO_MOTIVE( N ).MOTIV_RECORDING_DATE;
         RCRECOFTAB.ESTIMATED_INST_DATE( N ) := ITBMO_MOTIVE( N ).ESTIMATED_INST_DATE;
         RCRECOFTAB.ASSIGN_DATE( N ) := ITBMO_MOTIVE( N ).ASSIGN_DATE;
         RCRECOFTAB.ATTENTION_DATE( N ) := ITBMO_MOTIVE( N ).ATTENTION_DATE;
         RCRECOFTAB.ANNUL_DATE( N ) := ITBMO_MOTIVE( N ).ANNUL_DATE;
         RCRECOFTAB.STATUS_CHANGE_DATE( N ) := ITBMO_MOTIVE( N ).STATUS_CHANGE_DATE;
         RCRECOFTAB.STUDY_NUM_TRANSFEREN( N ) := ITBMO_MOTIVE( N ).STUDY_NUM_TRANSFEREN;
         RCRECOFTAB.CUSTOM_DECISION_FLAG( N ) := ITBMO_MOTIVE( N ).CUSTOM_DECISION_FLAG;
         RCRECOFTAB.EXECUTION_MAX_DATE( N ) := ITBMO_MOTIVE( N ).EXECUTION_MAX_DATE;
         RCRECOFTAB.STANDARD_TIME( N ) := ITBMO_MOTIVE( N ).STANDARD_TIME;
         RCRECOFTAB.SERVICE_NUMBER( N ) := ITBMO_MOTIVE( N ).SERVICE_NUMBER;
         RCRECOFTAB.PRODUCT_MOTIVE_ID( N ) := ITBMO_MOTIVE( N ).PRODUCT_MOTIVE_ID;
         RCRECOFTAB.DISTRIBUT_ADMIN_ID( N ) := ITBMO_MOTIVE( N ).DISTRIBUT_ADMIN_ID;
         RCRECOFTAB.DISTRICT_ID( N ) := ITBMO_MOTIVE( N ).DISTRICT_ID;
         RCRECOFTAB.BUILDING_ID( N ) := ITBMO_MOTIVE( N ).BUILDING_ID;
         RCRECOFTAB.ANNUL_CAUSAL_ID( N ) := ITBMO_MOTIVE( N ).ANNUL_CAUSAL_ID;
         RCRECOFTAB.PRODUCT_ID( N ) := ITBMO_MOTIVE( N ).PRODUCT_ID;
         RCRECOFTAB.MOTIVE_TYPE_ID( N ) := ITBMO_MOTIVE( N ).MOTIVE_TYPE_ID;
         RCRECOFTAB.PRODUCT_TYPE_ID( N ) := ITBMO_MOTIVE( N ).PRODUCT_TYPE_ID;
         RCRECOFTAB.MOTIVE_STATUS_ID( N ) := ITBMO_MOTIVE( N ).MOTIVE_STATUS_ID;
         RCRECOFTAB.SUBSCRIPTION_ID( N ) := ITBMO_MOTIVE( N ).SUBSCRIPTION_ID;
         RCRECOFTAB.PACKAGE_ID( N ) := ITBMO_MOTIVE( N ).PACKAGE_ID;
         RCRECOFTAB.UNDOASSIGN_CAUSAL_ID( N ) := ITBMO_MOTIVE( N ).UNDOASSIGN_CAUSAL_ID;
         RCRECOFTAB.GEOGRAP_LOCATION_ID( N ) := ITBMO_MOTIVE( N ).GEOGRAP_LOCATION_ID;
         RCRECOFTAB.CREDIT_LIMIT( N ) := ITBMO_MOTIVE( N ).CREDIT_LIMIT;
         RCRECOFTAB.CREDIT_LIMIT_COVERED( N ) := ITBMO_MOTIVE( N ).CREDIT_LIMIT_COVERED;
         RCRECOFTAB.CUST_CARE_REQUES_NUM( N ) := ITBMO_MOTIVE( N ).CUST_CARE_REQUES_NUM;
         RCRECOFTAB.VALUE_TO_DEBIT( N ) := ITBMO_MOTIVE( N ).VALUE_TO_DEBIT;
         RCRECOFTAB.TAG_NAME( N ) := ITBMO_MOTIVE( N ).TAG_NAME;
         RCRECOFTAB.ORGANIZAT_AREA_ID( N ) := ITBMO_MOTIVE( N ).ORGANIZAT_AREA_ID;
         RCRECOFTAB.COMMERCIAL_PLAN_ID( N ) := ITBMO_MOTIVE( N ).COMMERCIAL_PLAN_ID;
         RCRECOFTAB.PERMANENCE( N ) := ITBMO_MOTIVE( N ).PERMANENCE;
         RCRECOFTAB.COMPANY_ID( N ) := ITBMO_MOTIVE( N ).COMPANY_ID;
         RCRECOFTAB.INCLUDED_FEATURES_ID( N ) := ITBMO_MOTIVE( N ).INCLUDED_FEATURES_ID;
         RCRECOFTAB.RECEPTION_TYPE_ID( N ) := ITBMO_MOTIVE( N ).RECEPTION_TYPE_ID;
         RCRECOFTAB.CAUSAL_ID( N ) := ITBMO_MOTIVE( N ).CAUSAL_ID;
         RCRECOFTAB.ASSIGNED_PERSON_ID( N ) := ITBMO_MOTIVE( N ).ASSIGNED_PERSON_ID;
         RCRECOFTAB.ANSWER_ID( N ) := ITBMO_MOTIVE( N ).ANSWER_ID;
         RCRECOFTAB.CATEGORY_ID( N ) := ITBMO_MOTIVE( N ).CATEGORY_ID;
         RCRECOFTAB.SUBCATEGORY_ID( N ) := ITBMO_MOTIVE( N ).SUBCATEGORY_ID;
         RCRECOFTAB.IS_IMMEDIATE_ATTENT( N ) := ITBMO_MOTIVE( N ).IS_IMMEDIATE_ATTENT;
         RCRECOFTAB.ELEMENT_POSITION( N ) := ITBMO_MOTIVE( N ).ELEMENT_POSITION;
         RCRECOFTAB.ROW_ID( N ) := ITBMO_MOTIVE( N ).ROWID;
         OBLUSEROWID := RCRECOFTAB.ROW_ID( N ) IS NOT NULL;
      END LOOP;
   END;
   PROCEDURE LOAD( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    IS
      RCRECORDNULL CURECORD%ROWTYPE;
    BEGIN
      IF CURECORD%ISOPEN THEN
         CLOSE CURECORD;
      END IF;
      OPEN CURECORD( INUMOTIVE_ID );
      FETCH CURECORD
         INTO RCDATA;
      IF CURECORD%NOTFOUND THEN
         CLOSE CURECORD;
         RCDATA := RCRECORDNULL;
         RAISE NO_DATA_FOUND;
      END IF;
      CLOSE CURECORD;
   END;
   PROCEDURE LOADBYROWID( IRIROWID IN VARCHAR2 )
    IS
      RCRECORDNULL CURECORDBYROWID%ROWTYPE;
    BEGIN
      IF CURECORDBYROWID%ISOPEN THEN
         CLOSE CURECORDBYROWID;
      END IF;
      OPEN CURECORDBYROWID( IRIROWID );
      FETCH CURECORDBYROWID
         INTO RCDATA;
      IF CURECORDBYROWID%NOTFOUND THEN
         CLOSE CURECORDBYROWID;
         RCDATA := RCRECORDNULL;
         RAISE NO_DATA_FOUND;
      END IF;
      CLOSE CURECORDBYROWID;
   END;
   FUNCTION FBLALREADYLOADED( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      IF ( INUMOTIVE_ID = RCDATA.MOTIVE_ID ) THEN
         RETURN ( TRUE );
      END IF;
      RETURN ( FALSE );
   END;
   FUNCTION FSBVERSION
    RETURN VARCHAR2
    IS
    BEGIN
      RETURN CSBVERSION;
   END;
   PROCEDURE CLEARMEMORY
    IS
      RCRECORDNULL CURECORD%ROWTYPE;
    BEGIN
      RCDATA := RCRECORDNULL;
   END;
   FUNCTION FBLEXIST( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      LOAD( INUMOTIVE_ID );
      RETURN ( TRUE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN ( FALSE );
   END;
   PROCEDURE ACCKEY( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      LOAD( INUMOTIVE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE ACCKEYBYROWID( IRIROWID IN ROWID )
    IS
    BEGIN
      LOADBYROWID( IRIROWID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' rowid=[' || IRIROWID || ']' );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE VALDUPLICATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    IS
    BEGIN
      LOAD( INUMOTIVE_ID );
      ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY );
      RAISE EX.CONTROLLED_ERROR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
   END;
   PROCEDURE GETRECORD( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ORCRECORD OUT NOCOPY STYMO_MOTIVE )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      LOAD( INUMOTIVE_ID );
      ORCRECORD := RCDATA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRECORD( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    RETURN STYMO_MOTIVE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE )
    RETURN STYMO_MOTIVE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA
    RETURN STYMO_MOTIVE
    IS
    BEGIN
      RETURN ( RCDATA );
   END;
   PROCEDURE GETRECORDS( ISBQUERY IN VARCHAR2, OTBRESULT OUT NOCOPY TYTBMO_MOTIVE )
    IS
      RFMO_MOTIVE TYRFMO_MOTIVE;
      N NUMBER( 4 ) := 1;
      SBFULLQUERY VARCHAR2( 32000 ) := 'SELECT 
		            MO_motive.Motive_Id,
		            MO_motive.Privacy_Flag,
		            MO_motive.Client_Privacy_Flag,
		            MO_motive.Provisional_Flag,
		            MO_motive.Is_Mult_Product_Flag,
		            MO_motive.Authoriz_Letter_Flag,
		            MO_motive.Partial_Flag,
		            MO_motive.Prov_Initial_Date,
		            MO_motive.Prov_Final_Date,
		            MO_motive.Initial_Process_Date,
		            MO_motive.Priority,
		            MO_motive.Motiv_Recording_Date,
		            MO_motive.Estimated_Inst_Date,
		            MO_motive.Assign_Date,
		            MO_motive.Attention_Date,
		            MO_motive.Annul_Date,
		            MO_motive.Status_Change_Date,
		            MO_motive.Study_Num_Transferen,
		            MO_motive.Custom_Decision_Flag,
		            MO_motive.Execution_Max_Date,
		            MO_motive.Standard_Time,
		            MO_motive.Service_Number,
		            MO_motive.Product_Motive_Id,
		            MO_motive.Distribut_Admin_Id,
		            MO_motive.District_Id,
		            MO_motive.Building_Id,
		            MO_motive.Annul_Causal_Id,
		            MO_motive.Product_Id,
		            MO_motive.Motive_Type_Id,
		            MO_motive.Product_Type_Id,
		            MO_motive.Motive_Status_Id,
		            MO_motive.Subscription_Id,
		            MO_motive.Package_Id,
		            MO_motive.Undoassign_Causal_Id,
		            MO_motive.Geograp_Location_Id,
		            MO_motive.Credit_Limit,
		            MO_motive.Credit_Limit_Covered,
		            MO_motive.Cust_Care_Reques_Num,
		            MO_motive.Value_To_Debit,
		            MO_motive.Tag_Name,
		            MO_motive.Organizat_Area_Id,
		            MO_motive.Commercial_Plan_Id,
		            MO_motive.Permanence,
		            MO_motive.Company_Id,
		            MO_motive.Included_Features_Id,
		            MO_motive.Reception_Type_Id,
		            MO_motive.Causal_Id,
		            MO_motive.Assigned_Person_Id,
		            MO_motive.Answer_Id,
		            MO_motive.Category_Id,
		            MO_motive.Subcategory_Id,
		            MO_motive.Is_Immediate_Attent,
		            MO_motive.Element_Position,
		            MO_motive.rowid
                FROM MO_motive';
      NUMAXTBRECORDS NUMBER( 5 ) := GE_BOPARAMETER.FNUGET( 'MAXREGSQUERY' );
    BEGIN
      OTBRESULT.DELETE;
      IF ISBQUERY IS NOT NULL AND LENGTH( ISBQUERY ) > 0 THEN
         SBFULLQUERY := SBFULLQUERY || ' WHERE ' || ISBQUERY;
      END IF;
      OPEN RFMO_MOTIVE
           FOR SBFULLQUERY;
      FETCH RFMO_MOTIVE
         BULK COLLECT INTO OTBRESULT;
      CLOSE RFMO_MOTIVE;
      IF OTBRESULT.COUNT = 0 THEN
         RAISE NO_DATA_FOUND;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRFGETRECORDS( ISBCRITERIA IN VARCHAR2 := NULL, IBLLOCK IN BOOLEAN := FALSE )
    RETURN TYREFCURSOR
    IS
      RFQUERY TYREFCURSOR;
      SBSQL VARCHAR2( 32000 ) := 'select 
		            MO_motive.Motive_Id,
		            MO_motive.Privacy_Flag,
		            MO_motive.Client_Privacy_Flag,
		            MO_motive.Provisional_Flag,
		            MO_motive.Is_Mult_Product_Flag,
		            MO_motive.Authoriz_Letter_Flag,
		            MO_motive.Partial_Flag,
		            MO_motive.Prov_Initial_Date,
		            MO_motive.Prov_Final_Date,
		            MO_motive.Initial_Process_Date,
		            MO_motive.Priority,
		            MO_motive.Motiv_Recording_Date,
		            MO_motive.Estimated_Inst_Date,
		            MO_motive.Assign_Date,
		            MO_motive.Attention_Date,
		            MO_motive.Annul_Date,
		            MO_motive.Status_Change_Date,
		            MO_motive.Study_Num_Transferen,
		            MO_motive.Custom_Decision_Flag,
		            MO_motive.Execution_Max_Date,
		            MO_motive.Standard_Time,
		            MO_motive.Service_Number,
		            MO_motive.Product_Motive_Id,
		            MO_motive.Distribut_Admin_Id,
		            MO_motive.District_Id,
		            MO_motive.Building_Id,
		            MO_motive.Annul_Causal_Id,
		            MO_motive.Product_Id,
		            MO_motive.Motive_Type_Id,
		            MO_motive.Product_Type_Id,
		            MO_motive.Motive_Status_Id,
		            MO_motive.Subscription_Id,
		            MO_motive.Package_Id,
		            MO_motive.Undoassign_Causal_Id,
		            MO_motive.Geograp_Location_Id,
		            MO_motive.Credit_Limit,
		            MO_motive.Credit_Limit_Covered,
		            MO_motive.Cust_Care_Reques_Num,
		            MO_motive.Value_To_Debit,
		            MO_motive.Tag_Name,
		            MO_motive.Organizat_Area_Id,
		            MO_motive.Commercial_Plan_Id,
		            MO_motive.Permanence,
		            MO_motive.Company_Id,
		            MO_motive.Included_Features_Id,
		            MO_motive.Reception_Type_Id,
		            MO_motive.Causal_Id,
		            MO_motive.Assigned_Person_Id,
		            MO_motive.Answer_Id,
		            MO_motive.Category_Id,
		            MO_motive.Subcategory_Id,
		            MO_motive.Is_Immediate_Attent,
		            MO_motive.Element_Position,
		            MO_motive.rowid
                FROM MO_motive';
    BEGIN
      IF ISBCRITERIA IS NOT NULL THEN
         SBSQL := SBSQL || ' where ' || ISBCRITERIA;
      END IF;
      IF IBLLOCK THEN
         SBSQL := SBSQL || ' for update nowait';
      END IF;
      OPEN RFQUERY
           FOR SBSQL;
      RETURN ( RFQUERY );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSRECORD( IRCMO_MOTIVE IN STYMO_MOTIVE )
    IS
      RIROWID VARCHAR2( 200 );
    BEGIN
      INSRECORD( IRCMO_MOTIVE, RIROWID );
   END;
   PROCEDURE INSRECORD( IRCMO_MOTIVE IN STYMO_MOTIVE, ORIROWID OUT VARCHAR2 )
    IS
    BEGIN
      IF IRCMO_MOTIVE.MOTIVE_ID IS NULL THEN
         ERRORS.SETERROR( CNUINS_PK_NULL, FSBGETMESSAGEDESCRIPTION || '|Motive_Id' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      INSERT into MO_motive
		(
			Motive_Id,
			Privacy_Flag,
			Client_Privacy_Flag,
			Provisional_Flag,
			Is_Mult_Product_Flag,
			Authoriz_Letter_Flag,
			Partial_Flag,
			Prov_Initial_Date,
			Prov_Final_Date,
			Initial_Process_Date,
			Priority,
			Motiv_Recording_Date,
			Estimated_Inst_Date,
			Assign_Date,
			Attention_Date,
			Annul_Date,
			Status_Change_Date,
			Study_Num_Transferen,
			Custom_Decision_Flag,
			Execution_Max_Date,
			Standard_Time,
			Service_Number,
			Product_Motive_Id,
			Distribut_Admin_Id,
			District_Id,
			Building_Id,
			Annul_Causal_Id,
			Product_Id,
			Motive_Type_Id,
			Product_Type_Id,
			Motive_Status_Id,
			Subscription_Id,
			Package_Id,
			Undoassign_Causal_Id,
			Geograp_Location_Id,
			Credit_Limit,
			Credit_Limit_Covered,
			Cust_Care_Reques_Num,
			Value_To_Debit,
			Tag_Name,
			Organizat_Area_Id,
			Commercial_Plan_Id,
			Permanence,
			Company_Id,
			Included_Features_Id,
			Reception_Type_Id,
			Causal_Id,
			Assigned_Person_Id,
			Answer_Id,
			Category_Id,
			Subcategory_Id,
			Is_Immediate_Attent,
			Element_Position
		)
		values
		(
			ircMO_motive.Motive_Id,
			ircMO_motive.Privacy_Flag,
			ircMO_motive.Client_Privacy_Flag,
			ircMO_motive.Provisional_Flag,
			ircMO_motive.Is_Mult_Product_Flag,
			ircMO_motive.Authoriz_Letter_Flag,
			ircMO_motive.Partial_Flag,
			ircMO_motive.Prov_Initial_Date,
			ircMO_motive.Prov_Final_Date,
			ircMO_motive.Initial_Process_Date,
			ircMO_motive.Priority,
			ircMO_motive.Motiv_Recording_Date,
			ircMO_motive.Estimated_Inst_Date,
			ircMO_motive.Assign_Date,
			ircMO_motive.Attention_Date,
			ircMO_motive.Annul_Date,
			ircMO_motive.Status_Change_Date,
			ircMO_motive.Study_Num_Transferen,
			ircMO_motive.Custom_Decision_Flag,
			ircMO_motive.Execution_Max_Date,
			ircMO_motive.Standard_Time,
			ircMO_motive.Service_Number,
			ircMO_motive.Product_Motive_Id,
			ircMO_motive.Distribut_Admin_Id,
			ircMO_motive.District_Id,
			ircMO_motive.Building_Id,
			ircMO_motive.Annul_Causal_Id,
			ircMO_motive.Product_Id,
			ircMO_motive.Motive_Type_Id,
			ircMO_motive.Product_Type_Id,
			ircMO_motive.Motive_Status_Id,
			ircMO_motive.Subscription_Id,
			ircMO_motive.Package_Id,
			ircMO_motive.Undoassign_Causal_Id,
			ircMO_motive.Geograp_Location_Id,
			ircMO_motive.Credit_Limit,
			ircMO_motive.Credit_Limit_Covered,
			ircMO_motive.Cust_Care_Reques_Num,
			ircMO_motive.Value_To_Debit,
			ircMO_motive.Tag_Name,
			ircMO_motive.Organizat_Area_Id,
			ircMO_motive.Commercial_Plan_Id,
			ircMO_motive.Permanence,
			ircMO_motive.Company_Id,
			ircMO_motive.Included_Features_Id,
			ircMO_motive.Reception_Type_Id,
			ircMO_motive.Causal_Id,
			ircMO_motive.Assigned_Person_Id,
			ircMO_motive.Answer_Id,
			ircMO_motive.Category_Id,
			ircMO_motive.Subcategory_Id,
			ircMO_motive.Is_Immediate_Attent,
			ircMO_motive.Element_Position
		)
            returning
			rowid
		into
			orirowid;
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( IRCMO_MOTIVE ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSRECORDS( IOTBMO_MOTIVE IN OUT NOCOPY TYTBMO_MOTIVE )
    IS
      BLUSEROWID BOOLEAN;
    BEGIN
      FILLRECORDOFTABLES( IOTBMO_MOTIVE, BLUSEROWID );
      FORALL N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
         INSERT into MO_motive
			(
				Motive_Id,
				Privacy_Flag,
				Client_Privacy_Flag,
				Provisional_Flag,
				Is_Mult_Product_Flag,
				Authoriz_Letter_Flag,
				Partial_Flag,
				Prov_Initial_Date,
				Prov_Final_Date,
				Initial_Process_Date,
				Priority,
				Motiv_Recording_Date,
				Estimated_Inst_Date,
				Assign_Date,
				Attention_Date,
				Annul_Date,
				Status_Change_Date,
				Study_Num_Transferen,
				Custom_Decision_Flag,
				Execution_Max_Date,
				Standard_Time,
				Service_Number,
				Product_Motive_Id,
				Distribut_Admin_Id,
				District_Id,
				Building_Id,
				Annul_Causal_Id,
				Product_Id,
				Motive_Type_Id,
				Product_Type_Id,
				Motive_Status_Id,
				Subscription_Id,
				Package_Id,
				Undoassign_Causal_Id,
				Geograp_Location_Id,
				Credit_Limit,
				Credit_Limit_Covered,
				Cust_Care_Reques_Num,
				Value_To_Debit,
				Tag_Name,
				Organizat_Area_Id,
				Commercial_Plan_Id,
				Permanence,
				Company_Id,
				Included_Features_Id,
				Reception_Type_Id,
				Causal_Id,
				Assigned_Person_Id,
				Answer_Id,
				Category_Id,
				Subcategory_Id,
				Is_Immediate_Attent,
				Element_Position
			)
			values
			(
				rcRecOfTab.Motive_Id(n),
				rcRecOfTab.Privacy_Flag(n),
				rcRecOfTab.Client_Privacy_Flag(n),
				rcRecOfTab.Provisional_Flag(n),
				rcRecOfTab.Is_Mult_Product_Flag(n),
				rcRecOfTab.Authoriz_Letter_Flag(n),
				rcRecOfTab.Partial_Flag(n),
				rcRecOfTab.Prov_Initial_Date(n),
				rcRecOfTab.Prov_Final_Date(n),
				rcRecOfTab.Initial_Process_Date(n),
				rcRecOfTab.Priority(n),
				rcRecOfTab.Motiv_Recording_Date(n),
				rcRecOfTab.Estimated_Inst_Date(n),
				rcRecOfTab.Assign_Date(n),
				rcRecOfTab.Attention_Date(n),
				rcRecOfTab.Annul_Date(n),
				rcRecOfTab.Status_Change_Date(n),
				rcRecOfTab.Study_Num_Transferen(n),
				rcRecOfTab.Custom_Decision_Flag(n),
				rcRecOfTab.Execution_Max_Date(n),
				rcRecOfTab.Standard_Time(n),
				rcRecOfTab.Service_Number(n),
				rcRecOfTab.Product_Motive_Id(n),
				rcRecOfTab.Distribut_Admin_Id(n),
				rcRecOfTab.District_Id(n),
				rcRecOfTab.Building_Id(n),
				rcRecOfTab.Annul_Causal_Id(n),
				rcRecOfTab.Product_Id(n),
				rcRecOfTab.Motive_Type_Id(n),
				rcRecOfTab.Product_Type_Id(n),
				rcRecOfTab.Motive_Status_Id(n),
				rcRecOfTab.Subscription_Id(n),
				rcRecOfTab.Package_Id(n),
				rcRecOfTab.Undoassign_Causal_Id(n),
				rcRecOfTab.Geograp_Location_Id(n),
				rcRecOfTab.Credit_Limit(n),
				rcRecOfTab.Credit_Limit_Covered(n),
				rcRecOfTab.Cust_Care_Reques_Num(n),
				rcRecOfTab.Value_To_Debit(n),
				rcRecOfTab.Tag_Name(n),
				rcRecOfTab.Organizat_Area_Id(n),
				rcRecOfTab.Commercial_Plan_Id(n),
				rcRecOfTab.Permanence(n),
				rcRecOfTab.Company_Id(n),
				rcRecOfTab.Included_Features_Id(n),
				rcRecOfTab.Reception_Type_Id(n),
				rcRecOfTab.Causal_Id(n),
				rcRecOfTab.Assigned_Person_Id(n),
				rcRecOfTab.Answer_Id(n),
				rcRecOfTab.Category_Id(n),
				rcRecOfTab.Subcategory_Id(n),
				rcRecOfTab.Is_Immediate_Attent(n),
				rcRecOfTab.Element_Position(n)
			);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE DELRECORD( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INULOCK IN NUMBER := 1 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      DELETE
		from MO_motive
		where
       		Motive_Id=inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
      WHEN EX.RECORD_HAVE_CHILDREN THEN
         ERRORS.SETERROR( CNURECORD_HAVE_CHILDREN, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE DELBYROWID( IRIROWID IN ROWID, INULOCK IN NUMBER := 1 )
    IS
      RCRECORDNULL CURECORD%ROWTYPE;
      RCERROR STYMO_MOTIVE;
    BEGIN
      IF INULOCK = 1 THEN
         LOCKBYROWID( IRIROWID, RCDATA );
      END IF;
      DELETE
		from MO_motive
		where
			rowid = iriRowID
		returning
			Motive_Id
		into
			rcError.Motive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      IF RCDATA.ROWID = IRIROWID THEN
         RCDATA := RCRECORDNULL;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' rowid=[' || IRIROWID || ']' );
         RAISE EX.CONTROLLED_ERROR;
      WHEN EX.RECORD_HAVE_CHILDREN THEN
         ERRORS.SETERROR( CNURECORD_HAVE_CHILDREN, FSBGETMESSAGEDESCRIPTION || ' ' || ' rowid=[' || IRIROWID || ']' );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE DELRECORDS( IOTBMO_MOTIVE IN OUT NOCOPY TYTBMO_MOTIVE, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYMO_MOTIVE;
    BEGIN
      FILLRECORDOFTABLES( IOTBMO_MOTIVE, BLUSEROWID );
      IF ( BLUSEROWID ) THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
            DELETE
				from MO_motive
				where
					rowid = rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.MOTIVE_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
            DELETE
				from MO_motive
				where
		         	Motive_Id = rcRecOfTab.Motive_Id(n);
      END IF;
    EXCEPTION
      WHEN EX.RECORD_HAVE_CHILDREN THEN
         ERRORS.SETERROR( CNURECORD_HAVE_CHILDREN, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORD( IRCMO_MOTIVE IN STYMO_MOTIVE, INULOCK IN NUMBER := 0 )
    IS
      NUMOTIVE_ID MO_MOTIVE.MOTIVE_ID%TYPE;
    BEGIN
      IF IRCMO_MOTIVE.ROWID IS NOT NULL THEN
         IF INULOCK = 1 THEN
            LOCKBYROWID( IRCMO_MOTIVE.ROWID, RCDATA );
         END IF;
         UPDATE MO_motive
			set
				Privacy_Flag = ircMO_motive.Privacy_Flag,
				Client_Privacy_Flag = ircMO_motive.Client_Privacy_Flag,
				Provisional_Flag = ircMO_motive.Provisional_Flag,
				Is_Mult_Product_Flag = ircMO_motive.Is_Mult_Product_Flag,
				Authoriz_Letter_Flag = ircMO_motive.Authoriz_Letter_Flag,
				Partial_Flag = ircMO_motive.Partial_Flag,
				Prov_Initial_Date = ircMO_motive.Prov_Initial_Date,
				Prov_Final_Date = ircMO_motive.Prov_Final_Date,
				Initial_Process_Date = ircMO_motive.Initial_Process_Date,
				Priority = ircMO_motive.Priority,
				Motiv_Recording_Date = ircMO_motive.Motiv_Recording_Date,
				Estimated_Inst_Date = ircMO_motive.Estimated_Inst_Date,
				Assign_Date = ircMO_motive.Assign_Date,
				Attention_Date = ircMO_motive.Attention_Date,
				Annul_Date = ircMO_motive.Annul_Date,
				Status_Change_Date = ircMO_motive.Status_Change_Date,
				Study_Num_Transferen = ircMO_motive.Study_Num_Transferen,
				Custom_Decision_Flag = ircMO_motive.Custom_Decision_Flag,
				Execution_Max_Date = ircMO_motive.Execution_Max_Date,
				Standard_Time = ircMO_motive.Standard_Time,
				Service_Number = ircMO_motive.Service_Number,
				Product_Motive_Id = ircMO_motive.Product_Motive_Id,
				Distribut_Admin_Id = ircMO_motive.Distribut_Admin_Id,
				District_Id = ircMO_motive.District_Id,
				Building_Id = ircMO_motive.Building_Id,
				Annul_Causal_Id = ircMO_motive.Annul_Causal_Id,
				Product_Id = ircMO_motive.Product_Id,
				Motive_Type_Id = ircMO_motive.Motive_Type_Id,
				Product_Type_Id = ircMO_motive.Product_Type_Id,
				Motive_Status_Id = ircMO_motive.Motive_Status_Id,
				Subscription_Id = ircMO_motive.Subscription_Id,
				Package_Id = ircMO_motive.Package_Id,
				Undoassign_Causal_Id = ircMO_motive.Undoassign_Causal_Id,
				Geograp_Location_Id = ircMO_motive.Geograp_Location_Id,
				Credit_Limit = ircMO_motive.Credit_Limit,
				Credit_Limit_Covered = ircMO_motive.Credit_Limit_Covered,
				Cust_Care_Reques_Num = ircMO_motive.Cust_Care_Reques_Num,
				Value_To_Debit = ircMO_motive.Value_To_Debit,
				Tag_Name = ircMO_motive.Tag_Name,
				Organizat_Area_Id = ircMO_motive.Organizat_Area_Id,
				Commercial_Plan_Id = ircMO_motive.Commercial_Plan_Id,
				Permanence = ircMO_motive.Permanence,
				Company_Id = ircMO_motive.Company_Id,
				Included_Features_Id = ircMO_motive.Included_Features_Id,
				Reception_Type_Id = ircMO_motive.Reception_Type_Id,
				Causal_Id = ircMO_motive.Causal_Id,
				Assigned_Person_Id = ircMO_motive.Assigned_Person_Id,
				Answer_Id = ircMO_motive.Answer_Id,
				Category_Id = ircMO_motive.Category_Id,
				Subcategory_Id = ircMO_motive.Subcategory_Id,
				Is_Immediate_Attent = ircMO_motive.Is_Immediate_Attent,
				Element_Position = ircMO_motive.Element_Position
			where
				rowid = ircMO_motive.rowid
			returning
				Motive_Id
			into
				nuMotive_Id;
       ELSE
         IF INULOCK = 1 THEN
            LOCKBYPK( IRCMO_MOTIVE.MOTIVE_ID, RCDATA );
         END IF;
         UPDATE MO_motive
			set
				Privacy_Flag = ircMO_motive.Privacy_Flag,
				Client_Privacy_Flag = ircMO_motive.Client_Privacy_Flag,
				Provisional_Flag = ircMO_motive.Provisional_Flag,
				Is_Mult_Product_Flag = ircMO_motive.Is_Mult_Product_Flag,
				Authoriz_Letter_Flag = ircMO_motive.Authoriz_Letter_Flag,
				Partial_Flag = ircMO_motive.Partial_Flag,
				Prov_Initial_Date = ircMO_motive.Prov_Initial_Date,
				Prov_Final_Date = ircMO_motive.Prov_Final_Date,
				Initial_Process_Date = ircMO_motive.Initial_Process_Date,
				Priority = ircMO_motive.Priority,
				Motiv_Recording_Date = ircMO_motive.Motiv_Recording_Date,
				Estimated_Inst_Date = ircMO_motive.Estimated_Inst_Date,
				Assign_Date = ircMO_motive.Assign_Date,
				Attention_Date = ircMO_motive.Attention_Date,
				Annul_Date = ircMO_motive.Annul_Date,
				Status_Change_Date = ircMO_motive.Status_Change_Date,
				Study_Num_Transferen = ircMO_motive.Study_Num_Transferen,
				Custom_Decision_Flag = ircMO_motive.Custom_Decision_Flag,
				Execution_Max_Date = ircMO_motive.Execution_Max_Date,
				Standard_Time = ircMO_motive.Standard_Time,
				Service_Number = ircMO_motive.Service_Number,
				Product_Motive_Id = ircMO_motive.Product_Motive_Id,
				Distribut_Admin_Id = ircMO_motive.Distribut_Admin_Id,
				District_Id = ircMO_motive.District_Id,
				Building_Id = ircMO_motive.Building_Id,
				Annul_Causal_Id = ircMO_motive.Annul_Causal_Id,
				Product_Id = ircMO_motive.Product_Id,
				Motive_Type_Id = ircMO_motive.Motive_Type_Id,
				Product_Type_Id = ircMO_motive.Product_Type_Id,
				Motive_Status_Id = ircMO_motive.Motive_Status_Id,
				Subscription_Id = ircMO_motive.Subscription_Id,
				Package_Id = ircMO_motive.Package_Id,
				Undoassign_Causal_Id = ircMO_motive.Undoassign_Causal_Id,
				Geograp_Location_Id = ircMO_motive.Geograp_Location_Id,
				Credit_Limit = ircMO_motive.Credit_Limit,
				Credit_Limit_Covered = ircMO_motive.Credit_Limit_Covered,
				Cust_Care_Reques_Num = ircMO_motive.Cust_Care_Reques_Num,
				Value_To_Debit = ircMO_motive.Value_To_Debit,
				Tag_Name = ircMO_motive.Tag_Name,
				Organizat_Area_Id = ircMO_motive.Organizat_Area_Id,
				Commercial_Plan_Id = ircMO_motive.Commercial_Plan_Id,
				Permanence = ircMO_motive.Permanence,
				Company_Id = ircMO_motive.Company_Id,
				Included_Features_Id = ircMO_motive.Included_Features_Id,
				Reception_Type_Id = ircMO_motive.Reception_Type_Id,
				Causal_Id = ircMO_motive.Causal_Id,
				Assigned_Person_Id = ircMO_motive.Assigned_Person_Id,
				Answer_Id = ircMO_motive.Answer_Id,
				Category_Id = ircMO_motive.Category_Id,
				Subcategory_Id = ircMO_motive.Subcategory_Id,
				Is_Immediate_Attent = ircMO_motive.Is_Immediate_Attent,
				Element_Position = ircMO_motive.Element_Position
			where
				Motive_Id = ircMO_motive.Motive_Id
			returning
				Motive_Id
			into
				nuMotive_Id;
      END IF;
      IF NUMOTIVE_ID IS NULL THEN
         RAISE NO_DATA_FOUND;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || FSBPRIMARYKEY( IRCMO_MOTIVE ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORDS( IOTBMO_MOTIVE IN OUT NOCOPY TYTBMO_MOTIVE, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYMO_MOTIVE;
    BEGIN
      FILLRECORDOFTABLES( IOTBMO_MOTIVE, BLUSEROWID );
      IF BLUSEROWID THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
            UPDATE MO_motive
				set
					Privacy_Flag = rcRecOfTab.Privacy_Flag(n),
					Client_Privacy_Flag = rcRecOfTab.Client_Privacy_Flag(n),
					Provisional_Flag = rcRecOfTab.Provisional_Flag(n),
					Is_Mult_Product_Flag = rcRecOfTab.Is_Mult_Product_Flag(n),
					Authoriz_Letter_Flag = rcRecOfTab.Authoriz_Letter_Flag(n),
					Partial_Flag = rcRecOfTab.Partial_Flag(n),
					Prov_Initial_Date = rcRecOfTab.Prov_Initial_Date(n),
					Prov_Final_Date = rcRecOfTab.Prov_Final_Date(n),
					Initial_Process_Date = rcRecOfTab.Initial_Process_Date(n),
					Priority = rcRecOfTab.Priority(n),
					Motiv_Recording_Date = rcRecOfTab.Motiv_Recording_Date(n),
					Estimated_Inst_Date = rcRecOfTab.Estimated_Inst_Date(n),
					Assign_Date = rcRecOfTab.Assign_Date(n),
					Attention_Date = rcRecOfTab.Attention_Date(n),
					Annul_Date = rcRecOfTab.Annul_Date(n),
					Status_Change_Date = rcRecOfTab.Status_Change_Date(n),
					Study_Num_Transferen = rcRecOfTab.Study_Num_Transferen(n),
					Custom_Decision_Flag = rcRecOfTab.Custom_Decision_Flag(n),
					Execution_Max_Date = rcRecOfTab.Execution_Max_Date(n),
					Standard_Time = rcRecOfTab.Standard_Time(n),
					Service_Number = rcRecOfTab.Service_Number(n),
					Product_Motive_Id = rcRecOfTab.Product_Motive_Id(n),
					Distribut_Admin_Id = rcRecOfTab.Distribut_Admin_Id(n),
					District_Id = rcRecOfTab.District_Id(n),
					Building_Id = rcRecOfTab.Building_Id(n),
					Annul_Causal_Id = rcRecOfTab.Annul_Causal_Id(n),
					Product_Id = rcRecOfTab.Product_Id(n),
					Motive_Type_Id = rcRecOfTab.Motive_Type_Id(n),
					Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
					Motive_Status_Id = rcRecOfTab.Motive_Status_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Package_Id = rcRecOfTab.Package_Id(n),
					Undoassign_Causal_Id = rcRecOfTab.Undoassign_Causal_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Credit_Limit = rcRecOfTab.Credit_Limit(n),
					Credit_Limit_Covered = rcRecOfTab.Credit_Limit_Covered(n),
					Cust_Care_Reques_Num = rcRecOfTab.Cust_Care_Reques_Num(n),
					Value_To_Debit = rcRecOfTab.Value_To_Debit(n),
					Tag_Name = rcRecOfTab.Tag_Name(n),
					Organizat_Area_Id = rcRecOfTab.Organizat_Area_Id(n),
					Commercial_Plan_Id = rcRecOfTab.Commercial_Plan_Id(n),
					Permanence = rcRecOfTab.Permanence(n),
					Company_Id = rcRecOfTab.Company_Id(n),
					Included_Features_Id = rcRecOfTab.Included_Features_Id(n),
					Reception_Type_Id = rcRecOfTab.Reception_Type_Id(n),
					Causal_Id = rcRecOfTab.Causal_Id(n),
					Assigned_Person_Id = rcRecOfTab.Assigned_Person_Id(n),
					Answer_Id = rcRecOfTab.Answer_Id(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Is_Immediate_Attent = rcRecOfTab.Is_Immediate_Attent(n),
					Element_Position = rcRecOfTab.Element_Position(n)
				where
					rowid =  rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.MOTIVE_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBMO_MOTIVE.FIRST..IOTBMO_MOTIVE.LAST
            UPDATE MO_motive
				SET
					Privacy_Flag = rcRecOfTab.Privacy_Flag(n),
					Client_Privacy_Flag = rcRecOfTab.Client_Privacy_Flag(n),
					Provisional_Flag = rcRecOfTab.Provisional_Flag(n),
					Is_Mult_Product_Flag = rcRecOfTab.Is_Mult_Product_Flag(n),
					Authoriz_Letter_Flag = rcRecOfTab.Authoriz_Letter_Flag(n),
					Partial_Flag = rcRecOfTab.Partial_Flag(n),
					Prov_Initial_Date = rcRecOfTab.Prov_Initial_Date(n),
					Prov_Final_Date = rcRecOfTab.Prov_Final_Date(n),
					Initial_Process_Date = rcRecOfTab.Initial_Process_Date(n),
					Priority = rcRecOfTab.Priority(n),
					Motiv_Recording_Date = rcRecOfTab.Motiv_Recording_Date(n),
					Estimated_Inst_Date = rcRecOfTab.Estimated_Inst_Date(n),
					Assign_Date = rcRecOfTab.Assign_Date(n),
					Attention_Date = rcRecOfTab.Attention_Date(n),
					Annul_Date = rcRecOfTab.Annul_Date(n),
					Status_Change_Date = rcRecOfTab.Status_Change_Date(n),
					Study_Num_Transferen = rcRecOfTab.Study_Num_Transferen(n),
					Custom_Decision_Flag = rcRecOfTab.Custom_Decision_Flag(n),
					Execution_Max_Date = rcRecOfTab.Execution_Max_Date(n),
					Standard_Time = rcRecOfTab.Standard_Time(n),
					Service_Number = rcRecOfTab.Service_Number(n),
					Product_Motive_Id = rcRecOfTab.Product_Motive_Id(n),
					Distribut_Admin_Id = rcRecOfTab.Distribut_Admin_Id(n),
					District_Id = rcRecOfTab.District_Id(n),
					Building_Id = rcRecOfTab.Building_Id(n),
					Annul_Causal_Id = rcRecOfTab.Annul_Causal_Id(n),
					Product_Id = rcRecOfTab.Product_Id(n),
					Motive_Type_Id = rcRecOfTab.Motive_Type_Id(n),
					Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
					Motive_Status_Id = rcRecOfTab.Motive_Status_Id(n),
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Package_Id = rcRecOfTab.Package_Id(n),
					Undoassign_Causal_Id = rcRecOfTab.Undoassign_Causal_Id(n),
					Geograp_Location_Id = rcRecOfTab.Geograp_Location_Id(n),
					Credit_Limit = rcRecOfTab.Credit_Limit(n),
					Credit_Limit_Covered = rcRecOfTab.Credit_Limit_Covered(n),
					Cust_Care_Reques_Num = rcRecOfTab.Cust_Care_Reques_Num(n),
					Value_To_Debit = rcRecOfTab.Value_To_Debit(n),
					Tag_Name = rcRecOfTab.Tag_Name(n),
					Organizat_Area_Id = rcRecOfTab.Organizat_Area_Id(n),
					Commercial_Plan_Id = rcRecOfTab.Commercial_Plan_Id(n),
					Permanence = rcRecOfTab.Permanence(n),
					Company_Id = rcRecOfTab.Company_Id(n),
					Included_Features_Id = rcRecOfTab.Included_Features_Id(n),
					Reception_Type_Id = rcRecOfTab.Reception_Type_Id(n),
					Causal_Id = rcRecOfTab.Causal_Id(n),
					Assigned_Person_Id = rcRecOfTab.Assigned_Person_Id(n),
					Answer_Id = rcRecOfTab.Answer_Id(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Is_Immediate_Attent = rcRecOfTab.Is_Immediate_Attent(n),
					Element_Position = rcRecOfTab.Element_Position(n)
				where
					Motive_Id = rcRecOfTab.Motive_Id(n)
;
      END IF;
   END;
   PROCEDURE UPDPRIVACY_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBPRIVACY_FLAG$ IN MO_MOTIVE.PRIVACY_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Privacy_Flag = isbPrivacy_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRIVACY_FLAG := ISBPRIVACY_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCLIENT_PRIVACY_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBCLIENT_PRIVACY_FLAG$ IN MO_MOTIVE.CLIENT_PRIVACY_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Client_Privacy_Flag = isbClient_Privacy_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CLIENT_PRIVACY_FLAG := ISBCLIENT_PRIVACY_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPROVISIONAL_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBPROVISIONAL_FLAG$ IN MO_MOTIVE.PROVISIONAL_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Provisional_Flag = isbProvisional_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PROVISIONAL_FLAG := ISBPROVISIONAL_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDIS_MULT_PRODUCT_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBIS_MULT_PRODUCT_FLAG$ IN MO_MOTIVE.IS_MULT_PRODUCT_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Is_Mult_Product_Flag = isbIs_Mult_Product_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.IS_MULT_PRODUCT_FLAG := ISBIS_MULT_PRODUCT_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDAUTHORIZ_LETTER_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBAUTHORIZ_LETTER_FLAG$ IN MO_MOTIVE.AUTHORIZ_LETTER_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Authoriz_Letter_Flag = isbAuthoriz_Letter_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.AUTHORIZ_LETTER_FLAG := ISBAUTHORIZ_LETTER_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPARTIAL_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBPARTIAL_FLAG$ IN MO_MOTIVE.PARTIAL_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Partial_Flag = isbPartial_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PARTIAL_FLAG := ISBPARTIAL_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPROV_INITIAL_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTPROV_INITIAL_DATE$ IN MO_MOTIVE.PROV_INITIAL_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Prov_Initial_Date = idtProv_Initial_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PROV_INITIAL_DATE := IDTPROV_INITIAL_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPROV_FINAL_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTPROV_FINAL_DATE$ IN MO_MOTIVE.PROV_FINAL_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Prov_Final_Date = idtProv_Final_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PROV_FINAL_DATE := IDTPROV_FINAL_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDINITIAL_PROCESS_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTINITIAL_PROCESS_DATE$ IN MO_MOTIVE.INITIAL_PROCESS_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Initial_Process_Date = idtInitial_Process_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.INITIAL_PROCESS_DATE := IDTINITIAL_PROCESS_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRIORITY( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUPRIORITY$ IN MO_MOTIVE.PRIORITY%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Priority = inuPriority$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRIORITY := INUPRIORITY$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDMOTIV_RECORDING_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTMOTIV_RECORDING_DATE$ IN MO_MOTIVE.MOTIV_RECORDING_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Motiv_Recording_Date = idtMotiv_Recording_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.MOTIV_RECORDING_DATE := IDTMOTIV_RECORDING_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDESTIMATED_INST_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTESTIMATED_INST_DATE$ IN MO_MOTIVE.ESTIMATED_INST_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Estimated_Inst_Date = idtEstimated_Inst_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ESTIMATED_INST_DATE := IDTESTIMATED_INST_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDASSIGN_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTASSIGN_DATE$ IN MO_MOTIVE.ASSIGN_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Assign_Date = idtAssign_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ASSIGN_DATE := IDTASSIGN_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDATTENTION_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTATTENTION_DATE$ IN MO_MOTIVE.ATTENTION_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Attention_Date = idtAttention_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ATTENTION_DATE := IDTATTENTION_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDANNUL_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTANNUL_DATE$ IN MO_MOTIVE.ANNUL_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Annul_Date = idtAnnul_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ANNUL_DATE := IDTANNUL_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSTATUS_CHANGE_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTSTATUS_CHANGE_DATE$ IN MO_MOTIVE.STATUS_CHANGE_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Status_Change_Date = idtStatus_Change_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.STATUS_CHANGE_DATE := IDTSTATUS_CHANGE_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSTUDY_NUM_TRANSFEREN( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUSTUDY_NUM_TRANSFEREN$ IN MO_MOTIVE.STUDY_NUM_TRANSFEREN%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Study_Num_Transferen = inuStudy_Num_Transferen$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.STUDY_NUM_TRANSFEREN := INUSTUDY_NUM_TRANSFEREN$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCUSTOM_DECISION_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBCUSTOM_DECISION_FLAG$ IN MO_MOTIVE.CUSTOM_DECISION_FLAG%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Custom_Decision_Flag = isbCustom_Decision_Flag$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CUSTOM_DECISION_FLAG := ISBCUSTOM_DECISION_FLAG$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDEXECUTION_MAX_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, IDTEXECUTION_MAX_DATE$ IN MO_MOTIVE.EXECUTION_MAX_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Execution_Max_Date = idtExecution_Max_Date$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.EXECUTION_MAX_DATE := IDTEXECUTION_MAX_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSTANDARD_TIME( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUSTANDARD_TIME$ IN MO_MOTIVE.STANDARD_TIME%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Standard_Time = inuStandard_Time$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.STANDARD_TIME := INUSTANDARD_TIME$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSERVICE_NUMBER( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBSERVICE_NUMBER$ IN MO_MOTIVE.SERVICE_NUMBER%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Service_Number = isbService_Number$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SERVICE_NUMBER := ISBSERVICE_NUMBER$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRODUCT_MOTIVE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUPRODUCT_MOTIVE_ID$ IN MO_MOTIVE.PRODUCT_MOTIVE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Product_Motive_Id = inuProduct_Motive_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRODUCT_MOTIVE_ID := INUPRODUCT_MOTIVE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDDISTRIBUT_ADMIN_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUDISTRIBUT_ADMIN_ID$ IN MO_MOTIVE.DISTRIBUT_ADMIN_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Distribut_Admin_Id = inuDistribut_Admin_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.DISTRIBUT_ADMIN_ID := INUDISTRIBUT_ADMIN_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDDISTRICT_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBDISTRICT_ID$ IN MO_MOTIVE.DISTRICT_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			District_Id = isbDistrict_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.DISTRICT_ID := ISBDISTRICT_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDBUILDING_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUBUILDING_ID$ IN MO_MOTIVE.BUILDING_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Building_Id = inuBuilding_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.BUILDING_ID := INUBUILDING_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDANNUL_CAUSAL_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUANNUL_CAUSAL_ID$ IN MO_MOTIVE.ANNUL_CAUSAL_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Annul_Causal_Id = inuAnnul_Causal_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ANNUL_CAUSAL_ID := INUANNUL_CAUSAL_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRODUCT_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUPRODUCT_ID$ IN MO_MOTIVE.PRODUCT_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Product_Id = inuProduct_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRODUCT_ID := INUPRODUCT_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDMOTIVE_TYPE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUMOTIVE_TYPE_ID$ IN MO_MOTIVE.MOTIVE_TYPE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Motive_Type_Id = inuMotive_Type_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.MOTIVE_TYPE_ID := INUMOTIVE_TYPE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRODUCT_TYPE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUPRODUCT_TYPE_ID$ IN MO_MOTIVE.PRODUCT_TYPE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Product_Type_Id = inuProduct_Type_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRODUCT_TYPE_ID := INUPRODUCT_TYPE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDMOTIVE_STATUS_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUMOTIVE_STATUS_ID$ IN MO_MOTIVE.MOTIVE_STATUS_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Motive_Status_Id = inuMotive_Status_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.MOTIVE_STATUS_ID := INUMOTIVE_STATUS_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSUBSCRIPTION_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUSUBSCRIPTION_ID$ IN MO_MOTIVE.SUBSCRIPTION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Subscription_Id = inuSubscription_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SUBSCRIPTION_ID := INUSUBSCRIPTION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPACKAGE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUPACKAGE_ID$ IN MO_MOTIVE.PACKAGE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Package_Id = inuPackage_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PACKAGE_ID := INUPACKAGE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDUNDOASSIGN_CAUSAL_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUUNDOASSIGN_CAUSAL_ID$ IN MO_MOTIVE.UNDOASSIGN_CAUSAL_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Undoassign_Causal_Id = inuUndoassign_Causal_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.UNDOASSIGN_CAUSAL_ID := INUUNDOASSIGN_CAUSAL_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDGEOGRAP_LOCATION_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUGEOGRAP_LOCATION_ID$ IN MO_MOTIVE.GEOGRAP_LOCATION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Geograp_Location_Id = inuGeograp_Location_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.GEOGRAP_LOCATION_ID := INUGEOGRAP_LOCATION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCREDIT_LIMIT( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUCREDIT_LIMIT$ IN MO_MOTIVE.CREDIT_LIMIT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Credit_Limit = inuCredit_Limit$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CREDIT_LIMIT := INUCREDIT_LIMIT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCREDIT_LIMIT_COVERED( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUCREDIT_LIMIT_COVERED$ IN MO_MOTIVE.CREDIT_LIMIT_COVERED%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Credit_Limit_Covered = inuCredit_Limit_Covered$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CREDIT_LIMIT_COVERED := INUCREDIT_LIMIT_COVERED$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCUST_CARE_REQUES_NUM( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBCUST_CARE_REQUES_NUM$ IN MO_MOTIVE.CUST_CARE_REQUES_NUM%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Cust_Care_Reques_Num = isbCust_Care_Reques_Num$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CUST_CARE_REQUES_NUM := ISBCUST_CARE_REQUES_NUM$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDVALUE_TO_DEBIT( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUVALUE_TO_DEBIT$ IN MO_MOTIVE.VALUE_TO_DEBIT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Value_To_Debit = inuValue_To_Debit$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.VALUE_TO_DEBIT := INUVALUE_TO_DEBIT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDTAG_NAME( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBTAG_NAME$ IN MO_MOTIVE.TAG_NAME%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Tag_Name = isbTag_Name$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.TAG_NAME := ISBTAG_NAME$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDORGANIZAT_AREA_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUORGANIZAT_AREA_ID$ IN MO_MOTIVE.ORGANIZAT_AREA_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Organizat_Area_Id = inuOrganizat_Area_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ORGANIZAT_AREA_ID := INUORGANIZAT_AREA_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCOMMERCIAL_PLAN_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUCOMMERCIAL_PLAN_ID$ IN MO_MOTIVE.COMMERCIAL_PLAN_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Commercial_Plan_Id = inuCommercial_Plan_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.COMMERCIAL_PLAN_ID := INUCOMMERCIAL_PLAN_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPERMANENCE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUPERMANENCE$ IN MO_MOTIVE.PERMANENCE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Permanence = inuPermanence$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PERMANENCE := INUPERMANENCE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCOMPANY_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUCOMPANY_ID$ IN MO_MOTIVE.COMPANY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Company_Id = inuCompany_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.COMPANY_ID := INUCOMPANY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDINCLUDED_FEATURES_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUINCLUDED_FEATURES_ID$ IN MO_MOTIVE.INCLUDED_FEATURES_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Included_Features_Id = inuIncluded_Features_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.INCLUDED_FEATURES_ID := INUINCLUDED_FEATURES_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECEPTION_TYPE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURECEPTION_TYPE_ID$ IN MO_MOTIVE.RECEPTION_TYPE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Reception_Type_Id = inuReception_Type_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.RECEPTION_TYPE_ID := INURECEPTION_TYPE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCAUSAL_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUCAUSAL_ID$ IN MO_MOTIVE.CAUSAL_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Causal_Id = inuCausal_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CAUSAL_ID := INUCAUSAL_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDASSIGNED_PERSON_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUASSIGNED_PERSON_ID$ IN MO_MOTIVE.ASSIGNED_PERSON_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Assigned_Person_Id = inuAssigned_Person_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ASSIGNED_PERSON_ID := INUASSIGNED_PERSON_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDANSWER_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUANSWER_ID$ IN MO_MOTIVE.ANSWER_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Answer_Id = inuAnswer_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ANSWER_ID := INUANSWER_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCATEGORY_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUCATEGORY_ID$ IN MO_MOTIVE.CATEGORY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Category_Id = inuCategory_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CATEGORY_ID := INUCATEGORY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSUBCATEGORY_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUSUBCATEGORY_ID$ IN MO_MOTIVE.SUBCATEGORY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Subcategory_Id = inuSubcategory_Id$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SUBCATEGORY_ID := INUSUBCATEGORY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDIS_IMMEDIATE_ATTENT( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, ISBIS_IMMEDIATE_ATTENT$ IN MO_MOTIVE.IS_IMMEDIATE_ATTENT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Is_Immediate_Attent = isbIs_Immediate_Attent$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.IS_IMMEDIATE_ATTENT := ISBIS_IMMEDIATE_ATTENT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDELEMENT_POSITION( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INUELEMENT_POSITION$ IN MO_MOTIVE.ELEMENT_POSITION%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUMOTIVE_ID, RCDATA );
      END IF;
      UPDATE MO_motive
		set
			Element_Position = inuElement_Position$
		where
			Motive_Id = inuMotive_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ELEMENT_POSITION := INUELEMENT_POSITION$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FNUGETMOTIVE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.MOTIVE_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.MOTIVE_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.MOTIVE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETPRIVACY_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PRIVACY_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PRIVACY_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PRIVACY_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETCLIENT_PRIVACY_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CLIENT_PRIVACY_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CLIENT_PRIVACY_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CLIENT_PRIVACY_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETPROVISIONAL_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PROVISIONAL_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PROVISIONAL_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PROVISIONAL_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETIS_MULT_PRODUCT_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.IS_MULT_PRODUCT_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.IS_MULT_PRODUCT_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.IS_MULT_PRODUCT_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETAUTHORIZ_LETTER_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.AUTHORIZ_LETTER_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.AUTHORIZ_LETTER_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.AUTHORIZ_LETTER_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETPARTIAL_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PARTIAL_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PARTIAL_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PARTIAL_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETPROV_INITIAL_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PROV_INITIAL_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PROV_INITIAL_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PROV_INITIAL_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETPROV_FINAL_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PROV_FINAL_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PROV_FINAL_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PROV_FINAL_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETINITIAL_PROCESS_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.INITIAL_PROCESS_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.INITIAL_PROCESS_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.INITIAL_PROCESS_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPRIORITY( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PRIORITY%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PRIORITY );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PRIORITY );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETMOTIV_RECORDING_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.MOTIV_RECORDING_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.MOTIV_RECORDING_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.MOTIV_RECORDING_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETESTIMATED_INST_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ESTIMATED_INST_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ESTIMATED_INST_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ESTIMATED_INST_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETASSIGN_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ASSIGN_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ASSIGN_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ASSIGN_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETATTENTION_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ATTENTION_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ATTENTION_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ATTENTION_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETANNUL_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ANNUL_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ANNUL_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ANNUL_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETSTATUS_CHANGE_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.STATUS_CHANGE_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.STATUS_CHANGE_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.STATUS_CHANGE_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETSTUDY_NUM_TRANSFEREN( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.STUDY_NUM_TRANSFEREN%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.STUDY_NUM_TRANSFEREN );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.STUDY_NUM_TRANSFEREN );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETCUSTOM_DECISION_FLAG( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CUSTOM_DECISION_FLAG%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CUSTOM_DECISION_FLAG );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CUSTOM_DECISION_FLAG );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETEXECUTION_MAX_DATE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.EXECUTION_MAX_DATE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.EXECUTION_MAX_DATE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.EXECUTION_MAX_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETSTANDARD_TIME( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.STANDARD_TIME%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.STANDARD_TIME );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.STANDARD_TIME );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETSERVICE_NUMBER( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.SERVICE_NUMBER%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.SERVICE_NUMBER );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.SERVICE_NUMBER );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPRODUCT_MOTIVE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PRODUCT_MOTIVE_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PRODUCT_MOTIVE_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PRODUCT_MOTIVE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETDISTRIBUT_ADMIN_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.DISTRIBUT_ADMIN_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.DISTRIBUT_ADMIN_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.DISTRIBUT_ADMIN_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETDISTRICT_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.DISTRICT_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.DISTRICT_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.DISTRICT_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETBUILDING_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.BUILDING_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.BUILDING_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.BUILDING_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETANNUL_CAUSAL_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ANNUL_CAUSAL_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ANNUL_CAUSAL_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ANNUL_CAUSAL_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPRODUCT_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PRODUCT_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PRODUCT_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PRODUCT_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETMOTIVE_TYPE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.MOTIVE_TYPE_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.MOTIVE_TYPE_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.MOTIVE_TYPE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPRODUCT_TYPE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PRODUCT_TYPE_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PRODUCT_TYPE_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PRODUCT_TYPE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETMOTIVE_STATUS_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.MOTIVE_STATUS_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.MOTIVE_STATUS_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.MOTIVE_STATUS_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETSUBSCRIPTION_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.SUBSCRIPTION_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.SUBSCRIPTION_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.SUBSCRIPTION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPACKAGE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PACKAGE_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PACKAGE_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PACKAGE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETUNDOASSIGN_CAUSAL_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.UNDOASSIGN_CAUSAL_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.UNDOASSIGN_CAUSAL_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.UNDOASSIGN_CAUSAL_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETGEOGRAP_LOCATION_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.GEOGRAP_LOCATION_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.GEOGRAP_LOCATION_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.GEOGRAP_LOCATION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCREDIT_LIMIT( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CREDIT_LIMIT%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CREDIT_LIMIT );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CREDIT_LIMIT );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCREDIT_LIMIT_COVERED( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CREDIT_LIMIT_COVERED%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CREDIT_LIMIT_COVERED );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CREDIT_LIMIT_COVERED );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETCUST_CARE_REQUES_NUM( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CUST_CARE_REQUES_NUM%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CUST_CARE_REQUES_NUM );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CUST_CARE_REQUES_NUM );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETVALUE_TO_DEBIT( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.VALUE_TO_DEBIT%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.VALUE_TO_DEBIT );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.VALUE_TO_DEBIT );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETTAG_NAME( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.TAG_NAME%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.TAG_NAME );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.TAG_NAME );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETORGANIZAT_AREA_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ORGANIZAT_AREA_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ORGANIZAT_AREA_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ORGANIZAT_AREA_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCOMMERCIAL_PLAN_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.COMMERCIAL_PLAN_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.COMMERCIAL_PLAN_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.COMMERCIAL_PLAN_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPERMANENCE( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.PERMANENCE%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.PERMANENCE );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.PERMANENCE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCOMPANY_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.COMPANY_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.COMPANY_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.COMPANY_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETINCLUDED_FEATURES_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.INCLUDED_FEATURES_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.INCLUDED_FEATURES_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.INCLUDED_FEATURES_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETRECEPTION_TYPE_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.RECEPTION_TYPE_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.RECEPTION_TYPE_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.RECEPTION_TYPE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCAUSAL_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CAUSAL_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CAUSAL_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CAUSAL_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETASSIGNED_PERSON_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ASSIGNED_PERSON_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ASSIGNED_PERSON_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ASSIGNED_PERSON_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETANSWER_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ANSWER_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ANSWER_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ANSWER_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCATEGORY_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.CATEGORY_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.CATEGORY_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.CATEGORY_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETSUBCATEGORY_ID( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.SUBCATEGORY_ID%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.SUBCATEGORY_ID );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.SUBCATEGORY_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETIS_IMMEDIATE_ATTENT( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.IS_IMMEDIATE_ATTENT%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.IS_IMMEDIATE_ATTENT );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.IS_IMMEDIATE_ATTENT );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETELEMENT_POSITION( INUMOTIVE_ID IN MO_MOTIVE.MOTIVE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN MO_MOTIVE.ELEMENT_POSITION%TYPE
    IS
      RCERROR STYMO_MOTIVE;
    BEGIN
      RCERROR.MOTIVE_ID := INUMOTIVE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUMOTIVE_ID ) THEN
         RETURN ( RCDATA.ELEMENT_POSITION );
      END IF;
      LOAD( INUMOTIVE_ID );
      RETURN ( RCDATA.ELEMENT_POSITION );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   PROCEDURE SETUSECACHE( IBLUSECACHE IN BOOLEAN )
    IS
    BEGIN
      BLDAO_USE_CACHE := IBLUSECACHE;
   END;
 BEGIN
   GETDAO_USE_CACHE;
END DAMO_MOTIVE;
/


