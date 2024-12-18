CREATE OR REPLACE PACKAGE ADM_PERSON.DALD_RESULT_CONSULT
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALD_RESULT_CONSULT
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    31/05/2024              PAcosta         OSF-2767: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/     
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	IS
		SELECT LD_RESULT_CONSULT.*,LD_RESULT_CONSULT.rowid
		FROM LD_RESULT_CONSULT
		WHERE
		    RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LD_RESULT_CONSULT.*,LD_RESULT_CONSULT.rowid
		FROM LD_RESULT_CONSULT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLD_RESULT_CONSULT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLD_RESULT_CONSULT is table of styLD_RESULT_CONSULT index by binary_integer;
	type tyrfRecords is ref cursor return styLD_RESULT_CONSULT;

	/* Tipos referenciando al registro */
	type tytbPACKAGE_ID is table of LD_RESULT_CONSULT.PACKAGE_ID%type index by binary_integer;
	type tytbRESULT_CONSULT_ID is table of LD_RESULT_CONSULT.RESULT_CONSULT_ID%type index by binary_integer;
	type tytbIDENTIFICATION is table of LD_RESULT_CONSULT.IDENTIFICATION%type index by binary_integer;
	type tytbIDENT_TYPE_ID is table of LD_RESULT_CONSULT.IDENT_TYPE_ID%type index by binary_integer;
	type tytbGENDER_ID is table of LD_RESULT_CONSULT.GENDER_ID%type index by binary_integer;
	type tytbEFFECTIVE_STATE_ID is table of LD_RESULT_CONSULT.EFFECTIVE_STATE_ID%type index by binary_integer;
	type tytbAGE_RANGE_ID is table of LD_RESULT_CONSULT.AGE_RANGE_ID%type index by binary_integer;
	type tytbSUBSCRIBERNAME is table of LD_RESULT_CONSULT.SUBSCRIBERNAME%type index by binary_integer;
	type tytbCONSULT_CODES_ID is table of LD_RESULT_CONSULT.CONSULT_CODES_ID%type index by binary_integer;
	type tytbRESULT_CONSULT is table of LD_RESULT_CONSULT.RESULT_CONSULT%type index by binary_integer;
	type tytbNUMBER_REQUEST is table of LD_RESULT_CONSULT.NUMBER_REQUEST%type index by binary_integer;
	type tytbTERMINAL is table of LD_RESULT_CONSULT.TERMINAL%type index by binary_integer;
	type tytbUSER_NAME is table of LD_RESULT_CONSULT.USER_NAME%type index by binary_integer;
	type tytbCONSULTATION_DATE is table of LD_RESULT_CONSULT.CONSULTATION_DATE%type index by binary_integer;
	type tytbDEPARTAMENT_ISSUED is table of LD_RESULT_CONSULT.DEPARTAMENT_ISSUED%type index by binary_integer;
	type tytbCITY_ISSUED is table of LD_RESULT_CONSULT.CITY_ISSUED%type index by binary_integer;
	type tytbDATE_ISSUED is table of LD_RESULT_CONSULT.DATE_ISSUED%type index by binary_integer;
	type tytbSECOND_LAST_NAME is table of LD_RESULT_CONSULT.SECOND_LAST_NAME%type index by binary_integer;
	type tytbLAST_NAME is table of LD_RESULT_CONSULT.LAST_NAME%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLD_RESULT_CONSULT is record
	(
		PACKAGE_ID   tytbPACKAGE_ID,
		RESULT_CONSULT_ID   tytbRESULT_CONSULT_ID,
		IDENTIFICATION   tytbIDENTIFICATION,
		IDENT_TYPE_ID   tytbIDENT_TYPE_ID,
		GENDER_ID   tytbGENDER_ID,
		EFFECTIVE_STATE_ID   tytbEFFECTIVE_STATE_ID,
		AGE_RANGE_ID   tytbAGE_RANGE_ID,
		SUBSCRIBERNAME   tytbSUBSCRIBERNAME,
		CONSULT_CODES_ID   tytbCONSULT_CODES_ID,
		RESULT_CONSULT   tytbRESULT_CONSULT,
		NUMBER_REQUEST   tytbNUMBER_REQUEST,
		TERMINAL   tytbTERMINAL,
		USER_NAME   tytbUSER_NAME,
		CONSULTATION_DATE   tytbCONSULTATION_DATE,
		DEPARTAMENT_ISSUED   tytbDEPARTAMENT_ISSUED,
		CITY_ISSUED   tytbCITY_ISSUED,
		DATE_ISSUED   tytbDATE_ISSUED,
		SECOND_LAST_NAME   tytbSECOND_LAST_NAME,
		LAST_NAME   tytbLAST_NAME,
		row_id tytbrowid
	);


	/***** Metodos Publicos ****/

    FUNCTION fsbVersion
    RETURN varchar2;

	FUNCTION fsbGetMessageDescription
	return varchar2;

	PROCEDURE ClearMemory;

	FUNCTION fblExist
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	);

	PROCEDURE getRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		orcRecord out nocopy styLD_RESULT_CONSULT
	);

	FUNCTION frcGetRcData
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN styLD_RESULT_CONSULT;

	FUNCTION frcGetRcData
	RETURN styLD_RESULT_CONSULT;

	FUNCTION frcGetRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN styLD_RESULT_CONSULT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_RESULT_CONSULT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLD_RESULT_CONSULT in styLD_RESULT_CONSULT
	);

	PROCEDURE insRecord
	(
		ircLD_RESULT_CONSULT in styLD_RESULT_CONSULT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLD_RESULT_CONSULT in out nocopy tytbLD_RESULT_CONSULT
	);

	PROCEDURE delRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLD_RESULT_CONSULT in out nocopy tytbLD_RESULT_CONSULT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLD_RESULT_CONSULT in styLD_RESULT_CONSULT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLD_RESULT_CONSULT in out nocopy tytbLD_RESULT_CONSULT,
		inuLock in number default 1
	);

	PROCEDURE updPACKAGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuPACKAGE_ID$ in LD_RESULT_CONSULT.PACKAGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENTIFICATION
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbIDENTIFICATION$ in LD_RESULT_CONSULT.IDENTIFICATION%type,
		inuLock in number default 0
	);

	PROCEDURE updIDENT_TYPE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuIDENT_TYPE_ID$ in LD_RESULT_CONSULT.IDENT_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updGENDER_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuGENDER_ID$ in LD_RESULT_CONSULT.GENDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updEFFECTIVE_STATE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbEFFECTIVE_STATE_ID$ in LD_RESULT_CONSULT.EFFECTIVE_STATE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updAGE_RANGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuAGE_RANGE_ID$ in LD_RESULT_CONSULT.AGE_RANGE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBSCRIBERNAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbSUBSCRIBERNAME$ in LD_RESULT_CONSULT.SUBSCRIBERNAME%type,
		inuLock in number default 0
	);

	PROCEDURE updCONSULT_CODES_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuCONSULT_CODES_ID$ in LD_RESULT_CONSULT.CONSULT_CODES_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updRESULT_CONSULT
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbRESULT_CONSULT$ in LD_RESULT_CONSULT.RESULT_CONSULT%type,
		inuLock in number default 0
	);

	PROCEDURE updNUMBER_REQUEST
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuNUMBER_REQUEST$ in LD_RESULT_CONSULT.NUMBER_REQUEST%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbTERMINAL$ in LD_RESULT_CONSULT.TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbUSER_NAME$ in LD_RESULT_CONSULT.USER_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updCONSULTATION_DATE
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		idtCONSULTATION_DATE$ in LD_RESULT_CONSULT.CONSULTATION_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPARTAMENT_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbDEPARTAMENT_ISSUED$ in LD_RESULT_CONSULT.DEPARTAMENT_ISSUED%type,
		inuLock in number default 0
	);

	PROCEDURE updCITY_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbCITY_ISSUED$ in LD_RESULT_CONSULT.CITY_ISSUED%type,
		inuLock in number default 0
	);

	PROCEDURE updDATE_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		idtDATE_ISSUED$ in LD_RESULT_CONSULT.DATE_ISSUED%type,
		inuLock in number default 0
	);

	PROCEDURE updSECOND_LAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbSECOND_LAST_NAME$ in LD_RESULT_CONSULT.SECOND_LAST_NAME%type,
		inuLock in number default 0
	);

	PROCEDURE updLAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbLAST_NAME$ in LD_RESULT_CONSULT.LAST_NAME%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetPACKAGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.PACKAGE_ID%type;

	FUNCTION fnuGetRESULT_CONSULT_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.RESULT_CONSULT_ID%type;

	FUNCTION fsbGetIDENTIFICATION
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.IDENTIFICATION%type;

	FUNCTION fnuGetIDENT_TYPE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.IDENT_TYPE_ID%type;

	FUNCTION fnuGetGENDER_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.GENDER_ID%type;

	FUNCTION fsbGetEFFECTIVE_STATE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.EFFECTIVE_STATE_ID%type;

	FUNCTION fnuGetAGE_RANGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.AGE_RANGE_ID%type;

	FUNCTION fsbGetSUBSCRIBERNAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.SUBSCRIBERNAME%type;

	FUNCTION fnuGetCONSULT_CODES_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.CONSULT_CODES_ID%type;

	FUNCTION fsbGetRESULT_CONSULT
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.RESULT_CONSULT%type;

	FUNCTION fnuGetNUMBER_REQUEST
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.NUMBER_REQUEST%type;

	FUNCTION fsbGetTERMINAL
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.TERMINAL%type;

	FUNCTION fsbGetUSER_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.USER_NAME%type;

	FUNCTION fdtGetCONSULTATION_DATE
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.CONSULTATION_DATE%type;

	FUNCTION fsbGetDEPARTAMENT_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.DEPARTAMENT_ISSUED%type;

	FUNCTION fsbGetCITY_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.CITY_ISSUED%type;

	FUNCTION fdtGetDATE_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.DATE_ISSUED%type;

	FUNCTION fsbGetSECOND_LAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.SECOND_LAST_NAME%type;

	FUNCTION fsbGetLAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.LAST_NAME%type;


	PROCEDURE LockByPk
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		orcLD_RESULT_CONSULT  out styLD_RESULT_CONSULT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_RESULT_CONSULT  out styLD_RESULT_CONSULT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALD_RESULT_CONSULT;
/
CREATE OR REPLACE PACKAGE BODY ADM_PERSON.DALD_RESULT_CONSULT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO213740';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LD_RESULT_CONSULT';
	 cnuGeEntityId constant varchar2(30) := 7682; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	IS
		SELECT LD_RESULT_CONSULT.*,LD_RESULT_CONSULT.rowid
		FROM LD_RESULT_CONSULT
		WHERE  RESULT_CONSULT_ID = inuRESULT_CONSULT_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LD_RESULT_CONSULT.*,LD_RESULT_CONSULT.rowid
		FROM LD_RESULT_CONSULT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLD_RESULT_CONSULT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLD_RESULT_CONSULT;

	rcData cuRecord%rowtype;

    blDAO_USE_CACHE    boolean := null;


	/* Metodos privados */
	FUNCTION fsbGetMessageDescription
	return varchar2
	is
	      sbTableDescription varchar2(32000);
	BEGIN
	    if (cnuGeEntityId > 0 and dage_entity.fblExist (cnuGeEntityId))  then
	          sbTableDescription:= dage_entity.fsbGetDisplay_name(cnuGeEntityId);
	    else
	          sbTableDescription:= csbTABLEPARAMETER;
	    end if;

		return sbTableDescription ;
	END;

	PROCEDURE GetDAO_USE_CACHE
	IS
	BEGIN
	    if ( blDAO_USE_CACHE is null ) then
	        blDAO_USE_CACHE :=  ge_boparameter.fsbget('DAO_USE_CACHE') = 'Y';
	    end if;
	END;
	FUNCTION fsbPrimaryKey( rcI in styLD_RESULT_CONSULT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.RESULT_CONSULT_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		orcLD_RESULT_CONSULT  out styLD_RESULT_CONSULT
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

		Open cuLockRcByPk
		(
			inuRESULT_CONSULT_ID
		);

		fetch cuLockRcByPk into orcLD_RESULT_CONSULT;
		if cuLockRcByPk%notfound  then
			close cuLockRcByPk;
			raise no_data_found;
		end if;
		close cuLockRcByPk ;
	EXCEPTION
		when no_data_found then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
		when ex.RESOURCE_BUSY THEN
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			errors.setError(cnuAPPTABLEBUSSY,fsbPrimaryKey(rcError)||'|'|| fsbGetMessageDescription );
			raise ex.controlled_error;
		when others then
			if cuLockRcByPk%isopen then
				close cuLockRcByPk;
			end if;
			raise;
	END;
	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLD_RESULT_CONSULT  out styLD_RESULT_CONSULT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLD_RESULT_CONSULT;
		if cuLockRcbyRowId%notfound  then
			close cuLockRcbyRowId;
			raise no_data_found;
		end if;
		close cuLockRcbyRowId;
	EXCEPTION
		when no_data_found then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
			raise ex.CONTROLLED_ERROR;
		when ex.RESOURCE_BUSY THEN
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			errors.setError(cnuAPPTABLEBUSSY,'rowid=['||irirowid||']|'||fsbGetMessageDescription );
			raise ex.controlled_error;
		when others then
			if cuLockRcbyRowId%isopen then
				close cuLockRcbyRowId;
			end if;
			raise;
	END;
	PROCEDURE DelRecordOfTables
	(
		itbLD_RESULT_CONSULT  in out nocopy tytbLD_RESULT_CONSULT
	)
	IS
	BEGIN
			rcRecOfTab.PACKAGE_ID.delete;
			rcRecOfTab.RESULT_CONSULT_ID.delete;
			rcRecOfTab.IDENTIFICATION.delete;
			rcRecOfTab.IDENT_TYPE_ID.delete;
			rcRecOfTab.GENDER_ID.delete;
			rcRecOfTab.EFFECTIVE_STATE_ID.delete;
			rcRecOfTab.AGE_RANGE_ID.delete;
			rcRecOfTab.SUBSCRIBERNAME.delete;
			rcRecOfTab.CONSULT_CODES_ID.delete;
			rcRecOfTab.RESULT_CONSULT.delete;
			rcRecOfTab.NUMBER_REQUEST.delete;
			rcRecOfTab.TERMINAL.delete;
			rcRecOfTab.USER_NAME.delete;
			rcRecOfTab.CONSULTATION_DATE.delete;
			rcRecOfTab.DEPARTAMENT_ISSUED.delete;
			rcRecOfTab.CITY_ISSUED.delete;
			rcRecOfTab.DATE_ISSUED.delete;
			rcRecOfTab.SECOND_LAST_NAME.delete;
			rcRecOfTab.LAST_NAME.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLD_RESULT_CONSULT  in out nocopy tytbLD_RESULT_CONSULT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLD_RESULT_CONSULT);

		for n in itbLD_RESULT_CONSULT.first .. itbLD_RESULT_CONSULT.last loop
			rcRecOfTab.PACKAGE_ID(n) := itbLD_RESULT_CONSULT(n).PACKAGE_ID;
			rcRecOfTab.RESULT_CONSULT_ID(n) := itbLD_RESULT_CONSULT(n).RESULT_CONSULT_ID;
			rcRecOfTab.IDENTIFICATION(n) := itbLD_RESULT_CONSULT(n).IDENTIFICATION;
			rcRecOfTab.IDENT_TYPE_ID(n) := itbLD_RESULT_CONSULT(n).IDENT_TYPE_ID;
			rcRecOfTab.GENDER_ID(n) := itbLD_RESULT_CONSULT(n).GENDER_ID;
			rcRecOfTab.EFFECTIVE_STATE_ID(n) := itbLD_RESULT_CONSULT(n).EFFECTIVE_STATE_ID;
			rcRecOfTab.AGE_RANGE_ID(n) := itbLD_RESULT_CONSULT(n).AGE_RANGE_ID;
			rcRecOfTab.SUBSCRIBERNAME(n) := itbLD_RESULT_CONSULT(n).SUBSCRIBERNAME;
			rcRecOfTab.CONSULT_CODES_ID(n) := itbLD_RESULT_CONSULT(n).CONSULT_CODES_ID;
			rcRecOfTab.RESULT_CONSULT(n) := itbLD_RESULT_CONSULT(n).RESULT_CONSULT;
			rcRecOfTab.NUMBER_REQUEST(n) := itbLD_RESULT_CONSULT(n).NUMBER_REQUEST;
			rcRecOfTab.TERMINAL(n) := itbLD_RESULT_CONSULT(n).TERMINAL;
			rcRecOfTab.USER_NAME(n) := itbLD_RESULT_CONSULT(n).USER_NAME;
			rcRecOfTab.CONSULTATION_DATE(n) := itbLD_RESULT_CONSULT(n).CONSULTATION_DATE;
			rcRecOfTab.DEPARTAMENT_ISSUED(n) := itbLD_RESULT_CONSULT(n).DEPARTAMENT_ISSUED;
			rcRecOfTab.CITY_ISSUED(n) := itbLD_RESULT_CONSULT(n).CITY_ISSUED;
			rcRecOfTab.DATE_ISSUED(n) := itbLD_RESULT_CONSULT(n).DATE_ISSUED;
			rcRecOfTab.SECOND_LAST_NAME(n) := itbLD_RESULT_CONSULT(n).SECOND_LAST_NAME;
			rcRecOfTab.LAST_NAME(n) := itbLD_RESULT_CONSULT(n).LAST_NAME;
			rcRecOfTab.row_id(n) := itbLD_RESULT_CONSULT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuRESULT_CONSULT_ID
		);

		fetch cuRecord into rcData;
		if cuRecord%notfound  then
			close cuRecord;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecord;
	END;
	PROCEDURE LoadByRowId
	(
		irirowid in varchar2
	)
	IS
		rcRecordNull cuRecordByRowId%rowtype;
	BEGIN
		if cuRecordByRowId%isopen then
			close cuRecordByRowId;
		end if;
		open cuRecordByRowId
		(
			irirowid
		);

		fetch cuRecordByRowId into rcData;
		if cuRecordByRowId%notfound  then
			close cuRecordByRowId;
			rcData := rcRecordNull;
			raise no_data_found;
		end if;
		close cuRecordByRowId;
	END;
	FUNCTION fblAlreadyLoaded
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuRESULT_CONSULT_ID = rcData.RESULT_CONSULT_ID
		   ) then
			return ( true );
		end if;
		return (false);
	END;

	/***** Fin metodos privados *****/

	/***** Metodos publicos ******/
    FUNCTION fsbVersion
    RETURN varchar2
	IS
	BEGIN
		return csbVersion;
	END;
	PROCEDURE ClearMemory
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		rcData := rcRecordNull;
	END;
	FUNCTION fblExist
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuRESULT_CONSULT_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN		rcError.RESULT_CONSULT_ID:=inuRESULT_CONSULT_ID;

		Load
		(
			inuRESULT_CONSULT_ID
		);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	)
	IS
	BEGIN
		LoadByRowId
		(
			iriRowID
		);
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE ValDuplicate
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuRESULT_CONSULT_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		orcRecord out nocopy styLD_RESULT_CONSULT
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN		rcError.RESULT_CONSULT_ID:=inuRESULT_CONSULT_ID;

		Load
		(
			inuRESULT_CONSULT_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN styLD_RESULT_CONSULT
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID:=inuRESULT_CONSULT_ID;

		Load
		(
			inuRESULT_CONSULT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	)
	RETURN styLD_RESULT_CONSULT
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID:=inuRESULT_CONSULT_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuRESULT_CONSULT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLD_RESULT_CONSULT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLD_RESULT_CONSULT
	)
	IS
		rfLD_RESULT_CONSULT tyrfLD_RESULT_CONSULT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LD_RESULT_CONSULT.*, LD_RESULT_CONSULT.rowid FROM LD_RESULT_CONSULT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLD_RESULT_CONSULT for sbFullQuery;

		fetch rfLD_RESULT_CONSULT bulk collect INTO otbResult;

		close rfLD_RESULT_CONSULT;
		if otbResult.count = 0  then
			raise no_data_found;
		end if;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor
	IS
		rfQuery tyRefCursor;
		sbSQL VARCHAR2 (32000) := 'select LD_RESULT_CONSULT.*, LD_RESULT_CONSULT.rowid FROM LD_RESULT_CONSULT';
	BEGIN
		if isbCriteria is not null then
			sbSQL := sbSQL||' where '||isbCriteria;
		end if;
		if iblLock then
			sbSQL := sbSQL||' for update nowait';
		end if;
		open rfQuery for sbSQL;
		return(rfQuery);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecord
	(
		ircLD_RESULT_CONSULT in styLD_RESULT_CONSULT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLD_RESULT_CONSULT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLD_RESULT_CONSULT in styLD_RESULT_CONSULT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLD_RESULT_CONSULT.RESULT_CONSULT_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|RESULT_CONSULT_ID');
			raise ex.controlled_error;
		end if;

		insert into LD_RESULT_CONSULT
		(
			PACKAGE_ID,
			RESULT_CONSULT_ID,
			IDENTIFICATION,
			IDENT_TYPE_ID,
			GENDER_ID,
			EFFECTIVE_STATE_ID,
			AGE_RANGE_ID,
			SUBSCRIBERNAME,
			CONSULT_CODES_ID,
			RESULT_CONSULT,
			NUMBER_REQUEST,
			TERMINAL,
			USER_NAME,
			CONSULTATION_DATE,
			DEPARTAMENT_ISSUED,
			CITY_ISSUED,
			DATE_ISSUED,
			SECOND_LAST_NAME,
			LAST_NAME
		)
		values
		(
			ircLD_RESULT_CONSULT.PACKAGE_ID,
			ircLD_RESULT_CONSULT.RESULT_CONSULT_ID,
			ircLD_RESULT_CONSULT.IDENTIFICATION,
			ircLD_RESULT_CONSULT.IDENT_TYPE_ID,
			ircLD_RESULT_CONSULT.GENDER_ID,
			ircLD_RESULT_CONSULT.EFFECTIVE_STATE_ID,
			ircLD_RESULT_CONSULT.AGE_RANGE_ID,
			ircLD_RESULT_CONSULT.SUBSCRIBERNAME,
			ircLD_RESULT_CONSULT.CONSULT_CODES_ID,
			ircLD_RESULT_CONSULT.RESULT_CONSULT,
			ircLD_RESULT_CONSULT.NUMBER_REQUEST,
			ircLD_RESULT_CONSULT.TERMINAL,
			ircLD_RESULT_CONSULT.USER_NAME,
			ircLD_RESULT_CONSULT.CONSULTATION_DATE,
			ircLD_RESULT_CONSULT.DEPARTAMENT_ISSUED,
			ircLD_RESULT_CONSULT.CITY_ISSUED,
			ircLD_RESULT_CONSULT.DATE_ISSUED,
			ircLD_RESULT_CONSULT.SECOND_LAST_NAME,
			ircLD_RESULT_CONSULT.LAST_NAME
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLD_RESULT_CONSULT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLD_RESULT_CONSULT in out nocopy tytbLD_RESULT_CONSULT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLD_RESULT_CONSULT,blUseRowID);
		forall n in iotbLD_RESULT_CONSULT.first..iotbLD_RESULT_CONSULT.last
			insert into LD_RESULT_CONSULT
			(
				PACKAGE_ID,
				RESULT_CONSULT_ID,
				IDENTIFICATION,
				IDENT_TYPE_ID,
				GENDER_ID,
				EFFECTIVE_STATE_ID,
				AGE_RANGE_ID,
				SUBSCRIBERNAME,
				CONSULT_CODES_ID,
				RESULT_CONSULT,
				NUMBER_REQUEST,
				TERMINAL,
				USER_NAME,
				CONSULTATION_DATE,
				DEPARTAMENT_ISSUED,
				CITY_ISSUED,
				DATE_ISSUED,
				SECOND_LAST_NAME,
				LAST_NAME
			)
			values
			(
				rcRecOfTab.PACKAGE_ID(n),
				rcRecOfTab.RESULT_CONSULT_ID(n),
				rcRecOfTab.IDENTIFICATION(n),
				rcRecOfTab.IDENT_TYPE_ID(n),
				rcRecOfTab.GENDER_ID(n),
				rcRecOfTab.EFFECTIVE_STATE_ID(n),
				rcRecOfTab.AGE_RANGE_ID(n),
				rcRecOfTab.SUBSCRIBERNAME(n),
				rcRecOfTab.CONSULT_CODES_ID(n),
				rcRecOfTab.RESULT_CONSULT(n),
				rcRecOfTab.NUMBER_REQUEST(n),
				rcRecOfTab.TERMINAL(n),
				rcRecOfTab.USER_NAME(n),
				rcRecOfTab.CONSULTATION_DATE(n),
				rcRecOfTab.DEPARTAMENT_ISSUED(n),
				rcRecOfTab.CITY_ISSUED(n),
				rcRecOfTab.DATE_ISSUED(n),
				rcRecOfTab.SECOND_LAST_NAME(n),
				rcRecOfTab.LAST_NAME(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;


		delete
		from LD_RESULT_CONSULT
		where
       		RESULT_CONSULT_ID=inuRESULT_CONSULT_ID;
            if sql%notfound then
                raise no_data_found;
            end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
         raise ex.CONTROLLED_ERROR;
		when ex.RECORD_HAVE_CHILDREN then
			Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	)
	IS
		rcRecordNull cuRecord%rowtype;
		rcError  styLD_RESULT_CONSULT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LD_RESULT_CONSULT
		where
			rowid = iriRowID
		returning
			PACKAGE_ID
		into
			rcError.PACKAGE_ID;
            if sql%notfound then
			 raise no_data_found;
		    end if;
            if rcData.rowID=iriRowID then
			 rcData := rcRecordNull;
		    end if;
	EXCEPTION
		when no_data_found then
            Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
		when ex.RECORD_HAVE_CHILDREN then
            Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription||' '||' rowid=['||iriRowID||']');
            raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecords
	(
		iotbLD_RESULT_CONSULT in out nocopy tytbLD_RESULT_CONSULT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_RESULT_CONSULT;
	BEGIN
		FillRecordOfTables(iotbLD_RESULT_CONSULT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last
				delete
				from LD_RESULT_CONSULT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last loop
					LockByPk
					(
						rcRecOfTab.RESULT_CONSULT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last
				delete
				from LD_RESULT_CONSULT
				where
		         	RESULT_CONSULT_ID = rcRecOfTab.RESULT_CONSULT_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLD_RESULT_CONSULT in styLD_RESULT_CONSULT,
		inuLock in number default 0
	)
	IS
		nuRESULT_CONSULT_ID	LD_RESULT_CONSULT.RESULT_CONSULT_ID%type;
	BEGIN
		if ircLD_RESULT_CONSULT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLD_RESULT_CONSULT.rowid,rcData);
			end if;
			update LD_RESULT_CONSULT
			set
				PACKAGE_ID = ircLD_RESULT_CONSULT.PACKAGE_ID,
				IDENTIFICATION = ircLD_RESULT_CONSULT.IDENTIFICATION,
				IDENT_TYPE_ID = ircLD_RESULT_CONSULT.IDENT_TYPE_ID,
				GENDER_ID = ircLD_RESULT_CONSULT.GENDER_ID,
				EFFECTIVE_STATE_ID = ircLD_RESULT_CONSULT.EFFECTIVE_STATE_ID,
				AGE_RANGE_ID = ircLD_RESULT_CONSULT.AGE_RANGE_ID,
				SUBSCRIBERNAME = ircLD_RESULT_CONSULT.SUBSCRIBERNAME,
				CONSULT_CODES_ID = ircLD_RESULT_CONSULT.CONSULT_CODES_ID,
				RESULT_CONSULT = ircLD_RESULT_CONSULT.RESULT_CONSULT,
				NUMBER_REQUEST = ircLD_RESULT_CONSULT.NUMBER_REQUEST,
				TERMINAL = ircLD_RESULT_CONSULT.TERMINAL,
				USER_NAME = ircLD_RESULT_CONSULT.USER_NAME,
				CONSULTATION_DATE = ircLD_RESULT_CONSULT.CONSULTATION_DATE,
				DEPARTAMENT_ISSUED = ircLD_RESULT_CONSULT.DEPARTAMENT_ISSUED,
				CITY_ISSUED = ircLD_RESULT_CONSULT.CITY_ISSUED,
				DATE_ISSUED = ircLD_RESULT_CONSULT.DATE_ISSUED,
				SECOND_LAST_NAME = ircLD_RESULT_CONSULT.SECOND_LAST_NAME,
				LAST_NAME = ircLD_RESULT_CONSULT.LAST_NAME
			where
				rowid = ircLD_RESULT_CONSULT.rowid
			returning
				RESULT_CONSULT_ID
			into
				nuRESULT_CONSULT_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLD_RESULT_CONSULT.RESULT_CONSULT_ID,
					rcData
				);
			end if;

			update LD_RESULT_CONSULT
			set
				PACKAGE_ID = ircLD_RESULT_CONSULT.PACKAGE_ID,
				IDENTIFICATION = ircLD_RESULT_CONSULT.IDENTIFICATION,
				IDENT_TYPE_ID = ircLD_RESULT_CONSULT.IDENT_TYPE_ID,
				GENDER_ID = ircLD_RESULT_CONSULT.GENDER_ID,
				EFFECTIVE_STATE_ID = ircLD_RESULT_CONSULT.EFFECTIVE_STATE_ID,
				AGE_RANGE_ID = ircLD_RESULT_CONSULT.AGE_RANGE_ID,
				SUBSCRIBERNAME = ircLD_RESULT_CONSULT.SUBSCRIBERNAME,
				CONSULT_CODES_ID = ircLD_RESULT_CONSULT.CONSULT_CODES_ID,
				RESULT_CONSULT = ircLD_RESULT_CONSULT.RESULT_CONSULT,
				NUMBER_REQUEST = ircLD_RESULT_CONSULT.NUMBER_REQUEST,
				TERMINAL = ircLD_RESULT_CONSULT.TERMINAL,
				USER_NAME = ircLD_RESULT_CONSULT.USER_NAME,
				CONSULTATION_DATE = ircLD_RESULT_CONSULT.CONSULTATION_DATE,
				DEPARTAMENT_ISSUED = ircLD_RESULT_CONSULT.DEPARTAMENT_ISSUED,
				CITY_ISSUED = ircLD_RESULT_CONSULT.CITY_ISSUED,
				DATE_ISSUED = ircLD_RESULT_CONSULT.DATE_ISSUED,
				SECOND_LAST_NAME = ircLD_RESULT_CONSULT.SECOND_LAST_NAME,
				LAST_NAME = ircLD_RESULT_CONSULT.LAST_NAME
			where
				RESULT_CONSULT_ID = ircLD_RESULT_CONSULT.RESULT_CONSULT_ID
			returning
				RESULT_CONSULT_ID
			into
				nuRESULT_CONSULT_ID;
		end if;
		if
			nuRESULT_CONSULT_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLD_RESULT_CONSULT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLD_RESULT_CONSULT in out nocopy tytbLD_RESULT_CONSULT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLD_RESULT_CONSULT;
	BEGIN
		FillRecordOfTables(iotbLD_RESULT_CONSULT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last
				update LD_RESULT_CONSULT
				set
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					IDENTIFICATION = rcRecOfTab.IDENTIFICATION(n),
					IDENT_TYPE_ID = rcRecOfTab.IDENT_TYPE_ID(n),
					GENDER_ID = rcRecOfTab.GENDER_ID(n),
					EFFECTIVE_STATE_ID = rcRecOfTab.EFFECTIVE_STATE_ID(n),
					AGE_RANGE_ID = rcRecOfTab.AGE_RANGE_ID(n),
					SUBSCRIBERNAME = rcRecOfTab.SUBSCRIBERNAME(n),
					CONSULT_CODES_ID = rcRecOfTab.CONSULT_CODES_ID(n),
					RESULT_CONSULT = rcRecOfTab.RESULT_CONSULT(n),
					NUMBER_REQUEST = rcRecOfTab.NUMBER_REQUEST(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					USER_NAME = rcRecOfTab.USER_NAME(n),
					CONSULTATION_DATE = rcRecOfTab.CONSULTATION_DATE(n),
					DEPARTAMENT_ISSUED = rcRecOfTab.DEPARTAMENT_ISSUED(n),
					CITY_ISSUED = rcRecOfTab.CITY_ISSUED(n),
					DATE_ISSUED = rcRecOfTab.DATE_ISSUED(n),
					SECOND_LAST_NAME = rcRecOfTab.SECOND_LAST_NAME(n),
					LAST_NAME = rcRecOfTab.LAST_NAME(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last loop
					LockByPk
					(
						rcRecOfTab.RESULT_CONSULT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLD_RESULT_CONSULT.first .. iotbLD_RESULT_CONSULT.last
				update LD_RESULT_CONSULT
				SET
					PACKAGE_ID = rcRecOfTab.PACKAGE_ID(n),
					IDENTIFICATION = rcRecOfTab.IDENTIFICATION(n),
					IDENT_TYPE_ID = rcRecOfTab.IDENT_TYPE_ID(n),
					GENDER_ID = rcRecOfTab.GENDER_ID(n),
					EFFECTIVE_STATE_ID = rcRecOfTab.EFFECTIVE_STATE_ID(n),
					AGE_RANGE_ID = rcRecOfTab.AGE_RANGE_ID(n),
					SUBSCRIBERNAME = rcRecOfTab.SUBSCRIBERNAME(n),
					CONSULT_CODES_ID = rcRecOfTab.CONSULT_CODES_ID(n),
					RESULT_CONSULT = rcRecOfTab.RESULT_CONSULT(n),
					NUMBER_REQUEST = rcRecOfTab.NUMBER_REQUEST(n),
					TERMINAL = rcRecOfTab.TERMINAL(n),
					USER_NAME = rcRecOfTab.USER_NAME(n),
					CONSULTATION_DATE = rcRecOfTab.CONSULTATION_DATE(n),
					DEPARTAMENT_ISSUED = rcRecOfTab.DEPARTAMENT_ISSUED(n),
					CITY_ISSUED = rcRecOfTab.CITY_ISSUED(n),
					DATE_ISSUED = rcRecOfTab.DATE_ISSUED(n),
					SECOND_LAST_NAME = rcRecOfTab.SECOND_LAST_NAME(n),
					LAST_NAME = rcRecOfTab.LAST_NAME(n)
				where
					RESULT_CONSULT_ID = rcRecOfTab.RESULT_CONSULT_ID(n)
;
		end if;
	END;
	PROCEDURE updPACKAGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuPACKAGE_ID$ in LD_RESULT_CONSULT.PACKAGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			PACKAGE_ID = inuPACKAGE_ID$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PACKAGE_ID:= inuPACKAGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENTIFICATION
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbIDENTIFICATION$ in LD_RESULT_CONSULT.IDENTIFICATION%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			IDENTIFICATION = isbIDENTIFICATION$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENTIFICATION:= isbIDENTIFICATION$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIDENT_TYPE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuIDENT_TYPE_ID$ in LD_RESULT_CONSULT.IDENT_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			IDENT_TYPE_ID = inuIDENT_TYPE_ID$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IDENT_TYPE_ID:= inuIDENT_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGENDER_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuGENDER_ID$ in LD_RESULT_CONSULT.GENDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			GENDER_ID = inuGENDER_ID$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GENDER_ID:= inuGENDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updEFFECTIVE_STATE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbEFFECTIVE_STATE_ID$ in LD_RESULT_CONSULT.EFFECTIVE_STATE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			EFFECTIVE_STATE_ID = isbEFFECTIVE_STATE_ID$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.EFFECTIVE_STATE_ID:= isbEFFECTIVE_STATE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updAGE_RANGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuAGE_RANGE_ID$ in LD_RESULT_CONSULT.AGE_RANGE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			AGE_RANGE_ID = inuAGE_RANGE_ID$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.AGE_RANGE_ID:= inuAGE_RANGE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBSCRIBERNAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbSUBSCRIBERNAME$ in LD_RESULT_CONSULT.SUBSCRIBERNAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			SUBSCRIBERNAME = isbSUBSCRIBERNAME$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIBERNAME:= isbSUBSCRIBERNAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONSULT_CODES_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuCONSULT_CODES_ID$ in LD_RESULT_CONSULT.CONSULT_CODES_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			CONSULT_CODES_ID = inuCONSULT_CODES_ID$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONSULT_CODES_ID:= inuCONSULT_CODES_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRESULT_CONSULT
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbRESULT_CONSULT$ in LD_RESULT_CONSULT.RESULT_CONSULT%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			RESULT_CONSULT = isbRESULT_CONSULT$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RESULT_CONSULT:= isbRESULT_CONSULT$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updNUMBER_REQUEST
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuNUMBER_REQUEST$ in LD_RESULT_CONSULT.NUMBER_REQUEST%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			NUMBER_REQUEST = inuNUMBER_REQUEST$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.NUMBER_REQUEST:= inuNUMBER_REQUEST$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbTERMINAL$ in LD_RESULT_CONSULT.TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			TERMINAL = isbTERMINAL$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL:= isbTERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbUSER_NAME$ in LD_RESULT_CONSULT.USER_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			USER_NAME = isbUSER_NAME$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_NAME:= isbUSER_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCONSULTATION_DATE
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		idtCONSULTATION_DATE$ in LD_RESULT_CONSULT.CONSULTATION_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			CONSULTATION_DATE = idtCONSULTATION_DATE$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CONSULTATION_DATE:= idtCONSULTATION_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPARTAMENT_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbDEPARTAMENT_ISSUED$ in LD_RESULT_CONSULT.DEPARTAMENT_ISSUED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			DEPARTAMENT_ISSUED = isbDEPARTAMENT_ISSUED$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPARTAMENT_ISSUED:= isbDEPARTAMENT_ISSUED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCITY_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbCITY_ISSUED$ in LD_RESULT_CONSULT.CITY_ISSUED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			CITY_ISSUED = isbCITY_ISSUED$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CITY_ISSUED:= isbCITY_ISSUED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDATE_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		idtDATE_ISSUED$ in LD_RESULT_CONSULT.DATE_ISSUED%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			DATE_ISSUED = idtDATE_ISSUED$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DATE_ISSUED:= idtDATE_ISSUED$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSECOND_LAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbSECOND_LAST_NAME$ in LD_RESULT_CONSULT.SECOND_LAST_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			SECOND_LAST_NAME = isbSECOND_LAST_NAME$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SECOND_LAST_NAME:= isbSECOND_LAST_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		isbLAST_NAME$ in LD_RESULT_CONSULT.LAST_NAME%type,
		inuLock in number default 0
	)
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN
		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuRESULT_CONSULT_ID,
				rcData
			);
		end if;

		update LD_RESULT_CONSULT
		set
			LAST_NAME = isbLAST_NAME$
		where
			RESULT_CONSULT_ID = inuRESULT_CONSULT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LAST_NAME:= isbLAST_NAME$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetPACKAGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.PACKAGE_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.PACKAGE_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.PACKAGE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRESULT_CONSULT_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.RESULT_CONSULT_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.RESULT_CONSULT_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.RESULT_CONSULT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIDENTIFICATION
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.IDENTIFICATION%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.IDENTIFICATION);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.IDENTIFICATION);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetIDENT_TYPE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.IDENT_TYPE_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.IDENT_TYPE_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.IDENT_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetGENDER_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.GENDER_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.GENDER_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.GENDER_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetEFFECTIVE_STATE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.EFFECTIVE_STATE_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.EFFECTIVE_STATE_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.EFFECTIVE_STATE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetAGE_RANGE_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.AGE_RANGE_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.AGE_RANGE_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.AGE_RANGE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSUBSCRIBERNAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.SUBSCRIBERNAME%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.SUBSCRIBERNAME);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.SUBSCRIBERNAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCONSULT_CODES_ID
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.CONSULT_CODES_ID%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.CONSULT_CODES_ID);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.CONSULT_CODES_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetRESULT_CONSULT
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.RESULT_CONSULT%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.RESULT_CONSULT);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.RESULT_CONSULT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetNUMBER_REQUEST
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.NUMBER_REQUEST%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.NUMBER_REQUEST);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.NUMBER_REQUEST);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.TERMINAL%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.TERMINAL);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.TERMINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.USER_NAME%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.USER_NAME);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.USER_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetCONSULTATION_DATE
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.CONSULTATION_DATE%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.CONSULTATION_DATE);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.CONSULTATION_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetDEPARTAMENT_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.DEPARTAMENT_ISSUED%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.DEPARTAMENT_ISSUED);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.DEPARTAMENT_ISSUED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCITY_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.CITY_ISSUED%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.CITY_ISSUED);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.CITY_ISSUED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetDATE_ISSUED
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.DATE_ISSUED%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.DATE_ISSUED);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.DATE_ISSUED);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSECOND_LAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.SECOND_LAST_NAME%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.SECOND_LAST_NAME);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.SECOND_LAST_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetLAST_NAME
	(
		inuRESULT_CONSULT_ID in LD_RESULT_CONSULT.RESULT_CONSULT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LD_RESULT_CONSULT.LAST_NAME%type
	IS
		rcError styLD_RESULT_CONSULT;
	BEGIN

		rcError.RESULT_CONSULT_ID := inuRESULT_CONSULT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuRESULT_CONSULT_ID
			 )
		then
			 return(rcData.LAST_NAME);
		end if;
		Load
		(
		 		inuRESULT_CONSULT_ID
		);
		return(rcData.LAST_NAME);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALD_RESULT_CONSULT;
/
PROMPT Otorgando permisos de ejecucion a DALD_RESULT_CONSULT
BEGIN
    pkg_utilidades.praplicarpermisos('DALD_RESULT_CONSULT', 'ADM_PERSON');
END;
/
