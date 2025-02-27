CREATE OR REPLACE PACKAGE adm_person.daldc_titracop
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  11/06/2024   Adrianavg   OSF-2813: Migrar del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	IS
		SELECT LDC_TITRACOP.*,LDC_TITRACOP.rowid
		FROM LDC_TITRACOP
		WHERE
		    TASK_TYPE_ID = inuTASK_TYPE_ID
		    and ITEMS_ID = inuITEMS_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_TITRACOP.*,LDC_TITRACOP.rowid
		FROM LDC_TITRACOP
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_TITRACOP  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_TITRACOP is table of styLDC_TITRACOP index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_TITRACOP;

	/* Tipos referenciando al registro */
	type tytbTASK_TYPE_ID is table of LDC_TITRACOP.TASK_TYPE_ID%type index by binary_integer;
	type tytbITEMS_ID is table of LDC_TITRACOP.ITEMS_ID%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_TITRACOP is record
	(
		TASK_TYPE_ID   tytbTASK_TYPE_ID,
		ITEMS_ID   tytbITEMS_ID,
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
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	);

	PROCEDURE getRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		orcRecord out nocopy styLDC_TITRACOP
	);

	FUNCTION frcGetRcData
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN styLDC_TITRACOP;

	FUNCTION frcGetRcData
	RETURN styLDC_TITRACOP;

	FUNCTION frcGetRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN styLDC_TITRACOP;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TITRACOP
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_TITRACOP in styLDC_TITRACOP
	);

	PROCEDURE insRecord
	(
		ircLDC_TITRACOP in styLDC_TITRACOP,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_TITRACOP in out nocopy tytbLDC_TITRACOP
	);

	PROCEDURE delRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_TITRACOP in out nocopy tytbLDC_TITRACOP,
		inuLock in number default 1
	);

	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TITRACOP.TASK_TYPE_ID%type;

	FUNCTION fnuGetITEMS_ID
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TITRACOP.ITEMS_ID%type;


	PROCEDURE LockByPk
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		orcLDC_TITRACOP  out styLDC_TITRACOP
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_TITRACOP  out styLDC_TITRACOP
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_TITRACOP;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_TITRACOP
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO1';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_TITRACOP';
	 cnuGeEntityId constant varchar2(30) := 4384; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	IS
		SELECT LDC_TITRACOP.*,LDC_TITRACOP.rowid
		FROM LDC_TITRACOP
		WHERE  TASK_TYPE_ID = inuTASK_TYPE_ID
			and ITEMS_ID = inuITEMS_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_TITRACOP.*,LDC_TITRACOP.rowid
		FROM LDC_TITRACOP
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_TITRACOP is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_TITRACOP;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_TITRACOP default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.TASK_TYPE_ID);
		sbPk:=sbPk||','||ut_convert.fsbToChar(rcI.ITEMS_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		orcLDC_TITRACOP  out styLDC_TITRACOP
	)
	IS
		rcError styLDC_TITRACOP;
	BEGIN
		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;
		rcError.ITEMS_ID := inuITEMS_ID;

		Open cuLockRcByPk
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
		);

		fetch cuLockRcByPk into orcLDC_TITRACOP;
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
		orcLDC_TITRACOP  out styLDC_TITRACOP
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_TITRACOP;
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
		itbLDC_TITRACOP  in out nocopy tytbLDC_TITRACOP
	)
	IS
	BEGIN
			rcRecOfTab.TASK_TYPE_ID.delete;
			rcRecOfTab.ITEMS_ID.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_TITRACOP  in out nocopy tytbLDC_TITRACOP,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_TITRACOP);

		for n in itbLDC_TITRACOP.first .. itbLDC_TITRACOP.last loop
			rcRecOfTab.TASK_TYPE_ID(n) := itbLDC_TITRACOP(n).TASK_TYPE_ID;
			rcRecOfTab.ITEMS_ID(n) := itbLDC_TITRACOP(n).ITEMS_ID;
			rcRecOfTab.row_id(n) := itbLDC_TITRACOP(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
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
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuTASK_TYPE_ID = rcData.TASK_TYPE_ID AND
			inuITEMS_ID = rcData.ITEMS_ID
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
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	IS
		rcError styLDC_TITRACOP;
	BEGIN		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;		rcError.ITEMS_ID:=inuITEMS_ID;

		Load
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
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
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		orcRecord out nocopy styLDC_TITRACOP
	)
	IS
		rcError styLDC_TITRACOP;
	BEGIN		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;		rcError.ITEMS_ID:=inuITEMS_ID;

		Load
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN styLDC_TITRACOP
	IS
		rcError styLDC_TITRACOP;
	BEGIN
		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;
		rcError.ITEMS_ID:=inuITEMS_ID;

		Load
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type
	)
	RETURN styLDC_TITRACOP
	IS
		rcError styLDC_TITRACOP;
	BEGIN
		rcError.TASK_TYPE_ID:=inuTASK_TYPE_ID;
		rcError.ITEMS_ID:=inuITEMS_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuTASK_TYPE_ID,
			inuITEMS_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuTASK_TYPE_ID,
			inuITEMS_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_TITRACOP
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_TITRACOP
	)
	IS
		rfLDC_TITRACOP tyrfLDC_TITRACOP;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_TITRACOP.*, LDC_TITRACOP.rowid FROM LDC_TITRACOP';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_TITRACOP for sbFullQuery;

		fetch rfLDC_TITRACOP bulk collect INTO otbResult;

		close rfLDC_TITRACOP;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_TITRACOP.*, LDC_TITRACOP.rowid FROM LDC_TITRACOP';
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
		ircLDC_TITRACOP in styLDC_TITRACOP
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_TITRACOP,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_TITRACOP in styLDC_TITRACOP,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_TITRACOP.TASK_TYPE_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|TASK_TYPE_ID');
			raise ex.controlled_error;
		end if;
		if ircLDC_TITRACOP.ITEMS_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|ITEMS_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_TITRACOP
		(
			TASK_TYPE_ID,
			ITEMS_ID
		)
		values
		(
			ircLDC_TITRACOP.TASK_TYPE_ID,
			ircLDC_TITRACOP.ITEMS_ID
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_TITRACOP));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_TITRACOP in out nocopy tytbLDC_TITRACOP
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_TITRACOP,blUseRowID);
		forall n in iotbLDC_TITRACOP.first..iotbLDC_TITRACOP.last
			insert into LDC_TITRACOP
			(
				TASK_TYPE_ID,
				ITEMS_ID
			)
			values
			(
				rcRecOfTab.TASK_TYPE_ID(n),
				rcRecOfTab.ITEMS_ID(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_TITRACOP;
	BEGIN
		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;
		rcError.ITEMS_ID := inuITEMS_ID;

		if inuLock=1 then
			LockByPk
			(
				inuTASK_TYPE_ID,
				inuITEMS_ID,
				rcData
			);
		end if;


		delete
		from LDC_TITRACOP
		where
       		TASK_TYPE_ID=inuTASK_TYPE_ID and
       		ITEMS_ID=inuITEMS_ID;
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
		rcError  styLDC_TITRACOP;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_TITRACOP
		where
			rowid = iriRowID
		returning
			TASK_TYPE_ID,
			ITEMS_ID
		into
			rcError.TASK_TYPE_ID,
			rcError.ITEMS_ID;
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
		iotbLDC_TITRACOP in out nocopy tytbLDC_TITRACOP,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_TITRACOP;
	BEGIN
		FillRecordOfTables(iotbLDC_TITRACOP, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_TITRACOP.first .. iotbLDC_TITRACOP.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TITRACOP.first .. iotbLDC_TITRACOP.last
				delete
				from LDC_TITRACOP
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_TITRACOP.first .. iotbLDC_TITRACOP.last loop
					LockByPk
					(
						rcRecOfTab.TASK_TYPE_ID(n),
						rcRecOfTab.ITEMS_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_TITRACOP.first .. iotbLDC_TITRACOP.last
				delete
				from LDC_TITRACOP
				where
		         	TASK_TYPE_ID = rcRecOfTab.TASK_TYPE_ID(n) and
		         	ITEMS_ID = rcRecOfTab.ITEMS_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetTASK_TYPE_ID
	(
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TITRACOP.TASK_TYPE_ID%type
	IS
		rcError styLDC_TITRACOP;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;
		rcError.ITEMS_ID := inuITEMS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID,
		 		inuITEMS_ID
			 )
		then
			 return(rcData.TASK_TYPE_ID);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID,
		 		inuITEMS_ID
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
		inuTASK_TYPE_ID in LDC_TITRACOP.TASK_TYPE_ID%type,
		inuITEMS_ID in LDC_TITRACOP.ITEMS_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_TITRACOP.ITEMS_ID%type
	IS
		rcError styLDC_TITRACOP;
	BEGIN

		rcError.TASK_TYPE_ID := inuTASK_TYPE_ID;
		rcError.ITEMS_ID := inuITEMS_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuTASK_TYPE_ID,
		 		inuITEMS_ID
			 )
		then
			 return(rcData.ITEMS_ID);
		end if;
		Load
		(
		 		inuTASK_TYPE_ID,
		 		inuITEMS_ID
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
	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	) IS
	Begin
	    blDAO_USE_CACHE := iblUseCache;
	END;

begin
    GetDAO_USE_CACHE;
end DALDC_TITRACOP;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_TITRACOP
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_TITRACOP', 'ADM_PERSON'); 
END;
/  