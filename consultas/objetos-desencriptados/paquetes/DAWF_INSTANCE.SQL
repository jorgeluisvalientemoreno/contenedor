
CREATE OR REPLACE PACKAGE BODY DAWF_INSTANCE IS
   CNURECORD_NOT_EXIST CONSTANT NUMBER( 1 ) := 1;
   CNURECORD_ALREADY_EXIST CONSTANT NUMBER( 1 ) := 2;
   CNUAPPTABLEBUSSY CONSTANT NUMBER( 4 ) := 6951;
   CNUINS_PK_NULL CONSTANT NUMBER( 4 ) := 1682;
   CNURECORD_HAVE_CHILDREN CONSTANT NUMBER( 4 ) := -2292;
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO175100';
   CSBTABLEPARAMETER CONSTANT VARCHAR2( 30 ) := 'WF_INSTANCE';
   CNUGEENTITYID CONSTANT VARCHAR2( 30 ) := 3366;
   CURSOR CULOCKRCBYPK( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE ) IS
SELECT WF_instance.*,WF_instance.rowid 
		FROM WF_instance
		WHERE  Instance_Id = inuInstance_Id
		FOR UPDATE NOWAIT;
   CURSOR CULOCKRCBYROWID( IRIROWID IN VARCHAR2 ) IS
