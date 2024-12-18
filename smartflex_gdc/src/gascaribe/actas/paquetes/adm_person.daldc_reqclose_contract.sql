CREATE OR REPLACE PACKAGE adm_person.daldc_reqclose_contract
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	IS
		SELECT LDC_REQCLOSE_CONTRACT.*,LDC_REQCLOSE_CONTRACT.rowid
		FROM LDC_REQCLOSE_CONTRACT
		WHERE
		    ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_REQCLOSE_CONTRACT.*,LDC_REQCLOSE_CONTRACT.rowid
		FROM LDC_REQCLOSE_CONTRACT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_REQCLOSE_CONTRACT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_REQCLOSE_CONTRACT is table of styLDC_REQCLOSE_CONTRACT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_REQCLOSE_CONTRACT;

	/* Tipos referenciando al registro */
	type tytbID_REQCLOSE_CONTRACT is table of LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type index by binary_integer;
	type tytbID_CONTRATO is table of LDC_REQCLOSE_CONTRACT.ID_CONTRATO%type index by binary_integer;
	type tytbUSER_REQUEST_APPROVE is table of LDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE%type index by binary_integer;
	type tytbUSER_REQUEST_TERMINAL is table of LDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL%type index by binary_integer;
	type tytbREQUEST_DATE is table of LDC_REQCLOSE_CONTRACT.REQUEST_DATE%type index by binary_integer;
	type tytbREQUEST_COMMENTS is table of LDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS%type index by binary_integer;
	type tytbUSER_ is table of LDC_REQCLOSE_CONTRACT.USER_%type index by binary_integer;
	type tytbTERMINAL_ is table of LDC_REQCLOSE_CONTRACT.TERMINAL_%type index by binary_integer;
	type tytbPROCESS_DATE is table of LDC_REQCLOSE_CONTRACT.PROCESS_DATE%type index by binary_integer;
	type tytbCOMMENTS_ is table of LDC_REQCLOSE_CONTRACT.COMMENTS_%type index by binary_integer;
	type tytbREVERSE_USER is table of LDC_REQCLOSE_CONTRACT.REVERSE_USER%type index by binary_integer;
	type tytbREVERSE_TERMINAL is table of LDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL%type index by binary_integer;
	type tytbREVERSE_DATE is table of LDC_REQCLOSE_CONTRACT.REVERSE_DATE%type index by binary_integer;
	type tytbREVERSE_COMMENTS is table of LDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS%type index by binary_integer;
	type tytbSTATE_REQUEST is table of LDC_REQCLOSE_CONTRACT.STATE_REQUEST%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_REQCLOSE_CONTRACT is record
	(
		ID_REQCLOSE_CONTRACT   tytbID_REQCLOSE_CONTRACT,
		ID_CONTRATO   tytbID_CONTRATO,
		USER_REQUEST_APPROVE   tytbUSER_REQUEST_APPROVE,
		USER_REQUEST_TERMINAL   tytbUSER_REQUEST_TERMINAL,
		REQUEST_DATE   tytbREQUEST_DATE,
		REQUEST_COMMENTS   tytbREQUEST_COMMENTS,
		USER_   tytbUSER_,
		TERMINAL_   tytbTERMINAL_,
		PROCESS_DATE   tytbPROCESS_DATE,
		COMMENTS_   tytbCOMMENTS_,
		REVERSE_USER   tytbREVERSE_USER,
		REVERSE_TERMINAL   tytbREVERSE_TERMINAL,
		REVERSE_DATE   tytbREVERSE_DATE,
		REVERSE_COMMENTS   tytbREVERSE_COMMENTS,
		STATE_REQUEST   tytbSTATE_REQUEST,
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
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	);

	PROCEDURE getRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		orcRecord out nocopy styLDC_REQCLOSE_CONTRACT
	);

	FUNCTION frcGetRcData
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN styLDC_REQCLOSE_CONTRACT;

	FUNCTION frcGetRcData
	RETURN styLDC_REQCLOSE_CONTRACT;

	FUNCTION frcGetRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN styLDC_REQCLOSE_CONTRACT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_REQCLOSE_CONTRACT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_REQCLOSE_CONTRACT in styLDC_REQCLOSE_CONTRACT
	);

	PROCEDURE insRecord
	(
		ircLDC_REQCLOSE_CONTRACT in styLDC_REQCLOSE_CONTRACT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_REQCLOSE_CONTRACT in out nocopy tytbLDC_REQCLOSE_CONTRACT
	);

	PROCEDURE delRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_REQCLOSE_CONTRACT in out nocopy tytbLDC_REQCLOSE_CONTRACT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_REQCLOSE_CONTRACT in styLDC_REQCLOSE_CONTRACT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_REQCLOSE_CONTRACT in out nocopy tytbLDC_REQCLOSE_CONTRACT,
		inuLock in number default 1
	);

	PROCEDURE updID_CONTRATO
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuID_CONTRATO$ in LDC_REQCLOSE_CONTRACT.ID_CONTRATO%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_REQUEST_APPROVE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbUSER_REQUEST_APPROVE$ in LDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_REQUEST_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbUSER_REQUEST_TERMINAL$ in LDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUEST_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		idtREQUEST_DATE$ in LDC_REQCLOSE_CONTRACT.REQUEST_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updREQUEST_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREQUEST_COMMENTS$ in LDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS%type,
		inuLock in number default 0
	);

	PROCEDURE updUSER_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbUSER_$ in LDC_REQCLOSE_CONTRACT.USER_%type,
		inuLock in number default 0
	);

	PROCEDURE updTERMINAL_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbTERMINAL_$ in LDC_REQCLOSE_CONTRACT.TERMINAL_%type,
		inuLock in number default 0
	);

	PROCEDURE updPROCESS_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		idtPROCESS_DATE$ in LDC_REQCLOSE_CONTRACT.PROCESS_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMMENTS_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbCOMMENTS_$ in LDC_REQCLOSE_CONTRACT.COMMENTS_%type,
		inuLock in number default 0
	);

	PROCEDURE updREVERSE_USER
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREVERSE_USER$ in LDC_REQCLOSE_CONTRACT.REVERSE_USER%type,
		inuLock in number default 0
	);

	PROCEDURE updREVERSE_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREVERSE_TERMINAL$ in LDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL%type,
		inuLock in number default 0
	);

	PROCEDURE updREVERSE_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		idtREVERSE_DATE$ in LDC_REQCLOSE_CONTRACT.REVERSE_DATE%type,
		inuLock in number default 0
	);

	PROCEDURE updREVERSE_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREVERSE_COMMENTS$ in LDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS%type,
		inuLock in number default 0
	);

	PROCEDURE updSTATE_REQUEST
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbSTATE_REQUEST$ in LDC_REQCLOSE_CONTRACT.STATE_REQUEST%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetID_REQCLOSE_CONTRACT
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type;

	FUNCTION fnuGetID_CONTRATO
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.ID_CONTRATO%type;

	FUNCTION fsbGetUSER_REQUEST_APPROVE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE%type;

	FUNCTION fsbGetUSER_REQUEST_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL%type;

	FUNCTION fdtGetREQUEST_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REQUEST_DATE%type;

	FUNCTION fsbGetREQUEST_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS%type;

	FUNCTION fsbGetUSER_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.USER_%type;

	FUNCTION fsbGetTERMINAL_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.TERMINAL_%type;

	FUNCTION fdtGetPROCESS_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.PROCESS_DATE%type;

	FUNCTION fsbGetCOMMENTS_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.COMMENTS_%type;

	FUNCTION fsbGetREVERSE_USER
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_USER%type;

	FUNCTION fsbGetREVERSE_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL%type;

	FUNCTION fdtGetREVERSE_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_DATE%type;

	FUNCTION fsbGetREVERSE_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS%type;

	FUNCTION fsbGetSTATE_REQUEST
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.STATE_REQUEST%type;


	PROCEDURE LockByPk
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		orcLDC_REQCLOSE_CONTRACT  out styLDC_REQCLOSE_CONTRACT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_REQCLOSE_CONTRACT  out styLDC_REQCLOSE_CONTRACT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_REQCLOSE_CONTRACT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_REQCLOSE_CONTRACT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO807';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_REQCLOSE_CONTRACT';
	 cnuGeEntityId constant varchar2(30) := 5803; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	IS
		SELECT LDC_REQCLOSE_CONTRACT.*,LDC_REQCLOSE_CONTRACT.rowid
		FROM LDC_REQCLOSE_CONTRACT
		WHERE  ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_REQCLOSE_CONTRACT.*,LDC_REQCLOSE_CONTRACT.rowid
		FROM LDC_REQCLOSE_CONTRACT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_REQCLOSE_CONTRACT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_REQCLOSE_CONTRACT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_REQCLOSE_CONTRACT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ID_REQCLOSE_CONTRACT);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		orcLDC_REQCLOSE_CONTRACT  out styLDC_REQCLOSE_CONTRACT
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

		Open cuLockRcByPk
		(
			inuID_REQCLOSE_CONTRACT
		);

		fetch cuLockRcByPk into orcLDC_REQCLOSE_CONTRACT;
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
		orcLDC_REQCLOSE_CONTRACT  out styLDC_REQCLOSE_CONTRACT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_REQCLOSE_CONTRACT;
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
		itbLDC_REQCLOSE_CONTRACT  in out nocopy tytbLDC_REQCLOSE_CONTRACT
	)
	IS
	BEGIN
			rcRecOfTab.ID_REQCLOSE_CONTRACT.delete;
			rcRecOfTab.ID_CONTRATO.delete;
			rcRecOfTab.USER_REQUEST_APPROVE.delete;
			rcRecOfTab.USER_REQUEST_TERMINAL.delete;
			rcRecOfTab.REQUEST_DATE.delete;
			rcRecOfTab.REQUEST_COMMENTS.delete;
			rcRecOfTab.USER_.delete;
			rcRecOfTab.TERMINAL_.delete;
			rcRecOfTab.PROCESS_DATE.delete;
			rcRecOfTab.COMMENTS_.delete;
			rcRecOfTab.REVERSE_USER.delete;
			rcRecOfTab.REVERSE_TERMINAL.delete;
			rcRecOfTab.REVERSE_DATE.delete;
			rcRecOfTab.REVERSE_COMMENTS.delete;
			rcRecOfTab.STATE_REQUEST.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_REQCLOSE_CONTRACT  in out nocopy tytbLDC_REQCLOSE_CONTRACT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_REQCLOSE_CONTRACT);

		for n in itbLDC_REQCLOSE_CONTRACT.first .. itbLDC_REQCLOSE_CONTRACT.last loop
			rcRecOfTab.ID_REQCLOSE_CONTRACT(n) := itbLDC_REQCLOSE_CONTRACT(n).ID_REQCLOSE_CONTRACT;
			rcRecOfTab.ID_CONTRATO(n) := itbLDC_REQCLOSE_CONTRACT(n).ID_CONTRATO;
			rcRecOfTab.USER_REQUEST_APPROVE(n) := itbLDC_REQCLOSE_CONTRACT(n).USER_REQUEST_APPROVE;
			rcRecOfTab.USER_REQUEST_TERMINAL(n) := itbLDC_REQCLOSE_CONTRACT(n).USER_REQUEST_TERMINAL;
			rcRecOfTab.REQUEST_DATE(n) := itbLDC_REQCLOSE_CONTRACT(n).REQUEST_DATE;
			rcRecOfTab.REQUEST_COMMENTS(n) := itbLDC_REQCLOSE_CONTRACT(n).REQUEST_COMMENTS;
			rcRecOfTab.USER_(n) := itbLDC_REQCLOSE_CONTRACT(n).USER_;
			rcRecOfTab.TERMINAL_(n) := itbLDC_REQCLOSE_CONTRACT(n).TERMINAL_;
			rcRecOfTab.PROCESS_DATE(n) := itbLDC_REQCLOSE_CONTRACT(n).PROCESS_DATE;
			rcRecOfTab.COMMENTS_(n) := itbLDC_REQCLOSE_CONTRACT(n).COMMENTS_;
			rcRecOfTab.REVERSE_USER(n) := itbLDC_REQCLOSE_CONTRACT(n).REVERSE_USER;
			rcRecOfTab.REVERSE_TERMINAL(n) := itbLDC_REQCLOSE_CONTRACT(n).REVERSE_TERMINAL;
			rcRecOfTab.REVERSE_DATE(n) := itbLDC_REQCLOSE_CONTRACT(n).REVERSE_DATE;
			rcRecOfTab.REVERSE_COMMENTS(n) := itbLDC_REQCLOSE_CONTRACT(n).REVERSE_COMMENTS;
			rcRecOfTab.STATE_REQUEST(n) := itbLDC_REQCLOSE_CONTRACT(n).STATE_REQUEST;
			rcRecOfTab.row_id(n) := itbLDC_REQCLOSE_CONTRACT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuID_REQCLOSE_CONTRACT
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
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuID_REQCLOSE_CONTRACT = rcData.ID_REQCLOSE_CONTRACT
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
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuID_REQCLOSE_CONTRACT
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN		rcError.ID_REQCLOSE_CONTRACT:=inuID_REQCLOSE_CONTRACT;

		Load
		(
			inuID_REQCLOSE_CONTRACT
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
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	IS
	BEGIN
		Load
		(
			inuID_REQCLOSE_CONTRACT
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		orcRecord out nocopy styLDC_REQCLOSE_CONTRACT
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN		rcError.ID_REQCLOSE_CONTRACT:=inuID_REQCLOSE_CONTRACT;

		Load
		(
			inuID_REQCLOSE_CONTRACT
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN styLDC_REQCLOSE_CONTRACT
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT:=inuID_REQCLOSE_CONTRACT;

		Load
		(
			inuID_REQCLOSE_CONTRACT
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	)
	RETURN styLDC_REQCLOSE_CONTRACT
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT:=inuID_REQCLOSE_CONTRACT;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuID_REQCLOSE_CONTRACT
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_REQCLOSE_CONTRACT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_REQCLOSE_CONTRACT
	)
	IS
		rfLDC_REQCLOSE_CONTRACT tyrfLDC_REQCLOSE_CONTRACT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_REQCLOSE_CONTRACT.*, LDC_REQCLOSE_CONTRACT.rowid FROM LDC_REQCLOSE_CONTRACT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_REQCLOSE_CONTRACT for sbFullQuery;

		fetch rfLDC_REQCLOSE_CONTRACT bulk collect INTO otbResult;

		close rfLDC_REQCLOSE_CONTRACT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_REQCLOSE_CONTRACT.*, LDC_REQCLOSE_CONTRACT.rowid FROM LDC_REQCLOSE_CONTRACT';
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
		ircLDC_REQCLOSE_CONTRACT in styLDC_REQCLOSE_CONTRACT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_REQCLOSE_CONTRACT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_REQCLOSE_CONTRACT in styLDC_REQCLOSE_CONTRACT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ID_REQCLOSE_CONTRACT');
			raise ex.controlled_error;
		end if;

		insert into LDC_REQCLOSE_CONTRACT
		(
			ID_REQCLOSE_CONTRACT,
			ID_CONTRATO,
			USER_REQUEST_APPROVE,
			USER_REQUEST_TERMINAL,
			REQUEST_DATE,
			REQUEST_COMMENTS,
			USER_,
			TERMINAL_,
			PROCESS_DATE,
			COMMENTS_,
			REVERSE_USER,
			REVERSE_TERMINAL,
			REVERSE_DATE,
			REVERSE_COMMENTS,
			STATE_REQUEST
		)
		values
		(
			ircLDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT,
			ircLDC_REQCLOSE_CONTRACT.ID_CONTRATO,
			ircLDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE,
			ircLDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL,
			ircLDC_REQCLOSE_CONTRACT.REQUEST_DATE,
			ircLDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS,
			ircLDC_REQCLOSE_CONTRACT.USER_,
			ircLDC_REQCLOSE_CONTRACT.TERMINAL_,
			ircLDC_REQCLOSE_CONTRACT.PROCESS_DATE,
			ircLDC_REQCLOSE_CONTRACT.COMMENTS_,
			ircLDC_REQCLOSE_CONTRACT.REVERSE_USER,
			ircLDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL,
			ircLDC_REQCLOSE_CONTRACT.REVERSE_DATE,
			ircLDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS,
			ircLDC_REQCLOSE_CONTRACT.STATE_REQUEST
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_REQCLOSE_CONTRACT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_REQCLOSE_CONTRACT in out nocopy tytbLDC_REQCLOSE_CONTRACT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_REQCLOSE_CONTRACT,blUseRowID);
		forall n in iotbLDC_REQCLOSE_CONTRACT.first..iotbLDC_REQCLOSE_CONTRACT.last
			insert into LDC_REQCLOSE_CONTRACT
			(
				ID_REQCLOSE_CONTRACT,
				ID_CONTRATO,
				USER_REQUEST_APPROVE,
				USER_REQUEST_TERMINAL,
				REQUEST_DATE,
				REQUEST_COMMENTS,
				USER_,
				TERMINAL_,
				PROCESS_DATE,
				COMMENTS_,
				REVERSE_USER,
				REVERSE_TERMINAL,
				REVERSE_DATE,
				REVERSE_COMMENTS,
				STATE_REQUEST
			)
			values
			(
				rcRecOfTab.ID_REQCLOSE_CONTRACT(n),
				rcRecOfTab.ID_CONTRATO(n),
				rcRecOfTab.USER_REQUEST_APPROVE(n),
				rcRecOfTab.USER_REQUEST_TERMINAL(n),
				rcRecOfTab.REQUEST_DATE(n),
				rcRecOfTab.REQUEST_COMMENTS(n),
				rcRecOfTab.USER_(n),
				rcRecOfTab.TERMINAL_(n),
				rcRecOfTab.PROCESS_DATE(n),
				rcRecOfTab.COMMENTS_(n),
				rcRecOfTab.REVERSE_USER(n),
				rcRecOfTab.REVERSE_TERMINAL(n),
				rcRecOfTab.REVERSE_DATE(n),
				rcRecOfTab.REVERSE_COMMENTS(n),
				rcRecOfTab.STATE_REQUEST(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;


		delete
		from LDC_REQCLOSE_CONTRACT
		where
       		ID_REQCLOSE_CONTRACT=inuID_REQCLOSE_CONTRACT;
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
		rcError  styLDC_REQCLOSE_CONTRACT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_REQCLOSE_CONTRACT
		where
			rowid = iriRowID
		returning
			ID_REQCLOSE_CONTRACT
		into
			rcError.ID_REQCLOSE_CONTRACT;
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
		iotbLDC_REQCLOSE_CONTRACT in out nocopy tytbLDC_REQCLOSE_CONTRACT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_REQCLOSE_CONTRACT;
	BEGIN
		FillRecordOfTables(iotbLDC_REQCLOSE_CONTRACT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last
				delete
				from LDC_REQCLOSE_CONTRACT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last loop
					LockByPk
					(
						rcRecOfTab.ID_REQCLOSE_CONTRACT(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last
				delete
				from LDC_REQCLOSE_CONTRACT
				where
		         	ID_REQCLOSE_CONTRACT = rcRecOfTab.ID_REQCLOSE_CONTRACT(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_REQCLOSE_CONTRACT in styLDC_REQCLOSE_CONTRACT,
		inuLock in number default 0
	)
	IS
		nuID_REQCLOSE_CONTRACT	LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type;
	BEGIN
		if ircLDC_REQCLOSE_CONTRACT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_REQCLOSE_CONTRACT.rowid,rcData);
			end if;
			update LDC_REQCLOSE_CONTRACT
			set
				ID_CONTRATO = ircLDC_REQCLOSE_CONTRACT.ID_CONTRATO,
				USER_REQUEST_APPROVE = ircLDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE,
				USER_REQUEST_TERMINAL = ircLDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL,
				REQUEST_DATE = ircLDC_REQCLOSE_CONTRACT.REQUEST_DATE,
				REQUEST_COMMENTS = ircLDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS,
				USER_ = ircLDC_REQCLOSE_CONTRACT.USER_,
				TERMINAL_ = ircLDC_REQCLOSE_CONTRACT.TERMINAL_,
				PROCESS_DATE = ircLDC_REQCLOSE_CONTRACT.PROCESS_DATE,
				COMMENTS_ = ircLDC_REQCLOSE_CONTRACT.COMMENTS_,
				REVERSE_USER = ircLDC_REQCLOSE_CONTRACT.REVERSE_USER,
				REVERSE_TERMINAL = ircLDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL,
				REVERSE_DATE = ircLDC_REQCLOSE_CONTRACT.REVERSE_DATE,
				REVERSE_COMMENTS = ircLDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS,
				STATE_REQUEST = ircLDC_REQCLOSE_CONTRACT.STATE_REQUEST
			where
				rowid = ircLDC_REQCLOSE_CONTRACT.rowid
			returning
				ID_REQCLOSE_CONTRACT
			into
				nuID_REQCLOSE_CONTRACT;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT,
					rcData
				);
			end if;

			update LDC_REQCLOSE_CONTRACT
			set
				ID_CONTRATO = ircLDC_REQCLOSE_CONTRACT.ID_CONTRATO,
				USER_REQUEST_APPROVE = ircLDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE,
				USER_REQUEST_TERMINAL = ircLDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL,
				REQUEST_DATE = ircLDC_REQCLOSE_CONTRACT.REQUEST_DATE,
				REQUEST_COMMENTS = ircLDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS,
				USER_ = ircLDC_REQCLOSE_CONTRACT.USER_,
				TERMINAL_ = ircLDC_REQCLOSE_CONTRACT.TERMINAL_,
				PROCESS_DATE = ircLDC_REQCLOSE_CONTRACT.PROCESS_DATE,
				COMMENTS_ = ircLDC_REQCLOSE_CONTRACT.COMMENTS_,
				REVERSE_USER = ircLDC_REQCLOSE_CONTRACT.REVERSE_USER,
				REVERSE_TERMINAL = ircLDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL,
				REVERSE_DATE = ircLDC_REQCLOSE_CONTRACT.REVERSE_DATE,
				REVERSE_COMMENTS = ircLDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS,
				STATE_REQUEST = ircLDC_REQCLOSE_CONTRACT.STATE_REQUEST
			where
				ID_REQCLOSE_CONTRACT = ircLDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT
			returning
				ID_REQCLOSE_CONTRACT
			into
				nuID_REQCLOSE_CONTRACT;
		end if;
		if
			nuID_REQCLOSE_CONTRACT is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_REQCLOSE_CONTRACT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_REQCLOSE_CONTRACT in out nocopy tytbLDC_REQCLOSE_CONTRACT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_REQCLOSE_CONTRACT;
	BEGIN
		FillRecordOfTables(iotbLDC_REQCLOSE_CONTRACT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last
				update LDC_REQCLOSE_CONTRACT
				set
					ID_CONTRATO = rcRecOfTab.ID_CONTRATO(n),
					USER_REQUEST_APPROVE = rcRecOfTab.USER_REQUEST_APPROVE(n),
					USER_REQUEST_TERMINAL = rcRecOfTab.USER_REQUEST_TERMINAL(n),
					REQUEST_DATE = rcRecOfTab.REQUEST_DATE(n),
					REQUEST_COMMENTS = rcRecOfTab.REQUEST_COMMENTS(n),
					USER_ = rcRecOfTab.USER_(n),
					TERMINAL_ = rcRecOfTab.TERMINAL_(n),
					PROCESS_DATE = rcRecOfTab.PROCESS_DATE(n),
					COMMENTS_ = rcRecOfTab.COMMENTS_(n),
					REVERSE_USER = rcRecOfTab.REVERSE_USER(n),
					REVERSE_TERMINAL = rcRecOfTab.REVERSE_TERMINAL(n),
					REVERSE_DATE = rcRecOfTab.REVERSE_DATE(n),
					REVERSE_COMMENTS = rcRecOfTab.REVERSE_COMMENTS(n),
					STATE_REQUEST = rcRecOfTab.STATE_REQUEST(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last loop
					LockByPk
					(
						rcRecOfTab.ID_REQCLOSE_CONTRACT(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_REQCLOSE_CONTRACT.first .. iotbLDC_REQCLOSE_CONTRACT.last
				update LDC_REQCLOSE_CONTRACT
				SET
					ID_CONTRATO = rcRecOfTab.ID_CONTRATO(n),
					USER_REQUEST_APPROVE = rcRecOfTab.USER_REQUEST_APPROVE(n),
					USER_REQUEST_TERMINAL = rcRecOfTab.USER_REQUEST_TERMINAL(n),
					REQUEST_DATE = rcRecOfTab.REQUEST_DATE(n),
					REQUEST_COMMENTS = rcRecOfTab.REQUEST_COMMENTS(n),
					USER_ = rcRecOfTab.USER_(n),
					TERMINAL_ = rcRecOfTab.TERMINAL_(n),
					PROCESS_DATE = rcRecOfTab.PROCESS_DATE(n),
					COMMENTS_ = rcRecOfTab.COMMENTS_(n),
					REVERSE_USER = rcRecOfTab.REVERSE_USER(n),
					REVERSE_TERMINAL = rcRecOfTab.REVERSE_TERMINAL(n),
					REVERSE_DATE = rcRecOfTab.REVERSE_DATE(n),
					REVERSE_COMMENTS = rcRecOfTab.REVERSE_COMMENTS(n),
					STATE_REQUEST = rcRecOfTab.STATE_REQUEST(n)
				where
					ID_REQCLOSE_CONTRACT = rcRecOfTab.ID_REQCLOSE_CONTRACT(n)
;
		end if;
	END;
	PROCEDURE updID_CONTRATO
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuID_CONTRATO$ in LDC_REQCLOSE_CONTRACT.ID_CONTRATO%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			ID_CONTRATO = inuID_CONTRATO$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ID_CONTRATO:= inuID_CONTRATO$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_REQUEST_APPROVE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbUSER_REQUEST_APPROVE$ in LDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			USER_REQUEST_APPROVE = isbUSER_REQUEST_APPROVE$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_REQUEST_APPROVE:= isbUSER_REQUEST_APPROVE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_REQUEST_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbUSER_REQUEST_TERMINAL$ in LDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			USER_REQUEST_TERMINAL = isbUSER_REQUEST_TERMINAL$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_REQUEST_TERMINAL:= isbUSER_REQUEST_TERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUEST_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		idtREQUEST_DATE$ in LDC_REQCLOSE_CONTRACT.REQUEST_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			REQUEST_DATE = idtREQUEST_DATE$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUEST_DATE:= idtREQUEST_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREQUEST_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREQUEST_COMMENTS$ in LDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			REQUEST_COMMENTS = isbREQUEST_COMMENTS$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REQUEST_COMMENTS:= isbREQUEST_COMMENTS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updUSER_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbUSER_$ in LDC_REQCLOSE_CONTRACT.USER_%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			USER_ = isbUSER_$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.USER_:= isbUSER_$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updTERMINAL_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbTERMINAL_$ in LDC_REQCLOSE_CONTRACT.TERMINAL_%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			TERMINAL_ = isbTERMINAL_$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TERMINAL_:= isbTERMINAL_$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROCESS_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		idtPROCESS_DATE$ in LDC_REQCLOSE_CONTRACT.PROCESS_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			PROCESS_DATE = idtPROCESS_DATE$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROCESS_DATE:= idtPROCESS_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMMENTS_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbCOMMENTS_$ in LDC_REQCLOSE_CONTRACT.COMMENTS_%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			COMMENTS_ = isbCOMMENTS_$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMMENTS_:= isbCOMMENTS_$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVERSE_USER
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREVERSE_USER$ in LDC_REQCLOSE_CONTRACT.REVERSE_USER%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			REVERSE_USER = isbREVERSE_USER$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVERSE_USER:= isbREVERSE_USER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVERSE_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREVERSE_TERMINAL$ in LDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			REVERSE_TERMINAL = isbREVERSE_TERMINAL$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVERSE_TERMINAL:= isbREVERSE_TERMINAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVERSE_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		idtREVERSE_DATE$ in LDC_REQCLOSE_CONTRACT.REVERSE_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			REVERSE_DATE = idtREVERSE_DATE$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVERSE_DATE:= idtREVERSE_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREVERSE_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbREVERSE_COMMENTS$ in LDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			REVERSE_COMMENTS = isbREVERSE_COMMENTS$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REVERSE_COMMENTS:= isbREVERSE_COMMENTS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSTATE_REQUEST
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		isbSTATE_REQUEST$ in LDC_REQCLOSE_CONTRACT.STATE_REQUEST%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN
		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;
		if inuLock=1 then
			LockByPk
			(
				inuID_REQCLOSE_CONTRACT,
				rcData
			);
		end if;

		update LDC_REQCLOSE_CONTRACT
		set
			STATE_REQUEST = isbSTATE_REQUEST$
		where
			ID_REQCLOSE_CONTRACT = inuID_REQCLOSE_CONTRACT;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.STATE_REQUEST:= isbSTATE_REQUEST$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetID_REQCLOSE_CONTRACT
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.ID_REQCLOSE_CONTRACT);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.ID_REQCLOSE_CONTRACT);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetID_CONTRATO
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.ID_CONTRATO%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.ID_CONTRATO);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.ID_CONTRATO);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_REQUEST_APPROVE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.USER_REQUEST_APPROVE%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.USER_REQUEST_APPROVE);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.USER_REQUEST_APPROVE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_REQUEST_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.USER_REQUEST_TERMINAL%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.USER_REQUEST_TERMINAL);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.USER_REQUEST_TERMINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREQUEST_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REQUEST_DATE%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.REQUEST_DATE);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.REQUEST_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREQUEST_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REQUEST_COMMENTS%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.REQUEST_COMMENTS);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.REQUEST_COMMENTS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetUSER_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.USER_%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.USER_);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.USER_);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetTERMINAL_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.TERMINAL_%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.TERMINAL_);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.TERMINAL_);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetPROCESS_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.PROCESS_DATE%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.PROCESS_DATE);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.PROCESS_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetCOMMENTS_
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.COMMENTS_%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.COMMENTS_);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.COMMENTS_);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREVERSE_USER
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_USER%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.REVERSE_USER);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.REVERSE_USER);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREVERSE_TERMINAL
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_TERMINAL%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.REVERSE_TERMINAL);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.REVERSE_TERMINAL);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREVERSE_DATE
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_DATE%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.REVERSE_DATE);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.REVERSE_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetREVERSE_COMMENTS
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.REVERSE_COMMENTS%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.REVERSE_COMMENTS);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.REVERSE_COMMENTS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetSTATE_REQUEST
	(
		inuID_REQCLOSE_CONTRACT in LDC_REQCLOSE_CONTRACT.ID_REQCLOSE_CONTRACT%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_REQCLOSE_CONTRACT.STATE_REQUEST%type
	IS
		rcError styLDC_REQCLOSE_CONTRACT;
	BEGIN

		rcError.ID_REQCLOSE_CONTRACT := inuID_REQCLOSE_CONTRACT;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuID_REQCLOSE_CONTRACT
			 )
		then
			 return(rcData.STATE_REQUEST);
		end if;
		Load
		(
		 		inuID_REQCLOSE_CONTRACT
		);
		return(rcData.STATE_REQUEST);
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
end DALDC_REQCLOSE_CONTRACT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_REQCLOSE_CONTRACT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_REQCLOSE_CONTRACT', 'ADM_PERSON'); 
END;
/ 
