CREATE OR REPLACE PACKAGE adm_person.DALDC_BUDGETBYPROVIDER
is
    /***************************************************************
    Propiedad intelectual de Sincecomp Ltda.
    
    Unidad	     : DALDC_BUDGETBYPROVIDER
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	IS
		SELECT LDC_BUDGETBYPROVIDER.*,LDC_BUDGETBYPROVIDER.rowid
		FROM LDC_BUDGETBYPROVIDER
		WHERE
		    LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_BUDGETBYPROVIDER.*,LDC_BUDGETBYPROVIDER.rowid
		FROM LDC_BUDGETBYPROVIDER
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_BUDGETBYPROVIDER  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_BUDGETBYPROVIDER is table of styLDC_BUDGETBYPROVIDER index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_BUDGETBYPROVIDER;

	/* Tipos referenciando al registro */
	type tytbBUDGET_USERS is table of LDC_BUDGETBYPROVIDER.BUDGET_USERS%type index by binary_integer;
	type tytbCOMPONENT_ID is table of LDC_BUDGETBYPROVIDER.COMPONENT_ID%type index by binary_integer;
	type tytbLDC_BUDGETBYPROVIDER_ID is table of LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type index by binary_integer;
	type tytbBUDGET_YEAR is table of LDC_BUDGETBYPROVIDER.BUDGET_YEAR%type index by binary_integer;
	type tytbBUDGET_MONTH is table of LDC_BUDGETBYPROVIDER.BUDGET_MONTH%type index by binary_integer;
	type tytbDEPT_ID is table of LDC_BUDGETBYPROVIDER.DEPT_ID%type index by binary_integer;
	type tytbLOCATION_ID is table of LDC_BUDGETBYPROVIDER.LOCATION_ID%type index by binary_integer;
	type tytbPROVIDER_ID is table of LDC_BUDGETBYPROVIDER.PROVIDER_ID%type index by binary_integer;
	type tytbBUDGET_VALUE is table of LDC_BUDGETBYPROVIDER.BUDGET_VALUE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_BUDGETBYPROVIDER is record
	(
		BUDGET_USERS   tytbBUDGET_USERS,
		COMPONENT_ID   tytbCOMPONENT_ID,
		LDC_BUDGETBYPROVIDER_ID   tytbLDC_BUDGETBYPROVIDER_ID,
		BUDGET_YEAR   tytbBUDGET_YEAR,
		BUDGET_MONTH   tytbBUDGET_MONTH,
		DEPT_ID   tytbDEPT_ID,
		LOCATION_ID   tytbLOCATION_ID,
		PROVIDER_ID   tytbPROVIDER_ID,
		BUDGET_VALUE   tytbBUDGET_VALUE,
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	);

	PROCEDURE getRecord
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		orcRecord out nocopy styLDC_BUDGETBYPROVIDER
	);

	FUNCTION frcGetRcData
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN styLDC_BUDGETBYPROVIDER;

	FUNCTION frcGetRcData
	RETURN styLDC_BUDGETBYPROVIDER;

	FUNCTION frcGetRecord
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN styLDC_BUDGETBYPROVIDER;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_BUDGETBYPROVIDER
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_BUDGETBYPROVIDER in styLDC_BUDGETBYPROVIDER
	);

	PROCEDURE insRecord
	(
		ircLDC_BUDGETBYPROVIDER in styLDC_BUDGETBYPROVIDER,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_BUDGETBYPROVIDER in out nocopy tytbLDC_BUDGETBYPROVIDER
	);

	PROCEDURE delRecord
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_BUDGETBYPROVIDER in out nocopy tytbLDC_BUDGETBYPROVIDER,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_BUDGETBYPROVIDER in styLDC_BUDGETBYPROVIDER,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_BUDGETBYPROVIDER in out nocopy tytbLDC_BUDGETBYPROVIDER,
		inuLock in number default 1
	);

	PROCEDURE updBUDGET_USERS
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuBUDGET_USERS$ in LDC_BUDGETBYPROVIDER.BUDGET_USERS%type,
		inuLock in number default 0
	);

	PROCEDURE updCOMPONENT_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuCOMPONENT_ID$ in LDC_BUDGETBYPROVIDER.COMPONENT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBUDGET_YEAR
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuBUDGET_YEAR$ in LDC_BUDGETBYPROVIDER.BUDGET_YEAR%type,
		inuLock in number default 0
	);

	PROCEDURE updBUDGET_MONTH
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		isbBUDGET_MONTH$ in LDC_BUDGETBYPROVIDER.BUDGET_MONTH%type,
		inuLock in number default 0
	);

	PROCEDURE updDEPT_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuDEPT_ID$ in LDC_BUDGETBYPROVIDER.DEPT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updLOCATION_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuLOCATION_ID$ in LDC_BUDGETBYPROVIDER.LOCATION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updPROVIDER_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuPROVIDER_ID$ in LDC_BUDGETBYPROVIDER.PROVIDER_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updBUDGET_VALUE
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuBUDGET_VALUE$ in LDC_BUDGETBYPROVIDER.BUDGET_VALUE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetBUDGET_USERS
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_USERS%type;

	FUNCTION fnuGetCOMPONENT_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.COMPONENT_ID%type;

	FUNCTION fnuGetLDC_BUDGETBYPROVIDER_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type;

	FUNCTION fnuGetBUDGET_YEAR
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_YEAR%type;

	FUNCTION fsbGetBUDGET_MONTH
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_MONTH%type;

	FUNCTION fnuGetDEPT_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.DEPT_ID%type;

	FUNCTION fnuGetLOCATION_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.LOCATION_ID%type;

	FUNCTION fnuGetPROVIDER_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.PROVIDER_ID%type;

	FUNCTION fnuGetBUDGET_VALUE
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_VALUE%type;


	PROCEDURE LockByPk
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		orcLDC_BUDGETBYPROVIDER  out styLDC_BUDGETBYPROVIDER
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_BUDGETBYPROVIDER  out styLDC_BUDGETBYPROVIDER
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_BUDGETBYPROVIDER;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_BUDGETBYPROVIDER
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_BUDGETBYPROVIDER';
	 cnuGeEntityId constant varchar2(30) := 8052; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	IS
		SELECT LDC_BUDGETBYPROVIDER.*,LDC_BUDGETBYPROVIDER.rowid
		FROM LDC_BUDGETBYPROVIDER
		WHERE  LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_BUDGETBYPROVIDER.*,LDC_BUDGETBYPROVIDER.rowid
		FROM LDC_BUDGETBYPROVIDER
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_BUDGETBYPROVIDER is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_BUDGETBYPROVIDER;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_BUDGETBYPROVIDER default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.LDC_BUDGETBYPROVIDER_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		orcLDC_BUDGETBYPROVIDER  out styLDC_BUDGETBYPROVIDER
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

		Open cuLockRcByPk
		(
			inuLDC_BUDGETBYPROVIDER_ID
		);

		fetch cuLockRcByPk into orcLDC_BUDGETBYPROVIDER;
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
		orcLDC_BUDGETBYPROVIDER  out styLDC_BUDGETBYPROVIDER
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_BUDGETBYPROVIDER;
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
		itbLDC_BUDGETBYPROVIDER  in out nocopy tytbLDC_BUDGETBYPROVIDER
	)
	IS
	BEGIN
			rcRecOfTab.BUDGET_USERS.delete;
			rcRecOfTab.COMPONENT_ID.delete;
			rcRecOfTab.LDC_BUDGETBYPROVIDER_ID.delete;
			rcRecOfTab.BUDGET_YEAR.delete;
			rcRecOfTab.BUDGET_MONTH.delete;
			rcRecOfTab.DEPT_ID.delete;
			rcRecOfTab.LOCATION_ID.delete;
			rcRecOfTab.PROVIDER_ID.delete;
			rcRecOfTab.BUDGET_VALUE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_BUDGETBYPROVIDER  in out nocopy tytbLDC_BUDGETBYPROVIDER,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_BUDGETBYPROVIDER);

		for n in itbLDC_BUDGETBYPROVIDER.first .. itbLDC_BUDGETBYPROVIDER.last loop
			rcRecOfTab.BUDGET_USERS(n) := itbLDC_BUDGETBYPROVIDER(n).BUDGET_USERS;
			rcRecOfTab.COMPONENT_ID(n) := itbLDC_BUDGETBYPROVIDER(n).COMPONENT_ID;
			rcRecOfTab.LDC_BUDGETBYPROVIDER_ID(n) := itbLDC_BUDGETBYPROVIDER(n).LDC_BUDGETBYPROVIDER_ID;
			rcRecOfTab.BUDGET_YEAR(n) := itbLDC_BUDGETBYPROVIDER(n).BUDGET_YEAR;
			rcRecOfTab.BUDGET_MONTH(n) := itbLDC_BUDGETBYPROVIDER(n).BUDGET_MONTH;
			rcRecOfTab.DEPT_ID(n) := itbLDC_BUDGETBYPROVIDER(n).DEPT_ID;
			rcRecOfTab.LOCATION_ID(n) := itbLDC_BUDGETBYPROVIDER(n).LOCATION_ID;
			rcRecOfTab.PROVIDER_ID(n) := itbLDC_BUDGETBYPROVIDER(n).PROVIDER_ID;
			rcRecOfTab.BUDGET_VALUE(n) := itbLDC_BUDGETBYPROVIDER(n).BUDGET_VALUE;
			rcRecOfTab.row_id(n) := itbLDC_BUDGETBYPROVIDER(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuLDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuLDC_BUDGETBYPROVIDER_ID = rcData.LDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuLDC_BUDGETBYPROVIDER_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN		rcError.LDC_BUDGETBYPROVIDER_ID:=inuLDC_BUDGETBYPROVIDER_ID;

		Load
		(
			inuLDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuLDC_BUDGETBYPROVIDER_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		orcRecord out nocopy styLDC_BUDGETBYPROVIDER
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN		rcError.LDC_BUDGETBYPROVIDER_ID:=inuLDC_BUDGETBYPROVIDER_ID;

		Load
		(
			inuLDC_BUDGETBYPROVIDER_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN styLDC_BUDGETBYPROVIDER
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID:=inuLDC_BUDGETBYPROVIDER_ID;

		Load
		(
			inuLDC_BUDGETBYPROVIDER_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	)
	RETURN styLDC_BUDGETBYPROVIDER
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID:=inuLDC_BUDGETBYPROVIDER_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuLDC_BUDGETBYPROVIDER_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_BUDGETBYPROVIDER
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_BUDGETBYPROVIDER
	)
	IS
		rfLDC_BUDGETBYPROVIDER tyrfLDC_BUDGETBYPROVIDER;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_BUDGETBYPROVIDER.*, LDC_BUDGETBYPROVIDER.rowid FROM LDC_BUDGETBYPROVIDER';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_BUDGETBYPROVIDER for sbFullQuery;

		fetch rfLDC_BUDGETBYPROVIDER bulk collect INTO otbResult;

		close rfLDC_BUDGETBYPROVIDER;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_BUDGETBYPROVIDER.*, LDC_BUDGETBYPROVIDER.rowid FROM LDC_BUDGETBYPROVIDER';
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
		ircLDC_BUDGETBYPROVIDER in styLDC_BUDGETBYPROVIDER
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_BUDGETBYPROVIDER,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_BUDGETBYPROVIDER in styLDC_BUDGETBYPROVIDER,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|LDC_BUDGETBYPROVIDER_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_BUDGETBYPROVIDER
		(
			BUDGET_USERS,
			COMPONENT_ID,
			LDC_BUDGETBYPROVIDER_ID,
			BUDGET_YEAR,
			BUDGET_MONTH,
			DEPT_ID,
			LOCATION_ID,
			PROVIDER_ID,
			BUDGET_VALUE
		)
		values
		(
			ircLDC_BUDGETBYPROVIDER.BUDGET_USERS,
			ircLDC_BUDGETBYPROVIDER.COMPONENT_ID,
			ircLDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID,
			ircLDC_BUDGETBYPROVIDER.BUDGET_YEAR,
			ircLDC_BUDGETBYPROVIDER.BUDGET_MONTH,
			ircLDC_BUDGETBYPROVIDER.DEPT_ID,
			ircLDC_BUDGETBYPROVIDER.LOCATION_ID,
			ircLDC_BUDGETBYPROVIDER.PROVIDER_ID,
			ircLDC_BUDGETBYPROVIDER.BUDGET_VALUE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_BUDGETBYPROVIDER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_BUDGETBYPROVIDER in out nocopy tytbLDC_BUDGETBYPROVIDER
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_BUDGETBYPROVIDER,blUseRowID);
		forall n in iotbLDC_BUDGETBYPROVIDER.first..iotbLDC_BUDGETBYPROVIDER.last
			insert into LDC_BUDGETBYPROVIDER
			(
				BUDGET_USERS,
				COMPONENT_ID,
				LDC_BUDGETBYPROVIDER_ID,
				BUDGET_YEAR,
				BUDGET_MONTH,
				DEPT_ID,
				LOCATION_ID,
				PROVIDER_ID,
				BUDGET_VALUE
			)
			values
			(
				rcRecOfTab.BUDGET_USERS(n),
				rcRecOfTab.COMPONENT_ID(n),
				rcRecOfTab.LDC_BUDGETBYPROVIDER_ID(n),
				rcRecOfTab.BUDGET_YEAR(n),
				rcRecOfTab.BUDGET_MONTH(n),
				rcRecOfTab.DEPT_ID(n),
				rcRecOfTab.LOCATION_ID(n),
				rcRecOfTab.PROVIDER_ID(n),
				rcRecOfTab.BUDGET_VALUE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;


		delete
		from LDC_BUDGETBYPROVIDER
		where
       		LDC_BUDGETBYPROVIDER_ID=inuLDC_BUDGETBYPROVIDER_ID;
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
		rcError  styLDC_BUDGETBYPROVIDER;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_BUDGETBYPROVIDER
		where
			rowid = iriRowID
		returning
			BUDGET_USERS
		into
			rcError.BUDGET_USERS;
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
		iotbLDC_BUDGETBYPROVIDER in out nocopy tytbLDC_BUDGETBYPROVIDER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_BUDGETBYPROVIDER;
	BEGIN
		FillRecordOfTables(iotbLDC_BUDGETBYPROVIDER, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last
				delete
				from LDC_BUDGETBYPROVIDER
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last loop
					LockByPk
					(
						rcRecOfTab.LDC_BUDGETBYPROVIDER_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last
				delete
				from LDC_BUDGETBYPROVIDER
				where
		         	LDC_BUDGETBYPROVIDER_ID = rcRecOfTab.LDC_BUDGETBYPROVIDER_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_BUDGETBYPROVIDER in styLDC_BUDGETBYPROVIDER,
		inuLock in number default 0
	)
	IS
		nuLDC_BUDGETBYPROVIDER_ID	LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type;
	BEGIN
		if ircLDC_BUDGETBYPROVIDER.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_BUDGETBYPROVIDER.rowid,rcData);
			end if;
			update LDC_BUDGETBYPROVIDER
			set
				BUDGET_USERS = ircLDC_BUDGETBYPROVIDER.BUDGET_USERS,
				COMPONENT_ID = ircLDC_BUDGETBYPROVIDER.COMPONENT_ID,
				BUDGET_YEAR = ircLDC_BUDGETBYPROVIDER.BUDGET_YEAR,
				BUDGET_MONTH = ircLDC_BUDGETBYPROVIDER.BUDGET_MONTH,
				DEPT_ID = ircLDC_BUDGETBYPROVIDER.DEPT_ID,
				LOCATION_ID = ircLDC_BUDGETBYPROVIDER.LOCATION_ID,
				PROVIDER_ID = ircLDC_BUDGETBYPROVIDER.PROVIDER_ID,
				BUDGET_VALUE = ircLDC_BUDGETBYPROVIDER.BUDGET_VALUE
			where
				rowid = ircLDC_BUDGETBYPROVIDER.rowid
			returning
				LDC_BUDGETBYPROVIDER_ID
			into
				nuLDC_BUDGETBYPROVIDER_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID,
					rcData
				);
			end if;

			update LDC_BUDGETBYPROVIDER
			set
				BUDGET_USERS = ircLDC_BUDGETBYPROVIDER.BUDGET_USERS,
				COMPONENT_ID = ircLDC_BUDGETBYPROVIDER.COMPONENT_ID,
				BUDGET_YEAR = ircLDC_BUDGETBYPROVIDER.BUDGET_YEAR,
				BUDGET_MONTH = ircLDC_BUDGETBYPROVIDER.BUDGET_MONTH,
				DEPT_ID = ircLDC_BUDGETBYPROVIDER.DEPT_ID,
				LOCATION_ID = ircLDC_BUDGETBYPROVIDER.LOCATION_ID,
				PROVIDER_ID = ircLDC_BUDGETBYPROVIDER.PROVIDER_ID,
				BUDGET_VALUE = ircLDC_BUDGETBYPROVIDER.BUDGET_VALUE
			where
				LDC_BUDGETBYPROVIDER_ID = ircLDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID
			returning
				LDC_BUDGETBYPROVIDER_ID
			into
				nuLDC_BUDGETBYPROVIDER_ID;
		end if;
		if
			nuLDC_BUDGETBYPROVIDER_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_BUDGETBYPROVIDER));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_BUDGETBYPROVIDER in out nocopy tytbLDC_BUDGETBYPROVIDER,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_BUDGETBYPROVIDER;
	BEGIN
		FillRecordOfTables(iotbLDC_BUDGETBYPROVIDER,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last
				update LDC_BUDGETBYPROVIDER
				set
					BUDGET_USERS = rcRecOfTab.BUDGET_USERS(n),
					COMPONENT_ID = rcRecOfTab.COMPONENT_ID(n),
					BUDGET_YEAR = rcRecOfTab.BUDGET_YEAR(n),
					BUDGET_MONTH = rcRecOfTab.BUDGET_MONTH(n),
					DEPT_ID = rcRecOfTab.DEPT_ID(n),
					LOCATION_ID = rcRecOfTab.LOCATION_ID(n),
					PROVIDER_ID = rcRecOfTab.PROVIDER_ID(n),
					BUDGET_VALUE = rcRecOfTab.BUDGET_VALUE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last loop
					LockByPk
					(
						rcRecOfTab.LDC_BUDGETBYPROVIDER_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_BUDGETBYPROVIDER.first .. iotbLDC_BUDGETBYPROVIDER.last
				update LDC_BUDGETBYPROVIDER
				SET
					BUDGET_USERS = rcRecOfTab.BUDGET_USERS(n),
					COMPONENT_ID = rcRecOfTab.COMPONENT_ID(n),
					BUDGET_YEAR = rcRecOfTab.BUDGET_YEAR(n),
					BUDGET_MONTH = rcRecOfTab.BUDGET_MONTH(n),
					DEPT_ID = rcRecOfTab.DEPT_ID(n),
					LOCATION_ID = rcRecOfTab.LOCATION_ID(n),
					PROVIDER_ID = rcRecOfTab.PROVIDER_ID(n),
					BUDGET_VALUE = rcRecOfTab.BUDGET_VALUE(n)
				where
					LDC_BUDGETBYPROVIDER_ID = rcRecOfTab.LDC_BUDGETBYPROVIDER_ID(n)
;
		end if;
	END;
	PROCEDURE updBUDGET_USERS
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuBUDGET_USERS$ in LDC_BUDGETBYPROVIDER.BUDGET_USERS%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			BUDGET_USERS = inuBUDGET_USERS$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuCOMPONENT_ID$ in LDC_BUDGETBYPROVIDER.COMPONENT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			COMPONENT_ID = inuCOMPONENT_ID$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.COMPONENT_ID:= inuCOMPONENT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBUDGET_YEAR
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuBUDGET_YEAR$ in LDC_BUDGETBYPROVIDER.BUDGET_YEAR%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			BUDGET_YEAR = inuBUDGET_YEAR$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		isbBUDGET_MONTH$ in LDC_BUDGETBYPROVIDER.BUDGET_MONTH%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			BUDGET_MONTH = isbBUDGET_MONTH$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuDEPT_ID$ in LDC_BUDGETBYPROVIDER.DEPT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			DEPT_ID = inuDEPT_ID$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuLOCATION_ID$ in LDC_BUDGETBYPROVIDER.LOCATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			LOCATION_ID = inuLOCATION_ID$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.LOCATION_ID:= inuLOCATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updPROVIDER_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuPROVIDER_ID$ in LDC_BUDGETBYPROVIDER.PROVIDER_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			PROVIDER_ID = inuPROVIDER_ID$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.PROVIDER_ID:= inuPROVIDER_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updBUDGET_VALUE
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuBUDGET_VALUE$ in LDC_BUDGETBYPROVIDER.BUDGET_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN
		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;
		if inuLock=1 then
			LockByPk
			(
				inuLDC_BUDGETBYPROVIDER_ID,
				rcData
			);
		end if;

		update LDC_BUDGETBYPROVIDER
		set
			BUDGET_VALUE = inuBUDGET_VALUE$
		where
			LDC_BUDGETBYPROVIDER_ID = inuLDC_BUDGETBYPROVIDER_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.BUDGET_VALUE:= inuBUDGET_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetBUDGET_USERS
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_USERS%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.BUDGET_USERS);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.COMPONENT_ID%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.COMPONENT_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
	FUNCTION fnuGetLDC_BUDGETBYPROVIDER_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.LDC_BUDGETBYPROVIDER_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
		);
		return(rcData.LDC_BUDGETBYPROVIDER_ID);
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_YEAR%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.BUDGET_YEAR);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_MONTH%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.BUDGET_MONTH);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.DEPT_ID%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.DEPT_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.LOCATION_ID%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.LOCATION_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
	FUNCTION fnuGetPROVIDER_ID
	(
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.PROVIDER_ID%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.PROVIDER_ID);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
		);
		return(rcData.PROVIDER_ID);
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
		inuLDC_BUDGETBYPROVIDER_ID in LDC_BUDGETBYPROVIDER.LDC_BUDGETBYPROVIDER_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_BUDGETBYPROVIDER.BUDGET_VALUE%type
	IS
		rcError styLDC_BUDGETBYPROVIDER;
	BEGIN

		rcError.LDC_BUDGETBYPROVIDER_ID := inuLDC_BUDGETBYPROVIDER_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuLDC_BUDGETBYPROVIDER_ID
			 )
		then
			 return(rcData.BUDGET_VALUE);
		end if;
		Load
		(
		 		inuLDC_BUDGETBYPROVIDER_ID
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_BUDGETBYPROVIDER;
/
PROMPT Otorgando permisos de ejecucion a DALDC_BUDGETBYPROVIDER
BEGIN
    pkg_utilidades.praplicarpermisos('DALDC_BUDGETBYPROVIDER', 'ADM_PERSON');
END;
/