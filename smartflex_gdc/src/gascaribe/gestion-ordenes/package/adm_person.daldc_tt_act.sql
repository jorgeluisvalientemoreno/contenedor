CREATE OR REPLACE PACKAGE adm_person.daldc_tt_act
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	IS
		SELECT LDC_TT_ACT.*,LDC_TT_ACT.rowid
		FROM LDC_TT_ACT
		WHERE
		    TT_ACT_ID = inuTT_ACT_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TT_ACT.*,LDC_TT_ACT.rowid
		FROM LDC_TT_ACT
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TT_ACT  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TT_ACT is table of styLDC_TT_ACT index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TT_ACT;

	/* Tipos referenciando al registro */
	type tytbTT_ACT_ID is table of LDC_TT_ACT.TT_ACT_ID%type index by binary_integer;
	type tytbTASK_TYPE_ID is table of LDC_TT_ACT.TASK_TYPE_ID%type index by binary_integer;
	type tytbITEM_ID is table of LDC_TT_ACT.ITEM_ID%type index by binary_integer;
	type tytbFLAG_CAUSAL is table of LDC_TT_ACT.FLAG_CAUSAL%type index by binary_integer;
	type tytbCAUSAL_ID is table of LDC_TT_ACT.CAUSAL_ID%type index by binary_integer;
	type tytbCLASS_CAUSAL_ID is table of LDC_TT_ACT.CLASS_CAUSAL_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TT_ACT is record
	(
		TT_ACT_ID   tytbTT_ACT_ID,
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		ITEM_ID   tytbITEM_ID,
		FLAG_CAUSAL   tytbFLAG_CAUSAL,
		CAUSAL_ID   tytbCAUSAL_ID,
		CLASS_CAUSAL_ID   tytbCLASS_CAUSAL_ID,
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
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	);

	PROCEDURE getRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		orcRecord out nocopy styLDC_TT_ACT
	);

	FUNCTION frcGetRcData
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN styLDC_TT_ACT;

	FUNCTION frcGetRcData
	RETURN styLDC_TT_ACT;

	FUNCTION frcGetRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN styLDC_TT_ACT;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TT_ACT
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TT_ACT in styLDC_TT_ACT
	);

	PROCEDURE insRecord
	(
		ircLDC_TT_ACT in styLDC_TT_ACT,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TT_ACT in out nocopy tytbLDC_TT_ACT
	);

	PROCEDURE delRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TT_ACT in out nocopy tytbLDC_TT_ACT,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TT_ACT in styLDC_TT_ACT,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TT_ACT in out nocopy tytbLDC_TT_ACT,
		inuLock in number default 1
	);

	PROCEDURE updTASK_TYPE_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuTASK_TYPE_ID$ in LDC_TT_ACT.TASK_TYPE_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updITEM_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuITEM_ID$ in LDC_TT_ACT.ITEM_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updFLAG_CAUSAL
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		isbFLAG_CAUSAL$ in LDC_TT_ACT.FLAG_CAUSAL%type,
		inuLock in number default 0
	);

	PROCEDURE updCAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuCAUSAL_ID$ in LDC_TT_ACT.CAUSAL_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updCLASS_CAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuCLASS_CAUSAL_ID$ in LDC_TT_ACT.CLASS_CAUSAL_ID%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetTT_ACT_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.TT_ACT_ID%type;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.TASK_TYPE_ID%type;

	FUNCTION fnuGetITEM_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.ITEM_ID%type;

	FUNCTION fsbGetFLAG_CAUSAL
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.FLAG_CAUSAL%type;

	FUNCTION fnuGetCAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.CAUSAL_ID%type;

	FUNCTION fnuGetCLASS_CAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.CLASS_CAUSAL_ID%type;


	PROCEDURE LockByPk
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		orcLDC_TT_ACT  out styLDC_TT_ACT
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TT_ACT  out styLDC_TT_ACT
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TT_ACT;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TT_ACT
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TT_ACT';
	 cnuGeEntityId constant varchar2(30) := 8630; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	IS
		SELECT LDC_TT_ACT.*,LDC_TT_ACT.rowid
		FROM LDC_TT_ACT
		WHERE  TT_ACT_ID = inuTT_ACT_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TT_ACT.*,LDC_TT_ACT.rowid
		FROM LDC_TT_ACT
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TT_ACT is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TT_ACT;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TT_ACT default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TT_ACT_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		orcLDC_TT_ACT  out styLDC_TT_ACT
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;

		Open cuLockRcByPk
		(
			inuTT_ACT_ID
		);

		fetch cuLockRcByPk into orcLDC_TT_ACT;
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
		orcLDC_TT_ACT  out styLDC_TT_ACT
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TT_ACT;
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
		itbLDC_TT_ACT  in out nocopy tytbLDC_TT_ACT
	)
	IS
	BEGIN
			rcRecOfTab.TT_ACT_ID.delete;
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.ITEM_ID.delete;
			rcRecOfTab.FLAG_CAUSAL.delete;
			rcRecOfTab.CAUSAL_ID.delete;
			rcRecOfTab.CLASS_CAUSAL_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TT_ACT  in out nocopy tytbLDC_TT_ACT,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TT_ACT);

		for n in itbLDC_TT_ACT.first .. itbLDC_TT_ACT.last loop
			rcRecOfTab.TT_ACT_ID(n) := itbLDC_TT_ACT(n).TT_ACT_ID;
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_TT_ACT(n).TASK_TYPE_ID;
			rcRecOfTab.ITEM_ID(n) := itbLDC_TT_ACT(n).ITEM_ID;
			rcRecOfTab.FLAG_CAUSAL(n) := itbLDC_TT_ACT(n).FLAG_CAUSAL;
			rcRecOfTab.CAUSAL_ID(n) := itbLDC_TT_ACT(n).CAUSAL_ID;
			rcRecOfTab.CLASS_CAUSAL_ID(n) := itbLDC_TT_ACT(n).CLASS_CAUSAL_ID;
			rcRecOfTab.row_id(n) := itbLDC_TT_ACT(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTT_ACT_ID
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
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTT_ACT_ID = rcData.TT_ACT_ID
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
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTT_ACT_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN		rcError.TT_ACT_ID:=inuTT_ACT_ID;

		Load
		(
			inuTT_ACT_ID
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
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTT_ACT_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		orcRecord out nocopy styLDC_TT_ACT
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN		rcError.TT_ACT_ID:=inuTT_ACT_ID;

		Load
		(
			inuTT_ACT_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN styLDC_TT_ACT
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID:=inuTT_ACT_ID;

		Load
		(
			inuTT_ACT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type
	)
	RETURN styLDC_TT_ACT
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID:=inuTT_ACT_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTT_ACT_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTT_ACT_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TT_ACT
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TT_ACT
	)
	IS
		rfLDC_TT_ACT tyrfLDC_TT_ACT;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TT_ACT.*, LDC_TT_ACT.rowid FROM LDC_TT_ACT';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TT_ACT for sbFullQuery;

		fetch rfLDC_TT_ACT bulk collect INTO otbResult;

		close rfLDC_TT_ACT;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TT_ACT.*, LDC_TT_ACT.rowid FROM LDC_TT_ACT';
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
		ircLDC_TT_ACT in styLDC_TT_ACT
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TT_ACT,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TT_ACT in styLDC_TT_ACT,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TT_ACT.TT_ACT_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TT_ACT_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TT_ACT
		(
			TT_ACT_ID,
			TASK_TYPE_ID,
			ITEM_ID,
			FLAG_CAUSAL,
			CAUSAL_ID,
			CLASS_CAUSAL_ID
		)
		values
		(
			ircLDC_TT_ACT.TT_ACT_ID,
			ircLDC_TT_ACT.TASK_TYPE_ID,
			ircLDC_TT_ACT.ITEM_ID,
			ircLDC_TT_ACT.FLAG_CAUSAL,
			ircLDC_TT_ACT.CAUSAL_ID,
			ircLDC_TT_ACT.CLASS_CAUSAL_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TT_ACT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TT_ACT in out nocopy tytbLDC_TT_ACT
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_ACT,blUseRowID);
		forall n in iotbLDC_TT_ACT.first..iotbLDC_TT_ACT.last
			insert into LDC_TT_ACT
			(
				TT_ACT_ID,
				TASK_TYPE_ID,
				ITEM_ID,
				FLAG_CAUSAL,
				CAUSAL_ID,
				CLASS_CAUSAL_ID
			)
			values
			(
				rcRecOfTab.TT_ACT_ID(n),
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.ITEM_ID(n),
				rcRecOfTab.FLAG_CAUSAL(n),
				rcRecOfTab.CAUSAL_ID(n),
				rcRecOfTab.CLASS_CAUSAL_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTT_ACT_ID,
				rcData
			);
		end if;


		delete
		from LDC_TT_ACT
		where
       		TT_ACT_ID=inuTT_ACT_ID;
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
		rcError  styLDC_TT_ACT;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TT_ACT
		where
			rowid = iriRowID
		returning
			TT_ACT_ID
		into
			rcError.TT_ACT_ID;
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
		iotbLDC_TT_ACT in out nocopy tytbLDC_TT_ACT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TT_ACT;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_ACT, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last
				delete
				from LDC_TT_ACT
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last loop
					LockByPk
					(
						rcRecOfTab.TT_ACT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last
				delete
				from LDC_TT_ACT
				where
		         	TT_ACT_ID = rcRecOfTab.TT_ACT_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_TT_ACT in styLDC_TT_ACT,
		inuLock in number default 0
	)
	IS
		nuTT_ACT_ID	LDC_TT_ACT.TT_ACT_ID%type;
	BEGIN
		if ircLDC_TT_ACT.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TT_ACT.rowid,rcData);
			end if;
			update LDC_TT_ACT
			set
				TASK_TYPE_ID = ircLDC_TT_ACT.TASK_TYPE_ID,
				ITEM_ID = ircLDC_TT_ACT.ITEM_ID,
				FLAG_CAUSAL = ircLDC_TT_ACT.FLAG_CAUSAL,
				CAUSAL_ID = ircLDC_TT_ACT.CAUSAL_ID,
				CLASS_CAUSAL_ID = ircLDC_TT_ACT.CLASS_CAUSAL_ID
			where
				rowid = ircLDC_TT_ACT.rowid
			returning
				TT_ACT_ID
			into
				nuTT_ACT_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TT_ACT.TT_ACT_ID,
					rcData
				);
			end if;

			update LDC_TT_ACT
			set
				TASK_TYPE_ID = ircLDC_TT_ACT.TASK_TYPE_ID,
				ITEM_ID = ircLDC_TT_ACT.ITEM_ID,
				FLAG_CAUSAL = ircLDC_TT_ACT.FLAG_CAUSAL,
				CAUSAL_ID = ircLDC_TT_ACT.CAUSAL_ID,
				CLASS_CAUSAL_ID = ircLDC_TT_ACT.CLASS_CAUSAL_ID
			where
				TT_ACT_ID = ircLDC_TT_ACT.TT_ACT_ID
			returning
				TT_ACT_ID
			into
				nuTT_ACT_ID;
		end if;
		if
			nuTT_ACT_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TT_ACT));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_TT_ACT in out nocopy tytbLDC_TT_ACT,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TT_ACT;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_ACT,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last
				update LDC_TT_ACT
				set
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ITEM_ID = rcRecOfTab.ITEM_ID(n),
					FLAG_CAUSAL = rcRecOfTab.FLAG_CAUSAL(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					CLASS_CAUSAL_ID = rcRecOfTab.CLASS_CAUSAL_ID(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last loop
					LockByPk
					(
						rcRecOfTab.TT_ACT_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_ACT.first .. iotbLDC_TT_ACT.last
				update LDC_TT_ACT
				SET
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n),
					ITEM_ID = rcRecOfTab.ITEM_ID(n),
					FLAG_CAUSAL = rcRecOfTab.FLAG_CAUSAL(n),
					CAUSAL_ID = rcRecOfTab.CAUSAL_ID(n),
					CLASS_CAUSAL_ID = rcRecOfTab.CLASS_CAUSAL_ID(n)
				where
					TT_ACT_ID = rcRecOfTab.TT_ACT_ID(n)
;
		end if;
	END;
	PROCEDURE updTASK_TYPE_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuTASK_TYPE_ID$ in LDC_TT_ACT.TASK_TYPE_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_ACT_ID,
				rcData
			);
		end if;

		update LDC_TT_ACT
		set
			TASK_TYPE_ID = inuTASK_TYPE_ID$
		where
			TT_ACT_ID = inuTT_ACT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.TASK_TYPE_ID:= inuTASK_TYPE_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updITEM_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuITEM_ID$ in LDC_TT_ACT.ITEM_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_ACT_ID,
				rcData
			);
		end if;

		update LDC_TT_ACT
		set
			ITEM_ID = inuITEM_ID$
		where
			TT_ACT_ID = inuTT_ACT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.ITEM_ID:= inuITEM_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updFLAG_CAUSAL
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		isbFLAG_CAUSAL$ in LDC_TT_ACT.FLAG_CAUSAL%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_ACT_ID,
				rcData
			);
		end if;

		update LDC_TT_ACT
		set
			FLAG_CAUSAL = isbFLAG_CAUSAL$
		where
			TT_ACT_ID = inuTT_ACT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.FLAG_CAUSAL:= isbFLAG_CAUSAL$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuCAUSAL_ID$ in LDC_TT_ACT.CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_ACT_ID,
				rcData
			);
		end if;

		update LDC_TT_ACT
		set
			CAUSAL_ID = inuCAUSAL_ID$
		where
			TT_ACT_ID = inuTT_ACT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CAUSAL_ID:= inuCAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updCLASS_CAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuCLASS_CAUSAL_ID$ in LDC_TT_ACT.CLASS_CAUSAL_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_TT_ACT;
	BEGIN
		rcError.TT_ACT_ID := inuTT_ACT_ID;
		if inuLock=1 then
			LockByPk
			(
				inuTT_ACT_ID,
				rcData
			);
		end if;

		update LDC_TT_ACT
		set
			CLASS_CAUSAL_ID = inuCLASS_CAUSAL_ID$
		where
			TT_ACT_ID = inuTT_ACT_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.CLASS_CAUSAL_ID:= inuCLASS_CAUSAL_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTT_ACT_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.TT_ACT_ID%type
	IS
		rcError styLDC_TT_ACT;
	BEGIN

		rcError.TT_ACT_ID := inuTT_ACT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_ACT_ID
			 )
		then
			 return(rcData.TT_ACT_ID);
		end if;
		Load
		(
		 		inuTT_ACT_ID
		);
		return(rcData.TT_ACT_ID);
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
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.TASK_TYPE_ID%type
	IS
		rcError styLDC_TT_ACT;
	BEGIN

		rcError.TT_ACT_ID := inuTT_ACT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_ACT_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuTT_ACT_ID
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
	FUNCTION fnuGetITEM_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.ITEM_ID%type
	IS
		rcError styLDC_TT_ACT;
	BEGIN

		rcError.TT_ACT_ID := inuTT_ACT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_ACT_ID
			 )
		then
			 return(rcData.ITEM_ID);
		end if;
		Load
		(
		 		inuTT_ACT_ID
		);
		return(rcData.ITEM_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fsbGetFLAG_CAUSAL
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.FLAG_CAUSAL%type
	IS
		rcError styLDC_TT_ACT;
	BEGIN

		rcError.TT_ACT_ID := inuTT_ACT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_ACT_ID
			 )
		then
			 return(rcData.FLAG_CAUSAL);
		end if;
		Load
		(
		 		inuTT_ACT_ID
		);
		return(rcData.FLAG_CAUSAL);
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
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.CAUSAL_ID%type
	IS
		rcError styLDC_TT_ACT;
	BEGIN

		rcError.TT_ACT_ID := inuTT_ACT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_ACT_ID
			 )
		then
			 return(rcData.CAUSAL_ID);
		end if;
		Load
		(
		 		inuTT_ACT_ID
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
	FUNCTION fnuGetCLASS_CAUSAL_ID
	(
		inuTT_ACT_ID in LDC_TT_ACT.TT_ACT_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_ACT.CLASS_CAUSAL_ID%type
	IS
		rcError styLDC_TT_ACT;
	BEGIN

		rcError.TT_ACT_ID := inuTT_ACT_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTT_ACT_ID
			 )
		then
			 return(rcData.CLASS_CAUSAL_ID);
		end if;
		Load
		(
		 		inuTT_ACT_ID
		);
		return(rcData.CLASS_CAUSAL_ID);
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
end DALDC_TT_ACT;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TT_ACT
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TT_ACT', 'ADM_PERSON'); 
END;
/  
