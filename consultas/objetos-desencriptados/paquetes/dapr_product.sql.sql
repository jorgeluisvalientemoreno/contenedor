CREATE OR REPLACE PACKAGE BODY DAPR_PRODUCT IS
   CNURECORD_NOT_EXIST CONSTANT NUMBER( 1 ) := 1;
   CNURECORD_ALREADY_EXIST CONSTANT NUMBER( 1 ) := 2;
   CNUAPPTABLEBUSSY CONSTANT NUMBER( 4 ) := 6951;
   CNUINS_PK_NULL CONSTANT NUMBER( 4 ) := 1682;
   CNURECORD_HAVE_CHILDREN CONSTANT NUMBER( 4 ) := -2292;
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO191105';
   CSBTABLEPARAMETER CONSTANT VARCHAR2( 30 ) := 'PR_PRODUCT';
   CNUGEENTITYID CONSTANT VARCHAR2( 30 ) := 5006;
   CURSOR CULOCKRCBYPK( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE ) IS
SELECT PR_product.*,PR_product.rowid 
		FROM PR_product
		WHERE  Product_Id = inuProduct_Id
		FOR UPDATE NOWAIT;
   CURSOR CULOCKRCBYROWID( IRIROWID IN VARCHAR2 ) IS
SELECT PR_product.*,PR_product.rowid 
		FROM PR_product
		WHERE 
			rowId = irirowid
		FOR UPDATE NOWAIT;
   TYPE TYRFPR_PRODUCT IS REF CURSOR;
   RCRECOFTAB TYRCPR_PRODUCT;
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
   FUNCTION FSBPRIMARYKEY( RCI IN STYPR_PRODUCT := RCDATA )
    RETURN VARCHAR2
    IS
      SBPK VARCHAR2( 500 );
    BEGIN
      SBPK := '[';
      SBPK := SBPK || UT_CONVERT.FSBTOCHAR( RCI.PRODUCT_ID );
      SBPK := SBPK || ']';
      RETURN SBPK;
   END;
   PROCEDURE LOCKBYPK( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ORCPR_PRODUCT OUT STYPR_PRODUCT )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      OPEN CULOCKRCBYPK( INUPRODUCT_ID );
      FETCH CULOCKRCBYPK
         INTO ORCPR_PRODUCT;
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
   PROCEDURE LOCKBYROWID( IRIROWID IN VARCHAR2, ORCPR_PRODUCT OUT STYPR_PRODUCT )
    IS
    BEGIN
      OPEN CULOCKRCBYROWID( IRIROWID );
      FETCH CULOCKRCBYROWID
         INTO ORCPR_PRODUCT;
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
   PROCEDURE DELRECORDOFTABLES( ITBPR_PRODUCT IN OUT NOCOPY TYTBPR_PRODUCT )
    IS
    BEGIN
      RCRECOFTAB.PRODUCT_ID.DELETE;
      RCRECOFTAB.SUBSCRIPTION_ID.DELETE;
      RCRECOFTAB.PRODUCT_TYPE_ID.DELETE;
      RCRECOFTAB.DISTRIBUT_ADMIN_ID.DELETE;
      RCRECOFTAB.IS_PROVISIONAL.DELETE;
      RCRECOFTAB.PROVISIONAL_END_DATE.DELETE;
      RCRECOFTAB.PROVISIONAL_BEG_DATE.DELETE;
      RCRECOFTAB.PRODUCT_STATUS_ID.DELETE;
      RCRECOFTAB.SERVICE_NUMBER.DELETE;
      RCRECOFTAB.CREATION_DATE.DELETE;
      RCRECOFTAB.IS_PRIVATE.DELETE;
      RCRECOFTAB.RETIRE_DATE.DELETE;
      RCRECOFTAB.COMMERCIAL_PLAN_ID.DELETE;
      RCRECOFTAB.PERSON_ID.DELETE;
      RCRECOFTAB.CLASS_PRODUCT.DELETE;
      RCRECOFTAB.ROLE_WARRANTY.DELETE;
      RCRECOFTAB.CREDIT_LIMIT.DELETE;
      RCRECOFTAB.EXPIRATION_OF_PLAN.DELETE;
      RCRECOFTAB.INCLUDED_ID.DELETE;
      RCRECOFTAB.COMPANY_ID.DELETE;
      RCRECOFTAB.ORGANIZAT_AREA_ID.DELETE;
      RCRECOFTAB.ADDRESS_ID.DELETE;
      RCRECOFTAB.PERMANENCE.DELETE;
      RCRECOFTAB.SUBS_PHONE_ID.DELETE;
      RCRECOFTAB.CATEGORY_ID.DELETE;
      RCRECOFTAB.SUBCATEGORY_ID.DELETE;
      RCRECOFTAB.SUSPEN_ORD_ACT_ID.DELETE;
      RCRECOFTAB.COLLECT_DISTRIBUTE.DELETE;
      RCRECOFTAB.ROW_ID.DELETE;
   END;
   PROCEDURE FILLRECORDOFTABLES( ITBPR_PRODUCT IN OUT NOCOPY TYTBPR_PRODUCT, OBLUSEROWID OUT BOOLEAN )
    IS
    BEGIN
      DELRECORDOFTABLES( ITBPR_PRODUCT );
      FOR N IN ITBPR_PRODUCT.FIRST..ITBPR_PRODUCT.LAST
       LOOP
         RCRECOFTAB.PRODUCT_ID( N ) := ITBPR_PRODUCT( N ).PRODUCT_ID;
         RCRECOFTAB.SUBSCRIPTION_ID( N ) := ITBPR_PRODUCT( N ).SUBSCRIPTION_ID;
         RCRECOFTAB.PRODUCT_TYPE_ID( N ) := ITBPR_PRODUCT( N ).PRODUCT_TYPE_ID;
         RCRECOFTAB.DISTRIBUT_ADMIN_ID( N ) := ITBPR_PRODUCT( N ).DISTRIBUT_ADMIN_ID;
         RCRECOFTAB.IS_PROVISIONAL( N ) := ITBPR_PRODUCT( N ).IS_PROVISIONAL;
         RCRECOFTAB.PROVISIONAL_END_DATE( N ) := ITBPR_PRODUCT( N ).PROVISIONAL_END_DATE;
         RCRECOFTAB.PROVISIONAL_BEG_DATE( N ) := ITBPR_PRODUCT( N ).PROVISIONAL_BEG_DATE;
         RCRECOFTAB.PRODUCT_STATUS_ID( N ) := ITBPR_PRODUCT( N ).PRODUCT_STATUS_ID;
         RCRECOFTAB.SERVICE_NUMBER( N ) := ITBPR_PRODUCT( N ).SERVICE_NUMBER;
         RCRECOFTAB.CREATION_DATE( N ) := ITBPR_PRODUCT( N ).CREATION_DATE;
         RCRECOFTAB.IS_PRIVATE( N ) := ITBPR_PRODUCT( N ).IS_PRIVATE;
         RCRECOFTAB.RETIRE_DATE( N ) := ITBPR_PRODUCT( N ).RETIRE_DATE;
         RCRECOFTAB.COMMERCIAL_PLAN_ID( N ) := ITBPR_PRODUCT( N ).COMMERCIAL_PLAN_ID;
         RCRECOFTAB.PERSON_ID( N ) := ITBPR_PRODUCT( N ).PERSON_ID;
         RCRECOFTAB.CLASS_PRODUCT( N ) := ITBPR_PRODUCT( N ).CLASS_PRODUCT;
         RCRECOFTAB.ROLE_WARRANTY( N ) := ITBPR_PRODUCT( N ).ROLE_WARRANTY;
         RCRECOFTAB.CREDIT_LIMIT( N ) := ITBPR_PRODUCT( N ).CREDIT_LIMIT;
         RCRECOFTAB.EXPIRATION_OF_PLAN( N ) := ITBPR_PRODUCT( N ).EXPIRATION_OF_PLAN;
         RCRECOFTAB.INCLUDED_ID( N ) := ITBPR_PRODUCT( N ).INCLUDED_ID;
         RCRECOFTAB.COMPANY_ID( N ) := ITBPR_PRODUCT( N ).COMPANY_ID;
         RCRECOFTAB.ORGANIZAT_AREA_ID( N ) := ITBPR_PRODUCT( N ).ORGANIZAT_AREA_ID;
         RCRECOFTAB.ADDRESS_ID( N ) := ITBPR_PRODUCT( N ).ADDRESS_ID;
         RCRECOFTAB.PERMANENCE( N ) := ITBPR_PRODUCT( N ).PERMANENCE;
         RCRECOFTAB.SUBS_PHONE_ID( N ) := ITBPR_PRODUCT( N ).SUBS_PHONE_ID;
         RCRECOFTAB.CATEGORY_ID( N ) := ITBPR_PRODUCT( N ).CATEGORY_ID;
         RCRECOFTAB.SUBCATEGORY_ID( N ) := ITBPR_PRODUCT( N ).SUBCATEGORY_ID;
         RCRECOFTAB.SUSPEN_ORD_ACT_ID( N ) := ITBPR_PRODUCT( N ).SUSPEN_ORD_ACT_ID;
         RCRECOFTAB.COLLECT_DISTRIBUTE( N ) := ITBPR_PRODUCT( N ).COLLECT_DISTRIBUTE;
         RCRECOFTAB.ROW_ID( N ) := ITBPR_PRODUCT( N ).ROWID;
         OBLUSEROWID := RCRECOFTAB.ROW_ID( N ) IS NOT NULL;
      END LOOP;
   END;
   PROCEDURE LOAD( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
      RCRECORDNULL CURECORD%ROWTYPE;
    BEGIN
      IF CURECORD%ISOPEN THEN
         CLOSE CURECORD;
      END IF;
      OPEN CURECORD( INUPRODUCT_ID );
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
   FUNCTION FBLALREADYLOADED( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      IF ( INUPRODUCT_ID = RCDATA.PRODUCT_ID ) THEN
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
   FUNCTION FBLEXIST( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      LOAD( INUPRODUCT_ID );
      RETURN ( TRUE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN ( FALSE );
   END;
   PROCEDURE ACCKEY( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      LOAD( INUPRODUCT_ID );
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
   PROCEDURE VALDUPLICATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    IS
    BEGIN
      LOAD( INUPRODUCT_ID );
      ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY );
      RAISE EX.CONTROLLED_ERROR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
   END;
   PROCEDURE GETRECORD( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ORCRECORD OUT NOCOPY STYPR_PRODUCT )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      LOAD( INUPRODUCT_ID );
      ORCRECORD := RCDATA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRECORD( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN STYPR_PRODUCT
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE )
    RETURN STYPR_PRODUCT
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA
    RETURN STYPR_PRODUCT
    IS
    BEGIN
      RETURN ( RCDATA );
   END;
   PROCEDURE GETRECORDS( ISBQUERY IN VARCHAR2, OTBRESULT OUT NOCOPY TYTBPR_PRODUCT )
    IS
      RFPR_PRODUCT TYRFPR_PRODUCT;
      N NUMBER( 4 ) := 1;
      SBFULLQUERY VARCHAR2( 32000 ) := 'SELECT PR_product.*, PR_product.rowid FROM PR_product';
      NUMAXTBRECORDS NUMBER( 5 ) := GE_BOPARAMETER.FNUGET( 'MAXREGSQUERY' );
    BEGIN
      OTBRESULT.DELETE;
      IF ISBQUERY IS NOT NULL AND LENGTH( ISBQUERY ) > 0 THEN
         SBFULLQUERY := SBFULLQUERY || ' WHERE ' || ISBQUERY;
      END IF;
      OPEN RFPR_PRODUCT
           FOR SBFULLQUERY;
      FETCH RFPR_PRODUCT
         BULK COLLECT INTO OTBRESULT;
      CLOSE RFPR_PRODUCT;
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
      SBSQL VARCHAR2( 32000 ) := 'select PR_product.*, PR_product.rowid FROM PR_product';
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
   PROCEDURE INSRECORD( IRCPR_PRODUCT IN STYPR_PRODUCT )
    IS
      RIROWID VARCHAR2( 200 );
    BEGIN
      INSRECORD( IRCPR_PRODUCT, RIROWID );
   END;
   PROCEDURE INSRECORD( IRCPR_PRODUCT IN STYPR_PRODUCT, ORIROWID OUT VARCHAR2 )
    IS
    BEGIN
      IF IRCPR_PRODUCT.PRODUCT_ID IS NULL THEN
         ERRORS.SETERROR( CNUINS_PK_NULL, FSBGETMESSAGEDESCRIPTION || '|Product_Id' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      INSERT into PR_product
		(
			Product_Id,
			Subscription_Id,
			Product_Type_Id,
			Distribut_Admin_Id,
			Is_Provisional,
			Provisional_End_Date,
			Provisional_Beg_Date,
			Product_Status_Id,
			Service_Number,
			Creation_Date,
			Is_Private,
			Retire_Date,
			Commercial_Plan_Id,
			Person_Id,
			Class_Product,
			Role_Warranty,
			Credit_Limit,
			Expiration_Of_Plan,
			Included_Id,
			Company_Id,
			Organizat_Area_Id,
			Address_Id,
			Permanence,
			Subs_Phone_Id,
			Category_Id,
			Subcategory_Id,
			Suspen_Ord_Act_Id,
			Collect_Distribute
		)
		values
		(
			ircPR_product.Product_Id,
			ircPR_product.Subscription_Id,
			ircPR_product.Product_Type_Id,
			ircPR_product.Distribut_Admin_Id,
			ircPR_product.Is_Provisional,
			ircPR_product.Provisional_End_Date,
			ircPR_product.Provisional_Beg_Date,
			ircPR_product.Product_Status_Id,
			ircPR_product.Service_Number,
			ircPR_product.Creation_Date,
			ircPR_product.Is_Private,
			ircPR_product.Retire_Date,
			ircPR_product.Commercial_Plan_Id,
			ircPR_product.Person_Id,
			ircPR_product.Class_Product,
			ircPR_product.Role_Warranty,
			ircPR_product.Credit_Limit,
			ircPR_product.Expiration_Of_Plan,
			ircPR_product.Included_Id,
			ircPR_product.Company_Id,
			ircPR_product.Organizat_Area_Id,
			ircPR_product.Address_Id,
			ircPR_product.Permanence,
			ircPR_product.Subs_Phone_Id,
			ircPR_product.Category_Id,
			ircPR_product.Subcategory_Id,
			ircPR_product.Suspen_Ord_Act_Id,
			ircPR_product.Collect_Distribute
		)
            returning
			rowid
		into
			orirowid;
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( IRCPR_PRODUCT ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSRECORDS( IOTBPR_PRODUCT IN OUT NOCOPY TYTBPR_PRODUCT )
    IS
      BLUSEROWID BOOLEAN;
    BEGIN
      FILLRECORDOFTABLES( IOTBPR_PRODUCT, BLUSEROWID );
      FORALL N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
         INSERT into PR_product
			(
				Product_Id,
				Subscription_Id,
				Product_Type_Id,
				Distribut_Admin_Id,
				Is_Provisional,
				Provisional_End_Date,
				Provisional_Beg_Date,
				Product_Status_Id,
				Service_Number,
				Creation_Date,
				Is_Private,
				Retire_Date,
				Commercial_Plan_Id,
				Person_Id,
				Class_Product,
				Role_Warranty,
				Credit_Limit,
				Expiration_Of_Plan,
				Included_Id,
				Company_Id,
				Organizat_Area_Id,
				Address_Id,
				Permanence,
				Subs_Phone_Id,
				Category_Id,
				Subcategory_Id,
				Suspen_Ord_Act_Id,
				Collect_Distribute
			)
			values
			(
				rcRecOfTab.Product_Id(n),
				rcRecOfTab.Subscription_Id(n),
				rcRecOfTab.Product_Type_Id(n),
				rcRecOfTab.Distribut_Admin_Id(n),
				rcRecOfTab.Is_Provisional(n),
				rcRecOfTab.Provisional_End_Date(n),
				rcRecOfTab.Provisional_Beg_Date(n),
				rcRecOfTab.Product_Status_Id(n),
				rcRecOfTab.Service_Number(n),
				rcRecOfTab.Creation_Date(n),
				rcRecOfTab.Is_Private(n),
				rcRecOfTab.Retire_Date(n),
				rcRecOfTab.Commercial_Plan_Id(n),
				rcRecOfTab.Person_Id(n),
				rcRecOfTab.Class_Product(n),
				rcRecOfTab.Role_Warranty(n),
				rcRecOfTab.Credit_Limit(n),
				rcRecOfTab.Expiration_Of_Plan(n),
				rcRecOfTab.Included_Id(n),
				rcRecOfTab.Company_Id(n),
				rcRecOfTab.Organizat_Area_Id(n),
				rcRecOfTab.Address_Id(n),
				rcRecOfTab.Permanence(n),
				rcRecOfTab.Subs_Phone_Id(n),
				rcRecOfTab.Category_Id(n),
				rcRecOfTab.Subcategory_Id(n),
				rcRecOfTab.Suspen_Ord_Act_Id(n),
				rcRecOfTab.Collect_Distribute(n)
			);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE DELRECORD( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INULOCK IN NUMBER := 1 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      DELETE
		from PR_product
		where
       		Product_Id=inuProduct_Id;
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
      RCERROR STYPR_PRODUCT;
    BEGIN
      IF INULOCK = 1 THEN
         LOCKBYROWID( IRIROWID, RCDATA );
      END IF;
      DELETE
		from PR_product
		where
			rowid = iriRowID
		returning
			Product_Id
		into
			rcError.Product_Id;
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
   PROCEDURE DELRECORDS( IOTBPR_PRODUCT IN OUT NOCOPY TYTBPR_PRODUCT, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYPR_PRODUCT;
    BEGIN
      FILLRECORDOFTABLES( IOTBPR_PRODUCT, BLUSEROWID );
      IF ( BLUSEROWID ) THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
            DELETE
				from PR_product
				where
					rowid = rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.PRODUCT_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
            DELETE
				from PR_product
				where
		         	Product_Id = rcRecOfTab.Product_Id(n);
      END IF;
    EXCEPTION
      WHEN EX.RECORD_HAVE_CHILDREN THEN
         ERRORS.SETERROR( CNURECORD_HAVE_CHILDREN, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORD( IRCPR_PRODUCT IN STYPR_PRODUCT, INULOCK IN NUMBER := 0 )
    IS
      NUPRODUCT_ID PR_PRODUCT.PRODUCT_ID%TYPE;
    BEGIN
      IF IRCPR_PRODUCT.ROWID IS NOT NULL THEN
         IF INULOCK = 1 THEN
            LOCKBYROWID( IRCPR_PRODUCT.ROWID, RCDATA );
         END IF;
         UPDATE PR_product
			set
				Subscription_Id = ircPR_product.Subscription_Id,
				Product_Type_Id = ircPR_product.Product_Type_Id,
				Distribut_Admin_Id = ircPR_product.Distribut_Admin_Id,
				Is_Provisional = ircPR_product.Is_Provisional,
				Provisional_End_Date = ircPR_product.Provisional_End_Date,
				Provisional_Beg_Date = ircPR_product.Provisional_Beg_Date,
				Product_Status_Id = ircPR_product.Product_Status_Id,
				Service_Number = ircPR_product.Service_Number,
				Creation_Date = ircPR_product.Creation_Date,
				Is_Private = ircPR_product.Is_Private,
				Retire_Date = ircPR_product.Retire_Date,
				Commercial_Plan_Id = ircPR_product.Commercial_Plan_Id,
				Person_Id = ircPR_product.Person_Id,
				Class_Product = ircPR_product.Class_Product,
				Role_Warranty = ircPR_product.Role_Warranty,
				Credit_Limit = ircPR_product.Credit_Limit,
				Expiration_Of_Plan = ircPR_product.Expiration_Of_Plan,
				Included_Id = ircPR_product.Included_Id,
				Company_Id = ircPR_product.Company_Id,
				Organizat_Area_Id = ircPR_product.Organizat_Area_Id,
				Address_Id = ircPR_product.Address_Id,
				Permanence = ircPR_product.Permanence,
				Subs_Phone_Id = ircPR_product.Subs_Phone_Id,
				Category_Id = ircPR_product.Category_Id,
				Subcategory_Id = ircPR_product.Subcategory_Id,
				Suspen_Ord_Act_Id = ircPR_product.Suspen_Ord_Act_Id,
				Collect_Distribute = ircPR_product.Collect_Distribute
			where
				rowid = ircPR_product.rowid
			returning
				Product_Id
			into
				nuProduct_Id;
       ELSE
         IF INULOCK = 1 THEN
            LOCKBYPK( IRCPR_PRODUCT.PRODUCT_ID, RCDATA );
         END IF;
         UPDATE PR_product
			set
				Subscription_Id = ircPR_product.Subscription_Id,
				Product_Type_Id = ircPR_product.Product_Type_Id,
				Distribut_Admin_Id = ircPR_product.Distribut_Admin_Id,
				Is_Provisional = ircPR_product.Is_Provisional,
				Provisional_End_Date = ircPR_product.Provisional_End_Date,
				Provisional_Beg_Date = ircPR_product.Provisional_Beg_Date,
				Product_Status_Id = ircPR_product.Product_Status_Id,
				Service_Number = ircPR_product.Service_Number,
				Creation_Date = ircPR_product.Creation_Date,
				Is_Private = ircPR_product.Is_Private,
				Retire_Date = ircPR_product.Retire_Date,
				Commercial_Plan_Id = ircPR_product.Commercial_Plan_Id,
				Person_Id = ircPR_product.Person_Id,
				Class_Product = ircPR_product.Class_Product,
				Role_Warranty = ircPR_product.Role_Warranty,
				Credit_Limit = ircPR_product.Credit_Limit,
				Expiration_Of_Plan = ircPR_product.Expiration_Of_Plan,
				Included_Id = ircPR_product.Included_Id,
				Company_Id = ircPR_product.Company_Id,
				Organizat_Area_Id = ircPR_product.Organizat_Area_Id,
				Address_Id = ircPR_product.Address_Id,
				Permanence = ircPR_product.Permanence,
				Subs_Phone_Id = ircPR_product.Subs_Phone_Id,
				Category_Id = ircPR_product.Category_Id,
				Subcategory_Id = ircPR_product.Subcategory_Id,
				Suspen_Ord_Act_Id = ircPR_product.Suspen_Ord_Act_Id,
				Collect_Distribute = ircPR_product.Collect_Distribute
			where
				Product_Id = ircPR_product.Product_Id
			returning
				Product_Id
			into
				nuProduct_Id;
      END IF;
      IF NUPRODUCT_ID IS NULL THEN
         RAISE NO_DATA_FOUND;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || FSBPRIMARYKEY( IRCPR_PRODUCT ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORDS( IOTBPR_PRODUCT IN OUT NOCOPY TYTBPR_PRODUCT, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYPR_PRODUCT;
    BEGIN
      FILLRECORDOFTABLES( IOTBPR_PRODUCT, BLUSEROWID );
      IF BLUSEROWID THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
            UPDATE PR_product
				set
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
					Distribut_Admin_Id = rcRecOfTab.Distribut_Admin_Id(n),
					Is_Provisional = rcRecOfTab.Is_Provisional(n),
					Provisional_End_Date = rcRecOfTab.Provisional_End_Date(n),
					Provisional_Beg_Date = rcRecOfTab.Provisional_Beg_Date(n),
					Product_Status_Id = rcRecOfTab.Product_Status_Id(n),
					Service_Number = rcRecOfTab.Service_Number(n),
					Creation_Date = rcRecOfTab.Creation_Date(n),
					Is_Private = rcRecOfTab.Is_Private(n),
					Retire_Date = rcRecOfTab.Retire_Date(n),
					Commercial_Plan_Id = rcRecOfTab.Commercial_Plan_Id(n),
					Person_Id = rcRecOfTab.Person_Id(n),
					Class_Product = rcRecOfTab.Class_Product(n),
					Role_Warranty = rcRecOfTab.Role_Warranty(n),
					Credit_Limit = rcRecOfTab.Credit_Limit(n),
					Expiration_Of_Plan = rcRecOfTab.Expiration_Of_Plan(n),
					Included_Id = rcRecOfTab.Included_Id(n),
					Company_Id = rcRecOfTab.Company_Id(n),
					Organizat_Area_Id = rcRecOfTab.Organizat_Area_Id(n),
					Address_Id = rcRecOfTab.Address_Id(n),
					Permanence = rcRecOfTab.Permanence(n),
					Subs_Phone_Id = rcRecOfTab.Subs_Phone_Id(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Suspen_Ord_Act_Id = rcRecOfTab.Suspen_Ord_Act_Id(n),
					Collect_Distribute = rcRecOfTab.Collect_Distribute(n)
				where
					rowid =  rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.PRODUCT_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBPR_PRODUCT.FIRST..IOTBPR_PRODUCT.LAST
            UPDATE PR_product
				SET
					Subscription_Id = rcRecOfTab.Subscription_Id(n),
					Product_Type_Id = rcRecOfTab.Product_Type_Id(n),
					Distribut_Admin_Id = rcRecOfTab.Distribut_Admin_Id(n),
					Is_Provisional = rcRecOfTab.Is_Provisional(n),
					Provisional_End_Date = rcRecOfTab.Provisional_End_Date(n),
					Provisional_Beg_Date = rcRecOfTab.Provisional_Beg_Date(n),
					Product_Status_Id = rcRecOfTab.Product_Status_Id(n),
					Service_Number = rcRecOfTab.Service_Number(n),
					Creation_Date = rcRecOfTab.Creation_Date(n),
					Is_Private = rcRecOfTab.Is_Private(n),
					Retire_Date = rcRecOfTab.Retire_Date(n),
					Commercial_Plan_Id = rcRecOfTab.Commercial_Plan_Id(n),
					Person_Id = rcRecOfTab.Person_Id(n),
					Class_Product = rcRecOfTab.Class_Product(n),
					Role_Warranty = rcRecOfTab.Role_Warranty(n),
					Credit_Limit = rcRecOfTab.Credit_Limit(n),
					Expiration_Of_Plan = rcRecOfTab.Expiration_Of_Plan(n),
					Included_Id = rcRecOfTab.Included_Id(n),
					Company_Id = rcRecOfTab.Company_Id(n),
					Organizat_Area_Id = rcRecOfTab.Organizat_Area_Id(n),
					Address_Id = rcRecOfTab.Address_Id(n),
					Permanence = rcRecOfTab.Permanence(n),
					Subs_Phone_Id = rcRecOfTab.Subs_Phone_Id(n),
					Category_Id = rcRecOfTab.Category_Id(n),
					Subcategory_Id = rcRecOfTab.Subcategory_Id(n),
					Suspen_Ord_Act_Id = rcRecOfTab.Suspen_Ord_Act_Id(n),
					Collect_Distribute = rcRecOfTab.Collect_Distribute(n)
				where
					Product_Id = rcRecOfTab.Product_Id(n)
;
      END IF;
   END;
   PROCEDURE UPDSUBSCRIPTION_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUSUBSCRIPTION_ID$ IN PR_PRODUCT.SUBSCRIPTION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Subscription_Id = inuSubscription_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SUBSCRIPTION_ID := INUSUBSCRIPTION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRODUCT_TYPE_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUPRODUCT_TYPE_ID$ IN PR_PRODUCT.PRODUCT_TYPE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Product_Type_Id = inuProduct_Type_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRODUCT_TYPE_ID := INUPRODUCT_TYPE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDDISTRIBUT_ADMIN_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUDISTRIBUT_ADMIN_ID$ IN PR_PRODUCT.DISTRIBUT_ADMIN_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Distribut_Admin_Id = inuDistribut_Admin_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.DISTRIBUT_ADMIN_ID := INUDISTRIBUT_ADMIN_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDIS_PROVISIONAL( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBIS_PROVISIONAL$ IN PR_PRODUCT.IS_PROVISIONAL%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Is_Provisional = isbIs_Provisional$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.IS_PROVISIONAL := ISBIS_PROVISIONAL$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPROVISIONAL_END_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTPROVISIONAL_END_DATE$ IN PR_PRODUCT.PROVISIONAL_END_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Provisional_End_Date = idtProvisional_End_Date$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PROVISIONAL_END_DATE := IDTPROVISIONAL_END_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPROVISIONAL_BEG_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTPROVISIONAL_BEG_DATE$ IN PR_PRODUCT.PROVISIONAL_BEG_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Provisional_Beg_Date = idtProvisional_Beg_Date$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PROVISIONAL_BEG_DATE := IDTPROVISIONAL_BEG_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRODUCT_STATUS_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUPRODUCT_STATUS_ID$ IN PR_PRODUCT.PRODUCT_STATUS_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Product_Status_Id = inuProduct_Status_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRODUCT_STATUS_ID := INUPRODUCT_STATUS_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSERVICE_NUMBER( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBSERVICE_NUMBER$ IN PR_PRODUCT.SERVICE_NUMBER%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Service_Number = isbService_Number$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SERVICE_NUMBER := ISBSERVICE_NUMBER$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCREATION_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTCREATION_DATE$ IN PR_PRODUCT.CREATION_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Creation_Date = idtCreation_Date$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CREATION_DATE := IDTCREATION_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDIS_PRIVATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBIS_PRIVATE$ IN PR_PRODUCT.IS_PRIVATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Is_Private = isbIs_Private$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.IS_PRIVATE := ISBIS_PRIVATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRETIRE_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTRETIRE_DATE$ IN PR_PRODUCT.RETIRE_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Retire_Date = idtRetire_Date$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.RETIRE_DATE := IDTRETIRE_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCOMMERCIAL_PLAN_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUCOMMERCIAL_PLAN_ID$ IN PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Commercial_Plan_Id = inuCommercial_Plan_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.COMMERCIAL_PLAN_ID := INUCOMMERCIAL_PLAN_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPERSON_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUPERSON_ID$ IN PR_PRODUCT.PERSON_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Person_Id = inuPerson_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PERSON_ID := INUPERSON_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCLASS_PRODUCT( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBCLASS_PRODUCT$ IN PR_PRODUCT.CLASS_PRODUCT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Class_Product = isbClass_Product$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CLASS_PRODUCT := ISBCLASS_PRODUCT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDROLE_WARRANTY( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBROLE_WARRANTY$ IN PR_PRODUCT.ROLE_WARRANTY%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Role_Warranty = isbRole_Warranty$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ROLE_WARRANTY := ISBROLE_WARRANTY$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCREDIT_LIMIT( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUCREDIT_LIMIT$ IN PR_PRODUCT.CREDIT_LIMIT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Credit_Limit = inuCredit_Limit$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CREDIT_LIMIT := INUCREDIT_LIMIT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDEXPIRATION_OF_PLAN( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, IDTEXPIRATION_OF_PLAN$ IN PR_PRODUCT.EXPIRATION_OF_PLAN%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Expiration_Of_Plan = idtExpiration_Of_Plan$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.EXPIRATION_OF_PLAN := IDTEXPIRATION_OF_PLAN$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDINCLUDED_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUINCLUDED_ID$ IN PR_PRODUCT.INCLUDED_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Included_Id = inuIncluded_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.INCLUDED_ID := INUINCLUDED_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCOMPANY_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUCOMPANY_ID$ IN PR_PRODUCT.COMPANY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Company_Id = inuCompany_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.COMPANY_ID := INUCOMPANY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDORGANIZAT_AREA_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUORGANIZAT_AREA_ID$ IN PR_PRODUCT.ORGANIZAT_AREA_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Organizat_Area_Id = inuOrganizat_Area_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ORGANIZAT_AREA_ID := INUORGANIZAT_AREA_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDADDRESS_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUADDRESS_ID$ IN PR_PRODUCT.ADDRESS_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Address_Id = inuAddress_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ADDRESS_ID := INUADDRESS_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPERMANENCE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUPERMANENCE$ IN PR_PRODUCT.PERMANENCE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Permanence = inuPermanence$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PERMANENCE := INUPERMANENCE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSUBS_PHONE_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUSUBS_PHONE_ID$ IN PR_PRODUCT.SUBS_PHONE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Subs_Phone_Id = inuSubs_Phone_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SUBS_PHONE_ID := INUSUBS_PHONE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCATEGORY_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUCATEGORY_ID$ IN PR_PRODUCT.CATEGORY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Category_Id = inuCategory_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CATEGORY_ID := INUCATEGORY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSUBCATEGORY_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUSUBCATEGORY_ID$ IN PR_PRODUCT.SUBCATEGORY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Subcategory_Id = inuSubcategory_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SUBCATEGORY_ID := INUSUBCATEGORY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSUSPEN_ORD_ACT_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INUSUSPEN_ORD_ACT_ID$ IN PR_PRODUCT.SUSPEN_ORD_ACT_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Suspen_Ord_Act_Id = inuSuspen_Ord_Act_Id$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SUSPEN_ORD_ACT_ID := INUSUSPEN_ORD_ACT_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCOLLECT_DISTRIBUTE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, ISBCOLLECT_DISTRIBUTE$ IN PR_PRODUCT.COLLECT_DISTRIBUTE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUPRODUCT_ID, RCDATA );
      END IF;
      UPDATE PR_product
		set
			Collect_Distribute = isbCollect_Distribute$
		where
			Product_Id = inuProduct_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.COLLECT_DISTRIBUTE := ISBCOLLECT_DISTRIBUTE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FNUGETPRODUCT_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PRODUCT_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PRODUCT_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETSUBSCRIPTION_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.SUBSCRIPTION_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.SUBSCRIPTION_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETPRODUCT_TYPE_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PRODUCT_TYPE_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PRODUCT_TYPE_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETDISTRIBUT_ADMIN_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.DISTRIBUT_ADMIN_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.DISTRIBUT_ADMIN_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FSBGETIS_PROVISIONAL( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.IS_PROVISIONAL%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.IS_PROVISIONAL );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.IS_PROVISIONAL );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETPROVISIONAL_END_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PROVISIONAL_END_DATE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PROVISIONAL_END_DATE );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.PROVISIONAL_END_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETPROVISIONAL_BEG_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PROVISIONAL_BEG_DATE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PROVISIONAL_BEG_DATE );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.PROVISIONAL_BEG_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPRODUCT_STATUS_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PRODUCT_STATUS_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PRODUCT_STATUS_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.PRODUCT_STATUS_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETSERVICE_NUMBER( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.SERVICE_NUMBER%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.SERVICE_NUMBER );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FDTGETCREATION_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.CREATION_DATE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.CREATION_DATE );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.CREATION_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETIS_PRIVATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.IS_PRIVATE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.IS_PRIVATE );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.IS_PRIVATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETRETIRE_DATE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.RETIRE_DATE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.RETIRE_DATE );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.RETIRE_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCOMMERCIAL_PLAN_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.COMMERCIAL_PLAN_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.COMMERCIAL_PLAN_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETPERSON_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PERSON_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PERSON_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.PERSON_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETCLASS_PRODUCT( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.CLASS_PRODUCT%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.CLASS_PRODUCT );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.CLASS_PRODUCT );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETROLE_WARRANTY( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.ROLE_WARRANTY%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.ROLE_WARRANTY );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.ROLE_WARRANTY );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCREDIT_LIMIT( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.CREDIT_LIMIT%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.CREDIT_LIMIT );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FDTGETEXPIRATION_OF_PLAN( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.EXPIRATION_OF_PLAN%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.EXPIRATION_OF_PLAN );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.EXPIRATION_OF_PLAN );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETINCLUDED_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.INCLUDED_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.INCLUDED_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.INCLUDED_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCOMPANY_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.COMPANY_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.COMPANY_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETORGANIZAT_AREA_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.ORGANIZAT_AREA_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.ORGANIZAT_AREA_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETADDRESS_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.ADDRESS_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.ADDRESS_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.ADDRESS_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPERMANENCE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.PERMANENCE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.PERMANENCE );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETSUBS_PHONE_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.SUBS_PHONE_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.SUBS_PHONE_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.SUBS_PHONE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCATEGORY_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.CATEGORY_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.CATEGORY_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETSUBCATEGORY_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.SUBCATEGORY_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.SUBCATEGORY_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
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
   FUNCTION FNUGETSUSPEN_ORD_ACT_ID( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.SUSPEN_ORD_ACT_ID%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.SUSPEN_ORD_ACT_ID );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.SUSPEN_ORD_ACT_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETCOLLECT_DISTRIBUTE( INUPRODUCT_ID IN PR_PRODUCT.PRODUCT_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN PR_PRODUCT.COLLECT_DISTRIBUTE%TYPE
    IS
      RCERROR STYPR_PRODUCT;
    BEGIN
      RCERROR.PRODUCT_ID := INUPRODUCT_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUPRODUCT_ID ) THEN
         RETURN ( RCDATA.COLLECT_DISTRIBUTE );
      END IF;
      LOAD( INUPRODUCT_ID );
      RETURN ( RCDATA.COLLECT_DISTRIBUTE );
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
END DAPR_PRODUCT;
/


