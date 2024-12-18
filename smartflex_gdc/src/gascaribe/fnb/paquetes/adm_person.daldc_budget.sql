CREATE OR REPLACE PACKAGE adm_person.DALDC_BUDGET
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_BUDGET
    Descripcion	 : 
    
    Parametro	    Descripcion
    ============	==============================
    
    Historia de Modificaciones
    Fecha   	           Autor            Modificacion
    ====================   =========        ====================
    07/06/2024              PAcosta         OSF-2812: Cambio de esquema ADM_PERSON                                              
    ****************************************************************/   
    
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	IS
		SELECT LDC_BUDGET.*,LDC_BUDGET.rowid
		FROM LDC_BUDGET
		WHERE
		    LDC_BUDGET_ID = inuLDC_BUDGET_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_BUDGET.*,LDC_BUDGET.rowid
		FROM LDC_BUDGET
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_BUDGET  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_BUDGET is table of styLDC_BUDGET index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_BUDGET;

	/* Tipos referenciando al registro */
	type tytbLDC_BUDGET_ID is table of LDC_BUDGET.LDC_BUDGET_ID%type index by binary_integer;
	type tytbBUDGET_YEAR is table of LDC_BUDGET.BUDGET_YEAR%type index by binary_integer;
	type tytbBUDGET_MONTH is table of LDC_BUDGET.BUDGET_MONTH%type index by binary_integer;
	type tytbDEPT_ID is table of LDC_BUDGET.DEPT_ID%type index by binary_integer;
	type tytbLOCATION_ID is table of LDC_BUDGET.LOCATION_ID%type index by binary_integer;
	type tytbBUDGET_VALUE is table of LDC_BUDGET.BUDGET_VALUE%type index by binary_integer;
	type tytbBUDGET_USERS is table of LDC_BUDGET.BUDGET_USERS%type index by binary_integer;
	type tytbCOMPONENT_ID is table of LDC_BUDGET.COMPONENT_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_BUDGET is record
	(
		LDC_BUDGET_ID   tytbLDC_BUDGET_ID,
		BUDGET_YEAR   tytbBUDGET_YEAR,
		BUDGET_MONTH   tytbBUDGET_MONTH,
		DEPT_ID   tytbDEPT_ID,
		LOCATION_ID   tytbLOCATION_ID,
		BUDGET_VALUE   tytbBUDGET_VALUE,
		BUDGET_USERS   tytbBUDGET_USERS,
		COMPONENT_ID   tytbCOMPONENT_ID,
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
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	);

	PROCEDURE getRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		orcRecord out nocopy styLDC_BUDGET
	);

	FUNCTION frcGetRcData
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN styLDC_BUDGET;

	FUNCTION frcGetRcData
	RETURN styLDC_BUDGET;

	FUNCTION frcGetRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN styLDC_BUDGET;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_BUDGET
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_BUDGET in styLDC_BUDGET
	);

	PROCEDURE insRecord
	(
		ircLDC_BUDGET in styLDC_BUDGET,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_BUDGET in out nocopy tytbLDC_BUDGET
	);

	PROCEDURE delRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_BUDGET in out nocopy tytbLDC_BUDGET,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_BUDGET in styLDC_BUDGET,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_BUDGET in out nocopy tytbLDC_BUDGET,
		inuLock in number default 1
	);

	PROCEDURE updBUDGET_YEAR
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuBUDGET_YEAR$ in LDC_BUDGET.BUDGET_YEAR%type,
		inuLock in number default 0
	);

	PROCEDURE updBUDGET_MONTH
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		isbBUDGET_MONTH$ in LDC_BUDGET.BUDGET_MONTH%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuDEPT_ID$ in LDC_BUDGET.DEPT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updLOCATION_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuLOCATION_ID$ in LDC_BUDGET.LOCATION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBUDGET_VALUE
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuBUDGET_VALUE$ in LDC_BUDGET.BUDGET_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updBUDGET_USERS
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuBUDGET_USERS$ in LDC_BUDGET.BUDGET_USERS%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPONENT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuCOMPONENT_ID$ in LDC_BUDGET.COMPONENT_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetLDC_BUDGET_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.LDC_BUDGET_ID%type;

	FUNCTION fnuGetBUDGET_YEAR
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_YEAR%type;

	FUNCTION fsbGetBUDGET_MONTH
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_MONTH%type;

	FUNCTION fnuGetDEPT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.DEPT_ID%type;

	FUNCTION fnuGetLOCATION_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.LOCATION_ID%type;

	FUNCTION fnuGetBUDGET_VALUE
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_VALUE%type;

	FUNCTION fnuGetBUDGET_USERS
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_USERS%type;

	FUNCTION fnuGetCOMPONENT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.COMPONENT_ID%type;


	PROCEDURE LockByPk
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		orcLDC_BUDGET  out styLDC_BUDGET
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_BUDGET  out styLDC_BUDGET
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_BUDGET;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_BUDGET
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_BUDGET';
	 cnuGeEntityId constant varchar2(30) := 8050; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	IS
		SELECT LDC_BUDGET.*,LDC_BUDGET.rowid
		FROM LDC_BUDGET
		WHERE  LDC_BUDGET_ID = inuLDC_BUDGET_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_BUDGET.*,LDC_BUDGET.rowid
		FROM LDC_BUDGET
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_BUDGET is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_BUDGET;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_BUDGET default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LDC_BUDGET_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		orcLDC_BUDGET  out styLDC_BUDGET
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

		Open cuLockRcByPk
		(
			inuLDC_BUDGET_ID
		);

		fetch cuLockRcByPk into orcLDC_BUDGET;
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
		orcLDC_BUDGET  out styLDC_BUDGET
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_BUDGET;
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
		itbLDC_BUDGET  in out nocopy tytbLDC_BUDGET
	)
	IS
	BEGIN
			rcRecOfTab.LDC_BUDGET_ID.delete;
			rcRecOfTab.BUDGET_YEAR.delete;
			rcRecOfTab.BUDGET_MONTH.delete;
			rcRecOfTab.DEPT_ID.delete;
			rcRecOfTab.LOCATION_ID.delete;
			rcRecOfTab.BUDGET_VALUE.delete;
			rcRecOfTab.BUDGET_USERS.delete;
			rcRecOfTab.COMPONENT_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_BUDGET  in out nocopy tytbLDC_BUDGET,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_BUDGET);

		for n in itbLDC_BUDGET.first .. itbLDC_BUDGET.last loop
			rcRecOfTab.LDC_BUDGET_ID(n) := itbLDC_BUDGET(n).LDC_BUDGET_ID;
			rcRecOfTab.BUDGET_YEAR(n) := itbLDC_BUDGET(n).BUDGET_YEAR;
			rcRecOfTab.BUDGET_MONTH(n) := itbLDC_BUDGET(n).BUDGET_MONTH;
			rcRecOfTab.DEPT_ID(n) := itbLDC_BUDGET(n).DEPT_ID;
			rcRecOfTab.LOCATION_ID(n) := itbLDC_BUDGET(n).LOCATION_ID;
			rcRecOfTab.BUDGET_VALUE(n) := itbLDC_BUDGET(n).BUDGET_VALUE;
			rcRecOfTab.BUDGET_USERS(n) := itbLDC_BUDGET(n).BUDGET_USERS;
			rcRecOfTab.COMPONENT_ID(n) := itbLDC_BUDGET(n).COMPONENT_ID;
			rcRecOfTab.row_id(n) := itbLDC_BUDGET(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLDC_BUDGET_ID
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
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLDC_BUDGET_ID = rcData.LDC_BUDGET_ID
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
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLDC_BUDGET_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN		rcError.LDC_BUDGET_ID:=inuLDC_BUDGET_ID;

		Load
		(
			inuLDC_BUDGET_ID
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
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuLDC_BUDGET_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		orcRecord out nocopy styLDC_BUDGET
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN		rcError.LDC_BUDGET_ID:=inuLDC_BUDGET_ID;

		Load
		(
			inuLDC_BUDGET_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN styLDC_BUDGET
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID:=inuLDC_BUDGET_ID;

		Load
		(
			inuLDC_BUDGET_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type
	)
	RETURN styLDC_BUDGET
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID:=inuLDC_BUDGET_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuLDC_BUDGET_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLDC_BUDGET_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_BUDGET
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_BUDGET
	)
	IS
		rfLDC_BUDGET tyrfLDC_BUDGET;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_BUDGET.*, LDC_BUDGET.rowid FROM LDC_BUDGET';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_BUDGET for sbFullQuery;

		fetch rfLDC_BUDGET bulk collect INTO otbResult;

		close rfLDC_BUDGET;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_BUDGET.*, LDC_BUDGET.rowid FROM LDC_BUDGET';
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
		ircLDC_BUDGET in styLDC_BUDGET
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_BUDGET,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_BUDGET in styLDC_BUDGET,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_BUDGET.LDC_BUDGET_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LDC_BUDGET_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_BUDGET
		(
			LDC_BUDGET_ID,
			BUDGET_YEAR,
			BUDGET_MONTH,
			DEPT_ID,
			LOCATION_ID,
			BUDGET_VALUE,
			BUDGET_USERS,
			COMPONENT_ID
		)
		values
		(
			ircLDC_BUDGET.LDC_BUDGET_ID,
			ircLDC_BUDGET.BUDGET_YEAR,
			ircLDC_BUDGET.BUDGET_MONTH,
			ircLDC_BUDGET.DEPT_ID,
			ircLDC_BUDGET.LOCATION_ID,
			ircLDC_BUDGET.BUDGET_VALUE,
			ircLDC_BUDGET.BUDGET_USERS,
			ircLDC_BUDGET.COMPONENT_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_BUDGET));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_BUDGET in out nocopy tytbLDC_BUDGET
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_BUDGET,blUseRowID);
		forall n in iotbLDC_BUDGET.first..iotbLDC_BUDGET.last
			insert into LDC_BUDGET
			(
				LDC_BUDGET_ID,
				BUDGET_YEAR,
				BUDGET_MONTH,
				DEPT_ID,
				LOCATION_ID,
				BUDGET_VALUE,
				BUDGET_USERS,
				COMPONENT_ID
			)
			values
			(
				rcRecOfTab.LDC_BUDGET_ID(n),
				rcRecOfTab.BUDGET_YEAR(n),
				rcRecOfTab.BUDGET_MONTH(n),
				rcRecOfTab.DEPT_ID(n),
				rcRecOfTab.LOCATION_ID(n),
				rcRecOfTab.BUDGET_VALUE(n),
				rcRecOfTab.BUDGET_USERS(n),
				rcRecOfTab.COMPONENT_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;


		delete
		from LDC_BUDGET
		where
       		LDC_BUDGET_ID=inuLDC_BUDGET_ID;
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
		rcError  styLDC_BUDGET;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_BUDGET
		where
			rowid = iriRowID
		returning
			LDC_BUDGET_ID
		into
			rcError.LDC_BUDGET_ID;
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
		iotbLDC_BUDGET in out nocopy tytbLDC_BUDGET,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_BUDGET;
	BEGIN
		FillRecordOfTables(iotbLDC_BUDGET, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last
				delete
				from LDC_BUDGET
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last loop
					LockByPk
					(
						rcRecOfTab.LDC_BUDGET_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last
				delete
				from LDC_BUDGET
				where
		         	LDC_BUDGET_ID = rcRecOfTab.LDC_BUDGET_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_BUDGET in styLDC_BUDGET,
		inuLock in number default 0
	)
	IS
		nuLDC_BUDGET_ID	LDC_BUDGET.LDC_BUDGET_ID%type;
	BEGIN
		if ircLDC_BUDGET.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_BUDGET.rowid,rcData);
			end if;
			update LDC_BUDGET
			set
				BUDGET_YEAR = ircLDC_BUDGET.BUDGET_YEAR,
				BUDGET_MONTH = ircLDC_BUDGET.BUDGET_MONTH,
				DEPT_ID = ircLDC_BUDGET.DEPT_ID,
				LOCATION_ID = ircLDC_BUDGET.LOCATION_ID,
				BUDGET_VALUE = ircLDC_BUDGET.BUDGET_VALUE,
				BUDGET_USERS = ircLDC_BUDGET.BUDGET_USERS,
				COMPONENT_ID = ircLDC_BUDGET.COMPONENT_ID
			where
				rowid = ircLDC_BUDGET.rowid
			returning
				LDC_BUDGET_ID
			into
				nuLDC_BUDGET_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_BUDGET.LDC_BUDGET_ID,
					rcData
				);
			end if;

			update LDC_BUDGET
			set
				BUDGET_YEAR = ircLDC_BUDGET.BUDGET_YEAR,
				BUDGET_MONTH = ircLDC_BUDGET.BUDGET_MONTH,
				DEPT_ID = ircLDC_BUDGET.DEPT_ID,
				LOCATION_ID = ircLDC_BUDGET.LOCATION_ID,
				BUDGET_VALUE = ircLDC_BUDGET.BUDGET_VALUE,
				BUDGET_USERS = ircLDC_BUDGET.BUDGET_USERS,
				COMPONENT_ID = ircLDC_BUDGET.COMPONENT_ID
			where
				LDC_BUDGET_ID = ircLDC_BUDGET.LDC_BUDGET_ID
			returning
				LDC_BUDGET_ID
			into
				nuLDC_BUDGET_ID;
		end if;
		if
			nuLDC_BUDGET_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_BUDGET));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_BUDGET in out nocopy tytbLDC_BUDGET,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_BUDGET;
	BEGIN
		FillRecordOfTables(iotbLDC_BUDGET,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last
				update LDC_BUDGET
				set
					BUDGET_YEAR = rcRecOfTab.BUDGET_YEAR(n),
					BUDGET_MONTH = rcRecOfTab.BUDGET_MONTH(n),
					DEPT_ID = rcRecOfTab.DEPT_ID(n),
					LOCATION_ID = rcRecOfTab.LOCATION_ID(n),
					BUDGET_VALUE = rcRecOfTab.BUDGET_VALUE(n),
					BUDGET_USERS = rcRecOfTab.BUDGET_USERS(n),
					COMPONENT_ID = rcRecOfTab.COMPONENT_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last loop
					LockByPk
					(
						rcRecOfTab.LDC_BUDGET_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGET.first .. iotbLDC_BUDGET.last
				update LDC_BUDGET
				SET
					BUDGET_YEAR = rcRecOfTab.BUDGET_YEAR(n),
					BUDGET_MONTH = rcRecOfTab.BUDGET_MONTH(n),
					DEPT_ID = rcRecOfTab.DEPT_ID(n),
					LOCATION_ID = rcRecOfTab.LOCATION_ID(n),
					BUDGET_VALUE = rcRecOfTab.BUDGET_VALUE(n),
					BUDGET_USERS = rcRecOfTab.BUDGET_USERS(n),
					COMPONENT_ID = rcRecOfTab.COMPONENT_ID(n)
				where
					LDC_BUDGET_ID = rcRecOfTab.LDC_BUDGET_ID(n)
;
		end if;
	END;
	PROCEDURE updBUDGET_YEAR
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuBUDGET_YEAR$ in LDC_BUDGET.BUDGET_YEAR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			BUDGET_YEAR = inuBUDGET_YEAR$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BUDGET_YEAR:= inuBUDGET_YEAR$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBUDGET_MONTH
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		isbBUDGET_MONTH$ in LDC_BUDGET.BUDGET_MONTH%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			BUDGET_MONTH = isbBUDGET_MONTH$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BUDGET_MONTH:= isbBUDGET_MONTH$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updDEPT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuDEPT_ID$ in LDC_BUDGET.DEPT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			DEPT_ID = inuDEPT_ID$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.DEPT_ID:= inuDEPT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updLOCATION_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuLOCATION_ID$ in LDC_BUDGET.LOCATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			LOCATION_ID = inuLOCATION_ID$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LOCATION_ID:= inuLOCATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBUDGET_VALUE
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuBUDGET_VALUE$ in LDC_BUDGET.BUDGET_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			BUDGET_VALUE = inuBUDGET_VALUE$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BUDGET_VALUE:= inuBUDGET_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBUDGET_USERS
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuBUDGET_USERS$ in LDC_BUDGET.BUDGET_USERS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			BUDGET_USERS = inuBUDGET_USERS$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BUDGET_USERS:= inuBUDGET_USERS$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCOMPONENT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuCOMPONENT_ID$ in LDC_BUDGET.COMPONENT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGET;
	BEGIN
		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGET_ID,
				rcData
			);
		end if;

		update LDC_BUDGET
		set
			COMPONENT_ID = inuCOMPONENT_ID$
		where
			LDC_BUDGET_ID = inuLDC_BUDGET_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPONENT_ID:= inuCOMPONENT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetLDC_BUDGET_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.LDC_BUDGET_ID%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.LDC_BUDGET_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.LDC_BUDGET_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetBUDGET_YEAR
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_YEAR%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.BUDGET_YEAR);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.BUDGET_YEAR);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetBUDGET_MONTH
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_MONTH%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.BUDGET_MONTH);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.BUDGET_MONTH);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetDEPT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.DEPT_ID%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.DEPT_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.DEPT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetLOCATION_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.LOCATION_ID%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.LOCATION_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.LOCATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetBUDGET_VALUE
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_VALUE%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.BUDGET_VALUE);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.BUDGET_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetBUDGET_USERS
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.BUDGET_USERS%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.BUDGET_USERS);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.BUDGET_USERS);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCOMPONENT_ID
	(
		inuLDC_BUDGET_ID in LDC_BUDGET.LDC_BUDGET_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGET.COMPONENT_ID%type
	IS
		rcError styLDC_BUDGET;
	BEGIN

		rcError.LDC_BUDGET_ID := inuLDC_BUDGET_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGET_ID
			 )
		then
			 return(rcData.COMPONENT_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGET_ID
		);
		return(rcData.COMPONENT_ID);
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
end DALDC_BUDGET;
/
PROMPT Otorgando permisos de ejecucion a DALDC_BUDGET
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_BUDGET', 'ADM_PERSON');
END;
/