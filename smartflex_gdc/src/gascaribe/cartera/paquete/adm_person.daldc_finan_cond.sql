CREATE OR REPLACE PACKAGE adm_person.daldc_finan_cond
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  *************************************************************************
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	IS
		SELECT LDC_FINAN_COND.*,LDC_FINAN_COND.rowid
		FROM LDC_FINAN_COND
		WHERE
		    REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_FINAN_COND.*,LDC_FINAN_COND.rowid
		FROM LDC_FINAN_COND
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_FINAN_COND  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_FINAN_COND is table of styLDC_FINAN_COND index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_FINAN_COND;

	/* Tipos referenciando al registro */
	type tytbREC_FINAN_COND_ID is table of LDC_FINAN_COND.REC_FINAN_COND_ID%type index by binary_integer;
	type tytbRECO_ACTIVITY is table of LDC_FINAN_COND.RECO_ACTIVITY%type index by binary_integer;
	type tytbGEO_LOCATION_ID is table of LDC_FINAN_COND.GEO_LOCATION_ID%type index by binary_integer;
	type tytbCATEGORY_ID is table of LDC_FINAN_COND.CATEGORY_ID%type index by binary_integer;
	type tytbSUBCATEGORY_ID is table of LDC_FINAN_COND.SUBCATEGORY_ID%type index by binary_integer;
	type tytbMIN_VALUE is table of LDC_FINAN_COND.MIN_VALUE%type index by binary_integer;
	type tytbMAX_VALUE is table of LDC_FINAN_COND.MAX_VALUE%type index by binary_integer;
	type tytbFINAN_PLAN_ID is table of LDC_FINAN_COND.FINAN_PLAN_ID%type index by binary_integer;
	type tytbQUOTAS_NUMBER is table of LDC_FINAN_COND.QUOTAS_NUMBER%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_FINAN_COND is record
	(
		REC_FINAN_COND_ID   tytbREC_FINAN_COND_ID,
		RECO_ACTIVITY   tytbRECO_ACTIVITY,
		GEO_LOCATION_ID   tytbGEO_LOCATION_ID,
		CATEGORY_ID   tytbCATEGORY_ID,
		SUBCATEGORY_ID   tytbSUBCATEGORY_ID,
		MIN_VALUE   tytbMIN_VALUE,
		MAX_VALUE   tytbMAX_VALUE,
		FINAN_PLAN_ID   tytbFINAN_PLAN_ID,
		QUOTAS_NUMBER   tytbQUOTAS_NUMBER,
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
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	);

	PROCEDURE getRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		orcRecord out nocopy styLDC_FINAN_COND
	);

	FUNCTION frcGetRcData
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN styLDC_FINAN_COND;

	FUNCTION frcGetRcData
	RETURN styLDC_FINAN_COND;

	FUNCTION frcGetRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN styLDC_FINAN_COND;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FINAN_COND
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_FINAN_COND in styLDC_FINAN_COND
	);

	PROCEDURE insRecord
	(
		ircLDC_FINAN_COND in styLDC_FINAN_COND,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_FINAN_COND in out nocopy tytbLDC_FINAN_COND
	);

	PROCEDURE delRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_FINAN_COND in out nocopy tytbLDC_FINAN_COND,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_FINAN_COND in styLDC_FINAN_COND,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_FINAN_COND in out nocopy tytbLDC_FINAN_COND,
		inuLock in number default 1
	);

	PROCEDURE updRECO_ACTIVITY
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRECO_ACTIVITY$ in LDC_FINAN_COND.RECO_ACTIVITY%type,
		inuLock in number default 0
	);

	PROCEDURE updGEO_LOCATION_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuGEO_LOCATION_ID$ in LDC_FINAN_COND.GEO_LOCATION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuCATEGORY_ID$ in LDC_FINAN_COND.CATEGORY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSUBCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuSUBCATEGORY_ID$ in LDC_FINAN_COND.SUBCATEGORY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updMIN_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuMIN_VALUE$ in LDC_FINAN_COND.MIN_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updMAX_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuMAX_VALUE$ in LDC_FINAN_COND.MAX_VALUE%type,
		inuLock in number default 0
	);

	PROCEDURE updFINAN_PLAN_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuFINAN_PLAN_ID$ in LDC_FINAN_COND.FINAN_PLAN_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updQUOTAS_NUMBER
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuQUOTAS_NUMBER$ in LDC_FINAN_COND.QUOTAS_NUMBER%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetREC_FINAN_COND_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.REC_FINAN_COND_ID%type;

	FUNCTION fnuGetRECO_ACTIVITY
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.RECO_ACTIVITY%type;

	FUNCTION fnuGetGEO_LOCATION_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.GEO_LOCATION_ID%type;

	FUNCTION fnuGetCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.CATEGORY_ID%type;

	FUNCTION fnuGetSUBCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.SUBCATEGORY_ID%type;

	FUNCTION fnuGetMIN_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.MIN_VALUE%type;

	FUNCTION fnuGetMAX_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.MAX_VALUE%type;

	FUNCTION fnuGetFINAN_PLAN_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.FINAN_PLAN_ID%type;

	FUNCTION fnuGetQUOTAS_NUMBER
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.QUOTAS_NUMBER%type;


	PROCEDURE LockByPk
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		orcLDC_FINAN_COND  out styLDC_FINAN_COND
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_FINAN_COND  out styLDC_FINAN_COND
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_FINAN_COND;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_FINAN_COND
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_FINAN_COND';
	 cnuGeEntityId constant varchar2(30) := 8532; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	IS
		SELECT LDC_FINAN_COND.*,LDC_FINAN_COND.rowid
		FROM LDC_FINAN_COND
		WHERE  REC_FINAN_COND_ID = inuREC_FINAN_COND_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_FINAN_COND.*,LDC_FINAN_COND.rowid
		FROM LDC_FINAN_COND
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_FINAN_COND is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_FINAN_COND;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_FINAN_COND default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.REC_FINAN_COND_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		orcLDC_FINAN_COND  out styLDC_FINAN_COND
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

		Open cuLockRcByPk
		(
			inuREC_FINAN_COND_ID
		);

		fetch cuLockRcByPk into orcLDC_FINAN_COND;
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
		orcLDC_FINAN_COND  out styLDC_FINAN_COND
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_FINAN_COND;
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
		itbLDC_FINAN_COND  in out nocopy tytbLDC_FINAN_COND
	)
	IS
	BEGIN
			rcRecOfTab.REC_FINAN_COND_ID.delete;
			rcRecOfTab.RECO_ACTIVITY.delete;
			rcRecOfTab.GEO_LOCATION_ID.delete;
			rcRecOfTab.CATEGORY_ID.delete;
			rcRecOfTab.SUBCATEGORY_ID.delete;
			rcRecOfTab.MIN_VALUE.delete;
			rcRecOfTab.MAX_VALUE.delete;
			rcRecOfTab.FINAN_PLAN_ID.delete;
			rcRecOfTab.QUOTAS_NUMBER.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_FINAN_COND  in out nocopy tytbLDC_FINAN_COND,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_FINAN_COND);

		for n in itbLDC_FINAN_COND.first .. itbLDC_FINAN_COND.last loop
			rcRecOfTab.REC_FINAN_COND_ID(n) := itbLDC_FINAN_COND(n).REC_FINAN_COND_ID;
			rcRecOfTab.RECO_ACTIVITY(n) := itbLDC_FINAN_COND(n).RECO_ACTIVITY;
			rcRecOfTab.GEO_LOCATION_ID(n) := itbLDC_FINAN_COND(n).GEO_LOCATION_ID;
			rcRecOfTab.CATEGORY_ID(n) := itbLDC_FINAN_COND(n).CATEGORY_ID;
			rcRecOfTab.SUBCATEGORY_ID(n) := itbLDC_FINAN_COND(n).SUBCATEGORY_ID;
			rcRecOfTab.MIN_VALUE(n) := itbLDC_FINAN_COND(n).MIN_VALUE;
			rcRecOfTab.MAX_VALUE(n) := itbLDC_FINAN_COND(n).MAX_VALUE;
			rcRecOfTab.FINAN_PLAN_ID(n) := itbLDC_FINAN_COND(n).FINAN_PLAN_ID;
			rcRecOfTab.QUOTAS_NUMBER(n) := itbLDC_FINAN_COND(n).QUOTAS_NUMBER;
			rcRecOfTab.row_id(n) := itbLDC_FINAN_COND(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuREC_FINAN_COND_ID
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
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuREC_FINAN_COND_ID = rcData.REC_FINAN_COND_ID
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
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuREC_FINAN_COND_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN		rcError.REC_FINAN_COND_ID:=inuREC_FINAN_COND_ID;

		Load
		(
			inuREC_FINAN_COND_ID
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
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuREC_FINAN_COND_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		orcRecord out nocopy styLDC_FINAN_COND
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN		rcError.REC_FINAN_COND_ID:=inuREC_FINAN_COND_ID;

		Load
		(
			inuREC_FINAN_COND_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN styLDC_FINAN_COND
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID:=inuREC_FINAN_COND_ID;

		Load
		(
			inuREC_FINAN_COND_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type
	)
	RETURN styLDC_FINAN_COND
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID:=inuREC_FINAN_COND_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuREC_FINAN_COND_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_FINAN_COND
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_FINAN_COND
	)
	IS
		rfLDC_FINAN_COND tyrfLDC_FINAN_COND;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_FINAN_COND.*, LDC_FINAN_COND.rowid FROM LDC_FINAN_COND';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_FINAN_COND for sbFullQuery;

		fetch rfLDC_FINAN_COND bulk collect INTO otbResult;

		close rfLDC_FINAN_COND;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_FINAN_COND.*, LDC_FINAN_COND.rowid FROM LDC_FINAN_COND';
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
		ircLDC_FINAN_COND in styLDC_FINAN_COND
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_FINAN_COND,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_FINAN_COND in styLDC_FINAN_COND,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_FINAN_COND.REC_FINAN_COND_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|REC_FINAN_COND_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_FINAN_COND
		(
			REC_FINAN_COND_ID,
			RECO_ACTIVITY,
			GEO_LOCATION_ID,
			CATEGORY_ID,
			SUBCATEGORY_ID,
			MIN_VALUE,
			MAX_VALUE,
			FINAN_PLAN_ID,
			QUOTAS_NUMBER
		)
		values
		(
			ircLDC_FINAN_COND.REC_FINAN_COND_ID,
			ircLDC_FINAN_COND.RECO_ACTIVITY,
			ircLDC_FINAN_COND.GEO_LOCATION_ID,
			ircLDC_FINAN_COND.CATEGORY_ID,
			ircLDC_FINAN_COND.SUBCATEGORY_ID,
			ircLDC_FINAN_COND.MIN_VALUE,
			ircLDC_FINAN_COND.MAX_VALUE,
			ircLDC_FINAN_COND.FINAN_PLAN_ID,
			ircLDC_FINAN_COND.QUOTAS_NUMBER
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_FINAN_COND));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_FINAN_COND in out nocopy tytbLDC_FINAN_COND
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_FINAN_COND,blUseRowID);
		forall n in iotbLDC_FINAN_COND.first..iotbLDC_FINAN_COND.last
			insert into LDC_FINAN_COND
			(
				REC_FINAN_COND_ID,
				RECO_ACTIVITY,
				GEO_LOCATION_ID,
				CATEGORY_ID,
				SUBCATEGORY_ID,
				MIN_VALUE,
				MAX_VALUE,
				FINAN_PLAN_ID,
				QUOTAS_NUMBER
			)
			values
			(
				rcRecOfTab.REC_FINAN_COND_ID(n),
				rcRecOfTab.RECO_ACTIVITY(n),
				rcRecOfTab.GEO_LOCATION_ID(n),
				rcRecOfTab.CATEGORY_ID(n),
				rcRecOfTab.SUBCATEGORY_ID(n),
				rcRecOfTab.MIN_VALUE(n),
				rcRecOfTab.MAX_VALUE(n),
				rcRecOfTab.FINAN_PLAN_ID(n),
				rcRecOfTab.QUOTAS_NUMBER(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;


		delete
		from LDC_FINAN_COND
		where
       		REC_FINAN_COND_ID=inuREC_FINAN_COND_ID;
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
		rcError  styLDC_FINAN_COND;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_FINAN_COND
		where
			rowid = iriRowID
		returning
			REC_FINAN_COND_ID
		into
			rcError.REC_FINAN_COND_ID;
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
		iotbLDC_FINAN_COND in out nocopy tytbLDC_FINAN_COND,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FINAN_COND;
	BEGIN
		FillRecordOfTables(iotbLDC_FINAN_COND, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last
				delete
				from LDC_FINAN_COND
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last loop
					LockByPk
					(
						rcRecOfTab.REC_FINAN_COND_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last
				delete
				from LDC_FINAN_COND
				where
		         	REC_FINAN_COND_ID = rcRecOfTab.REC_FINAN_COND_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_FINAN_COND in styLDC_FINAN_COND,
		inuLock in number default 0
	)
	IS
		nuREC_FINAN_COND_ID	LDC_FINAN_COND.REC_FINAN_COND_ID%type;
	BEGIN
		if ircLDC_FINAN_COND.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_FINAN_COND.rowid,rcData);
			end if;
			update LDC_FINAN_COND
			set
				RECO_ACTIVITY = ircLDC_FINAN_COND.RECO_ACTIVITY,
				GEO_LOCATION_ID = ircLDC_FINAN_COND.GEO_LOCATION_ID,
				CATEGORY_ID = ircLDC_FINAN_COND.CATEGORY_ID,
				SUBCATEGORY_ID = ircLDC_FINAN_COND.SUBCATEGORY_ID,
				MIN_VALUE = ircLDC_FINAN_COND.MIN_VALUE,
				MAX_VALUE = ircLDC_FINAN_COND.MAX_VALUE,
				FINAN_PLAN_ID = ircLDC_FINAN_COND.FINAN_PLAN_ID,
				QUOTAS_NUMBER = ircLDC_FINAN_COND.QUOTAS_NUMBER
			where
				rowid = ircLDC_FINAN_COND.rowid
			returning
				REC_FINAN_COND_ID
			into
				nuREC_FINAN_COND_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_FINAN_COND.REC_FINAN_COND_ID,
					rcData
				);
			end if;

			update LDC_FINAN_COND
			set
				RECO_ACTIVITY = ircLDC_FINAN_COND.RECO_ACTIVITY,
				GEO_LOCATION_ID = ircLDC_FINAN_COND.GEO_LOCATION_ID,
				CATEGORY_ID = ircLDC_FINAN_COND.CATEGORY_ID,
				SUBCATEGORY_ID = ircLDC_FINAN_COND.SUBCATEGORY_ID,
				MIN_VALUE = ircLDC_FINAN_COND.MIN_VALUE,
				MAX_VALUE = ircLDC_FINAN_COND.MAX_VALUE,
				FINAN_PLAN_ID = ircLDC_FINAN_COND.FINAN_PLAN_ID,
				QUOTAS_NUMBER = ircLDC_FINAN_COND.QUOTAS_NUMBER
			where
				REC_FINAN_COND_ID = ircLDC_FINAN_COND.REC_FINAN_COND_ID
			returning
				REC_FINAN_COND_ID
			into
				nuREC_FINAN_COND_ID;
		end if;
		if
			nuREC_FINAN_COND_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_FINAN_COND));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_FINAN_COND in out nocopy tytbLDC_FINAN_COND,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_FINAN_COND;
	BEGIN
		FillRecordOfTables(iotbLDC_FINAN_COND,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last
				update LDC_FINAN_COND
				set
					RECO_ACTIVITY = rcRecOfTab.RECO_ACTIVITY(n),
					GEO_LOCATION_ID = rcRecOfTab.GEO_LOCATION_ID(n),
					CATEGORY_ID = rcRecOfTab.CATEGORY_ID(n),
					SUBCATEGORY_ID = rcRecOfTab.SUBCATEGORY_ID(n),
					MIN_VALUE = rcRecOfTab.MIN_VALUE(n),
					MAX_VALUE = rcRecOfTab.MAX_VALUE(n),
					FINAN_PLAN_ID = rcRecOfTab.FINAN_PLAN_ID(n),
					QUOTAS_NUMBER = rcRecOfTab.QUOTAS_NUMBER(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last loop
					LockByPk
					(
						rcRecOfTab.REC_FINAN_COND_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_FINAN_COND.first .. iotbLDC_FINAN_COND.last
				update LDC_FINAN_COND
				SET
					RECO_ACTIVITY = rcRecOfTab.RECO_ACTIVITY(n),
					GEO_LOCATION_ID = rcRecOfTab.GEO_LOCATION_ID(n),
					CATEGORY_ID = rcRecOfTab.CATEGORY_ID(n),
					SUBCATEGORY_ID = rcRecOfTab.SUBCATEGORY_ID(n),
					MIN_VALUE = rcRecOfTab.MIN_VALUE(n),
					MAX_VALUE = rcRecOfTab.MAX_VALUE(n),
					FINAN_PLAN_ID = rcRecOfTab.FINAN_PLAN_ID(n),
					QUOTAS_NUMBER = rcRecOfTab.QUOTAS_NUMBER(n)
				where
					REC_FINAN_COND_ID = rcRecOfTab.REC_FINAN_COND_ID(n)
;
		end if;
	END;
	PROCEDURE updRECO_ACTIVITY
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRECO_ACTIVITY$ in LDC_FINAN_COND.RECO_ACTIVITY%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			RECO_ACTIVITY = inuRECO_ACTIVITY$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.RECO_ACTIVITY:= inuRECO_ACTIVITY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updGEO_LOCATION_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuGEO_LOCATION_ID$ in LDC_FINAN_COND.GEO_LOCATION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			GEO_LOCATION_ID = inuGEO_LOCATION_ID$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.GEO_LOCATION_ID:= inuGEO_LOCATION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuCATEGORY_ID$ in LDC_FINAN_COND.CATEGORY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			CATEGORY_ID = inuCATEGORY_ID$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CATEGORY_ID:= inuCATEGORY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSUBCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuSUBCATEGORY_ID$ in LDC_FINAN_COND.SUBCATEGORY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			SUBCATEGORY_ID = inuSUBCATEGORY_ID$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBCATEGORY_ID:= inuSUBCATEGORY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMIN_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuMIN_VALUE$ in LDC_FINAN_COND.MIN_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			MIN_VALUE = inuMIN_VALUE$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MIN_VALUE:= inuMIN_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updMAX_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuMAX_VALUE$ in LDC_FINAN_COND.MAX_VALUE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			MAX_VALUE = inuMAX_VALUE$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.MAX_VALUE:= inuMAX_VALUE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFINAN_PLAN_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuFINAN_PLAN_ID$ in LDC_FINAN_COND.FINAN_PLAN_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			FINAN_PLAN_ID = inuFINAN_PLAN_ID$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FINAN_PLAN_ID:= inuFINAN_PLAN_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updQUOTAS_NUMBER
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuQUOTAS_NUMBER$ in LDC_FINAN_COND.QUOTAS_NUMBER%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_FINAN_COND;
	BEGIN
		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;
		if inuLock=1 then
			LockByPk
			(
				inuREC_FINAN_COND_ID,
				rcData
			);
		end if;

		update LDC_FINAN_COND
		set
			QUOTAS_NUMBER = inuQUOTAS_NUMBER$
		where
			REC_FINAN_COND_ID = inuREC_FINAN_COND_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.QUOTAS_NUMBER:= inuQUOTAS_NUMBER$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetREC_FINAN_COND_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.REC_FINAN_COND_ID%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.REC_FINAN_COND_ID);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.REC_FINAN_COND_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetRECO_ACTIVITY
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.RECO_ACTIVITY%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.RECO_ACTIVITY);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.RECO_ACTIVITY);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetGEO_LOCATION_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.GEO_LOCATION_ID%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.GEO_LOCATION_ID);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.GEO_LOCATION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.CATEGORY_ID%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.CATEGORY_ID);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.CATEGORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBCATEGORY_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.SUBCATEGORY_ID%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.SUBCATEGORY_ID);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.SUBCATEGORY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMIN_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.MIN_VALUE%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.MIN_VALUE);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.MIN_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetMAX_VALUE
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.MAX_VALUE%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.MAX_VALUE);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.MAX_VALUE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetFINAN_PLAN_ID
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.FINAN_PLAN_ID%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.FINAN_PLAN_ID);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.FINAN_PLAN_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetQUOTAS_NUMBER
	(
		inuREC_FINAN_COND_ID in LDC_FINAN_COND.REC_FINAN_COND_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_FINAN_COND.QUOTAS_NUMBER%type
	IS
		rcError styLDC_FINAN_COND;
	BEGIN

		rcError.REC_FINAN_COND_ID := inuREC_FINAN_COND_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuREC_FINAN_COND_ID
			 )
		then
			 return(rcData.QUOTAS_NUMBER);
		end if;
		Load
		(
		 		inuREC_FINAN_COND_ID
		);
		return(rcData.QUOTAS_NUMBER);
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
end DALDC_FINAN_COND;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_FINAN_COND
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_FINAN_COND', 'ADM_PERSON'); 
END;
/
