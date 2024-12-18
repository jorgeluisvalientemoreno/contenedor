CREATE OR REPLACE PACKAGE adm_person.daldc_segment_susc
is
  /**************************************************************************
  HISTORIA DE MODIFICACIONES
  FECHA        AUTOR       DESCRIPCION
  12/06/2024   Adrianavg   OSF-2779: Se migra del esquema OPEN al esquema ADM_PERSON
  ***************************************************************************/
	/* Cursor general para acceso por Llave Primaria */
	CURSOR cuRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	IS
		SELECT LDC_SEGMENT_SUSC.*,LDC_SEGMENT_SUSC.rowid
		FROM LDC_SEGMENT_SUSC
		WHERE
		    SEGMENT_SUSC_ID = inuSEGMENT_SUSC_ID;


	/* Cursor general para acceso por RowId */
	CURSOR cuRecordByRowId
	(
		irirowid in varchar2
	)
	IS
        SELECT LDC_SEGMENT_SUSC.*,LDC_SEGMENT_SUSC.rowid
		FROM LDC_SEGMENT_SUSC
		WHERE
			rowId = irirowid;


	/* Subtipos */
	subtype styLDC_SEGMENT_SUSC  is  cuRecord%rowtype;
	type    tyRefCursor is  REF CURSOR;

	/*Tipos*/
	type tytbLDC_SEGMENT_SUSC is table of styLDC_SEGMENT_SUSC index by binary_integer;
	type tyrfRecords is ref cursor return styLDC_SEGMENT_SUSC;

	/* Tipos referenciando al registro */
	type tytbSEGMENT_SUSC_ID is table of LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type index by binary_integer;
	type tytbSUBSCRIPTION_ID is table of LDC_SEGMENT_SUSC.SUBSCRIPTION_ID%type index by binary_integer;
	type tytbSEGMENT_ID is table of LDC_SEGMENT_SUSC.SEGMENT_ID%type index by binary_integer;
	type tytbREGISTER_DATE is table of LDC_SEGMENT_SUSC.REGISTER_DATE%type index by binary_integer;
	type tytbrowid is table of rowid index by binary_integer;

	type tyrcLDC_SEGMENT_SUSC is record
	(
		SEGMENT_SUSC_ID   tytbSEGMENT_SUSC_ID,
		SUBSCRIPTION_ID   tytbSUBSCRIPTION_ID,
		SEGMENT_ID   tytbSEGMENT_ID,
		REGISTER_DATE   tytbREGISTER_DATE,
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
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN boolean;

	PROCEDURE AccKey
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	);

	PROCEDURE AccKeyByRowId
	(
		iriRowID    in rowid
	);

	PROCEDURE ValDuplicate
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	);

	PROCEDURE getRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		orcRecord out nocopy styLDC_SEGMENT_SUSC
	);

	FUNCTION frcGetRcData
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN styLDC_SEGMENT_SUSC;

	FUNCTION frcGetRcData
	RETURN styLDC_SEGMENT_SUSC;

	FUNCTION frcGetRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN styLDC_SEGMENT_SUSC;

	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_SEGMENT_SUSC
	);

	FUNCTION frfGetRecords
	(
		isbCriteria in varchar2 default null,
		iblLock in boolean default false
	)
	RETURN tyRefCursor;

	PROCEDURE insRecord
	(
		ircLDC_SEGMENT_SUSC in styLDC_SEGMENT_SUSC
	);

	PROCEDURE insRecord
	(
		ircLDC_SEGMENT_SUSC in styLDC_SEGMENT_SUSC,
        orirowid   out varchar2
	);

	PROCEDURE insRecords
	(
		iotbLDC_SEGMENT_SUSC in out nocopy tytbLDC_SEGMENT_SUSC
	);

	PROCEDURE delRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuLock in number default 1
	);

	PROCEDURE delByRowID
	(
		iriRowID    in rowid,
		inuLock in number default 1
	);

	PROCEDURE delRecords
	(
		iotbLDC_SEGMENT_SUSC in out nocopy tytbLDC_SEGMENT_SUSC,
		inuLock in number default 1
	);

	PROCEDURE updRecord
	(
		ircLDC_SEGMENT_SUSC in styLDC_SEGMENT_SUSC,
		inuLock in number default 0
	);

	PROCEDURE updRecords
	(
		iotbLDC_SEGMENT_SUSC in out nocopy tytbLDC_SEGMENT_SUSC,
		inuLock in number default 1
	);

	PROCEDURE updSUBSCRIPTION_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_SEGMENT_SUSC.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updSEGMENT_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuSEGMENT_ID$ in LDC_SEGMENT_SUSC.SEGMENT_ID%type,
		inuLock in number default 0
	);

	PROCEDURE updREGISTER_DATE
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		idtREGISTER_DATE$ in LDC_SEGMENT_SUSC.REGISTER_DATE%type,
		inuLock in number default 0
	);

	FUNCTION fnuGetSEGMENT_SUSC_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type;

	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.SUBSCRIPTION_ID%type;

	FUNCTION fnuGetSEGMENT_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.SEGMENT_ID%type;

	FUNCTION fdtGetREGISTER_DATE
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.REGISTER_DATE%type;


	PROCEDURE LockByPk
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		orcLDC_SEGMENT_SUSC  out styLDC_SEGMENT_SUSC
	);

	PROCEDURE LockByRowID
	(
		irirowid    in  varchar2,
		orcLDC_SEGMENT_SUSC  out styLDC_SEGMENT_SUSC
	);

	PROCEDURE SetUseCache
	(
		iblUseCache    in  boolean
	);
