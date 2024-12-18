CREATE OR REPLACE PACKAGE adm_person.daldc_tt_tb
IS
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	IS
		SELECT LDC_TT_TB.*,LDC_TT_TB.rowid
		FROM LDC_TT_TB
		WHERE
		    TASK_TYPE_ID = inuTASK_TYPE_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TT_TB.*,LDC_TT_TB.rowid
		FROM LDC_TT_TB
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TT_TB  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TT_TB is table of styLDC_TT_TB index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TT_TB;

	/* Tipos referenciando al registro */
	TYPE tytbTASK_TYPE_ID IS TABLE OF LDC_TT_TB.TASK_TYPE_ID%TYPE INDEX BY BINARY_INTEGER;
	TYPE tytbWAREHOUSE_TYPE IS TABLE OF LDC_TT_TB.WAREHOUSE_TYPE%TYPE INDEX BY BINARY_INTEGER;
	TYPE tytbCREATION_DATE IS TABLE OF LDC_TT_TB.CREATION_DATE%TYPE INDEX BY BINARY_INTEGER;
	TYPE tytbDISABLE_DATE IS TABLE OF LDC_TT_TB.DISABLE_DATE%TYPE INDEX BY BINARY_INTEGER;
	TYPE tytbACTIVE_FLAG IS TABLE OF LDC_TT_TB.ACTIVE_FLAG%TYPE INDEX BY BINARY_INTEGER;
	TYPE tytbrowid IS TABLE OF ROWID INDEX BY BINARY_INTEGER;

	TYPE tyrcLDC_TT_TB IS RECORD
	(
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		WAREHOUSE_TYPE tytbWAREHOUSE_TYPE,
		CREATION_DATE  tytbCREATION_DATE,
		DISABLE_DATE   tytbDISABLE_DATE,
		ACTIVE_FLAG    tytbACTIVE_FLAG,
		row_id         tytbrowid
	);


	/***** Metodos Publicos ****/

    FUNCTION fsbVersion
    RETURN varchar2;

	FUNCTION fsbGetMessageDescription
	return varchar2;

	PROCEDURE ClearMemory;

	FUNCTION fblExist
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	);

	PROCEDURE getRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		orcRecord out nocopy styLDC_TT_TB
	);

	FUNCTION frcGetRcData
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN styLDC_TT_TB;

	FUNCTION frcGetRcData
	RETURN styLDC_TT_TB;

	FUNCTION frcGetRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN styLDC_TT_TB;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TT_TB
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TT_TB in styLDC_TT_TB
	);

	PROCEDURE insRecord
	(
		ircLDC_TT_TB in styLDC_TT_TB,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TT_TB in out nocopy tytbLDC_TT_TB
	);

	PROCEDURE delRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TT_TB in out nocopy tytbLDC_TT_TB,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_TT_TB in styLDC_TT_TB,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_TT_TB in out nocopy tytbLDC_TT_TB,
		inuLock in number default 1
	);

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.TASK_TYPE_ID%type;

	FUNCTION fsbGetWAREHOUSE_TYPE
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.WAREHOUSE_TYPE%type;

	FUNCTION fdtGetCREATION_DATE
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.CREATION_DATE%type;

	FUNCTION fdtGetDISABLE_DATE
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.DISABLE_DATE%type;

	FUNCTION fsbGetACTIVE_FLAG
	(
	    inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%TYPE,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.ACTIVE_FLAG%TYPE;

	PROCEDURE LockByPk
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		orcLDC_TT_TB  out styLDC_TT_TB
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TT_TB  out styLDC_TT_TB
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TT_TB;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TT_TB
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'TS RQ471';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TT_TB';
	cnuGeEntityId constant varchar2(30) := 0; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	IS
		SELECT LDC_TT_TB.*,LDC_TT_TB.rowid
		FROM LDC_TT_TB
		WHERE  TASK_TYPE_ID = inuTASK_TYPE_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TT_TB.*,LDC_TT_TB.rowid
		FROM LDC_TT_TB
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TT_TB is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TT_TB;

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

	FUNCTION fsbPrimaryKey( rcI in styLDC_TT_TB default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TASK_TYPE_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;

	PROCEDURE LockByPk
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		orcLDC_TT_TB  out styLDC_TT_TB
	)
	IS
		rcError styLDC_TT_TB;
	BEGIN
		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

		Open cuLockRcByPk
		(
			inuTASK_TYPE_ID
		);

		fetch cuLockRcByPk into orcLDC_TT_TB;
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
		orcLDC_TT_TB  out styLDC_TT_TB
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TT_TB;
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
		itbLDC_TT_TB  in out nocopy tytbLDC_TT_TB
	)
	IS
	BEGIN
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.WAREHOUSE_TYPE.delete;
			rcRecOfTab.CREATION_DATE.delete;
			rcRecOfTab.DISABLE_DATE.delete;
			rcRecOfTab.ACTIVE_FLAG.delete;
			rcRecOfTab.row_id.delete;
	END;

	PROCEDURE FillRecordOfTables
	(
		itbLDC_TT_TB  in out nocopy tytbLDC_TT_TB,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TT_TB);

		for n in itbLDC_TT_TB.first .. itbLDC_TT_TB.last loop
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_TT_TB(n).TASK_TYPE_ID;
			rcRecOfTab.WAREHOUSE_TYPE(n) := itbLDC_TT_TB(n).WAREHOUSE_TYPE;
			rcRecOfTab.CREATION_DATE(n) := itbLDC_TT_TB(n).CREATION_DATE;
			rcRecOfTab.DISABLE_DATE(n) := itbLDC_TT_TB(n).DISABLE_DATE;
			rcRecOfTab.ACTIVE_FLAG(n) := itbLDC_TT_TB(n).ACTIVE_FLAG;
			rcRecOfTab.row_id(n) := itbLDC_TT_TB(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTASK_TYPE_ID
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
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTASK_TYPE_ID = rcData.TASK_TYPE_ID
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
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTASK_TYPE_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;

	PROCEDURE AccKey
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	IS
		rcError styLDC_TT_TB;
	BEGIN		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;

		Load
		(
			inuTASK_TYPE_ID
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
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTASK_TYPE_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;

	PROCEDURE getRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		orcRecord out nocopy styLDC_TT_TB
	)
	IS
		rcError styLDC_TT_TB;
	BEGIN		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;

		Load
		(
			inuTASK_TYPE_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN styLDC_TT_TB
	IS
		rcError styLDC_TT_TB;
	BEGIN
		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;

		Load
		(
			inuTASK_TYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type
	)
	RETURN styLDC_TT_TB
	IS
		rcError styLDC_TT_TB;
	BEGIN
		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTASK_TYPE_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTASK_TYPE_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TT_TB
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TT_TB
	)
	IS
		rfLDC_TT_TB tyrfLDC_TT_TB;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TT_TB.*, LDC_TT_TB.rowid FROM LDC_TT_TB';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TT_TB for sbFullQuery;

		fetch rfLDC_TT_TB bulk collect INTO otbResult;

		close rfLDC_TT_TB;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TT_TB.*, LDC_TT_TB.rowid FROM LDC_TT_TB';
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
		ircLDC_TT_TB in styLDC_TT_TB
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TT_TB,rirowid);
	END;

	PROCEDURE insRecord
	(
		ircLDC_TT_TB in styLDC_TT_TB,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TT_TB.TASK_TYPE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TASK_TYPE_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TT_TB
		(
			TASK_TYPE_ID,
			WAREHOUSE_TYPE,
			CREATION_DATE,
			DISABLE_DATE,
			ACTIVE_FLAG
		)
		values
		(
			ircLDC_TT_TB.TASK_TYPE_ID,
			ircLDC_TT_TB.WAREHOUSE_TYPE,
			ircLDC_TT_TB.CREATION_DATE,
			ircLDC_TT_TB.DISABLE_DATE,
			ircLDC_TT_TB.ACTIVE_FLAG
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TT_TB));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE insRecords
	(
		iotbLDC_TT_TB in out nocopy tytbLDC_TT_TB
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_TB,blUseRowID);
		forall n in iotbLDC_TT_TB.first..iotbLDC_TT_TB.last
			insert into LDC_TT_TB
			(
				TASK_TYPE_ID,
				WAREHOUSE_TYPE,
				CREATION_DATE,
				DISABLE_DATE,
				ACTIVE_FLAG
			)
			values
			(
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.WAREHOUSE_TYPE(n),
				rcRecOfTab.CREATION_DATE(n),
				rcRecOfTab.DISABLE_DATE(n),
				rcRecOfTab.ACTIVE_FLAG(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE delRecord
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TT_TB;
	BEGIN
		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTASK_TYPE_ID,
				rcData
			);
		end if;


		delete
		from LDC_TT_TB
		where
       		TASK_TYPE_ID=inuTASK_TYPE_ID;
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
		rcError  styLDC_TT_TB;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TT_TB
		where
			rowid = iriRowID
		returning
			TASK_TYPE_ID
		into
			rcError.TASK_TYPE_ID;
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
		iotbLDC_TT_TB in out nocopy tytbLDC_TT_TB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TT_TB;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_TB, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last
				delete
				from LDC_TT_TB
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last loop
					LockByPk
					(
						rcRecOfTab.TASK_TYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last
				delete
				from LDC_TT_TB
				where
		         	TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecord
	(
		ircLDC_TT_TB in styLDC_TT_TB,
		inuLock in number default 0
	)
	IS
		nuTASK_TYPE_ID	LDC_TT_TB.TASK_TYPE_ID%type;
	BEGIN
		if ircLDC_TT_TB.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_TT_TB.rowid,rcData);
			end if;
			update LDC_TT_TB
			set
				WAREHOUSE_TYPE = ircLDC_TT_TB.WAREHOUSE_TYPE,
				CREATION_DATE = ircLDC_TT_TB.CREATION_DATE,
				DISABLE_DATE = ircLDC_TT_TB.DISABLE_DATE,
				ACTIVE_FLAG = ircLDC_TT_TB.ACTIVE_FLAG
			where
				rowid = ircLDC_TT_TB.rowid
			returning
				TASK_TYPE_ID
			into
				nuTASK_TYPE_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_TT_TB.TASK_TYPE_ID,
					rcData
				);
			end if;

			update LDC_TT_TB
			set
				WAREHOUSE_TYPE = ircLDC_TT_TB.WAREHOUSE_TYPE,
				CREATION_DATE = ircLDC_TT_TB.CREATION_DATE,
				DISABLE_DATE = ircLDC_TT_TB.DISABLE_DATE,
				ACTIVE_FLAG = ircLDC_TT_TB.ACTIVE_FLAG
			where
				TASK_TYPE_ID = ircLDC_TT_TB.TASK_TYPE_ID
			returning
				TASK_TYPE_ID
			into
				nuTASK_TYPE_ID;
		end if;
		if
			nuTASK_TYPE_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_TT_TB));
			raise ex.CONTROLLED_ERROR;
	END;

	PROCEDURE updRecords
	(
		iotbLDC_TT_TB in out nocopy tytbLDC_TT_TB,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TT_TB;
	BEGIN
		FillRecordOfTables(iotbLDC_TT_TB,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last
				update LDC_TT_TB
				set
					WAREHOUSE_TYPE = rcRecOfTab.WAREHOUSE_TYPE(n),
					CREATION_DATE = rcRecOfTab.CREATION_DATE(n),
					DISABLE_DATE = rcRecOfTab.DISABLE_DATE(n),
					ACTIVE_FLAG = rcRecOfTab.ACTIVE_FLAG(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last loop
					LockByPk
					(
						rcRecOfTab.TASK_TYPE_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TT_TB.first .. iotbLDC_TT_TB.last
				update LDC_TT_TB
				SET
					WAREHOUSE_TYPE = rcRecOfTab.WAREHOUSE_TYPE(n),
					CREATION_DATE = rcRecOfTab.CREATION_DATE(n),
					DISABLE_DATE = rcRecOfTab.DISABLE_DATE(n),
					ACTIVE_FLAG = rcRecOfTab.ACTIVE_FLAG(n)
				where
					TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n)
;
		end if;
	END;

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.TASK_TYPE_ID%type
	IS
		rcError styLDC_TT_TB;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID
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
	FUNCTION fsbGetWAREHOUSE_TYPE
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.WAREHOUSE_TYPE%type
	IS
		rcError styLDC_TT_TB;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID
			 )
		then
			 return(rcData.WAREHOUSE_TYPE);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID
		);
		return(rcData.WAREHOUSE_TYPE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetCREATION_DATE
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.CREATION_DATE%type
	IS
		rcError styLDC_TT_TB;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID
			 )
		then
			 return(rcData.CREATION_DATE);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID
		);
		return(rcData.CREATION_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fdtGetDISABLE_DATE
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.DISABLE_DATE%type
	IS
		rcError styLDC_TT_TB;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID
			 )
		then
			 return(rcData.DISABLE_DATE);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID
		);
		return(rcData.DISABLE_DATE);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;

	FUNCTION fsbGetACTIVE_FLAG
	(
		inuTASK_TYPE_ID in LDC_TT_TB.TASK_TYPE_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TT_TB.ACTIVE_FLAG%type
	IS
		rcError styLDC_TT_TB;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID
			 )
		then
			 return(rcData.ACTIVE_FLAG);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID
		);
		return(rcData.ACTIVE_FLAG);
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
end DALDC_TT_TB;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TT_TB
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TT_TB', 'ADM_PERSON'); 
END;
/