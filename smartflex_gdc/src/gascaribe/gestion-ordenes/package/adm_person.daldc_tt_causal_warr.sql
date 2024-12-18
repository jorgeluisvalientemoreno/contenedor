CREATE OR REPLACE PACKAGE adm_person.daldc_tt_causal_warr
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	IS
		SELECT LDC_TT_CAUSAL_WARR.*,LDC_TT_CAUSAL_WARR.rowid
		FROM LDC_TT_CAUSAL_WARR
		WHERE
		    TT_CAUSAL_WARR_ID = inuTT_CAUSAL_WARR_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TT_CAUSAL_WARR.*,LDC_TT_CAUSAL_WARR.rowid
		FROM LDC_TT_CAUSAL_WARR
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TT_CAUSAL_WARR  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TT_CAUSAL_WARR is table of styLDC_TT_CAUSAL_WARR index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TT_CAUSAL_WARR;

	/* Tipos referenciando al registro */
	type tytbTT_CAUSAL_WARR_ID is table of LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type index by binary_integer;
	type tytbTASK_TYPE_ID is table of LDC_TT_CAUSAL_WARR.TASK_TYPE_ID%type index by binary_integer;
	type tytbCAUSAL_ID is table of LDC_TT_CAUSAL_WARR.CAUSAL_ID%type index by binary_integer;
	type tytbIS_WARRANTY is table of LDC_TT_CAUSAL_WARR.IS_WARRANTY%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TT_CAUSAL_WARR is record
	(
		TT_CAUSAL_WARR_ID   tytbTT_CAUSAL_WARR_ID,
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		CAUSAL_ID   tytbCAUSAL_ID,
		IS_WARRANTY   tytbIS_WARRANTY,
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
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	);

	PROCEDURE getRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		orcRecord out nocopy styLDC_TT_CAUSAL_WARR
	);

	FUNCTION frcGetRcData
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN styLDC_TT_CAUSAL_WARR;

	FUNCTION frcGetRcData
	RETURN styLDC_TT_CAUSAL_WARR;

	FUNCTION frcGetRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN styLDC_TT_CAUSAL_WARR;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TT_CAUSAL_WARR
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TT_CAUSAL_WARR in styLDC_TT_CAUSAL_WARR
	);

	PROCEDURE insRecord
	(
		ircLDC_TT_CAUSAL_WARR in styLDC_TT_CAUSAL_WARR,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TT_CAUSAL_WARR in out nocopy tytbLDC_TT_CAUSAL_WARR
	);

	PROCEDURE delRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TT_CAUSAL_WARR in out nocopy tytbLDC_TT_CAUSAL_WARR,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TT_CAUSAL_WARR in styLDC_TT_CAUSAL_WARR,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TT_CAUSAL_WARR in out nocopy tytbLDC_TT_CAUSAL_WARR,
		inuLock in number default 1
	);

	PROCEDURE updTASK_TYPE_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuTASK_TYPE_ID$ in LDC_TT_CAUSAL_WARR.TASK_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuCAUSAL_ID$ in LDC_TT_CAUSAL_WARR.CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updIS_WARRANTY
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		isbIS_WARRANTY$ in LDC_TT_CAUSAL_WARR.IS_WARRANTY%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTT_CAUSAL_WARR_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.TASK_TYPE_ID%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.CAUSAL_ID%type;

	FUNCTION fsbGetIS_WARRANTY
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.IS_WARRANTY%type;


	PROCEDURE LockByPk
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		orcLDC_TT_CAUSAL_WARR  out styLDC_TT_CAUSAL_WARR
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TT_CAUSAL_WARR  out styLDC_TT_CAUSAL_WARR
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TT_CAUSAL_WARR;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TT_CAUSAL_WARR
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TT_CAUSAL_WARR';
	 cnuGeEntityId constant varchar2(30) := 8178; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	IS
		SELECT LDC_TT_CAUSAL_WARR.*,LDC_TT_CAUSAL_WARR.rowid
		FROM LDC_TT_CAUSAL_WARR
		WHERE  TT_CAUSAL_WARR_ID = inuTT_CAUSAL_WARR_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TT_CAUSAL_WARR.*,LDC_TT_CAUSAL_WARR.rowid
		FROM LDC_TT_CAUSAL_WARR
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TT_CAUSAL_WARR is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TT_CAUSAL_WARR;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TT_CAUSAL_WARR default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TT_CAUSAL_WARR_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		orcLDC_TT_CAUSAL_WARR  out styLDC_TT_CAUSAL_WARR
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;

		Open cuLockRcByPk
		(
			inuTT_CAUSAL_WARR_ID
		);

		fetch cuLockRcByPk into orcLDC_TT_CAUSAL_WARR;
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
		orcLDC_TT_CAUSAL_WARR  out styLDC_TT_CAUSAL_WARR
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TT_CAUSAL_WARR;
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
		itbLDC_TT_CAUSAL_WARR  in out nocopy tytbLDC_TT_CAUSAL_WARR
	)
	IS
	BEGIN
			rcRecOfTab.TT_CAUSAL_WARR_ID.delete;
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.IS_WARRANTY.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TT_CAUSAL_WARR  in out nocopy tytbLDC_TT_CAUSAL_WARR,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TT_CAUSAL_WARR);

		for n in itbLDC_TT_CAUSAL_WARR.first .. itbLDC_TT_CAUSAL_WARR.last loop
			rcRecOfTab.TT_CAUSAL_WARR_ID(n) := itbLDC_TT_CAUSAL_WARR(n).TT_CAUSAL_WARR_ID;
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_TT_CAUSAL_WARR(n).TASK_TYPE_ID;
			rcRecOfTab.CAUSAL_ID(n) := itbLDC_TT_CAUSAL_WARR(n).CAUSAL_ID;
			rcRecOfTab.IS_WARRANTY(n) := itbLDC_TT_CAUSAL_WARR(n).IS_WARRANTY;
			rcRecOfTab.row_id(n) := itbLDC_TT_CAUSAL_WARR(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTT_CAUSAL_WARR_ID
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
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTT_CAUSAL_WARR_ID = rcData.TT_CAUSAL_WARR_ID
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
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTT_CAUSAL_WARR_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN		rcError.TT_CAUSAL_WARR_ID:=inuTT_CAUSAL_WARR_ID;

		Load
		(
			inuTT_CAUSAL_WARR_ID
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
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTT_CAUSAL_WARR_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		orcRecord out nocopy styLDC_TT_CAUSAL_WARR
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN		rcError.TT_CAUSAL_WARR_ID:=inuTT_CAUSAL_WARR_ID;

		Load
		(
			inuTT_CAUSAL_WARR_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN styLDC_TT_CAUSAL_WARR
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID:=inuTT_CAUSAL_WARR_ID;

		Load
		(
			inuTT_CAUSAL_WARR_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	)
	RETURN styLDC_TT_CAUSAL_WARR
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID:=inuTT_CAUSAL_WARR_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTT_CAUSAL_WARR_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTT_CAUSAL_WARR_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TT_CAUSAL_WARR
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TT_CAUSAL_WARR
	)
	IS
		rfLDC_TT_CAUSAL_WARR tyrfLDC_TT_CAUSAL_WARR;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TT_CAUSAL_WARR.*, LDC_TT_CAUSAL_WARR.rowid FROM LDC_TT_CAUSAL_WARR';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TT_CAUSAL_WARR for sbFullQuery;

		fetch rfLDC_TT_CAUSAL_WARR bulk collect INTO otbResult;

		close rfLDC_TT_CAUSAL_WARR;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TT_CAUSAL_WARR.*, LDC_TT_CAUSAL_WARR.rowid FROM LDC_TT_CAUSAL_WARR';
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
		ircLDC_TT_CAUSAL_WARR in styLDC_TT_CAUSAL_WARR
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TT_CAUSAL_WARR,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TT_CAUSAL_WARR in styLDC_TT_CAUSAL_WARR,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TT_CAUSAL_WARR_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TT_CAUSAL_WARR
		(
			TT_CAUSAL_WARR_ID,
			TASK_TYPE_ID,
			CAUSAL_ID,
			IS_WARRANTY
		)
		values
		(
			ircLDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID,
			ircLDC_TT_CAUSAL_WARR.TASK_TYPE_ID,
			ircLDC_TT_CAUSAL_WARR.CAUSAL_ID,
			ircLDC_TT_CAUSAL_WARR.IS_WARRANTY
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TT_CAUSAL_WARR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TT_CAUSAL_WARR in out nocopy tytbLDC_TT_CAUSAL_WARR
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_CAUSAL_WARR,blUseRowID);
		forall n in iotbLDC_TT_CAUSAL_WARR.first..iotbLDC_TT_CAUSAL_WARR.last
			insert into LDC_TT_CAUSAL_WARR
			(
				TT_CAUSAL_WARR_ID,
				TASK_TYPE_ID,
				CAUSAL_ID,
				IS_WARRANTY
			)
			values
			(
				rcRecOfTab.TT_CAUSAL_WARR_ID(n),
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.IS_WARRANTY(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTT_CAUSAL_WARR_ID,
				rcData
			);
		end if;


		delete
		from LDC_TT_CAUSAL_WARR
		where
       		TT_CAUSAL_WARR_ID=inuTT_CAUSAL_WARR_ID;
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
		rcError  styLDC_TT_CAUSAL_WARR;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TT_CAUSAL_WARR
		where
			rowid = iriRowID
		returning
			TT_CAUSAL_WARR_ID
		into
			rcError.TT_CAUSAL_WARR_ID;
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
		iotbLDC_TT_CAUSAL_WARR in out nocopy tytbLDC_TT_CAUSAL_WARR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TT_CAUSAL_WARR;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_CAUSAL_WARR, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last
				delete
				from LDC_TT_CAUSAL_WARR
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last loop
					LockByPk
					(
						rcRecOfTab.TT_CAUSAL_WARR_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last
				delete
				from LDC_TT_CAUSAL_WARR
				where
		         	TT_CAUSAL_WARR_ID = rcRecOfTab.TT_CAUSAL_WARR_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TT_CAUSAL_WARR in styLDC_TT_CAUSAL_WARR,
		inuLock in number default 0
	)
	IS
		nuTT_CAUSAL_WARR_ID	LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type;
	BEGIN
		if ircLDC_TT_CAUSAL_WARR.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TT_CAUSAL_WARR.rowid,rcData);
			end if;
			update LDC_TT_CAUSAL_WARR
			set
				TASK_TYPE_ID = ircLDC_TT_CAUSAL_WARR.TASK_TYPE_ID,
				CAUSAL_ID = ircLDC_TT_CAUSAL_WARR.CAUSAL_ID,
				IS_WARRANTY = ircLDC_TT_CAUSAL_WARR.IS_WARRANTY
			where
				rowid = ircLDC_TT_CAUSAL_WARR.rowid
			returning
				TT_CAUSAL_WARR_ID
			into
				nuTT_CAUSAL_WARR_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID,
					rcData
				);
			end if;

			update LDC_TT_CAUSAL_WARR
			set
				TASK_TYPE_ID = ircLDC_TT_CAUSAL_WARR.TASK_TYPE_ID,
				CAUSAL_ID = ircLDC_TT_CAUSAL_WARR.CAUSAL_ID,
				IS_WARRANTY = ircLDC_TT_CAUSAL_WARR.IS_WARRANTY
			where
				TT_CAUSAL_WARR_ID = ircLDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID
			returning
				TT_CAUSAL_WARR_ID
			into
				nuTT_CAUSAL_WARR_ID;
		end if;
		if
			nuTT_CAUSAL_WARR_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TT_CAUSAL_WARR));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TT_CAUSAL_WARR in out nocopy tytbLDC_TT_CAUSAL_WARR,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TT_CAUSAL_WARR;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_CAUSAL_WARR,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last
				update LDC_TT_CAUSAL_WARR
				set
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					IS_WARRANTY = rcRecOfTab.IS_WARRANTY(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last loop
					LockByPk
					(
						rcRecOfTab.TT_CAUSAL_WARR_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_CAUSAL_WARR.first .. iotbLDC_TT_CAUSAL_WARR.last
				update LDC_TT_CAUSAL_WARR
				SET
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					IS_WARRANTY = rcRecOfTab.IS_WARRANTY(n)
				where
					TT_CAUSAL_WARR_ID = rcRecOfTab.TT_CAUSAL_WARR_ID(n)
;
		end if;
	END;
	PROCEDURE updTASK_TYPE_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuTASK_TYPE_ID$ in LDC_TT_CAUSAL_WARR.TASK_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_CAUSAL_WARR_ID,
				rcData
			);
		end if;

		update LDC_TT_CAUSAL_WARR
		set
			TASK_TYPE_ID = inuTASK_TYPE_ID$
		where
			TT_CAUSAL_WARR_ID = inuTT_CAUSAL_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TASK_TYPE_ID:= inuTASK_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuCAUSAL_ID$ in LDC_TT_CAUSAL_WARR.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_CAUSAL_WARR_ID,
				rcData
			);
		end if;

		update LDC_TT_CAUSAL_WARR
		set
			CAUSAL_ID = inuCAUSAL_ID$
		where
			TT_CAUSAL_WARR_ID = inuTT_CAUSAL_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updIS_WARRANTY
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		isbIS_WARRANTY$ in LDC_TT_CAUSAL_WARR.IS_WARRANTY%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN
		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_CAUSAL_WARR_ID,
				rcData
			);
		end if;

		update LDC_TT_CAUSAL_WARR
		set
			IS_WARRANTY = isbIS_WARRANTY$
		where
			TT_CAUSAL_WARR_ID = inuTT_CAUSAL_WARR_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.IS_WARRANTY:= isbIS_WARRANTY$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTT_CAUSAL_WARR_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN

		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_CAUSAL_WARR_ID
			 )
		then
			 return(rcData.TT_CAUSAL_WARR_ID);
		end if;
		Load
		(
		 		inuTT_CAUSAL_WARR_ID
		);
		return(rcData.TT_CAUSAL_WARR_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.TASK_TYPE_ID%type
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN

		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_CAUSAL_WARR_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuTT_CAUSAL_WARR_ID
		);
		return(rcData.TASK_TYPE_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetCAUSAL_ID
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.CAUSAL_ID%type
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN

		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_CAUSAL_WARR_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuTT_CAUSAL_WARR_ID
		);
		return(rcData.CAUSAL_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetIS_WARRANTY
	(
		inuTT_CAUSAL_WARR_ID in LDC_TT_CAUSAL_WARR.TT_CAUSAL_WARR_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_CAUSAL_WARR.IS_WARRANTY%type
	IS
		rcError styLDC_TT_CAUSAL_WARR;
	BEGIN

		rcError.TT_CAUSAL_WARR_ID := inuTT_CAUSAL_WARR_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_CAUSAL_WARR_ID
			 )
		then
			 return(rcData.IS_WARRANTY);
		end if;
		Load
		(
		 		inuTT_CAUSAL_WARR_ID
		);
		return(rcData.IS_WARRANTY);
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
end DALDC_TT_CAUSAL_WARR;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TT_CAUSAL_WARR
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TT_CAUSAL_WARR', 'ADM_PERSON'); 
END;
/