SELECT WF_instance.*,WF_instance.rowid 
		FROM WF_instance
		WHERE 
			rowId = irirowid
		FOR UPDATE NOWAIT;
   TYPE TYRFWF_INSTANCE IS REF CURSOR;
   RCRECOFTAB TYRCWF_INSTANCE;
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
   FUNCTION FSBPRIMARYKEY( RCI IN STYWF_INSTANCE := RCDATA )
    RETURN VARCHAR2
    IS
      SBPK VARCHAR2( 500 );
    BEGIN
      SBPK := '[';
      SBPK := SBPK || UT_CONVERT.FSBTOCHAR( RCI.INSTANCE_ID );
      SBPK := SBPK || ']';
      RETURN SBPK;
   END;
   PROCEDURE LOCKBYPK( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ORCWF_INSTANCE OUT STYWF_INSTANCE )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      OPEN CULOCKRCBYPK( INUINSTANCE_ID );
      FETCH CULOCKRCBYPK
         INTO ORCWF_INSTANCE;
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
   PROCEDURE LOCKBYROWID( IRIROWID IN VARCHAR2, ORCWF_INSTANCE OUT STYWF_INSTANCE )
    IS
    BEGIN
      OPEN CULOCKRCBYROWID( IRIROWID );
      FETCH CULOCKRCBYROWID
         INTO ORCWF_INSTANCE;
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
   PROCEDURE DELRECORDOFTABLES( ITBWF_INSTANCE IN OUT NOCOPY TYTBWF_INSTANCE )
    IS
    BEGIN
      RCRECOFTAB.INSTANCE_ID.DELETE;
      RCRECOFTAB.DESCRIPTION.DELETE;
      RCRECOFTAB.PARENT_ID.DELETE;
      RCRECOFTAB.ORIGINAL_TASK.DELETE;
      RCRECOFTAB.PLAN_ID.DELETE;
      RCRECOFTAB.UNIT_ID.DELETE;
      RCRECOFTAB.STATUS_ID.DELETE;
      RCRECOFTAB.PREVIOUS_STATUS_ID.DELETE;
      RCRECOFTAB.ONLINE_EXEC_ID.DELETE;
      RCRECOFTAB.ACTION_ID.DELETE;
      RCRECOFTAB.PRE_EXPRESSION_ID.DELETE;
      RCRECOFTAB.POS_EXPRESSION_ID.DELETE;
      RCRECOFTAB.QUANTITY.DELETE;
      RCRECOFTAB.INITIAL_DATE.DELETE;
      RCRECOFTAB.FINAL_DATE.DELETE;
      RCRECOFTAB.SINCRONIC_TIMEOUT.DELETE;
      RCRECOFTAB.ASINCRONIC_TIMEOUT.DELETE;
      RCRECOFTAB.LAYER_ID.DELETE;
      RCRECOFTAB.EXTERNAL_ID.DELETE;
      RCRECOFTAB.GEOMETRY.DELETE;
      RCRECOFTAB.TRY_NUMBER.DELETE;
      RCRECOFTAB.MULTI_INSTANCE.DELETE;
      RCRECOFTAB.FUNCTION_TYPE.DELETE;
      RCRECOFTAB.NODE_TYPE_ID.DELETE;
      RCRECOFTAB.MODULE_ID.DELETE;
      RCRECOFTAB.IS_COUNTABLE.DELETE;
      RCRECOFTAB.TOTAL_TIME.DELETE;
      RCRECOFTAB.PARENT_EXTERNAL_ID.DELETE;
      RCRECOFTAB.ENTITY_ID.DELETE;
      RCRECOFTAB.PAR_EXT_ENTITY_ID.DELETE;
      RCRECOFTAB.GROUP_ID.DELETE;
      RCRECOFTAB.MIN_GROUP_SIZE.DELETE;
      RCRECOFTAB.UNIT_TYPE_ID.DELETE;
      RCRECOFTAB.EXECUTION_ORDER.DELETE;
      RCRECOFTAB.ANNULATION_ORDER.DELETE;
      RCRECOFTAB.NOTIFICATION_ID.DELETE;
      RCRECOFTAB.EXECUTION_ID.DELETE;
      RCRECOFTAB.PREVIOUS_INSTANCE_ID.DELETE;
      RCRECOFTAB.ROW_ID.DELETE;
   END;
   PROCEDURE FILLRECORDOFTABLES( ITBWF_INSTANCE IN OUT NOCOPY TYTBWF_INSTANCE, OBLUSEROWID OUT BOOLEAN )
    IS
    BEGIN
      DELRECORDOFTABLES( ITBWF_INSTANCE );
      FOR N IN ITBWF_INSTANCE.FIRST..ITBWF_INSTANCE.LAST
       LOOP
         RCRECOFTAB.INSTANCE_ID( N ) := ITBWF_INSTANCE( N ).INSTANCE_ID;
         RCRECOFTAB.DESCRIPTION( N ) := ITBWF_INSTANCE( N ).DESCRIPTION;
         RCRECOFTAB.PARENT_ID( N ) := ITBWF_INSTANCE( N ).PARENT_ID;
         RCRECOFTAB.ORIGINAL_TASK( N ) := ITBWF_INSTANCE( N ).ORIGINAL_TASK;
         RCRECOFTAB.PLAN_ID( N ) := ITBWF_INSTANCE( N ).PLAN_ID;
         RCRECOFTAB.UNIT_ID( N ) := ITBWF_INSTANCE( N ).UNIT_ID;
         RCRECOFTAB.STATUS_ID( N ) := ITBWF_INSTANCE( N ).STATUS_ID;
         RCRECOFTAB.PREVIOUS_STATUS_ID( N ) := ITBWF_INSTANCE( N ).PREVIOUS_STATUS_ID;
         RCRECOFTAB.ONLINE_EXEC_ID( N ) := ITBWF_INSTANCE( N ).ONLINE_EXEC_ID;
         RCRECOFTAB.ACTION_ID( N ) := ITBWF_INSTANCE( N ).ACTION_ID;
         RCRECOFTAB.PRE_EXPRESSION_ID( N ) := ITBWF_INSTANCE( N ).PRE_EXPRESSION_ID;
         RCRECOFTAB.POS_EXPRESSION_ID( N ) := ITBWF_INSTANCE( N ).POS_EXPRESSION_ID;
         RCRECOFTAB.QUANTITY( N ) := ITBWF_INSTANCE( N ).QUANTITY;
         RCRECOFTAB.INITIAL_DATE( N ) := ITBWF_INSTANCE( N ).INITIAL_DATE;
         RCRECOFTAB.FINAL_DATE( N ) := ITBWF_INSTANCE( N ).FINAL_DATE;
         RCRECOFTAB.SINCRONIC_TIMEOUT( N ) := ITBWF_INSTANCE( N ).SINCRONIC_TIMEOUT;
         RCRECOFTAB.ASINCRONIC_TIMEOUT( N ) := ITBWF_INSTANCE( N ).ASINCRONIC_TIMEOUT;
         RCRECOFTAB.LAYER_ID( N ) := ITBWF_INSTANCE( N ).LAYER_ID;
         RCRECOFTAB.EXTERNAL_ID( N ) := ITBWF_INSTANCE( N ).EXTERNAL_ID;
         RCRECOFTAB.GEOMETRY( N ) := ITBWF_INSTANCE( N ).GEOMETRY;
         RCRECOFTAB.TRY_NUMBER( N ) := ITBWF_INSTANCE( N ).TRY_NUMBER;
         RCRECOFTAB.MULTI_INSTANCE( N ) := ITBWF_INSTANCE( N ).MULTI_INSTANCE;
         RCRECOFTAB.FUNCTION_TYPE( N ) := ITBWF_INSTANCE( N ).FUNCTION_TYPE;
         RCRECOFTAB.NODE_TYPE_ID( N ) := ITBWF_INSTANCE( N ).NODE_TYPE_ID;
         RCRECOFTAB.MODULE_ID( N ) := ITBWF_INSTANCE( N ).MODULE_ID;
         RCRECOFTAB.IS_COUNTABLE( N ) := ITBWF_INSTANCE( N ).IS_COUNTABLE;
         RCRECOFTAB.TOTAL_TIME( N ) := ITBWF_INSTANCE( N ).TOTAL_TIME;
         RCRECOFTAB.PARENT_EXTERNAL_ID( N ) := ITBWF_INSTANCE( N ).PARENT_EXTERNAL_ID;
         RCRECOFTAB.ENTITY_ID( N ) := ITBWF_INSTANCE( N ).ENTITY_ID;
         RCRECOFTAB.PAR_EXT_ENTITY_ID( N ) := ITBWF_INSTANCE( N ).PAR_EXT_ENTITY_ID;
         RCRECOFTAB.GROUP_ID( N ) := ITBWF_INSTANCE( N ).GROUP_ID;
         RCRECOFTAB.MIN_GROUP_SIZE( N ) := ITBWF_INSTANCE( N ).MIN_GROUP_SIZE;
         RCRECOFTAB.UNIT_TYPE_ID( N ) := ITBWF_INSTANCE( N ).UNIT_TYPE_ID;
         RCRECOFTAB.EXECUTION_ORDER( N ) := ITBWF_INSTANCE( N ).EXECUTION_ORDER;
         RCRECOFTAB.ANNULATION_ORDER( N ) := ITBWF_INSTANCE( N ).ANNULATION_ORDER;
         RCRECOFTAB.NOTIFICATION_ID( N ) := ITBWF_INSTANCE( N ).NOTIFICATION_ID;
         RCRECOFTAB.EXECUTION_ID( N ) := ITBWF_INSTANCE( N ).EXECUTION_ID;
         RCRECOFTAB.PREVIOUS_INSTANCE_ID( N ) := ITBWF_INSTANCE( N ).PREVIOUS_INSTANCE_ID;
         RCRECOFTAB.ROW_ID( N ) := ITBWF_INSTANCE( N ).ROWID;
         OBLUSEROWID := RCRECOFTAB.ROW_ID( N ) IS NOT NULL;
      END LOOP;
   END;
   PROCEDURE LOAD( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    IS
      RCRECORDNULL CURECORD%ROWTYPE;
    BEGIN
      IF CURECORD%ISOPEN THEN
         CLOSE CURECORD;
      END IF;
      OPEN CURECORD( INUINSTANCE_ID );
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
   FUNCTION FBLALREADYLOADED( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      IF ( INUINSTANCE_ID = RCDATA.INSTANCE_ID ) THEN
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
   FUNCTION FBLEXIST( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      LOAD( INUINSTANCE_ID );
      RETURN ( TRUE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN ( FALSE );
   END;
   PROCEDURE ACCKEY( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      LOAD( INUINSTANCE_ID );
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
   PROCEDURE VALDUPLICATE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    IS
    BEGIN
      LOAD( INUINSTANCE_ID );
      ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY );
      RAISE EX.CONTROLLED_ERROR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
   END;
   PROCEDURE GETRECORD( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ORCRECORD OUT NOCOPY STYWF_INSTANCE )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      LOAD( INUINSTANCE_ID );
      ORCRECORD := RCDATA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRECORD( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    RETURN STYWF_INSTANCE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE )
    RETURN STYWF_INSTANCE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA
    RETURN STYWF_INSTANCE
    IS
    BEGIN
      RETURN ( RCDATA );
   END;
   PROCEDURE GETRECORDS( ISBQUERY IN VARCHAR2, OTBRESULT OUT NOCOPY TYTBWF_INSTANCE )
    IS
      RFWF_INSTANCE TYRFWF_INSTANCE;
      N NUMBER( 4 ) := 1;
      SBFULLQUERY VARCHAR2( 32000 ) := 'SELECT 
		            WF_instance.Instance_Id,
		            WF_instance.Description,
		            WF_instance.Parent_Id,
		            WF_instance.Original_Task,
		            WF_instance.Plan_Id,
		            WF_instance.Unit_Id,
		            WF_instance.Status_Id,
		            WF_instance.Previous_Status_Id,
		            WF_instance.Online_Exec_Id,
		            WF_instance.Action_Id,
		            WF_instance.Pre_Expression_Id,
		            WF_instance.Pos_Expression_Id,
		            WF_instance.Quantity,
		            WF_instance.Initial_Date,
		            WF_instance.Final_Date,
		            WF_instance.Sincronic_Timeout,
		            WF_instance.Asincronic_Timeout,
		            WF_instance.Layer_Id,
		            WF_instance.External_Id,
		            WF_instance.Geometry,
		            WF_instance.Try_Number,
		            WF_instance.Multi_Instance,
		            WF_instance.Function_Type,
		            WF_instance.Node_Type_Id,
		            WF_instance.Module_Id,
		            WF_instance.Is_Countable,
		            WF_instance.Total_Time,
		            WF_instance.Parent_External_Id,
		            WF_instance.Entity_Id,
		            WF_instance.Par_Ext_Entity_Id,
		            WF_instance.Group_Id,
		            WF_instance.Min_Group_Size,
		            WF_instance.Unit_Type_Id,
		            WF_instance.Execution_Order,
		            WF_instance.Annulation_Order,
		            WF_instance.Notification_Id,
		            WF_instance.Execution_Id,
		            WF_instance.Previous_Instance_Id,
		            WF_instance.rowid
                FROM WF_instance';
      NUMAXTBRECORDS NUMBER( 5 ) := GE_BOPARAMETER.FNUGET( 'MAXREGSQUERY' );
    BEGIN
      OTBRESULT.DELETE;
      IF ISBQUERY IS NOT NULL AND LENGTH( ISBQUERY ) > 0 THEN
         SBFULLQUERY := SBFULLQUERY || ' WHERE ' || ISBQUERY;
      END IF;
      OPEN RFWF_INSTANCE
           FOR SBFULLQUERY;
      FETCH RFWF_INSTANCE
         BULK COLLECT INTO OTBRESULT;
      CLOSE RFWF_INSTANCE;
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
		            WF_instance.Instance_Id,
		            WF_instance.Description,
		            WF_instance.Parent_Id,
		            WF_instance.Original_Task,
		            WF_instance.Plan_Id,
		            WF_instance.Unit_Id,
		            WF_instance.Status_Id,
		            WF_instance.Previous_Status_Id,
		            WF_instance.Online_Exec_Id,
		            WF_instance.Action_Id,
		            WF_instance.Pre_Expression_Id,
		            WF_instance.Pos_Expression_Id,
		            WF_instance.Quantity,
		            WF_instance.Initial_Date,
		            WF_instance.Final_Date,
		            WF_instance.Sincronic_Timeout,
		            WF_instance.Asincronic_Timeout,
		            WF_instance.Layer_Id,
		            WF_instance.External_Id,
		            WF_instance.Geometry,
		            WF_instance.Try_Number,
		            WF_instance.Multi_Instance,
		            WF_instance.Function_Type,
		            WF_instance.Node_Type_Id,
		            WF_instance.Module_Id,
		            WF_instance.Is_Countable,
		            WF_instance.Total_Time,
		            WF_instance.Parent_External_Id,
		            WF_instance.Entity_Id,
		            WF_instance.Par_Ext_Entity_Id,
		            WF_instance.Group_Id,
		            WF_instance.Min_Group_Size,
		            WF_instance.Unit_Type_Id,
		            WF_instance.Execution_Order,
		            WF_instance.Annulation_Order,
		            WF_instance.Notification_Id,
		            WF_instance.Execution_Id,
		            WF_instance.Previous_Instance_Id,
		            WF_instance.rowid
                FROM WF_instance';
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
   PROCEDURE INSRECORD( IRCWF_INSTANCE IN STYWF_INSTANCE )
    IS
      RIROWID VARCHAR2( 200 );
    BEGIN
      INSRECORD( IRCWF_INSTANCE, RIROWID );
   END;
   PROCEDURE INSRECORD( IRCWF_INSTANCE IN STYWF_INSTANCE, ORIROWID OUT VARCHAR2 )
    IS
    BEGIN
      IF IRCWF_INSTANCE.INSTANCE_ID IS NULL THEN
         ERRORS.SETERROR( CNUINS_PK_NULL, FSBGETMESSAGEDESCRIPTION || '|Instance_Id' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      INSERT into WF_instance
		(
			Instance_Id,
			Description,
			Parent_Id,
			Original_Task,
			Plan_Id,
			Unit_Id,
			Status_Id,
			Previous_Status_Id,
			Online_Exec_Id,
			Action_Id,
			Pre_Expression_Id,
			Pos_Expression_Id,
			Quantity,
			Initial_Date,
			Final_Date,
			Sincronic_Timeout,
			Asincronic_Timeout,
			Layer_Id,
			External_Id,
			Geometry,
			Try_Number,
			Multi_Instance,
			Function_Type,
			Node_Type_Id,
			Module_Id,
			Is_Countable,
			Total_Time,
			Parent_External_Id,
			Entity_Id,
			Par_Ext_Entity_Id,
			Group_Id,
			Min_Group_Size,
			Unit_Type_Id,
			Execution_Order,
			Annulation_Order,
			Notification_Id,
			Execution_Id,
			Previous_Instance_Id
		)
		values
		(
			ircWF_instance.Instance_Id,
			ircWF_instance.Description,
			ircWF_instance.Parent_Id,
			ircWF_instance.Original_Task,
			ircWF_instance.Plan_Id,
			ircWF_instance.Unit_Id,
			ircWF_instance.Status_Id,
			ircWF_instance.Previous_Status_Id,
			ircWF_instance.Online_Exec_Id,
			ircWF_instance.Action_Id,
			ircWF_instance.Pre_Expression_Id,
			ircWF_instance.Pos_Expression_Id,
			ircWF_instance.Quantity,
			ircWF_instance.Initial_Date,
			ircWF_instance.Final_Date,
			ircWF_instance.Sincronic_Timeout,
			ircWF_instance.Asincronic_Timeout,
			ircWF_instance.Layer_Id,
			ircWF_instance.External_Id,
			ircWF_instance.Geometry,
			ircWF_instance.Try_Number,
			ircWF_instance.Multi_Instance,
			ircWF_instance.Function_Type,
			ircWF_instance.Node_Type_Id,
			ircWF_instance.Module_Id,
			ircWF_instance.Is_Countable,
			ircWF_instance.Total_Time,
			ircWF_instance.Parent_External_Id,
			ircWF_instance.Entity_Id,
			ircWF_instance.Par_Ext_Entity_Id,
			ircWF_instance.Group_Id,
			ircWF_instance.Min_Group_Size,
			ircWF_instance.Unit_Type_Id,
			ircWF_instance.Execution_Order,
			ircWF_instance.Annulation_Order,
			ircWF_instance.Notification_Id,
			ircWF_instance.Execution_Id,
			ircWF_instance.Previous_Instance_Id
		)
            returning
			rowid
		into
			orirowid;
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( IRCWF_INSTANCE ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSRECORDS( IOTBWF_INSTANCE IN OUT NOCOPY TYTBWF_INSTANCE )
    IS
      BLUSEROWID BOOLEAN;
    BEGIN
      FILLRECORDOFTABLES( IOTBWF_INSTANCE, BLUSEROWID );
      FORALL N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
         INSERT into WF_instance
			(
				Instance_Id,
				Description,
				Parent_Id,
				Original_Task,
				Plan_Id,
				Unit_Id,
				Status_Id,
				Previous_Status_Id,
				Online_Exec_Id,
				Action_Id,
				Pre_Expression_Id,
				Pos_Expression_Id,
				Quantity,
				Initial_Date,
				Final_Date,
				Sincronic_Timeout,
				Asincronic_Timeout,
				Layer_Id,
				External_Id,
				Geometry,
				Try_Number,
				Multi_Instance,
				Function_Type,
				Node_Type_Id,
				Module_Id,
				Is_Countable,
				Total_Time,
				Parent_External_Id,
				Entity_Id,
				Par_Ext_Entity_Id,
				Group_Id,
				Min_Group_Size,
				Unit_Type_Id,
				Execution_Order,
				Annulation_Order,
				Notification_Id,
				Execution_Id,
				Previous_Instance_Id
			)
			values
			(
				rcRecOfTab.Instance_Id(n),
				rcRecOfTab.Description(n),
				rcRecOfTab.Parent_Id(n),
				rcRecOfTab.Original_Task(n),
				rcRecOfTab.Plan_Id(n),
				rcRecOfTab.Unit_Id(n),
				rcRecOfTab.Status_Id(n),
				rcRecOfTab.Previous_Status_Id(n),
				rcRecOfTab.Online_Exec_Id(n),
				rcRecOfTab.Action_Id(n),
				rcRecOfTab.Pre_Expression_Id(n),
				rcRecOfTab.Pos_Expression_Id(n),
				rcRecOfTab.Quantity(n),
				rcRecOfTab.Initial_Date(n),
				rcRecOfTab.Final_Date(n),
				rcRecOfTab.Sincronic_Timeout(n),
				rcRecOfTab.Asincronic_Timeout(n),
				rcRecOfTab.Layer_Id(n),
				rcRecOfTab.External_Id(n),
				rcRecOfTab.Geometry(n),
				rcRecOfTab.Try_Number(n),
				rcRecOfTab.Multi_Instance(n),
				rcRecOfTab.Function_Type(n),
				rcRecOfTab.Node_Type_Id(n),
				rcRecOfTab.Module_Id(n),
				rcRecOfTab.Is_Countable(n),
				rcRecOfTab.Total_Time(n),
				rcRecOfTab.Parent_External_Id(n),
				rcRecOfTab.Entity_Id(n),
				rcRecOfTab.Par_Ext_Entity_Id(n),
				rcRecOfTab.Group_Id(n),
				rcRecOfTab.Min_Group_Size(n),
				rcRecOfTab.Unit_Type_Id(n),
				rcRecOfTab.Execution_Order(n),
				rcRecOfTab.Annulation_Order(n),
				rcRecOfTab.Notification_Id(n),
				rcRecOfTab.Execution_Id(n),
				rcRecOfTab.Previous_Instance_Id(n)
			);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE DELRECORD( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INULOCK IN NUMBER := 1 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      DELETE
		from WF_instance
		where
       		Instance_Id=inuInstance_Id;
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
      RCERROR STYWF_INSTANCE;
    BEGIN
      IF INULOCK = 1 THEN
         LOCKBYROWID( IRIROWID, RCDATA );
      END IF;
      DELETE
		from WF_instance
		where
			rowid = iriRowID
		returning
			Instance_Id
		into
			rcError.Instance_Id;
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
   PROCEDURE DELRECORDS( IOTBWF_INSTANCE IN OUT NOCOPY TYTBWF_INSTANCE, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYWF_INSTANCE;
    BEGIN
      FILLRECORDOFTABLES( IOTBWF_INSTANCE, BLUSEROWID );
      IF ( BLUSEROWID ) THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
            DELETE
				from WF_instance
				where
					rowid = rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.INSTANCE_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
            DELETE
				from WF_instance
				where
		         	Instance_Id = rcRecOfTab.Instance_Id(n);
      END IF;
    EXCEPTION
      WHEN EX.RECORD_HAVE_CHILDREN THEN
         ERRORS.SETERROR( CNURECORD_HAVE_CHILDREN, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORD( IRCWF_INSTANCE IN STYWF_INSTANCE, INULOCK IN NUMBER := 0 )
    IS
      NUINSTANCE_ID WF_INSTANCE.INSTANCE_ID%TYPE;
    BEGIN
      IF IRCWF_INSTANCE.ROWID IS NOT NULL THEN
         IF INULOCK = 1 THEN
            LOCKBYROWID( IRCWF_INSTANCE.ROWID, RCDATA );
         END IF;
         UPDATE WF_instance
			set
				Description = ircWF_instance.Description,
				Parent_Id = ircWF_instance.Parent_Id,
				Original_Task = ircWF_instance.Original_Task,
				Plan_Id = ircWF_instance.Plan_Id,
				Unit_Id = ircWF_instance.Unit_Id,
				Status_Id = ircWF_instance.Status_Id,
				Previous_Status_Id = ircWF_instance.Previous_Status_Id,
				Online_Exec_Id = ircWF_instance.Online_Exec_Id,
				Action_Id = ircWF_instance.Action_Id,
				Pre_Expression_Id = ircWF_instance.Pre_Expression_Id,
				Pos_Expression_Id = ircWF_instance.Pos_Expression_Id,
				Quantity = ircWF_instance.Quantity,
				Initial_Date = ircWF_instance.Initial_Date,
				Final_Date = ircWF_instance.Final_Date,
				Sincronic_Timeout = ircWF_instance.Sincronic_Timeout,
				Asincronic_Timeout = ircWF_instance.Asincronic_Timeout,
				Layer_Id = ircWF_instance.Layer_Id,
				External_Id = ircWF_instance.External_Id,
				Geometry = ircWF_instance.Geometry,
				Try_Number = ircWF_instance.Try_Number,
				Multi_Instance = ircWF_instance.Multi_Instance,
				Function_Type = ircWF_instance.Function_Type,
				Node_Type_Id = ircWF_instance.Node_Type_Id,
				Module_Id = ircWF_instance.Module_Id,
				Is_Countable = ircWF_instance.Is_Countable,
				Total_Time = ircWF_instance.Total_Time,
				Parent_External_Id = ircWF_instance.Parent_External_Id,
				Entity_Id = ircWF_instance.Entity_Id,
				Par_Ext_Entity_Id = ircWF_instance.Par_Ext_Entity_Id,
				Group_Id = ircWF_instance.Group_Id,
				Min_Group_Size = ircWF_instance.Min_Group_Size,
				Unit_Type_Id = ircWF_instance.Unit_Type_Id,
				Execution_Order = ircWF_instance.Execution_Order,
				Annulation_Order = ircWF_instance.Annulation_Order,
				Notification_Id = ircWF_instance.Notification_Id,
				Execution_Id = ircWF_instance.Execution_Id,
				Previous_Instance_Id = ircWF_instance.Previous_Instance_Id
			where
				rowid = ircWF_instance.rowid
			returning
				Instance_Id
			into
				nuInstance_Id;
       ELSE
         IF INULOCK = 1 THEN
            LOCKBYPK( IRCWF_INSTANCE.INSTANCE_ID, RCDATA );
         END IF;
         UPDATE WF_instance
			set
				Description = ircWF_instance.Description,
				Parent_Id = ircWF_instance.Parent_Id,
				Original_Task = ircWF_instance.Original_Task,
				Plan_Id = ircWF_instance.Plan_Id,
				Unit_Id = ircWF_instance.Unit_Id,
				Status_Id = ircWF_instance.Status_Id,
				Previous_Status_Id = ircWF_instance.Previous_Status_Id,
				Online_Exec_Id = ircWF_instance.Online_Exec_Id,
				Action_Id = ircWF_instance.Action_Id,
				Pre_Expression_Id = ircWF_instance.Pre_Expression_Id,
				Pos_Expression_Id = ircWF_instance.Pos_Expression_Id,
				Quantity = ircWF_instance.Quantity,
				Initial_Date = ircWF_instance.Initial_Date,
				Final_Date = ircWF_instance.Final_Date,
				Sincronic_Timeout = ircWF_instance.Sincronic_Timeout,
				Asincronic_Timeout = ircWF_instance.Asincronic_Timeout,
				Layer_Id = ircWF_instance.Layer_Id,
				External_Id = ircWF_instance.External_Id,
				Geometry = ircWF_instance.Geometry,
				Try_Number = ircWF_instance.Try_Number,
				Multi_Instance = ircWF_instance.Multi_Instance,
				Function_Type = ircWF_instance.Function_Type,
				Node_Type_Id = ircWF_instance.Node_Type_Id,
				Module_Id = ircWF_instance.Module_Id,
				Is_Countable = ircWF_instance.Is_Countable,
				Total_Time = ircWF_instance.Total_Time,
				Parent_External_Id = ircWF_instance.Parent_External_Id,
				Entity_Id = ircWF_instance.Entity_Id,
				Par_Ext_Entity_Id = ircWF_instance.Par_Ext_Entity_Id,
				Group_Id = ircWF_instance.Group_Id,
				Min_Group_Size = ircWF_instance.Min_Group_Size,
				Unit_Type_Id = ircWF_instance.Unit_Type_Id,
				Execution_Order = ircWF_instance.Execution_Order,
				Annulation_Order = ircWF_instance.Annulation_Order,
				Notification_Id = ircWF_instance.Notification_Id,
				Execution_Id = ircWF_instance.Execution_Id,
				Previous_Instance_Id = ircWF_instance.Previous_Instance_Id
			where
				Instance_Id = ircWF_instance.Instance_Id
			returning
				Instance_Id
			into
				nuInstance_Id;
      END IF;
      IF NUINSTANCE_ID IS NULL THEN
         RAISE NO_DATA_FOUND;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || FSBPRIMARYKEY( IRCWF_INSTANCE ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORDS( IOTBWF_INSTANCE IN OUT NOCOPY TYTBWF_INSTANCE, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYWF_INSTANCE;
    BEGIN
      FILLRECORDOFTABLES( IOTBWF_INSTANCE, BLUSEROWID );
      IF BLUSEROWID THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
            UPDATE WF_instance
				set
					Description = rcRecOfTab.Description(n),
					Parent_Id = rcRecOfTab.Parent_Id(n),
					Original_Task = rcRecOfTab.Original_Task(n),
					Plan_Id = rcRecOfTab.Plan_Id(n),
					Unit_Id = rcRecOfTab.Unit_Id(n),
					Status_Id = rcRecOfTab.Status_Id(n),
					Previous_Status_Id = rcRecOfTab.Previous_Status_Id(n),
					Online_Exec_Id = rcRecOfTab.Online_Exec_Id(n),
					Action_Id = rcRecOfTab.Action_Id(n),
					Pre_Expression_Id = rcRecOfTab.Pre_Expression_Id(n),
					Pos_Expression_Id = rcRecOfTab.Pos_Expression_Id(n),
					Quantity = rcRecOfTab.Quantity(n),
					Initial_Date = rcRecOfTab.Initial_Date(n),
					Final_Date = rcRecOfTab.Final_Date(n),
					Sincronic_Timeout = rcRecOfTab.Sincronic_Timeout(n),
					Asincronic_Timeout = rcRecOfTab.Asincronic_Timeout(n),
					Layer_Id = rcRecOfTab.Layer_Id(n),
					External_Id = rcRecOfTab.External_Id(n),
					Geometry = rcRecOfTab.Geometry(n),
					Try_Number = rcRecOfTab.Try_Number(n),
					Multi_Instance = rcRecOfTab.Multi_Instance(n),
					Function_Type = rcRecOfTab.Function_Type(n),
					Node_Type_Id = rcRecOfTab.Node_Type_Id(n),
					Module_Id = rcRecOfTab.Module_Id(n),
					Is_Countable = rcRecOfTab.Is_Countable(n),
					Total_Time = rcRecOfTab.Total_Time(n),
					Parent_External_Id = rcRecOfTab.Parent_External_Id(n),
					Entity_Id = rcRecOfTab.Entity_Id(n),
					Par_Ext_Entity_Id = rcRecOfTab.Par_Ext_Entity_Id(n),
					Group_Id = rcRecOfTab.Group_Id(n),
					Min_Group_Size = rcRecOfTab.Min_Group_Size(n),
					Unit_Type_Id = rcRecOfTab.Unit_Type_Id(n),
					Execution_Order = rcRecOfTab.Execution_Order(n),
					Annulation_Order = rcRecOfTab.Annulation_Order(n),
					Notification_Id = rcRecOfTab.Notification_Id(n),
					Execution_Id = rcRecOfTab.Execution_Id(n),
					Previous_Instance_Id = rcRecOfTab.Previous_Instance_Id(n)
				where
					rowid =  rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.INSTANCE_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBWF_INSTANCE.FIRST..IOTBWF_INSTANCE.LAST
            UPDATE WF_instance
				SET
					Description = rcRecOfTab.Description(n),
					Parent_Id = rcRecOfTab.Parent_Id(n),
					Original_Task = rcRecOfTab.Original_Task(n),
					Plan_Id = rcRecOfTab.Plan_Id(n),
					Unit_Id = rcRecOfTab.Unit_Id(n),
					Status_Id = rcRecOfTab.Status_Id(n),
					Previous_Status_Id = rcRecOfTab.Previous_Status_Id(n),
					Online_Exec_Id = rcRecOfTab.Online_Exec_Id(n),
					Action_Id = rcRecOfTab.Action_Id(n),
					Pre_Expression_Id = rcRecOfTab.Pre_Expression_Id(n),
					Pos_Expression_Id = rcRecOfTab.Pos_Expression_Id(n),
					Quantity = rcRecOfTab.Quantity(n),
					Initial_Date = rcRecOfTab.Initial_Date(n),
					Final_Date = rcRecOfTab.Final_Date(n),
					Sincronic_Timeout = rcRecOfTab.Sincronic_Timeout(n),
					Asincronic_Timeout = rcRecOfTab.Asincronic_Timeout(n),
					Layer_Id = rcRecOfTab.Layer_Id(n),
					External_Id = rcRecOfTab.External_Id(n),
					Geometry = rcRecOfTab.Geometry(n),
					Try_Number = rcRecOfTab.Try_Number(n),
					Multi_Instance = rcRecOfTab.Multi_Instance(n),
					Function_Type = rcRecOfTab.Function_Type(n),
					Node_Type_Id = rcRecOfTab.Node_Type_Id(n),
					Module_Id = rcRecOfTab.Module_Id(n),
					Is_Countable = rcRecOfTab.Is_Countable(n),
					Total_Time = rcRecOfTab.Total_Time(n),
					Parent_External_Id = rcRecOfTab.Parent_External_Id(n),
					Entity_Id = rcRecOfTab.Entity_Id(n),
					Par_Ext_Entity_Id = rcRecOfTab.Par_Ext_Entity_Id(n),
					Group_Id = rcRecOfTab.Group_Id(n),
					Min_Group_Size = rcRecOfTab.Min_Group_Size(n),
					Unit_Type_Id = rcRecOfTab.Unit_Type_Id(n),
					Execution_Order = rcRecOfTab.Execution_Order(n),
					Annulation_Order = rcRecOfTab.Annulation_Order(n),
					Notification_Id = rcRecOfTab.Notification_Id(n),
					Execution_Id = rcRecOfTab.Execution_Id(n),
					Previous_Instance_Id = rcRecOfTab.Previous_Instance_Id(n)
				where
					Instance_Id = rcRecOfTab.Instance_Id(n)
;
      END IF;
   END;
   PROCEDURE UPDDESCRIPTION( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBDESCRIPTION$ IN WF_INSTANCE.DESCRIPTION%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Description = isbDescription$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.DESCRIPTION := ISBDESCRIPTION$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPARENT_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPARENT_ID$ IN WF_INSTANCE.PARENT_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Parent_Id = inuParent_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PARENT_ID := INUPARENT_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDORIGINAL_TASK( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUORIGINAL_TASK$ IN WF_INSTANCE.ORIGINAL_TASK%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Original_Task = inuOriginal_Task$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ORIGINAL_TASK := INUORIGINAL_TASK$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPLAN_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPLAN_ID$ IN WF_INSTANCE.PLAN_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Plan_Id = inuPlan_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PLAN_ID := INUPLAN_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDUNIT_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUUNIT_ID$ IN WF_INSTANCE.UNIT_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Unit_Id = inuUnit_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.UNIT_ID := INUUNIT_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSTATUS_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUSTATUS_ID$ IN WF_INSTANCE.STATUS_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Status_Id = inuStatus_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.STATUS_ID := INUSTATUS_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPREVIOUS_STATUS_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPREVIOUS_STATUS_ID$ IN WF_INSTANCE.PREVIOUS_STATUS_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Previous_Status_Id = inuPrevious_Status_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PREVIOUS_STATUS_ID := INUPREVIOUS_STATUS_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDONLINE_EXEC_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUONLINE_EXEC_ID$ IN WF_INSTANCE.ONLINE_EXEC_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Online_Exec_Id = inuOnline_Exec_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ONLINE_EXEC_ID := INUONLINE_EXEC_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDACTION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUACTION_ID$ IN WF_INSTANCE.ACTION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Action_Id = inuAction_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ACTION_ID := INUACTION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPRE_EXPRESSION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPRE_EXPRESSION_ID$ IN WF_INSTANCE.PRE_EXPRESSION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Pre_Expression_Id = inuPre_Expression_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PRE_EXPRESSION_ID := INUPRE_EXPRESSION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPOS_EXPRESSION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPOS_EXPRESSION_ID$ IN WF_INSTANCE.POS_EXPRESSION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Pos_Expression_Id = inuPos_Expression_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.POS_EXPRESSION_ID := INUPOS_EXPRESSION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDQUANTITY( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUQUANTITY$ IN WF_INSTANCE.QUANTITY%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Quantity = inuQuantity$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.QUANTITY := INUQUANTITY$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDINITIAL_DATE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, IDTINITIAL_DATE$ IN WF_INSTANCE.INITIAL_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Initial_Date = idtInitial_Date$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.INITIAL_DATE := IDTINITIAL_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDFINAL_DATE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, IDTFINAL_DATE$ IN WF_INSTANCE.FINAL_DATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Final_Date = idtFinal_Date$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.FINAL_DATE := IDTFINAL_DATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSINCRONIC_TIMEOUT( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUSINCRONIC_TIMEOUT$ IN WF_INSTANCE.SINCRONIC_TIMEOUT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Sincronic_Timeout = inuSincronic_Timeout$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.SINCRONIC_TIMEOUT := INUSINCRONIC_TIMEOUT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDASINCRONIC_TIMEOUT( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUASINCRONIC_TIMEOUT$ IN WF_INSTANCE.ASINCRONIC_TIMEOUT%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Asincronic_Timeout = inuAsincronic_Timeout$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ASINCRONIC_TIMEOUT := INUASINCRONIC_TIMEOUT$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDLAYER_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INULAYER_ID$ IN WF_INSTANCE.LAYER_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Layer_Id = inuLayer_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.LAYER_ID := INULAYER_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDEXTERNAL_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBEXTERNAL_ID$ IN WF_INSTANCE.EXTERNAL_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			External_Id = isbExternal_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.EXTERNAL_ID := ISBEXTERNAL_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDGEOMETRY( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBGEOMETRY$ IN WF_INSTANCE.GEOMETRY%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Geometry = isbGeometry$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.GEOMETRY := ISBGEOMETRY$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDTRY_NUMBER( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUTRY_NUMBER$ IN WF_INSTANCE.TRY_NUMBER%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Try_Number = inuTry_Number$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.TRY_NUMBER := INUTRY_NUMBER$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDMULTI_INSTANCE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBMULTI_INSTANCE$ IN WF_INSTANCE.MULTI_INSTANCE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Multi_Instance = isbMulti_Instance$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.MULTI_INSTANCE := ISBMULTI_INSTANCE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDFUNCTION_TYPE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUFUNCTION_TYPE$ IN WF_INSTANCE.FUNCTION_TYPE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Function_Type = inuFunction_Type$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.FUNCTION_TYPE := INUFUNCTION_TYPE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDNODE_TYPE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUNODE_TYPE_ID$ IN WF_INSTANCE.NODE_TYPE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Node_Type_Id = inuNode_Type_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.NODE_TYPE_ID := INUNODE_TYPE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDMODULE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUMODULE_ID$ IN WF_INSTANCE.MODULE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Module_Id = inuModule_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.MODULE_ID := INUMODULE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDIS_COUNTABLE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBIS_COUNTABLE$ IN WF_INSTANCE.IS_COUNTABLE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Is_Countable = isbIs_Countable$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.IS_COUNTABLE := ISBIS_COUNTABLE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDTOTAL_TIME( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUTOTAL_TIME$ IN WF_INSTANCE.TOTAL_TIME%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Total_Time = inuTotal_Time$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.TOTAL_TIME := INUTOTAL_TIME$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPARENT_EXTERNAL_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBPARENT_EXTERNAL_ID$ IN WF_INSTANCE.PARENT_EXTERNAL_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Parent_External_Id = isbParent_External_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PARENT_EXTERNAL_ID := ISBPARENT_EXTERNAL_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDENTITY_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUENTITY_ID$ IN WF_INSTANCE.ENTITY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Entity_Id = inuEntity_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ENTITY_ID := INUENTITY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPAR_EXT_ENTITY_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPAR_EXT_ENTITY_ID$ IN WF_INSTANCE.PAR_EXT_ENTITY_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Par_Ext_Entity_Id = inuPar_Ext_Entity_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PAR_EXT_ENTITY_ID := INUPAR_EXT_ENTITY_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDGROUP_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUGROUP_ID$ IN WF_INSTANCE.GROUP_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Group_Id = inuGroup_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.GROUP_ID := INUGROUP_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDMIN_GROUP_SIZE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUMIN_GROUP_SIZE$ IN WF_INSTANCE.MIN_GROUP_SIZE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Min_Group_Size = inuMin_Group_Size$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.MIN_GROUP_SIZE := INUMIN_GROUP_SIZE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDUNIT_TYPE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUUNIT_TYPE_ID$ IN WF_INSTANCE.UNIT_TYPE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Unit_Type_Id = inuUnit_Type_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.UNIT_TYPE_ID := INUUNIT_TYPE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDEXECUTION_ORDER( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBEXECUTION_ORDER$ IN WF_INSTANCE.EXECUTION_ORDER%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Execution_Order = isbExecution_Order$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.EXECUTION_ORDER := ISBEXECUTION_ORDER$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDANNULATION_ORDER( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, ISBANNULATION_ORDER$ IN WF_INSTANCE.ANNULATION_ORDER%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Annulation_Order = isbAnnulation_Order$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.ANNULATION_ORDER := ISBANNULATION_ORDER$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDNOTIFICATION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUNOTIFICATION_ID$ IN WF_INSTANCE.NOTIFICATION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Notification_Id = inuNotification_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.NOTIFICATION_ID := INUNOTIFICATION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDEXECUTION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUEXECUTION_ID$ IN WF_INSTANCE.EXECUTION_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Execution_Id = inuExecution_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.EXECUTION_ID := INUEXECUTION_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDPREVIOUS_INSTANCE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INUPREVIOUS_INSTANCE_ID$ IN WF_INSTANCE.PREVIOUS_INSTANCE_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUINSTANCE_ID, RCDATA );
      END IF;
      UPDATE WF_instance
		set
			Previous_Instance_Id = inuPrevious_Instance_Id$
		where
			Instance_Id = inuInstance_Id;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.PREVIOUS_INSTANCE_ID := INUPREVIOUS_INSTANCE_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FNUGETINSTANCE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.INSTANCE_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.INSTANCE_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.INSTANCE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETDESCRIPTION( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.DESCRIPTION%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.DESCRIPTION );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.DESCRIPTION );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPARENT_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PARENT_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PARENT_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PARENT_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETORIGINAL_TASK( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.ORIGINAL_TASK%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.ORIGINAL_TASK );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.ORIGINAL_TASK );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPLAN_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PLAN_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PLAN_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PLAN_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETUNIT_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.UNIT_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.UNIT_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.UNIT_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETSTATUS_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.STATUS_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.STATUS_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.STATUS_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPREVIOUS_STATUS_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PREVIOUS_STATUS_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PREVIOUS_STATUS_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PREVIOUS_STATUS_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETONLINE_EXEC_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.ONLINE_EXEC_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.ONLINE_EXEC_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.ONLINE_EXEC_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETACTION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.ACTION_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.ACTION_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.ACTION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPRE_EXPRESSION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PRE_EXPRESSION_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PRE_EXPRESSION_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PRE_EXPRESSION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPOS_EXPRESSION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.POS_EXPRESSION_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.POS_EXPRESSION_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.POS_EXPRESSION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETQUANTITY( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.QUANTITY%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.QUANTITY );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.QUANTITY );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETINITIAL_DATE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.INITIAL_DATE%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.INITIAL_DATE );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.INITIAL_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FDTGETFINAL_DATE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.FINAL_DATE%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.FINAL_DATE );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.FINAL_DATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETSINCRONIC_TIMEOUT( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.SINCRONIC_TIMEOUT%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.SINCRONIC_TIMEOUT );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.SINCRONIC_TIMEOUT );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETASINCRONIC_TIMEOUT( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.ASINCRONIC_TIMEOUT%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.ASINCRONIC_TIMEOUT );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.ASINCRONIC_TIMEOUT );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETLAYER_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.LAYER_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.LAYER_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.LAYER_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETEXTERNAL_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.EXTERNAL_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.EXTERNAL_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.EXTERNAL_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETGEOMETRY( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.GEOMETRY%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.GEOMETRY );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.GEOMETRY );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETTRY_NUMBER( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.TRY_NUMBER%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.TRY_NUMBER );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.TRY_NUMBER );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETMULTI_INSTANCE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.MULTI_INSTANCE%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.MULTI_INSTANCE );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.MULTI_INSTANCE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETFUNCTION_TYPE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.FUNCTION_TYPE%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.FUNCTION_TYPE );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.FUNCTION_TYPE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETNODE_TYPE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.NODE_TYPE_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.NODE_TYPE_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.NODE_TYPE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETMODULE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.MODULE_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.MODULE_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.MODULE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETIS_COUNTABLE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.IS_COUNTABLE%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.IS_COUNTABLE );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.IS_COUNTABLE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETTOTAL_TIME( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.TOTAL_TIME%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.TOTAL_TIME );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.TOTAL_TIME );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETPARENT_EXTERNAL_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PARENT_EXTERNAL_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PARENT_EXTERNAL_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PARENT_EXTERNAL_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETENTITY_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.ENTITY_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.ENTITY_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.ENTITY_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPAR_EXT_ENTITY_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PAR_EXT_ENTITY_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PAR_EXT_ENTITY_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PAR_EXT_ENTITY_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETGROUP_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.GROUP_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.GROUP_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.GROUP_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETMIN_GROUP_SIZE( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.MIN_GROUP_SIZE%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.MIN_GROUP_SIZE );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.MIN_GROUP_SIZE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETUNIT_TYPE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.UNIT_TYPE_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.UNIT_TYPE_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.UNIT_TYPE_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETEXECUTION_ORDER( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.EXECUTION_ORDER%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.EXECUTION_ORDER );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.EXECUTION_ORDER );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETANNULATION_ORDER( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.ANNULATION_ORDER%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.ANNULATION_ORDER );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.ANNULATION_ORDER );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETNOTIFICATION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.NOTIFICATION_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.NOTIFICATION_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.NOTIFICATION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETEXECUTION_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.EXECUTION_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.EXECUTION_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.EXECUTION_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETPREVIOUS_INSTANCE_ID( INUINSTANCE_ID IN WF_INSTANCE.INSTANCE_ID%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN WF_INSTANCE.PREVIOUS_INSTANCE_ID%TYPE
    IS
      RCERROR STYWF_INSTANCE;
    BEGIN
      RCERROR.INSTANCE_ID := INUINSTANCE_ID;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUINSTANCE_ID ) THEN
         RETURN ( RCDATA.PREVIOUS_INSTANCE_ID );
      END IF;
      LOAD( INUINSTANCE_ID );
      RETURN ( RCDATA.PREVIOUS_INSTANCE_ID );
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
END DAWF_INSTANCE;
/


