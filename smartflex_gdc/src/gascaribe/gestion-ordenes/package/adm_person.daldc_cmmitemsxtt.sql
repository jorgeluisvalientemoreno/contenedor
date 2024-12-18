CREATE OR REPLACE PACKAGE adm_person.daldc_cmmitemsxtt
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	IS
		SELECT LDC_CMMITEMSXTT.*,LDC_CMMITEMSXTT.rowid
		FROM LDC_CMMITEMSXTT
		WHERE
		    ITEMSXTT_ID = inuITEMSXTT_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_CMMITEMSXTT.*,LDC_CMMITEMSXTT.rowid
		FROM LDC_CMMITEMSXTT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_CMMITEMSXTT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_CMMITEMSXTT is table of styLDC_CMMITEMSXTT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_CMMITEMSXTT;

	/* Tipos referenciando al registro */
	type tytbITEMSXTT_ID is table of LDC_CMMITEMSXTT.ITEMSXTT_ID%type index by binary_integer;
	type tytbTASK_TYPE_ID is table of LDC_CMMITEMSXTT.TASK_TYPE_ID%type index by binary_integer;
	type tytbITEMS_ID is table of LDC_CMMITEMSXTT.ITEMS_ID%type index by binary_integer;
	type tytbACTIVITY_ID is table of LDC_CMMITEMSXTT.ACTIVITY_ID%type index by binary_integer;
	type tytbITEM_AMOUNT_MIN is table of LDC_CMMITEMSXTT.ITEM_AMOUNT_MIN%type index by binary_integer;
	type tytbITEM_AMOUNT_MAX is table of LDC_CMMITEMSXTT.ITEM_AMOUNT_MAX%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_CMMITEMSXTT is record
	(
		ITEMSXTT_ID   tytbITEMSXTT_ID,
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		ITEMS_ID   tytbITEMS_ID,
		ACTIVITY_ID   tytbACTIVITY_ID,
		ITEM_AMOUNT_MIN   tytbITEM_AMOUNT_MIN,
		ITEM_AMOUNT_MAX   tytbITEM_AMOUNT_MAX,
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
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	);

	PROCEDURE getRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		orcRecord out nocopy styLDC_CMMITEMSXTT
	);

	FUNCTION frcGetRcData
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN styLDC_CMMITEMSXTT;

	FUNCTION frcGetRcData
	RETURN styLDC_CMMITEMSXTT;

	FUNCTION frcGetRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN styLDC_CMMITEMSXTT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CMMITEMSXTT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_CMMITEMSXTT in styLDC_CMMITEMSXTT
	);

	PROCEDURE insRecord
	(
		ircLDC_CMMITEMSXTT in styLDC_CMMITEMSXTT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_CMMITEMSXTT in out nocopy tytbLDC_CMMITEMSXTT
	);

	PROCEDURE delRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_CMMITEMSXTT in out nocopy tytbLDC_CMMITEMSXTT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_CMMITEMSXTT in styLDC_CMMITEMSXTT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_CMMITEMSXTT in out nocopy tytbLDC_CMMITEMSXTT,
		inuLock in number default 1
	);

	PROCEDURE updTASK_TYPE_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuTASK_TYPE_ID$ in LDC_CMMITEMSXTT.TASK_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updITEMS_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuITEMS_ID$ in LDC_CMMITEMSXTT.ITEMS_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updACTIVITY_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuACTIVITY_ID$ in LDC_CMMITEMSXTT.ACTIVITY_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updITEM_AMOUNT_MIN
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuITEM_AMOUNT_MIN$ in LDC_CMMITEMSXTT.ITEM_AMOUNT_MIN%type,
		inuLock in number default 0
	);

	PROCEDURE updITEM_AMOUNT_MAX
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuITEM_AMOUNT_MAX$ in LDC_CMMITEMSXTT.ITEM_AMOUNT_MAX%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetITEMSXTT_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEMSXTT_ID%type;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.TASK_TYPE_ID%type;

	FUNCTION fnuGetITEMS_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEMS_ID%type;

	FUNCTION fnuGetACTIVITY_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ACTIVITY_ID%type;

	FUNCTION fnuGetITEM_AMOUNT_MIN
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEM_AMOUNT_MIN%type;

	FUNCTION fnuGetITEM_AMOUNT_MAX
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEM_AMOUNT_MAX%type;


	PROCEDURE LockByPk
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		orcLDC_CMMITEMSXTT  out styLDC_CMMITEMSXTT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_CMMITEMSXTT  out styLDC_CMMITEMSXTT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_CMMITEMSXTT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_CMMITEMSXTT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_CMMITEMSXTT';
	 cnuGeEntityId constant varchar2(30) := 4637; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	IS
		SELECT LDC_CMMITEMSXTT.*,LDC_CMMITEMSXTT.rowid
		FROM LDC_CMMITEMSXTT
		WHERE  ITEMSXTT_ID = inuITEMSXTT_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_CMMITEMSXTT.*,LDC_CMMITEMSXTT.rowid
		FROM LDC_CMMITEMSXTT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_CMMITEMSXTT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_CMMITEMSXTT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_CMMITEMSXTT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.ITEMSXTT_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		orcLDC_CMMITEMSXTT  out styLDC_CMMITEMSXTT
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

		Open cuLockRcByPk
		(
			inuITEMSXTT_ID
		);

		fetch cuLockRcByPk into orcLDC_CMMITEMSXTT;
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
		orcLDC_CMMITEMSXTT  out styLDC_CMMITEMSXTT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_CMMITEMSXTT;
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
		itbLDC_CMMITEMSXTT  in out nocopy tytbLDC_CMMITEMSXTT
	)
	IS
	BEGIN
			rcRecOfTab.ITEMSXTT_ID.delete;
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.ITEMS_ID.delete;
			rcRecOfTab.ACTIVITY_ID.delete;
			rcRecOfTab.ITEM_AMOUNT_MIN.delete;
			rcRecOfTab.ITEM_AMOUNT_MAX.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_CMMITEMSXTT  in out nocopy tytbLDC_CMMITEMSXTT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_CMMITEMSXTT);

		for n in itbLDC_CMMITEMSXTT.first .. itbLDC_CMMITEMSXTT.last loop
			rcRecOfTab.ITEMSXTT_ID(n) := itbLDC_CMMITEMSXTT(n).ITEMSXTT_ID;
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_CMMITEMSXTT(n).TASK_TYPE_ID;
			rcRecOfTab.ITEMS_ID(n) := itbLDC_CMMITEMSXTT(n).ITEMS_ID;
			rcRecOfTab.ACTIVITY_ID(n) := itbLDC_CMMITEMSXTT(n).ACTIVITY_ID;
			rcRecOfTab.ITEM_AMOUNT_MIN(n) := itbLDC_CMMITEMSXTT(n).ITEM_AMOUNT_MIN;
			rcRecOfTab.ITEM_AMOUNT_MAX(n) := itbLDC_CMMITEMSXTT(n).ITEM_AMOUNT_MAX;
			rcRecOfTab.row_id(n) := itbLDC_CMMITEMSXTT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuITEMSXTT_ID
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
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuITEMSXTT_ID = rcData.ITEMSXTT_ID
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
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuITEMSXTT_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN		rcError.ITEMSXTT_ID:=inuITEMSXTT_ID;

		Load
		(
			inuITEMSXTT_ID
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
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuITEMSXTT_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		orcRecord out nocopy styLDC_CMMITEMSXTT
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN		rcError.ITEMSXTT_ID:=inuITEMSXTT_ID;

		Load
		(
			inuITEMSXTT_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN styLDC_CMMITEMSXTT
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID:=inuITEMSXTT_ID;

		Load
		(
			inuITEMSXTT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	)
	RETURN styLDC_CMMITEMSXTT
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID:=inuITEMSXTT_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuITEMSXTT_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuITEMSXTT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_CMMITEMSXTT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_CMMITEMSXTT
	)
	IS
		rfLDC_CMMITEMSXTT tyrfLDC_CMMITEMSXTT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_CMMITEMSXTT.*, LDC_CMMITEMSXTT.rowid FROM LDC_CMMITEMSXTT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_CMMITEMSXTT for sbFullQuery;

		fetch rfLDC_CMMITEMSXTT bulk collect INTO otbResult;

		close rfLDC_CMMITEMSXTT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_CMMITEMSXTT.*, LDC_CMMITEMSXTT.rowid FROM LDC_CMMITEMSXTT';
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
		ircLDC_CMMITEMSXTT in styLDC_CMMITEMSXTT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_CMMITEMSXTT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_CMMITEMSXTT in styLDC_CMMITEMSXTT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_CMMITEMSXTT.ITEMSXTT_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ITEMSXTT_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_CMMITEMSXTT
		(
			ITEMSXTT_ID,
			TASK_TYPE_ID,
			ITEMS_ID,
			ACTIVITY_ID,
			ITEM_AMOUNT_MIN,
			ITEM_AMOUNT_MAX
		)
		values
		(
			ircLDC_CMMITEMSXTT.ITEMSXTT_ID,
			ircLDC_CMMITEMSXTT.TASK_TYPE_ID,
			ircLDC_CMMITEMSXTT.ITEMS_ID,
			ircLDC_CMMITEMSXTT.ACTIVITY_ID,
			ircLDC_CMMITEMSXTT.ITEM_AMOUNT_MIN,
			ircLDC_CMMITEMSXTT.ITEM_AMOUNT_MAX
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_CMMITEMSXTT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_CMMITEMSXTT in out nocopy tytbLDC_CMMITEMSXTT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_CMMITEMSXTT,blUseRowID);
		forall n in iotbLDC_CMMITEMSXTT.first..iotbLDC_CMMITEMSXTT.last
			insert into LDC_CMMITEMSXTT
			(
				ITEMSXTT_ID,
				TASK_TYPE_ID,
				ITEMS_ID,
				ACTIVITY_ID,
				ITEM_AMOUNT_MIN,
				ITEM_AMOUNT_MAX
			)
			values
			(
				rcRecOfTab.ITEMSXTT_ID(n),
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.ITEMS_ID(n),
				rcRecOfTab.ACTIVITY_ID(n),
				rcRecOfTab.ITEM_AMOUNT_MIN(n),
				rcRecOfTab.ITEM_AMOUNT_MAX(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

		if inuLock=1 then
			LockByPk
			(
				inuITEMSXTT_ID,
				rcData
			);
		end if;


		delete
		from LDC_CMMITEMSXTT
		where
       		ITEMSXTT_ID=inuITEMSXTT_ID;
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
		rcError  styLDC_CMMITEMSXTT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_CMMITEMSXTT
		where
			rowid = iriRowID
		returning
			ITEMSXTT_ID
		into
			rcError.ITEMSXTT_ID;
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
		iotbLDC_CMMITEMSXTT in out nocopy tytbLDC_CMMITEMSXTT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CMMITEMSXTT;
	BEGIN
		FillRecordOfTables(iotbLDC_CMMITEMSXTT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last
				delete
				from LDC_CMMITEMSXTT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last loop
					LockByPk
					(
						rcRecOfTab.ITEMSXTT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last
				delete
				from LDC_CMMITEMSXTT
				where
		         	ITEMSXTT_ID = rcRecOfTab.ITEMSXTT_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_CMMITEMSXTT in styLDC_CMMITEMSXTT,
		inuLock in number default 0
	)
	IS
		nuITEMSXTT_ID	LDC_CMMITEMSXTT.ITEMSXTT_ID%type;
	BEGIN
		if ircLDC_CMMITEMSXTT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_CMMITEMSXTT.rowid,rcData);
			end if;
			update LDC_CMMITEMSXTT
			set
				TASK_TYPE_ID = ircLDC_CMMITEMSXTT.TASK_TYPE_ID,
				ITEMS_ID = ircLDC_CMMITEMSXTT.ITEMS_ID,
				ACTIVITY_ID = ircLDC_CMMITEMSXTT.ACTIVITY_ID,
				ITEM_AMOUNT_MIN = ircLDC_CMMITEMSXTT.ITEM_AMOUNT_MIN,
				ITEM_AMOUNT_MAX = ircLDC_CMMITEMSXTT.ITEM_AMOUNT_MAX
			where
				rowid = ircLDC_CMMITEMSXTT.rowid
			returning
				ITEMSXTT_ID
			into
				nuITEMSXTT_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_CMMITEMSXTT.ITEMSXTT_ID,
					rcData
				);
			end if;

			update LDC_CMMITEMSXTT
			set
				TASK_TYPE_ID = ircLDC_CMMITEMSXTT.TASK_TYPE_ID,
				ITEMS_ID = ircLDC_CMMITEMSXTT.ITEMS_ID,
				ACTIVITY_ID = ircLDC_CMMITEMSXTT.ACTIVITY_ID,
				ITEM_AMOUNT_MIN = ircLDC_CMMITEMSXTT.ITEM_AMOUNT_MIN,
				ITEM_AMOUNT_MAX = ircLDC_CMMITEMSXTT.ITEM_AMOUNT_MAX
			where
				ITEMSXTT_ID = ircLDC_CMMITEMSXTT.ITEMSXTT_ID
			returning
				ITEMSXTT_ID
			into
				nuITEMSXTT_ID;
		end if;
		if
			nuITEMSXTT_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_CMMITEMSXTT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_CMMITEMSXTT in out nocopy tytbLDC_CMMITEMSXTT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_CMMITEMSXTT;
	BEGIN
		FillRecordOfTables(iotbLDC_CMMITEMSXTT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last
				update LDC_CMMITEMSXTT
				set
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ITEMS_ID = rcRecOfTab.ITEMS_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					ITEM_AMOUNT_MIN = rcRecOfTab.ITEM_AMOUNT_MIN(n),
					ITEM_AMOUNT_MAX = rcRecOfTab.ITEM_AMOUNT_MAX(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last loop
					LockByPk
					(
						rcRecOfTab.ITEMSXTT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_CMMITEMSXTT.first .. iotbLDC_CMMITEMSXTT.last
				update LDC_CMMITEMSXTT
				SET
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ITEMS_ID = rcRecOfTab.ITEMS_ID(n),
					ACTIVITY_ID = rcRecOfTab.ACTIVITY_ID(n),
					ITEM_AMOUNT_MIN = rcRecOfTab.ITEM_AMOUNT_MIN(n),
					ITEM_AMOUNT_MAX = rcRecOfTab.ITEM_AMOUNT_MAX(n)
				where
					ITEMSXTT_ID = rcRecOfTab.ITEMSXTT_ID(n)
;
		end if;
	END;
	PROCEDURE updTASK_TYPE_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuTASK_TYPE_ID$ in LDC_CMMITEMSXTT.TASK_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEMSXTT_ID,
				rcData
			);
		end if;

		update LDC_CMMITEMSXTT
		set
			TASK_TYPE_ID = inuTASK_TYPE_ID$
		where
			ITEMSXTT_ID = inuITEMSXTT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TASK_TYPE_ID:= inuTASK_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEMS_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuITEMS_ID$ in LDC_CMMITEMSXTT.ITEMS_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEMSXTT_ID,
				rcData
			);
		end if;

		update LDC_CMMITEMSXTT
		set
			ITEMS_ID = inuITEMS_ID$
		where
			ITEMSXTT_ID = inuITEMSXTT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEMS_ID:= inuITEMS_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updACTIVITY_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuACTIVITY_ID$ in LDC_CMMITEMSXTT.ACTIVITY_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEMSXTT_ID,
				rcData
			);
		end if;

		update LDC_CMMITEMSXTT
		set
			ACTIVITY_ID = inuACTIVITY_ID$
		where
			ITEMSXTT_ID = inuITEMSXTT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ACTIVITY_ID:= inuACTIVITY_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEM_AMOUNT_MIN
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuITEM_AMOUNT_MIN$ in LDC_CMMITEMSXTT.ITEM_AMOUNT_MIN%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEMSXTT_ID,
				rcData
			);
		end if;

		update LDC_CMMITEMSXTT
		set
			ITEM_AMOUNT_MIN = inuITEM_AMOUNT_MIN$
		where
			ITEMSXTT_ID = inuITEMSXTT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_AMOUNT_MIN:= inuITEM_AMOUNT_MIN$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEM_AMOUNT_MAX
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuITEM_AMOUNT_MAX$ in LDC_CMMITEMSXTT.ITEM_AMOUNT_MAX%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN
		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuITEMSXTT_ID,
				rcData
			);
		end if;

		update LDC_CMMITEMSXTT
		set
			ITEM_AMOUNT_MAX = inuITEM_AMOUNT_MAX$
		where
			ITEMSXTT_ID = inuITEMSXTT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_AMOUNT_MAX:= inuITEM_AMOUNT_MAX$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetITEMSXTT_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEMSXTT_ID%type
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN

		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEMSXTT_ID
			 )
		then
			 return(rcData.ITEMSXTT_ID);
		end if;
		Load
		(
		 		inuITEMSXTT_ID
		);
		return(rcData.ITEMSXTT_ID);
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
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.TASK_TYPE_ID%type
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN

		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEMSXTT_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuITEMSXTT_ID
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
	FUNCTION fnuGetITEMS_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEMS_ID%type
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN

		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEMSXTT_ID
			 )
		then
			 return(rcData.ITEMS_ID);
		end if;
		Load
		(
		 		inuITEMSXTT_ID
		);
		return(rcData.ITEMS_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetACTIVITY_ID
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ACTIVITY_ID%type
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN

		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEMSXTT_ID
			 )
		then
			 return(rcData.ACTIVITY_ID);
		end if;
		Load
		(
		 		inuITEMSXTT_ID
		);
		return(rcData.ACTIVITY_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITEM_AMOUNT_MIN
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEM_AMOUNT_MIN%type
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN

		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEMSXTT_ID
			 )
		then
			 return(rcData.ITEM_AMOUNT_MIN);
		end if;
		Load
		(
		 		inuITEMSXTT_ID
		);
		return(rcData.ITEM_AMOUNT_MIN);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetITEM_AMOUNT_MAX
	(
		inuITEMSXTT_ID in LDC_CMMITEMSXTT.ITEMSXTT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_CMMITEMSXTT.ITEM_AMOUNT_MAX%type
	IS
		rcError styLDC_CMMITEMSXTT;
	BEGIN

		rcError.ITEMSXTT_ID := inuITEMSXTT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuITEMSXTT_ID
			 )
		then
			 return(rcData.ITEM_AMOUNT_MAX);
		end if;
		Load
		(
		 		inuITEMSXTT_ID
		);
		return(rcData.ITEM_AMOUNT_MAX);
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
end DALDC_CMMITEMSXTT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_CMMITEMSXTT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_CMMITEMSXTT', 'ADM_PERSON'); 
END;
/