END DALDC_SEGMENT_SUSC;
/
CREATE OR REPLACE PACKAGE BODY adm_person.DALDC_SEGMENT_SUSC
IS

    /*constantes locales al paquete*/
    cnuRECORD_NOT_EXIST constant number(1) := 1;
    cnuRECORD_ALREADY_EXIST constant number(1) := 2;
    cnuAPPTABLEBUSSY constant number(4) := 6951;
    cnuINS_PK_NULL constant number(4):= 1682;
    cnuRECORD_HAVE_CHILDREN constant number(4):= -2292;
    csbVersion   CONSTANT VARCHAR2(20) := 'SAO0';
    csbTABLEPARAMETER   CONSTANT VARCHAR2(30) := 'LDC_SEGMENT_SUSC';
	 cnuGeEntityId constant varchar2(30) := 1134; -- Id de Ge_entity

	/* Cursor para bloqueo de un registro por llave primaria */
	CURSOR cuLockRcByPk
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	IS
		SELECT LDC_SEGMENT_SUSC.*,LDC_SEGMENT_SUSC.rowid
		FROM LDC_SEGMENT_SUSC
		WHERE  SEGMENT_SUSC_ID = inuSEGMENT_SUSC_ID
		FOR UPDATE NOWAIT;

	/* Cursor para bloqueo de un registro por rowid */
	CURSOR cuLockRcbyRowId
	(
		irirowid in varchar2
	)
	IS
		SELECT LDC_SEGMENT_SUSC.*,LDC_SEGMENT_SUSC.rowid
		FROM LDC_SEGMENT_SUSC
		WHERE
			rowId = irirowid
		FOR UPDATE NOWAIT;


	/*Tipos*/
	type tyrfLDC_SEGMENT_SUSC is ref cursor;

	/*Variables Globales*/
	rcRecOfTab tyrcLDC_SEGMENT_SUSC;

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
	FUNCTION fsbPrimaryKey( rcI in styLDC_SEGMENT_SUSC default rcData )
	return varchar2
	IS
		sbPk varchar2(500);
	BEGIN
		sbPk:='[';
		sbPk:=sbPk||ut_convert.fsbToChar(rcI.SEGMENT_SUSC_ID);
		sbPk:=sbPk||']';
		return sbPk;
	END;
	PROCEDURE LockByPk
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		orcLDC_SEGMENT_SUSC  out styLDC_SEGMENT_SUSC
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;

		Open cuLockRcByPk
		(
			inuSEGMENT_SUSC_ID
		);

		fetch cuLockRcByPk into orcLDC_SEGMENT_SUSC;
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
		orcLDC_SEGMENT_SUSC  out styLDC_SEGMENT_SUSC
	)
	IS
	BEGIN
		Open cuLockRcbyRowId
		(
			irirowid
		);

		fetch cuLockRcbyRowId into orcLDC_SEGMENT_SUSC;
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
		itbLDC_SEGMENT_SUSC  in out nocopy tytbLDC_SEGMENT_SUSC
	)
	IS
	BEGIN
			rcRecOfTab.SEGMENT_SUSC_ID.delete;
			rcRecOfTab.SUBSCRIPTION_ID.delete;
			rcRecOfTab.SEGMENT_ID.delete;
			rcRecOfTab.REGISTER_DATE.delete;
			rcRecOfTab.row_id.delete;
	END;
	PROCEDURE FillRecordOfTables
	(
		itbLDC_SEGMENT_SUSC  in out nocopy tytbLDC_SEGMENT_SUSC,
		oblUseRowId out boolean
	)
	IS
	BEGIN
		DelRecordOfTables(itbLDC_SEGMENT_SUSC);

		for n in itbLDC_SEGMENT_SUSC.first .. itbLDC_SEGMENT_SUSC.last loop
			rcRecOfTab.SEGMENT_SUSC_ID(n) := itbLDC_SEGMENT_SUSC(n).SEGMENT_SUSC_ID;
			rcRecOfTab.SUBSCRIPTION_ID(n) := itbLDC_SEGMENT_SUSC(n).SUBSCRIPTION_ID;
			rcRecOfTab.SEGMENT_ID(n) := itbLDC_SEGMENT_SUSC(n).SEGMENT_ID;
			rcRecOfTab.REGISTER_DATE(n) := itbLDC_SEGMENT_SUSC(n).REGISTER_DATE;
			rcRecOfTab.row_id(n) := itbLDC_SEGMENT_SUSC(n).rowid;

			-- Indica si el rowid es Nulo
			oblUseRowId:=rcRecOfTab.row_id(n) is NOT NULL;
		end loop;
	END;

	PROCEDURE Load
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	IS
		rcRecordNull cuRecord%rowtype;
	BEGIN
		if cuRecord%isopen then
			close cuRecord;
		end if;
		open cuRecord
		(
			inuSEGMENT_SUSC_ID
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
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		if (
			inuSEGMENT_SUSC_ID = rcData.SEGMENT_SUSC_ID
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
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN boolean
	IS
	BEGIN
		Load
		(
			inuSEGMENT_SUSC_ID
		);
		return(TRUE);
	EXCEPTION
		when no_data_found then
			return(FALSE);
	END;
	PROCEDURE AccKey
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN		rcError.SEGMENT_SUSC_ID:=inuSEGMENT_SUSC_ID;

		Load
		(
			inuSEGMENT_SUSC_ID
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
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	IS
	BEGIN
		Load
		(
			inuSEGMENT_SUSC_ID
		);
		Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey);
		raise ex.CONTROLLED_ERROR;

	EXCEPTION
		when no_data_found then
			null;
	END;
	PROCEDURE getRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		orcRecord out nocopy styLDC_SEGMENT_SUSC
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN		rcError.SEGMENT_SUSC_ID:=inuSEGMENT_SUSC_ID;

		Load
		(
			inuSEGMENT_SUSC_ID
		);
		orcRecord := rcData;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN styLDC_SEGMENT_SUSC
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID:=inuSEGMENT_SUSC_ID;

		Load
		(
			inuSEGMENT_SUSC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION frcGetRcData
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	)
	RETURN styLDC_SEGMENT_SUSC
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID:=inuSEGMENT_SUSC_ID;
        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
			inuSEGMENT_SUSC_ID
			 )
		then
			 return(rcData);
		end if;
		Load
		(
			inuSEGMENT_SUSC_ID
		);
		return(rcData);
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '|| fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;

	FUNCTION frcGetRcData
	RETURN styLDC_SEGMENT_SUSC
	IS
	BEGIN
		return(rcData);
	END;
	PROCEDURE getRecords
	(
		isbQuery in varchar2,
		otbResult out nocopy tytbLDC_SEGMENT_SUSC
	)
	IS
		rfLDC_SEGMENT_SUSC tyrfLDC_SEGMENT_SUSC;
		n number(4) := 1;
		sbFullQuery VARCHAR2 (32000) := 'SELECT LDC_SEGMENT_SUSC.*, LDC_SEGMENT_SUSC.rowid FROM LDC_SEGMENT_SUSC';
		nuMaxTbRecords number(5):=ge_boparameter.fnuget('MAXREGSQUERY');
	BEGIN
		otbResult.delete;
		if isbQuery is not NULL and length(isbQuery) > 0 then
			sbFullQuery := sbFullQuery||' WHERE '||isbQuery;
		end if;

		open rfLDC_SEGMENT_SUSC for sbFullQuery;

		fetch rfLDC_SEGMENT_SUSC bulk collect INTO otbResult;

		close rfLDC_SEGMENT_SUSC;
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
		sbSQL VARCHAR2 (32000) := 'select LDC_SEGMENT_SUSC.*, LDC_SEGMENT_SUSC.rowid FROM LDC_SEGMENT_SUSC';
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
		ircLDC_SEGMENT_SUSC in styLDC_SEGMENT_SUSC
	)
	IS
		rirowid varchar2(200);
	BEGIN
		insRecord(ircLDC_SEGMENT_SUSC,rirowid);
	END;
	PROCEDURE insRecord
	(
		ircLDC_SEGMENT_SUSC in styLDC_SEGMENT_SUSC,
        orirowid   out varchar2
	)
	IS
	BEGIN
		if ircLDC_SEGMENT_SUSC.SEGMENT_SUSC_ID is NULL then
			Errors.SetError(cnuINS_PK_NULL,
			                fsbGetMessageDescription||'|SEGMENT_SUSC_ID');
			raise ex.controlled_error;
		end if;

		insert into LDC_SEGMENT_SUSC
		(
			SEGMENT_SUSC_ID,
			SUBSCRIPTION_ID,
			SEGMENT_ID,
			REGISTER_DATE
		)
		values
		(
			ircLDC_SEGMENT_SUSC.SEGMENT_SUSC_ID,
			ircLDC_SEGMENT_SUSC.SUBSCRIPTION_ID,
			ircLDC_SEGMENT_SUSC.SEGMENT_ID,
			ircLDC_SEGMENT_SUSC.REGISTER_DATE
		)
            returning
			rowid
		into
			orirowid;
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(ircLDC_SEGMENT_SUSC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE insRecords
	(
		iotbLDC_SEGMENT_SUSC in out nocopy tytbLDC_SEGMENT_SUSC
	)
	IS
		blUseRowID boolean;
	BEGIN
		FillRecordOfTables(iotbLDC_SEGMENT_SUSC,blUseRowID);
		forall n in iotbLDC_SEGMENT_SUSC.first..iotbLDC_SEGMENT_SUSC.last
			insert into LDC_SEGMENT_SUSC
			(
				SEGMENT_SUSC_ID,
				SUBSCRIPTION_ID,
				SEGMENT_ID,
				REGISTER_DATE
			)
			values
			(
				rcRecOfTab.SEGMENT_SUSC_ID(n),
				rcRecOfTab.SUBSCRIPTION_ID(n),
				rcRecOfTab.SEGMENT_ID(n),
				rcRecOfTab.REGISTER_DATE(n)
			);
	EXCEPTION
		when dup_val_on_index then
			Errors.setError(cnuRECORD_ALREADY_EXIST,fsbGetMessageDescription);
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE delRecord
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuLock in number default 1
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;

		if inuLock=1 then
			LockByPk
			(
				inuSEGMENT_SUSC_ID,
				rcData
			);
		end if;


		delete
		from LDC_SEGMENT_SUSC
		where
       		SEGMENT_SUSC_ID=inuSEGMENT_SUSC_ID;
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
		rcError  styLDC_SEGMENT_SUSC;
	BEGIN
		if inuLock=1 then
			LockByRowId(iriRowID,rcData);
		end if;


		delete
		from LDC_SEGMENT_SUSC
		where
			rowid = iriRowID
		returning
			SEGMENT_SUSC_ID
		into
			rcError.SEGMENT_SUSC_ID;
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
		iotbLDC_SEGMENT_SUSC in out nocopy tytbLDC_SEGMENT_SUSC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_SEGMENT_SUSC;
	BEGIN
		FillRecordOfTables(iotbLDC_SEGMENT_SUSC, blUseRowID);
        if ( blUseRowId ) then
			if inuLock = 1 then
				for n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last
				delete
				from LDC_SEGMENT_SUSC
				where
					rowid = rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last loop
					LockByPk
					(
						rcRecOfTab.SEGMENT_SUSC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last
				delete
				from LDC_SEGMENT_SUSC
				where
		         	SEGMENT_SUSC_ID = rcRecOfTab.SEGMENT_SUSC_ID(n);
		end if;
	EXCEPTION
            when ex.RECORD_HAVE_CHILDREN then
                  Errors.setError(cnuRECORD_HAVE_CHILDREN,fsbGetMessageDescription);
                  raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecord
	(
		ircLDC_SEGMENT_SUSC in styLDC_SEGMENT_SUSC,
		inuLock in number default 0
	)
	IS
		nuSEGMENT_SUSC_ID	LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type;
	BEGIN
		if ircLDC_SEGMENT_SUSC.rowid is not null then
			if inuLock=1 then
				LockByRowId(ircLDC_SEGMENT_SUSC.rowid,rcData);
			end if;
			update LDC_SEGMENT_SUSC
			set
				SUBSCRIPTION_ID = ircLDC_SEGMENT_SUSC.SUBSCRIPTION_ID,
				SEGMENT_ID = ircLDC_SEGMENT_SUSC.SEGMENT_ID,
				REGISTER_DATE = ircLDC_SEGMENT_SUSC.REGISTER_DATE
			where
				rowid = ircLDC_SEGMENT_SUSC.rowid
			returning
				SEGMENT_SUSC_ID
			into
				nuSEGMENT_SUSC_ID;
		else
			if inuLock=1 then
				LockByPk
				(
					ircLDC_SEGMENT_SUSC.SEGMENT_SUSC_ID,
					rcData
				);
			end if;

			update LDC_SEGMENT_SUSC
			set
				SUBSCRIPTION_ID = ircLDC_SEGMENT_SUSC.SUBSCRIPTION_ID,
				SEGMENT_ID = ircLDC_SEGMENT_SUSC.SEGMENT_ID,
				REGISTER_DATE = ircLDC_SEGMENT_SUSC.REGISTER_DATE
			where
				SEGMENT_SUSC_ID = ircLDC_SEGMENT_SUSC.SEGMENT_SUSC_ID
			returning
				SEGMENT_SUSC_ID
			into
				nuSEGMENT_SUSC_ID;
		end if;
		if
			nuSEGMENT_SUSC_ID is NULL
		then
			raise no_data_found;
		end if;
	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||fsbPrimaryKey(ircLDC_SEGMENT_SUSC));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updRecords
	(
		iotbLDC_SEGMENT_SUSC in out nocopy tytbLDC_SEGMENT_SUSC,
		inuLock in number default 1
	)
	IS
		blUseRowID boolean;
		rcAux styLDC_SEGMENT_SUSC;
	BEGIN
		FillRecordOfTables(iotbLDC_SEGMENT_SUSC,blUseRowID);
		if blUseRowID then
			if inuLock = 1 then
				for n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last loop
					LockByRowId
					(
						rcRecOfTab.row_id(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last
				update LDC_SEGMENT_SUSC
				set
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					SEGMENT_ID = rcRecOfTab.SEGMENT_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n)
				where
					rowid =  rcRecOfTab.row_id(n);
		else
			if inuLock = 1 then
				for n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last loop
					LockByPk
					(
						rcRecOfTab.SEGMENT_SUSC_ID(n),
						rcAux
					);
				end loop;
			end if;

			forall n in iotbLDC_SEGMENT_SUSC.first .. iotbLDC_SEGMENT_SUSC.last
				update LDC_SEGMENT_SUSC
				SET
					SUBSCRIPTION_ID = rcRecOfTab.SUBSCRIPTION_ID(n),
					SEGMENT_ID = rcRecOfTab.SEGMENT_ID(n),
					REGISTER_DATE = rcRecOfTab.REGISTER_DATE(n)
				where
					SEGMENT_SUSC_ID = rcRecOfTab.SEGMENT_SUSC_ID(n)
;
		end if;
	END;
	PROCEDURE updSUBSCRIPTION_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuSUBSCRIPTION_ID$ in LDC_SEGMENT_SUSC.SUBSCRIPTION_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMENT_SUSC_ID,
				rcData
			);
		end if;

		update LDC_SEGMENT_SUSC
		set
			SUBSCRIPTION_ID = inuSUBSCRIPTION_ID$
		where
			SEGMENT_SUSC_ID = inuSEGMENT_SUSC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SUBSCRIPTION_ID:= inuSUBSCRIPTION_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updSEGMENT_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuSEGMENT_ID$ in LDC_SEGMENT_SUSC.SEGMENT_ID%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMENT_SUSC_ID,
				rcData
			);
		end if;

		update LDC_SEGMENT_SUSC
		set
			SEGMENT_ID = inuSEGMENT_ID$
		where
			SEGMENT_SUSC_ID = inuSEGMENT_SUSC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.SEGMENT_ID:= inuSEGMENT_ID$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	PROCEDURE updREGISTER_DATE
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		idtREGISTER_DATE$ in LDC_SEGMENT_SUSC.REGISTER_DATE%type,
		inuLock in number default 0
	)
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN
		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;
		if inuLock=1 then
			LockByPk
			(
				inuSEGMENT_SUSC_ID,
				rcData
			);
		end if;

		update LDC_SEGMENT_SUSC
		set
			REGISTER_DATE = idtREGISTER_DATE$
		where
			SEGMENT_SUSC_ID = inuSEGMENT_SUSC_ID;

		if sql%notfound then
			raise no_data_found;
		end if;

		rcData.REGISTER_DATE:= idtREGISTER_DATE$;

	EXCEPTION
		when no_data_found then
			Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
			raise ex.CONTROLLED_ERROR;
	END;
	FUNCTION fnuGetSEGMENT_SUSC_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN

		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEGMENT_SUSC_ID
			 )
		then
			 return(rcData.SEGMENT_SUSC_ID);
		end if;
		Load
		(
		 		inuSEGMENT_SUSC_ID
		);
		return(rcData.SEGMENT_SUSC_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSUBSCRIPTION_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.SUBSCRIPTION_ID%type
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN

		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEGMENT_SUSC_ID
			 )
		then
			 return(rcData.SUBSCRIPTION_ID);
		end if;
		Load
		(
		 		inuSEGMENT_SUSC_ID
		);
		return(rcData.SUBSCRIPTION_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fnuGetSEGMENT_ID
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.SEGMENT_ID%type
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN

		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEGMENT_SUSC_ID
			 )
		then
			 return(rcData.SEGMENT_ID);
		end if;
		Load
		(
		 		inuSEGMENT_SUSC_ID
		);
		return(rcData.SEGMENT_ID);
	EXCEPTION
		when no_data_found then
			if inuRaiseError = 1 then
				Errors.setError(cnuRECORD_NOT_EXIST,fsbGetMessageDescription||' '||fsbPrimaryKey(rcError));
				raise ex.CONTROLLED_ERROR;
			else
				return null;
			end if;
	END;
	FUNCTION fdtGetREGISTER_DATE
	(
		inuSEGMENT_SUSC_ID in LDC_SEGMENT_SUSC.SEGMENT_SUSC_ID%type,
		inuRaiseError in number default 1
	)
	RETURN LDC_SEGMENT_SUSC.REGISTER_DATE%type
	IS
		rcError styLDC_SEGMENT_SUSC;
	BEGIN

		rcError.SEGMENT_SUSC_ID := inuSEGMENT_SUSC_ID;

        -- si usa cache y esta cargado retorna
		if  blDAO_USE_CACHE AND fblAlreadyLoaded
			 (
		 		inuSEGMENT_SUSC_ID
			 )
		then
			 return(rcData.REGISTER_DATE);
		end if;
		Load
		(
		 		inuSEGMENT_SUSC_ID
		);
		return(rcData.REGISTER_DATE);
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
end DALDC_SEGMENT_SUSC;
/
PROMPT OTORGA PERMISOS ESQUEMA sobre DALDC_SEGMENT_SUSC
BEGIN
    pkg_utilidades.prAplicarPermisos('DALDC_SEGMENT_SUSC', 'ADM_PERSON'); 
END;
/ 
