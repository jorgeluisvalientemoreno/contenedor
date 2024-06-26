
CREATE OR REPLACE PACKAGE DACC_ACTION_EVENT IS
   CURSOR CURECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE ) IS
SELECT CC_action_event.*,CC_action_event.rowid
		FROM CC_action_event
		WHERE 
		    Action_Event_Id = inuAction_Event_Id
		    and Executable = isbExecutable;
   CURSOR CURECORDBYROWID( IRIROWID IN VARCHAR2 ) IS
SELECT CC_action_event.*,CC_action_event.rowid
		FROM CC_action_event
		WHERE 
			rowId = irirowid;
   SUBTYPE STYCC_ACTION_EVENT IS CURECORD%ROWTYPE;
   TYPE TYREFCURSOR IS REF CURSOR;
   TYPE TYTBCC_ACTION_EVENT IS TABLE OF STYCC_ACTION_EVENT INDEX BY BINARY_INTEGER;
   TYPE TYRFRECORDS IS REF CURSOR
    RETURN STYCC_ACTION_EVENT;
   TYPE TYTBACTION_EVENT_ID IS TABLE OF CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE INDEX BY BINARY_INTEGER;
   TYPE TYTBEXPRESSION IS TABLE OF CC_ACTION_EVENT.EXPRESSION%TYPE INDEX BY BINARY_INTEGER;
   TYPE TYTBEXECUTABLE IS TABLE OF CC_ACTION_EVENT.EXECUTABLE%TYPE INDEX BY BINARY_INTEGER;
   TYPE TYTBSTATE IS TABLE OF CC_ACTION_EVENT.STATE%TYPE INDEX BY BINARY_INTEGER;
   TYPE TYTBCLASS_ID IS TABLE OF CC_ACTION_EVENT.CLASS_ID%TYPE INDEX BY BINARY_INTEGER;
   TYPE TYTBROWID IS TABLE OF ROWID INDEX BY BINARY_INTEGER;
   TYPE TYRCCC_ACTION_EVENT IS RECORD
    (
      ACTION_EVENT_ID TYTBACTION_EVENT_ID,
      EXPRESSION TYTBEXPRESSION,
      EXECUTABLE TYTBEXECUTABLE,
      STATE TYTBSTATE,
      CLASS_ID TYTBCLASS_ID,
      ROW_ID TYTBROWID
    );
   FUNCTION FSBVERSION
    RETURN VARCHAR2;
   FUNCTION FSBGETMESSAGEDESCRIPTION
    RETURN VARCHAR2;
   PROCEDURE CLEARMEMORY;
   FUNCTION FBLEXIST( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN BOOLEAN;
   PROCEDURE ACCKEY( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE );
   PROCEDURE ACCKEYBYROWID( IRIROWID IN ROWID );
   PROCEDURE VALDUPLICATE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE );
   PROCEDURE GETRECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, ORCRECORD OUT NOCOPY STYCC_ACTION_EVENT );
   FUNCTION FRCGETRCDATA( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN STYCC_ACTION_EVENT;
   FUNCTION FRCGETRCDATA
    RETURN STYCC_ACTION_EVENT;
   FUNCTION FRCGETRECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN STYCC_ACTION_EVENT;
   PROCEDURE GETRECORDS( ISBQUERY IN VARCHAR2, OTBRESULT OUT NOCOPY TYTBCC_ACTION_EVENT );
   FUNCTION FRFGETRECORDS( ISBCRITERIA IN VARCHAR2 := NULL, IBLLOCK IN BOOLEAN := FALSE )
    RETURN TYREFCURSOR;
   PROCEDURE INSRECORD( IRCCC_ACTION_EVENT IN STYCC_ACTION_EVENT );
   PROCEDURE INSRECORD( IRCCC_ACTION_EVENT IN STYCC_ACTION_EVENT, ORIROWID OUT VARCHAR2 );
   PROCEDURE INSRECORDS( IOTBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT );
   PROCEDURE DELRECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INULOCK IN NUMBER := 1 );
   PROCEDURE DELBYROWID( IRIROWID IN ROWID, INULOCK IN NUMBER := 1 );
   PROCEDURE DELRECORDS( IOTBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT, INULOCK IN NUMBER := 1 );
   PROCEDURE UPDRECORD( IRCCC_ACTION_EVENT IN STYCC_ACTION_EVENT, INULOCK IN NUMBER := 0 );
   PROCEDURE UPDRECORDS( IOTBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT, INULOCK IN NUMBER := 1 );
   PROCEDURE UPDEXPRESSION( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INUEXPRESSION$ IN CC_ACTION_EVENT.EXPRESSION%TYPE, INULOCK IN NUMBER := 0 );
   PROCEDURE UPDSTATE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, ISBSTATE$ IN CC_ACTION_EVENT.STATE%TYPE, INULOCK IN NUMBER := 0 );
   PROCEDURE UPDCLASS_ID( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INUCLASS_ID$ IN CC_ACTION_EVENT.CLASS_ID%TYPE, INULOCK IN NUMBER := 0 );
   FUNCTION FNUGETACTION_EVENT_ID( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE;
   FUNCTION FNUGETEXPRESSION( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.EXPRESSION%TYPE;
   FUNCTION FSBGETEXECUTABLE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.EXECUTABLE%TYPE;
   FUNCTION FSBGETSTATE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.STATE%TYPE;
   FUNCTION FNUGETCLASS_ID( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.CLASS_ID%TYPE;
   PROCEDURE LOCKBYPK( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, ORCCC_ACTION_EVENT OUT STYCC_ACTION_EVENT );
   PROCEDURE LOCKBYROWID( IRIROWID IN VARCHAR2, ORCCC_ACTION_EVENT OUT STYCC_ACTION_EVENT );
   PROCEDURE SETUSECACHE( IBLUSECACHE IN BOOLEAN );
END DACC_ACTION_EVENT;
/


CREATE OR REPLACE PACKAGE BODY DACC_ACTION_EVENT IS
   CNURECORD_NOT_EXIST CONSTANT NUMBER( 1 ) := 1;
   CNURECORD_ALREADY_EXIST CONSTANT NUMBER( 1 ) := 2;
   CNUAPPTABLEBUSSY CONSTANT NUMBER( 4 ) := 6951;
   CNUINS_PK_NULL CONSTANT NUMBER( 4 ) := 1682;
   CNURECORD_HAVE_CHILDREN CONSTANT NUMBER( 4 ) := -2292;
   CSBVERSION CONSTANT VARCHAR2( 20 ) := 'SAO175100';
   CSBTABLEPARAMETER CONSTANT VARCHAR2( 30 ) := 'CC_ACTION_EVENT';
   CNUGEENTITYID CONSTANT VARCHAR2( 30 ) := 6161;
   CURSOR CULOCKRCBYPK( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE ) IS
SELECT CC_action_event.*,CC_action_event.rowid 
		FROM CC_action_event
		WHERE  Action_Event_Id = inuAction_Event_Id
			and Executable = isbExecutable
		FOR UPDATE NOWAIT;
   CURSOR CULOCKRCBYROWID( IRIROWID IN VARCHAR2 ) IS
SELECT CC_action_event.*,CC_action_event.rowid 
		FROM CC_action_event
		WHERE 
			rowId = irirowid
		FOR UPDATE NOWAIT;
   TYPE TYRFCC_ACTION_EVENT IS REF CURSOR;
   RCRECOFTAB TYRCCC_ACTION_EVENT;
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
   FUNCTION FSBPRIMARYKEY( RCI IN STYCC_ACTION_EVENT := RCDATA )
    RETURN VARCHAR2
    IS
      SBPK VARCHAR2( 500 );
    BEGIN
      SBPK := '[';
      SBPK := SBPK || UT_CONVERT.FSBTOCHAR( RCI.ACTION_EVENT_ID );
      SBPK := SBPK || ',' || UT_CONVERT.FSBTOCHAR( RCI.EXECUTABLE );
      SBPK := SBPK || ']';
      RETURN SBPK;
   END;
   PROCEDURE LOCKBYPK( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, ORCCC_ACTION_EVENT OUT STYCC_ACTION_EVENT )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      OPEN CULOCKRCBYPK( INUACTION_EVENT_ID, ISBEXECUTABLE );
      FETCH CULOCKRCBYPK
         INTO ORCCC_ACTION_EVENT;
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
   PROCEDURE LOCKBYROWID( IRIROWID IN VARCHAR2, ORCCC_ACTION_EVENT OUT STYCC_ACTION_EVENT )
    IS
    BEGIN
      OPEN CULOCKRCBYROWID( IRIROWID );
      FETCH CULOCKRCBYROWID
         INTO ORCCC_ACTION_EVENT;
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
   PROCEDURE DELRECORDOFTABLES( ITBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT )
    IS
    BEGIN
      RCRECOFTAB.ACTION_EVENT_ID.DELETE;
      RCRECOFTAB.EXPRESSION.DELETE;
      RCRECOFTAB.EXECUTABLE.DELETE;
      RCRECOFTAB.STATE.DELETE;
      RCRECOFTAB.CLASS_ID.DELETE;
      RCRECOFTAB.ROW_ID.DELETE;
   END;
   PROCEDURE FILLRECORDOFTABLES( ITBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT, OBLUSEROWID OUT BOOLEAN )
    IS
    BEGIN
      DELRECORDOFTABLES( ITBCC_ACTION_EVENT );
      FOR N IN ITBCC_ACTION_EVENT.FIRST..ITBCC_ACTION_EVENT.LAST
       LOOP
         RCRECOFTAB.ACTION_EVENT_ID( N ) := ITBCC_ACTION_EVENT( N ).ACTION_EVENT_ID;
         RCRECOFTAB.EXPRESSION( N ) := ITBCC_ACTION_EVENT( N ).EXPRESSION;
         RCRECOFTAB.EXECUTABLE( N ) := ITBCC_ACTION_EVENT( N ).EXECUTABLE;
         RCRECOFTAB.STATE( N ) := ITBCC_ACTION_EVENT( N ).STATE;
         RCRECOFTAB.CLASS_ID( N ) := ITBCC_ACTION_EVENT( N ).CLASS_ID;
         RCRECOFTAB.ROW_ID( N ) := ITBCC_ACTION_EVENT( N ).ROWID;
         OBLUSEROWID := RCRECOFTAB.ROW_ID( N ) IS NOT NULL;
      END LOOP;
   END;
   PROCEDURE LOAD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    IS
      RCRECORDNULL CURECORD%ROWTYPE;
    BEGIN
      IF CURECORD%ISOPEN THEN
         CLOSE CURECORD;
      END IF;
      OPEN CURECORD( INUACTION_EVENT_ID, ISBEXECUTABLE );
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
   FUNCTION FBLALREADYLOADED( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      IF ( INUACTION_EVENT_ID = RCDATA.ACTION_EVENT_ID AND ISBEXECUTABLE = RCDATA.EXECUTABLE ) THEN
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
   FUNCTION FBLEXIST( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN BOOLEAN
    IS
    BEGIN
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( TRUE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         RETURN ( FALSE );
   END;
   PROCEDURE ACCKEY( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
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
   PROCEDURE VALDUPLICATE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    IS
    BEGIN
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY );
      RAISE EX.CONTROLLED_ERROR;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         NULL;
   END;
   PROCEDURE GETRECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, ORCRECORD OUT NOCOPY STYCC_ACTION_EVENT )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      ORCRECORD := RCDATA;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN STYCC_ACTION_EVENT
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE )
    RETURN STYCC_ACTION_EVENT
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUACTION_EVENT_ID, ISBEXECUTABLE ) THEN
         RETURN ( RCDATA );
      END IF;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FRCGETRCDATA
    RETURN STYCC_ACTION_EVENT
    IS
    BEGIN
      RETURN ( RCDATA );
   END;
   PROCEDURE GETRECORDS( ISBQUERY IN VARCHAR2, OTBRESULT OUT NOCOPY TYTBCC_ACTION_EVENT )
    IS
      RFCC_ACTION_EVENT TYRFCC_ACTION_EVENT;
      N NUMBER( 4 ) := 1;
      SBFULLQUERY VARCHAR2( 32000 ) := 'SELECT 
		            CC_action_event.Action_Event_Id,
		            CC_action_event.Expression,
		            CC_action_event.Executable,
		            CC_action_event.State,
		            CC_action_event.Class_Id,
		            CC_action_event.rowid
                FROM CC_action_event';
      NUMAXTBRECORDS NUMBER( 5 ) := GE_BOPARAMETER.FNUGET( 'MAXREGSQUERY' );
    BEGIN
      OTBRESULT.DELETE;
      IF ISBQUERY IS NOT NULL AND LENGTH( ISBQUERY ) > 0 THEN
         SBFULLQUERY := SBFULLQUERY || ' WHERE ' || ISBQUERY;
      END IF;
      OPEN RFCC_ACTION_EVENT
           FOR SBFULLQUERY;
      FETCH RFCC_ACTION_EVENT
         BULK COLLECT INTO OTBRESULT;
      CLOSE RFCC_ACTION_EVENT;
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
		            CC_action_event.Action_Event_Id,
		            CC_action_event.Expression,
		            CC_action_event.Executable,
		            CC_action_event.State,
		            CC_action_event.Class_Id,
		            CC_action_event.rowid
                FROM CC_action_event';
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
   PROCEDURE INSRECORD( IRCCC_ACTION_EVENT IN STYCC_ACTION_EVENT )
    IS
      RIROWID VARCHAR2( 200 );
    BEGIN
      INSRECORD( IRCCC_ACTION_EVENT, RIROWID );
   END;
   PROCEDURE INSRECORD( IRCCC_ACTION_EVENT IN STYCC_ACTION_EVENT, ORIROWID OUT VARCHAR2 )
    IS
    BEGIN
      IF IRCCC_ACTION_EVENT.ACTION_EVENT_ID IS NULL THEN
         ERRORS.SETERROR( CNUINS_PK_NULL, FSBGETMESSAGEDESCRIPTION || '|Action_Event_Id' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      IF IRCCC_ACTION_EVENT.EXECUTABLE IS NULL THEN
         ERRORS.SETERROR( CNUINS_PK_NULL, FSBGETMESSAGEDESCRIPTION || '|Executable' );
         RAISE EX.CONTROLLED_ERROR;
      END IF;
      INSERT into CC_action_event
		(
			Action_Event_Id,
			Expression,
			Executable,
			State,
			Class_Id
		)
		values
		(
			ircCC_action_event.Action_Event_Id,
			ircCC_action_event.Expression,
			ircCC_action_event.Executable,
			ircCC_action_event.State,
			ircCC_action_event.Class_Id
		)
            returning
			rowid
		into
			orirowid;
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( IRCCC_ACTION_EVENT ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE INSRECORDS( IOTBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT )
    IS
      BLUSEROWID BOOLEAN;
    BEGIN
      FILLRECORDOFTABLES( IOTBCC_ACTION_EVENT, BLUSEROWID );
      FORALL N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
         INSERT into CC_action_event
			(
				Action_Event_Id,
				Expression,
				Executable,
				State,
				Class_Id
			)
			values
			(
				rcRecOfTab.Action_Event_Id(n),
				rcRecOfTab.Expression(n),
				rcRecOfTab.Executable(n),
				rcRecOfTab.State(n),
				rcRecOfTab.Class_Id(n)
			);
    EXCEPTION
      WHEN DUP_VAL_ON_INDEX THEN
         ERRORS.SETERROR( CNURECORD_ALREADY_EXIST, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE DELRECORD( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INULOCK IN NUMBER := 1 )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUACTION_EVENT_ID, ISBEXECUTABLE, RCDATA );
      END IF;
      DELETE
		from CC_action_event
		where
       		Action_Event_Id=inuAction_Event_Id and 
       		Executable=isbExecutable;
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
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      IF INULOCK = 1 THEN
         LOCKBYROWID( IRIROWID, RCDATA );
      END IF;
      DELETE
		from CC_action_event
		where
			rowid = iriRowID
		returning
			Action_Event_Id,
			Expression
		into
			rcError.Action_Event_Id,
			rcError.Expression;
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
   PROCEDURE DELRECORDS( IOTBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYCC_ACTION_EVENT;
    BEGIN
      FILLRECORDOFTABLES( IOTBCC_ACTION_EVENT, BLUSEROWID );
      IF ( BLUSEROWID ) THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
            DELETE
				from CC_action_event
				where
					rowid = rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.ACTION_EVENT_ID( N ), RCRECOFTAB.EXECUTABLE( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
            DELETE
				from CC_action_event
				where
		         	Action_Event_Id = rcRecOfTab.Action_Event_Id(n) and 
		         	Executable = rcRecOfTab.Executable(n);
      END IF;
    EXCEPTION
      WHEN EX.RECORD_HAVE_CHILDREN THEN
         ERRORS.SETERROR( CNURECORD_HAVE_CHILDREN, FSBGETMESSAGEDESCRIPTION );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORD( IRCCC_ACTION_EVENT IN STYCC_ACTION_EVENT, INULOCK IN NUMBER := 0 )
    IS
      NUACTION_EVENT_ID CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE;
      NUEXECUTABLE CC_ACTION_EVENT.EXECUTABLE%TYPE;
    BEGIN
      IF IRCCC_ACTION_EVENT.ROWID IS NOT NULL THEN
         IF INULOCK = 1 THEN
            LOCKBYROWID( IRCCC_ACTION_EVENT.ROWID, RCDATA );
         END IF;
         UPDATE CC_action_event
			set
				Expression = ircCC_action_event.Expression,
				State = ircCC_action_event.State,
				Class_Id = ircCC_action_event.Class_Id
			where
				rowid = ircCC_action_event.rowid
			returning
				Action_Event_Id,
				Executable
			into
				nuAction_Event_Id,
				nuExecutable;
       ELSE
         IF INULOCK = 1 THEN
            LOCKBYPK( IRCCC_ACTION_EVENT.ACTION_EVENT_ID, IRCCC_ACTION_EVENT.EXPRESSION, RCDATA );
         END IF;
         UPDATE CC_action_event
			set
				Expression = ircCC_action_event.Expression,
				State = ircCC_action_event.State,
				Class_Id = ircCC_action_event.Class_Id
			where
				Action_Event_Id = ircCC_action_event.Action_Event_Id and 
				Executable = ircCC_action_event.Executable
			returning
				Action_Event_Id,
				Executable
			into
				nuAction_Event_Id,
				nuExecutable;
      END IF;
      IF NUACTION_EVENT_ID IS NULL OR NUEXECUTABLE IS NULL THEN
         RAISE NO_DATA_FOUND;
      END IF;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || FSBPRIMARYKEY( IRCCC_ACTION_EVENT ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDRECORDS( IOTBCC_ACTION_EVENT IN OUT NOCOPY TYTBCC_ACTION_EVENT, INULOCK IN NUMBER := 1 )
    IS
      BLUSEROWID BOOLEAN;
      RCAUX STYCC_ACTION_EVENT;
    BEGIN
      FILLRECORDOFTABLES( IOTBCC_ACTION_EVENT, BLUSEROWID );
      IF BLUSEROWID THEN
         IF INULOCK = 1 THEN
            FOR N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
             LOOP
               LOCKBYROWID( RCRECOFTAB.ROW_ID( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
            UPDATE CC_action_event
				set
					Expression = rcRecOfTab.Expression(n),
					State = rcRecOfTab.State(n),
					Class_Id = rcRecOfTab.Class_Id(n)
				where
					rowid =  rcRecOfTab.row_id(n);
       ELSE
         IF INULOCK = 1 THEN
            FOR N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
             LOOP
               LOCKBYPK( RCRECOFTAB.ACTION_EVENT_ID( N ), RCRECOFTAB.EXECUTABLE( N ), RCAUX );
            END LOOP;
         END IF;
         FORALL N IN IOTBCC_ACTION_EVENT.FIRST..IOTBCC_ACTION_EVENT.LAST
            UPDATE CC_action_event
				SET
					Expression = rcRecOfTab.Expression(n),
					State = rcRecOfTab.State(n),
					Class_Id = rcRecOfTab.Class_Id(n)
				where
					Action_Event_Id = rcRecOfTab.Action_Event_Id(n) and 
					Executable = rcRecOfTab.Executable(n)
;
      END IF;
   END;
   PROCEDURE UPDEXPRESSION( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INUEXPRESSION$ IN CC_ACTION_EVENT.EXPRESSION%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUACTION_EVENT_ID, ISBEXECUTABLE, RCDATA );
      END IF;
      UPDATE CC_action_event
		set
			Expression = inuExpression$
		where
			Action_Event_Id = inuAction_Event_Id and 
			Executable = isbExecutable;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.EXPRESSION := INUEXPRESSION$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDSTATE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, ISBSTATE$ IN CC_ACTION_EVENT.STATE%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUACTION_EVENT_ID, ISBEXECUTABLE, RCDATA );
      END IF;
      UPDATE CC_action_event
		set
			State = isbState$
		where
			Action_Event_Id = inuAction_Event_Id and 
			Executable = isbExecutable;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.STATE := ISBSTATE$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   PROCEDURE UPDCLASS_ID( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INUCLASS_ID$ IN CC_ACTION_EVENT.CLASS_ID%TYPE, INULOCK IN NUMBER := 0 )
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF INULOCK = 1 THEN
         LOCKBYPK( INUACTION_EVENT_ID, ISBEXECUTABLE, RCDATA );
      END IF;
      UPDATE CC_action_event
		set
			Class_Id = inuClass_Id$
		where
			Action_Event_Id = inuAction_Event_Id and 
			Executable = isbExecutable;
      IF SQL%NOTFOUND THEN
         RAISE NO_DATA_FOUND;
      END IF;
      RCDATA.CLASS_ID := INUCLASS_ID$;
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
         RAISE EX.CONTROLLED_ERROR;
   END;
   FUNCTION FNUGETACTION_EVENT_ID( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUACTION_EVENT_ID, ISBEXECUTABLE ) THEN
         RETURN ( RCDATA.ACTION_EVENT_ID );
      END IF;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA.ACTION_EVENT_ID );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETEXPRESSION( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.EXPRESSION%TYPE
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUACTION_EVENT_ID, ISBEXECUTABLE ) THEN
         RETURN ( RCDATA.EXPRESSION );
      END IF;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA.EXPRESSION );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETEXECUTABLE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.EXECUTABLE%TYPE
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUACTION_EVENT_ID, ISBEXECUTABLE ) THEN
         RETURN ( RCDATA.EXECUTABLE );
      END IF;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA.EXECUTABLE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FSBGETSTATE( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.STATE%TYPE
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUACTION_EVENT_ID, ISBEXECUTABLE ) THEN
         RETURN ( RCDATA.STATE );
      END IF;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA.STATE );
    EXCEPTION
      WHEN NO_DATA_FOUND THEN
         IF INURAISEERROR = 1 THEN
            ERRORS.SETERROR( CNURECORD_NOT_EXIST, FSBGETMESSAGEDESCRIPTION || ' ' || FSBPRIMARYKEY( RCERROR ) );
            RAISE EX.CONTROLLED_ERROR;
          ELSE
            RETURN NULL;
         END IF;
   END;
   FUNCTION FNUGETCLASS_ID( INUACTION_EVENT_ID IN CC_ACTION_EVENT.ACTION_EVENT_ID%TYPE, ISBEXECUTABLE IN CC_ACTION_EVENT.EXECUTABLE%TYPE, INURAISEERROR IN NUMBER := 1 )
    RETURN CC_ACTION_EVENT.CLASS_ID%TYPE
    IS
      RCERROR STYCC_ACTION_EVENT;
    BEGIN
      RCERROR.ACTION_EVENT_ID := INUACTION_EVENT_ID;
      RCERROR.EXECUTABLE := ISBEXECUTABLE;
      IF BLDAO_USE_CACHE AND FBLALREADYLOADED( INUACTION_EVENT_ID, ISBEXECUTABLE ) THEN
         RETURN ( RCDATA.CLASS_ID );
      END IF;
      LOAD( INUACTION_EVENT_ID, ISBEXECUTABLE );
      RETURN ( RCDATA.CLASS_ID );
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
END DACC_ACTION_EVENT;
/


